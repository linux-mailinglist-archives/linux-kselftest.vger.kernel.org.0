Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA8E7D0B6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376627AbjJTJUn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376676AbjJTJUS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:20:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDD0D60;
        Fri, 20 Oct 2023 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793602; x=1729329602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9EgME6PzSlZ5ig0d0uUH6Pd7j77lK3/DCO/qMVd1eog=;
  b=chl+AomvM95Ge/puiFRRv7kOW9dx3tmn1cbASgBqW8NjNcuNyg4lEVTT
   +ymT4NnkTvFBhXj5Ou3SesT9a9DB0JwWAvguAghM/WSAqYeG0s7ANAuTn
   hJeybchJ+hz8Ex8vqHUIBt1hQV0X4EFzmFUnvagO6j3Jx7ADbIpf41l7h
   Nr+x4q7PLtEn8aiih6JwUXnL2yX0YhyPHw3v+IWB9LOwYSuCzG3nnOQFy
   zDQWs4zqeTWqcSCMFXvya5RPOYIuYt0tVsZTZV57zMLw1Kc3za5RuCctE
   DW/54lAk3SUH752tE6a/XRH3jLG+9zOHVI35JNMc5W+9/qSFW5DLpovd6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="366693397"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="366693397"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:20:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707179453"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707179453"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2023 02:20:01 -0700
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
Subject: [PATCH v5 05/10] iommufd: Derive iommufd_hwpt_paging from iommufd_hw_pagetable
Date:   Fri, 20 Oct 2023 02:19:41 -0700
Message-Id: <20231020091946.12173-6-yi.l.liu@intel.com>
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

From: Nicolin Chen <nicolinc@nvidia.com>

To prepare for IOMMUFD_OBJ_HWPT_NESTED, derive struct iommufd_hwpt_paging
from struct iommufd_hw_pagetable, by leaving the common members in struct
iommufd_hw_pagetable. Add a __iommufd_object_alloc and to_hwpt_paging()
helpers for the new structure.

Then, update "hwpt" to "hwpt_paging" throughout the files, accordingly.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 78 ++++++++++++--------
 drivers/iommu/iommufd/hw_pagetable.c    | 98 ++++++++++++++-----------
 drivers/iommu/iommufd/iommufd_private.h | 37 +++++++---
 drivers/iommu/iommufd/main.c            |  4 +-
 drivers/iommu/iommufd/vfio_compat.c     |  6 +-
 5 files changed, 131 insertions(+), 92 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 3414276bbd15..cc9f5d0e5b7e 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -293,7 +293,7 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
 EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, IOMMUFD);
 
 static int iommufd_group_setup_msi(struct iommufd_group *igroup,
-				   struct iommufd_hw_pagetable *hwpt)
+				   struct iommufd_hwpt_paging *hwpt_paging)
 {
 	phys_addr_t sw_msi_start = igroup->sw_msi_start;
 	int rc;
@@ -311,8 +311,9 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	 * matches what the IRQ layer actually expects in a newly created
 	 * domain.
 	 */
-	if (sw_msi_start != PHYS_ADDR_MAX && !hwpt->msi_cookie) {
-		rc = iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
+	if (sw_msi_start != PHYS_ADDR_MAX && !hwpt_paging->msi_cookie) {
+		rc = iommu_get_msi_cookie(hwpt_paging->common.domain,
+					  sw_msi_start);
 		if (rc)
 			return rc;
 
@@ -320,12 +321,12 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 		 * iommu_get_msi_cookie() can only be called once per domain,
 		 * it returns -EBUSY on later calls.
 		 */
-		hwpt->msi_cookie = true;
+		hwpt_paging->msi_cookie = true;
 	}
 	return 0;
 }
 
-static int iommufd_hwpt_paging_attach(struct iommufd_hw_pagetable *hwpt,
+static int iommufd_hwpt_paging_attach(struct iommufd_hwpt_paging *hwpt_paging,
 				      struct iommufd_device *idev)
 {
 	int rc;
@@ -334,20 +335,22 @@ static int iommufd_hwpt_paging_attach(struct iommufd_hw_pagetable *hwpt,
 
 	/* Try to upgrade the domain we have */
 	if (idev->enforce_cache_coherency) {
-		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		rc = iommufd_hwpt_paging_enforce_cc(hwpt_paging);
 		if (rc)
 			return rc;
 	}
 
-	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
+	rc = iopt_table_enforce_dev_resv_regions(&hwpt_paging->ioas->iopt,
+						 idev->dev,
 						 &idev->igroup->sw_msi_start);
 	if (rc)
 		return rc;
 
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommufd_group_setup_msi(idev->igroup, hwpt);
+		rc = iommufd_group_setup_msi(idev->igroup, hwpt_paging);
 		if (rc) {
-			iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+			iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt,
+						  idev->dev);
 			return rc;
 		}
 	}
@@ -367,7 +370,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	}
 
 	if (hwpt_is_paging(hwpt)) {
-		rc = iommufd_hwpt_paging_attach(hwpt, idev);
+		rc = iommufd_hwpt_paging_attach(to_hwpt_paging(hwpt), idev);
 		if (rc)
 			goto err_unlock;
 	}
@@ -391,7 +394,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	return 0;
 err_unresv:
 	if (hwpt_is_paging(hwpt))
-		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+		iopt_remove_reserved_iova(&to_hwpt_paging(hwpt)->ioas->iopt,
+					  idev->dev);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
 	return rc;
@@ -409,7 +413,8 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 		idev->igroup->hwpt = NULL;
 	}
 	if (hwpt_is_paging(hwpt))
-		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+		iopt_remove_reserved_iova(&to_hwpt_paging(hwpt)->ioas->iopt,
+					  idev->dev);
 	mutex_unlock(&idev->igroup->lock);
 
 	/* Caller must destroy hwpt */
@@ -428,19 +433,20 @@ iommufd_device_do_attach(struct iommufd_device *idev,
 	return NULL;
 }
 
-static void iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
-					       struct iommufd_hw_pagetable *hwpt)
+static void
+iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
+				   struct iommufd_hwpt_paging *hwpt_paging)
 {
 	struct iommufd_device *cur;
 
 	lockdep_assert_held(&igroup->lock);
 
 	list_for_each_entry(cur, &igroup->device_list, group_item)
-		iopt_remove_reserved_iova(&hwpt->ioas->iopt, cur->dev);
+		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, cur->dev);
 }
 
 static int iommufd_group_do_replace_paging(struct iommufd_group *igroup,
-					   struct iommufd_hw_pagetable *hwpt)
+					   struct iommufd_hwpt_paging *hwpt_paging)
 {
 	struct iommufd_hw_pagetable *old_hwpt = igroup->hwpt;
 	struct iommufd_device *cur;
@@ -451,27 +457,28 @@ static int iommufd_group_do_replace_paging(struct iommufd_group *igroup,
 	/* Try to upgrade the domain we have */
 	list_for_each_entry(cur, &igroup->device_list, group_item) {
 		if (cur->enforce_cache_coherency) {
-			rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+			rc = iommufd_hwpt_paging_enforce_cc(hwpt_paging);
 			if (rc)
 				return rc;
 		}
 	}
 
-	if (hwpt_is_paging(old_hwpt) && hwpt->ioas != old_hwpt->ioas) {
+	if (hwpt_is_paging(old_hwpt) &&
+	    hwpt_paging->ioas != to_hwpt_paging(old_hwpt)->ioas) {
 		list_for_each_entry(cur, &igroup->device_list, group_item) {
 			rc = iopt_table_enforce_dev_resv_regions(
-				&hwpt->ioas->iopt, cur->dev, NULL);
+				&hwpt_paging->ioas->iopt, cur->dev, NULL);
 			if (rc)
 				goto err_unresv;
 		}
 	}
-	rc = iommufd_group_setup_msi(igroup, hwpt);
+	rc = iommufd_group_setup_msi(igroup, hwpt_paging);
 	if (rc)
 		goto err_unresv;
 	return 0;
 
 err_unresv:
-	iommufd_group_remove_reserved_iova(igroup, hwpt);
+	iommufd_group_remove_reserved_iova(igroup, hwpt_paging);
 	return rc;
 }
 
@@ -498,7 +505,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	}
 
 	if (hwpt_is_paging(hwpt)) {
-		rc = iommufd_group_do_replace_paging(igroup, hwpt);
+		rc = iommufd_group_do_replace_paging(igroup,
+						     to_hwpt_paging(hwpt));
 		if (rc)
 			goto err_unlock;
 	}
@@ -509,8 +517,10 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 
 	old_hwpt = igroup->hwpt;
 	if (hwpt_is_paging(old_hwpt) &&
-	    (!hwpt_is_paging(hwpt) || hwpt->ioas != old_hwpt->ioas))
-		iommufd_group_remove_reserved_iova(igroup, old_hwpt);
+	    (!hwpt_is_paging(hwpt) ||
+	     to_hwpt_paging(hwpt)->ioas != to_hwpt_paging(old_hwpt)->ioas))
+		iommufd_group_remove_reserved_iova(igroup,
+						   to_hwpt_paging(old_hwpt));
 
 	igroup->hwpt = hwpt;
 
@@ -530,7 +540,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	return old_hwpt;
 err_unresv:
 	if (hwpt_is_paging(hwpt))
-		iommufd_group_remove_reserved_iova(igroup, hwpt);
+		iommufd_group_remove_reserved_iova(igroup,
+						   to_hwpt_paging(old_hwpt));
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
 	return ERR_PTR(rc);
@@ -558,6 +569,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	 */
 	bool immediate_attach = do_attach == iommufd_device_do_attach;
 	struct iommufd_hw_pagetable *destroy_hwpt;
+	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
 
 	/*
@@ -566,10 +578,11 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	 * other.
 	 */
 	mutex_lock(&ioas->mutex);
-	list_for_each_entry(hwpt, &ioas->hwpt_list, hwpt_item) {
-		if (!hwpt->auto_domain)
+	list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hwpt_item) {
+		if (!hwpt_paging->auto_domain)
 			continue;
 
+		hwpt = &hwpt_paging->common;
 		if (!iommufd_lock_obj(&hwpt->obj))
 			continue;
 		destroy_hwpt = (*do_attach)(idev, hwpt);
@@ -590,12 +603,13 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		goto out_unlock;
 	}
 
-	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev,
-					  0, immediate_attach);
-	if (IS_ERR(hwpt)) {
-		destroy_hwpt = ERR_CAST(hwpt);
+	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev,
+						 0, immediate_attach);
+	if (IS_ERR(hwpt_paging)) {
+		destroy_hwpt = ERR_CAST(hwpt_paging);
 		goto out_unlock;
 	}
+	hwpt = &hwpt_paging->common;
 
 	if (!immediate_attach) {
 		destroy_hwpt = (*do_attach)(idev, hwpt);
@@ -605,7 +619,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		destroy_hwpt = NULL;
 	}
 
-	hwpt->auto_domain = true;
+	hwpt_paging->auto_domain = true;
 	*pt_id = hwpt->obj.id;
 
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index e100caa502ed..52df5b2bb329 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -8,56 +8,60 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
-void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
+void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
 {
-	struct iommufd_hw_pagetable *hwpt =
-		container_of(obj, struct iommufd_hw_pagetable, obj);
+	struct iommufd_hwpt_paging *hwpt_paging =
+		container_of(obj, struct iommufd_hwpt_paging, common.obj);
 
-	if (!list_empty(&hwpt->hwpt_item)) {
-		mutex_lock(&hwpt->ioas->mutex);
-		list_del(&hwpt->hwpt_item);
-		mutex_unlock(&hwpt->ioas->mutex);
+	if (!list_empty(&hwpt_paging->hwpt_item)) {
+		mutex_lock(&hwpt_paging->ioas->mutex);
+		list_del(&hwpt_paging->hwpt_item);
+		mutex_unlock(&hwpt_paging->ioas->mutex);
 
-		iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
+		iopt_table_remove_domain(&hwpt_paging->ioas->iopt,
+					 hwpt_paging->common.domain);
 	}
 
-	if (hwpt->domain)
-		iommu_domain_free(hwpt->domain);
+	if (hwpt_paging->common.domain)
+		iommu_domain_free(hwpt_paging->common.domain);
 
-	refcount_dec(&hwpt->ioas->obj.users);
+	refcount_dec(&hwpt_paging->ioas->obj.users);
 }
 
-void iommufd_hw_pagetable_abort(struct iommufd_object *obj)
+void iommufd_hwpt_paging_abort(struct iommufd_object *obj)
 {
-	struct iommufd_hw_pagetable *hwpt =
-		container_of(obj, struct iommufd_hw_pagetable, obj);
+	struct iommufd_hwpt_paging *hwpt_paging =
+		container_of(obj, struct iommufd_hwpt_paging, common.obj);
 
 	/* The ioas->mutex must be held until finalize is called. */
-	lockdep_assert_held(&hwpt->ioas->mutex);
+	lockdep_assert_held(&hwpt_paging->ioas->mutex);
 
-	if (!list_empty(&hwpt->hwpt_item)) {
-		list_del_init(&hwpt->hwpt_item);
-		iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
+	if (!list_empty(&hwpt_paging->hwpt_item)) {
+		list_del_init(&hwpt_paging->hwpt_item);
+		iopt_table_remove_domain(&hwpt_paging->ioas->iopt,
+					 hwpt_paging->common.domain);
 	}
-	iommufd_hw_pagetable_destroy(obj);
+	iommufd_hwpt_paging_destroy(obj);
 }
 
-int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
+int iommufd_hwpt_paging_enforce_cc(struct iommufd_hwpt_paging *hwpt_paging)
 {
-	if (hwpt->enforce_cache_coherency)
+	struct iommu_domain *paging_domain = hwpt_paging->common.domain;
+
+	if (hwpt_paging->enforce_cache_coherency)
 		return 0;
 
-	if (hwpt->domain->ops->enforce_cache_coherency)
-		hwpt->enforce_cache_coherency =
-			hwpt->domain->ops->enforce_cache_coherency(
-				hwpt->domain);
-	if (!hwpt->enforce_cache_coherency)
+	if (paging_domain->ops->enforce_cache_coherency)
+		hwpt_paging->enforce_cache_coherency =
+			paging_domain->ops->enforce_cache_coherency(
+				paging_domain);
+	if (!hwpt_paging->enforce_cache_coherency)
 		return -EINVAL;
 	return 0;
 }
 
 /**
- * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
+ * iommufd_hwpt_paging_alloc() - Get a PAGING iommu_domain for a device
  * @ictx: iommufd context
  * @ioas: IOAS to associate the domain with
  * @idev: Device to get an iommu_domain for
@@ -72,12 +76,13 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
  * iommufd_object_abort_and_destroy() or iommufd_object_finalize() is called on
  * the returned hwpt.
  */
-struct iommufd_hw_pagetable *
-iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct iommufd_device *idev, u32 flags,
-			   bool immediate_attach)
+struct iommufd_hwpt_paging *
+iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
+			  struct iommufd_device *idev, u32 flags,
+			  bool immediate_attach)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
+	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
@@ -86,14 +91,17 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if (flags && !ops->domain_alloc_user)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HWPT_PAGING);
-	if (IS_ERR(hwpt))
-		return hwpt;
+	hwpt_paging = __iommufd_object_alloc(ictx, hwpt_paging,
+					     IOMMUFD_OBJ_HWPT_PAGING,
+					     common.obj);
+	if (IS_ERR(hwpt_paging))
+		return ERR_CAST(hwpt_paging);
+	hwpt = &hwpt_paging->common;
 
-	INIT_LIST_HEAD(&hwpt->hwpt_item);
+	INIT_LIST_HEAD(&hwpt_paging->hwpt_item);
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
-	hwpt->ioas = ioas;
+	hwpt_paging->ioas = ioas;
 
 	if (ops->domain_alloc_user) {
 		hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
@@ -119,7 +127,7 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	 * a new domain.
 	 */
 	if (idev->enforce_cache_coherency) {
-		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		rc = iommufd_hwpt_paging_enforce_cc(hwpt_paging);
 		if (WARN_ON(rc))
 			goto out_abort;
 	}
@@ -136,11 +144,11 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			goto out_abort;
 	}
 
-	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
+	rc = iopt_table_add_domain(&ioas->iopt, hwpt->domain);
 	if (rc)
 		goto out_detach;
-	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
-	return hwpt;
+	list_add_tail(&hwpt_paging->hwpt_item, &ioas->hwpt_list);
+	return hwpt_paging;
 
 out_detach:
 	if (immediate_attach)
@@ -153,6 +161,7 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
+	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
 	struct iommufd_device *idev;
 	struct iommufd_ioas *ioas;
@@ -172,12 +181,13 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	}
 
 	mutex_lock(&ioas->mutex);
-	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas,
-					  idev, cmd->flags, false);
-	if (IS_ERR(hwpt)) {
-		rc = PTR_ERR(hwpt);
+	hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,
+						cmd->flags, false);
+	if (IS_ERR(hwpt_paging)) {
+		rc = PTR_ERR(hwpt_paging);
 		goto out_unlock;
 	}
+	hwpt = &hwpt_paging->common;
 
 	cmd->out_hwpt_id = hwpt->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 6244ffddee6e..a7ed384717a5 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -171,7 +171,7 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type);
 
-#define iommufd_object_alloc(ictx, ptr, type)                                  \
+#define __iommufd_object_alloc(ictx, ptr, type, obj)                           \
 	container_of(_iommufd_object_alloc(                                    \
 			     ictx,                                             \
 			     sizeof(*(ptr)) + BUILD_BUG_ON_ZERO(               \
@@ -180,6 +180,9 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 			     type),                                            \
 		     typeof(*(ptr)), obj)
 
+#define iommufd_object_alloc(ictx, ptr, type)                                  \
+	__iommufd_object_alloc(ictx, ptr, type, obj)
+
 /*
  * The IO Address Space (IOAS) pagetable is a virtual page table backed by the
  * io_pagetable object. It is a user controlled mapping of IOVA -> PFNs. The
@@ -231,8 +234,12 @@ int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
  */
 struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
-	struct iommufd_ioas *ioas;
 	struct iommu_domain *domain;
+};
+
+struct iommufd_hwpt_paging {
+	struct iommufd_hw_pagetable common;
+	struct iommufd_ioas *ioas;
 	bool auto_domain : 1;
 	bool enforce_cache_coherency : 1;
 	bool msi_cookie : 1;
@@ -245,24 +252,32 @@ static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
 	return hwpt->obj.type == IOMMUFD_OBJ_HWPT_PAGING;
 }
 
-struct iommufd_hw_pagetable *
-iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct iommufd_device *idev, u32 flags,
-			   bool immediate_attach);
-int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt);
+static inline struct iommufd_hwpt_paging *
+to_hwpt_paging(struct iommufd_hw_pagetable *hwpt)
+{
+	return container_of(hwpt, struct iommufd_hwpt_paging, common);
+}
+
+struct iommufd_hwpt_paging *
+iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
+			  struct iommufd_device *idev, u32 flags,
+			  bool immediate_attach);
+int iommufd_hwpt_paging_enforce_cc(struct iommufd_hwpt_paging *hwpt_paging);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev);
-void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
-void iommufd_hw_pagetable_abort(struct iommufd_object *obj);
+void iommufd_hwpt_paging_destroy(struct iommufd_object *obj);
+void iommufd_hwpt_paging_abort(struct iommufd_object *obj);
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
 
 static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 					    struct iommufd_hw_pagetable *hwpt)
 {
-	lockdep_assert_not_held(&hwpt->ioas->mutex);
-	if (hwpt->auto_domain)
+	struct iommufd_hwpt_paging *hwpt_paging = to_hwpt_paging(hwpt);
+
+	lockdep_assert_not_held(&hwpt_paging->ioas->mutex);
+	if (hwpt_paging->auto_domain)
 		iommufd_object_deref_user(ictx, &hwpt->obj);
 	else
 		refcount_dec(&hwpt->obj.users);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index ad7c8c9ea46a..b4a24ef041e6 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -483,8 +483,8 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 		.destroy = iommufd_ioas_destroy,
 	},
 	[IOMMUFD_OBJ_HWPT_PAGING] = {
-		.destroy = iommufd_hw_pagetable_destroy,
-		.abort = iommufd_hw_pagetable_abort,
+		.destroy = iommufd_hwpt_paging_destroy,
+		.abort = iommufd_hwpt_paging_abort,
 	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
diff --git a/drivers/iommu/iommufd/vfio_compat.c b/drivers/iommu/iommufd/vfio_compat.c
index 6c810bf80f99..538fbf76354d 100644
--- a/drivers/iommu/iommufd/vfio_compat.c
+++ b/drivers/iommu/iommufd/vfio_compat.c
@@ -255,7 +255,7 @@ static int iommufd_vfio_unmap_dma(struct iommufd_ctx *ictx, unsigned int cmd,
 
 static int iommufd_vfio_cc_iommu(struct iommufd_ctx *ictx)
 {
-	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_ioas *ioas;
 	int rc = 1;
 
@@ -264,8 +264,8 @@ static int iommufd_vfio_cc_iommu(struct iommufd_ctx *ictx)
 		return PTR_ERR(ioas);
 
 	mutex_lock(&ioas->mutex);
-	list_for_each_entry(hwpt, &ioas->hwpt_list, hwpt_item) {
-		if (!hwpt->enforce_cache_coherency) {
+	list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hwpt_item) {
+		if (!hwpt_paging->enforce_cache_coherency) {
 			rc = 0;
 			break;
 		}
-- 
2.34.1

