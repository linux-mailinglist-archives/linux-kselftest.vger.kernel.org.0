Return-Path: <linux-kselftest+bounces-41454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A55B57134
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 09:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EA7189D734
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 07:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7532F2D661A;
	Mon, 15 Sep 2025 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eypkGkRp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D402D5A16;
	Mon, 15 Sep 2025 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920928; cv=none; b=RN7joQAhLz1NX0asCEAfgB+d5jRcIKF4FXx3ROuJLs4Up6JBp5PsfVUzSQvPL71a7hJqNoEi1LW32aYov5mLNvkPQqS4TA7wbip1nVh2pceYZFW+qVtQfoo0FEEGnEpXnSpG+3k8njIUylZNBUnlFnyw+KVcauvN2aElc08cs4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920928; c=relaxed/simple;
	bh=FYWllZhfNbp4JgkdOlepno8iTqw+NUPFU302qk/TDZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwkTKDvGwLZ2f4CU3U+iSWGEvtRHc8ihdW2LGLvznv4f/gngbwuvhPiobEw9v4Tx54FL7R+yTrupCag9L8GvDhzddU1gnUXK8U3cfwLWVtbHeiXZfJtLX6tsbCkw5DJwGg7WZ6qc/iBugYl4Ub+zLBDIl8v4wux2oBd1Vk8bxyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eypkGkRp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hH26aYIp7wW0Rx8k/qri2ElN7BBI2gkazkXuHwYeotg=;
	t=1757920926; x=1759130526; b=eypkGkRp0foxCOakIuIbMJcB7Ok7G8o6xqcxSd4dkc4uKOH
	yHj5vFtrp59DXX8EqEGKsNnP9BB+nF1KOJMZLkoVMqE0K1KAkUsvRPkA/ppXYPEAgTb7BEJT+++nH
	w3ldKjKKNf3T4BrnmTe3+V+8GPgY1crXj4DjC1sKzQrGgcn6P/VzpQyyyoYDYwitVPEkvR3vPTNtq
	PR0pzQiIpEP5OjqCr9nSSbjQOf1mGDIa4sQSg/7hszGhtFy/Fy72rRY7EGKnBT8TeOMhi/y7ynNZ2
	fwDSHSsMTiYWCM6rKBx47WJaX2YGdNmZw8lgO/+YEbRF8W/u6HiMYrNLTU2XraAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XF-00000005w6o-0LYc;
	Mon, 15 Sep 2025 09:22:01 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/9] um: use tools/include for user files
Date: Mon, 15 Sep 2025 09:11:08 +0200
Message-ID: <20250915071115.1429196-3-benjamin@sipsolutions.net>
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

Using the kernel headers directly from the userspace parts of UML is
problematic. Switch to use the headers from the tools/include
subdirectory instead. These contain stripped down versions that work
well for UML and only relatively small adjustments are needed to make it
work.

This adds two symlinks so that the userspace code can still find
asm-offsets.h and user_constants.h. Other than that, some includes are
moved into USER_CFLAGS instead of handling them in Makefile.rules.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/Makefile                                  | 11 +++++++----
 arch/um/include/shared/generated/asm-offsets.h    |  1 +
 arch/um/include/shared/generated/user_constants.h |  1 +
 arch/um/include/shared/init.h                     |  2 +-
 arch/um/include/shared/user.h                     |  5 -----
 arch/um/kernel/skas/stub.c                        |  1 +
 arch/um/kernel/skas/stub_exe.c                    |  4 ++--
 arch/um/os-Linux/skas/process.c                   |  6 ++----
 arch/um/os-Linux/start_up.c                       |  4 ++--
 arch/um/scripts/Makefile.rules                    |  2 +-
 arch/x86/um/Makefile                              |  6 ++++--
 arch/x86/um/user-offsets.c                        |  1 -
 12 files changed, 22 insertions(+), 22 deletions(-)
 create mode 120000 arch/um/include/shared/generated/asm-offsets.h
 create mode 120000 arch/um/include/shared/generated/user_constants.h

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 7be0143b5ba3..a3f27d791cc0 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
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
+		-include $(srctree)/include/generated/autoconf.h \
+		-include $(srctree)/include/linux/kern_levels.h \
+		-include $(srctree)/$(ARCH_DIR)/include/shared/user.h
 
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-Linux
diff --git a/arch/um/include/shared/generated/asm-offsets.h b/arch/um/include/shared/generated/asm-offsets.h
new file mode 120000
index 000000000000..22fd929dbac7
--- /dev/null
+++ b/arch/um/include/shared/generated/asm-offsets.h
@@ -0,0 +1 @@
+../../../../../include/generated/asm-offsets.h
\ No newline at end of file
diff --git a/arch/um/include/shared/generated/user_constants.h b/arch/um/include/shared/generated/user_constants.h
new file mode 120000
index 000000000000..5f67c190ec09
--- /dev/null
+++ b/arch/um/include/shared/generated/user_constants.h
@@ -0,0 +1 @@
+../../../../../include/generated/user_constants.h
\ No newline at end of file
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
index b42c31cd2390..e5f1658a8f9d 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -38,8 +38,10 @@ subarch-$(CONFIG_MODULES) += ../kernel/module.o
 
 USER_OBJS := bugs_$(BITS).o ptrace_user.o fault.o
 
-$(obj)/user-offsets.s: c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) \
-	-Iarch/x86/include/generated
+$(obj)/user-offsets.s: c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS)	\
+	-Iarch/x86/include/generated					\
+	-include include/linux/kbuild.h
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


