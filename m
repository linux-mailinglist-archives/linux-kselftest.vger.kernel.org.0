Return-Path: <linux-kselftest+bounces-12835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D83919DAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 05:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D4C28521B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 03:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF8C1078B;
	Thu, 27 Jun 2024 03:02:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (unknown [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0EF8814;
	Thu, 27 Jun 2024 03:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457371; cv=none; b=fgF8zupecrlDaW7N+z3Q+hAvD0a/oEgLGAalza8U+GwwGNZX4FqvXCYm5N+Y77dXKt455TAqMNq1E37NqzdU6AWjj7TMlUUi+17iPxR9i5x0mnR5o/r1GdV9XTk9noTcEGhFwgKhl/fwF5T3h2WPs8bqnAmnr0i9i0kIFTtq3I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457371; c=relaxed/simple;
	bh=mzRu4FOP+Ip89fI4yXRMEnYoS1DyeLQ1AjfU2+P03B4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LYAlxAsGsQ0fhUvBoxJm8d0ad1ZKcPtyPlc8whyrm4USoLLawsdPmDnQMSNvJXcx4ZCNesLzIL/qCCoBGOvt7F+WrDr/qZYycGhEFvlUzBREcqVKk6mIcI6E2KEYdonYw7gZSphrVSnUlW4rmIj3/f/3kO2sp2pjWKr1i+6uPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ThinkPad-T480s.. (unknown [180.110.114.157])
	by APP-05 (Coremail) with SMTP id zQCowACXneU91nxmmgIiAA--.7124S2;
	Thu, 27 Jun 2024 11:02:23 +0800 (CST)
From: zhouquan@iscas.ac.cn
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: oleg@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	andy.chiu@sifive.com,
	shuah@kernel.org,
	charlie@rivosinc.com,
	zhouquan@iscas.ac.cn
Subject: [PATCH v1 0/2] riscv: Expose orig_a0 to userspace for ptrace to set the actual a0
Date: Thu, 27 Jun 2024 11:02:21 +0800
Message-Id: <cover.1719408040.git.zhouquan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXneU91nxmmgIiAA--.7124S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF43Ar1fXryUtFW7GFWDCFg_yoW8tFy3pa
	95Kwn8Kr1kJFy7t3WxXw4UZrWrAa4kGrW3G3WxZw13Z3y0yryvqr4xKa15t3sxA3y8XryS
	vF12k3W5C3W7Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUSiihUUUUU=
X-CM-SenderInfo: 52kr31xxdqqxpvfd2hldfou0/1tbiCQ4BBmZ8nayl6gAAsk

From: Quan Zhou <zhouquan@iscas.ac.cn>

Due to the path that modifies a0 in syscall_enter_from_user_mode before the
actual execution of syscall_handler [1], the kernel currently saves a0 to
orig_a0 at the entry point of do_trap_ecall_u as an original copy of a0.
Once the syscall is interrupted and later resumed, the restarted syscall
will use orig_a0 to continue execution.

The above rules generally apply except for ptrace(PTRACE_SETREGSET,),
where the kernel will ignore the tracer's setting of tracee/a0 and
will restart with the tracee/orig_a0. For the current kernel implementation
of ptrace, projects like CRIU/Proot will encounter issues where the a0
setting becomes ineffective when performing ptrace(PTRACE_SETREGSET,).

Here is a suggested solution, expose orig_a0 to userspace so that ptrace
can choose whether to set orig_a0 based on the actual scenario. In fact,
x86/orig_eax and loongArch/orig_a0 have adopted similar solutions.

[1] link:
https://lore.kernel.org/lkml/20230403-crisping-animosity-04ed8a45c625@spud/T/

---
Changes from RFC->v1:
- Rebased on Linux 6.10-rc5.
- Updated the patch description.
- Adjust MAX_REG_OFFSET to match the new bottom of pt_regs (Charlie).
- Simplify selftest to verify if a0 can be set (Charlie).
- Fix .gitignore error (Charlie).

---
RFC link:
https://lore.kernel.org/all/cover.1718693532.git.zhouquan@iscas.ac.cn/

Quan Zhou (2):
  riscv: Expose orig_a0 in the user_regs_struct structure
  riscv: selftests: Add a ptrace test to verify syscall parameter
    modification

 arch/riscv/include/asm/ptrace.h              |   7 +-
 arch/riscv/include/uapi/asm/ptrace.h         |   2 +
 tools/testing/selftests/riscv/Makefile       |   2 +-
 tools/testing/selftests/riscv/abi/.gitignore |   1 +
 tools/testing/selftests/riscv/abi/Makefile   |  12 ++
 tools/testing/selftests/riscv/abi/ptrace.c   | 124 +++++++++++++++++++
 6 files changed, 144 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/abi/.gitignore
 create mode 100644 tools/testing/selftests/riscv/abi/Makefile
 create mode 100644 tools/testing/selftests/riscv/abi/ptrace.c


base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
-- 
2.34.1


