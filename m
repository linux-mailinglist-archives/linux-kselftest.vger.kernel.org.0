Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE2F75F456
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjGXLFJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjGXLFD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:05:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4B610C3;
        Mon, 24 Jul 2023 04:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196677; x=1721732677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jdb8ZB5daKdGFPrTc/NRXCndQLaxOJW2ZTy0hfrrfYc=;
  b=eAYudO/jVBxCKMJ9eWXTRpjrjtpVWzECmCkofr6AUgxEMLLNQnsMDdAv
   k4FV73GZ7K1zk5/5qzA+PpePp91RSqzQM380wxA89wwuP+ykyhYOCZkqJ
   wNEb2QB6tSWSfpLIjdnquMIqSRa2hia8RIgxQlu1rqUA0HbdznO4E/PEV
   CGakfMMYGMAj1J/A/IW5io+KaBm+7O2Pix7T410+QEBKmLVFWPbzcZwH3
   ctCRY/vFODNG+eBReRcXRzjuZkaAhW4Tu0gDzyiYAt49sRwX8hb5yeigO
   gxgwInsdxVl6l+6IyoMNs1SBNX9rfqrKq1l/higY7TnMR0gMLQ6F3q96h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347013321"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347013321"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775871"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775871"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:22 -0700
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
Subject: [PATCH v3 12/17] iommufd/selftest: Add .get_resv_regions() for mock_dev
Date:   Mon, 24 Jul 2023 04:04:01 -0700
Message-Id: <20230724110406.107212-13-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724110406.107212-1-yi.l.liu@intel.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
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

This makes mock_dev to report resv_regions.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/selftest.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 271c6c261eb4..e40780db88b5 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -292,6 +292,32 @@ static void mock_domain_set_plaform_dma_ops(struct device *dev)
 	 */
 }
 
+static void iommufd_test_get_resv_regions(struct device *dev,
+					  struct list_head *head)
+{
+	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+	struct interval_tree_node *reserved, *next;
+
+	down_read(&mdev->reserved_rwsem);
+	for (reserved = interval_tree_iter_first(&mdev->reserved_itree, 0, ULONG_MAX);
+	     reserved; reserved = next) {
+		struct iommu_resv_region *resv;
+
+		next = interval_tree_iter_next(reserved, 0, ULONG_MAX);
+		/* Only adds IOMMU_RESV_DIRECT so far */
+		resv = iommu_alloc_resv_region(reserved->start,
+					       reserved->last + 1 - reserved->start,
+					       IOMMU_READ | IOMMU_WRITE,
+					       IOMMU_RESV_DIRECT,
+					       GFP_ATOMIC);
+		if (!resv)
+			break;
+
+		list_add_tail(&resv->list, head);
+	}
+	up_read(&mdev->reserved_rwsem);
+}
+
 static const struct iommu_ops mock_ops = {
 	.owner = THIS_MODULE,
 	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
@@ -299,6 +325,7 @@ static const struct iommu_ops mock_ops = {
 	.hw_info = mock_domain_hw_info,
 	.domain_alloc = mock_domain_alloc,
 	.capable = mock_domain_capable,
+	.get_resv_regions = iommufd_test_get_resv_regions,
 	.set_platform_dma_ops = mock_domain_set_plaform_dma_ops,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
-- 
2.34.1

