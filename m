Return-Path: <linux-kselftest+bounces-36950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40443AFFF7B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 12:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4257718950AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F152D978A;
	Thu, 10 Jul 2025 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NWQJGk8L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8FB2D9480
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144223; cv=none; b=E9McRGvY8X8l0BGM8KotHztDiXqA4ogCmBHnMfu3Ydcwp3zd2QaqmWuG2L7GFB0wckpYzWtNPbEECmyk/CtymxltrJ+yFMtThaZ6VpE5oxS7TLDYiNWkb41cKKK77stkZmtOafIolnTz566ukJc2pJ687DBQnpVnG7mIRBaR+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144223; c=relaxed/simple;
	bh=DEP14ZRZiG/sLyBz8iGbUt59dOaqPCdFYH1CPhYm1RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dc/HtZItxhb7bhuxCKc4Uyv4yvQCN2v3vbeK1La8+VqN+Lva6F8gFlkoio5n51/KVxPsuwEmw95kAVqj3LCJKtPzf+giHweXZwhpM2OKrwq5vOdgIqNu+WrdzeBWW7Ne8b8f9riOYcbFjpGbNO2G0P/5BUJpV/0Kgouz/DKP/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NWQJGk8L; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tsPadXZoxbJVZ8LaEhabHsYayQqqmvPpVP/g2wcp5bw=;
	t=1752144221; x=1753353821; b=NWQJGk8LIPTE3q+zk64+5vi+PP4pqI/3ARlF6MzRI0eOCsD
	GmbZXGNzaxvNY6s5pyN2XVRcoao2jVSo9U8nVMxKAqfDaqLDZDkseL+ez9ONvKb8blPdubdjRAVo1
	qE0SQtvmoqH6XuxDyeC2Nesh/YReUshe9mKG09JV5a1ILV4yE8Cely9E9OUptlGkGqWo8iVaVNaam
	BPQHPO1i6vQHF3hbInu08hX4lpPrZwLw4amWFSUPUXW0ey0OnnMoRMD703zJfUaqvRE52hfmUb7zW
	XEd/phLML9/xJ58nw9bBV98FY2Kwe6twRQ4Krh6OsM7h20MbXzC0/ow1Ev+lFs7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uZokP-0000000Eg4e-3crJ;
	Thu, 10 Jul 2025 12:43:26 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 3/4] tools/nolibc: add more generic bitmask macros for FD_*
Date: Thu, 10 Jul 2025 12:39:49 +0200
Message-ID: <20250710103950.1272379-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710103950.1272379-1-benjamin@sipsolutions.net>
References: <20250710103950.1272379-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The FD_* macros are assuming a specific type for the bitmask. Add new
macros that introspect the type of the passed variable in order to know
the size of the bitmask. This way the same macros can be used for other
purposes.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v2:
- Rename the macros for consistency and to mark them internal
- Fix shift to use the correct element type
---
 tools/include/nolibc/types.h | 72 ++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 16c6e9ec9451..f7f2ddf41e89 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -115,48 +115,56 @@
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
+#define __NOLIBC_BITMASK_CLEAR(num, set) do {				     \
+		__typeof__(set) *__set = &(set);			     \
+		int __num = (num);					     \
+		__typeof__(**__set) __bit = 1;				     \
+		if (__num >= 0 && __num < 8 * (ssize_t)sizeof(*__set))	     \
+			(*__set)[__num / (8 * sizeof(**__set))] &=	     \
+				~(__bit << (__num % (8 * sizeof(**__set)))); \
 	} while (0)
 
-#define FD_SET(fd, set) do {						\
-		fd_set *__set = (set);					\
-		int __fd = (fd);					\
-		if (__fd >= 0)						\
-			__set->fds[__fd / FD_SETIDXMASK] |=		\
-				1 << (__fd & FD_SETBITMASK);		\
+#define __NOLIBC_BITMASK_SET(num, set) do {				  \
+		__typeof__(set) *__set = &(set);			  \
+		int __num = (num);					  \
+		__typeof__(**__set) __bit = 1;				  \
+		if (__num >= 0 && __num < 8 * (ssize_t)sizeof(*__set))	  \
+			(*__set)[__num / (8 * sizeof(**__set))] |=	  \
+				__bit << (__num % (8 * sizeof(**__set))); \
 	} while (0)
 
-#define FD_ISSET(fd, set) ({						\
-			fd_set *__set = (set);				\
-			int __fd = (fd);				\
-		int __r = 0;						\
-		if (__fd >= 0)						\
-			__r = !!(__set->fds[__fd / FD_SETIDXMASK] &	\
-1U << (__fd & FD_SETBITMASK));						\
-		__r;							\
+#define __NOLIBC_BITMASK_TEST(num, set) ({				  \
+		__typeof__(set) *__set = &(set);			  \
+		int __num = (num);					  \
+		__typeof__(**__set) __r = 0;				  \
+		__typeof__(**__set) __bit = 1;				  \
+		if (__num >= 0 && __num < 8 * (ssize_t)sizeof(*__set))	  \
+			__r = (*__set)[__num / (8 * sizeof(**__set))] &	  \
+			      (__bit << (__num % (8 * sizeof(**__set)))); \
+		!!__r;							  \
 	})
 
-#define FD_ZERO(set) do {						\
-		fd_set *__set = (set);					\
+#define __NOLIBC_BITMASK_ZERO(set) do {					\
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
+#define FD_CLR(fd, set) __NOLIBC_BITMASK_CLEAR(fd, (set)->fds)
+#define FD_SET(fd, set) __NOLIBC_BITMASK_SET(fd, (set)->fds)
+#define FD_ISSET(fd, set) __NOLIBC_BITMASK_TEST(fd, (set)->fds)
+#define FD_ZERO(set) __NOLIBC_BITMASK_ZERO((set)->fds)
+
 /* for getdents64() */
 struct linux_dirent64 {
 	uint64_t       d_ino;
-- 
2.50.0


