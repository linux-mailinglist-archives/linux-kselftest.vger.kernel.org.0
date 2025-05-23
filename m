Return-Path: <linux-kselftest+bounces-33564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E16AC1B2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 06:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6DDA42428
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 04:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F9C226CF7;
	Fri, 23 May 2025 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqTkaNur"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072722331C;
	Fri, 23 May 2025 04:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975179; cv=none; b=AKHBp7/3Hk7I3GVacuEKp9P6G1X3OH15iciL8EZTyX0/XDLsgxq3TvDohhUTNnDb8IW0M/x0lk1J+AjV09LJDFUKJ1T+LAPVJ5OyywErqF3iu5MqSHvEuxijxGRZhgCM7pF6K01/+syQCC9znBioXsL6gZEc+iM4m/kaahnEyaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975179; c=relaxed/simple;
	bh=XVwkrc3glEUjTIVHxhgADYvS6InRhqZwcVUoNmb8gLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=U5pJTOStoqqY6gTLrXUWuAWRQiSiy/+7Rron68ZxI5sl+cLAF5KnZ1o9mEXmc5cszsJJPe9f6CxAlfPBYKaqpTjuUtjdIpjBA3jZnWLNMTxBe6+Ek/pcdljRWa/mX+T721LTtZncXyp7IQcQxvgvAu3mKO+XjhrPkfUdE1i1+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqTkaNur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D66C4AF09;
	Fri, 23 May 2025 04:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747975178;
	bh=XVwkrc3glEUjTIVHxhgADYvS6InRhqZwcVUoNmb8gLs=;
	h=From:To:Cc:Subject:Date:From;
	b=KqTkaNurs9FhJf2xVT2AAgHgZfsZLI22JZrnjsUUd3dLV4GIqcY/egNqMcrSdZ7KY
	 Qoe1xFjyvbHFLLwX8ltHL+UpEgH2pwDrHXGVG+gI/ZXCJ/PiG9bEf2d8W+XPMqCPxS
	 t7/QNPmTyrPco7X6qhPfaX8HwI7V5XMmTaddqEdLhPnbgxtzwoZVUVrHAupH5HXUWC
	 uJs8xAoP8DhUEFmLxMG2167yDtwxbVR5eXKMzN/8qSh6Y2P0fAEW0W27jJaqa0EEmQ
	 aqWuakzIBlY2iT7g7eX7sCheOJj+u51pIrSHjL9O7SZk51OYxQaixUP2zLbVkjOfiA
	 pVI4tIZzEwhLA==
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
Subject: [PATCH v2 00/14] stackleak: Support Clang stack depth tracking
Date: Thu, 22 May 2025 21:39:10 -0700
Message-Id: <20250523043251.it.550-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5806; i=kees@kernel.org; h=from:subject:message-id; bh=XVwkrc3glEUjTIVHxhgADYvS6InRhqZwcVUoNmb8gLs=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn6v7/zd349lB4js43v/P8PVhOrZ671qt7bkPjchC/4n VqhgOyjjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIm8qWdkeLn+6AuHlaaR0h8X HD0uxWndd9xPfAPD46tHXz3TfCnRVcDwTy94qstMZtfd7Myfr9qe83KzmFlVcIJ9CYvupkfljK9 kmQE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

 v2:
  - rename stackleak to kstack_erase (mingo)
  - address __init vs inline with KCOV changes
 v1:  https://lore.kernel.org/lkml/20250507180852.work.231-kees@kernel.org/
 RFC: https://lore.kernel.org/lkml/20250502185834.work.560-kees@kernel.org/

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

Kees Cook (14):
  stackleak: Rename STACKLEAK to KSTACK_ERASE
  stackleak: Rename stackleak_track_stack to __sanitizer_cov_stack_depth
  stackleak: Split KSTACK_ERASE_CFLAGS from GCC_PLUGINS_CFLAGS
  x86: Handle KCOV __init vs inline mismatches
  arm: Handle KCOV __init vs inline mismatches
  arm64: Handle KCOV __init vs inline mismatches
  s390: Handle KCOV __init vs inline mismatches
  powerpc: Handle KCOV __init vs inline mismatches
  mips: Handle KCOV __init vs inline mismatches
  loongarch: Handle KCOV __init vs inline mismatches
  init.h: Disable sanitizer coverage for __init and __head
  kstack_erase: Support Clang stack depth tracking
  configs/hardening: Enable CONFIG_KSTACK_ERASE
  configs/hardening: Enable CONFIG_INIT_ON_FREE_DEFAULT_ON

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
 arch/loongarch/include/asm/smp.h              |  2 +-
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
 arch/arm/kernel/entry-common.S                |  2 +-
 arch/arm64/kernel/entry.S                     |  2 +-
 arch/riscv/kernel/entry.S                     |  2 +-
 arch/s390/kernel/entry.S                      |  2 +-
 arch/arm/mm/cache-feroceon-l2.c               |  2 +-
 arch/arm/mm/cache-tauros2.c                   |  2 +-
 arch/loongarch/kernel/time.c                  |  2 +-
 arch/loongarch/mm/ioremap.c                   |  4 +-
 arch/powerpc/mm/book3s64/hash_utils.c         |  2 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      |  2 +-
 arch/s390/mm/init.c                           |  2 +-
 arch/x86/kernel/kvm.c                         |  2 +-
 drivers/clocksource/timer-orion.c             |  2 +-
 .../lkdtm/{stackleak.c => kstack_erase.c}     | 26 +++++-----
 drivers/platform/x86/thinkpad_acpi.c          |  4 +-
 drivers/soc/ti/pm33xx.c                       |  2 +-
 fs/proc/base.c                                |  6 +--
 kernel/fork.c                                 |  2 +-
 kernel/{stackleak.c => kstack_erase.c}        | 22 ++++----
 tools/objtool/check.c                         |  4 +-
 tools/testing/selftests/lkdtm/config          |  2 +-
 MAINTAINERS                                   |  6 ++-
 kernel/configs/hardening.config               |  6 +++
 69 files changed, 203 insertions(+), 171 deletions(-)
 create mode 100644 scripts/Makefile.kstack_erase
 rename include/linux/{stackleak.h => kstack_erase.h} (81%)
 rename drivers/misc/lkdtm/{stackleak.c => kstack_erase.c} (89%)
 rename kernel/{stackleak.c => kstack_erase.c} (87%)

-- 
2.34.1


