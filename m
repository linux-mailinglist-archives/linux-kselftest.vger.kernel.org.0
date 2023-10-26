Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26BE7D7B13
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 04:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjJZCxv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 22:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjJZCxt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 22:53:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69B2186;
        Wed, 25 Oct 2023 19:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698288826; x=1729824826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/AnHd0glJLhM4XWEU5B7l7tvLBpqBEBmveUVtvBe6W0=;
  b=fzHyIcLJpQ2GAWi6Eat5XdrDBRNXGNeGoK/lPlGioH9CkbnuY/0WlZmZ
   NLNG+wzl1ccozNQjydzCS4yWfPXAx8CDr92Rb1ZRYient1CT2goIitYik
   nNd2Yd+748anTFP1v7x99akpfYt8XS759Eh36PZ1EurcFZ/pPKLD3IJt5
   e/9QYgmfPKH2a3XVtZH+jwiIEF1U4LskD4r/NbNDzlGm61R4SYdCZZZkt
   GOL7M5H8UTiVjMgZaNqbHt2LnEiKMKokP53X+3QVkkvbdNqI1yfLXKXz1
   nR/I2+MS6s5bK+FI37KI75yj9dLsW9zPB9R0+2rIrcKMEpnj8Uf9GBy2k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="391316173"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="391316173"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 19:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="735604532"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="735604532"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga006.jf.intel.com with ESMTP; 25 Oct 2023 19:53:42 -0700
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
Subject: [PATCH v2 3/6] iommufd: Initializing and releasing IO page fault data
Date:   Thu, 26 Oct 2023 10:49:27 +0800
Message-Id: <20231026024930.382898-4-baolu.lu@linux.intel.com>
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

Add some housekeeping code for IO page fault dilivery. Add a fault field
in the iommufd_hw_pagetable structure to store pending IO page faults and
other related data.

The fault field is allocated and initialized when an IOPF-capable user
HWPT is allocated. It is indicated by the IOMMU_HWPT_ALLOC_IOPF_CAPABLE
flag being set in the allocation user data. The fault field exists until
the HWPT is destroyed. This also means that you can determine whether a
HWPT is IOPF-capable by checking the fault field.

When an IOPF-capable HWPT is attached to a device (could also be a PASID of
a device in the future), the iommufd device pointer is saved for the pasid
of the device. The pointer is recalled and all pending iopf groups are
discarded after the HWPT is detached from the device.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h                   |  6 +++
 drivers/iommu/iommufd/iommufd_private.h | 10 ++++
 drivers/iommu/iommufd/device.c          | 69 +++++++++++++++++++++++--
 drivers/iommu/iommufd/hw_pagetable.c    | 56 +++++++++++++++++++-
 4 files changed, 137 insertions(+), 4 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 615d8a5f9dee..600ca3842c8a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -130,6 +130,12 @@ struct iopf_group {
 	struct work_struct work;
 	struct device *dev;
 	struct iommu_domain *domain;
+
+	/*
+	 * Used by iopf handlers, like iommufd, to hook the iopf group
+	 * on its own lists.
+	 */
+	struct list_head node;
 };
 
 /**
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 1bd412cff2d6..0dbaa2dc5b22 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -230,6 +230,15 @@ int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 
 int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
 
+struct hw_pgtable_fault {
+	struct iommufd_ctx *ictx;
+	struct iommufd_hw_pagetable *hwpt;
+	/* Protect below iopf lists. */
+	struct mutex mutex;
+	struct list_head deliver;
+	struct list_head response;
+};
+
 /*
  * A HW pagetable is called an iommu_domain inside the kernel. This user object
  * allows directly creating and inspecting the domains. Domains that have kernel
@@ -239,6 +248,7 @@ int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
 struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
 	struct iommu_domain *domain;
+	struct hw_pgtable_fault *fault;
 
 	void (*abort)(struct iommufd_object *obj);
 	void (*destroy)(struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 645ab5d290fe..0a8e03d5e7c5 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -456,6 +456,16 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	if (rc)
 		goto err_unlock;
 
+	if (hwpt->fault) {
+		void *curr;
+
+		curr = iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, idev);
+		if (IS_ERR(curr)) {
+			rc = PTR_ERR(curr);
+			goto err_unresv;
+		}
+	}
+
 	/*
 	 * Only attach to the group once for the first device that is in the
 	 * group. All the other devices will follow this attachment. The user
@@ -466,17 +476,20 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	if (list_empty(&idev->igroup->device_list)) {
 		rc = iommufd_group_setup_msi(idev->igroup, hwpt);
 		if (rc)
-			goto err_unresv;
+			goto err_unset;
 
 		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
-			goto err_unresv;
+			goto err_unset;
 		idev->igroup->hwpt = hwpt;
 	}
 	refcount_inc(&hwpt->obj.users);
 	list_add_tail(&idev->group_item, &idev->igroup->device_list);
 	mutex_unlock(&idev->igroup->lock);
 	return 0;
+err_unset:
+	if (hwpt->fault)
+		iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, NULL);
 err_unresv:
 	iommufd_device_remove_rr(idev, hwpt);
 err_unlock:
@@ -484,6 +497,30 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	return rc;
 }
 
+/*
+ * Discard all pending page faults. Called when a hw pagetable is detached
+ * from a device. The iommu core guarantees that all page faults have been
+ * responded, hence there's no need to respond it again.
+ */
+static void iommufd_hw_pagetable_discard_iopf(struct iommufd_hw_pagetable *hwpt)
+{
+	struct iopf_group *group, *next;
+
+	if (!hwpt->fault)
+		return;
+
+	mutex_lock(&hwpt->fault->mutex);
+	list_for_each_entry_safe(group, next, &hwpt->fault->deliver, node) {
+		list_del(&group->node);
+		iopf_free_group(group);
+	}
+	list_for_each_entry_safe(group, next, &hwpt->fault->response, node) {
+		list_del(&group->node);
+		iopf_free_group(group);
+	}
+	mutex_unlock(&hwpt->fault->mutex);
+}
+
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 {
@@ -491,6 +528,8 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 
 	mutex_lock(&idev->igroup->lock);
 	list_del(&idev->group_item);
+	if (hwpt->fault)
+		iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, NULL);
 	if (list_empty(&idev->igroup->device_list)) {
 		iommu_detach_group(hwpt->domain, idev->igroup->group);
 		idev->igroup->hwpt = NULL;
@@ -498,6 +537,8 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 	iommufd_device_remove_rr(idev, hwpt);
 	mutex_unlock(&idev->igroup->lock);
 
+	iommufd_hw_pagetable_discard_iopf(hwpt);
+
 	/* Caller must destroy hwpt */
 	return hwpt;
 }
@@ -563,9 +604,24 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	if (rc)
 		goto err_unresv;
 
+	if (old_hwpt->fault) {
+		iommufd_hw_pagetable_discard_iopf(old_hwpt);
+		iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, NULL);
+	}
+
+	if (hwpt->fault) {
+		void *curr;
+
+		curr = iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, idev);
+		if (IS_ERR(curr)) {
+			rc = PTR_ERR(curr);
+			goto err_unresv;
+		}
+	}
+
 	rc = iommu_group_replace_domain(igroup->group, hwpt->domain);
 	if (rc)
-		goto err_unresv;
+		goto err_unset;
 
 	if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt)) {
 		list_for_each_entry(cur, &igroup->device_list, group_item)
@@ -583,8 +639,15 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 					      &old_hwpt->obj.users));
 	mutex_unlock(&idev->igroup->lock);
 
+	iommufd_hw_pagetable_discard_iopf(old_hwpt);
+
 	/* Caller must destroy old_hwpt */
 	return old_hwpt;
+err_unset:
+	if (hwpt->fault)
+		iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, NULL);
+	if (old_hwpt->fault)
+		iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, idev);
 err_unresv:
 	if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt)) {
 		list_for_each_entry(cur, &igroup->device_list, group_item)
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 72c46de1396b..9f94c824cf86 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -38,9 +38,38 @@ static void iommufd_kernel_managed_hwpt_destroy(struct iommufd_object *obj)
 	refcount_dec(&hwpt->ioas->obj.users);
 }
 
+static struct hw_pgtable_fault *hw_pagetable_fault_alloc(void)
+{
+	struct hw_pgtable_fault *fault;
+
+	fault = kzalloc(sizeof(*fault), GFP_KERNEL);
+	if (!fault)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&fault->deliver);
+	INIT_LIST_HEAD(&fault->response);
+	mutex_init(&fault->mutex);
+
+	return fault;
+}
+
+static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault)
+{
+	WARN_ON(!list_empty(&fault->deliver));
+	WARN_ON(!list_empty(&fault->response));
+
+	kfree(fault);
+}
+
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 {
-	container_of(obj, struct iommufd_hw_pagetable, obj)->destroy(obj);
+	struct iommufd_hw_pagetable *hwpt =
+		container_of(obj, struct iommufd_hw_pagetable, obj);
+
+	if (hwpt->fault)
+		hw_pagetable_fault_free(hwpt->fault);
+
+	hwpt->destroy(obj);
 }
 
 static void iommufd_user_managed_hwpt_abort(struct iommufd_object *obj)
@@ -289,6 +318,17 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx,
 	return ERR_PTR(rc);
 }
 
+static int iommufd_hw_pagetable_iopf_handler(struct iopf_group *group)
+{
+	struct iommufd_hw_pagetable *hwpt = group->domain->fault_data;
+
+	mutex_lock(&hwpt->fault->mutex);
+	list_add_tail(&group->node, &hwpt->fault->deliver);
+	mutex_unlock(&hwpt->fault->mutex);
+
+	return 0;
+}
+
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommufd_hw_pagetable *(*alloc_fn)(
@@ -364,6 +404,20 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		goto out_unlock;
 	}
 
+	if (cmd->flags & IOMMU_HWPT_ALLOC_IOPF_CAPABLE) {
+		hwpt->fault = hw_pagetable_fault_alloc();
+		if (IS_ERR(hwpt->fault)) {
+			rc = PTR_ERR(hwpt->fault);
+			hwpt->fault = NULL;
+			goto out_hwpt;
+		}
+
+		hwpt->fault->ictx = ucmd->ictx;
+		hwpt->fault->hwpt = hwpt;
+		hwpt->domain->iopf_handler = iommufd_hw_pagetable_iopf_handler;
+		hwpt->domain->fault_data = hwpt;
+	}
+
 	cmd->out_hwpt_id = hwpt->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
-- 
2.34.1

