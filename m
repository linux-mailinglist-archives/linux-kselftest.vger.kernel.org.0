Return-Path: <linux-kselftest+bounces-7545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDCD89EC11
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2F8282739
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5BE13CFA1;
	Wed, 10 Apr 2024 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3Q6KbJs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A4F13C9D7;
	Wed, 10 Apr 2024 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734277; cv=none; b=pVhBp+2Mhf5+LckXi/iHf9NdcGLXmri3+Rr5VCCXvolweMxZECax8ZZcGhPRg0C5wlgu08OGKjPLWiq78ZODq2FBS4Fkx4M/jK3trX9pylDUxKLm0W8Yb51TMQK6XUaAbHwAbeBq2RAgeZ7xNlvHjIyi72QL8xbOdYvHcCJNGKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734277; c=relaxed/simple;
	bh=8vFSssmI4/kc94zG0VyHk4HODVY34CyEtQSmqYfN5/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZhpsJFWWHDmj2XasEpTz11LhvX0mNRVqMcGfNkNlhhnn7CBr7OkCdtOCYm5fLeOpEnVc3w19sHOhSmr2q8QAIfZVgDcybeZb6k1KijGNaJZdVcRw2wgKyjqs3Upquk3XgmYpOsxX9VlcGsvCRRxWGeEo+fsf88dG/A/QUNstoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3Q6KbJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9E8C433A6;
	Wed, 10 Apr 2024 07:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734277;
	bh=8vFSssmI4/kc94zG0VyHk4HODVY34CyEtQSmqYfN5/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X3Q6KbJsaDHa1PdiBamw3IOKQDhuX6vsrnGJcK3Qbgb+EAereZGi0jRmQTir12b/F
	 DG47wm1jiJUCNQ/d9/uRwOlVWIT8J/xNsWQx/iu0yPUa60kTH8fOGJmqfkH4yJB8xW
	 kXgT8lfN0sAXW0g2XMAO5Fi1v+JOQnh83sau/FfyojANuJFTNu6ZMQ3YjESo9qZJB+
	 B0n0KMDKYW+ZoHrudxcxR7x5hRw9kGS+fgoJmM47YyWRCa6rU630l30IKxOqi2mmJ7
	 Grh2TgvVikBmIBLLmgqMopCWTObwfDq29pLWOoHi+6b3DiNmCVXfHHMDBGgSbMM3a0
	 2i8Lrt8NTtrqw==
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
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 13/14] selftests/bpf: Use start_server_* in test_tcp_check_syncookie
Date: Wed, 10 Apr 2024 15:29:46 +0800
Message-Id: <7ace7f90ad09f4136a5c590c79216922dd8167db.1712733999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712733999.git.tanggeliang@kylinos.cn>
References: <cover.1712733999.git.tanggeliang@kylinos.cn>
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

In order to use functions defined in network_helpers.c, Makefile needs
to be updated to avoid compilation errors.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/Makefile          |  1 +
 .../bpf/test_tcp_check_syncookie_user.c       | 50 ++++---------------
 2 files changed, 12 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 60c9edc04f73..4f42dd241c38 100644
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


