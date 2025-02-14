Return-Path: <linux-kselftest+bounces-26604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09800A353FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBBD3AC1ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE545D8F0;
	Fri, 14 Feb 2025 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBoq7x5i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EC42753F1;
	Fri, 14 Feb 2025 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498458; cv=none; b=M02cyuOb5iVul31m2JyPRPbMIDvI+LpMkJybWW00r4gYC44MMc0wntZX3d/QdRcAacTN1IQD9slfa9Eje2P83kJsa0I2b8EblniexAC1i1JZ5i/UaoPL6KtFVHDu3qugAnU2weWBHZJWG0YYOWEMRGBTfWbpKnk9hdZH1ctLWns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498458; c=relaxed/simple;
	bh=EB7r0YGrpBNCrpmzx8CQm0sjhuCgwIKQAEgtl9Z9WAY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bYmzN4aqbahEI/B/xJoputo1v9zG4mhg5GkqLrtyswi3tXkSIkkLsT+kFiQ1qzZvEE49qbGCAMhDlm2ImYk+8EwBT2l2p6H0G0siucGvZ1H55B+b+9/M7xDRadUhUNdusCWiNZx3vKbawjN2/JzSNfWntlXYcw0baSrCYzz8PPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBoq7x5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846B9C4CED1;
	Fri, 14 Feb 2025 02:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498457;
	bh=EB7r0YGrpBNCrpmzx8CQm0sjhuCgwIKQAEgtl9Z9WAY=;
	h=From:Subject:Date:To:Cc:From;
	b=SBoq7x5iYSTRnI6puD5w5yo86ZvdddduhU9aWXBlRGlJ8NF1Kf4NCWrXVc/KTNTeN
	 8B2+PKX/uthhGN77r7Hr57N8Sc6rUGlMt6i0JCIP19tKg4ccDReDSuQMjcYVc1TBXU
	 /acPESq1HGaJx/PSOxMqrUE3gO+hwVqTJZrK2hNqNDCjbcq3LmM6C9gOfvCvmXn+9c
	 8pq+8AATqeKzSNet/NH084ztxQ1dAbbjY/QOQ4MjAHCpAAH87T2Wsn/UBaAm1S8nwf
	 ck59sMbRUPeB2rq1UQUDaeX/gEE5JR6tDYjaJDwV674ASQBaVc/5V4g5fsvTzQyjgJ
	 suwuGmLdOOAWw==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 00/27] KVM: arm64: Implement support for SME in
 non-protected guests
Date: Fri, 14 Feb 2025 01:57:43 +0000
Message-Id: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABijrmcC/2WQwW6DMBBEfwX5XCPvYlzCKf9R9WDDEixiSGyCW
 kX59y6gVmpynJHezO7cRaLoKYk6u4tIi09+Glnot0w0vR1PJH3LWqDCQhUK5LAEaWMwWqZAUhk
 LqE1bmMIIZpxNJF20Y9Ov1Bwuq3uJ1PmvreXjk3Xv0zzF7610gdXd8w+IT/kLSCW7Dqr2XTs8U
 HscKI50zqd4EmvUgn844CuOjLcW0TQOKuXcC1784ppx9YwXjKvSKaga6Dr6jz/2zyJdbzzbvL+
 3L9BMIfi5zhaTg5axwXWFQCnZbdA648JSISg4lHxcDgglllqCDDYOebzNZzu2R74k5yiuevwAf
 IZVUakBAAA=
X-Change-ID: 20230301-kvm-arm64-sme-06a1246d3636
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=9327; i=broonie@kernel.org;
 h=from:subject:message-id; bh=EB7r0YGrpBNCrpmzx8CQm0sjhuCgwIKQAEgtl9Z9WAY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrqPAXw5rgAs7oQ2oIQSm6zRCqHNIicTnHW9UfUbL
 L/4OGOuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ66jwAAKCRAk1otyXVSH0B7wB/
 45qSiMgFhtOPwDoC1BNd2QYT1jJEpQ/T6aWw8iVyQjW0WN+sgw6MpoMAlbTdobT4KHk93G+sOx507R
 uXyGSR7r2pocn9gb1VCAT/Xtk112FHCPxg4BuW2F09GADCQIA2N0QOMmbq3Id8jc+QxcS28D7BraGm
 ndAXmxHbMf/FZKEy16/oOIsyz68mXiMpeX2nylXp+yCFtmbKm0hZBVpUZ0LdlWehijzzNWkt1ImA2i
 v4Ya8OOFH2D7Km3TuKrJJ1iQTYO1jgsPbIaW6jJ0oQy5QRVBIFrd5aQa9ogRlZXSoeWDLtbSD3Iltl
 TE43Ev9BnscybhVwE4QaIpKwKTBejT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

I've removed the RFC tag from this version of the series, but the items
that I'm looking for feedback on remains the same:

 - The userspace ABI, in particular:
  - The vector length used for the SVE registers, access to the SVE
    registers and access to ZA and (if available) ZT0 depending on
    the current state of PSTATE.{SM,ZA}.
  - The use of a single finalisation for both SVE and SME.

 - The addition of control for enabling fine grained traps in a similar
   manner to FGU but without the UNDEF, I'm not clear if this is desired
   at all and at present this requires symmetric read and write traps like
   FGU. That seemed like it might be desired from an implementation
   point of view but we already have one case where we enable an
   asymmetric trap (for ARM64_WORKAROUND_AMPERE_AC03_CPU_38) and it
   seems generally useful to enable asymmetrically.

This series implements support for SME use in non-protected KVM guests.
Much of this is very similar to SVE, the main additional challenge that
SME presents is that it introduces a new vector length similar to the
SVE vector length and two new controls which change the registers seen
by guests:

 - PSTATE.ZA enables the ZA matrix register and, if SME2 is supported,
   the ZT0 LUT register.
 - PSTATE.SM enables streaming mode, a new floating point mode which
   uses the SVE register set with the separately configured SME vector
   length.  In streaming mode implementation of the FFR register is
   optional.

It is also permitted to build systems which support SME without SVE, in
this case when not in streaming mode no SVE registers or instructions
are available.  Further, there is no requirement that there be any
overlap in the set of vector lengths supported by SVE and SME in a
system, this is expected to be a common situation in practical systems.

Since there is a new vector length to configure we introduce a new
feature parallel to the existing SVE one with a new pseudo register for
the streaming mode vector length.  Due to the overlap with SVE caused by
streaming mode rather than finalising SME as a separate feature we use
the existing SVE finalisation to also finalise SME, a new define
KVM_ARM_VCPU_VEC is provided to help make user code clearer.  Finalising
SVE and SME separately would introduce complication with register access
since finalising SVE makes the SVE regsiters writeable by userspace and
doing multiple finalisations results in an error being reported.
Dealing with a state where the SVE registers are writeable due to one of
SVE or SME being finalised but may have their VL changed by the other
being finalised seems like needless complexity with minimal practical
utility, it seems clearer to just express directly that only one
finalisation can be done in the ABI.

Access to the floating point registers follows the architecture:

 - When both SVE and SME are present:
   - If PSTATE.SM == 0 the vector length used for the Z and P registers
     is the SVE vector length.
   - If PSTATE.SM == 1 the vector length used for the Z and P registers
     is the SME vector length.
 - If only SME is present:
   - If PSTATE.SM == 0 the Z and P registers are inaccessible and the
     floating point state accessed via the encodings for the V registers. 
   - If PSTATE.SM == 1 the vector length used for the Z and P registers
 - The SME specific ZA and ZT0 registers are only accessible if SVCR.ZA is 1.

The VMM must understand this, in particular when loading state SVCR
should be configured before other state.

There are a large number of subfeatures for SME, most of which only
offer additional instructions but some of which (SME2 and FA64) add
architectural state. These are configured via the ID registers as per
usual.

The new KVM_ARM_VCPU_VEC feature and ZA and ZT0 registers have not been
added to the get-reg-list selftest, the idea of supporting additional
features there without restructuring the program to generate all
possible feature combinations has been rejected.  I will post a separate
series which does that restructuring.

No support is present for protected guests, this is expected to be added
separately, the series is already rather large and pKVM in general
offers a subset of features.

This series is based on Mark Rutland's fix series:

   https://lore.kernel.org/r/20250210195226.1215254-1-mark.rutland@arm.com

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v4:
- Rebase onto v6.14-rc2 and Mark Rutland's fixes.
- Expose SME to nested guests.
- Additional cleanups and test fixes following on from the rebase.
- Link to v3: https://lore.kernel.org/r/20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org

Changes in v3:
- Rebase onto v6.12-rc2.
- Link to v2: https://lore.kernel.org/r/20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org

Changes in v2:
- Rebase onto v6.7-rc3.
- Configure subfeatures based on host system only.
- Complete nVHE support.
- There was some snafu with sending v1 out, it didn't make it to the
  lists but in case it hit people's inboxes I'm sending as v2.

---
Mark Brown (27):
      arm64/fpsimd: Update FA64 and ZT0 enables when loading SME state
      arm64/fpsimd: Decide to save ZT0 and streaming mode FFR at bind time
      arm64/fpsimd: Check enable bit for FA64 when saving EFI state
      arm64/fpsimd: Determine maximum virtualisable SME vector length
      KVM: arm64: Introduce non-UNDEF FGT control
      KVM: arm64: Pay attention to FFR parameter in SVE save and load
      KVM: arm64: Pull ctxt_has_ helpers to start of sysreg-sr.h
      KVM: arm64: Move SVE state access macros after feature test macros
      KVM: arm64: Rename SVE finalization constants to be more general
      KVM: arm64: Document the KVM ABI for SME
      KVM: arm64: Define internal features for SME
      KVM: arm64: Rename sve_state_reg_region
      KVM: arm64: Store vector lengths in an array
      KVM: arm64: Implement SME vector length configuration
      KVM: arm64: Support SME control registers
      KVM: arm64: Support TPIDR2_EL0
      KVM: arm64: Support SME identification registers for guests
      KVM: arm64: Support SME priority registers
      KVM: arm64: Provide assembly for SME state restore
      KVM: arm64: Support userspace access to streaming mode Z and P registers
      KVM: arm64: Expose SME specific state to userspace
      KVM: arm64: Context switch SME state for normal guests
      KVM: arm64: Handle SME exceptions
      KVM: arm64: Expose SME to nested guests
      KVM: arm64: Provide interface for configuring and enabling SME for guests
      KVM: arm64: selftests: Add SME system registers to get-reg-list
      KVM: arm64: selftests: Add SME to set_id_regs test

 Documentation/virt/kvm/api.rst                   | 117 +++++++---
 arch/arm64/include/asm/fpsimd.h                  |  22 ++
 arch/arm64/include/asm/kvm_emulate.h             |  12 +-
 arch/arm64/include/asm/kvm_host.h                | 143 ++++++++++---
 arch/arm64/include/asm/kvm_hyp.h                 |   4 +-
 arch/arm64/include/asm/kvm_pkvm.h                |   2 +-
 arch/arm64/include/asm/vncr_mapping.h            |   2 +
 arch/arm64/include/uapi/asm/kvm.h                |  33 +++
 arch/arm64/kernel/cpufeature.c                   |   2 -
 arch/arm64/kernel/fpsimd.c                       |  86 ++++----
 arch/arm64/kvm/arm.c                             |  10 +
 arch/arm64/kvm/fpsimd.c                          |  19 +-
 arch/arm64/kvm/guest.c                           | 262 ++++++++++++++++++++---
 arch/arm64/kvm/handle_exit.c                     |  14 ++
 arch/arm64/kvm/hyp/fpsimd.S                      |  18 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h          | 141 ++++++++++--
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h       |  77 ++++---
 arch/arm64/kvm/hyp/nvhe/hyp-main.c               |   9 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                   |   4 +-
 arch/arm64/kvm/hyp/nvhe/switch.c                 |  11 +-
 arch/arm64/kvm/hyp/vhe/switch.c                  |  21 +-
 arch/arm64/kvm/nested.c                          |   3 +-
 arch/arm64/kvm/reset.c                           | 154 +++++++++----
 arch/arm64/kvm/sys_regs.c                        | 118 +++++++++-
 include/uapi/linux/kvm.h                         |   1 +
 tools/testing/selftests/kvm/arm64/get-reg-list.c |  32 ++-
 tools/testing/selftests/kvm/arm64/set_id_regs.c  |  29 ++-
 27 files changed, 1078 insertions(+), 268 deletions(-)
---
base-commit: 6a25088d268ce4c2163142ead7fe1975bb687cb7
change-id: 20230301-kvm-arm64-sme-06a1246d3636
prerequisite-message-id: 20250210195226.1215254-1-mark.rutland@arm.com
prerequisite-patch-id: 615ab9c526e9f6242bd5b8d7188e96fb66fb0e64
prerequisite-patch-id: e5c4f2ff9c9ba01a0f659dd1e8bf6396de46e197
prerequisite-patch-id: 0794d28526755180847841c045a6b7cb3d800c16
prerequisite-patch-id: 079d3a8a680f793b593268eeba000acc55a0b4ec
prerequisite-patch-id: a3428f67a5ee49f2b01208f30b57984d5409d8f5
prerequisite-patch-id: 26393e401e9eae7cff5bb1d3bdb18b4e29ffc8fe
prerequisite-patch-id: 64f9819f751da4a1c73b9d1b292ccee6afda89f6
prerequisite-patch-id: 0355baaa8ceb31dc85d015b56084c33416f78041

Best regards,
-- 
Mark Brown <broonie@kernel.org>


