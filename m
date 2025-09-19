Return-Path: <linux-kselftest+bounces-41963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191A8B8A52A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 17:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B0F561865
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DCA31A566;
	Fri, 19 Sep 2025 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="woKeZR/Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A4314A9A;
	Fri, 19 Sep 2025 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296168; cv=none; b=ToWm45Gbg/tZ2FybGCt3qN3wyc9yk4QR/Fd/C1Eu3n7puBEH4zHKWZqoEX98aBnBIlDUyaWy54YV4vZl8oKALpqem5ra9sW2xTSXqcjT//eLeIRZaeTcOtLZSr+NaNFV868TNbfrb1orKwwRyTlgAhGngXN0578isE3WDamiFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296168; c=relaxed/simple;
	bh=wcLrD0WS5YjvvCsdm8gr/2mkmWKC74LSIzDcH4K3Lmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jo6vkjZJlDs/eGxSHTuCNzxmKcvU50zHtk+CZrkIGJSQT+LkBTDebDU31cWmQqSMRJBtQZb1v4+VMzfd1oYN/sL+TReaN6gxO5urnK4YwVQkf438FE9UyiwJwQOzoM4616kkeP/lDp8/9to0UtbAf4lRVFLVO2V6boMyNfgCoRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=woKeZR/Q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XKawjy2bKBrQJPdin7KqQUscEYPsaoP0832vtVrwP/Q=;
	t=1758296165; x=1759505765; b=woKeZR/QX59XMHr/pH01fHWpjWxeh6iw1pkl9AOIXo5PQYZ
	wH3ht48FIyfCT9E0J1wTZc++TH4jInCL5qJk4y4lV8PNkugudEG4SHeyRiR08AAcMG5aquA01A6BE
	jnkG8G2We074Vlpsf8z62tkyr4ilggFwD+algH36jchtxROrRpzrv+kZgJcc41/+hT+l0lLtnoIGq
	HhA+hSt9exKzsuzqAII2xlBabd+PeDzZPko9srrm1Pg82LNyVrj72CrDfIcGfUW8xrej+e7fRnsNd
	xUQQDRWpvtx569SnEGGLOgv3LDILXNAuKdZmaOUc+wQ8H0mzaSLMV9JPwGRlx6mg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9U-0000000G6O6-1vjd;
	Fri, 19 Sep 2025 17:36:00 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 02/11] um: use tools/include for user files
Date: Fri, 19 Sep 2025 17:34:11 +0200
Message-ID: <20250919153420.727385-3-benjamin@sipsolutions.net>
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

Using the kernel headers directly from the userspace parts of UML is
problematic. Switch to use the headers from the tools/include
subdirectory instead. These contain stripped down versions that work
well for UML and only relatively small adjustments are needed to make it
work.

This adds code to create two symlinks so that the userspace code can
still find asm-offsets.h and user_constants.h. Other than that, some
includes are moved into USER_CFLAGS instead of handling them in
Makefile.rules.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---
v2:
- Fix out-of-tree building
---
 arch/um/Makefile                | 18 ++++++++++++------
 arch/um/include/shared/init.h   |  2 +-
 arch/um/include/shared/user.h   |  5 -----
 arch/um/kernel/skas/stub.c      |  1 +
 arch/um/kernel/skas/stub_exe.c  |  4 ++--
 arch/um/os-Linux/skas/process.c |  6 ++----
 arch/um/os-Linux/start_up.c     |  4 ++--
 arch/um/scripts/Makefile.rules  |  2 +-
 arch/x86/um/Makefile            |  6 ++++--
 arch/x86/um/user-offsets.c      |  1 -
 10 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 7be0143b5ba3..f7c509262568 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -42,7 +42,7 @@ include $(srctree)/$(HOST_DIR)/Makefile.um
 core-y += $(HOST_DIR)/um/
 
 SHARED_HEADERS	:= $(ARCH_DIR)/include/shared
-ARCH_INCLUDE	:= -I$(srctree)/$(SHARED_HEADERS)
+ARCH_INCLUDE	:= -I$(srctree)/$(SHARED_HEADERS) -I$(objtree)/$(SHARED_HEADERS)
 ARCH_INCLUDE	+= -I$(srctree)/$(HOST_DIR)/um/shared
 KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/um
 
@@ -70,10 +70,13 @@ KBUILD_AFLAGS += $(ARCH_INCLUDE)
 
 USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
 		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
-		-D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
-		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__ \
-		-include $(srctree)/include/linux/compiler-version.h \
-		-include $(srctree)/include/linux/kconfig.h
+		-idirafter $(srctree)/tools/include \
+		-D__UM_HOST__ \
+		-include $(srctree)/tools/include/linux/compiler.h \
+		-include $(srctree)/tools/include/linux/kconfig.h \
+		-include $(objtree)/include/generated/autoconf.h \
+		-include $(srctree)/include/linux/kern_levels.h \
+		-include $(srctree)/$(ARCH_DIR)/include/shared/user.h
 
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-Linux
@@ -116,6 +119,9 @@ archheaders:
 
 archprepare:
 	$(Q)$(MAKE) $(build)=$(HOST_DIR)/um include/generated/user_constants.h
+	$(Q)mkdir -p $(ARCH_DIR)/include/shared/generated
+	$(Q)ln -fs ../../../../../include/generated/user_constants.h $(ARCH_DIR)/include/shared/generated/
+	$(Q)ln -fs ../../../../../include/generated/asm-offsets.h $(ARCH_DIR)/include/shared/generated/
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
 LINK-$(CONFIG_LD_SCRIPT_DYN) += -no-pie
@@ -147,7 +153,7 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE) $(CC_FLAGS_
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out
-MRPROPER_FILES += $(HOST_DIR)/include/generated
+MRPROPER_FILES += $(HOST_DIR)/include/generated $(ARCH_DIR)/include/shared/generated
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
diff --git a/arch/um/include/shared/init.h b/arch/um/include/shared/init.h
index 1a659e2e8cc3..d201705bedb3 100644
--- a/arch/um/include/shared/init.h
+++ b/arch/um/include/shared/init.h
@@ -41,7 +41,7 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-#include <linux/compiler_types.h>
+#define __section(section)	__attribute__((__section__(section)))
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index 139eb78a4767..c9b853e1282f 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -16,13 +16,8 @@
  */
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
-/* This is to get size_t and NULL */
-#ifndef __UM_HOST__
 #include <linux/types.h>
-#else
 #include <stddef.h>
-#include <sys/types.h>
-#endif
 
 extern void panic(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
diff --git a/arch/um/kernel/skas/stub.c b/arch/um/kernel/skas/stub.c
index 67cab46a602c..6c9bb1511ea2 100644
--- a/arch/um/kernel/skas/stub.c
+++ b/arch/um/kernel/skas/stub.c
@@ -5,6 +5,7 @@
 
 #include <sysdep/stub.h>
 
+#include <linux/init.h>
 #include <linux/futex.h>
 #include <sys/socket.h>
 #include <errno.h>
diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index cbafaa684e66..0563838c01d1 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -4,8 +4,8 @@
 #include <asm/unistd.h>
 #include <sysdep/stub.h>
 #include <stub-data.h>
-#include <linux/filter.h>
-#include <linux/seccomp.h>
+#include <uapi/linux/filter.h>
+#include <uapi/linux/seccomp.h>
 #include <generated/asm-offsets.h>
 
 void _start(void);
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 78f48fa9db8b..8ad7e863af97 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -29,9 +29,7 @@
 #include <sysdep/stub.h>
 #include <sysdep/mcontext.h>
 #include <linux/futex.h>
-#include <linux/threads.h>
 #include <timetravel.h>
-#include <asm-generic/rwonce.h>
 #include "../internal.h"
 
 int is_skas_winch(int pid, int fd, void *data)
@@ -204,7 +202,7 @@ void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
 			 * Either way, if PID is negative, then we have no
 			 * choice but to kill the task.
 			 */
-			if (__READ_ONCE(mm_idp->pid) < 0)
+			if (READ_ONCE(mm_idp->pid) < 0)
 				goto out_kill;
 
 			ret = syscall(__NR_futex, &data->futex,
@@ -217,7 +215,7 @@ void wait_stub_done_seccomp(struct mm_id *mm_idp, int running, int wait_sigsys)
 			}
 		} while (data->futex == FUTEX_IN_CHILD);
 
-		if (__READ_ONCE(mm_idp->pid) < 0)
+		if (READ_ONCE(mm_idp->pid) < 0)
 			goto out_kill;
 
 		running = 0;
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index a827c2e01aa5..8971f4fdddab 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -28,8 +28,8 @@
 #include <stdbool.h>
 #include <stub-data.h>
 #include <sys/prctl.h>
-#include <linux/seccomp.h>
-#include <linux/filter.h>
+#include <uapi/linux/seccomp.h>
+#include <uapi/linux/filter.h>
 #include <sysdep/mcontext.h>
 #include <sysdep/stub.h>
 #include <registers.h>
diff --git a/arch/um/scripts/Makefile.rules b/arch/um/scripts/Makefile.rules
index a8b7d9dab0a6..b4a2e0058503 100644
--- a/arch/um/scripts/Makefile.rules
+++ b/arch/um/scripts/Makefile.rules
@@ -9,7 +9,7 @@ USER_OBJS += $(filter %_user.o,$(obj-y) $(USER_SINGLE_OBJS))
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 $(USER_OBJS:.o=.%): \
-	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/include/linux/kern_levels.h -include user.h $(CFLAGS_$(basetarget).o)
+	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) $(CFLAGS_$(basetarget).o)
 
 # These are like USER_OBJS but filter USER_CFLAGS through unprofile instead of
 # using it directly.
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index b42c31cd2390..d8a120bace25 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -38,8 +38,10 @@ subarch-$(CONFIG_MODULES) += ../kernel/module.o
 
 USER_OBJS := bugs_$(BITS).o ptrace_user.o fault.o
 
-$(obj)/user-offsets.s: c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) \
-	-Iarch/x86/include/generated
+$(obj)/user-offsets.s: c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS)	\
+	-Iarch/x86/include/generated					\
+	-include $(srctree)/include/linux/kbuild.h
+
 targets += user-offsets.s
 
 include/generated/user_constants.h: $(obj)/user-offsets.s FORCE
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index d6e1cd9956bf..74fc9763b76e 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -8,7 +8,6 @@
 #define __FRAME_OFFSETS
 #include <linux/ptrace.h>
 #include <asm/types.h>
-#include <linux/kbuild.h>
 
 #define DEFINE_LONGS(sym, val)	\
 	COMMENT(#val " / sizeof(unsigned long)");	\
-- 
2.51.0


