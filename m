Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8733B7B146F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 09:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjI1HPl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 03:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjI1HPi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 03:15:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C5CBE;
        Thu, 28 Sep 2023 00:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695885336; x=1727421336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZbmgDv3TXndc8FlXP9Hwf4R9VBmB58wZHJMvSo5a+l0=;
  b=gjdAgFkVgRl0ElXuSJwdw/itOZoSd78eqpmQIjiCSOyZRmuojwyUbHpi
   3MWY94UpS2Rtl9CGAjRcYPZpjFIx0duE3Xb8rdet4/tVnDTypiTgshs11
   vbehTu7KaN+pFRwrb/Ch1ieYutZ717r8CGcCYf9pshrOoPTPj3Ktv7OEB
   u1+5hZvSfUGt+xyKQzeSw/wUva9vrDyO+wZN9A8IbOhmU2/X68yNdsMOf
   YkUyhxdk2qKcVuuX//+jd5bqUthy4V9erlq8pvc6ophwTzqtS3xT1QyGL
   JGOE6Jic13oKAOqRz+vXNEZ5g7jC7H4XPiWhX6S7mZPJtbAtYN0PP8DWs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="412914850"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="412914850"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:15:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="784602027"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="784602027"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga001.jf.intel.com with ESMTP; 28 Sep 2023 00:15:33 -0700
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
Subject: [PATCH v2 3/6] iommufd/hw_pagetable: Accepts user flags for domain allocation
Date:   Thu, 28 Sep 2023 00:15:25 -0700
Message-Id: <20230928071528.26258-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928071528.26258-1-yi.l.liu@intel.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
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

This extends iommufd_hw_pagetable_alloc() to accepts user flags.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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

