Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539E476F81F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 04:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjHDC6k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 22:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjHDC6j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 22:58:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2743AA3;
        Thu,  3 Aug 2023 19:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691117917; x=1722653917;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z4LB8RNSm2kn25FS3xnbneimHurzuBCfFzvEVLw/4QA=;
  b=bcq/X9vF4lmY4f+NjuohMZDPQnfVtqiaI+QzIy3vqw7rPttC/2KojDW3
   DbcxFVemCFSCsbaRNyLJxVerxQULz4+4z4kq3h1gAWuR3n6vhzCpHqomC
   G5NrpjPP9psqKHuMGMYPwZgWGh32UwgiiJhj9ogFgS8pgJasqBR8fNYhE
   uR2/yBKUGm42U4Mc62i73fQWNJ6k9tx6SOTdE6STHKDjO5OLoijA7CyuA
   /ToBQUhzIJ1iQ7Hr/hb2aU2LpaNkBlemFRGynWh+pwlolefH1owg5vq39
   9B4RJLgg3m3Qab/o2pIm+K8wkGPjjvOuDucdmqqvQKhFg2/upjsu3ueNu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="373694035"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="373694035"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 19:58:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="1060543528"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="1060543528"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2023 19:58:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 19:58:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 19:58:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 19:58:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 19:58:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvLn6dof/WQWcn73u1TCzawrWjOFEz+IwmZ+qaIwSYzO8iK8blXbUbyS8h5eAxxzfsLeYwffNek+qEmfwygCbunrMwkifGbLfDBcrOdrqRarz7NxVf/y1XjHfdFi/oqogEnzCewDn2ZLOsZPA5nAJAkl2sV/TpNQd0cCyhVJmzbN6S3xoNuhb8Mn0rEyfD0jD2Q45OTSkndLTTIJ7t96ENpHe77+5uXKlcUWbhJgtH2GzKJwePK4VPi80stsDjms55a+xydjvaTAV6ROWiqHHBcw4TDeuPXlvtnE8kq/f7Cs4Ia/NC5UtNumzABUN/NKxtuveSDFUXwZ202dsYrY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYo1z/+/YarQJNz5x6toQa2zERtje0/YAlQIsLUcPoA=;
 b=OOXZhTsplXm50Mkm7kJhyzL2/SkhTXsmbClRZTvpP83iO3cCrScQO1kY1PWX6fT6NlwXFuCbGgn6XwD2atJ3IWkrlBMLg6+uGuFKWVe/OdflLNH/h9UNO02vNkTowzr5DtzgfODmAVkqeuBEZZ7PgYjzULxbusR1IYuLf3yNomlMFhUJBWNNoHcOgyOc5FDFGGObyEi/4XWfOukxr/v44zcKPmucEddCuHe0fPAFCbJYXDq2dAZP/XPmH/bBlnoNUpEhNwkKGEm54p3MIC+ChRxn6VZWKfjwVQS3Fr08r9XTOPyHcDIPU6uXUzK7D//sjxzNAOHAG+xviLLUpflCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by PH7PR11MB7498.namprd11.prod.outlook.com (2603:10b6:510:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Fri, 4 Aug
 2023 02:58:31 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::4e97:daa2:4c07:fc9c]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::4e97:daa2:4c07:fc9c%6]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 02:58:31 +0000
Message-ID: <fa0f5283-fdc6-1cd5-b34d-dcdc86856ad1@intel.com>
Date:   Fri, 4 Aug 2023 10:58:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 2/4] iommu: Add new iommu op to get iommu hardware
 information
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>
CC:     <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
        <yi.y.sun@linux.intel.com>, <peterx@redhat.com>,
        <jasowang@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
        <lulu@redhat.com>, <suravee.suthikulpanit@amd.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>
References: <20230803143144.200945-1-yi.l.liu@intel.com>
 <20230803143144.200945-3-yi.l.liu@intel.com>
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <20230803143144.200945-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0148.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::28) To DM4PR11MB5469.namprd11.prod.outlook.com
 (2603:10b6:5:399::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5469:EE_|PH7PR11MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a93394-173d-4bd8-0774-08db9496aec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NisiSmu1w/pN0+ZuwK4G8WeKUG7D9+hC2cB7SzYLdPQjQf5CGD4n8peX0XYf4Kw3aq4k+RI1VIWPUlmcg1b7m3+Kzx33fUp42GJc05BYSwAjB3kPP7YB4l/fKUUR+LWj7yEay4K8uWfTbODbx45b5GgYHLo75SPt5azbakn6VqQxXRM8hjHvYoD5N8VYC835cW+6W4P4C/z48uB9EU1rDWXVEPR8bEZIvDcE23/aP8LnShbB+6gQZS1SsOOvDAKRBoFXBqK4GIyD5trXccvt8etgG1LdgApizCSTOMT5KI4FuOzQFrrBDmQLcWuSYwFfm/4+wHFccWj/hNF1rX0izZg+qFJHCsHJxP0Wm2wuVDqoZplqzAcrNNfMwPGxuXHu70d4NF2SPfg0ZDfC4XQafG5HeX3exxbLnyN7jeX/+4iuuv+PQ2qpiDqfaNulZMlU68BL3Ch+7KO4roMRbdYNFLrIzfJORGBba3fJME+5LOTlTcKpmPruFIac5l+5CPmRnepVImxD6WlUQ93NOFKlOo3bFhCo/eGPfdrl3srLQA96bFuEJFuH31EuGGygFJMyZJmiPK7LPGO4rRi3LozHWq/hkB8dsv3kuZLJyXefhRAJVn7rUY2usyXA1cFKdD5dLFazBbcMVkkQiUmR44WQFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(39860400002)(366004)(136003)(1800799003)(186006)(451199021)(478600001)(86362001)(31696002)(6512007)(36756003)(6666004)(6486002)(316002)(8936002)(8676002)(41300700001)(5660300002)(31686004)(4326008)(66556008)(66476007)(83380400001)(7416002)(38100700002)(2906002)(66946007)(26005)(2616005)(53546011)(82960400001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkFzb0lGd1YyYWMvRWF6ZDkyVGs3dC84KzkvYkJ6ODAwck85WTlBY21CcHUv?=
 =?utf-8?B?aXpNNUtPOFBsd0d5d1g0ZFQ0OStTdjhaMVc3MWdQdUdITXV4WENOWXdqOW51?=
 =?utf-8?B?bHFqWnV2SGQyVnAyOENpckFIRjBtcXZzSnFUaUtOTi9FaU1waXNQRnk0b1NF?=
 =?utf-8?B?NXZhWjIwZTVCQndpaTRJQU5PNWtJREFzZXVvdTh0WVJWamlmVHZtTldmWWNt?=
 =?utf-8?B?ZzBHSDJ2V25lUzljS1dONEJyeHBvMjlHRFl5Y1A2ZlZKR3RLNmdoRjhacFVC?=
 =?utf-8?B?VDVzWCtPeW9ZcHl3NTd2QVovRFVkVG1xV0MwWWd2N0dYemN4TTRGK2JXUE9L?=
 =?utf-8?B?RUQ1QkVHQ2pwN1cwVFFIV2ZndHVpQ2ZwbDViVit0STYwMEpHQ3Z0U1JGQko2?=
 =?utf-8?B?WnJUUmhLak5QVUw1dEhwd2hEUFB5ZzBES3FIdlFTQ0tCN1VhK25xU3hPWUtW?=
 =?utf-8?B?cU9WM0pSbWNoRm9DZE4vV211MFBmdWtibVlZSy93WmJTWjhDUmI3UXA0Y0JP?=
 =?utf-8?B?UU1QRDJHYXcyd2ZuRDlXVnRFK1RCZWJqaXNROFpNcjM1R1JleU5MV1F0UnR2?=
 =?utf-8?B?SVBvcmhWdldsMW05RnBEeGF2bXkzWGZYUkRDbm81UUlCbjZTN2NmcEU1MUNV?=
 =?utf-8?B?ZzF0a0tQZkJMc1JlZ21PQllId0xvTHI1eE5ZbFluWTdGUlVJQUwxNDJQMkdS?=
 =?utf-8?B?RWdzWit5UENjaHFOQ2l2aERWWTNmZUErRjg3dTZnYXZvaE5IU3BOUlM4azgz?=
 =?utf-8?B?bEFvbDVUMkJKWFpZeFlsd3dBM3BxcDg3VTE2czNNNkc4bEpmQ1E5ZmtDZGNZ?=
 =?utf-8?B?RlA3OWFuWXN5Q3VBbnZzSW9SK3JyclowMmIwKzA2UjhzZjJpV0M0VWZlaTZv?=
 =?utf-8?B?bi9tYWJ6VUVqazgydWRpdVJWYkJWMDJjY0pxWTJDaHpmR2htMWJNT2R3WTg2?=
 =?utf-8?B?VjZZdDlKcmFqdkVmeUhTUGtDd0JTWFZnSHNFTGRKR1FUTERsa2NadDhmZ01K?=
 =?utf-8?B?Z0NSZm9mSnNxckNSc2J6VEdEemIvZzZKSkZjYzBwRnJIUWZSQmFEK3dTZDZj?=
 =?utf-8?B?VTV0S3M5UTV1S2EwZUdIa3NnZENKYm1pRjFJYlBlRDRHMTZCZ05QTGhXSUVt?=
 =?utf-8?B?ZWx3L09pUk9KQ3M3NC9CbGNZb3BJcFZUVkt0TlhYV2d2ODYvVVg1dGZBWG9W?=
 =?utf-8?B?ZFhSTXZNMlhLUFRla0pPWGRXNnNpd3A3a3ovTVFsZjBoRkJibHQvTlFIUU5t?=
 =?utf-8?B?U0hSTDkxOHU4bGltWGZyRU03anFIS3BNVTJ6bXVtMEtqakNYWW9JWFdBeDYw?=
 =?utf-8?B?NGdFeGZQYUpoUHdlYWtqNWFzMmEyUU9BUzNGaUNsVG1BOCs2VWhVcjR6dHNm?=
 =?utf-8?B?QjI5SmFrMEZ0VEFIdC9YWGwzR0RZZlFPaTBuc0EwVHRWckhSN0djY2xnbnJo?=
 =?utf-8?B?czhvaGJlRVlMa2thWDFLOFVieWVLWnFOVzY5MlNKZGttMm9zTnhUOGo3OE1u?=
 =?utf-8?B?dFhoNThxbm9aUG16ZXJBSW9HeExQNmVVMitXMVl1Y0N6RGszOHRNS1lhOERp?=
 =?utf-8?B?a2lTSVkwQzM0blJvanZ6TXp2MVlBK0FYQ3hHNC9Oell0RVFmRHhZeFc1Q25y?=
 =?utf-8?B?alltZTBjU0Q2c1pYeno3aHNVc1UxVGdXL0F0QnpGVjVsd2Uzc1RtL0VQWVZQ?=
 =?utf-8?B?V3ZTMFJvVWJyWmdoV1NndGJ4SkZjeHFoYW5JYXM1ZGNKMGZJUmd4UXVjTVVt?=
 =?utf-8?B?a1A2RHoreXhhQzhyRHljSDE2WVg4MG00V3B4ZjB0SDBqVDRZWXVlUXdpRmFM?=
 =?utf-8?B?RU5YUFlrc1VDTUJFMXJQazA1SFV5dGgxRWk2RHhXKzVlYU1COE1FcnFFUjJr?=
 =?utf-8?B?Z0tyZHEvL1JLRkt6dDVSWFNBMy9GYXYxV3dxNnZoaE9vN2RldjNsSy8wSUxo?=
 =?utf-8?B?MzZWSFBBZXJnbWdsQlFEemprTy9YeDFiaFlUSFpLeTYzNDFoVFRtS3p6RWhW?=
 =?utf-8?B?VWRPbnNLaFFOTWRTZGI3YU8zbjlvWGgvTGVJeU44WWVFU0x0YlVTak4zSHMv?=
 =?utf-8?B?NUF6RHd1aG1VMUN0cktwSWx6VjU4KzJYWjRkQmtvSUJiS3c0Z2E1MHFRc1pR?=
 =?utf-8?Q?JZCg9HYwG2PzYph8AbiVmnPEi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a93394-173d-4bd8-0774-08db9496aec0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 02:58:30.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dso3QXZ+sYt0zDXkBgJqKvBQrOCyqM7CVe6Rm/JYT6LP+qHCeKgPFdNvURLDxNRhzfYC3bP5MJz+rfPPp5yuJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7498
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/3/2023 10:31 PM, Yi Liu wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
>
> Introduce a new iommu op to get the IOMMU hardware capabilities for
> iommufd. This information will be used by any vIOMMU driver which is
> owned by userspace.
>
> This op chooses to make the special parameters opaque to the core. This
> suits the current usage model where accessing any of the IOMMU device
> special parameters does require a userspace driver that matches the kernel
> driver. If a need for common parameters, implemented similarly by several
> drivers, arises then there's room in the design to grow a generic parameter
> set as well. No wrapper API is added as it is supposed to be used by
> iommufd only.
>
> Different IOMMU hardware would have different hardware information. So the
> information reported differs as well. To let the external user understand
> the difference. enum iommu_hw_info_type is defined. For the iommu drivers
> that are capable to report hardware information, it should have a unique
> iommu_hw_info_type and return to caller. For the driver doesn't report
> hardware information, caller just uses IOMMU_HW_INFO_TYPE_NONE if a type
> is required.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   include/linux/iommu.h        | 9 +++++++++
>   include/uapi/linux/iommufd.h | 8 ++++++++
>   2 files changed, 17 insertions(+)
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e0245aa82b75..f2d6a3989713 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -228,6 +228,14 @@ struct iommu_iotlb_gather {
>   /**
>    * struct iommu_ops - iommu ops and capabilities
>    * @capable: check capability
> + * @hw_info: IOMMU hardware information. The type of the returned data is
> + *           marked by the output type of this op. Type is one of
> + *           enum iommu_hw_info_type defined in include/uapi/linux/iommufd.h.
> + *           The drivers that support this op should define a unique type
> + *           in include/uapi/linux/iommufd.h. The data buffer returned by this
> + *           op is allocated in the IOMMU driver and the caller should free it
> + *           after use. Return the data buffer if success, or ERR_PTR on
> + *           failure.
>    * @domain_alloc: allocate iommu domain
>    * @probe_device: Add device to iommu driver handling
>    * @release_device: Remove device from iommu driver handling
> @@ -257,6 +265,7 @@ struct iommu_iotlb_gather {
>    */
>   struct iommu_ops {
>   	bool (*capable)(struct device *dev, enum iommu_cap);
> +	void *(*hw_info)(struct device *dev, u32 *length, u32 *type);
>   
>   	/* Domain allocation and freeing by the iommu driver */
>   	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 8245c01adca6..1f616b0f8ae0 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -370,4 +370,12 @@ struct iommu_hwpt_alloc {
>   	__u32 __reserved;
>   };
>   #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
> +
> +/**
> + * enum iommu_hw_info_type - IOMMU Hardware Info Types
> + * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that does not report hardware info
It looks like this:
/s/does/do

Thanks,
Jingqi
