Return-Path: <linux-kselftest+bounces-12491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A528D913159
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 03:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1110F282F8C
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 01:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267E01FA5;
	Sat, 22 Jun 2024 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMnH+dPg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0051D4C6B;
	Sat, 22 Jun 2024 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719019446; cv=none; b=GT4Pl8j+kCthDZk6BYp+G3CuPcJsH6lGmf71aMopJbAHucZJI1QAFzv6vgplIR4ziKne+SnsclYVwfCbFcUu0uCVm1gjMIRP20BFuQyagSf3EtXgltfo1La1Goirxpw3MB/Brpq8FdtNZAn17Bs6qJyPTHUlh6HbI//1yLneAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719019446; c=relaxed/simple;
	bh=bjmSYjP2RFZmTcSMLnDjwyAItZFAXOlLRE/0dxToen8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvHcbMgwP94UPCAilLz+WyrUziVSeyQXrCtAdg0zGGWwZJTAZ9cGc00uMk6wzuEKQjzwar6lAuPSLDr51bZQNoWEC6lhodMYaSQsuR85vc0OrpomLiS2JclmHwaUY6Y/Ed137fKu0UHSOlJ+cLJEKPp9SE8H+VE0acUPSgV91ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMnH+dPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94E9C4AF0E;
	Sat, 22 Jun 2024 01:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719019445;
	bh=bjmSYjP2RFZmTcSMLnDjwyAItZFAXOlLRE/0dxToen8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMnH+dPgXH3joL+VRQH8cay+r75KJhUjhWW7RlKCkqBeceLpyGvmle9dC3wabYKjW
	 dzeZQ9OOxBtnxCz8KlTJiC8j3Ee2z0TQTb/kjXb4XrKTMbGOAf6t43mV5OUaMvCt8Z
	 CbBQCKBIWzrUaTsNEyHRhf7xehPrpJ+8lagutHRZgKfb+qstxQQNc/LV013wYoBbf2
	 wwV6WJ2vrnCeNqEAlEkVnMLd3c4M1KCAEbNYNguGmBUQhB+/SJZ8CmvuUFbTvLc6Xn
	 WltndDaB6Gnq2xRHvtD+G6Z1QXSidDOZnbzJukwzIIjbzOCvAwrWm4JDpHUz0exau/
	 7cIwPltQQsuuQ==
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
Subject: [PATCH bpf-next v2 1/7] selftests/bpf: Use start_server in sockmap_ktls
Date: Sat, 22 Jun 2024 09:23:41 +0800
Message-ID: <f8e3898f9037b2c791f9e4622006baa7255f7cf6.1719019125.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719019125.git.tanggeliang@kylinos.cn>
References: <cover.1719019125.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Include network_helpers.h in prog_tests/sockmap_ktls.c, use public network
helper start_server() instead of the local defined function tcp_server().
This can avoid duplicate code.

Technically, this is not a one-for-one replacement, as start_server() also
does bind() and it's listen backlog is 1, not SOMAXCONN. But the difference
does not seem to matter.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c    | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 2d0796314862..9cc881b38669 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -6,25 +6,11 @@
 
 #include <netinet/tcp.h>
 #include "test_progs.h"
+#include "network_helpers.h"
 
 #define MAX_TEST_NAME 80
 #define TCP_ULP 31
 
-static int tcp_server(int family)
-{
-	int err, s;
-
-	s = socket(family, SOCK_STREAM, 0);
-	if (!ASSERT_GE(s, 0, "socket"))
-		return -1;
-
-	err = listen(s, SOMAXCONN);
-	if (!ASSERT_OK(err, "listen"))
-		return -1;
-
-	return s;
-}
-
 static int disconnect(int fd)
 {
 	struct sockaddr unspec = { AF_UNSPEC };
@@ -39,7 +25,7 @@ static void test_sockmap_ktls_disconnect_after_delete(int family, int map)
 	socklen_t len = sizeof(addr);
 	int err, cli, srv, zero = 0;
 
-	srv = tcp_server(family);
+	srv = start_server(family, SOCK_STREAM, NULL, 0, 0);
 	if (srv == -1)
 		return;
 
-- 
2.43.0


