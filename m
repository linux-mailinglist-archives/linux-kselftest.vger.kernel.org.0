Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6DB702F0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbjEOOAt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbjEOOAs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3667AE77;
        Mon, 15 May 2023 07:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGbv0cKqwg2zLILUjAzOlxJEZZKYZdesNQ05lOAsVxq++LuJ+9ZoYoq/oUXcNNI/jma68pPt/Vxfkgq+mcorogNqR+ZMMT0TrcWOBjSGT8Plg6baUz633qKfSXqcOQbYkzmELdJPORa+BucJbM1QpQlKpn3Ui4Pbsoel+9UhHgqahK61KAOmZ0jExlpCUC3gjmauXrXvwF+XP46hzZaiHsKKQQcz4gLJFBP1mOEyEZZ+MpkdI/X247lOUDra93bhLx8Fw7y28H2OxV8JWffAWqJR6YF9+mDRL3gfZBjRj73umP3pYOarpuXO2dC2mJMGDl5NinmB7iyNEIiPsXYGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VCjjgOoIUAeTJLGqXK8KleClOMs0lKcEmEvm9W1Upg=;
 b=RGDJ5iFM9sqoC8NtULy9Je3o/1gzsurpRv/3eTgPMsZRk9yLYeopHfFsItQURex4eWqwO/0h7gTN2Iw9UztgHwfA3Niu3z3NQT7q/v5IVWdmX1p0HdfPff40vAgy5/UP791wGMKXzj6bGMMTSV43qnJQkhAz3fZQdSA/FuU8P3MtM3C642hjkAOsiP/SBXum4Ufwp2g4WDPCN7vtYGe1tpK9+CLL4aS8pZ47fc8KfAGpuUUfm1R7f6Sk9UGIMfGQ49gKjgAb8kC0rHtLRgV5dSAci2IXUte/aiR5bDOrfhPH9T0QacYLOmJmpGP4cqtoJ4khxIrVz192OGomKfuo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VCjjgOoIUAeTJLGqXK8KleClOMs0lKcEmEvm9W1Upg=;
 b=jKdZIGiOEehwBXSEFTGEwWZyYbIzIhxA148NdxSkV9xt+diZPmi9AWbAFckdUVCn4vFwh+QxpM8j1FPVWVZerTdWaaSD8JxZo5sugxowUEQRRofGSJnd58X9MuZwUZyjh774mED+ybxUe9vTq3aF+vIpG4icjaJrASDbf0sOgUDXyCyPpqhGcC+cuRLKqBG/Suun12ybcoZKvhnE4vJBlWxlKrXdne64mo/OCEISIEuX7C+oUwkmF0OJWpTrdhZ1J0dy0VF8ebDmVfEotKPPsi5YfRhgiBQ40VOF9uBXxrtif9oBxLl8qrZUlZoPPm56EUMdbMHaW+BirkjL1Kk3qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:41 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 14/19] iommufd: Add iommufd_device_replace()
Date:   Mon, 15 May 2023 11:00:29 -0300
Message-Id: <14-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:208:120::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: c0486874-26c4-43a2-2746-08db554cc1b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Flz+s4ibNwAvJEl0mFFCpwEBCKwG5HXc9GaH5Yz7rQIOBbaN5tKZfM/guUWcPZc+LMy9hVBvOVvhS8WD6yUJQrmjRwkDPbvQg/7dKCTmhVyUc/OBsesLBjHSbq6nq6hDeaCFQfsS+a6X0SNNQvJHNyxLLOH5bT99uRyZfFd0+WNLA6yWKxVJYKQAtatTMYziB01OlLcBDnp63KIXIdufFOUFkZNrP8K2G0nst08Xdbt+JHsAXRhYzbsRKtpTRxVie545R/EKgfl4I3CczFin1tEmSDaxKAP/W3/qouhC9kMnRyfSwFRfFhOEKG1H4Z8DAvOyf+CVSOwiN4KK9WbOTCiosexWoTnsFpbOvL2P/dM10d5IPnpg50zl5BzjQuJ8jIG+r7ZbXMxhWmF+6MedIG7FQGZtFgj38ynmFEMfoKlOFxxzzVmRE3I2xeGFy7OB4eQxsODxQExUrIdDlw2wBJtz8+PDzyDFy1wlpQMISR8fEoU9J76+BGokYZ+xIe7DOnh3BM9xk0DQkuqLp5JUrwybkSAU6pewS/fgkIfaZlJrF10+2jtXXZiKOIXngaz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DMD2wm6gB8woUpYRxSDg4ep1cOuZueY039CEf7SMRhNk6h3HESM1C5AUr9EG?=
 =?us-ascii?Q?EIUePbUhM+ybebECpzCmehWlpdUXsDNKAZV1y/ZnT2VBVfP2aqOA/djMJn81?=
 =?us-ascii?Q?mAewS5xXfehQqZUHsqXorXWsisOJk81qjpYNAQ/4tRGE6Lt3xLRUyuBSzPln?=
 =?us-ascii?Q?pBlHZ/piGgSThFpbfqhJEz3TEcEXhqN80BVEn1JlSurxxc4Tw+MwhIkpPwSw?=
 =?us-ascii?Q?TQ5hW0ne/A3nvEkwhKudntnDkvWhPFP82jjWG0fUmxVqa/9z8N6stZGgC37N?=
 =?us-ascii?Q?9atCOHI6SsD0yDZqysCqk1vQDhHR5UAfK78l4EjgTJM0y+YKmJOfMqNtumPN?=
 =?us-ascii?Q?SxrMcAffPmbqyAILvtY2dAPw9WlA0Qgz7is//d23xxxxQEJAiWIZ3WhXaKfQ?=
 =?us-ascii?Q?Vf0LB/6kLNtMip/HA4buzlEQ6m2JFz82ni9Noq1Bl6olHheV7WzHvm56k058?=
 =?us-ascii?Q?3PNV36uzY/pMhTPG6IORCodxAomZw5NBUC8EG4soy9AF6nN+04QcKSM+O18l?=
 =?us-ascii?Q?AP7Cw6WMV6hapxi6LNCXne2DysNCY/J2M7HlpPDN9IMwg4iS/Jo7YYqOYJ1I?=
 =?us-ascii?Q?dtZB+iMndky2YJsDZfw49rksO9ob8ggvUZMotfIvMn82Nx3FeEDPLFAuiMP9?=
 =?us-ascii?Q?SjvIl0wY1PCvPQBeZxOZvylqx1itgrggN8HTIAt2NSXUnRz1gxriesRPGGsR?=
 =?us-ascii?Q?MnQW6NpBvNQEw2cX8JbKHN+sE1HzVCBMUV77Ucb3SVb482cHz3O6Fa0q40Wv?=
 =?us-ascii?Q?9pQZdMejKSG4lwsaCCtoPnTO8C2Ow62iFmXxM+q2rpdizxI6si7S1oQkTmpB?=
 =?us-ascii?Q?Cf3NHgGmDOkB7TnAtZH1cg7TJU1s9lQI21P1rntvbBeTVMkSeWwxU6zCmdzx?=
 =?us-ascii?Q?Q30mOfeMTuqyuMxcAsvpJenOilWcbwy7uN0vOIBqEAECARGJNEBv3RCE3i5y?=
 =?us-ascii?Q?FC/6YFD/i1XHrUMj5DrJyh0vwT5BVj9+Hl/meraBOGk3TLKjl556EM/4NgoB?=
 =?us-ascii?Q?Ir3uHTSEgeV3LJT3gR+A0ElTYm6ltWQ/5MFs80xzRhzQNH4dVIbes14WC3Pr?=
 =?us-ascii?Q?jQiBSfH+oWca3UJ5KxoS3GUtaLF4mu5tAVTccHyAkUi8QK0LSOxeSZQKVFR4?=
 =?us-ascii?Q?F42cXldh+GeQDk1b0aO30+3oT2uAtMx8uURBptdvryurvly9NiwlJq6RtcP6?=
 =?us-ascii?Q?hjWQDgMbimS+mFUTsMklqWNPzyn+Ie/PJQhTYH/g8pr83pZOXBgDGaYxVUqN?=
 =?us-ascii?Q?1B57kh6j++4LyWaHiTmqMFxQLNoNBa24PNIdyrbmmak3QOb1hdN+nm+9TVGa?=
 =?us-ascii?Q?T3/MPpMsHozf0g09GStVtftuy8pxpHZdUrg+uOJxNLGAEbKICGk+TkNe/Qoy?=
 =?us-ascii?Q?n/NkYuGKF4klMEEZbAOfu6mLc2uSJblmOGtt7DANA3n8walb83/0yy6+d4+A?=
 =?us-ascii?Q?APQkD4yo3+il3bxodrMp4nuXWtV9gZr+bfph3gmUEbiA/ClD80MdpBTzDyMn?=
 =?us-ascii?Q?zDuT2im+m6Jv6sW9mZ9suTRqlM5bKHII+CbWPzEQ+RqPPh2dBmBKMSVijU2s?=
 =?us-ascii?Q?smk7gSO2UU51GvfEIFmRrv3/6WfY2mPoiahsFzlu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0486874-26c4-43a2-2746-08db554cc1b6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:36.0864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgWgCp/d5a9l4boIKo0MrppzNim+aFNiBZxHHBfHWCRn7PTbyI5Xlgh/TqjTJLwI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
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
index b7868c877d1c1c..ce758fbe3c525d 100644
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
2.40.1

