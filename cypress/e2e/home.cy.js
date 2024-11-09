describe('Home Page', () => {
  it ('succesfully loads', () => {
    cy.visit('/');
  })

  it("There is products on the page", () => {
    cy.visit('/')
    cy.get(".products article").should("be.visible")
  })

  it("There is 2 products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("have.length", 2);
  });
})