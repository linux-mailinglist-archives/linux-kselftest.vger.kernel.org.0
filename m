Return-Path: <linux-kselftest+bounces-32588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8387FAAE894
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 20:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA811B617E7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 18:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0451B28DF21;
	Wed,  7 May 2025 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCLje1xI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A745D7263D;
	Wed,  7 May 2025 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746641778; cv=none; b=hbsF0YgaFjEO/JaLFDOrOs1qALSBSHbziRkauD+R4NidLRacIJWFOAw6OtaVYUT7xWhaqEiEevFT1aOKSDcoX8XS6BjrrHhPD5Cq7lO/B6shU98/3j+R3sdaCBPd/vSdG0dSpJM31/vEJEoqqJ7FfwREFj24RKOsr/A6qzBDIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746641778; c=relaxed/simple;
	bh=6aIL2WCnvVzoSy7GS9eNZQkXfQlIiA6MSGlnUKLXAME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aS6wqIJJZ2yG91RibvsOVxh8QCONSlGFv70dSUFAOHuiuTzSYQ8dx9SEu6nAxGL4XdiPoRIlAOtcQ5Ho83v3WS1cEGYF5CKr9Izf/GO9hmX+5ajEpSQPbbiHpdAfAmqCpdPOHkxntbfkR0LGUQCt0+A1QxXjsjXKF2sRRtQv51g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCLje1xI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43088C4AF0C;
	Wed,  7 May 2025 18:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746641778;
	bh=6aIL2WCnvVzoSy7GS9eNZQkXfQlIiA6MSGlnUKLXAME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GCLje1xIjVKD8qscbIdJ/4BjVvAF6modLzo/6ln2VusBfvOf8kc4GFFszxZ92Smpz
	 ILUHt7P+41InyW6iOR/lP/lIo5msq/boeQN/BrnmgP4lCAKSQzRC55AUfMe/znLZ0y
	 jh8hO+leFTuR1VTnEjmU7nqh83BeykPKpd18UG1bNMOmIYqSq6qE9lOJrTa4fucggv
	 X2Y/4+sywvnFSGL99Hqhn4mfKVBNlE9mzeA7cPrWg/+RePRYKKmO63bt45qJ/gB8A0
	 OMcEN/CxIgFdBB4E+M9TSOzKaUM61iPHdM1TphhnCs8XLzLueYVOsoVtkvxIgCKP6M
	 OduOQgV/mn1Fw==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	x86@kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 3/8] stackleak: Rename CONFIG_GCC_PLUGIN_STACKLEAK to CONFIG_STACKLEAK
Date: Wed,  7 May 2025 11:16:09 -0700
Message-Id: <20250507181615.1947159-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507180852.work.231-kees@kernel.org>
References: <20250507180852.work.231-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17883; i=kees@kernel.org; h=from:subject; bh=6aIL2WCnvVzoSy7GS9eNZQkXfQlIiA6MSGlnUKLXAME=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnSi3PEE1p0Dja06F8x33Lret05261J9eHKrVWF2+ZJs jypENnQUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJGneowMp06eLkt/yZbuF7L9 SPlJhYXZM+/Ehf+bfDTiq5L9a2OtWwz/I+8WLxVa6b3C4Hnx0i71nxtSrIx4mwvqSlzq/8dpK51 hBQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for adding Clang sanitizer coverage stack depth
tracking that can support stack depth callbacks, remove "GCC_PLUGIN"
from "CONFIG_GCC_PLUGIN_STACKLEAK" and remove "PLUGIN" from
"DISABLE_STACKLEAK_PLUGIN". Rearrange the Kconfig to have a top-level
CONFIG_STACKLEAK that will depend on either GCC plugins or Clang soon.

While here, also split "prev_lowest_stack" into CONFIG_STACKLEAK_METRICS,
since that's the only place it is referenced from.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <x86@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: <linux-doc@vger.kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <kvmarm@lists.linux.dev>
Cc: <linux-riscv@lists.infradead.org>
Cc: <linux-s390@vger.kernel.org>
Cc: <linux-efi@vger.kernel.org>
Cc: <linux-hardening@vger.kernel.org>
Cc: <linux-kbuild@vger.kernel.org>
Cc: <linux-security-module@vger.kernel.org>
Cc: <linux-kselftest@vger.kernel.org>
---
 security/Kconfig.hardening                  | 18 +++++++++++-------
 arch/arm/boot/compressed/Makefile           |  2 +-
 arch/arm64/kernel/pi/Makefile               |  2 +-
 arch/arm64/kvm/hyp/nvhe/Makefile            |  2 +-
 arch/riscv/kernel/pi/Makefile               |  2 +-
 arch/riscv/purgatory/Makefile               |  2 +-
 arch/x86/purgatory/Makefile                 |  2 +-
 drivers/firmware/efi/libstub/Makefile       |  6 +++---
 kernel/Makefile                             |  4 ++--
 lib/Makefile                                |  2 +-
 scripts/Makefile.gcc-plugins                |  4 ++--
 Documentation/admin-guide/sysctl/kernel.rst |  2 +-
 Documentation/security/self-protection.rst  |  2 +-
 arch/x86/entry/calling.h                    |  4 ++--
 include/linux/sched.h                       |  4 +++-
 include/linux/stackleak.h                   |  4 ++--
 arch/arm/kernel/entry-common.S              |  2 +-
 arch/arm64/kernel/entry.S                   |  2 +-
 arch/riscv/kernel/entry.S                   |  2 +-
 arch/s390/kernel/entry.S                    |  2 +-
 drivers/misc/lkdtm/stackleak.c              |  8 ++++----
 tools/testing/selftests/lkdtm/config        |  2 +-
 22 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index c17366ce8224..2d5852676991 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -158,10 +158,10 @@ config GCC_PLUGIN_STRUCTLEAK_VERBOSE
 	  initialized. Since not all existing initializers are detected
 	  by the plugin, this can produce false positive warnings.
 
-config GCC_PLUGIN_STACKLEAK
+config STACKLEAK
 	bool "Poison kernel stack before returning from syscalls"
-	depends on GCC_PLUGINS
 	depends on HAVE_ARCH_STACKLEAK
+	depends on GCC_PLUGINS
 	help
 	  This option makes the kernel erase the kernel stack before
 	  returning from system calls. This has the effect of leaving
@@ -179,6 +179,10 @@ config GCC_PLUGIN_STACKLEAK
 	  are advised to test this feature on your expected workload before
 	  deploying it.
 
+config GCC_PLUGIN_STACKLEAK
+	def_bool STACKLEAK
+	depends on GCC_PLUGINS
+	help
 	  This plugin was ported from grsecurity/PaX. More information at:
 	   * https://grsecurity.net/
 	   * https://pax.grsecurity.net/
@@ -197,9 +201,9 @@ config STACKLEAK_TRACK_MIN_SIZE
 	int "Minimum stack frame size of functions tracked by STACKLEAK"
 	default 100
 	range 0 4096
-	depends on GCC_PLUGIN_STACKLEAK
+	depends on STACKLEAK
 	help
-	  The STACKLEAK gcc plugin instruments the kernel code for tracking
+	  The STACKLEAK options instruments the kernel code for tracking
 	  the lowest border of the kernel stack (and for some other purposes).
 	  It inserts the stackleak_track_stack() call for the functions with
 	  a stack frame size greater than or equal to this parameter.
@@ -207,7 +211,7 @@ config STACKLEAK_TRACK_MIN_SIZE
 
 config STACKLEAK_METRICS
 	bool "Show STACKLEAK metrics in the /proc file system"
-	depends on GCC_PLUGIN_STACKLEAK
+	depends on STACKLEAK
 	depends on PROC_FS
 	help
 	  If this is set, STACKLEAK metrics for every task are available in
@@ -219,11 +223,11 @@ config STACKLEAK_METRICS
 
 config STACKLEAK_RUNTIME_DISABLE
 	bool "Allow runtime disabling of kernel stack erasing"
-	depends on GCC_PLUGIN_STACKLEAK
+	depends on STACKLEAK
 	help
 	  This option provides 'stack_erasing' sysctl, which can be used in
 	  runtime to control kernel stack erasing for kernels built with
-	  CONFIG_GCC_PLUGIN_STACKLEAK.
+	  CONFIG_STACKLEAK.
 
 config INIT_ON_ALLOC_DEFAULT_ON
 	bool "Enable heap memory zeroing on allocation by default"
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index d61369b1eabe..cc71343694c7 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -9,7 +9,7 @@ OBJS		=
 
 HEAD	= head.o
 OBJS	+= misc.o decompress.o
-CFLAGS_decompress.o += $(DISABLE_STACKLEAK_PLUGIN)
+CFLAGS_decompress.o += $(DISABLE_STACKLEAK)
 ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
 OBJS	+= debug.o
 AFLAGS_head.o += -DDEBUG
diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
index 4d11a8c29181..77159298f3c6 100644
--- a/arch/arm64/kernel/pi/Makefile
+++ b/arch/arm64/kernel/pi/Makefile
@@ -2,7 +2,7 @@
 # Copyright 2022 Google LLC
 
 KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) -fpie \
-		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN) \
+		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK) \
 		   $(DISABLE_LATENT_ENTROPY_PLUGIN) \
 		   $(call cc-option,-mbranch-protection=none) \
 		   -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index b43426a493df..4e00a2a8ad0c 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -12,7 +12,7 @@ asflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS -D__DISABLE_TRACE_MMIO__
 ccflags-y += -fno-stack-protector	\
 	     -DDISABLE_BRANCH_PROFILING	\
-	     $(DISABLE_STACKLEAK_PLUGIN)
+	     $(DISABLE_STACKLEAK)
 
 hostprogs := gen-hyprel
 HOST_EXTRACFLAGS += -I$(objtree)/include
diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
index 81d69d45c06c..40238ed13ea1 100644
--- a/arch/riscv/kernel/pi/Makefile
+++ b/arch/riscv/kernel/pi/Makefile
@@ -2,7 +2,7 @@
 # This file was copied from arm64/kernel/pi/Makefile.
 
 KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) -fpie \
-		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN) \
+		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK) \
 		   $(call cc-option,-mbranch-protection=none) \
 		   -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
 		   -include $(srctree)/include/linux/hidden.h \
diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index fb9c917c9b45..af8fa4aded5c 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -53,7 +53,7 @@ targets += purgatory.ro purgatory.chk
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=medany -ffreestanding -fno-zero-initialized-in-bss
-PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
+PURGATORY_CFLAGS += $(DISABLE_STACKLEAK) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector -g0
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index ebdfd7b84feb..5450d5f7fd88 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -35,7 +35,7 @@ targets += purgatory.ro purgatory.chk
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=small -ffreestanding -fno-zero-initialized-in-bss -g0
 PURGATORY_CFLAGS += -fpic -fvisibility=hidden
-PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
+PURGATORY_CFLAGS += $(DISABLE_STACKLEAK) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d23a1b9fed75..1cfdde43da02 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -22,15 +22,15 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -std=gnu11 \
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
-cflags-$(CONFIG_ARM64)		+= -fpie $(DISABLE_STACKLEAK_PLUGIN) \
+cflags-$(CONFIG_ARM64)		+= -fpie $(DISABLE_STACKLEAK) \
 				   -fno-unwind-tables -fno-asynchronous-unwind-tables
 cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
 				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
 				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base) \
-				   $(DISABLE_STACKLEAK_PLUGIN)
+				   $(DISABLE_STACKLEAK)
 cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax \
-				   $(DISABLE_STACKLEAK_PLUGIN)
+				   $(DISABLE_STACKLEAK)
 cflags-$(CONFIG_LOONGARCH)	+= -fpie
 
 cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
diff --git a/kernel/Makefile b/kernel/Makefile
index 434929de17ef..79583e3501b4 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -137,8 +137,8 @@ obj-$(CONFIG_WATCH_QUEUE) += watch_queue.o
 obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
-CFLAGS_stackleak.o += $(DISABLE_STACKLEAK_PLUGIN)
-obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
+CFLAGS_stackleak.o += $(DISABLE_STACKLEAK)
+obj-$(CONFIG_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
 KCSAN_SANITIZE_stackleak.o := n
 KCOV_INSTRUMENT_stackleak.o := n
diff --git a/lib/Makefile b/lib/Makefile
index c38582f187dd..190c2eecffbf 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -337,7 +337,7 @@ obj-$(CONFIG_UBSAN) += ubsan.o
 UBSAN_SANITIZE_ubsan.o := n
 KASAN_SANITIZE_ubsan.o := n
 KCSAN_SANITIZE_ubsan.o := n
-CFLAGS_ubsan.o := -fno-stack-protector $(DISABLE_STACKLEAK_PLUGIN)
+CFLAGS_ubsan.o := -fno-stack-protector $(DISABLE_STACKLEAK)
 
 obj-$(CONFIG_SBITMAP) += sbitmap.o
 
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index e50dc931be49..33ddf5bfda34 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -32,9 +32,9 @@ gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE)	\
 		+= -fplugin-arg-stackleak_plugin-verbose
 ifdef CONFIG_GCC_PLUGIN_STACKLEAK
-    DISABLE_STACKLEAK_PLUGIN += -fplugin-arg-stackleak_plugin-disable
+    DISABLE_STACKLEAK += -fplugin-arg-stackleak_plugin-disable
 endif
-export DISABLE_STACKLEAK_PLUGIN
+export DISABLE_STACKLEAK
 
 # All the plugin CFLAGS are collected here in case a build target needs to
 # filter them out of the KBUILD_CFLAGS.
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index dd49a89a62d3..c94475661a80 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1465,7 +1465,7 @@ stack_erasing
 =============
 
 This parameter can be used to control kernel stack erasing at the end
-of syscalls for kernels built with ``CONFIG_GCC_PLUGIN_STACKLEAK``.
+of syscalls for kernels built with ``CONFIG_STACKLEAK``.
 
 That erasing reduces the information which kernel stack leak bugs
 can reveal and blocks some uninitialized stack variable attacks.
diff --git a/Documentation/security/self-protection.rst b/Documentation/security/self-protection.rst
index 910668e665cb..67a266d38172 100644
--- a/Documentation/security/self-protection.rst
+++ b/Documentation/security/self-protection.rst
@@ -303,7 +303,7 @@ Memory poisoning
 
 When releasing memory, it is best to poison the contents, to avoid reuse
 attacks that rely on the old contents of memory. E.g., clear stack on a
-syscall return (``CONFIG_GCC_PLUGIN_STACKLEAK``), wipe heap memory on a
+syscall return (``CONFIG_STACKLEAK``), wipe heap memory on a
 free. This frustrates many uninitialized variable attacks, stack content
 exposures, heap content exposures, and use-after-free attacks.
 
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index d83236b96f22..790e63df94a2 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -369,7 +369,7 @@ For 32-bit we have the following conventions - kernel is built with
 .endm
 
 .macro STACKLEAK_ERASE_NOCLOBBER
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+#ifdef CONFIG_STACKLEAK
 	PUSH_AND_CLEAR_REGS
 	call stackleak_erase
 	POP_REGS
@@ -388,7 +388,7 @@ For 32-bit we have the following conventions - kernel is built with
 #endif /* !CONFIG_X86_64 */
 
 .macro STACKLEAK_ERASE
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+#ifdef CONFIG_STACKLEAK
 	call stackleak_erase
 #endif
 .endm
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f96ac1982893..f323a4d9f0ef 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1599,8 +1599,10 @@ struct task_struct {
 	/* Used by BPF for per-TASK xdp storage */
 	struct bpf_net_context		*bpf_net_context;
 
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+#ifdef CONFIG_STACKLEAK
 	unsigned long			lowest_stack;
+#endif
+#ifdef CONFIG_STACKLEAK_METRICS
 	unsigned long			prev_lowest_stack;
 #endif
 
diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
index 3be2cb564710..71e8242fd8f2 100644
--- a/include/linux/stackleak.h
+++ b/include/linux/stackleak.h
@@ -12,7 +12,7 @@
 #define STACKLEAK_POISON -0xBEEF
 #define STACKLEAK_SEARCH_DEPTH 128
 
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+#ifdef CONFIG_STACKLEAK
 #include <asm/stacktrace.h>
 #include <linux/linkage.h>
 
@@ -82,7 +82,7 @@ asmlinkage void noinstr stackleak_erase_on_task_stack(void);
 asmlinkage void noinstr stackleak_erase_off_task_stack(void);
 void __no_caller_saved_registers noinstr stackleak_track_stack(void);
 
-#else /* !CONFIG_GCC_PLUGIN_STACKLEAK */
+#else /* !CONFIG_STACKLEAK */
 static inline void stackleak_task_init(struct task_struct *t) { }
 #endif
 
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index f379c852dcb7..9921898d29a1 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -119,7 +119,7 @@ no_work_pending:
 
 	ct_user_enter save = 0
 
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+#ifdef CONFIG_STACKLEAK
 	bl	stackleak_erase_on_task_stack
 #endif
 	restore_user_regs fast = 0, offset = 0
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 5ae2a34b50bd..c5456ff920d3 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -614,7 +614,7 @@ SYM_CODE_END(ret_to_kernel)
 SYM_CODE_START_LOCAL(ret_to_user)
 	ldr	x19, [tsk, #TSK_TI_FLAGS]	// re-check for single-step
 	enable_step_tsk x19, x2
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+#ifdef CONFIG_STACKLEAK
 	bl	stackleak_erase_on_task_stack
 #endif
 	kernel_exit 0
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 33a5a9f2a0d4..d6e9903817f7 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -220,7 +220,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 #endif
 	bnez s0, 1f
 
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+#ifdef CONFIG_STACKLEAK
 	call	stackleak_erase_on_task_stack
 #endif
 
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index dd291c9ad6a6..6b43318dc0cc 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -124,7 +124,7 @@ _LPP_OFFSET	= __LC_LPP
 #endif
 
 	.macro STACKLEAK_ERASE
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+#ifdef CONFIG_STACKLEAK
 	brasl	%r14,stackleak_erase_on_task_stack
 #endif
 	.endm
diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/stackleak.c
index f1d022160913..ab8c690a039a 100644
--- a/drivers/misc/lkdtm/stackleak.c
+++ b/drivers/misc/lkdtm/stackleak.c
@@ -11,7 +11,7 @@
 #include "lkdtm.h"
 #include <linux/stackleak.h>
 
-#if defined(CONFIG_GCC_PLUGIN_STACKLEAK)
+#if defined(CONFIG_STACKLEAK)
 /*
  * Check that stackleak tracks the lowest stack pointer and erases the stack
  * below this as expected.
@@ -129,16 +129,16 @@ static void lkdtm_STACKLEAK_ERASING(void)
 	check_stackleak_irqoff();
 	local_irq_restore(flags);
 }
-#else /* defined(CONFIG_GCC_PLUGIN_STACKLEAK) */
+#else /* defined(CONFIG_STACKLEAK) */
 static void lkdtm_STACKLEAK_ERASING(void)
 {
 	if (IS_ENABLED(CONFIG_HAVE_ARCH_STACKLEAK)) {
-		pr_err("XFAIL: stackleak is not enabled (CONFIG_GCC_PLUGIN_STACKLEAK=n)\n");
+		pr_err("XFAIL: stackleak is not enabled (CONFIG_STACKLEAK=n)\n");
 	} else {
 		pr_err("XFAIL: stackleak is not supported on this arch (HAVE_ARCH_STACKLEAK=n)\n");
 	}
 }
-#endif /* defined(CONFIG_GCC_PLUGIN_STACKLEAK) */
+#endif /* defined(CONFIG_STACKLEAK) */
 
 static struct crashtype crashtypes[] = {
 	CRASHTYPE(STACKLEAK_ERASING),
diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index 7afe05e8c4d7..b9b1275c07e8 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -2,7 +2,7 @@ CONFIG_LKDTM=y
 CONFIG_DEBUG_LIST=y
 CONFIG_SLAB_FREELIST_HARDENED=y
 CONFIG_FORTIFY_SOURCE=y
-CONFIG_GCC_PLUGIN_STACKLEAK=y
+CONFIG_STACKLEAK=y
 CONFIG_HARDENED_USERCOPY=y
 CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
 CONFIG_INIT_ON_FREE_DEFAULT_ON=y
-- 
2.34.1


