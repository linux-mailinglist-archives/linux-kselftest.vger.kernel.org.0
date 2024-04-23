Return-Path: <linux-kselftest+bounces-8687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893728AE257
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 12:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3D61C21949
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCE150279;
	Tue, 23 Apr 2024 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6tovTYc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9760A219FD;
	Tue, 23 Apr 2024 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868561; cv=none; b=cYUODJnqJ0++M+z4tIKP4rs2Y8mnvwslYu0RUYiDwi1ACO71s1Ghef32stryUrjjcEcmLHT0/Jx2Bi7R/7UoESTz6Vx7H33m9AkHzaWVAFQS9MKay9eBpdLQhOWykiDp+oyCsu3BQ42bWoqzpaGe8nhUqDFfpQl9MKJbkbJXBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868561; c=relaxed/simple;
	bh=YokjWLbOM68ZNxD/zFddfKnH2yFKGoD4M611tv+Xno4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MNmhJNXsgxDmYK/2R9tY1l03mh+7/rIumMKhm53JLTileYsu/sU06wKW2YGAHc/AZVX0TIKBL+OazBADJ44sXoh3lPobImP1hXjoF0r1mWxXluEgZakpHfoU9FUfliOYPw5+XujEsXZQmFzZXs8oikV2jCBExGPDms1TqIVYRwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6tovTYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6D6C4AF0C;
	Tue, 23 Apr 2024 10:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713868561;
	bh=YokjWLbOM68ZNxD/zFddfKnH2yFKGoD4M611tv+Xno4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6tovTYc0/mlJBULeXEKuc+8UccQPM+IEs5irhMQcBSphqLDC3fUAg+MQcQMyhUAK
	 rU3d9K9IRERZFUDrvPT4cNaGo8oaXQMR+WSq6jlTde2uMj/LEepCLPzkOGQsEDzmGF
	 9mzP3QpupXrpxzpQqCnPi/7ykJ2sw3tJbHlmTvI+75A3Ne7rGzj4xbELIZxS5GfAuu
	 GF5Uv0pbdEsEKvpqrB5r+muJ1LdAuoqQt7xFP31MHM5W3lVa/CH6Ri72O2cos85z8J
	 4gauVFZyDeNYNrHTvx/gE8eA+9lqiOTDFGJeNv97+q8c7wUAAi5o5WDwXS2aHxtolj
	 wDsZihR4Z9lSA==
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
Subject: [PATCH bpf-next v2 3/5] selftests/bpf: Use start_server_addr in test_sock_addr
Date: Tue, 23 Apr 2024 18:35:29 +0800
Message-Id: <3101f57bde5502383eb41723c8956cc26be06893.1713868264.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713868264.git.tanggeliang@kylinos.cn>
References: <cover.1713868264.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Include network_helpers.h in test_sock_addr.c, use the newly added public
helper start_server_addr() instead of the local defined function
start_server(). This can avoid duplicate code.

In order to use functions defined in network_helpers.c in test_sock_addr.c,
Makefile needs to be updated and <Linux/err.h> needs to be included in
network_helpers.h to avoid compilation errors.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/Makefile          |  3 +-
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 tools/testing/selftests/bpf/test_sock_addr.c  | 38 ++-----------------
 3 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f06c527eee34..2182a5af68c4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -278,11 +278,12 @@ UNPRIV_HELPERS  := $(OUTPUT)/unpriv_helpers.o
 TRACE_HELPERS	:= $(OUTPUT)/trace_helpers.o
 JSON_WRITER		:= $(OUTPUT)/json_writer.o
 CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
+NETWORK_HELPERS := $(OUTPUT)/network_helpers.o
 
 $(OUTPUT)/test_dev_cgroup: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
-$(OUTPUT)/test_sock_addr: $(CGROUP_HELPERS) $(TESTING_HELPERS)
+$(OUTPUT)/test_sock_addr: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(NETWORK_HELPERS)
 $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
 $(OUTPUT)/get_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index aef297dfa6ca..5a8c5cf4ec1a 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -11,6 +11,7 @@ typedef __u16 __sum16;
 #include <linux/ipv6.h>
 #include <linux/ethtool.h>
 #include <linux/sockios.h>
+#include <linux/err.h>
 #include <netinet/tcp.h>
 #include <bpf/bpf_endian.h>
 #include <net/if.h>
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 80c42583f597..ca4fb142b7b7 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -19,6 +19,7 @@
 #include <bpf/libbpf.h>
 
 #include "cgroup_helpers.h"
+#include "network_helpers.h"
 #include "testing_helpers.h"
 #include "bpf_util.h"
 
@@ -939,37 +940,6 @@ static int cmp_peer_addr(int sock1, const struct sockaddr_storage *addr2)
 	return cmp_sock_addr(getpeername, sock1, addr2, /*cmp_port*/ 1);
 }
 
-static int start_server(int type, const struct sockaddr_storage *addr,
-			socklen_t addr_len)
-{
-	int fd;
-
-	fd = socket(addr->ss_family, type, 0);
-	if (fd == -1) {
-		log_err("Failed to create server socket");
-		goto out;
-	}
-
-	if (bind(fd, (const struct sockaddr *)addr, addr_len) == -1) {
-		log_err("Failed to bind server socket");
-		goto close_out;
-	}
-
-	if (type == SOCK_STREAM) {
-		if (listen(fd, 128) == -1) {
-			log_err("Failed to listen on server socket");
-			goto close_out;
-		}
-	}
-
-	goto out;
-close_out:
-	close(fd);
-	fd = -1;
-out:
-	return fd;
-}
-
 static int connect_to_server(int type, const struct sockaddr_storage *addr,
 			     socklen_t addr_len)
 {
@@ -1178,7 +1148,7 @@ static int run_bind_test_case(const struct sock_addr_test *test)
 	if (init_addrs(test, &requested_addr, &expected_addr, NULL))
 		goto err;
 
-	servfd = start_server(test->type, &requested_addr, addr_len);
+	servfd = start_server_addr(test->type, &requested_addr, addr_len, NULL);
 	if (servfd == -1)
 		goto err;
 
@@ -1214,7 +1184,7 @@ static int run_connect_test_case(const struct sock_addr_test *test)
 		goto err;
 
 	/* Prepare server to connect to */
-	servfd = start_server(test->type, &expected_addr, addr_len);
+	servfd = start_server_addr(test->type, &expected_addr, addr_len, NULL);
 	if (servfd == -1)
 		goto err;
 
@@ -1271,7 +1241,7 @@ static int run_xmsg_test_case(const struct sock_addr_test *test, int max_cmsg)
 		goto err;
 
 	/* Prepare server to sendmsg to */
-	servfd = start_server(test->type, &server_addr, addr_len);
+	servfd = start_server_addr(test->type, &server_addr, addr_len, NULL);
 	if (servfd == -1)
 		goto err;
 
-- 
2.40.1


