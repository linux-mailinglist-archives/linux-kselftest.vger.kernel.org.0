Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EED56B1D5F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 09:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjCIIJi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 03:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCIIJe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 03:09:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4211870413;
        Thu,  9 Mar 2023 00:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349373; x=1709885373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f6a+QAIRGPkjHfuRSA0kkXfLfQHx0PbJp4L/PN4a0aE=;
  b=e1zPhXb3dOUV+Bc4QV8O8xkWuvAwq1UI8SZX+f2ek4w9POvOHmwvNxFo
   u9N15MXHF1q0vvDPqBgJqnNNo2D2oCBGrLoWIrMAunhAKllGzV5DaCo/c
   dMN738rDHXt+KKEWzX/Q2Fpf8jwlqYXxAQscD8dm2vkRkaCWn2CvLvU98
   tS/aVbuw7qAH0qanQ9VZgLzRJhKnQUKwf2fH9JT0W+cYUROd18omT9CRG
   V23b0r7go2xRm/oIRhq3vlYrq5JacOTYzvQIvrnTCd9zVfLUnOhuENWmV
   uhrqi1CMu0EB3l8bsO6/+z2ECK0yqjwWCi03XtvTM1oM/pjtuQEDcBnRS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364023048"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364023048"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787471371"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787471371"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:09:24 -0800
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
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 04/12] iommufd: Pass parent hwpt and user_data to iommufd_hw_pagetable_alloc()
Date:   Thu,  9 Mar 2023 00:09:02 -0800
Message-Id: <20230309080910.607396-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309080910.607396-1-yi.l.liu@intel.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
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
 drivers/iommu/iommufd/hw_pagetable.c    | 28 ++++++++++++++++++++++---
 drivers/iommu/iommufd/iommufd_private.h |  5 ++++-
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 5c352807d946..19cd6df46c6a 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -558,7 +558,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	}
 
 	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev,
-					  immediate_attach);
+					  NULL, NULL, immediate_attach);
 	if (IS_ERR(hwpt)) {
 		destroy_hwpt = ERR_CAST(hwpt);
 		goto out_unlock;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 84b4a11e62f8..16e92a1c150b 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -24,6 +24,8 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	if (hwpt->domain)
 		iommu_domain_free(hwpt->domain);
 
+	if (hwpt->parent)
+		refcount_dec(&hwpt->parent->obj.users);
 	refcount_dec(&hwpt->ioas->obj.users);
 }
 
@@ -46,6 +48,8 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
  * @ictx: iommufd context
  * @ioas: IOAS to associate the domain with
  * @idev: Device to get an iommu_domain for
+ * @parent: Optional parent HWPT to associate with the domain with
+ * @user_data: Optional user_data pointer
  * @immediate_attach: True if idev should be attached to the hwpt
  *
  * Allocate a new iommu_domain and return it as a hw_pagetable. The HWPT
@@ -54,14 +58,20 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
  */
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct iommufd_device *idev, bool immediate_attach)
+			   struct iommufd_device *idev,
+			   struct iommufd_hw_pagetable *parent,
+			   void *user_data, bool immediate_attach)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
+	struct iommu_domain *parent_domain = NULL;
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
 	lockdep_assert_held(&ioas->mutex);
 
+	if (parent && !ops->domain_alloc_user)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
 	if (IS_ERR(hwpt))
 		return hwpt;
@@ -70,9 +80,15 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
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
@@ -80,6 +96,11 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_abort;
 	}
 
+	/* It must be either NESTED or UNMANAGED, depending on parent_domain */
+	if ((parent_domain && hwpt->domain->type != IOMMU_DOMAIN_NESTED) ||
+	    (!parent_domain && hwpt->domain->type != IOMMU_DOMAIN_UNMANAGED))
+		goto out_abort;
+
 	/*
 	 * Set the coherency mode before we do iopt_table_add_domain() as some
 	 * iommus have a per-PTE bit that controls it and need to decide before
@@ -150,7 +171,8 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	}
 
 	mutex_lock(&ioas->mutex);
-	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev, false);
+	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev,
+					  NULL, NULL, false);
 	mutex_unlock(&ioas->mutex);
 	if (IS_ERR(hwpt)) {
 		rc = PTR_ERR(hwpt);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 05b5ad66f716..182c074eecdc 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -243,6 +243,7 @@ int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
  */
 struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
+	struct iommufd_hw_pagetable *parent;
 	struct iommufd_ioas *ioas;
 	struct iommu_domain *domain;
 	bool auto_domain : 1;
@@ -254,7 +255,9 @@ struct iommufd_hw_pagetable {
 
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct iommufd_device *idev, bool immediate_attach);
+			   struct iommufd_device *idev,
+			   struct iommufd_hw_pagetable *parent,
+			   void *user_data, bool immediate_attach);
 int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
-- 
2.34.1

