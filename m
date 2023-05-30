Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278BE715507
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjE3Fkw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjE3FkR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:40:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D95E51;
        Mon, 29 May 2023 22:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425201; x=1716961201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=emo/IqVPZFg6auY9BgZzkhRQc5NjjIUPKKD96DiiUS4=;
  b=WVcQzu9Jj4K3MJFTFI5hpaxmAeKryC/6cSelZXXYguUS41nImo82imdm
   nuwWxNUjkVyoJo9T2CR7X/r7+dXnPgjxkMR9CYZWX828cgHLhEpbVnjLO
   8LtKdzjMcVaNGUCHvrgQevELJoE1aOoWFyMXVX74ESVx6zDxiaUzYOQyV
   CfO70aUYeoHoqHFiVwRW8cZoCcIkVtaYi4z0K5igVi7fAdr4smiLrnB6u
   G5f48bQOzgScug7zGjxoYngrPPs5kEReA+mncD/YyFRd83RJUodlq4iFO
   ceN02+Bc88gYMYugqEoKjLH4XWq0l/kHbi4wepfWkEASNdA3FU00kNeBR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579760"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579760"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:38:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369666"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369666"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:38:51 -0700
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
Subject: [RFC PATCHES 08/17] iommufd: IO page fault delivery initialization and release
Date:   Tue, 30 May 2023 13:37:15 +0800
Message-Id: <20230530053724.232765-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530053724.232765-1-baolu.lu@linux.intel.com>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add some housekeeping code for IO page fault dilivery. Add a fault field
in the iommufd_hw_pagetable structure to store pending IO page faults and
other related data.

The fault field is allocated when an IOPF-capable user HWPT (indicated by
IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE being set in the allocation user data)
is allocated. This field exists until the HWPT is destroyed. This also
implies that it is possible to determine whether a HWPT is IOPF capable by
checking the fault field.

When an IOPF-capable HWPT is attached to a device (could also be a PASID of
a device in the future), a fault cookie is allocated and set to the device.
The cookie is cleared and freed when HWPT is detached from the device.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 12 +++++
 drivers/iommu/iommufd/device.c          | 61 +++++++++++++++++++++++--
 drivers/iommu/iommufd/hw_pagetable.c    | 55 ++++++++++++++++++++++
 3 files changed, 125 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index e951815f5707..5ff139acc5c0 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -236,6 +236,13 @@ int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 
 int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
 
+struct hw_pgtable_fault {
+	struct mutex mutex;
+	struct list_head deliver;
+	struct list_head response;
+	struct eventfd_ctx *trigger;
+};
+
 /*
  * A HW pagetable is called an iommu_domain inside the kernel. This user object
  * allows directly creating and inspecting the domains. Domains that have kernel
@@ -252,6 +259,7 @@ struct iommufd_hw_pagetable {
 	bool msi_cookie : 1;
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
+	struct hw_pgtable_fault *fault;
 };
 
 struct iommufd_hw_pagetable *
@@ -314,6 +322,10 @@ struct iommufd_device {
 	bool has_user_data;
 };
 
+struct iommufd_fault_cookie {
+	struct iommufd_device *idev;
+};
+
 static inline struct iommufd_device *
 iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
 {
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 29b212714e2c..3408f1fc3e9f 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -374,6 +374,44 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	return 0;
 }
 
+static int iommufd_device_set_fault_cookie(struct iommufd_hw_pagetable *hwpt,
+					   struct iommufd_device *idev,
+					   ioasid_t pasid)
+{
+	struct iommufd_fault_cookie *fcookie, *curr;
+
+	if (!hwpt->fault)
+		return 0;
+
+	fcookie = kzalloc(sizeof(*fcookie), GFP_KERNEL);
+	if (!fcookie)
+		return -ENOMEM;
+	fcookie->idev = idev;
+
+	curr = iommu_set_device_fault_cookie(idev->dev, pasid, fcookie);
+	if (IS_ERR(curr)) {
+		kfree(fcookie);
+		return PTR_ERR(curr);
+	}
+	kfree(curr);
+
+	return 0;
+}
+
+static void iommufd_device_unset_fault_cookie(struct iommufd_hw_pagetable *hwpt,
+					      struct iommufd_device *idev,
+					      ioasid_t pasid)
+{
+	struct iommufd_fault_cookie *curr;
+
+	if (!hwpt->fault)
+		return;
+
+	curr = iommu_set_device_fault_cookie(idev->dev, pasid, NULL);
+	WARN_ON(IS_ERR(curr));
+	kfree(curr);
+}
+
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
@@ -398,6 +436,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	if (rc)
 		goto err_unlock;
 
+	rc = iommufd_device_set_fault_cookie(hwpt, idev, 0);
+	if (rc)
+		goto err_unresv;
+
 	/*
 	 * Only attach to the group once for the first device that is in the
 	 * group. All the other devices will follow this attachment. The user
@@ -408,17 +450,21 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
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
+
 	refcount_inc(&hwpt->obj.users);
 	list_add_tail(&idev->group_item, &idev->igroup->device_list);
 	mutex_unlock(&idev->igroup->lock);
 	return 0;
+
+err_unset:
+	iommufd_device_unset_fault_cookie(hwpt, idev, 0);
 err_unresv:
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 err_unlock:
@@ -433,6 +479,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 
 	mutex_lock(&idev->igroup->lock);
 	list_del(&idev->group_item);
+	iommufd_device_unset_fault_cookie(hwpt, idev, 0);
 	if (list_empty(&idev->igroup->device_list)) {
 		iommu_detach_group(hwpt->domain, idev->igroup->group);
 		idev->igroup->hwpt = NULL;
@@ -502,9 +549,14 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	if (rc)
 		goto err_unresv;
 
+	iommufd_device_unset_fault_cookie(old_hwpt, idev, 0);
+	rc = iommufd_device_set_fault_cookie(hwpt, idev, 0);
+	if (rc)
+		goto err_unresv;
+
 	rc = iommu_group_replace_domain(igroup->group, hwpt->domain);
 	if (rc)
-		goto err_unresv;
+		goto err_replace;
 
 	if (hwpt->ioas != old_hwpt->ioas) {
 		list_for_each_entry(cur, &igroup->device_list, group_item)
@@ -526,6 +578,9 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 
 	/* Caller must destroy old_hwpt */
 	return old_hwpt;
+err_replace:
+	iommufd_device_unset_fault_cookie(hwpt, idev, 0);
+	iommufd_device_set_fault_cookie(old_hwpt, idev, 0);
 err_unresv:
 	list_for_each_entry(cur, &igroup->device_list, group_item)
 		iopt_remove_reserved_iova(&hwpt->ioas->iopt, cur->dev);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 47ec7ddd5f5d..d6d550c3d0cc 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -3,12 +3,16 @@
  * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
 #include <linux/iommu.h>
+#include <linux/eventfd.h>
 #include <uapi/linux/iommufd.h>
 
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 #include "iommufd_test.h"
 
+static struct hw_pgtable_fault *hw_pagetable_fault_alloc(int eventfd);
+static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault);
+
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_hw_pagetable *hwpt =
@@ -27,6 +31,9 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 
 	if (hwpt->parent)
 		refcount_dec(&hwpt->parent->obj.users);
+
+	if (hwpt->fault)
+		hw_pagetable_fault_free(hwpt->fault);
 	refcount_dec(&hwpt->ioas->obj.users);
 }
 
@@ -255,6 +262,11 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		goto out_put_pt;
 	}
 
+	if (!parent && (cmd->flags & IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE)) {
+		rc = -EINVAL;
+		goto out_put_pt;
+	}
+
 	if (klen) {
 		if (!cmd->data_len) {
 			rc = -EINVAL;
@@ -282,6 +294,14 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		goto out_unlock;
 	}
 
+	if (cmd->flags & IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE) {
+		hwpt->fault = hw_pagetable_fault_alloc(cmd->event_fd);
+		if (IS_ERR(hwpt->fault)) {
+			rc = PTR_ERR(hwpt->fault);
+			goto out_hwpt;
+		}
+	}
+
 	cmd->out_hwpt_id = hwpt->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
@@ -346,3 +366,38 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(&hwpt->obj);
 	return rc;
 }
+
+static struct hw_pgtable_fault *hw_pagetable_fault_alloc(int eventfd)
+{
+	struct hw_pgtable_fault *fault;
+	int rc;
+
+	fault = kzalloc(sizeof(*fault), GFP_KERNEL);
+	if (!fault)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&fault->deliver);
+	INIT_LIST_HEAD(&fault->response);
+	mutex_init(&fault->mutex);
+
+	fault->trigger = eventfd_ctx_fdget(eventfd);
+	if (IS_ERR(fault->trigger)) {
+		rc = PTR_ERR(fault->trigger);
+		goto out_free;
+	}
+
+	return fault;
+
+out_free:
+	kfree(fault);
+	return ERR_PTR(rc);
+}
+
+static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault)
+{
+	WARN_ON(!list_empty(&fault->deliver));
+	WARN_ON(!list_empty(&fault->response));
+
+	eventfd_ctx_put(fault->trigger);
+	kfree(fault);
+}
-- 
2.34.1

