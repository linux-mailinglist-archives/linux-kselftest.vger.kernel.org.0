Return-Path: <linux-kselftest+bounces-12194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FB190E186
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 04:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149952833EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ED214277;
	Wed, 19 Jun 2024 02:07:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D6BE541;
	Wed, 19 Jun 2024 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718762878; cv=none; b=uJQ9RjntckK/Iqm49+FNGmVlq9o7BslsPMa7pHS/fmKBNZ82MknMXioKCXuuR4XMMXhpIHdZF3DU8/Iz1KMZ+MFGEmayMtSZArYNMHZns+sxd0doo4STD8jQqevyenyV13w5CgfHpmO6MR5gDCjE0Z0PHms3tbTC3hZJEiiugLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718762878; c=relaxed/simple;
	bh=meFezo5W5aHSV7AeLtOxr2/C/HpnBtJlUo16/5qvthw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zuwu7d8uSIm6vZO/9wUQ+/b8q4byt8xLTOa8RvXwg2ORgKW8nqfOHPxriCybssIA+yDarIGK49ZpSEnADqR3PQ4XV8jJK2nbXVxjLH1tmjZGbnjV3/i1gHhCRqzgp8mOkVioCRwZv7lKt+J1xDFCR+AJPN2akdjrNazLz9xVSwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ThinkPad-T480s.. (unknown [121.237.44.152])
	by APP-05 (Coremail) with SMTP id zQCowACnr+fFO3Jmjn6bEQ--.46102S2;
	Wed, 19 Jun 2024 10:00:38 +0800 (CST)
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
Subject: [RFC PATCH 0/2] riscv: Expose orig_a0 to userspace for ptrace to set the actual a0
Date: Wed, 19 Jun 2024 10:00:37 +0800
Message-Id: <cover.1718693532.git.zhouquan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnr+fFO3Jmjn6bEQ--.46102S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF43Ar1fXryUtFW7Zw4rGrg_yoW8Cw4rpa
	95KwnYk3W8JFy2ya1xXw4UXr4rAa4fWrW3G3WxZry3ZrW8tryvqr4xKa1Yqr93CayxWryf
	ZF1Ikr15C3WUZa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwAKzVCY07xG64k0F24lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjRpBDUUUUU==
X-CM-SenderInfo: 52kr31xxdqqxpvfd2hldfou0/1tbiCRANBmZyBxOZHgAAsV

From: Quan Zhou <zhouquan@iscas.ac.cn>

Due to the path that modifies a0 in syscall_enter_from_user_mode before the
actual execution of syscall_handler [1], the kernel currently saves a0 to
orig_a0 at the entry point of do_trap_ecall_u as an original copy of a0.
Once the syscall is interrupted and later resumed, the restarted syscall
will use orig_a0 to continue execution.

The above rules generally apply except for ptrace(PTRACE_SETREGSET,),
where the kernel will ignore the tracer's setting of tracee/a0 and
will restart with the tracee's original a0 value. For the current
kernel implementation of ptrace, projects like CRIU/Proot will
encounter issues where the a0 setting becomes ineffective when
performing ptrace(PTRACE_{SET/GET}REGSET,).

Here is a suggested solution, expose orig_a0 to userspace so that ptrace
can choose whether to set orig_a0 based on the actual scenario. In fact,
x86/orig_eax and loongArch/orig_a0 have adopted similar solutions.

[1] link: https://lore.kernel.org/lkml/20230403-crisping-animosity-04ed8a45c625@spud/T/

Quan Zhou (2):
  riscv: Expose orig_a0 in the user_regs_struct structure
  riscv: selftests: Add a ptrace test to check a0 of restarted syscall

 arch/riscv/include/asm/ptrace.h               |   4 +-
 arch/riscv/include/uapi/asm/ptrace.h          |   2 +
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/abi/.gitignore  |   1 +
 tools/testing/selftests/riscv/abi/Makefile    |  12 ++
 .../riscv/abi/ptrace_restart_syscall.c        | 148 ++++++++++++++++++
 6 files changed, 166 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/abi/.gitignore
 create mode 100644 tools/testing/selftests/riscv/abi/Makefile
 create mode 100644 tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c


base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
-- 
2.34.1


