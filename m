Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ECE7D7B14
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 04:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjJZCx5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 22:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbjJZCxz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 22:53:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C331AB;
        Wed, 25 Oct 2023 19:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698288831; x=1729824831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SXBnjgZAYdAreHu7Ix6g3uSQoirCPPblBK4F+Kofnoo=;
  b=ebV8JrX/CiZAh9I3JYl1q/BDVZxzNeCHEtT5X3EmbB1b6QlelHJDExHj
   2laAcu7dPDFeLmhL4ELg5BEnpCd+bC2YBJRaJ9ZingpX9Opb+HqvoUX5E
   xPyopKwV5U+QgFjLzptyMjlZcPyklWSFUhmVVqlBEDgURj1RfRIC9A051
   zaTyLdZ45jGnMva2LsBtXGovmBDg5gqE4Ze8qpPQSh5TPVoC4ggan1uld
   HtHX9uzwauuH4WSav15f26PGvhGl/3ZYF9+CDoWZLwlFkn85+Ifa7VEit
   LW+Ez+GAl8y+HbI56zOjbbEnWBBLUg8Do4n2IT6l+OCnK6sjHC+VQ4vDT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="391316188"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="391316188"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 19:53:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="735604545"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="735604545"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga006.jf.intel.com with ESMTP; 25 Oct 2023 19:53:46 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Date:   Thu, 26 Oct 2023 10:49:28 +0800
Message-Id: <20231026024930.382898-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026024930.382898-1-baolu.lu@linux.intel.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the file interface that provides a simple and efficient way for
userspace to handle page faults. The file interface allows userspace
to read fault messages sequentially, and to respond to the handling
result by writing to the same file.

Userspace applications are recommended to use io_uring to speed up read
and write efficiency.

With this done, allow userspace application to allocate a hw page table
with IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag set.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h |   2 +
 drivers/iommu/iommufd/hw_pagetable.c    | 204 +++++++++++++++++++++++-
 2 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 0dbaa2dc5b22..ff063bc48150 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -237,6 +237,8 @@ struct hw_pgtable_fault {
 	struct mutex mutex;
 	struct list_head deliver;
 	struct list_head response;
+	struct file *fault_file;
+	int fault_fd;
 };
 
 /*
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 9f94c824cf86..f0aac1bb2d2d 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
 #include <linux/iommu.h>
+#include <linux/file.h>
+#include <linux/anon_inodes.h>
 #include <uapi/linux/iommufd.h>
 
 #include "../iommu-priv.h"
@@ -38,9 +40,198 @@ static void iommufd_kernel_managed_hwpt_destroy(struct iommufd_object *obj)
 	refcount_dec(&hwpt->ioas->obj.users);
 }
 
+static int iommufd_compose_fault_message(struct iommu_fault *fault,
+					 struct iommu_hwpt_pgfault *hwpt_fault,
+					 struct device *dev)
+{
+	struct iommufd_device *idev = iopf_pasid_cookie_get(dev, IOMMU_NO_PASID);
+
+	if (!idev)
+		return -ENODEV;
+
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	hwpt_fault->size = sizeof(*hwpt_fault);
+	hwpt_fault->flags = fault->prm.flags;
+	hwpt_fault->dev_id = idev->obj.id;
+	hwpt_fault->pasid = fault->prm.pasid;
+	hwpt_fault->grpid = fault->prm.grpid;
+	hwpt_fault->perm = fault->prm.perm;
+	hwpt_fault->addr = fault->prm.addr;
+	hwpt_fault->private_data[0] = fault->prm.private_data[0];
+	hwpt_fault->private_data[1] = fault->prm.private_data[1];
+
+	return 0;
+}
+
+static ssize_t hwpt_fault_fops_read(struct file *filep, char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
+	struct hw_pgtable_fault *fault = filep->private_data;
+	struct iommu_hwpt_pgfault data;
+	struct iopf_group *group;
+	struct iopf_fault *iopf;
+	size_t done = 0;
+	int rc;
+
+	if (*ppos || count % fault_size)
+		return -ESPIPE;
+
+	mutex_lock(&fault->mutex);
+	while (!list_empty(&fault->deliver) && count > done) {
+		group = list_first_entry(&fault->deliver,
+					 struct iopf_group, node);
+
+		if (list_count_nodes(&group->faults) * fault_size > count - done)
+			break;
+
+		list_for_each_entry(iopf, &group->faults, list) {
+			rc = iommufd_compose_fault_message(&iopf->fault,
+							   &data, group->dev);
+			if (rc)
+				goto err_unlock;
+			rc = copy_to_user(buf + done, &data, fault_size);
+			if (rc)
+				goto err_unlock;
+			done += fault_size;
+		}
+
+		list_move_tail(&group->node, &fault->response);
+	}
+	mutex_unlock(&fault->mutex);
+
+	return done;
+err_unlock:
+	mutex_unlock(&fault->mutex);
+	return rc;
+}
+
+static ssize_t hwpt_fault_fops_write(struct file *filep,
+				     const char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	size_t response_size = sizeof(struct iommu_hwpt_page_response);
+	struct hw_pgtable_fault *fault = filep->private_data;
+	struct iommu_hwpt_page_response response;
+	struct iommufd_hw_pagetable *hwpt;
+	struct iopf_group *iter, *group;
+	struct iommufd_device *idev;
+	size_t done = 0;
+	int rc = 0;
+
+	if (*ppos || count % response_size)
+		return -ESPIPE;
+
+	mutex_lock(&fault->mutex);
+	while (!list_empty(&fault->response) && count > done) {
+		rc = copy_from_user(&response, buf + done, response_size);
+		if (rc)
+			break;
+
+		/* Get the device that this response targets at. */
+		idev = container_of(iommufd_get_object(fault->ictx,
+						       response.dev_id,
+						       IOMMUFD_OBJ_DEVICE),
+				    struct iommufd_device, obj);
+		if (IS_ERR(idev)) {
+			rc = PTR_ERR(idev);
+			break;
+		}
+
+		/*
+		 * Get the hw page table that this response was generated for.
+		 * It must match the one stored in the fault data.
+		 */
+		hwpt = container_of(iommufd_get_object(fault->ictx,
+						       response.hwpt_id,
+						       IOMMUFD_OBJ_HW_PAGETABLE),
+				    struct iommufd_hw_pagetable, obj);
+		if (IS_ERR(hwpt)) {
+			iommufd_put_object(&idev->obj);
+			rc = PTR_ERR(hwpt);
+			break;
+		}
+
+		if (hwpt != fault->hwpt) {
+			rc = -EINVAL;
+			goto put_obj;
+		}
+
+		group = NULL;
+		list_for_each_entry(iter, &fault->response, node) {
+			if (response.grpid != iter->last_fault.fault.prm.grpid)
+				continue;
+
+			if (idev->dev != iter->dev)
+				continue;
+
+			if ((iter->last_fault.fault.prm.flags &
+			     IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) &&
+			    response.pasid != iter->last_fault.fault.prm.pasid)
+				continue;
+
+			group = iter;
+			break;
+		}
+
+		if (!group) {
+			rc = -ENODEV;
+			goto put_obj;
+		}
+
+		rc = iopf_group_response(group, response.code);
+		if (rc)
+			goto put_obj;
+
+		list_del(&group->node);
+		iopf_free_group(group);
+		done += response_size;
+put_obj:
+		iommufd_put_object(&hwpt->obj);
+		iommufd_put_object(&idev->obj);
+		if (rc)
+			break;
+	}
+	mutex_unlock(&fault->mutex);
+
+	return (rc < 0) ? rc : done;
+}
+
+static const struct file_operations hwpt_fault_fops = {
+	.owner		= THIS_MODULE,
+	.read		= hwpt_fault_fops_read,
+	.write		= hwpt_fault_fops_write,
+};
+
+static int hw_pagetable_get_fault_fd(struct hw_pgtable_fault *fault)
+{
+	struct file *filep;
+	int fdno;
+
+	fdno = get_unused_fd_flags(O_CLOEXEC);
+	if (fdno < 0)
+		return fdno;
+
+	filep = anon_inode_getfile("[iommufd-pgfault]", &hwpt_fault_fops,
+				   fault, O_RDWR);
+	if (IS_ERR(filep)) {
+		put_unused_fd(fdno);
+		return PTR_ERR(filep);
+	}
+
+	fd_install(fdno, filep);
+	fault->fault_file = filep;
+	fault->fault_fd = fdno;
+
+	return 0;
+}
+
 static struct hw_pgtable_fault *hw_pagetable_fault_alloc(void)
 {
 	struct hw_pgtable_fault *fault;
+	int rc;
 
 	fault = kzalloc(sizeof(*fault), GFP_KERNEL);
 	if (!fault)
@@ -50,6 +241,12 @@ static struct hw_pgtable_fault *hw_pagetable_fault_alloc(void)
 	INIT_LIST_HEAD(&fault->response);
 	mutex_init(&fault->mutex);
 
+	rc = hw_pagetable_get_fault_fd(fault);
+	if (rc) {
+		kfree(fault);
+		return ERR_PTR(rc);
+	}
+
 	return fault;
 }
 
@@ -58,6 +255,8 @@ static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault)
 	WARN_ON(!list_empty(&fault->deliver));
 	WARN_ON(!list_empty(&fault->response));
 
+	fput(fault->fault_file);
+	put_unused_fd(fault->fault_fd);
 	kfree(fault);
 }
 
@@ -347,7 +546,9 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	struct mutex *mutex;
 	int rc;
 
-	if (cmd->flags & ~IOMMU_HWPT_ALLOC_NEST_PARENT || cmd->__reserved)
+	if ((cmd->flags & ~(IOMMU_HWPT_ALLOC_NEST_PARENT |
+			    IOMMU_HWPT_ALLOC_IOPF_CAPABLE)) ||
+	    cmd->__reserved)
 		return -EOPNOTSUPP;
 	if (!cmd->data_len && cmd->hwpt_type != IOMMU_HWPT_TYPE_DEFAULT)
 		return -EINVAL;
@@ -416,6 +617,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		hwpt->fault->hwpt = hwpt;
 		hwpt->domain->iopf_handler = iommufd_hw_pagetable_iopf_handler;
 		hwpt->domain->fault_data = hwpt;
+		cmd->out_fault_fd = hwpt->fault->fault_fd;
 	}
 
 	cmd->out_hwpt_id = hwpt->obj.id;
-- 
2.34.1

