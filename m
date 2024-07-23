Return-Path: <linux-kselftest+bounces-14116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E31893A940
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F000B230C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555C8148848;
	Tue, 23 Jul 2024 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8SJcWOc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA2314882E;
	Tue, 23 Jul 2024 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773417; cv=none; b=PkrIdVBQaJriToeBhY5IwEsziLw561g0Ukxtjfylom/PKgnX8p8k+9NJrW4WCUcVIj7X/k0MeqEkYB7PuWn1ZKLGIIeotDXIXvH47SpwVF/fFWdA4yTsrLVcfHdga1Ef/IsmiLjfVXz3a63bgM8F9hmi8XZzDF/z0DnO7bbtBbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773417; c=relaxed/simple;
	bh=2LU2vjg3f906UWyhDzXWAXiRIxOItrklwjsTG1UwTzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tj6e+difzErR9AGCYdaswD5E+x3ikGi/JgwITSl/QlXHJb+VOw+sUbKnsdRF2at7NoXQ+IKsRIVfxQTF+56s2yPHZlDARaFEfQ56qKiiVaPRRYkU/AcFcFTd1VPAAhSNRPwG94pmTisLkfYGKTNe/nX8p9sHqfD5lvZ9m/RVYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8SJcWOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE91C4AF0A;
	Tue, 23 Jul 2024 22:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773416;
	bh=2LU2vjg3f906UWyhDzXWAXiRIxOItrklwjsTG1UwTzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8SJcWOcfw58BTkjnpuO9e88EIkrHRbhQYDvakVuO9wjJUpl05HoggBxvEo/AHBMD
	 Lg/PYxevuKR8H79Ec3+G3UFaPxfb+FSyjUczU4ZKorr9kITUU7JPwph3cxPttMR5jk
	 wHZSFhlZL5VTq/wp4bAqBOzV1C1X/1QlD0s5QgjeK8qY6I3/eTbYBnDTERCjJpwqkG
	 nz7wKRbrgdkdJbUzseBGLgmkmgzd8jFjhz6rqqNGC/8s66gADq7Vpvv8uG3tKNLwzj
	 yHAiPQIsr/NCjE1aLdxe1eh6PhzUYlQLD9AaCsnb/cnBmTgITjJESJ+AeSIsWHNQQM
	 LDPz4Qr/7KYmA==
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
Subject: [PATCH bpf-next 14/15] selftests/bpf: Clear type bits for start_server_addr
Date: Wed, 24 Jul 2024 06:22:20 +0800
Message-ID: <2bdf858ce89445fa66ef15b0159425649cfe1ffa.1721771340.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721771340.git.tanggeliang@kylinos.cn>
References: <cover.1721771340.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The types "sotype | SOCK_NONBLOCK" are passed to socket_loopback_reuseport
by some tests in sockmap_listen.c, so they must be handled in helper
start_server_addr() too.

This patch uses SOCK_TYPE_MASK to clear useless bits of "type" before check
whether it supports listen for connections.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 6b6734b893e4..919b691c2699 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -28,6 +28,9 @@
 #define IPPROTO_MPTCP 262
 #endif
 
+#define SOCK_MAX (SOCK_PACKET + 1)
+#define SOCK_TYPE_MASK 0xf
+
 #define clean_errno() (errno == 0 ? "None" : strerror(errno))
 #define log_err(MSG, ...) ({						\
 			int __save = errno;				\
@@ -121,6 +124,9 @@ int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t a
 		goto error_close;
 	}
 
+	if (type > SOCK_MAX)
+		type &= SOCK_TYPE_MASK;
+
 	if (!opts->nolisten && listen_support(type)) {
 		if (listen(fd, opts->backlog ? MAX(opts->backlog, 0) : 1) < 0) {
 			log_err("Failed to listed on socket");
-- 
2.43.0


