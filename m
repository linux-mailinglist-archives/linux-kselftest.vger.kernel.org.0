Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C846C3A14
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjCUTPN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjCUTPK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:15:10 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F98DC149;
        Tue, 21 Mar 2023 12:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgBAGwKUwCPLzmIgjKp8YXFYiZKP7jLxXUd2vqMo0QyiF6JnrSYSX9aViXjEMl2K54EJ9PNrMFJSAnhpHPrgntR2qH5Mlf9t6RAzFUm/lMIpArwUqqQ+Ou3euQlr1NhCxX7f1gRySYRu4S1tHJLfzOsSXzMQUJpMXRPDqoEtsDdMvFZOzNMRtRJQ/41a7eDZZBSBVoPjlNk9YSh50wJFL6mSybnmTwWawRzFWueto5++i6+qXdI8kCzCByE3bjHGtI8CpnkuFQgsopmx2UpJCrxVEuz6CR3NFWA7yDkAH8hMk5/4s5ePxBYaNYjZ7tUoThGo487gWl931BZTQicQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4i2qdTmsjnG5Mv9SLCS7XDfhq+oZNKibEnkL4OfeY8=;
 b=d7wDnw4dpGEQlA0f0vlGBHjQR9PMFNJn4jWqB3bhbXtjNhZNjVUTW3NijFmiVxGkQIQkI9GnT6oABgvnxIG97FJ4PCcG6obiPI0eT7nsE6wx3SVB+MI69E6ATJqnIOHVnjHwZS223vuuUAtqxl3X1c+v5HrisQIuh9LHBPXfeGViLClYKMoUulTzlDy167m0dvqTMTuLRpLNDtP8doBXqCBkKS8fZe61BtPhc3lxUoDYStUKQUoqH4AbuVEvYwGkgp/mUmICPoFCsAQNAiL1yD0tfVF0PjMKqDr5iwtXYNR/RpTy/vjwTPd2z8dGQWNCnBxkNcvX/Z2D0aMun9SKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4i2qdTmsjnG5Mv9SLCS7XDfhq+oZNKibEnkL4OfeY8=;
 b=qu0HI7F0mOVxodIjqCYgqarzXqaOvSSne2OzFlNbeUUGNx6vV8fzpKxwSqnkl4w1quPL7CZmKVLds/UGRlUv3RSs485rS9WBJhSfK01LKWULCe8dJAhilui6+VVMkShgpWqUypIwmh1upLoJHmfNK+hKez6tzYxOEl8KDU84JaoCrwlS0Ms5UTCAMZuSsMRJDArxhSdNtaoVmc0V4rQiIDaO1d8lrhLlMAqYM63SBoWSdlvXL+7F61irLk9g1+n9upmfpGdgtYh/0PqamXn06qVZApVG1QChEZi69vL92383Kshj98bl10jPsYrM6yjSILtwyIoazYqWM6fU0RDniA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:53 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 05/17] iommufd: Keep track of each device's reserved regions instead of groups
Date:   Tue, 21 Mar 2023 16:14:39 -0300
Message-Id: <5-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0310.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac77414-5c82-4169-667c-08db2a408c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5X7Ao5ECJah+sNbyHCmOQjex53INfcdek/3fXhC8g89fm0qux0ABrsCQDiMbKdMKIExA9lwpOSiScqliu+PasonuOCiFIH40U/bhMepKQJbb+Rv16bu7JM5o475cDDRuD4uN8xGa1CjpiD30Etna0CgYfrm+kVCuICMn8fUTFK9XtCBG4wp+Dtipd+PKP4haZcoGHr+Wl1rwOBWzFt1Y8/TvQ+JhRYZXSajyrip+9y5pPL6tH9pXCjc83VXbyGjRQLUAhBBaGOi9IY/K/ZTvXs5xjzt66RalQukzLUjPOxIuly+73B3fz6BtThdoW1FqPGgRya/BBt4YC/da+ryKzQQfI64gkbcMrCn3FhAouqb4RgmqVwpaJtDqF2hh1+KUmH0kWNFQgzcn4kphhhLw1UH4l7Eyp2mOqzxuuX3kpEi+pOmprjRWxwuYleRdBAw464YcPL3BYsSkwTMFSz4RNhlxR/E8k9GZIj2DnA7U2ZECguSrYwkc/Vp/B77dN9ooznLvUco6+4Lnt3vlvjm526E1T0qt7USg7aHAh2scy5zRC+C/dQWj4UR/jFMztqSWQiAgNPdMI5Q43piy2QyCYxo6m/ewNPqwnYWjubgVXRvoWSe5V68YvlPdxCi8E23fSYtZru21bf1AB7ZWRKM0BqT1TQuxzMJkCGPG/178b/HpvJOj/1ZPnLut3dr+WTaP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199018)(478600001)(66899018)(86362001)(83380400001)(26005)(186003)(54906003)(316002)(6486002)(6666004)(6512007)(8676002)(2616005)(6506007)(38100700002)(2906002)(8936002)(66556008)(66476007)(66946007)(5660300002)(4326008)(41300700001)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ChjoStBgCj7a4VKahVBM7k6K0o4A2upjyTujPo+mTRPlawKEv4tFqnL/G6H2?=
 =?us-ascii?Q?fFD/sfhkMSlQjaoiG3kGXy2DP+NtLbME3XON/ieUE11zqqQr04P4YdPeNG2a?=
 =?us-ascii?Q?XWx5OMGsv5BkiuEzHyiZfqDivC9p8Iz/hxZwzE8ogxOgfK+BprXSp9Enw1Vw?=
 =?us-ascii?Q?iG19xSrEYrvfUBA/7VgA3dfFCahnRGSmKgxDOJXdXEwdX6UgCkuWxjf/xcZD?=
 =?us-ascii?Q?NnLPME63z/Xk/CODg3T2rjGqVUSTC3Y1NQfEo2xXERoW4k5Xa6Zq9uaN9o0V?=
 =?us-ascii?Q?H1whh5QSUJ2xFOCmy4mtSfOhH46fG5fAvlf3xT368qASU3nYu7ysiul276BI?=
 =?us-ascii?Q?CDHL9qtNk1RIsnnD9HOi0LxAArTMCjrJtV6XtXVFwYI6N7c1SRGMmpH7mryR?=
 =?us-ascii?Q?mcBPZCSDpCXTCtg0iPaWc0qH/EYfGCxSPuFD4f2SIEmueyawMSDtYixggK7g?=
 =?us-ascii?Q?pwpwSLoSVMHuu2ivUT2JnStUty1JaJTUf1MQ7sVO6BrYlhLPnOmgnOjTCE+U?=
 =?us-ascii?Q?MmWyWZsTqa6J8V6O0CHMY0BZem60aayDVlgmsOlqmhwvUP8POKfkzN/4wu8o?=
 =?us-ascii?Q?u7yR8P8xvnT3oCOL5DYN389tVggclp4ABy/VM+XMZaECOB/fFp6xAzYIpz3T?=
 =?us-ascii?Q?VRKQKZV6xiuvXLFW7F0uY1aJmzaQ21KXpitDgXsas2AfhOlfmO/tkZvsUiGn?=
 =?us-ascii?Q?FrbdLzp8ot5EqaeYQDYWbLr/sLkK5zGSJZsXByOydiTTmfmOxsNNV/K2YOMj?=
 =?us-ascii?Q?h9W05MfuOOUEQFYMlkEjgHyNCBX/hqVBSLZKHp7aLJu8LuBqakNp3B6q2xJT?=
 =?us-ascii?Q?YKqIDx8SnWDH6h5cxl7XEEplTJerj6sSq25K0a6bg4h3p1x9yodOvwPlt5QZ?=
 =?us-ascii?Q?BDc00EMO385r4IPQr3R3y+RqPHf0sa81E7mi1wuJVkUc29qSBGMm0fX6yuKA?=
 =?us-ascii?Q?g0EyxWtK/txMET6LWXJgaddXfVVO96Pbef2UX6pRkfTQ9ZSNiU/JiGYxPU5f?=
 =?us-ascii?Q?Hgb12o6h5WCOv/ar89F9IX6QJ+RVcdVkCBNYRHIohvycRtdPusRVxy2gE4+v?=
 =?us-ascii?Q?BYVnZhQ61p77scoIDoDVihlGflAocxNh6OD4cECC2G0cC4O6AAgp4PGX3YI9?=
 =?us-ascii?Q?kigz9yCDotijINQwzuGtTmtSNmxC4vdbpUH5Lgwcra5Bm0g6mkV58MZCuD31?=
 =?us-ascii?Q?Q6Anq4EMzfa6JGvPlJLeN9mn4EBqFsr9498KBUgInv8j/TnlKAsmGcReMTck?=
 =?us-ascii?Q?q8hArAc1EPDJf0sDJhm+zX+ueAYP2nexzeco17vJZFaGltCPGf6+QIWTRVZF?=
 =?us-ascii?Q?pg0d/UHgE+z2aNkzVu0hqfnqDAS2bmlgQhSPItPYXH/RybRUDvz73s8JqHSt?=
 =?us-ascii?Q?PKIQAugRhEoSFgMIkoQLihLZzYMJfzZehP4YMzlINrzE54Uc+fniLP1nLcuV?=
 =?us-ascii?Q?ogMZt3en4W4CTEvpyaT/7XpZ0Zw+bUfVlWmwxBUKDo3pJmt5/fIvO722FR7m?=
 =?us-ascii?Q?LT8AWOZ2GsHquUbJ5Vwl/oPeX3w3d4RLOJbW7JR5DVMru+ZX1RHp6procQhE?=
 =?us-ascii?Q?psmjtOGcXcNrKsWtQB32BVV3RlzP6bSUi/doDJcW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac77414-5c82-4169-667c-08db2a408c5b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:52.7099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RoDTMl91wgFJTqmzYy1dlv0jzQucXi1Ix6qUacdirEyZMZ+TPZ1mGBzrlgVfO9U2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The driver facing API in the iommu core makes the reserved regions
per-device. An algorithm in the core code consolidates the regions of all
the devices in a group to return the group view.

To allow for devices to be hotplugged into the group iommufd would re-load
the entire group's reserved regions for each device, just in case they
changed.

Further iommufd already has to deal with duplicated/overlapping reserved
regions as it must union all the groups together.

Thus simplify all of this to just use the device reserved regions
interface directly from the iommu driver.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |  5 ++---
 drivers/iommu/iommufd/io_pagetable.c    | 27 ++++++++++---------------
 drivers/iommu/iommufd/iommufd_private.h |  7 +++----
 3 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 66de0274d65629..4566833494e076 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -310,9 +310,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		}
 	}
 
-	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
-						   idev->igroup->group,
-						   &sw_msi_start);
+	rc = iopt_table_enforce_dev_resv_regions(
+		&hwpt->ioas->iopt, idev->dev, &sw_msi_start);
 	if (rc)
 		return rc;
 
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index e0ae72b9e67f86..f842768b2e250b 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1161,25 +1161,22 @@ void iopt_remove_access(struct io_pagetable *iopt,
 	up_write(&iopt->domains_rwsem);
 }
 
-/* Narrow the valid_iova_itree to include reserved ranges from a group. */
-int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
-					  struct device *device,
-					  struct iommu_group *group,
-					  phys_addr_t *sw_msi_start)
+/* Narrow the valid_iova_itree to include reserved ranges from a device. */
+int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
+					struct device *dev,
+					phys_addr_t *sw_msi_start)
 {
 	struct iommu_resv_region *resv;
-	struct iommu_resv_region *tmp;
-	LIST_HEAD(group_resv_regions);
+	LIST_HEAD(resv_regions);
 	unsigned int num_hw_msi = 0;
 	unsigned int num_sw_msi = 0;
 	int rc;
 
 	down_write(&iopt->iova_rwsem);
-	rc = iommu_get_group_resv_regions(group, &group_resv_regions);
-	if (rc)
-		goto out_unlock;
+	/* FIXME: drivers allocate memory but there is no failure propogated */
+	iommu_get_resv_regions(dev, &resv_regions);
 
-	list_for_each_entry(resv, &group_resv_regions, list) {
+	list_for_each_entry(resv, &resv_regions, list) {
 		if (resv->type == IOMMU_RESV_DIRECT_RELAXABLE)
 			continue;
 
@@ -1191,7 +1188,7 @@ int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
 		}
 
 		rc = iopt_reserve_iova(iopt, resv->start,
-				       resv->length - 1 + resv->start, device);
+				       resv->length - 1 + resv->start, dev);
 		if (rc)
 			goto out_reserved;
 	}
@@ -1206,11 +1203,9 @@ int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
 	goto out_free_resv;
 
 out_reserved:
-	__iopt_remove_reserved_iova(iopt, device);
+	__iopt_remove_reserved_iova(iopt, dev);
 out_free_resv:
-	list_for_each_entry_safe(resv, tmp, &group_resv_regions, list)
-		kfree(resv);
-out_unlock:
+	iommu_put_resv_regions(dev, &resv_regions);
 	up_write(&iopt->iova_rwsem);
 	return rc;
 }
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 2ff192777f27d3..22863759c3bfb0 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -76,10 +76,9 @@ int iopt_table_add_domain(struct io_pagetable *iopt,
 			  struct iommu_domain *domain);
 void iopt_table_remove_domain(struct io_pagetable *iopt,
 			      struct iommu_domain *domain);
-int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
-					  struct device *device,
-					  struct iommu_group *group,
-					  phys_addr_t *sw_msi_start);
+int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
+					struct device *dev,
+					phys_addr_t *sw_msi_start);
 int iopt_set_allow_iova(struct io_pagetable *iopt,
 			struct rb_root_cached *allowed_iova);
 int iopt_reserve_iova(struct io_pagetable *iopt, unsigned long start,
-- 
2.40.0

