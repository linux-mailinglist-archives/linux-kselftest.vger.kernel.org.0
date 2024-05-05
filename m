Return-Path: <linux-kselftest+bounces-9473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DD08BC041
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 13:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A16ACB20C54
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 11:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0184C17C91;
	Sun,  5 May 2024 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8XXcLPb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCEA17556;
	Sun,  5 May 2024 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714908992; cv=none; b=uzz0B1qLQcIjE4IoKB1nDye+grICQTLt1zPw8IFBuQnfyPvwjTpFTSqQNf0lLAPtq/WjUd+foGPFdKWG5Be4bNfvSK/KZV5DhzcR1i68RozmcjTim4s+Dguqk2WKc1MM2zYgM5ClElMW2P9vbGCg9y8c0bnunhmKBf8SHHDRqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714908992; c=relaxed/simple;
	bh=e5Y6wOm375X95v05GWAm0GlDVN2W/22AEli4pK2oJiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NomEXvok6APpE3QVT4Qc0sjJpEqDmFypvEDWpCtDqNGF9jJo5ehMNOpg5RWMcKessNGWXGG00q61VWipQ+uA2vzYq7Bd+Po26+OD4pKTEPcQ1VDkjbaiGaRadHmH5PYRKtyvEyF4rAYyr00CHqnfc893Rlf9FPAy/DFDP5F0PJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8XXcLPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E39C113CC;
	Sun,  5 May 2024 11:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714908992;
	bh=e5Y6wOm375X95v05GWAm0GlDVN2W/22AEli4pK2oJiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8XXcLPbxjPkc2OCE3E1ggdQUiuJ2J21Cu3FXyNs5pWDu6QfHGomf48USOD/FLDpn
	 HDbi4FqU5hQCIesSOGsK/bTEQQDd61V39cKFbD/GFTxhwjbonLeYjzyhjBlyCAGLGJ
	 yMYjNxZNVC3qnkHlvrfmTcXWmOdGngtFAPq9W/wrD4UoJInlJzuqtHWr5e/Tkz7JG9
	 viUrIkUUCWH+oJ0tps4EA5Gkl5s1xo4k4/MIfPJkbuvLDXzs5rajxmVNlxBL3XKJup
	 2L2nN939r9v8vZetuIKXJQShzfbOzbFKZnpytE2yo5OjCtgEQ04ygt0MsuvM73GCpI
	 7hRPn/SGW48cw==
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
Subject: [PATCH bpf-next 3/6] selftests/bpf: Use start_server_addr in test_tcp_check_syncookie
Date: Sun,  5 May 2024 19:35:10 +0800
Message-ID: <e0c5324f5da84f453f47543536e70f126eaa8678.1714907662.git.tanggeliang@kylinos.cn>
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

Include network_helpers.h in test_tcp_check_syncookie_user.c, use
public helper start_server_addr() in it instead of the local defined
function start_server(). This can avoid duplicate code.

Add two helpers v6only_true() and v6only_false() to set IPV6_V6ONLY
sockopt to true or false, set them to post_socket_cb pointer of struct
network_helper_opts, and pass it to start_server_setsockopt().

In order to use functions defined in network_helpers.c, Makefile needs
to be updated too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/Makefile          |  1 +
 .../bpf/test_tcp_check_syncookie_user.c       | 68 +++++++------------
 2 files changed, 25 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 82247aeef857..b90c718218ae 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -297,6 +297,7 @@ $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
 $(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
 $(OUTPUT)/xsk.o: $(BPFOBJ)
+$(OUTPUT)/test_tcp_check_syncookie_user: $(NETWORK_HELPERS)
 
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
index 32df93747095..bf60bc267cbc 100644
--- a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
+++ b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
@@ -16,44 +16,7 @@
 #include <bpf/libbpf.h>
 
 #include "cgroup_helpers.h"
-
-static int start_server(const struct sockaddr *addr, socklen_t len, bool dual)
-{
-	int mode = !dual;
-	int fd;
-
-	fd = socket(addr->sa_family, SOCK_STREAM, 0);
-	if (fd == -1) {
-		log_err("Failed to create server socket");
-		goto out;
-	}
-
-	if (addr->sa_family == AF_INET6) {
-		if (setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, (char *)&mode,
-			       sizeof(mode)) == -1) {
-			log_err("Failed to set the dual-stack mode");
-			goto close_out;
-		}
-	}
-
-	if (bind(fd, addr, len) == -1) {
-		log_err("Failed to bind server socket");
-		goto close_out;
-	}
-
-	if (listen(fd, 128) == -1) {
-		log_err("Failed to listen on server socket");
-		goto close_out;
-	}
-
-	goto out;
-
-close_out:
-	close(fd);
-	fd = -1;
-out:
-	return fd;
-}
+#include "network_helpers.h"
 
 static int connect_to_server(const struct sockaddr *addr, socklen_t len)
 {
@@ -216,8 +179,23 @@ static bool get_port(int server_fd, in_port_t *port)
 	return true;
 }
 
+static int v6only_true(int fd, const struct post_socket_opts *opts)
+{
+	int mode = true;
+
+	return setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, &mode, sizeof(mode));
+}
+
+static int v6only_false(int fd, const struct post_socket_opts *opts)
+{
+	int mode = false;
+
+	return setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, &mode, sizeof(mode));
+}
+
 int main(int argc, char **argv)
 {
+	struct network_helper_opts opts = { 0 };
 	struct sockaddr_in addr4;
 	struct sockaddr_in6 addr6;
 	struct sockaddr_in addr4dual;
@@ -259,18 +237,20 @@ int main(int argc, char **argv)
 	addr6dual.sin6_addr = in6addr_any;
 	addr6dual.sin6_port = 0;
 
-	server = start_server((const struct sockaddr *)&addr4, sizeof(addr4),
-			      false);
+	server = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr4,
+				   sizeof(addr4), NULL);
 	if (server == -1 || !get_port(server, &addr4.sin_port))
 		goto err;
 
-	server_v6 = start_server((const struct sockaddr *)&addr6,
-				 sizeof(addr6), false);
+	opts.post_socket_cb = v6only_true;
+	server_v6 = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr6,
+				      sizeof(addr6), &opts);
 	if (server_v6 == -1 || !get_port(server_v6, &addr6.sin6_port))
 		goto err;
 
-	server_dual = start_server((const struct sockaddr *)&addr6dual,
-				   sizeof(addr6dual), true);
+	opts.post_socket_cb = v6only_false;
+	server_dual = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr6dual,
+					sizeof(addr6dual), &opts);
 	if (server_dual == -1 || !get_port(server_dual, &addr4dual.sin_port))
 		goto err;
 
-- 
2.43.0


