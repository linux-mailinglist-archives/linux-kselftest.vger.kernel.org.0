Return-Path: <linux-kselftest+bounces-19100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA8D991623
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 12:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17AC283D17
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 10:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7634A149011;
	Sat,  5 Oct 2024 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6rqnvRg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C6B13A250;
	Sat,  5 Oct 2024 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124668; cv=none; b=BDyhEwxW/ti6Ea8tH3UWZ93Sc3yKoLPZAcDykP9zsGqIkOsv5kp0T7wSW/mfWLXZb1J26XWnSKuDKXjOdVZYP9St7nITNlNdvr1sPWGJAAABmeNh/Ua0UGLVVsxmyVD2PjRTHh/4tslOcqIjdKIkcgXCmKJLfCHYituUdayykds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124668; c=relaxed/simple;
	bh=fONywxbxTzN0IAzlUbZO96WkETbfa3z2THUpoJ3dZ48=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ozXStCNSxjvGw2WUUXU38FuZ7NlqIzvZClmFe2FNrT01WnV31Ecj7dvLBewvsaPtkDO+WvmUU7CyY1owYo13g4D92tXcrbk+mpVBPlFviX/w/lHuu65dNNXpx8ib6EoxH6KSy6a3pNtWHo45P4eSSjIr8487r3/cq9vn42GbVTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6rqnvRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39033C4CEC2;
	Sat,  5 Oct 2024 10:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728124667;
	bh=fONywxbxTzN0IAzlUbZO96WkETbfa3z2THUpoJ3dZ48=;
	h=From:Subject:Date:To:Cc:From;
	b=l6rqnvRg1C7qfeh+Z/lYECZ7svobSKrPdxgvqYkRtkaYkI3KC7WG2O4n+KhGR8QK+
	 Kd/Zeg4M4XJalsU3OR1yy03MyWeJoLbsVMdRBmjBGXAbrnRbEKB8ddGVfqSoIw4vSl
	 8YYPC6MR1a6cjuh2QOP3munQgsVZJ/ucMC/mk/CuqtStktemDU+57e5ovoM9dSVPcw
	 gY2Caq3/1WyNStKgp+Zgb6mkJELDyA2YvsF+rWpkgTYWPen29Fl7jHWxvmetuQspsU
	 B2kWLpJ+diO70WZ+lfT60fXXF4RlY/S0s90QMn+wup2DAG8x9ELclhKQGTVWukCYev
	 qVqC+IKYdwr+Q==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v14 0/5] KVM: arm64: Provide guest support for GCS
Date: Sat, 05 Oct 2024 11:37:27 +0100
Message-Id: <20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOcWAWcC/2XTyU7EMAwA0F9BPVNkO24WTvwH4pDFmamAGdSiC
 oTm30lAMKminmLlJfHSr2GVZZZ1uL/5GhbZ5nU+n8oC+fZmiEd/Osg4pxIYCEhB+Ua/vGoeD3E
 dRSH6AMkackPZH/wqY1j8KR6reH99q9G3RfL88XPF41NZH+f1/bx8/ty4YY3+nm1QN2dvOMIY8
 qRNdioErx+eZTnJy915OQz1mI0aStxSKjRFipiYI0noqGqowpaqQmNK2WVnITnbUb5SC6alXKi
 2MXtVngzadXRqKFFLp0KdZLSYklbEHdX/FAFcS3Whxso0JfGeU+qouVLc32oKJcDIVoVkzNRR+
 0cZaNf4zdYyuSzRGG2U5I66K9U0tdQVClkrZu2CzdBRhKu1sOsOQq2xc0IhETroO4vY4H26WCe
 KMVh0bCSGPl+kFu/KjHWmmErGBbPSvsf/Q8WlR/tn16kiomBs+VdEZIcvl8s3ebAeCYYDAAA=
X-Change-ID: 20230303-arm64-gcs-e311ab0d8729
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=7916; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fONywxbxTzN0IAzlUbZO96WkETbfa3z2THUpoJ3dZ48=;
 b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBnARb0HLWryNQwMSzWp1/3Yb7JzqLL0j6pW5NgsEsm
 K3icbeeJATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwEW9AAKCRAk1otyXVSH0C6wB/
 jK+pdXsHLRsiuyv04yctaA/EZlq0vbe/mPQzYwKZsxyrI8IvtwBCUOOmlOPkyDeR/3AA9JDqfN7Rvn
 aKD3CZ7fe1w2j2lpzXq6e3pSpknJH+BNjYkKg24MOtb9/MxA4hXJOgz6j392dQDB+hdTK1hk++xPr6
 Q8iFTBdnK47k7n9ReCM8+tSRLkSJQuXHJKmfZZkxmOgnIMq2K7dYyNHK1n726h9AvEIvpQYbXTXE8Y
 UVFAd+fKDrtPVYSVOMq6Mz35erMIAuaOhk7t26GV4fh4eSGgBFZP4472Os0qOd+k+zW/FvSyDkoSxW
 afKkwp9CKjnbx0IIU66i4eM2Hxz3E=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The arm64 Guarded Control Stack (GCS) feature provides support for
hardware protected stacks of return addresses, intended to provide
hardening against return oriented programming (ROP) attacks and to make
it easier to gather call stacks for applications such as profiling.

When GCS is active a secondary stack called the Guarded Control Stack is
maintained, protected with a memory attribute which means that it can
only be written with specific GCS operations.  The current GCS pointer
can not be directly written to by userspace.  When a BL is executed the
value stored in LR is also pushed onto the GCS, and when a RET is
executed the top of the GCS is popped and compared to LR with a fault
being raised if the values do not match.  GCS operations may only be
performed on GCS pages, a data abort is generated if they are not.

The combination of hardware enforcement and lack of extra instructions
in the function entry and exit paths should result in something which
has less overhead and is more difficult to attack than a purely software
implementation like clang's shadow stacks.

This series implements support for managing GCS for KVM guests, it also
includes a fix for S1PIE which has also been sent separately as this
feature is a dependency for GCS.  It is based on:

   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/gcs

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v14:
- Rebase onto arm64/for-next/gcs which includes all the non-KVM support.
- Manage the fine grained traps for GCS instructions.
- Manage PSTATE.EXLOCK when delivering exceptions to KVM guests.
- Link to v13: https://lore.kernel.org/r/20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org

Changes in v13:
- Rebase onto v6.12-rc1.
- Allocate VM_HIGH_ARCH_6 since protection keys used all the existing
  bits.
- Implement mm_release() and free transparently allocated GCSs there.
- Use bit 32 of AT_HWCAP for GCS due to AT_HWCAP2 being filled.
- Since we now only set GCSCRE0_EL1 on change ensure that it is
  initialised with GCSPR_EL0 accessible to EL0.
- Fix OOM handling on thread copy.
- Link to v12: https://lore.kernel.org/r/20240829-arm64-gcs-v12-0-42fec947436a@kernel.org

Changes in v12:
- Clarify and simplify the signal handling code so we work with the
  register state.
- When checking for write aborts to shadow stack pages ensure the fault
  is a data abort.
- Depend on !UPROBES.
- Comment cleanups.
- Link to v11: https://lore.kernel.org/r/20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org

Changes in v11:
- Remove the dependency on the addition of clone3() support for shadow
  stacks, rebasing onto v6.11-rc3.
- Make ID_AA64PFR1_EL1.GCS writeable in KVM.
- Hide GCS registers when GCS is not enabled for KVM guests.
- Require HCRX_EL2.GCSEn if booting at EL1.
- Require that GCSCR_EL1 and GCSCRE0_EL1 be initialised regardless of
  if we boot at EL2 or EL1.
- Remove some stray use of bit 63 in signal cap tokens.
- Warn if we see a GCS with VM_SHARED.
- Remove rdundant check for VM_WRITE in fault handling.
- Cleanups and clarifications in the ABI document.
- Clean up and improve documentation of some sync placement.
- Only set the EL0 GCS mode if it's actually changed.
- Various minor fixes and tweaks.
- Link to v10: https://lore.kernel.org/r/20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org

Changes in v10:
- Fix issues with THP.
- Tighten up requirements for initialising GCSCR*.
- Only generate GCS signal frames for threads using GCS.
- Only context switch EL1 GCS registers if S1PIE is enabled.
- Move context switch of GCSCRE0_EL1 to EL0 context switch.
- Make GCS registers unconditionally visible to userspace.
- Use FHU infrastructure.
- Don't change writability of ID_AA64PFR1_EL1 for KVM.
- Remove unused arguments from alloc_gcs().
- Typo fixes.
- Link to v9: https://lore.kernel.org/r/20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org

Changes in v9:
- Rebase onto v6.10-rc3.
- Restructure and clarify memory management fault handling.
- Fix up basic-gcs for the latest clone3() changes.
- Convert to newly merged KVM ID register based feature configuration.
- Fixes for NV traps.
- Link to v8: https://lore.kernel.org/r/20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org

Changes in v8:
- Invalidate signal cap token on stack when consuming.
- Typo and other trivial fixes.
- Don't try to use process_vm_write() on GCS, it intentionally does not
  work.
- Fix leak of thread GCSs.
- Rebase onto latest clone3() series.
- Link to v7: https://lore.kernel.org/r/20231122-arm64-gcs-v7-0-201c483bd775@kernel.org

Changes in v7:
- Rebase onto v6.7-rc2 via the clone3() patch series.
- Change the token used to cap the stack during signal handling to be
  compatible with GCSPOPM.
- Fix flags for new page types.
- Fold in support for clone3().
- Replace copy_to_user_gcs() with put_user_gcs().
- Link to v6: https://lore.kernel.org/r/20231009-arm64-gcs-v6-0-78e55deaa4dd@kernel.org

Changes in v6:
- Rebase onto v6.6-rc3.
- Add some more gcsb_dsync() barriers following spec clarifications.
- Due to ongoing discussion around clone()/clone3() I've not updated
  anything there, the behaviour is the same as on previous versions.
- Link to v5: https://lore.kernel.org/r/20230822-arm64-gcs-v5-0-9ef181dd6324@kernel.org

Changes in v5:
- Don't map any permissions for user GCSs, we always use EL0 accessors
  or use a separate mapping of the page.
- Reduce the standard size of the GCS to RLIMIT_STACK/2.
- Enforce a PAGE_SIZE alignment requirement on map_shadow_stack().
- Clarifications and fixes to documentation.
- More tests.
- Link to v4: https://lore.kernel.org/r/20230807-arm64-gcs-v4-0-68cfa37f9069@kernel.org

Changes in v4:
- Implement flags for map_shadow_stack() allowing the cap and end of
  stack marker to be enabled independently or not at all.
- Relax size and alignment requirements for map_shadow_stack().
- Add more blurb explaining the advantages of hardware enforcement.
- Link to v3: https://lore.kernel.org/r/20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org

Changes in v3:
- Rebase onto v6.5-rc4.
- Add a GCS barrier on context switch.
- Add a GCS stress test.
- Link to v2: https://lore.kernel.org/r/20230724-arm64-gcs-v2-0-dc2c1d44c2eb@kernel.org

Changes in v2:
- Rebase onto v6.5-rc3.
- Rework prctl() interface to allow each bit to be locked independently.
- map_shadow_stack() now places the cap token based on the size
  requested by the caller not the actual space allocated.
- Mode changes other than enable via ptrace are now supported.
- Expand test coverage.
- Various smaller fixes and adjustments.
- Link to v1: https://lore.kernel.org/r/20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org

---
Mark Brown (5):
      KVM: arm64: Expose S1PIE to guests
      arm64/gcs: Ensure FGTs for EL1 GCS instructions are disabled
      KVM: arm64: Manage GCS access and registers for guests
      KVM: arm64: Set PSTATE.EXLOCK when entering an exception
      KVM: selftests: arm64: Add GCS registers to get-reg-list

 arch/arm64/include/asm/el2_setup.h                 |  7 ++++-
 arch/arm64/include/asm/kvm_host.h                  | 12 ++++++++
 arch/arm64/include/asm/vncr_mapping.h              |  2 ++
 arch/arm64/include/uapi/asm/ptrace.h               |  2 ++
 arch/arm64/kvm/hyp/exception.c                     | 10 +++++++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         | 31 +++++++++++++++++++
 arch/arm64/kvm/sys_regs.c                          | 35 ++++++++++++++++++++--
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 28 +++++++++++++++++
 8 files changed, 124 insertions(+), 3 deletions(-)
---
base-commit: ed4983d2da8c3b66ac6d048beb242916bec83522
change-id: 20230303-arm64-gcs-e311ab0d8729

Best regards,
-- 
Mark Brown <broonie@kernel.org>


