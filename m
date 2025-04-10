Return-Path: <linux-kselftest+bounces-30464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F76A83784
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 05:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DB346816D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 03:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E51020125D;
	Thu, 10 Apr 2025 03:57:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8331E5734;
	Thu, 10 Apr 2025 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744257423; cv=none; b=iSEJ++fSnIJ5yRAxxs36Izc0OWqi4KXwqB6D9OMWDG70YxDdKJ7Bcy0jL8vdn22qC25TEXVL2QyaPyqbNZzG7nv+ZytWpR/paJrWhOncT6dc4bX9UOBEnji1DKJMn0W+iwkZYDHKVpzDVE3ux4R+7gahx72cUSJj5QbmOwVsHsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744257423; c=relaxed/simple;
	bh=UN8BqIMil1oUKVpIH7eLt4XQrcpRFywaOcaiwyRKiSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jwtd6bjxeChvXOPPOz7pQkEcguaXKQ3hGeDRZXzXX9fGbc8bU+it/SGsuvDJLBPAGy+zLVG0ishudkXcaxuIdmeDlrBiPYKFWeQlD+uftTL7rbyHB5DCTMRCoB63cspSwLwLN8sLFmon9RomUCZKQRI/qkuxdgtzOVjfzdP0ORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxCGqAQfdn0pK2AA--.41644S3;
	Thu, 10 Apr 2025 11:56:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMBxHcV_QfdnQWl3AA--.27477S2;
	Thu, 10 Apr 2025 11:56:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v8 0/4] KVM: selftests: Add LoongArch support
Date: Thu, 10 Apr 2025 11:56:43 +0800
Message-Id: <20250410035647.3501139-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxHcV_QfdnQWl3AA--.27477S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

This patchset adds KVM selftests for LoongArch system, currently only
some common test cases are supported and pass to run. These testcase
are listed as following:
    coalesced_io_test
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
Changes in v8:
1. Porting patch based on the latest version.
2. For macro PC_OFFSET_EXREGS, offsetof() method is used for C header file,
   still hardcoded definition for assemble language.

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
Bibo Mao (4):
  KVM: selftests: Add KVM selftests header files for LoongArch
  KVM: selftests: Add core KVM selftests support for LoongArch
  KVM: selftests: Add ucall test support for LoongArch
  KVM: selftests: Add test cases for LoongArch

 tools/testing/selftests/kvm/Makefile          |   2 +-
 tools/testing/selftests/kvm/Makefile.kvm      |  18 +
 .../testing/selftests/kvm/include/kvm_util.h  |   5 +
 .../kvm/include/loongarch/kvm_util_arch.h     |   7 +
 .../kvm/include/loongarch/processor.h         | 138 +++++++
 .../selftests/kvm/include/loongarch/ucall.h   |  20 +
 .../selftests/kvm/lib/loongarch/exception.S   |  59 +++
 .../selftests/kvm/lib/loongarch/processor.c   | 349 ++++++++++++++++++
 .../selftests/kvm/lib/loongarch/ucall.c       |  38 ++
 .../selftests/kvm/set_memory_region_test.c    |   2 +-
 10 files changed, 636 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/loongarch/kvm_util_arch.h
 create mode 100644 tools/testing/selftests/kvm/include/loongarch/processor.h
 create mode 100644 tools/testing/selftests/kvm/include/loongarch/ucall.h
 create mode 100644 tools/testing/selftests/kvm/lib/loongarch/exception.S
 create mode 100644 tools/testing/selftests/kvm/lib/loongarch/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/loongarch/ucall.c


base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.39.3


