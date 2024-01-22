Return-Path: <linux-kselftest+bounces-3334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52988836D29
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF83A1F27F0E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1509655C0E;
	Mon, 22 Jan 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/Ui+xvu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95681DA5E;
	Mon, 22 Jan 2024 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940907; cv=none; b=mltr9vbbuXwX5H6OGGb8uqADLpmg/hb4Df43422iGhnFdI+/KtCAMn+sP3dRnm/xBY9pD8QCWd7ayxs2eUlsP5Qg0Mc6lBuI/k71m5vGSkmiD3Cs/DVuaHyIvhKxpPREgrbAxXBL6e0xePuXD7PJY5eJg0FRQwSqBW3GZWj08Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940907; c=relaxed/simple;
	bh=yU1L94VKvych83kNlKcfNEAjXVSSH90zSUQFgVDmdBo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dkSweOtlhExjQfKOmM1TN4MvJsW8zgkcVOXPlFwgiL3g1BVKYh6EWzgenGx6BD3hBrHh0dPxMQRWJWOp/lt9QtMwCUnOrxZX0tLhlfFJXOQtCXBXgUgeHzZqlzdscXDWQZPotUdrBOt1jUq0efVhV1H6W6FUofwXRH7QNGrStOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/Ui+xvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EFBC433C7;
	Mon, 22 Jan 2024 16:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705940906;
	bh=yU1L94VKvych83kNlKcfNEAjXVSSH90zSUQFgVDmdBo=;
	h=From:Subject:Date:To:Cc:From;
	b=C/Ui+xvuxwU9DDJVlibwNqE2F9gS4t08pysH74dCMMTpRPRc6wffzVL0FlqHtWJd1
	 zmJJq7xeXJuFLNElwGqEaTcMrzP2DmR0z1kPfSfswKjbPnrP7g7fMpKBaCRRrsse8V
	 MHVOWTzJO4KacYMueEd5IkWzT/vkhc3JFTHVAugnv0pvu9cQk4qKaDZyx0as8Xk4Og
	 ZCI7fS1W50RsRHtl/PpmwZHIKQeYf8gQROz5W9d3cN5FN1eBQDrbXUonI3G6NzG3Fm
	 CnOGYQZRFUEM6C6ggQYK2z9iXnYvYP9e1fUTUQn9ulYU2r8miATiWUgGs/gEmAouTl
	 crjVuqk7o2b8g==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 00/14] arm64: Support for 2023 DPISA extensions
Date: Mon, 22 Jan 2024 16:28:03 +0000
Message-Id: <20240122-arm64-2023-dpisa-v4-0-776e094861df@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJSXrmUC/23N0QqCMBTG8VeJXbfYzo7b7Kr3iC6mmzoqlS2kE
 N+9KYGEXv4/OL8zkuiCd5GcDyMJbvDRd20KPB5I2Zi2dtTb1AQYCM6YoCY8JdI5qe19NBQqYSF
 TKFEhSWd9cJV/L+T1lrrx8dWFz/Jh4PP6w0BusYFTRjUqZm2u86KAy92F1j1OXajJrA2wCpzjj
 gBJQAUZ1zlW0uiNIFYBWLYjiCTYoixKq6UyqvoTpmn6AuWXLoM1AQAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <dave.martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=4620; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yU1L94VKvych83kNlKcfNEAjXVSSH90zSUQFgVDmdBo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlrpebAKJwsvPF0u841eY8AfCNgFYHU3etbwbWemVX
 We8FYBiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZa6XmwAKCRAk1otyXVSH0PKHB/
 kBMuRfTZaXyGWBlnliKAkjtgawcERWxDvl3k6zKKAz8JHHz1VpJKOQbrIiqep/8J2eMIPQ3eh3R+Te
 HDiw+wS65cfEHEoPPVPIHS9jkGnvS7QCBWMgET3Ay0tsR/r3UZSgvi9luIkovDj9qLNufxD50d2Lso
 etyC6I9IGZGdhcWGsCIS5lEUKP3cmzOdXTxJLnkXNi4aFOQwj4Td2R79DTwZZBhLo3bJoAfVJvC19p
 l2xtt65uycxp2VqtDGf3FcWhhdaePKhZYi9KLpO8T7qjq3M30tV0LvPl8rNlMAyL8T70dbiAijbVsG
 FEisAtGEr5PuEVSUfrEGXBHpnA2/ui
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This series enables support for the data processing extensions in the
newly released 2023 architecture, this is mainly support for 8 bit
floating point formats.  Most of the extensions only introduce new
instructions and therefore only require hwcaps but there is a new EL0
visible control register FPMR used to control the 8 bit floating point
formats, we need to manage traps for this and context switch it.

Due to uncertainty with the plan for parsing ID registers to identify
which features to expose to the guest the KVM support is placed at the
end of the series, it will need to be revised once that issue is
resolved.  The sharing of floating point save code between the host and
guest kernels slightly complicates the introduction of KVM support, we
first introduce host support with some placeholders for KVM then replace
those with the actual KVM support.

I've not added test coverage for ptrace, I've got a test program which
exercises all the FP ptrace interfaces and their interactions together,
my plan is to cover it there rather than add another tiny test program
that duplicates the boilerplace for tracing a target and doesn't
actually run the traced program.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v4:
- Rebase onto v6.8-rc1.
- Move KVM support to the end of the series.
- Link to v3: https://lore.kernel.org/r/20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org

Changes in v3:
- Rebase onto v6.7-rc3.
- Hook up traps for FPMR in emulate-nested.c.
- Link to v2: https://lore.kernel.org/r/20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org

Changes in v2:
- Rebase onto v6.7-rc1.
- Link to v1: https://lore.kernel.org/r/20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org

---
Mark Brown (14):
      arm64/cpufeature: Hook new identification registers up to cpufeature
      arm64/fpsimd: Enable host kernel access to FPMR
      arm64/fpsimd: Support FEAT_FPMR
      arm64/signal: Add FPMR signal handling
      arm64/ptrace: Expose FPMR via ptrace
      arm64/hwcap: Define hwcaps for 2023 DPISA features
      kselftest/arm64: Handle FPMR context in generic signal frame parser
      kselftest/arm64: Add basic FPMR test
      kselftest/arm64: Add 2023 DPISA hwcap test coverage
      KVM: arm64: Share all userspace hardened thread data with the hypervisor
      KVM: arm64: Add newly allocated ID registers to register descriptions
      KVM: arm64: Support FEAT_FPMR for guests
      KVM: arm64: selftests: Document feature registers added in 2023 extensions
      KVM: arm64: selftests: Teach get-reg-list about FPMR

 Documentation/arch/arm64/elf_hwcaps.rst            |  49 +++++
 arch/arm64/include/asm/cpu.h                       |   3 +
 arch/arm64/include/asm/cpufeature.h                |   5 +
 arch/arm64/include/asm/fpsimd.h                    |   2 +
 arch/arm64/include/asm/hwcap.h                     |  15 ++
 arch/arm64/include/asm/kvm_arm.h                   |   4 +-
 arch/arm64/include/asm/kvm_host.h                  |   5 +-
 arch/arm64/include/asm/processor.h                 |   6 +-
 arch/arm64/include/uapi/asm/hwcap.h                |  15 ++
 arch/arm64/include/uapi/asm/sigcontext.h           |   8 +
 arch/arm64/kernel/cpufeature.c                     |  72 +++++++
 arch/arm64/kernel/cpuinfo.c                        |  18 ++
 arch/arm64/kernel/fpsimd.c                         |  13 ++
 arch/arm64/kernel/ptrace.c                         |  42 ++++
 arch/arm64/kernel/signal.c                         |  59 ++++++
 arch/arm64/kvm/emulate-nested.c                    |   8 +
 arch/arm64/kvm/fpsimd.c                            |  14 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |   9 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 |   4 +-
 arch/arm64/kvm/sys_regs.c                          |  17 +-
 arch/arm64/tools/cpucaps                           |   1 +
 include/uapi/linux/elf.h                           |   1 +
 tools/testing/selftests/arm64/abi/hwcap.c          | 217 +++++++++++++++++++++
 tools/testing/selftests/arm64/signal/.gitignore    |   1 +
 .../arm64/signal/testcases/fpmr_siginfo.c          |  82 ++++++++
 .../selftests/arm64/signal/testcases/testcases.c   |   8 +
 .../selftests/arm64/signal/testcases/testcases.h   |   1 +
 tools/testing/selftests/kvm/aarch64/get-reg-list.c |  11 +-
 28 files changed, 670 insertions(+), 20 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20231003-arm64-2023-dpisa-2f3d25746474

Best regards,
-- 
Mark Brown <broonie@kernel.org>


