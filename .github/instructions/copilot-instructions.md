# Core Instructions

Generate a complete MVP (Minimum Viable Product) project using **[PROGRAMMING_LANGUAGE/FRAMEWORK]** for **[PROJECT_TYPE/DOMAIN]**.

# Project Requirements

# 0. Personalize: Communication Style

- Use clear, concise, and practical language.
- Avoid unnecessary jargon or overly formal language.
- Focus on providing honest, helpful, and actionable answers.
- Respect established best practices, but suggest improvements when appropriate.
- Maintain a professional and approachable tone.

# 1. Project Definition

- **Project Name**: [Clear, descriptive name]
- **Core Purpose**: [One sentence describing the main problem this solves]
- **Target Users**: [Primary user group]
- **Success Metric**: [One key metric to measure MVP success]

# 2. Technology Stack

- **Primary Language/Framework**: [Specify main technology]
- **Database**: [Database choice with justification]
- **Authentication**: [Auth method if needed]
- **Deployment**: [Target deployment platform]
- **Additional Libraries**: [Max 3-5 essential libraries only]



# 3. MVP Feature Set (Maximum 5 Core Features)

Prioritize features using MoSCoW method:

- **Must Have**: [2-3 absolutely essential features]
- **Should Have**: [1-2 important but not critical features]
- **Could Have**: [1 nice-to-have feature for future]
- **Won't Have**: [Features explicitly excluded from MVP]

# 4. Project Structure

Generate a clean, organized folder structure with:

- Clear separation of concerns
- Logical grouping of related files
- Scalable architecture for future growth
- Standard conventions for the chosen technology



# 5. Development Rules & Constraints

# Code Organization

- **Max Component Size**: 150 lines per file/component
- **Function Length**: Maximum 20 lines per function
- **File Naming**: Use consistent naming convention (specify which)
- **Import Structure**: Group imports logically with clear separation

# Styling Guidelines

- **CSS Approach**: [Specify: inline, modules, styled-components, etc.]
- **Design System**: Use maximum 3 colors, 2 font sizes, consistent spacing
- **Responsive**: Mobile-first approach with 2 breakpoints maximum
- **Style Files**: Maximum 100 lines per stylesheet

# Database Schema

- **Tables/Collections**: Maximum 5 entities for MVP
- **Relationships**: Keep relationships simple (avoid complex many-to-many)
- **Fields**: Each entity should have 5-8 fields maximum
- **Indexing**: Define primary indexes only

# Performance & Quality

- **Bundle Size**: Keep total bundle under [specify size limit]
- **Dependencies**: Maximum 10 production dependencies
- **Testing**: Include basic unit tests for core functions
- **Error Handling**: Implement basic error boundaries/handlers



# 6. Page/Route Structure

Define maximum 5-7 pages/routes:

- Landing/Home page
- Core functionality pages (2-3 max)
- User management (login/signup if needed)
- Settings/Profile (if needed)
- Error pages (404, etc.)

# 7. Development Phases

Break development into 3 phases:

- **Phase 1**: Basic structure + core feature (Week 1)
- **Phase 2**: Additional features + styling (Week 2)
- **Phase 3**: Polish + testing + deployment (Week 3)

# 8. Specific Output Requirements

Provide:

1. **Complete project structure** (folder tree)
2. **Package.json/dependencies** (or equivalent)
3. **Database schema** with sample data
4. **Core component examples** (2-3 key files)
5. **Basic styling setup**
6. **README with setup instructions**
7. **Deployment checklist**



# 9. Constraints to Enforce Simplicity

- No user roles/permissions (single user type)
- No real-time features (WebSockets, etc.)
- No complex state management (use built-in solutions)
- No internationalization
- No advanced caching strategies
- No microservices (monolithic approach)
- No advanced CI/CD (basic deployment only)

# 10. Success Criteria

The MVP should:

- Be deployable in under 30 minutes
- Have all core features working
- Be responsive on mobile and desktop
- Include basic error handling
- Have clear, documented code
- Be maintainable by a single developer

# Example Usage

Replace the bracketed placeholders with specific requirements:

```Plain
Generate an MVP project using **React with TypeScript** for a **personal expense tracking app**.

[Follow all the guidelines above with this specific context]
```

# Quality Checklist

Before considering the MVP complete, verify:

- [ ] All files under specified line limits
- [ ] No unused dependencies or code
- [ ] Basic responsive design implemented
- [ ] Core user journey works end-to-end
- [ ] Database schema is normalized and simple
- [ ] Error handling covers main failure points
- [ ] Code is readable and follows conventions
- [ ] Setup/deployment instructions are clear
