Return-Path: <linux-kselftest+bounces-13964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C18E938111
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 13:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BDD9B212AC
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 11:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066A512C460;
	Sat, 20 Jul 2024 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu3DYg3J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3340127E3A;
	Sat, 20 Jul 2024 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721475657; cv=none; b=O7SGNdMzXaQQ7+qB4g4zBhSXV0C2ZooPy+S9VVq5RcEAAphGg6JoptWkim/jcSpaRGD+Mos8BS0Zcj48Pb0SDD2oRLin4lfjxiyM6QdQWOmYW9A94SU0YqXx+AYJ61ZHGYDQ38++TgRwa3sLRLX8YCwJek8tkb1fLr+pR9sUfDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721475657; c=relaxed/simple;
	bh=bgfaanFUHt1fg5aKtQXT1YN7plxOQcDy48h6Pqa0jEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCDMwYNG+Y9BX9Lng/1Jt+zfi8ZnfpbTgbDmZRgAfnzFEAQylSSehwPLWNyS8QbCNM8CWioLx8Rc23UoN2Sex7u1ZslWbK5RVzbMus1PWhiMFUo/X07lN6IvropTUTwekSZYzXqVw4h/yb6el1RBl6Fnul3QWKqXB9I1wFKo4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu3DYg3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E02C4AF09;
	Sat, 20 Jul 2024 11:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721475657;
	bh=bgfaanFUHt1fg5aKtQXT1YN7plxOQcDy48h6Pqa0jEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cu3DYg3J89FuBmIpUb+8sFpVUUb0V2EvA1QVQDUAdfvTGhjG+PQ8IC1lttdHWrUn8
	 eKp6D095FIZQ3tYUTY0L19ZEAkTaO/U7jfwLPPF2uYnJkkN/naKWrWDNl+T+dLN+PT
	 NBVna/1NY8RBKid494PgAnDrb2drIy1ppiZl+y5D9EiM5T+gzjh7zNglSRNJx9qUwE
	 3sWsoKftDd9aXh6LvpshOLXSfEGIZChD8M8BuAVqqhVKGep5Xvc4cnmVzNFoxRvgAs
	 RmBcrBqSeLwMQDxV318PAzEfTXFDFjbS7paUQ8zNYOv/qIfRIynbzq9cPTb7BLjPi7
	 6O3NELUe32Zrw==
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
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 4/4] selftests/bpf: Drop __start_server in network_helpers
Date: Sat, 20 Jul 2024 19:40:06 +0800
Message-ID: <31399df7cb957b7c233e79963b0aa0dc4278d273.1721475357.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721475357.git.tanggeliang@kylinos.cn>
References: <cover.1721475357.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper start_server_addr() is a wrapper of __start_server(), the
only difference between them is __start_server() accepts a sockaddr type
address parameter, but start_server_addr() accepts a sockaddr_storage one.

This patch drops __start_server(), and updates the callers to invoke
start_server_addr() instead.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 26 +++++++------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 9c98a60cf1e2..a3f0a49fb26f 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -80,12 +80,15 @@ int settimeo(int fd, int timeout_ms)
 
 #define save_errno_close(fd) ({ int __save = errno; close(fd); errno = __save; })
 
-static int __start_server(int type, const struct sockaddr *addr, socklen_t addrlen,
-			  const struct network_helper_opts *opts)
+int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
+		      const struct network_helper_opts *opts)
 {
 	int fd;
 
-	fd = socket(addr->sa_family, type, opts->proto);
+	if (!opts)
+		opts = &default_opts;
+
+	fd = socket(addr->ss_family, type, opts->proto);
 	if (fd < 0) {
 		log_err("Failed to create server socket");
 		return -1;
@@ -100,7 +103,7 @@ static int __start_server(int type, const struct sockaddr *addr, socklen_t addrl
 		goto error_close;
 	}
 
-	if (bind(fd, addr, addrlen) < 0) {
+	if (bind(fd, (struct sockaddr *)addr, addrlen) < 0) {
 		log_err("Failed to bind socket");
 		goto error_close;
 	}
@@ -131,7 +134,7 @@ int start_server_str(int family, int type, const char *addr_str, __u16 port,
 	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
 		return -1;
 
-	return __start_server(type, (struct sockaddr *)&addr, addrlen, opts);
+	return start_server_addr(type, &addr, addrlen, opts);
 }
 
 int start_server(int family, int type, const char *addr_str, __u16 port,
@@ -173,7 +176,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 	if (!fds)
 		return NULL;
 
-	fds[0] = __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
+	fds[0] = start_server_addr(type, &addr, addrlen, &opts);
 	if (fds[0] == -1)
 		goto close_fds;
 	nr_fds = 1;
@@ -182,7 +185,7 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 		goto close_fds;
 
 	for (; nr_fds < nr_listens; nr_fds++) {
-		fds[nr_fds] = __start_server(type, (struct sockaddr *)&addr, addrlen, &opts);
+		fds[nr_fds] = start_server_addr(type, &addr, addrlen, &opts);
 		if (fds[nr_fds] == -1)
 			goto close_fds;
 	}
@@ -194,15 +197,6 @@ int *start_reuseport_server(int family, int type, const char *addr_str,
 	return NULL;
 }
 
-int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t len,
-		      const struct network_helper_opts *opts)
-{
-	if (!opts)
-		opts = &default_opts;
-
-	return __start_server(type, (struct sockaddr *)addr, len, opts);
-}
-
 void free_fds(int *fds, unsigned int nr_close_fds)
 {
 	if (fds) {
-- 
2.43.0


