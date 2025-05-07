Return-Path: <linux-kselftest+bounces-32595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB57AAE8D5
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 20:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D614A4392
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224CC28ECDE;
	Wed,  7 May 2025 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4eqnIX0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F8528EA69;
	Wed,  7 May 2025 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746641781; cv=none; b=d3UmbsH3spG8+KWu/lVQSgJyc4bZ/ZyVqW7qnDcA7ZyWuVgeZqVy5G1ueOLC/sKEq0c6sGTSuNFBpIjHLj2n/vQHTkRen/sSXUqV56oLCU+H4TOBGhgMlkxy24bIaQWNq67rOfhiMA+ovihPYGJMWrrqEsKfCj1OSxxuoR3ovtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746641781; c=relaxed/simple;
	bh=xnX44A875J5pRQUvuRYdVrdaj7yDpDUw7/gsLr5gEV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EHtXzMtzmCTMjnfW7DvBw0sX4dH2CvIf8TKah2QRPzr8Qg5XPugONCi+nhKjh3BvK6u1z9Y8YfdpGTkunlH/J6CZShRdQ+WI2Z6BaRk0/JuhRmSitNAH2kfxbL0Hlufk9tuR0kRtlxt7O+spEh7I2djmWw6d2PYYRMXYpqQE9jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4eqnIX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED36C4CEE9;
	Wed,  7 May 2025 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746641781;
	bh=xnX44A875J5pRQUvuRYdVrdaj7yDpDUw7/gsLr5gEV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4eqnIX0WcGjfLO8f+lyrjegUMgvsmMLqhO4ll1KzzZYKRzMmi7+eEVKV/+8tvPM5
	 hxrrNbPRWhrJ775N6k+nhWQOPm5h+LlXbfIPGrVGAiii2JAzRq8418udB3prr5lZw+
	 ULHj5lOFTNukYXAeeYvCpd7m1SM7sVvSpEiC6WN4Es69BLf3kK6rKwIBo5UzyB6KjW
	 JpTUcvbeIfzLJ9MFn8nT7ECpHic6sTc3gfp7uCN1GHgA9GsqMPYbft9nTB5BfoxUuz
	 kdFfHxHXiVN6l1iNoodNM/mXFbf6UXVMzigHyw8dFzw3664h/c9kcLohtjOZet7ZQ1
	 L3KyWZ1trbCGg==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	sparclinux@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
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
	linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 5/8] stackleak: Split STACKLEAK_CFLAGS from GCC_PLUGINS_CFLAGS
Date: Wed,  7 May 2025 11:16:11 -0700
Message-Id: <20250507181615.1947159-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507180852.work.231-kees@kernel.org>
References: <20250507180852.work.231-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8800; i=kees@kernel.org; h=from:subject; bh=xnX44A875J5pRQUvuRYdVrdaj7yDpDUw7/gsLr5gEV0=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnSi3P6lfhV/RXS7W7EXssK1NBnXdB5Ysnr/mVB/17fl nyiPW9uRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEQyLjMydM67eeZ867qfzziX yUjOl4pne5p24PVarrW6CwO/xaRWMDIyvKpsa9K/d9l+e0Fs3d97Xkl7JGyWBRS8mL1yzr8DbL3 FfAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for Clang stack depth tracking for stackleak, split the
stackleak-specific cflags out of GCC_PLUGINS_CFLAGS into
STACKLEAK_CFLAGS.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <x86@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <sparclinux@vger.kernel.org>
Cc: <linux-kbuild@vger.kernel.org>
Cc: <linux-hardening@vger.kernel.org>
---
 Makefile                        |  1 +
 arch/arm/vdso/Makefile          |  2 +-
 arch/arm64/kernel/vdso/Makefile |  3 ++-
 arch/sparc/vdso/Makefile        |  3 ++-
 arch/x86/entry/vdso/Makefile    |  3 ++-
 scripts/Makefile.gcc-plugins    | 16 ++--------------
 scripts/Makefile.stackleak      | 15 +++++++++++++++
 MAINTAINERS                     |  6 ++++--
 8 files changed, 29 insertions(+), 20 deletions(-)
 create mode 100644 scripts/Makefile.stackleak

diff --git a/Makefile b/Makefile
index 5aa9ee52a765..1af8dfbcf0af 100644
--- a/Makefile
+++ b/Makefile
@@ -1089,6 +1089,7 @@ include-$(CONFIG_KMSAN)		+= scripts/Makefile.kmsan
 include-$(CONFIG_UBSAN)		+= scripts/Makefile.ubsan
 include-$(CONFIG_KCOV)		+= scripts/Makefile.kcov
 include-$(CONFIG_RANDSTRUCT)	+= scripts/Makefile.randstruct
+include-$(CONFIG_STACKLEAK)	+= scripts/Makefile.stackleak
 include-$(CONFIG_AUTOFDO_CLANG)	+= scripts/Makefile.autofdo
 include-$(CONFIG_PROPELLER_CLANG)	+= scripts/Makefile.propeller
 include-$(CONFIG_GCC_PLUGINS)	+= scripts/Makefile.gcc-plugins
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index cb044bfd145d..f05a27909a76 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -26,7 +26,7 @@ CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 CFLAGS_REMOVE_vdso.o = -pg
 
 # Force -O2 to avoid libgcc dependencies
-CFLAGS_REMOVE_vgettimeofday.o = -pg -Os $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS)
+CFLAGS_REMOVE_vgettimeofday.o = -pg -Os $(RANDSTRUCT_CFLAGS) $(STACKLEAK_CFLAGS) $(GCC_PLUGINS_CFLAGS)
 ifeq ($(c-gettimeofday-y),)
 CFLAGS_vgettimeofday.o = -O2
 else
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 5e27e46aa496..d4f60027f910 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -36,7 +36,8 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 # -Wmissing-prototypes and -Wmissing-declarations are removed from
 # the CFLAGS to make possible to build the kernel with CONFIG_WERROR enabled.
 CC_FLAGS_REMOVE_VDSO := $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
-			$(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
+			$(RANDSTRUCT_CFLAGS) $(STACKLEAK_CFLAGS) \
+			$(GCC_PLUGINS_CFLAGS) \
 			$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
 			-Wmissing-prototypes -Wmissing-declarations
 
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index fdc4a8f5a49c..d0cfaa2f508a 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -48,7 +48,7 @@ CFL := $(PROFILING) -mcmodel=medlow -fPIC -O2 -fasynchronous-unwind-tables -m64
 
 SPARC_REG_CFLAGS = -ffixed-g4 -ffixed-g5 $(call cc-option,-fcall-used-g5) $(call cc-option,-fcall-used-g7)
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(SPARC_REG_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(RANDSTRUCT_CFLAGS) $(STACKLEAK_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(SPARC_REG_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -79,6 +79,7 @@ KBUILD_CFLAGS_32 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_32 := $(filter-out -mcmodel=medlow,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RANDSTRUCT_CFLAGS),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(STACKLEAK_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(SPARC_REG_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -fpic
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 54d3e9774d62..9e912b6a889c 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -62,7 +62,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(PADDING_CFLAGS) $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(PADDING_CFLAGS) $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(RANDSTRUCT_CFLAGS) $(STACKLEAK_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 $(vobjs): KBUILD_AFLAGS += -DBUILD_VDSO
 
 #
@@ -123,6 +123,7 @@ KBUILD_CFLAGS_32 := $(filter-out -mcmodel=kernel,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RANDSTRUCT_CFLAGS),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(STACKLEAK_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 33ddf5bfda34..e27ffe8e7c75 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -22,20 +22,6 @@ export DISABLE_STRUCTLEAK_PLUGIN
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)		\
 		+= -DSTRUCTLEAK_PLUGIN
 
-gcc-plugin-$(CONFIG_GCC_PLUGIN_STACKLEAK)	+= stackleak_plugin.so
-gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
-		+= -DSTACKLEAK_PLUGIN
-gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
-		+= -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_STACKLEAK_TRACK_MIN_SIZE)
-gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
-		+= -fplugin-arg-stackleak_plugin-arch=$(SRCARCH)
-gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE)	\
-		+= -fplugin-arg-stackleak_plugin-verbose
-ifdef CONFIG_GCC_PLUGIN_STACKLEAK
-    DISABLE_STACKLEAK += -fplugin-arg-stackleak_plugin-disable
-endif
-export DISABLE_STACKLEAK
-
 # All the plugin CFLAGS are collected here in case a build target needs to
 # filter them out of the KBUILD_CFLAGS.
 GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y)) -DGCC_PLUGINS
@@ -50,6 +36,8 @@ gcc-plugin-external-$(CONFIG_GCC_PLUGIN_SANCOV)			\
 	+= sancov_plugin.so
 gcc-plugin-external-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)		\
 	+= randomize_layout_plugin.so
+gcc-plugin-external-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
+	+= stackleak_plugin.so
 
 # All enabled GCC plugins are collected here for building in
 # scripts/gcc-scripts/Makefile.
diff --git a/scripts/Makefile.stackleak b/scripts/Makefile.stackleak
new file mode 100644
index 000000000000..1db0835b29d4
--- /dev/null
+++ b/scripts/Makefile.stackleak
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+stackleak-cflags-y += -fplugin=$(objtree)/scripts/gcc-plugins/stackleak_plugin.so
+stackleak-cflags-y += -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_STACKLEAK_TRACK_MIN_SIZE)
+stackleak-cflags-y += -fplugin-arg-stackleak_plugin-arch=$(SRCARCH)
+stackleak-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE) += -fplugin-arg-stackleak_plugin-verbose
+DISABLE_STACKLEAK  := -fplugin-arg-stackleak_plugin-disable
+endif
+
+STACKLEAK_CFLAGS   := $(stackleak-cflags-y)
+
+export STACKLEAK_CFLAGS DISABLE_STACKLEAK
+
+KBUILD_CFLAGS += $(STACKLEAK_CFLAGS)
diff --git a/MAINTAINERS b/MAINTAINERS
index dc535c67a745..9a2be2dd96c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9827,8 +9827,6 @@ L:	linux-hardening@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	Documentation/kbuild/gcc-plugins.rst
-F:	include/linux/stackleak.h
-F:	kernel/stackleak.c
 F:	scripts/Makefile.gcc-plugins
 F:	scripts/gcc-plugins/
 
@@ -12890,11 +12888,15 @@ F:	Documentation/ABI/testing/sysfs-kernel-warn_count
 F:	arch/*/configs/hardening.config
 F:	include/linux/overflow.h
 F:	include/linux/randomize_kstack.h
+F:	include/linux/stackleak.h
 F:	include/linux/ucopysize.h
 F:	kernel/configs/hardening.config
+F:	kernel/stackleak.c
 F:	lib/tests/randstruct_kunit.c
 F:	lib/tests/usercopy_kunit.c
 F:	mm/usercopy.c
+F:	scripts/Makefile.randstruct
+F:	scripts/Makefile.stackleak
 F:	security/Kconfig.hardening
 K:	\b(add|choose)_random_kstack_offset\b
 K:	\b__check_(object_size|heap_object)\b
-- 
2.34.1


