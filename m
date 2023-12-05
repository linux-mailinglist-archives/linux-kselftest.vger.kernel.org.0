Return-Path: <linux-kselftest+bounces-1156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6A6805A4E
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F7FB21134
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968F95B1E3;
	Tue,  5 Dec 2023 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cA2ltJ3C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709FC4174B;
	Tue,  5 Dec 2023 16:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910E0C433C8;
	Tue,  5 Dec 2023 16:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701795069;
	bh=ld1xDDBIxU0aMjeZJcBk8TzmodfOXcQzxXPrqLOm3Wc=;
	h=From:Subject:Date:To:Cc:From;
	b=cA2ltJ3Ciu6iOJdi4d9B/ltq2K0G8sHqPxOAvifGX4gGCgc8VemqNpQJTyQayOS0p
	 N1/5z6HA7O21Gy0CuqHBd7MD93z1Fo+yFkhRXrmCNC/lvKfoODEHIqVUwvhFE69Dgb
	 tG9vV1X8YnX4m0mmtEQxHMKnxLhUJsE+pcjSsDohcOakIGGAVKM6QJS7Z2SILPGR3G
	 JvlcRZgctPb3u0CJQhcSm65XFRDhZt8TMfDdTZLN/7ldJR6xQDH14qO/uP70rXh9w9
	 4dE9Tc0pcvrI2L1UYABYYQPEEaRPYxENcSXqlL1aapvQI9x0D19LRIXkWNdhIy7gnM
	 VqgDaVl/NnV0Q==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 00/21] arm64: Support for 2023 DPISA extensions
Date: Tue, 05 Dec 2023 16:47:58 +0000
Message-Id: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD9Ub2UC/23N0QrCIBTG8VcZXmfo8UzdrnqP6MKl26TahoYUY
 ++eG0FEXf4/OL8zk+iCd5HUxUyCSz76ccghdgU592boHPU2NwEGgjMmqAk3iXRNaicfDYVWWCg
 VSlRI8tkUXOsfG3k85e59vI/huX1IfF3fGMhfLHHKqEbFrK101TRwuLgwuOt+DB1ZtQQfgXP8I
 0AWUEHJdYWtNPpLWJblBSYrTd/zAAAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=4657; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ld1xDDBIxU0aMjeZJcBk8TzmodfOXcQzxXPrqLOm3Wc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1ToWY21TL2lSFiNFFmpncXHZ+8uv3xdv0x92cWg
 Iu7GAfWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U6AAKCRAk1otyXVSH0CTCB/
 9LsWRTj/wZmAWjeHxaGBiu4BElH0V6M0Tohiptgba/9qZblZAxTt7uVj1YC/BTGqiGuGajmHYUQhJ8
 X2Bnb/Ttzt20+XlZnVYvaQ547tIUGHQ09wyXuPMfjoacAl/SfDZeP/NQzOBs+mNY2li70oPfvmhTO0
 2AmNK9Cq2jKWi/V8mqRw+tyKLV2lmvFGUrpahC8WEV7FgmGWsuH4q8ZeW2jLYA9DGW1WOk0W9W/TtF
 X05gevBgezfm+zlyxAS6q98+WbF+vcdXfWuKOkWuk0cKnUaViQZDE3EmuVQNJmJ8BiejhePxk5mCxX
 oXk5q8/Wx4ITOnEhKnMGqweRvTAHc0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This series enables support for the data processing extensions in the
newly released 2023 architecture, this is mainly support for 8 bit
floating point formats.  Most of the extensions only introduce new
instructions and therefore only require hwcaps but there is a new EL0
visible control register FPMR used to control the 8 bit floating point
formats, we need to manage traps for this and context switch it.

The sharing of floating point save code between the host and guest
kernels slightly complicates the introduction of KVM support, we first
introduce host support with some placeholders for KVM then replace those
with the actual KVM support.

I've not added test coverage for ptrace, I've got a not quite finished
test program which exercises all the FP ptrace interfaces and their
interactions together, my plan is to cover it there rather than add
another tiny test program that duplicates the boilerplace for tracing a
target and doesn't actually run the traced program.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Rebase onto v6.7-rc3.
- Hook up traps for FPMR in emulate-nested.c.
- Link to v2: https://lore.kernel.org/r/20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org

Changes in v2:
- Rebase onto v6.7-rc1.
- Link to v1: https://lore.kernel.org/r/20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org

---
Mark Brown (21):
      arm64/sysreg: Add definition for ID_AA64PFR2_EL1
      arm64/sysreg: Update ID_AA64ISAR2_EL1 defintion for DDI0601 2023-09
      arm64/sysreg: Add definition for ID_AA64ISAR3_EL1
      arm64/sysreg: Add definition for ID_AA64FPFR0_EL1
      arm64/sysreg: Update ID_AA64SMFR0_EL1 definition for DDI0601 2023-09
      arm64/sysreg: Update SCTLR_EL1 for DDI0601 2023-09
      arm64/sysreg: Update HCRX_EL2 definition for DDI0601 2023-09
      arm64/sysreg: Add definition for FPMR
      arm64/cpufeature: Hook new identification registers up to cpufeature
      arm64/fpsimd: Enable host kernel access to FPMR
      arm64/fpsimd: Support FEAT_FPMR
      arm64/signal: Add FPMR signal handling
      arm64/ptrace: Expose FPMR via ptrace
      KVM: arm64: Add newly allocated ID registers to register descriptions
      KVM: arm64: Support FEAT_FPMR for guests
      arm64/hwcap: Define hwcaps for 2023 DPISA features
      kselftest/arm64: Handle FPMR context in generic signal frame parser
      kselftest/arm64: Add basic FPMR test
      kselftest/arm64: Add 2023 DPISA hwcap test coverage
      KVM: arm64: selftests: Document feature registers added in 2023 extensions
      KVM: arm64: selftests: Teach get-reg-list about FPMR

 Documentation/arch/arm64/elf_hwcaps.rst            |  49 +++++
 arch/arm64/include/asm/cpu.h                       |   3 +
 arch/arm64/include/asm/cpufeature.h                |   5 +
 arch/arm64/include/asm/fpsimd.h                    |   2 +
 arch/arm64/include/asm/hwcap.h                     |  15 ++
 arch/arm64/include/asm/kvm_arm.h                   |   4 +-
 arch/arm64/include/asm/kvm_host.h                  |   3 +
 arch/arm64/include/asm/processor.h                 |   2 +
 arch/arm64/include/uapi/asm/hwcap.h                |  15 ++
 arch/arm64/include/uapi/asm/sigcontext.h           |   8 +
 arch/arm64/kernel/cpufeature.c                     |  72 +++++++
 arch/arm64/kernel/cpuinfo.c                        |  18 ++
 arch/arm64/kernel/fpsimd.c                         |  13 ++
 arch/arm64/kernel/ptrace.c                         |  42 ++++
 arch/arm64/kernel/signal.c                         |  59 ++++++
 arch/arm64/kvm/emulate-nested.c                    |   9 +
 arch/arm64/kvm/fpsimd.c                            |  19 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |   7 +-
 arch/arm64/kvm/sys_regs.c                          |  17 +-
 arch/arm64/tools/cpucaps                           |   1 +
 arch/arm64/tools/sysreg                            | 153 ++++++++++++++-
 include/uapi/linux/elf.h                           |   1 +
 tools/testing/selftests/arm64/abi/hwcap.c          | 217 +++++++++++++++++++++
 tools/testing/selftests/arm64/signal/.gitignore    |   1 +
 .../arm64/signal/testcases/fpmr_siginfo.c          |  82 ++++++++
 .../selftests/arm64/signal/testcases/testcases.c   |   8 +
 .../selftests/arm64/signal/testcases/testcases.h   |   1 +
 tools/testing/selftests/kvm/aarch64/get-reg-list.c |  11 +-
 28 files changed, 819 insertions(+), 18 deletions(-)
---
base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
change-id: 20231003-arm64-2023-dpisa-2f3d25746474

Best regards,
-- 
Mark Brown <broonie@kernel.org>


