Return-Path: <linux-kselftest+bounces-7534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440EB89EBF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B341C210AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D08E13CFB5;
	Wed, 10 Apr 2024 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgUYQH0S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027AB26AC7;
	Wed, 10 Apr 2024 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734211; cv=none; b=Q8GqwzAcommxgmmvJ6QZB7EiUtAEXCLUq2WUPcVcPF/T6z+bvyCHH4Yv13m8uit6riJrhjgT5qptCRRvPSeB5+MxJmsGnJ9rFUrUenFBp96T9oIgezQub5PbcPqkzkYCmzExU8UDHGEpe1cyaPH/fReQkWE5ok21mJvjDhHoNVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734211; c=relaxed/simple;
	bh=XWeh00IOXYJlftJnTBXDAKK+X/bhZEtWsLxktauMllw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ljg+qF2/lM/36tHF5702vooSuoIuV4PAXfthINykpzhxPEr5+lG9AQdmUMPV+jOjSTBuBMm1d2pVagnvyVl3Zi/HKkoInrg4OiqNvMdrToMASkDfuSCw412u/c/LxBGs0gf+e1ZakzS5CHpDmzUwathRd37LjdZlsThZQW36Yc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgUYQH0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBF1C43394;
	Wed, 10 Apr 2024 07:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734210;
	bh=XWeh00IOXYJlftJnTBXDAKK+X/bhZEtWsLxktauMllw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EgUYQH0SROeLQFgZo1MdFpPvG9ZBWGj/UvDXDMl5hUvuVVl5NRPUAPmjDhj4ACQyc
	 BeZhhZdCqNMhgnZYKKAltYaHIGXaOsc1grE5wPzrAy6/Dvt2UutcJ8BPT8khMhMDoe
	 20gaOVU8Ji2OS3D+UJpHPigr4ipgJldO6RR70cf7ZSTntUeiszxMkDK7cxlNdVN0bD
	 /ANLUKd/MGfW9lnRZAeAI2fwL/ZqT2jiPGooNzGdvnoJ8/wJStJURglBXOf2myxlJH
	 bHgW9wlUGJ6xSypYiYDC+2H7b/kC1rUaCGRBwaz9Ksxhp3BCKCVh/AZNQlW05d11bk
	 4xEJcKCEXtSYA==
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
Subject: [PATCH bpf-next 02/14] selftests/bpf: Use start_server_addr in cls_redirect
Date: Wed, 10 Apr 2024 15:29:35 +0800
Message-Id: <741f199a0bd26b9caed6a8b13c48ab98b3c28b42.1712733999.git.tanggeliang@kylinos.cn>
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

Include network_helpers.h in prog_tests/cls_redirect.c, use the newly
added public helper start_server_addr() instead of the local defined
function start_server(). This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/cls_redirect.c   | 20 ++-----------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
index 2a55f717fc07..013051555ce6 100644
--- a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
@@ -10,6 +10,7 @@
 #include <netinet/tcp.h>
 
 #include <test_progs.h>
+#include "network_helpers.h"
 
 #include "progs/test_cls_redirect.h"
 #include "test_cls_redirect.skel.h"
@@ -35,23 +36,6 @@ struct tuple {
 	struct addr_port dst;
 };
 
-static int start_server(const struct sockaddr *addr, socklen_t len, int type)
-{
-	int fd = socket(addr->sa_family, type, 0);
-	if (CHECK_FAIL(fd == -1))
-		return -1;
-	if (CHECK_FAIL(bind(fd, addr, len) == -1))
-		goto err;
-	if (type == SOCK_STREAM && CHECK_FAIL(listen(fd, 128) == -1))
-		goto err;
-
-	return fd;
-
-err:
-	close(fd);
-	return -1;
-}
-
 static int connect_to_server(const struct sockaddr *addr, socklen_t len,
 			     int type)
 {
@@ -98,7 +82,7 @@ static bool set_up_conn(const struct sockaddr *addr, socklen_t len, int type,
 	socklen_t slen = sizeof(ss);
 	struct sockaddr *sa = (struct sockaddr *)&ss;
 
-	*server = start_server(addr, len, type);
+	*server = start_server_addr(addr, len, type);
 	if (*server < 0)
 		return false;
 
-- 
2.40.1


