Return-Path: <linux-kselftest+bounces-12387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5096C91185B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 04:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810F71C21C54
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 02:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2B780603;
	Fri, 21 Jun 2024 02:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWFuBcqu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F7424B4A;
	Fri, 21 Jun 2024 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936190; cv=none; b=px1oXCuESmoSV9+gm5ARkqpzSTDecVW9QfJOEXeeMGY4K8jn4mJPavRf0p40WUHutqyCuBIkONVwzdIcqS9fuMegjJNVlwG4TZVLWZ4WXsdTcBbSd98UmlrFFIwV90EXNG4C4xcRQ643089J9jWsTyZEHPAfRI401BtnGKL2j+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936190; c=relaxed/simple;
	bh=YTtXja2HaGO0PTDhbVk0RAMTT/nK/v2/Ym26txOP3Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OldU65Pw1ejTETlpKc7B/SbFTkvfIRf4jrrLVh1jwy8rY+29J4LnSXLAbsCz588I+71WdtnaL/s9RzgNOSrCt/K3YyOQW41cQirRyzsmlOeqbihXmwINF0ZtbWq4eBbhQQvqGb1v9DtLWc9VNtmO0hPt+wQ89pQ6S94HFeqWpg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWFuBcqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15656C4AF0C;
	Fri, 21 Jun 2024 02:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718936189;
	bh=YTtXja2HaGO0PTDhbVk0RAMTT/nK/v2/Ym26txOP3Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWFuBcquP8Yq7g7SlLIfbO6xQil4TtkooLs5Y6IEysGF+X8+hk6xYqXQ4tzPDfG5Z
	 JTkGJxxdC0H/IgxZfqAQtVbAKgbO+wT9ukEQi/9MJhwPaj2zelpDNIh6KJQWKrSzWf
	 REmiWl+iUNll1c3/qeCWTFrF/hrbi340V53FqpVhdyrDHDy+F2v4LuvwoOla1VLwE6
	 SqMdd8jO7DjzggBtlDsh55sYnBflKy0m54ewmmb/6vCfY6YlNs4Mldyy6UkZ16exjw
	 FbCyR+M+W2q7rsQ24wUsb7PEeHCAvJwTxT+rgGXr1KNGPuftSxhypgy+AXD5QST1E5
	 JQLdvNMv6T+tw==
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
Subject: [PATCH bpf-next v6 2/6] selftests/bpf: Use connect_to_addr in connect_to_fd_opt
Date: Fri, 21 Jun 2024 10:15:59 +0800
Message-ID: <4569c30533e14c22fae6c05070aad809720551c1.1718932493.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718932493.git.tanggeliang@kylinos.cn>
References: <cover.1718932493.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch moves "post_socket_cb" and "noconnect" into connect_to_addr(),
then connect_to_fd_opts() can be implemented by getsockname() and
connect_to_addr(). This change makes connect_to_* interfaces more unified.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 33 ++++---------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index c0646d5a4283..5d1b4f165def 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -293,9 +293,14 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 	if (settimeo(fd, opts->timeout_ms))
 		goto error_close;
 
-	if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail))
+	if (opts->post_socket_cb &&
+	    opts->post_socket_cb(fd, opts->cb_opts))
 		goto error_close;
 
+	if (!opts->noconnect)
+		if (connect_fd_to_addr(fd, addr, addrlen, opts->must_fail))
+			goto error_close;
+
 	return fd;
 
 error_close:
@@ -306,9 +311,7 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
 int connect_to_fd_opts(int server_fd, int type, const struct network_helper_opts *opts)
 {
 	struct sockaddr_storage addr;
-	struct sockaddr_in *addr_in;
 	socklen_t addrlen;
-	int fd;
 
 	if (!opts)
 		opts = &default_opts;
@@ -319,29 +322,7 @@ int connect_to_fd_opts(int server_fd, int type, const struct network_helper_opts
 		return -1;
 	}
 
-	addr_in = (struct sockaddr_in *)&addr;
-	fd = socket(addr_in->sin_family, type, opts->proto);
-	if (fd < 0) {
-		log_err("Failed to create client socket");
-		return -1;
-	}
-
-	if (settimeo(fd, opts->timeout_ms))
-		goto error_close;
-
-	if (opts->post_socket_cb &&
-	    opts->post_socket_cb(fd, opts->cb_opts))
-		goto error_close;
-
-	if (!opts->noconnect)
-		if (connect_fd_to_addr(fd, &addr, addrlen, opts->must_fail))
-			goto error_close;
-
-	return fd;
-
-error_close:
-	save_errno_close(fd);
-	return -1;
+	return connect_to_addr(type, &addr, addrlen, opts);
 }
 
 int connect_to_fd(int server_fd, int timeout_ms)
-- 
2.43.0


