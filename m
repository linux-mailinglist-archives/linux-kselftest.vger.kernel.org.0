Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571F77A97FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 19:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjIUR3T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 13:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjIUR2o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 13:28:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55695AD25;
        Thu, 21 Sep 2023 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316280; x=1726852280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cxZTRu44xkZvSgweNgQ/ax7l1RyCji4jcedyDtK8Vag=;
  b=XVON4yOg04xCNnkdgBFkWMeci+MqVoSO6VSmPOUxgf+qdoJKSgTZBKpf
   731eLZwmO1IABgPBwORUH6NkuErTzFZWagfjhlM6ioDiDsQsleAa6eayD
   P2+rsgeUousP1BLPqdZJjCHKRasQooszd604jI4jfM8+sO4m7GBAIXnVJ
   BUQpfc6n9PKvCbz1SNWfWDLF7H8rfJ+9SC6SCfimOLvFQ8KwKvqUaDoLz
   Rw74R5IFxabZfA0qx1mi39TB/fBb/pim9B8TN5tdpsdZBvYwueyPAy9cH
   Nf3BFgXWUjDmbQ0mI0JclQet+AHMj4BONJzhRcgG+NdROVKNUUrCQzDe2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="370764470"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="370764470"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812523171"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="812523171"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 21 Sep 2023 00:54:52 -0700
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: [PATCH v5 08/11] iommu/vt-d: Make iotlb flush helpers to be extern
Date:   Thu, 21 Sep 2023 00:54:28 -0700
Message-Id: <20230921075431.125239-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075431.125239-1-yi.l.liu@intel.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This makes the helpers visible to nested.c.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 10 +++++-----
 drivers/iommu/intel/iommu.h |  6 ++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7b75f407c623..c93c91ed4ee2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1511,10 +1511,10 @@ static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
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
@@ -1587,7 +1587,7 @@ static inline void __mapping_notify_one(struct intel_iommu *iommu,
 		iommu_flush_write_buffer(iommu);
 }
 
-static void intel_flush_iotlb_all(struct iommu_domain *domain)
+void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct iommu_domain_info *info;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 411cde769787..ac23b9d22d20 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -865,6 +865,12 @@ void device_block_translation(struct device *dev);
 int prepare_domain_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
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

