==============================================
TODO
    high priority
        customer search
        customer search in orders
        add order
        edit order
        toggle pending
        toggle paid
        add customer
        add product
        edit product
        show paid

    low priority
        delete customer
        call customer
        navigate to customer
        edit customer
        product search



===========================================================================================
postgres
had to change id columns type from bigint to int because postgres converts numbers to strings



====================================================================================================
to deploy to heroku

go to heroku website
create new app
look at instructions in deploy tab
i might have to put server stuff in root folder

for postgres, have to get the free addon
then on local cmd
heroku pg:psql -a yummy-bites
to quit
\q


========================================================================================================

first create a folder
go into folder then
git init
then npm init
then npx create-react-app client



=========================================================================
wasnt styling because browser was getting styles from stale cache, need to turn it off. can only disable it if devtools is open, go to network tab.
the other tutorials, like just do it, uses styled components, that's why it didnt have a problem i guess. it had nothing to do with wrong folder paths. 