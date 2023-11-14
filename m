Return-Path: <linux-kselftest+bounces-81-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A48A7EB21D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 15:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC69B20A33
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 14:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB451F19D;
	Tue, 14 Nov 2023 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFw4c/Ul"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A8F4121A;
	Tue, 14 Nov 2023 14:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC7AC433C7;
	Tue, 14 Nov 2023 14:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699972521;
	bh=k9tklrd9CUW37pCy5xazKSbSEX1KKx7gXJfVBAQsxno=;
	h=From:Subject:Date:To:Cc:From;
	b=oFw4c/UlqT1y280OJKCojnhsWb5J0NHo8uViuJ8Mi95M2FKPfd3BKqh1LmGjtm8jt
	 YGCAnaXKKZg1/DehIjEzijXXa9nu2qhZefv2FFE0YORwMFRo/RCt4T/KCVLln5uhJM
	 cs4HioJBS6oErQTURw2IAbiZeZrWVAdtUfjZ+GxE4uW5a0uC0BuALwhyXexBn0EXgN
	 vPhNEd5da+M7jEWxE9Xw5JJClEEd5R/HDTcLHQyW4S3dDH+YxAZV14LtZIYKGuQi6Y
	 IWJjorv2mk+XJ+T6sUg/0RVlB7T/HcRvmzhFaeOOcwJK9wb0+bLr+8rELFq0WhkOpz
	 X2bSD5Zh68/gQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 00/21] arm64: Support for 2023 DPISA extensions
Date: Tue, 14 Nov 2023 14:34:45 +0000
Message-Id: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIaFU2UC/2XNTQ6CQAyG4auQrq0ZysiPK+9hWIBToFEZ0jFEQ
 7i7A3Hn8vmSvl0gsAoHOCcLKM8SxI8RdEjgNjRjzyguGshQlhqTYaPP3OJGdJOEBqnLHJ0Km9v
 CQjyblDt578lrHT1IeHn97B/mdFt/Mcr/Y3OKBktbGOeqsmpbutxZR34cvfZQr+v6BRyay4OxA
 AAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4410; i=broonie@kernel.org;
 h=from:subject:message-id; bh=k9tklrd9CUW37pCy5xazKSbSEX1KKx7gXJfVBAQsxno=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WUt+WiT6txaa4pxL7WEh963NJouUROCwfprTjL
 PYsyg7yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFlAAKCRAk1otyXVSH0JfpB/
 4ttQ8AjvZQxXTnoDNK6E2YDQipxqaTVWF1Sk0ZmnSApAeGKuPaSKm6FXkONbNHFttJgE7+oe/OsWGh
 vdLib5GBnzgqfoLUuYbHPOUHsYT4nw03C170xuEOs16eqEbHCaHSLqnFGL9NfYn9xWt8ZkIRex/Cex
 q5M/pVRRpi3gcVI6FJluYoPEJCGfCjDOHuZ5ZXZkGDIbWatF/39HuobHQAAK/4tFGNtidf5OBnXUNn
 aJgmc+Aon9SApW3lKxZ+5oCiW+u0uTlCd5yTOeZIKHQ8CwnrUPTZjLqWlN+CRSfidJeAWAZLOFeNs9
 ayFKtY87CcbaGc950CdfDkjTw/mDNb
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
 27 files changed, 810 insertions(+), 18 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231003-arm64-2023-dpisa-2f3d25746474

Best regards,
-- 
Mark Brown <broonie@kernel.org>


