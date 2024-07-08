Return-Path: <linux-kselftest+bounces-13294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE70929ACB
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 04:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2975828123C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 02:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6B42FB6;
	Mon,  8 Jul 2024 02:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7O9D65f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352051FA3;
	Mon,  8 Jul 2024 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405819; cv=none; b=lVUqwm4OXGGjY8nBKQPCMpv5WHYMyNMoQXwBuGP/01vmbxV0gUzFJ7z0EXFB1Zo4JzqKvO5o/MXbz4I4HPTWX8HAW/YDIY0Qr6mbc3ltGzep5YDHAJi+/XC++pdudg5/SDptXUPh4zWnfxSX1VrHYFq1LQ/ItpUWo5MbBetO4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405819; c=relaxed/simple;
	bh=00pdNC+8+bJCChvMSP7B2ks/Ry/OoNnOXIemGC5RruM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfNnO/zBDkPmZty/I7NG45VKDXJebcKWeWNoGGixCZ5vwZKMVvKBwlKuySpaynMZgQWCNizYo6ZQW8MwMfB/DFxd7Pn7bMEkQsAx+BCe0c/Ew7CXLDksJL2uaBxgszo0CaGaSIxfuVh/M7/ebjfSWMTeGwHSCG85fKDbKxuNSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7O9D65f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9643DC4AF14;
	Mon,  8 Jul 2024 02:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720405818;
	bh=00pdNC+8+bJCChvMSP7B2ks/Ry/OoNnOXIemGC5RruM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7O9D65f6HmnYQhWcurwSJSsWMHQW56LEVQakloS0vjHZDJmnaBYmm0oBLxGB0mYt
	 kBGcq8PM/TAtNWZKGRtDkEPsg/J6AXSm85OAEOQ/G6SWdh0qkFaQcwB1+Ka0nKX6o5
	 mwOaqh7FUor6RnOa18sFSWzgQv1hf5PL/MvUc6CuqJXXOtNHlNYF1Rtj3bAO2hLFeg
	 HuK2TcH06817YBFoO8E+X2BpmO2Q98u4W+l4uG6CnI8GKbWuPRh8ynQP+rn9sEH57x
	 4Tp8Wb6FD9WPOiJErqjf35Rs+ToCRA6kWRRQdhtDigDLGCLe8Jmssh/ad9wdI8j+9O
	 wYClT+kMQGRoQ==
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
Subject: [PATCH bpf-next v10 02/12] selftests/bpf: Use start_server_str in sockmap_ktls
Date: Mon,  8 Jul 2024 10:29:40 +0800
Message-ID: <52e84e1325b977c971d1745f8056a1cf9b5add17.1720405046.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720405046.git.tanggeliang@kylinos.cn>
References: <cover.1720405046.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Include network_helpers.h in prog_tests/sockmap_ktls.c, use public network
helper start_server_str() instead of local defined function tcp_server().
This can avoid duplicate code.

Technically, this is not a one-for-one replacement, as start_server_str()
also does bind(). But the difference does not seem to matter.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 23 +++++--------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 2d0796314862..32be112967a5 100644
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
@@ -35,12 +21,15 @@ static int disconnect(int fd)
 /* Disconnect (unhash) a kTLS socket after removing it from sockmap. */
 static void test_sockmap_ktls_disconnect_after_delete(int family, int map)
 {
+	struct network_helper_opts opts = {
+		.backlog = SOMAXCONN,
+	};
 	struct sockaddr_storage addr = {0};
 	socklen_t len = sizeof(addr);
 	int err, cli, srv, zero = 0;
 
-	srv = tcp_server(family);
-	if (srv == -1)
+	srv = start_server_str(family, SOCK_STREAM, NULL, 0, &opts);
+	if (!ASSERT_GE(srv, 0, "start_server_str"))
 		return;
 
 	err = getsockname(srv, (struct sockaddr *)&addr, &len);
-- 
2.43.0


