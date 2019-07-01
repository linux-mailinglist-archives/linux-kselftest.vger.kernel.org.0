Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECAE2078B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2019 15:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfEPNDN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 May 2019 09:03:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfEPNDN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 May 2019 09:03:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C285030B4AD0;
        Thu, 16 May 2019 13:03:12 +0000 (UTC)
Received: from thuth.com (ovpn-116-68.ams2.redhat.com [10.36.116.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EF1860BE5;
        Thu, 16 May 2019 13:03:00 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Compile code with warnings enabled
Date:   Thu, 16 May 2019 15:02:57 +0200
Message-Id: <20190516130257.29445-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 16 May 2019 13:03:12 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

So far the KVM selftests are compiled without any compiler warnings
enabled. That's quite bad, since we miss a lot of possible bugs this
way. Let's enable at least "-Wall" and some other useful warning flags
now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 This patch fixes most of the warnings in the x86 code already - but
 for some warnings, I was not quite sure (e.g. about the need for the
 kvm_get_supported_cpuid_entry(1) in some tests), so I did not touch
 that code yet. I also did not check aarch64 yet. I'd be glad if
 someone who knows these parts of the code could have a look at the
 warnings there.

 tools/testing/selftests/kvm/Makefile                        | 4 +++-
 tools/testing/selftests/kvm/dirty_log_test.c                | 6 +++++-
 tools/testing/selftests/kvm/lib/kvm_util.c                  | 3 ---
 tools/testing/selftests/kvm/lib/x86_64/processor.c          | 4 +---
 tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c    | 1 +
 tools/testing/selftests/kvm/x86_64/platform_info_test.c     | 1 -
 tools/testing/selftests/kvm/x86_64/smm_test.c               | 3 +--
 .../selftests/kvm/x86_64/vmx_close_while_nested_test.c      | 5 +----
 tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c    | 5 ++---
 9 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index f8588cca2bef..93f344bb96af 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -32,7 +32,9 @@ LIBKVM += $(LIBKVM_$(UNAME_M))
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
-CFLAGS += -O2 -g -std=gnu99 -fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(UNAME_M) -I..
+CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
+	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
+	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(UNAME_M) -I..
 
 no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
         $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 93f99c6b7d79..0b9f197a783e 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -131,6 +131,7 @@ static void *vcpu_worker(void *data)
 	while (!READ_ONCE(host_quit)) {
 		/* Let the guest dirty the random pages */
 		ret = _vcpu_run(vm, VCPU_ID);
+		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
 		if (get_ucall(vm, VCPU_ID, &uc) == UCALL_SYNC) {
 			pages_count += TEST_PAGES_PER_LOOP;
 			generate_random_array(guest_array, TEST_PAGES_PER_LOOP);
@@ -426,8 +427,11 @@ int main(int argc, char *argv[])
 	unsigned long interval = TEST_HOST_LOOP_INTERVAL;
 	bool mode_selected = false;
 	uint64_t phys_offset = 0;
-	unsigned int mode, host_ipa_limit;
+	unsigned int mode;
 	int opt, i;
+#ifdef __aarch64__
+	unsigned int host_ipa_limit;
+#endif
 
 #ifdef USE_CLEAR_DIRTY_LOG
 	if (!kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT)) {
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 4ca96b228e46..e2528a3894cf 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -135,7 +135,6 @@ struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages,
 			  int perm, unsigned long type)
 {
 	struct kvm_vm *vm;
-	int kvm_fd;
 
 	vm = calloc(1, sizeof(*vm));
 	TEST_ASSERT(vm != NULL, "Insufficient Memory");
@@ -556,7 +555,6 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	uint32_t flags)
 {
 	int ret;
-	unsigned long pmem_size = 0;
 	struct userspace_mem_region *region;
 	size_t huge_page_size = KVM_UTIL_PGS_PER_HUGEPG * vm->page_size;
 
@@ -1302,7 +1300,6 @@ void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
 int _vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
 {
 	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-	int ret;
 
 	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index dc7fae9fa424..21f3040d90cb 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -229,8 +229,6 @@ void sregs_dump(FILE *stream, struct kvm_sregs *sregs,
 
 void virt_pgd_alloc(struct kvm_vm *vm, uint32_t pgd_memslot)
 {
-	int rc;
-
 	TEST_ASSERT(vm->mode == VM_MODE_P52V48_4K, "Attempt to use "
 		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);
 
@@ -549,7 +547,6 @@ vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 	struct pageDirectoryPointerEntry *pdpe;
 	struct pageDirectoryEntry *pde;
 	struct pageTableEntry *pte;
-	void *hva;
 
 	TEST_ASSERT(vm->mode == VM_MODE_P52V48_4K, "Attempt to use "
 		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);
@@ -582,6 +579,7 @@ vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 unmapped_gva:
 	TEST_ASSERT(false, "No mapping for vm virtual address, "
 		    "gva: 0x%lx", gva);
+	exit(EXIT_FAILURE);
 }
 
 static void kvm_setup_gdt(struct kvm_vm *vm, struct kvm_dtable *dt, int gdt_memslot,
diff --git a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
index 7c2c4d4055a8..63cc9c3f5ab6 100644
--- a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
@@ -87,6 +87,7 @@ int main(int argc, char *argv[])
 	while (1) {
 		rc = _vcpu_run(vm, VCPU_ID);
 
+		TEST_ASSERT(rc == 0, "vcpu_run failed: %d\n", rc);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
 			    "Unexpected exit reason: %u (%s),\n",
 			    run->exit_reason,
diff --git a/tools/testing/selftests/kvm/x86_64/platform_info_test.c b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
index eb3e7a838cb4..40050e44ec0a 100644
--- a/tools/testing/selftests/kvm/x86_64/platform_info_test.c
+++ b/tools/testing/selftests/kvm/x86_64/platform_info_test.c
@@ -81,7 +81,6 @@ static void test_msr_platform_info_disabled(struct kvm_vm *vm)
 int main(int argc, char *argv[])
 {
 	struct kvm_vm *vm;
-	struct kvm_run *state;
 	int rv;
 	uint64_t msr_platform_info;
 
diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
index fb8086964d83..4daf520bada1 100644
--- a/tools/testing/selftests/kvm/x86_64/smm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
@@ -87,7 +87,6 @@ void guest_code(struct vmx_pages *vmx_pages)
 
 int main(int argc, char *argv[])
 {
-	struct vmx_pages *vmx_pages = NULL;
 	vm_vaddr_t vmx_pages_gva = 0;
 
 	struct kvm_regs regs;
@@ -115,7 +114,7 @@ int main(int argc, char *argv[])
 	vcpu_set_msr(vm, VCPU_ID, MSR_IA32_SMBASE, SMRAM_GPA);
 
 	if (kvm_check_cap(KVM_CAP_NESTED_STATE)) {
-		vmx_pages = vcpu_alloc_vmx(vm, &vmx_pages_gva);
+		vcpu_alloc_vmx(vm, &vmx_pages_gva);
 		vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_gva);
 	} else {
 		printf("will skip SMM test with VMX enabled\n");
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c b/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
index 6edec6fd790b..97182b47b10c 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_close_while_nested_test.c
@@ -39,8 +39,6 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 {
 #define L2_GUEST_STACK_SIZE 64
 	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
-	uint32_t control;
-	uintptr_t save_cr3;
 
 	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 	GUEST_ASSERT(load_vmcs(vmx_pages));
@@ -55,7 +53,6 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 
 int main(int argc, char *argv[])
 {
-	struct vmx_pages *vmx_pages;
 	vm_vaddr_t vmx_pages_gva;
 	struct kvm_cpuid_entry2 *entry = kvm_get_supported_cpuid_entry(1);
 
@@ -68,7 +65,7 @@ int main(int argc, char *argv[])
 	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
 
 	/* Allocate VMX pages and shared descriptors (vmx_pages). */
-	vmx_pages = vcpu_alloc_vmx(vm, &vmx_pages_gva);
+	vcpu_alloc_vmx(vm, &vmx_pages_gva);
 	vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_gva);
 
 	for (;;) {
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
index 18fa64db0d7a..6d37a3173956 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c
@@ -121,7 +121,7 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_DONE();
 }
 
-void report(int64_t val)
+static void report(int64_t val)
 {
 	printf("IA32_TSC_ADJUST is %ld (%lld * TSC_ADJUST_VALUE + %lld).\n",
 	       val, val / TSC_ADJUST_VALUE, val % TSC_ADJUST_VALUE);
@@ -129,7 +129,6 @@ void report(int64_t val)
 
 int main(int argc, char *argv[])
 {
-	struct vmx_pages *vmx_pages;
 	vm_vaddr_t vmx_pages_gva;
 	struct kvm_cpuid_entry2 *entry = kvm_get_supported_cpuid_entry(1);
 
@@ -142,7 +141,7 @@ int main(int argc, char *argv[])
 	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
 
 	/* Allocate VMX pages and shared descriptors (vmx_pages). */
-	vmx_pages = vcpu_alloc_vmx(vm, &vmx_pages_gva);
+	vcpu_alloc_vmx(vm, &vmx_pages_gva);
 	vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_gva);
 
 	for (;;) {
-- 
2.21.0

