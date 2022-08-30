Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4878B5A70B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiH3WWf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiH3WV7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:21:59 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A243983F0A
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:21:00 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id by13-20020a056a00400d00b0052ec5a1cd4dso5180704pfb.21
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=zd+lBScqnSmkIetLC1xR4dudPj5a700X/6NrBlSgAV4=;
        b=ET5No9KOQARFFK18hAOs093fKjXxVroc6nLNGj2YcF5XnW5vp4KG7BMHABT3lvRkys
         pfcLwV/CjF9DMORwkMQghxC6FjPEk3/jq0Ew5hs/MwfGWZsYNaOE0oHaufvVrEQeo569
         hJSw8//FeEyvOm0pZcf6MlA/u9hOGhHMk5hip7rFr/OrGgMsGnG9vfKcF8/7EOR+w0QI
         ZeAIg4uworipwrLCrej+fyLhv5V1O8psD/t2XZnlObKRo9Dn/hVDoA/awOceWqrzLz09
         JnyetQF7n21GylCr13ssH7SFgct8iPEYG27cyc+5FvWQiXM1zEyt+NIVoP6x/huPjdnQ
         JhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=zd+lBScqnSmkIetLC1xR4dudPj5a700X/6NrBlSgAV4=;
        b=prdaRbYdn2L0pmkZGZDKVbLVPpnQuS+lx9unIgGvaUW/6UDHk7R8LwjYEdlSj+CbvL
         4njmDwfFetlQkLlCB+OaQFeix6IFc7JTuXqWCVRc6Pa6VY0XnbmKLTqbcJM+86qpGo/W
         2rlmlLqWNA8YP2B33VZIUD1bVsnAPgFpHfRIZSuEz3o2fN9vMuJEcMDC+IfYsjkM1h0g
         lhg8dP8IBCEP6wWffu6BedqGEci3mhuzByELnXe4xJ1B5Pk0/61zEFaK4fD3c/pgSJZH
         kcRMQDX9KhkWrdiirG40PUXSR7UUuwd1cPHAz1qrO9sGDNv0ofLClLki9hysQWJo6ul8
         hA5w==
X-Gm-Message-State: ACgBeo0Bfx7hKIHr1pbTHpYQYo8uQpXBhZjvNyzxmfWrbQe0sDJGxxAq
        KzL5vAIZOztQ52RVAxL/LW8+DG4gRMaHcJ6sS+dJVVKgoUB40CvOglQ8G7oApFaUtFshOXcQdEZ
        XMZk1WuYMK/knehOUjffSY2CHi2OnlDpidKVZNeBEd0AEeK+HKQg+ZcmNdOKtr3iTG3gv+wU=
X-Google-Smtp-Source: AA6agR7l+9nzCrkMd2h5pdfU7qg8qiGZHLUMkG4txvqEY4nDBo+Jb6sEYsb5hHykvJHBJQ7xBXLtiptpiw==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:90a:738a:b0:1fa:d930:49d1 with SMTP id
 j10-20020a17090a738a00b001fad93049d1mr177774pjg.130.1661898033307; Tue, 30
 Aug 2022 15:20:33 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:19:59 +0000
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
Mime-Version: 1.0
References: <20220830222000.709028-1-sagis@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-17-sagis@google.com>
Subject: [RFC PATCH v2 16/17] KVM: selftest: TDX: Add TDG.VP.INFO test
From:   Sagi Shahar <sagis@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Sagi Shahar <sagis@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Ryan Afranji <afranji@google.com>,
        Roger Wang <runanwang@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Ben Gardon <bgardon@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Xu <peterx@redhat.com>, Oliver Upton <oupton@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Yang Zhong <yang.zhong@intel.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Shier <pshier@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Like Xu <like.xu@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roger Wang <runanwang@google.com>

Adds a test for TDG.VP.INFO

Signed-off-by: Roger Wang <runanwang@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  | 103 ++++++++----
 .../selftests/kvm/lib/x86_64/tdx_lib.c        |  18 ++-
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 150 ++++++++++++++++++
 3 files changed, 235 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
index 3729543a05a3..7af2d189043f 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -10,6 +10,11 @@
  */
 #define TDX_GUEST_MAX_NR_PAGES 10000
 
+/*
+ * Max number of vCPUs for the guest VM
+ */
+ #define TDX_GUEST_MAX_NUM_VCPUS 3
+
 /*
  * Page Table Address used when paging is enabled.
  */
@@ -71,6 +76,11 @@
 #define TDX_MMIO_READ 0
 #define TDX_MMIO_WRITE 1
 
+#define TDX_TDCALL_INFO   1
+
+#define TDX_TDPARAM_ATTR_SEPT_VE_DISABLE_BIT	(1UL << 28)
+#define TDX_TDPARAM_ATTR_PKS_BIT		(1UL << 30)
+
 #define GDT_ENTRY(flags, base, limit)				\
 		((((base)  & 0xff000000ULL) << (56-24)) |	\
 		 (((flags) & 0x0000f0ffULL) << 40) |		\
@@ -98,6 +108,7 @@ void add_td_memory(struct kvm_vm *vm, void *source_page,
 		   uint64_t gpa, int size);
 void finalize_td_memory(struct kvm_vm *vm);
 void initialize_td(struct kvm_vm *vm);
+void initialize_td_with_attributes(struct kvm_vm *vm, uint64_t attributes);
 void initialize_td_vcpu(struct kvm_vcpu *vcpu);
 void prepare_source_image(struct kvm_vm *vm, void *guest_code,
 			  size_t guest_code_size,
@@ -116,40 +127,41 @@ void prepare_source_image(struct kvm_vm *vm, void *guest_code,
 static inline void tdcall(struct kvm_regs *regs)
 {
 	asm volatile (
-			"mov %13, %%rax;\n\t"
-			"mov %14, %%rbx;\n\t"
-			"mov %15, %%rcx;\n\t"
-			"mov %16, %%rdx;\n\t"
-			"mov %17, %%r8;\n\t"
-			"mov %18, %%r9;\n\t"
-			"mov %19, %%r10;\n\t"
-			"mov %20, %%r11;\n\t"
-			"mov %21, %%r12;\n\t"
-			"mov %22, %%r13;\n\t"
-			"mov %23, %%r14;\n\t"
-			"mov %24, %%r15;\n\t"
-			"mov %25, %%rbp;\n\t"
-			"mov %26, %%rsi;\n\t"
-			"mov %27, %%rdi;\n\t"
+			"mov %14, %%rax;\n\t"
+			"mov %15, %%rbx;\n\t"
+			"mov %16, %%rcx;\n\t"
+			"mov %17, %%rdx;\n\t"
+			"mov %18, %%r8;\n\t"
+			"mov %19, %%r9;\n\t"
+			"mov %20, %%r10;\n\t"
+			"mov %21, %%r11;\n\t"
+			"mov %22, %%r12;\n\t"
+			"mov %23, %%r13;\n\t"
+			"mov %24, %%r14;\n\t"
+			"mov %25, %%r15;\n\t"
+			"mov %26, %%rbp;\n\t"
+			"mov %27, %%rsi;\n\t"
+			"mov %28, %%rdi;\n\t"
 			".byte 0x66, 0x0F, 0x01, 0xCC;\n\t"
 			"mov %%rax, %0;\n\t"
 			"mov %%rbx, %1;\n\t"
-			"mov %%rdx, %2;\n\t"
-			"mov %%r8, %3;\n\t"
-			"mov %%r9, %4;\n\t"
-			"mov %%r10, %5;\n\t"
-			"mov %%r11, %6;\n\t"
-			"mov %%r12, %7;\n\t"
-			"mov %%r13, %8;\n\t"
-			"mov %%r14, %9;\n\t"
-			"mov %%r15, %10;\n\t"
-			"mov %%rsi, %11;\n\t"
-			"mov %%rdi, %12;\n\t"
-			: "=m" (regs->rax), "=m" (regs->rbx), "=m" (regs->rdx),
-			"=m" (regs->r8), "=m" (regs->r9), "=m" (regs->r10),
-			"=m" (regs->r11), "=m" (regs->r12), "=m" (regs->r13),
-			"=m" (regs->r14), "=m" (regs->r15), "=m" (regs->rsi),
-			"=m" (regs->rdi)
+			"mov %%rcx, %2;\n\t"
+			"mov %%rdx, %3;\n\t"
+			"mov %%r8, %4;\n\t"
+			"mov %%r9, %5;\n\t"
+			"mov %%r10, %6;\n\t"
+			"mov %%r11, %7;\n\t"
+			"mov %%r12, %8;\n\t"
+			"mov %%r13, %9;\n\t"
+			"mov %%r14, %10;\n\t"
+			"mov %%r15, %11;\n\t"
+			"mov %%rsi, %12;\n\t"
+			"mov %%rdi, %13;\n\t"
+			: "=m" (regs->rax), "=m" (regs->rbx), "=m" (regs->rcx),
+			"=m" (regs->rdx), "=m" (regs->r8), "=m" (regs->r9),
+			"=m" (regs->r10), "=m" (regs->r11), "=m" (regs->r12),
+			"=m" (regs->r13), "=m" (regs->r14), "=m" (regs->r15),
+			"=m" (regs->rsi), "=m" (regs->rdi)
 			: "m" (regs->rax), "m" (regs->rbx), "m" (regs->rcx),
 			"m" (regs->rdx), "m" (regs->r8), "m" (regs->r9),
 			"m" (regs->r10), "m" (regs->r11), "m" (regs->r12),
@@ -370,6 +382,35 @@ static inline uint64_t tdvmcall_cpuid(uint32_t eax, uint32_t ecx,
 	return regs.r10;
 }
 
+/*
+ * Execute TDG.VP.INFO instruction.
+ */
+static inline uint64_t tdcall_vp_info(uint64_t *rcx, uint64_t *rdx,
+				      uint64_t *r8, uint64_t *r9,
+				      uint64_t *r10, uint64_t *r11)
+{
+	struct kvm_regs regs;
+
+	memset(&regs, 0, sizeof(regs));
+	regs.rax = TDX_TDCALL_INFO;
+	tdcall(&regs);
+
+	if (rcx)
+		*rcx = regs.rcx;
+	if (rdx)
+		*rdx = regs.rdx;
+	if (r8)
+		*r8 = regs.r8;
+	if (r9)
+		*r9 = regs.r9;
+	if (r10)
+		*r10 = regs.r10;
+	if (r11)
+		*r11 = regs.r11;
+
+	return regs.rax;
+}
+
 /*
  * Reports a 32 bit value from the guest to user space using a TDVM IO call.
  * Data is reported on port TDX_DATA_REPORT_PORT.
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c b/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
index 72bf2ff24a29..dc9a44ae4064 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
@@ -78,10 +78,10 @@ static struct tdx_cpuid_data get_tdx_cpuid_data(struct kvm_vm *vm)
 }
 
 /*
- * Initialize a VM as a TD.
+ * Initialize a VM as a TD with attributes.
  *
  */
-void initialize_td(struct kvm_vm *vm)
+void initialize_td_with_attributes(struct kvm_vm *vm, uint64_t attributes)
 {
 	struct tdx_cpuid_data cpuid_data;
 	int rc;
@@ -99,7 +99,7 @@ void initialize_td(struct kvm_vm *vm)
 			      KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK);
 	vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
 
-	/* Allocate and setup memoryfor the td guest. */
+	/* Allocate and setup memory for the td guest. */
 	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
 				    TDX_GUEST_PT_FIXED_ADDR,
 				    0, TDX_GUEST_MAX_NR_PAGES, 0);
@@ -108,12 +108,20 @@ void initialize_td(struct kvm_vm *vm)
 
 	cpuid_data = get_tdx_cpuid_data(vm);
 
-	init_vm.max_vcpus = 1;
-	init_vm.attributes = 0;
+	init_vm.max_vcpus = TDX_GUEST_MAX_NUM_VCPUS;
+	init_vm.attributes = attributes;
 	memcpy(&init_vm.cpuid, &cpuid_data, sizeof(cpuid_data));
 	tdx_ioctl(vm->fd, KVM_TDX_INIT_VM, 0, &init_vm);
 }
 
+/*
+ * Initialize a VM as a TD with no attributes.
+ *
+ */
+void initialize_td(struct kvm_vm *vm)
+{
+	initialize_td_with_attributes(vm, 0);
+}
 
 void initialize_td_vcpu(struct kvm_vcpu *vcpu)
 {
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 1776b39b7d9e..8d49099e1ed8 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -2,6 +2,7 @@
 
 #include "asm/kvm.h"
 #include "linux/kernel.h"
+#include <assert.h>
 #include <bits/stdint-uintn.h>
 #include <fcntl.h>
 #include <limits.h>
@@ -1366,6 +1367,154 @@ void verify_host_reading_private_mem(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Do a TDG.VP.INFO call from the guest
+ */
+TDX_GUEST_FUNCTION(guest_tdcall_vp_info)
+{
+	uint64_t err;
+	uint64_t rcx, rdx, r8, r9, r10, r11;
+
+	err = tdcall_vp_info(&rcx, &rdx, &r8, &r9, &r10, &r11);
+	if (err)
+		tdvmcall_fatal(err);
+
+	/* return values to user space host */
+	err = tdvm_report_64bit_to_user_space(rcx);
+	if (err)
+		tdvmcall_fatal(err);
+
+	err = tdvm_report_64bit_to_user_space(rdx);
+	if (err)
+		tdvmcall_fatal(err);
+
+	err = tdvm_report_64bit_to_user_space(r8);
+	if (err)
+		tdvmcall_fatal(err);
+
+	err = tdvm_report_64bit_to_user_space(r9);
+	if (err)
+		tdvmcall_fatal(err);
+
+	err = tdvm_report_64bit_to_user_space(r10);
+	if (err)
+		tdvmcall_fatal(err);
+
+	err = tdvm_report_64bit_to_user_space(r11);
+	if (err)
+		tdvmcall_fatal(err);
+
+	tdvmcall_success();
+}
+
+/*
+ * TDG.VP.INFO call from the guest. Verify the right values are returned
+ */
+void verify_tdcall_vp_info(void)
+{
+	const int num_vcpus = 2;
+	struct kvm_vcpu *vcpus[num_vcpus];
+	struct kvm_vm *vm;
+	uint64_t rcx, rdx, r8, r9, r10, r11;
+	uint32_t ret_num_vcpus, ret_max_vcpus;
+	uint64_t attributes;
+	uint32_t i;
+	struct kvm_cpuid_entry2 *cpuid_entry;
+	struct tdx_cpuid_data cpuid_data;
+	int max_pa = -1;
+	int ret;
+
+	printf("Verifying TDG.VP.INFO call:\n");
+	/* Create a TD VM with no memory.*/
+	vm = vm_create_tdx();
+
+	/* Setting attributes parameter used by TDH.MNG.INIT to 0x50000000 */
+	attributes = TDX_TDPARAM_ATTR_SEPT_VE_DISABLE_BIT |
+		     TDX_TDPARAM_ATTR_PKS_BIT;
+
+	/* Allocate TD guest memory and initialize the TD.*/
+	initialize_td_with_attributes(vm, attributes);
+
+	/* Create vCPUs*/
+	for (i = 0; i < num_vcpus; i++)
+		vcpus[i] = vm_vcpu_add_tdx(vm, i);
+
+	/* Setup and initialize VM memory */
+	prepare_source_image(vm, guest_tdcall_vp_info,
+			     TDX_FUNCTION_SIZE(guest_tdcall_vp_info), 0);
+	finalize_td_memory(vm);
+
+	/* Get KVM CPUIDs for reference */
+	memset(&cpuid_data, 0, sizeof(cpuid_data));
+	cpuid_data.cpuid.nent = KVM_MAX_CPUID_ENTRIES;
+	ret = ioctl(vm->kvm_fd, KVM_GET_SUPPORTED_CPUID, &cpuid_data);
+	TEST_ASSERT(!ret, "KVM_GET_SUPPORTED_CPUID failed\n");
+	cpuid_entry = find_cpuid_entry(cpuid_data, 0x80000008, 0);
+	TEST_ASSERT(cpuid_entry, "CPUID entry missing\n");
+	max_pa = cpuid_entry->eax & 0xff;
+
+	for (i = 0; i < num_vcpus; i++) {
+		struct kvm_vcpu *vcpu = vcpus[i];
+
+		/* Wait for guest to report rcx value */
+		vcpu_run(vcpu);
+		CHECK_GUEST_FAILURE(vcpu);
+		rcx = read_64bit_from_guest(vcpu, TDX_DATA_REPORT_PORT);
+
+		/* Wait for guest to report rdx value */
+		vcpu_run(vcpu);
+		CHECK_GUEST_FAILURE(vcpu);
+		rdx = read_64bit_from_guest(vcpu, TDX_DATA_REPORT_PORT);
+
+		/* Wait for guest to report r8 value */
+		vcpu_run(vcpu);
+		CHECK_GUEST_FAILURE(vcpu);
+		r8 = read_64bit_from_guest(vcpu, TDX_DATA_REPORT_PORT);
+
+		/* Wait for guest to report r9 value */
+		vcpu_run(vcpu);
+		CHECK_GUEST_FAILURE(vcpu);
+		r9 = read_64bit_from_guest(vcpu, TDX_DATA_REPORT_PORT);
+
+		/* Wait for guest to report r10 value */
+		vcpu_run(vcpu);
+		CHECK_GUEST_FAILURE(vcpu);
+		r10 = read_64bit_from_guest(vcpu, TDX_DATA_REPORT_PORT);
+
+		/* Wait for guest to report r11 value */
+		vcpu_run(vcpu);
+		CHECK_GUEST_FAILURE(vcpu);
+		r11 = read_64bit_from_guest(vcpu, TDX_DATA_REPORT_PORT);
+
+		ret_num_vcpus = r8 & 0xFFFFFFFF;
+		ret_max_vcpus = (r8 >> 32) & 0xFFFFFFFF;
+
+		/* first bits 5:0 of rcx represent the GPAW */
+		ASSERT_EQ(rcx & 0x3F, max_pa);
+		/* next 63:6 bits of rcx is reserved and must be 0 */
+		ASSERT_EQ(rcx >> 6, 0);
+		ASSERT_EQ(rdx, attributes);
+		ASSERT_EQ(ret_num_vcpus, num_vcpus);
+		ASSERT_EQ(ret_max_vcpus, TDX_GUEST_MAX_NUM_VCPUS);
+		/* VCPU_INDEX = i */
+		ASSERT_EQ(r9, i);
+		/* verify reserved registers are 0 */
+		ASSERT_EQ(r10, 0);
+		ASSERT_EQ(r11, 0);
+
+		/* Wait for guest to complete execution */
+		vcpu_run(vcpu);
+
+		CHECK_GUEST_FAILURE(vcpu);
+		CHECK_GUEST_COMPLETION(vcpu);
+
+		printf("\t ... Guest completed run on VCPU=%u\n", i);
+	}
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	if (!is_tdx_enabled()) {
@@ -1387,6 +1536,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_mmio_reads);
 	run_in_new_process(&verify_mmio_writes);
 	run_in_new_process(&verify_host_reading_private_mem);
+	run_in_new_process(&verify_tdcall_vp_info);
 
 	return 0;
 }
-- 
2.37.2.789.g6183377224-goog

