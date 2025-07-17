Return-Path: <linux-kselftest+bounces-37525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A83B0974F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888594A72C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF03246793;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn7vBNA8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4A723771E;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794720; cv=none; b=c8yonrc24YZt+QAq2eNw6qR2PVQTpf6fvrxgOOz3hKkJwY0HUqzeuC2dzvH5SsltWqsMB+tL/pCKwX+GHDycJ5+T0ggTI3nf5G0bCbH6GrnISC6D3L5MaYlUHjHqIBlM3F/CRjCimRXXp1eV6kDg7QHZ5HcUKbmEhWPTQuqY5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794720; c=relaxed/simple;
	bh=ix3ybSX3HXyR5ul7nVKO/r/KYy1s5o0+DAZiEgLkmcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lWjGbImXRLXkYQAN3ouUQg/JrefeI50iZX6s39DzF1qWyKOcMiHYIWmneI3SiLdQYunrhfnug15u/g7RCO8eWj9Rvx2Jdm+greXXrhOXiYl8BhZPQYmdXjjpv7t93BapY4zkcw9+vLs5ezbr7/BvOCBQFaGk71BQLIsaY1z/8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gn7vBNA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29831C4CEEB;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794720;
	bh=ix3ybSX3HXyR5ul7nVKO/r/KYy1s5o0+DAZiEgLkmcM=;
	h=From:To:Cc:Subject:Date:From;
	b=Gn7vBNA8ECW01pz7bzzi6l7uJmullsgdYyyFGomxO2fchHp+SDepdG+I6wOhD/gNK
	 T3SEIM+1NfmErc+8DhsFxy8ppv7/K4qPjswgAhSVTH/FsykQ/fNbHEvrnupijvTyea
	 b5T6AUCskwP0bPJyW348phxgXsYznPGl6Tfu0rEgmHXOlEMleiD7DVHcHq590DH2FY
	 oMdbUTk24voKuAcf1WeqMrcw3JXvI5a4jYL/MBUz2SF0aWznalOa6/vg9ppvdbzmOv
	 2MAUd25KsoHSEQdyNB+y5jYu/S+BPCr2PLArdK7j9HFT5emGVOiw+WzwFsulmUJmbM
	 r4pAIwieJbXxA==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
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
Subject: [PATCH v3 00/13] stackleak: Support Clang stack depth tracking
Date: Thu, 17 Jul 2025 16:25:05 -0700
Message-Id: <20250717231756.make.423-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5918; i=kees@kernel.org; h=from:subject:message-id; bh=ix3ybSX3HXyR5ul7nVKO/r/KYy1s5o0+DAZiEgLkmcM=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmVbZHJG+bN3K/qtDByvmFFwWZOiegr7v9P8cdPbSg4o 3Zj+4WOjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkYBjMyfNv4wNam5MZaxztb DVV2bLscf+z93ddLbf58MJq2fUdLOyfDP/uXom2zOn6oGNnZ+vY/6tuxYr3x7FmnbTaV1Sr/nay 2lB0A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

 v3:
  - split up and drop __init vs inline patches that went via arch trees
  - apply feedback about preferring __init to __always_inline
  - incorporate Ritesh Harjani's patch for __init cleanups in powerpc
  - wider build testing on older compilers
 v2: https://lore.kernel.org/lkml/20250523043251.it.550-kees@kernel.org/
 v1: https://lore.kernel.org/lkml/20250507180852.work.231-kees@kernel.org/

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

Kees Cook (12):
  stackleak: Rename STACKLEAK to KSTACK_ERASE
  stackleak: Rename stackleak_track_stack to __sanitizer_cov_stack_depth
  stackleak: Split KSTACK_ERASE_CFLAGS from GCC_PLUGINS_CFLAGS
  x86: Handle KCOV __init vs inline mismatches
  arm: Handle KCOV __init vs inline mismatches
  arm64: Handle KCOV __init vs inline mismatches
  s390: Handle KCOV __init vs inline mismatches
  mips: Handle KCOV __init vs inline mismatch
  init.h: Disable sanitizer coverage for __init and __head
  kstack_erase: Support Clang stack depth tracking
  configs/hardening: Enable CONFIG_KSTACK_ERASE
  configs/hardening: Enable CONFIG_INIT_ON_FREE_DEFAULT_ON

Ritesh Harjani (IBM) (1):
  powerpc/mm/book3s64: Move kfence and debug_pagealloc related calls to
    __init section

 arch/Kconfig                                  |  4 +-
 arch/arm/Kconfig                              |  2 +-
 arch/arm64/Kconfig                            |  2 +-
 arch/riscv/Kconfig                            |  2 +-
 arch/s390/Kconfig                             |  2 +-
 arch/x86/Kconfig                              |  2 +-
 security/Kconfig.hardening                    | 45 +++++++++-------
 Makefile                                      |  1 +
 arch/arm/boot/compressed/Makefile             |  2 +-
 arch/arm/vdso/Makefile                        |  2 +-
 arch/arm64/kernel/pi/Makefile                 |  2 +-
 arch/arm64/kernel/vdso/Makefile               |  3 +-
 arch/arm64/kvm/hyp/nvhe/Makefile              |  2 +-
 arch/riscv/kernel/pi/Makefile                 |  2 +-
 arch/riscv/purgatory/Makefile                 |  2 +-
 arch/sparc/vdso/Makefile                      |  3 +-
 arch/x86/entry/vdso/Makefile                  |  3 +-
 arch/x86/purgatory/Makefile                   |  2 +-
 drivers/firmware/efi/libstub/Makefile         |  8 +--
 drivers/misc/lkdtm/Makefile                   |  2 +-
 kernel/Makefile                               | 10 ++--
 lib/Makefile                                  |  2 +-
 scripts/Makefile.gcc-plugins                  | 16 +-----
 scripts/Makefile.kstack_erase                 | 21 ++++++++
 scripts/gcc-plugins/stackleak_plugin.c        | 52 +++++++++----------
 Documentation/admin-guide/sysctl/kernel.rst   |  4 +-
 Documentation/arch/x86/x86_64/mm.rst          |  2 +-
 Documentation/security/self-protection.rst    |  2 +-
 .../zh_CN/security/self-protection.rst        |  2 +-
 arch/arm64/include/asm/acpi.h                 |  2 +-
 arch/mips/include/asm/time.h                  |  2 +-
 arch/s390/hypfs/hypfs.h                       |  2 +-
 arch/s390/hypfs/hypfs_diag.h                  |  2 +-
 arch/x86/entry/calling.h                      |  4 +-
 arch/x86/include/asm/acpi.h                   |  4 +-
 arch/x86/include/asm/init.h                   |  2 +-
 arch/x86/include/asm/realmode.h               |  2 +-
 include/linux/acpi.h                          |  4 +-
 include/linux/bootconfig.h                    |  2 +-
 include/linux/efi.h                           |  2 +-
 include/linux/init.h                          |  4 +-
 include/linux/{stackleak.h => kstack_erase.h} | 20 +++----
 include/linux/memblock.h                      |  2 +-
 include/linux/mfd/dbx500-prcmu.h              |  2 +-
 include/linux/sched.h                         |  4 +-
 include/linux/smp.h                           |  2 +-
 arch/arm/kernel/entry-common.S                |  2 +-
 arch/arm64/kernel/entry.S                     |  2 +-
 arch/riscv/kernel/entry.S                     |  2 +-
 arch/s390/kernel/entry.S                      |  2 +-
 arch/arm/mm/cache-feroceon-l2.c               |  2 +-
 arch/arm/mm/cache-tauros2.c                   |  2 +-
 arch/powerpc/mm/book3s64/hash_utils.c         |  6 +--
 arch/powerpc/mm/book3s64/radix_pgtable.c      |  4 +-
 arch/s390/mm/init.c                           |  2 +-
 arch/x86/kernel/kvm.c                         |  2 +-
 arch/x86/mm/init_64.c                         |  2 +-
 drivers/clocksource/timer-orion.c             |  2 +-
 .../lkdtm/{stackleak.c => kstack_erase.c}     | 26 +++++-----
 drivers/soc/ti/pm33xx.c                       |  2 +-
 fs/proc/base.c                                |  6 +--
 kernel/fork.c                                 |  2 +-
 kernel/kexec_handover.c                       |  4 +-
 kernel/{stackleak.c => kstack_erase.c}        | 22 ++++----
 tools/objtool/check.c                         |  4 +-
 tools/testing/selftests/lkdtm/config          |  2 +-
 MAINTAINERS                                   |  6 ++-
 kernel/configs/hardening.config               |  6 +++
 68 files changed, 204 insertions(+), 172 deletions(-)
 create mode 100644 scripts/Makefile.kstack_erase
 rename include/linux/{stackleak.h => kstack_erase.h} (81%)
 rename drivers/misc/lkdtm/{stackleak.c => kstack_erase.c} (89%)
 rename kernel/{stackleak.c => kstack_erase.c} (87%)

-- 
2.34.1


