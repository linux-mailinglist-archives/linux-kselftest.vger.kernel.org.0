Return-Path: <linux-kselftest+bounces-8297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 155CE8A94A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 10:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64FA282AB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 08:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D567CF2B;
	Thu, 18 Apr 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epGTGI8E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30182C68C;
	Thu, 18 Apr 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427775; cv=none; b=hjeNFKk3oRTrTVKr6RgHZUQWVMx1gSooeYFOHY90L8ltyMPBZzV+Qz0PCFQluGtGSJpwCcHbSHxXUUANHGiCDz9QtVz8JQSbAOoczq911dT/EPXgMArfz38+ty/BZCQNMzBqu7gfONKKwwpSbarW6AAwwAVffShF93i1+wLg4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427775; c=relaxed/simple;
	bh=B0mLqYkHNsV+/yp9TZfhJRF6UHDk7gt/NZKMQV+0ozM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SE/WPzkDCXnaA4kZBZ8e+G5xDal/7ZBe7AXbXkSQN7G0LxQn/AY05P/qw20QMhF0Tex7jetBCEHw+6N0S/L+Mb5EB8rRQaes+/f1Vf2V5dOh/t7rUvlNfOrjIiOfTQHFCChAYBlBltyIrZ7x/M9NVl1NRvauDQ5LozX7QQ2o8Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epGTGI8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F48DC113CE;
	Thu, 18 Apr 2024 08:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713427775;
	bh=B0mLqYkHNsV+/yp9TZfhJRF6UHDk7gt/NZKMQV+0ozM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=epGTGI8EDgRkno3B+Nzntw+eNPcNItf6yxk6ROI0X0sdl2SD8fSWNgG2Hq8oO3jHs
	 TxU9gyWyqGb0LLjBU7KztLHYZDkYqi4Ytn7IPEdO0e6uP2jt9+x6Obyl/50c6+2+bV
	 kPXNMuQAzgFsSZTTGdEdml9rZ8hkWKLI5v8PWGPAnwPHqbDMFWTAjYUctPAxvY2Qq8
	 r/AQVDdRhCc9Ev09LRxiNas3fis1wnOL7NtLM8/cSoU6+0Gv/CGE++CqRRJNoIBh4a
	 ZxB4jXDAyc4bPN0Q0bfSKyWYJuih83XYhT14paNHa0DjvCwiQOubTC2sn+hmW5Sr71
	 1x/HsWpPligAw==
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
Subject: [PATCH bpf-next v5 2/6] selftests/bpf: Use start_server_addr in cls_redirect
Date: Thu, 18 Apr 2024 16:09:08 +0800
Message-Id: <13f336cb4c6680175d50bb963d9532e11528c758.1713427236.git.tanggeliang@kylinos.cn>
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

Include network_helpers.h in prog_tests/cls_redirect.c, use the newly
added public helper start_server_addr() instead of the local defined
function start_server(). This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/cls_redirect.c   | 20 ++-----------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
index 2a55f717fc07..68cb93106658 100644
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
+	*server = start_server_addr(type, (struct sockaddr_storage *)addr, len, NULL);
 	if (*server < 0)
 		return false;
 
-- 
2.40.1


