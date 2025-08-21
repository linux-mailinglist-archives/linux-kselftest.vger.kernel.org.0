Return-Path: <linux-kselftest+bounces-39496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B48B2FBD5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2035E1D0091E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19BD221572;
	Thu, 21 Aug 2025 14:02:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDFE1F463B;
	Thu, 21 Aug 2025 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784920; cv=none; b=FjjOAsOFX2Zl2ARhp4uZp+FiHHMLMLS4QHzUrn2tYzzIa1qrqNSIZc6DqxhY9nDkmBxqUnCsKzyxrNQfLc4cyP9ahfZx0bXPipn2vq0sYF+iiE6Q1g+Z6DCZkxQ60PlC+sHvJkMLiOJvg5ovpwqvLh3asqTgnKJOE+yog0S5PvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784920; c=relaxed/simple;
	bh=HQf8iG9brolgU0iVx1X71lVWDLRN87n0FG7+6GJp7hM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FCfPKpQQ/L4MgUyWKCkpdlf8T39XOWsDtR9Pct4sJ/ZQfn9VDmV7Ckq0e9OfFZvLTVIVD11R2gDkeJIuPDuaKY5evh27xjJvCefrCeAe/mnMABubFy7LHPKPklz26KDgp0dBEw9eAhIwyIKYGrrxJWFr2d1+PAfToAEf2aQYfeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from ROG.lan (unknown [118.251.176.166])
	by APP-03 (Coremail) with SMTP id rQCowABn+Xq+JqdoP8MTDg--.22469S2;
	Thu, 21 Aug 2025 22:01:36 +0800 (CST)
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
Subject: [PATCH v1 RESEND 0/5] RISC-V: Add Zilsd/Zclsd support in hwprobe and KVM
Date: Thu, 21 Aug 2025 22:01:26 +0800
Message-Id: <20250821140131.225756-1-pincheng.plct@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABn+Xq+JqdoP8MTDg--.22469S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArykGr1fCw45Aw13Xw4xJFb_yoW8KrWUpa
	n5Gw1YgF1kXry7C34fAr48ur1rKF4ru393Jrnxt348WFW3Cr95Jr93K3ZxZF18AFWI9ry0
	93WFgw1I93Z7ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJV
	WxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUU2jg7UUUUU==
X-CM-SenderInfo: pslquxhhqjh1xofwqxxvufhxpvfd2hldfou0/

Hi all,

This is a RESEND of v1 to correct a mistake in the CC list.
There are **no changes in code** compared to the previous v1.

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
  riscv: add ISA extension parsing for Zilsd and Zclsd:
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


