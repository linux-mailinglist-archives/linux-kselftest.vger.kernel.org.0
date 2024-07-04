Return-Path: <linux-kselftest+bounces-13194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 724CD927299
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 11:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDF91F213AD
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C3C1AB53E;
	Thu,  4 Jul 2024 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSglCuMo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCD32BB06;
	Thu,  4 Jul 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083651; cv=none; b=E1jWsdwS8uvwjHz8TsBaaHEhJgW6r6MEDlhUt2jeynWCLyb38HdJnBKfDrKyq8l2OWrWN5hlqbVxyFQs7lGyydiWj3j+fasTh1+pF2/Mz4J5GB/HBfkjRlXBE53+UjytxQkVUBRKij0/9awGlTyBivCSn/pYiKQfCAgLiSHv0hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083651; c=relaxed/simple;
	bh=yIL0fQNsMx5ijF7GWUBR64Zkm01hjeVcW0TnosV2/ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqV2nAVB9jdLmsi3iNS+sfsVNAicbAMu2H8HsNkD4qvNEudJlJLT7Ogp4x8aEz5GWKNwUWdzBMY0BBTAUknn7S3Fdzab2lUjClwk2OmQRATs8sI1VmPOvnShOIlPCzHAzDdNT9xIzXKSdB/SIv4gpNfeJ3weg698E0nj9Dlbv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSglCuMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6FFC3277B;
	Thu,  4 Jul 2024 09:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720083650;
	bh=yIL0fQNsMx5ijF7GWUBR64Zkm01hjeVcW0TnosV2/ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZSglCuMo5Y6gfausc3OJ21X5LLVRp7qyWPAvwAV06b/rnZzSzwkmPdgBN0Y8DbBGs
	 f1pSO1nkuLU1y1VQyGy8yie7MslJbkmUETLYtYFzRqvCSvh2Q/Wlps/6vU/Cqzhwit
	 sFOeYgPkYKpEx2H3yPr7R579iBWQXK8WpJMYpxKdcSWX5TJNewIsgsBVfyGtnNmU9O
	 dK1F+V8rP5UmWzylF7BFJ8mEFTOqIrKc1v7WECGQ/SW94ghZ02WPyvSIeP2B1wKYR9
	 ndjdq4PpdGblsVl8nOloczKrY/AnLhJ48J+Xc/wmJL0SskTwpjJDKWi/RIvIZ2zbZN
	 owi+LUjHu5gmw==
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
Subject: [PATCH bpf-next v7 7/9] selftests/bpf: Use connect_to_fd_opts in sk_lookup
Date: Thu,  4 Jul 2024 16:59:44 +0800
Message-ID: <c69b06bc8caf98461cc8fc156eef1e1d7eed10af.1720083019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720083019.git.tanggeliang@kylinos.cn>
References: <cover.1720083019.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper connect_to_fd_opts() exported in
network_helpers.h instead of using make_socket() and connect() in
prog_tests/sk_lookup.c. This can simplify the code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_lookup.c      | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index d03ea3e64a2e..ef4a3db34c5f 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -874,7 +874,9 @@ static void test_redirect_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_lookup(const struct test *t)
 {
-	struct sockaddr_storage dst = {};
+	struct network_helper_opts opts = {
+		.timeout_ms = IO_TIMEOUT_SEC,
+	};
 	int client_fd, server_fd, err;
 	struct bpf_link *lookup_link;
 	ssize_t n;
@@ -888,12 +890,11 @@ static void drop_on_lookup(const struct test *t)
 	if (server_fd < 0)
 		goto detach;
 
-	client_fd = make_socket(t->sotype, t->connect_to.ip,
-				t->connect_to.port, &dst);
+	client_fd = connect_to_fd_opts(server_fd, t->sotype, &opts);
 	if (client_fd < 0)
 		goto close_srv;
 
-	err = connect(client_fd, (void *)&dst, inetaddr_len(&dst));
+	err = 0;
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client_fd);
 		if (err)
@@ -988,7 +989,9 @@ static void test_drop_on_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_reuseport(const struct test *t)
 {
-	struct sockaddr_storage dst = { 0 };
+	struct network_helper_opts opts = {
+		.timeout_ms = IO_TIMEOUT_SEC,
+	};
 	int client, server1, server2, err;
 	struct bpf_link *lookup_link;
 	ssize_t n;
@@ -1012,12 +1015,11 @@ static void drop_on_reuseport(const struct test *t)
 	if (server2 < 0)
 		goto close_srv1;
 
-	client = make_socket(t->sotype, t->connect_to.ip,
-			     t->connect_to.port, &dst);
+	client = connect_to_fd_opts(server2, t->sotype, &opts);
 	if (client < 0)
 		goto close_srv2;
 
-	err = connect(client, (void *)&dst, inetaddr_len(&dst));
+	err = 0;
 	if (t->sotype == SOCK_DGRAM) {
 		err = send_byte(client);
 		if (err)
@@ -1158,13 +1160,16 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 				    int sotype)
 {
 	int err, client_fd, connected_fd, server_fd;
+	struct network_helper_opts opts = {
+		.timeout_ms = IO_TIMEOUT_SEC,
+	};
 	struct bpf_link *lookup_link;
 
 	server_fd = make_server(sotype, EXT_IP4, EXT_PORT, NULL);
 	if (server_fd < 0)
 		return;
 
-	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	connected_fd = connect_to_fd_opts(server_fd, sotype, &opts);
 	if (connected_fd < 0)
 		goto out_close_server;
 
@@ -1178,7 +1183,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 		goto out_close_connected;
 
 	/* Try to redirect TCP SYN / UDP packet to a connected socket */
-	client_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	client_fd = connect_to_fd_opts(server_fd, sotype, &opts);
 	if (client_fd < 0)
 		goto out_unlink_prog;
 	if (sotype == SOCK_DGRAM) {
-- 
2.43.0


