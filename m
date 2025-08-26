Return-Path: <linux-kselftest+bounces-39964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F29FB3704A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 18:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8657C1673
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 16:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8358923506F;
	Tue, 26 Aug 2025 16:30:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB49B2B9A7;
	Tue, 26 Aug 2025 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225836; cv=none; b=M3L7Obo1s6+OrSxldYxleDXI0VJX9Oe1oA7N8iZixLP3dn+kYrfgKq+vabJMItjYEAuXKBIk/w0lT4JjUgTkzaRfaWIpQGhiH+KTlAtGV90lLO1OYiOnceVQmoQyz19dGBCquKk8eNqlw8IKnfpulPFmEFqo6IjLrzu0R5FS6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225836; c=relaxed/simple;
	bh=yMwNl4e0l3TtPcySpAL6rbOFnmB2yIOLSJ7vpcZI0ws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aOTLb0W4XnqeGlDddDdO4JnLsspso6vH4CAZlsvsCbZ5Zd1ztCFwPnt/RlKcie4hLxYoiBtEI1w287ocIlDrjEe2FS4EPCkdgRRkg6oguMOZTEChKf4PZMa1ZGOAkFHIqM6hSiBbLrz/Tz+CVoVGulZnnF63ZEkyii2yE4GDt+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from ROG.lan (unknown [118.251.176.199])
	by APP-03 (Coremail) with SMTP id rQCowAD3jX8L4a1oBKJmDw--.6398S2;
	Wed, 27 Aug 2025 00:30:05 +0800 (CST)
From: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	anup@brainfault.org,
	pbonzini@redhat.com,
	shuah@kernel.org,
	cyan.yang@sifive.com,
	cleger@rivosinc.com,
	charlie@rivosinc.com,
	cuiyunhui@bytedance.com,
	samuel.holland@sifive.com,
	namcao@linutronix.de,
	jesse@rivosinc.com,
	inochiama@gmail.com,
	yongxuan.wang@sifive.com,
	ajones@ventanamicro.com,
	parri.andrea@gmail.com,
	mikisabate@gmail.com,
	yikming2222@gmail.com,
	thomas.weissschuh@linutronix.de
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	pincheng.plct@isrc.iscas.ac.cn
Subject: [PATCH v2 0/5] Add Zilsd/Zclsd support in hwprobe and KVM
Date: Wed, 27 Aug 2025 00:29:34 +0800
Message-Id: <20250826162939.1494021-1-pincheng.plct@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3jX8L4a1oBKJmDw--.6398S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyftr1UXr48Cr1DJrW5Jrb_yoW8KrW5pF
	s5GwnI9r1kJw13CF1fAr48ur1rKan5uws3tF9xtw18WayayFyrZr10k3ZxZF1kAFZ29FyD
	Z3WrWryI9wnrAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRM6wCDUUUU
X-CM-SenderInfo: pslquxhhqjh1xofwqxxvufhxpvfd2hldfou0/

Hi all,

This is v2 of a short series that adds kernel support for the ratified
Zilsd (Load/Store pair) and Zclsd (Compressed Load/Store pair) RISC-V
ISA extensions. The series enables kernel-side exposure so user-space
(for example glibc) can detect and use these extensions via hwprobe and
runtime checks.

Patches:
- Patch 1：Add device tree bindings documentation for Zilsd and Zclsd.
- Patch 2: Extend RISC-V ISA extension string parsing to recognize them.
- Patch 3: Export Zilsd and Zclsd via riscv_hwprobe.
- Patch 4: Allow KVM guests to use them.
- Patch 5: Add KVM selftests.

Changes in v2:
- Device-tree schema: simplified the rv64 validation for Zilsd by
  removing a redundant `contais: const: zilsd` in the `if` clause; the
  simpler `if (riscv, isa-base contains rv64i) then (riscv,
  isa-extension not contains zilsd)` form is used instead. Behaviour is
  unchanged, and the logic is cleaner.
- Device-tree schema: corrected Zclsd dependency to require both Zilsd
  and Zca (previous `anyOf` was incorrect; now both are enforced).
- Commit message typo fixed: "dt-bidings" -> "dt-bindings" in the Patch
  1 commit subject.

The v2 changes are documentation/schema corrections in extensions.yaml.
No functional changes were made to ISA parsing, hwprobe syscall, KVM
guest support or the selftests beyond ensuring the binding correctly
documents and validates the extension relationships.

Please review v2 and advise if futher changes are needed.

Thanks,
Pincheng Wang 

Pincheng Wang (5):
  dt-bindings: riscv: add Zilsd and Zclsd extension descriptions
  riscv: add ISA extension parsing for Zilsd and Zclsd
  riscv: hwprobe: export Zilsd and Zclsd ISA extensions
  riscv: KVM: allow Zilsd and Zclsd extensions for Guest/VM
  KVM: riscv: selftests: add Zilsd and Zclsd extension to get-reg-list
    test

 Documentation/arch/riscv/hwprobe.rst          |  8 +++++
 .../devicetree/bindings/riscv/extensions.yaml | 36 +++++++++++++++++++
 arch/riscv/include/asm/hwcap.h                |  2 ++
 arch/riscv/include/uapi/asm/hwprobe.h         |  2 ++
 arch/riscv/include/uapi/asm/kvm.h             |  2 ++
 arch/riscv/kernel/cpufeature.c                | 24 +++++++++++++
 arch/riscv/kernel/sys_hwprobe.c               |  2 ++
 arch/riscv/kvm/vcpu_onereg.c                  |  2 ++
 .../selftests/kvm/riscv/get-reg-list.c        |  6 ++++
 9 files changed, 84 insertions(+)

-- 
2.39.5


