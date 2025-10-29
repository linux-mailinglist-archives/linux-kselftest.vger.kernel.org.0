Return-Path: <linux-kselftest+bounces-44315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C76C1C41D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B942621EA2
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CD6351FB8;
	Wed, 29 Oct 2025 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nNs7kBlK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2F34DCFE;
	Wed, 29 Oct 2025 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753895; cv=none; b=lo2/w+JMtW60m53AMYPLh7f/lxgHeWk6gWT3gTZTtTgoWALIL6uNHf2IxiuxvL56rK2VxkZe8PAsJVacX4nuNADdBRpZflLN0KKHlIZL6gINpBfAYcT8ZI/sXuapg6PElWS4EErdkvQIYMfATuI3FWK1RgRut40uTrH26b7hkNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753895; c=relaxed/simple;
	bh=AbQbaLL02m4q7n1RQ5l0qlfzrr5SAXjX10+R/1QVLKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hBPwGpC7HUFzr5UN/PZzbvbDWFjEk9/KPE2y5WkfNlpiizm5NHErz4tUYpmhkFIBPvUPafaDz9Ly9RjxhD7Wx+WSzsNWm1vjMUpJBlQ68KYOy2AWwxt9WMf5RGn5ipPx1ak4aGi+8xVe65xsXhhFSI4PYPtu2ei0VZlljQB5FCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nNs7kBlK; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761753884;
	bh=AbQbaLL02m4q7n1RQ5l0qlfzrr5SAXjX10+R/1QVLKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nNs7kBlK0zX6EsyuvY5TFW5u3KdFEMK5pLUGnzQqPnPewzNFxMNekeckLMPBZtlLE
	 +J+1oo/7nkY9Vxjl9AchG6Go31Moy8XHGOvandvSsM5P1Ufz7OZgBkvcjmjEkjfHoi
	 utIfRb/LJwJaGSwQSMC3MI0I9iS8TiyTUyCPkg9I=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 17:02:59 +0100
Subject: [PATCH 09/12] tools/nolibc: use a custom struct timespec
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-nolibc-uapi-types-v1-9-e79de3b215d8@weissschuh.net>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
In-Reply-To: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761753881; l=1391;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AbQbaLL02m4q7n1RQ5l0qlfzrr5SAXjX10+R/1QVLKw=;
 b=HmhPLCn3lnGdNx/D/+asK+nOBGjQ9BfJjj/EI1BBRCYDniMlxOGZUf3cbhp5CL4xbAoVeRKIP
 fOufAYOYL2yAosmunVs6TMuTTXy0gVhcmGfzeiRH6VjJ1hqBVr5jiWj
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

A custom 'struct timespec' will be necessary for 64-bit time types on
32-bit architectures. <linux/time.h> will define other time-related
types in terms of the custom definition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-s390.h | 3 +++
 tools/include/nolibc/types.h     | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

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
index 16c6e9ec9451..4f5a25567e5c 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -13,9 +13,16 @@
 #include "std.h"
 #include <linux/mman.h>
 #include <linux/stat.h>
-#include <linux/time.h>
 #include <linux/wait.h>
 
+struct timespec {
+	time_t	tv_sec;
+	long	tv_nsec;
+};
+#define _STRUCT_TIMESPEC
+
+#include <linux/time.h>
+
 
 /* Only the generic macros and types may be defined here. The arch-specific
  * ones such as the O_RDONLY and related macros used by fcntl() and open()

-- 
2.51.1.dirty


