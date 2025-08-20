Return-Path: <linux-kselftest+bounces-39374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0AEB2DEF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 16:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12A51667F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C239B221F0C;
	Wed, 20 Aug 2025 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZnqJjl5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907131DDC07;
	Wed, 20 Aug 2025 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699319; cv=none; b=K01Is6JX3twqDGoEKpTu079xE2sv8YGmLs9qBy+VuW8+PRiUU9G5a9R8swlxgrJIj2Y6UKA5BmqfFpY+fyQLuaLpVG3Ro2dZNam/A5zRVVd7GTipBkHeHfqIpaxfqniaopej09ovryMR8U0YjDDpzWkvZys9f9j2BkM+QXPTpsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699319; c=relaxed/simple;
	bh=az0FxiDXmKVIPZV1Ev18Kw1GYBdYXlqv77n5btKqy2g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R0CuDQysto9FvHb4nvpmnrvtN7p0U6Afdj6YjgOghT0NkyzyOO8SkZ74hj7B5eRbBoZRDKuoUJHtrw9Hey1KTCHX7KdJRqLmEr5jIGwTwEtkFLyBmMshICe2SLvLHy5CYxUlPGSX1n4WL25jOB6auvfsjBXe+OqUYB2j3g8VFEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZnqJjl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99386C4CEE7;
	Wed, 20 Aug 2025 14:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755699318;
	bh=az0FxiDXmKVIPZV1Ev18Kw1GYBdYXlqv77n5btKqy2g=;
	h=From:Subject:Date:To:Cc:From;
	b=QZnqJjl5as15luX+evDK6G85xnf5wasbcEidrcSmyxbpFKG3Lf8cSOs5yYllk2Vx4
	 Xvgm0S18x4xeN6Ng0+5OMfswWjxELzxbGYhcgbYVtn66bBsJ8nWvkxic+pDknE44Lb
	 Kj8eziT+GDczQ+zzjkMiDdT5JnhtXDIJruiZBQcF0FFeJxb3addQ/H3EfyshLNciJu
	 Bi5O7jYGficfzEJ/Voib3QNkv4DKfLOY6nzAPB+EDqxpcD+Vt6F40wKjPBBA0X7mVl
	 xibd4WqkHDyx+b+kFNDmeyx70q5RbhDSgCiNucxaGnJ0TVCzojEO8zBY8As7jzgu92
	 MDTo4z0TKJTfQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v15 0/6] KVM: arm64: Provide guest support for GCS
Date: Wed, 20 Aug 2025 15:14:40 +0100
Message-Id: <20250820-arm64-gcs-v15-0-5e334da18b84@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFDYpWgC/2XTyW7cMAwA0F8JfK4LkqK2nPIfQQ9aqBkjzUxgB
 0aLYP69UopkZAg+idCTxMUf0ybrItv0+PAxrbIv23K91AXqHw9TOofLSeYl18BEQArqN4f11fB
 8StssCjFEyM6Sn+r+GDaZ4xou6dzE++tbi76tUpY/n1c8/6rr87K9X9e/nzfu2KL/z7ZourN3n
 GGORRtbvIoxmKcXWS/y++d1PU3tmJ06StxTqjQnSpiZE0kcqOqowp6qSlPOxRfvIHs3UL5TB7a
 nXKlxqQRVnwzGD1R3lKinulIvBR3mbBTxQM03RQDfU1OpdaJ1lhA454HaO8XjrbZSAkzsVMzW6
 oG6L8pAh8bvrpXJF0nWGqukDNTfqSHdU18pFKOYjY+uwEAR7tbBoTsIrcbeC8VM6GHsLGKHj+l
 imyjG6NCzlRTHfJF6fCgztpliqhlXzMqEEX8PFdceHZ/dpoqIonX1XxGREXOPD/XCNle6DhSkb
 MDTMefb7fYPlFIfY8MDAAA=
X-Change-ID: 20230303-arm64-gcs-e311ab0d8729
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=8303; i=broonie@kernel.org;
 h=from:subject:message-id; bh=az0FxiDXmKVIPZV1Ev18Kw1GYBdYXlqv77n5btKqy2g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBopdhtwezNGDr6bKVibgjxGDd4bfbttoLc03kh3
 kp7vZXT5hqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKXYbQAKCRAk1otyXVSH
 0De7B/0YBmgbLhmIUMotiaMyCyPe3WaBmas4aHuk4n/w638XrmUaxuWsty0CUzLev8gOYqderq6
 Yv6+GjBneNo8dvfL3Sahre8XrYQ/Fg47x4hmydl/zJax326DvvL4Hi08zBkgWbVSP/SgYbx6EHQ
 u7CSPfFD1MXHV0Zn6XfAAh+wU20SQc24DQmC0XNesCGqLOYBmqY/bqdfSwvMbpobWXTZ1KLzfS8
 16l/Rd6iByEnMabdjZhoNfvYBTHy4lyh3OnHZaowb4qiusjryCJhJauTWvfq2UgypqbRr+cOyrq
 wEctSnH4C3ZeWmxqW1PCrmd4h5PpJkmf+FVW12Q9xQuLxsxP
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
Changes in v15:
- Rebase onto v6.17-rc1.
- Link to v14: https://lore.kernel.org/r/20241005-arm64-gcs-v14-0-59060cd6092b@kernel.org

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
Mark Brown (6):
      arm64/gcs: Ensure FGTs for EL1 GCS instructions are disabled
      KVM: arm64: Manage GCS access and registers for guests
      KVM: arm64: Forward GCS exceptions to nested guests
      KVM: arm64: Set PSTATE.EXLOCK when entering an exception
      KVM: arm64: Allow GCS to be enabled for guests
      KVM: selftests: arm64: Add GCS registers to get-reg-list

 arch/arm64/include/asm/el2_setup.h               |  4 +++
 arch/arm64/include/asm/kvm_emulate.h             |  3 ++
 arch/arm64/include/asm/kvm_host.h                | 14 +++++++++
 arch/arm64/include/asm/vncr_mapping.h            |  2 ++
 arch/arm64/include/uapi/asm/ptrace.h             |  1 +
 arch/arm64/kvm/handle_exit.c                     | 14 +++++++--
 arch/arm64/kvm/hyp/exception.c                   | 37 ++++++++++++++++++++++++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h       | 31 ++++++++++++++++++++
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c               | 10 +++++++
 arch/arm64/kvm/sys_regs.c                        | 32 ++++++++++++++++++--
 tools/testing/selftests/kvm/arm64/get-reg-list.c | 12 ++++++++
 11 files changed, 155 insertions(+), 5 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20230303-arm64-gcs-e311ab0d8729

Best regards,
--  
Mark Brown <broonie@kernel.org>


