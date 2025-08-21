Return-Path: <linux-kselftest+bounces-39490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C8FB2FB97
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE6DB674DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B152EC570;
	Thu, 21 Aug 2025 13:56:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA4D2EC55D;
	Thu, 21 Aug 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784576; cv=none; b=Gp69b4lQA4T1djo4Pk9XAtGuFLENz3oW3br9pn6QS2rliN0KnlXugqg21eW16KW2SjmXwn82+KVMdfuHX6MGTSiC/opsS6JSfmgd55ednGIBpWJkT92JQ2fW1ws570hWR83MgJddpvOmDkrc+w/E4i3rHD7ISKJ6ve9DoL1LSzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784576; c=relaxed/simple;
	bh=3oc/IJQWBfYXXDjTK4ag+YVXoDkcvRedFhQypw2sN3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sq8+OPY4kr1WRr173DzmhSolzfCb2gaxlCVahdGVaWengbl9nIt0cy4s6g4LXEBbZXcM6LP+/XtaNx5xC9dI7/hE1WLQua193Plvcr/oGRQ0bgvNDudXoIUj5pvIWZBogH63imQKEmLqTTG3BcIfsX/Y9Pe/EGQ7pl7xb8peGLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from ROG.lan (unknown [118.251.176.166])
	by APP-03 (Coremail) with SMTP id rQCowAAngIFZJadoCYkTDg--.22571S2;
	Thu, 21 Aug 2025 21:55:39 +0800 (CST)
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
Cc: linux-riscv@list.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	pincheng.plct@isrc.iscas.ac.cn
Subject: [PATCH 0/5] RISC-V: Add Zilsd/Zclsd support in hwprobe and KVM
Date: Thu, 21 Aug 2025 21:55:22 +0800
Message-Id: <20250821135527.224044-1-pincheng.plct@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAngIFZJadoCYkTDg--.22571S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1kJF1xGr15GFy8Gw1xXwb_yoW8trW5pa
	n5Cw15KF1kXFy7C34fAr48ur1rKF4ru393Jrn3t348WFW3Cr95Jr9ak3ZxZF18ArZ29ry0
	93WrKw1I93Z7AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUU0JmUUUUUU==
X-CM-SenderInfo: pslquxhhqjh1xofwqxxvufhxpvfd2hldfou0/

Hi all,

This patch series adds support for the recently ratified Zilsd
(Load/Store pair instructions) and Zclsd (Compressed Load/Store pair
instructions) extensions to the RISC-V Linux kernel. It covers device tree
binding,ISA string parsing, hwprobe exposure, KVM guest handling and selftests.

Zilsd and Zclsd allow more efficient memory access sequences on RV32. My
goal is to enable glibc and other user-space libraries to detect these
extensions via hwprobe and make use of them for optimized
implementations of common routines. To achieve this, the Linux kernel
needs to recognize and expose the availability of these extensions
through the device tree bindings, ISA string parsing and hwprobe
interfaces. KVM support is also required to correctly virtualize these
features for guest environments.

The series is structured as follows:
- Patch 1: Add device tree bindings documentation for Zilsd and Zclsd
- Patch 2: Extend RISC-V ISA extension string parsing to recognize them.
- Patch 3: Export Zilsd and Zclsd via riscv_hwprobe
- Patch 4: Allow KVM guests to use them.
- Patch 5: Add KVM selftests.

This series of patches is a preparatory step toward enabling user-space
optimizations in glibc that leverage Zilsd and Zclsd, by providing the
necessary kernel-side support.

Please review, and let me know if any adjustments are needed.

Thanks,
Pincheng Wang


Pincheng Wang (5):
  dt-bidings: riscv: add Zilsd and Zclsd extension descriptions
  riscv: add ISA extension parsing for Zilsd and Zclsd
  riscv: hwprobe: export Zilsd and Zclsd ISA extensions
  riscv: KVM: allow Zilsd and Zclsd extensions for Guest/VM
  KVM: riscv: selftests: add Zilsd and Zclsd extension to get-reg-list
    test

 Documentation/arch/riscv/hwprobe.rst          |  8 ++++
 .../devicetree/bindings/riscv/extensions.yaml | 39 +++++++++++++++++++
 arch/riscv/include/asm/hwcap.h                |  2 +
 arch/riscv/include/uapi/asm/hwprobe.h         |  2 +
 arch/riscv/include/uapi/asm/kvm.h             |  2 +
 arch/riscv/kernel/cpufeature.c                | 24 ++++++++++++
 arch/riscv/kernel/sys_hwprobe.c               |  2 +
 arch/riscv/kvm/vcpu_onereg.c                  |  2 +
 .../selftests/kvm/riscv/get-reg-list.c        |  6 +++
 9 files changed, 87 insertions(+)

-- 
2.39.5


