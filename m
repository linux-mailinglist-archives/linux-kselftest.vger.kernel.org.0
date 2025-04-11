Return-Path: <linux-kselftest+bounces-30565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFAFA85777
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E08F1BC1325
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEC52C3772;
	Fri, 11 Apr 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SpZA0qVs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ABqpDU1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9117B2BE7BC;
	Fri, 11 Apr 2025 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362124; cv=none; b=ZCoRFedez/ttB5Mh+qMQdokm2BckKw9nwcmPWw0IHarDyZll9Uem8tIjvA/oCFIF1K1qLOXbTajU+e5ZYDHyrLo8LClb5Ix3TMs/0P3szckTDL1L2fWMVpg4QzLcQO2s19fO8T7vOTGX3VHziaUUqbGpbEGZ0oTH3rxf+gnEDco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362124; c=relaxed/simple;
	bh=tt5NS4cBLTbNoJ7EV6vHy54O54vj6AeymCsD10sDXy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVjCJxxeHDQknj7a1Lb/fv8BeQMKmR8bp9d6bThyA6LTHa0CGQQsUVn3arTtPTbubLLQXhfEPXUVij0rc9qtgEEMhldo/SY+04bOLU6Ja7KIyRoJNBFz96rnhAfc+b86i96I0bFc7K0K8qZQzjBjMwERmURv/9jLYHkceqTJZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SpZA0qVs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ABqpDU1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2u19rqjC1rYwxFvMglNkhCFpgxOoiJO9w3f9eDb1mvo=;
	b=SpZA0qVsVc+tdC57aUP6H2OR8ANOC7BHiiDNeX1Tl5Da78Z9XuwPe6eN3LLJgQ0hV5zxem
	wwCUvSF4AzbNXPf3Mo4bLFQYDwPLv/vvJjpMO+aT4GfLCYYXxorUFSUSLyj06OK8WZwBo1
	ri49tgHMSQum1Crf+x3JKB8y5g8r+yM8Onjw6/FqNleDCQ5sH4qFfb4a3u8RVkG/i7ZH3W
	6uiqL9UVLylC5wnXY49FScWLBS1CnyvlAOVP8yOqZxgm5awrv6zYg7k1RL0KJx37V7TgoH
	dI12dbZvxyJ6ZFAjDhF0ZDkTBuno08bW7Z463GXSiJRYHfb8nIUttV0C3WF/vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2u19rqjC1rYwxFvMglNkhCFpgxOoiJO9w3f9eDb1mvo=;
	b=0ABqpDU1nWxKU3Y5Nyv6sHApGMqyVJm+vTMBVDed7vwRNn4j749cZXG815kjg7dW6jDRuQ
	b/UjGzR6nriQ7LBg==
Date: Fri, 11 Apr 2025 11:00:48 +0200
Subject: [PATCH v3 24/32] tools/nolibc: add getopt()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-24-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=3808;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=tt5NS4cBLTbNoJ7EV6vHy54O54vj6AeymCsD10sDXy0=;
 b=HlntrhUVmalTrQtpJvqbO/+caW9Rxayx10g7RW6+Mxvd/P4xg69pgmub2g/PXSR4cVG92qWji
 yoNOTCn41P4D0bdV8Vdh/YWj3bsknWqInyy22V1mCqB9txwlBcwgRX4
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Introduce a getopt() implementation based on the one from musl.
The only deviations are adaption to the kernel coding style and nolibc
infrastructure and removal of multi-byte support.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/Makefile |   1 +
 tools/include/nolibc/getopt.h | 101 ++++++++++++++++++++++++++++++++++++++++++
 tools/include/nolibc/nolibc.h |   1 +
 3 files changed, 103 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index f9702877ac21ab5ad30df1740e40e67f477f3824..e47e1607bab82f1d91effc025c9257e8a451f047 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -31,6 +31,7 @@ all_files := \
 		ctype.h \
 		dirent.h \
 		errno.h \
+		getopt.h \
 		limits.h \
 		nolibc.h \
 		signal.h \
diff --git a/tools/include/nolibc/getopt.h b/tools/include/nolibc/getopt.h
new file mode 100644
index 0000000000000000000000000000000000000000..5fd06c9702e96e8c58a6b242f535bca09db69343
--- /dev/null
+++ b/tools/include/nolibc/getopt.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * getopt function definitions for NOLIBC, adapted from musl libc
+ * Copyright (C) 2005-2020 Rich Felker, et al.
+ * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
+ */
+
+#ifndef _NOLIBC_GETOPT_H
+#define _NOLIBC_GETOPT_H
+
+struct FILE;
+static struct FILE *const stderr;
+static int fprintf(struct FILE *stream, const char *fmt, ...);
+
+__attribute__((weak,unused,section(".data.nolibc_getopt")))
+char *optarg;
+
+__attribute__((weak,unused,section(".data.nolibc_getopt")))
+int optind = 1, opterr = 1, optopt;
+
+static __attribute__((unused))
+int getopt(int argc, char * const argv[], const char *optstring)
+{
+	static int __optpos;
+	int i;
+	char c, d;
+	char *optchar;
+
+	if (!optind) {
+		__optpos = 0;
+		optind = 1;
+	}
+
+	if (optind >= argc || !argv[optind])
+		return -1;
+
+	if (argv[optind][0] != '-') {
+		if (optstring[0] == '-') {
+			optarg = argv[optind++];
+			return 1;
+		}
+		return -1;
+	}
+
+	if (!argv[optind][1])
+		return -1;
+
+	if (argv[optind][1] == '-' && !argv[optind][2])
+		return optind++, -1;
+
+	if (!__optpos)
+		__optpos++;
+	c = argv[optind][__optpos];
+	optchar = argv[optind] + __optpos;
+	__optpos++;
+
+	if (!argv[optind][__optpos]) {
+		optind++;
+		__optpos = 0;
+	}
+
+	if (optstring[0] == '-' || optstring[0] == '+')
+		optstring++;
+
+	i = 0;
+	d = 0;
+	do {
+		d = optstring[i++];
+	} while (d && d != c);
+
+	if (d != c || c == ':') {
+		optopt = c;
+		if (optstring[0] != ':' && opterr)
+			fprintf(stderr, "%s: unrecognized option: %c\n", argv[0], *optchar);
+		return '?';
+	}
+	if (optstring[i] == ':') {
+		optarg = 0;
+		if (optstring[i + 1] != ':' || __optpos) {
+			optarg = argv[optind++];
+			if (__optpos)
+				optarg += __optpos;
+			__optpos = 0;
+		}
+		if (optind > argc) {
+			optopt = c;
+			if (optstring[0] == ':')
+				return ':';
+			if (opterr)
+				fprintf(stderr, "%s: option requires argument: %c\n",
+					argv[0], *optchar);
+			return '?';
+		}
+	}
+	return c;
+}
+
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
+#endif /* _NOLIBC_GETOPT_H */
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 70872401aca8d5aa37b12ee585193353f692576d..187490535d1359aff371e2981118e62bcc0c6948 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -105,6 +105,7 @@
 #include "time.h"
 #include "stackprotector.h"
 #include "dirent.h"
+#include "getopt.h"
 
 /* Used by programs to avoid std includes */
 #define NOLIBC

-- 
2.49.0


