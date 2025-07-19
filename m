Return-Path: <linux-kselftest+bounces-37634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DB1B0B0AB
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 17:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4A61AA296A
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 15:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A4928851C;
	Sat, 19 Jul 2025 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cTZQ/mx2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001C3287511;
	Sat, 19 Jul 2025 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752939537; cv=none; b=Cp2PXB+sNGYHNzjqwXVMUnQkI0UhBJHuCAwT17tr85PGkrK3aHBR2f06tJmZpPEUVwRdgeaUexm37nntJMsWc7PDQ0N8moA1kIALOlBwLzPqhGBemcjH89fEKYgr30xWFHrYymd0nZvzP4oDYVv7P0VgJvAhFFan07HNomBHAlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752939537; c=relaxed/simple;
	bh=UB84zosAyDKdcLtvdROGzQ359daOZJuFvZJIgYYE7IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1pytlZxDGhxWOmFIvRPlkMwabvgLvD9nmzzjOb6QtHnkjv4ixEC+aiKVU0irQCoh056tmZUCwv0iMvSb7N1WDv/ZpiT+Dy/oKQ51lEV8yz71cn3bcGG3/Hk+i+OpS7UJOVFtqtyaVz6pGb+aDJU0kxUIPgFQGfykHwGqEQ/HpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cTZQ/mx2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752939526;
	bh=UB84zosAyDKdcLtvdROGzQ359daOZJuFvZJIgYYE7IM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cTZQ/mx2fe6WEvv41Wz5OfpFtMkC4+vWrWUzUHaxHdW8zsu1pHkqNrRPra2fBmTsL
	 A6B9wUfWI0as32Vcu4i7P7b5R8x/p8/kRgJXDFXmCv6TjpSbuFfGQCWqYfAefwUUiF
	 fhxOJHs+XygTJoL+Q/+j36avORNkpuRBWtYYOi7g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 19 Jul 2025 17:38:27 +0200
Subject: [PATCH 1/3] selftests/nolibc: deduplicate invocations of toplevel
 Makefile
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250719-nolibc-llvm-system-v1-1-1730216ce171@weissschuh.net>
References: <20250719-nolibc-llvm-system-v1-0-1730216ce171@weissschuh.net>
In-Reply-To: <20250719-nolibc-llvm-system-v1-0-1730216ce171@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752939526; l=2285;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=UB84zosAyDKdcLtvdROGzQ359daOZJuFvZJIgYYE7IM=;
 b=s1ncXgxXKcQ2XRNo+TAW9o5Gh0zOt+iFEhttUlxtPpjxcvbA1svL3jofds50VIjpUZ3+0fHVk
 V48BM4+abGmB+HgXus+hNWC0UaM9gXhpmgjVnd6Q3cuHQ+uyWn33oum
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Various targets of the testsuite call back into the toplevel kernel
Makefile. These calls use various parameters and are quite long.

Introduce a common variable to make future changes smaller and the lines
shorter.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile.nolibc | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index 0fb759ba992ee6b1693b88f1b2e77463afa9f38b..8e7a832ba3f6da3ca0d669b941acd1cf79813a8d 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -262,6 +262,9 @@ REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++
 		if (f || !p || !done) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \
 		printf("\nSee all results in %s\n", ARGV[1]); }'
 
+# Execute the toplevel kernel Makefile
+KBUILD_MAKE = $(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE)
+
 help:
 	@echo "Supported targets under selftests/nolibc:"
 	@echo "  all               call the \"run\" target below"
@@ -340,17 +343,17 @@ initramfs: nolibc-test
 	$(Q)cp nolibc-test initramfs/init
 
 defconfig:
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(DEFCONFIG)
+	$(Q)$(KBUILD_MAKE) $(DEFCONFIG)
 	$(Q)if [ -n "$(EXTRACONFIG)" ]; then \
 		$(srctree)/scripts/config --file $(objtree)/.config $(EXTRACONFIG); \
-		$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) olddefconfig < /dev/null; \
+		$(KBUILD_MAKE) olddefconfig < /dev/null; \
 	fi
 
 kernel:
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) < /dev/null
+	$(Q)$(KBUILD_MAKE) $(IMAGE_NAME) < /dev/null
 
 kernel-standalone: initramfs
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs < /dev/null
+	$(Q)$(KBUILD_MAKE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs < /dev/null
 
 # run the tests after building the kernel
 run: kernel initramfs.cpio

-- 
2.50.1


