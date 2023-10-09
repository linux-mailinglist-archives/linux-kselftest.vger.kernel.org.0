Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766177BD5C5
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 10:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345570AbjJIIvg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 04:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345577AbjJIIvb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 04:51:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E9ED8;
        Mon,  9 Oct 2023 01:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696841488; x=1728377488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oW307Sz3JLhBJDdKvXdymtYFyyVye4wCg0yXRx4S4UE=;
  b=DrquFYH3kHqbyy/zHQxiY7t75YyhKn/89vJnDpro4QThddoKWYUHmd7a
   xyx3Sa2sjjJADFgXE+6gAcsTloCcRK9eJAp/mH7Qgx+ZIr4x+eWRc6MM9
   YY3vC5+F/407ap6m57FvSZy5eB4rHORytK8r4dRpcsbwHPJqivK/KCBwM
   3OgMIfEL5eHQS8jXwu1MXVYGvPh0Mm/xI0gHw+R+loId781qTcsmmUqTW
   W0oGXa+uAnh9GhZY9G1NMQR67NkbGauTosLM9E3Amk93+kOBhQF/f4+y8
   h26OZex0JN7NssA2GiNNNoXsTNoHborUvqblhiTqP7TZVUNjBnHyhK5FM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="364390755"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="364390755"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 01:51:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="818781645"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="818781645"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 09 Oct 2023 01:51:27 -0700
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
Subject: [RFC 1/7] iommufd: Handle unsafe interrupts in a separate function
Date:   Mon,  9 Oct 2023 01:51:17 -0700
Message-Id: <20231009085123.463179-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009085123.463179-1-yi.l.liu@intel.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
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

From: Kevin Tian <kevin.tian@intel.com>

This wraps the unsafe interrupts handling into helper as same check is also
required when supporting iommufd_device_bind_pasid() later.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 36 ++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 6a6145b4a25e..ca3919fecc89 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -145,6 +145,25 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 		iommufd_ctx_put(idev->ictx);
 }
 
+/*
+ * For historical compat with VFIO the insecure interrupt path is
+ * allowed if the module parameter is set. Insecure means that a MemWr
+ * operation from the device (eg a simple DMA) cannot trigger an
+ * interrupt outside this iommufd context.
+ */
+static int iommufd_allow_unsafe_interrupts(struct device *dev)
+{
+	if (!allow_unsafe_interrupts)
+		return -EPERM;
+
+	dev_warn(
+		dev,
+		"MSI interrupts are not secure, they cannot be isolated by the platform. "
+		"Check that platform features like interrupt remapping are enabled. "
+		"Use the \"allow_unsafe_interrupts\" module parameter to override\n");
+	return 0;
+}
+
 /**
  * iommufd_device_bind - Bind a physical device to an iommu fd
  * @ictx: iommufd file descriptor
@@ -179,24 +198,11 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	if (IS_ERR(igroup))
 		return ERR_CAST(igroup);
 
-	/*
-	 * For historical compat with VFIO the insecure interrupt path is
-	 * allowed if the module parameter is set. Secure/Isolated means that a
-	 * MemWr operation from the device (eg a simple DMA) cannot trigger an
-	 * interrupt outside this iommufd context.
-	 */
 	if (!iommufd_selftest_is_mock_dev(dev) &&
 	    !iommu_group_has_isolated_msi(igroup->group)) {
-		if (!allow_unsafe_interrupts) {
-			rc = -EPERM;
+		rc = iommufd_allow_unsafe_interrupts(dev);
+		if (rc)
 			goto out_group_put;
-		}
-
-		dev_warn(
-			dev,
-			"MSI interrupts are not secure, they cannot be isolated by the platform. "
-			"Check that platform features like interrupt remapping are enabled. "
-			"Use the \"allow_unsafe_interrupts\" module parameter to override\n");
 	}
 
 	rc = iommu_device_claim_dma_owner(dev, ictx);
-- 
2.34.1

