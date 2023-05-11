Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CFE6FF513
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 16:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbjEKOxU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 10:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbjEKOwl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 10:52:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6366711B63;
        Thu, 11 May 2023 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683816726; x=1715352726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zSBFf3R+KE7eDYqzxRY/XTRifADKsFtYgSSwmUYfOpg=;
  b=fL7fQk+h0kNFY08et8nEr3Yv6MlXhrooek+fuqhGEUw/TwftHFfRAOgK
   Lr211iGYErx6ESLe2ZdyCJXefytyAn2VRshalmNTM0VQ842Jl92p9fLJd
   erb2dk7kuH/FVZkb50X6TCCj4T5AB77XDRmtjkQvkYs49pzSGBL9PKAyb
   nOpgF9pVmejmqg7H1PhElbD0loL9dJfVkgiU3E8KvCTgp9LuLYEmD589i
   +Oru0O55Bji1+zcMXqnqQ1+zWgPNTVPETC4NUvTjOS35Ku+2+vUofmaEu
   nLVCLCAJY0myKmFVk5wHwkKLjVds2lymAYm9QkBLyNKskBVNO2ZUDw+Aq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335025529"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="335025529"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:51:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="769355198"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="769355198"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2023 07:51:21 -0700
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
Subject: [PATCH v3 10/10] iommu/vt-d: Disallow nesting on domains with read-only mappings
Date:   Thu, 11 May 2023 07:51:10 -0700
Message-Id: <20230511145110.27707-11-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511145110.27707-1-yi.l.liu@intel.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Disallow the nested translation when there are read-only pages in the
corresponding second-stage mappings. And, no read-only pages are allowed
to be configured in the second-stage table of a nested translation.
For the latter, an alternative is to disallow read-only mappings in
any stage-2 domain as long as it's ever been used as a parent. In this
way, we can simply replace the user counter with a flag.

In concept if the user understands this errata and does expect to
enable nested translation it should never install any RO mapping
in stage-2 in the entire VM life cycle."

Reference from Sapphire Rapids Specification Update [1], errata details,
SPR17.

[1] https://www.intel.com/content/www/us/en/content-details/772415/content-details.html

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c  | 13 +++++++++++++
 drivers/iommu/intel/iommu.h  |  4 ++++
 drivers/iommu/intel/nested.c | 22 ++++++++++++++++++++--
 include/uapi/linux/iommufd.h | 12 +++++++++++-
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 20d4ae1cb8a6..42288bd449a0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2150,6 +2150,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	struct dma_pte *first_pte = NULL, *pte = NULL;
 	unsigned int largepage_lvl = 0;
 	unsigned long lvl_pages = 0;
+	unsigned long flags;
 	phys_addr_t pteval;
 	u64 attr;
 
@@ -2159,6 +2160,17 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	if ((prot & (DMA_PTE_READ|DMA_PTE_WRITE)) == 0)
 		return -EINVAL;
 
+	if (!(prot & DMA_PTE_WRITE) && !domain->read_only_mapped) {
+		spin_lock_irqsave(&domain->lock, flags);
+		if (domain->nested_users > 0) {
+			spin_unlock_irqrestore(&domain->lock, flags);
+			return -EINVAL;
+		}
+
+		domain->read_only_mapped = true;
+		spin_unlock_irqrestore(&domain->lock, flags);
+	}
+
 	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
 	attr |= DMA_FL_PTE_PRESENT;
 	if (domain->use_first_level) {
@@ -4756,6 +4768,7 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length)
 	if (!vtd)
 		return ERR_PTR(-ENOMEM);
 
+	vtd->flags = IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;
 	vtd->cap_reg = iommu->cap;
 	vtd->ecap_reg = iommu->ecap;
 	*length = sizeof(*vtd);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 581596d90c1b..95644c6815af 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -616,6 +616,10 @@ struct dmar_domain {
 			int		agaw;
 			/* maximum mapped address */
 			u64		max_addr;
+			/* domain has mappings with read-only permission */
+			bool		read_only_mapped;
+			/* user nested domain count */
+			int		nested_users;
 		};
 
 		/* Nested user domain */
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index d13fbcd3f5a6..9092ce28382c 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -61,7 +61,14 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 
 static void intel_nested_domain_free(struct iommu_domain *domain)
 {
-	kfree(to_dmar_domain(domain));
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct dmar_domain *s2_domain = dmar_domain->s2_domain;
+	unsigned long flags;
+
+	spin_lock_irqsave(&s2_domain->lock, flags);
+	s2_domain->nested_users--;
+	spin_unlock_irqrestore(&s2_domain->lock, flags);
+	kfree(dmar_domain);
 }
 
 static void intel_nested_invalidate(struct device *dev,
@@ -143,14 +150,25 @@ struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *s2_domain,
 					       const union iommu_domain_user_data *user_data)
 {
 	const struct iommu_hwpt_intel_vtd *vtd = (struct iommu_hwpt_intel_vtd *)user_data;
+	struct dmar_domain *s2_dmar_domain = to_dmar_domain(s2_domain);
 	struct dmar_domain *domain;
+	unsigned long flags;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL_ACCOUNT);
 	if (!domain)
 		return NULL;
 
+	spin_lock_irqsave(&s2_dmar_domain->lock, flags);
+	if (s2_dmar_domain->read_only_mapped) {
+		spin_unlock_irqrestore(&s2_dmar_domain->lock, flags);
+		kfree(domain);
+		return NULL;
+	}
+	s2_dmar_domain->nested_users++;
+	spin_unlock_irqrestore(&s2_dmar_domain->lock, flags);
+
 	domain->use_first_level = true;
-	domain->s2_domain = to_dmar_domain(s2_domain);
+	domain->s2_domain = s2_dmar_domain;
 	domain->s1_pgtbl = vtd->pgtbl_addr;
 	domain->s1_cfg = *vtd;
 	domain->domain.ops = &intel_nested_domain_ops;
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index b46270a4cf46..8626f36e0353 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -471,10 +471,20 @@ enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_INTEL_VTD,
 };
 
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

