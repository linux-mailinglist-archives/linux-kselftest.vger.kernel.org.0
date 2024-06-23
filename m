Return-Path: <linux-kselftest+bounces-12507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3991491372E
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 03:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BAF1F22634
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 01:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B827D2CA7;
	Sun, 23 Jun 2024 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDthJMOv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E78B653;
	Sun, 23 Jun 2024 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719105660; cv=none; b=emgzhZByeDFYWWgxD3FDjA0EZeRJqIa6osSSz206BL3kbvf1QcVS1qShudrkUi7qZtIG7CabILPLYP2rs0iihKPFytIEtQQznyt9P0gMrQi+4EhqhvyIhnr7H71X1BchXy8+tCtmCZptBhUl9nngX7Kx2OJAzQTQ8x/xhct2NDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719105660; c=relaxed/simple;
	bh=yApkYtcs5+O+7ijpRkT0EqN+HHboLg9uvE4CSPpswQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlDI7AePCQlf6FpQZfW8pd9NXw4G8Urfa8CvYSeMYvtsUwHyygX+0BXUleNp8HI8x0TsyFiPRKw+G0Ds2JJcbhuaxBxqiWywW3QFlGV25gDxR8qtPd1SlRJMmEShMHDB1XBJnTn4AADDbWGGSYUqw+HQiVOTNPaf/Db4zzNHQVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDthJMOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F8CC3277B;
	Sun, 23 Jun 2024 01:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719105660;
	bh=yApkYtcs5+O+7ijpRkT0EqN+HHboLg9uvE4CSPpswQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mDthJMOvah4qp9xNKXQj/NQqZMZBNtDIK6Z8XzHuRdK0/wq1Zihjtay+dCXUUDXkw
	 HT455Kh3Lui4T2DbbH22Nmm5Q29tybzVpjnUP2M5auaZHzyba+igsXpG5mwpsSG73z
	 VRDKFS1I3D/VmXdnjmPW5jfo3vTIpGBhhtOqNByEe3yx8XZO4+rZkfQMW+bct0ka3F
	 uywPJbgZJJRTlqnT7l5he5D7wtWlnpxXeUkOkz/kglq3kFR/lcxcrX78X/JVv+tyrV
	 ENx8OXwGeYCXBLwC+cfS0ApY6weEQjaKXpQ+bYnBbanu84Eh3ajFnTYe6B0aSKdUwo
	 bbHui5qb/7YkA==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 5/8] selftests/bpf: Use connect_to_fd in sk_lookup
Date: Sun, 23 Jun 2024 09:19:59 +0800
Message-ID: <258f597d25fe5b2f279b249deaf7c5b070569387.1719105178.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719105178.git.tanggeliang@kylinos.cn>
References: <cover.1719105178.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper connect_to_fd() exported in network_helpers.h
instead of using make_socket() and connect() in prog_tests/sk_lookup.c.
This can simplify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/sk_lookup.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index ba73b56f4484..4a4fc22ed0d2 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -873,7 +873,6 @@ static void test_redirect_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_lookup(const struct test *t)
 {
-	struct sockaddr_storage dst = {};
 	int client_fd, server_fd, err;
 	struct bpf_link *lookup_link;
 	ssize_t n;
@@ -887,12 +886,11 @@ static void drop_on_lookup(const struct test *t)
 	if (server_fd < 0)
 		goto detach;
 
-	client_fd = make_socket(t->sotype, t->connect_to.ip,
-				t->connect_to.port, &dst);
+	client_fd = connect_to_fd(server_fd, IO_TIMEOUT_SEC);
 	if (client_fd < 0)
 		goto close_srv;
 
-	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
+	err = 0;
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client_fd);
 		if (err)
@@ -987,7 +985,6 @@ static void test_drop_on_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_reuseport(const struct test *t)
 {
-	struct sockaddr_storage dst = { 0 };
 	int client, server1, server2, err;
 	struct bpf_link *lookup_link;
 	ssize_t n;
@@ -1011,12 +1008,11 @@ static void drop_on_reuseport(const struct test *t)
 	if (server2 < 0)
 		goto close_srv1;
 
-	client = make_socket(t->sotype, t->connect_to.ip,
-			     t->connect_to.port, &dst);
+	client = connect_to_fd(server2, IO_TIMEOUT_SEC);
 	if (client < 0)
 		goto close_srv2;
 
-	err = connect(client, (void *)&dst, inetaddr_len(&dst));
+	err = 0;
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client);
 		if (err)
@@ -1163,7 +1159,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 	if (server_fd < 0)
 		return;
 
-	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	connected_fd = connect_to_fd(server_fd, IO_TIMEOUT_SEC);
 	if (connected_fd < 0)
 		goto out_close_server;
 
@@ -1177,7 +1173,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 		goto out_close_connected;
 
 	/* Try to redirect TCP SYN / UDP packet to a connected socket */
-	client_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	client_fd = connect_to_fd(server_fd, IO_TIMEOUT_SEC);
 	if (client_fd < 0)
 		goto out_unlink_prog;
 	if (sotype == SOCK_DGRAM) {
-- 
2.43.0


