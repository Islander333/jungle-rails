describe('Product details', () => {
  it ('navigates to product detail page when clicked', () => {
    cy.visit('/');
    cy.get(".products article").first().click()
    cy.url().should('include', '/products/');
  })

})