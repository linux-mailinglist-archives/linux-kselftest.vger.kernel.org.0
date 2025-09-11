Return-Path: <linux-kselftest+bounces-41252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D116B5345F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 15:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F341B21C10
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099B6338F2A;
	Thu, 11 Sep 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUMeFhcj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003A7337683
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598595; cv=none; b=lP0L5Fp9hhKs2Dkkcoi12eiQRQ4Ebz04EQZWL1JY6e11+6X2yrNzRVU6RF1UPSE1wC4GqhHUKmb0VLqXTEHXCxqkmiv7RimsZDUo8albk0rVu23Ki2xQGr9RfICivIV68fBdo/xXw9SEBQCwe5QTs8Z7yNhjbNv5BGv2EVvw75Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598595; c=relaxed/simple;
	bh=lTDjButRkJ3Cx5uU/JAtEV++5t/e00mS8oYnDCNnkjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M/FQfzDjO8Plw3CSMQfmaWY0T/2qYUmNFZz9MsASGlheAi6aoemx7u2PmWwOFRC35L3sWA1ZRlapY4bNoaeL62hpgSPn4reMXswemXJT3zQpPSJZkoFZQjuy+QTSlgHpHK7ib4K0oopivx+F1DwZryr1wRfwuy9C7jsOxzIqnwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUMeFhcj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dfb8e986aso8712415e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598592; x=1758203392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCSrMFeSurFqrsJ2giFUs5nVIkyf5eYx9hKkmNRZA3A=;
        b=HUMeFhcjYYsZJejKwpxOD0SKQe1xS7h6nV8mkDunU4ZJvCnxyFiJqQoqYTIwtiHfCy
         RrMWKw2AmhS/UpDOcQwQ8mS5FpTR4SxVPGmi9d9f1EUZ/08UhgVOycJA+52Gc1k1boLk
         mK0oWUOZUVOhAOuui2zIqTifLxSJiujM34Jxq1mesEAOhXne+IUkn2yLPDlQ/b3XOXUR
         g0SfASRwi/3SDSbZbbEIk/aUKI9oPdOl09FIkYCB2hG5zHyT+AFkmsuIrft43m/EsQta
         JsrK+JzuAOhkXnCKYUhCpOxhsz/wp2PrBJ5JQpZhUzk1tcUVaQjRRKHwWmsC/s6veS8b
         Cb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598592; x=1758203392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCSrMFeSurFqrsJ2giFUs5nVIkyf5eYx9hKkmNRZA3A=;
        b=Jc6fVA6nFVpiF4dLVoJAlWUXYfk0QGssFZqSMOUZRN33lhmWUF/j/La/MSizhddAAY
         iNTol2AW7Qj7PNW67t1xYtCBEKOpoFa8tp/xGmshpEhkGCJ0iW4ZRdAC0LsO2LwMw/Tm
         w02HsA772Tz3+GnkbiNSjXSB+zbUoSY7IrsTW96XiiIbSUrIjiUGzBzODkhu3ht1sD+n
         dY/JTnzQPns2M7r1z5odO3tdjlI7I3V0nnu1M5jOqeK4qxfqjTwTDTXYJagxMje7Ay4H
         rlFDkF5TA2dPdrPlIX7WMdPGJCcZopWWz3sInKrM7VTtNzyZ8VQ5mqolIkR6WW8zMuLF
         FbIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCaL6iR36zmz5J8UNFY2Z63Cu8d9D1YcLm3eP/CxP1hi7HuBaEBq1qCA24PHKbD2wLDUdND01sJ6NYvAtWSWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxF9HWEGRwEkX1pTKC/WuH76N/u836qpvPebgdYAm1pKKy7VNx
	Upl9qYPKLi5zcqdaAtkq4QHI7LhnqB6pT7TJbo8XEYl8zrSvBYdUSj1J
X-Gm-Gg: ASbGnct9POTB52UnHxU3XsmW1qAYSvrtHzx0WdM5g5BKUKlq41EhMPofNobSSGop5N4
	fFYDzPVqIzKb8mkkBC1Eu6oAgY5/itdEhF8wDGQxfXGEs/tOX8LqQ4zwLBUkm2o1yhrq/U9hTGU
	+BUavAeBO4VcTqUwYtxaQFIECPdRAbdliVjJRY645M2m3QIs/ao90s/Sy2ukQQAfmdHd4LUj7ue
	zm400egc+8NKZ7TkVUrrrhHUxb3Xu3euPfddZkAD6PuRWnoei6bEFxPx2LgZMkpen0rZ+UTgXkc
	NeCVeNHeDcnDWG3QE5beacxNdQ+rZg02nfCbSNHzwZmb3q+UVFtapgrFLXEplYyz8PbvLInXPFV
	6bUeAUPeR+Wp+BGfw3FWpuzUFls9mqjPRyqoKOT6/yzqSDrw4V2Num3l4J9c8hQkOzFNTPlgd
X-Google-Smtp-Source: AGHT+IH842Sw/0yXJovz2FflrQNKNRtbIPTzYOgGi48h59M9xzXKWI2UOrLl/gvL8P7iUFl+9U+RTQ==
X-Received: by 2002:a05:600c:a43:b0:45b:81ad:336 with SMTP id 5b1f17b1804b1-45dddea520dmr244204245e9.16.1757598592074;
        Thu, 11 Sep 2025 06:49:52 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.2.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760778915sm2608361f8f.12.2025.09.11.06.49.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Sep 2025 06:49:51 -0700 (PDT)
From: Jack Thomson <jackabt.amazon@gmail.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	pbonzini@redhat.com
Cc: joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com,
	roypat@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.com
Subject: [PATCH 5/6] KVM: selftests: Enable pre_fault_memory_test for arm64
Date: Thu, 11 Sep 2025 14:46:47 +0100
Message-Id: <20250911134648.58945-6-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250911134648.58945-1-jackabt.amazon@gmail.com>
References: <20250911134648.58945-1-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

Enable the pre_fault_memory_test to run on arm64 by making it work with
different guest page sizes and testing multiple guest configurations.

Update the test_assert to compare against the UCALL_EXIT_REASON, for
portability, as arm64 exits with KVM_EXIT_MMIO while x86 uses
KVM_EXIT_IO.

Signed-off-by: Jack Thomson <jackabt@amazon.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/pre_fault_memory_test.c     | 79 ++++++++++++++-----
 2 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 90f03f00cb04..4db1737fad04 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -180,6 +180,7 @@ TEST_GEN_PROGS_arm64 += memslot_perf_test
 TEST_GEN_PROGS_arm64 += mmu_stress_test
 TEST_GEN_PROGS_arm64 += rseq_test
 TEST_GEN_PROGS_arm64 += steal_time
+TEST_GEN_PROGS_arm64 += pre_fault_memory_test
 
 TEST_GEN_PROGS_s390 = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_s390 += s390/memop
diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
index 0350a8896a2f..ed9848a8af60 100644
--- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
@@ -10,19 +10,29 @@
 #include <test_util.h>
 #include <kvm_util.h>
 #include <processor.h>
+#include <guest_modes.h>
 
 /* Arbitrarily chosen values */
-#define TEST_SIZE		(SZ_2M + PAGE_SIZE)
-#define TEST_NPAGES		(TEST_SIZE / PAGE_SIZE)
+#define TEST_BASE_SIZE		SZ_2M
 #define TEST_SLOT		10
 
+/* Storage of test info to share with guest code */
+struct test_config {
+	int page_size;
+	uint64_t test_size;
+	uint64_t test_num_pages;
+};
+
+struct test_config test_config;
+
 static void guest_code(uint64_t base_gpa)
 {
 	volatile uint64_t val __used;
+	struct test_config *config = &test_config;
 	int i;
 
-	for (i = 0; i < TEST_NPAGES; i++) {
-		uint64_t *src = (uint64_t *)(base_gpa + i * PAGE_SIZE);
+	for (i = 0; i < config->test_num_pages; i++) {
+		uint64_t *src = (uint64_t *)(base_gpa + i * config->page_size);
 
 		val = *src;
 	}
@@ -63,11 +73,17 @@ static void pre_fault_memory(struct kvm_vcpu *vcpu, u64 gpa, u64 size,
 					    "KVM_PRE_FAULT_MEMORY", ret, vcpu->vm);
 }
 
-static void __test_pre_fault_memory(unsigned long vm_type, bool private)
+struct test_params {
+	unsigned long vm_type;
+	bool private;
+};
+
+static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
 {
+	struct test_params *p = arg;
 	const struct vm_shape shape = {
-		.mode = VM_MODE_DEFAULT,
-		.type = vm_type,
+		.mode = guest_mode,
+		.type = p->vm_type,
 	};
 	struct kvm_vcpu *vcpu;
 	struct kvm_run *run;
@@ -78,10 +94,17 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
 	uint64_t guest_test_virt_mem;
 	uint64_t alignment, guest_page_size;
 
+	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(guest_mode));
+
 	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, guest_code);
 
-	alignment = guest_page_size = vm_guest_mode_params[VM_MODE_DEFAULT].page_size;
-	guest_test_phys_mem = (vm->max_gfn - TEST_NPAGES) * guest_page_size;
+	guest_page_size = vm_guest_mode_params[guest_mode].page_size;
+
+	test_config.page_size = guest_page_size;
+	test_config.test_size = TEST_BASE_SIZE + test_config.page_size;
+	test_config.test_num_pages = vm_calc_num_guest_pages(vm->mode, test_config.test_size);
+
+	guest_test_phys_mem = (vm->max_gfn - test_config.test_num_pages) * test_config.page_size;
 #ifdef __s390x__
 	alignment = max(0x100000UL, guest_page_size);
 #else
@@ -91,22 +114,31 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
 	guest_test_virt_mem = guest_test_phys_mem & ((1ULL << (vm->va_bits - 1)) - 1);
 
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
-				    guest_test_phys_mem, TEST_SLOT, TEST_NPAGES,
-				    private ? KVM_MEM_GUEST_MEMFD : 0);
-	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, TEST_NPAGES);
-
-	if (private)
-		vm_mem_set_private(vm, guest_test_phys_mem, TEST_SIZE);
-	pre_fault_memory(vcpu, guest_test_phys_mem, SZ_2M, 0);
-	pre_fault_memory(vcpu, guest_test_phys_mem + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
-	pre_fault_memory(vcpu, guest_test_phys_mem + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
+				    guest_test_phys_mem, TEST_SLOT, test_config.test_num_pages,
+				    p->private ? KVM_MEM_GUEST_MEMFD : 0);
+	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, test_config.test_num_pages);
+
+	if (p->private)
+		vm_mem_set_private(vm, guest_test_phys_mem, test_config.test_size);
+	pre_fault_memory(vcpu, guest_test_phys_mem, TEST_BASE_SIZE, 0);
+	/* Test pre-faulting over an already faulted range */
+	pre_fault_memory(vcpu, guest_test_phys_mem, TEST_BASE_SIZE, 0);
+	pre_fault_memory(vcpu, guest_test_phys_mem + TEST_BASE_SIZE,
+			 test_config.page_size * 2, test_config.page_size);
+	pre_fault_memory(vcpu, guest_test_phys_mem + test_config.test_size,
+			 test_config.page_size, test_config.page_size);
 
 	vcpu_args_set(vcpu, 1, guest_test_virt_mem);
+
+	/* Export the shared variables to the guest. */
+	sync_global_to_guest(vm, test_config);
+
 	vcpu_run(vcpu);
 
 	run = vcpu->run;
-	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
-		    "Wanted KVM_EXIT_IO, got exit reason: %u (%s)",
+	TEST_ASSERT(run->exit_reason == UCALL_EXIT_REASON,
+		    "Wanted %s, got exit reason: %u (%s)",
+		    exit_reason_str(UCALL_EXIT_REASON),
 		    run->exit_reason, exit_reason_str(run->exit_reason));
 
 	switch (get_ucall(vcpu, &uc)) {
@@ -130,7 +162,12 @@ static void test_pre_fault_memory(unsigned long vm_type, bool private)
 		return;
 	}
 
-	__test_pre_fault_memory(vm_type, private);
+	struct test_params p = {
+		.vm_type = vm_type,
+		.private = private,
+	};
+
+	for_each_guest_mode(__test_pre_fault_memory, &p);
 }
 
 int main(int argc, char *argv[])
-- 
2.43.0


