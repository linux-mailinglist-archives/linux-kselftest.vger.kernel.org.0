Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF1D6A258E
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBYA2Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBYA2N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:28:13 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE011ADE2;
        Fri, 24 Feb 2023 16:28:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3+gYNHHfCWWqW7WCtK9tFYKMrlHxADTdw6SSAhU2zBwVMfQixdR+1vj0WFCGD+iJi/xTGji9DZFqLqvPX5j+GY8wd1LEIRZTNj97xPxbdrADZDQzS9QJpZcy1DjphwlLQrc8lAUBypvtbUEb9CCG6Cg4YwuJ1md1cVXxN5eJSwJ6oB2SfoFi0d1d0rUGGlSf6wLAWkNFWMFkyKANhZhqr0X3FsVWYxhCi3amBxIW+qQOqooxGNMqllox7UfmNR7jEURubrnIHk5MlQrGDN/N/AGUn5Z0Do7JZvax7XgOVJ/C+13oBvNDDLouY0lXl/sinI4JaCPZrdFJ/zp06F8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn25eTqY5kWysyNu58e+mWz/bPoasSrMP2Pf+5Ovy8I=;
 b=BTpCM4iT7yMg1Vg3alAl0LsaCnAiLZdPCY7FjMUfwndMcga7sD/dI3LjrKR6/FkVaTOI2I1FvcVsmleLn+v93kQcuEejL6g4BTShJn7t9qCRsrtMV37NhOTWw3bQOstC8JAqxz/G87tNYyGHv6vHchN6QEi7ELc9WGmdXfcMA+0G0nD/mjrddMu5Frj5pvyuz4CndBTO904BH+VLb7z7ttzjd3bbT2SqAthYn4GfrLQTcxtGH05RIFP+eOgLUtW1pWZY3tyX+oVdghqbO3wDJUOXgZg3Ddum6fbbV5qetaNSuZGmftbct2krlw6uNwSisrxaNw1MYp6cWDBiYqwxBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn25eTqY5kWysyNu58e+mWz/bPoasSrMP2Pf+5Ovy8I=;
 b=Y5b7Pb+eUG+l9pml/LKkCTqOvsMa7ovXgebe+sfRGoHnYt/7Q18P2PSjtUfUUJopl7QjHQK/t6uuXGFvzpi1ayMhFUbZAqHd1rcsS/lCTRbCzGGLvSmySzd5VGiuFtf7OTMX+w61IbwqJi5HdUFmXKMpkYWP66IJCEoroZLysl+RBKeYxKKFZfe4+3FCmpipk4LPCC5MZT+3kBW9awuVT/pNMflgAN25dJQREFJPzGyPeP0RLytKOdz50dWv3kb941Ljuh0j5RLJU8UottKdp79ODSSeDzJq1wMg8bQmJZLD7a9BUktec1YRBKmJROJBilwDcFIkBRQEJQaOw1yCAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21; Sat, 25 Feb 2023 00:28:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:28:04 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 05/14] iommufd: Make sw_msi_start a group global
Date:   Fri, 24 Feb 2023 20:27:50 -0400
Message-Id: <5-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 2404d883-e61a-4632-251c-08db16c72748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mB5JGp5mzTfIcuO3q/zKMZTFsZTY2MJlsTFJzqpZDOEdfVK7s6bVEllIxv5u0XlMR32oiE9plBKCfyXGOS6ZKrExyUmaCkKuLHLV9K+AiB5jRtFiW4GWF5/aoNc27Od21jRLTRDnMpPrz3z76Io3pvU3LWt+r64Krfwj07cLAf1s8dKDovJ4p4vnMVRrnv96AbYWE+s1XeGFyJVFK2lgQLWyFUs+3difSOxZHkziQR5tUeb9oMM66GuSBGDbRUAtnCsaYaZeVMBi5b+DWYfEGENEOAH+IE2Lc2xsHDI6F3w+0EI7NhHc1YDWHZBiJnLWwy5FYXtualUtFurxXluoFTGOVUV6R9tCLGu0ntnSrB1ZqoExbtmmssTyL6f3ejzLokTdA6tKDagy0zwRoU16DzPrrjNysK2yOEtVJ3ykztw/ir6rYTH+8SYSurClJunUY13rXzzsOaP4J3iGivfBYf1Tu5mP1pSmJX9Byi5WrL9INa8PHjySPyXyTh94EjFl8hQwTI9B/jodopY88DYvZ3t+KD/9/K+akduS8g0vtazgvgwE1JV53SdG/OcwKkRUYd5JdMhYx331hKgI1RK7FY4gPyW6qFWTILnU9+xUbIpIH3vfyXri4cNnXqDJ11wVsHUFOz+TYLVsghyvV8FBCrzmCBOw6IkrmlfY3DYkvI+7OyZv/1sx0ZzjKyn7s8Eh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199018)(2616005)(41300700001)(83380400001)(5660300002)(54906003)(478600001)(8936002)(4326008)(38100700002)(26005)(186003)(86362001)(8676002)(66946007)(6506007)(6512007)(66556008)(316002)(66476007)(36756003)(6486002)(2906002)(6666004)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/3pnGq7m2ufNlRT6vVVMczYWHrKKuWEjFBvmG+RJQmg+c2koyDkIcoq4SOjh?=
 =?us-ascii?Q?JXQXgstmzOEE9WZ99u6qovgvk4W5CLsdeqN23nQ1tuxZuShYZoGyIx9BrMUP?=
 =?us-ascii?Q?UwwMAotONjAcOTXibxupnMoCw2PANPo+aMKn6CasS/fKPqgVaRtasMY4u8Db?=
 =?us-ascii?Q?czLqBF53m2OSghjFsZgKExD/77uxYjmL9fZJtXsVnlieK93fkH6MKRZQL6IW?=
 =?us-ascii?Q?1M0++GXpwjFjYcWtjE8Jwj0ZTxe3mrxvkb1o+fsEeh9Pl64N3pgaWbOnUPb5?=
 =?us-ascii?Q?9ZmdNARbDRofCw1gRjJ/igTAO/bX120KRwCo/GO+0Vj88cqF6DggkQysefye?=
 =?us-ascii?Q?PXtRRRe6ktrE0wH5PE+dn9fU/yoCXSt4IU1qxLiYciXMuA9V7WzYhVrx5IzA?=
 =?us-ascii?Q?g4jerNtSQuys6G5xVq1odXlCFjF3Avu5bRk2WzqLiZzinaLZvcvKuSvD+EGO?=
 =?us-ascii?Q?GNscXHGWiyzXNl4i1lmz975S8Lvwenmc8mhR2HG3GDRNuoGZhoqrboZMpF47?=
 =?us-ascii?Q?eaNJBPE7FG9ITlcSRZLbQm+RP1I8teELRF82SKSZEICzl0eOse7QoErt2Yem?=
 =?us-ascii?Q?8bPhRBtQPiLPBpkwR9ktof+bVG7976jC8kZMtgV6Fyr/c2xWZQZkbBzf3brr?=
 =?us-ascii?Q?/fmkCUDvAd8l7fXaPOUYgfYfbshxZdfJftKzI02qXsLFUrQP+DPlM4EWFK9J?=
 =?us-ascii?Q?XR/++9LkBBq98uexBLHakglvuEkueqmcx0ByBF0eHEdQ61errLs6d1ZSdsEH?=
 =?us-ascii?Q?+4KRTIP4zJBp+nONw3OVXaoCb3AaG0kBl80u9YwZBEGv/VTs/QrG4465kp+U?=
 =?us-ascii?Q?DahBsedCM5HWkbY3RDUs4inCMGUbUjSLrQB8SjhulSRUkQ83lNfNSV1cai7J?=
 =?us-ascii?Q?g9xV4prsAb1ndWiTfGk9eByIes+5zV5iMpkxyNVvYF4Dj5FatnXIPMwLYDjZ?=
 =?us-ascii?Q?uZEA+ci4jlOFmtsTYhRxtDuXRNGLV5Zpgf03KtHOISr6XJTt0AT9yTS/pt58?=
 =?us-ascii?Q?mQ1GTaW91b6yx+GA8d62ci42WOLE4F7dnde3IDuLo1tW1Dn3iRZ9PHtG1NeX?=
 =?us-ascii?Q?GBeT3NJWXBgAheXzuJSF0lqtYhM2xf9xvLcQ+qCXJ0QgnA1ULAwSMmgP/usV?=
 =?us-ascii?Q?L4gFm7OOmNpifV3vaHDZnh6n9XoTp3mFldvB34Fp8o1HKcQ9JPsaVr6cbIv4?=
 =?us-ascii?Q?Vv7Xdhl7KwVFgnX6FoOOoNLJtmkQZ1uMBpNLiLhmViKL+17dvfAnYqscR6+m?=
 =?us-ascii?Q?cLR1fYD2mGthqclht3GoqpkuMFp65uZhCINofkds7Bg1oBfMyW9H5fKPobuR?=
 =?us-ascii?Q?c36kLReIxCHMpWiC0HhUxwVr/4JCZqqKak+z8hrtnSKlesvFw2pyuIVlUGDU?=
 =?us-ascii?Q?frtH8AziSwpbCdqbx3UJJivUGNMXo5Oj1fsDJDjSrTKzmbtPka7uRVzQEcYA?=
 =?us-ascii?Q?/IAWZKWtzNigpPjBRt8MHO/FnQnSee41FPTVqOQ7JDppfzM3/AwHI2+pSlfK?=
 =?us-ascii?Q?QSkfloQ73Z43p2QKHuS51ZY2WoKWPsLpgF0R7PA8TWq1Ez4ZwvfJXP3t/bKg?=
 =?us-ascii?Q?wcf2HmOjcqxo39OilRLpIKFk4OTqp7tjTL0/AXiL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2404d883-e61a-4632-251c-08db16c72748
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:28:01.7961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqVXKGrRvwRbtY0GoMMXkQ4ZGJGbTFIUevqTEJR9n5wLSh+zm6AAPXZFOTcP+7nm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The sw_msi_start is only set by the ARM drivers and it is always constant.
Due to the way vfio/iommufd allow domains to be re-used between
devices we have a built in assumption that there is only one value
for sw_msi_start and it is global to the system.

To make replace simpler where we may not reparse the
iommu_get_group_resv_regions() move the sw_msi_start to the iommufd_group
so it is always available once any HWPT has been attached.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 13 +++++++------
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 75e8d79678736f..ea34dc5b0fd1e4 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -74,6 +74,7 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
+	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
 
@@ -238,9 +239,9 @@ void iommufd_device_unbind(struct iommufd_device *idev)
 EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
 
 static int iommufd_device_setup_msi(struct iommufd_device *idev,
-				    struct iommufd_hw_pagetable *hwpt,
-				    phys_addr_t sw_msi_start)
+				    struct iommufd_hw_pagetable *hwpt)
 {
+	phys_addr_t sw_msi_start = idev->igroup->sw_msi_start;
 	int rc;
 
 	/*
@@ -273,7 +274,6 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
-	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
 	lockdep_assert_held(&idev->igroup->lock);
@@ -310,12 +310,13 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		return 0;
 	}
 
-	rc = iopt_table_enforce_group_resv_regions(
-		&hwpt->ioas->iopt, idev->igroup->group, &sw_msi_start);
+	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt,
+						   idev->igroup->group,
+						   &idev->igroup->sw_msi_start);
 	if (rc)
 		return rc;
 
-	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
+	rc = iommufd_device_setup_msi(idev, hwpt);
 	if (rc)
 		goto err_unresv;
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index dbecdff013d082..0497d6190fd1b3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -267,6 +267,7 @@ struct iommufd_group {
 	struct iommu_group *group;
 	struct iommufd_hw_pagetable *hwpt;
 	unsigned int devices;
+	phys_addr_t sw_msi_start;
 };
 
 /*
-- 
2.39.1

