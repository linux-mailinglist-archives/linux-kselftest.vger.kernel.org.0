Return-Path: <linux-kselftest+bounces-12443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2367B91228E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 12:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F501C23A42
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E79171E77;
	Fri, 21 Jun 2024 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUkeVpJy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E01274416;
	Fri, 21 Jun 2024 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966168; cv=none; b=e3NGugfB0Rscf+4Am6SwHpLt29P9XZSDSjXliD6S357BVz+LgxBwyU1M5QRGIiWUAHj8MmmfVFpsSuVqV6VPMU1dW1927jwQObE85rgYvTU6Xmy18IZMjgVUK8eYd7rhhNr1V+Yu4mgtCeMLvzndtKUYiIXUNHZ417K35p/MxcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966168; c=relaxed/simple;
	bh=WzGOMLewYd5PMcP0rKoHd/PUDB+GjRgLRtoznjoAL1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8LSlLV4m8Dk7QU9zQcjeiOFVl1HQVR6nnhJZLqxdvcKF5lX7nsEyW/k0HeIKGr6AQFtj1n8FrIM6/rnZuqU84EDYWNbOsRVc5Lt3Y5P26IWXnRyZTDhps39B7R2Y6fyyYqbXIDKSDN3aBmELR0QIW9afNE2Kanf+D1fLjllsB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUkeVpJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD6BC32781;
	Fri, 21 Jun 2024 10:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718966167;
	bh=WzGOMLewYd5PMcP0rKoHd/PUDB+GjRgLRtoznjoAL1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iUkeVpJykFr+2VvDbNKR7HEktVUtwtw4TwbMaDkbVIHDHMKbJfytJznwONcJ9Va7w
	 ttCpTN92kTkO1znFTqhXMssUDy7tjJDEPoNJTnKRvdkQN6L3C4fRIxJ+/focowzOD+
	 J+835Sf8e6APtzjuO4zYKKzFDQVP4hocxDKd7VkcAA1jM7LR/AgjQnebT/0PjNs/CZ
	 xwpAWhJetBaKuvdPHa4npSwTkGGy9avWz+guCdzyhe2Ej0atRdX7UNvu9nfegtzOF8
	 UnFx5sn2MByDIYnC7844+Js29Ew/zQpmhJHnIbdkMPfYudqDMxeXIQhkodxw+ywAQR
	 2TQeUpCN9JBLA==
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
Subject: [PATCH bpf-next 5/6] selftests/bpf: Use connect_to_fd in sk_lookup
Date: Fri, 21 Jun 2024 18:35:28 +0800
Message-ID: <588b96d36b36f88095802d28a6b236842e30cb96.1718965270.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718965270.git.tanggeliang@kylinos.cn>
References: <cover.1718965270.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/prog_tests/sk_lookup.c      | 33 +++++--------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 2fc2b928e168..0f2e8a4c1524 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -868,10 +868,8 @@ static void test_redirect_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_lookup(const struct test *t)
 {
-	struct sockaddr_storage dst = {};
 	int client_fd, server_fd, err;
 	struct bpf_link *lookup_link;
-	socklen_t len;
 	ssize_t n;
 
 	lookup_link = attach_lookup_prog(t->lookup_prog);
@@ -883,12 +881,10 @@ static void drop_on_lookup(const struct test *t)
 	if (server_fd < 0)
 		goto detach;
 
-	client_fd = make_socket(t->sotype, t->connect_to.ip,
-				t->connect_to.port, &dst, &len);
+	client_fd = connect_to_fd(server_fd, 0);
 	if (client_fd < 0)
 		goto close_srv;
 
-	err = connect(client_fd, (void *)&dst, len);
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client_fd);
 		if (err)
@@ -983,10 +979,8 @@ static void test_drop_on_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_reuseport(const struct test *t)
 {
-	struct sockaddr_storage dst = { 0 };
 	int client, server1, server2, err;
 	struct bpf_link *lookup_link;
-	socklen_t len;
 	ssize_t n;
 
 	lookup_link = attach_lookup_prog(t->lookup_prog);
@@ -1008,12 +1002,10 @@ static void drop_on_reuseport(const struct test *t)
 	if (server2 < 0)
 		goto close_srv1;
 
-	client = make_socket(t->sotype, t->connect_to.ip,
-			     t->connect_to.port, &dst, &len);
+	client = connect_to_fd(server2, 0);
 	if (client < 0)
 		goto close_srv2;
 
-	err = connect(client, (void *)&dst, len);
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client);
 		if (err)
@@ -1160,7 +1152,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 	if (server_fd < 0)
 		return;
 
-	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	connected_fd = connect_to_fd(server_fd, 0);
 	if (connected_fd < 0)
 		goto out_close_server;
 
@@ -1174,7 +1166,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 		goto out_close_connected;
 
 	/* Try to redirect TCP SYN / UDP packet to a connected socket */
-	client_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	client_fd = connect_to_fd(server_fd, 0);
 	if (client_fd < 0)
 		goto out_unlink_prog;
 	if (sotype == SOCK_DGRAM) {
@@ -1223,11 +1215,9 @@ struct test_multi_prog {
 
 static void run_multi_prog_lookup(const struct test_multi_prog *t)
 {
-	struct sockaddr_storage dst = {};
 	int map_fd, server_fd, client_fd;
 	struct bpf_link *link1, *link2;
 	int prog_idx, done, err;
-	socklen_t len;
 
 	map_fd = bpf_map__fd(t->run_map);
 
@@ -1257,17 +1247,13 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 	if (err)
 		goto out_close_server;
 
-	client_fd = make_socket(SOCK_STREAM, EXT_IP4, EXT_PORT, &dst, &len);
-	if (client_fd < 0)
-		goto out_close_server;
-
-	err = connect(client_fd, (void *)&dst, len);
-	if (CHECK(err && !t->expect_errno, "connect",
+	client_fd = connect_to_fd(server_fd, 0);
+	if (CHECK(client_fd < 0 && !t->expect_errno, "connect",
 		  "unexpected error %d\n", errno))
-		goto out_close_client;
-	if (CHECK(err && t->expect_errno && errno != t->expect_errno,
+		goto out_close_server;
+	if (CHECK(client_fd < 0 && t->expect_errno && errno != t->expect_errno,
 		  "connect", "unexpected error %d\n", errno))
-		goto out_close_client;
+		goto out_close_server;
 
 	done = 0;
 	prog_idx = PROG1;
@@ -1281,7 +1267,6 @@ static void run_multi_prog_lookup(const struct test_multi_prog *t)
 	CHECK(err, "bpf_map_lookup_elem", "failed\n");
 	CHECK(!done, "bpf_map_lookup_elem", "PROG2 !done\n");
 
-out_close_client:
 	close(client_fd);
 out_close_server:
 	close(server_fd);
-- 
2.43.0


