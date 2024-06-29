Return-Path: <linux-kselftest+bounces-12957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB0A91C9F9
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 03:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A849B2160A
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 01:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B372139C7;
	Sat, 29 Jun 2024 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKBfP3PP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA6A29;
	Sat, 29 Jun 2024 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719624046; cv=none; b=di4/aaDMl5dgI1C2HJ2VnnpBiLBqgV5Y26x78d537I03Hxkr8WaZmJVgdBgjjqisZMKIiYq8NeIQBY5YLgfcXTEdBCwyH7W3te89PjqjnEl/sQQcx6NFjcMKOxvs1rhBAi1WZwroXYUP1FOFRpKNlaVAtUPfeeznnHvWEisyndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719624046; c=relaxed/simple;
	bh=RPUpwnHqWv9OF1LgymXpVyycZoyJsq5oTKQuRymN69I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpFVG0ZYOJPI5xOcZXEUddiRCop8z+/h0Z/0oIsNMxPV8he9CZ7fNm3Q7OAjknj8HUyTY+givj7eAbbIQ2Idg6kyNyLT0oQ5p++QbY8r4tZvGFA51girCEy7xMmE7U27HaR22fKZsWrY3C9neVFOlBezkHSUfMYAWMciGpTPvb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKBfP3PP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C74C116B1;
	Sat, 29 Jun 2024 01:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719624046;
	bh=RPUpwnHqWv9OF1LgymXpVyycZoyJsq5oTKQuRymN69I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aKBfP3PPEyg/9f88SjeK0/qUg22/9JaMJE6rPbFi1LcXkglyV3N6KlWvgh4cj9hm6
	 hXEcnz2QIcl+4+OFFCF5h/BzsO+vbXyTjfLRfyq3q8SBLbTYSLQB+QMxJMhMVPN3Zi
	 J1imli6i1VXsL7LJQQ5vVNwmKAuU/DGySoMAb6XRayCA9bWqUE0BEyZ220/F5/Je9S
	 a3gCt3NVWftUbqWcoYEvqjznh8MYfmVYWaFqsqxQ39mngh38BRfBVdZnUomJaPiyxR
	 NubMZsk5hbbsXhN5ExEZA/aKE+MzdiVE5NRfrEfuPvHMan5Gkld6GTgjWfEK067wE+
	 5ZBP/QaL1HmtQ==
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
Subject: [PATCH bpf-next v6 2/9] selftests/bpf: Use start_server_str in sockmap_ktls
Date: Sat, 29 Jun 2024 09:20:12 +0800
Message-ID: <549f4b0a22ee953a57ebd3d96a5a6619e881b110.1719623708.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719623708.git.tanggeliang@kylinos.cn>
References: <cover.1719623708.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 21 +++++--------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 2d0796314862..4dc7933bb556 100644
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
@@ -35,11 +21,14 @@ static int disconnect(int fd)
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
+	srv = start_server_str(family, SOCK_STREAM, NULL, 0, &opts);
 	if (srv == -1)
 		return;
 
-- 
2.43.0


