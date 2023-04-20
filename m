Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13436E9C05
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjDTSwW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjDTSvx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:51:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B5D30E9;
        Thu, 20 Apr 2023 11:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMTLhMsMndJ5UBeysqYYSlE0PsXWW5gTT+EyiehzcdIAffMx2WgHezQ3RDmNnAzFjw3yfRQDGjk5YxY818Bf/cmSFJ3u1agi/t24H/4exUl3CQwi/OQOZurEFILtAxX1dP5vgK6xfoLLfv6yuktAQ/PYJpApn3gWCkn0kNjUyaXSVgkb6pP1V8VIijqG8p6iqz1Phb9dZumPeF+BGwe9/XvmMJwu+yNhVwa2leQ81fF++DLqbPahfAvw46prw7wdPtjoJHJtB/fTqm1hbxT6BlKWiVh7aYzE55K5TRl9Q/hT9zlrdk3pT2/ZM0jFSZT9/KBtYWAz6Apx99Y+y8Ftug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PotPaQfPH4+45IYRwWk4PvOt5jfLt720n3UICRNI6Uc=;
 b=NCGApNXxwqS2INjhOl7Ct7tLab/aTXCiKWZe8TWoLjq8Chxsyb2eEYU9pywjlJ7I+f3NFjgJYP+BuOrd5vzOGgVo1nIdtlRo1FKzdrvq9YAtbW9FzcgcRxmvTznuG5rhdbc7LfySShv/HGIoUjTrQJ1k+U2jfBTP60xioUTI81TcvdDp/EzZU4lWauuunY3rKaNyETD83W5SnYTV9PBsc8w4rTBdyEAjjgXOeA7HaoDQlaFgyySyKMXjcaTR5y2L+vxESRNgibnpgR1EnVu+JRmylVFszQnWv8eQu93gDY1cTIdy8vrxAFo/p2ccWMPkIKBNwESKILLzDZyaGd4WXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PotPaQfPH4+45IYRwWk4PvOt5jfLt720n3UICRNI6Uc=;
 b=JrZhBSlojtgSxfaHCaO54tvC+XTcNtaq91BjXziqflzw9GA5gMkNejeUwKaDRUMNFruxKkLXAlwzGfhJ2LFTQNv7ZfIGEobPoGlXXy0SQBLOfG8DR7OWYp6BUKRwXRRzmQRsch2Hnyd1tOBIohymbxQRLNLaJ8BlUYfGijWKlNokRJRpplUDD9q9tJu8PiOperlbnu7rA+End9kRIz6jtPMoiDaq04q6nzjQQ19wTV8wbreiq3ZNcN7s1bh9tFjMAw5pSoI5gRk09ot8GYsACBZpdLiKyTPZ3IKVY95doEyMSJiWHzz13ayVWTNfNilGaPt3YXdQreCXO46P7LqXUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:44 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 05/19] iommufd: Keep track of each device's reserved regions instead of groups
Date:   Thu, 20 Apr 2023 15:51:20 -0300
Message-Id: <5-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:2d::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d2774a-1bad-4600-3128-08db41d0457d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApZKffhTx0UoWfnCM4T/OQXMwLs1Lvc8UqREuXSvEnpD/ZOivlJruAc5fBpDi5totLUfQNr4eI6f2TYVSvewP0TFL4TsM6MNeIPyzBZq/J6B8Li10zR/JXTxouJnGlcRq06HprUxHrEdl22cKT79/rbLjbefFtgiqGJQsXXW6mmV6592vsfR7l7V7HriR3DYd8jgizXQ2DZ6yt1gUp6L9Fj2X+TdzE9dagAR17n3jj2ffIhIBhSYYBh61t6fkXqV6hB5wy4mgIhDd5MpNGXOXvC7LBlm+yDTTN3LJd75J8eARfhu3pj4AuXW1AqY7CmD804PQj1BfMxZyL0Bk56H4trnZpTQ676f/bxXsiDuzr5dNuOTy+wiWpO80QVte0GNd1IRsm65kihGQvycx3cEYPCCaCWHObbbeSRezG/SXyTFNecYiso3YCTkF9jdJZ/d89KpTf67/TmPiOiJHaa2vMiCYwOqXTbcSeOyLHnYWGr3zeL1Ue2mRBZrZDJCVndicjezXntvlrbI5iQeDev+rL9IjMoUrg+3ufllBLIyI/o5HmarLPragknhTSeKeJ3EiDoy+ZNyk2jnVtTSJ0jZTATz/W5Y1Dl+iRGdoLUEUDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001)(66899021)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cr6PPZVV7aRwlk7LZW63TWLq0QycZFsmqQTxM63rfHdasaJh2TPCKpZnt09g?=
 =?us-ascii?Q?eG+qxy3tvZJURwguLl99H55evP2iL9+vD/GqXrfJmOg3zf4RdK0NNTDNDa3t?=
 =?us-ascii?Q?9isR0RBAhlC0r00dgfs2vPmLkx9bRymqSWa32gvgovOxavrFBCXlTyS2o/cW?=
 =?us-ascii?Q?+goOM+bg99jtqrSGAWh858t8VO+ppDKd6o4IFTN8Q+bMIcHZPDskdenck5cV?=
 =?us-ascii?Q?pUPhZiex0WuMtP5C4xT3Ma1AiodEbGw875trYbpLvJv3h/WEPASKnj3rd05r?=
 =?us-ascii?Q?+qlLDalvSYxynDXlew/fJhqWNRcL2f1rfuVI95vmzSWPTCElZtop9O8gMvCE?=
 =?us-ascii?Q?Bn8qZOwhPmLciWuS3fdn1B+mV5x7sEr4ILTl5QK8psm2wLtSqH20LiHmK2MR?=
 =?us-ascii?Q?RFjx1dDOJfEMbVgw373qMA4DmJ6ttaXwzJp1cAwHcYOkrnrDK964foHpa4Cn?=
 =?us-ascii?Q?FQHMLF25TNDbcRl7OibGFdrLzGPd2QfXQF0SK4s/wq7pCf4z5eq4dtvSaM5U?=
 =?us-ascii?Q?jXzq/4t6ar6KTHbQ4aL480GtSbJKBY48yxAEBmR/toOgCc8BIPE8HNmEpLvL?=
 =?us-ascii?Q?b2s0zLAi2gHnFB/Qbc/ZDgx89ETxHQep1BhdkRA8UXc2SsBMimfhnV8EV4W0?=
 =?us-ascii?Q?vbjwn9u3AKCJmhptBkE/BLIa9nGxlflPeOxRAXBnGi9gz5UnZ+IOOKPeK4Yg?=
 =?us-ascii?Q?M6/F5M3AJ1DkTVeE3ngdTwLPGvBt0dNZPZkXTZ/f6MGBp9uhDQyIa92Khlhn?=
 =?us-ascii?Q?sPSBSfwVQn8OAX5yo+a4KiP6i8XJSsIKqToCEtxIy88ILHBKdTh4BW9Z+bb9?=
 =?us-ascii?Q?Z+udoZEn3D7+pcWR1+j+qsubGM33kKlcXWwuWPmA450CZVLa9GKj8htlwPvY?=
 =?us-ascii?Q?+TMfkY74cBHYzI4UtdbqFuKkSoVO+nEs1WT7NJ0h+9OgqXIhl6dZucJJ7Uoz?=
 =?us-ascii?Q?sH6XBGiabTR5Xy22j6IBLEs9O2RNXogc4Mr57eeHGvY/UlvqJcmlVhR3bkze?=
 =?us-ascii?Q?jRHSeqnKvGEu4rdnGPiXteSJW4T/uGcOKQaq1jsSPj2H3wCIOXvJZxN7yDuC?=
 =?us-ascii?Q?Pg6bNZCGU9enoCObNUxDxiOgVXL+iZchjsJz5DXo0kJU82+yO83vYmqz+ouj?=
 =?us-ascii?Q?hW2ViVOrs0C15scFheKXUXUJWwuxkdMFZML6k2/slTcoOiFeiA7ZYEGmc+IM?=
 =?us-ascii?Q?to5eCj2n0OpHbUXiJSd0CkaHnPiwykoAkLJgBs5d3DtcCGxQG1AvDfcHWEPu?=
 =?us-ascii?Q?6w2XbTZI1dWPC9X/AzgxZkiEQulS04LF/k/KzMNfWOpQzNwI36iCmi8f46+R?=
 =?us-ascii?Q?Vhi0t517arn8A8IHxlu/+I/V01BZV9XDBCI7nmcR8tJs9ltSUC8t2MXP7tfQ?=
 =?us-ascii?Q?pHiQwenCE2Fl27K6sAtg5PbXFjhrve41QiJCX5RR14yr1Z+aBc8eb1HzPJYQ?=
 =?us-ascii?Q?3o1TRnd2oV5WiFpjlSetYglsYEvAKtUfMMQj8niAlkwZg9DFRed0ubWf+1sT?=
 =?us-ascii?Q?RbgG0BKl4paUaG7+tvwROwUPidEtxeKCEgx5bpqn5lc/NooFKqFJuSP02Phv?=
 =?us-ascii?Q?Z0vJV205yJSHEzIWUIp3AW4OdsZgqyy36bUF76oC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d2774a-1bad-4600-3128-08db41d0457d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:37.9184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bq6MfbWUEf2zaRk6wpDidk/nIiWv2rP7TpIaWGEFCX+CyqGtx4FMrT+4M4WFHPGV
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
index 33f9ab2dc5f4ae..6836089e62eea4 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -313,9 +313,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		}
 	}
 
-	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
-						   idev->igroup->group,
-						   &sw_msi_start);
+	rc = iopt_table_enforce_dev_resv_regions(
+		&hwpt->ioas->iopt, idev->dev, &sw_msi_start);
 	if (rc)
 		goto err_unlock;
 
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

