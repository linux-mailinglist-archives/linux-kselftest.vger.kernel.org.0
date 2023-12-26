Return-Path: <linux-kselftest+bounces-2436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCED81E602
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 09:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02895281779
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 08:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22EC4CB3C;
	Tue, 26 Dec 2023 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILA4mmPr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F95F4CDEA;
	Tue, 26 Dec 2023 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703580202; x=1735116202;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wNl1gZUJrNpw/tFkQftS+Ui/DE/lmU0bAhzGq6/gGdo=;
  b=ILA4mmPrmp9gFQG1WevQGjph+XOqZBNTSNgp1aOHcbdE+QDXnpAefkEF
   Kq+4e1AqYPgJKjaA8iDiF2CvHZ79wEVu3oU/LkI5C0nuOlXGzh3Spvdik
   OIJL5oJRouio1cIf25L3U+IvlOI2V8SPI5O0UMQ02xSAiuNw36qeSSUqs
   tCk5ZZBSJVbBYwqBlP0SA18HFB0CPIYO4uR3nSDNhLJLeqV9TNLVubWXc
   owacfbq00CR7JOmtNnz4DOxvqF76sZWKQ7udEjRU0k9PHnQRIYFaNvVju
   4yLotgy6LYaF1Fc1sxkCz+Iw9DKC2ZyNTgsn1CU42TmebHvPe1GQH8WZN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3146262"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="3146262"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 00:43:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="901360338"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="901360338"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Dec 2023 00:43:21 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 00:43:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Dec 2023 00:43:20 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Dec 2023 00:43:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGkllJS5RaX5jQx56Tr0mhhigMkKVLlh07pABVozmMjiyd/vMx/JVyKyo0EQESC6+sN6sc1ZHsbBctxz3e/MMZ2BX4ydbROsX6gWguKTTs03J91Rcc1aNqUmVtr2kzw7hPhoZfatuUVv5H/f4qh637VSdpmLRBsy5DxAS1w2l3rpqvplYPURqUFfuRfOAs1pt2n26BfU7iR/s17E01FOhVv/7uBTzgDq+FhHFf5Edlcgms1xorONW0G7aQc/9LqVn7AveUzBJvCMw4x/lcSChZNuF1Q6TQhQUq7pWEX/jO7pXEYgoDC/06MQ+OfYLzAdQC0xmHKQuyN8xvkQOTBwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCoDTmeVRbnKWthaDyfZwSwH0IufX45A/4PjdxgspEM=;
 b=VDOpUURlTtqOMz+dEkCTCWuv4/QIQDNtGZ7hxPaxZMJcJtUfdABkdr3vJB2eto3o3d5R2pybJER9seyu9rkOnYegKq61qO0Q5TdsCj9w9z76v+X6Td+eZQrDkqLn1GgSywq1gq+0ByTA9jyjCvSfUCBw4yOnKvd0n9dWuBonHVMlkJa+ZqviUxB0ui1OPS3+mG001tsk2gUuXSBWhFwT9LUgpUMtairajEcsYZXvJ2zUpYV6bef3Jp8yDK5/5HoUwbIbI055oICfgdj4CbBDJmlOg2zxjhTgWbwuIk6y4sSYyMCPYaPMe5IXTovq3iMen2gWUm3I/Up8RTlABZpowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB6995.namprd11.prod.outlook.com (2603:10b6:806:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 08:43:13 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 08:43:12 +0000
Message-ID: <47433717-1c16-44de-b1d8-5957b4f8df06@intel.com>
Date: Tue, 26 Dec 2023 16:46:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "Yang, Weijiang" <weijiang.yang@intel.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-10-yi.l.liu@intel.com>
 <f6302d8e-fd5f-45e1-8148-e5812c61f5c0@intel.com>
 <BN9PR11MB52766A289D2CA50F8BD802F18C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <D35102EE-F1E8-4888-8A5E-A1A723B3363D@intel.com>
 <BN9PR11MB527672402F30F701A5EA53028C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <65B6D347-5C85-4CB0-9CD8-1C914045B62B@intel.com>
In-Reply-To: <65B6D347-5C85-4CB0-9CD8-1C914045B62B@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 359048cf-0b4f-4aa2-1e2c-08dc05eeb208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7lMnZaLfJi2d7+EqqZjy7kZbVum/+ny6CJunErIUzpNQruVQYvVm55MNNxCHj/nPyuN263LJI9Wuf54KMc0Oxp61Ta8K6lcHh85dLJzBML/9HRKHJdMKdeTJkG5vygbdQEt6rO7h4pHzApIvbrXRV2dsXZT7oxFTJ/ZWDmyOurlho3gE7e+Y7tnQ3yG2xczH/Y626povvyiX+0LpAqOcSVU7we2yRHydnEBPjj2qB43voUV3RPtLD353z42wa7RxN0uNjDro85pX+AamVU2KCgX1hDnKbDnKdblL4bpCU9gyPSbgK/4kwfNxlVHI9R/xKI1sgAkpPVxExVo7glgrhUuf5qMr+/AxBpRt7QzCz180bx2gawboU0pIhYO0AV3AHCq/pkICnl9wx88IkDvbyqAS7TH1d2ehshuas83Yyazy845e2y88gvTiYJTLpsz06NRSPNiaQh4JVLir8lntgokCW+V0xuAMe68UVM+ixva0IvhWC7KpmJokKMaRznCo7n4g0+GBp+xSaJhfRhQBzL4tliFtQQD1Tr0uJCADuyCGOgqG4jJpY4sdi2ZTXo16JbWqjDzQvFNDbJ1wNFiVHJyjmdxUy5XnXLpKdkwnBXex6kC0YpdbLLEmNDNNpvG4yWOrA4kFl6qRWK7XKcrevw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(316002)(8936002)(8676002)(6666004)(478600001)(6486002)(36756003)(2616005)(86362001)(26005)(31696002)(6506007)(6512007)(53546011)(82960400001)(38100700002)(41300700001)(54906003)(37006003)(66476007)(66556008)(6636002)(66946007)(5660300002)(31686004)(2906002)(7416002)(4326008)(6862004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGhWSmV1aFpOcjFhanltVmw4ak1mN3dEYml4VGxLZlZuNmU1RjNoMEZwZitX?=
 =?utf-8?B?Ui9JTUhBZE1uc0RIeG9GSnhHL1ZMNExVcThwVU1GWW5FOHVjdkVJMmFnbGdi?=
 =?utf-8?B?YWtoRmFzb1NTUTQvWHJ4M0tLZGdSSXRTa1RUZXNKL2tkVDl0d1puejJ2c3JY?=
 =?utf-8?B?RHVuU2tCMmNjMmF4K3RHVVJLMElFZXplNEt1NFJtMU9zUUlxZW0wODlTMG5S?=
 =?utf-8?B?UHg3Q3dzQjduREQ2Q1BJQklEZnZMd2ZPZnJJTGZ0a1lJNS81emE3WncyRzBp?=
 =?utf-8?B?eFQyblRBbkx5eDM2YkIwanFTZ2xEbUdvamd1eW1jM0lJVktwaUNQV1gvQVhp?=
 =?utf-8?B?VWxDbWZmdm96R0pPZ1FIbHE2MHBTMG5aKzhicGs4SlFlVU0remVQWmg5TmN6?=
 =?utf-8?B?MjNBdjNLTXMzNGFaQllMRmM1ZXIxK2NKak5zeGVyM05ybVFTbGJzSVYrTFZl?=
 =?utf-8?B?WTczNGl2VkJsM2IrMnMrVGxlNm8rMEJ0QzFyZlYzU2tPODBVU3ZFNlMxRFNU?=
 =?utf-8?B?ZDQvRkpqZEFBMjZobUUvdWdldk81ZUVpYjg5UlNtcHdFUWRzY3M0L0kvd1dC?=
 =?utf-8?B?QXEzY0lHYUtHTFZvcHZOZTVBTjZHM00ycjFzcEk4bURndG9YYnlZdW9WdC8z?=
 =?utf-8?B?d3hibUpJbmFiRUl5L0I3NUZDTGluSW5uZ2FQT3ViRXBTdkNDN3pVMGxSeEtP?=
 =?utf-8?B?TFBVMi9GaFo1RzZKTFh2dTZGbWdBUU5VOGNPVkpHc2htYW8yS0E3Zjk1bWxH?=
 =?utf-8?B?TzlxM1RRVDQxU1J4cHFXSVJKanQwK0VZM1FyZUNtV2xJcDRPVkRUWUR3ejdN?=
 =?utf-8?B?UCtkbllsdE5VcjRYNEdVNE94L2tZVWwwT0F5UGlWeUwvZk9kR2ltQW9wR0tw?=
 =?utf-8?B?Q2tiS2EvdThVcllJUklMNFZCVDlwSWlpaXN6SEZzU0Q4RHpZbHRybzFBcHlE?=
 =?utf-8?B?THdpOFc3ZHhOUFB2ODZEVEV1dmFZVld0ektNeURYRENIbjUxVGZ1UzBkL05w?=
 =?utf-8?B?OXlUZkJUU0VESUZrTHpUU2h1UDMzSkpKelFPT1VMdXJXcExNejJhVHdma0Vs?=
 =?utf-8?B?SW85a3lLLzdPSnc3TUlNd0U1QlhNWUw5MnpTZmw2WklBZWlMZi9ZRitYc2Fx?=
 =?utf-8?B?SVZzRWNXMStGZXRRZEU2Rkc4b1dROXN2SFlEWWh2U1VLTWduNW9mM3BwcXlN?=
 =?utf-8?B?b01BWkUyOVB3WmNPaG9wYURYOWUzK3FJNmRYTU9BdEJiNFM0ZVhtamdKZmRX?=
 =?utf-8?B?ZG1LeUpzcnc3elZ4c0dWN25LMkdDaC9hazEwTzREWXlhaEZlWUVTV3ZONEl3?=
 =?utf-8?B?VzQ4ZnM4UllhOHlZaGNWeWZaaTh1UVMzMmJkamh3bVlMQVJubDJ6WHhqQVZD?=
 =?utf-8?B?WTBXNDNXV1pFUWI4ZUJqMWtRQlE4bjBVbVhzQnExWmpaOG0zSlJWKy9KYzN3?=
 =?utf-8?B?YU4rVmNOODMzRWF2ZGN4YjROWnE4V2ZzaC9jRzBURVBUdlJaNHNoeGJRc3pK?=
 =?utf-8?B?clNsQW9GU2VBMlNqN2Vac1FHa3pHSzd6TVFqUlE5QTZoaWkrUUZlWWw5RVlh?=
 =?utf-8?B?K1h6cmxNV1NZcytBVm9QbmRnTldIMTlSNEI2Z0lram80eERLNUZ4eUFHWTVN?=
 =?utf-8?B?dGpiejd3bldPVEh1UHRXd0FjdEgyMlBra1dNTTBiVCs1eUVZeTkwc2R1UXJv?=
 =?utf-8?B?ekl2MzVEV0l5M3oyd0xBQzlvWFlMSnVaWGNEOTE0N2ZxZEg3eXViZE9tSWky?=
 =?utf-8?B?cjZkQTU5RkVmSEtmTzhyTFY1T2JBUFRuQUt2c1hpM1VlUDZwaFFtU3pwWnZs?=
 =?utf-8?B?bzhtelgvYVQwYjEwU0l1d2toRXF6aExZazBreXdZMW12UjNMem1FTXEyRUVT?=
 =?utf-8?B?UHlicE5tMVA0VDM4clBXKy9xMjdiUGh4dUdnV0h3UUd5d0hhdC8ycisrRXU1?=
 =?utf-8?B?MlRRNGlEbGtkcHA2endJQzdOdW5PM3JOSHRoTkJWZkR2bWNodGxaMmVHRkY5?=
 =?utf-8?B?anpCS2x4VDl5bWdwTmZZeU5FeVRCMm9kVzh0V1F2Wk43ZTh1REM3TU1yT0VX?=
 =?utf-8?B?V0VGOG5PQUpNTFg4R2NXZkkyVDZMMWNOdXRiL2hGc3duQzFqcklCTUVFUEtZ?=
 =?utf-8?Q?o+z4X6rOsiwC7u+/v1EOP44Sm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 359048cf-0b4f-4aa2-1e2c-08dc05eeb208
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 08:43:12.8655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FTrJ1/uPf+4sWKpnU3yxgVVCJFU2VtlfSByGtVqVzt89S5sX6X0B6Ib0VSWesFpYhcnwtNtooFc6c6cMkQKcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6995
X-OriginatorOrg: intel.com

On 2023/12/22 19:59, Liu, Yi L wrote:
> 
>> On Dec 22, 2023, at 15:12, Tian, Kevin <kevin.tian@intel.com> wrote:
>>
>> ﻿
>>>
>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>> Sent: Friday, December 22, 2023 3:02 PM
>>>
>>>
>>>>> On Dec 22, 2023, at 14:47, Tian, Kevin <kevin.tian@intel.com> wrote:
>>>>
>>>>
>>>>>
>>>>> From: Yang, Weijiang <weijiang.yang@intel.com>
>>>>> Sent: Friday, December 22, 2023 11:56 AM
>>>>>> +
>>>>>> +    xa_for_each(&domain->iommu_array, i, info) {
>>>>>> +        nested_flush_pasid_iotlb(info->iommu, domain, addr,
>>>>> npages, 0);
>>>>>> +
>>>>>> +        if (domain->has_iotlb_device)
>>>>>> +            continue;
>>>>>
>>>>> Shouldn't this be if (!domain->has_iotlb_device)?
>>>>
>>>> yes that is wrong.
>>>>
>>>> actually it's weird to put domain check in a loop of domain->iommu_array.
>>>>
>>>> that check along with devtlb flush should be done out of that loop.
>>>
>>> Maybe adding a bool, set it out of the loop, check the bool in the loop.
>>
>> the point is that dev iotlb doesn't rely on info->iommu:
>>
>>     nested_flush_dev_iotlb(domain, addr, mask, &fault);
>>
>> then why do it in the loop of info->iommu?
> 
> yes. It should have another device loop instead.

let me move the device tlb related code out of the info->iommu loop.

-- 
Regards,
Yi Liu

