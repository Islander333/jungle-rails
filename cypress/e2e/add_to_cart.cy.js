describe('Add to cart feature', () => {
  it ('increases by 1 when a products add to cart is clicked', () => {
    cy.visit('/');
    cy.contains('My Cart (0)')

    cy.get('.products article').first().within(() => {
      cy.contains('.btn', 'Add').click({ force: true })
    });
    
    cy.contains('My Cart (1)')
  })

})