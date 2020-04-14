import React from 'react';
import { Switch, Route } from 'react-router-dom';
import landingpage from './landingpage';
import aboutUs from './aboutUs';
import login from './login';
import signup from './signup';
import gamesAndTournaments from './gamesAndTournaments';
import browseTournaments from './browseTournaments';
import organizeTournaments from './organizeTournaments';


const Main = () => (
    <Switch>
        <Route exact path="/" component={landingpage} />
        <Route exact path="/aboutUs" component={aboutUs} />
        <Route exact path="/login" component={login} />
        <Route exact path="/signup" component={signup} />
        <Route exact path="/gamesAndTournaments" component={gamesAndTournaments} />
        <Route exact path="/browseTournaments" component={browseTournaments} />
        <Route exact path="/organizeTournaments" component={organizeTournaments} />

    </Switch>
)

export default Main;
