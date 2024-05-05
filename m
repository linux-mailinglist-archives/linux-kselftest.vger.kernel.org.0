Return-Path: <linux-kselftest+bounces-9472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF108BC03F
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 13:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D28281A2A
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 11:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20DF179AD;
	Sun,  5 May 2024 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oShpf8JF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB67E54C;
	Sun,  5 May 2024 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714908985; cv=none; b=ovMD9mW+OsqHHeJht9vdPruldYyVemrURDgBhbBjdzaCUpolWA3Duj2R5v8JWkPP0ArR9owZDcLzzMie+xv7cCWakfTv0oQib/+t7lk5nmK4Dk25B4CnRvS7bRxAMJwY/TZ2uj2QgPXCsOHeppiUqQS/LI+84PFHCSfgrhZY6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714908985; c=relaxed/simple;
	bh=DswGYNIEvAM0xbmLADZneHkiZ5QkmT0Colzhvlh7lZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Abtm6tWVGm+c14KAbV2NIeqNpz9i6wsUEj+DUPTpLMTFyNgS2Etio0hxibaRX/0PwMJVJUOZFxwEd5daLsz3r1QSqpzWw/NoAxL/8nRTqIShC1VIXzEOFtjxfpx0g1QXE4K6lVDU8r7iwQVX/EVtmuLRg9LU7Uz9QgqznPxB8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oShpf8JF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB973C113CC;
	Sun,  5 May 2024 11:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714908985;
	bh=DswGYNIEvAM0xbmLADZneHkiZ5QkmT0Colzhvlh7lZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oShpf8JFlFXXU/Hvo+04YRpJmChcIkzhvuI8smz11UA8gO5EoR8VMNLHItFnl/khM
	 2YxvrcONKiOPBHgm0SfjE+AWyNBOu+eVdAvRM1nM4TkYi4aDp4Mt9dQfhUpwbTYysm
	 le0ykImtvMXZ8M2PnrKGTrlb5vycUvrasaX8xXFK1r5ugNzGwzMEbfvMdzVFWZQr0+
	 bg+ivMMNlrP+7QutdtaFFRj/ssw8KMOj8tnH07WSagWnhL29zbVev44ISk5awQ7rWm
	 lCzZQvQsAgHCT8IKIsgPzgWIalkLi0Pb5J4Ibtsoj8tzrfI3RMtEVoSsJXbI7WSfJ+
	 vabKMFQaz7xRw==
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
	Shuah Khan <shuah@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next 2/6] selftests/bpf: Use start_server_addr in sockopt_inherit
Date: Sun,  5 May 2024 19:35:09 +0800
Message-ID: <687af66f743a0bf15cdba372c5f71fe64863219e.1714907662.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714907662.git.tanggeliang@kylinos.cn>
References: <cover.1714907662.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Include network_helpers.h in prog_tests/sockopt_inherit.c, use public
helper start_server_addr() instead of the local defined function
start_server(). This can avoid duplicate code.

Add a helper custom_cb() to set SOL_CUSTOM sockopt looply, set it to
post_socket_cb pointer of struct network_helper_opts, and pass it to
start_server_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../bpf/prog_tests/sockopt_inherit.c          | 32 +++++++------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index 917f486db826..ff0694ef5286 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include "cgroup_helpers.h"
+#include "network_helpers.h"
 
 #include "sockopt_inherit.skel.h"
 
@@ -98,23 +99,12 @@ static void *server_thread(void *arg)
 	return (void *)(long)err;
 }
 
-static int start_server(void)
+static int custom_cb(int fd, const struct post_socket_opts *opts)
 {
-	struct sockaddr_in addr = {
-		.sin_family = AF_INET,
-		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
-	};
 	char buf;
 	int err;
-	int fd;
 	int i;
 
-	fd = socket(AF_INET, SOCK_STREAM, 0);
-	if (fd < 0) {
-		log_err("Failed to create server socket");
-		return -1;
-	}
-
 	for (i = CUSTOM_INHERIT1; i <= CUSTOM_LISTENER; i++) {
 		buf = 0x01;
 		err = setsockopt(fd, SOL_CUSTOM, i, &buf, 1);
@@ -125,20 +115,21 @@ static int start_server(void)
 		}
 	}
 
-	if (bind(fd, (const struct sockaddr *)&addr, sizeof(addr)) < 0) {
-		log_err("Failed to bind socket");
-		close(fd);
-		return -1;
-	}
-
-	return fd;
+	return 0;
 }
 
 static void run_test(int cgroup_fd)
 {
 	struct bpf_link *link_getsockopt = NULL;
 	struct bpf_link *link_setsockopt = NULL;
+	struct network_helper_opts opts = {
+		.post_socket_cb = custom_cb,
+	};
 	int server_fd = -1, client_fd;
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
 	struct sockopt_inherit *obj;
 	void *server_err;
 	pthread_t tid;
@@ -160,7 +151,8 @@ static void run_test(int cgroup_fd)
 	if (!ASSERT_OK_PTR(link_setsockopt, "cg-attach-setsockopt"))
 		goto close_bpf_object;
 
-	server_fd = start_server();
+	server_fd = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr,
+				      sizeof(addr), &opts);
 	if (!ASSERT_GE(server_fd, 0, "start_server"))
 		goto close_bpf_object;
 
-- 
2.43.0


