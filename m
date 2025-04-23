Return-Path: <linux-kselftest+bounces-31410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AA4A98F12
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DF947A4A4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E36289367;
	Wed, 23 Apr 2025 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0eqsa60k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yesxX99x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DCD285412;
	Wed, 23 Apr 2025 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420505; cv=none; b=MrMRuHmOGjvYOiSg59v0z1UE6EmaZZbLBr0krXJxrfR1rcu4FHBHbgFx59sgPGhiu3DSnh0LhKuE/JeY9ZxtdZlh0smAXlF/Tz4zDg3iQxydudVJ3mJLxC02NcDVaeilfMfJpxEMs1wPM5hfPGm1v29hbxeWxnR/04WGpzVfxZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420505; c=relaxed/simple;
	bh=QfQ9GtmoHqSeMw2lyf9jJI9CMPdDtCVSWd27rKlz+Xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RY2Lf2vPnOoqAP75RBUcUubuuvFvrH78351C91pbM7UyGBbrYXAer1FhdcwiFscaRHv6M71TN4Z7N2bucPogiIwsLYWLTqfE+0MxdgVcnybSpF2dHAAPdn23G+j/3bj8tmZXxpJeIRQ4DuiqCSFNxnFfXSexQPcp/IkBXxr1veI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0eqsa60k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yesxX99x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745420502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8oVfZJdfrHYqPrR5e8gdRZt2wr7Trjz1vMDOcsGB5A=;
	b=0eqsa60ksROqE0A9zwtTZhW30qJ0E/zcXur12kRm+ZE6smO2TufA6hkwzjeJIOdRCAF3qO
	S5AFgOFmxuxIRPMEmz2h+LQvC1nPIeSVyT94310ywK9qf223sIsfs9aDS0jIy5iMxTgxf0
	PVL5OEfZ9YmeGF8qEv0fCQFarv5rAjFmoXDWuGqyB5blVtVCw6HQQqFoam/wJ5jq3ybHoH
	BH4mhS3EyEbkPQTl3gF8hTXrEzP+08OV4cJWhGJfLS5QfxSWsU8o23TZWfJCrTJdmupQUx
	ahZChMSbIN4TmF21qTf3bomRJeytdFy82o2fooUU5fCkx6OeNInUIvd5T990tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745420502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8oVfZJdfrHYqPrR5e8gdRZt2wr7Trjz1vMDOcsGB5A=;
	b=yesxX99xUgTUaOxIuEuhNzR192JpkaMNkMAUoXaK2fkbsi5D7PxSfVgCJOTRJRD7HKNqAQ
	q+ZnftM/VjXwZgCQ==
Date: Wed, 23 Apr 2025 17:01:36 +0200
Subject: [PATCH 06/15] tools/nolibc: add abs() and friends
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-nolibc-misc-v1-6-a925bf40297b@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
In-Reply-To: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745420497; l=3810;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=QfQ9GtmoHqSeMw2lyf9jJI9CMPdDtCVSWd27rKlz+Xo=;
 b=MRZljW58twBXWkoNS/TKUojIU7T/JIsIXFCxZ+jtRg7m9xSTcGEKdxuWdMjsYmux4OZwwmlmI
 IB6Qlx6iFDCCGgU5MObdpwaa7QI/IhYrWEfnRVetj+yp2AX9xgftjxu
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/math.h                  | 31 ++++++++++++++++++++++++++++
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/stdlib.h                | 18 ++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  2 ++
 5 files changed, 53 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index b22ff1e268b2e4bd788e974d6d8f2e1ef96dfc5f..3a82e036a2c1762da5c3916ff9f4e158fb6106ff 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -35,6 +35,7 @@ all_files := \
 		fcntl.h \
 		getopt.h \
 		limits.h \
+		math.h \
 		nolibc.h \
 		signal.h \
 		stackprotector.h \
diff --git a/tools/include/nolibc/math.h b/tools/include/nolibc/math.h
new file mode 100644
index 0000000000000000000000000000000000000000..4906d3eb7c1aed0c402d3ab39526dd1c93b5df2a
--- /dev/null
+++ b/tools/include/nolibc/math.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * math definitions for NOLIBC
+ * Copyright (C) 2025 Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ */
+
+#ifndef _NOLIBC_SYS_MATH_H
+#define _NOLIBC_SYS_MATH_H
+
+static __inline__
+double fabs(double x)
+{
+	return x >= 0 ? x : -x;
+}
+
+static __inline__
+float fabsf(float x)
+{
+	return x >= 0 ? x : -x;
+}
+
+static __inline__
+long double fabsl(long double x)
+{
+	return x >= 0 ? x : -x;
+}
+
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
+#endif /* _NOLIBC_SYS_MATH_H */
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 3f329feb379c4c808d2e56fbb2b7a6c4b08a7c0d..2207f3d3c5cf92b96150149050f0bde0ed7e7147 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -115,6 +115,7 @@
 #include "dirent.h"
 #include "fcntl.h"
 #include "getopt.h"
+#include "math.h"
 
 /* Used by programs to avoid std includes */
 #define NOLIBC
diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 69cf1d4418f1c1f59192aee40ea3a5b684d2709a..c8c44859aee20e2b9eb55ddae488f1f70b710fbb 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -29,6 +29,24 @@ static __attribute__((unused)) char itoa_buffer[21];
  * As much as possible, please keep functions alphabetically sorted.
  */
 
+static __inline__
+int abs(int j)
+{
+	return j >= 0 ? j : -j;
+}
+
+static __inline__
+long labs(long j)
+{
+	return j >= 0 ? j : -j;
+}
+
+static __inline__
+long long llabs(long long j)
+{
+	return j >= 0 ? j : -j;
+}
+
 /* must be exported, as it's used by libgcc for various divide functions */
 void abort(void);
 __attribute__((weak,unused,noreturn,section(".text.nolibc_abort")))
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 95d08e9ccf5b3be924548100e9621cd47f39e8c2..b6724c314766b0cf34d7cae5cac28a9102ebe66e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1315,6 +1315,8 @@ int run_stdlib(int min, int max)
 		CASE_TEST(tolower_noop);            EXPECT_EQ(1, tolower('a'), 'a'); break;
 		CASE_TEST(toupper);                 EXPECT_EQ(1, toupper('a'), 'A'); break;
 		CASE_TEST(toupper_noop);            EXPECT_EQ(1, toupper('A'), 'A'); break;
+		CASE_TEST(abs);                     EXPECT_EQ(1, abs(-10), 10); break;
+		CASE_TEST(abs_noop);                EXPECT_EQ(1, abs(10), 10); break;
 
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.49.0


