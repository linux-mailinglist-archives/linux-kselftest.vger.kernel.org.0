Return-Path: <linux-kselftest+bounces-2377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387E881CCAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAF81C20E50
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188A224203;
	Fri, 22 Dec 2023 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNSIJ51C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB710241E2;
	Fri, 22 Dec 2023 16:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5572BC433C7;
	Fri, 22 Dec 2023 16:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262097;
	bh=m0ODHtnaPkuVsw9fjoMNNENys/cu04TsEhtfrgB52v4=;
	h=From:Subject:Date:To:Cc:From;
	b=KNSIJ51CIod5RPX4Xz3Sb6/Xx3D2wL6/JJ1B6SzVBzF0EAq651qDnGDqJnZln7F+s
	 RDEqFqkwsVpnDjTFz9wzxg3Rn1HjxCO5VzWBgVOidPdQUS2fjRgf2A+OxvI8MqEiB8
	 kF8xXplbt8wuVg6mpNiY2/eiELI9fV4ZFAd1ZDk3ofNnkfQjjDdeGmilEwaH9UGQM+
	 8UHavYPD0jlbsO/k3zd+3QVftBEQojKW2s0d+DPRVVqakKDJYwmJVm6Cr71qAK0Xys
	 LC6QDsTsTm2+QtRBGUlscqAFS39d0pS67Pumu6l0wjjYNF4ruxBbWZIGIOqH25VwKm
	 vSDen4mnRM+uQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH RFC v2 00/22] KVM: arm64: Implement support for SME in
 non-protected guests
Date: Fri, 22 Dec 2023 16:21:08 +0000
Message-Id: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHS3hWUC/12Nyw6CMBBFf8XM2jF9kCquTEz8ALeGRaEDNNhCW
 kI0hH+3dOnynpuTs0KkYCnC9bBCoMVGO/o0xPEATa99R2hN2iCYkEwyjsPiUAenCoyOkCnNRaG
 MVFJBcmodCeugfdPv1uymnU6BWvvJlRc8H3eoEuxtnMfwzeWF5ytHSiH+IgtHhm3LL+Zc1KIkc
 xsoeHqfxtBBtW3bD/yAenbGAAAA
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=7140; i=broonie@kernel.org;
 h=from:subject:message-id; bh=m0ODHtnaPkuVsw9fjoMNNENys/cu04TsEhtfrgB52v4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbd7uP6NSZb+D8UhOZbWwepg4GW4chB3q1Zx3nyc
 E8TYpcuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3ewAKCRAk1otyXVSH0DbQB/
 9X48WCt09YD+HgqAYlKceDo460rtB8kn2k31GJlwiUZA6R1fLY09VZ2kBJdjCd0c/KcIMG2iXwHmon
 4eN2FBvC4wHZ8BbQAeV3cT5IqW4zc5IPIVByNcf0F+951iJjBxGh310nOcd89gjRl3JWFOOBkDPckB
 7qPD0YjHngsXXd6qbaQwddydmdFfJfI5ZOEUFiYGAwxLB7NwVPS9P36WV/06mu/t1re161el3+ZX1M
 SPyhfSN/XZdYr8nco2iQdGVzhL+vOUw3rCrVjJ84hJrIjF3Bez9d9mvyeX2oLUw6QPSseLl6zMdgC7
 ce2ZdMvb5UE+7Ad7qTTbXoGx11zMrH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This series implements support for SME use in non-protected KVM guests.
Much of this is very similar to SVE, the main additional challenge that
SME presents is that it introduces two new controls which change the
registers seen by guests:

 - PSTATE.ZA enables the ZA matrix register and, if SME2 is supported,
   the ZT0 LUT register.
 - PSTATE.SM enables streaming mode, a new floating point mode which
   uses the SVE register set with a separately configured vector length.
   In streaming mode implementation of the FFR register is optional.

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

We represent the streaming mode registers to userspace by always using
the existing SVE registers to access the floating point state, using the
larger of the SME and (if enabled for the guest) SVE vector lengths.

There are a large number of subfeatures for SME, most of which only
offer additional instructions but some of which (SME2 and FA64) add
architectural state.  The expectation is that these will be configured
via the ID registers but since the mechanism for doing this is still
unclear the current code enables SME2 and FA64 for the guest if the host
supports them regardless of what the ID registers say.

Since we do not yet have support for SVE in protected guests and SME is
very reliant on SVE this series does not implement support for SME in
protected guests.  This will be added separately once SVE support is
merged into mainline (or along with merging that), there is code for
protected guests using SVE in the Android tree.

The new KVM_ARM_VCPU_VEC feature and ZA and ZT0 registers have not been
added to the get-reg-list selftest, the idea of supporting additional
features there without restructuring the program to generate all
possible feature combinations has been rejected.  I will post a separate
series which does that restructuring.

I am seeing some test failures currently which I've not got to the
bottom of, at this point I'm reasonably sure these are preexisting
issues in the kernel which are more apparent in a guest.

To: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oliver.upton@linux.dev>
To: James Morse <james.morse@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc:  <linux-arm-kernel@lists.infradead.org>
Cc:  <kvmarm@lists.linux.dev>
Cc:  <linux-kernel@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc:  <kvm@vger.kernel.org>
Cc:  <linux-doc@vger.kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc:  <linux-kselftest@vger.kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>

Changes in v2:
- Rebase onto v6.7-rc3.
- Configure subfeatures based on host system only.
- Complete nVHE support.
- There was some snafu with sending v1 out, it didn't make it to the
  lists but in case it hit people's inboxes I'm sending as v2.

---
Mark Brown (22):
      KVM: arm64: Document why we trap SVE access from the host
      arm64/fpsimd: Make SVE<->FPSIMD rewriting available to KVM
      KVM: arm64: Move SVE state access macros after feature test macros
      KVM: arm64: Store vector lengths in an array
      KVM: arm64: Document the KVM ABI for SME
      KVM: arm64: Make FFR restore optional in __sve_restore_state()
      KVM: arm64: Define guest flags for SME
      KVM: arm64: Rename SVE finalization constants to be more general
      KVM: arm64: Basic SME system register descriptions
      KVM: arm64: Add support for TPIDR2_EL0
      KVM: arm64: Make SMPRI_EL1 RES0 for SME guests
      KVM: arm64: Make SVCR a normal system register
      KVM: arm64: Context switch SME state for guest
      KVM: arm64: Manage and handle SME traps
      KVM: arm64: Implement SME vector length configuration
      KVM: arm64: Rename sve_state_reg_region
      KVM: arm64: Support userspace access to streaming mode SVE registers
      KVM: arm64: Expose ZA to userspace
      KVM: arm64: Provide userspace access to ZT0
      KVM: arm64: Support SME version configuration via ID registers
      KVM: arm64: Provide userspace ABI for enabling SME
      KVM: arm64: selftests: Add SME system registers to get-reg-list

 Documentation/virt/kvm/api.rst                     | 104 +++++---
 arch/arm64/include/asm/fpsimd.h                    |   5 +
 arch/arm64/include/asm/kvm_emulate.h               |  13 +-
 arch/arm64/include/asm/kvm_host.h                  |  99 +++++---
 arch/arm64/include/asm/kvm_hyp.h                   |   3 +-
 arch/arm64/include/uapi/asm/kvm.h                  |  33 +++
 arch/arm64/kernel/fpsimd.c                         |  51 +++-
 arch/arm64/kvm/arm.c                               |  16 +-
 arch/arm64/kvm/fpsimd.c                            | 266 ++++++++++++++++++---
 arch/arm64/kvm/guest.c                             | 230 +++++++++++++++---
 arch/arm64/kvm/handle_exit.c                       |  11 +
 arch/arm64/kvm/hyp/fpsimd.S                        |  11 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |  86 ++++++-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |  16 ++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 |  60 ++++-
 arch/arm64/kvm/hyp/nvhe/switch.c                   |  13 +-
 arch/arm64/kvm/hyp/vhe/switch.c                    |   3 +
 arch/arm64/kvm/reset.c                             | 150 +++++++++---
 arch/arm64/kvm/sys_regs.c                          |  67 +++++-
 include/uapi/linux/kvm.h                           |   1 +
 tools/testing/selftests/kvm/aarch64/get-reg-list.c |  32 ++-
 21 files changed, 1063 insertions(+), 207 deletions(-)
---
base-commit: 4ae6e89253b387476c2ba0202c3a80f2e1284e91
change-id: 20230301-kvm-arm64-sme-06a1246d3636

Best regards,
-- 
Mark Brown <broonie@kernel.org>


