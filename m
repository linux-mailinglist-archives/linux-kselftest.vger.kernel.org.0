Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE3E7D0C06
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 11:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376724AbjJTJhZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 05:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376686AbjJTJhX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 05:37:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6EBD5B;
        Fri, 20 Oct 2023 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697794642; x=1729330642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=riP8bhy/mUKUAyTqB9Y6vwqhoUTajagOMubWqL1P/vI=;
  b=kcsyj3Ir8wvAWmSvO2Um7JD6G5OVPkGx+0MGSje8dBEFd1JLaiJFm0gy
   ybHmMseDIPwXD0P+LIVe4Bn5fc6zA0MirmoCCh/LzmxJQTjnT9a9AxAp0
   7GOtrMsTcoBML+M6V0iW5OiMtcL+Dtm3E4D049gNEb61b5CPnjE7u4NQZ
   Hsa9nFQ0yDw72PmVwUSgSiHkzNiekTivnbknKmMZz9kliFoj2rYE53O1Y
   nZxWSXSS9MhhTNqk7jor28kf6GWrCr0M+7t+a+i0HFOP4q3zuIwIEo3wQ
   zNHvTY011ILZWWzCTu+LFofubt7W9CSkB8WKkY46NlzE3XYRv6i8ptdpw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="385341727"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="385341727"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707181307"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707181307"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2023 02:37:21 -0700
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
Subject: [PATCH v6 2/3] iommu/vt-d: Make iotlb flush helpers to be extern
Date:   Fri, 20 Oct 2023 02:37:17 -0700
Message-Id: <20231020093719.18725-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020093719.18725-1-yi.l.liu@intel.com>
References: <20231020093719.18725-1-yi.l.liu@intel.com>
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

This makes the helpers visible to nested.c.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 10 +++++-----
 drivers/iommu/intel/iommu.h |  6 ++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a0341a069fbf..8f81a5c9fcc0 100644
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
index 0539a0f47557..b5f33a7c1973 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -867,6 +867,12 @@ void device_block_translation(struct device *dev);
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

