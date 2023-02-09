Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFE068FF3F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBIEe6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjBIEdt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:33:49 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D774C0FB;
        Wed,  8 Feb 2023 20:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917160; x=1707453160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2KfonypPuxfAWElcJEc2WJ7TkQ9Vf7HGpR1uJgAGgAk=;
  b=mhB9pUBXEP6tK0Ce/FGh1x4HO6j44aEFvSER4q9jHMTe/KdaDCRR3qIc
   6AfnNp3NPvlPA9JYAjoK3Mty6OHOwbXDMgHRqtu/pwha3GmIixOPNaKKH
   OZL3odDs1+BJCoQYQe14oyEfNdHKa4bU+BMCZ8i39ssu6NOgeUt8c1GPT
   aEHrqhbH+6w/GD5dLIxU68t1XlXkYPLO/d6fL5J7R88uYUwj/lynJPKBq
   QONm6e8Smm783T8YZ4o+bWFSQ+uGW0Ww3RCfqkDY6Sv1tNPc19IkfSCqa
   qPXr6IA4Y9aP8+h5GxAP2sLgkSuTk30nfmZS3SSVR0un4bzr5VzePdO1e
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298726"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298726"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447536"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447536"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:10 -0800
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: [PATCH 07/17] iommufd: Add/del hwpt to IOAS at alloc/destroy()
Date:   Wed,  8 Feb 2023 20:31:43 -0800
Message-Id: <20230209043153.14964-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

A hw_pagetable is allocated with an IOAS id, so it was supposed to link
to the IOAS upon its allocation. But, previously with ARM SMMUv3 driver
IOMMUFD fails to add a newly allocated hwpt to the IOAS, because SMMUv3
driver "finalises" an iommu_domain (hwpt->domain) after it attaches to
a device. This was because the existing domain_alloc op doesn't pass in
a dev pointer, so the driver could not know which SMMU device to look
for. Now, IOMMUFD allocates the hwpt->domain using domain_alloc_user op
that passes in the dev pointer. So, there's no need to wait for a device
attachment anymore.

Move iopt_table_add_domain() call, along with the list_add_tail call on
the hwpt_item, to the iommufd_hw_pagetable_alloc() right after a domain
allocation. Accordingly, move iopt_table_remove_domain() and list_del to
the iommufd_hw_pagetable_destroy() routine.

This simplifies the logic in the do_attach/detach(), by reducing the
dependency on the device list and potential locking conundrum with the
coming nesting feature.

Similarly, drop the iopt_table_add/remove_domain() calls, for selftest,
from the iommufd_device_selftest_attach/detach(). Also, allocate hwpts
outside the iommufd_device_selftest_attach() to make it symmetric with
the iommufd_device_selftest_detach().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 54 ++++---------------------
 drivers/iommu/iommufd/hw_pagetable.c    | 13 ++++++
 drivers/iommu/iommufd/iommufd_private.h |  6 +--
 drivers/iommu/iommufd/selftest.c        | 16 ++++++--
 4 files changed, 35 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 0e5d2bde7b3c..71a8c4f1c4a9 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -311,18 +311,11 @@ static void __iommmufd_device_detach(struct iommufd_device *idev,
 
 	mutex_lock(&hwpt->devices_lock);
 	list_del(&idev->devices_item);
-	if (hwpt->ioas != new_ioas)
-		mutex_lock(&hwpt->ioas->mutex);
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
-		if (list_empty(&hwpt->devices)) {
-			iopt_table_remove_domain(&hwpt->ioas->iopt,
-						 hwpt->domain);
-			list_del(&hwpt->hwpt_item);
-		}
-		if (detach_group)
-			iommu_detach_group(hwpt->domain, idev->group);
-	}
+	if (detach_group && !iommufd_hw_pagetable_has_group(hwpt, idev->group))
+		iommu_detach_group(hwpt->domain, idev->group);
+
 	if (hwpt->ioas != new_ioas) {
+		mutex_lock(&hwpt->ioas->mutex);
 		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 		mutex_unlock(&hwpt->ioas->mutex);
 	}
@@ -384,14 +377,6 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 		rc = iommu_group_replace_domain(idev->group, hwpt->domain);
 		if (rc)
 			goto out_iova;
-
-		if (list_empty(&hwpt->devices)) {
-			rc = iopt_table_add_domain(&hwpt->ioas->iopt,
-						   hwpt->domain);
-			if (rc)
-				goto out_detach;
-			list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
-		}
 	}
 
 	/* Replace the cur_hwpt without iommu_detach_group() */
@@ -404,11 +389,6 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 	mutex_unlock(&hwpt->devices_lock);
 	return 0;
 
-out_detach:
-	if (cur_hwpt)
-		iommu_group_replace_domain(idev->group, cur_hwpt->domain);
-	else
-		iommu_detach_group(hwpt->domain, idev->group);
 out_iova:
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 out_unlock:
@@ -940,35 +920,17 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_rw, IOMMUFD);
  * Creating a real iommufd_device is too hard, bypass creating a iommufd_device
  * and go directly to attaching a domain.
  */
-struct iommufd_hw_pagetable *
-iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
-			       struct iommufd_ioas *ioas,
-			       struct device *mock_dev)
-{
-	struct iommufd_hw_pagetable *hwpt;
-	int rc;
-
-	hwpt = iommufd_hw_pagetable_alloc(ictx, ioas, mock_dev);
-	if (IS_ERR(hwpt))
-		return hwpt;
-
-	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
-	if (rc)
-		goto out_hwpt;
 
+int iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
+				   struct iommufd_hw_pagetable *hwpt)
+{
 	refcount_inc(&hwpt->obj.users);
-	iommufd_object_finalize(ictx, &hwpt->obj);
-	return hwpt;
-
-out_hwpt:
-	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
-	return ERR_PTR(rc);
+	return 0;
 }
 
 void iommufd_device_selftest_detach(struct iommufd_ctx *ictx,
 				    struct iommufd_hw_pagetable *hwpt)
 {
-	iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
 	refcount_dec(&hwpt->obj.users);
 }
 #endif
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 08d963ee38c7..bda21ec737cf 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -11,8 +11,12 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	struct iommufd_hw_pagetable *hwpt =
 		container_of(obj, struct iommufd_hw_pagetable, obj);
 
+	lockdep_assert_held(&hwpt->ioas->mutex);
+
 	WARN_ON(!list_empty(&hwpt->devices));
 
+	iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
+	list_del(&hwpt->hwpt_item);
 	iommu_domain_free(hwpt->domain);
 	refcount_dec(&hwpt->ioas->obj.users);
 	mutex_destroy(&hwpt->devices_lock);
@@ -34,6 +38,8 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
+	lockdep_assert_held(&ioas->mutex);
+
 	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
 	if (IS_ERR(hwpt))
 		return hwpt;
@@ -53,11 +59,18 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	INIT_LIST_HEAD(&hwpt->devices);
 	INIT_LIST_HEAD(&hwpt->hwpt_item);
 	mutex_init(&hwpt->devices_lock);
+	rc = iopt_table_add_domain(&ioas->iopt, hwpt->domain);
+	if (rc)
+		goto out_free_domain;
+	list_add_tail(&hwpt->hwpt_item, &ioas->hwpt_list);
+
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
 	return hwpt;
 
+out_free_domain:
+	iommu_domain_free(hwpt->domain);
 out_abort:
 	iommufd_object_abort(ictx, &hwpt->obj);
 	return ERR_PTR(rc);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 7748117e36f9..604ad29f87b8 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -278,10 +278,8 @@ void iopt_remove_access(struct io_pagetable *iopt,
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
 #ifdef CONFIG_IOMMUFD_TEST
-struct iommufd_hw_pagetable *
-iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
-			       struct iommufd_ioas *ioas,
-			       struct device *mock_dev);
+int iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
+				   struct iommufd_hw_pagetable *hwpt);
 void iommufd_device_selftest_detach(struct iommufd_ctx *ictx,
 				    struct iommufd_hw_pagetable *hwpt);
 struct device *iommufd_selftest_obj_to_dev(struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 5013c8757f4b..5f841d1d9e96 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -311,22 +311,30 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	sobj->idev.mock_dev.bus = &mock_bus;
 	sobj->idev.mock_dev.iommu = &iommu;
 
-	hwpt = iommufd_device_selftest_attach(ucmd->ictx, ioas,
-					      &sobj->idev.mock_dev);
+	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas,
+					  &sobj->idev.mock_dev);
 	if (IS_ERR(hwpt)) {
 		rc = PTR_ERR(hwpt);
-		goto out_sobj;
+		goto out_unlock;
 	}
 	sobj->idev.hwpt = hwpt;
 
+	rc = iommufd_device_selftest_attach(ucmd->ictx, hwpt);
+	if (rc)
+		goto out_free_hwpt;
+
 	/* Userspace must destroy both of these IDs to destroy the object */
 	cmd->mock_domain.out_hwpt_id = hwpt->obj.id;
 	cmd->mock_domain.out_device_id = sobj->obj.id;
 	iommufd_object_finalize(ucmd->ictx, &sobj->obj);
+	iommufd_object_finalize(ucmd->ictx, &hwpt->obj);
 	iommufd_put_object(&ioas->obj);
 	return iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
-out_sobj:
+out_free_hwpt:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
+out_unlock:
+	mutex_unlock(&ioas->mutex);
 	iommufd_object_abort(ucmd->ictx, &sobj->obj);
 out_ioas:
 	iommufd_put_object(&ioas->obj);
-- 
2.34.1

