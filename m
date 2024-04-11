Return-Path: <linux-kselftest+bounces-7657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016B18A0541
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01CEF1C20E52
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D04604D5;
	Thu, 11 Apr 2024 01:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxxRRgTL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DABEEB5;
	Thu, 11 Apr 2024 01:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797484; cv=none; b=LA+fpz5TDnXintuFOu4mUwVkGNy+2hUIfjgO2FyBRcMxtgr6zyNCn+p1p2HoTtabSj7WF/F2u1va5mk/t5OpM5JPLy83Z8oNTRFstmh46T9PFs1Y46u9GvjElinKoDvO4TeXEBMOr1Wme6BffsRmvqDRfwpBtf7aLb1Gii6L1yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797484; c=relaxed/simple;
	bh=zZcnBQfKixrMVLzDiYNjVUUGOzJiKw5LGXwrJ09Y7ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RX4i7IcAt89n16XdsWBDaGhLbZgJ6iRUXVF9GKolbzUwu60TY9YmwIIDhz+7Q5agnlQ8vgNB83OupQeqHyx735SJQkHRPwjYz8jnzVRXKpd0JdUWOUc41lN6qnLqxR1iv4RwnzMnrtdE/CYaTQXTYNGJ8uleWNdh/0E0/Pi2iSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxxRRgTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70652C433F1;
	Thu, 11 Apr 2024 01:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712797484;
	bh=zZcnBQfKixrMVLzDiYNjVUUGOzJiKw5LGXwrJ09Y7ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZxxRRgTLi0/B0F9vkiU05YLDSvddaK+UDOFKwcnDcBLldgA2T3miVzVDrjJjVtDyE
	 VpXvLsT32J1bEzs/IgP3CSGTwgYbGCn19QK8d8ZxJrC/v4SzSDnasJhbOsbtB0CLxE
	 uYhuPbaGSuQIuoc/M5qRz5ZZOvXzfW+B9mAr2OuPaTPJp/QGensvOq8CGo529+vrfp
	 B6GdP4Bq3Y7+xopwxhnnmGqUcrEdoaQeIWYaRneTUdvmtocfp/m5tHxrDwJ/as1VyF
	 Oe8ehEIhwIPT4hPt2xgBPHPej8Ak0vMB9NLRzQ0j9zVwIT4UAaeXHxGgI4GQ7Bm/3O
	 G3gdn8S1wVjjw==
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
Subject: [PATCH bpf-next v2 11/14] selftests/bpf: Use start_server_setsockopt in sockopt_inherit
Date: Thu, 11 Apr 2024 09:03:19 +0800
Message-Id: <cf65883b5ad52bfe99e0dc02b6213aa0eaf51ead.1712796967.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712796967.git.tanggeliang@kylinos.cn>
References: <cover.1712796967.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Include network_helpers.h in prog_tests/sockopt_inherit.c, use public
helpers make_sockaddr() and start_server_setsockopt() instead of the
local defined function start_server(). This can avoid duplicate code.

Add a helper setsockopt_loop() to set SOL_CUSTOM sockopt looply, and
pass it to start_server_setsockopt().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../bpf/prog_tests/sockopt_inherit.c          | 33 ++++++++-----------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index 917f486db826..f000d9229765 100644
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
+static int setsockopt_loop(int fd, int val)
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
@@ -125,13 +115,18 @@ static int start_server(void)
 		}
 	}
 
-	if (bind(fd, (const struct sockaddr *)&addr, sizeof(addr)) < 0) {
-		log_err("Failed to bind socket");
-		close(fd);
-		return -1;
-	}
+	return 0;
+}
 
-	return fd;
+static int start_server_lo(void)
+{
+	struct sockaddr_storage addr;
+	socklen_t addrlen;
+
+	if (make_sockaddr(AF_INET, "127.0.0.1", 0, &addr, &addrlen))
+		return -1;
+	return start_server_setsockopt((struct sockaddr *)&addr, addrlen,
+				       SOCK_STREAM, (void *)setsockopt_loop, 0);
 }
 
 static void run_test(int cgroup_fd)
@@ -160,7 +155,7 @@ static void run_test(int cgroup_fd)
 	if (!ASSERT_OK_PTR(link_setsockopt, "cg-attach-setsockopt"))
 		goto close_bpf_object;
 
-	server_fd = start_server();
+	server_fd = start_server_lo();
 	if (!ASSERT_GE(server_fd, 0, "start_server"))
 		goto close_bpf_object;
 
-- 
2.40.1


