Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3F35A70B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiH3WWj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiH3WWI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:22:08 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C0381B1C
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:21:04 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id n30-20020a17090a5aa100b001fb0c492d5eso5411613pji.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=AzDgZBgFplUyYkteDiAFd4snp6/vsyrTsM86sz6yvPk=;
        b=oyUkqckUdLsL5ggmZbJj+/O1xqCczSWPMKvRE8ocdVgkeAZFayetIhhOe44TGpaLql
         ReZ149//ZWno+R6jcV3voWkq4A5b+eDmxLN5bzhJhvPYNIFlg9bor3UQmG/QjWaULZTz
         coYkgMTzQol2T7/dgQMPD1VePwLVC/50IgmlElxIveOAXEQtCK9aKN/L5P89G3MOi/LC
         Afa3y0Bdp5ncs6BijVBN+Zt6cVaAqghhmYC4OVXKyk6CKVmjiIsRVsJABLObRS1/OQWY
         w3X5Rt+1SXUmcSRyLW9RezJQkIhnSTSPOVJFitZjCWB4+XG/GY2Q32BsGVMojvcpvTNc
         90jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=AzDgZBgFplUyYkteDiAFd4snp6/vsyrTsM86sz6yvPk=;
        b=1bajW6KDUD/EDutt9XJqNGVrLAJLSNwcfrK6JHRnAFSjKbRYrHokrYWj26uP+/UyIv
         3960fvjiK1ldOq5V9I308TXM6f3CRnkAEiNYAb8kxJUFzCOmUAHOmErKXz9lewZhDvvV
         K5SjcJ5kYrSauNhBkwcZLBHAS/NfK5Rk7j6dSnHZss+KBToig/JrMGoPYdNVcHC9tvWk
         YXqLLdeDOEBRg7B70HpkTktN/Pj66YOyUupnyU4ByY6nAXjZXgbivmpNw8W6XtIea+vf
         jkg3RXzN+BAJuT69dlXw5t3LwUbGRgfiP+SY4XXaLd1vcCpBBcFNzuQElE5SQjA3Rb65
         JH8A==
X-Gm-Message-State: ACgBeo3Aw5E6+6qfDj8R/WH2TuSyLHuvHo6GeYCko7m1KkvYm2s9a2Au
        JzyWCvQGOa+qdnu8qlWHwPnYMQcDB9Xn6mYEI+ZVcsGlGlOVnzQr8w05qgBuzrmUNpboe+vVcx2
        qgP2wdVUBV5pxaIuraD4XDSKqPrTbZUMORldlkdb16b5Nmegjm9bbaYpBKIeCQXLMMk647wM=
X-Google-Smtp-Source: AA6agR4dolB76RWxR4Csigjf13X6+PTxv/agrCvSqBIs9UDI2TG+UKkBY4FJGdwS0vCvT+Rxs05FTlGBIQ==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a05:6a00:e8a:b0:535:cc5c:3d87 with SMTP id
 bo10-20020a056a000e8a00b00535cc5c3d87mr23494953pfb.24.1661898035202; Tue, 30
 Aug 2022 15:20:35 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:20:00 +0000
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
Mime-Version: 1.0
References: <20220830222000.709028-1-sagis@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-18-sagis@google.com>
Subject: [RFC PATCH v2 17/17] KVM: selftest: TDX: Add shared memory test
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

From: Ryan Afranji <afranji@google.com>

Adds a test that sets up shared memory between the host and guest.

Signed-off-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/tdx.h  |  38 +++++-
 .../selftests/kvm/lib/x86_64/tdx_lib.c        |  41 +++++-
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 124 ++++++++++++++++++
 3 files changed, 192 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx.h b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
index 7af2d189043f..be8564f4672d 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx.h
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx.h
@@ -23,10 +23,21 @@
 
 /*
  * Max Page Table Size
- * To map 4GB memory region with 2MB pages, there needs to be 1 page for PML4,
- * 1 Page for PDPT, 4 pages for PD. Reserving 6 pages for PT.
+ * To map 4GB memory regions for each private and shared memory with 2MB pages,
+ * there needs to be 1 page for PML4, 1 Page for PDPT, 8 pages for PD. Reserving
+ * 10 pages for PT.
  */
-#define TDX_GUEST_NR_PT_PAGES (1 + 1 + 4)
+#define TDX_GUEST_NR_PT_PAGES (1 + 1 + 8)
+
+/*
+ * Guest Virtual Address Shared Bit
+ * TDX's shared bit is defined as the highest order bit in the GPA. Since the
+ * highest order bit allowed in the GPA may exceed the GVA's, a 1:1 mapping
+ * cannot be applied for shared memory. This value is a bit within the range
+ * [32 - 38] (0-indexed) that will designate a 4 GB region of GVAs that map the
+ * shared GPAs. This approach does not increase number of PML4 and PDPT pages.
+ */
+#define TDX_GUEST_VIRT_SHARED_BIT 32
 
 /*
  * Predefined GDTR values.
@@ -60,6 +71,7 @@
 #define TDX_VMCALL_INVALID_OPERAND 0x8000000000000000
 
 #define TDX_GET_TD_VM_CALL_INFO 0x10000
+#define TDX_MAP_GPA 0x10001
 #define TDX_REPORT_FATAL_ERROR 0x10003
 #define TDX_INSTRUCTION_CPUID 10
 #define TDX_INSTRUCTION_HLT 12
@@ -101,7 +113,7 @@ struct __packed tdx_gdtr {
 struct page_table {
 	uint64_t  pml4[512];
 	uint64_t  pdpt[512];
-	uint64_t  pd[4][512];
+	uint64_t  pd[8][512];
 };
 
 void add_td_memory(struct kvm_vm *vm, void *source_page,
@@ -411,6 +423,24 @@ static inline uint64_t tdcall_vp_info(uint64_t *rcx, uint64_t *rdx,
 	return regs.rax;
 }
 
+/*
+ * Execute MapGPA instruction.
+ */
+static inline uint64_t tdvmcall_map_gpa(uint64_t address, uint64_t size,
+					uint64_t *data_out)
+{
+	struct kvm_regs regs;
+
+	memset(&regs, 0, sizeof(regs));
+	regs.r11 = TDX_MAP_GPA;
+	regs.r12 = address;
+	regs.r13 = size;
+	regs.rcx = 0x3C00;
+	tdcall(&regs);
+	*data_out = regs.r11;
+	return regs.r10;
+}
+
 /*
  * Reports a 32 bit value from the guest to user space using a TDVM IO call.
  * Data is reported on port TDX_DATA_REPORT_PORT.
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c b/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
index dc9a44ae4064..23893949c3a1 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx_lib.c
@@ -183,29 +183,56 @@ void build_gdtr_table(void *gdtr_target, void *gdt_target)
  * which will be used by the TDX guest when paging is enabled.
  * TODO: use virt_pg_map() functions to dynamically allocate the page tables.
  */
-void build_page_tables(void *pt_target, uint64_t  pml4_base_address)
+void build_page_tables(void *pt_target, uint64_t  pml4_base_address,
+		       uint64_t gpa_shared_bit)
 {
 	uint64_t i;
+	uint64_t shared_pdpt_index;
+	uint64_t gpa_shared_mask;
+	uint64_t *pde;
 	struct page_table *pt;
 
 	pt = malloc(sizeof(struct page_table));
 	TEST_ASSERT(pt != NULL, "Could not allocate memory for page tables!\n");
 	memset((void *) &(pt->pml4[0]), 0, sizeof(pt->pml4));
 	memset((void *) &(pt->pdpt[0]), 0, sizeof(pt->pdpt));
-	for (i = 0; i < 4; i++)
+	for (i = 0; i < 8; i++)
 		memset((void *) &(pt->pd[i][0]), 0, sizeof(pt->pd[i]));
 
+	/* Populate pml4 entry. */
 	pt->pml4[0] = (pml4_base_address + PAGE_SIZE) |
 		      _PAGE_PRESENT | _PAGE_RW;
+
+	/* Populate pdpt entries for private memory region. */
 	for (i = 0; i < 4; i++)
 		pt->pdpt[i] = (pml4_base_address + (i + 2) * PAGE_SIZE) |
-				_PAGE_PRESENT | _PAGE_RW;
+			      _PAGE_PRESENT | _PAGE_RW;
+
+	/* Index used in pdpt #0 to map to pd with guest virt shared bit set. */
+	static_assert(TDX_GUEST_VIRT_SHARED_BIT >= 32 &&
+		      TDX_GUEST_VIRT_SHARED_BIT <= 38,
+		      "Guest virtual shared bit must be in the range [32 - 38].\n");
+	shared_pdpt_index = 1 << (TDX_GUEST_VIRT_SHARED_BIT - 30);
 
-	uint64_t *pde = &(pt->pd[0][0]);
+	/* Populate pdpt entries for shared memory region. */
+	for (i = 0; i < 4; i++)
+		pt->pdpt[shared_pdpt_index + i] = (pml4_base_address + (i + 6) *
+						  PAGE_SIZE) | _PAGE_PRESENT |
+						  _PAGE_RW;
 
-	for (i = 0; i < sizeof(pt->pd) / sizeof(pt->pd[0][0]); i++, pde++)
+	/* Populate pd entries for private memory region. */
+	pde = &(pt->pd[0][0]);
+	for (i = 0; i < (sizeof(pt->pd) / sizeof(pt->pd[0][0])) / 2; i++, pde++)
 		*pde = (i << 21) | _PAGE_PRESENT | _PAGE_RW | _PAGE_PS;
-	memcpy(pt_target, pt, 6 * PAGE_SIZE);
+
+	/* Populate pd entries for shared memory region; set shared bit. */
+	pde = &(pt->pd[4][0]);
+	gpa_shared_mask = BIT_ULL(gpa_shared_bit);
+	for (i = 0; i < (sizeof(pt->pd) / sizeof(pt->pd[0][0])) / 2; i++, pde++)
+		*pde = gpa_shared_mask | (i << 21) | _PAGE_PRESENT | _PAGE_RW |
+		       _PAGE_PS;
+
+	memcpy(pt_target, pt, 10 * PAGE_SIZE);
 }
 
 static void
@@ -318,7 +345,7 @@ void prepare_source_image(struct kvm_vm *vm, void *guest_code,
 	guest_code_base =  gdt_address + (TDX_GUEST_STACK_NR_PAGES *
 					  PAGE_SIZE);
 
-	build_page_tables(pt_address, TDX_GUEST_PT_FIXED_ADDR);
+	build_page_tables(pt_address, TDX_GUEST_PT_FIXED_ADDR, vm->pa_bits - 1);
 	build_gdtr_table(gdtr_address, gdt_address);
 
 	/* reset vector code should end with int3 instructions.
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 8d49099e1ed8..a96abada54b6 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -1515,6 +1515,129 @@ void verify_tdcall_vp_info(void)
 	printf("\t ... PASSED\n");
 }
 
+TDX_GUEST_FUNCTION(guest_shared_mem)
+{
+	uint64_t gpa_shared_mask;
+	uint64_t gva_shared_mask;
+	uint64_t shared_gpa;
+	uint64_t shared_gva;
+	uint64_t gpa_width;
+	uint64_t failed_gpa;
+	uint64_t ret;
+	uint64_t err;
+
+	gva_shared_mask = BIT_ULL(TDX_GUEST_VIRT_SHARED_BIT);
+	shared_gpa = 0x80000000;
+	shared_gva = gva_shared_mask | shared_gpa;
+
+	/* Read highest order physical bit to calculate shared mask. */
+	err = tdcall_vp_info(&gpa_width, 0, 0, 0, 0, 0);
+	if (err)
+		tdvmcall_fatal(err);
+
+	/* Map gpa as shared. */
+	gpa_shared_mask = BIT_ULL(gpa_width - 1);
+	ret = tdvmcall_map_gpa(shared_gpa | gpa_shared_mask, PAGE_SIZE,
+			       &failed_gpa);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	/* Write to shared memory. */
+	*(uint16_t *)shared_gva = 0x1234;
+	tdvmcall_success();
+
+	/* Read from shared memory; report to host. */
+	ret = tdvmcall_io(TDX_TEST_PORT, 2, TDX_IO_WRITE,
+			  (uint64_t *)shared_gva);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	tdvmcall_success();
+}
+
+void verify_shared_mem(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct userspace_mem_region *region;
+	uint16_t guest_read_val;
+	uint64_t shared_gpa;
+	uint64_t shared_hva;
+	uint64_t shared_pages_num;
+	int ctr;
+
+	printf("Verifying shared memory\n");
+
+	/* Create a TD VM with no memory. */
+	vm = vm_create_tdx();
+
+	/* Allocate TD guest memory and initialize the TD. */
+	initialize_td(vm);
+
+	/* Initialize the TD vcpu and copy the test code to the guest memory. */
+	vcpu = vm_vcpu_add_tdx(vm, 0);
+
+	/* Allocate shared memory. */
+	shared_gpa = 0x80000000;
+	shared_pages_num = 1;
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    shared_gpa, 1,
+				    shared_pages_num, 0);
+
+	/* Setup and initialize VM memory. */
+	prepare_source_image(vm, guest_shared_mem,
+			     TDX_FUNCTION_SIZE(guest_shared_mem), 0);
+	finalize_td_memory(vm);
+
+	/* Begin guest execution; guest writes to shared memory. */
+	printf("\t ... Starting guest execution\n");
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+
+	/* Get the host's shared memory address. */
+	shared_hva = 0;
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
+		uint64_t region_guest_addr;
+
+		region_guest_addr = (uint64_t)region->region.guest_phys_addr;
+		if (region_guest_addr == (shared_gpa)) {
+			shared_hva = (uint64_t)region->host_mem;
+			break;
+		}
+	}
+	TEST_ASSERT(shared_hva != 0,
+		    "Guest address not found in guest memory regions\n");
+
+	/* Verify guest write -> host read succeeds. */
+	printf("\t ... Guest wrote 0x1234 to shared memory\n");
+	if (*(uint16_t *)shared_hva != 0x1234) {
+		printf("\t ... FAILED: Host read 0x%x instead of 0x1234\n",
+		       *(uint16_t *)shared_hva);
+	}
+	printf("\t ... Host read 0x%x from shared memory\n",
+	       *(uint16_t *)shared_hva);
+
+	/* Verify host write -> guest read succeeds. */
+	*((uint16_t *)shared_hva) = 0xABCD;
+	printf("\t ... Host wrote 0xabcd to shared memory\n");
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_IO(vcpu, TDX_TEST_PORT, 2, TDX_IO_WRITE);
+	guest_read_val = *(uint16_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	if (guest_read_val != 0xABCD) {
+		printf("\t ... FAILED: Guest read 0x%x instead of 0xABCD\n",
+		       guest_read_val);
+		kvm_vm_free(vm);
+		return;
+	}
+	printf("\t ... Guest read 0x%x from shared memory\n",
+	       guest_read_val);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	if (!is_tdx_enabled()) {
@@ -1537,6 +1660,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_mmio_writes);
 	run_in_new_process(&verify_host_reading_private_mem);
 	run_in_new_process(&verify_tdcall_vp_info);
+	run_in_new_process(&verify_shared_mem);
 
 	return 0;
 }
-- 
2.37.2.789.g6183377224-goog

