Return-Path: <linux-kselftest+bounces-8840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0615C8B1973
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 05:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9F71F22F0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 03:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C791A1D524;
	Thu, 25 Apr 2024 03:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlzr+pFB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FADB1CF8A;
	Thu, 25 Apr 2024 03:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015517; cv=none; b=GBM2QYc8qsPTnSfKfgiA+KVxIdsve5GAVAWa0tNCwfErVEalycb+GVWEFu2JZ8/TvMeg1Pg6QNr8ggCuSa9y9loBTt4LSNmTew1gVgopCzeuLPsQ8spa8Hh5dP3wdpFMTI3tsL7JhpvjJHGAyGoy6+4cBxDMPl6nRSfdpRfMpqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015517; c=relaxed/simple;
	bh=KKa40t/UH/iVI8vNB195Mgml0vbWpiZwIBJwGi8S2/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JDS9dX+qjgRLGDfqTmd8a0SyIV8RSUuwkN5eP3WlVd5F7oetMJDD9sA0WJKjJrB324Viiuy53hBv82WVC6kdQkOjgy0xLBWa5RLM9aHVOfVHk7BMWAk8UobfynWpmrDfw95RehoFQWSbdU11FJxk8BSLPq0u0LVo2Q5XOzGYkns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlzr+pFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EE6C4AF08;
	Thu, 25 Apr 2024 03:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714015517;
	bh=KKa40t/UH/iVI8vNB195Mgml0vbWpiZwIBJwGi8S2/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nlzr+pFBrfyBl8kK3/4cpyuKJUdsfr6A/XVcKVXb2LDr08dEmLdsvsSZ6BaiCwxae
	 tZqPzwcI6D/q2kLAJx8U/jeY5swwKXJ37YQk7eO51XqE1TW/QfgAnL/KE/eeZ3fVjW
	 b5vR0+v7MlqsVDxqTcIqtvpF5MPUjzela2iuKwcJhVhUVXtu7pSYYnHfm1Ac2mrTf7
	 1P3fPNr63pcW/bL0R8lxob0zRlMO1qMCJ30C0Ys64N28PF8VdFBiTbJoXg8tzktaQq
	 B0qTxU01i0tdc3KXbuE8ThXrMznDzZofuKSOwgBKkFtXeQavg/ESDvZriWpFsJiKxL
	 xBQSdQ+DLDjbw==
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
Subject: [PATCH bpf-next 6/6] selftests/bpf: Use start_server_addr in test_tcp_check_syncookie
Date: Thu, 25 Apr 2024 11:23:46 +0800
Message-Id: <4be40922b4f10fe6b5da1e5898b46f322713b72e.1714014697.git.tanggeliang@kylinos.cn>
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

Include network_helpers.h in test_tcp_check_syncookie_user.c, use
public helper start_server_addr() in it instead of the local defined
function start_server(). This can avoid duplicate code.

Add a helper setsockopt_v6only() to set IPV6_V6ONLY sockopt, set it
to setsockopt pointer of struct network_helper_opts, and pass it to
start_server_setsockopt().

In order to use functions defined in network_helpers.c, Makefile needs
to be updated too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/Makefile          |  1 +
 .../bpf/test_tcp_check_syncookie_user.c       | 64 ++++++-------------
 2 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2182a5af68c4..b5496ebec594 100644
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
index 32df93747095..bf60d529d0e8 100644
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
@@ -216,8 +179,19 @@ static bool get_port(int server_fd, in_port_t *port)
 	return true;
 }
 
+static int setsockopt_v6only(int fd, const void *optval, socklen_t optlen)
+{
+	return setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, optval, optlen);
+}
+
 int main(int argc, char **argv)
 {
+	int mode = false;
+	struct network_helper_opts opts = {
+		.setsockopt	= setsockopt_v6only,
+		.optval		= &mode,
+		.optlen		= sizeof(mode),
+	};
 	struct sockaddr_in addr4;
 	struct sockaddr_in6 addr6;
 	struct sockaddr_in addr4dual;
@@ -259,18 +233,20 @@ int main(int argc, char **argv)
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
+	mode = true;
+	server_v6 = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr6,
+				      sizeof(addr6), &opts);
 	if (server_v6 == -1 || !get_port(server_v6, &addr6.sin6_port))
 		goto err;
 
-	server_dual = start_server((const struct sockaddr *)&addr6dual,
-				   sizeof(addr6dual), true);
+	mode = false;
+	server_dual = start_server_addr(SOCK_STREAM, (struct sockaddr_storage *)&addr6dual,
+					sizeof(addr6dual), &opts);
 	if (server_dual == -1 || !get_port(server_dual, &addr4dual.sin_port))
 		goto err;
 
-- 
2.40.1


