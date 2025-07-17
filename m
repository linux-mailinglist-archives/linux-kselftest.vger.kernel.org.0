Return-Path: <linux-kselftest+bounces-37528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E433EB0976D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B374A71A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ECD259CBD;
	Thu, 17 Jul 2025 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tk4wrPxY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997F924503B;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794720; cv=none; b=osRh1dfIuCNR7jsVqIO8yqA1rR+y1lbdO9L9rahqkv6kcuA/ZfhXLLGF5RtHqimhO8HQlze2MfN/U3y6NmsUPNpyAP08MxIps9t4k5tGY4eecMe8PdyacebZb+iy2vI4gb+xdsa+uMjy3QUFy943czjPd/EBsEvRUDdRNAV04MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794720; c=relaxed/simple;
	bh=AbRY71s+EYNiungngyC7ql9fgU96lmuco+up3sBxJKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=is24hXtVh5MIhvFL96DKwkkA5u4lFSLCHDQh+NpxLxBr5Gt09q6f1404/kSbYbBNBY1Nw8h9f2Gwd+54B+Br1BvpLc4CAn7H4KAAFp549YIoIm1oas+ojzbiGIpQk4L9qBaGtkdqc07ba46TAgFdXIhSNh7OUxGvVFRrMHIw8xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tk4wrPxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF6EC4CEF4;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794720;
	bh=AbRY71s+EYNiungngyC7ql9fgU96lmuco+up3sBxJKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tk4wrPxY4xFasJDsLgPXZiDP5blWgzYMDheYlFOI3Ju/EqOSXUYvBq30aCZfRjcPX
	 hmbn9bM3ZH61MbdILD+3+XSM7QH8infrZsAiArbeSuv2uwWjadtfWXibU8cYRN1Zrk
	 hxKPB23rgd+/094VKryq4C5XTw9v01nV4e03ySc/er5H38eMGn6q4BB7JtzkwJu52C
	 ksiAi6wTNgRzMPBwuURKy8mKBt+bvPmb2LwkeFjC+hXr84tP+WhCBuCsiC2SvlTBzZ
	 rJj2W774YJpDD1lO8AdnP9gfHjS8XNe6i5qfibge3uMhwu/LgVMSUTfsuY7CNFnH//
	 vLX7oPs/geepg==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	sparclinux@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
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
	linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v3 03/13] stackleak: Split KSTACK_ERASE_CFLAGS from GCC_PLUGINS_CFLAGS
Date: Thu, 17 Jul 2025 16:25:08 -0700
Message-Id: <20250717232519.2984886-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717231756.make.423-kees@kernel.org>
References: <20250717231756.make.423-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8284; i=kees@kernel.org; h=from:subject; bh=AbRY71s+EYNiungngyC7ql9fgU96lmuco+up3sBxJKI=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmVbVFenPsnHmi0VJtRt3zfxZoThbLc+w/fuHDtsa1Lj DZvwOTHHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABfJYWQ4wpYXdVeFRXKb/qJP i6Mbvpg5Kx+RuNVw5v27mZmOGhf+MTLMt4uVMb7Dq+vSeDTycn9P5unzVarG7qGaH02nTeEQqeU DAA==
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
index c18d8b64f0e6..d6c0287a061f 100644
--- a/Makefile
+++ b/Makefile
@@ -1092,6 +1092,7 @@ include-$(CONFIG_KMSAN)		+= scripts/Makefile.kmsan
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
index 1d8067dd536d..cc7d7b779eb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13181,6 +13181,8 @@ F:	kernel/kstack_erase.c
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


