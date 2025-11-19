Return-Path: <linux-kselftest+bounces-45997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2758C6FD3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 16:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C894F2F3D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 15:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9769371DC5;
	Wed, 19 Nov 2025 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqLodNuy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B936CE1E
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567378; cv=none; b=pnbZU/+UA/fRy8fJWK7+ByQgBwX9MT2jMbuCvFYRQT8o4biGQN/HWL1zjn4DjG9uJSJCETnDQE3AnmLmG3OZ+7KBxk2KyGJtDl1vleXdqe2KtAEJdsdrhokL4ul4BXHU4mU5MGsF7Zjic0GXU71SE8W0vRDrI9izSu2XA5nkRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567378; c=relaxed/simple;
	bh=APLevQClc+Cq7LnuM4g/WwrwilUkIOU+tQfgjKDS05Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+ID5OoCH+xQAzIYH5oReRYBxAtm4xriErM8e/CI0MkhzxxlQzYqrOZZwZngaCfDKsm7Kw0tURCreBhRRw4J+DgzVk3J6DrupGPPVwUEpwbvE7/LZZj3YPD5cw9iWitAFafURaD/dCz8f1rq9MQi4BSbRB5HSbHloywfEugTbWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqLodNuy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3720e58eso6296190f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 07:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763567374; x=1764172174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYPZ2TAv2fl/D9t0qmZ6idVIls0qfp4iF8sGuYso3OI=;
        b=eqLodNuyPIz4LCfgfp1UPpLGksVT101xTg4/Y2gBoju0imaMKyXJCSQG3cdrl+J6PI
         DqRvbLFUoZL+gH8tuLxSsJbjyVyPd5P278sPM1rIhYGyKI5nn78yjU/jymZICwGcuLCa
         c57Kn6YAIbnP4mmeB1uuxFbaAzrlGVHpDVq0tOlv9w8EkFxssU/2b3VXzyTIfQQDfLEs
         JyiyRJwDXmBERBImLuvgdg9yIy8sGsaiR4V+cAFPnwx9WxZ1JZjklpKBatsgJpKNpPwX
         SnWlPEZ/3R4yrPuIEeHQToNLNMz+UjWzLVHe3qOHzyni+njIXrv+QVUApG5c5d4LqZg/
         4dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567374; x=1764172174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nYPZ2TAv2fl/D9t0qmZ6idVIls0qfp4iF8sGuYso3OI=;
        b=SSnHGMm+mFHBLq+vtnP0E3gpbgYjJo04Q/D+OpVIzsmtmAoX6tSMweEwjol2slSzQc
         obo/j5wFAxv9PztQp4oA9nCfGYLIFQz4hLbGJnPLBT0VfA+qHbZQMXDparPnDbWYhQGh
         MJ/JV6oQogCKRgfFlFmUDABT4SoYzZ3w6FpLT/GqsDgPserTUtY0ismFEvpqqQ6rSx6S
         MCMNOZiyBHJF+in3xhyQ/Sald2HUiJP8XQPSytsHZNX6b1lXJMMQPdP95AZWWVM8tZLF
         oMZuON2CxTlt3zXdYhUwWfav1zYiY1WQMkYS25n5APWWkfKHY6Ny9f6/L7TNhTEWhczA
         hszQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9QLs91v4s3XE30IeEByyhmW0hprdFUzc7R1LUsxhhGLS7EIdVXTl2KipYPmzCiK4sbHZsQrcfC/JLaKhH8Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbqc9EHDBDSi9CpAIwh6s5RcJ1/FSuehvMNDCnCxUiqSIIsQfX
	4DFkzAjjow0V75TcZyA21kYGCJLAs+6H75R0UnHvm3topAIFp1ltuqbT
X-Gm-Gg: ASbGncvWsuI9u7arZsuriQSI97+erCPWYf/1I0MFrKQjfFPBZN46bwvYNH0KTybd3SY
	LNcrYKkx5TduUDl4SwGlcLwbfPzB7mcZtZFiEdu9XZ7ayLwUQgCjRPggByZTK/CtdeuZDjubfXS
	W+3P4ZWKS1KwhDckUkeRp9YL5QbBOlAuj+Ep3FgA4t60PTih+17mf7kiWB5xdCacNjeJgo67zvG
	h1B3wK2gNC2twP6naUfJQ30Jwb1T/GBk/n4Xao3hi4qRp/y61DJlNBiWXieUfjr9/NdAdRNchgy
	sezXjKblpt4YjR9fUdx82BnXtVzOcecQlgqWwcUXgUbvoXLdi9xZRoGEkiq6Khxg1OtjEAZis93
	Qe9TDvtoaOFhIORyeohZ2thdzbhSPaXDIVXiesJrvvsBYlzpIh/FvpadKxNt9qPD9UvE7hqWxJX
	RX3F2c5Si40RW+fP8e6ZUP1FNkk4OooIwJRep+DLY0/C+srrin1oY+87Q=
X-Google-Smtp-Source: AGHT+IGnRWO/EQarXoiPW6xopu6JnhvTujLJMDnIONEFIwE5R1LQ002Uig+rL8Cjp6spjmieTrZ1vg==
X-Received: by 2002:a05:6000:1788:b0:42b:4139:577b with SMTP id ffacd0b85a97d-42b5938fe6dmr19867296f8f.45.1763567373753;
        Wed, 19 Nov 2025 07:49:33 -0800 (PST)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.3.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42c9628ebacsm25969755f8f.30.2025.11.19.07.49.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Nov 2025 07:49:33 -0800 (PST)
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
	xmarcalx@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.com
Subject: [PATCH v3 2/3] KVM: selftests: Enable pre_fault_memory_test for arm64
Date: Wed, 19 Nov 2025 15:49:09 +0000
Message-ID: <20251119154910.97716-3-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119154910.97716-1-jackabt.amazon@gmail.com>
References: <20251119154910.97716-1-jackabt.amazon@gmail.com>
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
 .../selftests/kvm/pre_fault_memory_test.c     | 78 ++++++++++++++-----
 2 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 148d427ff24b..0ddd8db60197 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -183,6 +183,7 @@ TEST_GEN_PROGS_arm64 += memslot_perf_test
 TEST_GEN_PROGS_arm64 += mmu_stress_test
 TEST_GEN_PROGS_arm64 += rseq_test
 TEST_GEN_PROGS_arm64 += steal_time
+TEST_GEN_PROGS_arm64 += pre_fault_memory_test
 
 TEST_GEN_PROGS_s390 = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_s390 += s390/memop
diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
index f04768c1d2e4..674931e7bb3a 100644
--- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
@@ -11,19 +11,29 @@
 #include <kvm_util.h>
 #include <processor.h>
 #include <pthread.h>
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
@@ -159,11 +169,17 @@ static void pre_fault_memory(struct kvm_vcpu *vcpu, u64 base_gpa, u64 offset,
 					  KVM_PRE_FAULT_MEMORY, ret, vcpu->vm);
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
@@ -174,10 +190,17 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
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
@@ -187,23 +210,31 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
 	guest_test_virt_mem = guest_test_phys_mem & ((1ULL << (vm->va_bits - 1)) - 1);
 
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
-				    guest_test_phys_mem, TEST_SLOT, TEST_NPAGES,
-				    private ? KVM_MEM_GUEST_MEMFD : 0);
-	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, TEST_NPAGES);
+				    guest_test_phys_mem, TEST_SLOT, test_config.test_num_pages,
+				    p->private ? KVM_MEM_GUEST_MEMFD : 0);
+	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, test_config.test_num_pages);
+
+	if (p->private)
+		vm_mem_set_private(vm, guest_test_phys_mem, test_config.test_size);
+	pre_fault_memory(vcpu, guest_test_phys_mem, TEST_BASE_SIZE, 0, p->private);
+	/* Test pre-faulting over an already faulted range */
+	pre_fault_memory(vcpu, guest_test_phys_mem, TEST_BASE_SIZE, 0, p->private);
+	pre_fault_memory(vcpu, guest_test_phys_mem + TEST_BASE_SIZE,
+			 test_config.page_size * 2, test_config.page_size, p->private);
+	pre_fault_memory(vcpu, guest_test_phys_mem + test_config.test_size,
+			 test_config.page_size, test_config.page_size, p->private);
 
-	if (private)
-		vm_mem_set_private(vm, guest_test_phys_mem, TEST_SIZE);
+	vcpu_args_set(vcpu, 1, guest_test_virt_mem);
 
-	pre_fault_memory(vcpu, guest_test_phys_mem, 0, SZ_2M, 0, private);
-	pre_fault_memory(vcpu, guest_test_phys_mem, SZ_2M, PAGE_SIZE * 2, PAGE_SIZE, private);
-	pre_fault_memory(vcpu, guest_test_phys_mem, TEST_SIZE, PAGE_SIZE, PAGE_SIZE, private);
+	/* Export the shared variables to the guest. */
+	sync_global_to_guest(vm, test_config);
 
-	vcpu_args_set(vcpu, 1, guest_test_virt_mem);
 	vcpu_run(vcpu);
 
 	run = vcpu->run;
-	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
-		    "Wanted KVM_EXIT_IO, got exit reason: %u (%s)",
+	TEST_ASSERT(run->exit_reason == UCALL_EXIT_REASON,
+		    "Wanted %s, got exit reason: %u (%s)",
+		    exit_reason_str(UCALL_EXIT_REASON),
 		    run->exit_reason, exit_reason_str(run->exit_reason));
 
 	switch (get_ucall(vcpu, &uc)) {
@@ -227,7 +258,12 @@ static void test_pre_fault_memory(unsigned long vm_type, bool private)
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


