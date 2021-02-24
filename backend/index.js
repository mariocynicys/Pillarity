import express from 'express';
import { ApolloServer, gql } from 'apollo-server-express';
import { MongoClient } from 'mongodb';

const uri = "mongodb://127.0.0.1:27017/?compressors=disabled&gssapiServiceName=mongodb";
const db = new MongoClient(uri);

const typeDefs = gql`
  type Query {
    hello: String,
  }
`;

const resolvers = {
  Query: {
    hello: () => 'This Is Mind Blowing',
  },
};
 
const server = new ApolloServer({ 
    typeDefs,
    resolvers,
    introspection: true,
    playground: true,
 });

 
const app = express();

server.applyMiddleware({ app });

app.listen({ port: 80 }, () =>
  console.log('Now browse to http://localhost' + server.graphqlPath)
);
