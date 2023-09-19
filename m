Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CD47A5DD0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 11:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjISJ0b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 05:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjISJ0V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 05:26:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939E1102;
        Tue, 19 Sep 2023 02:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695115576; x=1726651576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nqhafFsOTCXMpS7yBdxvrhkU6NiVVIo1xDbd9DzqNGI=;
  b=OkOXU2b60WA0DZ/h0Vh/3RZIuya4J47xG8j+efDmw9TUbxA9od6KmzCt
   fAndSzsyLlVcUyj1lVvrz+D+RqVI3Ax54STXAODerUFTM6+1dgObR9pXF
   qKKOASkMZIVvwsn9HWqO6OqcCoxawy/if/lxs2XHg6lgVSVwcP69y/lUG
   thxyv+0DxR87hVD0At4jbLbHKk9B1XUoKrIBK1LBmW76Sx+wB/0d6SjJk
   8ur8Qijwhsu3nQuaINp29sVKeroVhPUyA22Ec0vkyOjg9eHxnwH6JQ8Ny
   efZWnEdx1EZZDwX6qK8+NR3DD02AddO/0yLt2tAoecW3cM8u1t3+qHlCY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446368958"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="446368958"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 02:25:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="722804771"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="722804771"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 19 Sep 2023 02:25:34 -0700
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
Subject: [PATCH 3/6] iommufd/hw_pagetable: Accepts user flags for domain allocation
Date:   Tue, 19 Sep 2023 02:25:20 -0700
Message-Id: <20230919092523.39286-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919092523.39286-1-yi.l.liu@intel.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This extends iommufd_hw_pagetable_alloc() to accepts user flags.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 2 +-
 drivers/iommu/iommufd/hw_pagetable.c    | 9 ++++++---
 drivers/iommu/iommufd/iommufd_private.h | 3 ++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index ce78c3671539..e88fa73a45e6 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -540,7 +540,7 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	}
 
 	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev,
-					  immediate_attach);
+					  0, immediate_attach);
 	if (IS_ERR(hwpt)) {
 		destroy_hwpt = ERR_CAST(hwpt);
 		goto out_unlock;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 48874f896521..5be7a31cbd9c 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -61,6 +61,7 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
  * @ictx: iommufd context
  * @ioas: IOAS to associate the domain with
  * @idev: Device to get an iommu_domain for
+ * @flags: Flags from userspace
  * @immediate_attach: True if idev should be attached to the hwpt
  *
  * Allocate a new iommu_domain and return it as a hw_pagetable. The HWPT
@@ -73,7 +74,8 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
  */
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct iommufd_device *idev, bool immediate_attach)
+			   struct iommufd_device *idev, u32 flags,
+			   bool immediate_attach)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hw_pagetable *hwpt;
@@ -91,7 +93,7 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	hwpt->ioas = ioas;
 
 	if (ops->domain_alloc_user) {
-		hwpt->domain = ops->domain_alloc_user(idev->dev, 0);
+		hwpt->domain = ops->domain_alloc_user(idev->dev, flags);
 		if (IS_ERR(hwpt->domain)) {
 			rc = PTR_ERR(hwpt->domain);
 			hwpt->domain = NULL;
@@ -166,7 +168,8 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	}
 
 	mutex_lock(&ioas->mutex);
-	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev, false);
+	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas,
+					  idev, cmd->flags, false);
 	if (IS_ERR(hwpt)) {
 		rc = PTR_ERR(hwpt);
 		goto out_unlock;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 2c58670011fe..3064997a0181 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -242,7 +242,8 @@ struct iommufd_hw_pagetable {
 
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct iommufd_device *idev, bool immediate_attach);
+			   struct iommufd_device *idev, u32 flags,
+			   bool immediate_attach);
 int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
-- 
2.34.1

