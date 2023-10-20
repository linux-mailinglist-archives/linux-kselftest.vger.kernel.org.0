Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C5D7D0BCE
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376769AbjJTJdL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376728AbjJTJdD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:33:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD2D63;
        Fri, 20 Oct 2023 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697794376; x=1729330376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KFY6DFqQdqzEYR8dbOOBhT/l5R4uXZhFdyT3GIHn4js=;
  b=b8yipmwxKtahFd/uMSiql8+IDUeohAWadYqTasLREw5pBUvfQBOl2hRE
   LrOwCi8KcfVkJq7J3/aZgX7UPt+Byfv3tYAFf5/QiPteOscIdRvs6r6Xs
   X7f5Guv2lOFQlThW6XuiEpGv3xwbnFdNAk4IrHCiafJxUC0Hm7UqcVrOp
   ICXLlJ+AOGjgsfOT/s+XyPjqXTStOdZl8s+3UHjgOuZZysHsLH5Zugm/F
   TvzUietGs/ufI+sb6mceGZb+XRb98KW9uR3ayooj96qznhDuMca35/4SJ
   1lGgjzgl0P7kZXRtcFunH7K1j9l+RJ/xLef3LtfgVuNLeLlOfOEtijMo7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450691761"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450691761"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="733906314"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="733906314"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2023 02:32:56 -0700
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
Subject: [PATCH v6 8/8] iommu/vt-d: Disallow read-only mappings to nest parent domain
Date:   Fri, 20 Oct 2023 02:32:46 -0700
Message-Id: <20231020093246.17015-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020093246.17015-1-yi.l.liu@intel.com>
References: <20231020093246.17015-1-yi.l.liu@intel.com>
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
---
 drivers/iommu/intel/iommu.c  |  9 +++++++++
 drivers/iommu/intel/iommu.h  |  1 +
 include/uapi/linux/iommufd.h | 12 +++++++++++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c7704e7efd4a..a0341a069fbf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2193,6 +2193,11 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	if ((prot & (DMA_PTE_READ|DMA_PTE_WRITE)) == 0)
 		return -EINVAL;
 
+	if (!(prot & DMA_PTE_WRITE) && domain->is_nested_parent) {
+		pr_err_ratelimited("Read-only mapping is disallowed on the domain which serves as the parent in a nested configuration, due to HW errata (ERRATA_772415_SPR17)\n");
+		return -EINVAL;
+	}
+
 	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
 	attr |= DMA_FL_PTE_PRESENT;
 	if (domain->use_first_level) {
@@ -4101,6 +4106,9 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 		domain = iommu_domain_alloc(dev->bus);
 		if (!domain)
 			return ERR_PTR(-ENOMEM);
+		container_of(domain,
+			     struct dmar_domain,
+			     domain)->is_nested_parent = request_nest_parent;
 		return domain;
 	}
 
@@ -4839,6 +4847,7 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
 	if (!vtd)
 		return ERR_PTR(-ENOMEM);
 
+	vtd->flags = IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;
 	vtd->cap_reg = iommu->cap;
 	vtd->ecap_reg = iommu->ecap;
 	*length = sizeof(*vtd);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b4560983b8b9..0539a0f47557 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -593,6 +593,7 @@ struct dmar_domain {
 					 * otherwise, goes through the second
 					 * level.
 					 */
+	u8 is_nested_parent:1;		/* has other domains nested on it */
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 9b843a197ea8..c8f523a7bc06 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -439,10 +439,20 @@ struct iommu_hwpt_alloc {
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
 
+/**
+ * enum iommu_hw_info_vtd_flags - Flags for VT-d hw_info
+ * @IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17: If set, disallow nesting on domains
+ *                                   with read-only mapping.
+ *                                   https://www.intel.com/content/www/us/en/content-details/772415/content-details.html
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

