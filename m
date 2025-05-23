Return-Path: <linux-kselftest+bounces-33563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E99FAAC1B25
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 06:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366294A7412
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 04:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2CF225771;
	Fri, 23 May 2025 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjCSBxXm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06CF221F3C;
	Fri, 23 May 2025 04:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975179; cv=none; b=cjm5rVCNaWOPPYyIbw+k7uOvmteN7jAqbGyNskjM/iaSFeMH2wUiEZeMadHgWFAsNnipwd25Njg19FIJKq7z+bCaGG80GNB/JGeuLe78ZwVHfIdd6efSpQSplEiA7+Kpyzhpa1TnHkmSRkmn+8k3QUJjVF1afxV6P5yAiB+aXS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975179; c=relaxed/simple;
	bh=eWRsrdfChO/6nxvZ/lswGVHEy8N01D610T/TBTk48qM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lmIEFkszqDMNlPfYhtzlGDM/oQ0rk2oUGDxsN11t8MGrGpre/XHrbToUoAawOjzzqlCjHV4rOMWEsZPnL4+kbmw6gvp+NklnAOdn0QhHl2u/ngZm2WnNL2ZjnW0LnDx7n1xZ6HELbY/244UiH7shkL9VIO+e+uYfzjCXLOpqZpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjCSBxXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EEFC4AF0C;
	Fri, 23 May 2025 04:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747975178;
	bh=eWRsrdfChO/6nxvZ/lswGVHEy8N01D610T/TBTk48qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjCSBxXmKoLIvGzuYzdrJxrUW2Pn1sN+VdT+glZSg8upLU1buKOvtJ0jDyYHkyRC8
	 rbUeiDxYKNJZdp1b+KiPBV3oZWLYv7LGJeAP6S0TQIocjdLTJBC0CXZ7ZbbeBTsM6Q
	 etBDmsVwaKJb4EBKJc7n1wGJI4h3obI/UJuRxUGE4T6a7PUGH6GsiBLM8yaiBMHb9+
	 KZslTo25Fr9aUyxPprgaaSG2uy+W3GGDbVRxMZPZ41pHxhFqsfrKP2+IIvmLl/2gDy
	 xA0wniIv6U/4tAql2zhNm3No9CQDyGhlLw+W+o/ulFycARb4CjzKPBGRhP58+OTB7b
	 hGDqoD8cFuFlQ==
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
Subject: [PATCH v2 03/14] stackleak: Split KSTACK_ERASE_CFLAGS from GCC_PLUGINS_CFLAGS
Date: Thu, 22 May 2025 21:39:13 -0700
Message-Id: <20250523043935.2009972-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523043251.it.550-kees@kernel.org>
References: <20250523043251.it.550-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8284; i=kees@kernel.org; h=from:subject; bh=eWRsrdfChO/6nxvZ/lswGVHEy8N01D610T/TBTk48qM=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn6v3/M4L5kqPDWsu/D37Zj0uE23tMv7z9xqLl0obbR+ wjWeMOQjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIlMvMvIcNd8c+86HffiN8rJ 6+ySOnSmXdo/9UVUUNSN5YdjJ+qlT2D4KxV5LlhZ/0ta26qZV/m37FOc21Y3qSawPO71I96NVns +MgMA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for Clang stack depth tracking for KSTACK_ERASE,
split the stackleak-specific cflags out of GCC_PLUGINS_CFLAGS into
KSTACK_ERASE_CFLAGS.

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
 scripts/Makefile.kstack_erase   | 15 +++++++++++++++
 MAINTAINERS                     |  2 ++
 8 files changed, 27 insertions(+), 18 deletions(-)
 create mode 100644 scripts/Makefile.kstack_erase

diff --git a/Makefile b/Makefile
index 4bfac7e00d2b..4c9e4b5ec36c 100644
--- a/Makefile
+++ b/Makefile
@@ -1086,6 +1086,7 @@ include-$(CONFIG_KMSAN)		+= scripts/Makefile.kmsan
 include-$(CONFIG_UBSAN)		+= scripts/Makefile.ubsan
 include-$(CONFIG_KCOV)		+= scripts/Makefile.kcov
 include-$(CONFIG_RANDSTRUCT)	+= scripts/Makefile.randstruct
+include-$(CONFIG_KSTACK_ERASE)	+= scripts/Makefile.kstack_erase
 include-$(CONFIG_AUTOFDO_CLANG)	+= scripts/Makefile.autofdo
 include-$(CONFIG_PROPELLER_CLANG)	+= scripts/Makefile.propeller
 include-$(CONFIG_GCC_PLUGINS)	+= scripts/Makefile.gcc-plugins
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index cb044bfd145d..cf8cd39ab804 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -26,7 +26,7 @@ CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 CFLAGS_REMOVE_vdso.o = -pg
 
 # Force -O2 to avoid libgcc dependencies
-CFLAGS_REMOVE_vgettimeofday.o = -pg -Os $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS)
+CFLAGS_REMOVE_vgettimeofday.o = -pg -Os $(RANDSTRUCT_CFLAGS) $(KSTACK_ERASE_CFLAGS) $(GCC_PLUGINS_CFLAGS)
 ifeq ($(c-gettimeofday-y),)
 CFLAGS_vgettimeofday.o = -O2
 else
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 5e27e46aa496..7dec05dd33b7 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -36,7 +36,8 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 # -Wmissing-prototypes and -Wmissing-declarations are removed from
 # the CFLAGS to make possible to build the kernel with CONFIG_WERROR enabled.
 CC_FLAGS_REMOVE_VDSO := $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
-			$(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
+			$(RANDSTRUCT_CFLAGS) $(KSTACK_ERASE_CFLAGS) \
+			$(GCC_PLUGINS_CFLAGS) \
 			$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
 			-Wmissing-prototypes -Wmissing-declarations
 
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index fdc4a8f5a49c..683b2d408224 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -48,7 +48,7 @@ CFL := $(PROFILING) -mcmodel=medlow -fPIC -O2 -fasynchronous-unwind-tables -m64
 
 SPARC_REG_CFLAGS = -ffixed-g4 -ffixed-g5 $(call cc-option,-fcall-used-g5) $(call cc-option,-fcall-used-g7)
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(SPARC_REG_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(RANDSTRUCT_CFLAGS) $(KSTACK_ERASE_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(SPARC_REG_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -79,6 +79,7 @@ KBUILD_CFLAGS_32 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_32 := $(filter-out -mcmodel=medlow,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RANDSTRUCT_CFLAGS),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(KSTACK_ERASE_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(SPARC_REG_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -fpic
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 54d3e9774d62..f247f5f5cb44 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -62,7 +62,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(PADDING_CFLAGS) $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(PADDING_CFLAGS) $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(RANDSTRUCT_CFLAGS) $(KSTACK_ERASE_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 $(vobjs): KBUILD_AFLAGS += -DBUILD_VDSO
 
 #
@@ -123,6 +123,7 @@ KBUILD_CFLAGS_32 := $(filter-out -mcmodel=kernel,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RANDSTRUCT_CFLAGS),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(KSTACK_ERASE_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 28b8867c4e84..b0e1423b09c2 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -8,20 +8,6 @@ ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
 endif
 export DISABLE_LATENT_ENTROPY_PLUGIN
 
-gcc-plugin-$(CONFIG_GCC_PLUGIN_STACKLEAK)	+= stackleak_plugin.so
-gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
-		+= -DSTACKLEAK_PLUGIN
-gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
-		+= -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_KSTACK_ERASE_TRACK_MIN_SIZE)
-gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
-		+= -fplugin-arg-stackleak_plugin-arch=$(SRCARCH)
-gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE)	\
-		+= -fplugin-arg-stackleak_plugin-verbose
-ifdef CONFIG_GCC_PLUGIN_STACKLEAK
-    DISABLE_KSTACK_ERASE += -fplugin-arg-stackleak_plugin-disable
-endif
-export DISABLE_KSTACK_ERASE
-
 # All the plugin CFLAGS are collected here in case a build target needs to
 # filter them out of the KBUILD_CFLAGS.
 GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y)) -DGCC_PLUGINS
@@ -34,6 +20,8 @@ KBUILD_CFLAGS += $(GCC_PLUGINS_CFLAGS)
 # be included in GCC_PLUGIN so they can get built.
 gcc-plugin-external-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)		\
 	+= randomize_layout_plugin.so
+gcc-plugin-external-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
+	+= stackleak_plugin.so
 
 # All enabled GCC plugins are collected here for building in
 # scripts/gcc-scripts/Makefile.
diff --git a/scripts/Makefile.kstack_erase b/scripts/Makefile.kstack_erase
new file mode 100644
index 000000000000..5223d3a35817
--- /dev/null
+++ b/scripts/Makefile.kstack_erase
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+kstack-erase-cflags-y += -fplugin=$(objtree)/scripts/gcc-plugins/stackleak_plugin.so
+kstack-erase-cflags-y += -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_KSTACK_ERASE_TRACK_MIN_SIZE)
+kstack-erase-cflags-y += -fplugin-arg-stackleak_plugin-arch=$(SRCARCH)
+kstack-erase-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE) += -fplugin-arg-stackleak_plugin-verbose
+DISABLE_KSTACK_ERASE := -fplugin-arg-stackleak_plugin-disable
+endif
+
+KSTACK_ERASE_CFLAGS   := $(kstack-erase-cflags-y)
+
+export STACKLEAK_CFLAGS DISABLE_KSTACK_ERASE
+
+KBUILD_CFLAGS += $(KSTACK_ERASE_CFLAGS)
diff --git a/MAINTAINERS b/MAINTAINERS
index 9f76b329fdb3..f4dcf3c0be8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13067,6 +13067,8 @@ F:	kernel/kstack_erase.c
 F:	lib/tests/randstruct_kunit.c
 F:	lib/tests/usercopy_kunit.c
 F:	mm/usercopy.c
+F:	scripts/Makefile.kstack_erase
+F:	scripts/Makefile.randstruct
 F:	security/Kconfig.hardening
 K:	\b(add|choose)_random_kstack_offset\b
 K:	\b__check_(object_size|heap_object)\b
-- 
2.34.1


