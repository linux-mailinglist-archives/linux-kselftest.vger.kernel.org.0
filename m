Return-Path: <linux-kselftest+bounces-47711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B99CCC321
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 15:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 182AD30439D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 14:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36166345CB3;
	Thu, 18 Dec 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="WjwtDyNE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out198-20.us.a.mail.aliyun.com (out198-20.us.a.mail.aliyun.com [47.90.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C882034403F;
	Thu, 18 Dec 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066480; cv=none; b=Y0oQE5bRlL3wIHcmbYeOjcGyb8ZJ6tmsd1iNv5sh+7MbSIGD1dSCoLZMpAaKcCXukQeMalDEL5TvaXsfKHC6PP7+Qw2ZqYikAQWo5NTPt0cI6HUDPmmkJeKYf3AQVq5XoSxg7lSO0X6yR4qqvY0TW2KzV4bj/TXBfRuix/7Q7ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066480; c=relaxed/simple;
	bh=Zj2x2WczkgoB0wJ6yqJAX3yn0pXp9GCR3SIIVslacS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H3qJihUqaZ//nhsobNZsZGcniV0MgzZPcqQ02U0spdsh8Vv+bmvZzOzCElYY0sU77YDabcKJak3ig7+o20urs/F6dYrUFjQesQEWxhVKCv5hMtmHzI/ZUUuodIi//mKappnT9wsQsevAiwGPlaqc0+iml1L6e0drRcDEGhOx1eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=WjwtDyNE; arc=none smtp.client-ip=47.90.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1766066454; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JGjyl52eVJxyEoU0zaj329p7+Mpj9y+2N634ae6VlMc=;
	b=WjwtDyNEHhkK9mcV+2GyOpLYrLZhS1LHvtkwHdHM44Psq7uPisMdXlfeQ6PsWYvvpSkCEtK9FuxhvsphYu3BD3v9oqg6Ob6oAXSlEtPLZwSoicltkWH7z3v7kAsO+2kzskWnBhOifmuZBcJicAyn89p7m+4/dVZfl8pHY6I+MUs=
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.fnicD1Y_1766066453 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 18 Dec 2025 22:00:54 +0800
From: Hou Wenlong <houwenlong.hwl@antgroup.com>
To: kvm@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/9] KVM: x86: Improve the handling of debug exceptions during instruction emulation
Date: Thu, 18 Dec 2025 22:00:35 +0800
Message-Id: <cover.1766066076.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During my testing, I found that guest debugging with 'DR6.BD' does not
work in instruction emulation, as the current code only considers the
guest's DR7. Upon reviewing the code, I also observed that the checks
for the userspace guest debugging feature and the guest's own debugging
feature are repeated in different places during instruction
emulation, but the overall logic is the same. If guest debug
is enabled, it needs to exit to userspace; otherwise, a #DB
exception needs to be injected into the guest. Therefore, as
suggested by Jiangshan Lai, some cleanup has been done for #DB
handling in instruction emulation in this patchset. A new
function named 'kvm_inject_emulated_db()' is introduced to
consolidate all the checking logic. Moreover, I hope we can make
the #DB interception path use the same function as well.

Additionally, when I looked into the single-step #DB handling in
instruction emulation, I noticed that the interrupt shadow is toggled,
but it is not considered in the single-step #DB injection. This
oversight causes VM entry to fail on VMX (due to pending debug
exceptions state checking).

As pointed out by Sean, fault-like code #DBs can be coincident with
trap-like single-step #DBs at the instruction boundary on the hardware.
However it is difficult to emulate this in the emulator, as
kvm_vcpu_check_code_breakpoint() is called at the start of the next
instruction while the single-step #DB for the previous instruction has
already been injected.

v1->v2:
  - cleanup in inject_emulated_exception().
  - rename 'set_pending_dbg' callback as 'refresh_pending_dbg_exceptions'.
  - fold refresh_pending_dbg_exceptions() call into
    kvm_vcpu_do_singlestep().
  - Split the change to move up kvm_set_rflags() into a single patch.
  - Move the #DB and IRQ handler registration after guest debug testcases.

Hou Wenlong (9):
  KVM: x86: Capture "struct x86_exception" in
    inject_emulated_exception()
  KVM: x86: Set guest DR6 by kvm_queue_exception_p() in instruction
    emulation
  KVM: x86: Check guest debug in DR access instruction emulation
  KVM: x86: Only check effective code breakpoint in emulation
  KVM: x86: Consolidate KVM_GUESTDBG_SINGLESTEP check into the
    kvm_inject_emulated_db()
  KVM: x86: Move kvm_set_rflags() up before kvm_vcpu_do_singlestep()
  KVM: VMX: Refresh 'PENDING_DBG_EXCEPTIONS.BS' bit during instruction
    emulation
  KVM: selftests: Verify guest debug DR7.GD checking during instruction
    emulation
  KVM: selftests: Verify 'BS' bit checking in pending debug exception
    during VM entry

 arch/x86/include/asm/kvm-x86-ops.h            |   1 +
 arch/x86/include/asm/kvm_host.h               |   1 +
 arch/x86/kvm/emulate.c                        |  14 +--
 arch/x86/kvm/kvm_emulate.h                    |   7 +-
 arch/x86/kvm/vmx/main.c                       |   9 ++
 arch/x86/kvm/vmx/vmx.c                        |  15 ++-
 arch/x86/kvm/vmx/x86_ops.h                    |   1 +
 arch/x86/kvm/x86.c                            | 116 ++++++++++--------
 arch/x86/kvm/x86.h                            |   7 ++
 .../selftests/kvm/include/x86/processor.h     |   3 +-
 tools/testing/selftests/kvm/x86/debug_regs.c  |  72 ++++++++++-
 11 files changed, 178 insertions(+), 68 deletions(-)


base-commit: 5d3e2d9ba9ed68576c70c127e4f7446d896f2af2
--
2.31.1


