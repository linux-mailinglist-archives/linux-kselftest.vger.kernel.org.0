Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7998268FF46
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjBIEfB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjBIEeA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:34:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0159A4FAC5;
        Wed,  8 Feb 2023 20:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917174; x=1707453174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PBFJ6TbDlAcW3TvlfZUDDjiRVo3eS7ALVE66cynI8FM=;
  b=YiTlofmF+vOoAKbBi3bDZqlqgg/GXlGYvioKY3nUZpeOyyp7aiMYaOxw
   bvRxUyVSS6UrP86zuzQ6VUGWXZOXOqdoC/w6dUbxyZt3T0obWXfGkaaok
   nfww7ZellMVLwfAVJKVlJSOmqKQhIQF9oCyR7znMcYBEF7MWgk4V31KVw
   ipaCfEus+qShpxcp/0+ArMSwd+ZkhtIC3JqEciNIpV2wFgdIHcuNmf7eb
   jHgNJh2jRM/zge8TYsSFP6gO1xwZHMlf48ZRss2zPOqKSHk390RC1rSLr
   kjeb56dJn18b7s5sw5Mr4stX6VjzLMDOnJfFImRAWBt5GuJ4xAuHFEmgV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298780"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298780"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447573"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447573"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:16 -0800
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
Subject: [PATCH 10/17] iommufd/device: Move IOAS attaching and detaching operations into helpers
Date:   Wed,  8 Feb 2023 20:31:46 -0800
Message-Id: <20230209043153.14964-11-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

When using a 2-stage nested hw_pagetable (hwpt) setup, the IOVA mappings
or SW MSI are at the stage-2 hwpt, while the device will be attached to
a stage-1 hwpt. And then the current do_attach() flow will fail to set up
MSI, since it always uses the attaching hwpt pointer (i.e. stage-1 in such
case).

As a preparatory change for the following nesting support patch, move all
related operations into a pair of separate functions, so we only need to
redirect the hwpt pointer to its stage-2 hwpt, when using a nested setup.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 40 +++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index dd7943ff02e4..cdc4ab36f52d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -294,6 +294,36 @@ static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
 	return false;
 }
 
+static int iommufd_device_attach_ioas(struct iommufd_device *idev,
+				      struct iommufd_hw_pagetable *hwpt)
+{
+	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
+	struct io_pagetable *iopt;
+	int rc;
+
+	iopt = &hwpt->ioas->iopt;
+
+	rc = iopt_table_enforce_group_resv_regions(iopt, idev->dev,
+						   idev->group, &sw_msi_start);
+	if (rc)
+		return rc;
+
+	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
+	if (rc)
+		goto out_iova;
+
+	return 0;
+out_iova:
+	iopt_remove_reserved_iova(iopt, idev->group);
+	return rc;
+}
+
+static void iommufd_device_detach_ioas(struct iommufd_device *idev,
+				       struct iommufd_hw_pagetable *hwpt)
+{
+	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+}
+
 /**
  * __iommmufd_device_detach - Detach a device from idev->hwpt to new_hwpt
  * @idev: device to detach
@@ -323,7 +353,7 @@ static void __iommmufd_device_detach(struct iommufd_device *idev,
 
 	if (hwpt->ioas != new_ioas) {
 		mutex_lock(&hwpt->ioas->mutex);
-		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+		iommufd_device_detach_ioas(idev, hwpt);
 		mutex_unlock(&hwpt->ioas->mutex);
 	}
 	mutex_unlock(&hwpt->devices_lock);
@@ -342,7 +372,6 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 				    struct iommufd_hw_pagetable *hwpt)
 {
 	struct iommufd_hw_pagetable *cur_hwpt = idev->hwpt;
-	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
 	lockdep_assert_held(&hwpt->ioas->mutex);
@@ -367,15 +396,10 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 		}
 	}
 
-	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
-						   idev->group, &sw_msi_start);
+	rc = iommufd_device_attach_ioas(idev, hwpt);
 	if (rc)
 		goto out_unlock;
 
-	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
-	if (rc)
-		goto out_iova;
-
 	/*
 	 * FIXME: Hack around missing a device-centric iommu api, only attach to
 	 * the group once for the first device that is in the group.
-- 
2.34.1

