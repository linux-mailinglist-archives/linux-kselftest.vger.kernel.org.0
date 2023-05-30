Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED11715513
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjE3FlP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjE3Fkk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:40:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D25107;
        Mon, 29 May 2023 22:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425221; x=1716961221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ahpCrKl/gZhgbumlo1Sx9/qZq5FOZ/WQW6MhgCLqjXg=;
  b=jwX5106X4rYjuLF8pPUyMceVfDUkbBYPrM+2EcN2IIyqpZoDexOhQ01c
   fguQHSrcJPHCzDh4Tn55bk2Z1GsBqm8HfNso8XztgL2RcMXJ3i3lJUYBj
   s1dbtYMwlm1u2zUzpfjp5TJjbeNCcTx3HANu1jDAGeRM7LOKuR9OSZPzh
   HKOfuklZ+nIzKbEB6/WNa6jpo6nWBAFM5CcvTVeafvBEG5UDR9lwu+Btc
   2Qa+Ol8ymW1fl48qemGaWhT2SPE9fVBt4Z50rmD0M8he783YmMuds3yGl
   s19hc76yFclh8aSlkK8/OccVksaXx2NLz+8jvrs0UEaLvlaMqhn/Vr2qv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420579914"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420579914"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:39:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739369974"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739369974"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2023 22:39:22 -0700
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
Subject: [RFC PATCHES 16/17] iommufd/selftest: Add IOPF feature for mock devices
Date:   Tue, 30 May 2023 13:37:23 +0800
Message-Id: <20230530053724.232765-17-baolu.lu@linux.intel.com>
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

So that we can test the delilvery of IO page faults through IOMMU with
the selftest infrastructure.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/selftest.c | 71 ++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index debf2d588990..d3d3342e95b6 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -14,6 +14,7 @@
 #include "io_pagetable.h"
 #include "iommufd_private.h"
 #include "iommufd_test.h"
+#include "../io-pgfault.h"
 
 static DECLARE_FAULT_ATTR(fail_iommufd);
 static struct dentry *dbgfs_root;
@@ -96,6 +97,8 @@ enum selftest_obj_type {
 struct mock_dev {
 	struct device dev;
 	u32 dev_data;
+	unsigned char iopfq_name[16];
+	struct iopf_queue *iopf_queue;
 };
 
 struct selftest_obj {
@@ -360,6 +363,64 @@ static int mock_domain_user_data_len(u32 hwpt_type)
 	return sizeof(struct iommu_hwpt_selftest);
 };
 
+static int mock_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
+{
+	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+	struct iommu_group *group;
+	int rc;
+
+	if (feat != IOMMU_DEV_FEAT_IOPF)
+		return -EOPNOTSUPP;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
+
+	/* Allocate the iopf queue: */
+	snprintf(mdev->iopfq_name, sizeof(mdev->iopfq_name),
+		 "mock%d-iopfq", iommu_group_id(group));
+	mdev->iopf_queue = iopf_queue_alloc(mdev->iopfq_name);
+	if (!mdev->iopf_queue) {
+		rc = -ENOMEM;
+		goto err_put_group;
+	}
+
+	/* Register I/O page fault: */
+	rc = iopf_queue_add_device(mdev->iopf_queue, &mdev->dev);
+	if (rc)
+		goto err_free_queue;
+	rc = iommu_register_device_fault_handler(&mdev->dev, iommu_queue_iopf,
+						 &mdev->dev);
+	if (rc)
+		goto err_remove_device;
+
+	iommu_group_put(group);
+
+	return 0;
+
+err_remove_device:
+	iopf_queue_remove_device(mdev->iopf_queue, &mdev->dev);
+err_free_queue:
+	iopf_queue_free(mdev->iopf_queue);
+err_put_group:
+	iommu_group_put(group);
+	return rc;
+}
+
+static int mock_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
+{
+	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+
+	if (feat != IOMMU_DEV_FEAT_IOPF)
+		return -EOPNOTSUPP;
+
+	iommu_unregister_device_fault_handler(dev);
+	iopf_queue_remove_device(mdev->iopf_queue, dev);
+	iopf_queue_free(mdev->iopf_queue);
+
+	return 0;
+}
+
 static const struct iommu_ops mock_ops = {
 	.owner = THIS_MODULE,
 	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
@@ -373,6 +434,8 @@ static const struct iommu_ops mock_ops = {
 	.set_dev_user_data = mock_domain_set_dev_user_data,
 	.unset_dev_user_data = mock_domain_unset_dev_user_data,
 	.dev_user_data_len = sizeof(struct iommu_test_device_data),
+	.dev_enable_feat = mock_dev_enable_feat,
+	.dev_disable_feat = mock_dev_disable_feat,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
@@ -494,9 +557,16 @@ static struct mock_dev *mock_dev_create(void)
 	rc = iommu_group_add_device(iommu_group, &mdev->dev);
 	if (rc)
 		goto err_del;
+
+	rc = iommu_dev_enable_feature(&mdev->dev, IOMMU_DEV_FEAT_IOPF);
+	if (rc)
+		goto err_remove;
+
 	iommu_group_put(iommu_group);
 	return mdev;
 
+err_remove:
+	iommu_group_remove_device(&mdev->dev);
 err_del:
 	device_del(&mdev->dev);
 err_dev_iommu:
@@ -511,6 +581,7 @@ static struct mock_dev *mock_dev_create(void)
 
 static void mock_dev_destroy(struct mock_dev *mdev)
 {
+	iommu_dev_disable_feature(&mdev->dev, IOMMU_DEV_FEAT_IOPF);
 	iommu_group_remove_device(&mdev->dev);
 	device_del(&mdev->dev);
 	kfree(mdev->dev.iommu);
-- 
2.34.1

