Return-Path: <linux-kselftest+bounces-8118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7658A6807
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37222813C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB2E1272AA;
	Tue, 16 Apr 2024 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1r1p4T1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988CE86250;
	Tue, 16 Apr 2024 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262517; cv=none; b=b5Hxf91mJm7uh1JSqd0x8sktAJw0BLrQuiHI7acugm+N+xTbYX72wx3tKLhtE5GoGDr+Oqa5U+4beYs8NQL/UdbpBQCkFS6btMmZUsv37i68ZpSy/4ZNe5xU5ynA1XopvIVnIpRbzNpHQzXzmnZ/EWzj24obgNiohvGWUV8CXk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262517; c=relaxed/simple;
	bh=W3URAAzTaKAuxanl+UQmGAIMDLYs5iSFe2bJxQA00Xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XaFHpKIiw7gzvw2ONuBxsTIUkCc8JI37AG9PVHafAWiU2cshcY6L5vIzHSfhWdgox124hc7uVwfejrsjxDmq5fMt94QNyjLABtkODC+arU6mtj/1U8CCILq0sDgVTMQ/pW4dOfo3QSBdZG6kX23RXVx1TQHozu8Pp5u+L4ari1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1r1p4T1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCE6C4AF07;
	Tue, 16 Apr 2024 10:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262517;
	bh=W3URAAzTaKAuxanl+UQmGAIMDLYs5iSFe2bJxQA00Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1r1p4T1luKbAL6tTNl4z0brf/gF+mQVC2jaCRGxuBXIOfwDbL2vMSX3J0+sIs3wV
	 YNZhbGqgtCtVaXq2tKDrO03HcYVDjR/lfCSLRnrEZGPxcIaLzRvuOF/+5EoUFiU8Az
	 BFchRMTPMywow7UZERQlLKUZmaegN+ehGg0VPSYN8kNjB85XAAgg4QDlFIQatRABdn
	 8nBM0iAo4zLLIPIEnaarAzKU4aecfG1vTKXOfaU5ZJJpe4PUnGikR31aAeUQrwGJnr
	 fBVK1+aURdq9bxOlPQCeCKvCsFK7IUzlqZF0RkMBG6KYcV289FWQimSICWn3QcUWy8
	 miEho3V4OHVtg==
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
Subject: [PATCH bpf-next v4 10/14] selftests/bpf: Use start_server_addr in test_sock_addr
Date: Tue, 16 Apr 2024 18:13:56 +0800
Message-Id: <3692ba963ac309a855eeeb05c5b0cfa45dfeb7c8.1713262052.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713262052.git.tanggeliang@kylinos.cn>
References: <cover.1713262052.git.tanggeliang@kylinos.cn>
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


