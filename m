Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A1B75F4AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjGXLOC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGXLNs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:13:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4766CE5A;
        Mon, 24 Jul 2023 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690197227; x=1721733227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Evb/uH75XnFTXbrCht5Yjl6IDfDcpiTHryTOzFFcMAQ=;
  b=h3o5pnDT5/KWnZtKO87Ady4zUBbTYiVUFdFY0RiDAEAu7UCp+VDIOqBA
   GakAV+T5waYMkOMsacNhZrgL2CzFSeaWzsp2bpDuK/Fyg7KfW59na9gXU
   DRfAY/INok270TtAqNdf0iLKlxEC1p8CWpSu6NM1pzDnkYuWKb9sndrfo
   yBX/UJVOyU4wgMzWtdZ6snw/XOe1jpPxQ937XabDNWB0dUCs7qCiWunzL
   VQn/e98ncMLZ5+lHHJasyfn80QiNwXQQG8w9doOOz7ZN1zDZYdQslLi6c
   g5xD392inpg4qXToFD+rVGwRyFD742O1Vt3aVzf/rhT5uv/NHC8nq32+e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347015022"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347015022"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839415556"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839415556"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 04:13:46 -0700
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
Subject: [PATCH v4 08/12] iommu/vt-d: Make iotlb flush helpers to be extern
Date:   Mon, 24 Jul 2023 04:13:30 -0700
Message-Id: <20230724111335.107427-9-yi.l.liu@intel.com>
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

This makes the helpers visible to nested.c.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 10 +++++-----
 drivers/iommu/intel/iommu.h |  6 ++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 289e8c2417ad..3119a79ebc83 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1466,10 +1466,10 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
-static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
-				  struct dmar_domain *domain,
-				  unsigned long pfn, unsigned int pages,
-				  int ih, int map)
+void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
+			   struct dmar_domain *domain,
+			   unsigned long pfn, unsigned int pages,
+			   int ih, int map)
 {
 	unsigned int aligned_pages = __roundup_pow_of_two(pages);
 	unsigned int mask = ilog2(aligned_pages);
@@ -1542,7 +1542,7 @@ static inline void __mapping_notify_one(struct intel_iommu *iommu,
 		iommu_flush_write_buffer(iommu);
 }
 
-static void intel_flush_iotlb_all(struct iommu_domain *domain)
+void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct iommu_domain_info *info;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 4b12166a9c3f..5b292213bcb8 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -859,6 +859,12 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain);
 void domain_update_iommu_cap(struct dmar_domain *domain);
+void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
+			   struct dmar_domain *domain,
+			   unsigned long pfn, unsigned int pages,
+			   int ih, int map);
+void intel_flush_iotlb_all(struct iommu_domain *domain);
+
 
 int dmar_ir_support(void);
 
-- 
2.34.1

