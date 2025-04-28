Return-Path: <linux-kselftest+bounces-31773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D04A9F0FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0C4460CDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5100426E145;
	Mon, 28 Apr 2025 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iLh73l/r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CClS0+NJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C926B0A7;
	Mon, 28 Apr 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844016; cv=none; b=XtqIefnLft76DyGvYzKb8XR51dc1CWj+nWC9EIk3Kr+LmeBjuoIe/+tyRIZe24Wl0PxFEXPgU+Bek3iivbqBAECsXyQYr9RcZL3H+StWydk1NzQ8fJzlGmZWlVwvC0IOgqC58shN2vgH/IidAT3JwNolh7FHViO2yKiwIRbmK2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844016; c=relaxed/simple;
	bh=GgB68c8Kv1yFST4RZVyzlgzYluq4bR/jdOFo+kxIPbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxolQBMnBjVAUd4kPwQeST6SMwQuR3cYSLIMbQC8V9jvVasiwEE9FLXJWt6wRw90ZFdJqmRgVJuBkYnbgLTjcar587/6MWQdrAgPsOZpJJ3u1gIpcr21YRws6Z6poJj3LEsUqbhl6omU9OWEiUpnKUE/Sn7HTl4sCTCPYxJEZaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iLh73l/r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CClS0+NJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745844011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcSKazjeGyETBw+7Vy3nf4kOTNfP5Y5fqGj9lMJNEgg=;
	b=iLh73l/rQV8k6n55xL3tZmxMRsJikStmVx4dq7Z4j0ZPp4vF172Qkw5LTC50vjBqf0mSn+
	SQHpwrwnhm9UlU4FnuLDqG/Euj5/LPmCc5AR5rZ2zP7c9lmbnJ/hOOR7fChpNN5qZwuD0S
	jqyPzQLKKeSAVrg36gbfij2//SlTC2cftVAwGYjSJUA9Gy3UYeIk+n0BCGuMbUXo4I3cIR
	PzN5CYscMJyUZ9MKoX2xTJ3qpJVqTXuFMoccSjsBR1qeHocLQrAQ8qNG89MB0Aq16BA5Xj
	zIC08fzXw/t9JKYZXBK35VId1cl99JwBDvbYOMheGxCmDpn/BbhNgyDL51zDyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745844011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcSKazjeGyETBw+7Vy3nf4kOTNfP5Y5fqGj9lMJNEgg=;
	b=CClS0+NJB9oR9t6rUgQswE6jfggx963QcRa0vmpcfDGK7WlE80nG3og3WUd1bTjqHXE6xk
	r1ouu/eyrEFA2bCA==
Date: Mon, 28 Apr 2025 14:40:07 +0200
Subject: [PATCH v2 06/15] tools/nolibc: add abs() and friends
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-nolibc-misc-v2-6-3c043eeab06c@linutronix.de>
References: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
In-Reply-To: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745844007; l=3846;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=GgB68c8Kv1yFST4RZVyzlgzYluq4bR/jdOFo+kxIPbo=;
 b=k0R3n4y1NO3iWIMDM0YCMUXSPtuyqcq27cOTOXaF4ScxgTOIH6+okkzkOF2QLuhPJJwEp3D/n
 0I4eQO3ODq7AEYGh7uYVy97Id6FzPMm7VyNuC0NmORE91uQ31jXQCxd
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/Makefile                |  1 +
 tools/include/nolibc/math.h                  | 31 ++++++++++++++++++++++++++++
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/stdlib.h                | 18 ++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  2 ++
 5 files changed, 53 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 4bbe3b7fa2805f356d9a5cc1e4a8ee55b05af746..552e44f5a48211f81c68068b9b99c1dd6e44e9d8 100644
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
index 0000000000000000000000000000000000000000..9df823ddd41297436015333d66561f810f101d06
--- /dev/null
+++ b/tools/include/nolibc/math.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * math definitions for NOLIBC
+ * Copyright (C) 2025 Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ */
+
+/* make sure to include all global symbols */
+#include "nolibc.h"
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
index 4790298f985c2b0db91ec777140201b7ec869346..5fd99a480f821210212f08d814a4c09c2c804db8 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -32,6 +32,24 @@ static __attribute__((unused)) char itoa_buffer[21];
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
index df1cb3e62564f1fa78c55740f7c2403b8390168f..14a27bc6c83e4fda595b10dc29cf56b63904272a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1318,6 +1318,8 @@ int run_stdlib(int min, int max)
 		CASE_TEST(tolower_noop);            EXPECT_EQ(1, tolower('a'), 'a'); break;
 		CASE_TEST(toupper);                 EXPECT_EQ(1, toupper('a'), 'A'); break;
 		CASE_TEST(toupper_noop);            EXPECT_EQ(1, toupper('A'), 'A'); break;
+		CASE_TEST(abs);                     EXPECT_EQ(1, abs(-10), 10); break;
+		CASE_TEST(abs_noop);                EXPECT_EQ(1, abs(10), 10); break;
 
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.49.0


