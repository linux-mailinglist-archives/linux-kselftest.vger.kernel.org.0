Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A8E756B94
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjGQSOZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjGQSOO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:14:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F5B3;
        Mon, 17 Jul 2023 11:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHN0niLqjbWJcVxNxS7myP6TSEeQnV/EBJie7N1Ie6KQahlTGdenMKGNeaHwzA6RdPg2tWn5n7/MERPz2Y2Pp0hJ3dOW0ib7XQzMvgxS/9mAOWRwHOJVj0VnYDZRc40R+siKstJg6EsA3f6DHSAd+PSGHuO7+qgS3vn2QQ8KVczH3etVf5oopMyq/274oJZVjYPuA9A+/xBOTHNnClfLpmtRqHPCkI+48iaT1qoZPRM5TBI37zCz5tgqxarpp/lF1OHETLfdgDDu4spJ7DSZKZgrmTTq2/TbO7U2GRXT67mliVvejvhEIi84R4BTk/cmyjkRUEPT6Cgo3LOcxCKXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxI/vFXgUgAsRZh+P2ld87+dXHhDPADonliJcAR4MZU=;
 b=NxqnA7zlFO9A8IEPSVjJPQqWO2oT+TYIlFQ6i7WtB7jheCAIKp4cCs9/mSse+a8KEMINhBHATDxiABzKHMFYYbNvwqmDYcncbgWXj7maWVrzLY+0zzgSz4IfvNIdeMVf7ndEchHqfA7BwYNBvEOfk2EVrsioVPjuJw4TkIHcdPK7SKX31jKdo64zTFN6m2Dp0+tEJgu2cvKmmyGa/csxbDSrQqVGPLOOIs6yVrdfAvMuV/mnec7LDdKb9V3sDqgFrukCPryuGmGWjjhgMDKDUipnRdmBJ59puM5IP7OVF/KEfayJuEmTAofXrQB3+e0ekAiRYBMShCig7ypW3zqXrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxI/vFXgUgAsRZh+P2ld87+dXHhDPADonliJcAR4MZU=;
 b=HnvDBjvXXxD1Ps2+ccd+S6KT9la/hZXVTuEnTRyYLv3yC3/cPsWbYpEcAcLhRobpw3BQ7vZVnpU5JjL9s0P/6KGVMIWVRhKmpT5f+96fF6qJsFXZI8MR2aFbk6z58z33IH7Yg62QhQVDXGhH+AfCwzekBAmM7+XxQOXxvsW/OJjhnF47CKVlKLNWJD0nHEnpD3DiOPm51QGIk7THC/9TsRK7t9m/X0wHymug8GprKY8AGMlt4gFQHeqdAB1vAiLwkRoHZCcFv5eESx7ZNH88brwocVp8IfSr+M/0/Jy3ADADSXPsoBuVyjs4zFiKSMLUSf4ZaQyyx9PnrZbhSq2hFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:12:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:32 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 06/19] iommufd: Use the iommufd_group to avoid duplicate MSI setup
Date:   Mon, 17 Jul 2023 15:12:02 -0300
Message-ID: <6-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0086.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e531ba-7bc8-473f-92f1-08db86f15f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P3YkOW32nqcWarE1QoH7C6k6aSoiT90fwk8Obk29bTTn5oUqDpTP2S1ETC3Wmnxw/BrhibfinW/b/7hXbQNeKMZiDpWPUYls8QvGkUkE/kz4D2Gf777bm5hz2kUFOZNdfuSUHgYi+fRkNh/fckJYaaS8NJzcfXkWeNtcDb5YTudJZ/j5j6DgBU0VOo1J0ljOx2c/F6EGRhX8fRsycWGSs8K7wz9rpgPniGI8Ju/st1Ja8Ee5deRZCzKAKLM416fsZ799OknZmn1YqSnFAflXqaaWQ21n93Lub+M7XQCzJ+BjGOf2KVrpVoG7wOWq494AopP2n4zPEmGcfF/ebgr8mCoa/As05Q09d4o6cHmBBphFxn63AfLqBkLIy+tnS8S9hSI8AsDvjMqXK5NQCpPBQRZyUrv6Mj+BwkwNwVSDYWZL/+Xw8LIux26a3N9MG/pnt7HLyzncjZ4g4HYdvVS7MZcMX/9FKd/GR58GngN3AJuPq9oCrTebOzaK1DAfiKdy+SJLvo1X35MJCgoi7rp23tBij8MZqKtB9ixDgDPJ5sgwE5wlU5ZN7sH+S5G5TtJixqUXzfRYBca7cvm2l2DsAdQdk/p2fgOjkhbf6a5Rjc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(2906002)(54906003)(478600001)(6486002)(6666004)(8936002)(36756003)(8676002)(66556008)(41300700001)(66476007)(316002)(4326008)(66946007)(83380400001)(38100700002)(86362001)(6512007)(5660300002)(26005)(2616005)(186003)(6506007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UdIYwiE+0VDWdB4u9njx6BbiLYkQVnwd5tBKXK/+LnO5e9mPPXbUJOwLVrat?=
 =?us-ascii?Q?atUlxukNHz/7MG3uwHMvX6NeupPd+7rYPDC9KNOxwNJ2gbnrMtiwt3p1pf1T?=
 =?us-ascii?Q?EqosEVtNDxUYdi/jyJPxGBmRuzErnKoFAi1Wgx/MLwzNe2aTqUM41w5Jej/R?=
 =?us-ascii?Q?77hR0oRM8o7p8imHFGXbayITjlgZYDWSJ6O0lC5TUjzamVMQmMvjALzew7KP?=
 =?us-ascii?Q?TngC9I5dFR6DzaoT33oA+2PPFo03xEEZWqoJp8Q3FOqFiZUrA22EWx3qQ3nQ?=
 =?us-ascii?Q?6ZUnSA6kt6I+deYpg0Id9KwmRHGCzaFoV7c5o/CSBvGxf7f2kGMfkdTL4Mr9?=
 =?us-ascii?Q?AZC4QeA4Pkg3UOPfYxeMIbMBZfTlhqsknpbn1VdpT468DHovfBBgKljOK15b?=
 =?us-ascii?Q?jkoh9NeqTeRtXTQCRYpd2eFY1UlBtJ3XbqETgw3mJ/UDaa9fNJgHRHGKUF5a?=
 =?us-ascii?Q?YE+W97TPgMadKleExPtLU4+vDpuwnmY+0u+71nY7i7eJiiGQWS/7znAUlzCw?=
 =?us-ascii?Q?E8Fnb5667zvKRmkDg7PA2T/46D5loHBhowip+RNDaSF3H3NqR9nSi3k+xfpI?=
 =?us-ascii?Q?Qqo0DWKThhWDLWU3nSdtUAK8pIsNuc0c4jOtAENZ1k7rpk1017sJwY0MxOM1?=
 =?us-ascii?Q?Ie6FEPtiv+0R+GNPEiheePqe2sziBJn646ElsgsxEwGDFzf8JtHuy4QgWHPk?=
 =?us-ascii?Q?AX5G7Ifu1IQd51uIRLrpZ6AJfZmxymOBa9FG6dgeDSrGEsxDHsZFld74eGDg?=
 =?us-ascii?Q?Mt0ghVOUdxenok0FflwcajotRh7MkmXy8PAFMlbFva4egpwfMYJFO1TYrSld?=
 =?us-ascii?Q?4YkRcExsvj7I6Vju8OJbF8b6BE3bEdzaeRQEJ6GQkqRCHaKBrz2LYx1ADB0S?=
 =?us-ascii?Q?yU8ZKYK6lnnozdWcIzJlKXTgDuMWt/jNURLpL+DjHjMtnH4ZVIO+3SUVUpbo?=
 =?us-ascii?Q?sE50I2OfasbFo4YXQx21FUEpC68HJKiPmRystW+dUbAmXJpadGWQa7IFatGU?=
 =?us-ascii?Q?btySLS4AZS8rJKIahrMIQlvXMh4vg4770Fx3YI1dY8sFcL8HiyZ3HtW5CGWs?=
 =?us-ascii?Q?rNK/PbWuK66PB+6dWHDKJ9pRmuRhq/R+52bX3QM6EIR+O0zahbfNEwJH72hY?=
 =?us-ascii?Q?oZossuEggkNPE47dnVs6HJAekjSuARpR8OPn/4Te50rMDT9x+LkleLalIAmm?=
 =?us-ascii?Q?ILzfiJwPsI7Um6qaTnpjOaouB4gJACaf+tFOJ/exIFFesBpQVs6GZC8sZFWW?=
 =?us-ascii?Q?m+bJoQipCdYfF9ZI/WLFV+d0zug4/LM7cE7pHesAItQwFyLPQKjKS1U9XUZl?=
 =?us-ascii?Q?ByrJSRHXRkbfubVazIOzUqD8h1HiXElnA6cA+2UfM4gEMCQ6iku07C5Cests?=
 =?us-ascii?Q?G8iWBX8c8AAEqCBXsvILz3lmGnGUyMem5xrUBHf+q9qwUt8R9M0FShKjb2zA?=
 =?us-ascii?Q?B6jhZ/9PS6GzGqWskCgzWysWErGaLy+uJm16bXzzHcDs6CcnivlcbQfZYd3t?=
 =?us-ascii?Q?qnSfMSwKsCf6pkDO+cwx8VZ4vl7/lr1y5Y4FMu841ceZ2vxKLaRwhg0eh9ey?=
 =?us-ascii?Q?2yilUnWFSOp+lNCVKb2LS1vcsFo8+S5QByHN6wKK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e531ba-7bc8-473f-92f1-08db86f15f12
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:24.4386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kHJekwX5Gwlg8raARvjn1+gHvBA+LAggdVZM954/qCNSwWqJcRrAzGpRuB76Qy2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This only needs to be done once per group, not once per device. The once
per device was a way to make the device list work. Since we are abandoning
this we can optimize things a bit.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 83bd6b751a9799..b2504c612a37b7 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -318,10 +318,6 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	if (rc)
 		goto err_unlock;
 
-	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
-	if (rc)
-		goto err_unresv;
-
 	/*
 	 * Only attach to the group once for the first device that is in the
 	 * group. All the other devices will follow this attachment. The user
@@ -330,6 +326,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
+		rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
+		if (rc)
+			goto err_unresv;
+
 		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
-- 
2.41.0

