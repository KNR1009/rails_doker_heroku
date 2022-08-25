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

describe 'Post /posts' do
  it '新しいタスクを作成する' do
    valid_params = { title: "test"}

    #データが作成されていることを確認
    expect { post '/posts', params: valid_params }.to change(Post, :count).by(+1)
    expect(response.status).to eq(201)
  end
end

describe "PUT /posts/:id" do
  it 'ユーザーが更新されること' do
    post = create(:post)
    post_update_params = {
      title: "更新です"
    }
    put "/posts/#{post.id}", params: post_update_params

    expect(response.status).to eq(200)
    expect(post.reload.title).to eq(post_update_params[:title])
  end
end

describe 'Delete /posts/:id' do
  it 'postを削除する' do
    post = create(:post)
    #データが削除されている事を確認
    expect { delete "/posts/#{post.id}" }.to change(Post, :count).by(-1)
    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(204)
  end
end
