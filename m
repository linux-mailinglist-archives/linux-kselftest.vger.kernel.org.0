Return-Path: <linux-kselftest+bounces-14990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7278394B26C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE611F22BD7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636AE15A85A;
	Wed,  7 Aug 2024 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="K9maKGHJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F243156649;
	Wed,  7 Aug 2024 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067526; cv=none; b=V7nBDIdVmr+CZ8kwqLuoZw/KABpLwPXx8Fh5Eug8eFUc6ke2Zc8GF3Mo5bqGofGwJA/6T/Rh6ru/zpYUOWz/G8pHrV5vAD11s7sS8ueI/yi03KkEXiwe2wgEjl6nvWRmGuqtRSSAEMUYkeiJ7FQ6ac8c+WQu4BJlO+7YMwvFmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067526; c=relaxed/simple;
	bh=CvIO1V+EWLk9gJaEt19CwmObVNz50d2RnPOeITjF7XM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=toxqQxD0Y4EbSasNcdETKiYa4N7/BAyEjqsu4acG6EChcKqgF4dVi9bErATXPdA9pMruBYE1FcTWTTDkV1GgDazUFppOhUSLXFRB4tieGd/93RwOeMjDliXVbq4lvQJ2Ah3UJVBT/yukHghs5uKjjrh5YXFdx7lgHdwbOLiYb0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=K9maKGHJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723067511;
	bh=CvIO1V+EWLk9gJaEt19CwmObVNz50d2RnPOeITjF7XM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K9maKGHJcx2OjpJtmDvBq6j2d4T5uQwyTbHTd1Zbayec4LbS4GD45fnpMiQCbLKuO
	 sYMwAy7r+Ah13ar007qrXpawFGWUsz7WL/xLYyZz5WUEkeqcxFId7lfOpfcB7SrOuy
	 EyIPN4nvQ0FRACGowpfbh7hocCx/L+Q2+0A5jta8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 07 Aug 2024 23:51:46 +0200
Subject: [PATCH v2 10/15] selftests/nolibc: add support for LLVM= parameter
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-nolibc-llvm-v2-10-c20f2f5fc7c2@weissschuh.net>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
In-Reply-To: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723067509; l=2298;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=CvIO1V+EWLk9gJaEt19CwmObVNz50d2RnPOeITjF7XM=;
 b=aIYQwTZfI8AxgslY0Uhi52TonR+hoTgGqjrxXg0Ymu2i831yZFf9wa2ETKbNoLxIUkYh/tAjz
 wBclZdA6YIVA4OsdAlqjFO/dSo2ftC+OGMdtwe6Z1cQOVi0pnBwAnc5
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Makefile.include can modify CC and CFLAGS for usage with clang.
Make use of it.

Makefile.include is currently used to handle the O= variable.
This is incompatible with the LLVM= handling as for O= it has to be
included as early as possible, while for LLVM= it needs to be included
after CFLAGS are set up.

To avoid this incompatibility, switch the O= handling to custom logic.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/nolibc/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 803a4e1bbe24..cdff317c35f2 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -5,7 +5,6 @@ ifeq ($(srctree),)
 srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
 endif
 
-include $(srctree)/tools/scripts/Makefile.include
 include $(srctree)/tools/scripts/utilities.mak
 # We need this for the "cc-option" macro.
 include $(srctree)/tools/build/Build.include
@@ -14,6 +13,9 @@ ifneq ($(O),)
 ifneq ($(call is-absolute,$(O)),y)
 $(error Only absolute O= parameters are supported)
 endif
+objtree := $(O)
+else
+objtree ?= $(srctree)
 endif
 
 ifeq ($(ARCH),)
@@ -21,8 +23,6 @@ include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
 endif
 
-objtree ?= $(srctree)
-
 # XARCH extends the kernel's ARCH with a few variants of the same
 # architecture that only differ by the configuration, the toolchain
 # and the Qemu program used. It is copied as-is into ARCH except for
@@ -155,6 +155,9 @@ CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wex
 		$(CFLAGS_$(XARCH)) $(CFLAGS_STACKPROTECTOR) $(CFLAGS_EXTRA)
 LDFLAGS :=
 
+# Modify CFLAGS based on LLVM=
+include $(srctree)/tools/scripts/Makefile.include
+
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++; print;} /\[SKIPPED\][\r]*$$/{s++} \
 		END{ printf("\n%3d test(s): %3d passed, %3d skipped, %3d failed => status: ", p+s+f, p, s, f); \
 		if (f || !p) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \

-- 
2.46.0


