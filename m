Return-Path: <linux-kselftest+bounces-30555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 931D7A85759
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3D21BC0C56
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1458C29DB94;
	Fri, 11 Apr 2025 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oO0RO+BF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="riEYAA/h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F2829B204;
	Fri, 11 Apr 2025 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362118; cv=none; b=oJoDzuVBiYzMK8cM6vtNIHZon6PRjUUpMk2PqKxQW3iN4iPf3g1qrt62Pdz8v5BcfiF1h3N+QryxRF7pfSd+cVrspDNBc8ZbVC5KJYoz7rgUQpsBhRlFnUjwoyUg0blFi+1Cu0xf6+i847Z4nimSx03oWoYLh+N/2vXlbkX26Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362118; c=relaxed/simple;
	bh=k1JKwXo2zjXkowh2Iz1iHtu5+LVsdl8EjpnFP/4zQps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ehi6dwmUlivZOn6A20nB3Fuw1/qeuZIIFPSrOLJUGGyccfyIPqRqM0GDJJ2dPBxX9CMjWmSzd4miCMi93X/f0J7Bx8UlaxUBBgnvW3W2TDPcm+/5v6O+MxTsuAk+l0rO9E47rUQpEBfRxw5ulYXPXad+tvDZVyiIC8wNnrj22ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oO0RO+BF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=riEYAA/h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sSOX1xpNeJxiyfhOoTmnjm0bIp+e5sn96YzgFsrPl2s=;
	b=oO0RO+BFSarEgfwaY/61MFQYqArzezQOHV3s2scldE79gZleWoKHhBuBfy+ajplS40ZrJU
	fAcCSvEeA9+fgnM4BoYfDAn0qWIQ3SHWr42jv2GdgLvDiPz9HOd0KfWnB67+i71cen+af6
	mKoFTxgjSWaE2158mETc1E5a51nB99gFxyVpXgX+qivnVBy0HhKbZB8NBYFHwjp1OAz99z
	cqyUM3oFLoxVLkQDOG4dEwGOYXc0HAtBe6d5ZQInI5IIGOyiQPhUraPc1+5qcCpMoe4182
	JNOnfn62J+kN/5Jfy/0s3MjdeIs537gzTcGlHohjF1RkPFjjUnhMYK8apokG5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sSOX1xpNeJxiyfhOoTmnjm0bIp+e5sn96YzgFsrPl2s=;
	b=riEYAA/hHOZnycrkYvchP7HY9aJi3OfhnbMvMLof1erTZOsmoVzJPIzHMatTzVnplIjlsX
	xIoeKufHwpxIkKBg==
Date: Fri, 11 Apr 2025 11:00:42 +0200
Subject: [PATCH v3 18/32] tools/nolibc: add tolower() and toupper()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-18-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=2208;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=k1JKwXo2zjXkowh2Iz1iHtu5+LVsdl8EjpnFP/4zQps=;
 b=HW6uNre6Z7SZ/h96/FqB1eblGw0acCRiD8C7T13Nl9iYLQjpMXq6KIn/6zygBLkIJ8o05jU+u
 J7vR9xrghj5DvZPKMyh1el4XpAR1RBF7LqN+a+1w2u7bQheJnzmQvvy
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


