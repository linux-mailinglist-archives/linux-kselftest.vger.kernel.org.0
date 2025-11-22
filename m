Return-Path: <linux-kselftest+bounces-46326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0A8C7D45B
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 18:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A453AA801
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 17:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786E32FC013;
	Sat, 22 Nov 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="uEF4JVMW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E292E7BAA;
	Sat, 22 Nov 2025 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830798; cv=none; b=QW33S+yidYQ0GflNQLXnNBSU3QY2DKLPY/1bfIk8QOrz5Ikt890zULDbOzPOJ/ZfNzEc7W6aqzTVIjsFoGT1sq/7TQKiVso+dSgkaRS3EBrTE+4XUemb6FM0Aej0AGDKisKGOIM0hri5bD+1Sbol5BpQb9is7iKtychgqmXPpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830798; c=relaxed/simple;
	bh=bPkH6voRfrAwZjOsEEP1623h6Mf0N8JgvChGd5XT+5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G8wPZ9lxh+3hkpzo2HUHf4+iAL1C49YeMWrfKAndd53nR+n2zGpXJA1i+Y/rWt+9dZ6ZVZtuoF28+6vVcj+lQfeoamJVobixOXL9Y8EN8xPC54Tfb6nnErPQ/IoVyPGt9QtNWqldK+pP2+KrUhLTFzlpIYKXJ7J61UzORDoGiO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=uEF4JVMW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763830791;
	bh=bPkH6voRfrAwZjOsEEP1623h6Mf0N8JgvChGd5XT+5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uEF4JVMWSQBktcIXS9pvlp1cfSi3CiRJR5mWIFfA0pfJLnfbBRRziPD5BTnQNyJEl
	 BLYjZPtUq+fqP8Sins4Qx937wK/1/vE/X811lLTAEXEPhrQ8RYZVfG8jibh4CEsH+1
	 zhJLXmDK6bk9F7nEfnEtYmDUqHG20KTsbhbESN3g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 22 Nov 2025 17:59:14 +0100
Subject: [PATCH v2 08/13] tools/nolibc: use custom structs timespec and
 timeval
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-nolibc-uapi-types-v2-8-b814a43654f5@weissschuh.net>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
In-Reply-To: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763830790; l=1759;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=bPkH6voRfrAwZjOsEEP1623h6Mf0N8JgvChGd5XT+5c=;
 b=rnlNsRGSiYjUe6f20u1gGvDlUCD/+EVQKjx+pSTw2zjtkFvVoxcZHiAN5zTMjWrnIX3nY0ymC
 HVyLcrPDB0CD9Feqx7aXZzpYdVw5z7Ev7f00dwLYGLPWrj65KhEVt9z
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

A custom 'struct timespec' and 'struct timeval' will be necessary for
64-bit time types on 32-bit architectures. <linux/time.h> will define
other time-related types in terms of the custom 'struct timespec'.

Add custom struct definitions which for now mirror exactly the ones from
the UAPI headers, but provide the foundation for further changes.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-s390.h |  3 +++
 tools/include/nolibc/types.h     | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 6237211385c0..1e87ac42ab9c 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -5,6 +5,9 @@
 
 #ifndef _NOLIBC_ARCH_S390_H
 #define _NOLIBC_ARCH_S390_H
+
+#include "types.h"
+
 #include <linux/signal.h>
 #include <linux/unistd.h>
 
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 470a5f77bc0f..5d180ffabcb6 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -13,9 +13,23 @@
 #include "std.h"
 #include <linux/mman.h>
 #include <linux/stat.h>
-#include <linux/time.h>
+#include <linux/time_types.h>
 #include <linux/wait.h>
 
+struct timespec {
+	__kernel_old_time_t	tv_sec;
+	long			tv_nsec;
+};
+#define _STRUCT_TIMESPEC
+
+struct timeval {
+	__kernel_old_time_t	tv_sec;
+	__kernel_suseconds_t	tv_usec;
+};
+
+#define timeval __nolibc_kernel_timeval
+#include <linux/time.h>
+#undef timeval
 
 /* Only the generic macros and types may be defined here. The arch-specific
  * ones such as the O_RDONLY and related macros used by fcntl() and open()

-- 
2.52.0


