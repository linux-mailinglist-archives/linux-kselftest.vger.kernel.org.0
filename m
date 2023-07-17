Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611C9756B89
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGQSOC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjGQSOC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:14:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C961708;
        Mon, 17 Jul 2023 11:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qz++FgZv8sGpGBOX/rt9ZjekZQujOGfCGX1HOc6v83/CFA/t5cpjYeGmR0KdNfdsGgRiToT/w96p3RxynUEiX4qHnbEK5n5OJrXRe2qKa4tEftl3Z9KY/C9j4N8Y0PJkRg0sZ99UBIprqS0dmpn0o+LKXmbRUg3YI6qjJwPdCo0sAkdzJStnj/ejFCm2nTOnsJZ7cw8lZggAM3uuU42/d8BP9tZzfVJxu+6/X1G6VJRL9u1D7BxHfWzasU8nHV1+ONu9A0V2byff7AzHFG9pDWcYlYKihfBZfqPJIcaks5dEB00YKbvI65jOS6CFgx47ClMUPAw3FmO/lb3XMo54yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNa1hrtutCPIWVF6Jnhw3LzBRke3a19yea8AGSh7wXQ=;
 b=LUSAZkLTdgjJgNxcMZmGFXqH87Jj4Kh1G0gTsjW2BjycHYQI0IEoy0g+NGetJzdcF6ziOPGSb7e96R/kgUFlHMFgDH2hu/qjsDMXoobsNucI8KMUTK5ar/pm87+9XWlLgKynSyUxVwExjxKO/5HtqPQyolJLcfS8SYIus9ZYfefLCYidnvZKmewg1AStFHa5YmugIopYtU6B/SWPtjkYJfcRMyI9a0RLjJPvfXkgU25d8r/mQccYX+BLOwm1eP3ZAVkfVPNf9ATzJazrm1ryEsW+XqclsUU4ejOFmz2zrKqdTC8k1ISiw+OaumFnSa9IlqxpZX1XrcXs/IsurCDnGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNa1hrtutCPIWVF6Jnhw3LzBRke3a19yea8AGSh7wXQ=;
 b=dnhXOGaC35AEZRjPHGnjZDVefYOUJFQfPbfVGM68CRQVqyw2ROYlgk/+0sFzYElCCK8QnulBAHgqAa/nPgHF4rDyXktKLs9v6CW7PxmUnlJbPgT0jXKNQG0BebkT9Ea28qLGPQ7ieNV9BvLkF+3RY9XqQ9rjk3kMJX95Q+dPPRT+sAdGXfoTJhBYPGZ/Po+bLUeiT8K7Von7SapqFiN23p4U+URt5ljFSRsp8e4CG+6PtZYl97n0I1JEMPTFKUQifEi2efgQNnc6cO4mTPjv6L3FlmuZJwMr26V/MKePsb72M9Rooycy2PRbFX3oazZkvRrWDco2z8hF13EjYoxySA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:12:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:25 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 05/19] iommufd: Keep track of each device's reserved regions instead of groups
Date:   Mon, 17 Jul 2023 15:12:01 -0300
Message-ID: <5-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e54157-980d-4843-123c-08db86f15d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iGQXcl4L0vyCbvAvjwX/PvsVU5kKdCrZ5xU33Wvy51LJzybWHIEKTlrAIfI1QU21gGXY+1LvpgcEDmyEvagV6vAFPYiq7Uu90i5QkLTF8qHL5KEqYxotwlYrZia7LtZ2fg9rgXk1NoMATvKgFBc96XeZ8ymNKjIfIEUW/x0QihOfgMS63wSK1J62YvzjgTgsGwyqx9XYNyWCxNrjoK1J4A466PvnrSvA8pXTLAVcWNqK/7njYwTUjoGu/vO/Jm8M1iSq4KsxoHAqswacTFZV3IOHcPQHoCFEhjIMg+Jil6205MCL+0yj2Q7dlickMMaD2oa4/DUrw2xWjtdeQj8SOraazXL+WHDFGaReanAltmPlyB9lYDJnEZ08+mnWDdU8T3Z68ub7hSGWFvNEXl7fQC3B4NQ0op+HLuFoHL/J+HNPB0SHxIHPYjq8ybi7UupA1tgstjX+rnpqD5WwNQs9ctNiJ90ou3NfSoO7ryOE93cqf0Aox4FdLlcV/xsC0ELybqjsuVtKYAiS0ljQV5fDDONUOphm2w1IATg575HIexCeasOAilzsApuEdsbSAhL7Z0k+UIVCsaW3AmUiBw6qjVXe1NuYSVk4ihWvnW6Pcus=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(86362001)(2906002)(36756003)(66899021)(6512007)(186003)(83380400001)(6506007)(26005)(38100700002)(6666004)(6486002)(54906003)(316002)(5660300002)(66476007)(66946007)(66556008)(2616005)(4326008)(478600001)(41300700001)(8936002)(8676002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eTfRWcSQdq1QQZCm4DNwLz+oIFU7RZ6y3lIWbAJ4cP1xok3M0F7Rbtzr4cib?=
 =?us-ascii?Q?eROJcF2MTnBhWXcw3ZHWkDGR8a/JkiRz5F+V2sk8k2KNg0qwlXB+TIgGUSFS?=
 =?us-ascii?Q?mx3PGzkeNz64JQ8hym5dO/wIOmwBH86hZQuJ79WGF1BfS+tRuCwT0Iwy2jDo?=
 =?us-ascii?Q?PPvWeTsIp0ZCm28heDPaLHh7CysaX9ahekXkqCG3yXaaPqthqrP+qeWXVSnJ?=
 =?us-ascii?Q?Ora7qZXAJmBJK9UaupO5pOKLt9/erYRIKxsEioozwVGHg94ayhMf7490L38h?=
 =?us-ascii?Q?I4le3vzgkiHJAEsnryXyGd2DQFerlfkqbqQODcLOu55RbxFnzLN9zjHwuHZy?=
 =?us-ascii?Q?aKc2npntjGZHKaXCpU8I3heXggytPFEjoIi1Jy+sG0JnbUevzZBeviqELCnL?=
 =?us-ascii?Q?oqPJ4u9tYA9pXr3Whld9M4KAxr8YZxDCz0qiWBt4RhFMbeuB9tjjPB8BVOy8?=
 =?us-ascii?Q?m8oZMfj2QfEtL3qAm95Jb03QzsvrhzcxYM1TtGndcY1TOQGebze731E2Dazt?=
 =?us-ascii?Q?SSr6EpLadKyHlNJYED6JESf+twJHLc/Fa8uLYKoY0+a3sCrcFij25ZrnfBxO?=
 =?us-ascii?Q?a1/cPfFS1lzgdpKQ+JG/YV4ROV1jAq/ENeUMiEF22zfd6fXn5ePw86EdPJxk?=
 =?us-ascii?Q?ho6rVXrB2/uGsBeg0DkdC33O6F/bllTiQX5GDMgqFQrjZEXtaW442W8lOP8+?=
 =?us-ascii?Q?mzD0yyM0RdynFexQaKI5hKjX7k7MrvEqpL95v8Bqr70aoqlOMA+CSCNPS1BO?=
 =?us-ascii?Q?1Oz3hfJ9FzPIDUz4QkmZSsr3O6JpL9W2JCQ1AoB0UXK7bLkwVdIF/+MARUhP?=
 =?us-ascii?Q?YVPONGxBcYIvh4REgWfq+vDx1CjZ1yqf6tMQpTg6cFvS68x93XNBtON+RUiN?=
 =?us-ascii?Q?RuS/ksUbrqiOfQemfo9catUdYJEkd8Ztthka4xO/DTWAidmxPiNQawjcV9DB?=
 =?us-ascii?Q?P8IKLjBTqj27FgzVXkrt6RNiHeyDwYUgiYD+LBZm4QiQUbbgWNIzpJJAjqIZ?=
 =?us-ascii?Q?vnrJNYq6yZ9AyEunTyMsRljRCeA5v0PyhVkj1tWSQ4sXqejUB9wM/RDUF1uK?=
 =?us-ascii?Q?atxXF3QK5OjSgQLJidLt+U8PQel7LPZRDcNT+edgIvJGo5Yh3vmnLDLYAk5K?=
 =?us-ascii?Q?5VGRfvoruDuuQxwNpoPkI0iuhpuPohSKAlx9D7IB1AoAJA8aOhVMJkCFtgIT?=
 =?us-ascii?Q?Ho1Z4FmcJ+mhZ/ykRjX4+Q2H79hoEOCgS7wmRv2BO70c1jg9JO54gO4wASjm?=
 =?us-ascii?Q?5J23Pgz1WB6/Kd4NtcY012jy19xwVhWZ4LVQ3/0Enz8f9Au8ZTHytdPCEf4Q?=
 =?us-ascii?Q?IwCkSl4VZ/hzqSbXg1/C6Uh+93uRiovXMrAQVvfCiDrCZtki0ONqZLFR9kdY?=
 =?us-ascii?Q?sv/Piw8XPPaHg9m3USC/aYIWN3+dzi6Y5QMs+tKqYxP/QG9I6YzST/pbKtPY?=
 =?us-ascii?Q?48feYjkHdUgMyKlX5XFaGxcV/R6/0lyWGUrh6Ye7lrYIuqtQUrwbAHEj8X1y?=
 =?us-ascii?Q?/1+0yCR2YV+LAo161wtDhXss/2dWCYc+MOyEMuWDt6MbXb2fXnYE5QHf5FMt?=
 =?us-ascii?Q?JpL2GvyEDwYVb3qC841GWPRVs/dHt2ti+GJ680qJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e54157-980d-4843-123c-08db86f15d12
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:21.0873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNhm3niayELPRtyY0cz/VgESknm5jukcpqUOV3JRxmHDiuaJZqJB1uAQgcW9mLNs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |  5 ++---
 drivers/iommu/iommufd/io_pagetable.c    | 27 ++++++++++---------------
 drivers/iommu/iommufd/iommufd_private.h |  7 +++----
 3 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 0ab2fdf9c76be4..83bd6b751a9799 100644
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
index 724c4c5742417a..112bea5a84e43a 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1169,25 +1169,22 @@ void iopt_remove_access(struct io_pagetable *iopt,
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
 
@@ -1199,7 +1196,7 @@ int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
 		}
 
 		rc = iopt_reserve_iova(iopt, resv->start,
-				       resv->length - 1 + resv->start, device);
+				       resv->length - 1 + resv->start, dev);
 		if (rc)
 			goto out_reserved;
 	}
@@ -1214,11 +1211,9 @@ int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
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
2.41.0

