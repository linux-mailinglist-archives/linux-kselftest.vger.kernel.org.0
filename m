Return-Path: <linux-kselftest+bounces-41968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06480B8A54B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 17:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECF17E3836
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B5D31C598;
	Fri, 19 Sep 2025 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="i8cj1TSa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996EE31BC9D;
	Fri, 19 Sep 2025 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296172; cv=none; b=hNqshC7hMY0u+vlDleo3y4/hr4zfB8ouHbEsNVMbNNYHB2O+Q78DcFmpD+pVyf0eTK3JvvJlKbgmJ/iS26DGlU/ggSXcvB/Os5TAzoOSovyH0zZSQQgHt2/xgk8tff+YdivdQL8K9r1fi99nH4kTlXZJSBi7U897b+Ovog2i/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296172; c=relaxed/simple;
	bh=fx18mHkX/v80wGI7XRo5gGPBbygD8VbMZyhP9EZSlqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cre4o5bvbxraznfB+1i2TJPr0j1wxEtDjo4fH6cSyIkDCVova3O/F/rUBfqfs7hQFYp2SZjpoWYs+IAJbkJ4Zoylm+QZplLJ6rOTo/lMyDEfA7hC5ZxMlKXpEkUMWipCvASHDrGzji0l5LE7sHkXlfnnFJQtAVW1y9xJ34hOVZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=i8cj1TSa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=c+1HXvxd4hXiAOxdd0af57RhIuaagKYTnqM46MPDRos=;
	t=1758296170; x=1759505770; b=i8cj1TSanLMNXLJ2d9ZM7ZfWoQqdE/DiMByaoZFcBiEGIDX
	mHeekkt5Ivkm6hmaXbJ4qHknxEmJG20/54/nXiPgofWhrcAe+kGBLGkwz/U14xKzHgowbBR85Bjqt
	OiqMMhfiFCryj26WzcP5vXEnt06PUPA7I8iNE1WBAD0wK8XwkNBQ3P+rwrRMR3SZczyZL/D7HLZFc
	ABY3U1MgI+CQ/pFfbMFS/Z27RHnVoLkqPqMNB/ED3b7Zf+zHInwIopUBPQB26NvoMBirnqa7Ylp7N
	EYQanwYKwjSuFTonCvEL/27fXWnOVIMldHlKzQpUdriQvd4KfuvtKX9Mwh5DJVvQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9b-0000000G6O6-0VDy;
	Fri, 19 Sep 2025 17:36:07 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 07/11] um: add infrastructure to build files using nolibc
Date: Fri, 19 Sep 2025 17:34:16 +0200
Message-ID: <20250919153420.727385-8-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Add NOLIBC_CFLAGS and NOLIBC_OBJS to build files against nolibc rather
than libc. With this it is possible to move to nolibc in smaller steps.

Set NOLIBC_IGNORE_ERRNO, as the nolibc errno implementation is overly
simple and cannot handle threading. nolibc provides sys_* functions that
do not emulate the libc errno behaviour and can be used instead.

Guard the syscall definition as it is a macro in nolibc.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---
v2:
- Do not include nolibc.h via CFLAGS
- Make syscall guard more explicit
- Remove __UM_NOLIBC__ define, it is not needed
- Fix out-of-tree building
---
 arch/um/Makefile               | 20 +++++++++++++++++++-
 arch/um/include/shared/os.h    |  2 ++
 arch/um/include/shared/user.h  |  1 -
 arch/um/scripts/Makefile.rules |  8 +++++++-
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index f7c509262568..c3a81df50911 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -78,6 +78,24 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
 		-include $(srctree)/include/linux/kern_levels.h \
 		-include $(srctree)/$(ARCH_DIR)/include/shared/user.h
 
+NOLIBC_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
+		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
+		-I $(srctree)/tools/include \
+		-D__EXPORTED_HEADERS__ \
+		-D__UM_HOST__ \
+		-DNOLIBC_NO_RUNTIME \
+		-DNOLIBC_IGNORE_ERRNO \
+		-nostdlib -nostdinc -static \
+		-I$(srctree)/include/uapi \
+		-I$(srctree)/$(HOST_DIR)/include/uapi \
+		-I$(objtree)/$(HOST_DIR)/include/generated/uapi \
+		-I $(srctree)/tools/include/nolibc \
+		-I $(srctree)/usr/include \
+		-include $(objtree)/include/generated/autoconf.h \
+		-include $(srctree)/tools/include/linux/kconfig.h \
+		-include $(srctree)/include/linux/kern_levels.h \
+		-include $(srctree)/$(ARCH_DIR)/include/shared/user.h
+
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-Linux
 
@@ -160,4 +178,4 @@ archclean:
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
 	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
 
-export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
+export HEADER_ARCH SUBARCH USER_CFLAGS NOLIBC_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index b35cc8ce333b..a131ae9e00db 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -327,7 +327,9 @@ extern int __ignore_sigio_fd(int fd);
 /* tty.c */
 extern int get_pty(void);
 
+#ifndef NOLIBC
 long syscall(long number, ...);
+#endif
 
 /* irqflags tracing */
 extern void block_signals_trace(void);
diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index c9b853e1282f..e32bdd032029 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -16,7 +16,6 @@
  */
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
-#include <linux/types.h>
 #include <stddef.h>
 
 extern void panic(const char *fmt, ...)
diff --git a/arch/um/scripts/Makefile.rules b/arch/um/scripts/Makefile.rules
index b4a2e0058503..5f07551935c3 100644
--- a/arch/um/scripts/Makefile.rules
+++ b/arch/um/scripts/Makefile.rules
@@ -11,6 +11,12 @@ USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 $(USER_OBJS:.o=.%): \
 	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) $(CFLAGS_$(basetarget).o)
 
+# Similar USER_OBJS but compiled against nolibc (may include kernel headers?)
+NOLIBC_OBJS := $(foreach file,$(NOLIBC_OBJS),$(obj)/$(file))
+
+$(NOLIBC_OBJS:.o=.%): \
+	c_flags = -Wp,-MD,$(depfile) $(NOLIBC_CFLAGS) $(CFLAGS_$(basetarget).o)
+
 # These are like USER_OBJS but filter USER_CFLAGS through unprofile instead of
 # using it directly.
 UNPROFILE_OBJS := $(foreach file,$(UNPROFILE_OBJS),$(obj)/$(file))
@@ -18,7 +24,7 @@ UNPROFILE_OBJS := $(foreach file,$(UNPROFILE_OBJS),$(obj)/$(file))
 $(UNPROFILE_OBJS:.o=.%): \
 	c_flags = -Wp,-MD,$(depfile) $(call unprofile,$(USER_CFLAGS)) $(CFLAGS_$(basetarget).o)
 
-$(USER_OBJS) $(UNPROFILE_OBJS): \
+$(USER_OBJS) $(NOLIBC_OBJS) $(UNPROFILE_OBJS): \
 	CHECKFLAGS := $(patsubst $(NOSTDINC_FLAGS),,$(CHECKFLAGS))
 
 # The stubs can't try to call mcount or update basic block data
-- 
2.51.0


