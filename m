Return-Path: <linux-kselftest+bounces-36835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 401C4AFEE4A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 17:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05647162DD1
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A3A2E975D;
	Wed,  9 Jul 2025 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AogC48c6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FE92E9746
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Jul 2025 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076689; cv=none; b=lEjv5J5ITOD9K3VvLORy4m5wJnr/XlDfLuT4ESXKa2FvbNB0wtu7yjo0RLibRboY6usKZU7L+G640agwjHPjUXleoo1RA4k51TIvXWBLIub89rEsUXVqzzgpwHjOPk8CN5V98WAYVKJp+YRz6SHdLSdEsI7N64I7Xx/WWXCSalM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076689; c=relaxed/simple;
	bh=ukp+RAxBTuUebM6uAX3t7qoVxN5aAaDAKYOxiDF6p6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLs0H9Y3QUHwT3sclRZM1vtD975C+j/b61e0xyZ1BeszL0HvCGVmJsvuSfhNG+ae8x9CIkz7x0EoItWrbBqNiNner8hsOfrhWytiJxPjtOS4xKak4L6iCEc0AXoavMQaFXrBP/QKCMcjXVcFPT3lMbxxMwPY4opufgQ4uDEhVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AogC48c6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jxtLoLC3sggOPhWK5ntzWFeRLJnCxjZwSklhIjIHK6s=;
	t=1752076687; x=1753286287; b=AogC48c60AKelUhVN2IPQmzBad60j2pNC9GXAyYmiAyaiYu
	N+5Dt4L4vspkYcvnOnMXMQLap9kwsKwahHUslLAwbCKDIjA5CQK7Z/IWtysPllWQTtj47pvm4O4RC
	kZShTLMc25CahLevZYREt45jLFNL8NbsRaAmaBDHKHGoSCDUc5cB/ts6YmDVuw+8QCmJKF0/pNBPI
	zbIRW7ffoU3bOqKqyT7HHrW2mAJ9wa1Bv0RHOupqwKSqh5ZDpObWc2ZnfGyvtC8bA8tIm1I4n+I3f
	ljbK384LKJG2uyy4K1j0Kqb6luJVAEWukPOm2Ifr4kVGsGDsthOJAQvW3tPy65OQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uZXBM-0000000DWBm-2S9b;
	Wed, 09 Jul 2025 17:58:04 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/3] tools/nolibc: add more generic BITSET_* macros for FD_*
Date: Wed,  9 Jul 2025 17:55:11 +0200
Message-ID: <20250709155512.971080-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250709155512.971080-1-benjamin@sipsolutions.net>
References: <20250709155512.971080-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The FD_* macros are assuming a specific type for the bitset. Add new
macros that introspect the type of the passed variable in order to know
the size of the bitset. This way the same macros can be used for other
purposes.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 tools/include/nolibc/types.h | 67 +++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 16c6e9ec9451..3100771e21ad 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -115,48 +115,53 @@
 #define EXIT_SUCCESS 0
 #define EXIT_FAILURE 1
 
-#define FD_SETIDXMASK (8 * sizeof(unsigned long))
-#define FD_SETBITMASK (8 * sizeof(unsigned long)-1)
-
-/* for select() */
-typedef struct {
-	unsigned long fds[(FD_SETSIZE + FD_SETBITMASK) / FD_SETIDXMASK];
-} fd_set;
-
-#define FD_CLR(fd, set) do {						\
-		fd_set *__set = (set);					\
-		int __fd = (fd);					\
-		if (__fd >= 0)						\
-			__set->fds[__fd / FD_SETIDXMASK] &=		\
-				~(1U << (__fd & FD_SETBITMASK));	\
+#define BITSET_CLR(num, set) do {					  \
+		__typeof__(set) *__set = &(set);			  \
+		int __num = (num);					  \
+		if (__num >= 0 && __num < 8 * (ssize_t)sizeof(*__set))	  \
+			(*__set)[__num / (8 * sizeof(set[0]))] &=	  \
+				~(1U << (__num % (8 * sizeof(**__set)))); \
 	} while (0)
 
-#define FD_SET(fd, set) do {						\
-		fd_set *__set = (set);					\
-		int __fd = (fd);					\
-		if (__fd >= 0)						\
-			__set->fds[__fd / FD_SETIDXMASK] |=		\
-				1 << (__fd & FD_SETBITMASK);		\
+#define BITSET_SET(num, set) do {					\
+		__typeof__(set) *__set = &(set);			\
+		int __num = (num);					\
+		if (__num >= 0 && __num < 8 * (ssize_t)sizeof(*__set))	\
+			(*__set)[__num / (8 * sizeof(set[0]))] |=	\
+				1U << (__num % (8 * sizeof(**__set)));	\
 	} while (0)
 
-#define FD_ISSET(fd, set) ({						\
-			fd_set *__set = (set);				\
-			int __fd = (fd);				\
+#define BITSET_ISSET(num, set) ({					\
+		__typeof__(set) *__set = &(set);			\
+		int __num = (num);					\
 		int __r = 0;						\
-		if (__fd >= 0)						\
-			__r = !!(__set->fds[__fd / FD_SETIDXMASK] &	\
-1U << (__fd & FD_SETBITMASK));						\
-		__r;							\
+		if (__num >= 0 && __num < 8 * (ssize_t)sizeof(*__set))	\
+			__r = (*__set)[__num / (8 * sizeof(set[0]))] &	\
+			      (1U << (__num % (8 * sizeof(**__set))));	\
+		!!__r;							\
 	})
 
-#define FD_ZERO(set) do {						\
-		fd_set *__set = (set);					\
+#define BITSET_ZERO(set) do {						\
+		__typeof__(set) *__set = &(set);			\
 		int __idx;						\
-		int __size = (FD_SETSIZE+FD_SETBITMASK) / FD_SETIDXMASK;\
+		int __size = sizeof(*__set) / sizeof(**__set);		\
 		for (__idx = 0; __idx < __size; __idx++)		\
-			__set->fds[__idx] = 0;				\
+			(*__set)[__idx] = 0;				\
 	} while (0)
 
+#define FD_SETIDXMASK (8 * sizeof(unsigned long))
+#define FD_SETBITMASK (8 * sizeof(unsigned long)-1)
+
+/* for select() */
+typedef struct {
+	unsigned long fds[(FD_SETSIZE + FD_SETBITMASK) / FD_SETIDXMASK];
+} fd_set;
+
+#define FD_CLR(fd, set) BITSET_CLR(fd, (set)->fds)
+#define FD_SET(fd, set) BITSET_SET(fd, (set)->fds)
+#define FD_ISSET(fd, set) BITSET_ISSET(fd, (set)->fds)
+#define FD_ZERO(set) BITSET_ZERO((set)->fds)
+
 /* for getdents64() */
 struct linux_dirent64 {
 	uint64_t       d_ino;
-- 
2.50.0


