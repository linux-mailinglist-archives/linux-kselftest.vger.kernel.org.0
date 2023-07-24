Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534BF75F461
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjGXLFi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjGXLFZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:05:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E67E5A;
        Mon, 24 Jul 2023 04:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196703; x=1721732703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mg550ofGRCkx0TRyX/k25V5Hgrta9fIM/SqDWuOS38s=;
  b=gj6NQiKc51nKpC8PxC4Ustoo0aWgDUQU1+U+DIC1Cj0waGACJCGaK4wd
   ISXGQCQPPOXZNx1iIJakdE+kiJUna9rmd6wkEsmE6gg+yHe+sxdglyK7z
   p6L/Yjb2t0GLPr+L8W1Ez9SZ0Qx9dTTJzrNEE8QXg7hM6/iGdaSBQK+Kj
   QSy9Xpy7tjbjrSeJM7rlZN6sGxtTQmz5d+Vjr9I4wf6e+75/9X1codcl6
   76qcibaB+Lx2Qf7FZpiGmH7wsPNSRpvhFrpTe5cencMdF/iiQOfhZCpGh
   JI/jPoZq9cJKD2Xpj1tRUZxXyPp8erCtpDlKl7MmMz9wdEk2eTIuCdVfI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347013287"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347013287"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775802"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775802"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:16 -0700
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
Subject: [PATCH v3 06/17] iommufd: Only enforce IOMMU_RESV_SW_MSI when attaching user-managed HWPT
Date:   Mon, 24 Jul 2023 04:03:55 -0700
Message-Id: <20230724110406.107212-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724110406.107212-1-yi.l.liu@intel.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

Reserved IOVA regions except for the IOMMU_RESV_DIRECT_RELAXABLE type
should be excluded from the device's DMA address space. For single stage
translation configuration, such reserved regions are excluded in the
attaching HWPT that is managed by kernel. While for nested translation
configuration, there are two stage HWPTs, the reserved regions should be
excluded in stage-1 HWPT which is managed by userspace. The current code
always excludes the reserved regions in the stage-2 HWPT which is kernel
managed. This is incorrect. Instead, the reserved regions should be
reported to userspace and excluded in stage-1 HWPT.

Besides above, the IOMMU_RESV_SW_MSI type region needs to be excluded in
the stage-2 HWPT even in the nested translation configuration on ARM. So
the IOMMU_RESV_SW_MSI type region should always be excluded in the kernel
managed HWPT.

This adds a boolean argument to enforce IOMMU_RESV_SW_MSI only, if attaching
HWPT is a user-managed one, i.e. hwpt->parent must be valid, resulting
"!!hwpt->parent" to be true, hence only add the IOMMU_RESV_SW_MSI region to
the stage-2 HWPT reserved iovas.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 6 ++++--
 drivers/iommu/iommufd/io_pagetable.c    | 5 ++++-
 drivers/iommu/iommufd/iommufd_private.h | 3 ++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 97e4e5f5aca0..c0917683097f 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -347,7 +347,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	}
 
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
-						 &idev->igroup->sw_msi_start);
+						 &idev->igroup->sw_msi_start,
+						 !!hwpt->parent);
 	if (rc)
 		goto err_unlock;
 
@@ -445,7 +446,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 	if (hwpt->ioas != old_hwpt->ioas) {
 		list_for_each_entry(cur, &igroup->device_list, group_item) {
 			rc = iopt_table_enforce_dev_resv_regions(
-				&hwpt->ioas->iopt, cur->dev, NULL);
+				&hwpt->ioas->iopt, cur->dev, NULL,
+				!!hwpt->parent);
 			if (rc)
 				goto err_unresv;
 		}
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 4d095115c2d0..e658261f44ed 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1172,7 +1172,8 @@ void iopt_remove_access(struct io_pagetable *iopt,
 /* Narrow the valid_iova_itree to include reserved ranges from a device. */
 int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 					struct device *dev,
-					phys_addr_t *sw_msi_start)
+					phys_addr_t *sw_msi_start,
+					bool sw_msi_only)
 {
 	struct iommu_resv_region *resv;
 	LIST_HEAD(resv_regions);
@@ -1198,6 +1199,8 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 			num_sw_msi++;
 		}
 
+		if (sw_msi_only && resv->type != IOMMU_RESV_SW_MSI)
+			continue;
 		rc = iopt_reserve_iova(iopt, resv->start,
 				       resv->length - 1 + resv->start, dev);
 		if (rc)
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 90dcf4041530..268ae0d5ae12 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -79,7 +79,8 @@ void iopt_table_remove_domain(struct io_pagetable *iopt,
 			      struct iommu_domain *domain);
 int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 					struct device *dev,
-					phys_addr_t *sw_msi_start);
+					phys_addr_t *sw_msi_start,
+					bool sw_msi_only);
 int iopt_set_allow_iova(struct io_pagetable *iopt,
 			struct rb_root_cached *allowed_iova);
 int iopt_reserve_iova(struct io_pagetable *iopt, unsigned long start,
-- 
2.34.1

