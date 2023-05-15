Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68DF702F00
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbjEOOAo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbjEOOAm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2423D10F3;
        Mon, 15 May 2023 07:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdWW4fGq4c90T+iGo7HGHf+r4rFZEceCyE1fYLlaB6hLb/2+MoXxjJvACURGynVMrM36YB9ncTFYf/tc+/GFplwl8dgSJJElgQ8n3KzfX9Z8zmu/A6f/6ZYYI5uifDHScATMNMIu34QAe4nQv1peSJ1bnBy4zepAV2ZAUQjNoAdupIZ8IY2W8oLlSiP2LM48MNsmcDEUrUoiF330AiiMrdIu0EKupO2MyMX0JEt0JDJXEQt5Pjn2BYGabWRmcWMJDoUpUDqBexS2nKgGfR5OSXjF/qUlnYwLYCVM7O4+kJ1LOHQqSI1fRTOu8PtRwxQBsW/nsboq03/6hUwkiJlq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfX5gH6CInzmht+WUqgUOpAiEksx5FbZDNUMJEQGNJw=;
 b=jJb7MFNVUDWchhkt2nRYJP55OFjes0pPmErscQGKRg+O+7ohmOrVb6H+4kvgqkIuywIyeKa9i1dbkXqqNrdFldq5w5ic6PN3E1l4RGZ2b9100fdHtaGtK6qH878lG0TjaH05FpBoGDftKllQaJwQp8K03E4nF7F6UN9F2M9X8hCfJ8H9AgT33cRXx1wpLf/ZmtPvWnsy41qEgRlLxBITvgB+Hy4hHU3PmIJGlSsgzSnvVExyQBxDkzAei5eOtW/zbNj34ZwLnsT7oaX+ZX5caVvcGFBSTSmhyAVo+Y/wgEM9PK/pE1SWjiicdpLO/MJFehvRZSzUpWzCcJH/hAYVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfX5gH6CInzmht+WUqgUOpAiEksx5FbZDNUMJEQGNJw=;
 b=DAr1BOYnWv6inast1zqbYFg6FLyL2JQTFYPePiMw/IIPqfQj9mcxIkHGDtf3xgcgEQBUvmZ5K4nyf7ByMG2pne49FPztwJTK7A/1t+P9nwV/9cDcyZx0qr7CecwXkbr3D2W1EnuewdVFVubWiDA+MxVOsSlyhZOTaNpDxgoYqzLdYnacQkdp2cVkG9jMpl4cAhbV8EhfvwuG94d+uX24cGhqmTi/D20JYQ5OlBLiiUAH5sVL+nSm1gmVcBzMDCXWJySfaORsoDfjEPXnFCmS6mj8HO0ouIYGa2KNNFkshn497aHnhHt6GjPx+BZkfIEGDiUDg6Va7WS9hrLAAL+xhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:37 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 05/19] iommufd: Keep track of each device's reserved regions instead of groups
Date:   Mon, 15 May 2023 11:00:20 -0300
Message-Id: <5-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:32b::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a3c00c-4363-402d-e2bb-08db554cc14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ph1isbtj9enj1Wo8B+pgsW2U9pmyL2oRzSblVCc9xua3q1Hn+WN3DBqvFYeeedGji1ny/8G0VmdQIaMPEJp3S33mkxciYia2UbU6jwIG0nM/PXPP5s9/xLuUGCcv0juO4THPzWBsQgb8KnbMOx3a3oc09Lysn8+E3eBAY5zPPBYyUrC61GS577I+TvtzMuDASy414MnRT96Iab8OU7OL01kdlnybYgA3bH2D+mrzhKdONjGKhWbLuRibBYgE8tT51DV+3La+VU2IVxoJti1KI3XQ9d9zJhzuyqwd/LWkOpyzgnLVU744k56b1YU/vyadzWh0RgyBHzJFzNddIuYjcu4uJfP2Ov+BqrmNKMMq9ahp5EL0U6K2iub2LpYoZmluswYRnDQvmILkz8X9fvcWbsp29f4n5DGEYknqDiztjWxK0+eW5/7XdC4kjAu32ET6+U0XebYxXIsnTeYb/bcyn9YcKdGK6MHubFuc9NEUzpVUkT0s0UrKHfdVIFMCeQNm86oo4UcFNVRkct1rqqa7atQjNukw9mb+0NVLMSX3NEwuq33GDLnVlzy5oohA/HVLlaQiMtRGEDDWsQKj6o1qW2KzaM9+T0ByP20uOBufODo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002)(66899021)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GnBbKIC+47QYXIc4o9KEzxKC5SZP5cH7k3qvn0YDc6ybP7GASz/vvuGd1+ge?=
 =?us-ascii?Q?Ch8DBtinCvfk32mkMxlnNYGD20P/huXr/CVi7HYxe/VMSlXZmQ8NqoC+kBKn?=
 =?us-ascii?Q?KBgsr7gnwGkzSBFgL+ge9qQF/ojUxyAdvbFgL6L4tcX++gf/Nz+jtSKweZKG?=
 =?us-ascii?Q?yVYZQ5sfrNAFjhp8G89HxA8jkYTzMSv5XdYYeSmBx+jJP2Aqh4fSK6/NQnMF?=
 =?us-ascii?Q?0dKrUYDZK3UUfdc5K2vxZwh9GI/5R7+nTvNDbrp4S2VNss2etyFmMHBSW3Vx?=
 =?us-ascii?Q?WCmRY+OzqjazZzkyKo/2DN89tN8y1qXPilPqOR57JQSp8Kp0k7GT6Tege7jA?=
 =?us-ascii?Q?j9YRRlgQGpfy3pWxzejNFeLWwSR8WUk8pbWpshbIOapC8Hg8qxImK3zDSQyK?=
 =?us-ascii?Q?spGBCjOI/FNZgV4cOuRsERB4i5+kfXivgnlKdmypUDrknkbmLdNG5eIRXAo3?=
 =?us-ascii?Q?zX6SMlQEWvFitWxV3Zhy9nam3HEnUtiZvcsv2EnMAkAYmLbagcOg4iFplKzI?=
 =?us-ascii?Q?2uC9g9HCS7CeGbRTql3UAbi7UE/xUovicBgLytpJ/g8KvaxLJl7eK62SjJoO?=
 =?us-ascii?Q?J9VxqQfkkvoHhbRyKbq1EoVaEpiQX8EHkIDrRd8lk4O3ZcTNTdZhZHbrqm+5?=
 =?us-ascii?Q?+G0npvrRr/0KifR40+ejFrlBnIPswnf+h/w2K+NxyyjRgGxxu5wvBlhNlVs1?=
 =?us-ascii?Q?lIkdNI3AwN7qYeA2mfL5LsADBQfQMug+P03IcgF8BLEw2C2C2WWBCE+EMVit?=
 =?us-ascii?Q?zLvFsBma/5jO4Thgum1GGSLx+LtZActikjR2Xa5VJILKq4sLvYdhVg8uUju3?=
 =?us-ascii?Q?kc6pMem7s63yt3q01NBvAxNottP8oTWMe+VQVTMNdP/QLwZnvPAbb/bs4NCp?=
 =?us-ascii?Q?IdMIggH5L0GNu5mDT0cGW4tKAZJ+hvX1WxniXVXz1MCbnthO4ZK7aJ13cU3e?=
 =?us-ascii?Q?/X8kdGgrX6xB/KkPlwV8molCY4CtBFAWkI27IezHu1PaeMTyooIvViEXBAFy?=
 =?us-ascii?Q?bcjxGOC+kT8azJJZGv7tS6p1mO0YlETWAWDv1zHZcH3WxpUePkNgnnADnYWh?=
 =?us-ascii?Q?n+4UCnafHn2fQta1V42B9rHQZJMXnWt4QTbezd0CZeXMG+zaHmy/gbiX8OTq?=
 =?us-ascii?Q?J/2Md5bsQL65GjdpGhg0Y7ZqF93Ja2y+fltN9wE+DoYN0+OvEtSylf2fhWzy?=
 =?us-ascii?Q?BvzJIBBtZ+MBbvkQukmOHZKmh1idMxuPwpJ/r9QNdpmMZy2VzE7XQ5Yee3M1?=
 =?us-ascii?Q?XwaREX2bC01WVA/o6uw07+I33BA44vDXVgPL8MKG/HrNJLCv7Bs2uMeAFBVM?=
 =?us-ascii?Q?UwShnOFasnRWwOse7DI5w7TZ6yiWe9EQdaIoe6yN74cG1d45ScoD5Ly4l934?=
 =?us-ascii?Q?EKIpVkEWA88ZicHyK9gSRgpkQBojlJVDK7dn/P7AW8tAy5rPhcJxVRteYYu8?=
 =?us-ascii?Q?9j6AVKuWn2xBZMg343y9AGQXBRxDQFfFwCW/pISYKBLPZNmmCXLl4Q6VXohm?=
 =?us-ascii?Q?NtKc5Dhsl0p/oVIULSXwFKHKlWpLiBFjwFsKcEWG6Upd4CYfdh9BfpOF0iAl?=
 =?us-ascii?Q?JDhZ2dikTZ9okSO9uHQmFTZ5dW/mJWPqIflxczcl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a3c00c-4363-402d-e2bb-08db554cc14a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:35.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+qHiyAY/rLYRHtv8Vnali06SASLHqqngaSOZzfbxO/yM5ckZgmvMAhgucYKaoBM
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
index 23ebf2065e20de..cd8ded265495cc 100644
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
index e2eb1db5f8f8ce..d5c3c627c0dff3 100644
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
2.40.1

