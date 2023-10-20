Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501A07D0B5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376672AbjJTJUS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376666AbjJTJUK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:20:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF215D49;
        Fri, 20 Oct 2023 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793600; x=1729329600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yScEkXexh5WYdQNVnnkYAnl39Dbni1EUA9qaWM/lfSQ=;
  b=PQEp/SdK9j/MtvfE5oy1QhyKySzgZ/mpUyB5B+no0J8G2GCZXVfOKOWZ
   g2VtopAOHsnmHgTLzc7zK0qNLIZ+IHXzD5OMEnFsxkjK20L4y5vDwO87+
   yByM8tmDBFeQv41bonaCmRECYcQMVSzyKKehBJFs3n0Og9d83rGwjqtsW
   H8zmPToqkEMRk1bebLH0+VY2vUyA1BAwcvCFjproIV3K7tpV+Ct7UVsan
   c4kVbk701RW1JUK+bJkn5FdPRGRHLJC+Bzug0Ebn5jrnGHcQuZYgPnpJm
   SPWplvb6H1ckx3tp4KMrMu94d8IKGjswEq4kjLX6Ybj2QpRXrsdblZl8o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="366693381"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="366693381"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:20:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707179439"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707179439"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2023 02:19:59 -0700
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com,
        baolu.lu@linux.intel.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
        xin.zeng@intel.com
Subject: [PATCH v5 04/10] iommufd/device: Wrap IOMMUFD_OBJ_HWPT_PAGING-only configurations
Date:   Fri, 20 Oct 2023 02:19:40 -0700
Message-Id: <20231020091946.12173-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020091946.12173-1-yi.l.liu@intel.com>
References: <20231020091946.12173-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Some of the configurations during the attach/replace() should only apply
to IOMMUFD_OBJ_HWPT_PAGING. Once IOMMUFD_OBJ_HWPT_NESTED gets introduced
in a following patch, keeping them unconditionally in the common routine
will not work.

Wrap all of those PAGING-only configurations together into helpers. Do a
hwpt_is_paging check whenever calling them or their fallback routines.

Also, move "num_devices++" closer to the place using it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 137 ++++++++++++++++--------
 drivers/iommu/iommufd/iommufd_private.h |   5 +
 2 files changed, 99 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a5f9f20b2a9b..3414276bbd15 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -325,6 +325,35 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	return 0;
 }
 
+static int iommufd_hwpt_paging_attach(struct iommufd_hw_pagetable *hwpt,
+				      struct iommufd_device *idev)
+{
+	int rc;
+
+	lockdep_assert_held(&idev->igroup->lock);
+
+	/* Try to upgrade the domain we have */
+	if (idev->enforce_cache_coherency) {
+		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		if (rc)
+			return rc;
+	}
+
+	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
+						 &idev->igroup->sw_msi_start);
+	if (rc)
+		return rc;
+
+	if (list_empty(&idev->igroup->device_list)) {
+		rc = iommufd_group_setup_msi(idev->igroup, hwpt);
+		if (rc) {
+			iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+			return rc;
+		}
+	}
+	return 0;
+}
+
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
@@ -337,18 +366,12 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unlock;
 	}
 
-	/* Try to upgrade the domain we have */
-	if (idev->enforce_cache_coherency) {
-		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+	if (hwpt_is_paging(hwpt)) {
+		rc = iommufd_hwpt_paging_attach(hwpt, idev);
 		if (rc)
 			goto err_unlock;
 	}
 
-	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
-						 &idev->igroup->sw_msi_start);
-	if (rc)
-		goto err_unlock;
-
 	/*
 	 * Only attach to the group once for the first device that is in the
 	 * group. All the other devices will follow this attachment. The user
@@ -357,10 +380,6 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommufd_group_setup_msi(idev->igroup, hwpt);
-		if (rc)
-			goto err_unresv;
-
 		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
@@ -371,7 +390,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	mutex_unlock(&idev->igroup->lock);
 	return 0;
 err_unresv:
-	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	if (hwpt_is_paging(hwpt))
+		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
 	return rc;
@@ -388,7 +408,8 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 		iommu_detach_group(hwpt->domain, idev->igroup->group);
 		idev->igroup->hwpt = NULL;
 	}
-	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	if (hwpt_is_paging(hwpt))
+		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 	mutex_unlock(&idev->igroup->lock);
 
 	/* Caller must destroy hwpt */
@@ -407,40 +428,36 @@ iommufd_device_do_attach(struct iommufd_device *idev,
 	return NULL;
 }
 
-static struct iommufd_hw_pagetable *
-iommufd_device_do_replace(struct iommufd_device *idev,
-			  struct iommufd_hw_pagetable *hwpt)
+static void iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
+					       struct iommufd_hw_pagetable *hwpt)
 {
-	struct iommufd_group *igroup = idev->igroup;
-	struct iommufd_hw_pagetable *old_hwpt;
-	unsigned int num_devices = 0;
 	struct iommufd_device *cur;
-	int rc;
 
-	mutex_lock(&idev->igroup->lock);
+	lockdep_assert_held(&igroup->lock);
 
-	if (igroup->hwpt == NULL) {
-		rc = -EINVAL;
-		goto err_unlock;
-	}
+	list_for_each_entry(cur, &igroup->device_list, group_item)
+		iopt_remove_reserved_iova(&hwpt->ioas->iopt, cur->dev);
+}
 
-	if (hwpt == igroup->hwpt) {
-		mutex_unlock(&idev->igroup->lock);
-		return NULL;
-	}
+static int iommufd_group_do_replace_paging(struct iommufd_group *igroup,
+					   struct iommufd_hw_pagetable *hwpt)
+{
+	struct iommufd_hw_pagetable *old_hwpt = igroup->hwpt;
+	struct iommufd_device *cur;
+	int rc;
+
+	lockdep_assert_held(&igroup->lock);
 
 	/* Try to upgrade the domain we have */
 	list_for_each_entry(cur, &igroup->device_list, group_item) {
-		num_devices++;
 		if (cur->enforce_cache_coherency) {
 			rc = iommufd_hw_pagetable_enforce_cc(hwpt);
 			if (rc)
-				goto err_unlock;
+				return rc;
 		}
 	}
 
-	old_hwpt = igroup->hwpt;
-	if (hwpt->ioas != old_hwpt->ioas) {
+	if (hwpt_is_paging(old_hwpt) && hwpt->ioas != old_hwpt->ioas) {
 		list_for_each_entry(cur, &igroup->device_list, group_item) {
 			rc = iopt_table_enforce_dev_resv_regions(
 				&hwpt->ioas->iopt, cur->dev, NULL);
@@ -448,23 +465,57 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 				goto err_unresv;
 		}
 	}
-
-	rc = iommufd_group_setup_msi(idev->igroup, hwpt);
+	rc = iommufd_group_setup_msi(igroup, hwpt);
 	if (rc)
 		goto err_unresv;
+	return 0;
+
+err_unresv:
+	iommufd_group_remove_reserved_iova(igroup, hwpt);
+	return rc;
+}
+
+static struct iommufd_hw_pagetable *
+iommufd_device_do_replace(struct iommufd_device *idev,
+			  struct iommufd_hw_pagetable *hwpt)
+{
+	struct iommufd_group *igroup = idev->igroup;
+	struct iommufd_hw_pagetable *old_hwpt;
+	unsigned int num_devices = 0;
+	struct iommufd_device *cur;
+	int rc;
+
+	mutex_lock(&idev->igroup->lock);
+
+	if (igroup->hwpt == NULL) {
+		rc = -EINVAL;
+		goto err_unlock;
+	}
+
+	if (hwpt == igroup->hwpt) {
+		mutex_unlock(&idev->igroup->lock);
+		return NULL;
+	}
+
+	if (hwpt_is_paging(hwpt)) {
+		rc = iommufd_group_do_replace_paging(igroup, hwpt);
+		if (rc)
+			goto err_unlock;
+	}
 
 	rc = iommu_group_replace_domain(igroup->group, hwpt->domain);
 	if (rc)
 		goto err_unresv;
 
-	if (hwpt->ioas != old_hwpt->ioas) {
-		list_for_each_entry(cur, &igroup->device_list, group_item)
-			iopt_remove_reserved_iova(&old_hwpt->ioas->iopt,
-						  cur->dev);
-	}
+	old_hwpt = igroup->hwpt;
+	if (hwpt_is_paging(old_hwpt) &&
+	    (!hwpt_is_paging(hwpt) || hwpt->ioas != old_hwpt->ioas))
+		iommufd_group_remove_reserved_iova(igroup, old_hwpt);
 
 	igroup->hwpt = hwpt;
 
+	list_for_each_entry(cur, &igroup->device_list, group_item)
+		num_devices++;
 	/*
 	 * Move the refcounts held by the device_list to the new hwpt. Retain a
 	 * refcount for this thread as the caller will free it.
@@ -478,8 +529,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	/* Caller must destroy old_hwpt */
 	return old_hwpt;
 err_unresv:
-	list_for_each_entry(cur, &igroup->device_list, group_item)
-		iopt_remove_reserved_iova(&hwpt->ioas->iopt, cur->dev);
+	if (hwpt_is_paging(hwpt))
+		iommufd_group_remove_reserved_iova(igroup, hwpt);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
 	return ERR_PTR(rc);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 07ce35f09599..6244ffddee6e 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -240,6 +240,11 @@ struct iommufd_hw_pagetable {
 	struct list_head hwpt_item;
 };
 
+static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
+{
+	return hwpt->obj.type == IOMMUFD_OBJ_HWPT_PAGING;
+}
+
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct iommufd_device *idev, u32 flags,
-- 
2.34.1

