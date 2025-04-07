Return-Path: <linux-kselftest+bounces-30204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67812A7D4B5
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67ACE3B233C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F08F22AE75;
	Mon,  7 Apr 2025 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VkT0ydVV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j58ANFYe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF50422A4FE;
	Mon,  7 Apr 2025 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008792; cv=none; b=f4PG+a6d7WdpZunbssW1j+rUPsC/ph8U8kLDGDh9PrAbUzXvgr7YTSTa2vl0JKgZR7blgtSZeg1XCO2NjA73ELumXoNfVah6NlcnExlEgS5bUxVJttejmZNkXaY/pz3HBpb8vdW8SO/5ywEbmmHd3y2S0v8uS2rXd3svpK3VTxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008792; c=relaxed/simple;
	bh=k1JKwXo2zjXkowh2Iz1iHtu5+LVsdl8EjpnFP/4zQps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BZHeerZqRsXYLmu4U8mJLbGIlf6EPCkZewiU945adQHigaf73ZxcdSy05gZU4dBxQjUUjH60XrV2mAmJV0k2nniBgXx4bhV1IrGtYACe5uX0CmxhaHymjjnhmD5N2pAOqFmwznafa3JGM/c/ETyDjkg98Oq/NQwmYD15ViGCUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VkT0ydVV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j58ANFYe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sSOX1xpNeJxiyfhOoTmnjm0bIp+e5sn96YzgFsrPl2s=;
	b=VkT0ydVVHCG0pKLyhiCMzKwTRMozffwYPXM53/e7lz/6aCqJyTSy/BUk/RqBwLBjE/NUzE
	uf6wwDifHKGlMReq+5L3y06cpCRnaBJ18lMJbWXVDOaTyfSukV2s1EZk7cg3gOHe8EwtcG
	2zwiOboGrIeF7bM6sx8prqAwNIbGiQ0SFki6x7o3F10aM09cY5DdPewD0JYOBdibFm6A2D
	A3EIbGYaQ87BMl4h+WFzLfynsI4uSM8Y4DMvCXCBi/qCl19c95Ddp2NpShtiMNEOrUovv2
	loR/V3TbJwYFf1yeG2k/DtP2dDb7SZHVmzigl7UDkwhenHFVdSWfvv+mNcx4iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sSOX1xpNeJxiyfhOoTmnjm0bIp+e5sn96YzgFsrPl2s=;
	b=j58ANFYeAuXUGDLp1IEz5aPkd7uCGriHT3UnUpH/QBaKM4Th4K7/qyZgmmvwalyX5mEtM5
	7XvBkz6W3THEd0BQ==
Date: Mon, 07 Apr 2025 08:52:41 +0200
Subject: [PATCH v2 18/32] tools/nolibc: add tolower() and toupper()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-18-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=2208;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=k1JKwXo2zjXkowh2Iz1iHtu5+LVsdl8EjpnFP/4zQps=;
 b=iiaXByHJ8N+nZTuC3Z0NcMB0cA7uBZDkwQun4LszzuFnFezONYgfGs1d0SpFJUgbhDHQ5Z5SE
 7ys+o2HGSo7CXIy3UkC32LpTM7PIC3RC22QlDaXrJj+C5F/tvobKVQG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The kselftest harness uses these functions.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/string.h                | 17 +++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index ba84ab700e3001a7d105e1c9e40c01bf45db9d8c..f0d335f0e467ec870066811289dfd11e46e60a92 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -289,6 +289,23 @@ char *strrchr(const char *s, int c)
 	return (char *)ret;
 }
 
+static __attribute__((unused))
+int tolower(int c)
+{
+	if (c >= 'A' && c <= 'Z')
+		return c - 'A' + 'a';
+	return c;
+}
+
+static __attribute__((unused))
+int toupper(int c)
+{
+	if (c >= 'a' && c <= 'z')
+		return c - 'a' + 'A';
+	return c;
+}
+
+
 /* make sure to include all global symbols */
 #include "nolibc.h"
 
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index ccf865e80eb715488f4ee5d623b7a02d9dd8abec..70d418b87f7731572b85d64a8128c62d01df6b2b 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -40,6 +40,7 @@
 #include <stdint.h>
 #include <unistd.h>
 #include <limits.h>
+#include <ctype.h>
 #endif
 #endif
 
@@ -1281,6 +1282,10 @@ int run_stdlib(int min, int max)
 		CASE_TEST(strerror_EINVAL);         EXPECT_STREQ(is_nolibc, strerror(EINVAL), "errno=22"); break;
 		CASE_TEST(strerror_int_max);        EXPECT_STREQ(is_nolibc, strerror(INT_MAX), "errno=2147483647"); break;
 		CASE_TEST(strerror_int_min);        EXPECT_STREQ(is_nolibc, strerror(INT_MIN), "errno=-2147483648"); break;
+		CASE_TEST(tolower);                 EXPECT_EQ(1, tolower('A'), 'a'); break;
+		CASE_TEST(tolower_noop);            EXPECT_EQ(1, tolower('a'), 'a'); break;
+		CASE_TEST(toupper);                 EXPECT_EQ(1, toupper('a'), 'A'); break;
+		CASE_TEST(toupper_noop);            EXPECT_EQ(1, toupper('A'), 'A'); break;
 
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.49.0


