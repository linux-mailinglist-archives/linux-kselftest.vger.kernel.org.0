Return-Path: <linux-kselftest+bounces-24961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D6AA198B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 19:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34C5188D945
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 18:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A19215F76;
	Wed, 22 Jan 2025 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pn2QIjNj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0892153FF;
	Wed, 22 Jan 2025 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571325; cv=none; b=bGWcg6SzvsPsf+gb98eae+kWimq8RxgyOZ/vf/RHzAcL7PZbkMHWjysKaazhipH8OSNm3ypronBZ8qjd/uD0w7ujmHCVWsLArjZsJUpdF6rUhmPu9q4pa5QrykLwo4iN4OtvRa4K3swYxORkm8hIrJEL/0mtujICLrD1vjqP/J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571325; c=relaxed/simple;
	bh=+CRDay+53YjmjDUoZr23NQjukGzwcpQV4L/S0QarAVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R3B+z3Neig74FkFYUlK9dKxDhHpNswXvg9mIxMvvtt1ETLU31nBqrg/RQ1/earsY/spg/px4oUgV7gT1bE5rs+h1qOUDLmOnQ6S5oF3tShMjpOij7oqaw7ZSWB/mntBBVrfjXLPJ8eogOg901wz+fQbhk0wIbl4c7L3iNxralHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pn2QIjNj; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737571320;
	bh=+CRDay+53YjmjDUoZr23NQjukGzwcpQV4L/S0QarAVc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pn2QIjNjl6xeKLGnRDI6EnYvwTtfXADvjaZn6+38bPDY+P+sJ0bso/bMfij7p7dMY
	 OXy8vZROLYcJJOVWYt0a4nHwECcQgdhjyJxU0+Zl3iIhs3IN2fNUPpjwxtvU4l80xo
	 YwYOz/hOYAZvlqRwIwveo0NavGAG7vMVKCJlrmgU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 22 Jan 2025 19:41:44 +0100
Subject: [PATCH 1/5] selftests/nolibc: drop custom EXTRACONFIG
 functionality
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250122-nolibc-config-v1-1-a697db968b49@weissschuh.net>
References: <20250122-nolibc-config-v1-0-a697db968b49@weissschuh.net>
In-Reply-To: <20250122-nolibc-config-v1-0-a697db968b49@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737571320; l=1920;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+CRDay+53YjmjDUoZr23NQjukGzwcpQV4L/S0QarAVc=;
 b=1eVGiGV42afDCRd8dXJo98zrSgUFZmQEeaDIYF+vS5HhmJZN620aIe5hWr8G6F/DM6QV1RCJE
 nEbiZRnlwh8DbyLSF/RoH0YrzIyBGyL8RdUvgYj+E7YKR8N2zGv32RQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

kbuild already contains logic to merge predefines snippets into a
defconfig file. This already works nicely with the current "defconfig"
target. Make use of the snippet and drop the custom logic.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 7d14a7c0cb62608f328b251495264517d333db2e..ba044c8a042ce345ff90bdd35569de4b5acd117d 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -82,7 +82,7 @@ DEFCONFIG_x86        = defconfig
 DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_mips32le   = malta_defconfig
-DEFCONFIG_mips32be   = malta_defconfig
+DEFCONFIG_mips32be   = malta_defconfig generic/eb.config
 DEFCONFIG_ppc        = pmac32_defconfig
 DEFCONFIG_ppc64      = powernv_be_defconfig
 DEFCONFIG_ppc64le    = powernv_defconfig
@@ -93,9 +93,6 @@ DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
 DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
-EXTRACONFIG_mips32be = -d CONFIG_CPU_LITTLE_ENDIAN -e CONFIG_CPU_BIG_ENDIAN
-EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
-
 # optional tests to run (default = all)
 TEST =
 
@@ -265,10 +262,6 @@ initramfs: nolibc-test
 
 defconfig:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
-	$(Q)if [ -n "$(EXTRACONFIG)" ]; then \
-		$(srctree)/scripts/config --file $(objtree)/.config $(EXTRACONFIG); \
-		$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) olddefconfig < /dev/null; \
-	fi
 
 kernel:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) < /dev/null

-- 
2.48.1


