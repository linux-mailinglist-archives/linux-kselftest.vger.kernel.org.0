Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CCE7C01E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 18:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjJJQoB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 12:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbjJJQoA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 12:44:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ABD8E;
        Tue, 10 Oct 2023 09:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y76832PtgNpiwRFmyNkFrcTKmAIkbZDaB1ueojsjUSlYTD9S3fdSayJgYZXLe7xXzqnQT3mlZlXrg7F5lUn6TN1S0k5cialZwEwxzG4tV4c5Q5GB+5Eegi/XeZTgJYMcifpqBuNqwI2jlvtTGGWWpdqtAb9xUHDousk7Ovpd6VBlTQfrFeMmZL6rmeUVOxzgs3y6r7DbNhnEgPzOQalevWy80rACMhvUmmuHDotgLHn1EE3AyNosRSURv1EGQi73orCul/og/fVEjXy6eKOuxJJBpt6Zzm1bMAAygyrvGvXGxKFjJhRzi0Q8zCsJhsBdR+vvLRuJUNAOE0hliv4IEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOcc8SPL5b2ijmoj7gkwXv2mFDycsa6o323XBWrK9MM=;
 b=E6mIRhYq3PRR03lV9iVVNg6JalcOrEOy5QukbVSp3GID7DM/thZ3jNzAnbk67/DcRZpqiS+ItcxSNdqlaAt0RSV4dQBPmpYE5sZ3Op9Xrj7aLmVzHwCewjMqOfEN/zCg82ftAwgvZy2V19P/jLJPmhYAMznMnFljjKEdZFoaZSOCpQUOKEFIi0IrG/qMat531s+uc3e/EJCDNynT2REz7a89YjGiVhVfCv+4PvohgrNoBJ1730noI91F66s7gF40H3ZXmUS5TaBQA+jiuERLa4Wbzna/M3ve2vGTklYfJjUjxmQC6Y106lzy0GtkF5bjxpY47PY3/0MP0U/s5pBxYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOcc8SPL5b2ijmoj7gkwXv2mFDycsa6o323XBWrK9MM=;
 b=KcPtPAJn8BCV6B9vT1O9Wx5JWcGajN31hNkGnRpaoYi7ELLH6f6SSizCZYxETNGBgQivSukFiLnLfVNUOG+XZLLFg6yzCwCILckuRSv9n8J3rKVU+Gafjehib32q9GVTV6H19VY0jkCPdkHoUuyzk3y5ApwjxOJLAi/xvLvG5S1NRCoFr1dZrBv0W5KW1wAKT47SQPclrqVEt7vdD8qLGfKZtcESqgpoCnv1QJvEcSFCWY4huZjQRF2eOqVvZJdjPBF5zt8d+Js6O19+GEyCoubaxNh1n0SY5Zoa8XeDgb/3/rQZ665Bm/WORJ5R2frJfPMngzGW9YU0aMEqd8/GzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 16:43:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 16:43:56 +0000
Date:   Tue, 10 Oct 2023 13:43:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v2 6/6] iommu/vt-d: Add domain_alloc_user op
Message-ID: <20231010164355.GA74795@nvidia.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-7-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928071528.26258-7-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:208:236::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4b631e-bb70-4bfa-f1dd-08dbc9b01830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V3dm2FArdbwfqgzH4CZf6G3Nw81sNmvPbh7+wtY5eAmUjWBgLQ6scsAb1t52yt8wyyIn8PXsQoVe3k8A4Hc3Da4ILAJge/boo0NgRovGH44zIzNAWsww8uFg/Y5cXULA9xliK5afaXOARrcAGlzwz2bcXI1aFGD41s0DaeThItfzz2PPAF+WG3OGO9iyf21j+vrSIfPMD6ybR9AXajTKIfQQrkVLopAsU9JXy+4+ZNC7NqrBRcU7xrl6EQFzxo06vLdA6UAMKxf7sVDsGHE1qvbPWSwxOu04iajrieTY0lWzZN9TP5hNVxc8zhBH3Ah9aSse1uP8TWOzX6iZ7LwjIYhQBVKutiYOzhv/c75Go3OidlSK1t3HnAELbGTJjv2bS/8GlHCdody3b/4iE7mnFKFU2M9moa2A5+Sw/IhhHxjMw2XXHiArU/OVN7ruNozR1Z/eKHtYVP22w0l1Bfr9+J9LQg2b6L77pq8oaUPQzwMs3mBThOy66u7uOFtW5ER/LnbvjAilWfORSCKA6wtVr5MWTkMNi01crCVjCWMRYZEbXbO6TyzrexrXIWnlTv/R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(86362001)(38100700002)(36756003)(33656002)(6512007)(2906002)(8936002)(478600001)(6486002)(8676002)(5660300002)(41300700001)(4326008)(2616005)(1076003)(6506007)(66476007)(66556008)(6916009)(7416002)(66946007)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XqhenXwuSGTZwC1PYLIVizv8AJbNL1/RNzygBIrQdF40KarUTXvNPvDWqr5/?=
 =?us-ascii?Q?l4inuk/4NNtHDdtwHVqBHRW8p86xQXtoD50SOmC0gwiS6oAiJnYePvJ5BjGv?=
 =?us-ascii?Q?06ezZHCxcgYc1iNfgppk7tMlH6k1TchLjbM4ct+9QVGeYcyVoybKIjEpCPw/?=
 =?us-ascii?Q?711avtah4U8DqGlVHned4rG5p+3g3smzBN24KuD5F23+pZeSnm3X6C/7ZXKb?=
 =?us-ascii?Q?PzvG4/6/zWHFtiouXGb3LeDvPplDbIbvJOXB4uq6Zzs4xj2Z6FswunlAP6oh?=
 =?us-ascii?Q?1qXJHjOdNALvW/4P8EkOQGkVZB80aB8AyocC1SyY6vJOOHDsAxP3p512oPY0?=
 =?us-ascii?Q?cNfZzAWtYrsfqlkxoYIiuQc14fAiIIIQD3+c9TA9wpp9maP5xAYvQSqTXgjB?=
 =?us-ascii?Q?E0wbOeWXXcnvNiIRMASadxqJBWoDpQJXjxSci2gUH/SLGuWshEVoyYOD1qJK?=
 =?us-ascii?Q?/QlDjs2sddfaNLynvN34Xra6Clzc+xBYVpBOYwld5j3tc7FLHyH5a6XfvBh3?=
 =?us-ascii?Q?zwk5ailj6AWhRrqX+H8CwHYlzfpx7hf/6USgIqB8YlLqzeA8iPaflOPC8hAX?=
 =?us-ascii?Q?BbWSB0dU9ptzsGQx7ie8vbBtLcLoPTgfvloQfFITpSYr/ylL1HW26f5P8BJ0?=
 =?us-ascii?Q?wLLOZhDX0ZSpALb+TGXUnhYZon4kuZY+ymTHzuwL5XDLHPl94kbTOE3yHNv9?=
 =?us-ascii?Q?4LDBouk6Hb6AgPSlBT3vwJHnSvknZqMtn3GZQo9S/Xy/0dntQCKdUyAKJKHh?=
 =?us-ascii?Q?iVcJ2OH0D9j+Or/uN+WcxpIbGMyL2SX4rPX79NRWjnsGSQ9MJvFnIM6cwmXt?=
 =?us-ascii?Q?3dcaqsm23RvGo5lein1uNn9P7AfxmqfEtupBHSbKWW7kCe/E4kgfkK2FzOnM?=
 =?us-ascii?Q?88410WdfOA/P91byK/swPJpvVkpQJrCBd3u1auCBGo0cScal9SQ1S/ojFSy2?=
 =?us-ascii?Q?1gnSMY5xwuwRX2jizpurhtqEbjEPb0YIhCqgQm0nHdboiVjoiaR0nko2aST5?=
 =?us-ascii?Q?oOn3R/W6vduCU4WJ26klG2WBWj/MkVYZ5+g7jJLA+qvCLNwQNStRE/KYWqZN?=
 =?us-ascii?Q?/ee1aLhgPFmreO8edtixdjUn63cavjwSdMktT4erS+s9hqQEzRUigS/WiMB1?=
 =?us-ascii?Q?POIoRAtFDLooaOm/BTY23muznvMcV5CxxeYWjRL/cafpX9359E59dbdIM8Wx?=
 =?us-ascii?Q?X6ANVE5VWsNXzCG+U5JwY9R4zsIjbgK9qeSqE4rpPTNCA7BHtkndFyUUu5u9?=
 =?us-ascii?Q?x9SKvcLe+EGSNsRzH54EpUqugFU24jLHfYmSxMNGkSer28DZyOGe+KX+X3zS?=
 =?us-ascii?Q?PZhoypyKTqI8AL1lQ1wIAcpcBkPplC0bhBxJMHkKj/rb/LgxHvIWaQuwRkYK?=
 =?us-ascii?Q?MYE15kkVcxRG8yRt4cOh4+4IYG2m7op7ao9+cmbqkM89IX/ajzbk5T8Mt8ix?=
 =?us-ascii?Q?36RxlYRb+PMCyv4VY+1C8ALdRe/KZC/Kp7z5OI1dltziaofteX1IYKTJgwnR?=
 =?us-ascii?Q?1pDbyh9r6RIzP8xTuMnNK9NQI55JIRkySTsa+3uWZDBNCocM9VX2ub0U3Xza?=
 =?us-ascii?Q?wLIru2iU1ythcZgb7swbRBrSEc6br+ClgpucIYfF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4b631e-bb70-4bfa-f1dd-08dbc9b01830
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 16:43:56.2387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/EwZwEU9cJLwK8IM9VKXGFuQhs0MmnuUOHPHUg792HbBZMf8gB+Q7giDgv5LpWy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 28, 2023 at 12:15:28AM -0700, Yi Liu wrote:
> This adds the domain_alloc_user op implementation. It supports allocating
> domains to be used as parent under nested translation.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 5db283c17e0d..017aed5813d8 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4074,6 +4074,33 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>  	return NULL;
>  }
>  
> +static struct iommu_domain *
> +intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
> +{
> +	struct iommu_domain *domain;
> +	struct intel_iommu *iommu;
> +
> +	if (flags & (~IOMMU_HWPT_ALLOC_NEST_PARENT))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	iommu = device_to_iommu(dev, NULL, NULL);
> +	if (!iommu)
> +		return ERR_PTR(-ENODEV);

Why isn't this just

	struct device_domain_info *info = dev_iommu_priv_get(dev)
	struct intel_iommu *iommu = info->iommu

???

Same question for almost all other calls to this function! The one in
probe is reasonable, but I don't think it should be ever called again.

I'm going to leave this, but please make a series cleaning all the
device_to_iommu() stuff next cycle..

Jason
