Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE8C7A9BC0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 21:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjIUTEO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 15:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjIUTED (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 15:04:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CDE5B99;
        Thu, 21 Sep 2023 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318592; x=1726854592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bz3ca0YRi75jrvCVUg/Zp4X79iO7/7EaRLPYgFOWiCI=;
  b=fZbKJ8myqMe+3ImZSrhI1iGjNHKssv0agOgCVsJCZTiAl/hfiNb1c17f
   zaUBtUopjfqkx/QZ5ZIEexqjm4oDBEKpZjpmhjlcYSRUl0tZm08Fbx7ux
   /rFnhZcVgPp+M/ZH+iSBI1d2tepPxk2Y+2i9immJ9EZkoiyhl7UC3p18g
   gue1/gbJLz+1tgWRxVbnMidvMQuJ+qYxY9iFIR80Z9WwisdIbsgfYF9/A
   XiYvcSIkFcUlyPc3hbwkKqDZjZQUZvFPFlXqrpyE3ba9A/XQG3mvnCYh8
   b7YrQMxlV5OEp7tmvfHZcwEJY8/bAK0c1lv/Gsj9upHkzEpkTZZG3P+r4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832860"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832860"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649520"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649520"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:11 -0700
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
Subject: [PATCH v4 06/17] iommufd: Add shared alloc_fn function pointer and mutex pointer
Date:   Thu, 21 Sep 2023 00:51:27 -0700
Message-Id: <20230921075138.124099-7-yi.l.liu@intel.com>
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

This allows iommufd_hwpt_alloc() to have a common routine but jump to a
different allocator and hold a different mutex, corresponding to types
of HWPT allocation (either kernel-managed or user-managed). This shared
function pointer takes "pt_obj" as an input that would be coverted into
an IOAS pointer or a parent HWPT pointer.

Then, update the kernel-managed allocator to follow this pt_obj change.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          |  2 +-
 drivers/iommu/iommufd/hw_pagetable.c    | 46 ++++++++++++++++++-------
 drivers/iommu/iommufd/iommufd_private.h |  3 +-
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e04900f101f1..eb120f70a3e3 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -539,7 +539,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		goto out_unlock;
 	}
 
-	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev,
+	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, &ioas->obj, idev,
 					  0, IOMMU_HWPT_TYPE_DEFAULT,
 					  NULL, immediate_attach);
 	if (IS_ERR(hwpt)) {
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 1cc7178121d1..b2af68776877 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -69,7 +69,7 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
 /**
  * iommufd_hw_pagetable_alloc() - Get a kernel-managed iommu_domain for a device
  * @ictx: iommufd context
- * @ioas: IOAS to associate the domain with
+ * @pt_obj: An object to an IOAS to associate the domain with
  * @idev: Device to get an iommu_domain for
  * @flags: Flags from userspace
  * @hwpt_type: Requested type of hw_pagetable
@@ -85,12 +85,15 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
  * the returned hwpt.
  */
 struct iommufd_hw_pagetable *
-iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
+iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx,
+			   struct iommufd_object *pt_obj,
 			   struct iommufd_device *idev, u32 flags,
 			   enum iommu_hwpt_type hwpt_type,
 			   struct iommu_user_data *user_data,
 			   bool immediate_attach)
 {
+	struct iommufd_ioas *ioas =
+		container_of(pt_obj, struct iommufd_ioas, obj);
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
@@ -184,10 +187,19 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
+	struct iommufd_hw_pagetable *(*alloc_fn)(
+					struct iommufd_ctx *ictx,
+					struct iommufd_object *pt_obj,
+					struct iommufd_device *idev,
+					u32 flags, enum iommu_hwpt_type type,
+					struct iommu_user_data *user_data,
+					bool flag);
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
 	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_object *pt_obj;
 	struct iommufd_device *idev;
 	struct iommufd_ioas *ioas;
+	struct mutex *mutex;
 	int rc;
 
 	if (cmd->flags & ~IOMMU_HWPT_ALLOC_NEST_PARENT || cmd->__reserved)
@@ -197,17 +209,26 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 
-	ioas = iommufd_get_ioas(ucmd->ictx, cmd->pt_id);
-	if (IS_ERR(ioas)) {
-		rc = PTR_ERR(ioas);
+	pt_obj = iommufd_get_object(ucmd->ictx, cmd->pt_id, IOMMUFD_OBJ_ANY);
+	if (IS_ERR(pt_obj)) {
+		rc = -EINVAL;
 		goto out_put_idev;
 	}
 
-	mutex_lock(&ioas->mutex);
-	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas,
-					  idev, cmd->flags,
-					  IOMMU_HWPT_TYPE_DEFAULT,
-					  NULL, false);
+	switch (pt_obj->type) {
+	case IOMMUFD_OBJ_IOAS:
+		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
+		mutex = &ioas->mutex;
+		alloc_fn = iommufd_hw_pagetable_alloc;
+		break;
+	default:
+		rc = -EINVAL;
+		goto out_put_pt;
+	}
+
+	mutex_lock(mutex);
+	hwpt = alloc_fn(ucmd->ictx, pt_obj, idev, cmd->flags,
+			IOMMU_HWPT_TYPE_DEFAULT, NULL, false);
 	if (IS_ERR(hwpt)) {
 		rc = PTR_ERR(hwpt);
 		goto out_unlock;
@@ -223,8 +244,9 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 out_hwpt:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
 out_unlock:
-	mutex_unlock(&ioas->mutex);
-	iommufd_put_object(&ioas->obj);
+	mutex_unlock(mutex);
+out_put_pt:
+	iommufd_put_object(pt_obj);
 out_put_idev:
 	iommufd_put_object(&idev->obj);
 	return rc;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 3e89c3d530f3..e4d06ae6b0c5 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -250,7 +250,8 @@ struct iommufd_hw_pagetable {
 };
 
 struct iommufd_hw_pagetable *
-iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
+iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx,
+			   struct iommufd_object *pt_obj,
 			   struct iommufd_device *idev, u32 flags,
 			   enum iommu_hwpt_type hwpt_type,
 			   struct iommu_user_data *user_data,
-- 
2.34.1

