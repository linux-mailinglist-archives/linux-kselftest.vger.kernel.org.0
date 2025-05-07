Return-Path: <linux-kselftest+bounces-32591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E67AAE8C1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 20:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E3F17A5D3
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C028E57C;
	Wed,  7 May 2025 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC9uw5GO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D923028A73E;
	Wed,  7 May 2025 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746641779; cv=none; b=car8t7m+XZBAXV5cxY88HuLlRl7sYwzL6rqyh2/Hx7HklMqeVDfiSO0hipKzaChYoeVEEkcWVHQx1qE1yjl9hoLFz0siu42QhLqtei29U3I/GWImzVc428GwMv8NkLAZZB1v0xqI5g0YBSqx/K5/2Ndw9VpMhI2Z4WjU304dK4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746641779; c=relaxed/simple;
	bh=QgH8ehGN6f9HfgN0XYJ8BWQbTspcTZep+O49/EkwCxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CSgsgjXD/gCppBsiaSccjNo8gbjykVLWqJSj3UAmn+8MmTYHYHgQWKEHkvUp2EDF5ky96QaeOBKP4TJwtxRwhUzmXhd+bvcBi6hUrQJ9X0JrfBVjTdoR9qrgJGUEwVbAw4pY+TQeV2SLjeycv7mQu9iFpK/Z3KVbXOYrOrejFvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC9uw5GO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E0CC4CEE2;
	Wed,  7 May 2025 18:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746641778;
	bh=QgH8ehGN6f9HfgN0XYJ8BWQbTspcTZep+O49/EkwCxs=;
	h=From:To:Cc:Subject:Date:From;
	b=BC9uw5GOIJnXPxMtqpDWHCEfkXPbmNn7t0cWCLNpKPKsnoNLHlqk8aNbz4Zy/aXN7
	 bm+yhIFILcF1DCIXTScc5wN4Bk9G1/powraLUOdozefqT0Aausk0IPrpMPkpcQLr96
	 37BspEHKByXTwR7NeetcRg6l9tkyN9gP27E9WclP7nohaoVdigqhZDgXq0zeIH2BDz
	 uIdzHXnQN7UUpektS5ORSN90IrYCE5Da63eBTQPSEThKcQzGbd2uRwxOK4p2++NjeH
	 ws8d5259AqgMR4a6JEPiJ0K0pt3gYlX1gilwkZXWc9DOv5QbQakn5fwSa2+p+DuKDt
	 NFZx5jNCzUKYA==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
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
	x86@kernel.org,
	kasan-dev@googlegroups.com,
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
	sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 0/8] stackleak: Support Clang stack depth tracking
Date: Wed,  7 May 2025 11:16:06 -0700
Message-Id: <20250507180852.work.231-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3469; i=kees@kernel.org; h=from:subject:message-id; bh=QgH8ehGN6f9HfgN0XYJ8BWQbTspcTZep+O49/EkwCxs=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnSi7OXB/nf2/RYVPv/qsRZa9yqy1d3KRS0fd0+3e/0Z mOmo6+/dpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAExkaTfD/4gpl7Tzdxoot/B1 XkiZEXAzf8mNdas/f/b9e06jz0Os9y/DP5NK7e6JV6Unzc9+dL7NyOhP2UaDL/szeOxaV8Zseb3 iAisA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

As part of looking at what GCC plugins could be replaced with Clang
implementations, this series uses the recently landed stack depth tracking
callback in Clang[1] to implement the stackleak feature. Since the Clang
feature is now landed, I'm moving this out of RFC to a v1.

Since this touches a lot of arch-specific Makefiles, I tried to trim
the CC list down to just mailing lists in those cases, otherwise the CC
was giant.

Thanks!

-Kees

[1] https://clang.llvm.org/docs/SanitizerCoverage.html#tracing-stack-depth

 v1:
  - Finalize Clang URLs for landed feature
  - Perform CFLAGS enabling more sanely, as done for randstruct
  - Split __no_sanitize_coverage into separate patch
  - Update hardening.config and MAINTAINERS
  - Fix bug found with nvme tree
 RFC: https://lore.kernel.org/lkml/20250502185834.work.560-kees@kernel.org/

Kees Cook (8):
  nvme-pci: Make nvme_pci_npages_prp() __always_inline
  init.h: Disable sanitizer coverage for __init and __head
  stackleak: Rename CONFIG_GCC_PLUGIN_STACKLEAK to CONFIG_STACKLEAK
  stackleak: Rename stackleak_track_stack to __sanitizer_cov_stack_depth
  stackleak: Split STACKLEAK_CFLAGS from GCC_PLUGINS_CFLAGS
  stackleak: Support Clang stack depth tracking
  configs/hardening: Enable CONFIG_STACKLEAK
  configs/hardening: Enable CONFIG_INIT_ON_FREE_DEFAULT_ON

 security/Kconfig.hardening                  | 25 ++++++----
 Makefile                                    |  1 +
 arch/arm/boot/compressed/Makefile           |  2 +-
 arch/arm/vdso/Makefile                      |  2 +-
 arch/arm64/kernel/pi/Makefile               |  2 +-
 arch/arm64/kernel/vdso/Makefile             |  3 +-
 arch/arm64/kvm/hyp/nvhe/Makefile            |  2 +-
 arch/riscv/kernel/pi/Makefile               |  2 +-
 arch/riscv/purgatory/Makefile               |  2 +-
 arch/sparc/vdso/Makefile                    |  3 +-
 arch/x86/entry/vdso/Makefile                |  3 +-
 arch/x86/purgatory/Makefile                 |  2 +-
 drivers/firmware/efi/libstub/Makefile       |  6 +--
 kernel/Makefile                             |  4 +-
 lib/Makefile                                |  2 +-
 scripts/Makefile.gcc-plugins                | 16 +------
 scripts/Makefile.stackleak                  | 21 +++++++++
 scripts/gcc-plugins/stackleak_plugin.c      | 52 ++++++++++-----------
 Documentation/admin-guide/sysctl/kernel.rst |  2 +-
 Documentation/security/self-protection.rst  |  2 +-
 arch/x86/entry/calling.h                    |  4 +-
 arch/x86/include/asm/init.h                 |  2 +-
 include/linux/init.h                        |  4 +-
 include/linux/sched.h                       |  4 +-
 include/linux/stackleak.h                   |  6 +--
 arch/arm/kernel/entry-common.S              |  2 +-
 arch/arm64/kernel/entry.S                   |  2 +-
 arch/riscv/kernel/entry.S                   |  2 +-
 arch/s390/kernel/entry.S                    |  2 +-
 drivers/misc/lkdtm/stackleak.c              |  8 ++--
 drivers/nvme/host/pci.c                     |  2 +-
 kernel/stackleak.c                          |  4 +-
 tools/objtool/check.c                       |  2 +-
 tools/testing/selftests/lkdtm/config        |  2 +-
 MAINTAINERS                                 |  6 ++-
 kernel/configs/hardening.config             |  6 +++
 36 files changed, 122 insertions(+), 90 deletions(-)
 create mode 100644 scripts/Makefile.stackleak

-- 
2.34.1


