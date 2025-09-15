Return-Path: <linux-kselftest+bounces-41459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2198B57145
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 09:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA55189DC00
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 07:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1932D7DD8;
	Mon, 15 Sep 2025 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TtBtOXaQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293332D73AE;
	Mon, 15 Sep 2025 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920933; cv=none; b=Mrb2Sk2u8BsT0E8Z+1PTBohs84FhDnn53jX3Ink7TFCAUaYhRNFpi5b32g1cRqsZ3wrcVKT5KscAT9+B/No2ASCggNyy9LTW/Twv+AbosRKeHIyWEY7qRugWpO/AZ8BAbq4lWQrWMeefgnM+O6UgFHbYQ7n9ptJxA+zu4XlJ41c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920933; c=relaxed/simple;
	bh=zzhgr2MSz+WwIyXeNFgpi85yheVgDVQre4NsMvzcufk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hK8UVP21jM077BsDuEXhaIwZmZm6ylIataJtCQRDIR9ABWUhrsN8lWwV7J6F7il053wSIJ6sDBStOfG1ZBp9nas0pg9u3TGZV1QiWN8PT4tN5CrOtqcvf4IC2SU/vJKEIIqjUg8UJyxjNfMoW1zVfM1TIvNiW6/m43IcgReSjgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TtBtOXaQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HVA8rahyRRzDT6UOZjkHUe+vnU2a954Je71AnOZJQWI=;
	t=1757920931; x=1759130531; b=TtBtOXaQ2Ak+W9e/Fc1CHThxCBUfVKzUO2+BLELQq19M8vs
	qJCm4FpDosv1DKICSahwsF2tcKcno0AtVoR0A16kQJk567QLAoh2A1xHB25Vzm3N73mcmJfVeH1sq
	JVoziv4jWVH/F2SRSUiOid4gCoO4Ei+jxsuw2l/+FBVVkNjd53yl7uJXehU8ztT9fUfWPU8cQj0JU
	+7rVZDnHHYCrR76AnlU0Py/rX6NROH7yFOimgdELya8yC+/wtqJWLUpYDtMMk2vwjXGyyw+Yt3LNv
	nxhd29qexlzf6noAo91AZWUX6+iFfaPjO3HNx1IMeBCm44QBCSjAAiIwZLIYTdnA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XL-00000005w6o-3k8S;
	Mon, 15 Sep 2025 09:22:08 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 7/9] um: add infrastructure to build files using nolibc
Date: Mon, 15 Sep 2025 09:11:13 +0200
Message-ID: <20250915071115.1429196-8-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915071115.1429196-1-benjamin@sipsolutions.net>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
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
 arch/um/Makefile               | 21 ++++++++++++++++++++-
 arch/um/include/shared/os.h    |  2 ++
 arch/um/scripts/Makefile.rules |  8 +++++++-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index a3f27d791cc0..54aa26fcc32b 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -78,6 +78,25 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
 		-include $(srctree)/include/linux/kern_levels.h \
 		-include $(srctree)/$(ARCH_DIR)/include/shared/user.h
 
+NOLIBC_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
+		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
+		-I $(srctree)/tools/include \
+		-D__EXPORTED_HEADERS__ \
+		-D__UM_HOST__ -D__UM_NOLIBC__ \
+		-DNOLIBC_NO_STARTCODE \
+		-DNOLIBC_IGNORE_ERRNO \
+		-nostdlib -nostdinc -static \
+		-I$(srctree)/include/uapi \
+		-I$(srctree)/$(HOST_DIR)/include/uapi \
+		-I$(objtree)/$(HOST_DIR)/include/generated/uapi \
+		-I $(srctree)/tools/include/nolibc \
+		-I $(srctree)/usr/include \
+		-include $(srctree)/include/generated/autoconf.h \
+		-include $(srctree)/tools/include/linux/kconfig.h \
+		-include $(srctree)/include/linux/kern_levels.h \
+		-include $(srctree)/tools/include/nolibc/nolibc.h \
+		-include $(srctree)/$(ARCH_DIR)/include/shared/user.h
+
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-Linux
 
@@ -157,4 +176,4 @@ archclean:
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
 	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
 
-export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
+export HEADER_ARCH SUBARCH USER_CFLAGS NOLIBC_CFLAGS CFLAGS_NO_HARDENING DEV_NULL_PATH
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index b35cc8ce333b..3e9f3ae61658 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -327,7 +327,9 @@ extern int __ignore_sigio_fd(int fd);
 /* tty.c */
 extern int get_pty(void);
 
+#ifndef syscall
 long syscall(long number, ...);
+#endif
 
 /* irqflags tracing */
 extern void block_signals_trace(void);
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


