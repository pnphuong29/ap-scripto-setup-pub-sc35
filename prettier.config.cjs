// prettier.config.js, .prettierrc.js, prettier.config.mjs, or .prettierrc.mjs

/**
 * @see https://prettier.io/docs/en/configuration.html
 * @type {import("prettier").Config}
 */
const config = {
    singleQuote: true,
    semi: true,
    trailingComma: 'all',
    bracketSpacing: true,
    overrides: [
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
