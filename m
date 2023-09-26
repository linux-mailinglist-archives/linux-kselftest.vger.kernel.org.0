Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBB77AE910
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 11:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjIZJ1L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 05:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbjIZJ1H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 05:27:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA88012A;
        Tue, 26 Sep 2023 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695720419; x=1727256419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hu5+DAlc/LxtKTBDHUP2n+rfmHyfTgHBNfP8o8wGcU8=;
  b=OCtWr6NtIwf1ZP1J8fxgu+OBPnCYbcDlrfCz721VMsVSb8prONCANify
   Pe9ysvR9UZpKLWiH/0OB7VeNsqwR7M0wjtuMQI8va+X85zjL4VXfJQRif
   QBBIWEeI0po0Nt9fMkdbrDW6Yrl4ndhOBJobRNLsI+P/udAOdJyezLPUs
   ZygsqI6p54m8/SbeDCWUtmaLSqk6uKeHizf2O3YDidMRFgJUB0wq0e9ji
   7CBMeF+Eu7Mi0vawZykqVsJXHQpQScWNO/cbe7Si+tyP6PdeEp98SE1Zc
   N6eGde9rkl0+YFvWvT5gv2RDmZraaGT7eJnJmXfpLFuJu3rL42WzDjB8h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360905377"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360905377"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 02:26:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079642553"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="1079642553"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2023 02:26:57 -0700
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
Subject: [RFC 4/8] iommufd/selftest: Add set_dev_pasid and remove_dev_pasid in mock iommu
Date:   Tue, 26 Sep 2023 02:26:47 -0700
Message-Id: <20230926092651.17041-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926092651.17041-1-yi.l.liu@intel.com>
References: <20230926092651.17041-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The two callbacks are needed to make pasid_attach/detach path complete for
mock device. A nop is enough for set_dev_pasid, a domain type check in the
remove_dev_pasid is also helpful.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/selftest.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 117776d236dc..200c88387cd1 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -431,6 +431,31 @@ static void mock_domain_unset_dev_user_data(struct device *dev)
 	mdev->dev_data = 0;
 }
 
+static void mock_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_domain *domain;
+
+	/* Domain type specific cleanup: */
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
+	if (domain) {
+		switch (domain->type) {
+		case IOMMU_DOMAIN_NESTED:
+		case IOMMU_DOMAIN_UNMANAGED:
+			break;
+		default:
+			/* should never reach here */
+			WARN_ON(1);
+			break;
+		}
+	}
+}
+
+static int mock_domain_set_dev_pasid_nop(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t pasid)
+{
+	return 0;
+}
+
 static const struct iommu_ops mock_ops = {
 	.owner = THIS_MODULE,
 	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
@@ -443,6 +468,7 @@ static const struct iommu_ops mock_ops = {
 	.probe_device = mock_probe_device,
 	.set_dev_user_data = mock_domain_set_dev_user_data,
 	.unset_dev_user_data = mock_domain_unset_dev_user_data,
+	.remove_dev_pasid = mock_iommu_remove_dev_pasid,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
@@ -450,6 +476,7 @@ static const struct iommu_ops mock_ops = {
 			.map_pages = mock_domain_map_pages,
 			.unmap_pages = mock_domain_unmap_pages,
 			.iova_to_phys = mock_domain_iova_to_phys,
+			.set_dev_pasid = mock_domain_set_dev_pasid_nop,
 		},
 };
 
@@ -500,6 +527,7 @@ static struct iommu_domain_ops domain_nested_ops = {
 	.free = mock_domain_free,
 	.attach_dev = mock_domain_nop_attach,
 	.cache_invalidate_user = mock_domain_cache_invalidate_user,
+	.set_dev_pasid = mock_domain_set_dev_pasid_nop,
 };
 
 static inline struct iommufd_hw_pagetable *
-- 
2.34.1

