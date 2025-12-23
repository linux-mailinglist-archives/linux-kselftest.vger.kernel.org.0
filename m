Return-Path: <linux-kselftest+bounces-47870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8993FCD7A5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A7833042BA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EBE222565;
	Tue, 23 Dec 2025 01:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jijWCj6x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443B1F541E;
	Tue, 23 Dec 2025 01:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452895; cv=none; b=F+UBn+ZWEz8ytmMHrnLP3QnOI4eEyvGlEH66rU1SJxtLFpcFfTd2qcq0bD8Ry1ZQMj9pQfo7T+mKygxaMSfZOCioyL7cGaVTjwf7fnbsr+pcIWWE9HKp4Vsabb5cUA3/FmGRgcTR4hEKpK9dj3xaxhfGQq51kgQUnvn7vYkZfpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452895; c=relaxed/simple;
	bh=RCwPCR8V7LwNtswKx2PNWbdaptOLKzPY1WFiZk8EQPk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JUBsAgJnDwicq8NrW88dl/R5GumWt1J1gL0RtLh5daWmQ4irzmb/X/kIlvBYB1yd104w/q25H1ElBJGzmISWUiVkJMjEaD5Kyk6EbAds8idtv4iYaWvb36DW8L03hAGbWbWW3DJT8DjiQACsfWAanVsPY+x7exQpsItl5HNmbHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jijWCj6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9EBC116C6;
	Tue, 23 Dec 2025 01:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452895;
	bh=RCwPCR8V7LwNtswKx2PNWbdaptOLKzPY1WFiZk8EQPk=;
	h=From:Subject:Date:To:Cc:From;
	b=jijWCj6xTEtNwrDopp8+5dgmHORgA0hroCyyC44inKXo2RT9vHkpc5Qzgrl7UYxEU
	 6iHRYhV/CJTCor4t10qHXczJ0EMrJjDtns6u21vZWvIrEOtohSYYEHA1nALy4CKUia
	 nvBXbOJW8l6FQxuXfWW5vhMRXwrUi1x7yK+hpiVdZs9JUOUbnJM9adb5LFgq0oCPGK
	 tAzyKkZGcMRiXrtmPXlfxUqqVwyctKybNYO1zuv+EPaDHhm976UuLxH1uZ3UJz7/vA
	 fF47yPzr2D+Fr5RxCKgYFiREgFtnqjdFCmwUacju3vS5GCzv/JcdbXOD2vvSVoSucF
	 zZ6Rk3TI0ckOQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v9 00/30] KVM: arm64: Implement support for SME
Date: Tue, 23 Dec 2025 01:20:54 +0000
Message-Id: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHfuSWkC/2XSzW7DIAwH8Fepch4VdsCBnvYe0w58tlGXpCNZt
 Knqu4806qqFoy1+NqD/tRpDasNYHXbXKoW5Hduhz4V+2VXuZPpjYK3PdYUca15zYOe5YyZ1JNj
 YBcbJAAryNdVUZWPNGJhNpnenRU3dZeleUojt933L23uuT+04DennvnSGpbvO14ib+TMwzmIE5
 RthUQf/eg6pDx/7IR2rZdSMfxyw5Ji5N4jkLChubcHrBxeZ8y2vM+fSclAOYgwlFw8uOYLYcrF
 sJ2FIgfHOYcHlkwtotlwubxekDXoZZSMKTk9OKLecMgcQLkaR785L3jy5Kr+uybwxJL1Cqyzwg
 qsn17zgKnN0FkFrR5LcP35bQ5HC51dO3LQmYw2PG7qunQ67mfagWXKQT99+AfttIkinAgAA
X-Change-ID: 20230301-kvm-arm64-sme-06a1246d3636
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=10595; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RCwPCR8V7LwNtswKx2PNWbdaptOLKzPY1WFiZk8EQPk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6CE43K4tNMoaKm8RiLoj8JbAp4KnLo7g6wZ
 yPW8xSXwdGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnuggAKCRAk1otyXVSH
 0BLRB/9GOFsxJhKl+9f+soMN4ZPT/Rrld8Fq3PinnZUfAJeqbKOokmEt+vUCY6gV/ttk2xU+SZI
 p5CK94uS0xIz3R/HZpZwGVIsjEq6vm1E6akZmhJC0ZmylJO9fqGpI/cTFF0VRvfSR2OWWZU7BRB
 3EkRu3KnatzHkcHwSZy8xk/SyAkh+qa9Y98NNuNRV06lQ8/YoO/v42PmaJHa4mQBaNRIEjYCaLP
 RJWekXtpUVPxlMpN260dXt6OCGjWXkQ56cB4PzGWCNLk7T4HxBmpn8tQFcjYalerpNmOf66HxMs
 XqVyGo3VDKrcjnMFQuGmlS8gb9P4zideSr2ynT5DyU5X5xqY
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
Changes in v9:
- Rebase onto v6.19-rc1.
- ABI document clarifications.
- Add changes dropping asserts on single bit wide bitfields in set_id_regs.
- Link to v8: https://lore.kernel.org/r/20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org

Changes in v8:
- Small fixes in ABI documentation.
- Link to v7: https://lore.kernel.org/r/20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org

Changes in v7:
- Rebase onto v6.17-rc1.
- Handle SMIDR_EL1 as a VM wide ID register and use this in feat_sme_smps().
- Expose affinity fields in SMIDR_EL1.
- Remove SMPRI_EL1 from vcpu_sysreg, the value is always 0 currently.
- Prevent userspace writes to SMPRIMAP_EL2.
- Link to v6: https://lore.kernel.org/r/20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org

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
Mark Brown (30):
      arm64/sysreg: Update SMIDR_EL1 to DDI0601 2025-06
      arm64/fpsimd: Update FA64 and ZT0 enables when loading SME state
      arm64/fpsimd: Decide to save ZT0 and streaming mode FFR at bind time
      arm64/fpsimd: Check enable bit for FA64 when saving EFI state
      arm64/fpsimd: Determine maximum virtualisable SME vector length
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
      KVM: arm64: selftests: Remove spurious check for single bit safe values
      KVM: arm64: selftests: Skip impossible invalid value tests
      KVM: arm64: selftests: Add SME system registers to get-reg-list
      KVM: arm64: selftests: Add SME to set_id_regs test

 Documentation/virt/kvm/api.rst                   | 120 ++++++++---
 arch/arm64/include/asm/fpsimd.h                  |  26 +++
 arch/arm64/include/asm/kvm_emulate.h             |   6 +
 arch/arm64/include/asm/kvm_host.h                | 163 ++++++++++++---
 arch/arm64/include/asm/kvm_hyp.h                 |   5 +-
 arch/arm64/include/asm/kvm_pkvm.h                |   2 +-
 arch/arm64/include/asm/vncr_mapping.h            |   2 +
 arch/arm64/include/uapi/asm/kvm.h                |  33 +++
 arch/arm64/kernel/cpufeature.c                   |   2 -
 arch/arm64/kernel/fpsimd.c                       |  89 ++++----
 arch/arm64/kvm/arm.c                             |  10 +
 arch/arm64/kvm/config.c                          |  11 +-
 arch/arm64/kvm/fpsimd.c                          |  28 ++-
 arch/arm64/kvm/guest.c                           | 252 ++++++++++++++++++++---
 arch/arm64/kvm/handle_exit.c                     |  14 ++
 arch/arm64/kvm/hyp/fpsimd.S                      |  28 ++-
 arch/arm64/kvm/hyp/include/hyp/switch.h          | 168 +++++++++++++--
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h       | 110 ++++++----
 arch/arm64/kvm/hyp/nvhe/hyp-main.c               |  86 ++++++--
 arch/arm64/kvm/hyp/nvhe/pkvm.c                   |  85 ++++++--
 arch/arm64/kvm/hyp/nvhe/switch.c                 |   4 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c               |   6 +
 arch/arm64/kvm/hyp/vhe/switch.c                  |  17 +-
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c               |   7 +
 arch/arm64/kvm/nested.c                          |   3 +-
 arch/arm64/kvm/reset.c                           | 156 ++++++++++----
 arch/arm64/kvm/sys_regs.c                        | 140 ++++++++++++-
 arch/arm64/tools/sysreg                          |   8 +-
 include/uapi/linux/kvm.h                         |   1 +
 tools/testing/selftests/kvm/arm64/get-reg-list.c |  15 +-
 tools/testing/selftests/kvm/arm64/set_id_regs.c  |  84 ++++++--
 31 files changed, 1367 insertions(+), 314 deletions(-)
---
base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
change-id: 20230301-kvm-arm64-sme-06a1246d3636

Best regards,
--  
Mark Brown <broonie@kernel.org>


