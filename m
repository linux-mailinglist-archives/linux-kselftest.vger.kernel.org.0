Return-Path: <linux-kselftest+bounces-2496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D784D81F605
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 09:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D7B1C227F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 08:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFAB53B4;
	Thu, 28 Dec 2023 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVQelkXP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE005671;
	Thu, 28 Dec 2023 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703752814; x=1735288814;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0pUsfS3dpJ9FXMvKwRQP2hYtDFcVDnc8+Q/p+Y4aX14=;
  b=GVQelkXPkUJGUTByy7/iYiKjeRL1pWTgKwMJ2Ja5rkTkkerq3JaRJ9I+
   K7jx0Pw3Xcu5WiEnC/9NlpNEISNOZWIVH55GfNirlWuDmo0ftXQr/6zPr
   UoCZqXDsxQaopGguGTnXluijYpMPfL3g2R0UvdqPK4LaR4Xv3V0FGqWHT
   dK50RETj4hE2SQpwp3i4vave8rVcHpS10M/7AcUjdVa73jOA5MV8ml4YM
   BcDP3eDLlhO8Sn0JOIG51Thv0nUbn7+ShT3uzzKGxE+q03yqzYu3AWJta
   p/06dV6pG4prdUGeOpEgCCxvS6TBeqY95JY0xW71GEV9hJb/vS4LIxDaY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="427699823"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="427699823"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 00:40:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="781984837"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="781984837"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Dec 2023 00:40:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 00:40:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 00:40:12 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 00:40:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3Mh6x7E2YbfN3ZvgDHTnN+5U3fWqX6uQx1itEWgoIC0VCZWfyybkS1wXBpaqO6IOb3C9FM0YfRcHgJg2vZsntHlsdB5MZF3H8qOa+uRBm+X6jRC5B4fp88itw5DooNzCmM8LBx2CWGNnKZzTja10xo1jwhmiScOOFEDhNJq1BS0pVUHz3NVAgZkuo8RBx0V/c0JC++/kz0BtoiX+31sfb4oyqIcFlg1s1pnkBNZ5+iSwUV3saqL5GHn4gZ4aqpCnUDefm2it15Vj7RkUCZT/bQSUQ0J99y97wPFXgSXXJeSOpomtA5wjYqf/doZyen01I2XZnPleeqfGuvIfHV4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBm4pvorTDlNIncGVEQUrFjVa1y9JtmFgnq5YKhkRPk=;
 b=KhJP3IZ7yoUuLqm6t3Me2ho8aJoOYhzaP3i247U9KEMDidu4inNJb71QnOrBDvwMcmQDsp4/Qd10prU19FlQ303AXr+Bgm5ic24fd1FCwk7M1srELeqgeCOsJSlb2g/CWf9hnziDk4yv+WLIfalJv8HXL3ol4niy84gyBT5wS3QpQUDDS20K9VSS9rA+GaE4GRwvdYrM9WUOGZSKAspo1TUj7dufyMwBCfjsuTdYV8Jl+S4dSmdj9t1UAYcS0YXBQYhgiGWcQBSigUYjAqDpB4b19/W9R13iCwTS7cCsBKf3R5GZU2QC100inC0Bn08byt/N0r0rVexVtXfoNP7eMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ2PR11MB8513.namprd11.prod.outlook.com (2603:10b6:a03:56e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 08:40:05 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 08:40:05 +0000
Message-ID: <77f8a549-4d81-4ad4-8acf-bff3b2cafcb4@intel.com>
Date: Thu, 28 Dec 2023 16:42:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/10] iommu/vt-d: Add iotlb flush for nested domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>
References: <20231227161354.67701-1-yi.l.liu@intel.com>
 <20231227161354.67701-11-yi.l.liu@intel.com>
 <BN9PR11MB527696416E2B1F33900007968C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB527696416E2B1F33900007968C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0117.apcprd02.prod.outlook.com
 (2603:1096:4:92::33) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ2PR11MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 52351878-64c2-424a-445e-08dc078096c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KA+rQwTWyghhatx0pfK85m4X98uE0/F/trvnCa/dYjh6vhkLatc2XmnJAr7pg1Nc816wN+G63/efNK1oPZa6mQSEJ/EXoCqaxenczyw44W8+sfC0tBUhdyerJ+R8Fw7mpv06Cpa+W9ft/Y8aecUU0EQcZ0issnUp7V2jqUTOKcgA3iCfs7ECz8KMqc8Q8wOkWtGUuToFl9YjdxR3HHlMHbVOW37Mi6lXzcLN3+rKvpOoZ2jz3jcU1kLvWBgwvCR/Ilbg1W36y6FtVPTh6U+Merf45DoTGERfcFOgnk5W9srOqwOos/TjRtvqf9XABvkiQ5I59SZ9W932StrS+kgfNrPNglmY45PURigyH+wOFmfOJwuJSv+C7nORvbYg+ItjP9YVxIThEQH//4z79W0HBpKazAt3rczqPTBQEXVFs0x24toPnMKL5E8gxy7Vq8Zq98hQ86jaTsFU6CaqSNc+WamdzBO0fjuHCazkg/zbrv2INyqWGBUlc6V0evT6y3dRcpxO+Z/HELWqq62BiqM9iIEnBR/nCdNIeXBlsUKByxEM6OYf7Vuc2LXvbuDUJa88z34OUJVWtuk9sn9AtjaTii9euye6tEYvP22VOGE2tJnm2642fJ8y1z4mKCrGrE/xIf9kXn59xH1rRiqmMi+v9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(36756003)(31686004)(6666004)(6506007)(53546011)(6512007)(6486002)(66946007)(66556008)(31696002)(86362001)(66476007)(26005)(38100700002)(82960400001)(83380400001)(41300700001)(2616005)(54906003)(2906002)(5660300002)(8676002)(8936002)(478600001)(4326008)(7416002)(110136005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWtrWlBoeEdQQ0lwSEhRbC9RUE1oS2RNd0psK3VUL2lHNCs4cmgwQ1VwZytP?=
 =?utf-8?B?eDdESHllbzErS29CRkhVT1lhVlRidFlocHQ1ZCtTa3BuUWRsc1pZdW95TEdT?=
 =?utf-8?B?MEkvcEcwZ1Fnb3R1MjlieTNQV2VCUGlHQU5sOWVtUHVHeld1VjRVanZNOGVr?=
 =?utf-8?B?L1NTZkNFdFFFdkszaVZjVStoTDZ0b3RPOUZReVRGempoaDJ5OFFaeC9lRWM4?=
 =?utf-8?B?Mnl6aGI2QWtualJpakZDdFVFa05VYjJvMnNNZkVUNkZUNXJSbzI4UVZSVWQr?=
 =?utf-8?B?MVByRVR3VWxlQTlnUDBXZkZOUk9aelEyZmhUcVMvYnpXVkJ6SmY0TU8vQ0tw?=
 =?utf-8?B?blhsVmY1d0xkMFZkcWJib1VVVEpDbDBZMDBhN3AzOEtZUEdmS1l5S1VmaktL?=
 =?utf-8?B?VXFsaDRvYXBaa2k0ZHk5a3hnaDNOUjdNc2tia2FwU2QwdkRrY2xJcmd0WGI2?=
 =?utf-8?B?NU5SdUsvaE5GcVJIczVLNkRjUVhiWTh3cWlrTlp3SkFWdllDN1ZXVmJLaTM1?=
 =?utf-8?B?V1ErRnExbUVDVFArMlBWUWVOMnVMdTVJZlJuV1dBcVYvbS9uSmt0cnQybk5x?=
 =?utf-8?B?UTNQUzJ6NUxpWm1naGVvcHJBTW9FRDQ0MVpLR2I1ZElmczBmY1B0bG5BV3Ns?=
 =?utf-8?B?c2EwRDRTSGtTR09WRUlVSDBsTGwxWjNkU3JKNTNvdmlsMk5YTXRZOWE2ZW5U?=
 =?utf-8?B?a2FuZ2tORlpCU3JudHN2aVVnT0c0ZGJTV2dLZEkzUk1DRHgrU01LWno1MjZI?=
 =?utf-8?B?ejZwcVJ4SHJXelBQd2dwdlpvY2JkTFdyN2VzNnBSSFF4cWZKR2FMZTRObUJq?=
 =?utf-8?B?MEprZjhjNERmYXNKTk1pWHgyUlZ1K2d3U2xLa2hZS3Rlb2RJNWc2UE51NXg2?=
 =?utf-8?B?S3pXRjhVMnBybG5uY0xiZG01NGlyTGR1eFlNWFhqUnEzbTJvSCtQTG1qRGt6?=
 =?utf-8?B?bjZGN2gxNUo4V0FicmpQUHNrOHRZRnVKSk1RWXgyYkpkMHpLNVdGSjNtYjlQ?=
 =?utf-8?B?TGhBM0hvcUZCcFVNZmFNT3VxLzVtSUJRbEdHYUZLMktHTWptQlNBcXJ4YU5T?=
 =?utf-8?B?cE1hYVpIc0FxOHFTdnJnZDBnZk1OanVJY05NbWNQLzdibld0ZXBrRGhSMW5Q?=
 =?utf-8?B?T3d6VjJKVWtaWHRjZGgzWGhpdVVnSzZ5d0NUdm5pSWxkcEpIYlpQY2gxTmlO?=
 =?utf-8?B?Mm5iRkxzTzdRWFpIbmRnMkZ4b1VYMlhYK2MzTUszRGJiV2VRUCtDYVRXK2c4?=
 =?utf-8?B?TkQ0ZndXdWtkQjg2WHRPdENseTA2d0xBajVaUnBna2xDV1A5eC9td2NySERa?=
 =?utf-8?B?WVBwcnB4bGZWTHN2aFBocm5SSEcvUjVuTFhReEdBQllReWZDL1RtQTNnNGJH?=
 =?utf-8?B?ZlRaUnlPZURaelZPK0RyY2d1TS8vNVBsK21zNlBKdDQwOHdGeUU0UmdHMkpn?=
 =?utf-8?B?YWN3Y2RlYUVNNHdvUmp0V1gveHJGUHNySnFLMFFSVEVidms5OXd3Qm9DbU9Q?=
 =?utf-8?B?eDB4cnNzODZJaWVTQ3BEWjdYUWh0a2Z0Nm1sQlE3YlZYR3FJbTBJR3dtdFlu?=
 =?utf-8?B?YXVSWU9uZVp3cGNkdnExRjlpVEpQTG9UakVYWkdodUxraE9IU2Z4NmN2TnpL?=
 =?utf-8?B?SDVnMFhLTkpNWklqc1NKOGpnaTB3WmdSSURLU3haS0JDNmRmSHpqK2RPWmF0?=
 =?utf-8?B?aFVXTUNKcVdMMHFvdysrN2VMZGRlb1oxM01jb2tqQ3JwOVcvR3RxWm9sa0xC?=
 =?utf-8?B?YmVQL1FaTTF5RzNFK3hHWWxFTDdEUEVPSktLUlg2elBPWUJJZ2NLa2UxbVZV?=
 =?utf-8?B?ZkJ3QTRTbEJhcjhCNUhVUjdUeGZLZ2E5eHB5UDErTUlwZGZpaXNaeDdsV0FF?=
 =?utf-8?B?b1VnbGhSazJtaFV5Y0lkcDN4SG1RTWF4NmhYWEhEYTRlY0lLNmpySCtmSEc4?=
 =?utf-8?B?aDg4MlBGS0NzR2l1WkZRM0lhdGFuVUMrOEZ6aHI5ZWtoM0pNdU5TVDQ5TkhW?=
 =?utf-8?B?VTVjekxCcElFT3pvdW5JU1dYOUlvVnZ6VkVld1hVT0V1YW5xRGY5UUZhQmZS?=
 =?utf-8?B?MkhTUG1vb2taamVCaEU3bXVvMmgrb2ZkU29ySG94QjQwYTZ3bXhLREd2U21r?=
 =?utf-8?Q?ymZy4hyXf8WEbk7R7mDhdDJYP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52351878-64c2-424a-445e-08dc078096c3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 08:40:04.9832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JF6usyWtjX2rpWv6hh4COevCzjQAoDDS/3pWsEdT3rQKG+xvhBcxPnplQ5P0+VsN3I66kZNY074dQcwBBD3aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8513
X-OriginatorOrg: intel.com

On 2023/12/28 15:11, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, December 28, 2023 12:14 AM
>>
>>
>> +static void nested_flush_pasid_iotlb(struct intel_iommu *iommu,
>> +				     struct dmar_domain *domain, u64 addr,
>> +				     unsigned long npages, bool ih)
>> +{
>> +	u16 did = domain_id_iommu(domain, iommu);
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&domain->lock, flags);
>> +	if (!list_empty(&domain->devices))
>> +		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr,
>> +				npages, ih, NULL);
> 
> Not sure the check of domain->devices makes sense here. The outer
> loop is xa_for_each(&domain->iommu_array, i, info) which, if found,
> then implies certain devices behind this iommu must be attached to
> this domain.

yes.

> I wonder whether it's clearer to remove this function and just call
> qi_flush_piotlb() from intel_nested_flush_cache().

yeah, with above remark, it would be more clear to call qi_flush_piotlb()
from intel_nested_flush_cache().

>> +
>> +	/*
>> +	 * Invalidation queue error (i.e. IQE) will not be reported to user
>> +	 * as it's caused only by driver internal bug.
>> +	 */
> 
> here lack of:
> 
> 	*error = 0;

yes.

>> +	if (fault & DMA_FSTS_ICE)
>> +		*error |= IOMMU_HWPT_INVALIDATE_VTD_S1_ICE;
>> +	if (fault & DMA_FSTS_ITE)
>> +		*error |= IOMMU_HWPT_INVALIDATE_VTD_S1_ITE;
>> +}
>> +

-- 
Regards,
Yi Liu

