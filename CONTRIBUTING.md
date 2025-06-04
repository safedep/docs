# Contributing to SafeDep Documentation

Welcome to the SafeDep Documentation repository! We're excited to have you contribute to making our documentation better for the security engineering community.

## Documentation Framework

This repository follows the **[Diátaxis framework](https://diataxis.fr)** for systematic documentation architecture. Diátaxis organizes documentation into four distinct types based on user needs and context:

- **📖 Tutorials** - Learning-oriented, hands-on lessons
- **🔧 How-to Guides** - Problem-oriented, practical solutions  
- **📚 Reference** - Information-oriented, technical specifications
- **💡 Explanation** - Understanding-oriented, theoretical knowledge

Before contributing, we strongly recommend familiarizing yourself with the [Diátaxis principles](https://diataxis.fr) to understand how different types of content should be structured and written.

## Repository Structure & Diátaxis Mapping

Our documentation structure aligns with Diátaxis principles as follows:

### 🔧 How-to Guides (`/guides/`)
**Problem-oriented practical solutions**
- `github-code-scanning.mdx` - CI/CD integration guides
- `gitlab-dependency-scanning.mdx` - Platform-specific implementations
- `defect-dojo-integration.mdx` - Tool integrations
- `cyclonedx-sbom.mdx` - SBOM generation workflows
- `dependency-inventory.mdx` - Inventory management processes
- `code-analysis.mdx` - Analysis workflows
- `dependency-usage-identification.mdx` - Usage analysis procedures
- `insights-api-using-typescript.mdx` - API integration guides
- `terraform-supply-chain-audit.mdx` - Infrastructure security audits

**Characteristics:**
- Start with a specific problem or goal
- Provide step-by-step instructions
- Include practical examples and code snippets
- Focus on achieving a particular outcome

### 📖 Tutorials (`/quickstart.mdx`, `/introduction.mdx`)
**Learning-oriented educational content**
- `introduction.mdx` - Welcome and first steps
- `quickstart.mdx` - Get started in under 5 minutes

**Characteristics:**
- Designed for beginners
- Learning by doing approach
- Safe to fail environment
- Build confidence through success

### 📚 Reference (`/api-reference/`, `/advanced/`)
**Information-oriented technical specifications**

**API Reference:**
- `api-reference/introduction.mdx` - API overview
- `api-reference/endpoint/*.mdx` - Detailed API specifications

**Advanced Reference:**
- `advanced/filtering.mdx` - CEL expression reference
- `advanced/policy-as-code.mdx` - Policy language specification
- `advanced/exceptions.mdx` - Exception system reference
- `advanced/build-your-own-queries.mdx` - Query syntax reference
- `advanced/path-exclusion.mdx` - Path pattern reference
- `advanced/shell-completion.mdx` - CLI completion reference

**Characteristics:**
- Comprehensive and accurate
- Organized for easy lookup
- Minimal explanation, maximum information
- Assumes existing knowledge

### 💡 Explanation (`/concepts/`, `/cloud/`, `/resources.mdx`)
**Understanding-oriented conceptual content**

**Concepts:**
- `concepts/why-vet.mdx` - Problem space and motivation
- `concepts/about.mdx` - Architecture and design principles

**Cloud Platform:**
- `cloud/overview.mdx` - Platform concepts and architecture
- `cloud/authentication.mdx` - Authentication concepts
- `cloud/sync.mdx` - Data synchronization concepts
- `cloud/malware-analysis.mdx` - Threat detection concepts

**Supporting Materials:**
- `resources.mdx` - Industry context and related concepts
- `community.mdx` - Community and contribution philosophy
- `faq.mdx` - Common misconceptions and clarifications

**Characteristics:**
- Explains the "why" behind features
- Provides context and background
- Connects ideas and concepts
- Helps build mental models

## Content Standards

### Writing Guidelines

1. **Follow Diátaxis Principles**
   - Identify which quadrant your content belongs to
   - Write in the appropriate style for that content type
   - Don't mix different content types in the same document

2. **Use Clear, Accessible Language**
   - Write for international audiences
   - Define technical terms when first introduced
   - Use active voice when possible
   - Keep sentences concise and scannable

3. **Structure for Scannability**
   - Use descriptive headings (H2, H3)
   - Include bullet points and numbered lists
   - Add code examples and visual elements
   - Use callout components for important information

### Technical Standards

1. **Mintlify Components**
   - Use `<CardGroup>` and `<Card>` for related links
   - Use `<Steps>` for sequential processes
   - Use `<Tabs>` for alternative approaches
   - Use `<AccordionGroup>` for optional details
   - Use `<Info>`, `<Warning>`, `<Tip>`, `<Note>` callouts appropriately

2. **Code Examples**
   - Always test code examples before including them
   - Use syntax highlighting with appropriate language tags
   - Include comments explaining complex parts
   - Provide complete, runnable examples when possible

3. **Cross-References**
   - Link to related content within the documentation
   - Use descriptive link text (avoid "click here")
   - Link to authoritative external sources
   - Keep external links current and relevant

### File Organization

1. **Naming Conventions**
   - Use kebab-case for file names (`my-guide.mdx`)
   - Choose descriptive, specific names
   - Avoid generic names like `guide.mdx` or `tutorial.mdx`

2. **Frontmatter Requirements**
   ```yaml
   ---
   title: Descriptive Page Title
   description: "Clear, searchable description under 160 characters"
   ---
   ```

3. **Content Structure**
   - Start with frontmatter
   - Begin content immediately (no H1 header)
   - Use H2 for main sections, H3 for subsections
   - End with related links using `<CardGroup>`

## Contribution Workflow

### 1. Planning Your Contribution

Before writing, consider:
- **What type of content** are you creating? (Tutorial, How-to, Reference, Explanation)
- **Who is your audience?** (Beginners, experienced users, developers, security teams)
- **What problem does this solve?** (Specific user need or gap in documentation)
- **Where should this live?** (Which directory and section)

### 2. Writing Process

1. **Create an outline** following Diátaxis principles for your content type
2. **Draft the content** using our content standards
3. **Test all examples** to ensure they work correctly
4. **Review for clarity** and accessibility
5. **Check cross-references** and external links

### 3. Quality Checklist

Before submitting, verify:
- [ ] Content follows appropriate Diátaxis quadrant principles
- [ ] All code examples are tested and working
- [ ] Links are functional and point to current resources
- [ ] Images are optimized and have descriptive alt text
- [ ] Content is accessible to international audiences
- [ ] Frontmatter includes title and description
- [ ] No redundant H1 headers (Mintlify handles titles)
- [ ] Related content is properly cross-referenced

### 4. Submission Guidelines

1. **Fork the repository** and create a feature branch
2. **Follow conventional commit messages**:
   ```
   type(scope): description
   
   docs(guides): add terraform security audit guide
   fix(concepts): clarify vet architecture explanation
   feat(api): add new endpoint documentation
   ```

3. **Create a pull request** with:
   - Clear title describing the change
   - Description explaining the motivation
   - Screenshots for visual changes
   - Testing notes for code examples

4. **Respond to feedback** constructively and promptly

## Review Process

### Content Review Criteria

Reviewers will evaluate:
1. **Diátaxis Compliance** - Does content fit the intended quadrant?
2. **Technical Accuracy** - Are examples and instructions correct?
3. **User Experience** - Is content helpful for the intended audience?
4. **Writing Quality** - Is it clear, concise, and well-structured?
5. **Integration** - Does it fit well with existing documentation?

### Review Timeline

- **Initial response**: Within 2 business days
- **Full review**: Within 1 week
- **Revision cycles**: 2-3 business days per round

## Style Guide

### Voice and Tone
- **Professional but approachable** - Expert guidance without intimidation
- **Action-oriented** - Focus on what users can do
- **Empathetic** - Acknowledge that security is challenging
- **Confident** - Provide clear direction and recommendations

### Technical Writing
- **Use second person** ("you") for instructions
- **Use first person plural** ("we") for project decisions
- **Prefer active voice** over passive voice
- **Write in present tense** for current capabilities

### Code Style
- **Include full examples** rather than fragments when possible
- **Use realistic data** in examples (sanitized)
- **Explain non-obvious code** with comments
- **Show expected outputs** when helpful

## Content Types by Use Case

### When to Write Tutorials (📖)
- Introducing new users to vet or SafeDep Cloud
- Teaching fundamental concepts through hands-on practice
- Showing end-to-end workflows for common scenarios
- Building confidence in new users

### When to Write How-to Guides (🔧)
- Solving specific integration challenges
- Addressing common user problems
- Providing implementation patterns
- Showing platform-specific setups

### When to Write Reference (📚)
- Documenting API endpoints and parameters
- Listing configuration options
- Providing comprehensive feature coverage
- Creating lookup resources for experienced users

### When to Write Explanation (💡)
- Describing architectural decisions
- Explaining the reasoning behind features
- Providing industry context
- Connecting SafeDep to broader security concepts

## Getting Help

### Resources
- **Diátaxis Documentation**: https://diataxis.fr
- **Mintlify Documentation**: https://mintlify.com/docs
- **SafeDep Community**: [Discord](https://discord.gg/kAGEj25dCn)

### Questions?
- **Documentation questions**: Create an issue in this repository
- **SafeDep product questions**: Join our [Discord community](https://discord.gg/kAGEj25dCn)
- **Contribution help**: Tag `@maintainers` in your pull request

## Recognition

We appreciate all contributions to SafeDep documentation! Contributors will be:
- **Credited** in release notes for significant contributions
- **Invited** to contributor-only community channels
- **Acknowledged** in the annual community report

Thank you for helping make SafeDep documentation better for everyone! 🎉

---

*For technical support, visit our [community page](/community) or contact [support@safedep.io](mailto:support@safedep.io)*