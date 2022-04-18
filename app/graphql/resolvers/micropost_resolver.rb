require "search_object"
require "search_object/plugin/graphql"

class Resolvers::MicropostResolver < GraphQL::Schema::Resolver
    include SearchObject.module(:graphql)

    scope() {Micropost.all}

    option(:content, type: [String]) {|scope, value| scope.where(
        (["content like ?"] * value.size).join(" or "), *value.map() {|e| "%#{e}%"})}
    
    class Pagination < Types::BaseInputObject
        argument(:page, Int, required: true)
        argument(:count, Int, required: false)
    end

    option(:pagination, type: Pagination) {|scope, value| scope.limit(value.count).offset(value.page)}
end