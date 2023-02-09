Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C0D68FE63
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 05:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBIEUW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 23:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBIEUT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 23:20:19 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177085BB6;
        Wed,  8 Feb 2023 20:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675916364; x=1707452364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FvzP1cm3MJo8mMYBDAYm1g80hB7lsWqyw4EEdmHNXb4=;
  b=DuT36FuySU9sAa4zuVmP34locoWLSwXQu3814a2c8s21lGEvF4ASJQpz
   9Ou73zbYJ/65EwgBZSPGWHWYUwfGFCzTaO11XjpitqTYhOC0tBdIcO+LY
   soyEwGLNuEC2AJBWcRjlj/g7jhtO5SidoVqYtWDZVaAL/k98bTsxcb2aB
   J03EoWYizV3nhUGMnh2ECamyiCm8x0AM4wSjnYvTk5t34LbRMJD2qXDQC
   ElvSk4ImnaWJAtWjFhXrjwnabZdIz0Q/rLVQvGjnB7bFEra227nUcvS3v
   6MLSeyqnX2imXYFhU4G128/wN/ohZ8c30wVXGvx0iwgWrRCBMiPA11bMq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394600742"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="394600742"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:16:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="912982117"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="912982117"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2023 20:16:51 -0800
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
Subject: [PATCH 4/6] iommufd/device: Add mock_device support in iommufd_device_get_info()
Date:   Wed,  8 Feb 2023 20:16:40 -0800
Message-Id: <20230209041642.9346-5-yi.l.liu@intel.com>
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

This prepares for adding selftest for IOMMU_DEVICE_GET_INFO. Selftest
uses mock device, while physical device uses iommufd_device, so add
a helper iommufd_obj_dev() to get struct device from the iommufd_object
for a given dev_id.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 22 ++++++++++++++++++++--
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/selftest.c        |  7 +++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 3b64aef24807..470838e6902d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -145,6 +145,20 @@ static int iommufd_zero_fill_user(u64 ptr, int bytes)
 	return 0;
 }
 
+static struct device *
+iommufd_obj_dev(struct iommufd_object *obj)
+{
+	struct device *dev = NULL;
+
+	if (obj->type == IOMMUFD_OBJ_DEVICE)
+		dev = container_of(obj, struct iommufd_device, obj)->dev;
+#ifdef CONFIG_IOMMUFD_TEST
+	else if (obj->type == IOMMUFD_OBJ_SELFTEST)
+		dev = iommufd_selftest_obj_to_dev(obj);
+#endif
+	return dev;
+}
+
 int iommufd_device_get_info(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_device_info *cmd = ucmd->cmd;
@@ -159,11 +173,15 @@ int iommufd_device_get_info(struct iommufd_ucmd *ucmd)
 		return -EOPNOTSUPP;
 
 	dev_obj = iommufd_get_object(ucmd->ictx, cmd->dev_id,
-				     IOMMUFD_OBJ_DEVICE);
+				     IOMMUFD_OBJ_ANY);
 	if (IS_ERR(dev_obj))
 		return PTR_ERR(dev_obj);
 
-	dev = container_of(dev_obj, struct iommufd_device, obj)->dev;
+	dev = iommufd_obj_dev(dev_obj);
+	if (!dev) {
+		rc = -EINVAL;
+		goto out_put;
+	}
 
 	ops = dev_iommu_ops(dev);
 	if (!ops || !ops->hw_info) {
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 4a0a1a7fdae1..7748117e36f9 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -284,6 +284,7 @@ iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
 			       struct device *mock_dev);
 void iommufd_device_selftest_detach(struct iommufd_ctx *ictx,
 				    struct iommufd_hw_pagetable *hwpt);
+struct device *iommufd_selftest_obj_to_dev(struct iommufd_object *obj);
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
 extern size_t iommufd_test_memory_limit;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index b94870f93138..2ecde22a60f4 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -802,6 +802,13 @@ void iommufd_selftest_destroy(struct iommufd_object *obj)
 	}
 }
 
+struct device *iommufd_selftest_obj_to_dev(struct iommufd_object *obj)
+{
+	struct selftest_obj *sobj = container_of(obj, struct selftest_obj, obj);
+
+	return &sobj->idev.mock_dev;
+}
+
 int iommufd_test(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_test_cmd *cmd = ucmd->cmd;
-- 
2.34.1

