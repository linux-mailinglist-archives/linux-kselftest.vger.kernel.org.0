Return-Path: <linux-kselftest+bounces-12542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A61914128
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 06:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E654B22863
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 04:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6053DF49;
	Mon, 24 Jun 2024 04:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="df+70FAz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8C7DDDC;
	Mon, 24 Jun 2024 04:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719203711; cv=none; b=Dlu6mOpwoIDqgmSQYum4SNyG7sSkMdE8AhhwDpP3wrGaocEJfEkn/OHHsjadqrFncMsKXXN2ozcCUTV8f6coMwZXnb1c3tfWLapVMyZqA56jXsjZoG+tUqGNMEBncHUfffmxLXxZimUrnEQDxMTitT49CNeuKfPjkRm5wYfyu7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719203711; c=relaxed/simple;
	bh=uJEQg3aL1HWizXL1rTp0C2Wp9owEq4OCbwJu5gsFv8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRyUu9h65+8Kpbv5jNSbwSsvA6l9Vj/o6U7dhHWD1ij6DHWtO+L8MM/46RbIFH6dOvHlVBcQZuiFBOqhxQbaFQqrt6HAhpnrGOk6XBFV6IL+u+H+j0ROUH1Zbnz7RZf226oqHajFLebCtI5EO74ExqLGSz+LjJYjvlklIPVfSxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=df+70FAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068F3C2BBFC;
	Mon, 24 Jun 2024 04:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719203711;
	bh=uJEQg3aL1HWizXL1rTp0C2Wp9owEq4OCbwJu5gsFv8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=df+70FAzRr7eVjxDw+85/iMtUbzf/fFHRpz0QSY+8Yp1AaKzxr4Q3G8Fcn54QcfLD
	 ZE3K9/Te8HNtvo57bD8egT+J4FZPwAMkRs+GI43RmLM0C/8Bom4smHOf8laQJOf3S8
	 Y1jp3zomymLC+IWGKQvTMaRNih5iHH0NaNOrpXtdNDzRZjMHuh7E3EicQX7z6vaTtz
	 WF4I0nUwQUSJilevUY4oSXHUmoI3A0cJwjYgZzRH4bAwxLLENssh8mr4gGWbsFRQTI
	 13Ko8v/+91Ens1yVXRNS/gnn+deXQCuBczoGbbl8Nz4pFZaf6NyVuCkrrTj9lXTZys
	 s9+HBynDCFU/w==
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
Subject: [PATCH bpf-next v4 8/9] selftests/bpf: Use connect_to_fd in sk_lookup
Date: Mon, 24 Jun 2024 12:33:55 +0800
Message-ID: <ac106d422e1b91ffc63e40d712ccf4a3bfb7ee0f.1719203293.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719203293.git.tanggeliang@kylinos.cn>
References: <cover.1719203293.git.tanggeliang@kylinos.cn>
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
index 634c2ac0595e..e1c5b7d1fb3a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -861,7 +861,6 @@ static void drop_on_lookup(const struct test *t)
 		.post_socket_cb = setsockopts,
 		.cb_opts	= &cb_opts,
 	};
-	struct sockaddr_storage dst = {};
 	int client_fd, server_fd, err;
 	struct bpf_link *lookup_link;
 	ssize_t n;
@@ -878,12 +877,11 @@ static void drop_on_lookup(const struct test *t)
 	if (attach_reuseport(server_fd, t->reuseport_prog))
 		goto close_srv;
 
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
@@ -997,7 +995,6 @@ static void drop_on_reuseport(const struct test *t)
 		.post_socket_cb = setsockopts,
 		.cb_opts	= &cb_opts2,
 	};
-	struct sockaddr_storage dst = { 0 };
 	int client, server1, server2, err;
 	struct bpf_link *lookup_link;
 	ssize_t n;
@@ -1024,12 +1021,11 @@ static void drop_on_reuseport(const struct test *t)
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
@@ -1195,7 +1191,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 	if (server_fd < 0)
 		return;
 
-	connected_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	connected_fd = connect_to_fd(server_fd, IO_TIMEOUT_SEC);
 	if (connected_fd < 0)
 		goto out_close_server;
 
@@ -1209,7 +1205,7 @@ static void run_sk_assign_connected(struct test_sk_lookup *skel,
 		goto out_close_connected;
 
 	/* Try to redirect TCP SYN / UDP packet to a connected socket */
-	client_fd = make_client(sotype, EXT_IP4, EXT_PORT);
+	client_fd = connect_to_fd(server_fd, IO_TIMEOUT_SEC);
 	if (client_fd < 0)
 		goto out_unlink_prog;
 	if (sotype == SOCK_DGRAM) {
-- 
2.43.0


