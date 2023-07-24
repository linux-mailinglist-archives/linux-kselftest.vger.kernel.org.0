Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44C475F4A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjGXLNs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjGXLNo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:13:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85797FF;
        Mon, 24 Jul 2023 04:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690197223; x=1721733223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FXBTIP+OQ9wTdu1UGJnmn0T3WIgxJoNq+7m5gogWvLw=;
  b=E1fNUxLFYMBtQxnsZPhPkUwigOE3IxuApvsjcCX8ydXv7e9GrIL4HDFs
   N7LMKlIEfNEiyPAD0jvTZr034Dkq1pXIUFq95tQ0QCoTRQ33zJpnja0t8
   1QtyHh5DE1LiNkfy07eSZa1CH/LrSmIjEOrw86pVR3R7PH9xpi6eyB6nJ
   +zUqFWg+GOtwxPF2tJlmvZ/JYQ9Zhkak8O3ymH3hBhoiPsiw6AdEluCOR
   3mgsnQ03W3HhXeWOpd3JJotMdHRo23EdPscQoJa9/zhFmW+r+17FLVml5
   hin1Uy5hwqRx+um595SeIHi20BrMS+ynNB+AmUUJzNluMG2NiO0id8P++
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347014962"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347014962"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:13:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839415509"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839415509"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 04:13:41 -0700
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
        zhenzhong.duan@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 04/12] iommu/vt-d: Add helper to setup pasid nested translation
Date:   Mon, 24 Jul 2023 04:13:26 -0700
Message-Id: <20230724111335.107427-5-yi.l.liu@intel.com>
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
 drivers/iommu/intel/pasid.c | 127 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.h |   2 +
 2 files changed, 129 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c5d479770e12..af9cfd2d5c52 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -335,6 +335,15 @@ static inline void pasid_set_fault_enable(struct pasid_entry *pe)
 	pasid_set_bits(&pe->val[0], 1 << 1, 0);
 }
 
+/*
+ * Setup the SRE(Supervisor Request Enable) field (Bit 128) of a
+ * scalable mode PASID entry.
+ */
+static inline void pasid_set_sre(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[2], 1 << 0, 1);
+}
+
 /*
  * Setup the WPE(Write Protect Enable) field (Bit 132) of a
  * scalable mode PASID entry.
@@ -402,6 +411,15 @@ pasid_set_flpm(struct pasid_entry *pe, u64 value)
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
@@ -713,3 +731,112 @@ void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 	if (!cap_caching_mode(iommu->cap))
 		devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
+
+/**
+ * intel_pasid_setup_nested() - Set up PASID entry for nested translation.
+ * This could be used for nested translation based vIOMMU. e.g. guest IOVA
+ * and guest shared virtual address. In this case, the first level page
+ * tables are used for GVA/GIOVA-GPA translation in the guest, second level
+ * page tables are used for GPA-HPA translation.
+ *
+ * @iommu:      IOMMU which the device belong to
+ * @dev:        Device to be set up for translation
+ * @pasid:      PASID to be programmed in the device PASID table
+ * @domain:     User stage-1 domain nested on a s2 domain
+ */
+int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
+			     u32 pasid, struct dmar_domain *domain)
+{
+	struct iommu_hwpt_vtd_s1 *s1_cfg = &domain->s1_cfg;
+	pgd_t *s1_gpgd = (pgd_t *)(uintptr_t)domain->s1_pgtbl;
+	struct dmar_domain *s2_domain = domain->s2_domain;
+	u16 did = domain_id_iommu(domain, iommu);
+	struct dma_pte *pgd = s2_domain->pgd;
+	struct pasid_entry *pte;
+
+	if (!ecap_nest(iommu->ecap)) {
+		pr_err_ratelimited("%s: No nested translation support\n",
+				   iommu->name);
+		return -ENODEV;
+	}
+
+	/*
+	 * Address width should match in two dimensions: CPU vs. IOMMU,
+	 * guest vs. host.
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
+	if ((s1_cfg->flags & IOMMU_VTD_S1_SRE) && !ecap_srs(iommu->ecap)) {
+		pr_err_ratelimited("No supervisor request support on %s\n",
+				   iommu->name);
+		return -EINVAL;
+	}
+
+	if ((s1_cfg->flags & IOMMU_VTD_S1_EAFE) && !ecap_eafs(iommu->ecap)) {
+		pr_err_ratelimited("No extended access flag support on %s\n",
+				   iommu->name);
+		return -EINVAL;
+	}
+
+	if (s2_domain->agaw > iommu->agaw) {
+		pr_err_ratelimited("Incompatible agaw %s\n", iommu->name);
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
+	if (s1_cfg->flags & IOMMU_VTD_S1_SRE) {
+		pasid_set_sre(pte);
+		if (s1_cfg->flags & IOMMU_VTD_S1_WPE)
+			pasid_set_wpe(pte);
+	}
+
+	if (s1_cfg->flags & IOMMU_VTD_S1_EAFE)
+		pasid_set_eafe(pte);
+
+	pasid_set_slptr(pte, virt_to_phys(pgd));
+	pasid_set_fault_enable(pte);
+	pasid_set_domain_id(pte, did);
+	pasid_set_address_width(pte, s2_domain->agaw);
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
index d6b7d21244b1..864b12848392 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -111,6 +111,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
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

