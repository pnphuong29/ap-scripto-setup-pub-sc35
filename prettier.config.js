// prettier.config.js, .prettierrc.js, prettier.config.mjs, or .prettierrc.mjs

/**
 * @see https://prettier.io/docs/en/configuration.html
 * @type {import("prettier").Config}
 */
const config = {
    singleQuote: true,
    semi: true,
    // tabWidth: 4,
    indent_size: 4,
    trailingComma: 'all',
    bracketSpacing: true,
    overrides: [
        {
            files: ['*.html', '*.tsx', '*.jsx', '*.yaml', '*.yml'],
            options: {
                indent_size: 2,
            },
        },
        {
            files: ['*.md'],
            options: {
                parser: 'mdx',
            },
        },
        {
            files: ['*.yml', '*.yaml'],
            options: {
                singleQuote: false,
            },
        },
    ],
    // plugins: ['prettier-plugin-tailwindcss'],
    // tailwindFunctions: ['clsx', 'tw'],
};

module.exports = config;
// export default config;
