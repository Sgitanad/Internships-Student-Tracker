import { render } from "@testing-library/react";
import App from "./App";

test("l'application s'affiche sans erreur", () => {
  const { container } = render(<App />);
  expect(container).toBeInTheDocument();
});