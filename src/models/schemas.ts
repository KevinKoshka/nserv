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
    img?: string, 
    guest_list?: Array<Users>,
}
interface Guests {
    meal_id: number,
    user_id: string,
}
interface GuestsView {
    meal_id?: string,
    username: string,
    name: string,
    uid: string,
}