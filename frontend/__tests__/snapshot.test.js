import { render } from '@testing-library/react'
import Home from '../pages/index'
import '@testing-library/jest-dom'

describe('Home Snapshot', () => {
  it('matches snapshot (normalized)', () => {
    const { container } = render(<Home apiBaseUrl="http://localhost:8000" />)
    // Normalize styled-jsx / CSS-module hashes (e.g. "jsx-abc123") to avoid flaky snapshots.
    const normalizedHtml = container.innerHTML.replace(/jsx-[a-f0-9]+/g, 'jsx-HASH')
    expect(normalizedHtml).toMatchSnapshot()
  })
})
