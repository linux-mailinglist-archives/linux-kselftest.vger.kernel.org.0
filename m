Return-Path: <linux-kselftest+bounces-37526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C51B09753
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476A44A72C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F241C24EA8D;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7idVzHj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A50B241667;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794720; cv=none; b=C2QOdPOAl2SM+BZlSwm1KuN4+nMb/NVuMMF4w2TE29numcdTBgWokN3k5l22CiJVz4DBd5KO7PwLD4yt8Tr9QK23IdZ04BhKdMrQwQQAbvak1+7mO49mlzOLdSuI2wSaKN7ylBhGDna+X7v5Z1z7U1P4zEVZAGxL36j8ZwJ1FfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794720; c=relaxed/simple;
	bh=1YRtnYELK8wt+w3+2tTU3u9v9uUB1wW6aJSjY5OZF78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CS5mXBatp5AMyXhXZ4itu3F4rfbNukpdtslUXxw64A7T3ZvGagt/DKmn6dXd2bBIrhRDklsTX2oVCteNzsS7M7Y+x9W98a2Ekc/fQnE0f13wVw386CJaz80e6HbTpL1op2EAdw0i8IEy/gbdEM9kTxMG26CUtmsBuTRhImsQiOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7idVzHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268F0C4CEE3;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794720;
	bh=1YRtnYELK8wt+w3+2tTU3u9v9uUB1wW6aJSjY5OZF78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7idVzHjnPVSvAKlTG/s5HVoMh/LvSx8dHMotIRdXzulk4yGpBxLmlZQ0RXbn+EfQ
	 m65/hoobNpgsJ6NT9v6XF5grCu0CBGfQUdC3gwMC0rykI5zkQs/mUmt0JyhO5IU/c9
	 pgd6JfiY3bTtHPPFjW9iqCMLp6MJhYabVzai6dBm4VQMDKZ+tCykm2Yfkrc5KmGFhz
	 0Ai5a2SmOT3F6Iu09hectGxCk/ejr0MqmA39VjZkQE/wFLHSzfNu4yggTlFbFKjoxG
	 uZXX+y4D6hMfgUGSdX36dI09GumWs2Uf2g1OlxKPF5Mb3p1Uf//4Eoy4coaxFs8h0Y
	 y9+3unVl0iWWg==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
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
Subject: [PATCH v3 01/13] stackleak: Rename STACKLEAK to KSTACK_ERASE
Date: Thu, 17 Jul 2025 16:25:06 -0700
Message-Id: <20250717232519.2984886-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717231756.make.423-kees@kernel.org>
References: <20250717231756.make.423-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=36008; i=kees@kernel.org; h=from:subject; bh=1YRtnYELK8wt+w3+2tTU3u9v9uUB1wW6aJSjY5OZF78=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmVbZElLCsS/1w921YY9Opshp+zoqGyW1B3gdDsqTLO3 /InuK/rKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmEjLA0aGPX2Hgutizqzyn1Cl ypfWKv/lrvaP47XM7L2swgfMEosPMPyVOLn5jsbsmWbVUdbJHxQdIif6HJnQeF6dMdV9EWtHfiQ 7AA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In preparation for adding Clang sanitizer coverage stack depth tracking
that can support stack depth callbacks:

- Add the new top-level CONFIG_KSTACK_ERASE option which will be
  implemented either with the stackleak GCC plugin, or with the Clang
  stack depth callback support.
- Rename CONFIG_GCC_PLUGIN_STACKLEAK as needed to CONFIG_KSTACK_ERASE,
  but keep it for anything specific to the GCC plugin itself.
- Rename all exposed "STACKLEAK" names and files to "KSTACK_ERASE" (named
  for what it does rather than what it protects against), but leave as
  many of the internals alone as possible to avoid even more churn.

While here, also split "prev_lowest_stack" into CONFIG_KSTACK_ERASE_METRICS,
since that's the only place it is referenced from.

Suggested-by: Ingo Molnar <mingo@kernel.org>
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
 arch/Kconfig                                  |  4 +--
 arch/arm/Kconfig                              |  2 +-
 arch/arm64/Kconfig                            |  2 +-
 arch/riscv/Kconfig                            |  2 +-
 arch/s390/Kconfig                             |  2 +-
 arch/x86/Kconfig                              |  2 +-
 security/Kconfig.hardening                    | 36 ++++++++++---------
 arch/arm/boot/compressed/Makefile             |  2 +-
 arch/arm64/kernel/pi/Makefile                 |  2 +-
 arch/arm64/kvm/hyp/nvhe/Makefile              |  2 +-
 arch/riscv/kernel/pi/Makefile                 |  2 +-
 arch/riscv/purgatory/Makefile                 |  2 +-
 arch/x86/purgatory/Makefile                   |  2 +-
 drivers/firmware/efi/libstub/Makefile         |  8 ++---
 drivers/misc/lkdtm/Makefile                   |  2 +-
 kernel/Makefile                               | 10 +++---
 lib/Makefile                                  |  2 +-
 scripts/Makefile.gcc-plugins                  |  6 ++--
 Documentation/admin-guide/sysctl/kernel.rst   |  4 +--
 Documentation/arch/x86/x86_64/mm.rst          |  2 +-
 Documentation/security/self-protection.rst    |  2 +-
 .../zh_CN/security/self-protection.rst        |  2 +-
 arch/x86/entry/calling.h                      |  4 +--
 include/linux/{stackleak.h => kstack_erase.h} | 18 +++++-----
 include/linux/sched.h                         |  4 ++-
 arch/arm/kernel/entry-common.S                |  2 +-
 arch/arm64/kernel/entry.S                     |  2 +-
 arch/riscv/kernel/entry.S                     |  2 +-
 arch/s390/kernel/entry.S                      |  2 +-
 .../lkdtm/{stackleak.c => kstack_erase.c}     | 26 +++++++-------
 fs/proc/base.c                                |  6 ++--
 kernel/fork.c                                 |  2 +-
 kernel/{stackleak.c => kstack_erase.c}        | 18 +++++-----
 tools/objtool/check.c                         |  2 +-
 tools/testing/selftests/lkdtm/config          |  2 +-
 MAINTAINERS                                   |  4 +--
 36 files changed, 100 insertions(+), 94 deletions(-)
 rename include/linux/{stackleak.h => kstack_erase.h} (85%)
 rename drivers/misc/lkdtm/{stackleak.c => kstack_erase.c} (89%)
 rename kernel/{stackleak.c => kstack_erase.c} (90%)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9233fbfd8dd3..e133c7d1b48f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -639,11 +639,11 @@ config SECCOMP_CACHE_DEBUG
 
 	  If unsure, say N.
 
-config HAVE_ARCH_STACKLEAK
+config HAVE_ARCH_KSTACK_ERASE
 	bool
 	help
 	  An architecture should select this if it has the code which
-	  fills the used part of the kernel stack with the STACKLEAK_POISON
+	  fills the used part of the kernel stack with the KSTACK_ERASE_POISON
 	  value before returning from system calls.
 
 config HAVE_STACKPROTECTOR
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c531b49aa98e..e4c52d736dcd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -85,11 +85,11 @@ config ARM
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
 	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
+	select HAVE_ARCH_KSTACK_ERASE
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_PFN_VALID
 	select HAVE_ARCH_SECCOMP
 	select HAVE_ARCH_SECCOMP_FILTER if AEABI && !OABI_COMPAT
-	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARM_LPAE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index dac3d79eaf54..fa3fef014550 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -184,12 +184,12 @@ config ARM64
 	select HAVE_ARCH_KCSAN if EXPERT
 	select HAVE_ARCH_KFENCE
 	select HAVE_ARCH_KGDB
+	select HAVE_ARCH_KSTACK_ERASE
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
-	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9bbe3e7b6a76..32771175fddf 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -133,13 +133,13 @@ config RISCV
 	select HAVE_ARCH_KASAN if MMU && 64BIT
 	select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
 	select HAVE_ARCH_KFENCE if MMU && 64BIT
+	select HAVE_ARCH_KSTACK_ERASE
 	select HAVE_ARCH_KGDB if !XIP_KERNEL
 	select HAVE_ARCH_KGDB_QXFER_PKT
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
-	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8f44bf7e71d6..fdf981c95a64 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -176,10 +176,10 @@ config S390
 	select HAVE_ARCH_KCSAN
 	select HAVE_ARCH_KMSAN
 	select HAVE_ARCH_KFENCE
+	select HAVE_ARCH_KSTACK_ERASE
 	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_SOFT_DIRTY
-	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_VMAP_STACK
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ee48240da6aa..8b6451cf2882 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -200,13 +200,13 @@ config X86
 	select HAVE_ARCH_KFENCE
 	select HAVE_ARCH_KMSAN			if X86_64
 	select HAVE_ARCH_KGDB
+	select HAVE_ARCH_KSTACK_ERASE
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
 	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
 	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
-	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index fd1238753cad..125b35e2ef0f 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -82,10 +82,10 @@ choice
 
 endchoice
 
-config GCC_PLUGIN_STACKLEAK
+config KSTACK_ERASE
 	bool "Poison kernel stack before returning from syscalls"
+	depends on HAVE_ARCH_KSTACK_ERASE
 	depends on GCC_PLUGINS
-	depends on HAVE_ARCH_STACKLEAK
 	help
 	  This option makes the kernel erase the kernel stack before
 	  returning from system calls. This has the effect of leaving
@@ -103,6 +103,10 @@ config GCC_PLUGIN_STACKLEAK
 	  are advised to test this feature on your expected workload before
 	  deploying it.
 
+config GCC_PLUGIN_STACKLEAK
+	def_bool KSTACK_ERASE
+	depends on GCC_PLUGINS
+	help
 	  This plugin was ported from grsecurity/PaX. More information at:
 	   * https://grsecurity.net/
 	   * https://pax.grsecurity.net/
@@ -117,37 +121,37 @@ config GCC_PLUGIN_STACKLEAK_VERBOSE
 	  instrumented. This is useful for comparing coverage between
 	  builds.
 
-config STACKLEAK_TRACK_MIN_SIZE
-	int "Minimum stack frame size of functions tracked by STACKLEAK"
+config KSTACK_ERASE_TRACK_MIN_SIZE
+	int "Minimum stack frame size of functions tracked by KSTACK_ERASE"
 	default 100
 	range 0 4096
-	depends on GCC_PLUGIN_STACKLEAK
+	depends on KSTACK_ERASE
 	help
-	  The STACKLEAK gcc plugin instruments the kernel code for tracking
+	  The KSTACK_ERASE option instruments the kernel code for tracking
 	  the lowest border of the kernel stack (and for some other purposes).
 	  It inserts the stackleak_track_stack() call for the functions with
 	  a stack frame size greater than or equal to this parameter.
 	  If unsure, leave the default value 100.
 
-config STACKLEAK_METRICS
-	bool "Show STACKLEAK metrics in the /proc file system"
-	depends on GCC_PLUGIN_STACKLEAK
+config KSTACK_ERASE_METRICS
+	bool "Show KSTACK_ERASE metrics in the /proc file system"
+	depends on KSTACK_ERASE
 	depends on PROC_FS
 	help
-	  If this is set, STACKLEAK metrics for every task are available in
-	  the /proc file system. In particular, /proc/<pid>/stack_depth
+	  If this is set, KSTACK_ERASE metrics for every task are available
+	  in the /proc file system. In particular, /proc/<pid>/stack_depth
 	  shows the maximum kernel stack consumption for the current and
 	  previous syscalls. Although this information is not precise, it
-	  can be useful for estimating the STACKLEAK performance impact for
-	  your workloads.
+	  can be useful for estimating the KSTACK_ERASE performance impact
+	  for your workloads.
 
-config STACKLEAK_RUNTIME_DISABLE
+config KSTACK_ERASE_RUNTIME_DISABLE
 	bool "Allow runtime disabling of kernel stack erasing"
-	depends on GCC_PLUGIN_STACKLEAK
+	depends on KSTACK_ERASE
 	help
 	  This option provides 'stack_erasing' sysctl, which can be used in
 	  runtime to control kernel stack erasing for kernels built with
-	  CONFIG_GCC_PLUGIN_STACKLEAK.
+	  CONFIG_KSTACK_ERASE.
 
 config INIT_ON_ALLOC_DEFAULT_ON
 	bool "Enable heap memory zeroing on allocation by default"
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index d61369b1eabe..f9075edfd773 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -9,7 +9,7 @@ OBJS		=
 
 HEAD	= head.o
 OBJS	+= misc.o decompress.o
-CFLAGS_decompress.o += $(DISABLE_STACKLEAK_PLUGIN)
+CFLAGS_decompress.o += $(DISABLE_KSTACK_ERASE)
 ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
 OBJS	+= debug.o
 AFLAGS_head.o += -DDEBUG
diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
index 211e1a79b07a..be92d73c25b2 100644
--- a/arch/arm64/kernel/pi/Makefile
+++ b/arch/arm64/kernel/pi/Makefile
@@ -2,7 +2,7 @@
 # Copyright 2022 Google LLC
 
 KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) -fpie \
-		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN) \
+		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_KSTACK_ERASE) \
 		   $(DISABLE_LATENT_ENTROPY_PLUGIN) \
 		   $(call cc-option,-mbranch-protection=none) \
 		   -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index a76522d63c3e..0b0a68b663d4 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -12,7 +12,7 @@ asflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS -D__DISABLE_TRACE_MMIO__
 ccflags-y += -fno-stack-protector	\
 	     -DDISABLE_BRANCH_PROFILING	\
-	     $(DISABLE_STACKLEAK_PLUGIN)
+	     $(DISABLE_KSTACK_ERASE)
 
 hostprogs := gen-hyprel
 HOST_EXTRACFLAGS += -I$(objtree)/include
diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
index 81d69d45c06c..7dd15be69c90 100644
--- a/arch/riscv/kernel/pi/Makefile
+++ b/arch/riscv/kernel/pi/Makefile
@@ -2,7 +2,7 @@
 # This file was copied from arm64/kernel/pi/Makefile.
 
 KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) -fpie \
-		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN) \
+		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_KSTACK_ERASE) \
 		   $(call cc-option,-mbranch-protection=none) \
 		   -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
 		   -include $(srctree)/include/linux/hidden.h \
diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index fb9c917c9b45..240592e3f5c2 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -53,7 +53,7 @@ targets += purgatory.ro purgatory.chk
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=medany -ffreestanding -fno-zero-initialized-in-bss
-PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
+PURGATORY_CFLAGS += $(DISABLE_KSTACK_ERASE) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector -g0
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index ebdfd7b84feb..e0a607a14e7e 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -35,7 +35,7 @@ targets += purgatory.ro purgatory.chk
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=small -ffreestanding -fno-zero-initialized-in-bss -g0
 PURGATORY_CFLAGS += -fpic -fvisibility=hidden
-PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
+PURGATORY_CFLAGS += $(DISABLE_KSTACK_ERASE) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 939a4955e00b..94b05e4451dd 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -22,16 +22,16 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -std=gnu11 \
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
-cflags-$(CONFIG_ARM64)		+= -fpie $(DISABLE_STACKLEAK_PLUGIN) \
+cflags-$(CONFIG_ARM64)		+= -fpie $(DISABLE_KSTACK_ERASE) \
 				   -fno-unwind-tables -fno-asynchronous-unwind-tables
 cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
 				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
 				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base) \
-				   $(DISABLE_STACKLEAK_PLUGIN)
+				   $(DISABLE_KSTACK_ERASE)
 cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax \
-				   $(DISABLE_STACKLEAK_PLUGIN)
-cflags-$(CONFIG_LOONGARCH)	+= -fpie $(DISABLE_STACKLEAK_PLUGIN)
+				   $(DISABLE_KSTACK_ERASE)
+cflags-$(CONFIG_LOONGARCH)	+= -fpie $(DISABLE_KSTACK_ERASE)
 
 cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
 
diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 39468bd27b85..03ebe33185f9 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -8,7 +8,7 @@ lkdtm-$(CONFIG_LKDTM)		+= perms.o
 lkdtm-$(CONFIG_LKDTM)		+= refcount.o
 lkdtm-$(CONFIG_LKDTM)		+= rodata_objcopy.o
 lkdtm-$(CONFIG_LKDTM)		+= usercopy.o
-lkdtm-$(CONFIG_LKDTM)		+= stackleak.o
+lkdtm-$(CONFIG_LKDTM)		+= kstack_erase.o
 lkdtm-$(CONFIG_LKDTM)		+= cfi.o
 lkdtm-$(CONFIG_LKDTM)		+= fortify.o
 lkdtm-$(CONFIG_PPC_64S_HASH_MMU)	+= powerpc.o
diff --git a/kernel/Makefile b/kernel/Makefile
index c486f17e669a..af0a565a3eaa 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -139,11 +139,11 @@ obj-$(CONFIG_WATCH_QUEUE) += watch_queue.o
 obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
-CFLAGS_stackleak.o += $(DISABLE_STACKLEAK_PLUGIN)
-obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
-KASAN_SANITIZE_stackleak.o := n
-KCSAN_SANITIZE_stackleak.o := n
-KCOV_INSTRUMENT_stackleak.o := n
+CFLAGS_kstack_erase.o += $(DISABLE_KSTACK_ERASE)
+obj-$(CONFIG_KSTACK_ERASE) += kstack_erase.o
+KASAN_SANITIZE_kstack_erase.o := n
+KCSAN_SANITIZE_kstack_erase.o := n
+KCOV_INSTRUMENT_kstack_erase.o := n
 
 obj-$(CONFIG_SCF_TORTURE_TEST) += scftorture.o
 
diff --git a/lib/Makefile b/lib/Makefile
index 3bdcf4b839bb..9cb4bc4a0c7a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -307,7 +307,7 @@ obj-$(CONFIG_UBSAN) += ubsan.o
 UBSAN_SANITIZE_ubsan.o := n
 KASAN_SANITIZE_ubsan.o := n
 KCSAN_SANITIZE_ubsan.o := n
-CFLAGS_ubsan.o := -fno-stack-protector $(DISABLE_STACKLEAK_PLUGIN)
+CFLAGS_ubsan.o := -fno-stack-protector $(DISABLE_KSTACK_ERASE)
 
 obj-$(CONFIG_SBITMAP) += sbitmap.o
 
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 435ab3f0ec44..28b8867c4e84 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -12,15 +12,15 @@ gcc-plugin-$(CONFIG_GCC_PLUGIN_STACKLEAK)	+= stackleak_plugin.so
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
 		+= -DSTACKLEAK_PLUGIN
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
-		+= -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_STACKLEAK_TRACK_MIN_SIZE)
+		+= -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_KSTACK_ERASE_TRACK_MIN_SIZE)
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
 		+= -fplugin-arg-stackleak_plugin-arch=$(SRCARCH)
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE)	\
 		+= -fplugin-arg-stackleak_plugin-verbose
 ifdef CONFIG_GCC_PLUGIN_STACKLEAK
-    DISABLE_STACKLEAK_PLUGIN += -fplugin-arg-stackleak_plugin-disable
+    DISABLE_KSTACK_ERASE += -fplugin-arg-stackleak_plugin-disable
 endif
-export DISABLE_STACKLEAK_PLUGIN
+export DISABLE_KSTACK_ERASE
 
 # All the plugin CFLAGS are collected here in case a build target needs to
 # filter them out of the KBUILD_CFLAGS.
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 95b1cbbd78fc..6255e409cd79 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1480,7 +1480,7 @@ stack_erasing
 =============
 
 This parameter can be used to control kernel stack erasing at the end
-of syscalls for kernels built with ``CONFIG_GCC_PLUGIN_STACKLEAK``.
+of syscalls for kernels built with ``CONFIG_KSTACK_ERASE``.
 
 That erasing reduces the information which kernel stack leak bugs
 can reveal and blocks some uninitialized stack variable attacks.
@@ -1488,7 +1488,7 @@ The tradeoff is the performance impact: on a single CPU system kernel
 compilation sees a 1% slowdown, other systems and workloads may vary.
 
 = ====================================================================
-0 Kernel stack erasing is disabled, STACKLEAK_METRICS are not updated.
+0 Kernel stack erasing is disabled, KSTACK_ERASE_METRICS are not updated.
 1 Kernel stack erasing is enabled (default), it is performed before
   returning to the userspace at the end of syscalls.
 = ====================================================================
diff --git a/Documentation/arch/x86/x86_64/mm.rst b/Documentation/arch/x86/x86_64/mm.rst
index f2db178b353f..a6cf05d51bd8 100644
--- a/Documentation/arch/x86/x86_64/mm.rst
+++ b/Documentation/arch/x86/x86_64/mm.rst
@@ -176,5 +176,5 @@ Be very careful vs. KASLR when changing anything here. The KASLR address
 range must not overlap with anything except the KASAN shadow area, which is
 correct as KASAN disables KASLR.
 
-For both 4- and 5-level layouts, the STACKLEAK_POISON value in the last 2MB
+For both 4- and 5-level layouts, the KSTACK_ERASE_POISON value in the last 2MB
 hole: ffffffffffff4111
diff --git a/Documentation/security/self-protection.rst b/Documentation/security/self-protection.rst
index 910668e665cb..a32ca23c21b0 100644
--- a/Documentation/security/self-protection.rst
+++ b/Documentation/security/self-protection.rst
@@ -303,7 +303,7 @@ Memory poisoning
 
 When releasing memory, it is best to poison the contents, to avoid reuse
 attacks that rely on the old contents of memory. E.g., clear stack on a
-syscall return (``CONFIG_GCC_PLUGIN_STACKLEAK``), wipe heap memory on a
+syscall return (``CONFIG_KSTACK_ERASE``), wipe heap memory on a
 free. This frustrates many uninitialized variable attacks, stack content
 exposures, heap content exposures, and use-after-free attacks.
 
diff --git a/Documentation/translations/zh_CN/security/self-protection.rst b/Documentation/translations/zh_CN/security/self-protection.rst
index 3c8a68b1e1be..93de9cee5c1a 100644
--- a/Documentation/translations/zh_CN/security/self-protection.rst
+++ b/Documentation/translations/zh_CN/security/self-protection.rst
@@ -259,7 +259,7 @@ KALLSYSM，则会直接打印原始地址。
 --------
 
 在释放内存时，最好对内存内容进行清除处理，以防止攻击者重用内存中以前
-的内容。例如，在系统调用返回时清除堆栈（CONFIG_GCC_PLUGIN_STACKLEAK）,
+的内容。例如，在系统调用返回时清除堆栈（CONFIG_KSTACK_ERASE）,
 在释放堆内容是清除其内容。这有助于防止许多未初始化变量攻击、堆栈内容
 泄露、堆内容泄露以及使用后释放攻击（user-after-free）。
 
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index d83236b96f22..94519688b007 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -369,7 +369,7 @@ For 32-bit we have the following conventions - kernel is built with
 .endm
 
 .macro STACKLEAK_ERASE_NOCLOBBER
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+#ifdef CONFIG_KSTACK_ERASE
 	PUSH_AND_CLEAR_REGS
 	call stackleak_erase
 	POP_REGS
@@ -388,7 +388,7 @@ For 32-bit we have the following conventions - kernel is built with
 #endif /* !CONFIG_X86_64 */
 
 .macro STACKLEAK_ERASE
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+#ifdef CONFIG_KSTACK_ERASE
 	call stackleak_erase
 #endif
 .endm
diff --git a/include/linux/stackleak.h b/include/linux/kstack_erase.h
similarity index 85%
rename from include/linux/stackleak.h
rename to include/linux/kstack_erase.h
index 3be2cb564710..4e432eefa4d0 100644
--- a/include/linux/stackleak.h
+++ b/include/linux/kstack_erase.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_STACKLEAK_H
-#define _LINUX_STACKLEAK_H
+#ifndef _LINUX_KSTACK_ERASE_H
+#define _LINUX_KSTACK_ERASE_H
 
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
@@ -9,10 +9,10 @@
  * Check that the poison value points to the unused hole in the
  * virtual memory map for your platform.
  */
-#define STACKLEAK_POISON -0xBEEF
-#define STACKLEAK_SEARCH_DEPTH 128
+#define KSTACK_ERASE_POISON -0xBEEF
+#define KSTACK_ERASE_SEARCH_DEPTH 128
 
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+#ifdef CONFIG_KSTACK_ERASE
 #include <asm/stacktrace.h>
 #include <linux/linkage.h>
 
@@ -50,7 +50,7 @@ stackleak_task_high_bound(const struct task_struct *tsk)
 static __always_inline unsigned long
 stackleak_find_top_of_poison(const unsigned long low, const unsigned long high)
 {
-	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
+	const unsigned int depth = KSTACK_ERASE_SEARCH_DEPTH / sizeof(unsigned long);
 	unsigned int poison_count = 0;
 	unsigned long poison_high = high;
 	unsigned long sp = high;
@@ -58,7 +58,7 @@ stackleak_find_top_of_poison(const unsigned long low, const unsigned long high)
 	while (sp > low && poison_count < depth) {
 		sp -= sizeof(unsigned long);
 
-		if (*(unsigned long *)sp == STACKLEAK_POISON) {
+		if (*(unsigned long *)sp == KSTACK_ERASE_POISON) {
 			poison_count++;
 		} else {
 			poison_count = 0;
@@ -72,7 +72,7 @@ stackleak_find_top_of_poison(const unsigned long low, const unsigned long high)
 static inline void stackleak_task_init(struct task_struct *t)
 {
 	t->lowest_stack = stackleak_task_low_bound(t);
-# ifdef CONFIG_STACKLEAK_METRICS
+# ifdef CONFIG_KSTACK_ERASE_METRICS
 	t->prev_lowest_stack = t->lowest_stack;
 # endif
 }
@@ -82,7 +82,7 @@ asmlinkage void noinstr stackleak_erase_on_task_stack(void);
 asmlinkage void noinstr stackleak_erase_off_task_stack(void);
 void __no_caller_saved_registers noinstr stackleak_track_stack(void);
 
-#else /* !CONFIG_GCC_PLUGIN_STACKLEAK */
+#else /* !CONFIG_KSTACK_ERASE */
 static inline void stackleak_task_init(struct task_struct *t) { }
 #endif
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index db99ffd56c20..8e9cfe89e7fa 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1590,8 +1590,10 @@ struct task_struct {
 	/* Used by BPF for per-TASK xdp storage */
 	struct bpf_net_context		*bpf_net_context;
 
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+#ifdef CONFIG_KSTACK_ERASE
 	unsigned long			lowest_stack;
+#endif
+#ifdef CONFIG_KSTACK_ERASE_METRICS
 	unsigned long			prev_lowest_stack;
 #endif
 
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index f379c852dcb7..88336a1292bb 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -119,7 +119,7 @@ no_work_pending:
 
 	ct_user_enter save = 0
 
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+#ifdef CONFIG_KSTACK_ERASE
 	bl	stackleak_erase_on_task_stack
 #endif
 	restore_user_regs fast = 0, offset = 0
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 5ae2a34b50bd..67331437b2aa 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -614,7 +614,7 @@ SYM_CODE_END(ret_to_kernel)
 SYM_CODE_START_LOCAL(ret_to_user)
 	ldr	x19, [tsk, #TSK_TI_FLAGS]	// re-check for single-step
 	enable_step_tsk x19, x2
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+#ifdef CONFIG_KSTACK_ERASE
 	bl	stackleak_erase_on_task_stack
 #endif
 	kernel_exit 0
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 75656afa2d6b..3a0ec6fd5956 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -220,7 +220,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 #endif
 	bnez s0, 1f
 
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+#ifdef CONFIG_KSTACK_ERASE
 	call	stackleak_erase_on_task_stack
 #endif
 
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 0f00f4b06d51..75b0fbb236d0 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -124,7 +124,7 @@ _LPP_OFFSET	= __LC_LPP
 #endif
 
 	.macro STACKLEAK_ERASE
-#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+#ifdef CONFIG_KSTACK_ERASE
 	brasl	%r14,stackleak_erase_on_task_stack
 #endif
 	.endm
diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/kstack_erase.c
similarity index 89%
rename from drivers/misc/lkdtm/stackleak.c
rename to drivers/misc/lkdtm/kstack_erase.c
index f1d022160913..4fd9b0bfb874 100644
--- a/drivers/misc/lkdtm/stackleak.c
+++ b/drivers/misc/lkdtm/kstack_erase.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * This code tests that the current task stack is properly erased (filled
- * with STACKLEAK_POISON).
+ * with KSTACK_ERASE_POISON).
  *
  * Authors:
  *   Alexander Popov <alex.popov@linux.com>
@@ -9,9 +9,9 @@
  */
 
 #include "lkdtm.h"
-#include <linux/stackleak.h>
+#include <linux/kstack_erase.h>
 
-#if defined(CONFIG_GCC_PLUGIN_STACKLEAK)
+#if defined(CONFIG_KSTACK_ERASE)
 /*
  * Check that stackleak tracks the lowest stack pointer and erases the stack
  * below this as expected.
@@ -85,7 +85,7 @@ static void noinstr check_stackleak_irqoff(void)
 	while (poison_low > task_stack_low) {
 		poison_low -= sizeof(unsigned long);
 
-		if (*(unsigned long *)poison_low == STACKLEAK_POISON)
+		if (*(unsigned long *)poison_low == KSTACK_ERASE_POISON)
 			continue;
 
 		instrumentation_begin();
@@ -96,7 +96,7 @@ static void noinstr check_stackleak_irqoff(void)
 	}
 
 	instrumentation_begin();
-	pr_info("stackleak stack usage:\n"
+	pr_info("kstack erase stack usage:\n"
 		"  high offset: %lu bytes\n"
 		"  current:     %lu bytes\n"
 		"  lowest:      %lu bytes\n"
@@ -121,7 +121,7 @@ static void noinstr check_stackleak_irqoff(void)
 	instrumentation_end();
 }
 
-static void lkdtm_STACKLEAK_ERASING(void)
+static void lkdtm_KSTACK_ERASE(void)
 {
 	unsigned long flags;
 
@@ -129,19 +129,19 @@ static void lkdtm_STACKLEAK_ERASING(void)
 	check_stackleak_irqoff();
 	local_irq_restore(flags);
 }
-#else /* defined(CONFIG_GCC_PLUGIN_STACKLEAK) */
-static void lkdtm_STACKLEAK_ERASING(void)
+#else /* defined(CONFIG_KSTACK_ERASE) */
+static void lkdtm_KSTACK_ERASE(void)
 {
-	if (IS_ENABLED(CONFIG_HAVE_ARCH_STACKLEAK)) {
-		pr_err("XFAIL: stackleak is not enabled (CONFIG_GCC_PLUGIN_STACKLEAK=n)\n");
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_KSTACK_ERASE)) {
+		pr_err("XFAIL: stackleak is not enabled (CONFIG_KSTACK_ERASE=n)\n");
 	} else {
-		pr_err("XFAIL: stackleak is not supported on this arch (HAVE_ARCH_STACKLEAK=n)\n");
+		pr_err("XFAIL: stackleak is not supported on this arch (HAVE_ARCH_KSTACK_ERASE=n)\n");
 	}
 }
-#endif /* defined(CONFIG_GCC_PLUGIN_STACKLEAK) */
+#endif /* defined(CONFIG_KSTACK_ERASE) */
 
 static struct crashtype crashtypes[] = {
-	CRASHTYPE(STACKLEAK_ERASING),
+	CRASHTYPE(KSTACK_ERASE),
 };
 
 struct crashtype_category stackleak_crashtypes = {
diff --git a/fs/proc/base.c b/fs/proc/base.c
index e93149a01341..62d35631ba8c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3290,7 +3290,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 }
 #endif /* CONFIG_KSM */
 
-#ifdef CONFIG_STACKLEAK_METRICS
+#ifdef CONFIG_KSTACK_ERASE_METRICS
 static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
 				struct pid *pid, struct task_struct *task)
 {
@@ -3303,7 +3303,7 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
 							prev_depth, depth);
 	return 0;
 }
-#endif /* CONFIG_STACKLEAK_METRICS */
+#endif /* CONFIG_KSTACK_ERASE_METRICS */
 
 /*
  * Thread groups
@@ -3410,7 +3410,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_LIVEPATCH
 	ONE("patch_state",  S_IRUSR, proc_pid_patch_state),
 #endif
-#ifdef CONFIG_STACKLEAK_METRICS
+#ifdef CONFIG_KSTACK_ERASE_METRICS
 	ONE("stack_depth", S_IRUGO, proc_stack_depth),
 #endif
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
diff --git a/kernel/fork.c b/kernel/fork.c
index fa869f5e5b84..3c31a6f10253 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -93,7 +93,7 @@
 #include <linux/kcov.h>
 #include <linux/livepatch.h>
 #include <linux/thread_info.h>
-#include <linux/stackleak.h>
+#include <linux/kstack_erase.h>
 #include <linux/kasan.h>
 #include <linux/scs.h>
 #include <linux/io_uring.h>
diff --git a/kernel/stackleak.c b/kernel/kstack_erase.c
similarity index 90%
rename from kernel/stackleak.c
rename to kernel/kstack_erase.c
index bb65321761b4..201b846f8345 100644
--- a/kernel/stackleak.c
+++ b/kernel/kstack_erase.c
@@ -6,14 +6,14 @@
  *
  * Author: Alexander Popov <alex.popov@linux.com>
  *
- * STACKLEAK reduces the information which kernel stack leak bugs can
+ * KSTACK_ERASE reduces the information which kernel stack leak bugs can
  * reveal and blocks some uninitialized stack variable attacks.
  */
 
-#include <linux/stackleak.h>
+#include <linux/kstack_erase.h>
 #include <linux/kprobes.h>
 
-#ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
+#ifdef CONFIG_KSTACK_ERASE_RUNTIME_DISABLE
 #include <linux/jump_label.h>
 #include <linux/string_choices.h>
 #include <linux/sysctl.h>
@@ -68,7 +68,7 @@ late_initcall(stackleak_sysctls_init);
 #define skip_erasing()	static_branch_unlikely(&stack_erasing_bypass)
 #else
 #define skip_erasing()	false
-#endif /* CONFIG_STACKLEAK_RUNTIME_DISABLE */
+#endif /* CONFIG_KSTACK_ERASE_RUNTIME_DISABLE */
 
 #ifndef __stackleak_poison
 static __always_inline void __stackleak_poison(unsigned long erase_low,
@@ -91,7 +91,7 @@ static __always_inline void __stackleak_erase(bool on_task_stack)
 	erase_low = stackleak_find_top_of_poison(task_stack_low,
 						 current->lowest_stack);
 
-#ifdef CONFIG_STACKLEAK_METRICS
+#ifdef CONFIG_KSTACK_ERASE_METRICS
 	current->prev_lowest_stack = erase_low;
 #endif
 
@@ -113,7 +113,7 @@ static __always_inline void __stackleak_erase(bool on_task_stack)
 	else
 		erase_high = task_stack_high;
 
-	__stackleak_poison(erase_low, erase_high, STACKLEAK_POISON);
+	__stackleak_poison(erase_low, erase_high, KSTACK_ERASE_POISON);
 
 	/* Reset the 'lowest_stack' value for the next syscall */
 	current->lowest_stack = task_stack_high;
@@ -161,11 +161,11 @@ void __used __no_caller_saved_registers noinstr stackleak_track_stack(void)
 	unsigned long sp = current_stack_pointer;
 
 	/*
-	 * Having CONFIG_STACKLEAK_TRACK_MIN_SIZE larger than
-	 * STACKLEAK_SEARCH_DEPTH makes the poison search in
+	 * Having CONFIG_KSTACK_ERASE_TRACK_MIN_SIZE larger than
+	 * KSTACK_ERASE_SEARCH_DEPTH makes the poison search in
 	 * stackleak_erase() unreliable. Let's prevent that.
 	 */
-	BUILD_BUG_ON(CONFIG_STACKLEAK_TRACK_MIN_SIZE > STACKLEAK_SEARCH_DEPTH);
+	BUILD_BUG_ON(CONFIG_KSTACK_ERASE_TRACK_MIN_SIZE > KSTACK_ERASE_SEARCH_DEPTH);
 
 	/* 'lowest_stack' should be aligned on the register width boundary */
 	sp = ALIGN(sp, sizeof(unsigned long));
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d967ac001498..1b3e6968a82d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1192,7 +1192,7 @@ static const char *uaccess_safe_builtin[] = {
 	"__ubsan_handle_type_mismatch_v1",
 	"__ubsan_handle_shift_out_of_bounds",
 	"__ubsan_handle_load_invalid_value",
-	/* STACKLEAK */
+	/* KSTACK_ERASE */
 	"stackleak_track_stack",
 	/* TRACE_BRANCH_PROFILING */
 	"ftrace_likely_update",
diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index 7afe05e8c4d7..bd09fdaf53e0 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -2,7 +2,7 @@ CONFIG_LKDTM=y
 CONFIG_DEBUG_LIST=y
 CONFIG_SLAB_FREELIST_HARDENED=y
 CONFIG_FORTIFY_SOURCE=y
-CONFIG_GCC_PLUGIN_STACKLEAK=y
+CONFIG_KSTACK_ERASE=y
 CONFIG_HARDENED_USERCOPY=y
 CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
 CONFIG_INIT_ON_FREE_DEFAULT_ON=y
diff --git a/MAINTAINERS b/MAINTAINERS
index efba8922744a..1d8067dd536d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10056,8 +10056,6 @@ L:	linux-hardening@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	Documentation/kbuild/gcc-plugins.rst
-F:	include/linux/stackleak.h
-F:	kernel/stackleak.c
 F:	scripts/Makefile.gcc-plugins
 F:	scripts/gcc-plugins/
 
@@ -13174,10 +13172,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/har
 F:	Documentation/ABI/testing/sysfs-kernel-oops_count
 F:	Documentation/ABI/testing/sysfs-kernel-warn_count
 F:	arch/*/configs/hardening.config
+F:	include/linux/kstack_erase.h
 F:	include/linux/overflow.h
 F:	include/linux/randomize_kstack.h
 F:	include/linux/ucopysize.h
 F:	kernel/configs/hardening.config
+F:	kernel/kstack_erase.c
 F:	lib/tests/randstruct_kunit.c
 F:	lib/tests/usercopy_kunit.c
 F:	mm/usercopy.c
-- 
2.34.1


