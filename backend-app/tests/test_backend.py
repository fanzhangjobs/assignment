import pytest
from backend import app

@pytest.fixture
def client():
    with app.test_client() as client:
        yield client

def test_status(client):
    """Test GET /status endpoint"""
    response = client.get("/status")
    assert response.status_code == 200
    assert response.json == {"status": "backend running"}

def test_compute(client):
    """Test POST /compute endpoint"""
    response = client.post("/compute", json={"value": 5})
    assert response.status_code == 200
    assert response.json == {"result": 500}

def test_compute_default(client):
    """Test POST /compute with no value"""
    response = client.post("/compute", json={})
    assert response.status_code == 200
    assert response.json == {"result": 0}
