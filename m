Return-Path: <linux-kselftest+bounces-47768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D21FCCD3034
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 14:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1C933034ECF
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E1530DD08;
	Sat, 20 Dec 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XNvAgwYK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA273093B5;
	Sat, 20 Dec 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766238970; cv=none; b=XWEqU1dNkHK6fF73lDinTE1s87rM9TGPilkB9BICh9kL1tr5xXfb/BMA7zss4+7bprkC0TBBjaXZm4QvLUJTjwY7fV3MUpxAV+soF8V/GTkXOwjzY6FPcQFe1itIk+nU7vMULZKu8sHEdpIpzUtnLz3F/Nd7bGxcCkh5uPNIn80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766238970; c=relaxed/simple;
	bh=pQy/DAOtKUxUVvlXyyPTb8+FfFbofayILdjdyv3QpFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g8wDlpf1/KSjbj1Pzhe2B+iHdhfAO4vQmz/dGuMKOMZoVLLk+RsQpB6igOZVd293XRd97UFSZPjG85fR7sevSdvjHmoREP2cibuFAyFEETOwTGNHtwodYT2rwoomrf57jvOWPhg8peTw+Uxw3gEHwMbdRk/tdjUx+pxmkmJ1f04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XNvAgwYK; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1766238957;
	bh=pQy/DAOtKUxUVvlXyyPTb8+FfFbofayILdjdyv3QpFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XNvAgwYKzpgs+8/JJP0xVQWmImFsaO4AgPFzHM5nvb6thkpAfzoDXKqR17fZC38lf
	 PfazrLXV8gzN18qiZwILpLqSLXompyh2F9V2J9Htv+cdc3J1QT8YPQt6BCo+0yiDQt
	 wRkKYnp2oII1be0+57htdOJrBTLBXaxNdcjyvGN8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 20 Dec 2025 14:55:52 +0100
Subject: [PATCH v3 08/14] tools/nolibc: use custom structs timespec and
 timeval
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-nolibc-uapi-types-v3-8-c662992f75d7@weissschuh.net>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
In-Reply-To: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766238956; l=1795;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=pQy/DAOtKUxUVvlXyyPTb8+FfFbofayILdjdyv3QpFQ=;
 b=OyUD3UXG6cTDN7PyraCF70v7FpG1Ne8gvoyR/7KG2uvw1BSFLoIYburxyjpYVe7WFtOp9aqnn
 fOXNSBB9cNTCkvbrhKcy2NFnV4icNruyOO7e7I7XuEplb+iTmv7J+8B
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

A custom 'struct timespec' and 'struct timeval' will be necessary for
64-bit time types on 32-bit architectures. <linux/time.h> will define
other time-related types in terms of the custom 'struct timespec'.

Add custom struct definitions which for now mirror exactly the ones from
the UAPI headers, but provide the foundation for further changes.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-s390.h |  3 +++
 tools/include/nolibc/types.h     | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 74125a254ce3..5bee6ecbde0a 100644
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


