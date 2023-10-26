Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F207D7B94
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 06:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjJZEju (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 00:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjJZEjs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 00:39:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428EB187;
        Wed, 25 Oct 2023 21:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698295186; x=1729831186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ch3f1N0bCPpJiw/OvADgtjMDzXOjbqYOAsULFPOj6jI=;
  b=XZPYryNIjnRgXzyp2ZoEP+IH5lk2Xiec6xxRHkoZ5r7vWLF9ZnxelLq3
   L3992L1M1AWiODkiJoFXauGGnY26oa/1rdfQaHdgnpYLHKhD7wEgEHNP3
   0ztBxntPs24ddNggO06lfNdlkHOZMeBs2HhcgUKabuoJzFUMLibdEsDWz
   frzqUToom4ETQ8ndunS4/PlKXAjvRxaYs4gJTxwEB63n/79VMjPoNuJko
   HNmXa4B1OJmd9haoOubNbiOeyE8d9MAHScr7ULNgmpai3eKtk6PEF03qF
   1/dcS6LLR/Y5/12EwuFS773S1NQ3YJkdtBRFp0+Yk4WtVwKyQbYT69X5R
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9014444"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="9014444"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:39:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="708931283"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="708931283"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2023 21:39:42 -0700
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
Subject: [PATCH v7 02/10] iommufd: Rename IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING
Date:   Wed, 25 Oct 2023 21:39:30 -0700
Message-Id: <20231026043938.63898-3-yi.l.liu@intel.com>
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

To add a new IOMMUFD_OBJ_HWPT_NESTED, rename the HWPT object to confine
it to PAGING hwpts/domains. The following patch will separate the hwpt
structure as well.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
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
index c2b742ffeb0c..8dc2b39f8cb0 100644
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
index d8551c9d5b6c..068928ba7950 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -437,7 +437,7 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 	struct iommufd_object *obj;
 
 	obj = iommufd_get_object(ucmd->ictx, mockpt_id,
-				 IOMMUFD_OBJ_HW_PAGETABLE);
+				 IOMMUFD_OBJ_HWPT_PAGING);
 	if (IS_ERR(obj))
 		return ERR_CAST(obj);
 	hwpt = container_of(obj, struct iommufd_hw_pagetable, obj);
-- 
2.34.1

