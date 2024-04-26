Return-Path: <linux-kselftest+bounces-8915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 500828B3650
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 13:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 061AFB23085
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 11:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4B114532B;
	Fri, 26 Apr 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="PUYvuhGV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D12144D0E;
	Fri, 26 Apr 2024 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129765; cv=none; b=clj1Hd5DPFrc8PiVAefDNfHkGHz3cPbSoqDG22Exz4/d5IkFLT4ST6pvvnFjTV7WtA296D+jApFPhwxsLRT/Rr3ydoezVCt2VQ9bj8fphl7MktfUazmkqK0UzCFG20SJYOYabbdrf4pk4eAGipz7HIXCM7zPT7CVDF82R74BEp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129765; c=relaxed/simple;
	bh=NBg8CCRMBOJmgxZRwKaQbukZLLVfWaE0h/O78pLsQbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0yJQGfgBMP149iRJPlarVPOVxAvynuE9NBHpiB5YK2u9zb7Wvvg6WXrDNqJvtX3wn6XscXuJM4N9LFFx52bxJhUvWkYocgM7Lq9NdHbXNaAE7AngBysiddp41PTXTRfeJPIwoUJgTkTqXl93OMtbZmqE/xBQepJCRKu/WARzk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=PUYvuhGV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714129754;
	bh=NBg8CCRMBOJmgxZRwKaQbukZLLVfWaE0h/O78pLsQbU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PUYvuhGV+o4EGVe/HmRpG/breHRO5ePgxGc5iPgXfaIDqpYB1BBratm/0XeNHaxvX
	 3QbytrVb/0s8Fvq9UT7iyQbCbJEt+YAgN2Ms+JlEjJZ/3pSKYEC/GE1om50aainndt
	 wNZZqLK+WsAbzvo2iuwZAnE4pQWJ7rjtwi7pmO0M=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 26 Apr 2024 13:08:57 +0200
Subject: [PATCH 2/3] tools/nolibc: implement strerror()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240426-nolibc-strerror-v1-2-76a4c9c5271d@weissschuh.net>
References: <20240426-nolibc-strerror-v1-0-76a4c9c5271d@weissschuh.net>
In-Reply-To: <20240426-nolibc-strerror-v1-0-76a4c9c5271d@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714129753; l=2098;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=NBg8CCRMBOJmgxZRwKaQbukZLLVfWaE0h/O78pLsQbU=;
 b=2+5cf3DWm5+radMrTu3w4PvCDKr2JJPmJ8wDAZsbZbd6gEOODQIPfQ5J3G65Uj1iiNDRQTWvK
 MdMaa2zXQTACrye0T+HKaznHdkpV7xrMWzFOq+VGV1HKvHvOizPI0/Y
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

strerror() is commonly used.
For example in kselftest which currently needs to do an #ifdef NOLIBC to
handle the lack of strerror().

Keep it simple and reuse the output format of perror() for strerror().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/stdio.h                 | 10 ++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 16cd4d807251..c968dbbc4ef8 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -376,6 +376,16 @@ int setvbuf(FILE *stream __attribute__((unused)),
 	return 0;
 }
 
+static __attribute__((unused))
+const char *strerror(int errno)
+{
+	static char buf[18] = "errno=";
+
+	i64toa_r(errno, &buf[6]);
+
+	return buf;
+}
+
 /* make sure to include all global symbols */
 #include "nolibc.h"
 
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index dadc9b8f2727..1c23776713f5 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1208,6 +1208,10 @@ int run_stdlib(int min, int max)
 		CASE_TEST(strtol_underflow);        EXPECT_STRTOX(1, strtol, "-0x8000000000000001", 16, LONG_MIN, -1, ERANGE); break;
 		CASE_TEST(strtoul_negative);        EXPECT_STRTOX(1, strtoul, "-0x1", 16, ULONG_MAX, 4, 0); break;
 		CASE_TEST(strtoul_overflow);        EXPECT_STRTOX(1, strtoul, "0x10000000000000000", 16, ULONG_MAX, -1, ERANGE); break;
+		CASE_TEST(strerror_success);        EXPECT_STREQ(is_nolibc, strerror(0), "errno=0"); break;
+		CASE_TEST(strerror_EINVAL);         EXPECT_STREQ(is_nolibc, strerror(EINVAL), "errno=22"); break;
+		CASE_TEST(strerror_int_max);        EXPECT_STREQ(is_nolibc, strerror(INT_MAX), "errno=2147483647"); break;
+		CASE_TEST(strerror_int_min);        EXPECT_STREQ(is_nolibc, strerror(INT_MIN), "errno=-2147483648"); break;
 
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.44.0


