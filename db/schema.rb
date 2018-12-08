# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_29_212955) do

  create_table "contracts", force: :cascade do |t|
    t.string "name", null: false
    t.string "code"
    t.decimal "price", precision: 10, scale: 2
    t.date "podp_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "service_id"
    t.integer "org_id"
    t.integer "contragent_id"
    t.binary "gvs"
    t.decimal "v_gvs", precision: 10, scale: 2
    t.decimal "t_gvs", precision: 10, scale: 2
    t.decimal "o_gvs", precision: 10, scale: 2
    t.binary "hvs"
    t.decimal "v_hvs", precision: 10, scale: 2
    t.decimal "t_hvs", precision: 10, scale: 2
    t.decimal "o_hvs", precision: 10, scale: 2
    t.binary "vgvs"
    t.decimal "v_vgvs", precision: 10, scale: 2
    t.decimal "t_vgvs", precision: 10, scale: 2
    t.decimal "o_vgvs", precision: 10, scale: 2
    t.binary "vhvs"
    t.decimal "v_vhvs", precision: 10, scale: 2
    t.decimal "t_vhvs", precision: 10, scale: 2
    t.decimal "o_vhvs", precision: 10, scale: 2
    t.binary "otop"
    t.decimal "v_otop", precision: 10, scale: 2
    t.decimal "t_otop", precision: 10, scale: 2
    t.decimal "o_otop", precision: 10, scale: 2
    t.binary "exp"
    t.decimal "v_exp", precision: 10, scale: 2
    t.decimal "t_exp", precision: 10, scale: 2
    t.decimal "o_exp", precision: 10, scale: 2
    t.binary "tbo"
    t.decimal "v_tbo", precision: 10, scale: 2
    t.decimal "t_tbo", precision: 10, scale: 2
    t.decimal "o_tbo", precision: 10, scale: 2
    t.string "last_cb"
    t.string "created_by"
    t.string "nds"
    t.string "kod_p"
    t.string "innkpp"
    t.string "rsch"
    t.string "bank"
    t.string "ksch"
    t.string "bik"
    t.string "u_address"
    t.string "tel"
    t.string "p_address"
    t.string "price_name"
    t.decimal "price_nds", precision: 10, scale: 2
  end

  create_table "contragents", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "typ", null: false
    t.string "full_name", null: false
    t.string "group", null: false
    t.string "inn", null: false
    t.string "kpp", null: false
    t.string "code_okpo", null: false
    t.string "tel", null: false
    t.string "u_address", null: false
    t.string "f_address", null: false
    t.string "other"
    t.string "bank_code", null: false
    t.string "code_name", null: false
    t.string "bank_name", null: false
    t.binary "status"
    t.string "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_cb"
  end

  create_table "info_admins", force: :cascade do |t|
    t.string "post"
    t.string "address"
    t.string "tel"
    t.string "destination"
    t.string "trans"
    t.string "fil"
    t.string "bik"
    t.string "ksch"
    t.string "innkpp"
    t.string "gruz"
    t.string "addressg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "dir"
    t.string "main_buh"
  end

  create_table "kontragents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orgs", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "full_name", null: false
    t.string "small_name", null: false
    t.string "typ", null: false
    t.string "person", null: false
    t.string "usedge", null: false
    t.string "account", null: false
    t.string "u_address", null: false
    t.string "f_address", null: false
    t.binary "foreign"
    t.integer "square"
    t.integer "people"
    t.integer "space_fp"
    t.binary "status"
    t.string "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_cb"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "contract_id"
    t.integer "number"
    t.date "date"
    t.date "month"
    t.string "bank"
    t.decimal "summ", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_cb"
    t.string "created_by"
    t.string "file_name"
    t.string "nazn"
    t.boolean "paid"
    t.decimal "perep", precision: 10, scale: 2, default: "0.0"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "fio", default: "ФИО"
    t.boolean "mail", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
