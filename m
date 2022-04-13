Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586735000BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbiDMVNX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239038AbiDMVNL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64893BBD4;
        Wed, 13 Apr 2022 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884249; x=1681420249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eLr5re2T/viyxP0posCVPiYzzqhEHZM6ilr1tybEJq8=;
  b=aGmiv5z2rC0U6wTkq4tEesdwVU59gKjJHz6ANzLgSMhKE0WNoDbBPnic
   g9cffcjGSQQlEFLVslVZ966djrB2MOOyDiMf+CCUyg+QPiJJ/BFdbgVs2
   y/nyuRdMg9KwGLDrpZxIzJ6QExR5fSnA4D6njP45aIyMANULfZAEJ6XEq
   OuEGselKsSKgIwUr5ENC7qdDBLw6YkA6KdDqMOVYBis8ia5L4KD84Zc3X
   Z7Ri2u3ukr6z8/nD9HpqNZNOnxSsUlaWZ0+VmPLqrB65B3SJtY4v8EJTT
   Ur74jlMj9kRtEPSiXlqcn62fK9fSO8kNSSRhqE/lSJdWmm0FU/9xoBikO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323219047"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323219047"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054296"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:45 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 19/31] x86/sgx: Support complete page removal
Date:   Wed, 13 Apr 2022 14:10:19 -0700
Message-Id: <f31cac6385336a19ddd25d5208319d0e856388ae.1649878359.git.reinette.chatre@intel.com>
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

The SGX2 page removal flow was introduced in previous patch and is
as follows:
1) Change the type of the pages to be removed to SGX_PAGE_TYPE_TRIM
   using the ioctl() SGX_IOC_ENCLAVE_MODIFY_TYPES introduced in
   previous patch.
2) Approve the page removal by running ENCLU[EACCEPT] from within
   the enclave.
3) Initiate actual page removal using the ioctl()
   SGX_IOC_ENCLAVE_REMOVE_PAGES introduced here.

Support the final step of the SGX2 page removal flow with ioctl()
SGX_IOC_ENCLAVE_REMOVE_PAGES. With this ioctl() the user specifies
a page range that should be removed. All pages in the provided
range should have the SGX_PAGE_TYPE_TRIM page type and the request
will fail with EPERM (Operation not permitted) if a page that does
not have the correct type is encountered. Page removal can fail
on any page within the provided range. Support partial success by
returning the number of pages that were successfully removed.

Since actual page removal will succeed even if ENCLU[EACCEPT] was not
run from within the enclave the ENCLU[EMODPR] instruction with RWX
permissions is used as a no-op mechanism to ensure ENCLU[EACCEPT] was
successfully run from within the enclave before the enclave page is
removed.

If the user omits running SGX_IOC_ENCLAVE_REMOVE_PAGES the pages will
still be removed when the enclave is unloaded.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V3:
- Add Jarkko's Reviewed-by tag.
- Rename SGX_IOC_ENCLAVE_MODIFY_TYPE to
  SGX_IOC_ENCLAVE_MODIFY_TYPES. (Jarkko)

Changes since V2:
- Adjust ioctl number since removal of
  SGX_IOC_ENCLAVE_RELAX_PERMISSIONS.

Changes since V1:
- Update comments to refer to new ioctl() names SGX_IOC_PAGE_MODT ->
  SGX_IOC_ENCLAVE_MODIFY_TYPE.
- Fix kernel-doc to have () as part of function name.
- Change name of ioctl():
  SGX_IOC_PAGE_REMOVE -> SGX_IOC_ENCLAVE_REMOVE_PAGES (Jarkko).
- With the above name change the page removal ioctl() has its name
  aligned with existing SGX_IOC_ENCLAVE_ADD_PAGES ioctl(). Also align
  naming of struct and functions:
  struct sgx_page_remove -> struct sgx_enclave_remove_pages
  sgx_page_remove() -> sgx_encl_remove_pages()
  sgx_ioc_page_remove() -> sgx_ioc_enclave_remove_pages()
- Use new SGX2 checking helper.
- When loading enclave page, make error code consistent with other
  instances to help user distinguish between permanent and temporary
  failures.
- Move kernel-doc to function that provides documentation for
  Documentation/x86/sgx.rst.
- Remove redundant comment.
- Use offset/length validation utility.
- Make explicit which member of struct sgx_enclave_remove_pages is for
  output (Dave).

 arch/x86/include/uapi/asm/sgx.h |  21 +++++
 arch/x86/kernel/cpu/sgx/ioctl.c | 145 ++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index de4d1af628d5..ec708bd30528 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -33,6 +33,8 @@ enum sgx_page_flags {
 	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_permissions)
 #define SGX_IOC_ENCLAVE_MODIFY_TYPES \
 	_IOWR(SGX_MAGIC, 0x06, struct sgx_enclave_modify_type)
+#define SGX_IOC_ENCLAVE_REMOVE_PAGES \
+	_IOWR(SGX_MAGIC, 0x07, struct sgx_enclave_remove_pages)
 
 /**
  * struct sgx_enclave_create - parameter structure for the
@@ -116,6 +118,25 @@ struct sgx_enclave_modify_type {
 	__u64 count;
 };
 
+/**
+ * struct sgx_enclave_remove_pages - %SGX_IOC_ENCLAVE_REMOVE_PAGES parameters
+ * @offset:	starting page offset (page aligned relative to enclave base
+ *		address defined in SECS)
+ * @length:	length of memory (multiple of the page size)
+ * @count:	(output) bytes successfully changed (multiple of page size)
+ *
+ * Regular (PT_REG) or TCS (PT_TCS) can be removed from an initialized
+ * enclave if the system supports SGX2. First, the %SGX_IOC_ENCLAVE_MODIFY_TYPES
+ * ioctl() should be used to change the page type to PT_TRIM. After that
+ * succeeds ENCLU[EACCEPT] should be run from within the enclave and then
+ * %SGX_IOC_ENCLAVE_REMOVE_PAGES can be used to complete the page removal.
+ */
+struct sgx_enclave_remove_pages {
+	__u64 offset;
+	__u64 length;
+	__u64 count;
+};
+
 struct sgx_enclave_run;
 
 /**
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 8709f131ae40..f9a1654a49b7 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -1070,6 +1070,148 @@ static long sgx_ioc_enclave_modify_type(struct sgx_encl *encl, void __user *arg)
 	return ret;
 }
 
+/**
+ * sgx_encl_remove_pages() - Remove trimmed pages from SGX enclave
+ * @encl:	Enclave to which the pages belong
+ * @params:	Checked parameters from user on which pages need to be removed
+ *
+ * Return:
+ * - 0:		Success.
+ * - -errno:	Otherwise.
+ */
+static long sgx_encl_remove_pages(struct sgx_encl *encl,
+				  struct sgx_enclave_remove_pages *params)
+{
+	struct sgx_encl_page *entry;
+	struct sgx_secinfo secinfo;
+	unsigned long addr;
+	unsigned long c;
+	void *epc_virt;
+	int ret;
+
+	memset(&secinfo, 0, sizeof(secinfo));
+	secinfo.flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_X;
+
+	for (c = 0 ; c < params->length; c += PAGE_SIZE) {
+		addr = encl->base + params->offset + c;
+
+		mutex_lock(&encl->lock);
+
+		entry = sgx_encl_load_page(encl, addr);
+		if (IS_ERR(entry)) {
+			ret = PTR_ERR(entry) == -EBUSY ? -EAGAIN : -EFAULT;
+			goto out_unlock;
+		}
+
+		if (entry->type != SGX_PAGE_TYPE_TRIM) {
+			ret = -EPERM;
+			goto out_unlock;
+		}
+
+		/*
+		 * ENCLS[EMODPR] is a no-op instruction used to inform if
+		 * ENCLU[EACCEPT] was run from within the enclave. If
+		 * ENCLS[EMODPR] is run with RWX on a trimmed page that is
+		 * not yet accepted then it will return
+		 * %SGX_PAGE_NOT_MODIFIABLE, after the trimmed page is
+		 * accepted the instruction will encounter a page fault.
+		 */
+		epc_virt = sgx_get_epc_virt_addr(entry->epc_page);
+		ret = __emodpr(&secinfo, epc_virt);
+		if (!encls_faulted(ret) || ENCLS_TRAPNR(ret) != X86_TRAP_PF) {
+			ret = -EPERM;
+			goto out_unlock;
+		}
+
+		if (sgx_unmark_page_reclaimable(entry->epc_page)) {
+			ret = -EBUSY;
+			goto out_unlock;
+		}
+
+		/*
+		 * Do not keep encl->lock because of dependency on
+		 * mmap_lock acquired in sgx_zap_enclave_ptes().
+		 */
+		mutex_unlock(&encl->lock);
+
+		sgx_zap_enclave_ptes(encl, addr);
+
+		mutex_lock(&encl->lock);
+
+		sgx_encl_free_epc_page(entry->epc_page);
+		encl->secs_child_cnt--;
+		entry->epc_page = NULL;
+		xa_erase(&encl->page_array, PFN_DOWN(entry->desc));
+		sgx_encl_shrink(encl, NULL);
+		kfree(entry);
+
+		mutex_unlock(&encl->lock);
+	}
+
+	ret = 0;
+	goto out;
+
+out_unlock:
+	mutex_unlock(&encl->lock);
+out:
+	params->count = c;
+
+	return ret;
+}
+
+/**
+ * sgx_ioc_enclave_remove_pages() - handler for %SGX_IOC_ENCLAVE_REMOVE_PAGES
+ * @encl:	an enclave pointer
+ * @arg:	userspace pointer to &struct sgx_enclave_remove_pages instance
+ *
+ * Final step of the flow removing pages from an initialized enclave. The
+ * complete flow is:
+ *
+ * 1) User changes the type of the pages to be removed to %SGX_PAGE_TYPE_TRIM
+ *    using the %SGX_IOC_ENCLAVE_MODIFY_TYPES ioctl().
+ * 2) User approves the page removal by running ENCLU[EACCEPT] from within
+ *    the enclave.
+ * 3) User initiates actual page removal using the
+ *    %SGX_IOC_ENCLAVE_REMOVE_PAGES ioctl() that is handled here.
+ *
+ * First remove any page table entries pointing to the page and then proceed
+ * with the actual removal of the enclave page and data in support of it.
+ *
+ * VA pages are not affected by this removal. It is thus possible that the
+ * enclave may end up with more VA pages than needed to support all its
+ * pages.
+ *
+ * Return:
+ * - 0:		Success
+ * - -errno:	Otherwise
+ */
+static long sgx_ioc_enclave_remove_pages(struct sgx_encl *encl,
+					 void __user *arg)
+{
+	struct sgx_enclave_remove_pages params;
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
+	if (params.count)
+		return -EINVAL;
+
+	ret = sgx_encl_remove_pages(encl, &params);
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
@@ -1098,6 +1240,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	case SGX_IOC_ENCLAVE_MODIFY_TYPES:
 		ret = sgx_ioc_enclave_modify_type(encl, (void __user *)arg);
 		break;
+	case SGX_IOC_ENCLAVE_REMOVE_PAGES:
+		ret = sgx_ioc_enclave_remove_pages(encl, (void __user *)arg);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
-- 
2.25.1

