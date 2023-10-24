Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D017D54D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 17:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjJXPKM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbjJXPKB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 11:10:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC92210D7;
        Tue, 24 Oct 2023 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698160198; x=1729696198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=37BvLwwRACjyNHJ7JoZu+0CeXs+e2+FlLHXXOtygDGg=;
  b=Sjp+XpXjwmWdeIh9L7RFtnJEkiE91fp49cCMKYhLxo7gsx3RkVhRDMHD
   7yrhlo0EJonbRmwcJB5LB0zkDfBW2Atn1KPiAnoJAWxsXvugqJuGsVWo0
   wt6NgQD5lVoDAKHs7TikrrVc6KMRCDEsV0NJYkhE6EANHLpri0dlEC/Ra
   fAboAswIEdO+NNuKKfMXDiKC6fVghv/6QyBUn3eq7FuQKc+kIMmHLum+a
   e/5abWdAf1YKXJRl9jNN86+3Y116cghx7kLlYvE2rik4+5T6HNB6og9yd
   w+LbZtKYjGMZOnLlUtpQRSL+r8DJHuaZtdoI9JDWcLh8ZriNqca0wL2SM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418203033"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="418203033"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:06:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="6486181"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2023 08:06:21 -0700
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
Subject: [PATCH v6 06/10] iommufd: Share iommufd_hwpt_alloc with IOMMUFD_OBJ_HWPT_NESTED
Date:   Tue, 24 Oct 2023 08:06:05 -0700
Message-Id: <20231024150609.46884-7-yi.l.liu@intel.com>
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

Allow iommufd_hwpt_alloc() to have a common routine but jump to different
allocators corresponding to different user input pt_obj types, either an
IOMMUFD_OBJ_IOAS for a PAGING hwpt or an IOMMUFD_OBJ_HWPT_PAGING as the
parent for a NESTED hwpt.

Also, move the "flags" validation to the hwpt allocator (paging), so that
later the hwpt_nested allocator can do its own separate flags validation.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 46 ++++++++++++++++++----------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index ddce4189753f..fbe09e2473bc 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -82,6 +82,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			  struct iommufd_device *idev, u32 flags,
 			  bool immediate_attach)
 {
+	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
+				IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
@@ -91,6 +93,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 
 	if (flags && !ops->domain_alloc_user)
 		return ERR_PTR(-EOPNOTSUPP);
+	if (flags & ~valid_flags)
+		return ERR_PTR(-EOPNOTSUPP);
 
 	hwpt_paging = __iommufd_object_alloc(ictx, hwpt_paging,
 					     IOMMUFD_OBJ_HWPT_PAGING,
@@ -169,35 +173,41 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
-	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_ioas *ioas = NULL;
+	struct iommufd_object *pt_obj;
 	struct iommufd_device *idev;
-	struct iommufd_ioas *ioas;
 	int rc;
 
-	if ((cmd->flags & ~(IOMMU_HWPT_ALLOC_NEST_PARENT |
-			    IOMMU_HWPT_ALLOC_DIRTY_TRACKING)) ||
-	    cmd->__reserved)
+	if (cmd->__reserved)
 		return -EOPNOTSUPP;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
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
-	hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,
-						cmd->flags, false);
-	if (IS_ERR(hwpt_paging)) {
-		rc = PTR_ERR(hwpt_paging);
-		goto out_unlock;
+	if (pt_obj->type == IOMMUFD_OBJ_IOAS) {
+		struct iommufd_hwpt_paging *hwpt_paging;
+
+		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
+		mutex_lock(&ioas->mutex);
+		hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,
+							cmd->flags, false);
+		if (IS_ERR(hwpt_paging)) {
+			rc = PTR_ERR(hwpt_paging);
+			goto out_unlock;
+		}
+		hwpt = &hwpt_paging->common;
+	} else {
+		rc = -EINVAL;
+		goto out_put_pt;
 	}
-	hwpt = &hwpt_paging->common;
 
 	cmd->out_hwpt_id = hwpt->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
@@ -209,8 +219,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 out_hwpt:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
 out_unlock:
-	mutex_unlock(&ioas->mutex);
-	iommufd_put_object(&ioas->obj);
+	if (ioas)
+		mutex_unlock(&ioas->mutex);
+out_put_pt:
+	iommufd_put_object(pt_obj);
 out_put_idev:
 	iommufd_put_object(&idev->obj);
 	return rc;
-- 
2.34.1

