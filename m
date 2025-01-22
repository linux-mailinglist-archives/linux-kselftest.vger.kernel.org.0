Return-Path: <linux-kselftest+bounces-24958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA9DA198AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 19:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05C6C7A361C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 18:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8905821578A;
	Wed, 22 Jan 2025 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Qupcj2YC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0F021576C;
	Wed, 22 Jan 2025 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571324; cv=none; b=kr5JYASP4SLsiKnBsK6jN5tjmQMmWvfLyX0GHjZ8TRhf5LLBr0RnfyVot9S7qsIeZyOw+ceJaQu8kjXBH9ns5VufYAbJ+doi4OlcainQ2NIwp0u74jTA38NDdAZG8Ule+1lFrU7sUSRAGd5MmFumSJ1tCcXqNuS+exNcrArfJ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571324; c=relaxed/simple;
	bh=9GeYmwk11CHz23eY62uR618gIEclqpJRQ3rArk0tRVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rINqWHtcaU74i89muvEp1vMGJ/c2F+PkRvuyxI7u5z4frXGmK6GwBb9GYW9bb19ZRIgTDkp9zNLsdXGepOr71NBqfY+vDZrNiE5mCE4CzK+xKtNMTvpmTRbRXlQ57IjQBGEpRUnX+la1tld0yswlJOpwhx9Z8VnSiX0FYzyCA1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Qupcj2YC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737571320;
	bh=9GeYmwk11CHz23eY62uR618gIEclqpJRQ3rArk0tRVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qupcj2YC5B6P1xeCDcwn30bbTx4TkBA15l2oJj2RPbzW3b3WnxXeBJv9ls4Mfhq0P
	 KZcaB4WOq49rjfYUuMOWRnBa0iGo9F7TTJd77LNQHhPrKHXuDV2LZpC5rYk6NaFNag
	 OxXHMxpEntV/xx7y+u3vuDUjIMv+c0fUpky11bc0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 22 Jan 2025 19:41:47 +0100
Subject: [PATCH 4/5] selftests/nolibc: execute defconfig before other
 targets
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250122-nolibc-config-v1-4-a697db968b49@weissschuh.net>
References: <20250122-nolibc-config-v1-0-a697db968b49@weissschuh.net>
In-Reply-To: <20250122-nolibc-config-v1-0-a697db968b49@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737571320; l=1613;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9GeYmwk11CHz23eY62uR618gIEclqpJRQ3rArk0tRVw=;
 b=Qvg+YT6uq1ydThNZf7zdp6qrSWMq4rfqLqzrUfP0co9gn/xE7UtcSruDnYxaX06E7wTDyw4M6
 xJKClTwFKwJCIwEuubOeYkypK0mjHMnUL2TfkCXTd+zd1TrYmmUwxY3
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


