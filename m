Return-Path: <linux-kselftest+bounces-8298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4708A94A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 10:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1311F2168B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 08:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46967D07C;
	Thu, 18 Apr 2024 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWFwJ+Yl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2897CF2B;
	Thu, 18 Apr 2024 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427782; cv=none; b=eJYsiFiGR9uPC/bUgs7U1heRfvUJSYj/ybtWHGkyMO8afFtIEbHtPNeF6i9nTYPEvlDW1VKC7FTPndd2ZrlK32rF9coVjyCXYLt5BbtB4HlyGeFyYgSFwzG4JOsyf939xdg7br7RkiUEFU7ur6nzDxspNupr4YuHBuEebGnmUNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427782; c=relaxed/simple;
	bh=hXTzw17BtXmyG2zQDfFTBmZNcXLVJ7pnXsvviybn1Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YCEQz3omotTbEI2tF1r+4hH/Q6u/KNQRUmSR6tu9fTZQuW7NYwhq9bWy1NTzXZ1bHj3D291K4JkKwp59lzq1ZOVwdIafhLDJWHqrQ1in95gpWjIhYviXXgQ404Ww/toB3SJw3gLIkCKF30OOUVlgzvWn0NW0j4yVMF36nJahPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWFwJ+Yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0897CC32783;
	Thu, 18 Apr 2024 08:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713427781;
	bh=hXTzw17BtXmyG2zQDfFTBmZNcXLVJ7pnXsvviybn1Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWFwJ+Ylb3U8aeYHEM6OgDVqsPYyWST8SU+mZdQiTeh7euD4EtATzjKU5+iWCBt7I
	 Q09y7KuBs8CoD+xe9wGXgLCFUMjSrybqX3jtlzTZ1UVCa8Wl7mfU5jHbopRbwPBno1
	 z/CNYwfKXjTXNu4QYrycZk1aDQt5+qZ0bUjrFzEYVRw1y9cBpQOOe/Ui+tQ+u9BzWi
	 evSGabwgoLBjSK15lmzkNBK9AfdromNUs+XzNh1iuaa71Dg/k+MASuoFiLlwMovm7B
	 2ztL2TdNvkIR0X4VCpUud5hdMmNUm2WAw2duFFxN3tqrz5iGSrme3uYMV7mDyaGQbR
	 HcUycAT7DcwLA==
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
Subject: [PATCH bpf-next v5 3/6] selftests/bpf: Use start_server_addr in sk_assign
Date: Thu, 18 Apr 2024 16:09:09 +0800
Message-Id: <2af706ffbad63b4f7eaf93a426ed1076eadf1a05.1713427236.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713427236.git.tanggeliang@kylinos.cn>
References: <cover.1713427236.git.tanggeliang@kylinos.cn>
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

The code that sets SO_RCVTIMEO timeout as timeo_sec (3s) can be dropped,
since start_server_addr() sets default timeout as 3s.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_assign.c      | 29 +++----------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 1374b626a985..b066b6b88d7c 100644
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
@@ -310,7 +287,9 @@ void test_sk_assign(void)
 			continue;
 		prepare_addr(test->addr, test->family, BIND_PORT, false);
 		addr = (const struct sockaddr *)test->addr;
-		server = start_server(addr, test->len, test->type);
+		server = start_server_addr(test->type,
+					   (const struct sockaddr_storage *)addr,
+					   test->len, NULL);
 		if (server == -1)
 			goto close;
 
-- 
2.40.1


