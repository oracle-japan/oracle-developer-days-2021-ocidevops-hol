import { render, screen } from '@testing-library/react';
import App from './App';

test('renders learn react link', () => {
  render(<App />);
  const Element = screen.getByText("Hello Oracle Developer Day and OCI DevOps");
  expect(Element).toBeInTheDocument()
});
