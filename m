Return-Path: <linux-kselftest+bounces-31541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF93A9AC5C
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 13:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5415E7B2D8A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 11:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFA022489A;
	Thu, 24 Apr 2025 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c0DNCiLG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kbl3b5bH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C291C21FF5A;
	Thu, 24 Apr 2025 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495300; cv=none; b=NY0EsGCntMg0OUuU4k5OtGx8cDO1XBd9lhggY+LbEuQmihtYJNR3kVcqCittkbz/zmtOP7nbpJpo3xhY/yEfn76avX1Y91Ez1yQ+4PNWlqKFXbuPzNxu9+9WHxsFaBNgS3DlFlOGg23CddGpeeHaRqzvUjwnfaqlxltBYF/RaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495300; c=relaxed/simple;
	bh=VoE6OmAwofxkHiKLz+nGUa+9WokQvVG4ZP7QwcR4GxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BzPw98HHWnSiKuYmmwXZZceXJWJHg9FVgihO8Q0+LppO57/qi4Hn+ikp1SS88rbK+wmOdrOPIEQDwcl3cSxoD1tdY7mpoOVcOQc5lvUVKzI01y17FyIIAlr5rA3YZZ2h0EXpngJIwGU69h34RMytNFWc0GNptPLTCowkvht37aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c0DNCiLG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kbl3b5bH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745495296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yn58Vv/VpIlhtWOr6OS0BMTd6rBqTRqVk+MHr1fF1HY=;
	b=c0DNCiLG2Edrc2Fd2+1g87S/vznCz1Op/gVrqwz9VWUJAPgHTMbnXApGR1wjOmgQctrEb2
	+Sv0IWpDc0mT0kVybtsdXQ+4GiNiY3W4r52HEuIB5omvJsitCuynEpipHlqtvtg8yh8joT
	FqJBgT9tG9F/L+qrsEL0vwN+FfmXhMtpgSMnY/DP2Yc9sDSLTBCnI6GYxZse0J5d53HCNG
	ZPGeaBvVnMOkrcH09pF3bAuw8mxy+umszAiQgHIhUR5pEOlLSeiuWQSjqWCnTgz+YII0sI
	fi6xLMmt70kV5s21dkdlmMnzoPUWBEEAPlwirqsEipRE3L3v393N2CHgNn0U0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745495296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yn58Vv/VpIlhtWOr6OS0BMTd6rBqTRqVk+MHr1fF1HY=;
	b=kbl3b5bHky0ZpyGsYz5KrXBgwUuF/EGzlXC9+NDxfcwPuKU1qCI3pUyOguyeumjgNw4Jl0
	AItN/uYw0jUnpZAA==
Date: Thu, 24 Apr 2025 13:48:12 +0200
Subject: [PATCH 2/3] tools/nolibc: include nolibc.h early from all header
 files
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250424-nolibc-header-check-v1-2-011576b6ed6f@linutronix.de>
References: <20250424-nolibc-header-check-v1-0-011576b6ed6f@linutronix.de>
In-Reply-To: <20250424-nolibc-header-check-v1-0-011576b6ed6f@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745495292; l=15357;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=VoE6OmAwofxkHiKLz+nGUa+9WokQvVG4ZP7QwcR4GxM=;
 b=93IFqJ6pPP7/a7bkRI6L/cSkrVVDGtgoGvxe6KILlhLbvKZpTsK8P7/NIXub/B8jQ0btZjDWq
 c3Uy1+OWgclDMLpgTNV8Su9PB2rjKwpIvwi/vFZlyoPjXVw+O7LvZsO
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Inclusion of any nolibc header file should also bring all other headers.
On the other hand it should also be possible to include any nolibc header
files
in any order.

Currently this is implemented by including the catch-all nolibc.h after the
headers own definitions.
This is problematic if one nolibc header depends on another one.
The first header has to include the other one before defining any symbols.
That in turn will include the rest of nolibc while the current header has
not defined anything yet. If any other part of nolibc depends on
definitions from the current header, errors are encountered.
This is already the case today. Effectively nolibc can only be included in
the order of nolibc.h.

Restructure the way "nolibc.h" is included.
Move it to the beginning of the header files and before the include guards.
Now any header will behave exactly like "nolibc.h" while the include
guards prevent any duplicate definitions.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/ctype.h       | 6 +++---
 tools/include/nolibc/dirent.h      | 6 +++---
 tools/include/nolibc/elf.h         | 6 +++---
 tools/include/nolibc/errno.h       | 6 +++---
 tools/include/nolibc/fcntl.h       | 6 +++---
 tools/include/nolibc/getopt.h      | 6 +++---
 tools/include/nolibc/signal.h      | 6 +++---
 tools/include/nolibc/stdio.h       | 6 +++---
 tools/include/nolibc/stdlib.h      | 6 +++---
 tools/include/nolibc/string.h      | 7 +++----
 tools/include/nolibc/sys.h         | 6 +++---
 tools/include/nolibc/sys/auxv.h    | 6 +++---
 tools/include/nolibc/sys/mman.h    | 6 +++---
 tools/include/nolibc/sys/stat.h    | 7 +++----
 tools/include/nolibc/sys/syscall.h | 6 +++---
 tools/include/nolibc/sys/time.h    | 6 +++---
 tools/include/nolibc/sys/wait.h    | 7 +++----
 tools/include/nolibc/time.h        | 6 +++---
 tools/include/nolibc/types.h       | 6 +++---
 tools/include/nolibc/unistd.h      | 6 +++---
 20 files changed, 60 insertions(+), 63 deletions(-)

diff --git a/tools/include/nolibc/ctype.h b/tools/include/nolibc/ctype.h
index 6f90706d06442d87e262cf36c00ce7fe61972dbf..470fdf34394a5045681c76c9750c467cd944bb5e 100644
--- a/tools/include/nolibc/ctype.h
+++ b/tools/include/nolibc/ctype.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
  */
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #ifndef _NOLIBC_CTYPE_H
 #define _NOLIBC_CTYPE_H
 
@@ -96,7 +99,4 @@ int ispunct(int c)
 	return isgraph(c) && !isalnum(c);
 }
 
-/* make sure to include all global symbols */
-#include "nolibc.h"
-
 #endif /* _NOLIBC_CTYPE_H */
diff --git a/tools/include/nolibc/dirent.h b/tools/include/nolibc/dirent.h
index 6c60ec4ba27baefc1fc59b607338909e55c50fb6..758b95c48e7a4c9779625160f1a60a5641513ddf 100644
--- a/tools/include/nolibc/dirent.h
+++ b/tools/include/nolibc/dirent.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
  */
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #ifndef _NOLIBC_DIRENT_H
 #define _NOLIBC_DIRENT_H
 
@@ -94,7 +97,4 @@ int readdir_r(DIR *dirp, struct dirent *entry, struct dirent **result)
 	return 0;
 }
 
-/* make sure to include all global symbols */
-#include "nolibc.h"
-
 #endif /* _NOLIBC_DIRENT_H */
diff --git a/tools/include/nolibc/elf.h b/tools/include/nolibc/elf.h
index beb0b3a87569a3037055c8fe7e9b086a26ca7d13..3e2c5228bf3d99322754ac5ba8824a0e25624d55 100644
--- a/tools/include/nolibc/elf.h
+++ b/tools/include/nolibc/elf.h
@@ -4,12 +4,12 @@
  * Copyright (C) 2025 Thomas Weißschuh <thomas.weissschuh@linutronix.de>
  */
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #ifndef _NOLIBC_SYS_ELF_H
 #define _NOLIBC_SYS_ELF_H
 
 #include <linux/elf.h>
 
-/* make sure to include all global symbols */
-#include "nolibc.h"
-
 #endif /* _NOLIBC_SYS_ELF_H */
diff --git a/tools/include/nolibc/errno.h b/tools/include/nolibc/errno.h
index 1d8d8033e8ff766ee4b3cf7efdb741d4208db04e..08a33c40ec0c18c70e32dda04a835745dad8fb30 100644
--- a/tools/include/nolibc/errno.h
+++ b/tools/include/nolibc/errno.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #ifndef _NOLIBC_ERRNO_H
 #define _NOLIBC_ERRNO_H
 
@@ -22,7 +25,4 @@ int errno __attribute__((weak));
  */
 #define MAX_ERRNO 4095
 
-/* make sure to include all global symbols */
-#include "nolibc.h"
-
 #endif /* _NOLIBC_ERRNO_H */
diff --git a/tools/include/nolibc/fcntl.h b/tools/include/nolibc/fcntl.h
index 5feb08ad54a7d943b8100eac21f4058310efea91..bff2e542f20f9dbee34b88a51b08ba2dfcf26464 100644
--- a/tools/include/nolibc/fcntl.h
+++ b/tools/include/nolibc/fcntl.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
  */
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #ifndef _NOLIBC_FCNTL_H
 #define _NOLIBC_FCNTL_H
 
@@ -63,7 +66,4 @@ int open(const char *path, int flags, ...)
 	return __sysret(sys_open(path, flags, mode));
 }
 
-/* make sure to include all global symbols */
-#include "nolibc.h"
-
 #endif /* _NOLIBC_FCNTL_H */
diff --git a/tools/include/nolibc/getopt.h b/tools/include/nolibc/getopt.h
index 5fd06c9702e96e8c58a6b242f535bca09db69343..217abb95264b286a9f6bcd500779575a9a508352 100644
--- a/tools/include/nolibc/getopt.h
+++ b/tools/include/nolibc/getopt.h
@@ -5,6 +5,9 @@
  * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
  */
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #ifndef _NOLIBC_GETOPT_H
 #define _NOLIBC_GETOPT_H
 
@@ -95,7 +98,4 @@ int getopt(int argc, char * const argv[], const char *optstring)
 	return c;
 }
 
-/* make sure to include all global symbols */
-#include "nolibc.h"
-
 #endif /* _NOLIBC_GETOPT_H */
diff --git a/tools/include/nolibc/signal.h b/tools/include/nolibc/signal.h
index cdcc5904c51e93c524f9afc7d49a17feda3d9af2..ac13e53ac31d7c0fb1f58e421417104caa32f765 100644
--- a/tools/include/nolibc/signal.h
+++ b/tools/include/nolibc/signal.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #ifndef _NOLIBC_SIGNAL_H
 #define _NOLIBC_SIGNAL_H
 
@@ -20,7 +23,4 @@ int raise(int signal)
 	return sys_kill(sys_getpid(), signal);
 }
 
-/* make sure to include all global symbols */
-#include "nolibc.h"
-
 #endif /* _NOLIBC_SIGNAL_H */
diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index fb0417477759ee6c9663e84807c1d1067e735dec..8fa98abab2127c2cd175201d2f50d71b78d03559 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
  */
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #ifndef _NOLIBC_STDIO_H
 #define _NOLIBC_STDIO_H
 
@@ -598,7 +601,4 @@ const char *strerror(int errno)
 	return buf;
 }
 
-/* make sure to include all global symbols */
-#include "nolibc.h"
-
 #endif /* _NOLIBC_STDIO_H */
diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 69cf1d4418f1c1f59192aee40ea3a5b684d2709a..4790298f985c2b0db91ec777140201b7ec869346 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
  */
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #ifndef _NOLIBC_STDLIB_H
 #define _NOLIBC_STDLIB_H
 
@@ -522,7 +525,4 @@ uintmax_t strtoumax(const char *nptr, char **endptr, int base)
 	return __strtox(nptr, endptr, base, 0, UINTMAX_MAX);
 }
 
-/* make sure to include all global symbols */
-#include "nolibc.h"
-
 #endif /* _NOLIBC_STDLIB_H */
diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index f0d335f0e467ec870066811289dfd11e46e60a92..febfd69789666e2445b82423a5f4df5e18a1c774 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
  */
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #ifndef _NOLIBC_STRING_H
 #define _NOLIBC_STRING_H
 
@@ -305,8 +308,4 @@ int toupper(int c)
 	return c;
 }
 
-
-/* make sure to include all global symbols */
-#include "nolibc.h"
-
 #endif /* _NOLIBC_STRING_H */
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index bc47007f04429e5b1ff7d57f21e566fa235f6512..68e60e6742114a5422c8afef56a67415ed652c2f 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
  */
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #ifndef _NOLIBC_SYS_H
 #define _NOLIBC_SYS_H
 
@@ -1119,7 +1122,4 @@ int memfd_create(const char *name, unsigned int flags)
 	return __sysret(sys_memfd_create(name, flags));
 }
 
-/* make sure to include all global symbols */
-#include "nolibc.h"
-
 #endif /* _NOLIBC_SYS_H */
diff --git a/tools/include/nolibc/sys/auxv.h b/tools/include/nolibc/sys/auxv.h
index 04c2b9cbe51a262025bbbc7c74a0640c71529eab..c52463d6c18d7a38f40344c1817bef3a4a121e7a 100644
--- a/tools/include/nolibc/sys/auxv.h
+++ b/tools/include/nolibc/sys/auxv.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
  */
 
+/* make sure to include all global symbols */
+#include "../nolibc.h"
+
 #ifndef _NOLIBC_SYS_AUXV_H
 #define _NOLIBC_SYS_AUXV_H
 
@@ -35,7 +38,4 @@ unsigned long getauxval(unsigned long type)
 	return ret;
 }
 
-/* make sure to include all global symbols */
-#include "../nolibc.h"
-
 #endif /* _NOLIBC_SYS_AUXV_H */
diff --git a/tools/include/nolibc/sys/mman.h b/tools/include/nolibc/sys/mman.h
index ad9d06b6b7919ec76a0652266158366cf639a77a..41c7bf45e427b96efec949364890e9c2b9c226a5 100644
--- a/tools/include/nolibc/sys/mman.h
+++ b/tools/include/nolibc/sys/mman.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
  */
 
+/* make sure to include all global symbols */
+#include "../nolibc.h"
+
 #ifndef _NOLIBC_SYS_MMAN_H
 #define _NOLIBC_SYS_MMAN_H
 
@@ -57,7 +60,4 @@ int munmap(void *addr, size_t length)
 	return __sysret(sys_munmap(addr, length));
 }
 
-/* make sure to include all global symbols */
-#include "../nolibc.h"
-
 #endif /* _NOLIBC_SYS_MMAN_H */
diff --git a/tools/include/nolibc/sys/stat.h b/tools/include/nolibc/sys/stat.h
index 0eaf5496ce233a4d8b5a239eef5ecefe05a39dd6..987c8bb52502f1f758005b0afdfb2e39fc8ea1c6 100644
--- a/tools/include/nolibc/sys/stat.h
+++ b/tools/include/nolibc/sys/stat.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
  */
 
+/* make sure to include all global symbols */
+#include "../nolibc.h"
+
 #ifndef _NOLIBC_SYS_STAT_H
 #define _NOLIBC_SYS_STAT_H
 
@@ -67,8 +70,4 @@ int stat(const char *path, struct stat *buf)
 	return 0;
 }
 
-
-/* make sure to include all global symbols */
-#include "../nolibc.h"
-
 #endif /* _NOLIBC_SYS_STAT_H */
diff --git a/tools/include/nolibc/sys/syscall.h b/tools/include/nolibc/sys/syscall.h
index 59efdec8fd1c8cd9f282d1e9ea52431003342a7f..4bf97f1386a03d6db33ebf1f8de116ba72a5e608 100644
--- a/tools/include/nolibc/sys/syscall.h
+++ b/tools/include/nolibc/sys/syscall.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
  */
 
+/* make sure to include all global symbols */
+#include "../nolibc.h"
+
 #ifndef _NOLIBC_SYS_SYSCALL_H
 #define _NOLIBC_SYS_SYSCALL_H
 
@@ -13,7 +16,4 @@
 #define _syscall_n(N, ...) _syscall(N, __VA_ARGS__)
 #define syscall(...) _syscall_n(_syscall_narg(__VA_ARGS__), ##__VA_ARGS__)
 
-/* make sure to include all global symbols */
-#include "../nolibc.h"
-
 #endif /* _NOLIBC_SYS_SYSCALL_H */
diff --git a/tools/include/nolibc/sys/time.h b/tools/include/nolibc/sys/time.h
index 1d326c05ee627b6bdb7d2777cbb11eea385f2407..785961c52fa3b6606ee30c19a4a1c11e86ccacc0 100644
--- a/tools/include/nolibc/sys/time.h
+++ b/tools/include/nolibc/sys/time.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
  */
 
+/* make sure to include all global symbols */
+#include "../nolibc.h"
+
 #ifndef _NOLIBC_SYS_TIME_H
 #define _NOLIBC_SYS_TIME_H
 
@@ -30,7 +33,4 @@ int gettimeofday(struct timeval *tv, struct timezone *tz)
 	return __sysret(sys_gettimeofday(tv, tz));
 }
 
-/* make sure to include all global symbols */
-#include "../nolibc.h"
-
 #endif /* _NOLIBC_SYS_TIME_H */
diff --git a/tools/include/nolibc/sys/wait.h b/tools/include/nolibc/sys/wait.h
index 9a68e6a6b1df8f938225007eb0de0574257ccf00..f27be86ad5e480f3817b4500ac42fae445cdfc27 100644
--- a/tools/include/nolibc/sys/wait.h
+++ b/tools/include/nolibc/sys/wait.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
  */
 
+/* make sure to include all global symbols */
+#include "../nolibc.h"
+
 #ifndef _NOLIBC_SYS_WAIT_H
 #define _NOLIBC_SYS_WAIT_H
 
@@ -110,8 +113,4 @@ pid_t waitpid(pid_t pid, int *status, int options)
 	return info.si_pid;
 }
 
-
-/* make sure to include all global symbols */
-#include "../nolibc.h"
-
 #endif /* _NOLIBC_SYS_WAIT_H */
diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index 84655361b9ad2ce141f9af2759f2b128ae8a83a3..9502f9aaf62110ec8ee113fcf08dd47de40e924c 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #ifndef _NOLIBC_TIME_H
 #define _NOLIBC_TIME_H
 
@@ -25,7 +28,4 @@ time_t time(time_t *tptr)
 	return tv.tv_sec;
 }
 
-/* make sure to include all global symbols */
-#include "nolibc.h"
-
 #endif /* _NOLIBC_TIME_H */
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 32d0929c633bbae29263375c461a0c82baf7f869..fe97953d16572db3e4c18cdc8921c6a991d64f94 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
  */
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #ifndef _NOLIBC_TYPES_H
 #define _NOLIBC_TYPES_H
 
@@ -214,7 +217,4 @@ struct stat {
 })
 #endif
 
-/* make sure to include all global symbols */
-#include "nolibc.h"
-
 #endif /* _NOLIBC_TYPES_H */
diff --git a/tools/include/nolibc/unistd.h b/tools/include/nolibc/unistd.h
index ac7d53d986cd11ac84dd0a17e5a7055c779b2b10..ed253305fdbafd040ca5820207d8c53c6ea9f9fc 100644
--- a/tools/include/nolibc/unistd.h
+++ b/tools/include/nolibc/unistd.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2017-2022 Willy Tarreau <w@1wt.eu>
  */
 
+/* make sure to include all global symbols */
+#include "nolibc.h"
+
 #ifndef _NOLIBC_UNISTD_H
 #define _NOLIBC_UNISTD_H
 
@@ -56,7 +59,4 @@ int tcsetpgrp(int fd, pid_t pid)
 	return ioctl(fd, TIOCSPGRP, &pid);
 }
 
-/* make sure to include all global symbols */
-#include "nolibc.h"
-
 #endif /* _NOLIBC_UNISTD_H */

-- 
2.49.0


