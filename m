Return-Path: <linux-kselftest+bounces-36569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6AEAF9480
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355553BAA3E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AEA30AAC0;
	Fri,  4 Jul 2025 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rYFVQfVM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g0tO88ty"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC3309DCC;
	Fri,  4 Jul 2025 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751636641; cv=none; b=ElPRV1rNycanpTU7OcKnLFgcwesxPMoFSP7N9M78OAsWy3dH08++McC7qZpKXKXT1yborMqAMHNP7Jxl54nI5g+k55FO2kaL/m0ZAidJPDzdJdHEOzuoYj+o+h92mLpHRUEyje9B+O6o9wAG6tyebDEmO+zm3+Tgg79YwhTSky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751636641; c=relaxed/simple;
	bh=iyflMMcaww0TaUxIqv5bhmdY1+EB8uHiVyLkjVNtbmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZLW2CUl4ailut6xpwfjq/nlbUqVidnq/rj4hfK0pZnvq/D2Fn1oP/BtItlD/wy6rP2DL9XDBAoKeO/CNFSZBiC/c26SUGf2zlARjVp0g5MNtx9wHMm8o2hvlNGS5i+DmpHFX1c7vHk76OzovSjkNKmK9hM9JIK5NCRJ1ZyHWYvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rYFVQfVM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g0tO88ty; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751636636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7n6+lL1C8Ihfql4cv8oByCjEskhz1uNdcFSsnzh03nU=;
	b=rYFVQfVM/TKJXzTAaMVv9SxUNf5aWULBmV2rc8Vq2WRxNImdeXf63jyCoy7w/HIQJdaoBN
	0rGa4/1rwtlFud5KB91uqOAVaJ0908cUmHd12YSSvtQujPJFkMP0q3ZOnvZcYHJISy14kL
	lLseEwhCJAylj7Fbl4BdF30+4K+hjqFwLCrfEKMmJkaVdfOcBiAQA/c8BSaIgvmf/oWVOn
	Nutd2LuRfHORd1wuQvy38IDsctP9Hz8im1sOqR3e0X5Wp1bB8jwLr4obwB7eUOF3cmQ/5O
	oTC8tgaohhwpb9P0ocy2x/jtMNK1VD8zJlj+gorpJ/B1lYPCLyqqgOFqQmjHxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751636636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7n6+lL1C8Ihfql4cv8oByCjEskhz1uNdcFSsnzh03nU=;
	b=g0tO88tyvGX+T4EQfkgCZ06GxlmRSYAmT59ruAZcMPWCIKvgCVDg4nAXEg2gG7JbvsWvf7
	P5Nb56yAgtKRYoCA==
Date: Fri, 04 Jul 2025 15:43:13 +0200
Subject: [PATCH 2/2] selftests/nolibc: correctly report errors from
 printf() and friends
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-nolibc-printf-error-v1-2-74b7a092433b@linutronix.de>
References: <20250704-nolibc-printf-error-v1-0-74b7a092433b@linutronix.de>
In-Reply-To: <20250704-nolibc-printf-error-v1-0-74b7a092433b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751636627; l=2397;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=iyflMMcaww0TaUxIqv5bhmdY1+EB8uHiVyLkjVNtbmQ=;
 b=vlqXtG0vZzOuAK5oipWe+2Nkn/Dq/7rTG5mSwe6qGxTYsltBGHKy2CDC6OcU68Hcbl7E7iTUb
 /M/6gH+5cbgDbx8WJAgUbrG7Nq0hYR6e0z0cIDHn79lm9O/ZprcwTfN
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When an error is encountered by printf() it needs to be reported.
errno() is already set by the callback.

sprintf() is different, but that keeps working and is already tested.

Also add a new test.

Fixes: 7e4346f4a3a6 ("tools/nolibc/stdio: add a minimal [vf]printf() implementation")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/stdio.h                 |  4 ++--
 tools/testing/selftests/nolibc/nolibc-test.c | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index c470d334ef3f410d0584e01045d380347d61ad95..7630234408c584a560b059f0a7e30d407d186f17 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -358,11 +358,11 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
 				n -= w;
 				while (width-- > w) {
 					if (cb(state, " ", 1) != 0)
-						break;
+						return -1;
 					written += 1;
 				}
 				if (cb(state, outstr, w) != 0)
-					break;
+					return -1;
 			}
 
 			written += len;
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 929b966099b369aeca6d43002ebb0a160674dddc..2835f65bda30ffabde749f42a6d3dfecc9b555fd 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1661,6 +1661,28 @@ int test_strerror(void)
 	return 0;
 }
 
+static int test_printf_error(void)
+{
+	int fd, ret, saved_errno;
+
+	fd = open("/dev/full", O_RDWR);
+	if (fd == -1)
+		return 1;
+
+	errno = 0;
+	ret = dprintf(fd, "foo");
+	saved_errno = errno;
+	close(fd);
+
+	if (ret != -1)
+		return 2;
+
+	if (saved_errno != ENOSPC)
+		return 3;
+
+	return 0;
+}
+
 static int run_printf(int min, int max)
 {
 	int test;
@@ -1690,6 +1712,7 @@ static int run_printf(int min, int max)
 		CASE_TEST(width_trunc);  EXPECT_VFPRINTF(25, "                    ", "%25d", 1); break;
 		CASE_TEST(scanf);        EXPECT_ZR(1, test_scanf()); break;
 		CASE_TEST(strerror);     EXPECT_ZR(1, test_strerror()); break;
+		CASE_TEST(printf_error); EXPECT_ZR(1, test_printf_error()); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */

-- 
2.50.0


