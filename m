Return-Path: <linux-kselftest+bounces-12610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7014915E44
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 07:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635B1283692
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 05:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AE4145B03;
	Tue, 25 Jun 2024 05:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FppMrEEl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB3D145A1E;
	Tue, 25 Jun 2024 05:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719294179; cv=none; b=O00Nak7O6iMlYPjDL1KfZhgtwW+dveup1d7zZKJ04SQLOiKZrJCrh3iZbWjnDWOnVdOtuHYNbU2cw6BRh2I7naUSr9r+6WhUYQw6evE5eid3KMGGcHLv5poBm0bLUoxLt5Xl2M1w/5/1LNwfmpsbqJn2vLa5hx2LFqBHppGjiqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719294179; c=relaxed/simple;
	bh=RPUpwnHqWv9OF1LgymXpVyycZoyJsq5oTKQuRymN69I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poPW86ZxWiHXQ17DxAN+YasvJkTF/n/abh6FfeiViH8ufZ7UM6LYGwkWp+sZOi0qBt+dFJB/nH6j66KyGHwkuK1nvFcU/dcjCHVb515Wlr7fozagBYujjCyMA5howrQhehPKhHJqQnfmp7OOy2d/qKeFF+wEbVbAi6GUgrxDRfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FppMrEEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA30FC4AF0A;
	Tue, 25 Jun 2024 05:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719294179;
	bh=RPUpwnHqWv9OF1LgymXpVyycZoyJsq5oTKQuRymN69I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FppMrEElFJXBqWoo3/g9otLOKFdXIhSrrs3U+24R//5mO3iTR26+zOYUZsDF6GcPt
	 iA/71p4oV4hesImPZwAExOREf27VPX8CN9J4HA3ejZpj+tQEPbQf/Qtmt5l7NWBj5l
	 KLSWs69ErWW9iVQ9U80N0BNMY4rK1BnjI+bFOv5mFEcpAST4ajfI1UosjiEFnrV72T
	 dwxN+UeojrDpq0a73XiYFhAgdcJkU9DGZ9NWM5G1S6m9948MO0XUAkbK1hmbjT7bzF
	 1hcDyNOeKyWDZfJm2FDdgdJ94c7r1gUKnDq47zIpxQ6aHRDU5xlCTCLGegKqVEOrqr
	 9v/63BuM+mQ+Q==
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
Subject: [PATCH bpf-next v5 2/9] selftests/bpf: Use start_server_str in sockmap_ktls
Date: Tue, 25 Jun 2024 13:42:29 +0800
Message-ID: <fb543ca7d765c8ac52c5c64b860292e14852676c.1719293738.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719293738.git.tanggeliang@kylinos.cn>
References: <cover.1719293738.git.tanggeliang@kylinos.cn>
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


