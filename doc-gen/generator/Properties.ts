import * as fs from "fs";
import * as YAML from "yaml";

type Property = { name: string, flags: string[], value: string | undefined, valueType: string }

type Properties = {
    instance: Property[],
    server: Property[],
    client: Property[],
    channel: Property[],
    playlist: Property[],
    connection: Property[]
}

type DescriptionMap = {[key: string]: string};
type Descriptions = {
    instance: DescriptionMap,
    server: DescriptionMap,
    client: DescriptionMap,
    channel: DescriptionMap,
    playlist: DescriptionMap,
    connection: DescriptionMap
}

function parseProperties(file: string) : Properties {
    const payload = fs.readFileSync(file).toString();
    const data = payload.split("|").map(e => e.trim().split(" ").map(e => {
        const index = e.indexOf('=');
        if(index === -1) {
            return [e];
        } else {
            return [e.substring(0, index), e.substring(index + 1)];
        }
    }));
    const flags: string[] = data[0].find(e => e[0] === "flag_set")[1].split("\\p").reverse();
    const result = {
        instance: [],
        channel: [],
        client: [],
        playlist: [],
        server: [],
        connection: []
    } as Properties;

    for(const info of data) {
        const flagSet = parseInt(info.find(e => e[0] === "flags")[1]) >>> 0;
        const assignedFlags = flags
            .map((flag, index) => (flagSet & (1 << index)) > 0 ? flag : undefined)
            .filter(e => !!e)
            .map(e => e.toLowerCase().replace(/_/g, " "));
        const property = {
            name: info.find(e => e[0] === "name")[1],
            value: info.find(e => e[0] === "value")[1],
            flags: assignedFlags,
            valueType: info.find(e => e[0] === "value_type")[1].toLowerCase(),
        } as Property;

        switch (info.find(e => e[0] === "type")[1]) {
            case "SERVER":
                result.server.push(property);
                break;
            case "CHANNEL":
                result.channel.push(property);
                break;
            case "CLIENT":
                result.client.push(property);
                break;
            case "INSTANCE":
                result.instance.push(property);
                break;
            case "CONNECTION":
                result.connection.push(property);
                break;
            case "PLAYLIST":
                result.playlist.push(property);
                break;
        }
    }

    return result;
}

function parseDescriptions(file: string) : Descriptions {
    return YAML.parse(fs.readFileSync(file).toString());
}

function generateMarkdownTable(properties: Property[], descriptions: DescriptionMap) : string {
    let result = "";
    result += `| Name | Type | Flags | Default Value | Description |  \n`;
    result += `| ---- | ---- | ----- | ------------- | ----------- |  \n`;
    for(const property of properties) {
        if(property.name === "undefined") { continue; }
        result += `| \`${property.name}\` | ${property.valueType} | ${property.flags.join(", ")} `;
        result += `| ${property.value ? `\`${property.value}\`` : "empty"} `;
        result += `| ${descriptions[property.name] ? descriptions[property.name] : "no description"} |  \n`;
    }
    return result;
}

function generateMarkdown(input: string, properties: Properties, descriptions: Descriptions) : string {
    return input.replace(/<!-- properties_(\S+) -->/g, substring => {
        const group = substring.match(/<!-- properties_(\S+) -->/)[1];
        if(typeof properties[group] === "undefined") { throw "unknown property group " + group }
        if(typeof descriptions[group] === "undefined") { throw "missing descriptions for property group " + group }

        return generateMarkdownTable(properties[group], descriptions[group]);
    });
}

function main(args: string[]) {
    console.error(args);
    if(args.length !== 4) {
        console.error("Missing arguments: <property list> <property descriptions> <markdown template> <output file>");
        process.exit(1);
    }

    const properties = parseProperties(args[0]);
    const descriptions = parseDescriptions(args[1]);

    const md = generateMarkdown(fs.readFileSync(args[2]).toString(), properties, descriptions);
    fs.writeFileSync(args[3], md);
}
main(process.argv.slice(2));