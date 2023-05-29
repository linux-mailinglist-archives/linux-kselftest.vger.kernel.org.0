Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1126715009
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 21:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjE2TyG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 15:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjE2TyG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 15:54:06 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A3BE3;
        Mon, 29 May 2023 12:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=II4Ze8D1bBl6eaifHrJj+2GSDtaI9i02ce2PCvMh+glVPxBciY1Be5PURsXxiWgKi4p4kHQJayrjSI0GBuvYSEr0gPhHkYke2AD2FCi3BmqbDtpKWYf8BpfntSode/cTRVC3ePanLt7+MUgRaG8xbZZD18797XX7hZ9HYRyBhO8ahlctgRJqKPpDQhG7Fj2EiyiXeR/GNf1fqV3iz+U1fHo6kz6Zp07xXXIH86rb1DM/WIoQiFg5E76k9QGG2QDLiNJFmDj35aOseTTAfbFHfPZy6e+Gz9JCM09ySUTvd+fKXtHyGQ0zqUzjsv8m8Ep8RTiQVH2tCqd6NgWV+05cfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+AfPmGaUE/yskb661oKdRI0Dn2unM3QaRPwJV1x1ME=;
 b=PbFhFGzo06IcxuZg5qWcU2fBZJrCu7jmyu9AirDJiQgrFZoeye6mgojS9fjfdK8WcB2KYB82PzGKnMawY0/qocO77tctXa0xmSdN4OFRD6JKvD9on/c5vdH02mtOfWroPf+7508BPmFvhl5nelVrmdb2V0JPAn+LWiZg1f/LLERlmtiUISLiRoT1kJ2WT5e3EoifQWKbe8g1qyvn1PvhqTv/CaS6nSMHSOvUm5nSvP0n2K7dFkJjOwaSWJmcb9PEt+WQvunV+z8dLygXi1gDHfrlhCNVYK5GaB7+zg/YucPyN90PgnzbKRkus+LLxz1lWPs0fVaLu8uxXwrnwIJbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+AfPmGaUE/yskb661oKdRI0Dn2unM3QaRPwJV1x1ME=;
 b=OHqHIn+hDahLIP8xpPHPxBdF42MXMXKdfxK8+WA9poNato9JsRRYeOey1+/VXG6HvEaaSmPJBjCA2MTo4GhTa9A49y/jLrim2GS01YK/FjzONDxh5QggD5rnfvnjE52fThcnxYN1s1yxwhaeAgZB28jO9dk9bp8kGnvDuf0D9Wphg2Ab+9708ghA29cKaecB0XPvOVpp/o8BTzjDXvK8FfbxLsqOIVHnpbIRkP1MpsgPoz0ek6ONUg7NcDgWvmoODn40JhRpaSs3V9ofV96mMaSaihdgcP5QSGaBWsVioSmM+I8emHb3nHmF7xfBWJQjdwsME4PzFr4ZVjUzWBWI5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 19:54:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.017; Mon, 29 May 2023
 19:54:00 +0000
Date:   Mon, 29 May 2023 16:53:58 -0300
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
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v3 01/10] iommufd: Add data structure for Intel VT-d
 stage-1 domain allocation
Message-ID: <ZHUC1it98cHN9lM3@nvidia.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511145110.27707-2-yi.l.liu@intel.com>
X-ClientProxiedBy: YT4PR01CA0384.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: eeae3df1-5986-4763-a920-08db607e7213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qoqPY2vWth9ZxswKMigITNbfNa5RS2u3Xcc/yz+FulPV+FTSJGBSoR0YTe48zTzJ61F9Tyk5fJdSNH8dRuaibUG2Y+fqE0Dyq4sOqH2680Ea/gyVAI92CCX7b8m1y1X22hB6Bpl3R/SIniNLk3N2EU3wPUiaN1VVbR37n/m6dfzeS9z0zaLR+Zo1uu0OZtjNHNUyonwyGt4GJ4eh0K6Cop9giO/XMBXV8Srmp6+n5iYIXCvtWJTTe/PycS/4FYHmnqZEN70Q256jAdIy7fihvXiZIoJgEcFw4fitqTas3wZ9tMCLoqK1jPGYYnjbI/L3qRWiBpjkgrT1bWrF/SFryWt5o73dLw7e03Y/ehAviWl8u91LLC7gAlXox4tNPFUWQBmBfA/BZ2y1TjMqDq+pOUnetv729XO7zHlTz2mrXaNbmxGOjKupFe1akgmbdGo/kKCs860f4+kLeLDfI288x1M9zmRKYuQOXc09YDGXNkOxdE0MdUVlPKv2lmYtfDI+NlvCMLrzFdEZ8icmSsSr6CJVo8ExLULhf6YWQnGcNKxqndwENG/XSp8hQkdLd4c4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(478600001)(38100700002)(66556008)(66476007)(66946007)(6486002)(41300700001)(7416002)(8676002)(5660300002)(86362001)(8936002)(26005)(2906002)(186003)(6506007)(6512007)(6916009)(4326008)(316002)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OwNSZK2cntSl+d97+fOGfKmlJ0KOJoJ2pSPiWlOIFU5NGNNVpGYmldrkkjP7?=
 =?us-ascii?Q?OmH+ey+FC88utrmHEwgoJu+k0SPFC0PrD7ImgodhNHUKFgYL4WlkpBhVZeSH?=
 =?us-ascii?Q?OYZR4c1YiiUOryd/vjATVaSbLFhE2KSmvhYbqDpX1JPMPwFapkn5jq1wCNaG?=
 =?us-ascii?Q?kQBBAGh4GRx7+0ePkkGV1nq28FgBONIsq1gvlKGpUcgF39scChfj9hDbUpzg?=
 =?us-ascii?Q?UNSb/oaphMNHgNg09zrPqxj/pM7CGDkTGfQADVd9JgpzGW9NuxtMVzSYL9OS?=
 =?us-ascii?Q?JAq6iTA+Eh8wMGZKg9XOD/+t3frFTrY7jaGa4hT18fi8Xu8fStAojbJKmCmA?=
 =?us-ascii?Q?qK+tWzQ5K2LOzrDp4KpbJyHYuAYRbdSVbJ6VBGEEHyt+by3Cv94zhbcUcht+?=
 =?us-ascii?Q?tkbpmqOiq/sSs0+rYSOI+WomEkAJbfaj2A/TIGxSDynAMrnI3U60cfc6Is61?=
 =?us-ascii?Q?MW9YhGRic/QJkaQHjCg3K/sznnb1B7Wmqwn6mERxsErJzpN90WPqcdYU/Fa9?=
 =?us-ascii?Q?QzMxVjxG3zr0eODjZAaa2/N3S/zKACQCh6lmCfVdvDyKQYa9mW5hSfGDpu29?=
 =?us-ascii?Q?+cPNStLS/59329uXLz8G9cns/REG7tunZjfoCI/j5PLoK6rwkppI9Yp0wdv1?=
 =?us-ascii?Q?DsKpabDhUCpfSe+v4Iqcyj4TXQHvFecvgVyjQUIRgHZ2bYEXD3lVxYg+r67G?=
 =?us-ascii?Q?dfkRf1SCAFwF58fhBWe/Byr/lVHMXtR4i9MB5L5CjnIr7Ru+YDZ29fBcvbUM?=
 =?us-ascii?Q?yV0Za+0mI7CsjYZJPIi/jzoNVgktup7Q8kk4WMekZDDCilo4yaxsuD6oC8sD?=
 =?us-ascii?Q?aV2g9pbgViqiZX8fT3nfJIUsKdPRiVqznra0UgP1D2ahfDwplJvVXOFa5k9w?=
 =?us-ascii?Q?bh1U2/djJ+/fmqgu5McqhNyxXdTlvff+TLWHikv6QEX5cxp9PlwUSeNw2k2I?=
 =?us-ascii?Q?BaBO/KPBAbgY+td8i7Xvmt85+vT7IZ4iqn3+XTFUdbVM8c2KMsVxBSpgHxwP?=
 =?us-ascii?Q?tsfDIPKb0UTNIIXyI3l8PKA8WziRW5zMIodzehMY241Keo17rzxaZ2nzrtxD?=
 =?us-ascii?Q?bjdJgkzw0a2EZoOBENHmQGv/M6NUWRFaYb/h6k6RauVUHtCI1tRqHbSAB4yT?=
 =?us-ascii?Q?fG5cCEoTl+ZzOnRNgnYkL6EvIx5pVIWXzT8vQYSCy2MiFcIaRb87hxjmi0ex?=
 =?us-ascii?Q?ah/u76QbdvMpAvadawB3v+yHZf3L0N5fYuet+RseBVHk5WVgXA1TAq6fZxMT?=
 =?us-ascii?Q?2YdteXPubXV3NbmeNDFx9U/syFEMnqImW3ebyJOc1RyERoo2gjpz8hBbYreb?=
 =?us-ascii?Q?sCp5CPeljVq/o4gypYV3hzPioJQfzTTrrNe0GTqjOdvzcj38w0YuW8F7TZx8?=
 =?us-ascii?Q?VY/jwJm3WC6y3XbA3PvXUqBF4wBn6IkLHuyatjhdpYI4yIhmC8SND7OT8AgL?=
 =?us-ascii?Q?DP0sdIhdzNHTZlwXFEzyAe23a2hq5/zQKwHbOg805G6xzorBVvFbrzSIbEFj?=
 =?us-ascii?Q?hF0r/aX5nYYJWQTEqCEpq/sQthIPGK8NxJE6tpFLiKi0faM1cz6TF8b0viVm?=
 =?us-ascii?Q?SxZGnq4LKBHlOBmGKWwa2cGCZ+Hw3mS8nYWzLQqx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeae3df1-5986-4763-a920-08db607e7213
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 19:54:00.0302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baAyoxB2k8fUWd03DX8zPq5Iob/zj+C1fRdCvLRBd6yUju6an0rKdUyvVak5+bfs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 11, 2023 at 07:51:01AM -0700, Yi Liu wrote:
> This adds IOMMU_HWPT_TYPE_VTD_S1 for stage-1 hw_pagetable of Intel VT-d
> +/**
> + * struct iommu_hwpt_intel_vtd - Intel VT-d specific user-managed
> + *                               stage-1 page table info
> + * @flags: Combination of enum iommu_hwpt_intel_vtd_flags
> + * @pgtbl_addr: The base address of the user-managed stage-1 page table.
> + * @pat: Page attribute table data to compute effective memory type
> + * @emt: Extended memory type
> + * @addr_width: The address width of the untranslated addresses that are
> + *              subjected to the user-managed stage-1 page table.
> + * @__reserved: Must be 0
> + *
> + * The Intel VT-d specific data for creating hw_pagetable to represent
> + * the user-managed stage-1 page table that is used in nested translation.
> + *
> + * In nested translation, the stage-1 page table locates in the address
> + * space that defined by the corresponding stage-2 page table. Hence the
> + * stage-1 page table base address value should not be higher than the
> + * maximum untranslated address of stage-2 page table.
> + *
> + * The paging level of the stage-1 page table should be compatible with
> + * the hardware iommu. Otherwise, the allocation would be failed.
> + */
> +struct iommu_hwpt_intel_vtd {
> +	__u64 flags;
> +	__u64 pgtbl_addr;

__aligned_u64

> +	__u32 pat;
> +	__u32 emt;
> +	__u32 addr_width;
> +	__u32 __reserved;
>  };
>  
>  /**
> @@ -391,6 +446,8 @@ enum iommu_hwpt_type {
>   * +------------------------------+-------------------------------------+-----------+
>   * | IOMMU_HWPT_TYPE_DEFAULT      |               N/A                   |    IOAS   |
>   * +------------------------------+-------------------------------------+-----------+
> + * | IOMMU_HWPT_TYPE_VTD_S1       |      struct iommu_hwpt_intel_vtd    |    HWPT   |
> + * +------------------------------+-------------------------------------+-----------+

Please don't make ascii art tables.

Note beside the struct what enum it is for

Jason
