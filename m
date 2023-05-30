Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B667154FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjE3Fir (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjE3Fim (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:38:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E10AD;
        Mon, 29 May 2023 22:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425119; x=1716961119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ZqasWAA5mVjNHn5DIUADADIinyg0cr8B//uQHoZisM=;
  b=UvsvPeUuSesiB8u0JipVkBQuxRQZvIhbsB5BjeJ6QBhoNbueq4XS1UyZ
   26Gwo9C0YLZD+fnIzfm8MBeT8Dr2kQq2iJlkaRfkw70C1M/YrvwP9Vehz
   hK0Z0/GOHoxcUdv8EKI/U+qClbgb6CVN6iocevrDEGhSYn77fVX2LQUjH
   8gQMqAxrQDAb8ybR5s1l9yVOB1S6Sbtnapro5OhUHRjMCn12hL2kT/3QB
   FphRlkqgqs5vBtwMLeNGk1tFnQVU2JV4IoLGhYWCbHyrvTYIkPS0mLuS6
   n1H4q834FF8m0NGQDAdp/a5oJkM504lWzxW8peuwf6109PYV+V04UK8/t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579652"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579652"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:38:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369467"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369467"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:38:32 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCHES 03/17] iommu: Add helper to set iopf handler for domain
Date:   Tue, 30 May 2023 13:37:10 +0800
Message-Id: <20230530053724.232765-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530053724.232765-1-baolu.lu@linux.intel.com>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To avoid open code everywhere. No intentional functionality change.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 10 ++++++++++
 drivers/iommu/iommu.c |  3 +--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fce7ad81206f..f554328528bc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -273,6 +273,16 @@ static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
 	return domain->type & __IOMMU_DOMAIN_DMA_API;
 }
 
+static inline void
+iommu_domain_set_iopf_handler(struct iommu_domain *domain,
+		enum iommu_page_response_code (*handler)(struct iommu_fault *fault,
+							 void *data),
+		void *data)
+{
+	domain->iopf_handler = handler;
+	domain->fault_data = data;
+}
+
 enum iommu_cap {
 	IOMMU_CAP_CACHE_COHERENCY,	/* IOMMU_CACHE is supported */
 	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 13a2e0e26884..fd65ed1d3642 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3419,8 +3419,7 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	domain->type = IOMMU_DOMAIN_SVA;
 	mmgrab(mm);
 	domain->mm = mm;
-	domain->iopf_handler = iommu_sva_handle_iopf;
-	domain->fault_data = mm;
+	iommu_domain_set_iopf_handler(domain, iommu_sva_handle_iopf, mm);
 
 	return domain;
 }
-- 
2.34.1

