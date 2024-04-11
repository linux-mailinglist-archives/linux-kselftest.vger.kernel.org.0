Return-Path: <linux-kselftest+bounces-7659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A58F8A0546
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D77B1C20F71
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEF6605CE;
	Thu, 11 Apr 2024 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeGS4oNa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E23605BA;
	Thu, 11 Apr 2024 01:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797498; cv=none; b=TakL0edhcDTtqkzRo1U10oqmxPupwvWPxB2XSmvX/vWCDIpoXvLg5YfdgZq8hxhHth2t6k5406y8s/FGAgejSwFRmF/IWLpVn+YwJNstsP698xgO7kest5+mLKI7Il2PmRXmvVKK2Ib559avncJ+I+HzHziwLefMsi1ZLvrlBAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797498; c=relaxed/simple;
	bh=D681493RS9/j/Z5FXYsW/FjB6GnXH9LyJ4AKTGsA0ZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JI5GQGATtCHsQpeatvgIPWYGjJdKpzPQiDPasylb0kfrxzmPpLtTu+xQkMMw3CkI3UAF+0pEfCNNFhbjE5u+lG6T/u+wKqiFMrQ3jlEo24QaKTGjTVQGHsKp9OZfU7SY2qTB1z+9dccoQiL/KvpKmGXXtMk8CHMzRsBo3wdfGgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeGS4oNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7099C433C7;
	Thu, 11 Apr 2024 01:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712797497;
	bh=D681493RS9/j/Z5FXYsW/FjB6GnXH9LyJ4AKTGsA0ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PeGS4oNaosuVP/4FNzLSY3NtHKoLltvKG3pjH6k5mpvRSkK7orrIlugC3XB2uu4Xj
	 E3Yh6RHx5LdMvr8Xa93IXIcK39VkR0Xve8CyPuB1+2ZiokLMVGaDqbRr2zcZDmUWZ1
	 youxt5dHbqLwnffu1dCt2xyoB6Xu4KFAKxTI7RTZsBc8obCSlnvjLiJXI384XnzndA
	 TXNzlkqU20RVSYqpdDo7LAwD90YJO5OMYes/SAUJOIx9JySIy+LoXMate4dM5s+yno
	 WeQfmRox5W3WeEmD2S4GUVqlxQmhIgrlFn/ObO3V+bQ9TfOo6h1U7cVlm5IN13Y6mM
	 LU1odBPh3qOEA==
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
Subject: [PATCH bpf-next v2 13/14] selftests/bpf: Use start_server_* in test_tcp_check_syncookie
Date: Thu, 11 Apr 2024 09:03:21 +0800
Message-Id: <9abfa7cda06cc5bf5a706bf546877c765e762112.1712796967.git.tanggeliang@kylinos.cn>
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

Include network_helpers.h in test_tcp_check_syncookie_user.c, use
public helpers start_server_addr() and start_server_setsockopt() in it
instead of the local defined function start_server(). This can avoid
duplicate code.

Add a helper setsockopt_mode() to set IPV6_V6ONLY sockopt, and pass it
to start_server_setsockopt().

In order to use functions defined in network_helpers.c, Makefile needs
to be updated to avoid compilation errors.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/Makefile          |  1 +
 .../bpf/test_tcp_check_syncookie_user.c       | 50 ++++---------------
 2 files changed, 12 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c8049d1d13b5..1199a02a5ae4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -309,6 +309,7 @@ $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
 $(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
 $(OUTPUT)/xsk.o: $(BPFOBJ)
+$(OUTPUT)/test_tcp_check_syncookie_user: $(NETWORK_HELPERS)
 
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
index 32df93747095..e6ad4895d2b3 100644
--- a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
+++ b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
@@ -16,43 +16,13 @@
 #include <bpf/libbpf.h>
 
 #include "cgroup_helpers.h"
+#include "network_helpers.h"
 
-static int start_server(const struct sockaddr *addr, socklen_t len, bool dual)
+static int setsockopt_mode(int fd, int dual)
 {
 	int mode = !dual;
-	int fd;
 
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
+	return setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, (char *)&mode, sizeof(mode));
 }
 
 static int connect_to_server(const struct sockaddr *addr, socklen_t len)
@@ -259,18 +229,20 @@ int main(int argc, char **argv)
 	addr6dual.sin6_addr = in6addr_any;
 	addr6dual.sin6_port = 0;
 
-	server = start_server((const struct sockaddr *)&addr4, sizeof(addr4),
-			      false);
+	server = start_server_addr((const struct sockaddr *)&addr4,
+				   sizeof(addr4), SOCK_STREAM);
 	if (server == -1 || !get_port(server, &addr4.sin_port))
 		goto err;
 
-	server_v6 = start_server((const struct sockaddr *)&addr6,
-				 sizeof(addr6), false);
+	server_v6 = start_server_setsockopt((const struct sockaddr *)&addr6,
+					    sizeof(addr6), SOCK_STREAM,
+					    (void *)setsockopt_mode, false);
 	if (server_v6 == -1 || !get_port(server_v6, &addr6.sin6_port))
 		goto err;
 
-	server_dual = start_server((const struct sockaddr *)&addr6dual,
-				   sizeof(addr6dual), true);
+	server_dual = start_server_setsockopt((const struct sockaddr *)&addr6dual,
+					      sizeof(addr6dual), SOCK_STREAM,
+					      (void *)setsockopt_mode, true);
 	if (server_dual == -1 || !get_port(server_dual, &addr4dual.sin_port))
 		goto err;
 
-- 
2.40.1


