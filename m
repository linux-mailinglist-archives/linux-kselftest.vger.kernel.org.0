Return-Path: <linux-kselftest+bounces-8735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD98AFBA0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 00:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFDE1F20FE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 22:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B33145B04;
	Tue, 23 Apr 2024 22:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="c5lFi0A+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F0144D22;
	Tue, 23 Apr 2024 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713910538; cv=none; b=QtEZD+/B/2NgyYjhay+pvM6/9semsyLwregLBLVrsZy56oBCvCUhSy0LqNZ1okTi2rG3UJoBBj7uqdo3Sykl8R3XgxVL/IrXtz3a3biMiNqgf383hmFbRbmGFtAD7b2+vbX0g203FZn2LQfknHg9LPY1o5CGbiVSnTmMA9+8rkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713910538; c=relaxed/simple;
	bh=v/uHqDbYyNczx9qU8qaftsOIwKU/Btebsep5aBORjOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cwWuRT4ecN9CMPcsUTaw0dCzoT5JBb7i0d9AtwnGDCO4J2HyCLeIVjzOr8rXgxJc4N2m8RHr8BRYedChN/AnYdIpj+zpxHMDhKajeXi27w8UqXetc2PHjyeKG7mB6jTNbzz2qEjDeL0IKNB28sZm3Xm8uBgh/Fzsj4ULf+FkBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=c5lFi0A+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713910534;
	bh=v/uHqDbYyNczx9qU8qaftsOIwKU/Btebsep5aBORjOg=;
	h=From:Date:Subject:To:Cc:From;
	b=c5lFi0A+wfLcN1/dShqW4qOhOTT1SghvqtlqBpGL70e+NXkkIrwzNnaHsdUBFMtNx
	 PF+s6WRQ3p4pZUyUJrA1aqTOaDCOe3A3TNlkIkxtxrVzj5IqjZfCTye5zsuriDMaXZ
	 s0ZNNyuSU7Qhqcg96XEbVl3rZ8MtqREMRqFmlGBg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 24 Apr 2024 00:15:33 +0200
Subject: [PATCH] selftests/nolibc: disable brk()/sbrk() tests on musl
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240424-nolibc-musl-brk-v1-1-b49882dd9a93@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAQzKGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEyNj3bz8nMykZN3c0uIc3aSibF1zcwuTxJQUI0sLA0MloK6CotS0zAq
 widGxtbUA0FOv9mEAAAA=
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713910533; l=2481;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=v/uHqDbYyNczx9qU8qaftsOIwKU/Btebsep5aBORjOg=;
 b=HPqnlAQGaiCRLb87BWAbrmaCSgNyiByABLLXZDgndTFSn2JzyeLNju53F/FMVRc+4quBbAQ52
 bqCWZ8eV666C535FvzSZ2suQKGa8mWgix3T6tZE0ftG24Q6NnfO7WKh
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

On musl calls to brk() and sbrk() always fail with ENOMEM.
Detect this and skip the tests on musl.

Tested on glibc 2.39 and musl 1.2.5 in addition to nolibc.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 94bb6e11c16f..89be9ba95179 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -942,6 +942,7 @@ int run_syscall(int min, int max)
 	int ret = 0;
 	void *p1, *p2;
 	int has_gettid = 1;
+	int has_brk;
 
 	/* <proc> indicates whether or not /proc is mounted */
 	proc = stat("/proc", &stat_buf) == 0;
@@ -954,6 +955,9 @@ int run_syscall(int min, int max)
 	has_gettid = __GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 30);
 #endif
 
+	/* on musl setting brk()/sbrk() always fails */
+	has_brk = brk(0) == 0;
+
 	for (test = min; test >= 0 && test <= max; test++) {
 		int llen = 0; /* line length */
 
@@ -969,9 +973,9 @@ int run_syscall(int min, int max)
 		CASE_TEST(kill_0);            EXPECT_SYSZR(1, kill(getpid(), 0)); break;
 		CASE_TEST(kill_CONT);         EXPECT_SYSZR(1, kill(getpid(), 0)); break;
 		CASE_TEST(kill_BADPID);       EXPECT_SYSER(1, kill(INT_MAX, 0), -1, ESRCH); break;
-		CASE_TEST(sbrk_0);            EXPECT_PTRNE(1, sbrk(0), (void *)-1); break;
-		CASE_TEST(sbrk);              if ((p1 = p2 = sbrk(4096)) != (void *)-1) p2 = sbrk(-4096); EXPECT_SYSZR(1, (p2 == (void *)-1) || p2 == p1); break;
-		CASE_TEST(brk);               EXPECT_SYSZR(1, brk(sbrk(0))); break;
+		CASE_TEST(sbrk_0);            EXPECT_PTRNE(has_brk, sbrk(0), (void *)-1); break;
+		CASE_TEST(sbrk);              if ((p1 = p2 = sbrk(4096)) != (void *)-1) p2 = sbrk(-4096); EXPECT_SYSZR(has_brk, (p2 == (void *)-1) || p2 == p1); break;
+		CASE_TEST(brk);               EXPECT_SYSZR(has_brk, brk(sbrk(0))); break;
 		CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); chdir(getenv("PWD")); break;
 		CASE_TEST(chdir_dot);         EXPECT_SYSZR(1, chdir(".")); break;
 		CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOENT); break;

---
base-commit: 0adab2b6b7336fb6ee3c6456a432dad3b1d25647
change-id: 20240423-nolibc-musl-brk-7784add29801

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


