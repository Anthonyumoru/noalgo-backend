-- Businesses Table
CREATE TABLE businesses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Deals Table  
CREATE TABLE deals (
    id SERIAL PRIMARY KEY,
    business_id INTEGER REFERENCES businesses(id),
    title VARCHAR(255) NOT NULL,
    discount INTEGER NOT NULL,
    price INTEGER NOT NULL,
    expires_at DATE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Add 2 test businesses
INSERT INTO businesses (name, category) VALUES 
('Dominos Abuja', 'Food'),
('Cutting Edge Salon', 'Beauty');
