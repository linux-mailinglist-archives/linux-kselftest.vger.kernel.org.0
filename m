Return-Path: <linux-kselftest+bounces-8299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206718A94A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 10:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB9A282A43
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 08:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A167D07F;
	Thu, 18 Apr 2024 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKMMTA6E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F07C0A9;
	Thu, 18 Apr 2024 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427787; cv=none; b=FnvVjuENOiJr3zdSpI+k4RqMPU2zDIw2f2eRcLOYdshsQi3CUTPplj9pQUdTiql+XGaigYwUAI9gor89f11XHIBUicCDiZgL60a2Yk5cLkpHpVy4itb8eODsGVqii4fuKdjKAVEke0rmaeqANvdGgywn7u+hqI7ibvg5oxNH6Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427787; c=relaxed/simple;
	bh=VkOI1LTyEWa1WTCTTCieOSkjZUweM+kBa07gptDvTY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ibokFTuceB0yt4NRIwEaf7C/EPmILsey0VrH1UodZ7Y92VdWRnuLzAlMFNT/5//cg4d2j5mvb/yZTqBEJYYBQFj5rRYw8bt89bD955UHxn4ZS2M9p0DXZEbIBWU4/wFloXJckylz41ju/JT5rVlD+uPx9fcDCTPsKPv84JWkdK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKMMTA6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DCAC4AF07;
	Thu, 18 Apr 2024 08:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713427786;
	bh=VkOI1LTyEWa1WTCTTCieOSkjZUweM+kBa07gptDvTY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RKMMTA6EROt6DuMVkduIlbjC3UCMXf6wKVfgH4M6H/s+CuIEGHlKl1Rxbt23uEODh
	 BlBhSS2DDPg8vKG1Zi/3JwQcmGo2k2BOD4iRc4O+u7dK2/XjuyBI0g0qg0UM1n2JDl
	 bsAIXvKkDCIPiJLlwvyS7AUF6iwuGLwEKvfk5y1z+BGnYHCwsznyGmevTVGK5Kyhuy
	 TVq5jhDNVtYebZMeAcPPDEZFCRDMvsj8VlYDsgR+XINifTMJLtuiiu/DCjBvSX4Czh
	 /JzuV0X86TSkgQCzAWfteLJ5ZZ5ZVYvj2guylAH7r7dHITLoT9rTOsFbb6F6LdMqKC
	 pH7Gt1TSc+4jg==
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
Subject: [PATCH bpf-next v5 4/6] selftests/bpf: Update arguments of connect_to_addr
Date: Thu, 18 Apr 2024 16:09:10 +0800
Message-Id: <088ea8a95055f93409c5f57d12f0e58d43059ac4.1713427236.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713427236.git.tanggeliang@kylinos.cn>
References: <cover.1713427236.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Move the third argument "int type" of connect_to_addr() to the first one
which is closer to how the socket syscall is doing it. And add a
network_helper_opts argument as the fourth one. Then change its usages in
sock_addr.c too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c      | 13 ++++++++++---
 tools/testing/selftests/bpf/network_helpers.h      |  3 ++-
 tools/testing/selftests/bpf/prog_tests/sock_addr.c |  6 +++---
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 28fe8367451b..9d63d2ac13d8 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -270,17 +270,24 @@ static int connect_fd_to_addr(int fd,
 	return 0;
 }
 
-int connect_to_addr(const struct sockaddr_storage *addr, socklen_t addrlen, int type)
+int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
+		    const struct network_helper_opts *opts)
 {
 	int fd;
 
-	fd = socket(addr->ss_family, type, 0);
+	if (!opts)
+		opts = &default_opts;
+
+	fd = socket(addr->ss_family, type, opts->proto);
 	if (fd < 0) {
 		log_err("Failed to create client socket");
 		return -1;
 	}
 
-	if (connect_fd_to_addr(fd, addr, addrlen, false))
+	if (settimeo(fd, opts->timeout_ms))
+		goto error_close;
+
+	if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail))
 		goto error_close;
 
 	return fd;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 414ea50bb3fc..aef297dfa6ca 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -56,7 +56,8 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
 		      const struct network_helper_opts *opts);
 void free_fds(int *fds, unsigned int nr_close_fds);
-int connect_to_addr(const struct sockaddr_storage *addr, socklen_t len, int type);
+int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
+		    const struct network_helper_opts *opts);
 int connect_to_fd(int server_fd, int timeout_ms);
 int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 5fd617718991..61668e0f11b0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -328,7 +328,7 @@ static void test_bind(struct sock_addr_test *test)
 		goto cleanup;
 
 	/* Try to connect to server just in case */
-	client = connect_to_addr(&expected_addr, expected_addr_len, test->socket_type);
+	client = connect_to_addr(test->socket_type, &expected_addr, expected_addr_len, NULL);
 	if (!ASSERT_GE(client, 0, "connect_to_addr"))
 		goto cleanup;
 
@@ -357,7 +357,7 @@ static void test_connect(struct sock_addr_test *test)
 	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
 		goto cleanup;
 
-	client = connect_to_addr(&addr, addr_len, test->socket_type);
+	client = connect_to_addr(test->socket_type, &addr, addr_len, NULL);
 	if (!ASSERT_GE(client, 0, "connect_to_addr"))
 		goto cleanup;
 
@@ -538,7 +538,7 @@ static void test_getpeername(struct sock_addr_test *test)
 	if (!ASSERT_EQ(err, 0, "make_sockaddr"))
 		goto cleanup;
 
-	client = connect_to_addr(&addr, addr_len, test->socket_type);
+	client = connect_to_addr(test->socket_type, &addr, addr_len, NULL);
 	if (!ASSERT_GE(client, 0, "connect_to_addr"))
 		goto cleanup;
 
-- 
2.40.1


