Return-Path: <linux-kselftest+bounces-18555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB3298980B
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 23:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9ED1F216BF
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 21:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D29F185B62;
	Sun, 29 Sep 2024 21:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dMGieA04"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3137181D00;
	Sun, 29 Sep 2024 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727646474; cv=none; b=oNvmu8W/btvdChUxGZ5t0COz/JCGSDml5SMsq0RaS7osVwLwRu1u/uQOq4hXcCbajb6aMfBmCrEdWFYJm+dmU+GOVttf3vC+TQpLYtQlsR5t3gBBLkaRbDl8h53Ipj64NdlA+UdifmsBkHT6XS8fpEO8h/dLNpRV0GdeBsLpcY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727646474; c=relaxed/simple;
	bh=KjxYPOTEK04i0aDe9R3P7xjZpnny61B4KWUV7zhoxYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8DflxCb+DvNr1jftPoezA6TQluLjOVhfdKWxWAdUheuth1LmzgWtUx6kNDmXYW9g8SnL5ZWDRev0LGoXvsJhnonsv101NHmVyH+TZheSuVOSMgOJG2vbj1C/XtmqLM32c8WjkaPU1+xwr6CaF0w/rtaF638G9tfzWWwAWB28ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dMGieA04; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1727646465;
	bh=KjxYPOTEK04i0aDe9R3P7xjZpnny61B4KWUV7zhoxYU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dMGieA04I1ViWnYpd+fojwnXQNoDCDM47Tc3qxbuohIipbMr6MQ1XzJUctpFpn840
	 atD1wP4kFz3zep0LWQp0lYrDXi7Nk9eT+3LvMZh+Rgbry4efJlEduzfI4TXtmnWlm9
	 RM0IhRHYpl5reL7QvfZJKLmQQ2eFU4BEH+5OrMSk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 29 Sep 2024 23:47:40 +0200
Subject: [PATCH 5/5] selftests/nolibc: skip test for getppid() on csky
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240929-nolibc-csky-v1-5-bb28031a73b0@weissschuh.net>
References: <20240929-nolibc-csky-v1-0-bb28031a73b0@weissschuh.net>
In-Reply-To: <20240929-nolibc-csky-v1-0-bb28031a73b0@weissschuh.net>
To: Guo Ren <guoren@kernel.org>, Willy Tarreau <w@1wt.eu>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727646464; l=2023;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=KjxYPOTEK04i0aDe9R3P7xjZpnny61B4KWUV7zhoxYU=;
 b=1ofSVpBYrnMLeG02nuqsxZrKjnXJpHxpp3FJIwFQKCCUGVb/PKQivP6lnZtC9zsAv+qE/yfU4
 qMonmekTr0PBbReUXTPKJKk8O69mrEgD4eJ5VlJShxAWAaZ3vZGp+Iz
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Old non-mainline Linux and current non-mainline qemu-user use different
syscall numbers than mainline Linux.
__NR_getppid and __NR_rt_sigreturn are swapped.
As the runtime environment can't be determined during compilation,
sidestep the whole issue by skipping the test.

Link: https://lore.kernel.org/linux-csky/2fa3151f-5aab-406c-95d9-add398ae58b3@t-8ch.de/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6fba7025c5e3c002085862fdf6fa950da6000d6c..daf6a9b84a3051413cbb1d01918f745c3b83426c 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -995,7 +995,7 @@ int run_syscall(int min, int max)
 	int tmp;
 	int ret = 0;
 	void *p1, *p2;
-	int has_gettid = 1;
+	int has_gettid = 1, has_getppid = 1;
 	int has_brk;
 
 	/* <proc> indicates whether or not /proc is mounted */
@@ -1009,6 +1009,11 @@ int run_syscall(int min, int max)
 	has_gettid = __GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 30);
 #endif
 
+	/* qemu-user and non-mainline Linux use different syscall number */
+#if defined(__csky__)
+	has_getppid = 0;
+#endif
+
 	/* on musl setting brk()/sbrk() always fails */
 	has_brk = brk(0) == 0;
 
@@ -1020,7 +1025,7 @@ int run_syscall(int min, int max)
 		 */
 		switch (test + __LINE__ + 1) {
 		CASE_TEST(getpid);            EXPECT_SYSNE(1, getpid(), -1); break;
-		CASE_TEST(getppid);           EXPECT_SYSNE(1, getppid(), -1); break;
+		CASE_TEST(getppid);           EXPECT_SYSNE(has_getppid, getppid(), -1); break;
 		CASE_TEST(gettid);            EXPECT_SYSNE(has_gettid, gettid(), -1); break;
 		CASE_TEST(getpgid_self);      EXPECT_SYSNE(1, getpgid(0), -1); break;
 		CASE_TEST(getpgid_bad);       EXPECT_SYSER(1, getpgid(-1), -1, ESRCH); break;

-- 
2.46.2


