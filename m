Return-Path: <linux-kselftest+bounces-35743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223C3AE80E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A0A77A6771
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61482BEC25;
	Wed, 25 Jun 2025 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/xSwY+/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890F425B677;
	Wed, 25 Jun 2025 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850687; cv=none; b=njn3xUGq1n6YHovvc8xjAL7njVgv6e5mhMyP28JRzZBysM+1WzSQ4UdlQC0ij/beU0yr1R4wRoRuBPjCq9nh3T/2sdotPSbKXRHhD9jBU1PO7Sa1Dx5wvSMhN1uHEhld7qoaQk2B1G9a4/E7vFIMrA4LXmMpEWQHQSz6/639n4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850687; c=relaxed/simple;
	bh=WyjPlzEckQK2AsiUXQqAYWbsE3Q3tZ56mU/lgBXCQu8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mzygKZT8Bp8Z/cLuybjo2OnZNbCbonSoz4PYkhorAHOTJT2+6Rkx0cAF/I2uV6e+VxuyX1Yx4ekRbGzujo0TOBLrquxsGB1BxbOVmrFCgMyoAhAQwclmiRygAfDIpuethihT1LIs3C/t8Wib0z2c7y8D7wWIscFJwR7oi4sGW94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/xSwY+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8F5C4CEEA;
	Wed, 25 Jun 2025 11:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850687;
	bh=WyjPlzEckQK2AsiUXQqAYWbsE3Q3tZ56mU/lgBXCQu8=;
	h=From:Subject:Date:To:Cc:From;
	b=j/xSwY+/YguU+QdpVUl4ep3qM71MYwW+MswIyvFRaP9pl6v3rE/97dhMN8ChqZTF1
	 j0fJ53I5aD9SBnZJb1fPfDpv0uMT1+F3qI9sZ+m6IccKD2leXyM3a/wV+yXn9jZZH2
	 UNxZHBuqPl2KVqjHLVKBxaqCIpMtCuCpNWTOzhDOSoUi9XwhJ5YKkBS3+jPfPBuadU
	 /m6riUXP3s1KKI0bdsINpD22XrWGgGyOlO+qcCInX7AZotukZPYSoVAEZyvlJqMj3N
	 L9j3gp6e9SJBj/i6BhSmJl2QvtjSrrtB5Yw8bdXY0xvpm1F6QgqKn4MvZ0XYEhPKsU
	 oCoiLwRG3071w==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v6 00/28] KVM: arm64: Implement support for SME
Date: Wed, 25 Jun 2025 11:47:51 +0100
Message-Id: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANjTW2gC/2XRS26DMBAG4Ksgr+vIM34AWfUeVRd+BisFEkNRq
 yh3rx2UVoXljPzNyP/cyORT9BM5VjeS/BKnOA65UC8VsZ0eTp5Gl2uCDDnjDOh56alOvRJ06j1
 lSgMK5bjiimRj9OSpSXqwXVFzfyndS/Ihfj22vL3nuovTPKbvx9IFSned3yJu5i9AGQ0BGlcLg
 613r2efBv9xGNOJlFEL/nLAPcfMnUZU1kDDjNlx/uQic7blPHMmDYPGQgh+z8WTS4YgtlyU7Up
 o1YB21uKOyz8uoN5yWf4uVKvRySBr8Y/f11yTv37mo81ruGv+duz7OB+rRR1A0WR5fn3/AejH/
 n3qAQAA
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
X-Mailer: b4 0.15-dev-08c49
X-Developer-Signature: v=1; a=openpgp-sha256; l=9496; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WyjPlzEckQK2AsiUXQqAYWbsE3Q3tZ56mU/lgBXCQu8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9xkzQxYIgAGrougDvfgpfufkhPrD66hFs/CK
 35t3+AA226JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvcZAAKCRAk1otyXVSH
 0FgeB/sHUc9EaNlDwvkIdk29jGlqiCtgeTHwGoEtYAgZhS/2bMZFl+uXH4kiQElWjdJ4AkrqFWW
 Hwm1Sj4FtDFn+ovlrn+jb5oYfTCk6YO9lMLJkuSgOn5PshFGnj0/CV3LeeC8UMZAGNxesYJsQw5
 1+NitCaZgnQ8ZzsGFPtxsFyw3JSn5OPdkOsDBYaK54/uKb+d/NrkZ7BShM5h41by/4mGo5DxgQL
 Ce59pXCjjsSkWDFzxSFltyuA5H1yYg1PrJb1Jch6nbZvX+ldXFKy9ErD+odWS1W3qsCmDMMnJ5Y
 yW2Vf3MQIJfL+W/oDvxNpIjDJS7Atjy5R0syNHu4E+7E+Jle
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
since finalising SVE makes the SVE registers writeable by userspace and
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
should be configured before other state.  It should be noted that while
the architecture refers to PSTATE.SM and PSTATE.ZA these PSTATE bits are
not preserved in SPSR_ELx, they are only accessible via SVCR.

There are a large number of subfeatures for SME, most of which only
offer additional instructions but some of which (SME2 and FA64) add
architectural state. These are configured via the ID registers as per
usual.

Protected KVM supported, with the implementation maintaining the
existing restriction that the hypervisor will refuse to run if streaming
mode or ZA is enabled.  This both simplfies the code and avoids the need
to allocate storage for host ZA and ZT0 state, there seems to be little
practical use case for supporting this and the memory usage would be
non-trivial.

The new KVM_ARM_VCPU_VEC feature and ZA and ZT0 registers have not been
added to the get-reg-list selftest, the idea of supporting additional
features there without restructuring the program to generate all
possible feature combinations has been rejected.  I will post a separate
series which does that restructuring.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v6:
- Rebase onto v6.16-rc3.
- Link to v5: https://lore.kernel.org/r/20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org

Changes in v5:
- Rebase onto v6.15-rc2.
- Add pKVM guest support.
- Always restore SVCR.
- Link to v4: https://lore.kernel.org/r/20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org

Changes in v4:
- Rebase onto v6.14-rc2 and Mark Rutland's fixes.
- Expose SME to nested guests.
- Additional cleanups and test fixes following on from the rebase.
- Flush register state on VMM PSTATE.{SM,ZA}.
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
Mark Brown (28):
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
      KVM: arm64: Provide assembly for SME register access
      KVM: arm64: Support userspace access to streaming mode Z and P registers
      KVM: arm64: Flush register state on writes to SVCR.SM and SVCR.ZA
      KVM: arm64: Expose SME specific state to userspace
      KVM: arm64: Context switch SME state for guests
      KVM: arm64: Handle SME exceptions
      KVM: arm64: Expose SME to nested guests
      KVM: arm64: Provide interface for configuring and enabling SME for guests
      KVM: arm64: selftests: Add SME system registers to get-reg-list
      KVM: arm64: selftests: Add SME to set_id_regs test

 Documentation/virt/kvm/api.rst                   | 117 +++++++----
 arch/arm64/include/asm/fpsimd.h                  |  26 +++
 arch/arm64/include/asm/kvm_emulate.h             |   6 +
 arch/arm64/include/asm/kvm_host.h                | 168 ++++++++++++---
 arch/arm64/include/asm/kvm_hyp.h                 |   5 +-
 arch/arm64/include/asm/kvm_pkvm.h                |   2 +-
 arch/arm64/include/asm/vncr_mapping.h            |   2 +
 arch/arm64/include/uapi/asm/kvm.h                |  33 +++
 arch/arm64/kernel/cpufeature.c                   |   2 -
 arch/arm64/kernel/fpsimd.c                       |  89 ++++----
 arch/arm64/kvm/arm.c                             |  10 +
 arch/arm64/kvm/fpsimd.c                          |  28 ++-
 arch/arm64/kvm/guest.c                           | 252 ++++++++++++++++++++---
 arch/arm64/kvm/handle_exit.c                     |  14 ++
 arch/arm64/kvm/hyp/fpsimd.S                      |  28 ++-
 arch/arm64/kvm/hyp/include/hyp/switch.h          | 175 ++++++++++++++--
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h       |  97 +++++----
 arch/arm64/kvm/hyp/nvhe/hyp-main.c               |  86 ++++++--
 arch/arm64/kvm/hyp/nvhe/pkvm.c                   |  81 ++++++--
 arch/arm64/kvm/hyp/nvhe/switch.c                 |   4 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c               |   6 +
 arch/arm64/kvm/hyp/vhe/switch.c                  |  17 +-
 arch/arm64/kvm/nested.c                          |   3 +-
 arch/arm64/kvm/reset.c                           | 156 ++++++++++----
 arch/arm64/kvm/sys_regs.c                        | 140 ++++++++++++-
 include/uapi/linux/kvm.h                         |   1 +
 tools/testing/selftests/kvm/arm64/get-reg-list.c |  32 ++-
 tools/testing/selftests/kvm/arm64/set_id_regs.c  |  29 ++-
 28 files changed, 1315 insertions(+), 294 deletions(-)
---
base-commit: 7204503c922cfdb4fcfce4a4ab61f4558a01a73b
change-id: 20230301-kvm-arm64-sme-06a1246d3636

Best regards,
--  
Mark Brown <broonie@kernel.org>


