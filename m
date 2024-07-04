Return-Path: <linux-kselftest+bounces-13189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A99792728F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 11:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212D61F21CFE
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B148E19DF88;
	Thu,  4 Jul 2024 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4Nm5DLt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8904E335BA;
	Thu,  4 Jul 2024 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083617; cv=none; b=Ff2caMJ1pt7TZGThHhmPiA7oCfJBdxyq9ei7xuGO1DsKYI858NdnhRznP5VKcY1w5XvWPkceG7ZqfsnsUr2g0eeFl5gb5iR2C21d4iBy+FIBTqR/d6cI7h7PglMsXNmpWzdOLmsKuBmw+8DX590nA7DkxDuVfcb1c68hiByVYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083617; c=relaxed/simple;
	bh=00pdNC+8+bJCChvMSP7B2ks/Ry/OoNnOXIemGC5RruM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iiaeim5pvvbA5Q+i66Lb6J2n9zMVk9JPtsZPxKYXL+MZ7cFdIKNdPwPWShhXWM2WvE7Hz4zXSbjyECgKMBIEauHxKCQ9ngzXTx9ruvNnTKyOLdDCF047PJNiQIJ2GKCbQJQhxFIMOQDDdaNXfTVLKEUw5JoCOhI/mhRgrxhy14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4Nm5DLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13BEC3277B;
	Thu,  4 Jul 2024 09:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720083617;
	bh=00pdNC+8+bJCChvMSP7B2ks/Ry/OoNnOXIemGC5RruM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u4Nm5DLttdH1YeASKuxwHAI6ZxGORrPvdWgtkkS+FTYTUgTPLsh9Ds5EauNcgk/Si
	 3NpUhLOzbqztqigy26J6Apen66VLG5gCejAwPO9UP2WM7lSjCXbh9584jH8Yy32Gco
	 ZmZrix0xtnTLm8ipXPZjCzkV4vjPHr/U8mZUftfLvMA61frltn0lGSFbNK43cx0At2
	 yFHY1b0D8LG4cfHbE63m7QvKGMrRQa0eo/vtCbU83UTJzCg350g11Qage1i1uRhqom
	 0a69CK66Oakfk+hiFu3yQS1UHeKE2m5EBk3WVImX1ls1RhBwjlhfVfALMZsgJJE6H4
	 QwC+jiOLwf1zQ==
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
Subject: [PATCH bpf-next v7 2/9] selftests/bpf: Use start_server_str in sockmap_ktls
Date: Thu,  4 Jul 2024 16:59:39 +0800
Message-ID: <c856b5ef2286386ddb16748b0ce6ef746a08817b.1720083019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720083019.git.tanggeliang@kylinos.cn>
References: <cover.1720083019.git.tanggeliang@kylinos.cn>
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


