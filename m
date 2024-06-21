Return-Path: <linux-kselftest+bounces-12439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE5D912286
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 12:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFE328CB80
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35332171E5D;
	Fri, 21 Jun 2024 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLv1s1hI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C214171662;
	Fri, 21 Jun 2024 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966149; cv=none; b=HWmDL6mowZE7LkJsE0R9Tu5KsMT3Tcgsv9golUkoj1dGoNzUCDAacSOj4KRp73+7qHBbEJz827bjJPJ9YpGTNX4Rp5BeLs093mn9pVCgRYADm0N/a7NoYAtxsOSD1vyTVUlXYFxssM/56WIywBtLD3kgngh6APvPIweOuhQN4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966149; c=relaxed/simple;
	bh=SKyyCdL528nLERGcSxTQAVRM3f1L6kcDJj8MadPAgFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwGzxvfgaQaZzRh/rOAaoO6eUlbkymRmZm2xRmbNBJ3qiyvNhc3mFt39FcioMcM9XtkwxrFjLfEuJJLBNSB23/40VLsUQUiMYTj8wikIi9hW2UcWyUjtTliA4xv/r5vI7f699FWxxw7j3xMG0oxudwT9SGEvdNKvqYhzB+IxSqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLv1s1hI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115A4C2BBFC;
	Fri, 21 Jun 2024 10:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718966148;
	bh=SKyyCdL528nLERGcSxTQAVRM3f1L6kcDJj8MadPAgFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SLv1s1hIHomfbvFsRi1MCeQnZPIkmMag7BGXhS6rlkN4dFVOm4jGjLmtmM1rEOy/2
	 G/8v6JI9jQ+zLhc5QAWac+5BEDl9xgwwubv9jOhSOMUFBoccoGLn14YU+7NxLEK6sN
	 +mc8o1I+MQPqGBQlqVOz3iEWRgpboT2IA4SZHeQYcgfmarlljtr1q097a4oUDZDxYW
	 KQuNwszGuSipHSvnY/pGQ+fzyO6rGv0M2qS8ar8RIaGs2abnVEDlPTjXXF7cZCRKSG
	 rYWJaMHMLSCiZMJSxYiwWhiHYuRUpRZVwneR7dad7qnlHxwgJmE7AYYjanN5DuKG5y
	 55+Ll0MlhfEAQ==
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
Subject: [PATCH bpf-next 1/6] selftests/bpf: Use start_server in sockmap_ktls
Date: Fri, 21 Jun 2024 18:35:24 +0800
Message-ID: <37b9e2f3c61b4bb73326f6c4e63d562433b59255.1718965270.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718965270.git.tanggeliang@kylinos.cn>
References: <cover.1718965270.git.tanggeliang@kylinos.cn>
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


