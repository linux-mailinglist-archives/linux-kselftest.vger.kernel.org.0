Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D505F522371
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 20:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348664AbiEJSNg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 14:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348577AbiEJSNZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 14:13:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C052DD79;
        Tue, 10 May 2022 11:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652206165; x=1683742165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DuxL9oYyXbFCTNHVeaGMeVzitcnd3IGWqcsktj8f+D8=;
  b=O+jIfJRxDvBASKYGexWSkXGE/AK6HIHagjccw/wD2nNMJqcZ9KTKfDm+
   dvRQqAlm5ZKL9/2ncs8AZ3cEycKm5PSUxwSHIx8mDokbKnnV1f525uVL1
   ikuzzikmHiHtdfI7BEcWESt8TvE1Dfng36XBKSHiZe6QDwtvyqJm6uBpX
   mZRnSEgOsTP8DDdIleHGKo56G+RzNMhqT0scyANTDGiCpfLbA43xYK7Ot
   BwR5l+3EAFvEZszQJb8n1xz/sMgVf91PjwKpT6KME5YTqEk162Z0WZ8dk
   j56b+ROP+MlEuhb5X0Fh9JVliA36Pu3QHQOY0RaSB/DfDL5a+7VrZOevU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="330057531"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="330057531"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="541908791"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:16 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 15/31] x86/sgx: Support restricting of enclave page permissions
Date:   Tue, 10 May 2022 11:08:51 -0700
Message-Id: <082cee986f3c1a2f4fdbf49501d7a8c5a98446f8.1652137848.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652137848.git.reinette.chatre@intel.com>
References: <cover.1652137848.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In the initial (SGX1) version of SGX, pages in an enclave need to be
created with permissions that support all usages of the pages, from the
time the enclave is initialized until it is unloaded. For example,
pages used by a JIT compiler or when code needs to otherwise be
relocated need to always have RWX permissions.

SGX2 includes a new function ENCLS[EMODPR] that is run from the kernel
and can be used to restrict the EPCM permissions of regular enclave
pages within an initialized enclave.

Introduce ioctl() SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS to support
restricting EPCM permissions. With this ioctl() the user specifies
a page range and the EPCM permissions to be applied to all pages in
the provided range. ENCLS[EMODPR] is run to restrict the EPCM
permissions followed by the ENCLS[ETRACK] flow that will ensure
no cached linear-to-physical address mappings to the changed
pages remain.

It is possible for the permission change request to fail on any
page within the provided range, either with an error encountered
by the kernel or by the SGX hardware while running
ENCLS[EMODPR]. To support partial success the ioctl() returns an
error code based on failures encountered by the kernel as well
as two result output parameters: one for the number of pages
that were successfully changed and one for the SGX return code.

The page table entry permissions are not impacted by the EPCM
permission changes. VMAs and PTEs will continue to allow the
maximum vetted permissions determined at the time the pages
are added to the enclave. The SGX error code in a page fault
will indicate if it was an EPCM permission check that prevented
an access attempt.

No checking is done to ensure that the permissions are actually
being restricted. This is because the enclave may have relaxed
the EPCM permissions from within the enclave without the kernel
knowing. An attempt to relax permissions using this call will
be ignored by the hardware.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Haitao Huang <haitao.huang@intel.com>
Tested-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V4:
- Add Vijay's Tested-by tag.
- Add Jarkko's Reviewed-by and Tested-by tags.
- Add Haitao's Tested-by tag.
- Revert change that required minimum of read permissions since
  requesting zero permissions is valid. Return earlier
  parameter check to ensure read permission accompanies write
  permission. (Vijay)

Changes since V3:
- User provides only new permissions, replacing secinfo. (Jarkko)
- Expand comments of sgx_enclave_etrack() to document the
  context in which the function is safe to use.

Changes since V2:
- Include the sgx_ioc_sgx2_ready() utility
  that previously was in "x86/sgx: Support relaxing of enclave page
  permissions" that is removed from the next version.
- Few renames requested by Jarkko:
  struct sgx_enclave_restrict_perm ->
         struct sgx_enclave_restrict_permissions
  sgx_enclave_restrict_perm()     ->
         sgx_enclave_restrict_permissions()
  sgx_ioc_enclave_restrict_perm() ->
         sgx_ioc_enclave_restrict_permissions()
- Make EPCM permissions independent from kernel view of
  permissions.  (Jarkko)
  - Remove attempt at runtime tracking of EPCM permissions
    (sgx_encl_page->vm_run_prot_bits).
  - Do not flush page table entries - they are no longer impacted by
    EPCM permission changes.
  - Modify changelog to reflect new architecture.
- Ensure at least PROT_READ is requested - enclave requires read
  access to the page for commands like EMODPE and EACCEPT. (Jarkko)

Changes since V1:
- Change terminology to use "relax" instead of "extend" to refer to
  the case when enclave page permissions are added (Dave).
- Use ioctl() in commit message (Dave).
- Add examples on what permissions would be allowed (Dave).
- Split enclave page permission changes into two ioctl()s, one for
  permission restricting (SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS)
  and one for permission relaxing (SGX_IOC_ENCLAVE_RELAX_PERMISSIONS)
  (Jarkko).
- In support of the ioctl() name change the following names have been
  changed:
  struct sgx_page_modp -> struct sgx_enclave_restrict_perm
  sgx_ioc_page_modp() -> sgx_ioc_enclave_restrict_perm()
  sgx_page_modp() -> sgx_enclave_restrict_perm()
- ioctl() takes entire secinfo as input instead of
  page permissions only (Jarkko).
- Fix kernel-doc to include () in function name.
- Create and use utility for the ETRACK flow.
- Fixups in comments
- Move kernel-doc to function that provides documentation for
  Documentation/x86/sgx.rst.
- Remove redundant comment.
- Make explicit which members of struct sgx_enclave_restrict_perm
  are for output (Dave).

 arch/x86/include/uapi/asm/sgx.h |  21 ++++
 arch/x86/kernel/cpu/sgx/ioctl.c | 216 ++++++++++++++++++++++++++++++++
 2 files changed, 237 insertions(+)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index f4b81587e90b..82648c006470 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -29,6 +29,8 @@ enum sgx_page_flags {
 	_IOW(SGX_MAGIC, 0x03, struct sgx_enclave_provision)
 #define SGX_IOC_VEPC_REMOVE_ALL \
 	_IO(SGX_MAGIC, 0x04)
+#define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
+	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_permissions)
 
 /**
  * struct sgx_enclave_create - parameter structure for the
@@ -76,6 +78,25 @@ struct sgx_enclave_provision {
 	__u64 fd;
 };
 
+/**
+ * struct sgx_enclave_restrict_permissions - parameters for ioctl
+ *                                        %SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
+ * @offset:	starting page offset (page aligned relative to enclave base
+ *		address defined in SECS)
+ * @length:	length of memory (multiple of the page size)
+ * @permissions:new permission bits for pages in range described by @offset
+ *              and @length
+ * @result:	(output) SGX result code of ENCLS[EMODPR] function
+ * @count:	(output) bytes successfully changed (multiple of page size)
+ */
+struct sgx_enclave_restrict_permissions {
+	__u64 offset;
+	__u64 length;
+	__u64 permissions;
+	__u64 result;
+	__u64 count;
+};
+
 struct sgx_enclave_run;
 
 /**
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 5d41aa204761..720188d86ed4 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -660,6 +660,218 @@ static long sgx_ioc_enclave_provision(struct sgx_encl *encl, void __user *arg)
 	return sgx_set_attribute(&encl->attributes_mask, params.fd);
 }
 
+/*
+ * Ensure enclave is ready for SGX2 functions. Readiness is checked
+ * by ensuring the hardware supports SGX2 and the enclave is initialized
+ * and thus able to handle requests to modify pages within it.
+ */
+static int sgx_ioc_sgx2_ready(struct sgx_encl *encl)
+{
+	if (!(cpu_feature_enabled(X86_FEATURE_SGX2)))
+		return -ENODEV;
+
+	if (!test_bit(SGX_ENCL_INITIALIZED, &encl->flags))
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Some SGX functions require that no cached linear-to-physical address
+ * mappings are present before they can succeed. Collaborate with
+ * hardware via ENCLS[ETRACK] to ensure that all cached
+ * linear-to-physical address mappings belonging to all threads of
+ * the enclave are cleared. See sgx_encl_cpumask() for details.
+ *
+ * Must be called with enclave's mutex held from the time the
+ * SGX function requiring that no cached linear-to-physical mappings
+ * are present is executed until this ETRACK flow is complete.
+ */
+static int sgx_enclave_etrack(struct sgx_encl *encl)
+{
+	void *epc_virt;
+	int ret;
+
+	epc_virt = sgx_get_epc_virt_addr(encl->secs.epc_page);
+	ret = __etrack(epc_virt);
+	if (ret) {
+		/*
+		 * ETRACK only fails when there is an OS issue. For
+		 * example, two consecutive ETRACK was sent without
+		 * completed IPI between.
+		 */
+		pr_err_once("ETRACK returned %d (0x%x)", ret, ret);
+		/*
+		 * Send IPIs to kick CPUs out of the enclave and
+		 * try ETRACK again.
+		 */
+		on_each_cpu_mask(sgx_encl_cpumask(encl), sgx_ipi_cb, NULL, 1);
+		ret = __etrack(epc_virt);
+		if (ret) {
+			pr_err_once("ETRACK repeat returned %d (0x%x)",
+				    ret, ret);
+			return -EFAULT;
+		}
+	}
+	on_each_cpu_mask(sgx_encl_cpumask(encl), sgx_ipi_cb, NULL, 1);
+
+	return 0;
+}
+
+/**
+ * sgx_enclave_restrict_permissions() - Restrict EPCM permissions
+ * @encl:	Enclave to which the pages belong.
+ * @modp:	Checked parameters from user on which pages need modifying and
+ *              their new permissions.
+ *
+ * Return:
+ * - 0:		Success.
+ * - -errno:	Otherwise.
+ */
+static long
+sgx_enclave_restrict_permissions(struct sgx_encl *encl,
+				 struct sgx_enclave_restrict_permissions *modp)
+{
+	struct sgx_encl_page *entry;
+	struct sgx_secinfo secinfo;
+	unsigned long addr;
+	unsigned long c;
+	void *epc_virt;
+	int ret;
+
+	memset(&secinfo, 0, sizeof(secinfo));
+	secinfo.flags = modp->permissions & SGX_SECINFO_PERMISSION_MASK;
+
+	for (c = 0 ; c < modp->length; c += PAGE_SIZE) {
+		addr = encl->base + modp->offset + c;
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
+		 * Changing EPCM permissions is only supported on regular
+		 * SGX pages. Attempting this change on other pages will
+		 * result in #PF.
+		 */
+		if (entry->type != SGX_PAGE_TYPE_REG) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		/*
+		 * Apart from ensuring that read-access remains, do not verify
+		 * the permission bits requested. Kernel has no control over
+		 * how EPCM permissions can be relaxed from within the enclave.
+		 * ENCLS[EMODPR] can only remove existing EPCM permissions,
+		 * attempting to set new permissions will be ignored by the
+		 * hardware.
+		 */
+
+		/* Change EPCM permissions. */
+		epc_virt = sgx_get_epc_virt_addr(entry->epc_page);
+		ret = __emodpr(&secinfo, epc_virt);
+		if (encls_faulted(ret)) {
+			/*
+			 * All possible faults should be avoidable:
+			 * parameters have been checked, will only change
+			 * permissions of a regular page, and no concurrent
+			 * SGX1/SGX2 ENCLS instructions since these
+			 * are protected with mutex.
+			 */
+			pr_err_once("EMODPR encountered exception %d\n",
+				    ENCLS_TRAPNR(ret));
+			ret = -EFAULT;
+			goto out_unlock;
+		}
+		if (encls_failed(ret)) {
+			modp->result = ret;
+			ret = -EFAULT;
+			goto out_unlock;
+		}
+
+		ret = sgx_enclave_etrack(encl);
+		if (ret) {
+			ret = -EFAULT;
+			goto out_unlock;
+		}
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
+	modp->count = c;
+
+	return ret;
+}
+
+/**
+ * sgx_ioc_enclave_restrict_permissions() - handler for
+ *                                        %SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS
+ * @encl:	an enclave pointer
+ * @arg:	userspace pointer to a &struct sgx_enclave_restrict_permissions
+ *		instance
+ *
+ * SGX2 distinguishes between relaxing and restricting the enclave page
+ * permissions maintained by the hardware (EPCM permissions) of pages
+ * belonging to an initialized enclave (after SGX_IOC_ENCLAVE_INIT).
+ *
+ * EPCM permissions cannot be restricted from within the enclave, the enclave
+ * requires the kernel to run the privileged level 0 instructions ENCLS[EMODPR]
+ * and ENCLS[ETRACK]. An attempt to relax EPCM permissions with this call
+ * will be ignored by the hardware.
+ *
+ * Return:
+ * - 0:		Success
+ * - -errno:	Otherwise
+ */
+static long sgx_ioc_enclave_restrict_permissions(struct sgx_encl *encl,
+						 void __user *arg)
+{
+	struct sgx_enclave_restrict_permissions params;
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
+	if (params.permissions & ~SGX_SECINFO_PERMISSION_MASK)
+		return -EINVAL;
+
+	/*
+	 * Fail early if invalid permissions requested to prevent ENCLS[EMODPR]
+	 * from faulting later when the CPU does the same check.
+	 */
+	if ((params.permissions & SGX_SECINFO_W) &&
+	    !(params.permissions & SGX_SECINFO_R))
+		return -EINVAL;
+
+	if (params.result || params.count)
+		return -EINVAL;
+
+	ret = sgx_enclave_restrict_permissions(encl, &params);
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
@@ -681,6 +893,10 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	case SGX_IOC_ENCLAVE_PROVISION:
 		ret = sgx_ioc_enclave_provision(encl, (void __user *)arg);
 		break;
+	case SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS:
+		ret = sgx_ioc_enclave_restrict_permissions(encl,
+							   (void __user *)arg);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
-- 
2.25.1

