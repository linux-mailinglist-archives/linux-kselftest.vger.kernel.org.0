Return-Path: <linux-kselftest+bounces-7543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B62E89EC0D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B9A1F21B94
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0160413D251;
	Wed, 10 Apr 2024 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMFOkm9e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2DE13CFA1;
	Wed, 10 Apr 2024 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734264; cv=none; b=lNlBDTGWHxjq3RaxiStzISdwe4MnVwsgB/8ldo0QcYDFcUXkCTPzat4sxXMnFknPAWVu+U8b7rXrK9jpr68L6mAntl+JeL+iRm9j0l9Odxm/s64sxX2n7wkHvS62GY98u3lUKsSdWGMgdho9Hy+a8p76h/KtY+vuvmY/HuwS3i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734264; c=relaxed/simple;
	bh=ddcUc2GvC6cttiBg+2jPY0ijTi1aBmIgeRcsxp0Owrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iefPgFyy9p+gc7vh2nk4XkaalS+XlcS7RXvQyNphw7DUxlp2za9CRD/tKYSdwdbEdKMFkHIh00MEBNuBw3zyUu1EosIQH6vac9fT3a1C4eX1lsEvSFyNlrLb95vQhBSEFEu3Eo/xaMZLM9YAn32mCa6NE9/Fkiu6nHev8A1ajPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMFOkm9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9B4C433C7;
	Wed, 10 Apr 2024 07:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734264;
	bh=ddcUc2GvC6cttiBg+2jPY0ijTi1aBmIgeRcsxp0Owrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jMFOkm9eZUD9ez0myPzvjIRjUFqeYHXjavOvFX2g3LsW87qqsN3PSuT+1BCWeVNYa
	 rs3GSOAHAcKi5iHcHfOInuWjKr2qHT3pMIrGiPYZL/6YDPQdYDVdtmhVwjFMQla3E3
	 8jGIZhC9rAFxHwnhNyxphhNxzqDosx7Nl8us7TWYn151wIwtZoTSzIkxSLM/A3e2RU
	 unp+EcHYCSrsDzdFwcBNEBOqDcDFFYKPM/QKs9ooJU1IcEm8clVxpKu12wN1Uq7Gsy
	 D2Ra+IeCSJ0oG+Xn3YYPslkAm7UnZmBYgji+ADFxDlCs2ow26ywrFSyuY3zGTg7Xr7
	 OMi7yhFM8Ty+Q==
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
Subject: [PATCH bpf-next 11/14] selftests/bpf: Use start_server_setsockopt in sockopt_inherit
Date: Wed, 10 Apr 2024 15:29:44 +0800
Message-Id: <4452c137ced92a1b513acf35ef2546db9298b644.1712733999.git.tanggeliang@kylinos.cn>
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

Include network_helpers.h in prog_tests/sockopt_inherit.c, use public
helpers make_sockaddr() and start_server_setsockopt() instead of the
local defined function start_server(). This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../bpf/prog_tests/sockopt_inherit.c          | 33 ++++++++-----------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index 917f486db826..f000d9229765 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include "cgroup_helpers.h"
+#include "network_helpers.h"
 
 #include "sockopt_inherit.skel.h"
 
@@ -98,23 +99,12 @@ static void *server_thread(void *arg)
 	return (void *)(long)err;
 }
 
-static int start_server(void)
+static int setsockopt_loop(int fd, int val)
 {
-	struct sockaddr_in addr = {
-		.sin_family = AF_INET,
-		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
-	};
 	char buf;
 	int err;
-	int fd;
 	int i;
 
-	fd = socket(AF_INET, SOCK_STREAM, 0);
-	if (fd < 0) {
-		log_err("Failed to create server socket");
-		return -1;
-	}
-
 	for (i = CUSTOM_INHERIT1; i <= CUSTOM_LISTENER; i++) {
 		buf = 0x01;
 		err = setsockopt(fd, SOL_CUSTOM, i, &buf, 1);
@@ -125,13 +115,18 @@ static int start_server(void)
 		}
 	}
 
-	if (bind(fd, (const struct sockaddr *)&addr, sizeof(addr)) < 0) {
-		log_err("Failed to bind socket");
-		close(fd);
-		return -1;
-	}
+	return 0;
+}
 
-	return fd;
+static int start_server_lo(void)
+{
+	struct sockaddr_storage addr;
+	socklen_t addrlen;
+
+	if (make_sockaddr(AF_INET, "127.0.0.1", 0, &addr, &addrlen))
+		return -1;
+	return start_server_setsockopt((struct sockaddr *)&addr, addrlen,
+				       SOCK_STREAM, (void *)setsockopt_loop, 0);
 }
 
 static void run_test(int cgroup_fd)
@@ -160,7 +155,7 @@ static void run_test(int cgroup_fd)
 	if (!ASSERT_OK_PTR(link_setsockopt, "cg-attach-setsockopt"))
 		goto close_bpf_object;
 
-	server_fd = start_server();
+	server_fd = start_server_lo();
 	if (!ASSERT_GE(server_fd, 0, "start_server"))
 		goto close_bpf_object;
 
-- 
2.40.1


