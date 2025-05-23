Return-Path: <linux-kselftest+bounces-33569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18131AC1B3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 06:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946191BA65DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 04:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1640425DD09;
	Fri, 23 May 2025 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuoIUYt5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDBB2505A9;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975181; cv=none; b=RualcrJO2mjxSdjwFmA8q/zERPESuE0POeZxOCnp3/15LsrQuXqmwFGcGYiReqPu+hDspe5HSHKZQed04zPmiCQcXNFE4JHCTHVCIDMwEuMD431EEbSLJ1zmeJxKM9wXMMEVIMxEW+WMnmLTqzTpKzaNFkkQx9nsKtjP0GFwkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975181; c=relaxed/simple;
	bh=p+7YUBTmffdnZ8pKAPuZ2rzC3Zvp9P0MFRgY7Xz1ydU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YOBMyqaK3xMRf7lcXHCP6VMjYpbynnTLVXCXSCE7KckyG6b1E3/NBw4vbB9D8CMN2KEf09+9+cKQVM9QeZARzpebKAiImtxmHH7g9dKfrWW9fr5QBUTi2grCyJ8UbbLLu30YdYA6G1FvnjFS2s3LuHI8NrpyU7xyj1xOzw+n5Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuoIUYt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37879C4AF09;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747975181;
	bh=p+7YUBTmffdnZ8pKAPuZ2rzC3Zvp9P0MFRgY7Xz1ydU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cuoIUYt5lZT/MOb5bo+IaJ7aQ3M00dLryP3hUiTSuemr+Glf19Mqt9NCJ7hvzcGA8
	 cF6XXsa9V8bFu81nQe8KR17Go7G/c1wTpTz+HnOv+456DDqlf5145g9eKiconkOAhz
	 l4QndzvhhW3ELKWijIE2p1gBkE2eVtJAW19EridJn5a4hpye1jt2OTnUmVBXTxLD/F
	 kaPldkcRShipvrgSO1ODJHLlAGizRNTFYqWNtGcCgfWKe1QaSTl7fIOF4jpwa+gF2e
	 LBYHB8dyw1Ajs2TM/20TZSefBCyBo5opbte97pHeo20nA0S2wVguHNFvVg25EUr92m
	 95IVkUtrl6qVQ==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kbuild@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 12/14] kstack_erase: Support Clang stack depth tracking
Date: Thu, 22 May 2025 21:39:22 -0700
Message-Id: <20250523043935.2009972-12-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523043251.it.550-kees@kernel.org>
References: <20250523043251.it.550-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2299; i=kees@kernel.org; h=from:subject; bh=p+7YUBTmffdnZ8pKAPuZ2rzC3Zvp9P0MFRgY7Xz1ydU=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn6v3/vPnPUwKQyTLv6YDRX59942Z9pVg4x/Z3tr6sPL i8Lmbqoo5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCIh3gy/2RSNKlmvL8m9MY2r Wbrn3fITnxd82hB9cYHtv/Cm+4suZTMyPNm8de0lHpnV+k8jWq5Yr/ylxKmUuEhjp6St9pbzk2V 2cwEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Wire up CONFIG_KSTACK_ERASE to Clang 21's new stack depth tracking
callback[1] option.

Link: https://clang.llvm.org/docs/SanitizerCoverage.html#tracing-stack-depth [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas.schier@linux.dev>
Cc: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: <linux-kbuild@vger.kernel.org>
Cc: <kasan-dev@googlegroups.com>
Cc: <linux-hardening@vger.kernel.org>
---
 security/Kconfig.hardening    | 5 ++++-
 scripts/Makefile.kstack_erase | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index f7aa2024ab25..b9a5bc3430aa 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -82,10 +82,13 @@ choice
 
 endchoice
 
+config CC_HAS_SANCOV_STACK_DEPTH_CALLBACK
+	def_bool $(cc-option,-fsanitize-coverage-stack-depth-callback-min=1)
+
 config KSTACK_ERASE
 	bool "Poison kernel stack before returning from syscalls"
 	depends on HAVE_ARCH_KSTACK_ERASE
-	depends on GCC_PLUGINS
+	depends on GCC_PLUGINS || CC_HAS_SANCOV_STACK_DEPTH_CALLBACK
 	help
 	  This option makes the kernel erase the kernel stack before
 	  returning from system calls. This has the effect of leaving
diff --git a/scripts/Makefile.kstack_erase b/scripts/Makefile.kstack_erase
index 5223d3a35817..c7bc2379e113 100644
--- a/scripts/Makefile.kstack_erase
+++ b/scripts/Makefile.kstack_erase
@@ -8,6 +8,12 @@ kstack-erase-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK_VERBOSE) += -fplugin-arg-stack
 DISABLE_KSTACK_ERASE := -fplugin-arg-stackleak_plugin-disable
 endif
 
+ifdef CONFIG_CC_IS_CLANG
+kstack-erase-cflags-y += -fsanitize-coverage=stack-depth
+kstack-erase-cflags-y += -fsanitize-coverage-stack-depth-callback-min=$(CONFIG_KSTACK_ERASE_TRACK_MIN_SIZE)
+DISABLE_KSTACK_ERASE  := -fno-sanitize-coverage=stack-depth
+endif
+
 KSTACK_ERASE_CFLAGS   := $(kstack-erase-cflags-y)
 
 export STACKLEAK_CFLAGS DISABLE_KSTACK_ERASE
-- 
2.34.1


