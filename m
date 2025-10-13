Return-Path: <linux-kselftest+bounces-43002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E16EBD49A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB3B403D5D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD7E30E83A;
	Mon, 13 Oct 2025 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTK9m1xA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A186E30E0E9
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368547; cv=none; b=oH8/I/xW13E2dtKaG6smwSXOeIaN4aVVG3P7zuyVzf2WxrHXf0h/XOYgVomAcP0zpf1kN9EBwV8jgXQoqhqkmCO0imiNpBi15u6L9N2GAMYOqDy8sKerfdglrCYn00KeocaNif5w88k23VuTOTFu18q6corUsUY/8Lh4rul3/2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368547; c=relaxed/simple;
	bh=lTDjButRkJ3Cx5uU/JAtEV++5t/e00mS8oYnDCNnkjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/mASou0c0Kb0qXQN3umsE69PGozM/I2sShyi2dTOqvcQljHNcDRtCtGgrMAUY4iJ3bIgAoFesExu246yPZccNtHnTpsKymVnKX8boOaMxCy9+gs7cxOc5AHBRQ484o0QrqSOOV6lucbAyGJFahJZP9zO1mKtE3yk0IdL8k9hQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTK9m1xA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so26159075e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760368543; x=1760973343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCSrMFeSurFqrsJ2giFUs5nVIkyf5eYx9hKkmNRZA3A=;
        b=kTK9m1xARwH2mQR/z2EuwHWBt+hbFrAXbuSLonnzyI4pegEQKYqhjEggDDjLkkeZnW
         SYPYDzKDR6YpHOy4SAcBryllUMY9quUNTvuESSOLyJW3JfU+knwCwHDkYQfgfUN1TUkY
         G0oX3wcxVAfwtpNDnbUuZBFLOYHAYO9aXtCcLTipKFKDU55xal1HLXIK+VmwQu0mojeR
         Zrw6AIv/HMiR42zB6UUAI6SMTL6pmKLA0L8QvP0+4LgJa/QI1mWgCVMUb+a43+hWYl69
         uAa4WcJ7bHxDMzAF8vPtFFjIcRkO/9AApi/sKXXSDAlGkIR224OrLqF9gqyVIG8sivTp
         oeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368543; x=1760973343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCSrMFeSurFqrsJ2giFUs5nVIkyf5eYx9hKkmNRZA3A=;
        b=EOz5FurbBYNqGUwR54FOHSV3Sj/Gp49NBfohfT5KAbFKFH5Xtd4FqZADFft6lqS/gD
         zuq1qiBcVa8k83XxoQP4qOWlMa/kb0MRCDddwlWrz1cUYleJ59wyVggF22ZwguZNF81U
         MQZ+fPtOyLxBGYnPxSNmHzbWTbZnLPN1KZN4y9LZwo4xavlVhgEDffQYjqn3HvOX/M9k
         PByYJcBilIlB8aG8U62fx1F1/GysdwCzX168ZXJcQFjasFhNEQf0T9FCiz4vUHb0oZUN
         e3VRmQZprQdbICniWw0v0rJ8UswecU33LNVHaPOXdHoePGhcBRfBfejO0XC+ryCE+bCX
         bE4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMRqKypsjgllmlJIGxZeMGGEL0TReX+X7B04wwqwMJDvHOjTHLAwx0UCPvkhjOe7+E20aK1rAnS4sUltfoOyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGiPF7YS/3nv0WLFOw7JKDeMvQvZc5jP5EjaCduVETmXZP4qiD
	hoQTE4ow8jdBlllMguc4iyc/uor/KoTPmw9fLQFXUm5cvEdhqkVMSJsL
X-Gm-Gg: ASbGnctD8vWqmv87MRVXQYDFL30oJomLafvCSWOtjSMLu12Cz9oBS1wgo/tIjOarzK/
	5hcvBHG7aNIMpwl0RwRNuLfgu2SyqtvDGIMmQowN4wo/scXRl+TdtRj0FSXUAij5uSql3RrVXi/
	n19P3Kc/ePPUBsDRiYI2ntW6JpgNmiu2IMtmeTP5JrlgDHF+DN+NucK8ebCfQq5WUfnp+1pLHtA
	3xsjnzN/ZTnvvp67eQow4fw/WN0y/Fq0oYvO8/15fFuMYnkLBlMWemwY61Q3NURbnDAuVrlQjQo
	wZ2WzxSO3D9BHUZ6FQDCZdS7Vc9gJcHyfZ4ziHpqUnqnM4/p37Gs1mtcUlb0MoD9wwfAYbhYN0L
	JItStRTRZoTizsLkNCmjCN44Cmr4/nBRBF4VOimKIpSlWEnWGPd2XAw88uO6Ra8ebNeqaORnDxT
	FkoIyGMuYetIEoaNo=
X-Google-Smtp-Source: AGHT+IEt3rxThBLWKGN/jwmns/gxZmIihkaAQISXuC9Iitep8SFGSh4XAnm8RXbIElBPhI6EpEA2fw==
X-Received: by 2002:a05:600c:8487:b0:45b:79fd:cb3d with SMTP id 5b1f17b1804b1-46fa9b13ab7mr150449805e9.36.1760368542783;
        Mon, 13 Oct 2025 08:15:42 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.3.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab36a773sm135545825e9.0.2025.10.13.08.15.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 08:15:42 -0700 (PDT)
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
Subject: [PATCH v2 3/4] KVM: selftests: Enable pre_fault_memory_test for arm64
Date: Mon, 13 Oct 2025 16:15:00 +0100
Message-ID: <20251013151502.6679-4-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013151502.6679-1-jackabt.amazon@gmail.com>
References: <20251013151502.6679-1-jackabt.amazon@gmail.com>
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


