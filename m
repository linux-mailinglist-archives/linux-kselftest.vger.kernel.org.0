Return-Path: <linux-kselftest+bounces-41096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6DDB50BCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 04:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73034E2E37
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 02:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361F923D7C8;
	Wed, 10 Sep 2025 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="jShTTKP+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A8C2033A;
	Wed, 10 Sep 2025 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472576; cv=none; b=kuJdz9G/MCmO6LvBukMEcL1cVZ/dffScAOE9KpyOYh0+SDSKtgCOUIWoQfgBweGPMM7L6UHnKhdAB5d+oh6Vk5uTz0iemI1YMs82kTX90RI4JixpsuEu/ypYOEPzWuzel7DGSegLHCICtmyMSS21yDNjjbIHgMYkhUgmfztSDTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472576; c=relaxed/simple;
	bh=W/lNsHQOpMwOw6qbBISXNboe+wqRqgWIvQw5KI4JO0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kNkaVITmbwgJnUChf55yGR+EWEfZSljdnFCPBbEBV2nj+DS0bIBeL2SYJxG/9ej1ZrRqo1UXnZbV270QGStbwA+1H4+MGQyPVq9b9o/k6eTkqiT/Bp3nG+dqflmcpAzgBdX5dsKeEgA+Q/4xC7vT33T4LKhN1E9vNse2Pe+Anfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=jShTTKP+; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1757472563; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=WqFTYK/ICNliwAdi5HA1h5xy4TAhp+T7+wGB7zW5Ln0=;
	b=jShTTKP+GoT7WrZhHxQXFtqdSPiDq/PvZiRXgCDIJ7bdGBBUaBu6ArkCtXsisUQwCMIqztqjcRhUfFqkQebsZ7zQf/+JbKxnbpZ8s8CYM3qewW/IPSH9lUlmtFrOs3iuA+a1giiFsyaJ4L15RbydyMcpA+sAE/UjYVx18IRFJHc=
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.ebbFypy_1757472562 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 10:49:22 +0800
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
Subject: [PATCH 0/7] KVM: x86: Improve the handling of debug exceptions during instruction emulation
Date: Wed, 10 Sep 2025 10:49:12 +0800
Message-Id: <cover.1757416809.git.houwenlong.hwl@antgroup.com>
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
emulation, but the overall logic is the same. If guest debugging
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
exceptions checking) or breaks the 'MOV SS' suppressed #DB. For the
latter, I have kept the behavior for now in my patchset, as I need some
suggestions.

Hou Wenlong (7):
  KVM: x86: Set guest DR6 by kvm_queue_exception_p() in instruction
    emulation
  KVM: x86: Check guest debug in DR access instruction emulation
  KVM: x86: Only check effective code breakpoint in emulation
  KVM: x86: Consolidate KVM_GUESTDBG_SINGLESTEP check into the
    kvm_inject_emulated_db()
  KVM: VMX: Set 'BS' bit in pending debug exceptions during instruction
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
 arch/x86/kvm/vmx/vmx.c                        |  14 ++-
 arch/x86/kvm/vmx/x86_ops.h                    |   1 +
 arch/x86/kvm/x86.c                            | 109 +++++++++++-------
 arch/x86/kvm/x86.h                            |   7 ++
 .../selftests/kvm/include/x86/processor.h     |   3 +-
 tools/testing/selftests/kvm/x86/debug_regs.c  |  64 +++++++++-
 11 files changed, 167 insertions(+), 63 deletions(-)


base-commit: ecbcc2461839e848970468b44db32282e5059925
--
2.31.1


