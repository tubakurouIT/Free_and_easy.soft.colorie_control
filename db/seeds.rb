
Admin.find_or_create_by!(email: "aa@aa") do |admin|
  admin.password = "123456"
end

# 5人のユーザーを作成
5.times do |n|
  member = Member.create(
    name: "member#{n+1}", # ユーザー名を設定 ("user1" から "user5")
    email: "test#{n+1}@test.com", # ユーザーのメールアドレスを設定
    password: "123456", # パスワードを一律で設定
  )
end