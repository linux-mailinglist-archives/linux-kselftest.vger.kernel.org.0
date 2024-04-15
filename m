Return-Path: <linux-kselftest+bounces-7939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4468A481A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 08:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5411C21DD1
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 06:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D78134A9;
	Mon, 15 Apr 2024 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWjD2I1i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873ED1CAAF;
	Mon, 15 Apr 2024 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162741; cv=none; b=erdpJs/crskTqY1lBWG0v/DJhKOM73jBRMYvUqBto+MS0cvoCBzk+W7/Ozm0jljcfYI2mw5cY5w4dXdhsKZy1aDyVFgxXn8+HJRBA0aT+ufhDJavOm/qBfmjsBllqz16svD1OkpVaXR5IbIWB2rcFfi2721uRqdKNnxRAormzo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162741; c=relaxed/simple;
	bh=W3URAAzTaKAuxanl+UQmGAIMDLYs5iSFe2bJxQA00Xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R7lipW/481ErrdNaooMQj7wcLZT+THN+UyCPQ5dvOAVjgvPAfCqn3g4hf/blbYzmOG7J+W+TpQ9vzU87jM+EJbJaRBtbSBhxKH/g18kc28WqV9yO0RkJvd+bKVJCvtyqyhh5uSFwO1jK1PJuJSWTDES1G3iFhkJq5qP2R/Z5imc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWjD2I1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECCEC113CC;
	Mon, 15 Apr 2024 06:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713162741;
	bh=W3URAAzTaKAuxanl+UQmGAIMDLYs5iSFe2bJxQA00Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWjD2I1i8F3r+h4Wy1sIVd/07PrScqwW/WUM0+sPHrZCMoj0LW+Re+HX9wJYi5+Yl
	 IN/DTwVGUvT1YVT2Ww5VJT6BfGYS4ohQ6CtyMmsJGRNrxdG7jP4VTZDp6X6dJnSeAW
	 9aKC5AzVZgYmn8LqWi14aQpvGi/rBXPEma6AnKhmEZTxyJ9p8dp70ZAv/LXka/62ZV
	 7fmvCPyg91Sbobcet7BNoefIHtoSeIFdxXwPMY7qeTgcKSwimOvEBwlsww+RH6wJw8
	 6mg2P0+itna/+XsRxxvx+qEopC2dfju52fFxpCAhErv4mWZ+sjTMOl1yJI6al+Q8az
	 t7khOlvrHNb1w==
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
Subject: [PATCH bpf-next v3 8/9] selftests/bpf: Use start_server_addr in test_sock_addr
Date: Mon, 15 Apr 2024 14:31:17 +0800
Message-Id: <7fe8f7d0716ffaa12531d97a4f1ad1c2b1cd75ad.1713161975.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713161974.git.tanggeliang@kylinos.cn>
References: <cover.1713161974.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Include network_helpers.h in test_sock_addr.c, use the newly added
public helper start_server_addr() instead of the local defined
function start_server(). This can avoid duplicate code.

In order to use functions defined in network_helpers.c, Makefile needs
to be updated and <Linux/err.h> needs to be included in network_helpers.h
to avoid compilation errors.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/Makefile          |  3 +-
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 tools/testing/selftests/bpf/test_sock_addr.c  | 38 ++-----------------
 3 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b0be07f29dde..53713f4495dd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -289,11 +289,12 @@ UNPRIV_HELPERS  := $(OUTPUT)/unpriv_helpers.o
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
index 9e6fcc89a8d0..5e0806a3d745 100644
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
index 80c42583f597..9ce5dad7468b 100644
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
+	servfd = start_server_addr(test->type, &requested_addr, addr_len);
 	if (servfd == -1)
 		goto err;
 
@@ -1214,7 +1184,7 @@ static int run_connect_test_case(const struct sock_addr_test *test)
 		goto err;
 
 	/* Prepare server to connect to */
-	servfd = start_server(test->type, &expected_addr, addr_len);
+	servfd = start_server_addr(test->type, &expected_addr, addr_len);
 	if (servfd == -1)
 		goto err;
 
@@ -1271,7 +1241,7 @@ static int run_xmsg_test_case(const struct sock_addr_test *test, int max_cmsg)
 		goto err;
 
 	/* Prepare server to sendmsg to */
-	servfd = start_server(test->type, &server_addr, addr_len);
+	servfd = start_server_addr(test->type, &server_addr, addr_len);
 	if (servfd == -1)
 		goto err;
 
-- 
2.40.1


