Return-Path: <linux-kselftest+bounces-3506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB70683B6E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 02:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECE31C22318
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 01:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC79817C2;
	Thu, 25 Jan 2024 01:54:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E6EECC;
	Thu, 25 Jan 2024 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706147667; cv=none; b=gyscpzOVSjzEQxWsLMmiD4LyS/SWDsaoj+PixLaMsD29VnOM/YOCsevXtfKhPT9I/aYEOKnb1wrRJv86DpK1FqrVBfmNp5Te7LSKS69c80gwRnhxzXueSHNflQB5NLcLgaxLkYLtT7+BvpUQsyIYCNJdKO640oH9jukSqSPw1lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706147667; c=relaxed/simple;
	bh=EYJs42oleCox/S63sw57aXE+eNGfKyc9KiXA8iCOBdI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RbKLyH1F0Jc6/Mnc6DdkMlHohPEI8ETZKR5iNBaA9h1XfsD8eY58+yFvqmgzqcJWtRJKLK9ApIL5NcytdIYhHHYb5LO7gJQdzP0rj4WlEvkt2bt22oX6UT7VZ+nLaPU1Rt+AkBNtGT1pyNKBb7WDyuHcSD9X9CljDUvUnCKsAgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxeehNv7Fllj0FAA--.682S3;
	Thu, 25 Jan 2024 09:54:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxVMxMv7FlojkYAA--.45641S2;
	Thu, 25 Jan 2024 09:54:20 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 0/4] VM: selftests: Add LoongArch support
Date: Thu, 25 Jan 2024 09:54:16 +0800
Message-Id: <20240125015420.1960090-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxVMxMv7FlojkYAA--.45641S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF4DZFyUtryrury7tF15Jrc_yoW5KrWUpa
	yI9Fn0gF48JFy2q3Z3J34kXFyfK3Z3GF4xCr1aqrWUuw1jyrW8JrWxKFWqyas5Z398Xa40
	v3WxtwnxW3WUtacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

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


base-commit: 7ed2632ec7d72e926b9e8bcc9ad1bb0cd37274bf
-- 
2.33.0


