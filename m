Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3472AA14B
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Nov 2020 00:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgKFX3j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 18:29:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:6401 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728971AbgKFX3h (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 18:29:37 -0500
IronPort-SDR: g3xz5ewhkGPgV2heYBE9ywq+ikQlSZd2ZYcVI63+AHxl9mE6KIIpxPhXHTGiEA55jXE9Qt03ss
 3DTJSQfOQd3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="169761084"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="169761084"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 15:29:36 -0800
IronPort-SDR: oJ4qP16GqiVLol5S/l+vImE4qLgOR+i9YlkkBN9/5avQg3oj0gbnAgdl4iA235XVX4UjkAEu+l
 zCDEturXBT3Q==
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="337730609"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 15:29:35 -0800
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH V3 08/10] x86/pks: Add PKS kernel API
Date:   Fri,  6 Nov 2020 15:29:06 -0800
Message-Id: <20201106232908.364581-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201106232908.364581-1-ira.weiny@intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

PKS allows kernel users to define domains of page mappings which have
additional protections beyond the paging protections.

Add an API to allocate, use, and free a protection key which identifies
such a domain.  Export 5 new symbols pks_key_alloc(), pks_mknoaccess(),
pks_mkread(), pks_mkrdwr(), and pks_key_free().  Add 2 new macros;
PAGE_KERNEL_PKEY(key) and _PAGE_PKEY(pkey).

Update the protection key documentation to cover pkeys on supervisor
pages.

Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

---
Changes from V2
	From Greg KH
		Replace all WARN_ON_ONCE() uses with pr_err()
	From Dan Williams
		Add __must_check to pks_key_alloc() to help ensure users
		are using the API correctly

Changes from V1
	Per Dave Hansen
		Add flags to pks_key_alloc() to help future proof the
		interface if/when the key space is exhausted.

Changes from RFC V3
	Per Dave Hansen
		Put WARN_ON_ONCE in pks_key_free()
		s/pks_mknoaccess/pks_mk_noaccess/
		s/pks_mkread/pks_mk_readonly/
		s/pks_mkrdwr/pks_mk_readwrite/
		Change return pks_key_alloc() to EOPNOTSUPP when not
			supported or configured
	Per Peter Zijlstra
		Remove unneeded preempt disable/enable
---
 Documentation/core-api/protection-keys.rst | 102 +++++++++++++---
 arch/x86/include/asm/pgtable_types.h       |  12 ++
 arch/x86/include/asm/pkeys.h               |  11 ++
 arch/x86/include/asm/pkeys_common.h        |   4 +
 arch/x86/mm/pkeys.c                        | 128 +++++++++++++++++++++
 include/linux/pgtable.h                    |   4 +
 include/linux/pkeys.h                      |  24 ++++
 7 files changed, 267 insertions(+), 18 deletions(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index ec575e72d0b2..c4e6c480562f 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -4,25 +4,33 @@
 Memory Protection Keys
 ======================
 
-Memory Protection Keys for Userspace (PKU aka PKEYs) is a feature
-which is found on Intel's Skylake (and later) "Scalable Processor"
-Server CPUs. It will be available in future non-server Intel parts
-and future AMD processors.
-
-For anyone wishing to test or use this feature, it is available in
-Amazon's EC2 C5 instances and is known to work there using an Ubuntu
-17.04 image.
-
 Memory Protection Keys provides a mechanism for enforcing page-based
 protections, but without requiring modification of the page tables
-when an application changes protection domains.  It works by
-dedicating 4 previously ignored bits in each page table entry to a
-"protection key", giving 16 possible keys.
+when an application changes protection domains.
+
+PKeys Userspace (PKU) is a feature which is found on Intel's Skylake "Scalable
+Processor" Server CPUs and later.  And It will be available in future
+non-server Intel parts and future AMD processors.
+
+Future Intel processors will support Protection Keys for Supervisor pages
+(PKS).
+
+For anyone wishing to test or use user space pkeys, it is available in Amazon's
+EC2 C5 instances and is known to work there using an Ubuntu 17.04 image.
+
+pkeys work by dedicating 4 previously Reserved bits in each page table entry to
+a "protection key", giving 16 possible keys.  User and Supervisor pages are
+treated separately.
+
+Protections for each page are controlled with per CPU registers for each type
+of page User and Supervisor.  Each of these 32 bit register stores two separate
+bits (Access Disable and Write Disable) for each key.
 
-There is also a new user-accessible register (PKRU) with two separate
-bits (Access Disable and Write Disable) for each key.  Being a CPU
-register, PKRU is inherently thread-local, potentially giving each
-thread a different set of protections from every other thread.
+For Userspace the register is user-accessible (rdpkru/wrpkru).  For
+Supervisor, the register (MSR_IA32_PKRS) is accessible only to the kernel.
+
+Being a CPU register, pkeys are inherently thread-local, potentially giving
+each thread an independent set of protections from every other thread.
 
 There are two new instructions (RDPKRU/WRPKRU) for reading and writing
 to the new register.  The feature is only available in 64-bit mode,
@@ -30,8 +38,11 @@ even though there is theoretically space in the PAE PTEs.  These
 permissions are enforced on data access only and have no effect on
 instruction fetches.
 
-Syscalls
-========
+For kernel space rdmsr/wrmsr are used to access the kernel MSRs.
+
+
+Syscalls for user space keys
+============================
 
 There are 3 system calls which directly interact with pkeys::
 
@@ -98,3 +109,58 @@ with a read()::
 The kernel will send a SIGSEGV in both cases, but si_code will be set
 to SEGV_PKERR when violating protection keys versus SEGV_ACCERR when
 the plain mprotect() permissions are violated.
+
+
+Kernel API for PKS support
+==========================
+
+The following interface is used to allocate, use, and free a pkey which defines
+a 'protection domain' within the kernel.  Setting a pkey value in a supervisor
+mapping adds that mapping to the protection domain.
+
+        int pks_key_alloc(const char * const pkey_user, int flags);
+        #define PAGE_KERNEL_PKEY(pkey)
+        #define _PAGE_KEY(pkey)
+        void pks_mk_noaccess(int pkey);
+        void pks_mk_readonly(int pkey);
+        void pks_mk_readwrite(int pkey);
+        void pks_key_free(int pkey);
+
+pks_key_alloc() allocates keys dynamically to allow better use of the limited
+key space.  'flags' alter the allocation based on the users need.  Currently
+they can request an exclusive key.
+
+Callers of pks_key_alloc() _must_ be prepared for it to fail and take
+appropriate action.  This is due mainly to the fact that PKS may not be
+available on all arch's.  Failure to check the return of pks_key_alloc() and
+using any of the rest of the API is undefined.
+
+Kernel users must set the PTE permissions in the page table entries for the
+mappings they want to protect.  This can be done with PAGE_KERNEL_PKEY() or
+_PAGE_KEY().
+
+The pks_mk*() family of calls allows kernel users the ability to change the
+protections for the domain identified by the pkey specified.  3 states are
+available pks_mk_noaccess(), pks_mk_readonly(), and pks_mk_readwrite() which
+set the access to none, read, and read/write respectively.
+
+Finally, pks_key_free() allows a user to return the key to the allocator for
+use by others.
+
+The interface maintains pks_mk_noaccess() (Access Disabled (AD=1)) for all keys
+not currently allocated.  Therefore, the user can depend on access being
+disabled when pks_key_alloc() returns a key and the user should remove mappings
+from the domain (remove the pkey from the PTE) prior to calling pks_key_free().
+
+It should be noted that the underlying WRMSR(MSR_IA32_PKRS) is not serializing
+but still maintains ordering properties similar to WRPKRU.  Thus it is safe to
+immediately use a mapping when the pks_mk*() functions returns.
+
+The current SDM section on PKRS needs updating but should be the same as that
+of WRPKRU.  So to quote from the WRPKRU text:
+
+	WRPKRU will never execute transiently. Memory accesses
+	affected by PKRU register will not execute (even transiently)
+	until all prior executions of WRPKRU have completed execution
+	and updated the PKRU register.
+
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 816b31c68550..c9fdfbdcbbfb 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -73,6 +73,12 @@
 			 _PAGE_PKEY_BIT2 | \
 			 _PAGE_PKEY_BIT3)
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+#define _PAGE_PKEY(pkey)	(_AT(pteval_t, pkey) << _PAGE_BIT_PKEY_BIT0)
+#else
+#define _PAGE_PKEY(pkey)	(_AT(pteval_t, 0))
+#endif
+
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 #define _PAGE_KNL_ERRATUM_MASK (_PAGE_DIRTY | _PAGE_ACCESSED)
 #else
@@ -229,6 +235,12 @@ enum page_cache_mode {
 #define PAGE_KERNEL_IO		__pgprot_mask(__PAGE_KERNEL_IO)
 #define PAGE_KERNEL_IO_NOCACHE	__pgprot_mask(__PAGE_KERNEL_IO_NOCACHE)
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+#define PAGE_KERNEL_PKEY(pkey)	__pgprot_mask(__PAGE_KERNEL | _PAGE_PKEY(pkey))
+#else
+#define PAGE_KERNEL_PKEY(pkey) PAGE_KERNEL
+#endif
+
 #endif	/* __ASSEMBLY__ */
 
 /*         xwr */
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 4526245b03e5..990fe9c4787c 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_PKEYS_H
 
 #include <asm/pkeys_common.h>
+#include <asm-generic/mman-common.h>
 
 #define ARCH_DEFAULT_PKEY	0
 
@@ -138,4 +139,14 @@ static inline int vma_pkey(struct vm_area_struct *vma)
 
 u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags);
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+__must_check int pks_key_alloc(const char *const pkey_user, int flags);
+void pks_key_free(int pkey);
+
+void pks_mk_noaccess(int pkey);
+void pks_mk_readonly(int pkey);
+void pks_mk_readwrite(int pkey);
+
+#endif /* CONFIG_ARCH_HAS_SUPERVISOR_PKEYS */
+
 #endif /*_ASM_X86_PKEYS_H */
diff --git a/arch/x86/include/asm/pkeys_common.h b/arch/x86/include/asm/pkeys_common.h
index 11a95e6efd2d..f921c58793f9 100644
--- a/arch/x86/include/asm/pkeys_common.h
+++ b/arch/x86/include/asm/pkeys_common.h
@@ -26,6 +26,10 @@
 			 PKR_AD_KEY(10) | PKR_AD_KEY(11) | PKR_AD_KEY(12) | \
 			 PKR_AD_KEY(13) | PKR_AD_KEY(14) | PKR_AD_KEY(15))
 
+/*  PKS supports 16 keys. Key 0 is reserved for the kernel. */
+#define        PKS_KERN_DEFAULT_KEY    0
+#define        PKS_NUM_KEYS            16
+
 #ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
 DECLARE_PER_CPU(u32, pkrs_cache);
 noinstr void write_pkrs(u32 new_pkrs);
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 6892d4524868..57718716cc70 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -3,6 +3,9 @@
  * Intel Memory Protection Keys management
  * Copyright (c) 2015, Intel Corporation.
  */
+#undef pr_fmt
+#define pr_fmt(fmt) "x86/pkeys: " fmt
+
 #include <linux/debugfs.h>		/* debugfs_create_u32()		*/
 #include <linux/mm_types.h>             /* mm_struct, vma, etc...       */
 #include <linux/pkeys.h>                /* PKEY_*                       */
@@ -231,6 +234,7 @@ u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
 
 	return pk_reg;
 }
+EXPORT_SYMBOL_GPL(update_pkey_val);
 
 DEFINE_PER_CPU(u32, pkrs_cache);
 
@@ -262,3 +266,127 @@ noinstr void write_pkrs(u32 new_pkrs)
 	}
 	put_cpu_ptr(pkrs);
 }
+EXPORT_SYMBOL_GPL(write_pkrs);
+
+/**
+ * Do not call this directly, see pks_mk*() below.
+ *
+ * @pkey: Key for the domain to change
+ * @protection: protection bits to be used
+ *
+ * Protection utilizes the same protection bits specified for User pkeys
+ *     PKEY_DISABLE_ACCESS
+ *     PKEY_DISABLE_WRITE
+ *
+ */
+static inline void pks_update_protection(int pkey, unsigned long protection)
+{
+	current->thread.saved_pkrs = update_pkey_val(current->thread.saved_pkrs,
+						     pkey, protection);
+	write_pkrs(current->thread.saved_pkrs);
+}
+
+/**
+ * PKS access control functions
+ *
+ * Change the access of the domain specified by the pkey.  These are global
+ * updates.  They only affects the current running thread.  It is undefined and
+ * a bug for users to call this without having allocated a pkey and using it as
+ * pkey here.
+ *
+ * pks_mk_noaccess()
+ *     Disable all access to the domain
+ * pks_mk_readonly()
+ *     Make the domain Read only
+ * pks_mk_readwrite()
+ *     Make the domain Read/Write
+ *
+ * @pkey the pkey for which the access should change.
+ *
+ */
+void pks_mk_noaccess(int pkey)
+{
+	pks_update_protection(pkey, PKEY_DISABLE_ACCESS);
+}
+EXPORT_SYMBOL_GPL(pks_mk_noaccess);
+
+void pks_mk_readonly(int pkey)
+{
+	pks_update_protection(pkey, PKEY_DISABLE_WRITE);
+}
+EXPORT_SYMBOL_GPL(pks_mk_readonly);
+
+void pks_mk_readwrite(int pkey)
+{
+	pks_update_protection(pkey, 0);
+}
+EXPORT_SYMBOL_GPL(pks_mk_readwrite);
+
+static const char pks_key_user0[] = "kernel";
+
+/* Store names of allocated keys for debug.  Key 0 is reserved for the kernel.  */
+static const char *pks_key_users[PKS_NUM_KEYS] = {
+	pks_key_user0
+};
+
+/*
+ * Each key is represented by a bit.  Bit 0 is set for key 0 and reserved for
+ * its use.  We use ulong for the bit operations but only 16 bits are used.
+ */
+static unsigned long pks_key_allocation_map = 1 << PKS_KERN_DEFAULT_KEY;
+
+/*
+ * pks_key_alloc - Allocate a PKS key
+ * @pkey_user: String stored for debugging of key exhaustion.  The caller is
+ *             responsible to maintain this memory until pks_key_free().
+ * @flags: Flags to modify behavior: see pks_alloc_flags
+ *
+ * Returns: pkey if success
+ *          -EOPNOTSUPP if pks is not supported or not enabled
+ *          -ENOSPC if no keys are available (even for sharing)
+ */
+__must_check int pks_key_alloc(const char * const pkey_user, int flags)
+{
+	int nr;
+
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return -EOPNOTSUPP;
+
+	while (1) {
+		nr = find_first_zero_bit(&pks_key_allocation_map, PKS_NUM_KEYS);
+		if (nr >= PKS_NUM_KEYS) {
+			pr_info("Cannot allocate supervisor key for %s.\n",
+				pkey_user);
+			return -ENOSPC;
+		}
+		if (!test_and_set_bit_lock(nr, &pks_key_allocation_map))
+			break;
+	}
+
+	/* for debugging key exhaustion */
+	pks_key_users[nr] = pkey_user;
+
+	return nr;
+}
+EXPORT_SYMBOL_GPL(pks_key_alloc);
+
+/*
+ * pks_key_free - Free a previously allocate PKS key
+ * @pkey: Key to be free'ed
+ */
+void pks_key_free(int pkey)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	if (pkey >= PKS_NUM_KEYS || pkey <= PKS_KERN_DEFAULT_KEY) {
+		pr_err("Invalid PKey value: %d\n", pkey);
+		return;
+	}
+
+	/* Restore to default of no access */
+	pks_mk_noaccess(pkey);
+	pks_key_users[pkey] = NULL;
+	__clear_bit(pkey, &pks_key_allocation_map);
+}
+EXPORT_SYMBOL_GPL(pks_key_free);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 38c33eabea89..cd72d73e8e1c 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1402,6 +1402,10 @@ static inline bool arch_has_pfn_modify_check(void)
 # define PAGE_KERNEL_EXEC PAGE_KERNEL
 #endif
 
+#ifndef PAGE_KERNEL_PKEY
+#define PAGE_KERNEL_PKEY(pkey) PAGE_KERNEL
+#endif
+
 /*
  * Page Table Modification bits for pgtbl_mod_mask.
  *
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 2955ba976048..bed0e293f13b 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -50,4 +50,28 @@ static inline void copy_init_pkru_to_fpregs(void)
 
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
+#define PKS_FLAG_EXCLUSIVE 0x00
+
+#ifndef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+static inline __must_check int pks_key_alloc(const char * const pkey_user, int flags)
+{
+	return -EOPNOTSUPP;
+}
+static inline void pks_key_free(int pkey)
+{
+}
+static inline void pks_mk_noaccess(int pkey)
+{
+	pr_err("%s is not valid without PKS support\n", __func__);
+}
+static inline void pks_mk_readonly(int pkey)
+{
+	pr_err("%s is not valid without PKS support\n", __func__);
+}
+static inline void pks_mk_readwrite(int pkey)
+{
+	pr_err("%s is not valid without PKS support\n", __func__);
+}
+#endif /* ! CONFIG_ARCH_HAS_SUPERVISOR_PKEYS */
+
 #endif /* _LINUX_PKEYS_H */
-- 
2.28.0.rc0.12.gb6a658bd00c9

