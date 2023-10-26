Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EB87D7BC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 06:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjJZEna (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 00:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjJZEm6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 00:42:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B4D193;
        Wed, 25 Oct 2023 21:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698295375; x=1729831375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F1KN5Wxh4+xwtDgUqGDWT2IF4dm9998xnyNQbiGHIDM=;
  b=k5mXtQi9SgTC8FJC/s9fG36HE56sJmJmJ6OI1ZJmSEVCUbf/J66QqMoQ
   f9J8/VyfEvWmwwbXzB7NcDRP+prxC3k6UlCTXTBwk2moDYc+SVV+3Ksl5
   SEjg/I5v5uZzjZJLapIyYYW5LL8LmHAoSnf3tG55iiviLNGWJtsAx0otE
   NVBOnhOxO2ZqvDZb4wiNx3SobHscoKP9fm85P6EvlTMObl5WVNLGmyRWZ
   dA9kJPfuioVKBff56pwREj2Vran83IrCcMqkIGaD+enSI2HVCAFnXFmtJ
   zp6II9Nepsb2BSyYq/JvK4qsDbE2YgDnx4DfAoa6A82l3iUMsS9EFM6cM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="367670755"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="367670755"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:42:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="829478541"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="829478541"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2023 21:42:22 -0700
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
        xin.zeng@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v8 4/8] iommu/vt-d: Add helper to setup pasid nested translation
Date:   Wed, 25 Oct 2023 21:42:12 -0700
Message-Id: <20231026044216.64964-5-yi.l.liu@intel.com>
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
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/pasid.c | 112 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.h |   2 +
 2 files changed, 114 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index b9264b9174e8..74e8e4c17e81 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -370,6 +370,15 @@ static inline bool pasid_get_ssade(struct pasid_entry *pe)
 	return pasid_get_bits(&pe->val[0]) & (1 << 9);
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
@@ -437,6 +446,15 @@ pasid_set_flpm(struct pasid_entry *pe, u64 value)
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
@@ -822,3 +840,97 @@ void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 	if (!cap_caching_mode(iommu->cap))
 		devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
+
+/**
+ * intel_pasid_setup_nested() - Set up PASID entry for nested translation.
+ * @iommu:      IOMMU which the device belong to
+ * @dev:        Device to be set up for translation
+ * @pasid:      PASID to be programmed in the device PASID table
+ * @domain:     User stage-1 domain nested on a stage-2 domain
+ *
+ * This is used for nested translation. The input domain should be
+ * nested type and nested on a parent with 'is_nested_parent' flag
+ * set.
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
+	/* Address width should match the address width supported by hardware */
+	switch (s1_cfg->addr_width) {
+	case ADDR_WIDTH_4LEVEL:
+		break;
+	case ADDR_WIDTH_5LEVEL:
+		if (!cap_fl5lp_support(iommu->cap)) {
+			dev_err_ratelimited(dev,
+					    "5-level paging not supported\n");
+			return -EINVAL;
+		}
+		break;
+	default:
+		dev_err_ratelimited(dev, "Invalid stage-1 address width %d\n",
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
+	if (s2_domain->force_snooping)
+		pasid_set_pgsnp(pte);
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
index 958050b093aa..dd37611175cc 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -113,6 +113,8 @@ int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
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

