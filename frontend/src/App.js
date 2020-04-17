import React from 'react';
import './App.css';
import { Layout, Header, Navigation, Drawer, /*Footer, FooterSection, FooterDropDownSection, FooterLinkList,*/ Content } from 'react-mdl';
import Main from './components/main';
import { Link } from 'react-router-dom';

function App() {
  return (
    <div className="demo-big-content">
    <Layout>
        <Header className="header-color" title="[Website Name]" scroll>
            <Navigation>
                <Link to="/">Home</Link>
                <Link to="/gamesAndTournaments">Games and Tournaments</Link>
                <Link to="/aboutUs">About Us</Link>
                <Link to="/login">Login</Link>
                <Link to="/signup">Sign Up</Link>
            </Navigation>
        </Header>
        <Drawer title="[Website Name]">
            <Navigation>
                <Link to="/browseTournaments">Browse Tournaments</Link>
                <Link to="/organizeTournaments">Organize Tournaments</Link>
                <Link to="/">Link</Link>
                <Link to="/">Link</Link>
            </Navigation>
        </Drawer>
        <Content>
            <div className="page-content" />
            <Main/>
        </Content>
    </Layout>
</div>
  );
}

export default App;
