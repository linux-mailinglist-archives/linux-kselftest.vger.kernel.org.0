Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124C97154FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjE3Fif (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjE3Fie (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:38:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0842FAD;
        Mon, 29 May 2023 22:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425112; x=1716961112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4cYj8sTyvLBKZg/N54/ZRBBAlaG5CsvyE1vXMZic30o=;
  b=PLebcoLRb5OjFmUdFAOtZKVqGqbcDjj9LbpFXKwUhnudaVAFmYgZ64U5
   zqPaoROMCtMC27FmhxuyKiKIJqibiU8N402QMpAkjtNA2kR7eCiHvNd8Z
   9Mb1JyQpoiD9HPgP53uCaz7MvaTJ2KtOursNBta0m2VSAv+AI0OXSpuP+
   fy6QVXaDhvsYPQ2WrUkUOetvnaa4e3bXXeBHX1RXHqNc9RUZBXcy2BriP
   GH/NgxwaWUHwirFNtRPVBrvTlCKNRBc6JVR5tkAyZfk3ePmJQs3kEJA0/
   i7QCiiqsNRXYKL1dsCwRmLq5jkIIopknpE0BtRJwkWaXrsiDBCf6RWzc1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579608"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579608"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:38:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369425"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369425"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:38:29 -0700
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
Subject: [RFC PATCHES 02/17] iommu: Support asynchronous I/O page fault response
Date:   Tue, 30 May 2023 13:37:09 +0800
Message-Id: <20230530053724.232765-3-baolu.lu@linux.intel.com>
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

Add a new page response code, IOMMU_PAGE_RESP_ASYNC, to indicate that the
domain's page fault handler doesn't respond the hardware immediately, but
do it in an asynchronous way.

The use case of this response code is the nested translation, where the
first-stage page table is owned by the VM guest and any page fault on
it should be propagated to the VM guest and page fault will be responded
in a different thread context later.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h      | 2 ++
 drivers/iommu/io-pgfault.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d6a93de7d1dd..fce7ad81206f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -164,11 +164,13 @@ struct iommu_fault {
  *	this device if possible. This is "Response Failure" in PCI PRI.
  * @IOMMU_PAGE_RESP_INVALID: Could not handle this fault, don't retry the
  *	access. This is "Invalid Request" in PCI PRI.
+ * @IOMMU_PAGE_RESP_ASYNC: Will response later by calling iommu_page_response().
  */
 enum iommu_page_response_code {
 	IOMMU_PAGE_RESP_SUCCESS = 0,
 	IOMMU_PAGE_RESP_INVALID,
 	IOMMU_PAGE_RESP_FAILURE,
+	IOMMU_PAGE_RESP_ASYNC,
 };
 
 /**
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index e5b8b9110c13..83f8055a0e09 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -96,7 +96,8 @@ static void iopf_handler(struct work_struct *work)
 			kfree(iopf);
 	}
 
-	iopf_complete_group(group->dev, &group->last_fault, status);
+	if (status != IOMMU_PAGE_RESP_ASYNC)
+		iopf_complete_group(group->dev, &group->last_fault, status);
 	kfree(group);
 }
 
-- 
2.34.1

