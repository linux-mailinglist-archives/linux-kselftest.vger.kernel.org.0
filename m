Return-Path: <linux-kselftest+bounces-8121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6008A680D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906921F21906
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F9F1272AA;
	Tue, 16 Apr 2024 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BveOyk50"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8949286244;
	Tue, 16 Apr 2024 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262537; cv=none; b=gtGwAyOt77o4GWWo0XbVE3u2rCUnnQJ7dX3Sc2u1SX/RFW95M1Pl85+Z+IAwv77dlPuVulhb5s2rGmxXZV0r0rzJcpwkK+FmZGdUOnlFE7Fdf4z9GckKhSZS/FrVG6v3T5Zzz8I2RJsyPrXP8dPlMEGHs97QsDesadz8LqtkKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262537; c=relaxed/simple;
	bh=tyobW2Do6ObYQyVRaIWjj4xb8VK248vbw4vE6pBEZsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l0NlH799WjkPswAR1kt3T/A6NKwM0lmF+8ZwVdTjkaaiYG4AD9s63o/Jmp1y3kX2gByvvva0s4QBI3usjPIMvlbrUiv++YEKGJWs8T5ihloglb3bMBxoGfknBGsIOsYwmPCRfyv2kUSagyEBayBK0TJpbUEZmCNCdkHiV3ax82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BveOyk50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50005C3277B;
	Tue, 16 Apr 2024 10:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262537;
	bh=tyobW2Do6ObYQyVRaIWjj4xb8VK248vbw4vE6pBEZsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BveOyk509SYoVOi7MA1AV1Sv/Uurf+Me+EcRz3Mt23A7pYQGsMUAjyNReq1oSOM1b
	 fC57XTGRwaQp1LsVxG0teq3AJlCGJxFyTz4P/TsRozwfuqf2fdF0mF+Ps8oQ9z5Yfx
	 Er6I7XqVtwww7jnJEd5MGxoO3YS4lbt89q9jL1fQTdXFQCb4fuOPwnQeBpSQRs2mwt
	 qcqlaXDzHtDuFMffCDpOAgV2aeBK5nagW7FITOmuc1gMndtqoyD70zEpRCpdjNqJKw
	 2KbyP5QadSDEpV9vQBfYwL8ngBkLb2dE4V7w495SkwiMpspUS9U7c12Da19zEKAyNQ
	 RDOJzrum4QJeQ==
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
Subject: [PATCH bpf-next v4 13/14] selftests/bpf: Use make_sockaddr in test_sock
Date: Tue, 16 Apr 2024 18:13:59 +0800
Message-Id: <5fd898f4d55d407c2e0be2b7a3e60c93778135d2.1713262052.git.tanggeliang@kylinos.cn>
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

This patch uses public helper make_sockaddr() exported in network_helpers.h
instead of open-coding in bind_sock() in test_sock.c. This can avoid
duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/Makefile    |  1 +
 tools/testing/selftests/bpf/test_sock.c | 28 ++++---------------------
 2 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 53713f4495dd..017fe30f49a8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -308,6 +308,7 @@ $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
 $(OUTPUT)/test_maps: $(TESTING_HELPERS)
 $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HELPERS)
 $(OUTPUT)/xsk.o: $(BPFOBJ)
+$(OUTPUT)/test_sock: $(NETWORK_HELPERS)
 
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
diff --git a/tools/testing/selftests/bpf/test_sock.c b/tools/testing/selftests/bpf/test_sock.c
index 810c3740b2cc..ac00f598ff8e 100644
--- a/tools/testing/selftests/bpf/test_sock.c
+++ b/tools/testing/selftests/bpf/test_sock.c
@@ -13,6 +13,7 @@
 #include <bpf/bpf.h>
 
 #include "cgroup_helpers.h"
+#include "network_helpers.h"
 #include <bpf/bpf_endian.h>
 #include "bpf_util.h"
 
@@ -414,8 +415,6 @@ static int bind_sock(int domain, int type, const char *ip,
 		     unsigned short port, unsigned short port_retry)
 {
 	struct sockaddr_storage addr;
-	struct sockaddr_in6 *addr6;
-	struct sockaddr_in *addr4;
 	int sockfd = -1;
 	socklen_t len;
 	int res = SUCCESS;
@@ -424,25 +423,8 @@ static int bind_sock(int domain, int type, const char *ip,
 	if (sockfd < 0)
 		goto err;
 
-	memset(&addr, 0, sizeof(addr));
-
-	if (domain == AF_INET) {
-		len = sizeof(struct sockaddr_in);
-		addr4 = (struct sockaddr_in *)&addr;
-		addr4->sin_family = domain;
-		addr4->sin_port = htons(port);
-		if (inet_pton(domain, ip, (void *)&addr4->sin_addr) != 1)
-			goto err;
-	} else if (domain == AF_INET6) {
-		len = sizeof(struct sockaddr_in6);
-		addr6 = (struct sockaddr_in6 *)&addr;
-		addr6->sin6_family = domain;
-		addr6->sin6_port = htons(port);
-		if (inet_pton(domain, ip, (void *)&addr6->sin6_addr) != 1)
-			goto err;
-	} else {
+	if (make_sockaddr(domain, ip, port, &addr, &len))
 		goto err;
-	}
 
 	if (bind(sockfd, (const struct sockaddr *)&addr, len) == -1) {
 		/* sys_bind() may fail for different reasons, errno has to be
@@ -458,10 +440,8 @@ static int bind_sock(int domain, int type, const char *ip,
 
 	goto out;
 retry:
-	if (domain == AF_INET)
-		addr4->sin_port = htons(port_retry);
-	else
-		addr6->sin6_port = htons(port_retry);
+	if (make_sockaddr(domain, ip, port_retry, &addr, &len))
+		goto err;
 	if (bind(sockfd, (const struct sockaddr *)&addr, len) == -1) {
 		if (errno != EPERM)
 			goto err;
-- 
2.40.1


