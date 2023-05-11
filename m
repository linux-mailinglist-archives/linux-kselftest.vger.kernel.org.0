Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4844D6FF4D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbjEKOnI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 10:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbjEKOma (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 10:42:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B9CE70;
        Thu, 11 May 2023 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683815931; x=1715351931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0jJBkgHs2LiMuos7AIUtcLmWfKMOM9rcJobxYX+NdgU=;
  b=X5VYdc6V4hZ2obtAIcO+ajjkrgDyuFjj3RkYToGkOc9wq4ogchiivJlK
   fCuzfBGhdZQf7jadT1z0WSaPcpJUIIlWlwwOIFa2CmcSZIW6hwKJLYP6H
   SOwmILm2rFXNKs85t3Ib+GK1UCL352Fx/5fXkxCEGbUdmu5dmjF0zp3R/
   R0xNBVnkRCcfQhAcwEHu/kTUndExc4E3aONARibUWUXKiXftix+cDKAah
   ZePkAXCrgCpKRATWliKyr5k5zmCctG+q0K2mC/A4031s2du4kS5HaPopT
   fA4eLAIHt6tp71bqaQHkecIL/5M/1EGwIR5sI3pGPr4weaimdqpYALulq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="339812885"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="339812885"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:38:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730382615"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="730382615"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2023 07:38:48 -0700
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
        zhenzhong.duan@intel.com
Subject: [PATCH v2 04/11] iommufd: Pass parent hwpt and user_data to iommufd_hw_pagetable_alloc()
Date:   Thu, 11 May 2023 07:38:37 -0700
Message-Id: <20230511143844.22693-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511143844.22693-1-yi.l.liu@intel.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Nested translation has stage-1 and stage-2 page tables. A stage-1 page
table is managed by user space, and it needs to work with a stage-2 page
table, which is a parent hwpt for the stage-1 hwpt.

iommu core already supports accepting parent iommu_domain and user_data
to allocate an iommu_domain. This makes iommufd_hw_pagetable_alloc() to
accept the parent hwpt and user_data, and relays them to iommu core, to
prepare for supporting hw_pagetable allocation with user_data.

Also, add a parent pointer in struct iommufd_hw_pagetable for taking and
releasing its refcount.

Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          |  2 +-
 drivers/iommu/iommufd/hw_pagetable.c    | 34 ++++++++++++++++++++++---
 drivers/iommu/iommufd/iommufd_private.h |  7 ++++-
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 4541d785bfd8..58c4deb3cb5d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -584,7 +584,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	}
 
 	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev,
-					  immediate_attach);
+					  NULL, NULL, immediate_attach);
 	if (IS_ERR(hwpt)) {
 		destroy_hwpt = ERR_CAST(hwpt);
 		goto out_unlock;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index b6323ad9c32d..ec9b140939ce 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -24,6 +24,8 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	if (hwpt->domain)
 		iommu_domain_free(hwpt->domain);
 
+	if (hwpt->parent)
+		refcount_dec(&hwpt->parent->obj.users);
 	refcount_dec(&hwpt->ioas->obj.users);
 }
 
@@ -61,6 +63,8 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
  * @ictx: iommufd context
  * @ioas: IOAS to associate the domain with
  * @idev: Device to get an iommu_domain for
+ * @parent: Optional parent HWPT to associate with the domain with
+ * @user_data: Optional user_data pointer
  * @immediate_attach: True if idev should be attached to the hwpt
  *
  * Allocate a new iommu_domain and return it as a hw_pagetable. The HWPT
@@ -73,14 +77,22 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
  */
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct iommufd_device *idev, bool immediate_attach)
+			   struct iommufd_device *idev,
+			   struct iommufd_hw_pagetable *parent,
+			   union iommu_domain_user_data *user_data,
+			   bool immediate_attach)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
+	struct iommu_domain *parent_domain = NULL;
 	struct iommufd_hw_pagetable *hwpt;
+	bool type_unmanaged, type_nested;
 	int rc;
 
 	lockdep_assert_held(&ioas->mutex);
 
+	if ((user_data || parent) && !ops->domain_alloc_user)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
 	if (IS_ERR(hwpt))
 		return hwpt;
@@ -89,9 +101,15 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
+	if (parent) {
+		hwpt->parent = parent;
+		parent_domain = parent->domain;
+		refcount_inc(&parent->obj.users);
+	}
 
 	if (ops->domain_alloc_user)
-		hwpt->domain = ops->domain_alloc_user(idev->dev, NULL, NULL);
+		hwpt->domain = ops->domain_alloc_user(idev->dev,
+						      parent_domain, user_data);
 	else
 		hwpt->domain = iommu_domain_alloc(idev->dev->bus);
 	if (!hwpt->domain) {
@@ -99,6 +117,15 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_abort;
 	}
 
+	/* It must be either NESTED or UNMANAGED, depending on parent_domain */
+       type_nested = hwpt->domain->type == IOMMU_DOMAIN_NESTED;
+       type_unmanaged = hwpt->domain->type == IOMMU_DOMAIN_UNMANAGED;
+       if (WARN_ON((parent_domain && !type_nested) ||
+                   (!parent_domain && !type_unmanaged))) {
+		rc = -EINVAL;
+		goto out_abort;
+	}
+
 	/*
 	 * Set the coherency mode before we do iopt_table_add_domain() as some
 	 * iommus have a per-PTE bit that controls it and need to decide before
@@ -160,7 +187,8 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	}
 
 	mutex_lock(&ioas->mutex);
-	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev, false);
+	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev,
+					  NULL, NULL, false);
 	if (IS_ERR(hwpt)) {
 		rc = PTR_ERR(hwpt);
 		goto out_unlock;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 69d6bb61d387..9fe807e0aed6 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -8,6 +8,7 @@
 #include <linux/xarray.h>
 #include <linux/refcount.h>
 #include <linux/uaccess.h>
+#include <linux/iommu.h>
 
 struct iommu_domain;
 struct iommu_group;
@@ -243,6 +244,7 @@ int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
  */
 struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
+	struct iommufd_hw_pagetable *parent;
 	struct iommufd_ioas *ioas;
 	struct iommu_domain *domain;
 	bool auto_domain : 1;
@@ -254,7 +256,10 @@ struct iommufd_hw_pagetable {
 
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct iommufd_device *idev, bool immediate_attach);
+			   struct iommufd_device *idev,
+			   struct iommufd_hw_pagetable *parent,
+			   union iommu_domain_user_data *user_data,
+			   bool immediate_attach);
 int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
-- 
2.34.1

