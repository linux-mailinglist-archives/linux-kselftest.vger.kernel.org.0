Return-Path: <linux-kselftest+bounces-7650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566A88A0533
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9E01F23909
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EAE60EC3;
	Thu, 11 Apr 2024 01:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYs5SeAW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3938F60DE9;
	Thu, 11 Apr 2024 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797439; cv=none; b=CHsPTXzlq0OM4SQEbbeHguWMFohhxkMlperLKaS6Mhz1Uejt7gwwskPeWOEbkEmQKWp2os4QsXikopS+CgBNdjV1BlShiPiuBhDg2eaIkIjTKs15C/YrqW5SIH2h4EZhNPfDBSGFSKsAC5h8332nMhFD2IrsGW+E7DUEcqpLU4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797439; c=relaxed/simple;
	bh=i0/HbyXy9mTe8xyzUPu5bCQ3pV8e1VXhg0MQMOhx8Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ad+zV2trsyUwAnNOFRcb1MsPQOf3IbPu1AgdA+yQCDFd5rKueRsfpDa9UnomV7TZWvHCnonmAfZjFUuhzsV5y5lMeNAuAtCHYdOX6UcHwjRURZenYsaHL8lllPVmeVbMrKKQyizTp2X7gggHeOEvTzx2reG+vZNDWFTHNHb7L+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYs5SeAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BA2C43394;
	Thu, 11 Apr 2024 01:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712797438;
	bh=i0/HbyXy9mTe8xyzUPu5bCQ3pV8e1VXhg0MQMOhx8Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sYs5SeAWGu3DyudYWqSwG5WCFssiVEFzt/pbcVg+TkNVxLr1VBxQKNK/+Epo2cscK
	 Gj8g/BBjCbWnirNTLwFfyM1Si16NKLs6SGGMfd4palXd9aGlWu4G+ZbzukVIKwoXZ5
	 6w1stlOs4gV3SKgkiJWqRrt/RNZdX4HdLqcwjYHn9XjSQa4Fpoy8cdNwayn2NkX8Zz
	 a2+M82nLmAn2p2vHzqvHs9vFtgueQlrghn2/Q3Pmqw6qWKSn/sTgTNCRunDrauWX6k
	 SGxF3yJrzGw/xmLmRZl4jM3VKDIe0Lb6fNErc9/QFHtzqRBkQuJB08sEzzvKuhnYbz
	 XhQYHQC4KxMoQ==
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
Subject: [PATCH bpf-next v2 04/14] selftests/bpf: Use start_server_addr in sk_assign
Date: Thu, 11 Apr 2024 09:03:12 +0800
Message-Id: <4aa58529b2bb841672176014a4f28d3ae2658caa.1712796967.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712796967.git.tanggeliang@kylinos.cn>
References: <cover.1712796967.git.tanggeliang@kylinos.cn>
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


