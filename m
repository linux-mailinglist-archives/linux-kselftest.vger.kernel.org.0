Return-Path: <linux-kselftest+bounces-28172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985E6A4D481
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E76F3B0718
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8151FE47A;
	Tue,  4 Mar 2025 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O6Zm1zY6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z4LrsfWU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0E1F75A6;
	Tue,  4 Mar 2025 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072285; cv=none; b=CbJxJGJfPxPdiQ/N6rHB2AI2TeAN4aVMKSWRqNMOlMoIqMAP4A+9CM49eNXSVvukXJCIRJf4UUHdrI6lRahmis/aHl7z3EkRSTtDqsdtjXZIQrT+FHQkoZHdz4NdjWJXFvfQDClNbIobdozxnYvumeWs2IK0wd60sqzSyAv2Hog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072285; c=relaxed/simple;
	bh=UNGJO7yXadKLjRIIE8kbtzb+KQjgQekHUq7TFuDp7Ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NmqKbdsOO4hALuMz0ApAZZA+qz6H32k2pA/nPNzDBZ8l4LEu5h/vdKhY+SziH22ZHd7mUdsS+UwNjc5s9fQYPpr6XBo1EQAgvIADXtjDts46J9n1qO6ec9OYz8HG79gQDVP5gg3R3EVgOZ4VZMZJPtZ5N6xgPt/uaQJM2BGf060=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O6Zm1zY6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z4LrsfWU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHu1593CA9HkSs2rxw7I2z7kblLRcFAvsElqTkbmuQ0=;
	b=O6Zm1zY6srVgI9uiwBUsVWW2O5OspkS5YNu2rn1eCj7VEXOyrF7XKMuLaRktlAqqN1kibP
	VC8pWeqNMjn3ePtPupytkOhl+B00rz7k3hP8qUY4k6GE0d4xjOX8mdER98wniXLAX9c/va
	ALfTjjKtd5hKUJjrFJhBrBh5niS+U/tQb0Jy22yrB+x78hIpiJnUb/lxBe/VyKybAXUrpP
	0AsqKHYou+2HrbyrFz6Du/ma9LvCnUKCdftdew5zxVnSQqHlpKUEkVfhiEIu/1FJWZIdrf
	X+kuN6PebF5H3Dz1mFpubBv6NCDJWoCpsPHsSZrlM2CHu9HXE0NMrJoKfUNauQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHu1593CA9HkSs2rxw7I2z7kblLRcFAvsElqTkbmuQ0=;
	b=z4LrsfWUdxw2cX3cEVSpPpyqy1BxzI8kxzyf9grr0LJISPamcdTy2RWBdkVWiAE1c+RhJT
	XOoDKTsmNa/TkyBw==
Date: Tue, 04 Mar 2025 08:10:54 +0100
Subject: [PATCH 24/32] tools/nolibc: add getopt()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-24-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=3954;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=UNGJO7yXadKLjRIIE8kbtzb+KQjgQekHUq7TFuDp7Ts=;
 b=FzvluaKa0nqgq0yQ+iTBN1Dsef4WpOfaYik+/RV931BSG/nXeIsK7gVn84B6EoiMOIQeBBTZ+
 mIMkzSSP3HCAb8DL3wgPNNasu+vSV8+0N3aRU6zHTJSwX/WVtYkep5S
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Introduce a getopt() implementation based on the one from musl.
The only deviations are adaption to the kernel coding style and nolibc
infrastructure and removal of multi-byte support.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/Makefile |   1 +
 tools/include/nolibc/getopt.h | 105 ++++++++++++++++++++++++++++++++++++++++++
 tools/include/nolibc/nolibc.h |   1 +
 3 files changed, 107 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index dceec0e1a135119108d6f4dcb3d2ec57c002ffd3..821a716094549ff9ee2fbe006fb7b3066e5e418d 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -31,6 +31,7 @@ all_files := \
 		ctype.h \
 		dirent.h \
 		errno.h \
+		getopt.h \
 		nolibc.h \
 		signal.h \
 		stackprotector.h \
diff --git a/tools/include/nolibc/getopt.h b/tools/include/nolibc/getopt.h
new file mode 100644
index 0000000000000000000000000000000000000000..35aee582681b79e21bce8ddbf634ae9dfdef8f1d
--- /dev/null
+++ b/tools/include/nolibc/getopt.h
@@ -0,0 +1,105 @@
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
+__attribute__((weak,unused,section(".data.nolibc_getopt")))
+int optind = 1;
+__attribute__((weak,unused,section(".data.nolibc_getopt")))
+int opterr = 1;
+__attribute__((weak,unused,section(".data.nolibc_getopt")))
+int optopt;
+__attribute__((weak,unused,section(".data.nolibc_getopt")))
+int __optpos;
+
+static __inline__
+int getopt(int argc, char * const argv[], const char *optstring)
+{
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
index 05d92afedb7258f0e3c311bf6f12be68b25d6e9a..d4043051072928f43d4d73c0e509430087c66e94 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -106,6 +106,7 @@
 #include "time.h"
 #include "stackprotector.h"
 #include "dirent.h"
+#include "getopt.h"
 
 /* Used by programs to avoid std includes */
 #define NOLIBC

-- 
2.48.1


