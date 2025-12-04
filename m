Return-Path: <linux-kselftest+bounces-46979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 19585CA2C7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 09:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E312030087AB
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 08:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175C6331212;
	Thu,  4 Dec 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="W2EpN1Pu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D42327202;
	Thu,  4 Dec 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836513; cv=none; b=NXwlgF1FgsUIyj9KwpRZ+xPK6jlbIkHlSJ6ZO9tR8Hwuj5aD42rBIVlAtQZtioT3PasBAPnAU+OD5aHaKzaFa4BaKamWegNuixEnxHnM7Ub5f6KL+gnzsWL7lIi/CaxrCiyqYSqJG39uHIF/s8Enc+89fYyI2iemROjPzk/pWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836513; c=relaxed/simple;
	bh=krH+UBJxHZJk3VXfTXpmjGjndk0thrLqyo+oW7N93qo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gft20mTMhdU5lKukpgTTJobiYgKFfhTPKVFVw2hQ6+bQr3J0SU90XYow+DMuyZIfbatokLGPmqNI+EwS5feQf7JQzbLGbE1E/xQBthE7sRr9HWcKU8AtVmUH6nw0WaQnUmL8rFH/9M7f1TC1pF95gYGoNRG9Pv/yRd11uJiGa8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=W2EpN1Pu; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HeOxLrjw/czjXLl4+ESl1GzdVLjikIv/6OJaVbcjhXk=;
	b=W2EpN1PuHXwsYbiLnlfExTMgMPtDiapgby4OBl8HpxrJaDrEuSqb0ndOIHjLjGBg/IZ3Oxv6n
	8aLyYUFBuU2g/t7RfxPlzd3n0jXyZJxrydqg3rJBTldsMv+iFgnbxc9EbTxTMOIAEfv13pkRj8i
	DUnfqj/z7r3fVY//CZAsWzo=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dMS9J61Cbz1cyPG;
	Thu,  4 Dec 2025 16:19:48 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id EACB51400D4;
	Thu,  4 Dec 2025 16:21:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Dec
 2025 16:21:40 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<shuah@kernel.org>, <kees@kernel.org>, <wad@chromium.org>, <deller@gmx.de>,
	<macro@orcam.me.uk>, <charlie@rivosinc.com>, <kevin.brodsky@arm.com>,
	<ldv@strace.io>, <mark.rutland@arm.com>, <song@kernel.org>,
	<ryan.roberts@arm.com>, <ada.coupriediaz@arm.com>,
	<anshuman.khandual@arm.com>, <broonie@kernel.org>, <pengcan@kylinos.cn>,
	<dvyukov@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v9 00/16] arm64: entry: Convert to Generic Entry
Date: Thu, 4 Dec 2025 16:21:07 +0800
Message-ID: <20251204082123.2792067-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Currently, x86, Riscv, Loongarch use the Generic Entry which makes
maintainers' work easier and codes more elegant. arm64 has already
successfully switched to the Generic IRQ Entry in commit
b3cf07851b6c ("arm64: entry: Switch to generic IRQ entry"), it is
time to completely convert arm64 to Generic Entry.

The goal is to bring arm64 in line with other architectures that already
use the generic entry infrastructure, reducing duplicated code and
making it easier to share future changes in entry/exit paths, such as
"Syscall User Dispatch".

This patch set is rebased on v6.18-rc7. And the performance was measured
on Kunpeng 920 using "perf bench basic syscall" with "arm64.nopauth
selinux=0 audit=1".

After switch to Generic Entry, the performance are below:

| Metric     | W/O Generic Framework | With Generic Framework | Change |
| ---------- | --------------------- | ---------------------- | ------ |
| Total time | 2.130 [sec]           | 2.235 [sec]            | ↑4.90% |
| usecs/op   | 0.213095              | 0.223512               | ↑4.89% |
| ops/sec    | 4,692,753             | 4,474,044              | ↓4.89% |

Compared to earlier with arch specific handling, the performance decreased
by approximately 4.9%.

On the basis of optimizing syscall_get_arguments()[1], el0_svc_common()
and syscall_exit_work(), the performance are below:

| Metric     | W/O Generic Entry | With Generic Entry opt| Change |
| ---------- | ----------------- | ------------------    | ------ |
| Total time | 2.130 [sec]       | 2.134 [sec]           | ↑0.18% |
| usecs/op   | 0.213095          | 0.213414              | ↑0.15% |
| ops/sec    | 4,692,753         | 4,685,737             | ↓0.15% |

Therefore, after the optimization, ARM64 System Call performance remains
almost unchanged.

It was tested ok with following test cases on kunpeng920 and QEMU
virt platform:
 - Perf tests.
 - Different `dynamic preempt` mode switch.
 - Pseudo NMI tests.
 - Stress-ng CPU stress test.
 - Hackbench stress test.
 - MTE test case in Documentation/arch/arm64/memory-tagging-extension.rst
   and all test cases in tools/testing/selftests/arm64/mte/*.
 - "sud" selftest testcase.
 - get_set_sud, get_syscall_info, set_syscall_info, peeksiginfo
   in tools/testing/selftests/ptrace.
 - breakpoint_test_arm64 in selftests/breakpoints.
 - syscall-abi and ptrace in tools/testing/selftests/arm64/abi
 - fp-ptrace, sve-ptrace, za-ptrace in selftests/arm64/fp.
 - vdso_test_getrandom in tools/testing/selftests/vDSO
 - Strace tests.

The test QEMU configuration is as follows:

	qemu-system-aarch64 \
		-M virt,gic-version=3,virtualization=on,mte=on \
		-cpu max,pauth-impdef=on \
		-kernel Image \
		-smp 8,sockets=1,cores=4,threads=2 \
		-m 512m \
		-nographic \
		-no-reboot \
		-device virtio-rng-pci \
		-append "root=/dev/vda rw console=ttyAMA0 kgdboc=ttyAMA0,115200 \
			earlycon preempt=voluntary irqchip.gicv3_pseudo_nmi=1" \
		-drive if=none,file=images/rootfs.ext4,format=raw,id=hd0 \
		-device virtio-blk-device,drive=hd0 \

[1]: https://lore.kernel.org/all/20251201120633.1193122-3-ruanjinjie@huawei.com/

Changes in v9:
- Move "Return early for ptrace_report_syscall_entry() error" patch ahead
  to make it not introduce a regression.
- Not check _TIF_SECCOMP/SYSCALL_EMU for syscall_exit_work() in
  a separate patch.
- Do not report_syscall_exit() for PTRACE_SYSEMU_SINGLESTEP in a separate
  patch.
- Add two performance patch to improve the arm64 performance.
- Add Reviewed-by.
- Link to v8: https://lore.kernel.org/all/20251126071446.3234218-1-ruanjinjie@huawei.com/

Changes in v8:
- Rename "report_syscall_enter()" to "report_syscall_entry()".
- Add ptrace_save_reg() to avoid duplication.
- Remove unused _TIF_WORK_MASK in a standalone patch.
- Align syscall_trace_enter() return value with the generic version.
- Use "scno" instead of regs->syscallno in el0_svc_common().
- Move rseq_syscall() ahead in a standalone patch to clarify it clearly.
- Rename "syscall_trace_exit()" to "syscall_exit_work()".
- Keep the goto in el0_svc_common().
- No argument was passed to __secure_computing() and check -1 not -1L.
- Remove "Add has_syscall_work() helper" patch.
- Move "Add syscall_exit_to_user_mode_prepare() helper" patch later.
- Add miss header for asm/entry-common.h.
- Update the implementation of arch_syscall_is_vdso_sigreturn().
- Add "ARCH_SYSCALL_WORK_EXIT" to be defined as "SECCOMP | SYSCALL_EMU"
  to keep the behaviour unchanged.
- Add more testcases test.
- Add Reviewed-by.
- Update the commit message.
- Link to v7: https://lore.kernel.org/all/20251117133048.53182-1-ruanjinjie@huawei.com/

Chanegs in v7:
- Support "Syscall User Dispatch" by implementing
  arch_syscall_is_vdso_sigreturn() as kemal suggested.
- Add aarch64 support for "sud" selftest testcase, which tested ok with
  the patch series.
- Fix the kernel test robot warning for arch_ptrace_report_syscall_entry()
  and arch_ptrace_report_syscall_exit() in asm/entry-common.h.
- Add perf syscall performance test.
- Link to v6: https://lore.kernel.org/all/20250916082611.2972008-1-ruanjinjie@huawei.com/

Changes in v6:
- Rebased on v6.17-rc5-next as arm64 generic irq entry has merged.
- Update the commit message.
- Link to v5: https://lore.kernel.org/all/20241206101744.4161990-1-ruanjinjie@huawei.com/

Changes in v5:
- Not change arm32 and keep inerrupts_enabled() macro for gicv3 driver.
- Move irqentry_state definition into arch/arm64/kernel/entry-common.c.
- Avoid removing the __enter_from_*() and __exit_to_*() wrappers.
- Update "irqentry_state_t ret/irq_state" to "state"
  to keep it consistently.
- Use generic irq entry header for PREEMPT_DYNAMIC after split
  the generic entry.
- Also refactor the ARM64 syscall code.
- Introduce arch_ptrace_report_syscall_entry/exit(), instead of
  arch_pre/post_report_syscall_entry/exit() to simplify code.
- Make the syscall patches clear separation.
- Update the commit message.
- Link to v4: https://lore.kernel.org/all/20241025100700.3714552-1-ruanjinjie@huawei.com/

Changes in v4:
- Rework/cleanup split into a few patches as Mark suggested.
- Replace interrupts_enabled() macro with regs_irqs_disabled(), instead
  of left it here.
- Remove rcu and lockdep state in pt_regs by using temporary
  irqentry_state_t as Mark suggested.
- Remove some unnecessary intermediate functions to make it clear.
- Rework preempt irq and PREEMPT_DYNAMIC code
  to make the switch more clear.
- arch_prepare_*_entry/exit() -> arch_pre_*_entry/exit().
- Expand the arch functions comment.
- Make arch functions closer to its caller.
- Declare saved_reg in for block.
- Remove arch_exit_to_kernel_mode_prepare(), arch_enter_from_kernel_mode().
- Adjust "Add few arch functions to use generic entry" patch to be
  the penultimate.
- Update the commit message.
- Add suggested-by.
- Link to v3: https://lore.kernel.org/all/20240629085601.470241-1-ruanjinjie@huawei.com/

Changes in v3:
- Test the MTE test cases.
- Handle forget_syscall() in arch_post_report_syscall_entry()
- Make the arch funcs not use __weak as Thomas suggested, so move
  the arch funcs to entry-common.h, and make arch_forget_syscall() folded
  in arch_post_report_syscall_entry() as suggested.
- Move report_single_step() to thread_info.h for arm64
- Change __always_inline() to inline, add inline for the other arch funcs.
- Remove unused signal.h for entry-common.h.
- Add Suggested-by.
- Update the commit message.

Changes in v2:
- Add tested-by.
- Fix a bug that not call arch_post_report_syscall_entry() in
  syscall_trace_enter() if ptrace_report_syscall_entry() return not zero.
- Refactor report_syscall().
- Add comment for arch_prepare_report_syscall_exit().
- Adjust entry-common.h header file inclusion to alphabetical order.
- Update the commit message.

Jinjie Ruan (15):
  arm64: Remove unused _TIF_WORK_MASK
  arm64/ptrace: Split report_syscall()
  arm64/ptrace: Return early for ptrace_report_syscall_entry() error
  arm64/ptrace: Refactor syscall_trace_enter/exit()
  arm64: ptrace: Move rseq_syscall() before audit_syscall_exit()
  arm64: syscall: Rework el0_svc_common()
  arm64/ptrace: Not check _TIF_SECCOMP/SYSCALL_EMU for
    syscall_exit_work()
  arm64/ptrace: Do not report_syscall_exit() for
    PTRACE_SYSEMU_SINGLESTEP
  arm64/ptrace: Expand secure_computing() in place
  arm64/ptrace: Use syscall_get_arguments() helper
  entry: Split syscall_exit_to_user_mode_work() for arch reuse
  entry: Add arch_ptrace_report_syscall_entry/exit()
  arm64: entry: Convert to generic entry
  arm64: Inline el0_svc_common()
  entry: Inline syscall_exit_work()

kemal (1):
  selftests: sud_test: Support aarch64

 arch/arm64/Kconfig                            |  2 +-
 arch/arm64/include/asm/entry-common.h         | 76 ++++++++++++++
 arch/arm64/include/asm/syscall.h              | 19 +++-
 arch/arm64/include/asm/thread_info.h          | 22 +----
 arch/arm64/kernel/debug-monitors.c            |  7 ++
 arch/arm64/kernel/ptrace.c                    | 94 ------------------
 arch/arm64/kernel/signal.c                    |  2 +-
 arch/arm64/kernel/syscall.c                   | 29 ++----
 include/linux/entry-common.h                  | 98 ++++++++++++++++---
 kernel/entry/syscall-common.c                 | 60 +++++-------
 .../syscall_user_dispatch/sud_test.c          |  4 +
 11 files changed, 220 insertions(+), 193 deletions(-)

-- 
2.34.1


