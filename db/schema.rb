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

ActiveRecord::Schema.define(version: 20170620151250) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_employee_details", force: :cascade do |t|
    t.integer  "account_employee_id"
    t.integer  "employee_id"
    t.integer  "total"
    t.string   "pay"
    t.integer  "number_bill"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "certification_id"
    t.date     "date"
    t.string   "state"
    t.index ["account_employee_id"], name: "index_account_employee_details_on_account_employee_id", using: :btree
    t.index ["certification_id"], name: "index_account_employee_details_on_certification_id", using: :btree
    t.index ["employee_id"], name: "index_account_employee_details_on_employee_id", using: :btree
  end

  create_table "account_employees", force: :cascade do |t|
    t.integer  "pay"
    t.date     "date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "contract_id"
    t.index ["contract_id"], name: "index_account_employees_on_contract_id", using: :btree
  end

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index", using: :btree
    t.index ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
    t.index ["created_at"], name: "index_audits_on_created_at", using: :btree
    t.index ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
    t.index ["user_id", "user_type"], name: "user_index", using: :btree
  end

  create_table "budget_details", force: :cascade do |t|
    t.integer  "budget_id"
    t.integer  "rubro_id"
    t.integer  "price",              default: 0
    t.float    "quantity",           default: 0.0
    t.integer  "subtotal",           default: 0
    t.integer  "utility",            default: 0
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "measurement_unit"
    t.decimal  "cost"
    t.float    "certified_quantity", default: 0.0
    t.integer  "state",              default: 0,   null: false
    t.index ["budget_id"], name: "index_budget_details_on_budget_id", using: :btree
    t.index ["rubro_id"], name: "index_budget_details_on_rubro_id", using: :btree
  end

  create_table "budgets", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "contract_id"
    t.date     "date"
    t.string   "description"
    t.bigint   "total_amount",  default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name"
    t.integer  "state",         default: 0, null: false
    t.bigint   "expected_gain"
    t.index ["client_id"], name: "index_budgets_on_client_id", using: :btree
    t.index ["contract_id"], name: "index_budgets_on_contract_id", using: :btree
  end

  create_table "certification_details", force: :cascade do |t|
    t.integer  "certification_id"
    t.integer  "employee_id"
    t.float    "quantity",         default: 0.0
    t.integer  "discount",         default: 0
    t.string   "observation"
    t.integer  "subtotal",         default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.decimal  "total"
    t.decimal  "pay"
    t.index ["certification_id"], name: "index_certification_details_on_certification_id", using: :btree
    t.index ["employee_id"], name: "index_certification_details_on_employee_id", using: :btree
  end

  create_table "certifications", force: :cascade do |t|
    t.date     "date"
    t.integer  "contract_id"
    t.datetime "created_at",                                                                            null: false
    t.datetime "updated_at",                                                                            null: false
    t.integer  "state",                default: 0
    t.integer  "certification_number", default: -> { "nextval('certification_number_seq'::regclass)" }
    t.index ["contract_id"], name: "index_certifications_on_contract_id", using: :btree
  end

  create_table "client_certification_details", force: :cascade do |t|
    t.integer  "client_certification_id"
    t.float    "quantity"
    t.integer  "price"
    t.integer  "total"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.float    "total_quantity"
    t.integer  "budget_detail_id"
    t.index ["budget_detail_id"], name: "index_client_certification_details_on_budget_detail_id", using: :btree
    t.index ["client_certification_id"], name: "index_client_certification_details_on_client_certification_id", using: :btree
  end

  create_table "client_certifications", force: :cascade do |t|
    t.integer  "contract_id"
    t.date     "date"
    t.string   "observation"
    t.string   "received"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "observations"
    t.string   "approved_by"
    t.date     "approved_date"
    t.integer  "state",         default: 0
    t.string   "number"
    t.integer  "total"
    t.index ["contract_id"], name: "index_client_certifications_on_contract_id", using: :btree
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "email"
    t.string   "adress"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "ruc"
  end

  create_table "company_configs", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.string   "email"
    t.string   "tel_fax"
    t.string   "celphone"
    t.string   "avatar"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "current_avatar"
    t.string   "letterhead"
    t.date     "validity_of_letterhead"
    t.decimal  "current_pay",            default: "0.0"
    t.decimal  "default_utility",        default: "0.0"
  end

  create_table "concepts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.integer  "client_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "name"
    t.bigint   "amount"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "budget_id"
    t.integer  "advance_payment",            default: 0
    t.date     "advance_payment_date"
    t.string   "advance_payment_voucher"
    t.float    "advance_payment_percentage", default: 0.0
    t.boolean  "has_advance_payment"
    t.string   "state",                      default: "activo"
    t.string   "attachment"
    t.index ["budget_id"], name: "index_contracts_on_budget_id", using: :btree
    t.index ["client_id"], name: "index_contracts_on_client_id", using: :btree
  end

  create_table "employees", force: :cascade do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "address"
    t.string   "email"
    t.string   "phone"
    t.string   "identification_document"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.decimal  "balance",                 precision: 15, scale: 2, default: "0.0"
  end

  create_table "installment_payment_purchases", force: :cascade do |t|
    t.integer  "installment_purchase_id"
    t.integer  "amount"
    t.date     "date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["installment_purchase_id"], name: "index_installment_payment_purchases_on_installment_purchase_id", using: :btree
  end

  create_table "installment_payments", force: :cascade do |t|
    t.integer  "installment_id"
    t.integer  "amount"
    t.date     "date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["installment_id"], name: "index_installment_payments_on_installment_id", using: :btree
  end

  create_table "installment_purchases", force: :cascade do |t|
    t.date     "due_date"
    t.integer  "amount"
    t.integer  "balance"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "purchase_bill_id"
    t.index ["purchase_bill_id"], name: "index_installment_purchases_on_purchase_bill_id", using: :btree
  end

  create_table "installments", force: :cascade do |t|
    t.integer  "sale_bill_id"
    t.date     "due_date"
    t.integer  "amount"
    t.integer  "balance"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["sale_bill_id"], name: "index_installments_on_sale_bill_id", using: :btree
  end

  create_table "material_movements", force: :cascade do |t|
    t.date     "date",        default: -> { "('now'::text)::date" }
    t.string   "reason"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "contract_id"
    t.integer  "total"
    t.string   "sender"
    t.integer  "remission"
    t.index ["contract_id"], name: "index_material_movements_on_contract_id", using: :btree
  end

  create_table "materials", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "price"
    t.integer  "quantity"
    t.integer  "minimun_stock",    default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "measurement_unit"
  end

  create_table "movement_details", force: :cascade do |t|
    t.integer  "material_movement_id"
    t.integer  "material_id"
    t.float    "quantity",             default: 1.0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.decimal  "price"
    t.string   "measurement_unit"
    t.integer  "subtotal"
    t.index ["material_id"], name: "index_movement_details_on_material_id", using: :btree
    t.index ["material_movement_id"], name: "index_movement_details_on_material_movement_id", using: :btree
  end

  create_table "payments", force: :cascade do |t|
    t.date    "date"
    t.integer "amount"
    t.integer "balance"
    t.integer "purchase_bill_id"
    t.index ["purchase_bill_id"], name: "index_payments_on_purchase_bill_id", using: :btree
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "subject_class"
    t.text     "action",        default: [],              array: true
    t.integer  "role_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["role_id"], name: "index_permissions_on_role_id", using: :btree
  end

  create_table "providers", force: :cascade do |t|
    t.string   "name"
    t.string   "ruc"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.boolean  "state"
    t.bigint   "balance",    default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "purchase_bills", force: :cascade do |t|
    t.datetime "date"
    t.string   "condition"
    t.integer  "number"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "provider_id"
    t.integer  "total"
    t.string   "state"
    t.integer  "balance",     default: 0
    t.index ["provider_id"], name: "index_purchase_bills_on_provider_id", using: :btree
  end

  create_table "purchase_details", force: :cascade do |t|
    t.integer  "material_id"
    t.integer  "quantity",         default: 1
    t.integer  "price"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "purchase_bill_id"
    t.integer  "total"
    t.index ["material_id"], name: "index_purchase_details_on_material_id", using: :btree
    t.index ["purchase_bill_id"], name: "index_purchase_details_on_purchase_bill_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "rubro_material_details", force: :cascade do |t|
    t.integer  "rubro_id"
    t.integer  "material_id"
    t.float    "quantity"
    t.integer  "subtotal"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "price",            default: 0
    t.string   "measurement_unit"
    t.index ["material_id"], name: "index_rubro_material_details_on_material_id", using: :btree
    t.index ["rubro_id"], name: "index_rubro_material_details_on_rubro_id", using: :btree
  end

  create_table "rubro_service_details", force: :cascade do |t|
    t.integer  "rubro_id"
    t.integer  "service_id"
    t.float    "quantity"
    t.integer  "subtotal"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "price",            default: 0
    t.string   "measurement_unit"
    t.index ["rubro_id"], name: "index_rubro_service_details_on_rubro_id", using: :btree
    t.index ["service_id"], name: "index_rubro_service_details_on_service_id", using: :btree
  end

  create_table "rubros", force: :cascade do |t|
    t.integer  "material_id"
    t.integer  "service_id"
    t.integer  "material_quantity"
    t.integer  "service_quantity"
    t.string   "name"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "price",             default: 0
    t.float    "utility"
    t.string   "measurement_unit"
    t.index ["material_id"], name: "index_rubros_on_material_id", using: :btree
    t.index ["service_id"], name: "index_rubros_on_service_id", using: :btree
  end

  create_table "sale_bills", force: :cascade do |t|
    t.date     "date"
    t.string   "condition"
    t.string   "number"
    t.integer  "client_id"
    t.integer  "contract_id"
    t.integer  "total",       default: 0
    t.integer  "balance",     default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "state"
    t.index ["client_id"], name: "index_sale_bills_on_client_id", using: :btree
    t.index ["contract_id"], name: "index_sale_bills_on_contract_id", using: :btree
  end

  create_table "sale_details", force: :cascade do |t|
    t.integer  "sale_bill_id"
    t.string   "concept"
    t.integer  "price"
    t.integer  "quantity"
    t.integer  "total",                   default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "client_certification_id"
    t.index ["client_certification_id"], name: "index_sale_details_on_client_certification_id", using: :btree
    t.index ["sale_bill_id"], name: "index_sale_details_on_sale_bill_id", using: :btree
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "measurement_unit"
    t.integer  "price"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "avatar"
    t.integer  "role_id"
    t.string   "current_avatar"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["role_id"], name: "index_users_on_role_id", using: :btree
  end

  add_foreign_key "account_employee_details", "account_employees"
  add_foreign_key "account_employee_details", "certifications"
  add_foreign_key "account_employee_details", "employees"
  add_foreign_key "account_employees", "contracts"
  add_foreign_key "budget_details", "budgets"
  add_foreign_key "budget_details", "rubros"
  add_foreign_key "budgets", "clients"
  add_foreign_key "budgets", "contracts"
  add_foreign_key "certification_details", "certifications"
  add_foreign_key "certification_details", "employees"
  add_foreign_key "certifications", "contracts"
  add_foreign_key "client_certification_details", "budget_details"
  add_foreign_key "client_certification_details", "client_certifications"
  add_foreign_key "client_certifications", "contracts"
  add_foreign_key "contracts", "budgets"
  add_foreign_key "contracts", "clients"
  add_foreign_key "installment_payment_purchases", "installment_purchases"
  add_foreign_key "installment_payments", "installments"
  add_foreign_key "installment_purchases", "purchase_bills"
  add_foreign_key "installments", "sale_bills"
  add_foreign_key "material_movements", "contracts"
  add_foreign_key "movement_details", "material_movements"
  add_foreign_key "movement_details", "materials"
  add_foreign_key "payments", "purchase_bills"
  add_foreign_key "purchase_bills", "providers"
  add_foreign_key "purchase_details", "materials"
  add_foreign_key "purchase_details", "purchase_bills"
  add_foreign_key "rubro_material_details", "materials"
  add_foreign_key "rubro_material_details", "rubros"
  add_foreign_key "rubro_service_details", "rubros"
  add_foreign_key "rubro_service_details", "services"
  add_foreign_key "rubros", "materials"
  add_foreign_key "rubros", "services"
  add_foreign_key "sale_bills", "clients"
  add_foreign_key "sale_bills", "contracts"
  add_foreign_key "sale_details", "client_certifications"
  add_foreign_key "sale_details", "sale_bills"
  add_foreign_key "users", "roles"
end
