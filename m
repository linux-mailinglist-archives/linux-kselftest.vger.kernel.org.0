Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEC27AE90C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 11:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjIZJ1J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 05:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjIZJ1I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 05:27:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408B3EB;
        Tue, 26 Sep 2023 02:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695720421; x=1727256421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z/8xtA8gAK2sz+3XlyEPUKVKbvGdFNqEfJbcjCXtYIM=;
  b=dVg55Z41/VSGlO/gM9n7Z3KeFSBgLYQT07H271JJbEVu177T/lTcJvTv
   nUHs54I9OQYBzuHGHLrGE6htW1vEhmOxLAx6V5o4LRUCxuE9mGroldUhs
   uhel1ORB/EZUFyOAsskrfWZZuUu8ant19pZjwr8wh/fHrgilhz/EDdh8N
   JittMYwCUSUGRa5EhFsiTCYsDGyhqT0M6fBXdoZBzJ+FuG0UMcoKu3ZIr
   QH93eM9SgPvNT2+RH2/w3ZgNhgw5XGHXXDhK1J5r6DF6lrJw838Gvy6g+
   6HAma/HZT5zr6U4MuXPA1AXjeOrXI8U+zKklPDAadl21IkZ+bI1S4ERui
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360905388"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360905388"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 02:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079642559"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="1079642559"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga005.fm.intel.com with ESMTP; 26 Sep 2023 02:26:58 -0700
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
Subject: [RFC 5/8] iommufd/selftest: Add a helper to get test device
Date:   Tue, 26 Sep 2023 02:26:48 -0700
Message-Id: <20230926092651.17041-6-yi.l.liu@intel.com>
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

There is need to get the selftest device (sobj->type == TYPE_IDEV) in
multiple places, so have a helper to for it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/selftest.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 200c88387cd1..1f2ce4ffee4e 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -668,29 +668,39 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
-/* Replace the mock domain with a manually allocated hw_pagetable */
-static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
-					    unsigned int device_id, u32 pt_id,
-					    struct iommu_test_cmd *cmd)
+static struct selftest_obj *
+iommufd_test_get_self_test_device(struct iommufd_ctx *ictx, u32 id)
 {
 	struct iommufd_object *dev_obj;
 	struct selftest_obj *sobj;
-	int rc;
 
 	/*
 	 * Prefer to use the OBJ_SELFTEST because the destroy_rwsem will ensure
 	 * it doesn't race with detach, which is not allowed.
 	 */
-	dev_obj =
-		iommufd_get_object(ucmd->ictx, device_id, IOMMUFD_OBJ_SELFTEST);
+	dev_obj = iommufd_get_object(ictx, id, IOMMUFD_OBJ_SELFTEST);
 	if (IS_ERR(dev_obj))
-		return PTR_ERR(dev_obj);
+		return (struct selftest_obj *)dev_obj;
 
 	sobj = container_of(dev_obj, struct selftest_obj, obj);
 	if (sobj->type != TYPE_IDEV) {
-		rc = -EINVAL;
-		goto out_dev_obj;
+		iommufd_put_object(dev_obj);
+		return ERR_PTR(-EINVAL);
 	}
+	return sobj;
+}
+
+/* Replace the mock domain with a manually allocated hw_pagetable */
+static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
+					    unsigned int device_id, u32 pt_id,
+					    struct iommu_test_cmd *cmd)
+{
+	struct selftest_obj *sobj;
+	int rc;
+
+	sobj = iommufd_test_get_self_test_device(ucmd->ictx, device_id);
+	if (IS_ERR(sobj))
+		return PTR_ERR(sobj);
 
 	rc = iommufd_device_replace(sobj->idev.idev, &pt_id);
 	if (rc)
@@ -700,7 +710,7 @@ static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
 out_dev_obj:
-	iommufd_put_object(dev_obj);
+	iommufd_put_object(&sobj->obj);
 	return rc;
 }
 
-- 
2.34.1

