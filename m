Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17A97BC6D1
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 12:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343804AbjJGKgT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 06:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbjJGKgR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 06:36:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0139E;
        Sat,  7 Oct 2023 03:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696674976; x=1728210976;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=3ewEelkA+DkD9uq0syO56lDsIyIMYPwZZ9ehxn5JMEE=;
  b=MJclNnrEpwmvopEcIh9r5zqi9bEIlDrHQ7IoVKrlmymggaDB/xroAzz1
   HuxrwBKRrREpPXSupC0DKb4+kniwb3G+Fn99vthAhXVP9hhLJ8PysvvYg
   mNdyA2NDDRhVpti9glmayEk3p6IwWZ9F/XRRwJg0YLk3bqUXlIAeQkqW7
   GPENjssoX8W9AUDEuYpYU5YNMOQa0rdbx1TC/PePLRGm2gu0jKTpXheCX
   phyTIT/hiBJHaBibdGWyGXTQAjIqSEAqrFZ1BfwjYBaKaUvm5HjQibXRj
   sKnWpmyQJIfdKa/8U0UrdW0HidKNhmAci+9Fbv90OHa4r7RK7OEfBT/Xh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="363268139"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="363268139"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 03:36:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="822816810"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="822816810"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2023 03:36:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 7 Oct 2023 03:36:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 7 Oct 2023 03:36:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sat, 7 Oct 2023 03:36:15 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sat, 7 Oct 2023 03:36:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXKyB4e8AW0WRRnWGtRCDl1DkaopmFvPd524HIBmVHl3sZ25mfvE+jFrgAJ1cw2ClqL89opzL/HYQx3rxPW1N2LmXWpq3vpafA02MSvl8Rbhgmz+KRqDJ8NEeuq8aAcs3na9Rg+3YSgwjuT1OFeY3rdLN5+FiKa19CkagzBzUpGRbZib5TRIZYZI20tHiaWPV/M5FUDb8qe9EtN3GmGctxu9l3Hr0l2FnD200fJhf5D9oCIg7nfoGkfJaHnbfvYRvUYDBwMA0b5dwwYehvaQC53xz45mvM7YjRPt61mDmSwQfkx8m31tYnqmDtgsh6SJ7GjmKo+kho4m7McTYq1T4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiIpaaWK8nlTA9lt3zCOCL7HKOoDwBRU5KZvOGJ/G0w=;
 b=WtMH2IPv7LDHM4KanLZtSEF8yoXsG0ASxstr7JxqJU7bb/kTTLa65RYYiU5XeDQPEvAuT5DghhoosUpzuNZlgBAIE791aaSJgIY6iBjCE5FOWKibsVwzRbLqyfXce5Etk8RQe+8tiQRFxcnxWvO7FU6th9sA+Cp4US7KihOxMRMGzEBZ0qIJhPusxZltzge4JCYuc5U7JFuQa/YV6xaqu9NhrbAe/SANQcE9AhsrPeKhSsUWqPKuAXmQ7310QKu7cjOr7Fo6GnYsUyExYLu8H++c+LdizGFZa54gPt89WB8pFtlia8XuTvguRA3Vtz7drFiV7t/xJ0VhczDgIbJZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 MN6PR11MB8195.namprd11.prod.outlook.com (2603:10b6:208:47f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 10:36:12 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::5e79:2d52:51e:f602]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::5e79:2d52:51e:f602%6]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 10:36:12 +0000
Date:   Sat, 7 Oct 2023 18:08:05 +0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     Yi Liu <yi.l.liu@intel.com>
CC:     <joro@8bytes.org>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
        <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 03/17] iommufd: Unite all kernel-managed members into
 a struct
Message-ID: <ZSEuBcLaSq4NjoC8@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230921075138.124099-4-yi.l.liu@intel.com>
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|MN6PR11MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b37eb30-3195-41f0-5acf-08dbc72139c0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFfqHjxenSTUyOPwCChjESHqx7y6JO4Q0TD1YwjgzfyxXzQoE3PRrMC5nApcCWK0AQeXQij/XxkvygTep5er9NO/tVE24l64RKHbrVawIwCtlH/NGRxqjslGdbX0YUYdsmhm7h7zpO6zisw6YeGQxeJF6HbVg5qiJxKpjuqdIqbmRqJpOsF8xcximWl90KU0D6/CJM4ULU2/uPHx82juVfmgfTDVWCtjFlJHywrPAMiZ8H+JF4+WbowDPlhI419RqzqvG3kIjF0ytaAcFeE+DlH6yg9AwGaJ8mjup9QBVkebSSkS99PY9vpd/TLoGSceLhwKEOniMK/oIyxV0pYPZ0XPuWlMa34ih6n4vmVgj3HqO5Ouv/bJF5stDkJbiPyPywwi+ZC3b4mpraA+/7R+x/oXHqpr0+PZZuqHQD/MXxwST3YCEDSKRbjwtL1dxDKmE7yhUin72wtbUD6gXvRFxiWcBitYEwEnDOnVuVlh8Fmidfgq6a+ogdnSuVpxsQKKu5URa3QwdfS14c3g1jpplsNhP2frQ/+Q4lwEDTm2z2DYx5bRjN8enrFmfZ2pSBPX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(26005)(66946007)(66476007)(66556008)(316002)(6636002)(7416002)(8936002)(8676002)(6862004)(4326008)(5660300002)(41300700001)(6506007)(6666004)(6512007)(2906002)(3450700001)(6486002)(478600001)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9EDe8ugVmNDfR8cP2O/GVTYAkLVAiqGrstOIstnW6v0dM/REpHero4epKBdi?=
 =?us-ascii?Q?SICbnrIeH3iEgqiw8KrAmJKs2Vy32ddQcHkbPicjMBW9H5cwz4LzAPhnZBeL?=
 =?us-ascii?Q?f5xu/rkgTphjbFoYI/8ZpCD5jNiH3hEKuuDeOZkYRfzVuN1n+W2pkiVHMKjm?=
 =?us-ascii?Q?jq7GS1ayJ93/cV81iN+ofO4oyrbVYkK1sb2QK6/HODfZYQXvoyGfGg8+W7b6?=
 =?us-ascii?Q?AapQWMGgjSDmcQqrt4yMtMmbTGIQplihRr2Bm50apIzSRvOQBH4kzmEz+PXY?=
 =?us-ascii?Q?0Rp27giI/zXhrwmx+oiPFCFuxuUcbq9lwZdckKRbkU+Z0Q1XIv3Bla/pSmt7?=
 =?us-ascii?Q?k9E3dfiYG1S6W1yHtrM2hqYo9Fjs/TDLCE8KamEOGyXvj6G6rGELHE38Ykkj?=
 =?us-ascii?Q?RciS1DDF1TOVbtVFXt+thCfg7G+TGzU5X52zTwp6SlPUProGtWWWAMHtlbJj?=
 =?us-ascii?Q?Jgv0Jf/6q5UzSMQOzuBNKG6pkTkbathxLuExKa669l3PBsPXhIVH9/C1qZ2o?=
 =?us-ascii?Q?DReoh9X+jX68gXCNrqYHfPsbA2outJexQT+l8poK3kyH2BqQ2DaLFdcQwwT/?=
 =?us-ascii?Q?B5/F0MhYfJ48Olv75/U53t8aiTZCGiCW+oHnKOkTzsNS/cOmZddJjVFw0V/X?=
 =?us-ascii?Q?rAUcQ9AlopL/za1fxTnlE70rTQYXiLVo2CFfwb23FwRbIVY8H8B4H15hd4+W?=
 =?us-ascii?Q?xjHttFNCVSGjNcFn0j1P0YA3ts4dJEiK9WIM+KzvDFI2jnIrikETliA/Fr5Y?=
 =?us-ascii?Q?34At6Q9yJud/6N80GVhg7Jobki48d0YVD0WYeTg7QEfA0DqQRDWUlIZ6OW82?=
 =?us-ascii?Q?Wm8s/i2EATMQ2agq5n9ywpdIAI20whmkyfBlGgWrdrN1pq3JgBRX8wyHRfnk?=
 =?us-ascii?Q?0tEYt79/Vs6T9UxHc+bgAH0qpp0ocG02cuO7EyLC0CuVgYpQn88ydfjSQVS4?=
 =?us-ascii?Q?9wQ0j6qigA1qb0tMEeiC1y0+cyysMwsp8wmWdDH/DJDVJ0ocj+nlSvaAToqJ?=
 =?us-ascii?Q?tl153dt+hl4AaZSm9jEjaX0DBotiwrwv3yr9gw64c/psehoXZLzIgEKrKl3y?=
 =?us-ascii?Q?RFHOABB9HJ/qEnJG7bZfXRIiIPVKfJhCq+Eetu0OL98MFNwvdThuzefUP4RU?=
 =?us-ascii?Q?j91a5LYCvyzU5/vm+QpsWOuLbbi5QlvLkQjLcUhfgZjzavG+U6HsL+Ye5+GH?=
 =?us-ascii?Q?dT6vjGgVrXIXq/Eg0XJ/rkQza4s+ZMX2o7aR5GRsO6ET+sa8TyU2U3Sx34ZT?=
 =?us-ascii?Q?jf0Kdigae4rDervGgef7ovmkv61ryju5Nhs/RjwhrJ702SlFCrzJXO65J/qi?=
 =?us-ascii?Q?iOqDBAWJi9KOyxtayed8KeM4UdGUOCeWMzfKm3csRX4ZiUqq95/NiPIVKJAu?=
 =?us-ascii?Q?VdFKJs23tRPL561No0x6IcbHBiD6mbtNV8yebq6MI1xEWW9wGqmKbc0pRIU1?=
 =?us-ascii?Q?tWJ1FZHNFBGqmYdOelXuwZjkKw0olzB8JS7/bqmiBhgotLOa+t4rUdGAuTRT?=
 =?us-ascii?Q?h7ZRoYoeiXhMRJJSNPulrvqEL3rdcx/A0uVH04pNV55prhGMuDSBaIWLjoeX?=
 =?us-ascii?Q?H/ZV2Gqwv7EvdWgjRXNxjvA/0Am4Zl6dS1tyUxc6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b37eb30-3195-41f0-5acf-08dbc72139c0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 10:36:12.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6sOuNjcw2RI6q1iPRpWbJjw4c0p056wbRumPShpwCtuAWDncGpW3njqnN5iYW7BDLxBNR96nFtyxRr/U2BTWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8195
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 21, 2023 at 12:51:24AM -0700, Yi Liu wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> The struct iommufd_hw_pagetable has been representing a kernel-managed
> HWPT, yet soon will be reused to represent a user-managed HWPT. These
> two types of HWPTs has the same IOMMUFD object type and an iommu_domain
> object, but have quite different attributes/members.
> 
> Add a union in struct iommufd_hw_pagetable and group all the existing
> kernel-managed members. One of the following patches will add another
> struct for user-managed members.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 3064997a0181..947a797536e3 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -231,13 +231,18 @@ int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
>   */
>  struct iommufd_hw_pagetable {
>  	struct iommufd_object obj;
> -	struct iommufd_ioas *ioas;
>  	struct iommu_domain *domain;
> -	bool auto_domain : 1;
> -	bool enforce_cache_coherency : 1;
> -	bool msi_cookie : 1;
> -	/* Head at iommufd_ioas::hwpt_list */
> -	struct list_head hwpt_item;
> +
> +	union {
> +		struct { /* kernel-managed */
> +			struct iommufd_ioas *ioas;
> +			bool auto_domain : 1;
Will iommufd_hw_pagetable_put() also be called on non-kernel-managed domain?
If yes, hwpt->user_managed needs to be checked in iommufd_hw_pagetable_put(),
(e.g. as below).
Otherwise, this union will lead to hwpt->ioas and hwpt->auto_domain still being
accessible though invalid.


 static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
                                            struct iommufd_hw_pagetable *hwpt)
 {
-       lockdep_assert_not_held(&hwpt->ioas->mutex);
-       if (hwpt->auto_domain)
+       if (!hwpt->user_managed)
+               lockdep_assert_not_held(&hwpt->ioas->mutex);
+
+       if (!hwpt->user_managed && hwpt->auto_domain)
                iommufd_object_deref_user(ictx, &hwpt->obj);
        else
                refcount_dec(&hwpt->obj.users);
}

> +			bool enforce_cache_coherency : 1;
> +			bool msi_cookie : 1;
> +			/* Head at iommufd_ioas::hwpt_list */
> +			struct list_head hwpt_item;
> +		};
> +	};
>  };
>  
>  struct iommufd_hw_pagetable *
> -- 
> 2.34.1
> 
