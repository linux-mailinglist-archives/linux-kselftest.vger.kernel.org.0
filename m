Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782607D54C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 17:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjJXPJz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 11:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjJXPJy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 11:09:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F55210D9;
        Tue, 24 Oct 2023 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698160192; x=1729696192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s4Xa96bsVS3Jd+jb1M+8348qLErwHoDq5hhv2oz1Wro=;
  b=S1dHSgoeQSrMRa+ZP8UIF7yZk38P2Mit9C4FUzqiPI9RUX92UxbWPTG0
   UH9+bR+6gssCBsgAH49klt3BzYLwfv/UUqGH0ILlu3+XJuXO6AcJognZg
   pRjfoZLf/oThNlU3idvjRjb4v8Vg5pPb7RZYqhSTLxf0dCO1TTpbIflpX
   olI/mHR+D4d6zH0WLOBRJOmvj9VfsswMCc2KO3Qj86COX4BaF0I2teFCX
   hw4U/I+gxvn8n/84uUhsKPhDlOL/VBKqkgyEuxQNNiqwRqQDsa/DckJtv
   JHSq4GZ6ay1cgKjisB395osQ6gJK596A4DtYcV23YYctggLSTuh/KVV8D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418202967"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="418202967"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:06:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="6486170"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2023 08:06:17 -0700
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
Subject: [PATCH v6 03/10] iommufd: Rename IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING
Date:   Tue, 24 Oct 2023 08:06:02 -0700
Message-Id: <20231024150609.46884-4-yi.l.liu@intel.com>
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
 drivers/iommu/iommufd/iommufd_private.h |  4 ++--
 drivers/iommu/iommufd/main.c            |  2 +-
 drivers/iommu/iommufd/selftest.c        |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 0a8867487508..449b64e6ef53 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -563,7 +563,7 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
 		return PTR_ERR(pt_obj);
 
 	switch (pt_obj->type) {
-	case IOMMUFD_OBJ_HW_PAGETABLE: {
+	case IOMMUFD_OBJ_HWPT_PAGING: {
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
@@ -601,8 +601,8 @@ static int iommufd_device_change_pt(struct iommufd_device *idev, u32 *pt_id,
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
@@ -630,8 +630,8 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
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
index 97b84d681e09..1c13c3b6368c 100644
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
index 43410fd53157..70bebad63a74 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -123,7 +123,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_NONE,
 	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
 	IOMMUFD_OBJ_DEVICE,
-	IOMMUFD_OBJ_HW_PAGETABLE,
+	IOMMUFD_OBJ_HWPT_PAGING,
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
 #ifdef CONFIG_IOMMUFD_TEST
@@ -256,7 +256,7 @@ static inline struct iommufd_hw_pagetable *
 iommufd_get_hwpt(struct iommufd_ucmd *ucmd, u32 id)
 {
 	return container_of(iommufd_get_object(ucmd->ictx, id,
-					       IOMMUFD_OBJ_HW_PAGETABLE),
+					       IOMMUFD_OBJ_HWPT_PAGING),
 			    struct iommufd_hw_pagetable, obj);
 }
 int iommufd_hwpt_set_dirty_tracking(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index d50f42a730aa..46198e8948d6 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -488,7 +488,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_IOAS] = {
 		.destroy = iommufd_ioas_destroy,
 	},
-	[IOMMUFD_OBJ_HW_PAGETABLE] = {
+	[IOMMUFD_OBJ_HWPT_PAGING] = {
 		.destroy = iommufd_hw_pagetable_destroy,
 		.abort = iommufd_hw_pagetable_abort,
 	},
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index a01a38332dc1..d71007234896 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -442,7 +442,7 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 	struct iommufd_object *obj;
 
 	obj = iommufd_get_object(ucmd->ictx, mockpt_id,
-				 IOMMUFD_OBJ_HW_PAGETABLE);
+				 IOMMUFD_OBJ_HWPT_PAGING);
 	if (IS_ERR(obj))
 		return ERR_CAST(obj);
 	hwpt = container_of(obj, struct iommufd_hw_pagetable, obj);
-- 
2.34.1

