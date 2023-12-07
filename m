Return-Path: <linux-kselftest+bounces-1338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DC6808143
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 07:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9054F281A9B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 06:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7466414016;
	Thu,  7 Dec 2023 06:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULQm65wq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD47E85;
	Wed,  6 Dec 2023 22:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701932211; x=1733468211;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U/ZKVdQtJl6Dx4jvbgWm23xJxD2HfGnoxmKWYTLbtt4=;
  b=ULQm65wqE6gV3FqoiR2O40wy/oq+t2fAbeRuGWpLTXUwCTJsmcVgm60z
   gUPzPJjLvVjC7ksYYfeh26eC3TntbV/J+7QIp7xuaj/AfNg64qjFdsDkv
   rtKW+7pvGIa9n0UXvn0UdGk5G91U8qEmem7tAZH6274sy04XaKfYEgbSB
   HcmuECy9NMi5x5FZvUSKG7keexNtKhqD4e520xgiFkC8KwtWflMLJ3eYH
   DCmA3s7I10f6yVq86AnbnGbtV6iMl6E62KogbKSQWYnPE+T6STt7kFfyE
   MhNkNHFtqdPH2Up05I5ob0sl0+hJuvR2cOfVtHqyfxf3FqQy7yPgH+VHC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1268487"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1268487"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 22:56:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="19605236"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 22:56:49 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 22:56:48 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 22:56:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 22:56:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 22:56:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tx1UoPkuPy/04Y2W1AopdLb7lAzVgrkMYDCLxofzQc+nmGG7whsQnvf3fOT4oibFHvYCTx5ijKJp/bzyfDyOoYy2WlHYN6ETE+VMKHTD3QEHTwmKfWiXSv2ldV4LO/TYqqbJnLptlJ19LEYrNjTNv4GAW2r78nbmlMg53BlJAA3du61RFdgukBqF6vLPuMQbLcj7xCEfcM4ss8ix3rOw/OFYWVCxLhXrk2if28uK6dO2VUGbgF1srhBFZGLc7X3hqocSx/zXAgZ+Y4XhOKbj7rjK2vMAFifLJXlHel6IXoyYCykBPH/9NA7KvgDuXIiZ3xFSVDh2PpSWxIMQDM8xMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozVnRYo74LPOYXr4kP2Nke5/azj7Onm9ehPVO2kIOYU=;
 b=MBl1RZ8W65yR8k+MbXxCLZtIXMkHijka0yh+W3kCCdAo5rnB05hGjpKLcgJabiBYKCsH6R+w2l8zMintn9lRRYclJGautD2oaPz2jivgfGJx9HG8TKNOWfnOIHbr9mvahjwAD6295MfwAIE5MV+Lp+PJlDfJ4gzOJZKYMd5aFOvfXpKlX0K9q9LtLVx3uH/yb8SH0QnDw2koDL7g84jqEtdbup+gmrtF3XLArivR286AvQdEHj0gczrV5lNfFH0n21ufecthkQK2snzTqQ2cFSUezvftoZM3YGHKYzflj7f/Z0qAi6vVer3DOHUj60IoNiORmgY5hsrb7gbOc9JUvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY8PR11MB7900.namprd11.prod.outlook.com (2603:10b6:930:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 06:56:46 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 06:56:45 +0000
Message-ID: <112383df-3ea3-475f-963f-5c53232a1bf4@intel.com>
Date: Thu, 7 Dec 2023 14:59:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Content-Language: en-US
To: <joro@8bytes.org>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>
CC: <cohuck@redhat.com>, <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231117130717.19875-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY8PR11MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ca386a-84d7-4be9-22d7-08dbf6f1acb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HR1A/jZuaI7J+fQfJrbD1HvQukPNGtYFg7dKHuYeSu9wKFCMmgzZqNLzGx72cmORYF/N1Gx6O+UdeEZGL7nYudlP2MAsJstX54/alNWeki9zyMWTU/YYuQtjUvCJuekBpqSd6Nn7PfjjmgkxCS0xoUYfCOqGpcyoYYjS12O4tOfLPTK51zBD2xOnIeloqvxBXuaMCTK6BX79m0A0SpBuiCkQrNn47UlVsMCTbey+WmbnfdPpmr5DQV6+edQdeeSniLGXU6Qc/SA7JBOKvCZcUYf2FvPAPMLC8omDtCpi4afv19/AgybdRa+8x5SkByHI3DXzt8wKtMVBMoj1LotGip58PryJBbfvz861cuAvasX4twljZ1Ch50NAWeittmFtDYe3/PD0+/XeD/1uZlPkvUAEee33SRru6P8U7F/hlqHZAxdAIOXQfNLzPg1xl1biptbbok7H1MsskwgWlR1ZozopIhWeOURMboPttIiDvPOknU6dcjhOn11LLd+2MD+743c3LuIizue8TGNRK5KVeCrg2xaEH5Qkgvczkq7EvqEH7USXQ3HBXcD7wya3aRQYx/uSaPgJqDRgmE0C+BEMwoyy8RU6BMvSOka2sDJLYByVkufLGJkS4vclDWW9VT1iBwjEs9MegLaKmQCUra1qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(7416002)(5660300002)(82960400001)(31696002)(6666004)(4326008)(8676002)(86362001)(36756003)(41300700001)(8936002)(38100700002)(31686004)(2906002)(316002)(26005)(83380400001)(2616005)(6512007)(966005)(53546011)(6506007)(66556008)(66946007)(478600001)(66476007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlRYZnl0aWhzcjg4TWpYRXdiNGYxTnlnelFKSFUvRk5zeUtZSmgvNXhLOElR?=
 =?utf-8?B?M2orOGFZMkRXTmY0UWlyaVJLdXJKNVJFZmFPZ3ZTb0RrWVR5Y3VNeGIxMklu?=
 =?utf-8?B?TEVJZ0hRekNTeTNtZEVReHNIR1BmR3dPeWNVRk5KZ2VsL2xFVVQ3VitPUFlS?=
 =?utf-8?B?WmpkNEVkVjBZTmNKRXJtTTlPU3FFRjhlQWFFeFFHcGJOMm1rY1Z6UGxrWGNS?=
 =?utf-8?B?VENnWW0wTXRQYlZYeGt3SzRIeEpCdi9ubDIyWXp2Qm93RkNoQWUwNi9rTE54?=
 =?utf-8?B?MUt0dWd1VXZhOHZaSkJERkd4aktDNVJ1YlNXRXp1YXJrYm9OZDkrQWlGKzFq?=
 =?utf-8?B?aFh5emtSRHg2TStJWGUveXBkY1ZJZTN2OEZxQnRYV09WMXJkMVVGZzRCcjdH?=
 =?utf-8?B?YkFmRTNiOEp6dFY1cFJIMC9QV2hzaVN3MDJMUFpkdHNpTUg4cWhZTDBUVFoy?=
 =?utf-8?B?K0pPakJ3SThDcUdrWXNJMGpUK2xRT1YvWWNuMHRCMFFQdHE2RFMzWnNFQW8v?=
 =?utf-8?B?Vjk2RlUzNUxwaHp4R2dKV05Idk85Q3hCbDJ6UnQ3YSs0alBndU5BNmkzRDlB?=
 =?utf-8?B?TkVYUGNXQUFEa0l4STBJMXVNcjlBeTdhMnNaZ3Zic0NDSmMrV2p0MTZNU05k?=
 =?utf-8?B?NEdvR25DKzBrWTBoS0c3d3Z3aUdhaHVsajRsc3N1S0E1eDdNRWZudnhnT0dZ?=
 =?utf-8?B?Zm9wb3hCdGZBcmpDT2ZVRFhWQnBUQ3JZQVBhYlpXR2szNzlhVStkc3A3WWNu?=
 =?utf-8?B?eEFHRTR5eUxFWDBKOHBsWlk2dU4zMUM5MHlYQ3NTQ0pSeUZzVjZyUnlpZmZu?=
 =?utf-8?B?SkIvNFBaY0hQTW1rdXRoWjljck52RG12RGcrYktsSklidjAzRkVXaC9Ndytu?=
 =?utf-8?B?ejYwbEUwRnFIVGMvSTQrSVl5NnQveTdhL0I0QnN1OGkwMzBPdU4wSXVCNkcv?=
 =?utf-8?B?ZjdRVGVZQ0krSGNaNExNRG1qcHVEMm5GSWZYOWhNVVhhcWZsbktsY0ozS0Yr?=
 =?utf-8?B?RytWZld4Vjd6QWtVVmJjU2VnTnN3M3hkNlYxbGNheXFGc2NkRGRuTjZFL1Jt?=
 =?utf-8?B?R01xbitkNWRaVWtYQ3JRZWdxVjlLQnc0ZUx4K0FWZDU3a0VWdTZXRUpkVkFr?=
 =?utf-8?B?TUJSMGcyMmtmU3ZwMWVBL0NsaTJxdDUrWkVLRDAvZm1qT1g3TFRES1M0U3lh?=
 =?utf-8?B?K0U2T3dQeVhud0t6b0ZCTjd2TkdoQTRoWS9UcHppYk9Ha0xmTzZvNDRUWCtn?=
 =?utf-8?B?bmI4WE1CU2RIcHgrSk40Wk40ZXJieGpVQlJINFBvcHVZN0ZTQ015VU5OQWpU?=
 =?utf-8?B?RzN1R1I0Y0ZQUFNZY3B1Y0Erbm9qWWRqblhnK2JHQVJMbTN5WWU2L3JtT0Fr?=
 =?utf-8?B?R2hHZy9WUXdyQ2xNQU15YUdndjBxNnNNd2RYN1FEd3VYQXlNTUcycjA4Z3p3?=
 =?utf-8?B?ZVkrT210bTN6RENId2ZZeWV3ZG9uVW5tNzVqeGJaQ0hsd3RYNklNZXd5bVlq?=
 =?utf-8?B?S1NITHZmZlU0T1NwTENVVHZ4b0JiRUwxVlFKOFlDdWM2Q1A4RTZKWXF3eW1q?=
 =?utf-8?B?dlBLd2Q0QVJ0NmZhOFdGcFNiZ0xYc011TUtwVG91TFNISy9PWU4xczRMMkF2?=
 =?utf-8?B?S0ZBMXkvcnV3WlU0c2ViQ0hLRXdPRndrekV3WmFjSFcwdW8rM0ZBNnFpYXE0?=
 =?utf-8?B?UzlxYWxJU3dYMlFPTnlxajF6SlVkNUlYc1hYKzI3Z3hlbU1sdGtnT1o5V281?=
 =?utf-8?B?c3gvVGxoNUJTYkMyUkhxTUFCcXRHN3AybEE4MDJWcEF3cGNyejNUTkd0QUJl?=
 =?utf-8?B?Q0d2Q3Bvb0JWYWF0N0FCME5PU0lJYWN3cWxsbmRFb1JjUVZUTHN5RTNGQldz?=
 =?utf-8?B?alhwdmhzampjK1E5YlVGQm9IajRlTzVKaUJTWGIxbGZJdTV1KzVTMVdVdGpO?=
 =?utf-8?B?U3FkRVozc0pYZGlzd0tWWDFpMFpvTTJmMENjL0FUTmM4QWZ3SFZydmJQTC9a?=
 =?utf-8?B?ZVoxbnp6SUtTeGdyNmd4Vit0VzhCaXJOUmRaSE10N0VINFNJbWtlb0ZLUWY2?=
 =?utf-8?B?WldsSzBkbXRiZUkyVGtVL1dWVUN1MlNBenByUmU4QzBlSVpQRVVZMWE3Z0tZ?=
 =?utf-8?Q?3k33YT9A4AlTws+CwscX27Orm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ca386a-84d7-4be9-22d7-08dbf6f1acb5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 06:56:45.4155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9V+Hl30W2z5sAvTqkOQDRDi61/dxXij8W2chr2xZn4+qGV8Mm/74uouiIsaLyMRicA++FYFW+yqnGolRgBtBtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7900
X-OriginatorOrg: intel.com

On 2023/11/17 21:07, Yi Liu wrote:
> In nested translation, the stage-1 page table is user-managed but cached
> by the IOMMU hardware, so an update on present page table entries in the
> stage-1 page table should be followed with a cache invalidation.
> 
> Add an IOMMU_HWPT_INVALIDATE ioctl to support such a cache invalidation.
> It takes hwpt_id to specify the iommu_domain, and a multi-entry array to
> support multiple invalidation requests in one ioctl.
> 
> Check cache_invalidate_user op in the iommufd_hw_pagetable_alloc_nested,
> since all nested domains need that.
> 
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/hw_pagetable.c    | 35 +++++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h |  9 +++++++
>   drivers/iommu/iommufd/main.c            |  3 +++
>   include/uapi/linux/iommufd.h            | 35 +++++++++++++++++++++++++
>   4 files changed, 82 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 2abbeafdbd22..367459d92f69 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -238,6 +238,11 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>   		rc = -EINVAL;
>   		goto out_abort;
>   	}
> +	/* Driver is buggy by missing cache_invalidate_user in domain_ops */
> +	if (WARN_ON_ONCE(!hwpt->domain->ops->cache_invalidate_user)) {
> +		rc = -EINVAL;
> +		goto out_abort;
> +	}
>   	return hwpt_nested;
>   
>   out_abort:
> @@ -370,4 +375,34 @@ int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd)
>   
>   	iommufd_put_object(&hwpt_paging->common.obj);
>   	return rc;
> +};
> +
> +int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hwpt_invalidate *cmd = ucmd->cmd;
> +	struct iommu_user_data_array data_array = {
> +		.type = cmd->req_type,
> +		.uptr = u64_to_user_ptr(cmd->reqs_uptr),
> +		.entry_len = cmd->req_len,
> +		.entry_num = cmd->req_num,
> +	};
> +	struct iommufd_hw_pagetable *hwpt;
> +	int rc = 0;
> +
> +	if (cmd->req_type == IOMMU_HWPT_DATA_NONE)
> +		return -EINVAL;
> +	if (!cmd->reqs_uptr || !cmd->req_len || !cmd->req_num)
> +		return -EINVAL;
> +
> +	hwpt = iommufd_hw_pagetable_get_nested(ucmd, cmd->hwpt_id);
> +	if (IS_ERR(hwpt))
> +		return PTR_ERR(hwpt);
> +
> +	rc = hwpt->domain->ops->cache_invalidate_user(hwpt->domain, &data_array,
> +						      &cmd->out_driver_error_code);
> +	cmd->req_num = data_array.entry_num;
> +	if (iommufd_ucmd_respond(ucmd, sizeof(*cmd)))
> +		return -EFAULT;
> +	iommufd_put_object(&hwpt->obj);
> +	return rc;
>   }
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index a74cfefffbc6..160521800d9b 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -301,6 +301,7 @@ void iommufd_hwpt_paging_abort(struct iommufd_object *obj);
>   void iommufd_hwpt_nested_destroy(struct iommufd_object *obj);
>   void iommufd_hwpt_nested_abort(struct iommufd_object *obj);
>   int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
> +int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd);
>   
>   static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
>   					    struct iommufd_hw_pagetable *hwpt)
> @@ -318,6 +319,14 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
>   	refcount_dec(&hwpt->obj.users);
>   }
>   
> +static inline struct iommufd_hw_pagetable *
> +iommufd_hw_pagetable_get_nested(struct iommufd_ucmd *ucmd, u32 id)
> +{
> +	return container_of(iommufd_get_object(ucmd->ictx, id,
> +					       IOMMUFD_OBJ_HWPT_NESTED),
> +			    struct iommufd_hw_pagetable, obj);
> +}
> +
>   struct iommufd_group {
>   	struct kref ref;
>   	struct mutex lock;
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 45b9d40773b1..6edef860f91c 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -309,6 +309,7 @@ union ucmd_buffer {
>   	struct iommu_hwpt_alloc hwpt;
>   	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
>   	struct iommu_hwpt_set_dirty_tracking set_dirty_tracking;
> +	struct iommu_hwpt_invalidate cache;
>   	struct iommu_ioas_alloc alloc;
>   	struct iommu_ioas_allow_iovas allow_iovas;
>   	struct iommu_ioas_copy ioas_copy;
> @@ -348,6 +349,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>   		 struct iommu_hwpt_get_dirty_bitmap, data),
>   	IOCTL_OP(IOMMU_HWPT_SET_DIRTY_TRACKING, iommufd_hwpt_set_dirty_tracking,
>   		 struct iommu_hwpt_set_dirty_tracking, __reserved),
> +	IOCTL_OP(IOMMU_HWPT_INVALIDATE, iommufd_hwpt_invalidate,
> +		 struct iommu_hwpt_invalidate, out_driver_error_code),
>   	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
>   		 struct iommu_ioas_alloc, out_ioas_id),
>   	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 0b2bc6252e2c..7f92cecc87d7 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -49,6 +49,7 @@ enum {
>   	IOMMUFD_CMD_GET_HW_INFO,
>   	IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING,
>   	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP,
> +	IOMMUFD_CMD_HWPT_INVALIDATE,
>   };
>   
>   /**
> @@ -613,4 +614,38 @@ struct iommu_hwpt_get_dirty_bitmap {
>   #define IOMMU_HWPT_GET_DIRTY_BITMAP _IO(IOMMUFD_TYPE, \
>   					IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP)
>   
> +/**
> + * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
> + * @size: sizeof(struct iommu_hwpt_invalidate)
> + * @hwpt_id: HWPT ID of a nested HWPT for cache invalidation
> + * @reqs_uptr: User pointer to an array having @req_num of cache invalidation
> + *             requests. The request entries in the array are of fixed width
> + *             @req_len, and contain a user data structure for invalidation
> + *             request specific to the given hardware page table.
> + * @req_type: One of enum iommu_hwpt_data_type, defining the data type of all
> + *            the entries in the invalidation request array. It should suit
> + *            with the data_type passed per the allocation of the hwpt pointed
> + *            by @hwpt_id.

@Jason and Kevin,

Here a check with you two. I had a conversation with Nic on the definition
of req_type here. It was added to support potential multiple kinds of cache
invalidation data types for a invalidating cache for a single hwpt type[1].
But we defined it as reusing the hwpt_data_type. In this way, it is not
able to support the potential case in[1]. is it? Shall we define a separate
enum for invalidation data types? And how can we let user know the
available invalidation data types for a hwpt type? Any idea?

[1] https://lore.kernel.org/linux-iommu/20231018163720.GA3952@nvidia.com/


> + * @req_len: Length (in bytes) of a request entry in the request array
> + * @req_num: Input the number of cache invalidation requests in the array.
> + *           Output the number of requests successfully handled by kernel.
> + * @out_driver_error_code: Report a driver speicifc error code upon failure.
> + *                         It's optional, driver has a choice to fill it or
> + *                         not.
> + *
> + * Invalidate the iommu cache for user-managed page table. Modifications on a
> + * user-managed page table should be followed by this operation to sync cache.
> + * Each ioctl can support one or more cache invalidation requests in the array
> + * that has a total size of @req_len * @req_num.
> + */
> +struct iommu_hwpt_invalidate {
> +	__u32 size;
> +	__u32 hwpt_id;
> +	__aligned_u64 reqs_uptr;
> +	__u32 req_type;
> +	__u32 req_len;
> +	__u32 req_num;
> +	__u32 out_driver_error_code;
> +};
> +#define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
>   #endif

-- 
Regards,
Yi Liu

