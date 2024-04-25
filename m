Return-Path: <linux-kselftest+bounces-8835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE998B196A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 05:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AA08B21D8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 03:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B352F1CF8A;
	Thu, 25 Apr 2024 03:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1JZ1yN2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBEA22F0D;
	Thu, 25 Apr 2024 03:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015473; cv=none; b=qzmDgV80HJBn2/oS3sSHKbfCYANwNdmWHr2H798goNPYruGmJx7m37b9veQZp3UHcrapO/MMZpnIuAv0HrHAkyN4ghaoEmvh/mV5f/m8Y5/ZARtyYw9wB2lIZo7afqR/GPkmHtnZM5mc+M9r+GrKDaGRiALJI+pwr5Fi3A1y3NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015473; c=relaxed/simple;
	bh=MslP5v/DhbDl30mweKw1fyNAy1kzzY7JRHIHzaxV3ZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfbpHVMoOR0VPnh46Gtig1JNT1dzdmFqQdqis2fSTaHf+X3c8SXxSc/IFIR32eDGPbU/ycPA9Edh1mz8+b60wlfLOpbI3xt/CllD+KNaT6V4bQBYPm03VoZ4l18D+roZr6nKqDNZoqf1qUDtQZMoBwhk/O/Voi9oOKsZ8TdRTRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1JZ1yN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E577CC113CE;
	Thu, 25 Apr 2024 03:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714015471;
	bh=MslP5v/DhbDl30mweKw1fyNAy1kzzY7JRHIHzaxV3ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W1JZ1yN2sEzTY60+AWYk0dfLBmwEoulH7dLg8G8iLscHFVUVqjLgGKFI4zj2PYJaR
	 N1VKmzcBAY5kiGD4K1jn/ZYhoxcRvM7YpnSr9Q19mkmYpp6dSAk2xdw17+0EfSVgHM
	 smia4msG/d1cVf7izliMJrKupdI2PGwRd0Bmcxao4ddOuX5AukelUtHZ/wmIN1YOrP
	 sGK/vGHopFQIYQjbr5hWFmemXg/qqb4VlMKfKFIa9YRsUQVTP1+3QdUYbrrOF/ucJP
	 Z/GSJlAPP3ljJzzCHujF6C006fxpsYwM8U5WwV1eyH5jt8Z5sTHMEck8STRrYMxIqG
	 f0XdHnUNfmQjg==
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
Subject: [PATCH bpf-next 1/6] selftests/bpf: Add opts argument for __start_server
Date: Thu, 25 Apr 2024 11:23:41 +0800
Message-Id: <127d2f0929980b41f757dcfebe1b667e6bfb43f1.1714014697.git.tanggeliang@kylinos.cn>
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

This patch adds network_helper_opts parameter for __start_server()
instead of "int protocol" and "int timeout_ms". This not only reduces
the number of parameters, but also makes it more flexible.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 27 ++++++++++---------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index c134cd740638..b9d204a1a480 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -80,19 +80,19 @@ int settimeo(int fd, int timeout_ms)
 
 #define save_errno_close(fd) ({ int __save = errno; close(fd); errno = __save; })
 
-static int __start_server(int type, int protocol, const struct sockaddr *addr,
-			  socklen_t addrlen, int timeout_ms, bool reuseport)
+static int __start_server(int type, const struct sockaddr *addr, socklen_t addrlen,
+			  bool reuseport, const struct network_helper_opts *opts)
 {
 	int on = 1;
 	int fd;
 
-	fd = socket(addr->sa_family, type, protocol);
+	fd = socket(addr->sa_family, type, opts->proto);
 	if (fd < 0) {
 		log_err("Failed to create server socket");
 		return -1;
 	}
 
-	if (settimeo(fd, timeout_ms))
+	if (settimeo(fd, opts->timeout_ms))
 		goto error_close;
 
 	if (reuseport &&
@@ -123,14 +123,17 @@ static int __start_server(int type, int protocol, const struct sockaddr *addr,
 static int start_server_proto(int family, int type, int protocol,
 			      const char *addr_str, __u16 port, int timeout_ms)
 {
+	struct network_helper_opts opts = {
+		.timeout_ms	= timeout_ms,
+		.proto		= protocol,
+	};
 	struct sockaddr_storage addr;
 	socklen_t addrlen;
 
 	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
 		return -1;
 
-	return __start_server(type, protocol, (struct sockaddr *)&addr,
-			      addrlen, timeout_ms, false);
+	return __start_server(type, (struct sockaddr *)&addr, addrlen, false, &opts);
 }
 
 int start_server(int family, int type, const char *addr_str, __u16 port,
@@ -149,6 +152,9 @@ int start_mptcp_server(int family, const char *addr_str, __u16 port,
 int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms, unsigned int nr_listens)
 {
+	struct network_helper_opts opts = {
+		.timeout_ms = timeout_ms,
+	};
 	struct sockaddr_storage addr;
 	unsigned int nr_fds = 0;
 	socklen_t addrlen;
@@ -164,8 +170,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 	if (!fds)
 		return NULL;
 
-	fds[0] = __start_server(type, 0, (struct sockaddr *)&addr, addrlen,
-				timeout_ms, true);
+	fds[0] = __start_server(type, (struct sockaddr *)&addr, addrlen, true, &opts);
 	if (fds[0] == -1)
 		goto close_fds;
 	nr_fds = 1;
@@ -174,8 +179,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 		goto close_fds;
 
 	for (; nr_fds < nr_listens; nr_fds++) {
-		fds[nr_fds] = __start_server(type, 0, (struct sockaddr *)&addr,
-					     addrlen, timeout_ms, true);
+		fds[nr_fds] = __start_server(type, (struct sockaddr *)&addr, addrlen, true, &opts);
 		if (fds[nr_fds] == -1)
 			goto close_fds;
 	}
@@ -193,8 +197,7 @@ int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t l
 	if (!opts)
 		opts = &default_opts;
 
-	return __start_server(type, 0, (struct sockaddr *)addr, len,
-			      opts->timeout_ms, 0);
+	return __start_server(type, (struct sockaddr *)addr, len, 0, opts);
 }
 
 void free_fds(int *fds, unsigned int nr_close_fds)
-- 
2.40.1


