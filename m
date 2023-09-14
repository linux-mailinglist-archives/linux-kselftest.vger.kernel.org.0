Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A4279F649
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 03:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjINB2Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 21:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjINB2P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 21:28:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971CF1BD2;
        Wed, 13 Sep 2023 18:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694654891; x=1726190891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xR0jk69XiNoXQSVUE8+NJjR+y22dLHxb52r3e+Xe00Y=;
  b=YXSuQblDonZo4Ik9nVVXHHTYWp6Yd6j1nZVzv+yo/3nzrw8z/vaKjtJ3
   JAzhgy7tEM+KTewlAOk+AnqtEAKl77Tg7cNR51TF+G7o0aG1s2nJ+9PQY
   Z639DwHPbEvMevGy+/Ve+vsizxHY2AEHujkRze2hXtrwbl9G8moVeIs+Y
   X6Z306erqWz+PwhXcSZ3E6poeSEBABGJ35cIhIajVJvpAjJFv4TdY3Dis
   IwmJfcpAAuKr0MPdPOoJC6feqVF2GiSQdfskSnC7V7a2zsc/WSd0BeW5s
   7Lb7z7W0WmnSY7O/X7ARQzOzTXpBzbL8tvLa1Co0rr03DRv6Frw/Dw+WP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="377734004"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="377734004"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 18:28:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="694049055"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="694049055"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 18:28:03 -0700
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        Sean Christopherson <seanjc@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Thomas Huth <thuth@redhat.com>,
        Colton Lewis <coltonlewis@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: [PATCH v3 1/9] KVM: selftests: Unify the codes for guest exception handling
Date:   Thu, 14 Sep 2023 09:36:55 +0800
Message-Id: <7e642ad130d62320cc25a81ed83d08871029e3be.1694421911.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694421911.git.haibo1.xu@intel.com>
References: <cover.1694421911.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rename the vm_init_descriptor_tables() and vcpu_init_vector_tables()
prototypes to vm_init_vector_tables() and vcpu_init_vector_tables()
respectively, so that we can use common names for the architectures
(x86/aarch64/riscv) and then put them in a common header.

By the way, vm_install_exception_handler() prototype were also moved to
the common header since they are commonly used across the architectures.

The patch is a preparation to share the guest exception handling codes
in riscv.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/testing/selftests/kvm/aarch64/arch_timer.c          | 4 ++--
 tools/testing/selftests/kvm/aarch64/debug-exceptions.c    | 4 ++--
 tools/testing/selftests/kvm/aarch64/page_fault_test.c     | 4 ++--
 tools/testing/selftests/kvm/aarch64/vgic_irq.c            | 4 ++--
 tools/testing/selftests/kvm/include/aarch64/processor.h   | 8 +-------
 tools/testing/selftests/kvm/include/kvm_util_base.h       | 7 +++++++
 tools/testing/selftests/kvm/include/x86_64/processor.h    | 5 -----
 tools/testing/selftests/kvm/lib/aarch64/processor.c       | 6 +++---
 tools/testing/selftests/kvm/lib/x86_64/processor.c        | 4 ++--
 tools/testing/selftests/kvm/x86_64/amx_test.c             | 4 ++--
 tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c   | 4 ++--
 tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c         | 4 ++--
 tools/testing/selftests/kvm/x86_64/hyperv_features.c      | 8 ++++----
 tools/testing/selftests/kvm/x86_64/hyperv_ipi.c           | 6 +++---
 tools/testing/selftests/kvm/x86_64/kvm_pv_test.c          | 4 ++--
 tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c   | 4 ++--
 .../testing/selftests/kvm/x86_64/pmu_event_filter_test.c  | 8 ++++----
 .../kvm/x86_64/smaller_maxphyaddr_emulation_test.c        | 4 ++--
 tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c     | 4 ++--
 .../selftests/kvm/x86_64/svm_nested_shutdown_test.c       | 4 ++--
 .../selftests/kvm/x86_64/svm_nested_soft_inject_test.c    | 4 ++--
 tools/testing/selftests/kvm/x86_64/ucna_injection_test.c  | 8 ++++----
 .../selftests/kvm/x86_64/userspace_msr_exit_test.c        | 4 ++--
 .../kvm/x86_64/vmx_exception_with_invalid_guest_state.c   | 4 ++--
 tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c    | 4 ++--
 tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c       | 4 ++--
 tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c      | 4 ++--
 tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c      | 4 ++--
 28 files changed, 66 insertions(+), 70 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
index 274b8465b42a..b63859829a96 100644
--- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
+++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
@@ -377,7 +377,7 @@ static struct kvm_vm *test_vm_create(void)
 
 	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
 
-	vm_init_descriptor_tables(vm);
+	vm_init_vector_tables(vm);
 	vm_install_exception_handler(vm, VECTOR_IRQ_CURRENT, guest_irq_handler);
 
 	if (!test_args.offset.reserved) {
@@ -388,7 +388,7 @@ static struct kvm_vm *test_vm_create(void)
 	}
 
 	for (i = 0; i < nr_vcpus; i++)
-		vcpu_init_descriptor_tables(vcpus[i]);
+		vcpu_init_vector_tables(vcpus[i]);
 
 	test_init_timer_irq(vm);
 	gic_fd = vgic_v3_setup(vm, nr_vcpus, 64, GICD_BASE_GPA, GICR_BASE_GPA);
diff --git a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
index f5b6cb3a0019..38370f28183d 100644
--- a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
+++ b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
@@ -429,8 +429,8 @@ static void test_guest_debug_exceptions(uint8_t bpn, uint8_t wpn, uint8_t ctx_bp
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 
 	vm_install_sync_handler(vm, VECTOR_SYNC_CURRENT,
 				ESR_EC_BRK_INS, guest_sw_bp_handler);
diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
index 47bb914ab2fa..4503afe8a569 100644
--- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
+++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
@@ -541,8 +541,8 @@ static void load_exec_code_for_test(struct kvm_vm *vm)
 static void setup_abort_handlers(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
 				 struct test_desc *test)
 {
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 
 	vm_install_sync_handler(vm, VECTOR_SYNC_CURRENT,
 				ESR_EC_DABT, no_dabt_handler);
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
index 2e64b4856e38..76616d3c6333 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
@@ -756,8 +756,8 @@ static void test_vgic(uint32_t nr_irqs, bool level_sensitive, bool eoi_split)
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 
 	/* Setup the guest args page (so it gets the args). */
 	args_gva = vm_vaddr_alloc_page(vm);
diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index cb537253a6b9..69e7b08d3f99 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -121,14 +121,8 @@ enum {
 void aarch64_get_supported_page_sizes(uint32_t ipa,
 				      bool *ps4k, bool *ps16k, bool *ps64k);
 
-void vm_init_descriptor_tables(struct kvm_vm *vm);
-void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu);
-
-typedef void(*handler_fn)(struct ex_regs *);
-void vm_install_exception_handler(struct kvm_vm *vm,
-		int vector, handler_fn handler);
 void vm_install_sync_handler(struct kvm_vm *vm,
-		int vector, int ec, handler_fn handler);
+		int vector, int ec, exception_handler_fn handler);
 
 uint64_t *virt_get_pte_hva(struct kvm_vm *vm, vm_vaddr_t gva);
 
diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index a18db6a7b3cf..135ae2eb5249 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -932,4 +932,11 @@ void kvm_selftest_arch_init(void);
 
 void kvm_arch_vm_post_create(struct kvm_vm *vm);
 
+void vm_init_vector_tables(struct kvm_vm *vm);
+void vcpu_init_vector_tables(struct kvm_vcpu *vcpu);
+
+struct ex_regs;
+typedef void(*exception_handler_fn)(struct ex_regs *);
+void vm_install_exception_handler(struct kvm_vm *vm, int vector, exception_handler_fn handler);
+
 #endif /* SELFTEST_KVM_UTIL_BASE_H */
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 4fd042112526..8b102bad77c8 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1062,11 +1062,6 @@ struct idt_entry {
 	uint32_t offset2; uint32_t reserved;
 };
 
-void vm_init_descriptor_tables(struct kvm_vm *vm);
-void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu);
-void vm_install_exception_handler(struct kvm_vm *vm, int vector,
-			void (*handler)(struct ex_regs *));
-
 /* If a toddler were to say "abracadabra". */
 #define KVM_EXCEPTION_MAGIC 0xabacadabaULL
 
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 3a0259e25335..51842d23cc39 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -415,10 +415,10 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 }
 
 struct handlers {
-	handler_fn exception_handlers[VECTOR_NUM][ESR_EC_NUM];
+	exception_handler_fn exception_handlers[VECTOR_NUM][ESR_EC_NUM];
 };
 
-void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
+void vcpu_init_vector_tables(struct kvm_vcpu *vcpu)
 {
 	extern char vectors;
 
@@ -458,7 +458,7 @@ void route_exception(struct ex_regs *regs, int vector)
 	kvm_exit_unexpected_exception(vector, ec, valid_ec);
 }
 
-void vm_init_descriptor_tables(struct kvm_vm *vm)
+void vm_init_vector_tables(struct kvm_vm *vm)
 {
 	vm->handlers = __vm_vaddr_alloc(vm, sizeof(struct handlers),
 					vm->page_size, MEM_REGION_DATA);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index d8288374078e..c728c1564f47 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1093,7 +1093,7 @@ void route_exception(struct ex_regs *regs)
 		     regs->vector, regs->rip);
 }
 
-void vm_init_descriptor_tables(struct kvm_vm *vm)
+void vm_init_vector_tables(struct kvm_vm *vm)
 {
 	extern void *idt_handlers;
 	int i;
@@ -1106,7 +1106,7 @@ void vm_init_descriptor_tables(struct kvm_vm *vm)
 			DEFAULT_CODE_SELECTOR);
 }
 
-void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
+void vcpu_init_vector_tables(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vm *vm = vcpu->vm;
 	struct kvm_sregs sregs;
diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 11329e5ff945..4e36c54c2771 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -246,8 +246,8 @@ int main(int argc, char *argv[])
 	vcpu_regs_get(vcpu, &regs1);
 
 	/* Register #NM handler */
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 	vm_install_exception_handler(vm, NM_VECTOR, guest_nm_handler);
 
 	/* amx cfg for guest_code */
diff --git a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
index 0f728f05ea82..ec50e5895e34 100644
--- a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
@@ -110,8 +110,8 @@ static void test_fix_hypercall(bool disable_quirk)
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
 
-	vm_init_descriptor_tables(vcpu->vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vcpu->vm);
+	vcpu_init_vector_tables(vcpu);
 	vm_install_exception_handler(vcpu->vm, UD_VECTOR, guest_ud_handler);
 
 	if (disable_quirk)
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c
index 7bde0c4dfdbd..2ad3785d2795 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c
@@ -257,8 +257,8 @@ int main(int argc, char *argv[])
 	vcpu_args_set(vcpu, 3, vmx_pages_gva, hv_pages_gva, addr_gva2gpa(vm, hcall_page));
 	vcpu_set_msr(vcpu, HV_X64_MSR_VP_INDEX, vcpu->id);
 
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 	vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
 	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index 9f28aa276c4e..0a5a8756b04d 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -156,8 +156,8 @@ static void guest_test_msrs_access(void)
 			vcpu_init_cpuid(vcpu, prev_cpuid);
 		}
 
-		vm_init_descriptor_tables(vm);
-		vcpu_init_descriptor_tables(vcpu);
+		vm_init_vector_tables(vm);
+		vcpu_init_vector_tables(vcpu);
 
 		/* TODO: Make this entire test easier to maintain. */
 		if (stage >= 21)
@@ -531,8 +531,8 @@ static void guest_test_hcalls_access(void)
 	while (true) {
 		vm = vm_create_with_one_vcpu(&vcpu, guest_hcall);
 
-		vm_init_descriptor_tables(vm);
-		vcpu_init_descriptor_tables(vcpu);
+		vm_init_vector_tables(vm);
+		vcpu_init_vector_tables(vcpu);
 
 		/* Hypercall input/output */
 		hcall_page = vm_vaddr_alloc_pages(vm, 2);
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c b/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c
index 6feb5ddb031d..980eef6015a3 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c
@@ -254,16 +254,16 @@ int main(int argc, char *argv[])
 	hcall_page = vm_vaddr_alloc_pages(vm, 2);
 	memset(addr_gva2hva(vm, hcall_page), 0x0, 2 * getpagesize());
 
-	vm_init_descriptor_tables(vm);
+	vm_init_vector_tables(vm);
 
 	vcpu[1] = vm_vcpu_add(vm, RECEIVER_VCPU_ID_1, receiver_code);
-	vcpu_init_descriptor_tables(vcpu[1]);
+	vcpu_init_vector_tables(vcpu[1]);
 	vcpu_args_set(vcpu[1], 2, hcall_page, addr_gva2gpa(vm, hcall_page));
 	vcpu_set_msr(vcpu[1], HV_X64_MSR_VP_INDEX, RECEIVER_VCPU_ID_1);
 	vcpu_set_hv_cpuid(vcpu[1]);
 
 	vcpu[2] = vm_vcpu_add(vm, RECEIVER_VCPU_ID_2, receiver_code);
-	vcpu_init_descriptor_tables(vcpu[2]);
+	vcpu_init_vector_tables(vcpu[2]);
 	vcpu_args_set(vcpu[2], 2, hcall_page, addr_gva2gpa(vm, hcall_page));
 	vcpu_set_msr(vcpu[2], HV_X64_MSR_VP_INDEX, RECEIVER_VCPU_ID_2);
 	vcpu_set_hv_cpuid(vcpu[2]);
diff --git a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
index 9e2879af7c20..dbbedea55cc9 100644
--- a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
+++ b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
@@ -146,8 +146,8 @@ int main(void)
 
 	vcpu_clear_cpuid_entry(vcpu, KVM_CPUID_FEATURES);
 
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 
 	enter_guest(vcpu);
 	kvm_vm_free(vm);
diff --git a/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c b/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
index 80aa3d8b18f8..dbe861db569a 100644
--- a/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
+++ b/tools/testing/selftests/kvm/x86_64/monitor_mwait_test.c
@@ -78,8 +78,8 @@ int main(int argc, char *argv[])
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	vcpu_clear_cpuid_feature(vcpu, X86_FEATURE_MWAIT);
 
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 
 	while (1) {
 		vcpu_run(vcpu);
diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 283cc55597a4..2fbedb0acb0d 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -389,8 +389,8 @@ static void test_pmu_config_disable(void (*guest_code)(void))
 	vm_enable_cap(vm, KVM_CAP_PMU_CAPABILITY, KVM_PMU_CAP_DISABLE);
 
 	vcpu = vm_vcpu_add(vm, 0, guest_code);
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 
 	TEST_ASSERT(!sanity_check_pmu(vcpu),
 		    "Guest should not be able to use disabled PMU.");
@@ -929,8 +929,8 @@ int main(int argc, char *argv[])
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 
 	TEST_REQUIRE(sanity_check_pmu(vcpu));
 
diff --git a/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c b/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
index 06edf00a97d6..37cd8cd230e3 100644
--- a/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
+++ b/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c
@@ -60,8 +60,8 @@ int main(int argc, char *argv[])
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	vcpu_args_set(vcpu, 1, kvm_is_tdp_enabled());
 
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 
 	vcpu_set_cpuid_maxphyaddr(vcpu, MAXPHYADDR);
 
diff --git a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
index 32bef39bec21..c2c451cb3d47 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
@@ -93,8 +93,8 @@ int main(int argc, char *argv[])
 
 	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 
 	vm_install_exception_handler(vm, VINTR_IRQ_NUMBER, vintr_irq_handler);
 	vm_install_exception_handler(vm, INTR_IRQ_NUMBER, intr_irq_handler);
diff --git a/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c b/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c
index d6fcdcc3af31..b06f2ee93e3b 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_nested_shutdown_test.c
@@ -48,8 +48,8 @@ int main(int argc, char *argv[])
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
 
 	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 
 	vcpu_alloc_svm(vm, &svm_gva);
 
diff --git a/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c b/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
index 7ee44496cf97..30f850ebaa4f 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_nested_soft_inject_test.c
@@ -152,8 +152,8 @@ static void run_test(bool is_nmi)
 
 	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 
 	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 	vm_install_exception_handler(vm, BP_VECTOR, guest_bp_handler);
diff --git a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
index 85f34ca7e49e..c92065abe0fd 100644
--- a/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
+++ b/tools/testing/selftests/kvm/x86_64/ucna_injection_test.c
@@ -285,10 +285,10 @@ int main(int argc, char *argv[])
 	cmcidis_vcpu = create_vcpu_with_mce_cap(vm, 1, false, cmci_disabled_guest_code);
 	cmci_vcpu = create_vcpu_with_mce_cap(vm, 2, true, cmci_enabled_guest_code);
 
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(ucna_vcpu);
-	vcpu_init_descriptor_tables(cmcidis_vcpu);
-	vcpu_init_descriptor_tables(cmci_vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(ucna_vcpu);
+	vcpu_init_vector_tables(cmcidis_vcpu);
+	vcpu_init_vector_tables(cmci_vcpu);
 	vm_install_exception_handler(vm, CMCI_VECTOR, guest_cmci_handler);
 	vm_install_exception_handler(vm, GP_VECTOR, guest_gp_handler);
 
diff --git a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
index 3533dc2fbfee..6e473e532c88 100644
--- a/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
+++ b/tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c
@@ -544,8 +544,8 @@ static void test_msr_filter_allow(void)
 
 	vm_ioctl(vm, KVM_X86_SET_MSR_FILTER, &filter_allow);
 
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 
 	vm_install_exception_handler(vm, GP_VECTOR, guest_gp_handler);
 
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
index a9b827c69f32..c5af48f73432 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
@@ -115,8 +115,8 @@ int main(int argc, char *argv[])
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	get_set_sigalrm_vcpu(vcpu);
 
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 
 	vm_install_exception_handler(vm, UD_VECTOR, guest_ud_handler);
 
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index ebbcb0a3f743..e9a2527a0319 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -85,8 +85,8 @@ static void test_guest_wrmsr_perf_capabilities(union perf_capabilities host_cap)
 	struct ucall uc;
 	int r, i;
 
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
 
diff --git a/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
index 67ac2a3292ef..d4f9d100b89a 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c
@@ -410,8 +410,8 @@ int main(int argc, char *argv[])
 
 	vm = vm_create_with_one_vcpu(&params[0].vcpu, halter_guest_code);
 
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(params[0].vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(params[0].vcpu);
 	vm_install_exception_handler(vm, IPI_VECTOR, guest_ipi_handler);
 
 	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
diff --git a/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c b/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c
index 77d04a7bdadd..726b13c9e1f4 100644
--- a/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test.c
@@ -109,8 +109,8 @@ int main(int argc, char *argv[])
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	run = vcpu->run;
 
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 
 	while (1) {
 		vcpu_run(vcpu);
diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
index 05898ad9f4d9..854e512d7963 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
@@ -526,8 +526,8 @@ int main(int argc, char *argv[])
 	};
 	vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &vec);
 
-	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vcpu);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 	vm_install_exception_handler(vm, EVTCHN_VECTOR, evtchn_handler);
 
 	if (do_runstate_tests) {
-- 
2.34.1

