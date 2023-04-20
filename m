Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885816E9C01
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjDTSvw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjDTSvu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:51:50 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5204217;
        Thu, 20 Apr 2023 11:51:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6q80xCFGkLfSihQcV2+//UwBktl5rTHNj/K0XN2DU413oCxwfwgyuZlF5rsjvqEM5WVryBcdgb/bWi+RfQtTYdmhwA6bSkPH/pEnh4vmlKfARfoiWshG7zMLwHwzm+flVad7sRC0+UH+++Rbv1xmaPLflZdKX1nHdc8kfwkD0hbE1V8RpHKrfUhG2lI2+XjOcOhRRILkK4KQ6o+/1UEeGRwWwxRi6XiC3qeTAkGtzCMJU3WAN3NLhCmYF2KRmSStq0gv+J/CcbyOr7qXdYI3iiHQUDMUEVJVNLOmFRDlR8UZUaqNwX5X87j7/AwZRCto/M1CjL3KW1BvXWf7T65Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SF5KYnt7bCj6mKudlspF9E+rYoi+Iwzl/TPDpr4j24o=;
 b=h+mAl5zQRrisul5+ZdQ0NrjHMg73F2X24m+bpxq+BLPqbR7ZnMvjsfkR4w81x2F3RBHv6VgN7fk884ULxUaBLQpDbYw/EfAQWUbLaOmmJHrwHP7VAgAXG755wKFyr4dfZ4E6XhuqmKBsuzN7I1LMPvS5QagvdH/vMp8s0gHNnqPdSqA4f+oFHFIpH15E7iLXr+i24bEu7N8pEsdDpuzRPA5/QxAv3CUUWpi/0usncazlg9sNGs0VXtH+dS7Ztj+LMdbCLKzI50NqJrhxkqAomNiFFOIp8UslB+/0UwDJqihVA8pYJPj55M8XPP1pAA0e6kxHqggUJUHpFHuTK9dhJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SF5KYnt7bCj6mKudlspF9E+rYoi+Iwzl/TPDpr4j24o=;
 b=DgX+JZFLV17PNO8KfVp/OPcvsgx9e0yT0M7Z2cGVq4ReCGdY5GbNIMQfqbNqXSCmq4FIWNAdTq/2k1IBPYvLiJBWUEWvi0jF6Wd8gPiK+LWTUh+aEDaCR03D2Bhxtjw0zuZDagThdQyYYvyMmMiqAmnHF9L5HxRRs1sEgE7hr6QNTvtGYdsFQO0bQHy/IdUWsNUoSyKkfhv2IOBQMcKXy1hm1Mv9ovyl+KbCUoTVLV4yzka20LcJG5rQCtpqB0IHtj1nIC3/nDMGNhGWszves/Jx/tVfNGmwvAVRUSnM5wik+GeZdcZl7cTyzjDgigInw9gkoqggnTvAnBJT97dwvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:43 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 14/19] iommufd: Add iommufd_device_replace()
Date:   Thu, 20 Apr 2023 15:51:29 -0300
Message-Id: <14-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0349.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: df914123-8db0-446b-9636-08db41d04560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FY2AMtl8gtqQgkxlLYvEr6udxD8869+tZZeC3nAH2MjvKfB8jEAJ6/Y4m00HVVYcwyXCbgHLzq+PPJAaVTjZAfcKNi+HVVmAORxVoO5e+ndN8cjFYWde04EnrokPmnlFo8LiaEpRdKVpWH5QANSmuG3HiVHEvdVasABfP0n6QgMY4g/eTgsmMj71i/6eb1aBj64adiyP+QyrUMOV55drxSxxyctfcbXsaULEALa7LC4PCeM+C/n/Ifmu5FIUpAup+26EhX2M1NxwvSdsgkKAleRguTEADpvZnSPmp1o79rs+VNRaCKSaVIt87h4BPNHpushlLz46ECpAyl4lFXt/7pijnM6uUzoenNcpVRknXnWi32VNPg6mk9n7gJ4h8Db93cZpZ38A15EaFE46fhRlWrI+8I4MfgdHByP21JnsecYGB9vxYaxpVFP39xm1mqpQzBzErfK2MtjME/HilA2/JZTIek5hHhPav39A7sR48be3obTcWYdeLDFtxStdkrUC1gHem0y6xBbPjdNX9h38J5FRmiwHBKM9QBjcBJQP66QpdaKkvb0Is3fsvc8vVwpX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+88e0oCOEgvBW5tcjJvDRGPoVZXOI8RZDqlXdcfxSbKSnjkJdnQqbjfCA4Ei?=
 =?us-ascii?Q?jFmYPIFHUbV2+vIfXZ0C4OvbwZTOv06qMOyh+ykTapwWlPZKbe1aDJG8+Hu+?=
 =?us-ascii?Q?J/ELPXLzvi5X++l7NmVAdTzR3cRzuXhCMLM7e0vamjHDQzcGWXvixbUBagZB?=
 =?us-ascii?Q?8Lm03S+cdKS1wDwAnBQaEDGJp9mWIm4Hzdl+TlqvxOeEYMV906oqw1GXSUBx?=
 =?us-ascii?Q?sJ4J9AytIO9/BLv3aIdXszkIN4fadtIFr2+t1kxt0LHxvwBZg2dGr/h73+zW?=
 =?us-ascii?Q?TGz0DxD0HvjSYO3Z7k6i9jytL3MyoRkydfwcmn1IZJo+FpHtIGtGH6+DhdJC?=
 =?us-ascii?Q?oIRjQwyHI3qbg3O9k1KVNpk20DqBKI+2/S0+v+6YZLJPecvb8fUNkbxWC3N6?=
 =?us-ascii?Q?gDZRYpA1BnSXESUm5FjYjcbm3nU1rXEo1TlfWVHtlrHvBdyZN1VeODlNzhV/?=
 =?us-ascii?Q?7/jzJRPJfJdH/Jky9krKb3wrCNN3kPICY462CpAtqiCL10561z30lvBQsvYV?=
 =?us-ascii?Q?YRMEhOo93PKXnc7FVkT7LWgHMCCnOgqrYAK4N/qHRjia7AxOyDpUaJgdQriv?=
 =?us-ascii?Q?EMz676q1UzY/x3KgfLrQY/JOkV0n7ipbrUQJqI/SFa2Y37/pkY3BN6tAJ5j2?=
 =?us-ascii?Q?CDHcwA0govIJLqM94U45+QL/txtiFzMxlz/KL1RkeYafO5jqPu1RyP9KP3Zd?=
 =?us-ascii?Q?pklMA/UOQXYcbUHJRuMrJknNQHNvE4K1EDZQao2hVmoY1KWdFB+HlKIbagPf?=
 =?us-ascii?Q?ckj+KuVrlnO1AdDt83R8aT6lp7AILUG4CIkH5OqiLMdlfThrcXy6mMw9Yumz?=
 =?us-ascii?Q?aCj6z4FKzguLRjvclS70aSrZ1P+utc12A4Zhr7wqzS9cWj9EE2Qlcc78GuJL?=
 =?us-ascii?Q?4rabm67wpiqdFt9YnxebEkK5Evr9pfh326XE/Fc1fxl5GB1coowl4lpGz/t5?=
 =?us-ascii?Q?dIGCEIJFZ8SK4o2Hv0h00mXNizXXfxfDhZuHWW3/RBfJbez4E+b2jYmapn4L?=
 =?us-ascii?Q?boN6q2xsYut3HkPdQh7siOp3mvk6X6l/EpGNYNxKQhThiSKiu4fSg4vklaG9?=
 =?us-ascii?Q?fomCBXiTznOtkZsAJSufou2JC8TkH0R+CgeAA5DWtcpla1b9vet9Y05pktXB?=
 =?us-ascii?Q?BLy9F3nzYfArSSBOwg5tH4/9H9HCVoknoqjg9pzrAPq1tGps8vrhQhvRfrrb?=
 =?us-ascii?Q?mvQFvnMtvl9zEx/uno6ghX/s+0NSD5ECWrSGM7j843vNZb9MttvTUslMS9P0?=
 =?us-ascii?Q?kW7BpF2GUdublXHThAiAYvIbqOO1V2F5wETMT9BQuXQ982w8Q1HCRoH/G99P?=
 =?us-ascii?Q?Il3t83UNRHzNRdweGZCAV6gZQFBm3tWP4AQBfbCMxK5wJmiitZLCsQjQBKN2?=
 =?us-ascii?Q?1iDXM5aCAQe+5N4zicAwHSTR9XRFn/yUjLTWwPeqXvFFnzJXkpMzKAWRxHFw?=
 =?us-ascii?Q?LArEvE3JwGZvEF9/qev2QBnUE6x0XuFP0gLqGlSE22nOsU9G2BmSKvA9Uysn?=
 =?us-ascii?Q?mbDZuCsY8dlhX+n3KJ/Ys0/nCILCH4j5eJM5kFFK4XRnw82/wV9NAI5eIn8F?=
 =?us-ascii?Q?+Txgvwc/yYwrzbbVVMqdoRipC/1sSBMsPHkiEdtz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df914123-8db0-446b-9636-08db41d04560
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:37.8042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vznd5e4K/ahOa4fJ7DZ1Epd4pkmMaILcSSH/ojdSrSGyT4HYYzUVozd3sGtOrRPJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 99 ++++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c   |  1 +
 2 files changed, 100 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 9d61a62c4be067..2770087059ba73 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -4,6 +4,7 @@
 #include <linux/iommufd.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include "../iommu-priv.h"
 
 #include "io_pagetable.h"
 #include "iommufd_private.h"
@@ -365,6 +366,84 @@ iommufd_device_do_attach(struct iommufd_device *idev,
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
+	/*
+	 * Move the refcounts held by the device_list to the new hwpt. Retain a
+	 * refcount for this thread as the caller will free it.
+	 */
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
 
@@ -523,6 +602,26 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
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
index 24f30f384df6f9..5b7f70543adb24 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -466,5 +466,6 @@ module_exit(iommufd_exit);
 MODULE_ALIAS_MISCDEV(VFIO_MINOR);
 MODULE_ALIAS("devname:vfio/vfio");
 #endif
+MODULE_IMPORT_NS(IOMMUFD_INTERNAL);
 MODULE_DESCRIPTION("I/O Address Space Management for passthrough devices");
 MODULE_LICENSE("GPL");
-- 
2.40.0

