Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1407D7BC0
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 06:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbjJZEnW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 00:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbjJZEm7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 00:42:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0451AE;
        Wed, 25 Oct 2023 21:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698295377; x=1729831377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KDC9jbEWS+pUOjSnJASBzBnQmqmwgvSEBwA1Yc2XCvQ=;
  b=F5NVRdyDSePTP+CoSkWw9GYcamC4QahcnclkuS4KD9vVAVFcLrUVsrdo
   i4u78rL9W8k6C2M9shaPi2hIOIuRGqgQLNH3CIAAg2QTi+th9WG6MGt8w
   u8G5fibLfL4zvQaSgMzbXy/l7uXL39NNtpwvYkaglK4th1gempnASX2DJ
   vkqNPhRf8BUilU/1IqYfUP3k5xlab63JlCRpqv7L/nQipk17NzuLFtsw1
   s9UUtEmhukYnxpAx37pQI8cxoSZ8II9jx7xIxqVYeaOe8dMa35dDH6uWd
   GpaezkrLmwZa2QVvT9ZXxtPz2ptdivKVNuHhfdt1oKvbqeQRkrkP6jsc/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="367670804"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="367670804"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:42:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="829478598"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="829478598"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2023 21:42:28 -0700
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
Subject: [PATCH v8 8/8] iommu/vt-d: Disallow read-only mappings to nest parent domain
Date:   Wed, 25 Oct 2023 21:42:16 -0700
Message-Id: <20231026044216.64964-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026044216.64964-1-yi.l.liu@intel.com>
References: <20231026044216.64964-1-yi.l.liu@intel.com>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

When remapping hardware is configured by system software in scalable mode
as Nested (PGTT=011b) and with PWSNP field Set in the PASID-table-entry,
it may Set Accessed bit and Dirty bit (and Extended Access bit if enabled)
in first-stage page-table entries even when second-stage mappings indicate
that corresponding first-stage page-table is Read-Only.

As the result, contents of pages designated by VMM as Read-Only can be
modified by IOMMU via PML5E (PML4E for 4-level tables) access as part of
address translation process due to DMAs issued by Guest.

This disallows read-only mappings in the domain that is supposed to be used
as nested parent. Reference from Sapphire Rapids Specification Update [1],
errata details, SPR17. Userspace should know this limitation by checking
the IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17 flag reported in the IOMMU_GET_HW_INFO
ioctl.

[1] https://www.intel.com/content/www/us/en/content-details/772415/content-details.html

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/iommu.c  |  6 ++++++
 include/uapi/linux/iommufd.h | 12 +++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4ce372d5d4f3..a2c429855cc0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2194,6 +2194,11 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	if ((prot & (DMA_PTE_READ|DMA_PTE_WRITE)) == 0)
 		return -EINVAL;
 
+	if (!(prot & DMA_PTE_WRITE) && domain->nested_parent) {
+		pr_err_ratelimited("Read-only mapping is disallowed on the domain which serves as the parent in a nested configuration, due to HW errata (ERRATA_772415_SPR17)\n");
+		return -EINVAL;
+	}
+
 	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
 	attr |= DMA_FL_PTE_PRESENT;
 	if (domain->use_first_level) {
@@ -4850,6 +4855,7 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
 	if (!vtd)
 		return ERR_PTR(-ENOMEM);
 
+	vtd->flags = IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;
 	vtd->cap_reg = iommu->cap;
 	vtd->ecap_reg = iommu->ecap;
 	*length = sizeof(*vtd);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 3ce5ee5f09b6..0b2bc6252e2c 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -443,10 +443,20 @@ struct iommu_hwpt_alloc {
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
 
+/**
+ * enum iommu_hw_info_vtd_flags - Flags for VT-d hw_info
+ * @IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17: If set, disallow read-only mappings
+ *                                         on a nested_parent domain.
+ *                                         https://www.intel.com/content/www/us/en/content-details/772415/content-details.html
+ */
+enum iommu_hw_info_vtd_flags {
+	IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17 = 1 << 0,
+};
+
 /**
  * struct iommu_hw_info_vtd - Intel VT-d hardware information
  *
- * @flags: Must be 0
+ * @flags: Combination of enum iommu_hw_info_vtd_flags
  * @__reserved: Must be 0
  *
  * @cap_reg: Value of Intel VT-d capability register defined in VT-d spec
-- 
2.34.1

