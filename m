Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5166C3A1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjCUTPU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCUTPR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:15:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB9D2279C;
        Tue, 21 Mar 2023 12:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDxSf+GqeSVdrlMLafMSW2XxxcKPWLTc9tv1aBkOTYygFYOtMDu2NFex0xLPGD6+xvjICImleJFy4SMobrqn4UEidBHAZmLfvaRDIczZmkSuS828ohKGlrwy/Bv0uq691vA7tFSdATvdtQrW8GtHzDK85WzBbxk4BTXlQlDnFXM4AVVHEZYP819aVs2zApVuArY3oVkV2vcYXmZCNnOXa+WMf9CPa1PwofrJP/OZpOQPBrrB52JZqgsJq1gTu5/ZgA6OW0nZL9sCKnA4MmARi+qhBlIcnU6Tsx3yvtWTEsV++vTG2qE2MM6docB37msJ3EJBD5vsnTND70y+IwfJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+h3kZdIJ+769AlvQWmk3zX28Ru9zTPW+EQWPQIAowA=;
 b=YI5iVA/CTch3DN+VhepAnTys54LU68zE8xIkT48WS7FeOpp4gNmjbDMezb8pmh+wsfs4hedEZh49rMAPLGMENko5eCilYDFeXX6Hlh/n737MxPvkT6DblptGW1Ib1CyF8w+deXUcE+RLx7E5AdmS949GYJlWyR/Gp4n0lBjIs2tK/VWZvYkWhxpAw/hEjqeiJcM24BjVDuRl8XRuTRKO+ZhEISZlZcEIM6clfXx3RWf3a/s8vSRWxpHv+TJhKDW8RipqL6T+z7nQsXzUhJjK/8t2+r0/dIwitx1deeOiL7r2taug30N3YFmc4zX/m4HoliBk5R9o/36V0NFnCFsJtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+h3kZdIJ+769AlvQWmk3zX28Ru9zTPW+EQWPQIAowA=;
 b=gquVh3YpteGhxgyn/B7vhn/uTH+SIYXk3CU/QrbjOhk01U+ZiYzgi5jQjxcwjWtQKRWUbC/Sxzk7GB/eTDrNKQdvSqzqeGC1CW1NyGyyUVlIsm5HCqiUNxRcUIQT1nnw4HUU6NRX2ljHKBJAXarxLYjPKY4MNsatUkQrVrtW4ebQTRgNmLCT2Z6L3C2JDPo1S8T2ECWvhYdPZ1YInD3d/zTtiy2UQJVqWCquMm0vrjC2DOBfnpy6EIVc1axiL1bI6WbOu+myhKjLe3InqpdrY6+4j9q68MCN3g71HWSx5Lp9Sg1LoloG0R83VZEZWrZ5BiIXBh0NnouQfZnOUAJhCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:56 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 12/17] iommufd: Add iommufd_device_replace()
Date:   Tue, 21 Mar 2023 16:14:46 -0300
Message-Id: <12-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: c0624c8b-ea8d-46de-9c7e-08db2a408d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngBj7/80TyrGSKM0hkqP9fWe8uET82e/i4cc60ncaVANUCNBUsi4f2X+eDajyM52wIgoOyzv5jsASiT9dQ7rfzfe/Do3kbNOarJ61sf8TNSgk44s+8oR7Cx+FRsGptPMxtY2BHPilHqCELEMQBTb4s/XGUWk1WkS8RQq7Bo27jU6jP5JK17r0Jh6smCqEMmAKcZ+u8P7Hk4UyvTRzp55C8mJ0E2zXVj3q+l5eX+fVJ0CoNtttQhqx7JXBvHCLO87Z3bs7L78sslk/jPMpp4PvI2GvqTKh+wDwRk8A013L20IElrTwY3thHRNMIvmRinCCOAVRTGd1l1a0RKBRKnKkJJv1DTnUaV7tDzONoMfas7gwVJ7qt9oCwFlMpyNCpT8M5Xe9zgk6nT2fCDb4SMLjWKHbRtdNO6P99pMkFQcXmk09aIexgY34ixWLdV6sI8ZYbCqLl81t/NhOvEdetn2zbAVT9GiD3RwU09u6sg5e3WtF0g0Jij7Zqv4b6jvuCBdPmSeValj/1smCmmg0vkHNX2zKFgKT1sa04+/TzoBbUABAUw+j+jZYUJLe6gSIqcLOs+QNPUGfupc8W/39RkGcaRjxu57kz6858jx+vTOJqv5fR/ryJ/vrQNuinfs0UWoTm3JIkFu0nbi+tWRqiZqRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199018)(38100700002)(36756003)(86362001)(83380400001)(26005)(6506007)(6512007)(186003)(6666004)(2616005)(6486002)(8676002)(66476007)(66946007)(4326008)(66556008)(478600001)(316002)(54906003)(5660300002)(8936002)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y+qvvIPbGyNQvK602gwgdNeXe8DWR6NWJKHcZraWORqT59+ZwT0596m3YiqQ?=
 =?us-ascii?Q?Ihs/qmhHJTxMcpSZUR5IoPDvL5/nNC6+tWp3l3mFLhdMdOa9TNJj3g2sz3OO?=
 =?us-ascii?Q?wDj6c42wAESGn0bfcDpkXnNg5U/xSoJ6pcyiCYeRTgmg5MbgadDuMF18bWLU?=
 =?us-ascii?Q?Gu6y3Kwmt28w7329sH/0bBuSl+g/8y21/lhxCavNeUQmlxFubcxI8LrLWF7+?=
 =?us-ascii?Q?PWIplMVpotkX53ILX9TSg16m3J/Ww0o9l6zYdvPehg4D9zIf0yx1T6rxOl7A?=
 =?us-ascii?Q?tg1ZXzCerssxyEtpt4vHXezVAQsY4/+HKAyt04MNwTrrsmGE/07fwl1wXBhR?=
 =?us-ascii?Q?pGLWkKMWqWlqvJyCvsjGU5IzlREcWfyfaIO6yXCxOECWG/+XaHWfHC1YxSR5?=
 =?us-ascii?Q?UzlyLBgNi0GaC7LD3iQYRZ83K+ARcawPCLMvQ8F4qyzuVZgjtL1t6l+9QjkX?=
 =?us-ascii?Q?hCvqH8N8rgmSig8manhmv6IabR+7uuFr1drzZuTEgmZmvYKECuBOQmW33IGM?=
 =?us-ascii?Q?mHJPFb6P2O5L1RKH3D+9rkUJmsb/lRGEvvGZiEbpAKTXnsI/EKajzn2HWIxv?=
 =?us-ascii?Q?ksH1+1fgmhV7h/+f04J8D91/P2CMnUc/mRWRDJZ2F89er39sEk+bY//cMQDR?=
 =?us-ascii?Q?cjmkMcHySyeXdwj7jftOxXMbYYiA57sVYHDSwz0mzwiU0OncP6ZITzz+rdfs?=
 =?us-ascii?Q?YbqbovR/t4Iw1Un13Ig0zRyJAp09LKu/SanzjZGnP2VMgJjwjuU4xgKXdj4C?=
 =?us-ascii?Q?ZYPy+Atw7RMhKvJGc8yjL5Yqg0NK4XdAB0/HVMisrey3ORiy3GiEQzVrbmK8?=
 =?us-ascii?Q?0+9OUvXhp0QjjYpi1pkpejW8O4aJ5C4LH8qPd4r+YhsfciMSEq/Hr4IgdW7r?=
 =?us-ascii?Q?07xIHVgyzgHLGGfonDbCsn2NTQq9u2Md4Wt/1xQB3o/EBZv43gfDUtkSgg8U?=
 =?us-ascii?Q?6rido+A8TUBGWLNOFQcf3UeMbLbsNpS8Ow1ps/EKcRP+hrhD3p0u8l3B4VWi?=
 =?us-ascii?Q?swCeXvsyQUv4by9Z1YSb/Jj+LXC9BXh/NS8f48J9cujeW6YMl1R52CjcVXrJ?=
 =?us-ascii?Q?+U16uUG9VWyRTX7ji55acpfVdyY6Q+fgYZ1laI6uQnjF9GIjlQMgKf1cfOWE?=
 =?us-ascii?Q?y2FfRm2YaBZ8ZmGdl8d+bRW9P/luKjN7sg7o6cSKsZj2n3fF7Rc97bc8I4n+?=
 =?us-ascii?Q?ShItKGKtvqhOvP5IgKlq5Ek4Xl86FABQSu4Tg867E+cCfm2D8oBc7TtaMyb9?=
 =?us-ascii?Q?Bc/qxjjRGIbQojFyL0X6ly6rRDOY+d7Y0KLjpFl5s5tH3WIQZTJBnT5+W5uK?=
 =?us-ascii?Q?PXi1CADdqMMvsMp+8H2uAyD0Y9IKJF8UTSVDtXTlnSh9kStEikMyK4aaP4S8?=
 =?us-ascii?Q?v0aDMXnN+ezPavi/EA7O+gFN/QYWUKOq8jPpNgj2bt46e3mPmohLYC38sbIo?=
 =?us-ascii?Q?8DAMq499UUdYLxOx8eNZFGgCOYPjpB9qoeDCjFkEcYEqCEcFsqeNgIf2fDP1?=
 =?us-ascii?Q?kH71rAWGnLBNrO8bWbS2MFEVdhebl+KClJI7YuuGEETJrYieJuvjNEwlcCuJ?=
 =?us-ascii?Q?Spxtp28hsmNZm32xZ01u7q3EvJ2t6YPOsLliSGPE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0624c8b-ea8d-46de-9c7e-08db2a408d5a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:54.2574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLj3h2Un/g+gj2EQksGBR5csdUlp2RvDcjccDCkNRqs12aePSECNy9uJ70JowE7m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace allows all the devices in a group to move in one step to a new
HWPT. Further, the HWPT move is done without going through a blocking
domain so that the IOMMU driver can implement some level of
non-distruption to ongoing DMA if that has meaning for it (eg for future
special driver domains)

Replace uses a lot of the same logic as normal attach, except the actual
domain change over has different restrictions, and we are careful to
sequence things so that failure is going to leave everything the way it
was, and not get trapped in a blocking domain or something if there is
ENOMEM.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 96 ++++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c   |  1 +
 2 files changed, 97 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 40466152b68132..5b5c2745b4a088 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -4,6 +4,7 @@
 #include <linux/iommufd.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include "../iommu-priv.h"
 
 #include "io_pagetable.h"
 #include "iommufd_private.h"
@@ -360,6 +361,81 @@ iommufd_device_do_attach(struct iommufd_device *idev,
 	return NULL;
 }
 
+static struct iommufd_hw_pagetable *
+iommufd_device_do_replace(struct iommufd_device *idev,
+			  struct iommufd_hw_pagetable *hwpt)
+{
+	struct iommufd_group *igroup = idev->igroup;
+	struct iommufd_hw_pagetable *old_hwpt;
+	unsigned int num_devices = 0;
+	struct iommufd_device *cur;
+	int rc;
+
+	mutex_lock(&idev->igroup->lock);
+
+	if (igroup->hwpt == NULL) {
+		rc = -EINVAL;
+		goto err_unlock;
+	}
+
+	if (hwpt == igroup->hwpt) {
+		mutex_unlock(&idev->igroup->lock);
+		return NULL;
+	}
+
+	/* Try to upgrade the domain we have */
+	list_for_each_entry(cur, &igroup->device_list, group_item) {
+		num_devices++;
+		if (cur->enforce_cache_coherency) {
+			rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+			if (rc)
+				goto err_unlock;
+		}
+	}
+
+	old_hwpt = igroup->hwpt;
+	if (hwpt->ioas != old_hwpt->ioas) {
+		list_for_each_entry(cur, &igroup->device_list, group_item) {
+			rc = iopt_table_enforce_dev_resv_regions(
+				&hwpt->ioas->iopt, cur->dev, NULL);
+			if (rc)
+				goto err_unresv;
+		}
+	}
+
+	rc = iommufd_group_setup_msi(idev->igroup, hwpt);
+	if (rc)
+		goto err_unresv;
+
+	rc = iommu_group_replace_domain(igroup->group, hwpt->domain);
+	if (rc)
+		goto err_unresv;
+
+	if (hwpt->ioas != old_hwpt->ioas) {
+		list_for_each_entry(cur, &igroup->device_list, group_item)
+			iopt_remove_reserved_iova(&old_hwpt->ioas->iopt,
+						  cur->dev);
+	}
+
+	igroup->hwpt = hwpt;
+
+	/* Move the refcounts held by the device_list to the new hwpt */
+	refcount_add(num_devices, &hwpt->obj.users);
+	if (num_devices > 1)
+		WARN_ON(refcount_sub_and_test(num_devices - 1,
+					      &old_hwpt->obj.users));
+	mutex_unlock(&idev->igroup->lock);
+
+	/* Caller must destroy old_hwpt */
+	return old_hwpt;
+err_unresv:
+	list_for_each_entry(cur, &igroup->device_list, group_item)
+		iopt_remove_reserved_iova(&hwpt->ioas->iopt, cur->dev);
+err_unlock:
+	mutex_unlock(&idev->igroup->lock);
+	return ERR_PTR(rc);
+}
+
 typedef struct iommufd_hw_pagetable *(*attach_fn)(
 	struct iommufd_device *idev, struct iommufd_hw_pagetable *hwpt);
 
@@ -518,6 +594,26 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
 
+/**
+ * iommufd_device_replace - Change the device's iommu_domain
+ * @idev: device to change
+ * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
+ *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
+ *
+ * This is the same as
+ *   iommufd_device_detach();
+ *   iommufd_device_attach();
+ * If it fails then no change is made to the attachment. The iommu driver may
+ * implement this so there is no disruption in translation. This can only be
+ * called if iommufd_device_attach() has already succeeded.
+ */
+int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
+{
+	return iommufd_device_change_pt(idev, pt_id,
+					&iommufd_device_do_replace);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, IOMMUFD);
+
 /**
  * iommufd_device_detach - Disconnect a device to an iommu_domain
  * @idev: device to detach
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index e5ed5dfa91a0b5..8597f2fb88da3a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -461,5 +461,6 @@ module_exit(iommufd_exit);
 MODULE_ALIAS_MISCDEV(VFIO_MINOR);
 MODULE_ALIAS("devname:vfio/vfio");
 #endif
+MODULE_IMPORT_NS(IOMMUFD_INTERNAL);
 MODULE_DESCRIPTION("I/O Address Space Management for passthrough devices");
 MODULE_LICENSE("GPL");
-- 
2.40.0

