Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8FB7A9AFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 20:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjIUSw5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 14:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIUSwp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 14:52:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5119258C03;
        Thu, 21 Sep 2023 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318593; x=1726854593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2mkPrmRE/ueRx331NAPcdWIqS7NvtaigtkFuUoq9+mU=;
  b=TcPKdptCkOmiW7/zpAC24u9A1BjgJmKZoxJ3nt5tkELIhU9dNBR8QX13
   6FeXVil62wLjZ0aL2fjKWhDsDU2oEB7JLUdHCVnRN8g0L5lvE6di21xih
   yS+98JFquj2HkptrCvQSCnowopSYQxC3ItSF9XzLI+nZHgCxT0vuT4gQV
   Wd70JIitsbewWPaL1t47gWOppDEqdDvG61hNe5MAqUkuPrkSRZXKIi4SA
   b9XUGQpGfl5KCO7K/o0xMHj/CL3fjdDcGGtF/LWIqJLKXxeYBSkEAt1tU
   NBxopliXReKKgzrgaGUmPUpVmiZYxY8R6XUF5F4MUL9S60gu3+4ni8JNO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832897"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832897"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649553"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649553"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:14 -0700
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
Subject: [PATCH v4 09/17] iommufd/device: Add helpers to enforce/remove device reserved regions
Date:   Thu, 21 Sep 2023 00:51:30 -0700
Message-Id: <20230921075138.124099-10-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075138.124099-1-yi.l.liu@intel.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

The iopt_table_enforce_dev_resv_regions() and iopt_remove_reserved_iova()
require callers to pass in an ioas->iopt pointer. It simply works with a
kernel-managed hw_pagetable by passing in its hwpt->ioas->iopt pointer.
However, now there could be a user-managed hw_pagetable that doesn't have
an ioas pointer. And typically most of device reserved regions should be
enforced to a kernel-managed domain only, although the IOMMU_RESV_SW_MSI
used by SMMU will introduce some complication.

Add a pair of iommufd_device_enforce_rr/iommufd_device_remove_rr helpers
that calls iopt_table_enforce_dev_resv_regions/iopt_remove_reserved_iova
functions after some additional checks. This would also ease any further
extension to support the IOMMU_RESV_SW_MSI complication mentioned above.

For the replace() routine, add another helper to compare ioas pointers,
with the support of user-managed hw_pagetables.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 42 ++++++++++++++++++-------
 drivers/iommu/iommufd/iommufd_private.h | 18 +++++++++++
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 104dd061a2a3..10e6ec590ede 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -329,6 +329,28 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	return 0;
 }
 
+static void iommufd_device_remove_rr(struct iommufd_device *idev,
+				     struct iommufd_hw_pagetable *hwpt)
+{
+	if (WARN_ON(!hwpt))
+		return;
+	if (hwpt->user_managed)
+		return;
+	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+}
+
+static int iommufd_device_enforce_rr(struct iommufd_device *idev,
+				     struct iommufd_hw_pagetable *hwpt,
+				     phys_addr_t *sw_msi_start)
+{
+	if (WARN_ON(!hwpt))
+		return -EINVAL;
+	if (hwpt->user_managed)
+		return 0;
+	return iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
+						   sw_msi_start);
+}
+
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
@@ -348,8 +370,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 			goto err_unlock;
 	}
 
-	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
-						 &idev->igroup->sw_msi_start);
+	rc = iommufd_device_enforce_rr(idev, hwpt, &idev->igroup->sw_msi_start);
 	if (rc)
 		goto err_unlock;
 
@@ -375,7 +396,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	mutex_unlock(&idev->igroup->lock);
 	return 0;
 err_unresv:
-	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	iommufd_device_remove_rr(idev, hwpt);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
 	return rc;
@@ -392,7 +413,7 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 		iommu_detach_group(hwpt->domain, idev->igroup->group);
 		idev->igroup->hwpt = NULL;
 	}
-	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	iommufd_device_remove_rr(idev, hwpt);
 	mutex_unlock(&idev->igroup->lock);
 
 	/* Caller must destroy hwpt */
@@ -444,10 +465,9 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	}
 
 	old_hwpt = igroup->hwpt;
-	if (hwpt->ioas != old_hwpt->ioas) {
+	if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt)) {
 		list_for_each_entry(cur, &igroup->device_list, group_item) {
-			rc = iopt_table_enforce_dev_resv_regions(
-				&hwpt->ioas->iopt, cur->dev, NULL);
+			rc = iommufd_device_enforce_rr(cur, hwpt, NULL);
 			if (rc)
 				goto err_unresv;
 		}
@@ -461,12 +481,10 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	if (rc)
 		goto err_unresv;
 
-	if (hwpt->ioas != old_hwpt->ioas) {
+	if (iommufd_hw_pagetable_compare_ioas(old_hwpt, hwpt)) {
 		list_for_each_entry(cur, &igroup->device_list, group_item)
-			iopt_remove_reserved_iova(&old_hwpt->ioas->iopt,
-						  cur->dev);
+			iommufd_device_remove_rr(cur, hwpt);
 	}
-
 	igroup->hwpt = hwpt;
 
 	/*
@@ -483,7 +501,7 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	return old_hwpt;
 err_unresv:
 	list_for_each_entry(cur, &igroup->device_list, group_item)
-		iopt_remove_reserved_iova(&hwpt->ioas->iopt, cur->dev);
+		iommufd_device_remove_rr(cur, hwpt);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
 	return ERR_PTR(rc);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 34940596c2c2..b14f23d3f42e 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -281,6 +281,24 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 		refcount_dec(&hwpt->obj.users);
 }
 
+static inline bool
+iommufd_hw_pagetable_compare_ioas(struct iommufd_hw_pagetable *old_hwpt,
+				  struct iommufd_hw_pagetable *new_hwpt)
+{
+	struct iommufd_ioas *old_ioas, *new_ioas;
+
+	WARN_ON(!old_hwpt || !new_hwpt);
+	if (old_hwpt->user_managed)
+		old_ioas = old_hwpt->parent->ioas;
+	else
+		old_ioas = old_hwpt->ioas;
+	if (new_hwpt->user_managed)
+		new_ioas = new_hwpt->parent->ioas;
+	else
+		new_ioas = new_hwpt->ioas;
+	return old_ioas != new_ioas;
+}
+
 struct iommufd_group {
 	struct kref ref;
 	struct mutex lock;
-- 
2.34.1

