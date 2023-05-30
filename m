Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CB5715511
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjE3FlM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjE3Fkj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:40:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1663A11B;
        Mon, 29 May 2023 22:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425221; x=1716961221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Il+8YMeI0EiWGMw/azL1HK4UGyN0VoQuqukfg2UvUJc=;
  b=gwk5/Eeedw/S3RRqvKH4go0vLyP1ct1NKAjxKVLkZtlluOGm3InV0KQM
   7Gug8WtPe3egUnjpeJ7tbEPmSsfxYJNtDYzfECM3nRo9D+C9ZKUnbl7Da
   48D5IkN4n+r3hqkHvi5ZYemtmNw3F3i7WeL1ni/XhIjtBwjB7aq/SeiFI
   ZRZtptsICpxo5JflPx8uEfCk9/Oe3HOguP9j1FZo5AEiVXYy5exaeBTZZ
   ig12HQtZEgRQWd8RjvwiZ76OiAG7nPLzUaV705tjnG7FoB+ClWjrM+7mI
   PFtDpfLBGEgFIR2IRnI1y2suQ6mRVC9xa0adoSKlwb0SANkMFVCeTZIQY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579896"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579896"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369946"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369946"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:39:18 -0700
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
Subject: [RFC PATCHES 15/17] iommufd: Allow new hwpt_alloc flags
Date:   Tue, 30 May 2023 13:37:22 +0800
Message-Id: <20230530053724.232765-16-baolu.lu@linux.intel.com>
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

We have completed all puzzles for IO page fault delivery so far. We can
allow user space to opt-in the flags of IOMMU_HWPT_ALLOC_FLAGS_IOPF and
IOMMU_HWPT_ALLOC_FLAGS_USER_PASID_TABLE now.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/uapi/linux/iommufd.h         | 3 +++
 drivers/iommu/iommufd/hw_pagetable.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 65bb856dd8fb..908d12219727 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -491,6 +491,9 @@ struct iommu_hwpt_alloc {
 	__u32 flags;
 #define IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE		(1 << 0)
 #define IOMMU_HWPT_ALLOC_FLAGS_USER_PASID_TABLE		(1 << 1)
+#define IOMMU_HWPT_ALLOC_FLAGS_ALL				\
+		(IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE |		\
+		 IOMMU_HWPT_ALLOC_FLAGS_USER_PASID_TABLE)
 	__u32 dev_id;
 	__u32 pt_id;
 	__u32 out_hwpt_id;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 7f18e6bd76ec..7be6bf26290f 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -208,7 +208,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	int klen = 0;
 	int rc = 0;
 
-	if (cmd->flags || cmd->__reserved)
+	if ((cmd->flags & ~IOMMU_HWPT_ALLOC_FLAGS_ALL) || cmd->__reserved)
 		return -EOPNOTSUPP;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
-- 
2.34.1

