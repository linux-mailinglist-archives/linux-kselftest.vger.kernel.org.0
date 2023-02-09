Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A74168FE66
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjBIEUX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBIEUW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:20:22 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46E91A95D;
        Wed,  8 Feb 2023 20:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675916367; x=1707452367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HKkQ3XLh/cgddbfTjAzae85+rSiZHI2gRNi0xQo2hVQ=;
  b=l+ZwhvxAJzdUjkfPoz4EG/G7HBdWBqT8G4Duaa3ifPIjNu2NaeJuTRzz
   bquZ49LBbZCauWhiIbJqfWipQl9qyLrrE9STsoDd6qmSEw4IorsJrcUwz
   K85faZHY7thNoifj/illtyjKyxOP6ZpAOHt9KapgbpCqtfzkaR76YGVMt
   SqjXfURM5FlA1KYRxAcfnWfZs/11cJnVUwiov2BKm/0tq226+JCOTBoTN
   WG33CuZnKrZXgQbjD7yaIpBX8L3WYC7VgPkhAvmJmaMgbPzv0laytLGCT
   4n2KieltwojgQJXFXYKMwaO46VlE4gDcxroXKA18NvmwkEY4JNK4trX8+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394600757"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="394600757"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:16:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="912982130"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="912982130"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2023 20:16:54 -0800
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: [PATCH 5/6] iommufd/selftest: Set iommu_device for mock_device
Date:   Wed,  8 Feb 2023 20:16:41 -0800
Message-Id: <20230209041642.9346-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209041642.9346-1-yi.l.liu@intel.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
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

From: Nicolin Chen <nicolinc@nvidia.com>

This is required to avoid NULL pointer when iommufd selftest tries to
allocate domain for mock_device.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/selftest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 2ecde22a60f4..5afed3fc30fe 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -273,6 +273,8 @@ get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
 static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 				    struct iommu_test_cmd *cmd)
 {
+	static struct iommu_device iommu_dev = { .ops = &mock_ops };
+	static struct dev_iommu iommu = { .iommu_dev = &iommu_dev };
 	static struct bus_type mock_bus = { .iommu_ops = &mock_ops };
 	struct iommufd_hw_pagetable *hwpt;
 	struct selftest_obj *sobj;
@@ -291,6 +293,7 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	sobj->idev.ictx = ucmd->ictx;
 	sobj->type = TYPE_IDEV;
 	sobj->idev.mock_dev.bus = &mock_bus;
+	sobj->idev.mock_dev.iommu = &iommu;
 
 	hwpt = iommufd_device_selftest_attach(ucmd->ictx, ioas,
 					      &sobj->idev.mock_dev);
-- 
2.34.1

