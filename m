Return-Path: <linux-kselftest+bounces-8116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5408A6803
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315A51F21EF5
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0601272AE;
	Tue, 16 Apr 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnTISD7n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553241272A0;
	Tue, 16 Apr 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262504; cv=none; b=VnjwBq+E4h1aBkalDKZ+IS44lqKGKg21zzzWq41pUFzK8H+/2OQZuPNWQ/lo683tvphltJLDaStxB9xxOq344GFp4iI2qmuHR4dolJ4ezXqhp0ismEvkMIvzIAMOJicfgSJzypmc9BEHZnXs62tZ0PrI5enIaMnVIfmncg+qXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262504; c=relaxed/simple;
	bh=qiNOeJlMK4Gap3egVspgufbRH3oE7PklngmbBiyzAxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l0BcfgFzH+uYW7wEiGgeaLeuUXNu46qUmzKbC+jZQb1PColJJDY/Rlv1SDEvbJuYpbN3FFZTaqHik/lxRChpuqDj6l8UgCOYBNt5H/I4xPjqRu5xI9vxYcmCDGi5EkZv2ta5hffliRdXsJBhCHg8xCXpmZDJ/Ei32DAgs0fM9S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnTISD7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BCDC3277B;
	Tue, 16 Apr 2024 10:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262503;
	bh=qiNOeJlMK4Gap3egVspgufbRH3oE7PklngmbBiyzAxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FnTISD7nSh7WsnjQ1YwBr2q68+HuBdn16DOwi9ME4sob4yA70dosIqVspBfXV3mGq
	 hfKHKR1+cK1pH+NzkKGcQqRy6DS+/JdQcrJDnzI2+yqI4wnDXAFHwIpXX+BINMz6uL
	 EUPysY0XoPeh9Lgjo4m55JNA0ocaLx7ve5aXk49yxTSWy141UIbiHy2yqINTnVoNzj
	 8A+xCIWJPc1qg6BlGmzE9RIyvdOSMTxiC7CLWURrQSUGVFZzRsuX2fp6wfqO3gQheM
	 Z1/crCl4269AL0rcp0H0TVEnQAj561P2+oIY2msrwxu7noEs445CopxQlPGC7RJ/Ir
	 c3N+qIRWTK2uQ==
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
Subject: [PATCH bpf-next v4 08/14] selftests/bpf: Use make_sockaddr in sk_assign
Date: Tue, 16 Apr 2024 18:13:54 +0800
Message-Id: <fadcfa896d680847943b56984434b720b720c439.1713262052.git.tanggeliang@kylinos.cn>
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
instead of open-coding it prepare_addr() in prog_tests/sk_assign.c. This
can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/sk_assign.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index c0ef210f7622..67daa2268cdc 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -148,24 +148,19 @@ prepare_addr(struct sockaddr *addr, int family, __u16 port, bool rewrite_addr)
 {
 	struct sockaddr_in *addr4;
 	struct sockaddr_in6 *addr6;
+	socklen_t len;
+
+	make_sockaddr(family, family == AF_INET ? "127.0.0.1" : "::1",
+		      port, (struct sockaddr_storage *)addr, &len);
 
 	switch (family) {
 	case AF_INET:
 		addr4 = (struct sockaddr_in *)addr;
-		memset(addr4, 0, sizeof(*addr4));
-		addr4->sin_family = family;
-		addr4->sin_port = htons(port);
 		if (rewrite_addr)
 			addr4->sin_addr.s_addr = htonl(TEST_DADDR);
-		else
-			addr4->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
 		break;
 	case AF_INET6:
 		addr6 = (struct sockaddr_in6 *)addr;
-		memset(addr6, 0, sizeof(*addr6));
-		addr6->sin6_family = family;
-		addr6->sin6_port = htons(port);
-		addr6->sin6_addr = in6addr_loopback;
 		if (rewrite_addr)
 			addr6->sin6_addr.s6_addr32[3] = htonl(TEST_DADDR);
 		break;
-- 
2.40.1


