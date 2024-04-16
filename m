Return-Path: <linux-kselftest+bounces-8113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EF48A67FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52DA61F21BB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06311272DF;
	Tue, 16 Apr 2024 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+t1n6it"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F1B1272BA;
	Tue, 16 Apr 2024 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262485; cv=none; b=fBmsNZ9h5e90hMQU2s6H8ZTEK7QdJ0lykZLFlWo5ab7d0Etukp3dUZBxsC1w2k1WnPW1fFPSyD49sFdzHdvE7D/54xobPnb7c1ci8udfmVOT/IfrL218tyB67MifzeYUbtVkE9kZZ7LNikv0CPUjXPU2yUqczdaFGiQ53us1qUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262485; c=relaxed/simple;
	bh=gPaD6ZJyxD4PgHJQ62WTuuIeGVpHrnbCX8NFKI8kpRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Narf07AtXTwjfy+gua3FvSsqe1au8bedvvlWS71Kr1FF1qaAB5xwMo26Kr/NT1vS2Ia4AWrthel6vvuE+rFikld3qPeGluqop+8jqf/8cSZAsWvoZIJqi7++9HuVsfMzHIupEvTjfWRuPUDPJpREARS4m3AKTXfGpc744nDpRf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+t1n6it; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0050C3277B;
	Tue, 16 Apr 2024 10:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262485;
	bh=gPaD6ZJyxD4PgHJQ62WTuuIeGVpHrnbCX8NFKI8kpRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+t1n6it++epyLjfopbsxQhdnhpX19IDElkBJxhK5EJGIUcmKlA2Fo/D6EP4uZyNq
	 3eovMO1vOkWJVqT6Ph1hytqkAsPxLQd3x9k68B78UwANABhyuEoiCWwQuIieDTqEtT
	 djo2jiw5uXXS5JlyV+4fgkeEPcRJ3n01ZvBozKdUQA/Nko3KJwQC8cf6kb6R7rG2tz
	 wxEjM9i8XNOPWIlNpH6mWgEP/NWWmxPcRyvSQi6MQno32AKYMyV1ZZ0dWwQ//jOoMx
	 dEiBw4Gs8cBKrRpqmvKAhOsh6gGSVTsP/xUgw+lmXYTl91r4XJa/0cGENqcAJu7VkB
	 UPFeFysdUYV8A==
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
Subject: [PATCH bpf-next v4 05/14] selftests/bpf: Use start_server_addr in sk_assign
Date: Tue, 16 Apr 2024 18:13:51 +0800
Message-Id: <ae308c91ae256b4271dc35903e457c8b5d29f4de.1713262052.git.tanggeliang@kylinos.cn>
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

Include network_helpers.h in prog_tests/sk_assign.c, use the newly
added public helper start_server_addr() instead of the local defined
function start_server(). This can avoid duplicate code.

The code that sets SO_RCVTIMEO timeout as timeo_sec (3s) can be dropped,
since start_server_addr() sets default timeout as 3s.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/sk_assign.c      | 28 ++-----------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 1374b626a985..fa8f757c0edd 100644
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
@@ -310,7 +287,8 @@ void test_sk_assign(void)
 			continue;
 		prepare_addr(test->addr, test->family, BIND_PORT, false);
 		addr = (const struct sockaddr *)test->addr;
-		server = start_server(addr, test->len, test->type);
+		server = start_server_addr(test->type,
+					   (const struct sockaddr_storage *)addr, test->len);
 		if (server == -1)
 			goto close;
 
-- 
2.40.1


