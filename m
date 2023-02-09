Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B9E68FF34
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBIEeI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjBIEdn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:33:43 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B584A21C;
        Wed,  8 Feb 2023 20:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917153; x=1707453153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JKcVk5obW5Gyaa9H4l3A4rS0bALSWHthJ/4fsparY2c=;
  b=IDKnCyrVuQxQlsY2NDIe1R/i7G4ftmMaLYCKC8x2nkxB3i/mcdmZJJqW
   Gaw7BBreR6vIkDzzmHEAtuDAzjyhmkyuneafHuR4NJtoPP9lb//v8P4/Y
   l2dPlb7rs+rkRJAhVXMx9G6QajbpKaPeBwEI1x2n57EhEMeWW07dW0HQo
   W1nCx6Wliw/STYmtJTD0YLbbnymu86RJwqnn0nDaECzlYBQGp6VYut9H9
   WxQWhYd4AlxDdNUBB67ZgZrs0UKi1hhwo5Frx5+9yyR3V9G9b+3g70WSs
   bo5uOXFk5kCAOSVGjswtKMnxD4X8xb00o/ZjZg7ce3ffBkPapEySi51bJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298657"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298657"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447489"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447489"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:04 -0800
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
        baolu.lu@linux.intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 04/17] iommu/vt-d: Add helper to setup pasid nested translation
Date:   Wed,  8 Feb 2023 20:31:40 -0800
Message-Id: <20230209043153.14964-5-yi.l.liu@intel.com>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

The configurations are passed in from the user when the user domain is
allocated. This helper interprets these configurations according to the
data structure defined in uapi/linux/iommufd.h. The EINVAL error will be
returned if any of configurations are not compatible with the hardware
capabilities. The caller can retry with another compatible user domain.
The encoding of fields of each pasid entry is defined in section 9.6 of
the VT-d spec.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/pasid.c | 142 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.h |   2 +
 2 files changed, 144 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index fb3c7020028d..1ca19262f649 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -21,6 +21,11 @@
 #include "iommu.h"
 #include "pasid.h"
 
+#define IOMMU_VTD_PGTBL_MTS_MASK	(IOMMU_VTD_PGTBL_CD | \
+					 IOMMU_VTD_PGTBL_EMTE | \
+					 IOMMU_VTD_PGTBL_PCD | \
+					 IOMMU_VTD_PGTBL_PWT)
+
 /*
  * Intel IOMMU system wide PASID name space:
  */
@@ -394,6 +399,15 @@ pasid_set_flpm(struct pasid_entry *pe, u64 value)
 	pasid_set_bits(&pe->val[2], GENMASK_ULL(3, 2), value << 2);
 }
 
+/*
+ * Setup the Extended Access Flag Enable (EAFE) field (Bit 135)
+ * of a scalable mode PASID entry.
+ */
+static inline void pasid_set_eafe(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[2], 1 << 7, 1 << 7);
+}
+
 static void
 pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 				    u16 did, u32 pasid)
@@ -738,3 +752,131 @@ void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 	if (!cap_caching_mode(iommu->cap))
 		devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
+
+/**
+ * intel_pasid_setup_nested() - Set up PASID entry for nested translation.
+ * This could be used for guest shared virtual address. In this case, the
+ * first level page tables are used for GVA-GPA translation in the guest,
+ * second level page tables are used for GPA-HPA translation.
+ *
+ * @iommu:      IOMMU which the device belong to
+ * @dev:        Device to be set up for translation
+ * @pasid:      PASID to be programmed in the device PASID table
+ * @domain:     User domain nested on a s2 domain
+ */
+int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
+			     u32 pasid, struct dmar_domain *domain)
+{
+	struct iommu_hwpt_intel_vtd *s1_cfg = &domain->s1_cfg;
+	pgd_t *s1_gpgd = (pgd_t *)(uintptr_t)domain->s1_pgtbl;
+	struct dmar_domain *s2_domain = domain->s2_domain;
+	u16 did = domain_id_iommu(domain, iommu);
+	struct dma_pte *pgd = s2_domain->pgd;
+	struct pasid_entry *pte;
+	int agaw;
+
+	if (!ecap_nest(iommu->ecap)) {
+		pr_err_ratelimited("%s: No nested translation support\n",
+				   iommu->name);
+		return -ENODEV;
+	}
+
+	/*
+	 * Sanity checking performed by caller to make sure address width
+	 * matching in two dimensions: CPU vs. IOMMU, guest vs. host.
+	 */
+	switch (s1_cfg->addr_width) {
+	case ADDR_WIDTH_4LEVEL:
+		break;
+#ifdef CONFIG_X86
+	case ADDR_WIDTH_5LEVEL:
+		if (!cpu_feature_enabled(X86_FEATURE_LA57) ||
+		    !cap_fl5lp_support(iommu->cap)) {
+			dev_err_ratelimited(dev,
+					    "5-level paging not supported\n");
+			return -EINVAL;
+		}
+		break;
+#endif
+	default:
+		dev_err_ratelimited(dev, "Invalid guest address width %d\n",
+				    s1_cfg->addr_width);
+		return -EINVAL;
+	}
+
+	if ((s1_cfg->flags & IOMMU_VTD_PGTBL_SRE) && !ecap_srs(iommu->ecap)) {
+		pr_err_ratelimited("No supervisor request support on %s\n",
+				   iommu->name);
+		return -EINVAL;
+	}
+
+	if ((s1_cfg->flags & IOMMU_VTD_PGTBL_EAFE) && !ecap_eafs(iommu->ecap)) {
+		pr_err_ratelimited("No extended access flag support on %s\n",
+				   iommu->name);
+		return -EINVAL;
+	}
+
+	/*
+	 * Memory type is only applicable to devices inside processor coherent
+	 * domain. Will add MTS support once coherent devices are available.
+	 */
+	if (s1_cfg->flags & IOMMU_VTD_PGTBL_MTS_MASK) {
+		pr_warn_ratelimited("No memory type support %s\n",
+				    iommu->name);
+		return -EINVAL;
+	}
+
+	agaw = iommu_skip_agaw(s2_domain, iommu, &pgd);
+	if (agaw < 0) {
+		dev_err_ratelimited(dev, "Invalid domain page table\n");
+		return -EINVAL;
+	}
+
+	/* First level PGD (in GPA) must be supported by the second level. */
+	if ((uintptr_t)s1_gpgd > (1ULL << s2_domain->gaw)) {
+		dev_err_ratelimited(dev,
+				    "Guest PGD %lx not supported, max %llx\n",
+				    (uintptr_t)s1_gpgd, s2_domain->max_addr);
+		return -EINVAL;
+	}
+
+	spin_lock(&iommu->lock);
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (!pte) {
+		spin_unlock(&iommu->lock);
+		return -ENODEV;
+	}
+	if (pasid_pte_is_present(pte)) {
+		spin_unlock(&iommu->lock);
+		return -EBUSY;
+	}
+
+	pasid_clear_entry(pte);
+
+	if (s1_cfg->addr_width == ADDR_WIDTH_5LEVEL)
+		pasid_set_flpm(pte, 1);
+
+	pasid_set_flptr(pte, (uintptr_t)s1_gpgd);
+
+	if (s1_cfg->flags & IOMMU_VTD_PGTBL_SRE) {
+		pasid_set_sre(pte);
+		if (s1_cfg->flags & IOMMU_VTD_PGTBL_WPE)
+			pasid_set_wpe(pte);
+	}
+
+	if (s1_cfg->flags & IOMMU_VTD_PGTBL_EAFE)
+		pasid_set_eafe(pte);
+
+	pasid_set_slptr(pte, virt_to_phys(pgd));
+	pasid_set_fault_enable(pte);
+	pasid_set_domain_id(pte, did);
+	pasid_set_address_width(pte, agaw);
+	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
+	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
+	pasid_set_present(pte);
+	spin_unlock(&iommu->lock);
+
+	pasid_flush_caches(iommu, pte, pasid, did);
+
+	return 0;
+}
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 20c54e50f533..2a72bbc79532 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -118,6 +118,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
 				   struct device *dev, u32 pasid);
+int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
+			     u32 pasid, struct dmar_domain *domain);
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 struct device *dev, u32 pasid,
 				 bool fault_ignore);
-- 
2.34.1

