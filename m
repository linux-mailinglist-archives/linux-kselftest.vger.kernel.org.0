Return-Path: <linux-kselftest+bounces-23667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729499F96E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDED51883B57
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA64321A428;
	Fri, 20 Dec 2024 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wps48XRq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F903219A63;
	Fri, 20 Dec 2024 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713454; cv=none; b=EPeSZb8BeY0JsjepBKhxzX9Afy5bRLYE4eHJ/Z2qIIjt4lnC4TCE+k7ro7XrZCPJr9fEm87BzVcUMzsbrfXrEj9GJbt8LGN/w4hHQOUMEyjH1mnuvK8lnevwcXw6Y4bp6s49f4SAZtJgeXZFKtESM9Pw+M994M50d1S8uHBBQgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713454; c=relaxed/simple;
	bh=qCEeBucWpsjsadxrEapp877BPJganTt123C8rlGCdKc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tR4qzEIlABut+XLOhz6YEcv6FhowJWaYe4hpTblSyg5NCCciSCfEZ1pMaWVW8vFk9Vd4GH7uwohDyCmYW6v1lL5vzrwprAkTBUHtx6BqyO1uCNnAEBQgriKmIQi6uOKNd4vn7JVI8xUd1wXzaHK6ohaNLL1asNbxpd85gIjuQwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wps48XRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9234DC4CED3;
	Fri, 20 Dec 2024 16:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713454;
	bh=qCEeBucWpsjsadxrEapp877BPJganTt123C8rlGCdKc=;
	h=From:Subject:Date:To:Cc:From;
	b=Wps48XRqGq04AitmWW4Mp1nPnb9fxwp9H+wYNkAa8MMm9Zgftg0E0ON+aMI9YA8hl
	 AhpKldwh5ff0y7+vJ/ThgEgHWAg0Hl2k5abmrS32xbP1vX8DDURi5qBPUp30R3omXO
	 cBd+h+tXYLGhyXTryddKNogk6RYLGy3oQuhhuxr5seGX2Qw9X1JY7CgJRLQUBBQVwc
	 wBFxxZO/KFe+RFtEhUn4zlmoIYtBc12TIxb/yzDRz2q7ouB6MbsT1Muy+Jc3jVd9uY
	 6IRPu3S9KiwaiUJIy+mr+uAQyB7+GF/UVAzz9i88gPe/lN00zgrv9Be4CNcYyTQOI9
	 sdtOjmQ4AJzfw==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH RFC v3 00/27] KVM: arm64: Implement support for SME in
 non-protected guests
Date: Fri, 20 Dec 2024 16:46:25 +0000
Message-Id: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGKfZWcC/2WQwU7DMAyGX6XKmVSx06ZrT5Mm8QBcEYekddtoS
 zOSUoGmvTtpQEjA0bY+f/59Y5GCpci64sYCbTZav6RCPhSsn/UyEbdDqhkKlEIK4OfNcR2cqnh
 0xIXSgJUapJKKJcboSNwEvfTzTq3uunevgUb7ni3P7OnxxF5Sc7Zx9eEjmzfIoyxpEf9INuCCj
 yMchqYy2NJwPFNY6FL6MOVVG/7ggP9xTPigEVVv4CCM+YXfv+4L9PqWwq/fR+YcvXfOrl2xqRI
 kDz3uWRzFqPNbuiIJK0BQIGpRN2XdtEICB75qY/Rx8n66UJm2JMv9E1FYBmFqAQAA
X-Change-ID: 20230301-kvm-arm64-sme-06a1246d3636
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=10004; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qCEeBucWpsjsadxrEapp877BPJganTt123C8rlGCdKc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBUm9K6QKHwOnM1xfJPwVnxakQq/zpoUi5fWS76
 g+Hr6m6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgVAAKCRAk1otyXVSH0J/uB/
 9Ul5tMNpnWWKoP9Qg3Qm2LvqvJgMGWRxN8zgcI6vOiLsAA737fAz0OKlAJvWvBrZ8lSJUIqwnERqGw
 nBnqKN8yuzQrMrVpU/DtWlUK1gdhJCgNf6b0puLPjy2mlpUqQ6Vq2yLKTzwMdH0j4Zww6RjaW2MU76
 xX9ZJnL2LiEmSw+0sH4BXalUddy9J1d4hyYaz56WU1OD2vwJTeYkHO39KDaMiYZwAM8EVwRd4NUYfZ
 TTdSMfwn0JtN1wyo4FxBZMvb7rN2p2kTA/iD20O5acNvOzR9dLarceFf4oUU79WEkIq4UM71/crN/L
 tHJaVLHhp9IUq1GYXXqSVZ4LgUUFs0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Given the time of year and point in the release cycle this is an RFC
series, there's a few areas where I'm particularly expecting that people
might have feedback:

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

There is some nested virtualisation support in the code but it is not
enabled or complete, this will be completed before the RFC tag is
removed. I am anticipating having a vastly better test environment soon
which will make this much easier to complete and there is no SME
specific ABI for nested virtualisation.

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
separately.

The series is based on Fuad's series:

  https://lore.kernel.org/r/20241216105057.579031-1-tabba@google.com/

It will need a rebase on:

  https://lore.kernel.org/r/20241219173351.1123087-1-maz@kernel.org

(as will Fuad's.)

Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
      KVM: arm64: Pull ctxt_has_ helpers to start of sysreg-sr.h
      KVM: arm64: Convert cpacr_clear_set() to a static inline
      KVM: arm64: Move SVE state access macros after feature test macros
      KVM: arm64: Factor SVE guest exit handling out into a function
      KVM: arm64: Rename SVE finalization constants to be more general
      KVM: arm64: Document the KVM ABI for SME
      KVM: arm64: Define internal features for SME
      KVM: arm64: Rename sve_state_reg_region
      KVM: arm64: Store vector lengths in an array
      KVM: arm64: Implement SME vector length configuration
      KVM: arm64: Add definitions for SME control register
      KVM: arm64: Support TPIDR2_EL0
      KVM: arm64: Support SMIDR_EL1 for guests
      KVM: arm64: Support SME priority registers
      KVM: arm64: Provide assembly for SME state restore
      KVM: arm64: Support Z and P registers in streaming mode
      KVM: arm64: Expose SME specific state to userspace
      KVM: arm64: Context switch SME state for normal guests
      KVM: arm64: Handle SME exceptions
      KVM: arm64: Provide interface for configuring and enabling SME for guests
      KVM: arm64: selftests: Add SME system registers to get-reg-list
      KVM: arm64: selftests: Add SME to set_id_regs test

 Documentation/virt/kvm/api.rst                     | 117 ++++++---
 arch/arm64/include/asm/fpsimd.h                    |  22 ++
 arch/arm64/include/asm/kvm_emulate.h               |  37 ++-
 arch/arm64/include/asm/kvm_host.h                  | 135 ++++++++---
 arch/arm64/include/asm/kvm_hyp.h                   |   4 +-
 arch/arm64/include/asm/kvm_pkvm.h                  |   2 +-
 arch/arm64/include/asm/vncr_mapping.h              |   2 +
 arch/arm64/include/uapi/asm/kvm.h                  |  33 +++
 arch/arm64/kernel/cpufeature.c                     |   2 -
 arch/arm64/kernel/fpsimd.c                         |  86 ++++---
 arch/arm64/kvm/arm.c                               |  10 +
 arch/arm64/kvm/fpsimd.c                            | 156 +++++++-----
 arch/arm64/kvm/guest.c                             | 262 ++++++++++++++++++---
 arch/arm64/kvm/handle_exit.c                       |  14 ++
 arch/arm64/kvm/hyp/fpsimd.S                        |  16 ++
 arch/arm64/kvm/hyp/include/hyp/switch.h            | 104 ++++++--
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |  47 ++--
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 |  17 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |   4 +-
 arch/arm64/kvm/hyp/nvhe/switch.c                   |  11 +-
 arch/arm64/kvm/hyp/vhe/switch.c                    |  21 +-
 arch/arm64/kvm/reset.c                             | 154 +++++++++---
 arch/arm64/kvm/sys_regs.c                          | 118 +++++++++-
 include/uapi/linux/kvm.h                           |   1 +
 tools/testing/selftests/kvm/aarch64/get-reg-list.c |  32 ++-
 tools/testing/selftests/kvm/aarch64/set_id_regs.c  |  29 ++-
 26 files changed, 1117 insertions(+), 319 deletions(-)
---
base-commit: e32a80927434907f973f38a88cd19d7e51991d24
change-id: 20230301-kvm-arm64-sme-06a1246d3636
prerequisite-message-id: 20241216105057.579031-1-tabba@google.com
prerequisite-patch-id: 10a23279fc1aa942c363d66df0e95414342b614b
prerequisite-patch-id: 670db72b1987d2591e23db072fd27db7f65ffb0f
prerequisite-patch-id: c6bc6f799cebe5010bf3d734eb06e39d5dfab0d6
prerequisite-patch-id: 5555cde0b025483c2318d006a0324fd95bd06268
prerequisite-patch-id: a73738d5bbc5e694c92b7a5654f78eb79ed23c09
prerequisite-patch-id: 6194857db22ccaefe13e88b3155b6e761c9b7692
prerequisite-patch-id: 5dca3992c2ffa5bf2edb45f68be45edfae9b41b3
prerequisite-patch-id: b048e799d816c9c6750ed4f264fd38cb6e31f968
prerequisite-patch-id: 07fea6c2207f8cd2d35d4c171a97d28397db9a79
prerequisite-patch-id: f330e82665af9f223e838511bd4a95faad56e3ac
prerequisite-patch-id: 060a6061eaedb7fd02c18e898bfd9652c991b9af
prerequisite-patch-id: fc31d9f0e7812a8f962876fdb311414122895389
prerequisite-patch-id: ae675f63215a211c42a497789ee5e092fd461279
prerequisite-patch-id: ff3c533043a1fa3a13827ea5c70459b228aa95ee
prerequisite-patch-id: de489d2d73f49d74b75c628828a6b56dbac751e2
prerequisite-patch-id: 92f4a1249e3a1ff32eb16c25af56930762c5697d
prerequisite-patch-id: ac1248b4e10dce15672e02b366a359d634297877

Best regards,
-- 
Mark Brown <broonie@kernel.org>


