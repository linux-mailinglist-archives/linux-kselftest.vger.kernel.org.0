Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1870C75F445
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjGXLEd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjGXLE1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:04:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97786E7C;
        Mon, 24 Jul 2023 04:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196660; x=1721732660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YsgoeQkQQrPWohp2NoLi++Hed46Wb48fWZYPCiqb+vg=;
  b=ljz35/5jYPMTE1n8yZYp2VOFCeq8utetdag7ZCqOtZU9TowF7qWwzjUU
   9gXwR8PFH89+pczQvJCPXfl94ksXGc3+e1PynBD07zSPtX5MVLiTb61p1
   uBId9RPs/IF77uE12vXwTq+X+YWOAnfyF6wdmESs32uuOEhTga74KEs35
   DdkNO0ams0BvvucjS3PVsMP/cVemhlKKUVZ6WcLv7SLxcCNZKKjFRNASq
   6SrWtrgSfHQfZI9LpqA5HwLcolaCmcg9L0St9bqf2QAES8ZjzjmADZTvA
   6JajbT9XBjiGfk+TCzTt2sdNYKy3kA0LuX4fn/g/OPGaejOYu1/CLY3+f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="366301802"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="366301802"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775782"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775782"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:13 -0700
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
Subject: [PATCH v3 04/17] iommufd: Pass in hwpt_type/parent/user_data to iommufd_hw_pagetable_alloc()
Date:   Mon, 24 Jul 2023 04:03:53 -0700
Message-Id: <20230724110406.107212-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724110406.107212-1-yi.l.liu@intel.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/iommu/iommufd/device.c          |  3 +-
 drivers/iommu/iommufd/hw_pagetable.c    | 40 +++++++++++++++++++++----
 drivers/iommu/iommufd/iommufd_private.h |  8 ++++-
 3 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 0deb2a2ec01a..97e4e5f5aca0 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -542,7 +542,8 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	}
 
 	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev,
-					  immediate_attach);
+					  IOMMU_HWPT_TYPE_DEFAULT,
+					  NULL, NULL, immediate_attach);
 	if (IS_ERR(hwpt)) {
 		destroy_hwpt = ERR_CAST(hwpt);
 		goto out_unlock;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 1371e96653b2..28122a49b529 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -24,6 +24,8 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	if (hwpt->domain)
 		iommu_domain_free(hwpt->domain);
 
+	if (hwpt->parent)
+		refcount_dec(&hwpt->parent->obj.users);
 	refcount_dec(&hwpt->ioas->obj.users);
 }
 
@@ -61,6 +63,9 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
  * @ictx: iommufd context
  * @ioas: IOAS to associate the domain with
  * @idev: Device to get an iommu_domain for
+ * @hwpt_type: Requested type of hw_pagetable
+ * @parent: Optional parent HWPT to associate with
+ * @user_data: Optional user_data pointer
  * @immediate_attach: True if idev should be attached to the hwpt
  *
  * Allocate a new iommu_domain and return it as a hw_pagetable. The HWPT
@@ -73,14 +78,24 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
  */
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct iommufd_device *idev, bool immediate_attach)
+			   struct iommufd_device *idev,
+			   enum iommu_hwpt_type hwpt_type,
+			   struct iommufd_hw_pagetable *parent,
+			   union iommu_domain_user_data *user_data,
+			   bool immediate_attach)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
+	struct iommu_domain *parent_domain = NULL;
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
 	lockdep_assert_held(&ioas->mutex);
 
+	if (parent && !user_data)
+		return ERR_PTR(-EINVAL);
+	if (user_data && !ops->domain_alloc_user)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
 	if (IS_ERR(hwpt))
 		return hwpt;
@@ -89,11 +104,15 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	/* Pairs with iommufd_hw_pagetable_destroy() */
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
+	if (parent) {
+		hwpt->parent = parent;
+		parent_domain = parent->domain;
+		refcount_inc(&parent->obj.users);
+	}
 
 	if (ops->domain_alloc_user) {
-		hwpt->domain = ops->domain_alloc_user(idev->dev,
-						      IOMMU_HWPT_TYPE_DEFAULT,
-						      NULL, NULL);
+		hwpt->domain = ops->domain_alloc_user(idev->dev, hwpt_type,
+						      parent_domain, user_data);
 		if (IS_ERR(hwpt->domain)) {
 			rc = PTR_ERR(hwpt->domain);
 			hwpt->domain = NULL;
@@ -107,6 +126,15 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		}
 	}
 
+	/* It must be either NESTED or UNMANAGED, depending on parent_domain */
+	if (WARN_ON_ONCE((parent_domain &&
+			  hwpt->domain->type != IOMMU_DOMAIN_NESTED) ||
+			 (!parent_domain &&
+			  hwpt->domain->type != IOMMU_DOMAIN_UNMANAGED))) {
+		rc = -EINVAL;
+		goto out_abort;
+	}
+
 	/*
 	 * Set the coherency mode before we do iopt_table_add_domain() as some
 	 * iommus have a per-PTE bit that controls it and need to decide before
@@ -168,7 +196,9 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	}
 
 	mutex_lock(&ioas->mutex);
-	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev, false);
+	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev,
+					  IOMMU_HWPT_TYPE_DEFAULT,
+					  NULL, NULL, false);
 	if (IS_ERR(hwpt)) {
 		rc = PTR_ERR(hwpt);
 		goto out_unlock;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index dba730129b8c..90dcf4041530 100644
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
@@ -254,7 +256,11 @@ struct iommufd_hw_pagetable {
 
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct iommufd_device *idev, bool immediate_attach);
+			   struct iommufd_device *idev,
+			   enum iommu_hwpt_type hwpt_type,
+			   struct iommufd_hw_pagetable *parent,
+			   union iommu_domain_user_data *user_data,
+			   bool immediate_attach);
 int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
-- 
2.34.1

