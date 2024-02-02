Return-Path: <linux-kselftest+bounces-3986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D5C8466D1
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 05:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2F628C94B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 04:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3565F51C;
	Fri,  2 Feb 2024 04:10:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDC6F4EF;
	Fri,  2 Feb 2024 04:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706847057; cv=none; b=asnn7PuC+MasYGJ7v+aoho+mjV7X9iwMaWgvhyByc/YTCctFttMaPFJkg5eJjIeoM2uRpfemCsEDT2/WjxgUeFUlNZaqeNpmvFU1zzxqdUxipR7IJ1fdVcHZ45AH3BrXVMM+zOG4PbeDeB379R1xGpmskJAEKsLp9MN3+8dmBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706847057; c=relaxed/simple;
	bh=rYynzo8dPedwgpU40IZHWK9ZM8miUJLDQc2MlL0o2dY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QYHLJ2RY0x3g1HNEaFQXqPl1d6h8jm2QS3YATkFWkDPKuV9Ocz6dKsqJ5Idq2v2HXxpe/zcmG1jdtINy0xJcmZdL/iWIFjQUfOjsdmy0pSWvbvpguesHIyQqyjmz13r7VfDOyRKjkOPFBZ/1xJ46xaaGApMyo3XNWXKyoFR3M14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxifBHa7xlZf4JAA--.28946S3;
	Fri, 02 Feb 2024 12:10:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvhNGa7xlhd0sAA--.51008S2;
	Fri, 02 Feb 2024 12:10:46 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v7 0/4] KVM: selftests: Add LoongArch support
Date: Fri,  2 Feb 2024 12:10:42 +0800
Message-Id: <20240202041046.3405779-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxvhNGa7xlhd0sAA--.51008S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF4DZFyxtw48tFWUXw4rCrX_yoWrJr1Dpa
	yI9Fn0gF48JFy2q3Z7J34kXFyfK3Z3GFWxCr1aqrWUuw1jyrW8JrWxKFZ0yas5Z398Xa4F
	v3WxtwnxWa4UtacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9UUUUU=

This patchset adds KVM selftests for LoongArch system, currently only
some common test cases are supported and pass to run. These testcase
are listed as following:
        demand_paging_test
        dirty_log_perf_test
        dirty_log_test
        guest_print_test
        hardware_disable_test
        kvm_binary_stats_test
        kvm_create_max_vcpus
        kvm_page_table_test
        memslot_modification_stress_test
        memslot_perf_test
        set_memory_region_test

This patchset originally is posted from zhaotianrui, I continue to work
on his efforts.

---
Changes in v7:
1. Refine code to add LoongArch support in test case 
set_memory_region_test.

Changes in v6:
1. Refresh the patch based on latest kernel 6.8-rc1, add LoongArch
support about testcase set_memory_region_test.
2. Add hardware_disable_test test case.
3. Drop modification about macro DEFAULT_GUEST_TEST_MEM, it is problem
of LoongArch binutils, this issue is raised to LoongArch binutils owners.

Changes in v5:
1. In LoongArch kvm self tests, the DEFAULT_GUEST_TEST_MEM could be
0x130000000, it is different from the default value in memstress.h.
So we Move the definition of DEFAULT_GUEST_TEST_MEM into LoongArch
ucall.h, and add 'ifndef' condition for DEFAULT_GUEST_TEST_MEM
in memstress.h.

Changes in v4:
1. Remove the based-on flag, as the LoongArch KVM patch series
have been accepted by Linux kernel, so this can be applied directly
in kernel.

Changes in v3:
1. Improve implementation of LoongArch VM page walk.
2. Add exception handler for LoongArch.
3. Add dirty_log_test, dirty_log_perf_test, guest_print_test
test cases for LoongArch.
4. Add __ASSEMBLER__ macro to distinguish asm file and c file.
5. Move ucall_arch_do_ucall to the header file and make it as
static inline to avoid function calls.
6. Change the DEFAULT_GUEST_TEST_MEM base addr for LoongArch.

Changes in v2:
1. We should use ".balign 4096" to align the assemble code with 4K in
exception.S instead of "align 12".
2. LoongArch only supports 3 or 4 levels page tables, so we remove the
hanlders for 2-levels page table.
3. Remove the DEFAULT_LOONGARCH_GUEST_STACK_VADDR_MIN and use the common
DEFAULT_GUEST_STACK_VADDR_MIN to allocate stack memory in guest.
4. Reorganize the test cases supported by LoongArch.
5. Fix some code comments.
6. Add kvm_binary_stats_test test case into LoongArch KVM selftests.

---
Tianrui Zhao (4):
  KVM: selftests: Add KVM selftests header files for LoongArch
  KVM: selftests: Add core KVM selftests support for LoongArch
  KVM: selftests: Add ucall test support for LoongArch
  KVM: selftests: Add test cases for LoongArch

 tools/testing/selftests/kvm/Makefile          |  16 +
 .../selftests/kvm/include/kvm_util_base.h     |   5 +
 .../kvm/include/loongarch/processor.h         | 133 +++++++
 .../selftests/kvm/include/loongarch/ucall.h   |  20 ++
 .../selftests/kvm/lib/loongarch/exception.S   |  59 ++++
 .../selftests/kvm/lib/loongarch/processor.c   | 332 ++++++++++++++++++
 .../selftests/kvm/lib/loongarch/ucall.c       |  38 ++
 .../selftests/kvm/set_memory_region_test.c    |   2 +-
 8 files changed, 604 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/include/loongarch/processor.h
 create mode 100644 tools/testing/selftests/kvm/include/loongarch/ucall.h
 create mode 100644 tools/testing/selftests/kvm/lib/loongarch/exception.S
 create mode 100644 tools/testing/selftests/kvm/lib/loongarch/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/loongarch/ucall.c


base-commit: 6764c317b6bb91bd806ef79adf6d9c0e428b191e
-- 
2.39.3


