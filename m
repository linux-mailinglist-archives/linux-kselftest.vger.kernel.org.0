Return-Path: <linux-kselftest+bounces-1889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B357081258D
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 03:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AFF1F21FF3
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 02:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F240A59;
	Thu, 14 Dec 2023 02:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJQin7Tb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FABDAD;
	Wed, 13 Dec 2023 18:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702522548; x=1734058548;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b6G3AaKY1QqyEgro3ByPARL0kAKRkGeie3aD4IwcR4Q=;
  b=oJQin7TbO+ouz+StOnUt1Y0Ycy8Uw7eP7r003qIHLN/DlXpStYJYhcZo
   gm92imWkx2mYtrKBIKRjNunNirL6Elv2s8Yw6mOicbx+vL0cepKaI/zsJ
   jirWipttiySJLwWKL0od+lBB8DGLyaVedJm1692sksJb9F9CBjhu+wMSI
   w+AG5ASMn64n+sYdg/dfvNSRde5ImiXQheObOEujUJObKHEWc+HBysEBq
   IjPtw4pZGHNur1qkb4nacnRPlugPjgg8NgVwysgvcDUBKRsYkd4TBQRBv
   XomXa+oN1Z6kvDxKeMfM38xc61bZCtI5+iCL2cOpnRAppD4v7SrUpvfNn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8420572"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="8420572"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 18:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="803104373"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="803104373"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 18:55:46 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 18:55:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 18:55:45 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 18:55:45 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 18:55:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsNaGzIi+J+6+uHXxWzD1+ryGlLDNXD/X5jod2kd88QghHkXCLjqAETOThdBiuu3Ad16JqXYnW7V8MwLi6a+Xsr20ouZLvfC8tVcO6b2Sh0GJwQxh/eQG6Xxf6KYUJLUBFK7NYpkzs1uMTACpBvKsA1iszRqZ4sqIR64SitspmE24VnnJH3PuGLav0lCMt83D4/DIY3ryKJ/ns3+CDQ684UXv4zgeiZnnHiHe/FATZ931L3rHPsMYTQ+PLiZux7JTfM99jn+tVcGQqDzLlntC3/Flu/5eCDXFuPlJ8PNmbadm5Gk4A1eKsjf6mrsNz1U5D7/3zrW1J5iYvV2xanS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERmdwQMcqfzQ1H42MiG96f21fLvaIJVkq8z9GRrvxMI=;
 b=icWb915z5nyUreTs7f9nmq8bQMGAmGlfAlHLyWkRcGBQJzGy/c+eZBWv8324Y775M6s7oanhl1A4qaqP4p4DoJLWcMREEIAEehs+4vHRK32WX5/zAmTIxMAXxMBUfTg/LQUmS8IJOhabchPBJM/Vzb+y/VvB2JUOjjmyHH08PQ5CAhokyUamewuwesBNSe4JnDR2Hr24xjdra8AnzaqjUhHRuzPSLN6JjGAP6o257ISi9njUjouDV23ZTUdF9cA6WE9rUSFYq3gU7mirCPI3Zs9XS/9267KSPoeTgVMKdklahj3DvgJCGaB5J2b7EiyJnmAAHVoq3cBl7WGW54E7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7)
 by MW3PR11MB4649.namprd11.prod.outlook.com (2603:10b6:303:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 02:55:41 +0000
Received: from PH0PR11MB4965.namprd11.prod.outlook.com
 ([fe80::ea04:122f:f20c:94e8]) by PH0PR11MB4965.namprd11.prod.outlook.com
 ([fe80::ea04:122f:f20c:94e8%2]) with mapi id 15.20.7068.033; Thu, 14 Dec 2023
 02:55:41 +0000
Message-ID: <a19031b0-7c30-45e6-b171-c53e3578b867@intel.com>
Date: Thu, 14 Dec 2023 10:55:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] iommu/vt-d: Add set_dev_pasid callback for nested
 domain
To: Yi Liu <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>
CC: <robin.murphy@arm.com>, <kevin.tian@intel.com>, <jgg@nvidia.com>,
	<alex.williamson@redhat.com>, <joro@8bytes.org>, <cohuck@redhat.com>,
	<eric.auger@redhat.com>, <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
	<mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
	<yi.y.sun@linux.intel.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-9-yi.l.liu@intel.com>
Content-Language: en-US
From: "Yang, Weijiang" <weijiang.yang@intel.com>
In-Reply-To: <20231127063428.127436-9-yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0195.apcprd04.prod.outlook.com
 (2603:1096:4:14::33) To PH0PR11MB4965.namprd11.prod.outlook.com
 (2603:10b6:510:34::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4965:EE_|MW3PR11MB4649:EE_
X-MS-Office365-Filtering-Correlation-Id: 51effe6a-3aa3-4f10-c000-08dbfc502857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HikMozAiU6DmM1weboTqgXmD/gY2QfI/VeK6ruY0hm62NU08VnEEVZxuowViGK9btv8dYiklayq5WWvE7m8LQi1as4nMTuicgWj02kTriGnxYnR67CStO5rLLCc56XForqXM33ZFeQmAsuXtQgtoe2G7kgUl+umDnF0NZEguZzTpvV55gfVhm+Gsa9U9e5zCUH6CEc3BBXIvgC+Hw7lu6N1/txEy9wr5305Fkfu7IC1BKA7awFjJQrnWsW9hJ4QdAR/LrB2T6c/JxJ7JB5sWCCAZPD4vah6UFVQwqrqz4SH28mSXufvhCFgt5C5V7REOXiY2giPPrMsW1uB215LivwiDK5080l5Ljte58tXRpDCus2e92ve5Jzo7pSwuqdCN75CxFROKbVNCTtOC+lZLIXYIElztmnwoA0y5Y/sRsSyfKBIdS2w5QqoZjAPKYQ00vIdujYr50LmhLJ78TVWfhk5osnwJn5dLAlB5l5VGAhZ5MC/UcZxM6rRAOYPWouvdNisAwPgk3JigQcEtcBPf0X++3WeX3vFm/XSUbaiVcZe+ydyB78L7MH38V/2YRZrzck40sDCuNfNfBiYjK8sf45zjoNlAvtaq41qQbfrC2dfaBpvqNM8aYtItIf4C7Sa7Pfvclji0zrS3Fdnt4wzK6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82960400001)(26005)(36756003)(41300700001)(83380400001)(6506007)(86362001)(6666004)(53546011)(31696002)(8676002)(8936002)(4326008)(7416002)(6512007)(5660300002)(478600001)(31686004)(38100700002)(6486002)(66946007)(316002)(66556008)(66476007)(2616005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V253UmhpZkdjQ2l4RE9MaDBOamZ5V0ZsUmQ1bFdBaTNhdG9SNlRQWFdWMHJZ?=
 =?utf-8?B?b3h5WXFMRndsN0w2OUE5N053Z2RjMTI3amVadmJmRlBpdndoSkZqaXpZK1pQ?=
 =?utf-8?B?ZnU4V3kxUGk1ZDdwVktZU05CZW9qOVZSQ0dRaUJsUldDSGhQamxPSisvSU13?=
 =?utf-8?B?M3JCcFBJR090MmlrR2tJM1Y1SVJWNUlwT0VHVG1xbW43Z2tUaThNYU85TkNk?=
 =?utf-8?B?VDdZc29KL2NJRFRrWXNXa1NCQ0c3djlJN2VtZEQwazVlQTdiZkJBQjUwY2NW?=
 =?utf-8?B?cis4dUkzYkNpU2xFblk4S0tFV0F5aG9SRnZjcFFpVmVXZUtQOUtlUGhZU0t2?=
 =?utf-8?B?TGFielRCZTlkOE5oTTd1LytQbEZIWDNsYkRDZjgzcmIrTDZPeHB6WWJtN256?=
 =?utf-8?B?dWRHRXlBbzk2TmVjOUJFQkc2UFoyWWxheVpLY2MzcGpYMnFmeW5NWDVOWmQ2?=
 =?utf-8?B?QVJuQWdVTzc3NWtXTVIrR1pqWGJuUmN2SnIwQTkwV05EazNVSVNaTG1QOURJ?=
 =?utf-8?B?SVhucloyN3ZXVUhEQlcvc29BZ0FiaS83bDFmTW5IS3NSQlZMaTl1YXNTWmtl?=
 =?utf-8?B?Ykc1M0hydnUyTzBpK0M4Vk5LVFVXdzlTTkl5UndaZFFrd1lZUlJDdjZFUFZJ?=
 =?utf-8?B?RDBtN2dJVFI5YUpTN0g4a0h3UHFyMHlsNEM0ZCtUdkthVytrZVk5NW01am5E?=
 =?utf-8?B?VHNsSyt1V0F6WFBGeXA4azh5Z1BFejh2QitJWitwQmEzWGRCR0NEeHRNbXcv?=
 =?utf-8?B?OWpidmJiQTVTS1UvbHQyQXBXSW0ydEE5M2ZsSE9PQ3FnQmtSYldjUU80SWhU?=
 =?utf-8?B?cXdtc2Fkb291L2RKR0piQkZyb2FTL2tpdXY1ZUtjMXQyeFBhYWJGdUc5eHVZ?=
 =?utf-8?B?YTAvdXNYSmloMm9HNUx0MENQT25LcUNMM3VkYld2QnFLVnlQVG9Sc0VLc3Jz?=
 =?utf-8?B?bWQrc0thVUhFZ1JSZUJoZ0xaUk0veVJ0dThYMzdvSkgzc3dZeUNpYTVIWnQ0?=
 =?utf-8?B?UWtkZHdWT2IxVFJtUDBtd0lYTWduajFVdFdWeUhrK0tTK215MGdRSm5TdUE2?=
 =?utf-8?B?TzZvbHJubFo3eVB2TVlpbElRUnRWeVdDd3UvQjFBL0xMUDFNWm92d0h3OHFr?=
 =?utf-8?B?RVZMYTRUcUJ2aVd6OWJXMnk4cXZLZnFLU291aTJOUUwza1ZiS0NXUWdIdVdZ?=
 =?utf-8?B?cG1mWWQxdEdJWU9mL1lNYU5DWFhCUVZkUlNlcDRvUEo4N3RxSEVvbUlDWmFO?=
 =?utf-8?B?VkFWQ1QzVDdCTzM3VjZ1a2FLeTljeWF4NDRHVldxVk9VUTVFNStCSXdaQldD?=
 =?utf-8?B?M1V0Um5TT3J4dG1vVVZJbWd2cGRtdUNlTWJNVnVtT3lIaFFhQmgrQmJDRmw1?=
 =?utf-8?B?Nlp4aWE4aDFvNlJQTGNPY09wQ0M1RS9ySDIyWDl1Um96YjViR1ZqeFhEYklR?=
 =?utf-8?B?YUpReG9TNzNnVUZtZnUrZHY2VXVSZkFERXEvWHZZWHB3OXpjVW1ETDQvN0hK?=
 =?utf-8?B?VUQ0aE81Vy8vUUlEN1hUbnE2dUY0NXM5clRJZlk4V1hTSE0zeUltVVNZaWNm?=
 =?utf-8?B?eVE5T3dNVW85bkJDN0ROMUlhQ0x4a0VMaHJpcG5NNXEvMjdtSVhUUkNvb3M0?=
 =?utf-8?B?bXFJUGo2MExBQkZBZ1RMR0JvVm9RMThlQkZZTjF0cUwzODl6cHlSdDI4bUdV?=
 =?utf-8?B?YUhNRWdyNmU4Ky8vOXNmaDRTS1M0UHY3OUZ2anZlQlFnV1I5MUhpOXFhQTZn?=
 =?utf-8?B?amRibE1ma0kyTTQ3MEJjRjh5WFkxRUNqVjVoem4zMlgwV1BRcjB3NCs1d0Fr?=
 =?utf-8?B?UUNDb2E5ZjdBUXB3UEtpR1RlQzZVWmpabkNVM0xZbThnTzRXQloyOXVXZFA0?=
 =?utf-8?B?Wlo0TDdpcTYvbDU2cEUzRE1heU51Y1lEMVdkUDVEc2cydVFjVjRiVFNmcElF?=
 =?utf-8?B?M2N3WDJtbU9sUDNLdkNxUDVVSldOMisvbFFseW1sRkNZQUlFUXNFVHhOd3VU?=
 =?utf-8?B?bEVTeE9jc3lvNnpMK3YrcHJnbUpyQXo3UXV3ZGNwQlVhWWduQ3dYejFlRjNr?=
 =?utf-8?B?MEYwNGg4NVJjbW44T3RmQ014eU9iSEltL3kwWmdHUkZ5WUVtNTBBQjNDRFdK?=
 =?utf-8?B?QjBxNUl3b0RCWVFESnRXV2kwL3dXc0lZbWZhUUZVRm16ekJUZHpQUEtKNGxD?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51effe6a-3aa3-4f10-c000-08dbfc502857
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 02:55:41.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDnGzQ+2lQESvBhcA6RBEMmfX0W316b9yNdMmAq8CqwMvBcdmdQFsmk6IKDOBiKm1g+eAquTEDXJvaghkBW34Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4649
X-OriginatorOrg: intel.com

On 11/27/2023 2:34 PM, Yi Liu wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
>
> This allows the upper layers to set a nested type domain to a PASID of a
> device if the PASID feature is supported by the IOMMU hardware.
>
> The set_dev_pasid callback for non-nest domain has already be there, so
> this only needs to add it for nested domains.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/nested.c | 47 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
>
> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
> index 44ad48db7ea0..f6f687750104 100644
> --- a/drivers/iommu/intel/nested.c
> +++ b/drivers/iommu/intel/nested.c
> @@ -68,6 +68,52 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
>   	return 0;
>   }
>   
> +static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
> +				      struct device *dev, ioasid_t pasid)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct intel_iommu *iommu = info->iommu;
> +	struct dev_pasid_info *dev_pasid;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (!pasid_supported(iommu))
> +		return -EOPNOTSUPP;
> +
> +	if (iommu->agaw < dmar_domain->s2_domain->agaw)
> +		return -EINVAL;
> +
> +	ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);
> +	if (ret)
> +		return ret;
> +
> +	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
> +	if (!dev_pasid)
> +		return -ENOMEM;
> +
> +	ret = domain_attach_iommu(dmar_domain, iommu);
> +	if (ret)
> +		goto err_free;
> +
> +	ret = intel_pasid_setup_nested(iommu, dev, pasid, dmar_domain);
> +	if (ret)
> +		goto err_detach_iommu;
> +
> +	dev_pasid->dev = dev;
> +	dev_pasid->pasid = pasid;
> +	spin_lock_irqsave(&dmar_domain->lock, flags);
> +	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
> +	spin_unlock_irqrestore(&dmar_domain->lock, flags);

---> list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);

dev_pasid is linked at later time, this leads to domain->has_iotlb_device is not correctly set, which finally results into a missing of device iotlb flush in iommu_flush_dev_iotlb()when it's called.
Check this call path:
domain_attach_iommu()->domain_update_iommu_cap()->domain_update_iotlb()->domain->has_iotlb_device = has_iotlb_device; The ugly fixup is to call domain_update_iommu_cap() or domain_update_iotlb() here again before return.
The similar issue is in intel_iommu_set_dev_pasid() and intel_nested_attach_dev().
> +
> +	return 0;
> +err_detach_iommu:
> +	domain_detach_iommu(dmar_domain, iommu);
> +err_free:
> +	kfree(dev_pasid);
> +	return ret;
> +}
> +
>   static void intel_nested_domain_free(struct iommu_domain *domain)
>   {
>   	kfree(to_dmar_domain(domain));
> @@ -128,6 +174,7 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
>   
>   static const struct iommu_domain_ops intel_nested_domain_ops = {
>   	.attach_dev		= intel_nested_attach_dev,
> +	.set_dev_pasid		= intel_nested_set_dev_pasid,
>   	.free			= intel_nested_domain_free,
>   	.cache_invalidate_user	= intel_nested_cache_invalidate_user,
>   };


