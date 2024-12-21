Return-Path: <linux-kselftest+bounces-23720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEE99FA112
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 15:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782F718909E7
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BAB1FBC9B;
	Sat, 21 Dec 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qlYyNW/i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473D11F868A;
	Sat, 21 Dec 2024 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734792277; cv=none; b=dsu6+U5gv69DrdpqPjWxrwe6K4jtNipOPCtrc1UTwrcisD8BR/cS0GNYRYtV7389Z8WPeB2gc7ZKIs5+Ngta1qGNDvWC6AoLxPyO0yrMs4myYtdcz9kOSM0xwlWnFfyT+tklgssuScEErsttvfgigOKUN7FGzK7sucdlXlw+NJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734792277; c=relaxed/simple;
	bh=nj0Jq2wR9LzNkifobwaqgqXXDXIUpTLkrlfLIfSBrB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e1AH9rTEK4UsX1LcLFd2R6umVlozcYshnC0udhszxhZfxz83FDo5U1+MA4L6ILpDqwTItFE3KZJQo7xPTPJnQWfRBhRednkTIxazYir2TXdnnH7ryT3FUUhrSKN6p6jDnO6hmNX6NbpzY5RKWh3qPBMva/JQA+PTxaBcLZE+9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qlYyNW/i; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734792272;
	bh=nj0Jq2wR9LzNkifobwaqgqXXDXIUpTLkrlfLIfSBrB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qlYyNW/izxCwfFi+f66Ru0I8+DJsNe4VI5K+fVDh/dW7IvmATed3cwBw4PqoiW2RK
	 nRwH8DmOTcq334Zcjbx24G7FaJV3tJhMvCwuQi1xNZ03ETZz3yPX1I63rvfy8zmSUs
	 Hg7mfMhSeLDztySrOWH0RwKshbp9f8lGc1urPlNI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 21 Dec 2024 15:44:29 +0100
Subject: [PATCH 2/6] selftests/nolibc: use waitid() over waitpid()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241221-nolibc-rv32-v1-2-d9ef6dab7c63@weissschuh.net>
References: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
In-Reply-To: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Zhangjin Wu <falcon@tinylab.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734792271; l=1420;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=nj0Jq2wR9LzNkifobwaqgqXXDXIUpTLkrlfLIfSBrB4=;
 b=nvClkbgo3WfomII9Gy/xuFDJ9bB9UMA1pDy2NmiSII3/8wtxOEGKSgH4f7omKIQ1AdzBh90WO
 KikHBwUy9gaDVBG4QiL3SWkr/UlaGwLPzeAQUIDgyz+zlaJNiyN5UwW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Newer archs like riscv32 don't provide waitpid() anymore.
Switch to waitid() which is available everywhere.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6fba7025c5e3c002085862fdf6fa950da6000d6c..60c50968d3630e4909a5ecb2400770baaf7c2add 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1323,7 +1323,8 @@ static int run_protection(int min __attribute__((unused)),
 			  int max __attribute__((unused)))
 {
 	pid_t pid;
-	int llen = 0, status;
+	int llen = 0, ret;
+	siginfo_t siginfo = {};
 	struct rlimit rlimit = { 0, 0 };
 
 	llen += printf("0 -fstackprotector ");
@@ -1361,10 +1362,11 @@ static int run_protection(int min __attribute__((unused)),
 		return 1;
 
 	default:
-		pid = waitpid(pid, &status, 0);
+		ret = waitid(P_PID, pid, &siginfo, WEXITED);
 
-		if (pid == -1 || !WIFSIGNALED(status) || WTERMSIG(status) != SIGABRT) {
-			llen += printf("waitpid()");
+		if (ret != 0 || siginfo.si_signo != SIGCHLD ||
+		    siginfo.si_code != CLD_KILLED || siginfo.si_status != SIGABRT) {
+			llen += printf("waitid()");
 			result(llen, FAIL);
 			return 1;
 		}

-- 
2.47.1


