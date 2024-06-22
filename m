Return-Path: <linux-kselftest+bounces-12494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFAE91315F
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 03:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34AE51F23632
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 01:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09029441D;
	Sat, 22 Jun 2024 01:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8abTtDv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4319522E;
	Sat, 22 Jun 2024 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719019458; cv=none; b=eUdssO4sgTKt1RXvRckPqR0/TiBa6g+7XT+cmefbFPvOSEAzvPg6XNnm9Y6AEF+pFIJ8PeWnTWb+IQwzvALVJ2cwHDhet4pVWVIPAOK3kfT5nUEc3DgDB10j7oSVegkHRnheJfv/j310aIFRWiDFyonLd4QqH8KV5mwrUz4mNtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719019458; c=relaxed/simple;
	bh=yApkYtcs5+O+7ijpRkT0EqN+HHboLg9uvE4CSPpswQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWiAPqWDEUlPbNE7rAQtHTkRz88hMwVlE1ibN21r353eh9QK1SaiVftNCajaI3ZGHJCrdEPpp2dj+IDoWvP/FuLsK49Q4FhpgdzqUc0OmZepy5ApCrTilpc8kdCHwzeCD1VxdEvcUAr96pBUAP1UTPsu1INHhsPfXDlJm2jxGE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8abTtDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D971CC3277B;
	Sat, 22 Jun 2024 01:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719019458;
	bh=yApkYtcs5+O+7ijpRkT0EqN+HHboLg9uvE4CSPpswQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8abTtDvmVxEq7VdK6MqDnJGQEd3V+5zpGMGDZpJ1bF2W9kPzhvEDLgX2qeyMEjC0
	 KHb9W7rzjBj9dLEI61pxKFMsCetKCUBiNrvUhQImeuGVFdIcuKVyrgAvf7VJBMlTsM
	 77PeYCkt9GGR76veC64Ny0NxYHoXE1qbVIJR0zz83/xqzkjLT5fsM1cZGTLwFvOQJv
	 ZaWgCXTb6mgEnfgqF+eliLbMe9e56ykHKciY9Zws16DVasa5jCR8b2r0OH9QlMRx88
	 yXpVRCDM1GWLJoJcPIBdXiL4WB6a7aztX2GYpWCMT+ZYN1RuMj91JkDAa52NHppviN
	 /Y6Xwrm1FhKDA==
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
Subject: [PATCH bpf-next v2 4/7] selftests/bpf: Use connect_to_fd in sk_lookup
Date: Sat, 22 Jun 2024 09:23:44 +0800
Message-ID: <49717bed77340bec2678e64b5da66b470f3991bb.1719019125.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719019125.git.tanggeliang@kylinos.cn>
References: <cover.1719019125.git.tanggeliang@kylinos.cn>
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


