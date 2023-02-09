Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3348768FF42
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjBIEfA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjBIEdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:33:52 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E8147438;
        Wed,  8 Feb 2023 20:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917169; x=1707453169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ja+t+nxs1FvQ3VSNmIfqBCGaB8PSH4Fy0AP9hils4l4=;
  b=NHzfZHWVM9kKCABvKlMZx/1IvJMsit2/8FoAUzH0lwRIZuEAz5zc0sOk
   9VC2a72ZbIISOKCy/umcg2tlOY8ycNB8lUWLj9GAi/2VTuq9GNb2XuNBi
   4TWWlhKYx4VQdIQhNr2r0gOqR0YVu8BHAgv+h52JbX1L/VFFSNGk9O8Hv
   uB+/QGfjQ750u44cDsonfN5N8+uKZ6eIuxT8BbplU615hWfPN5hm8aBfb
   FUnas1ROCFukRtyy01S0LSAFl/eP1jg7zgm/l0ZafUBJPJ6/VNFZoZSiM
   Pbg9T/jW27OOqapVgAPSznlLiI049bL/Rw/1iMyM/p106IWpT2InkrCMe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298748"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298748"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447547"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447547"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:12 -0800
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: [PATCH 08/17] iommufd: Split iommufd_hw_pagetable_alloc()
Date:   Wed,  8 Feb 2023 20:31:44 -0800
Message-Id: <20230209043153.14964-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
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

to a helper which accepts the parent hw_pagetable pointer and user_data
pointer. This is a prepareation for supporting userspace hw_pagetable
allocation as caller needs to pass the two parameters to domain_alloc_user
op.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 41 ++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index bda21ec737cf..ee97d2f3cf43 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -22,24 +22,23 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	mutex_destroy(&hwpt->devices_lock);
 }
 
-/**
- * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
- * @ictx: iommufd context
- * @ioas: IOAS to associate the domain with
- * @dev: Device to get an iommu_domain for
- *
- * Allocate a new iommu_domain and return it as a hw_pagetable.
- */
-struct iommufd_hw_pagetable *
-iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct device *dev)
+static struct iommufd_hw_pagetable *
+__iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx,
+			     struct iommufd_ioas *ioas,
+			     struct device *dev,
+			     struct iommufd_hw_pagetable *parent,
+			     void *user_data)
 {
 	const struct iommu_ops *ops;
+	struct iommu_domain *parent_domain = NULL;
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
 	lockdep_assert_held(&ioas->mutex);
 
+	if (WARN_ON(!ioas && !parent))
+		return ERR_PTR(-EINVAL);
+
 	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
 	if (IS_ERR(hwpt))
 		return hwpt;
@@ -50,7 +49,10 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_abort;
 	}
 
-	hwpt->domain = ops->domain_alloc_user(dev, NULL, NULL);
+	if (parent)
+		parent_domain = parent->domain;
+
+	hwpt->domain = ops->domain_alloc_user(dev, parent_domain, user_data);
 	if (!hwpt->domain) {
 		rc = -ENOMEM;
 		goto out_abort;
@@ -75,3 +77,18 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	iommufd_object_abort(ictx, &hwpt->obj);
 	return ERR_PTR(rc);
 }
+
+/**
+ * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
+ * @ictx: iommufd context
+ * @ioas: IOAS to associate the domain with
+ * @dev: Device to get an iommu_domain for
+ *
+ * Allocate a new iommu_domain and return it as a hw_pagetable.
+ */
+struct iommufd_hw_pagetable *
+iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
+			   struct device *dev)
+{
+	return __iommufd_hw_pagetable_alloc(ictx, ioas, dev, NULL, NULL);
+}
-- 
2.34.1

