Return-Path: <linux-kselftest+bounces-8839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05C18B1971
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 05:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089E61C2222E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 03:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C571CFBC;
	Thu, 25 Apr 2024 03:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlKz4JeO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD961CAA6;
	Thu, 25 Apr 2024 03:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015506; cv=none; b=sfpt8azDFHG0O1TuUEFblhorlM3CmAdlEdUi02hCK3OLyw03HlEWy2TwNe3tplDzrCRMqUgddCzzxPFTJqkEbpPr41QivSFCXF3pg3smeCA/hwDNeuhi3tWVPGln3gM3S98UDI9+kn1sKsYpcksxgZovTwFwE0Ayk5+0f4jzEAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015506; c=relaxed/simple;
	bh=GEmknfXbM8BqwBQteO+nfWsRu6fmsr9HCBaPQe0RqrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YdvONeispqu0i+YT5FiFwFO5HQJW716houpbifCRB2bMoi3gsMVlVL5CGXcJ2nNapjrUrB91tE30dIWZzORkbnneOgbyxvfKwYoGm7CQC7hbafbasrfwnVoVOtcbJJXsfmTod5uWMFEWzvRPQkWFIOg4zSRAXlh5fC4GGRg8J6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlKz4JeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED83FC2BBFC;
	Thu, 25 Apr 2024 03:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714015506;
	bh=GEmknfXbM8BqwBQteO+nfWsRu6fmsr9HCBaPQe0RqrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GlKz4JeOWbgobZzoCgKyFHH6cEPO0dsoJEvL4+g+Jyt3XnlkQIvWedxMsjreYqGtu
	 zyyyTECvTj6zSDUM4NEpr/3TxeKfJbjlAjDXeT5pZb2XDXHC1hwKwyhKrjeJRLLwAH
	 jjTu+sFuaJKpsz0XqBFGx0XUTmX0r2uSqXdkad+8ljXUv5WfQHM8iqBq66mR18eg5R
	 WivLRVa/RJCpP5mNMNN054gY0T7734jNMpjHUqWeNaK7rFK+lFHkFOGlKL2BcF4UX3
	 aE9iHA09Tgtghy+jBSIjMnjGQ0uqQE+9cRr4s8s5vwnk1N2fxpWKuvnOMr9KsqfTMD
	 vyFJQOJI1s5+g==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next 5/6] selftests/bpf: Use start_server_addr in sockopt_inherit
Date: Thu, 25 Apr 2024 11:23:45 +0800
Message-Id: <53b6b85cbcdc9e3a7277d8e06c4b53c42dadbd5b.1714014697.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1714014697.git.tanggeliang@kylinos.cn>
References: <cover.1714014697.git.tanggeliang@kylinos.cn>
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

Add a helper setsockopt_custom() to set SOL_CUSTOM sockopt looply, set
it to setsockopt pointer of struct network_helper_opts, and pass it to
start_server_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../bpf/prog_tests/sockopt_inherit.c          | 34 +++++++------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index 917f486db826..31cf7e9075da 100644
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
+static int setsockopt_custom(int fd, const void *optval, socklen_t optlen)
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
+		.setsockopt = setsockopt_custom,
+	};
 	int server_fd = -1, client_fd;
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
 	struct sockopt_inherit *obj;
 	void *server_err;
 	pthread_t tid;
@@ -160,8 +151,9 @@ static void run_test(int cgroup_fd)
 	if (!ASSERT_OK_PTR(link_setsockopt, "cg-attach-setsockopt"))
 		goto close_bpf_object;
 
-	server_fd = start_server();
-	if (!ASSERT_GE(server_fd, 0, "start_server"))
+	server_fd = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr,
+				      sizeof(addr), &opts);
+	if (!ASSERT_GE(server_fd, 0, "start_server_addr"))
 		goto close_bpf_object;
 
 	pthread_mutex_lock(&server_started_mtx);
-- 
2.40.1


