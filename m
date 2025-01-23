Return-Path: <linux-kselftest+bounces-24980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F378AA19F20
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 08:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907B11889115
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 07:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6948520C009;
	Thu, 23 Jan 2025 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GfmjJ+LR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5163920B7ED;
	Thu, 23 Jan 2025 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617926; cv=none; b=DqD9Yclci5PDrgM69kYUPFl78ObvpvfeKvSiYVklSgKL/XyJk11Yw3AJX6FUIS0TAShwBgfVKvjaBJGZiibb2b6l8VdLhn0jYMIgcG5S2I/UqwXKxk8WnncFkOaSxTNatq64S2U5LcLNe9kq7qQZh95nU5G73I3UDPUx8JulIOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617926; c=relaxed/simple;
	bh=+CRDay+53YjmjDUoZr23NQjukGzwcpQV4L/S0QarAVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uYwO/9vhTJ6abHj3fP4muHxhAnevH1KXXu8w6oTTWvNlRCe5t04lJMg5stF7XjPGFe/VLK++m6O30dEGlJayNUhp7vFDCbiIT6zna5sybgahShwm7kaUSwNsY/QP0pOS+liow0fd4ofyAW0oeLu1fp1/v22HDZmmApxJcwpUh/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GfmjJ+LR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737617921;
	bh=+CRDay+53YjmjDUoZr23NQjukGzwcpQV4L/S0QarAVc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GfmjJ+LRO26YcxShVTAzX2avf7gFXZN9OBhafKLV30HaLhdAtwPua7gMJ1zFYyeg+
	 rNr3CSqHfi3QZVhlJleiGijs1b/JHiCmFQocddNXSNQ7vsRQMi+kkDcBaJSRsRNyUG
	 JPd0fm8+KXDE07p7WDGt9xHu3z3zPA83u4oKWsaQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 23 Jan 2025 08:37:37 +0100
Subject: [PATCH v2 1/5] selftests/nolibc: drop custom EXTRACONFIG
 functionality
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250123-nolibc-config-v2-1-5701c35995d6@weissschuh.net>
References: <20250123-nolibc-config-v2-0-5701c35995d6@weissschuh.net>
In-Reply-To: <20250123-nolibc-config-v2-0-5701c35995d6@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737617921; l=1920;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+CRDay+53YjmjDUoZr23NQjukGzwcpQV4L/S0QarAVc=;
 b=pXBfScCXbhj5BbPfc4tm1oCLMUvgcCrzA1sCxbH5neHMfbJd/5UjXc6JwJHR02Loo7GkVIi6Y
 e3uK/NR3IgKALWLlemhYX95l+5o2ehijsHRhq2MSsGIidtpSvtNhpcn
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


