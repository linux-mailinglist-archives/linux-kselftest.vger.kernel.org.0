Return-Path: <linux-kselftest+bounces-24983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5357AA19F28
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 08:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939BE168989
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 07:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD4220CCCA;
	Thu, 23 Jan 2025 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KTcAVjbg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEF520B816;
	Thu, 23 Jan 2025 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617929; cv=none; b=pf5EDFpYMoxqjL4Z2fSLQwt36s/xyJo/lv/jGP44S6wA/BvcbUrU9r33ueCNc6QLC830uUd/UvdBSMWDm9ZkMvy8/yC7XLBiMtW1cZQWyZPU0YJ1R57OLlnMIhMNuxG/GMl1/wUK3usTuZuXa/tAjK4ZwJRAvEH1dX106k6c6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617929; c=relaxed/simple;
	bh=9GeYmwk11CHz23eY62uR618gIEclqpJRQ3rArk0tRVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q4VIWj6V8p4Vksna/xnEce7LAsKsRf6Sr6rpTyQHzt+TB46LeqvASA66/Z5Wrg8LF2f0TuLF6+NvYRdg+Dq5rqywmChP4wHGHXdNtwxn47zMOYI2CFIUYvxNsYUlyfOSY2sZUjt3yEJMVURYfBF8xymMWaUBCzcdXXqzTao9+JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KTcAVjbg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737617921;
	bh=9GeYmwk11CHz23eY62uR618gIEclqpJRQ3rArk0tRVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KTcAVjbgfCMLhPGVPLb0PcQE0gRrZy1lX1hITR8wN8wU9JGU8XGs1Dch+ZPhQZ3zg
	 7sq59r0++zLTJ09mWjz7u58NXiCBJA5UlkRcEjXZVhQKIXFIAlXGeUwMgOfh+fimKL
	 dLVAqBdzMBFy2aaPXhCloqhzMnIjbady2Nk+TRsQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 23 Jan 2025 08:37:40 +0100
Subject: [PATCH v2 4/5] selftests/nolibc: execute defconfig before other
 targets
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250123-nolibc-config-v2-4-5701c35995d6@weissschuh.net>
References: <20250123-nolibc-config-v2-0-5701c35995d6@weissschuh.net>
In-Reply-To: <20250123-nolibc-config-v2-0-5701c35995d6@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737617921; l=1613;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9GeYmwk11CHz23eY62uR618gIEclqpJRQ3rArk0tRVw=;
 b=3jh+uc6/t4zBWyVo2jlfXrohcWlTxbsrzxuMdAoQuotCCKzwDVU2rOGcXiVfDKvA2UJYPgjYJ
 h1fJ08NhxYbDKY+iRdXzTMoJbFSH+VcMCIMdols73jP57cfK8mLZEul
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Some targets use the test kernel configuration.
Executing defconfig in the same make invocation as those targets results
in errors as the configuration may be in an inconsistent state during
reconfiguration.
Avoid this by introducing ordering dependencies between the defconfig
and some other targets.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index d3afb71b4c6b7fc51b89f034c826692e76122864..b74fa74e5ce296f032bec76ce9b3f5a3debe2b40 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -217,7 +217,7 @@ all: run
 
 sysroot: sysroot/$(ARCH)/include
 
-sysroot/$(ARCH)/include:
+sysroot/$(ARCH)/include: | defconfig
 	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
 	$(QUIET_MKDIR)mkdir -p sysroot
 	$(Q)$(MAKE) -C $(srctree) outputmakefile
@@ -263,10 +263,10 @@ initramfs: nolibc-test
 defconfig:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(DEFCONFIG)
 
-kernel:
+kernel: | defconfig
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) < /dev/null
 
-kernel-standalone: initramfs
+kernel-standalone: initramfs | defconfig
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs < /dev/null
 
 # run the tests after building the kernel

-- 
2.48.1


