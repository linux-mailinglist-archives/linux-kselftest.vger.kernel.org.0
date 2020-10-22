Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1166C296743
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 00:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372861AbgJVW1c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 18:27:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:33644 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S372851AbgJVW13 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 18:27:29 -0400
IronPort-SDR: s/V2A/2ijE4+A9iv1bNlv7ZChdm7qVMC7ejp6nX4L7PwNyE9QRhW2so9qSUL5LhsF3BHxGflZB
 iwucyBKu6N5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="167697354"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="167697354"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 15:27:26 -0700
IronPort-SDR: CZp5Pd1EufykC4e5Zo3LAPUh4uZ4N8lald2xQ1lcV6dSZ1xxERTNtNJyhKGiWQclT8dSBHPiWI
 5rH1pAEadi/g==
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="302567674"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 15:27:26 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 10/10] x86/pks: Add PKS test code
Date:   Thu, 22 Oct 2020 15:27:01 -0700
Message-Id: <20201022222701.887660-11-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201022222701.887660-1-ira.weiny@intel.com>
References: <20201022222701.887660-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The core PKS functionality provides an interface for kernel users to
reserve keys to their domains set up the page tables with those keys and
control access to those domains when needed.

Define test code which exercises the core functionality of PKS via a
debugfs entry.  Basic checks can be triggered on boot with a kernel
command line option while both basic and preemption checks can be
triggered with separate debugfs values.

debugfs controls are:

'0' -- Run access tests with a single pkey
'1' -- Set up the pkey register with no access for the pkey allocated to
       this fd
'2' -- Check that the pkey register updated in '1' is still the same.
       (To be used after a forced context switch.)
'3' -- Allocate all pkeys possible and run tests on each pkey allocated.
       DEFAULT when run at boot.

Closing the fd will cleanup and release the pkey, therefore to exercise
context switch testing a user space program is provided in:

	.../tools/testing/selftests/x86/test_pks.c

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC V3
	Comments from Dave Hansen
		clean up whitespace dmanage
		Clean up Kconfig help
		Clean up user test error output
		s/pks_mknoaccess/pks_mk_noaccess/
		s/pks_mkread/pks_mk_readonly/
		s/pks_mkrdwr/pks_mk_readwrite/
	Comments from Jing Han
		Remove duplicate stdio.h
---
 Documentation/core-api/protection-keys.rst |   1 +
 arch/x86/mm/fault.c                        |  23 +
 lib/Kconfig.debug                          |  12 +
 lib/Makefile                               |   3 +
 lib/pks/Makefile                           |   3 +
 lib/pks/pks_test.c                         | 691 +++++++++++++++++++++
 tools/testing/selftests/x86/Makefile       |   3 +-
 tools/testing/selftests/x86/test_pks.c     |  66 ++
 8 files changed, 801 insertions(+), 1 deletion(-)
 create mode 100644 lib/pks/Makefile
 create mode 100644 lib/pks/pks_test.c
 create mode 100644 tools/testing/selftests/x86/test_pks.c

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index e6cb29dda5b8..b0196c6cf29a 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -163,3 +163,4 @@ of WRPKRU.  So to quote from the WRPKRU text:
 	until all prior executions of WRPKRU have completed execution
 	and updated the PKRU register.
 
+Example code can be found in lib/pks/pks_test.c
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e2f83a596b50..4b23a13a7802 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>		/* faulthandler_disabled()	*/
 #include <linux/efi.h>			/* efi_recover_from_page_fault()*/
 #include <linux/mm_types.h>
+#include <linux/pkeys.h>
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
 #include <asm/traps.h>			/* dotraplinkage, ...		*/
@@ -1149,6 +1150,25 @@ bool fault_in_kernel_space(unsigned long address)
 	return address >= TASK_SIZE_MAX;
 }
 
+#ifdef CONFIG_PKS_TESTING
+bool pks_test_callback(irqentry_state_t *irq_state);
+static bool handle_pks_testing(unsigned long hw_error_code, irqentry_state_t *irq_state)
+{
+	/*
+	 * If we get a protection key exception it could be because we
+	 * are running the PKS test.  If so, pks_test_callback() will
+	 * clear the protection mechanism and return true to indicate
+	 * the fault was handled.
+	 */
+	return (hw_error_code & X86_PF_PK) && pks_test_callback(irq_state);
+}
+#else
+static bool handle_pks_testing(unsigned long hw_error_code, irqentry_state_t *irq_state)
+{
+	return false;
+}
+#endif
+
 /*
  * Called for all faults where 'address' is part of the kernel address
  * space.  Might get called for faults that originate from *code* that
@@ -1165,6 +1185,9 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 	if (!cpu_feature_enabled(X86_FEATURE_PKS))
 		WARN_ON_ONCE(hw_error_code & X86_PF_PK);
 
+	if (handle_pks_testing(hw_error_code, irq_state))
+		return;
+
 #ifdef CONFIG_X86_32
 	/*
 	 * We can fault-in kernel-space virtual memory on-demand. The
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 66d44d35cc97..8bc32ad9ae94 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2446,6 +2446,18 @@ config HYPERV_TESTING
 	help
 	  Select this option to enable Hyper-V vmbus testing.
 
+config PKS_TESTING
+	bool "PKey (S)upervisor testing"
+	default n
+	depends on ARCH_HAS_SUPERVISOR_PKEYS
+	help
+	  Select this option to enable testing of PKS core software and
+	  hardware.  The PKS core provides a mechanism to allocate keys as well
+	  as maintain the protection settings across context switches.
+	  Answer N if you don't know what supervisor keys are.
+
+	  If unsure, say N.
+
 endmenu # "Kernel Testing and Coverage"
 
 endmenu # Kernel hacking
diff --git a/lib/Makefile b/lib/Makefile
index ce45af50983a..6a402bc1b9a0 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -352,3 +352,6 @@ obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
+
+# PKS test
+obj-y += pks/
diff --git a/lib/pks/Makefile b/lib/pks/Makefile
new file mode 100644
index 000000000000..7d1df7563db9
--- /dev/null
+++ b/lib/pks/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_PKS_TESTING) += pks_test.o
diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
new file mode 100644
index 000000000000..0edeb085ced9
--- /dev/null
+++ b/lib/pks/pks_test.c
@@ -0,0 +1,691 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright(c) 2020 Intel Corporation. All rights reserved.
+ *
+ * Implement PKS testing
+ * Access to run this test can be with a command line parameter
+ * ("pks-test-on-boot") or more detailed tests can be triggered through:
+ *
+ *    /sys/kernel/debug/x86/run_pks
+ *
+ *  debugfs controls are:
+ *
+ *  '0' -- Run access tests with a single pkey
+ *
+ *  '1' -- Set up the pkey register with no access for the pkey allocated to
+ *         this fd
+ *  '2' -- Check that the pkey register updated in '1' is still the same.  (To
+ *         be used after a forced context switch.)
+ *
+ *  '3' -- Allocate all pkeys possible and run tests on each pkey allocated.
+ *         DEFAULT when run at boot.
+ *
+ *  Closing the fd will cleanup and release the pkey.
+ *
+ *  A companion user space program is provided in:
+ *
+ *          .../tools/testing/selftests/x86/test_pks.c
+ *
+ *  which will better test the context switching.
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/entry-common.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/mman.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/percpu-defs.h>
+#include <linux/pgtable.h>
+#include <linux/pkeys.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#define PKS_TEST_MEM_SIZE (PAGE_SIZE)
+
+/*
+ * run_on_boot default '= false' which checkpatch complains about initializing;
+ * so we don't
+ */
+static bool run_on_boot;
+static struct dentry *pks_test_dentry;
+static bool run_9;
+
+/*
+ * We must lock the following globals for brief periods while the fault handler
+ * checks/updates them.
+ */
+static DEFINE_SPINLOCK(test_lock);
+static int test_armed_key;
+static unsigned long prev_cnt;
+static unsigned long fault_cnt;
+
+struct pks_test_ctx {
+	bool pass;
+	bool pks_cpu_enabled;
+	int pkey;
+	char data[64];
+};
+static struct pks_test_ctx *test_exception_ctx;
+
+static pte_t *walk_table(void *ptr)
+{
+	struct page *page = NULL;
+	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pud_t *pudp;
+	pmd_t *pmdp;
+	pte_t *ret = NULL;
+
+	pgdp = pgd_offset_k((unsigned long)ptr);
+	if (pgd_none(*pgdp) || pgd_bad(*pgdp))
+		goto error;
+
+	p4dp = p4d_offset(pgdp, (unsigned long)ptr);
+	if (p4d_none(*p4dp) || p4d_bad(*p4dp))
+		goto error;
+
+	pudp = pud_offset(p4dp, (unsigned long)ptr);
+	if (pud_none(*pudp) || pud_bad(*pudp))
+		goto error;
+
+	pmdp = pmd_offset(pudp, (unsigned long)ptr);
+	if (pmd_none(*pmdp) || pmd_bad(*pmdp))
+		goto error;
+
+	ret = pte_offset_map(pmdp, (unsigned long)ptr);
+	if (pte_present(*ret)) {
+		page = pte_page(*ret);
+		if (!page) {
+			pte_unmap(ret);
+			goto error;
+		}
+		pr_info("page 0x%lx; flags 0x%lx\n",
+		       (unsigned long)page, page->flags);
+	}
+
+error:
+	return ret;
+}
+
+static bool check_pkey_val(u32 pk_reg, int pkey, u32 expected)
+{
+	u32 pkey_shift = pkey * PKR_BITS_PER_PKEY;
+	u32 pkey_mask = ((1 << PKR_BITS_PER_PKEY) - 1) << pkey_shift;
+
+	pk_reg = (pk_reg & pkey_mask) >> pkey_shift;
+	return (pk_reg == expected);
+}
+
+/*
+ * Check if the register @pkey value matches @expected value
+ *
+ * Both the cached and actual MSR must match.
+ */
+static bool check_pkrs(int pkey, u32 expected)
+{
+	bool ret = true;
+	u64 pkrs;
+	u32 *tmp_cache;
+
+	tmp_cache = get_cpu_ptr(&pkrs_cache);
+	if (!check_pkey_val(*tmp_cache, pkey, expected))
+		ret = false;
+	put_cpu_ptr(tmp_cache);
+
+	rdmsrl(MSR_IA32_PKRS, pkrs);
+	if (!check_pkey_val(pkrs, pkey, expected))
+		ret = false;
+
+	return ret;
+}
+
+static void check_exception(irqentry_state_t *irq_state)
+{
+	/* Check the thread saved state */
+	if (!check_pkey_val(irq_state->pkrs, test_armed_key, PKEY_DISABLE_WRITE)) {
+		pr_err("     FAIL: checking irq_state->pkrs\n");
+		test_exception_ctx->pass = false;
+	}
+
+	/* Check the exception state */
+	if (!check_pkrs(test_armed_key, PKEY_DISABLE_ACCESS)) {
+		pr_err("     FAIL: PKRS cache and MSR\n");
+		test_exception_ctx->pass = false;
+	}
+
+	/*
+	 * Check we can update the value during exception without affecting the
+	 * calling thread.  The calling thread is checked after exception...
+	 */
+	pks_mk_readwrite(test_armed_key);
+	if (!check_pkrs(test_armed_key, 0)) {
+		pr_err("     FAIL: exception did not change register to 0\n");
+		test_exception_ctx->pass = false;
+	}
+	pks_mk_noaccess(test_armed_key);
+	if (!check_pkrs(test_armed_key, PKEY_DISABLE_ACCESS)) {
+		pr_err("     FAIL: exception did not change register to 0x%x\n",
+			PKEY_DISABLE_ACCESS);
+		test_exception_ctx->pass = false;
+	}
+}
+
+/* Silence prototype warning */
+bool pks_test_callback(irqentry_state_t *irq_state);
+
+/**
+ * pks_test_callback() is exported so that the fault handler can detect
+ * and report back status of intentional faults.
+ *
+ * NOTE: It clears the protection key from the page such that the fault handler
+ * will not re-trigger.
+ */
+bool pks_test_callback(irqentry_state_t *irq_state)
+{
+	bool armed = (test_armed_key != 0);
+
+	if (test_exception_ctx) {
+		check_exception(irq_state);
+		/*
+		 * We stop this check within the exception because the
+		 * fault handler clean up code will call us 2x while checking
+		 * the PMD entry and we don't need to check this again
+		 */
+		test_exception_ctx = NULL;
+	}
+
+	if (armed) {
+		/* Enable read and write to stop faults */
+		irq_state->pkrs = update_pkey_val(irq_state->pkrs, test_armed_key, 0);
+		fault_cnt++;
+	}
+
+	return armed;
+}
+EXPORT_SYMBOL(pks_test_callback);
+
+static bool exception_caught(void)
+{
+	bool ret = (fault_cnt != prev_cnt);
+
+	prev_cnt = fault_cnt;
+	return ret;
+}
+
+static void report_pkey_settings(void *unused)
+{
+	u8 pkey;
+	unsigned long long msr = 0;
+	unsigned int cpu = smp_processor_id();
+
+	rdmsrl(MSR_IA32_PKRS, msr);
+
+	pr_info("for CPU %d : 0x%llx\n", cpu, msr);
+	for (pkey = 0; pkey < PKS_NUM_KEYS; pkey++) {
+		int ad, wd;
+
+		ad = (msr >> (pkey * PKR_BITS_PER_PKEY)) & PKEY_DISABLE_ACCESS;
+		wd = (msr >> (pkey * PKR_BITS_PER_PKEY)) & PKEY_DISABLE_WRITE;
+		pr_info("   %u: A:%d W:%d\n", pkey, ad, wd);
+	}
+}
+
+enum pks_access_mode {
+	PKS_TEST_NO_ACCESS,
+	PKS_TEST_RDWR,
+	PKS_TEST_RDONLY
+};
+
+static char *get_mode_str(enum pks_access_mode mode)
+{
+	switch (mode) {
+	case PKS_TEST_NO_ACCESS:
+		return "No Access";
+	case PKS_TEST_RDWR:
+		return "Read Write";
+	case PKS_TEST_RDONLY:
+		return "Read Only";
+	default:
+		pr_err("BUG in test invalid mode\n");
+		break;
+	}
+
+	return "";
+}
+
+struct pks_access_test {
+	enum pks_access_mode mode;
+	bool write;
+	bool exception;
+};
+
+static struct pks_access_test pkey_test_ary[] = {
+	/*  disable both */
+	{ PKS_TEST_NO_ACCESS, true,  true },
+	{ PKS_TEST_NO_ACCESS, false, true },
+
+	/*  enable both */
+	{ PKS_TEST_RDWR, true,  false },
+	{ PKS_TEST_RDWR, false, false },
+
+	/*  enable read only */
+	{ PKS_TEST_RDONLY, true,  true },
+	{ PKS_TEST_RDONLY, false, false },
+};
+
+static int test_it(struct pks_test_ctx *ctx, struct pks_access_test *test, void *ptr)
+{
+	bool exception;
+	int ret = 0;
+
+	spin_lock(&test_lock);
+	WRITE_ONCE(test_armed_key, ctx->pkey);
+
+	if (test->write)
+		memcpy(ptr, ctx->data, 8);
+	else
+		memcpy(ctx->data, ptr, 8);
+
+	exception = exception_caught();
+
+	WRITE_ONCE(test_armed_key, 0);
+	spin_unlock(&test_lock);
+
+	if (test->exception != exception) {
+		pr_err("pkey test FAILED: mode %s; write %s; exception %s != %s\n",
+			get_mode_str(test->mode),
+			test->write ? "TRUE" : "FALSE",
+			test->exception ? "TRUE" : "FALSE",
+			exception ? "TRUE" : "FALSE");
+		ret = -EFAULT;
+	}
+
+	return ret;
+}
+
+static int run_access_test(struct pks_test_ctx *ctx,
+			   struct pks_access_test *test,
+			   void *ptr)
+{
+	switch (test->mode) {
+	case PKS_TEST_NO_ACCESS:
+		pks_mk_noaccess(ctx->pkey);
+		break;
+	case PKS_TEST_RDWR:
+		pks_mk_readwrite(ctx->pkey);
+		break;
+	case PKS_TEST_RDONLY:
+		pks_mk_readonly(ctx->pkey);
+		break;
+	default:
+		pr_err("BUG in test invalid mode\n");
+		break;
+	}
+
+	return test_it(ctx, test, ptr);
+}
+
+static void *alloc_test_page(int pkey)
+{
+	return __vmalloc_node_range(PKS_TEST_MEM_SIZE, 1, VMALLOC_START, VMALLOC_END,
+				    GFP_KERNEL, PAGE_KERNEL_PKEY(pkey), 0,
+				    NUMA_NO_NODE, __builtin_return_address(0));
+}
+
+static void test_mem_access(struct pks_test_ctx *ctx)
+{
+	int i, rc;
+	u8 pkey;
+	void *ptr = NULL;
+	pte_t *ptep;
+
+	ptr = alloc_test_page(ctx->pkey);
+	if (!ptr) {
+		pr_err("Failed to vmalloc page???\n");
+		ctx->pass = false;
+		return;
+	}
+
+	ptep = walk_table(ptr);
+	if (!ptep) {
+		pr_err("Failed to walk table???\n");
+		ctx->pass = false;
+		goto done;
+	}
+
+	pkey = pte_flags_pkey(ptep->pte);
+	pr_info("ptep flags 0x%lx pkey %u\n",
+	       (unsigned long)ptep->pte, pkey);
+
+	if (pkey != ctx->pkey) {
+		pr_err("invalid pkey found: %u, test_pkey: %u\n",
+			pkey, ctx->pkey);
+		ctx->pass = false;
+		goto unmap;
+	}
+
+	if (!ctx->pks_cpu_enabled) {
+		pr_err("not CPU enabled; skipping access tests...\n");
+		ctx->pass = true;
+		goto unmap;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pkey_test_ary); i++) {
+		rc = run_access_test(ctx, &pkey_test_ary[i], ptr);
+
+		/*  only save last error is fine */
+		if (rc)
+			ctx->pass = false;
+	}
+
+unmap:
+	pte_unmap(ptep);
+done:
+	vfree(ptr);
+}
+
+static void pks_run_test(struct pks_test_ctx *ctx)
+{
+	ctx->pass = true;
+
+	pr_info("\n");
+	pr_info("\n");
+	pr_info("     ***** BEGIN: Testing (CPU enabled : %s) *****\n",
+		ctx->pks_cpu_enabled ? "TRUE" : "FALSE");
+
+	if (ctx->pks_cpu_enabled)
+		on_each_cpu(report_pkey_settings, NULL, 1);
+
+	pr_info("           BEGIN: pkey %d Testing\n", ctx->pkey);
+	test_mem_access(ctx);
+	pr_info("           END: PAGE_KERNEL_PKEY Testing : %s\n",
+		ctx->pass ? "PASS" : "FAIL");
+
+	pr_info("     ***** END: Testing *****\n");
+	pr_info("\n");
+	pr_info("\n");
+}
+
+static ssize_t pks_read_file(struct file *file, char __user *user_buf,
+			     size_t count, loff_t *ppos)
+{
+	struct pks_test_ctx *ctx = file->private_data;
+	char buf[32];
+	unsigned int len;
+
+	if (!ctx)
+		len = sprintf(buf, "not run\n");
+	else
+		len = sprintf(buf, "%s\n", ctx->pass ? "PASS" : "FAIL");
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static struct pks_test_ctx *alloc_ctx(const char *name)
+{
+	struct pks_test_ctx *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+
+	if (!ctx) {
+		pr_err("Failed to allocate memory for test context\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ctx->pkey = pks_key_alloc(name);
+	if (ctx->pkey <= 0) {
+		pr_err("Failed to allocate memory for test context\n");
+		kfree(ctx);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ctx->pks_cpu_enabled = cpu_feature_enabled(X86_FEATURE_PKS);
+	sprintf(ctx->data, "%s", "DEADBEEF");
+	return ctx;
+}
+
+static void free_ctx(struct pks_test_ctx *ctx)
+{
+	pks_key_free(ctx->pkey);
+	kfree(ctx);
+}
+
+static void run_exception_test(void)
+{
+	void *ptr = NULL;
+	bool pass = true;
+	struct pks_test_ctx *ctx;
+
+	pr_info("     ***** BEGIN: exception checking\n");
+
+	ctx = alloc_ctx("Exception test");
+	if (IS_ERR(ctx)) {
+		pr_err("     FAIL: no context\n");
+		pass = false;
+		goto result;
+	}
+	ctx->pass = true;
+
+	ptr = alloc_test_page(ctx->pkey);
+	if (!ptr) {
+		pr_err("     FAIL: no vmalloc page\n");
+		pass = false;
+		goto free_context;
+	}
+
+	pks_mk_readonly(ctx->pkey);
+
+	spin_lock(&test_lock);
+	WRITE_ONCE(test_exception_ctx, ctx);
+	WRITE_ONCE(test_armed_key, ctx->pkey);
+
+	memcpy(ptr, ctx->data, 8);
+
+	if (!exception_caught()) {
+		pr_err("     FAIL: did not get an exception\n");
+		pass = false;
+	}
+
+	/*
+	 * NOTE The exception code has to enable access (b00) to keep the
+	 * fault from looping forever.  So we don't see the write disabled
+	 * restored but rather full access restored.  Also note that as part
+	 * of this test the exception callback attempted to disable access
+	 * completely (b11) and so we ensure that we are seeing the proper
+	 * thread value restored here.
+	 */
+	if (!check_pkrs(test_armed_key, 0)) {
+		pr_err("     FAIL: PKRS not restored\n");
+		pass = false;
+	}
+
+	if (!ctx->pass)
+		pass = false;
+
+	WRITE_ONCE(test_armed_key, 0);
+	spin_unlock(&test_lock);
+
+	vfree(ptr);
+free_context:
+	free_ctx(ctx);
+result:
+	pr_info("     ***** END: exception checking : %s\n",
+		 pass ? "PASS" : "FAIL");
+}
+
+static void run_all(void)
+{
+	struct pks_test_ctx *ctx[PKS_NUM_KEYS];
+	static char name[PKS_NUM_KEYS][64];
+	int i;
+
+	for (i = 1; i < PKS_NUM_KEYS; i++) {
+		sprintf(name[i], "pks ctx %d", i);
+		ctx[i] = alloc_ctx((const char *)name[i]);
+	}
+
+	for (i = 1; i < PKS_NUM_KEYS; i++) {
+		if (!IS_ERR(ctx[i]))
+			pks_run_test(ctx[i]);
+	}
+
+	for (i = 1; i < PKS_NUM_KEYS; i++) {
+		if (!IS_ERR(ctx[i]))
+			free_ctx(ctx[i]);
+	}
+
+	run_exception_test();
+}
+
+static void crash_it(void)
+{
+	struct pks_test_ctx *ctx;
+	void *ptr;
+
+	pr_warn("     ***** BEGIN: Unhandled fault test *****\n");
+
+	ctx = alloc_ctx("crashing kernel\n");
+
+	ptr = alloc_test_page(ctx->pkey);
+	if (!ptr) {
+		pr_err("Failed to vmalloc page???\n");
+		ctx->pass = false;
+		return;
+	}
+
+	pks_mk_noaccess(ctx->pkey);
+
+	spin_lock(&test_lock);
+	WRITE_ONCE(test_armed_key, 0);
+	/* This purposely faults */
+	memcpy(ptr, ctx->data, 8);
+	spin_unlock(&test_lock);
+
+	vfree(ptr);
+	free_ctx(ctx);
+}
+
+static ssize_t pks_write_file(struct file *file, const char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	char buf[2];
+	struct pks_test_ctx *ctx = file->private_data;
+
+	if (copy_from_user(buf, user_buf, 1))
+		return -EFAULT;
+	buf[1] = '\0';
+
+	/*
+	 * WARNING: Test "9" will crash the kernel.
+	 *
+	 * So we arm the test and print a warning.  A second "9" will run the
+	 * test.
+	 */
+	if (!strcmp(buf, "9")) {
+		if (run_9) {
+			crash_it();
+			run_9 = false;
+		} else {
+			pr_warn("CAUTION: Test 9 will crash in the kernel.\n");
+			pr_warn("         Specify 9 a second time to run\n");
+			pr_warn("         run any other test to clear\n");
+			run_9 = true;
+		}
+	} else {
+		run_9 = false;
+	}
+
+	/*
+	 * Test "3" will test allocating all keys. Do it first without
+	 * using "ctx".
+	 */
+	if (!strcmp(buf, "3"))
+		run_all();
+
+	if (!ctx) {
+		ctx = alloc_ctx("pks test");
+		if (IS_ERR(ctx))
+			return -ENOMEM;
+		file->private_data = ctx;
+	}
+
+	if (!strcmp(buf, "0"))
+		pks_run_test(ctx);
+
+	/* start of context switch test */
+	if (!strcmp(buf, "1")) {
+		/* Ensure a known state to test context switch */
+		pks_mk_noaccess(ctx->pkey);
+	}
+
+	/* After context switch msr should be restored */
+	if (!strcmp(buf, "2") && ctx->pks_cpu_enabled) {
+		unsigned long reg_pkrs;
+		int access;
+
+		rdmsrl(MSR_IA32_PKRS, reg_pkrs);
+
+		access = (reg_pkrs >> (ctx->pkey * PKR_BITS_PER_PKEY)) &
+			  PKEY_ACCESS_MASK;
+		if (access != (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)) {
+			ctx->pass = false;
+			pr_err("Context switch check failed\n");
+		}
+	}
+
+	return count;
+}
+
+static int pks_release_file(struct inode *inode, struct file *file)
+{
+	struct pks_test_ctx *ctx = file->private_data;
+
+	if (!ctx)
+		return 0;
+
+	free_ctx(ctx);
+	return 0;
+}
+
+static const struct file_operations fops_init_pks = {
+	.read = pks_read_file,
+	.write = pks_write_file,
+	.llseek = default_llseek,
+	.release = pks_release_file,
+};
+
+static int __init parse_pks_test_options(char *str)
+{
+	run_on_boot = true;
+
+	return 0;
+}
+early_param("pks-test-on-boot", parse_pks_test_options);
+
+static int __init pks_test_init(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_PKS)) {
+		if (run_on_boot)
+			run_all();
+
+		pks_test_dentry = debugfs_create_file("run_pks", 0600, arch_debugfs_dir,
+						      NULL, &fops_init_pks);
+	}
+
+	return 0;
+}
+late_initcall(pks_test_init);
+
+static void __exit pks_test_exit(void)
+{
+	debugfs_remove(pks_test_dentry);
+	pr_info("test exit\n");
+}
+module_exit(pks_test_exit);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 6703c7906b71..f5c80f952eab 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -13,7 +13,8 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
 			test_vdso test_vsyscall mov_ss_trap \
-			syscall_arg_fault fsgsbase_restore
+			syscall_arg_fault fsgsbase_restore test_pks
+
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
diff --git a/tools/testing/selftests/x86/test_pks.c b/tools/testing/selftests/x86/test_pks.c
new file mode 100644
index 000000000000..cd40f930b172
--- /dev/null
+++ b/tools/testing/selftests/x86/test_pks.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <assert.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#define PKS_TEST_FILE "/sys/kernel/debug/x86/run_pks"
+
+int main(void)
+{
+	cpu_set_t cpuset;
+	char result[32];
+	pid_t pid;
+	int fd;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+	/* Two processes run on CPU 0 so that they go through context switch. */
+	sched_setaffinity(getpid(), sizeof(cpu_set_t), &cpuset);
+
+	pid = fork();
+	if (pid == 0) {
+		fd = open(PKS_TEST_FILE, O_RDWR);
+		if (fd < 0) {
+			printf("cannot open %s\n", PKS_TEST_FILE);
+			return -1;
+		}
+
+		/* Allocate test_pkey1 and run test. */
+		write(fd, "0", 1);
+
+		/* Arm for context switch test */
+		write(fd, "1", 1);
+
+		/* Context switch out... */
+		sleep(4);
+
+		/* Check msr restored */
+		write(fd, "2", 1);
+	} else {
+		sleep(2);
+
+		fd = open(PKS_TEST_FILE, O_RDWR);
+		if (fd < 0) {
+			printf("cannot open %s\n", PKS_TEST_FILE);
+			return -1;
+		}
+
+		/* run test with alternate pkey */
+		write(fd, "0", 1);
+	}
+
+	read(fd, result, 10);
+	printf("#PF, context switch, pkey allocation and free tests: %s\n",
+	       result);
+
+	close(fd);
+
+	return 0;
+}
-- 
2.28.0.rc0.12.gb6a658bd00c9

