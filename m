Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DE97BD5C7
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 10:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345503AbjJIIwJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 04:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345591AbjJIIvf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 04:51:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6496AB;
        Mon,  9 Oct 2023 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696841490; x=1728377490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZrNdz5dSYF7ymp/w9UQeOTkhWG7Zhjt6N1Zo2oVnAYQ=;
  b=TwDfRf4YaMU0IFGjwo7TK8AAhvaEtsbMmJwBWNvYXQypgwq8RzWPewIn
   zEx2B77jlwIKezJzq0c7ThE6DaCNcJWKnAa9tleWb6+DB+43WnoGn16iA
   95T7YKQ1f7n+RDOyjeSgR2LBpiSbcCSsOHQ4rqBGVot8qKg0fNJKI+Zsc
   ZDRkXRprZkI6mW/F9+fNNxom6IvWKZfkVkXiD7DlvzlwE/P31UOvcmJKo
   SLcIL6OBovvci26TXwAtxod5edHqV5vrYWSRFAKgdF9MgzUwEpIvZwxOT
   d7j2YpLkSSbuqE1aYSrzKXAxdzJ8lC2+nsRpbVo/aCgIfN0i+avb7oNeq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="364390781"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="364390781"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 01:51:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="818781660"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="818781660"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga008.fm.intel.com with ESMTP; 09 Oct 2023 01:51:29 -0700
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
Subject: [RFC 2/7] iommufd: Introduce iommufd_alloc_device()
Date:   Mon,  9 Oct 2023 01:51:18 -0700
Message-Id: <20231009085123.463179-3-yi.l.liu@intel.com>
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

This abstracts the common logic used in the iommufd_device_bind() and the
later iommufd_device_bind_pasid() to be helper.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index ca3919fecc89..9dd76d92b7f6 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -164,6 +164,27 @@ static int iommufd_allow_unsafe_interrupts(struct device *dev)
 	return 0;
 }
 
+static struct iommufd_device *iommufd_alloc_device(struct iommufd_ctx *ictx,
+						   struct device *dev)
+{
+	struct iommufd_device *idev;
+
+	idev = iommufd_object_alloc(ictx, idev, IOMMUFD_OBJ_DEVICE);
+	if (IS_ERR(idev))
+		return idev;
+	idev->ictx = ictx;
+	if (!iommufd_selftest_is_mock_dev(dev))
+		iommufd_ctx_get(ictx);
+	idev->dev = dev;
+	idev->enforce_cache_coherency =
+		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
+	xa_init(&idev->pasid_hwpts);
+
+	/* The calling driver is a user until iommufd_device_unbind() */
+	refcount_inc(&idev->obj.users);
+	return idev;
+}
+
 /**
  * iommufd_device_bind - Bind a physical device to an iommu fd
  * @ictx: iommufd file descriptor
@@ -209,24 +230,15 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	if (rc)
 		goto out_group_put;
 
-	idev = iommufd_object_alloc(ictx, idev, IOMMUFD_OBJ_DEVICE);
+	idev = iommufd_alloc_device(ictx, dev);
 	if (IS_ERR(idev)) {
 		rc = PTR_ERR(idev);
 		goto out_release_owner;
 	}
-	idev->ictx = ictx;
-	if (!iommufd_selftest_is_mock_dev(dev))
-		iommufd_ctx_get(ictx);
-	idev->dev = dev;
-	idev->enforce_cache_coherency =
-		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
-	/* The calling driver is a user until iommufd_device_unbind() */
-	refcount_inc(&idev->obj.users);
+
 	/* igroup refcount moves into iommufd_device */
 	idev->igroup = igroup;
 
-	xa_init(&idev->pasid_hwpts);
-
 	/*
 	 * If the caller fails after this success it must call
 	 * iommufd_unbind_device() which is safe since we hold this refcount.
-- 
2.34.1

