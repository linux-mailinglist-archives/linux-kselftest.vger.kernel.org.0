Return-Path: <linux-kselftest+bounces-7536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8EC89EBFD
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9302830B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903DA13D287;
	Wed, 10 Apr 2024 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7D2vscr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661B013D27C;
	Wed, 10 Apr 2024 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734224; cv=none; b=ETgfNi12QFp5ZMVvgL6Ih3QrAVefgSibWt8l5SEMhRa0Dcj32qpRHTA++ZcyQmgwFIurAn7d8DDvjDhUY4h2M674mOATrCVOIa887flx25U/QKgYkM98UyHtqNjP9tGqpLcFBWRnp/Cm85NTOu/igfAH35MDhGk99nd4Re5fHOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734224; c=relaxed/simple;
	bh=vLrjMmKetyO8Sy9BYX3xzhrWl5qjTGc6cDgENe6iOaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IPQYJTGpK9h5Mmkgghq5IZnNhnqIiX8BjpxC/jL0X8i7jmU8FB1r8fJ9sVamSs/XDIaAaSqGThsPk48rw4ltF9T34AgQRzDnZ32Vdaw0GqUEuezIv5Ei8IZ5sfgxL3i4f3494Q4Y1svNsHztLj8Feo7u4nbgJirG+4onoeUBgsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7D2vscr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E637FC433F1;
	Wed, 10 Apr 2024 07:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734224;
	bh=vLrjMmKetyO8Sy9BYX3xzhrWl5qjTGc6cDgENe6iOaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7D2vscr04nAqGNFsCz5OSHMjlH148YNIzPrwBXQB3zsGbPy8ayCzm+ZGXaP5QK9P
	 O+pYCxXnqTFipNUEPq7JxBeR3M0hXRajsMtk79R6RN42FKvhy3bxAzaDHxtvdw0Iah
	 9JMQWLmJZfPMX0W9vbe1df/9+Z9n6Hr3mJKO2MqfEBX2zZ/MGlKuVoAyWqVkZbL+SU
	 q0oQutgs01gZPiVh8jC9ubn0aDlfBow92rdl5fnpa1K+3yxSNcS0ctd2btyANnbXuU
	 XIzNXaCnIt4vFBmAMItmFou5sgqbeXNanjp9T9H63ntjqXCsdtj5RxVQQOral7bFNK
	 RQGDtawXLadLw==
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
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 04/14] selftests/bpf: Use start_server_addr in sk_assign
Date: Wed, 10 Apr 2024 15:29:37 +0800
Message-Id: <4a7eeff9a79df18d4723ec4477f7ee5fc2409e58.1712733999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712733999.git.tanggeliang@kylinos.cn>
References: <cover.1712733999.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Include network_helpers.h in prog_tests/sk_assign.c, use the newly
added public helper start_server_addr() instead of the local defined
function start_server(). This can avoid duplicate code.

The code set SO_RCVTIMEO timeout as timeo_sec (3s) can be dropped,
since start_server_addr() sets default timeout as 3s.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_assign.c      | 27 ++-----------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 1374b626a985..130aafe8cff6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 
 #include "test_progs.h"
+#include "network_helpers.h"
 
 #define BIND_PORT 1234
 #define CONNECT_PORT 4321
@@ -73,30 +74,6 @@ configure_stack(void)
 	return true;
 }
 
-static int
-start_server(const struct sockaddr *addr, socklen_t len, int type)
-{
-	int fd;
-
-	fd = socket(addr->sa_family, type, 0);
-	if (CHECK_FAIL(fd == -1))
-		goto out;
-	if (CHECK_FAIL(setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo_sec,
-				  timeo_optlen)))
-		goto close_out;
-	if (CHECK_FAIL(bind(fd, addr, len) == -1))
-		goto close_out;
-	if (type == SOCK_STREAM && CHECK_FAIL(listen(fd, 128) == -1))
-		goto close_out;
-
-	goto out;
-close_out:
-	close(fd);
-	fd = -1;
-out:
-	return fd;
-}
-
 static int
 connect_to_server(const struct sockaddr *addr, socklen_t len, int type)
 {
@@ -310,7 +287,7 @@ void test_sk_assign(void)
 			continue;
 		prepare_addr(test->addr, test->family, BIND_PORT, false);
 		addr = (const struct sockaddr *)test->addr;
-		server = start_server(addr, test->len, test->type);
+		server = start_server_addr(addr, test->len, test->type);
 		if (server == -1)
 			goto close;
 
-- 
2.40.1


