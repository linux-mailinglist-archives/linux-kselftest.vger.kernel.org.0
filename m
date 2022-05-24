Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC985332B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 22:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241818AbiEXU5Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 16:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241776AbiEXU5P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 16:57:15 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161363E0C5
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 13:57:12 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y202-20020a6264d3000000b00518297f1410so8060179pfb.6
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 13:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UZI2m7qTvl5zlNGI+2KJiafQShDj8mSYQ8WRvEqZh9M=;
        b=Vf4iMzuUn1lSoBlsmYAd8BUo00yaS/1OjkfovwgO5tg/gP1kzjFcWa0qP8GCXHgfpk
         RS4gBF65EbgKFhpRvV988mB3SI9qhIcyxuHA1B/LXUjFlThtpPtLXA2W7U0oUTG9odXT
         cpeP2vXCH5nEa2Q+RhZUmoejk48refBEZPH78W4hNk9hTE16sylbSzEYQGQGHwnCkba+
         GSIjf78UnbsL66AGrbQhZKdMr1u0xSaitCRW/XXq5++/ZzI3+h6Cbvk6hRMqiJ2Ksdel
         IFGKPc+XQ1CgFzw2Mi7WUMvEqZ5lG7rqfeEjhXddwkFAPTZDphNsMaX4DVRIgYYpQG7y
         MLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UZI2m7qTvl5zlNGI+2KJiafQShDj8mSYQ8WRvEqZh9M=;
        b=cVsV5IMswGCJdPCBhGna/v1GQh5a1BTyWCb9nIyA+g3828gUz5UWZ+0JxUUz+LW3V4
         AXvELBoLW7hQfh3AlFSIgiDZ5ZH62o7uS6/TJjRQcLuauUEfJ7ezDLMSt7UcEhdWHs9j
         henhoAApdyTlS0wa7Iy7A2ulWdWXZXtQlzPta5U7JbUyD6Gjun6BLgOMSwnpB/Qtv0Kz
         wpOskuqPKQDqGrbl/pcSinyjKHW0VTAhX/1vmMUWykRXpNCX3+yYha3qfkLZz5+5GVHY
         kG0IU+LPUyDMpUbXSMVts4h285UDxZWN3zq3SToi4cuNWToNcSmK2olwJboQpYNbZr3K
         GEZQ==
X-Gm-Message-State: AOAM531Mo7N+Fq3M1jiaZEBzoOl0xYu6+CfOkBdh3KrJt1nNLiPlvyf7
        I6w6m6CQuYkHzEzGQdxNKpn1FicX0VVGcr0d
X-Google-Smtp-Source: ABdhPJxqEIhonr5Gge0Q/RWVIEK4RPDXj1Tkm22fsDoDnlbSYegtlFIdROuV1/6HU0q4QOmZ6jA/6DEwvajGTTXR
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:902:bf09:b0:153:99a6:55b8 with SMTP
 id bi9-20020a170902bf0900b0015399a655b8mr28793638plb.142.1653425831481; Tue,
 24 May 2022 13:57:11 -0700 (PDT)
Date:   Tue, 24 May 2022 20:56:46 +0000
In-Reply-To: <20220524205646.1798325-1-vannapurve@google.com>
Message-Id: <20220524205646.1798325-4-vannapurve@google.com>
Mime-Version: 1.0
References: <20220524205646.1798325-1-vannapurve@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC V1 PATCH 3/3] selftests: kvm: sev: Port UPM selftests onto
 SEV/SEV-ES VMs
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Port UPM tests from rfc v2 series posted here:
https://lore.kernel.org/lkml/20220511000811.384766-1-vannapurve@google.com/T/
to execute with SEV/SEV-ES VMs.

Major changes from original series:
1) SEV/SEV-ES VM creation logic is hooked into setup_and_execute_test.
2) Shared ucall is used for communication between vmm and the guest.
3) C bit toggle logic is added at places where memory conversion is
   needed.
4) memory size is passed via vcpu registers instead of MMIO.

Example invocation on AMD SEV/SEV-ES capable machine:
./sev_priv_memfd_test -> Runs UPM selftests with SEV VMs
./sev_priv_memfd_test -e -> Runs UPM selftests with SEV-ES VMs

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |    1 +
 tools/testing/selftests/kvm/Makefile          |    1 +
 .../kvm/x86_64/sev_priv_memfd_test.c          | 1511 +++++++++++++++++
 3 files changed, 1513 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_priv_memfd_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 8d4fda1ace8f..3cd4a6678663 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -56,6 +56,7 @@
 /x86_64/xss_msr_test
 /x86_64/vmx_pmu_msrs_test
 /x86_64/sev_all_boot_test
+/x86_64/sev_priv_memfd_test
 /access_tracking_perf_test
 /demand_paging_test
 /dirty_log_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 6d269c3159bf..1840f6a4c6f5 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -94,6 +94,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/xen_shinfo_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_vmcall_test
 TEST_GEN_PROGS_x86_64 += x86_64/sev_migrate_tests
 TEST_GEN_PROGS_x86_64 += x86_64/sev_all_boot_test
+TEST_GEN_PROGS_x86_64 += x86_64/sev_priv_memfd_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
 TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/x86_64/sev_priv_memfd_test.c b/tools/testing/selftests/kvm/x86_64/sev_priv_memfd_test.c
new file mode 100644
index 000000000000..9255a6a3ce41
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/sev_priv_memfd_test.c
@@ -0,0 +1,1511 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/kvm_para.h>
+#include <linux/memfd.h>
+
+#include <test_util.h>
+#include <kvm_util.h>
+#include <processor.h>
+
+#include <linux/psp-sev.h>
+#include <sev.h>
+#include <sev_exitlib.h>
+
+#define BYTE_MASK 0xFF
+
+// flags for mmap
+#define MAP_HUGE_2MB    (21 << MAP_HUGE_SHIFT)
+#define MAP_HUGE_1GB    (30 << MAP_HUGE_SHIFT)
+
+// page sizes
+#define PAGE_SIZE_4KB ((size_t)0x1000)
+#define PAGE_SIZE_2MB (PAGE_SIZE_4KB * (size_t)512)
+#define PAGE_SIZE_1GB ((PAGE_SIZE_4KB * 256) * 1024)
+
+#define TEST_MEM_GPA		0xb0000000
+#define TEST_MEM_DATA_PAT1	0x6666666666666666
+#define TEST_MEM_DATA_PAT2	0x9999999999999999
+#define TEST_MEM_DATA_PAT3	0x3333333333333333
+#define TEST_MEM_DATA_PAT4	0xaaaaaaaaaaaaaaaa
+
+#define TOTAL_PAGES		(1024)
+#define GUEST_PGT_MIN_VADDR	0x10000
+
+enum mem_op {
+	SET_PAT,
+	VERIFY_PAT
+};
+
+#define TEST_MEM_SLOT		10
+
+#define VCPU_ID			0
+
+#define VM_STAGE_PROCESSED(x)	pr_info("Processed stage %s\n", #x)
+
+// global used for storing the current mem allocation size
+// for the running test
+static size_t test_mem_size;
+
+typedef bool (*vm_stage_handler_fn)(struct kvm_vm *, struct ucall *, void *,
+				uint64_t);
+
+static uint64_t g_ghcb_gpa;
+static void *g_ghcb_gva;
+
+/* guest code function will accept 4 arguments:
+ * - pointer to shared ucall struct
+ * - encryption bit shift
+ * - pointer to guest_pgt_info struct
+ * - size of the test memory buffer
+ * - guest physical address of ghcb page
+ * - guest virtual address of ghcb page
+ */
+typedef void (*guest_code_fn)(struct ucall *, uint8_t,
+	struct guest_pgt_info *, uint64_t, uint64_t, void *);
+
+struct test_run_helper {
+	char *test_desc;
+	vm_stage_handler_fn vmst_handler;
+	guest_code_fn guest_fn;
+	void *shared_mem;
+	int priv_memfd;
+	bool disallow_boot_shared_access;
+	bool toggle_shared_mem_state;
+};
+
+enum page_size {
+	PAGE_4KB,
+	PAGE_2MB,
+	PAGE_1GB
+};
+
+struct page_combo {
+	enum page_size shared;
+	enum page_size private;
+};
+
+static char *page_size_to_str(enum page_size x)
+{
+	switch (x) {
+	case PAGE_4KB:
+		return "PAGE_4KB";
+	case PAGE_2MB:
+		return "PAGE_2MB";
+	case PAGE_1GB:
+		return "PAGE_1GB";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static uint64_t test_mem_end(const uint64_t start, const uint64_t size)
+{
+	return start + size;
+}
+
+/* Guest code in selftests is loaded to guest memory using kvm_vm_elf_load
+ * which doesn't handle global offset table updates. Calling standard libc
+ * functions would normally result in referring to the global offset table.
+ * Adding O1 here seems to prohibit compiler from replacing the memory
+ * operations with standard libc functions such as memset.
+ */
+static bool __attribute__((optimize("O1"))) do_mem_op(enum mem_op op, void *mem,
+	uint64_t pat, uint32_t size)
+{
+	uint64_t *buf = (uint64_t *)mem;
+	uint32_t chunk_size = sizeof(pat);
+	uint64_t mem_addr = (uint64_t)mem;
+
+	if (((mem_addr % chunk_size) != 0) || ((size % chunk_size) != 0))
+		return false;
+
+	for (uint32_t i = 0; i < (size / chunk_size); i++) {
+		if (op == SET_PAT)
+			buf[i] = pat;
+		if (op == VERIFY_PAT) {
+			if (buf[i] != pat)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static inline uint64_t guest_hypercall(uint64_t nr, uint64_t a0, uint64_t a1,
+	uint64_t a2, uint64_t a3)
+{
+	uint64_t r;
+
+	asm volatile("vmmcall"
+		: "=a"(r)
+		: "a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
+	return r;
+}
+
+static void guest_set_clr_pte_bit(struct ucall *uc,
+	struct guest_pgt_info *gpgt_info, uint64_t vaddr_start,
+	uint64_t mem_size, bool set, uint32_t bit)
+{
+	uint64_t vaddr = vaddr_start;
+	uint32_t guest_page_size = gpgt_info->page_size;
+	uint32_t num_pages;
+
+	GUEST_SHARED_ASSERT(uc, !(mem_size % guest_page_size));
+	num_pages = mem_size / guest_page_size;
+	for (uint32_t i = 0; i < num_pages; i++) {
+		uint64_t *pte = guest_code_get_pte(gpgt_info, vaddr);
+
+		GUEST_SHARED_ASSERT(uc, pte);
+		if (set)
+			*pte |= (1ULL << bit);
+		else
+			*pte &= ~(1ULL << bit);
+		asm volatile("invlpg (%0)" :: "r"(vaddr) : "memory");
+		vaddr += guest_page_size;
+	}
+}
+
+static void guest_verify_sev_vm_boot(struct ucall *uc, bool sev_es)
+{
+	uint32_t eax, ebx, ecx, edx;
+	uint64_t sev_status;
+
+	/* Check CPUID values via GHCB MSR protocol. */
+	eax = 0x8000001f;
+	ecx = 0;
+	cpuid(&eax, &ebx, &ecx, &edx);
+
+	/* Check SEV bit. */
+	GUEST_SHARED_ASSERT(uc, eax & (1 << 1));
+
+	/* Check SEV-ES bit. */
+	if (sev_es)
+		GUEST_SHARED_ASSERT(uc, eax & (1 << 3));
+
+	/* Check SEV and SEV-ES enabled bits (bits 0 and 1, respectively). */
+	sev_status = rdmsr(MSR_AMD64_SEV);
+	GUEST_SHARED_ASSERT(uc, (sev_status & 0x1) == 1);
+
+	if (sev_es)
+		GUEST_SHARED_ASSERT(uc, (sev_status & 0x2) == 2);
+}
+
+/* Test to verify guest private accesses on private memory with following steps:
+ * 1) Upon entry, guest signals VMM that it has started.
+ * 2) VMM populates the shared memory with known pattern and continues guest
+ *    execution.
+ * 3) Guest writes a different pattern on the private memory and signals VMM
+ *      that it has updated private memory.
+ * 4) VMM verifies its shared memory contents to be same as the data populated
+ *      in step 2 and continues guest execution.
+ * 5) Guest verifies its private memory contents to be same as the data
+ *      populated in step 3 and marks the end of the guest execution.
+ */
+#define PMPAT_ID				0
+#define PMPAT_DESC				"PrivateMemoryPrivateAccessTest"
+
+/* Guest code execution stages for private mem access test */
+#define PMPAT_GUEST_STARTED			0ULL
+#define PMPAT_GUEST_PRIV_MEM_UPDATED		1ULL
+
+static bool pmpat_handle_vm_stage(struct kvm_vm *vm, struct ucall *uc,
+	void *test_info, uint64_t stage)
+{
+	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
+
+	switch (stage) {
+	case PMPAT_GUEST_STARTED: {
+		/* Initialize the contents of shared memory */
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, test_mem_size),
+			"Shared memory update failure");
+		VM_STAGE_PROCESSED(PMPAT_GUEST_STARTED);
+		break;
+	}
+	case PMPAT_GUEST_PRIV_MEM_UPDATED: {
+		/* verify host updated data is still intact */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, test_mem_size),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(PMPAT_GUEST_PRIV_MEM_UPDATED);
+		break;
+	}
+	default:
+		TEST_FAIL("Unhandled VM stage %ld\n", stage);
+		return false;
+	}
+
+	return true;
+}
+
+static void pmpat_guest_code(struct ucall *uc, uint8_t enc_bit_shift,
+	struct guest_pgt_info *gpgt_info, uint64_t mem_size, uint64_t ghcb_gpa,
+	void *ghcb_gva)
+{
+	void *priv_mem = (void *)TEST_MEM_GPA;
+	int ret;
+
+	g_ghcb_gva = ghcb_gva;
+	g_ghcb_gpa = ghcb_gpa;
+	GUEST_SHARED_SYNC(uc, PMPAT_GUEST_STARTED);
+	guest_verify_sev_vm_boot(uc, g_ghcb_gva != NULL);
+
+	guest_set_clr_pte_bit(uc, gpgt_info, TEST_MEM_GPA, mem_size, true,
+		enc_bit_shift);
+	/* Mark the GPA range to be treated as always accessed privately */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT, KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+
+	GUEST_SHARED_ASSERT(uc, do_mem_op(SET_PAT, priv_mem, TEST_MEM_DATA_PAT2,
+			mem_size));
+	GUEST_SHARED_SYNC(uc, PMPAT_GUEST_PRIV_MEM_UPDATED);
+
+	GUEST_SHARED_ASSERT(uc, do_mem_op(VERIFY_PAT, priv_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+
+	GUEST_SHARED_DONE(uc);
+}
+
+/* Test to verify guest shared accesses on private memory with following steps:
+ * 1) Upon entry, guest signals VMM that it has started.
+ * 2) VMM populates the shared memory with known pattern and continues guest
+ *    execution.
+ * 3) Guest reads private gpa range in a shared fashion and verifies that it
+ *    reads what VMM has written in step2.
+ * 3) Guest writes a different pattern on the shared memory and signals VMM
+ *      that it has updated the shared memory.
+ * 4) VMM verifies shared memory contents to be same as the data populated
+ *      in step 3 and continues guest execution.
+ */
+#define PMSAT_ID				1
+#define PMSAT_DESC				"PrivateMemorySharedAccessTest"
+
+/* Guest code execution stages for private mem access test */
+#define PMSAT_GUEST_STARTED			0ULL
+#define PMSAT_GUEST_TEST_MEM_UPDATED		1ULL
+
+static bool pmsat_handle_vm_stage(struct kvm_vm *vm, struct ucall *uc,
+	void *test_info, uint64_t stage)
+{
+	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
+
+	switch (stage) {
+	case PMSAT_GUEST_STARTED: {
+		/* Initialize the contents of shared memory */
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, test_mem_size),
+			"Shared memory update failed");
+		VM_STAGE_PROCESSED(PMSAT_GUEST_STARTED);
+		break;
+	}
+	case PMSAT_GUEST_TEST_MEM_UPDATED: {
+		/* verify data to be same as what guest wrote */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, test_mem_size),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(PMSAT_GUEST_TEST_MEM_UPDATED);
+		break;
+	}
+	default:
+		TEST_FAIL("Unhandled VM stage %ld\n", stage);
+		return false;
+	}
+
+	return true;
+}
+
+static void pmsat_guest_code(struct ucall *uc, uint8_t enc_bit_shift,
+	struct guest_pgt_info *gpgt_info, uint64_t mem_size, uint64_t ghcb_gpa,
+	void *ghcb_gva)
+{
+	void *shared_mem = (void *)TEST_MEM_GPA;
+
+	g_ghcb_gva = ghcb_gva;
+	g_ghcb_gpa = ghcb_gpa;
+	GUEST_SHARED_SYNC(uc, PMSAT_GUEST_STARTED);
+	guest_verify_sev_vm_boot(uc, g_ghcb_gva != NULL);
+	GUEST_SHARED_ASSERT(uc, do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, mem_size));
+
+	GUEST_SHARED_ASSERT(uc, do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+	GUEST_SHARED_SYNC(uc, PMSAT_GUEST_TEST_MEM_UPDATED);
+
+	GUEST_SHARED_DONE(uc);
+}
+
+/* Test to verify guest shared accesses on shared memory with following steps:
+ * 1) Upon entry, guest signals VMM that it has started.
+ * 2) VMM deallocates the backing private memory and populates the shared memory
+ *    with known pattern and continues guest execution.
+ * 3) Guest reads shared gpa range in a shared fashion and verifies that it
+ *    reads what VMM has written in step2.
+ * 3) Guest writes a different pattern on the shared memory and signals VMM
+ *      that it has updated the shared memory.
+ * 4) VMM verifies shared memory contents to be same as the data populated
+ *      in step 3 and continues guest execution.
+ */
+#define SMSAT_ID				2
+#define SMSAT_DESC				"SharedMemorySharedAccessTest"
+
+#define SMSAT_GUEST_STARTED			0ULL
+#define SMSAT_GUEST_TEST_MEM_UPDATED		1ULL
+
+static bool smsat_handle_vm_stage(struct kvm_vm *vm, struct ucall *uc,
+	void *test_info, uint64_t stage)
+{
+	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
+	int priv_memfd = ((struct test_run_helper *)test_info)->priv_memfd;
+
+	switch (stage) {
+	case SMSAT_GUEST_STARTED: {
+		/* Remove the backing private memory storage */
+		int ret = fallocate(priv_memfd,
+				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				0, test_mem_size);
+		TEST_ASSERT(ret != -1, "fallocate failed in smsat handling");
+		/* Initialize the contents of shared memory */
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, test_mem_size),
+			"Shared memory updated failed");
+		VM_STAGE_PROCESSED(SMSAT_GUEST_STARTED);
+		break;
+	}
+	case SMSAT_GUEST_TEST_MEM_UPDATED: {
+		/* verify data to be same as what guest wrote */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, test_mem_size),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(SMSAT_GUEST_TEST_MEM_UPDATED);
+		break;
+	}
+	default:
+		TEST_FAIL("Unhandled VM stage %ld\n", stage);
+		return false;
+	}
+
+	return true;
+}
+
+static void smsat_guest_code(struct ucall *uc, uint8_t enc_bit_shift,
+	struct guest_pgt_info *gpgt_info, uint64_t mem_size, uint64_t ghcb_gpa,
+	void *ghcb_gva)
+{
+	void *shared_mem = (void *)TEST_MEM_GPA;
+
+	g_ghcb_gva = ghcb_gva;
+	g_ghcb_gpa = ghcb_gpa;
+	GUEST_SHARED_SYNC(uc, SMSAT_GUEST_STARTED);
+	guest_verify_sev_vm_boot(uc, g_ghcb_gva != NULL);
+	GUEST_SHARED_ASSERT(uc, do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, mem_size));
+
+	GUEST_SHARED_ASSERT(uc, do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+	GUEST_SHARED_SYNC(uc, SMSAT_GUEST_TEST_MEM_UPDATED);
+
+	GUEST_SHARED_DONE(uc);
+}
+
+/* Test to verify guest private accesses on shared memory with following steps:
+ * 1) Upon entry, guest signals VMM that it has started.
+ * 2) VMM deallocates the backing private memory and populates the shared memory
+ *    with known pattern and continues guest execution.
+ * 3) Guest writes gpa range via private access and signals VMM.
+ * 4) VMM verifies shared memory contents to be same as the data populated
+ *    in step 2 and continues guest execution.
+ * 5) Guest reads gpa range via private access and verifies that the contents
+ *    are same as written in step 3.
+ */
+#define SMPAT_ID				3
+#define SMPAT_DESC				"SharedMemoryPrivateAccessTest"
+
+#define SMPAT_GUEST_STARTED			0ULL
+#define SMPAT_GUEST_TEST_MEM_UPDATED		1ULL
+
+static bool smpat_handle_vm_stage(struct kvm_vm *vm, struct ucall *uc,
+	void *test_info, uint64_t stage)
+{
+	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
+	int priv_memfd = ((struct test_run_helper *)test_info)->priv_memfd;
+
+	switch (stage) {
+	case SMPAT_GUEST_STARTED: {
+		/* Remove the backing private memory storage */
+		int ret = fallocate(priv_memfd,
+				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				0, test_mem_size);
+		TEST_ASSERT(ret != -1, "fallocate failed in smpat handling");
+		/* Initialize the contents of shared memory */
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem, TEST_MEM_DATA_PAT1,
+			test_mem_size), "Shared memory updated failed");
+		VM_STAGE_PROCESSED(SMPAT_GUEST_STARTED);
+		break;
+	}
+	case SMPAT_GUEST_TEST_MEM_UPDATED: {
+		/* verify data to be same as what vmm wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, test_mem_size),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(SMPAT_GUEST_TEST_MEM_UPDATED);
+		break;
+	}
+	default:
+		TEST_FAIL("Unhandled VM stage %ld\n", stage);
+		return false;
+	}
+
+	return true;
+}
+
+static void smpat_guest_code(struct ucall *uc, uint8_t enc_bit_shift,
+	struct guest_pgt_info *gpgt_info, uint64_t mem_size, uint64_t ghcb_gpa,
+	void *ghcb_gva)
+{
+	void *shared_mem = (void *)TEST_MEM_GPA;
+	int ret;
+
+	g_ghcb_gva = ghcb_gva;
+	g_ghcb_gpa = ghcb_gpa;
+	GUEST_SHARED_SYNC(uc, SMPAT_GUEST_STARTED);
+	guest_verify_sev_vm_boot(uc, g_ghcb_gva != NULL);
+
+	guest_set_clr_pte_bit(uc, gpgt_info, TEST_MEM_GPA,
+		mem_size, true, enc_bit_shift);
+	/* Mark the GPA range to be treated as always accessed privately */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT, KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+
+	GUEST_SHARED_ASSERT(uc, do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+	GUEST_SHARED_SYNC(uc, SMPAT_GUEST_TEST_MEM_UPDATED);
+	GUEST_SHARED_ASSERT(uc, do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+
+	GUEST_SHARED_DONE(uc);
+}
+
+/* Test to verify guest shared and private accesses on memory with following
+ * steps:
+ * 1) Upon entry, guest signals VMM that it has started.
+ * 2) VMM populates the shared memory with known pattern and continues guest
+ *    execution.
+ * 3) Guest writes shared gpa range in a private fashion and signals VMM
+ * 4) VMM verifies that shared memory still contains the pattern written in
+ *    step 2 and continues guest execution.
+ * 5) Guest verifies private memory contents to be same as the data populated
+ *    in step 3 and signals VMM.
+ * 6) VMM removes the private memory backing which should also clear out the
+ *    second stage mappings for the VM
+ * 6) Guest does shared write access on shared memory and signals vmm
+ * 7) VMM reads the shared memory and verifies that the data is same as what
+ *    guest wrote in step 6 and continues guest execution.
+ * 8) Guest reads the private memory and verifies that the data is same as
+ *    written in step 6.
+ */
+#define PSAT_ID			4
+#define PSAT_DESC		"PrivateSharedAccessTest"
+
+#define PSAT_GUEST_STARTED			0ULL
+#define PSAT_GUEST_PRIVATE_MEM_UPDATED		1ULL
+#define PSAT_GUEST_PRIVATE_MEM_VERIFIED		2ULL
+#define PSAT_GUEST_SHARED_MEM_UPDATED		3ULL
+
+static bool psat_handle_vm_stage(struct kvm_vm *vm, struct ucall *uc,
+	void *test_info, uint64_t stage)
+{
+	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
+	int priv_memfd = ((struct test_run_helper *)test_info)->priv_memfd;
+
+	switch (stage) {
+	case PSAT_GUEST_STARTED: {
+		/* Initialize the contents of shared memory */
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, test_mem_size),
+			"Shared memory update failed");
+		VM_STAGE_PROCESSED(PSAT_GUEST_STARTED);
+		break;
+	}
+	case PSAT_GUEST_PRIVATE_MEM_UPDATED: {
+		/* verify data to be same as what vmm wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, test_mem_size),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(PSAT_GUEST_PRIVATE_MEM_UPDATED);
+		break;
+	}
+	case PSAT_GUEST_PRIVATE_MEM_VERIFIED: {
+		/* Remove the backing private memory storage so that
+		 * subsequent accesses from guest cause a second stage
+		 * page fault
+		 */
+		int ret = fallocate(priv_memfd,
+				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				0, test_mem_size);
+		TEST_ASSERT(ret != -1,
+			"fallocate failed in smpat handling");
+		VM_STAGE_PROCESSED(PSAT_GUEST_PRIVATE_MEM_VERIFIED);
+		break;
+	}
+	case PSAT_GUEST_SHARED_MEM_UPDATED: {
+		/* verify data to be same as what guest wrote */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, test_mem_size),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(PSAT_GUEST_SHARED_MEM_UPDATED);
+		break;
+	}
+	default:
+		TEST_FAIL("Unhandled VM stage %ld\n", stage);
+		return false;
+	}
+
+	return true;
+}
+
+static void psat_guest_code(struct ucall *uc, uint8_t enc_bit_shift,
+	struct guest_pgt_info *gpgt_info, uint64_t mem_size, uint64_t ghcb_gpa,
+	void *ghcb_gva)
+{
+	void *shared_mem = (void *)TEST_MEM_GPA;
+	int ret;
+
+	g_ghcb_gva = ghcb_gva;
+	g_ghcb_gpa = ghcb_gpa;
+	GUEST_SHARED_SYNC(uc, PSAT_GUEST_STARTED);
+	guest_verify_sev_vm_boot(uc, g_ghcb_gva != NULL);
+
+	guest_set_clr_pte_bit(uc, gpgt_info, TEST_MEM_GPA, mem_size, true,
+		enc_bit_shift);
+	/* Mark the GPA range to be treated as always accessed privately */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT, KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+
+	GUEST_SHARED_ASSERT(uc, do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+	GUEST_SHARED_SYNC(uc, PSAT_GUEST_PRIVATE_MEM_UPDATED);
+	GUEST_SHARED_ASSERT(uc, do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+
+	GUEST_SHARED_SYNC(uc, PSAT_GUEST_PRIVATE_MEM_VERIFIED);
+
+	guest_set_clr_pte_bit(uc, gpgt_info, TEST_MEM_GPA, mem_size, false,
+		enc_bit_shift);
+	/* Mark no GPA range to be treated as accessed privately */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, 0, 0,
+		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+	GUEST_SHARED_ASSERT(uc, do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+	GUEST_SHARED_SYNC(uc, PSAT_GUEST_SHARED_MEM_UPDATED);
+	GUEST_SHARED_ASSERT(uc, do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+
+	GUEST_SHARED_DONE(uc);
+}
+
+/* Test to verify guest shared and private accesses on memory with following
+ * steps:
+ * 1) Upon entry, guest signals VMM that it has started.
+ * 2) VMM removes the private memory backing and populates the shared memory
+ *    with known pattern and continues guest execution.
+ * 3) Guest reads shared gpa range in a shared fashion and verifies that it
+ *    reads what VMM has written in step2.
+ * 4) Guest writes a different pattern on the shared memory and signals VMM
+ *      that it has updated the shared memory.
+ * 5) VMM verifies shared memory contents to be same as the data populated
+ *      in step 4 and installs private memory backing again to allow guest
+ *      to do private access and invalidate second stage mappings.
+ * 6) Guest does private write access on shared memory and signals vmm
+ * 7) VMM reads the shared memory and verified that the data is still same
+ *    as in step 4 and continues guest execution.
+ * 8) Guest reads the private memory and verifies that the data is same as
+ *    written in step 6.
+ */
+#define SPAT_ID					5
+#define SPAT_DESC				"SharedPrivateAccessTest"
+
+#define SPAT_GUEST_STARTED			0ULL
+#define SPAT_GUEST_SHARED_MEM_UPDATED		1ULL
+#define SPAT_GUEST_PRIVATE_MEM_UPDATED		2ULL
+
+static bool spat_handle_vm_stage(struct kvm_vm *vm, struct ucall *uc,
+	void *test_info, uint64_t stage)
+{
+	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
+	int priv_memfd = ((struct test_run_helper *)test_info)->priv_memfd;
+	int ret;
+
+	switch (stage) {
+	case SPAT_GUEST_STARTED: {
+		/* Remove the backing private memory storage so that
+		 * subsequent accesses from guest cause a second stage
+		 * page fault
+		 */
+		ret = fallocate(priv_memfd,
+				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				0, test_mem_size);
+		TEST_ASSERT(ret != -1,
+			"fallocate failed in spat handling");
+
+		/* Initialize the contents of shared memory */
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, test_mem_size),
+			"Shared memory updated failed");
+		VM_STAGE_PROCESSED(SPAT_GUEST_STARTED);
+		break;
+	}
+	case SPAT_GUEST_SHARED_MEM_UPDATED: {
+		/* verify data to be same as what guest wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, test_mem_size),
+			"Shared memory view mismatch");
+		/* Allocate memory for private backing store */
+		ret = fallocate(priv_memfd, 0, 0, test_mem_size);
+		TEST_ASSERT(ret != -1, "fallocate failed in spat handling");
+		VM_STAGE_PROCESSED(SPAT_GUEST_SHARED_MEM_UPDATED);
+		break;
+	}
+	case SPAT_GUEST_PRIVATE_MEM_UPDATED: {
+		/* verify data to be same as what guest wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, test_mem_size),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(SPAT_GUEST_PRIVATE_MEM_UPDATED);
+		break;
+	}
+	default:
+		TEST_FAIL("Unhandled VM stage %ld\n", stage);
+		return false;
+	}
+
+	return true;
+}
+
+static void spat_guest_code(struct ucall *uc, uint8_t enc_bit_shift,
+	struct guest_pgt_info *gpgt_info, uint64_t mem_size, uint64_t ghcb_gpa,
+	void *ghcb_gva)
+{
+	void *shared_mem = (void *)TEST_MEM_GPA;
+	int ret;
+
+	g_ghcb_gva = ghcb_gva;
+	g_ghcb_gpa = ghcb_gpa;
+	GUEST_SHARED_SYNC(uc, SPAT_GUEST_STARTED);
+	guest_verify_sev_vm_boot(uc, g_ghcb_gva != NULL);
+	GUEST_SHARED_ASSERT(uc, do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, mem_size));
+	GUEST_SHARED_ASSERT(uc, do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+
+	GUEST_SHARED_SYNC(uc, SPAT_GUEST_SHARED_MEM_UPDATED);
+
+	guest_set_clr_pte_bit(uc, gpgt_info, TEST_MEM_GPA, mem_size, true,
+		enc_bit_shift);
+	/* Mark the GPA range to be treated as always accessed privately */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT, KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+
+	GUEST_SHARED_ASSERT(uc, do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, mem_size));
+	GUEST_SHARED_SYNC(uc, PSAT_GUEST_PRIVATE_MEM_UPDATED);
+	GUEST_SHARED_ASSERT(uc, do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, mem_size));
+	GUEST_SHARED_DONE(uc);
+}
+
+/* Test to verify guest private, shared, private accesses on memory with
+ * following steps:
+ * 1) Upon entry, guest signals VMM that it has started.
+ * 2) VMM initializes the shared memory with known pattern and continues guest
+ *    execution
+ * 3) Guest writes the private memory privately via a known pattern and
+ *    signals VMM
+ * 4) VMM reads the shared memory and verifies that it's same as whats written
+ *    in step 2 and continues guest execution
+ * 5) Guest reads the private memory privately and verifies that the contents
+ *    are same as written in step 3.
+ * 6) Guest invokes KVM_HC_MAP_GPA_RANGE to map the hpa range as shared
+ *    and marks the range to be accessed via shared access.
+ * 7) Guest does a shared access to shared memory and verifies that the
+ *    contents are same as written in step 2.
+ * 8) Guest writes known pattern to test memory and signals VMM.
+ * 9) VMM verifies the memory contents to be same as written by guest in step
+ *    8
+ * 10) Guest invokes KVM_HC_MAP_GPA_RANGE to map the hpa range as private
+ *    and marks the range to be accessed via private access.
+ * 11) Guest writes a known pattern to the test memory and signals VMM.
+ * 12) VMM verifies the memory contents to be same as written by guest in step
+ *     8 and continues guest execution.
+ * 13) Guest verififes the memory pattern to be same as written in step 11.
+ */
+#define PSPAHCT_ID		6
+#define PSPAHCT_DESC		"PrivateSharedPrivateAccessHyperCallTest"
+
+#define PSPAHCT_GUEST_STARTED				0ULL
+#define PSPAHCT_GUEST_PRIVATE_MEM_UPDATED		1ULL
+#define PSPAHCT_GUEST_SHARED_MEM_UPDATED		2ULL
+#define PSPAHCT_GUEST_PRIVATE_MEM_UPDATED2		3ULL
+
+static bool pspahct_handle_vm_stage(struct kvm_vm *vm, struct ucall *uc,
+	void *test_info, uint64_t stage)
+{
+	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
+
+	switch (stage) {
+	case PSPAHCT_GUEST_STARTED: {
+		/* Initialize the contents of shared memory */
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, test_mem_size),
+			"Shared memory update failed");
+		VM_STAGE_PROCESSED(PSPAHCT_GUEST_STARTED);
+		break;
+	}
+	case PSPAHCT_GUEST_PRIVATE_MEM_UPDATED: {
+		/* verify data to be same as what guest wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, test_mem_size),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(PSPAHCT_GUEST_PRIVATE_MEM_UPDATED);
+		break;
+	}
+	case PSPAHCT_GUEST_SHARED_MEM_UPDATED: {
+		/* verify data to be same as what guest wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, test_mem_size),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(PSPAHCT_GUEST_SHARED_MEM_UPDATED);
+		break;
+	}
+	case PSPAHCT_GUEST_PRIVATE_MEM_UPDATED2: {
+		/* verify data to be same as what guest wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, test_mem_size),
+			"Shared memory view mismatch");
+		VM_STAGE_PROCESSED(PSPAHCT_GUEST_PRIVATE_MEM_UPDATED2);
+		break;
+	}
+	default:
+		TEST_FAIL("Unhandled VM stage %ld\n", stage);
+		return false;
+	}
+
+	return true;
+}
+
+static void pspahct_guest_code(struct ucall *uc, uint8_t enc_bit_shift,
+	struct guest_pgt_info *gpgt_info, uint64_t mem_size, uint64_t ghcb_gpa,
+	void *ghcb_gva)
+{
+	void *test_mem = (void *)TEST_MEM_GPA;
+	int ret;
+
+	g_ghcb_gva = ghcb_gva;
+	g_ghcb_gpa = ghcb_gpa;
+	GUEST_SHARED_SYNC(uc, PSPAHCT_GUEST_STARTED);
+	guest_verify_sev_vm_boot(uc, g_ghcb_gva != NULL);
+
+	guest_set_clr_pte_bit(uc, gpgt_info, TEST_MEM_GPA, mem_size, true,
+		enc_bit_shift);
+	/* Mark the GPA range to be treated as always accessed privately */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT, KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+	GUEST_SHARED_ASSERT(uc, do_mem_op(SET_PAT, test_mem, TEST_MEM_DATA_PAT2,
+		mem_size));
+
+	GUEST_SHARED_SYNC(uc, PSPAHCT_GUEST_PRIVATE_MEM_UPDATED);
+	GUEST_SHARED_ASSERT(uc, do_mem_op(VERIFY_PAT, test_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+
+	/* Map the GPA range to be treated as shared */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT,
+		KVM_MAP_GPA_RANGE_DECRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+
+	guest_set_clr_pte_bit(uc, gpgt_info, TEST_MEM_GPA, mem_size, false,
+		enc_bit_shift);
+	/* Mark the GPA range to be treated as always accessed via shared
+	 * access
+	 */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, 0, 0,
+		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+
+	GUEST_SHARED_ASSERT(uc, do_mem_op(VERIFY_PAT, test_mem,
+			TEST_MEM_DATA_PAT1, mem_size));
+	GUEST_SHARED_ASSERT(uc, do_mem_op(SET_PAT, test_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+	GUEST_SHARED_SYNC(uc, PSPAHCT_GUEST_SHARED_MEM_UPDATED);
+
+	GUEST_SHARED_ASSERT(uc, do_mem_op(VERIFY_PAT, test_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+
+	guest_set_clr_pte_bit(uc, gpgt_info, TEST_MEM_GPA, mem_size, true,
+		enc_bit_shift);
+	/* Map the GPA range to be treated as private */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT,
+		KVM_MAP_GPA_RANGE_ENCRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+
+	/* Mark the GPA range to be treated as always accessed via private
+	 * access
+	 */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT, KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+
+	GUEST_SHARED_ASSERT(uc, do_mem_op(SET_PAT, test_mem,
+			TEST_MEM_DATA_PAT1, mem_size));
+	GUEST_SHARED_SYNC(uc, PSPAHCT_GUEST_PRIVATE_MEM_UPDATED2);
+	GUEST_SHARED_ASSERT(uc, do_mem_op(VERIFY_PAT, test_mem,
+			TEST_MEM_DATA_PAT1, mem_size));
+	GUEST_SHARED_DONE(uc);
+}
+
+/* Test to verify guest accesses without double allocation:
+ * Guest starts with shared memory access disallowed by default.
+ * 1) Guest writes the private memory privately via a known pattern
+ * 3) Guest reads the private memory privately and verifies that the contents
+ *    are same as written.
+ * 4) Guest invokes KVM_HC_MAP_GPA_RANGE to map the hpa range as shared
+ *    and marks the range to be accessed via shared access.
+ * 5) Guest writes shared memory with another pattern and signals VMM
+ * 6) VMM verifies the memory contents to be same as written by guest in step
+ *    5 and updates the memory with a different pattern
+ * 7) Guest verifies the memory contents to be same as written in step 6.
+ * 8) Guest invokes KVM_HC_MAP_GPA_RANGE to map the hpa range as private
+ *    and marks the range to be accessed via private access.
+ * 9) Guest writes a known pattern to the test memory and verifies the contents
+ *    to be same as written.
+ * 10) Guest invokes KVM_HC_MAP_GPA_RANGE to map the hpa range as shared
+ *    and marks the range to be accessed via shared access.
+ * 11) Guest writes shared memory with another pattern and signals VMM
+ * 12) VMM verifies the memory contents to be same as written by guest in step
+ *    5 and updates the memory with a different pattern
+ * 13) Guest verifies the memory contents to be same as written in step 6.
+ */
+#define PSAWDAT_ID	7
+#define PSAWDAT_DESC	"PrivateSharedAccessWithoutDoubleAllocationTest"
+
+#define PSAWDAT_GUEST_SHARED_MEM_UPDATED1		1ULL
+#define PSAWDAT_GUEST_SHARED_MEM_UPDATED2		2ULL
+
+static bool psawdat_handle_vm_stage(struct kvm_vm *vm, struct ucall *uc,
+	void *test_info, uint64_t stage)
+{
+	void *shared_mem = ((struct test_run_helper *)test_info)->shared_mem;
+
+	switch (stage) {
+	case PSAWDAT_GUEST_SHARED_MEM_UPDATED1: {
+		/* verify data to be same as what guest wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT2, test_mem_size),
+			"Shared memory view mismatch");
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT1, test_mem_size),
+			"Shared mem update Failure");
+		VM_STAGE_PROCESSED(PSAWDAT_GUEST_SHARED_MEM_UPDATED);
+		break;
+	}
+	case PSAWDAT_GUEST_SHARED_MEM_UPDATED2: {
+		/* verify data to be same as what guest wrote earlier */
+		TEST_ASSERT(do_mem_op(VERIFY_PAT, shared_mem,
+			TEST_MEM_DATA_PAT3, test_mem_size),
+			"Shared memory view mismatch");
+		TEST_ASSERT(do_mem_op(SET_PAT, shared_mem,
+			TEST_MEM_DATA_PAT4, test_mem_size),
+			"Shared mem update Failure");
+		VM_STAGE_PROCESSED(PSAWDAT_GUEST_SHARED_MEM_UPDATED2);
+		break;
+	}
+	default:
+		TEST_FAIL("Unhandled VM stage %ld\n", stage);
+		return false;
+	}
+
+	return true;
+}
+
+static void psawdat_guest_code(struct ucall *uc, uint8_t enc_bit_shift,
+	struct guest_pgt_info *gpgt_info, uint64_t mem_size, uint64_t ghcb_gpa,
+	void *ghcb_gva)
+{
+	void *test_mem = (void *)TEST_MEM_GPA;
+	int ret;
+
+	g_ghcb_gva = ghcb_gva;
+	g_ghcb_gpa = ghcb_gpa;
+	guest_verify_sev_vm_boot(uc, g_ghcb_gva != NULL);
+	guest_set_clr_pte_bit(uc, gpgt_info, TEST_MEM_GPA, mem_size, true,
+		enc_bit_shift);
+	/* Mark the GPA range to be treated as always accessed privately */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT, KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+	GUEST_SHARED_ASSERT(uc, do_mem_op(SET_PAT, test_mem, TEST_MEM_DATA_PAT1,
+		mem_size));
+
+	GUEST_SHARED_ASSERT(uc, do_mem_op(VERIFY_PAT, test_mem,
+			TEST_MEM_DATA_PAT1, mem_size));
+
+	/* Map the GPA range to be treated as shared */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT,
+		KVM_MAP_GPA_RANGE_DECRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+
+	guest_set_clr_pte_bit(uc, gpgt_info, TEST_MEM_GPA, mem_size, false,
+		enc_bit_shift);
+	/* Mark the GPA range to be treated as always accessed via shared
+	 * access
+	 */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, 0, 0,
+		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+
+	GUEST_SHARED_ASSERT(uc, do_mem_op(SET_PAT, test_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+	GUEST_SHARED_SYNC(uc, PSAWDAT_GUEST_SHARED_MEM_UPDATED1);
+
+	GUEST_SHARED_ASSERT(uc, do_mem_op(VERIFY_PAT, test_mem,
+			TEST_MEM_DATA_PAT1, mem_size));
+
+	/* Map the GPA range to be treated as private */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT,
+		KVM_MAP_GPA_RANGE_ENCRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+
+	guest_set_clr_pte_bit(uc, gpgt_info, TEST_MEM_GPA, mem_size, true,
+		enc_bit_shift);
+	/* Mark the GPA range to be treated as always accessed via private
+	 * access
+	 */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT, KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+
+	GUEST_SHARED_ASSERT(uc, do_mem_op(SET_PAT, test_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+	GUEST_SHARED_ASSERT(uc, do_mem_op(VERIFY_PAT, test_mem,
+			TEST_MEM_DATA_PAT2, mem_size));
+
+	/* Map the GPA range to be treated as shared */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, TEST_MEM_GPA,
+		mem_size >> MIN_PAGE_SHIFT,
+		KVM_MAP_GPA_RANGE_DECRYPTED | KVM_MAP_GPA_RANGE_PAGE_SZ_4K, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+
+	guest_set_clr_pte_bit(uc, gpgt_info, TEST_MEM_GPA, mem_size, false,
+		enc_bit_shift);
+	/* Mark the GPA range to be treated as always accessed via shared
+	 * access
+	 */
+	ret = guest_hypercall(KVM_HC_MAP_GPA_RANGE, 0, 0,
+		KVM_MARK_GPA_RANGE_ENC_ACCESS, 0);
+	GUEST_SHARED_ASSERT_1(uc, ret == 0, ret);
+
+	GUEST_SHARED_ASSERT(uc, do_mem_op(SET_PAT, test_mem,
+			TEST_MEM_DATA_PAT3, mem_size));
+	GUEST_SHARED_SYNC(uc, PSAWDAT_GUEST_SHARED_MEM_UPDATED2);
+
+	GUEST_SHARED_ASSERT(uc, do_mem_op(VERIFY_PAT, test_mem,
+			TEST_MEM_DATA_PAT4, mem_size));
+
+	GUEST_SHARED_DONE(uc);
+}
+
+static struct test_run_helper priv_memfd_testsuite[] = {
+	[PMPAT_ID] = {
+		.test_desc = PMPAT_DESC,
+		.vmst_handler = pmpat_handle_vm_stage,
+		.guest_fn = pmpat_guest_code,
+	},
+	[PMSAT_ID] = {
+		.test_desc = PMSAT_DESC,
+		.vmst_handler = pmsat_handle_vm_stage,
+		.guest_fn = pmsat_guest_code,
+	},
+	[SMSAT_ID] = {
+		.test_desc = SMSAT_DESC,
+		.vmst_handler = smsat_handle_vm_stage,
+		.guest_fn = smsat_guest_code,
+	},
+	[SMPAT_ID] = {
+		.test_desc = SMPAT_DESC,
+		.vmst_handler = smpat_handle_vm_stage,
+		.guest_fn = smpat_guest_code,
+	},
+	[PSAT_ID] = {
+		.test_desc = PSAT_DESC,
+		.vmst_handler = psat_handle_vm_stage,
+		.guest_fn = psat_guest_code,
+	},
+	[SPAT_ID] = {
+		.test_desc = SPAT_DESC,
+		.vmst_handler = spat_handle_vm_stage,
+		.guest_fn = spat_guest_code,
+	},
+	[PSPAHCT_ID] = {
+		.test_desc = PSPAHCT_DESC,
+		.vmst_handler = pspahct_handle_vm_stage,
+		.guest_fn = pspahct_guest_code,
+	},
+	[PSAWDAT_ID] = {
+		.test_desc = PSAWDAT_DESC,
+		.vmst_handler = psawdat_handle_vm_stage,
+		.guest_fn = psawdat_guest_code,
+		.toggle_shared_mem_state = true,
+		.disallow_boot_shared_access = true,
+	},
+};
+
+static void handle_vm_exit_hypercall(struct kvm_run *run,
+	uint32_t test_id)
+{
+	uint64_t gpa, npages, attrs, mem_end;
+	int priv_memfd = priv_memfd_testsuite[test_id].priv_memfd;
+	int ret;
+	int fallocate_mode;
+	void *shared_mem = priv_memfd_testsuite[test_id].shared_mem;
+	bool toggle_shared_mem_state =
+		priv_memfd_testsuite[test_id].toggle_shared_mem_state;
+	int mprotect_mode;
+
+	if (run->hypercall.nr != KVM_HC_MAP_GPA_RANGE)
+		TEST_FAIL("Unhandled Hypercall %lld\n", run->hypercall.nr);
+
+	gpa = run->hypercall.args[0];
+	npages = run->hypercall.args[1];
+	attrs = run->hypercall.args[2];
+	mem_end = test_mem_end(gpa, test_mem_size);
+
+	if ((gpa < TEST_MEM_GPA) ||
+		((gpa + (npages << MIN_PAGE_SHIFT)) > mem_end))
+		TEST_FAIL("Unhandled gpa 0x%lx npages %ld\n", gpa, npages);
+
+	if (attrs & KVM_MAP_GPA_RANGE_ENCRYPTED) {
+		fallocate_mode = 0;
+		mprotect_mode = PROT_NONE;
+	} else {
+		fallocate_mode = (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
+		mprotect_mode = PROT_READ | PROT_WRITE;
+	}
+	pr_info("Converting off 0x%lx pages 0x%lx to %s\n",
+		(gpa - TEST_MEM_GPA), npages, fallocate_mode ?
+		"shared" : "private");
+	ret = fallocate(priv_memfd, fallocate_mode, (gpa - TEST_MEM_GPA),
+		npages << MIN_PAGE_SHIFT);
+	TEST_ASSERT(ret != -1, "fallocate failed in hc handling");
+	if (toggle_shared_mem_state) {
+		if (fallocate_mode) {
+			ret = madvise(shared_mem, test_mem_size, MADV_DONTNEED);
+			TEST_ASSERT(ret != -1, "madvise failed in hc handling");
+		}
+		ret = mprotect(shared_mem, test_mem_size, mprotect_mode);
+		TEST_ASSERT(ret != -1, "mprotect failed in hc handling");
+	}
+	run->hypercall.ret = 0;
+}
+
+static void handle_vm_exit_memory_error(struct kvm_run *run,
+	uint32_t test_id)
+{
+	uint64_t gpa, size, flags, mem_end;
+	int ret;
+	int priv_memfd =
+		priv_memfd_testsuite[test_id].priv_memfd;
+	void *shared_mem = priv_memfd_testsuite[test_id].shared_mem;
+	bool toggle_shared_mem_state =
+		priv_memfd_testsuite[test_id].toggle_shared_mem_state;
+	int fallocate_mode;
+	int mprotect_mode;
+
+	gpa = run->memory.gpa;
+	size = run->memory.size;
+	flags = run->memory.flags;
+	mem_end = test_mem_end(gpa, test_mem_size);
+
+	if ((gpa < TEST_MEM_GPA) || ((gpa + size) > mem_end))
+		TEST_FAIL("Unhandled gpa 0x%lx size 0x%lx\n", gpa, size);
+
+	if (flags & KVM_MEMORY_EXIT_FLAG_PRIVATE) {
+		fallocate_mode = 0;
+		mprotect_mode = PROT_NONE;
+	} else {
+		fallocate_mode = (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
+		mprotect_mode = PROT_READ | PROT_WRITE;
+	}
+	pr_info("Converting off 0x%lx size 0x%lx to %s\n", (gpa - TEST_MEM_GPA),
+		size, fallocate_mode ? "shared" : "private");
+	ret = fallocate(priv_memfd, fallocate_mode, (gpa - TEST_MEM_GPA), size);
+	TEST_ASSERT(ret != -1, "fallocate failed in memory error handling");
+
+	if (toggle_shared_mem_state) {
+		if (fallocate_mode) {
+			ret = madvise(shared_mem, test_mem_size, MADV_DONTNEED);
+			TEST_ASSERT(ret != -1,
+				"madvise failed in memory error handling");
+		}
+		ret = mprotect(shared_mem, test_mem_size, mprotect_mode);
+		TEST_ASSERT(ret != -1,
+			"mprotect failed in memory error handling");
+	}
+}
+
+static void vcpu_work(struct kvm_vm *vm, struct ucall *uc, uint32_t test_id)
+{
+	struct kvm_run *run;
+	uint64_t cmd;
+
+	/*
+	 * Loop until the guest is done.
+	 */
+	run = vcpu_state(vm, VCPU_ID);
+
+	while (true) {
+		vcpu_run(vm, VCPU_ID);
+
+		if (run->exit_reason == KVM_EXIT_HLT) {
+			cmd = get_ucall_shared(vm, VCPU_ID, uc);
+			if (cmd != UCALL_SYNC)
+				break;
+
+			if (!priv_memfd_testsuite[test_id].vmst_handler(
+				vm, uc, &priv_memfd_testsuite[test_id],
+					uc->args[1]))
+				break;
+
+			continue;
+		}
+
+		if (run->exit_reason == KVM_EXIT_HYPERCALL) {
+			handle_vm_exit_hypercall(run, test_id);
+			continue;
+		}
+
+		if (run->exit_reason == KVM_EXIT_MEMORY_FAULT) {
+			handle_vm_exit_memory_error(run, test_id);
+			continue;
+		}
+
+		TEST_FAIL("Unhandled VCPU exit reason %d\n", run->exit_reason);
+		break;
+	}
+
+	if (run->exit_reason == KVM_EXIT_HLT && cmd == UCALL_ABORT)
+		TEST_FAIL("%s at %s:%ld, val = %lu", (const char *)uc->args[0],
+			  __FILE__, uc->args[1], uc->args[2]);
+}
+
+static void priv_memory_region_add(struct kvm_vm *vm, void *mem, uint32_t slot,
+				uint32_t size, uint64_t guest_addr,
+				uint32_t priv_fd, uint64_t priv_offset)
+{
+	struct kvm_userspace_memory_region_ext region_ext;
+	int ret;
+
+	region_ext.region.slot = slot;
+	region_ext.region.flags = KVM_MEM_PRIVATE;
+	region_ext.region.guest_phys_addr = guest_addr;
+	region_ext.region.memory_size = size;
+	region_ext.region.userspace_addr = (uintptr_t) mem;
+	region_ext.private_fd = priv_fd;
+	region_ext.private_offset = priv_offset;
+	ret = ioctl(vm_get_fd(vm), KVM_SET_USER_MEMORY_REGION, &region_ext);
+	TEST_ASSERT(ret == 0, "Failed to register user region for gpa 0x%lx\n",
+		guest_addr);
+}
+
+static void vc_handler(struct ex_regs *regs)
+{
+	sev_es_handle_vc(g_ghcb_gva, g_ghcb_gpa, regs);
+}
+
+static void setup_and_execute_test(uint32_t test_id,
+	const enum page_size shared,
+	const enum page_size private,
+	uint32_t policy)
+{
+	struct kvm_vm *vm;
+	vm_vaddr_t uc_vaddr;
+	struct sev_vm *sev;
+	int priv_memfd;
+	int ret;
+	void *shared_mem;
+	struct kvm_enable_cap cap;
+	bool disallow_boot_shared_access =
+		priv_memfd_testsuite[test_id].disallow_boot_shared_access;
+	int prot_flags = PROT_READ | PROT_WRITE;
+	uint8_t measurement[512];
+	uint32_t vm_page_size, num_test_pages;
+	vm_vaddr_t ghcb_vaddr = 0;
+	uint8_t enc_bit;
+
+	sev = sev_vm_create(policy, TOTAL_PAGES);
+	TEST_ASSERT(sev, "Failed to create SEV VM");
+	vm = sev_get_vm(sev);
+
+	vm_set_pgt_alloc_tracking(vm);
+
+	/* Set up VCPU and initial guest kernel. */
+	vm_vcpu_add_default(vm, VCPU_ID,
+		priv_memfd_testsuite[test_id].guest_fn);
+	kvm_vm_elf_load(vm, program_invocation_name);
+
+	// use 2 pages by default
+	size_t mem_size = PAGE_SIZE_4KB * 2;
+	bool using_hugepages = false;
+
+	int mmap_flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE;
+
+	switch (shared) {
+	case PAGE_4KB:
+		// no additional flags are needed
+		break;
+	case PAGE_2MB:
+		mmap_flags |= MAP_HUGETLB | MAP_HUGE_2MB | MAP_POPULATE;
+		mem_size = max(mem_size, PAGE_SIZE_2MB);
+		using_hugepages = true;
+		break;
+	case PAGE_1GB:
+		mmap_flags |= MAP_HUGETLB | MAP_HUGE_1GB | MAP_POPULATE;
+		mem_size = max(mem_size, PAGE_SIZE_1GB);
+		using_hugepages = true;
+		break;
+	default:
+		TEST_FAIL("unknown page size for shared memory\n");
+	}
+
+	unsigned int memfd_flags = MFD_INACCESSIBLE;
+
+	switch (private) {
+	case PAGE_4KB:
+		// no additional flags are needed
+		break;
+	case PAGE_2MB:
+		memfd_flags |= MFD_HUGETLB | MFD_HUGE_2MB;
+		mem_size = PAGE_SIZE_2MB;
+		using_hugepages = true;
+		break;
+	case PAGE_1GB:
+		memfd_flags |= MFD_HUGETLB | MFD_HUGE_1GB;
+		mem_size = PAGE_SIZE_1GB;
+		using_hugepages = true;
+		break;
+	default:
+		TEST_FAIL("unknown page size for private memory\n");
+	}
+
+	// set global for mem size to use later
+	test_mem_size = mem_size;
+
+	if (disallow_boot_shared_access)
+		prot_flags = PROT_NONE;
+
+	/* Allocate shared memory */
+	shared_mem = mmap(NULL, mem_size, prot_flags, mmap_flags, -1, 0);
+	TEST_ASSERT(shared_mem != MAP_FAILED, "Failed to mmap() host");
+
+	if (using_hugepages) {
+		ret = madvise(shared_mem, mem_size, MADV_WILLNEED);
+		TEST_ASSERT(ret == 0, "madvise failed");
+	}
+
+	/* Allocate private memory */
+	priv_memfd = memfd_create("vm_private_mem", memfd_flags);
+	TEST_ASSERT(priv_memfd != -1, "Failed to create priv_memfd");
+	ret = fallocate(priv_memfd, 0, 0, mem_size);
+	TEST_ASSERT(ret != -1, "fallocate failed");
+
+	priv_memory_region_add(vm, shared_mem, TEST_MEM_SLOT, mem_size,
+				TEST_MEM_GPA, priv_memfd, 0);
+
+	vm_page_size = vm_get_page_size(vm);
+	num_test_pages = mem_size / vm_page_size;
+	TEST_ASSERT(!(mem_size % vm_page_size),
+				"mem_size unaligned with vm page size");
+	pr_info("Mapping test memory pages 0x%x page_size 0x%x\n",
+				num_test_pages, vm_page_size);
+	virt_map(vm, TEST_MEM_GPA, TEST_MEM_GPA, num_test_pages);
+
+	/* Set up shared ucall buffer. */
+	uc_vaddr = ucall_shared_alloc(vm, 1);
+
+	/* Enable exit on KVM_HC_MAP_GPA_RANGE */
+	pr_info("Enabling exit on map_gpa_range hypercall\n");
+	ret = ioctl(vm_get_fd(vm), KVM_CHECK_EXTENSION, KVM_CAP_EXIT_HYPERCALL);
+	TEST_ASSERT(ret & (1 << KVM_HC_MAP_GPA_RANGE),
+				"VM exit on MAP_GPA_RANGE HC not supported");
+	cap.cap = KVM_CAP_EXIT_HYPERCALL;
+	cap.flags = 0;
+	cap.args[0] = (1 << KVM_HC_MAP_GPA_RANGE);
+	ret = ioctl(vm_get_fd(vm), KVM_ENABLE_CAP, &cap);
+	TEST_ASSERT(ret == 0,
+		"Failed to enable exit on MAP_GPA_RANGE hypercall\n");
+
+	vm_map_page_table(vm, GUEST_PGT_MIN_VADDR);
+	vm_vaddr_t pgt_info_vaddr = vm_setup_pgt_info_buf(vm,
+					GUEST_PGT_MIN_VADDR);
+
+	if (policy & SEV_POLICY_ES) {
+		ghcb_vaddr = vm_vaddr_alloc_shared(vm, vm_page_size,
+			vm_page_size);
+		/* Set up VC handler. */
+		vm_init_descriptor_tables(vm);
+		vm_install_exception_handler(vm, 29, vc_handler);
+		vcpu_init_descriptor_tables(vm, VCPU_ID);
+	}
+
+	/* Set up guest params. */
+	enc_bit = sev_get_enc_bit(sev);
+	vcpu_args_set(vm, VCPU_ID, 6, uc_vaddr, enc_bit, pgt_info_vaddr,
+		test_mem_size, ghcb_vaddr ? addr_gva2gpa(vm, ghcb_vaddr) : 0,
+		ghcb_vaddr);
+	struct ucall *uc = (struct ucall *)addr_gva2hva(vm, uc_vaddr);
+
+	priv_memfd_testsuite[test_id].shared_mem = shared_mem;
+	priv_memfd_testsuite[test_id].priv_memfd = priv_memfd;
+
+	/* Allocations/setup done. Encrypt initial guest payload. */
+	sev_vm_launch(sev);
+	sev_vm_launch_measure(sev, measurement);
+	pr_info("guest measurement: ");
+	for (uint32_t i = 0; i < 32; ++i)
+		pr_info("%02x", measurement[i]);
+	pr_info("\n");
+
+	sev_vm_launch_finish(sev);
+
+	vcpu_work(vm, uc, test_id);
+
+	munmap(shared_mem, mem_size);
+	priv_memfd_testsuite[test_id].shared_mem = NULL;
+	close(priv_memfd);
+	priv_memfd_testsuite[test_id].priv_memfd = -1;
+	sev_vm_free(sev);
+}
+
+static void hugepage_requirements_text(const struct page_combo matrix)
+{
+	int pages_needed_2mb = 0;
+	int pages_needed_1gb = 0;
+	enum page_size sizes[] = { matrix.shared, matrix.private };
+
+	for (int i = 0; i < ARRAY_SIZE(sizes); ++i) {
+		if (sizes[i] == PAGE_2MB)
+			++pages_needed_2mb;
+		if (sizes[i] == PAGE_1GB)
+			++pages_needed_1gb;
+	}
+	if (pages_needed_2mb != 0 && pages_needed_1gb != 0) {
+		pr_info("This test requires %d 2MB page(s) and %d 1GB page(s)\n",
+				pages_needed_2mb, pages_needed_1gb);
+	} else if (pages_needed_2mb != 0) {
+		pr_info("This test requires %d 2MB page(s)\n", pages_needed_2mb);
+	} else if (pages_needed_1gb != 0) {
+		pr_info("This test requires %d 1GB page(s)\n", pages_needed_1gb);
+	}
+}
+
+static bool should_skip_test(const struct page_combo matrix,
+	const bool use_2mb_pages,
+	const bool use_1gb_pages)
+{
+	if ((matrix.shared == PAGE_2MB || matrix.private == PAGE_2MB)
+		&& !use_2mb_pages)
+		return true;
+	if ((matrix.shared == PAGE_1GB || matrix.private == PAGE_1GB)
+		&& !use_1gb_pages)
+		return true;
+	return false;
+}
+
+static void print_help(const char *const name)
+{
+	puts("");
+	printf("usage %s [-h] [-m] [-g]\n", name);
+	puts("");
+	printf(" -h: Display this help message\n");
+	printf(" -m: include test runs using 2MB page permutations\n");
+	printf(" -g: include test runs using 1GB page permutations\n");
+	printf(" -e: Run test with SEV-ES VM\n");
+	exit(0);
+}
+
+int main(int argc, char *argv[])
+{
+	/* Tell stdout not to buffer its content */
+	setbuf(stdout, NULL);
+
+	// arg parsing
+	int opt;
+	bool use_2mb_pages = false;
+	bool use_1gb_pages = false;
+	uint32_t policy = 0;
+
+	while ((opt = getopt(argc, argv, "emgh")) != -1) {
+		switch (opt) {
+		case 'm':
+			use_2mb_pages = true;
+			break;
+		case 'g':
+			use_1gb_pages = true;
+			break;
+		case 'e':
+			policy |= SEV_POLICY_ES;
+			break;
+		case 'h':
+		default:
+			print_help(argv[0]);
+		}
+	}
+
+	struct page_combo page_size_matrix[] = {
+		{ .shared = PAGE_4KB, .private = PAGE_4KB },
+		{ .shared = PAGE_2MB, .private = PAGE_4KB },
+	};
+
+	for (uint32_t i = 0; i < ARRAY_SIZE(priv_memfd_testsuite); i++) {
+		for (uint32_t j = 0; j < ARRAY_SIZE(page_size_matrix); j++) {
+			const struct page_combo current_page_matrix =
+							page_size_matrix[j];
+
+			if (should_skip_test(current_page_matrix,
+				use_2mb_pages, use_1gb_pages))
+				break;
+			pr_info("=== Starting test %s... ===\n",
+					priv_memfd_testsuite[i].test_desc);
+			pr_info("using page sizes shared: %s private: %s\n",
+					page_size_to_str(
+						current_page_matrix.shared),
+					page_size_to_str(
+						current_page_matrix.private));
+			hugepage_requirements_text(current_page_matrix);
+			setup_and_execute_test(i, current_page_matrix.shared,
+				current_page_matrix.private, policy);
+			pr_info("--- completed test %s ---\n\n",
+					priv_memfd_testsuite[i].test_desc);
+		}
+	}
+
+	return 0;
+}
-- 
2.36.1.124.g0e6072fb45-goog

