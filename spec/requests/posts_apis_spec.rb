require 'rails_helper'

describe 'GET /posts' do
  it '全て記事取得' do
    FactoryBot.create_list(:post, 10)

    get '/posts'
    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)
    # 正しい数のデータが返されたか確認する。
    expect(json.length).to eq(10)
  end
end

describe 'GET /posts/:id' do
  it '特定の記事を取得する' do
    post = create(:post, title: "サンプル記事")
    get "/posts/#{post.id}"
    json = JSON.parse(response.body)
    # # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)
    # # 正しい数のデータが返されたか確認する。
    expect(json["title"]).to eq(post["title"])
  end
end
