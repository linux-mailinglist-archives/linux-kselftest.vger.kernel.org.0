Return-Path: <linux-kselftest+bounces-14103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B7693A922
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A228283D2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8331482E2;
	Tue, 23 Jul 2024 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8w3Zo4i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86391DDD6;
	Tue, 23 Jul 2024 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773361; cv=none; b=gyLufQm+HQ0IJzneuznKB2boX4Ahhntrvt8NTmq9Wthbzos+zu0lo6J6v+gXNAJF9HgExxJY2KfqnN8aOXBspiFE9zKctfbvQdEn25yHcEinGDzO7hcACXQGMK6ilVttUijcxFcsttFVW9wtE3/Nmc6bYwW4nCPH+2GmwlgIxt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773361; c=relaxed/simple;
	bh=ElpE2SCASgLAzFZeIC5RV+POqvIJfTF2T+hNolb6Xgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkCT31E2R9RihEWYAyNsJooiWJp5Ttg4rAkfVpeokHQkFKyulQSDouY6egGvhgYm3oZKQHByBIgfRlyy6uafg35Ag+VPbOc6Hbk2HdwqfT0c0gLmeA0C7iDgH0YwSUPgRMT/zs+ad/NjMAViMqmwkANdqLDmfm1NYgkGr0PvXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8w3Zo4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBADFC4AF0F;
	Tue, 23 Jul 2024 22:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773361;
	bh=ElpE2SCASgLAzFZeIC5RV+POqvIJfTF2T+hNolb6Xgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8w3Zo4ix6WFStCKHCkvG3BDjigxNuemxP31xEgB+sI/2AxoqlME8Ayrij4YV2d3X
	 nwfF4BhSfg+/+77MCdlxf5tZqBAaSS5JlmgFf9i7l6x71x0lwduRGrXz8HT9Tv5tF3
	 79HAj7ZTZcG1YVa5PoDD4JSnmNh26a3wuUp3s1v3F//hex1JnMIcZDUUBejF77OO/W
	 rF+dHLQV4nP6cMrJFH9HvVEMKGZrR4+6Kq8nsQ/+9ziYjEGuYEVjB18jRr3qEKBt9m
	 hXTnUn1HohDECViTDhFw5KS9kHhyqaL6BcGQW9AVR9GUV+ZHoXu4omMZ++ijEq58ac
	 bXRAcHE/yFKBg==
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
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 01/15] selftests/bpf: Use start_server_str in skc_to_unix_sock
Date: Wed, 24 Jul 2024 06:22:07 +0800
Message-ID: <ef82cdec1a33202e3d97d7624f04c7c992f0420b.1721771340.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721771340.git.tanggeliang@kylinos.cn>
References: <cover.1721771340.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses network helper start_server_str() in skc_to_unix_sock
test in skc_to_unix_sock.c to simplify the code.

This is the first time to use start_server_str() for a AF_UNIX socket.
The first "@" of "sun_path" needs to be skipped by make_sockaddr(), so
path string "sock_path + 1" ("skc_to_unix_sock") is passed to the helper,
not "sock_path" ("@skc_to_unix_sock").

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../bpf/prog_tests/skc_to_unix_sock.c         | 22 +++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c b/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
index 3eefdfed1db9..4c23409a3072 100644
--- a/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
+++ b/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
@@ -4,13 +4,16 @@
 #include <test_progs.h>
 #include <sys/un.h>
 #include "test_skc_to_unix_sock.skel.h"
+#include "network_helpers.h"
 
 static const char *sock_path = "@skc_to_unix_sock";
 
 void test_skc_to_unix_sock(void)
 {
+	struct network_helper_opts opts = {
+		.backlog = 1,
+	};
 	struct test_skc_to_unix_sock *skel;
-	struct sockaddr_un sockaddr;
 	int err, sockfd = 0;
 
 	skel = test_skc_to_unix_sock__open();
@@ -28,21 +31,8 @@ void test_skc_to_unix_sock(void)
 		goto cleanup;
 
 	/* trigger unix_listen */
-	sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
-	if (!ASSERT_GT(sockfd, 0, "socket failed"))
-		goto cleanup;
-
-	memset(&sockaddr, 0, sizeof(sockaddr));
-	sockaddr.sun_family = AF_UNIX;
-	strncpy(sockaddr.sun_path, sock_path, strlen(sock_path));
-	sockaddr.sun_path[0] = '\0';
-
-	err = bind(sockfd, (struct sockaddr *)&sockaddr, sizeof(sockaddr));
-	if (!ASSERT_OK(err, "bind failed"))
-		goto cleanup;
-
-	err = listen(sockfd, 1);
-	if (!ASSERT_OK(err, "listen failed"))
+	sockfd = start_server_str(AF_UNIX, SOCK_STREAM, sock_path + 1, 0, &opts);
+	if (!ASSERT_OK_FD(sockfd, "start_server_str"))
 		goto cleanup;
 
 	ASSERT_EQ(strcmp(skel->bss->path, sock_path), 0, "bpf_skc_to_unix_sock failed");
-- 
2.43.0


