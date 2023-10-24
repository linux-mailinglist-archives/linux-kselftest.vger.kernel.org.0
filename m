Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D707D54CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 17:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjJXPKB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 11:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjJXPKA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 11:10:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F235010D4;
        Tue, 24 Oct 2023 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698160196; x=1729696196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7aZF9c4PAC5OLSaoXv2gvr76CmPzOppg2TalF+vpsLM=;
  b=PtdvZuNkAJmYr+aCsI/+CIfD89OTNTnVsCqTfClnmuStND25qduxvydA
   pcJonGNnuA1mxS7fAqLE3Bhskr1+6gcVCNqUstNF+WrZD6bIbJaBTG3Fp
   p3UgezLNJZsMUc0fCoCtzVmyIXXYq+pT/IAne47uNgWWQZQVnhAgcixx6
   fqpZzsGso2IChygkSshY3mL9Mw4GJ2DVkf2y5J4BI3HB/gbhbZaik2J2N
   JGneZWWGEvk9I4qOs20ICTFVI43s1djjdu2oI/zsx9GkGsL1FSzTkAA62
   AMbWDbwce+axk6WNS9mYRUEGMaWsZZ+36zCGzig0MzRvsKR1FZpoeJpSd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418203010"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="418203010"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:06:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="6486177"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2023 08:06:20 -0700
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: [PATCH v6 05/10] iommufd: Derive iommufd_hwpt_paging from iommufd_hw_pagetable
Date:   Tue, 24 Oct 2023 08:06:04 -0700
Message-Id: <20231024150609.46884-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024150609.46884-1-yi.l.liu@intel.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/iommu/iommufd/device.c          |  74 ++++++++------
 drivers/iommu/iommufd/hw_pagetable.c    | 129 +++++++++++++-----------
 drivers/iommu/iommufd/iommufd_private.h |  41 +++++---
 drivers/iommu/iommufd/main.c            |   4 +-
 drivers/iommu/iommufd/vfio_compat.c     |   6 +-
 5 files changed, 148 insertions(+), 106 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 5bcc15cd54a1..902288ca910d 100644
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
 
@@ -320,27 +321,29 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
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
 
 	lockdep_assert_held(&idev->igroup->lock);
 
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
@@ -360,7 +363,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	}
 
 	if (hwpt_is_paging(hwpt)) {
-		rc = iommufd_hwpt_paging_attach(hwpt, idev);
+		rc = iommufd_hwpt_paging_attach(to_hwpt_paging(hwpt), idev);
 		if (rc)
 			goto err_unlock;
 	}
@@ -384,7 +387,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	return 0;
 err_unresv:
 	if (hwpt_is_paging(hwpt))
-		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+		iopt_remove_reserved_iova(&to_hwpt_paging(hwpt)->ioas->iopt,
+					  idev->dev);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
 	return rc;
@@ -402,7 +406,8 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 		idev->igroup->hwpt = NULL;
 	}
 	if (hwpt_is_paging(hwpt))
-		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+		iopt_remove_reserved_iova(&to_hwpt_paging(hwpt)->ioas->iopt,
+					  idev->dev);
 	mutex_unlock(&idev->igroup->lock);
 
 	/* Caller must destroy hwpt */
@@ -421,19 +426,20 @@ iommufd_device_do_attach(struct iommufd_device *idev,
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
@@ -441,22 +447,23 @@ static int iommufd_group_do_replace_paging(struct iommufd_group *igroup,
 
 	lockdep_assert_held(&igroup->lock);
 
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
 
@@ -482,7 +489,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	}
 
 	if (hwpt_is_paging(hwpt)) {
-		rc = iommufd_group_do_replace_paging(igroup, hwpt);
+		rc = iommufd_group_do_replace_paging(igroup,
+						     to_hwpt_paging(hwpt));
 		if (rc)
 			goto err_unlock;
 	}
@@ -493,8 +501,10 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 
 	old_hwpt = igroup->hwpt;
 	if (hwpt_is_paging(old_hwpt) &&
-	    (!hwpt_is_paging(hwpt) || hwpt->ioas != old_hwpt->ioas))
-		iommufd_group_remove_reserved_iova(igroup, old_hwpt);
+	    (!hwpt_is_paging(hwpt) ||
+	     to_hwpt_paging(hwpt)->ioas != to_hwpt_paging(old_hwpt)->ioas))
+		iommufd_group_remove_reserved_iova(igroup,
+						   to_hwpt_paging(old_hwpt));
 
 	igroup->hwpt = hwpt;
 
@@ -513,7 +523,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	return old_hwpt;
 err_unresv:
 	if (hwpt_is_paging(hwpt))
-		iommufd_group_remove_reserved_iova(igroup, hwpt);
+		iommufd_group_remove_reserved_iova(igroup,
+						   to_hwpt_paging(old_hwpt));
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
 	return ERR_PTR(rc);
@@ -541,6 +552,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	 */
 	bool immediate_attach = do_attach == iommufd_device_do_attach;
 	struct iommufd_hw_pagetable *destroy_hwpt;
+	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
 
 	/*
@@ -549,10 +561,11 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
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
@@ -573,12 +586,13 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
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
@@ -588,7 +602,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		destroy_hwpt = NULL;
 	}
 
-	hwpt->auto_domain = true;
+	hwpt_paging->auto_domain = true;
 	*pt_id = hwpt->obj.id;
 
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 1c13c3b6368c..ddce4189753f 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -8,56 +8,61 @@
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
 
-static int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
+static int
+iommufd_hwpt_paging_enforce_cc(struct iommufd_hwpt_paging *hwpt_paging)
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
@@ -72,12 +77,13 @@ static int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
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
 
@@ -86,14 +92,17 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
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
@@ -126,7 +135,7 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	 * allocate a separate HWPT (non-CC).
 	 */
 	if (idev->enforce_cache_coherency) {
-		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		rc = iommufd_hwpt_paging_enforce_cc(hwpt_paging);
 		if (WARN_ON(rc))
 			goto out_abort;
 	}
@@ -143,11 +152,11 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
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
@@ -160,6 +169,7 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
+	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
 	struct iommufd_device *idev;
 	struct iommufd_ioas *ioas;
@@ -181,12 +191,13 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
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
@@ -208,7 +219,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 int iommufd_hwpt_set_dirty_tracking(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_set_dirty_tracking *cmd = ucmd->cmd;
-	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_ioas *ioas;
 	int rc = -EOPNOTSUPP;
 	bool enable;
@@ -216,23 +227,24 @@ int iommufd_hwpt_set_dirty_tracking(struct iommufd_ucmd *ucmd)
 	if (cmd->flags & ~IOMMU_HWPT_DIRTY_TRACKING_ENABLE)
 		return rc;
 
-	hwpt = iommufd_get_hwpt(ucmd, cmd->hwpt_id);
-	if (IS_ERR(hwpt))
-		return PTR_ERR(hwpt);
+	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt_paging))
+		return PTR_ERR(hwpt_paging);
 
-	ioas = hwpt->ioas;
+	ioas = hwpt_paging->ioas;
 	enable = cmd->flags & IOMMU_HWPT_DIRTY_TRACKING_ENABLE;
 
-	rc = iopt_set_dirty_tracking(&ioas->iopt, hwpt->domain, enable);
+	rc = iopt_set_dirty_tracking(&ioas->iopt,
+				     hwpt_paging->common.domain, enable);
 
-	iommufd_put_object(&hwpt->obj);
+	iommufd_put_object(&hwpt_paging->common.obj);
 	return rc;
 }
 
 int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_get_dirty_bitmap *cmd = ucmd->cmd;
-	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_ioas *ioas;
 	int rc = -EOPNOTSUPP;
 
@@ -240,14 +252,15 @@ int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd)
 	    cmd->__reserved)
 		return -EOPNOTSUPP;
 
-	hwpt = iommufd_get_hwpt(ucmd, cmd->hwpt_id);
-	if (IS_ERR(hwpt))
-		return PTR_ERR(hwpt);
+	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt_paging))
+		return PTR_ERR(hwpt_paging);
 
-	ioas = hwpt->ioas;
-	rc = iopt_read_and_clear_dirty_data(&ioas->iopt, hwpt->domain,
+	ioas = hwpt_paging->ioas;
+	rc = iopt_read_and_clear_dirty_data(&ioas->iopt,
+					    hwpt_paging->common.domain,
 					    cmd->flags, cmd);
 
-	iommufd_put_object(&hwpt->obj);
+	iommufd_put_object(&hwpt_paging->common.obj);
 	return rc;
 }
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 776dd41c077f..6493fcdad1b7 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -181,7 +181,7 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type);
 
-#define iommufd_object_alloc(ictx, ptr, type)                                  \
+#define __iommufd_object_alloc(ictx, ptr, type, obj)                           \
 	container_of(_iommufd_object_alloc(                                    \
 			     ictx,                                             \
 			     sizeof(*(ptr)) + BUILD_BUG_ON_ZERO(               \
@@ -190,6 +190,9 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 			     type),                                            \
 		     typeof(*(ptr)), obj)
 
+#define iommufd_object_alloc(ictx, ptr, type)                                  \
+	__iommufd_object_alloc(ictx, ptr, type, obj)
+
 /*
  * The IO Address Space (IOAS) pagetable is a virtual page table backed by the
  * io_pagetable object. It is a user controlled mapping of IOVA -> PFNs. The
@@ -243,8 +246,12 @@ int iommufd_check_iova_range(struct io_pagetable *iopt,
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
@@ -257,33 +264,41 @@ static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
 	return hwpt->obj.type == IOMMUFD_OBJ_HWPT_PAGING;
 }
 
-static inline struct iommufd_hw_pagetable *
-iommufd_get_hwpt(struct iommufd_ucmd *ucmd, u32 id)
+static inline struct iommufd_hwpt_paging *
+to_hwpt_paging(struct iommufd_hw_pagetable *hwpt)
+{
+	return container_of(hwpt, struct iommufd_hwpt_paging, common);
+}
+
+static inline struct iommufd_hwpt_paging *
+iommufd_get_hwpt_paging(struct iommufd_ucmd *ucmd, u32 id)
 {
 	return container_of(iommufd_get_object(ucmd->ictx, id,
 					       IOMMUFD_OBJ_HWPT_PAGING),
-			    struct iommufd_hw_pagetable, obj);
+			    struct iommufd_hwpt_paging, common.obj);
 }
 int iommufd_hwpt_set_dirty_tracking(struct iommufd_ucmd *ucmd);
 int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd);
 
-struct iommufd_hw_pagetable *
-iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct iommufd_device *idev, u32 flags,
-			   bool immediate_attach);
+struct iommufd_hwpt_paging *
+iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
+			  struct iommufd_device *idev, u32 flags,
+			  bool immediate_attach);
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
index 46198e8948d6..ab6675a7f6b4 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -489,8 +489,8 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
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

