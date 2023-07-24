Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E06275F4BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjGXLOs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjGXLOb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:14:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AF2198E;
        Mon, 24 Jul 2023 04:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690197234; x=1721733234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YTaq/gvDINGEMieq70WcQfgAkgR6JHSIqAWu7f0pkko=;
  b=UG2QDGGNlaLiGtzqKjRgdklm0nH1kbN1SnFYIu3xpnLYjarsFrdTxOSW
   8myf4j5InHGaNODFpkTMuYMvbk//Jf+GR3X7378H22arbjkFlRzxDt7jc
   qqtG7JnuE7LPUm4Lyeq0+VgazzL+vmI5fatXMtdAN9yRk6+5rcmThO0Jl
   kiFpqWuvCxLHWJa/lCAVCShO76DZbcLBONhN46exLlzrYuYRCVs6fsLT+
   BoQ5SAggLGym9gOv9m+Gk9lKvkLn7WojXrGr604+cZ+L7DpgihyDLcUJh
   vEbYHlMcFWBC0BkRLM5ExUSA6EmA9pIskcrWzcWxeKGtADlnSlZnxmC6k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347015080"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347015080"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:13:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839415617"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839415617"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 04:13:51 -0700
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
Subject: [PATCH v4 12/12] iommu/vt-d: Disallow nesting on domains with read-only mappings
Date:   Mon, 24 Jul 2023 04:13:34 -0700
Message-Id: <20230724111335.107427-13-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724111335.107427-1-yi.l.liu@intel.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
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

For simplicity the 2nd restriction is not relaxed even when the nesting
is turned off later due to vIOMMU config change. In concept if the user
understands this errata and does expect to enable nested translation
it should never install any RO mapping in stage-2 in the entire VM life
cycle. Accordingly introduce a single sticky bit to mark the parent role
on a domain instead of tracking the role with a counter.

Reference from Sapphire Rapids Specification Update [1], errata details,
SPR17.

[1] https://www.intel.com/content/www/us/en/content-details/772415/content-details.html

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c  | 14 ++++++++++++++
 drivers/iommu/intel/iommu.h  |  4 ++++
 drivers/iommu/intel/nested.c | 14 +++++++++++++-
 include/uapi/linux/iommufd.h | 12 +++++++++++-
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ba34827045e6..caaa3a58dc94 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2138,6 +2138,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	struct dma_pte *first_pte = NULL, *pte = NULL;
 	unsigned int largepage_lvl = 0;
 	unsigned long lvl_pages = 0;
+	unsigned long flags;
 	phys_addr_t pteval;
 	u64 attr;
 
@@ -2147,6 +2148,18 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	if ((prot & (DMA_PTE_READ|DMA_PTE_WRITE)) == 0)
 		return -EINVAL;
 
+	if (!(prot & DMA_PTE_WRITE) && !domain->read_only_mapped) {
+		spin_lock_irqsave(&domain->lock, flags);
+		if (domain->set_nested) {
+			pr_err_ratelimited("No read-only mapping permitted\n");
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
@@ -4758,6 +4771,7 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length)
 	if (!vtd)
 		return ERR_PTR(-ENOMEM);
 
+	vtd->flags = IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;
 	vtd->cap_reg = iommu->cap;
 	vtd->ecap_reg = iommu->ecap;
 	*length = sizeof(*vtd);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 5b292213bcb8..2a14fab6ac4f 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -592,6 +592,10 @@ struct dmar_domain {
 					 * otherwise, goes through the second
 					 * level.
 					 */
+	u8 read_only_mapped:1;		/* domain has mappings with read-only
+					 * permission.
+					 */
+	u8 set_nested:1;		/* has other domains nested on it */
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 2739c0d7880d..50934da613fa 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -142,14 +142,26 @@ struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *s2_domain,
 					       const union iommu_domain_user_data *user_data)
 {
 	const struct iommu_hwpt_vtd_s1 *vtd = (struct iommu_hwpt_vtd_s1 *)user_data;
+	struct dmar_domain *s2_dmar_domain = to_dmar_domain(s2_domain);
 	struct dmar_domain *domain;
+	unsigned long flags;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL_ACCOUNT);
 	if (!domain)
 		return NULL;
 
+	spin_lock_irqsave(&s2_dmar_domain->lock, flags);
+	if (s2_dmar_domain->read_only_mapped) {
+		spin_unlock_irqrestore(&s2_dmar_domain->lock, flags);
+		pr_err_ratelimited("S2 domain has read-only mappings\n");
+		kfree(domain);
+		return NULL;
+	}
+	s2_dmar_domain->set_nested = true;
+	spin_unlock_irqrestore(&s2_dmar_domain->lock, flags);
+
 	domain->use_first_level = true;
-	domain->s2_domain = to_dmar_domain(s2_domain);
+	domain->s2_domain = s2_dmar_domain;
 	domain->s1_pgtbl = vtd->pgtbl_addr;
 	domain->s1_cfg = *vtd;
 	domain->domain.ops = &intel_nested_domain_ops;
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 0dfb6f3d8dda..2f8f2dab95a7 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -435,10 +435,20 @@ struct iommu_hwpt_alloc {
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

