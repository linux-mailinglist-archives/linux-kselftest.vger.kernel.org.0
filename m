Return-Path: <linux-kselftest+bounces-8111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74098A67F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CEF1C20F45
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF2E126F0D;
	Tue, 16 Apr 2024 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtiEvm15"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55BF86AFC;
	Tue, 16 Apr 2024 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262473; cv=none; b=HE20I8lScHdRIoxXYULS48wTqEBrlQw9V3nr1X5fkPUFIPZhvjX7nHE0PlmPEkg02kOknDI38V2+iIDPuanKEcBwFQldsT0OgBNsxZiSR1QtPmltFSSDYW2cPHty8me7B5989KNCMXSYCPRx6UcSRX2G8tdT3f0D0zE2uOdABns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262473; c=relaxed/simple;
	bh=NHEB9TokBCk2Zcvs5aYjfmxZ3CANdUFDFp4WT/vneAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IeJfZq5dkVfinBHZJU3Ott4uFTd0QM9KWFM2FypFbwGYwDB8/36+c02oYcGrIfUzr104hTo91nuYebQm2hGb5ZJjr7u8kA2nss8XDEIwj7oVU6EfpNwqRw68PvM3d0u3sFV87v0b20keR46YEMW09Yfn9rGVv45QpGgOonKI11k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtiEvm15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B82EC2BD10;
	Tue, 16 Apr 2024 10:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262473;
	bh=NHEB9TokBCk2Zcvs5aYjfmxZ3CANdUFDFp4WT/vneAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MtiEvm15RCq66te4B9nCMeCw9D5SoRnhlPq9irwKd2I1x2sGYhu7pXhd5EDWkn3GZ
	 rwsPsLjNhwV0FXM6ibQ/RrLs79FQP7FR+FjmJGyXCphMUWdbai8sWsD7lUk0rUkGXA
	 KOsUKqkM6o6eGCpMT067BuJoDWpIclZm8G01pUCTc1ohA3LkBwCGQbt2TXqj8fILCm
	 qLteikQUweh7Weq5d960199tZuIUEK9eqNWg5xRfmlBXlG/ldVuzoVwSgSSFNm07Sh
	 9oUBRFXKKYq6Ah5A/x2VxPXHLTVMpHXao+WP8bpr+O2Wdlt7iAXNbazxRNpCYGT2vj
	 0XpwtsTBgpZcA==
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
Subject: [PATCH bpf-next v4 03/14] selftests/bpf: Use start_server_addr in cls_redirect
Date: Tue, 16 Apr 2024 18:13:49 +0800
Message-Id: <4358ac25a3924d2f66cd73efd034530443eee254.1713262052.git.tanggeliang@kylinos.cn>
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

Include network_helpers.h in prog_tests/cls_redirect.c, use the newly
added public helper start_server_addr() instead of the local defined
function start_server(). This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/prog_tests/cls_redirect.c   | 20 ++-----------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cls_redirect.c b/tools/testing/selftests/bpf/prog_tests/cls_redirect.c
index 2a55f717fc07..4050d470d2a2 100644
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
+	*server = start_server_addr(type, (struct sockaddr_storage *)addr, len);
 	if (*server < 0)
 		return false;
 
-- 
2.40.1


