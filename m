Return-Path: <linux-kselftest+bounces-14985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD8194B264
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2291F22C46
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69870158A18;
	Wed,  7 Aug 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Tzqwg2FA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE9155A4E;
	Wed,  7 Aug 2024 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067525; cv=none; b=BwX5P8duOg44267MBqz9d6GFUuz5+43X8hBSplqAcMBWlbwzHxIGJ7F3LP7SPIXwLtolshYeY/IXLhIKAm8EGHVo7AxC0uQqWCaoBuRNTdmNLLD7crLONA5COeWib+IxUnWY6bvs2FIjn58RXsnGgne6LaMFic5MCdBiUbT3Qm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067525; c=relaxed/simple;
	bh=JtLEcuDc7sUI0OHNtKc1zClGfVywsj/5MGDGho6L+CA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=da3+TuXSCXlIfqoEoY50JsbRinLvdSTCnWPHGD32XNVMg7FCVUJGvUQJYDn2+6Eq+B9Z6XsvwUUjx44vgH7KCFk6JPK/x6wi8acDXra/ISHlIaGjCFrpHSn+1FqsAVMG3N7rNyS2wc3WtkbwM8QNmdMaO38wjzaMSSj3S8jpSPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Tzqwg2FA; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723067511;
	bh=JtLEcuDc7sUI0OHNtKc1zClGfVywsj/5MGDGho6L+CA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tzqwg2FAxUJ3BZb/tDBVlqqS1VhcSEZcuwq6MWSnjRbRI8WjPrLAWEo3lo19RxdI5
	 e84kKS5jtbGpYEUQWX/8EHdUUppuZgRl9gPNJQhfINUVheDj8rD+9vIV+VOrw+1viS
	 XiUOG31ct3gWbnj9ViiXYVD+RnIp9xHQFq080IRI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 07 Aug 2024 23:51:49 +0200
Subject: [PATCH v2 13/15] selftests/nolibc: don't use libgcc when building
 with clang
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-nolibc-llvm-v2-13-c20f2f5fc7c2@weissschuh.net>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
In-Reply-To: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723067509; l=1797;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=JtLEcuDc7sUI0OHNtKc1zClGfVywsj/5MGDGho6L+CA=;
 b=lZd+zdKU0xX5jts8qZF/ixTsYcq2SUyAVAuJLSeaEVXLIZT/M7/AgAmGNYusymJlBPqJNthJo
 FpMu+BanZBxAl0luNOMqjVsan0GHHRLfl/S6mwgkCUQvcVuMxYm/8R+
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The logic in clang to find the libgcc.a from a GCC toolchain for a
specific ABI does not work reliably and can lead to errors.
Instead disable libgcc when building with clang, as it's not needed
anyways.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index b8577086e008..f0ce8264baac 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -157,6 +157,13 @@ CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wex
 		$(CFLAGS_$(XARCH)) $(CFLAGS_STACKPROTECTOR) $(CFLAGS_EXTRA)
 LDFLAGS :=
 
+LIBGCC := -lgcc
+
+ifneq ($(LLVM),)
+# Not needed for clang
+LIBGCC :=
+endif
+
 # Modify CFLAGS based on LLVM=
 include $(srctree)/tools/scripts/Makefile.include
 
@@ -209,11 +216,11 @@ sysroot/$(ARCH)/include:
 ifneq ($(NOLIBC_SYSROOT),0)
 nolibc-test: nolibc-test.c nolibc-test-linkage.c sysroot/$(ARCH)/include
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
-	  -nostdlib -nostdinc -static -Isysroot/$(ARCH)/include nolibc-test.c nolibc-test-linkage.c -lgcc
+	  -nostdlib -nostdinc -static -Isysroot/$(ARCH)/include nolibc-test.c nolibc-test-linkage.c $(LIBGCC)
 else
 nolibc-test: nolibc-test.c nolibc-test-linkage.c
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
-	  -nostdlib -static -include $(srctree)/tools/include/nolibc/nolibc.h nolibc-test.c nolibc-test-linkage.c -lgcc
+	  -nostdlib -static -include $(srctree)/tools/include/nolibc/nolibc.h nolibc-test.c nolibc-test-linkage.c $(LIBGCC)
 endif
 
 libc-test: nolibc-test.c nolibc-test-linkage.c

-- 
2.46.0


