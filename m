Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4DB7D7B98
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 06:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbjJZEj6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 00:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjJZEjw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 00:39:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE55D186;
        Wed, 25 Oct 2023 21:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698295188; x=1729831188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VzU84oetmnLH1pN8XZzdCzD5/BUGYg5LyBn9RczZ7eQ=;
  b=F5u8SwKrXN6DaEG9dhzsWw0NmC9biUqBxEZZ3rK8ugVUdtxXbGw0u2Pv
   YAV0FJoP5/QkZBlDnGjrSAXOAMdBrAe/7feVEsz0d5H+w3ZJF86l0Rl3T
   BDb3v0LqjAUASAsya+ZxL+zT3aqN1ijHW1duimdc2x4lcNIUVpnxJHTOZ
   eEQb5IoVQ08qxBZ4F63dTgTqbYiSx+s0cCAdudHdCvXS4+3LZxloeWGos
   RzQWZwXptMO+T0oTwFICee/eSm6L1rGQPenjksPKyv1Ef0Aq7WSNrXukn
   XPZrl3mDErVD2C+ePS8w2lcDw0ox5h3XBGXKdnlXzvuMUw46w/0c2tvjo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9014463"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="9014463"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:39:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="708931294"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="708931294"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2023 21:39:43 -0700
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
Subject: [PATCH v7 03/10] iommufd/device: Wrap IOMMUFD_OBJ_HWPT_PAGING-only configurations
Date:   Wed, 25 Oct 2023 21:39:31 -0700
Message-Id: <20231026043938.63898-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026043938.63898-1-yi.l.liu@intel.com>
References: <20231026043938.63898-1-yi.l.liu@intel.com>
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

From: Jason Gunthorpe <jgg@nvidia.com>

Some of the configurations during the attach/replace() should only apply
to IOMMUFD_OBJ_HWPT_PAGING. Once IOMMUFD_OBJ_HWPT_NESTED gets introduced
in a following patch, keeping them unconditionally in the common routine
will not work.

Wrap all of those PAGING-only configurations together into helpers. Do a
hwpt_is_paging check whenever calling them or their fallback routines.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 111 +++++++++++++++++-------
 drivers/iommu/iommufd/iommufd_private.h |   5 ++
 2 files changed, 86 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 449b64e6ef53..0c844acb15b9 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -325,6 +325,28 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 	return 0;
 }
 
+static int iommufd_hwpt_paging_attach(struct iommufd_hw_pagetable *hwpt,
+				      struct iommufd_device *idev)
+{
+	int rc;
+
+	lockdep_assert_held(&idev->igroup->lock);
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
@@ -337,10 +359,11 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unlock;
 	}
 
-	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
-						 &idev->igroup->sw_msi_start);
-	if (rc)
-		goto err_unlock;
+	if (hwpt_is_paging(hwpt)) {
+		rc = iommufd_hwpt_paging_attach(hwpt, idev);
+		if (rc)
+			goto err_unlock;
+	}
 
 	/*
 	 * Only attach to the group once for the first device that is in the
@@ -350,10 +373,6 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
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
@@ -364,7 +383,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	mutex_unlock(&idev->igroup->lock);
 	return 0;
 err_unresv:
-	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	if (hwpt_is_paging(hwpt))
+		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 err_unlock:
 	mutex_unlock(&idev->igroup->lock);
 	return rc;
@@ -381,7 +401,8 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 		iommu_detach_group(hwpt->domain, idev->igroup->group);
 		idev->igroup->hwpt = NULL;
 	}
-	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	if (hwpt_is_paging(hwpt))
+		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 	mutex_unlock(&idev->igroup->lock);
 
 	/* Caller must destroy hwpt */
@@ -400,13 +421,52 @@ iommufd_device_do_attach(struct iommufd_device *idev,
 	return NULL;
 }
 
+static void
+iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
+				   struct iommufd_hw_pagetable *hwpt)
+{
+	struct iommufd_device *cur;
+
+	lockdep_assert_held(&igroup->lock);
+
+	list_for_each_entry(cur, &igroup->device_list, group_item)
+		iopt_remove_reserved_iova(&hwpt->ioas->iopt, cur->dev);
+}
+
+static int iommufd_group_do_replace_paging(struct iommufd_group *igroup,
+					   struct iommufd_hw_pagetable *hwpt)
+{
+	struct iommufd_hw_pagetable *old_hwpt = igroup->hwpt;
+	struct iommufd_device *cur;
+	int rc;
+
+	lockdep_assert_held(&igroup->lock);
+
+	if (!hwpt_is_paging(old_hwpt) || hwpt->ioas != old_hwpt->ioas) {
+		list_for_each_entry(cur, &igroup->device_list, group_item) {
+			rc = iopt_table_enforce_dev_resv_regions(
+				&hwpt->ioas->iopt, cur->dev, NULL);
+			if (rc)
+				goto err_unresv;
+		}
+	}
+
+	rc = iommufd_group_setup_msi(igroup, hwpt);
+	if (rc)
+		goto err_unresv;
+	return 0;
+
+err_unresv:
+	iommufd_group_remove_reserved_iova(igroup, hwpt);
+	return rc;
+}
+
 static struct iommufd_hw_pagetable *
 iommufd_device_do_replace(struct iommufd_device *idev,
 			  struct iommufd_hw_pagetable *hwpt)
 {
 	struct iommufd_group *igroup = idev->igroup;
 	struct iommufd_hw_pagetable *old_hwpt;
-	struct iommufd_device *cur;
 	unsigned int num_devices;
 	int rc;
 
@@ -422,29 +482,20 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 		return NULL;
 	}
 
-	old_hwpt = igroup->hwpt;
-	if (hwpt->ioas != old_hwpt->ioas) {
-		list_for_each_entry(cur, &igroup->device_list, group_item) {
-			rc = iopt_table_enforce_dev_resv_regions(
-				&hwpt->ioas->iopt, cur->dev, NULL);
-			if (rc)
-				goto err_unresv;
-		}
+	if (hwpt_is_paging(hwpt)) {
+		rc = iommufd_group_do_replace_paging(igroup, hwpt);
+		if (rc)
+			goto err_unlock;
 	}
 
-	rc = iommufd_group_setup_msi(idev->igroup, hwpt);
-	if (rc)
-		goto err_unresv;
-
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
 
@@ -462,8 +513,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
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
index 70bebad63a74..776dd41c077f 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -252,6 +252,11 @@ struct iommufd_hw_pagetable {
 	struct list_head hwpt_item;
 };
 
+static inline bool hwpt_is_paging(struct iommufd_hw_pagetable *hwpt)
+{
+	return hwpt->obj.type == IOMMUFD_OBJ_HWPT_PAGING;
+}
+
 static inline struct iommufd_hw_pagetable *
 iommufd_get_hwpt(struct iommufd_ucmd *ucmd, u32 id)
 {
-- 
2.34.1

