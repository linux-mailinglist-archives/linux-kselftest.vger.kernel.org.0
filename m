Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248AC6AFB37
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCHAgN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjCHAgG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:06 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE89CFEE;
        Tue,  7 Mar 2023 16:36:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1I2pqWfkcqnK+iYall3XMYWMwl2sdHxheuWq3st5n3h6wWWRLHwYWnp7DARdGSBsJv3u+HcCAXnfOaBtCRbRILdLiWS8IFFKKLL8Y7r/K/7CbPabwaZDq/Id2kYD7sHEgFcSOrIziXZkJ4NM1mWdVh3Nps6z6QVFdqXGhLhImjIEJkdXMlmzy0jDopH7PDTg42EZswkK3H5rR7ALbSQgga9RjrFc3bJIlPiuRFWxxuUctx2VCwUamc6wKw6Mk+s95IRlwACnfTeXD/Lqk9HfGugbxhXNf9oZnmnSagsZBaiLhKO286/Ts9Wf9YhP1zDo52CmrKPRJgGAcA/jwqwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfnuLljLZxxBwEw0tPqdr24L5v0XUTVZQV21QBqUWZY=;
 b=UH/nlsNRb+/eszgs5pEgZ40pcVGH1lY/hswQ2qZGogkDPnqI6h+bvVoqtHgjXW6vBlSM9ZpWc6e7S1l/4zdPe1+8QIIaUIgU2ZMkFYfx83bb2RtSvbAvkvRLvHCvc1/LAqxumosZRfTgJwlKo4ALJz2kKK2JbstiGRxejULLXZgVz89eXUz+VtLzGmCyCRYc4e1nJLWq+V6UVjOw9DVBqejS+kpd1lfij6e22Crr+m0oJJwVJU9hPARFw3FIy7wFciC8xS3ESRKEG3Muy560VcG6HQOI9BqhZRMvQSn/++AuUN7szxu3PVh9vBbnrlSPZMAoCqiqFT0p1hsNbdJhqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfnuLljLZxxBwEw0tPqdr24L5v0XUTVZQV21QBqUWZY=;
 b=Fa6aNUcNG73KJSky/vRsBeY4l78Fm+L1gVhzJZLUUUSDnihhto2XP5d6JMlWNAlKEVrTd6zRCG9DqBOZb6nxPwZl+xUEd1Ee/ms8PXZClJGU/DPfmt253GoJ2vlP14vALUkNACl6j4t3FHcVUb2tphysEJGUw66h8RFPKJ2wemUm3gTEWZOiAacUgM5pf1/3uv60ecD4/WEwQikbx+3uuoiEggMYIfSe8zOphsAI4m86jpiocNaq26qXl3H5ZzVb15fKflm9RR4c/6VW650WLBLDxvuNzz1FHfsRaLBp4D9mdHTgFTStLmAceD+NpvpGV+d3/jYeAbwpSzME3FyK3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:35:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:35:59 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 04/17] iommu: Export iommu_get_resv_regions()
Date:   Tue,  7 Mar 2023 20:35:43 -0400
Message-Id: <4-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0306.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 73bae30b-6d9d-401c-036b-08db1f6d1597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTuyuCr9Qe4xvxDGXJgX4AUj9ndo7qzDjBDpzHwQKom1Gyt3CaMZeEBhiYXjZUaVuXLONATAxSLcAupJD5iJe3XsM/jl0tFSy37SGCMvhTvK6fgjq17HQtBnzwfLk0mIAf0T6GedV+JzU0nmMAvwP/SmnSiAS6wH37XtV8x4QYVeBdaaJStY6Izmj3pODfP6Tw9KNDcM8JJvjEgJxrfq54q0HtKX8bGSfKmDuzlhRJdD0L01V3AHBwu+X+eMbtiamuUKoXiDzLwaWmGTwxx+O8ZfueatkVKWxh+WZByjniq9n5E4DZdzwR8QvDMrJLDXnB3ZcghHrMV89BdxxZqvLFtvQDCDJsiosmrHY0Y0TDXNy4pMd32FwfTiDK6siju5vftlAaBdkPpFzLLDkAGdY2v+mQQqoN9aFv9rbfieG/04C2j9dclK6xWkFyn7iRkvLqdFjJew7RUxH2j4RmivTu6H1m9ORBFy1tuWbcBmhl8QMIuBas4T+Qd7uQ3o/X5beh/Nnczra3YHDXN1EuKwYkAiBxg/Fgh12ZfBY2YkT+YbzoPEzuMwjpr3m4uwcrGrbU/NDIzulumX+mUZ9KII097aRJ/QevCkNgGHlPAID8t/8PunUl1y8KfbCRjFQ8HLxoSO+MSY/Ob5CXK3gcRz75V0jTGNIQe3FRS/EUlmFhnTBuCu+7HPFQcucjqR2rc8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oNbNFT4GmjeWHebttao6FVYwdqBObU0+hxwSQG9xJWKMQ5AqBJ7yzZyInaBr?=
 =?us-ascii?Q?bxfCxTATULpawUcxoBm6pmpUuHdPWiHdq1XHRhtfUf0gry65nqwtmVHzoVtb?=
 =?us-ascii?Q?wBOBWoKrijUTsvmfTjq8APeBK5/2l3ARmvkO8ByKlB4aeZAdYJtFNlKHyktX?=
 =?us-ascii?Q?DAbp5Ei4xxB7Y33ZMMnVFjYbg/Rwa+bXCST/404M+QOdxlEV5YbezIc21ttN?=
 =?us-ascii?Q?lmiVHE75B5gDYlQiGZpy0bWI1/Mdyj+yvYX6YCTnS3j5F+dvfUWCRzNQsSHG?=
 =?us-ascii?Q?GF3VoparU/cxAPKGtVcHRRBETwvqURH3qe4W7mQYWN//0GtiPW2bwi6B74hD?=
 =?us-ascii?Q?Zzs1BM/oyNaId2aM9y01Fv3IzrKGzahDn9p3JqxIkMV3rckv/MQqOAn/vx/f?=
 =?us-ascii?Q?IME0VBEUbyS6TsLTv6BmwI6yYfajtnT3NzOh8wTdF5zONfxrQcYDsjsGFPHl?=
 =?us-ascii?Q?pYYR26lHUZRJxVI0fR3ugx+1DudJHwvH5G1RIXTb2/PBuQGA8wnrty5gEXlS?=
 =?us-ascii?Q?8LnKee5H4XgWy+V2HSVaegI/FWvVhPKGgcCK0yLVSr7w4ABGnbDQ5wJG0Bca?=
 =?us-ascii?Q?gDOEdV6/woqREcfpQQnZUcP2FQITfpxTYELdrKwYdR75D1unTDWmjsekJkEV?=
 =?us-ascii?Q?bEIuAeNsyUl22WCDDuYms/r6IDjGAq9kTZ32iopGWCjUVCqL0DzOJ3b6eUoM?=
 =?us-ascii?Q?yWAEiupt6IR40Kb/jdGKkk+nGKseUDm3gaMId0oodzk84MNKwXGnHpCp4Kfo?=
 =?us-ascii?Q?aarzBpJrSLv6MgdJuOEIW66LoJ6mJVGJaT08KXZDJYBxFCpr+1osutIpV63J?=
 =?us-ascii?Q?mhKh1bjWXt82hNcNp3cuyRbOLE6TicVpQYjEQUCDW9XC+/O+4jTIMzdM0brt?=
 =?us-ascii?Q?UHBk5IUzo/8/9O3Kt181msjLK7S4angJlMAiKELzugWYbb0dMIezrdBb0NkA?=
 =?us-ascii?Q?AYmkMNj9XKlPXnXqhZqKd9zTkxdpM+j+SG2D4eCY/BlfKYjkZ0jd5d2Wjybw?=
 =?us-ascii?Q?odXp/TBhKb4A1+xwUD77lGM+bhzkKcza58YtB3EOSI81b9SNqdRc5IRkjXMH?=
 =?us-ascii?Q?aZqlavwFFLl296WOjVBgnvHEhBatLXKrVSiigrVHwZdDVbWFunEYFDmmwQMz?=
 =?us-ascii?Q?GWGzZpQnNj3NqiEOG4lhcmDVuFHyEerv6RTj/pp8I54W1EzkZmspPmfrtoKz?=
 =?us-ascii?Q?OnTVZplH4ixAPaX1hroQoRSB07MEJeou6tjpGnww4h7FeF+yFbGxntJT7r3Y?=
 =?us-ascii?Q?3h7y0ss9NkMWlV/IOCJaCmJPoPkMpDzBJ5aUOLylTolFJ6O21VXooB81dzpT?=
 =?us-ascii?Q?k97L1XN4qU9ByCEV07zX59lwsy19lMIpl8BJZ9FRDVA1QJjAd+UT8Dw60Am5?=
 =?us-ascii?Q?xUvHfnXhO8Imq6zSaiRD1PCamvi6X4sf0OySDORq4u2ZHqTFZGSf89jilEse?=
 =?us-ascii?Q?Z3JipCyUIEJcSlFUmHmSIsgKSuhZFXUCHToGJt37cqZKMF/wPmgMY7HCVjst?=
 =?us-ascii?Q?KDpiVwTcZnsI2kExcbA6SjNAnNtiBYNMbxOuFGuVxWd8iljZ5JLdbyl4U1T9?=
 =?us-ascii?Q?B5XiuQQA/qnK2QtW6BZl/10ijnigFc0h2OYP/BVz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bae30b-6d9d-401c-036b-08db1f6d1597
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:35:57.8890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXfEGmgiQbsyT5ieu6HD4dBnauSCjZebb6tG/TnNdW81RUBZfQGDtYCjuYMYZ5je
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

iommufd wants to use this in the next patch. For some reason the
iommu_put_resv_regions() was already exported.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 10db680acaed5a..e57462bb06d9f0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2639,6 +2639,14 @@ int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_set_pgtable_quirks);
 
+/**
+ * iommu_get_resv_regions - get reserved regions
+ * @dev: device for which to get reserved regions
+ * @list: reserved region list for device
+ *
+ * This returns a list of reserved IOVA regions specific to this device.
+ * A domain user should not map IOVA to these ranges.
+ */
 void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
@@ -2646,9 +2654,10 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 	if (ops->get_resv_regions)
 		ops->get_resv_regions(dev, list);
 }
+EXPORT_SYMBOL_GPL(iommu_get_resv_regions);
 
 /**
- * iommu_put_resv_regions - release resered regions
+ * iommu_put_resv_regions - release reserved regions
  * @dev: device for which to free reserved regions
  * @list: reserved region list for device
  *
-- 
2.39.2

