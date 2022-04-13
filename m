Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D635000D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbiDMVNo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239036AbiDMVNL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C063A5C1;
        Wed, 13 Apr 2022 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884248; x=1681420248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F8b7P8OJqPH4ahg0MtAEokKjriaMg1rgYIqoxz3/QyI=;
  b=LUCRXbX1s9ehXrEzcwejAldQuR7YnKMuWWd1KLeBykm9K+ryvxP/Lgcx
   78CFW9EKZ1Q29LRU+xWyHOeCNPd60K66wQJxRAdFIZo3i/sBA/LLRHUDM
   JkDfQDf7X3zei3ZvJU8cpWPjIoh75Cqiuy9L1ZOR0AZc70IX60EW4aa9Y
   O2KMQVex72rKPsK+vc/73fUL5j6NFNfsodIZ0ChgT9Ujx7agv1pFaxPFr
   B1Wg1KJChiz2NS2fzjP09UpVDev7Pq8Cu4Qk1dOHJePIUyTmEW1wjF5RC
   g8X36G2Xw4fZNcSEhTe15XJQ9M31WwI33j7mBYjSucLlQnZdkE8o2IbU0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323219044"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323219044"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054293"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:44 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 18/31] x86/sgx: Support modifying SGX page type
Date:   Wed, 13 Apr 2022 14:10:18 -0700
Message-Id: <bd6442f4b0d5bd380664a9e5abaf41637cb298f5.1649878359.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649878359.git.reinette.chatre@intel.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Every enclave contains one or more Thread Control Structures (TCS). The
TCS contains meta-data used by the hardware to save and restore thread
specific information when entering/exiting the enclave. With SGX1 an
enclave needs to be created with enough TCSs to support the largest
number of threads expecting to use the enclave and enough enclave pages
to meet all its anticipated memory demands. In SGX1 all pages remain in
the enclave until the enclave is unloaded.

SGX2 introduces a new function, ENCLS[EMODT], that is used to change
the type of an enclave page from a regular (SGX_PAGE_TYPE_REG) enclave
page to a TCS (SGX_PAGE_TYPE_TCS) page or change the type from a
regular (SGX_PAGE_TYPE_REG) or TCS (SGX_PAGE_TYPE_TCS)
page to a trimmed (SGX_PAGE_TYPE_TRIM) page (setting it up for later
removal).

With the existing support of dynamically adding regular enclave pages
to an initialized enclave and changing the page type to TCS it is
possible to dynamically increase the number of threads supported by an
enclave.

Changing the enclave page type to SGX_PAGE_TYPE_TRIM is the first step
of dynamically removing pages from an initialized enclave. The complete
page removal flow is:
1) Change the type of the pages to be removed to SGX_PAGE_TYPE_TRIM
   using the SGX_IOC_ENCLAVE_MODIFY_TYPES ioctl() introduced here.
2) Approve the page removal by running ENCLU[EACCEPT] from within
   the enclave.
3) Initiate actual page removal using the ioctl() introduced in the
   following patch.

Add ioctl() SGX_IOC_ENCLAVE_MODIFY_TYPES to support changing SGX
enclave page types within an initialized enclave. With
SGX_IOC_ENCLAVE_MODIFY_TYPES the user specifies a page range and the
enclave page type to be applied to all pages in the provided range.
The ioctl() itself can return an error code based on failures
encountered by the kernel. It is also possible for SGX specific
failures to be encountered.  Add a result output parameter to
communicate the SGX return code. It is possible for the enclave page
type change request to fail on any page within the provided range.
Support partial success by returning the number of pages that were
successfully changed.

After the page type is changed the page continues to be accessible
from the kernel perspective with page table entries and internal
state. The page may be moved to swap. Any access until ENCLU[EACCEPT]
will encounter a page fault with SGX flag set in error code.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V3:
- Rename ioctl() SGX_IOC_ENCLAVE_MODIFY_TYPE to
  SGX_IOC_ENCLAVE_MODIFY_TYPES. (Jarkko)
- User provides just page type, replacing secinfo. (Jarkko)

Changes since V2:
- Adjust ioctl number after removal of SGX_IOC_ENCLAVE_RELAX_PERMISSIONS.
- Remove attempt at runtime tracking of EPCM permissions
  (sgx_encl_page->vm_run_prot_bits). (Jarkko)
- Change names to follow guidance of using detailed names (Jarkko):
  struct sgx_enclave_modt -> struct sgx_enclave_modify_type
  sgx_enclave_modt() -> sgx_enclave_modify_type()
  sgx_ioc_enclave_modt() -> sgx_ioc_enclave_modify_type()

Changes since V1:
- Remove the "Earlier changes ..." paragraph (Jarkko).
- Change "new ioctl" text to "Add SGX_IOC_ENCLAVE_MOD_TYPE" (Jarkko).
- Discussion about EPCM interaction and the EPCM MODIFIED bit is moved
  to new patch that introduces the ENCLS[EMODT] wrapper while keeping
  the higher level discussion on page accessibility in
  this commit log (Jarkko).
- Rename SGX_IOC_PAGE_MODT ioctl() to SGX_IOC_ENCLAVE_MODIFY_TYPE
  (Jarkko).
- Rename struct sgx_page_modt to struct sgx_enclave_modt in support
  of ioctl() rename.
- Rename sgx_page_modt() to sgx_enclave_modt() and sgx_ioc_page_modt()
  to sgx_ioc_enclave_modt() in support of ioctl() rename.
- Provide secinfo as parameter to ioctl() instead of just
  page type (Jarkko).
- Update comments to refer to new ioctl() names.
- Use new SGX2 checking helper().
- Use ETRACK flow utility.
- Move kernel-doc to function that provides documentation for
  Documentation/x86/sgx.rst.
- Remove redundant comment.
- Use offset/length validation utility.
- Make explicit which members of struct sgx_enclave_modt are for
  output (Dave).

 arch/x86/include/uapi/asm/sgx.h |  19 +++
 arch/x86/kernel/cpu/sgx/ioctl.c | 201 ++++++++++++++++++++++++++++++++
 2 files changed, 220 insertions(+)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 82648c006470..de4d1af628d5 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -31,6 +31,8 @@ enum sgx_page_flags {
 	_IO(SGX_MAGIC, 0x04)
 #define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
 	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_permissions)
+#define SGX_IOC_ENCLAVE_MODIFY_TYPES \
+	_IOWR(SGX_MAGIC, 0x06, struct sgx_enclave_modify_type)
 
 /**
  * struct sgx_enclave_create - parameter structure for the
@@ -97,6 +99,23 @@ struct sgx_enclave_restrict_permissions {
 	__u64 count;
 };
 
+/**
+ * struct sgx_enclave_modify_type - parameters for %SGX_IOC_ENCLAVE_MODIFY_TYPES
+ * @offset:	starting page offset (page aligned relative to enclave base
+ *		address defined in SECS)
+ * @length:	length of memory (multiple of the page size)
+ * @page_type:	new type for pages in range described by @offset and @length
+ * @result:	(output) SGX result code of ENCLS[EMODT] function
+ * @count:	(output) bytes successfully changed (multiple of page size)
+ */
+struct sgx_enclave_modify_type {
+	__u64 offset;
+	__u64 length;
+	__u64 page_type;
+	__u64 result;
+	__u64 count;
+};
+
 struct sgx_enclave_run;
 
 /**
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 395b4e58a295..8709f131ae40 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -872,6 +872,204 @@ static long sgx_ioc_enclave_restrict_permissions(struct sgx_encl *encl,
 	return ret;
 }
 
+/**
+ * sgx_enclave_modify_type() - Modify type of SGX enclave pages
+ * @encl:	Enclave to which the pages belong.
+ * @modt:	Checked parameters from user about which pages need modifying
+ *              and their new page type.
+ *
+ * Return:
+ * - 0:		Success
+ * - -errno:	Otherwise
+ */
+static long sgx_enclave_modify_type(struct sgx_encl *encl,
+				    struct sgx_enclave_modify_type *modt)
+{
+	unsigned long max_prot_restore;
+	enum sgx_page_type page_type;
+	struct sgx_encl_page *entry;
+	struct sgx_secinfo secinfo;
+	unsigned long prot;
+	unsigned long addr;
+	unsigned long c;
+	void *epc_virt;
+	int ret;
+
+	page_type = modt->page_type & SGX_PAGE_TYPE_MASK;
+
+	/*
+	 * The only new page types allowed by hardware are PT_TCS and PT_TRIM.
+	 */
+	if (page_type != SGX_PAGE_TYPE_TCS && page_type != SGX_PAGE_TYPE_TRIM)
+		return -EINVAL;
+
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	secinfo.flags = page_type << 8;
+
+	for (c = 0 ; c < modt->length; c += PAGE_SIZE) {
+		addr = encl->base + modt->offset + c;
+
+		mutex_lock(&encl->lock);
+
+		entry = sgx_encl_load_page(encl, addr);
+		if (IS_ERR(entry)) {
+			ret = PTR_ERR(entry) == -EBUSY ? -EAGAIN : -EFAULT;
+			goto out_unlock;
+		}
+
+		/*
+		 * Borrow the logic from the Intel SDM. Regular pages
+		 * (SGX_PAGE_TYPE_REG) can change type to SGX_PAGE_TYPE_TCS
+		 * or SGX_PAGE_TYPE_TRIM but TCS pages can only be trimmed.
+		 * CET pages not supported yet.
+		 */
+		if (!(entry->type == SGX_PAGE_TYPE_REG ||
+		      (entry->type == SGX_PAGE_TYPE_TCS &&
+		       page_type == SGX_PAGE_TYPE_TRIM))) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		max_prot_restore = entry->vm_max_prot_bits;
+
+		/*
+		 * Once a regular page becomes a TCS page it cannot be
+		 * changed back. So the maximum allowed protection reflects
+		 * the TCS page that is always RW from kernel perspective but
+		 * will be inaccessible from within enclave. Before doing
+		 * so, do make sure that the new page type continues to
+		 * respect the originally vetted page permissions.
+		 */
+		if (entry->type == SGX_PAGE_TYPE_REG &&
+		    page_type == SGX_PAGE_TYPE_TCS) {
+			if (~entry->vm_max_prot_bits & (VM_READ | VM_WRITE)) {
+				ret = -EPERM;
+				goto out_unlock;
+			}
+			prot = PROT_READ | PROT_WRITE;
+			entry->vm_max_prot_bits = calc_vm_prot_bits(prot, 0);
+
+			/*
+			 * Prevent page from being reclaimed while mutex
+			 * is released.
+			 */
+			if (sgx_unmark_page_reclaimable(entry->epc_page)) {
+				ret = -EAGAIN;
+				goto out_entry_changed;
+			}
+
+			/*
+			 * Do not keep encl->lock because of dependency on
+			 * mmap_lock acquired in sgx_zap_enclave_ptes().
+			 */
+			mutex_unlock(&encl->lock);
+
+			sgx_zap_enclave_ptes(encl, addr);
+
+			mutex_lock(&encl->lock);
+
+			sgx_mark_page_reclaimable(entry->epc_page);
+		}
+
+		/* Change EPC type */
+		epc_virt = sgx_get_epc_virt_addr(entry->epc_page);
+		ret = __emodt(&secinfo, epc_virt);
+		if (encls_faulted(ret)) {
+			/*
+			 * All possible faults should be avoidable:
+			 * parameters have been checked, will only change
+			 * valid page types, and no concurrent
+			 * SGX1/SGX2 ENCLS instructions since these are
+			 * protected with mutex.
+			 */
+			pr_err_once("EMODT encountered exception %d\n",
+				    ENCLS_TRAPNR(ret));
+			ret = -EFAULT;
+			goto out_entry_changed;
+		}
+		if (encls_failed(ret)) {
+			modt->result = ret;
+			ret = -EFAULT;
+			goto out_entry_changed;
+		}
+
+		ret = sgx_enclave_etrack(encl);
+		if (ret) {
+			ret = -EFAULT;
+			goto out_unlock;
+		}
+
+		entry->type = page_type;
+
+		mutex_unlock(&encl->lock);
+	}
+
+	ret = 0;
+	goto out;
+
+out_entry_changed:
+	entry->vm_max_prot_bits = max_prot_restore;
+out_unlock:
+	mutex_unlock(&encl->lock);
+out:
+	modt->count = c;
+
+	return ret;
+}
+
+/**
+ * sgx_ioc_enclave_modify_type() - handler for %SGX_IOC_ENCLAVE_MODIFY_TYPES
+ * @encl:	an enclave pointer
+ * @arg:	userspace pointer to a &struct sgx_enclave_modify_type instance
+ *
+ * Ability to change the enclave page type supports the following use cases:
+ *
+ * * It is possible to add TCS pages to an enclave by changing the type of
+ *   regular pages (%SGX_PAGE_TYPE_REG) to TCS (%SGX_PAGE_TYPE_TCS) pages.
+ *   With this support the number of threads supported by an initialized
+ *   enclave can be increased dynamically.
+ *
+ * * Regular or TCS pages can dynamically be removed from an initialized
+ *   enclave by changing the page type to %SGX_PAGE_TYPE_TRIM. Changing the
+ *   page type to %SGX_PAGE_TYPE_TRIM marks the page for removal with actual
+ *   removal done by handler of %SGX_IOC_ENCLAVE_REMOVE_PAGES ioctl() called
+ *   after ENCLU[EACCEPT] is run on %SGX_PAGE_TYPE_TRIM page from within the
+ *   enclave.
+ *
+ * Return:
+ * - 0:		Success
+ * - -errno:	Otherwise
+ */
+static long sgx_ioc_enclave_modify_type(struct sgx_encl *encl, void __user *arg)
+{
+	struct sgx_enclave_modify_type params;
+	long ret;
+
+	ret = sgx_ioc_sgx2_ready(encl);
+	if (ret)
+		return ret;
+
+	if (copy_from_user(&params, arg, sizeof(params)))
+		return -EFAULT;
+
+	if (sgx_validate_offset_length(encl, params.offset, params.length))
+		return -EINVAL;
+
+	if (params.page_type & ~SGX_PAGE_TYPE_MASK)
+		return -EINVAL;
+
+	if (params.result || params.count)
+		return -EINVAL;
+
+	ret = sgx_enclave_modify_type(encl, &params);
+
+	if (copy_to_user(arg, &params, sizeof(params)))
+		return -EFAULT;
+
+	return ret;
+}
+
 long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 {
 	struct sgx_encl *encl = filep->private_data;
@@ -897,6 +1095,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		ret = sgx_ioc_enclave_restrict_permissions(encl,
 							   (void __user *)arg);
 		break;
+	case SGX_IOC_ENCLAVE_MODIFY_TYPES:
+		ret = sgx_ioc_enclave_modify_type(encl, (void __user *)arg);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
-- 
2.25.1

