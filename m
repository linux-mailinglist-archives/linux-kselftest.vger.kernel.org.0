Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9617D0B5C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376635AbjJTJUD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376636AbjJTJUB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:20:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0E6D63;
        Fri, 20 Oct 2023 02:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697793599; x=1729329599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kUfgqW/lAODTF0S1kos6ZtnnekNva98TjIvhpU120+s=;
  b=YxqgVbUj4STtSUjOfip6V78UCTLEWp31YOwoqg44jDGf0t4U99LKk2Rt
   7R1lAL3wYZHJBRURpg8Gzr4WYTVjJExAY0z3rH+9JTWrNyLgdIsDIURAo
   2VeqRUJiGwlt6Q270AOhia8gDeeKJA8RWOyeW5XwG8WFlF320yYgwhQqz
   kQZVO3s2pLbIqtvdUaM8QE465RJDSMR57AQXPicaTODpWJnZF9xyfBmeM
   5NrnJJ5IgUE8+yPH/NQUx2ruJJ9BmbFmG/KvtN79NtCsthpYtHJoDZXeR
   IPrhNv/BfHHcY4Ir44Imdq8s2kJbi8KFjQmRjlKnl5NuTjSPWnQTS0FHZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="366693361"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="366693361"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:19:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707179430"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707179430"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2023 02:19:58 -0700
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
Subject: [PATCH v5 03/10] iommufd: Rename IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING
Date:   Fri, 20 Oct 2023 02:19:39 -0700
Message-Id: <20231020091946.12173-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020091946.12173-1-yi.l.liu@intel.com>
References: <20231020091946.12173-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

To add a new IOMMUFD_OBJ_HWPT_NESTED, rename the HWPT object to confine
it to PAGING hwpts/domains. The following patch will separate the hwpt
structure as well.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 10 +++++-----
 drivers/iommu/iommufd/hw_pagetable.c    |  2 +-
 drivers/iommu/iommufd/iommufd_private.h |  2 +-
 drivers/iommu/iommufd/main.c            |  2 +-
 drivers/iommu/iommufd/selftest.c        |  2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e88fa73a45e6..a5f9f20b2a9b 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -579,7 +579,7 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		return PTR_ERR(pt_obj);
 
 	switch (pt_obj->type) {
-	case IOMMUFD_OBJ_HW_PAGETABLE: {
+	case IOMMUFD_OBJ_HWPT_PAGING: {
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
@@ -617,8 +617,8 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 /**
  * iommufd_device_attach - Connect a device to an iommu_domain
  * @idev: device to attach
- * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
- *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
+ * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HWPT_PAGING
+ *         Output the IOMMUFD_OBJ_HWPT_PAGING ID
  *
  * This connects the device to an iommu_domain, either automatically or manually
  * selected. Once this completes the device could do DMA.
@@ -646,8 +646,8 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
 /**
  * iommufd_device_replace - Change the device's iommu_domain
  * @idev: device to change
- * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
- *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
+ * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HWPT_PAGING
+ *         Output the IOMMUFD_OBJ_HWPT_PAGING ID
  *
  * This is the same as::
  *
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 548079c8ca0a..e100caa502ed 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -86,7 +86,7 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if (flags && !ops->domain_alloc_user)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
+	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HWPT_PAGING);
 	if (IS_ERR(hwpt))
 		return hwpt;
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 3064997a0181..07ce35f09599 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -113,7 +113,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_NONE,
 	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
 	IOMMUFD_OBJ_DEVICE,
-	IOMMUFD_OBJ_HW_PAGETABLE,
+	IOMMUFD_OBJ_HWPT_PAGING,
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
 #ifdef CONFIG_IOMMUFD_TEST
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index e71523cbd0de..ad7c8c9ea46a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -482,7 +482,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_IOAS] = {
 		.destroy = iommufd_ioas_destroy,
 	},
-	[IOMMUFD_OBJ_HW_PAGETABLE] = {
+	[IOMMUFD_OBJ_HWPT_PAGING] = {
 		.destroy = iommufd_hw_pagetable_destroy,
 		.abort = iommufd_hw_pagetable_abort,
 	},
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 2bfe8dc9adc3..eca5b1d0919d 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -350,7 +350,7 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 	struct iommufd_object *obj;
 
 	obj = iommufd_get_object(ucmd->ictx, mockpt_id,
-				 IOMMUFD_OBJ_HW_PAGETABLE);
+				 IOMMUFD_OBJ_HWPT_PAGING);
 	if (IS_ERR(obj))
 		return ERR_CAST(obj);
 	hwpt = container_of(obj, struct iommufd_hw_pagetable, obj);
-- 
2.34.1

