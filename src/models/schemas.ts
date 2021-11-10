interface Users {
    username: string,
    name?: string,
    password?: string,
    uid?: string,
}
interface Meals {
    mid: number,
    name: string,
    description: string,
    dessert?: string,
    active: string,
    date: string,
}
interface Guests {
    meal_id: number,
    user_id: string,
}