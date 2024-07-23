Return-Path: <linux-kselftest+bounces-14115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F31893A93D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D74283C30
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA251494C4;
	Tue, 23 Jul 2024 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beyXCFmY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C515D1422AB;
	Tue, 23 Jul 2024 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773412; cv=none; b=lwYpaSC5Wu+WitBD4eDPhIUwMQ0SFJA95hQ/2yHhpNxoxLjom9pjuQ2cG+snHLvcOtxGQwIe3KHnn9iYTkT5ONWwjJVEV6P70HSxYaHzrHDjq6wH5WXvw2mDAFGljw//KOYJ3hZfaVNYftmuW1QajGltr5QyoMGHuxCHmVQWlgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773412; c=relaxed/simple;
	bh=SDq3d/iEx9vI0ULJ3CqdeMcebgGgRTUsqukdR9Cpzt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gkvjj482ayvwGMJJat4P/8be87AM0JAyRSoliDppt6yL3VqxLSpynIKR1TE03kGH0uJQhl3zLwOX4F4kbO4V67B78APqg8C+UUg/C2HHTDdw8BhdJhzF0ZliMoeeeRBE4mA43w9VJ3yGasgkyl6+RXDOnVgZnjYLbyS/JLljWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beyXCFmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36F3C4AF11;
	Tue, 23 Jul 2024 22:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773412;
	bh=SDq3d/iEx9vI0ULJ3CqdeMcebgGgRTUsqukdR9Cpzt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=beyXCFmYzzEJqASQWEOUEMS7X2fzUJfTjHTs865sGKFa3TAegi8BdhGYhQfZkW2c1
	 10osi/NmWRPS0Q1V0nJvHyGax8TKsNMh8EkzOwg5uWxQMW6j3JBKFD7ProQF0b/lm/
	 btpiEX64j+PVa3FgxNYBXW2zp1F9/FzVSQw62DozXZuWO7rbFmeQXunhJUvrndslDL
	 XL2ejo/uWhnnDz4qj+6cBs/lEPyC4jAFybR7Kl+XK7P5YI+RTtFMR4F/k5UPhLEQHU
	 6HMiRFpIbw2GlH+yh0Mi2qUUTyaBdGJQos8Y3WhMAk96Br2QH1F9tX1HWtyyr576ml
	 WYJi4FUbXRY3g==
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
Subject: [PATCH bpf-next 13/15] selftests/bpf: Check listen support for start_server_addr
Date: Wed, 24 Jul 2024 06:22:19 +0800
Message-ID: <b2ab8c367cd621743f74bf7bc7aa81a98fe571e2.1721771340.git.tanggeliang@kylinos.cn>
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

No only SOCK_STREAM type supports listen for connections on a socket,
SOCK_SEQPACKET used in sockmap_listen.c supports it too. This patch
adds a new helper listen_support() to check whether a given "type"
supports listen for connections on a socket or not.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 8b06b0bf66ae..6b6734b893e4 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -82,6 +82,17 @@ int settimeo(int fd, int timeout_ms)
 
 #define save_errno_close(fd) ({ int __save = errno; close(fd); errno = __save; })
 
+static bool listen_support(int type)
+{
+	switch (type) {
+	case SOCK_STREAM:
+	case SOCK_SEQPACKET:
+		return true;
+	default:
+		return false;
+	}
+}
+
 int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
 		      const struct network_helper_opts *opts)
 {
@@ -110,7 +121,7 @@ int start_server_addr(int type, const struct sockaddr_storage *addr, socklen_t a
 		goto error_close;
 	}
 
-	if (!opts->nolisten && type == SOCK_STREAM) {
+	if (!opts->nolisten && listen_support(type)) {
 		if (listen(fd, opts->backlog ? MAX(opts->backlog, 0) : 1) < 0) {
 			log_err("Failed to listed on socket");
 			goto error_close;
-- 
2.43.0


