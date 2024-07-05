Return-Path: <linux-kselftest+bounces-13225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA9A9280CC
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 05:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459C81F24D43
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 03:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EFA139D1B;
	Fri,  5 Jul 2024 02:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBjG8NV0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44C136E3E;
	Fri,  5 Jul 2024 02:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720148358; cv=none; b=prto/nOREZhfMRqsqv8K53ISEsiCVlimLjjE2rOG5fVLg2roU+EhGSAAcCGRpe4yCdwfpA5oDNttMyDiYPkObfwv1R0CN5ViEOcyi48zYFZRZZonGDzmVsgFljBwsvT0oYDuXWwbfUqX/b9aZ1tmWEMoe/fAmovsg/kP6U5bQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720148358; c=relaxed/simple;
	bh=yIL0fQNsMx5ijF7GWUBR64Zkm01hjeVcW0TnosV2/ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7LEyZLOzpscpU4ED0/kCsa6QLSQRPPHzhLwo1v0In5NyxfuGwI16z2wbaZgz7UD8nC8GCIcPWM+RezcoZIrRUW2so2tUoS1MPHzfAGNX86SNWnlVmdavW2yAk/D6szP982OKefkH0ntkGCEO4W0XeGkwXvKdQSkm7AjSqgYWmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBjG8NV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE542C32781;
	Fri,  5 Jul 2024 02:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720148357;
	bh=yIL0fQNsMx5ijF7GWUBR64Zkm01hjeVcW0TnosV2/ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WBjG8NV0YCkK/cOXME/VLAzFqweb8xLBwJyQSVPw2NLaFJu1qU+HmF/rtlfEDq01D
	 g/TvhlGaeZ1IAwWZ9mhKVErbZ6huPWlBazACUJN7wi5hIanwFCNq1IX6Rp+PO9GYBo
	 ak2tDbaodNCoKsdUsadVjUMcUT309/PbWWo1fSpNXVrtz5y+Tvwjf4bNjSTSWAvE7M
	 rzwosECe2uUO3zowv4yGpw0s5feCATdJQdCbLMyu9Pd9pWrxsUO4WuLmWNtHWibn0u
	 L5mkFTHPp/xd7VN3lxdsm0cN9CWkFAjfT+lEtydOfBOOgzGqYzCYVuYIb8UvuftZfh
	 MNr6u4jS71nyw==
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
Subject: [PATCH bpf-next v8 7/9] selftests/bpf: Use connect_to_fd_opts in sk_lookup
Date: Fri,  5 Jul 2024 10:58:29 +0800
Message-ID: <ea13af3dece280c663bb5cc9800674489af9ad1d.1720147953.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720147952.git.tanggeliang@kylinos.cn>
References: <cover.1720147952.git.tanggeliang@kylinos.cn>
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


