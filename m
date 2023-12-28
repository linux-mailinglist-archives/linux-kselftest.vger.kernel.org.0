Return-Path: <linux-kselftest+bounces-2495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CCF81F5FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 09:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B411C227F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 08:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7195C5380;
	Thu, 28 Dec 2023 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cXvZ/F47"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2749363AB;
	Thu, 28 Dec 2023 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703752345; x=1735288345;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UlOIK0NzjoP4QwOxv3OG6ASDRYXZpSKU83IxWYl6Zhg=;
  b=cXvZ/F47w/KZvYc+JLJeZiH238MkJYx6Bxy+KfGYGmWM66dZrn7LuF77
   xnsm7Hcm5cXlWMS3EI2yzMgjoXJhV0bbZaRM0EbD5h3X9badOhR+rl+h5
   Pz+am8Y5mZ4MCoWXwI8gsfUg0D+EdGQLIUjEt+WECh3LCyA++A93eCR2f
   IaCfabcfvJAazq0AdwJh2yB1cXDtskleBez/TQ8Yn3FCzMQHVTDF76Cqp
   fIMknZFlszWcaTdCaJcn/hBfajfx/fxx5dNjCeiXCgFaB8+NAe0uCMRQ9
   92LgqKjP4JNy47g5Tm8PVFkQqVfotKlCjyMLITrKNhtICittFaRCCDOeQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="427699012"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="427699012"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 00:32:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="781983235"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="781983235"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Dec 2023 00:32:23 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 00:32:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 00:32:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 00:32:23 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 00:32:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQfHFQM+XTbdIjbUsWl2ovxine7jUMwnUOJWqYJllLE42OVYkS8ZH+kNFyaQIkGmv1holOlHOGgdaKovLxxRlvRk8x5jlbbBR7FXgS71QAFo9ZEaky7ggql9duGBOax92ub49QNKZHkr73BsmqCoPdBNSoaRG0S+a1Uo3JaJzo6dk3O+MjwamF/GnBFXquhiGMDEiH/kZ+MNPSDyWYA7slArvzf0D69LUJv4vUvctjECveMSqqtGD9BG245Z8lIcR2Bdt6WMbTOsiMhXw4SZ9NUa8zrpw1cYMuF6ro6VtOK1r1bp6KPP61Uc9mR7jS7SkRkmKejoxx/z/HgWWPAdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2xwaxtn2RbEAEAPp1PZnWjjNVlF3szNYXx8Zr0JZhA=;
 b=gxkjj1stLfPR0+7NSngUzInJQcmS5+JbMLf3mrPYb2Rndl4k31Z3Otug4cbbYBDZtXCU8zD9i3NM8IK1dcDMHKntMDJHNPilK7KVAFQUnpA9RJlxdkW/hGsJ87N/GHBtqOZ4FocXoNDtceWL1rhg2vicdbOG5hIcAq1YamIca3tOSIPMWTamtOf0ucP4KmuZfdjPa9zU2pfS20rhecCK0kwfzO1p4+2gDz8YL7g+u0HLU8ap5KCeNnQvIaE2cFYeTmOJeUlr1Z5NSqga1HNItOnJVZtPNOFLFv4XN1yF9JkIxx0y6P2l58H3+R+QVvIqCNYQPicvpJyZwzyYNyJiVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH0PR11MB5474.namprd11.prod.outlook.com (2603:10b6:610:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 08:32:20 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 08:32:20 +0000
Message-ID: <9be98837-b656-49e5-8ae6-d70ad2c073b4@intel.com>
Date: Thu, 28 Dec 2023 16:35:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/10] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
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
 <20231227161354.67701-10-yi.l.liu@intel.com>
 <BN9PR11MB5276A53786CD3AF7F170E8B98C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276A53786CD3AF7F170E8B98C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH0PR11MB5474:EE_
X-MS-Office365-Filtering-Correlation-Id: e06d89d4-0310-4b9e-8fb0-08dc077f8217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWniMSuxL3S2zDJx7/d+0O43FOy0wI0XvyGEXBKCQJSSK1ZQUE0q0CMh/RCbh76tjUUjJ9ify8UXIBCbCWzPgKikqDgsCDCvcZmHIGGYQdfN3x6aSGyWTNvd/nJNQRPTaUCBbusGvMJ9FgrhZc1b7GbUamRcQRd9EsZxPYZYLSPN0ykPAcHeLUeORySSp2nAo0ogFreRZLZGDwsWdL0sdJKLSdj3FXOjE77e70qsR0UWzrtA5uTRFCjwfPpR1eA1dXFptRUaJj+offWpm31QpSo7KFlYIKtD8JihtAv5CsP2SxQVhAiCYnkcgxuZ38LW0SX3GgwEZYzbdqL+I5nTaUHrOYGgm86gP0OQ3KJ/ONYvG+6T3yZE/ugaOcpAR80ZiSRaUhqBTCVTqse3c8Hmogiy0e0BUEk6kOklUsHZU0u/90Sgb1Ex6wdL31iR7z1i3gMVh0ZanFgGSMNceF5fS2nNqOb863LpsiXIIL/f0WHWu/zFlRJG3iD7GMvQsYMV1T60WS2aw4kayjCAMRu5jInza631Y3H1syFpuHw8JBgTkPg+J6wrfyP7nFA7+XvJL4eFgFj+No50UaenU8Z4dLDqC0Gb0qMXDGzUBm1v6w0E4jvMwc61vCHoOWqUA1bCvHacVyTUi+amECdPeJMyVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(6512007)(6486002)(86362001)(4326008)(66556008)(66476007)(66946007)(53546011)(7416002)(82960400001)(6666004)(36756003)(2616005)(6506007)(41300700001)(316002)(2906002)(54906003)(31696002)(110136005)(478600001)(83380400001)(5660300002)(26005)(8676002)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3F0dFB6TXJPWlNBclROeGZyemRsWHlOTlJmV1B6QU0venNMcHpLVTIxb3h0?=
 =?utf-8?B?TllSVGhJKytoM21uWWZJN3dNcVh6TjJZanBQWEk3Z0xoaUdEOVlKNGN4OFhq?=
 =?utf-8?B?cG12YXpIeTRtK21ROXFabWJ4bGRGSTdnZkhGZVlPdElHZzd2MGx5MkFhN2dU?=
 =?utf-8?B?aGgrTzNxSDBtMDNSQUVyWEM1RERCYVY3azRMQ01mbEc2bFhxWXA3ajVkRWw0?=
 =?utf-8?B?aERzQitDWFg5UU5xeWphZ1haeWFhdlNtNmo5c0RDMWdJMENDWmRGYXFzc09n?=
 =?utf-8?B?MnFpTkl5ZzgrRm1XRjl5MVFMVDBpT2FHd0pOZHB3Tm93SXFnemlBY0JnWlRM?=
 =?utf-8?B?TUVlNU5jRENqY2VwUk4zdDFhWmQxMkJGTFliN0NaenFxOERqVmhSZmtLZk1s?=
 =?utf-8?B?eGlnK2NOUmZLQWQ1bUZQUGNEb2FiWHJDRDlUbzdkSThuMFRrMG5HdDNHZkcz?=
 =?utf-8?B?ZWd0Yi9uWmorYVJQMXg1djR4bytvRnZtSS91azhWeVVMS0wvYzdCdFN6ekZS?=
 =?utf-8?B?U3pVMUIxZFJJWit6TkZpNHRsY2kwSlJaNlVjeDdmcEhWMkVMWVdEL3hoZFk1?=
 =?utf-8?B?NnVPdFBaelh3bkEwTnVWcUpMeUFVbjVjNXlFTnhBaTE5Yko3N2JsSzV6eFdz?=
 =?utf-8?B?c2E1emdzbjJrS2J3QndMZTlYOUJRMzJWeTJmcHhSYzB5c2ZBcWorbW9jRmY5?=
 =?utf-8?B?dnlLbDJWRGpiWWd3QTBJcVYvSE1XL1RTeE9YQlpyaVg4MXA5eG9KZXNJOFZr?=
 =?utf-8?B?NnJmN3IySGN6cGVoNGVZVjBKYUhyL0k0M0FkQjZVYVJkRWl5cTMrem13dVUz?=
 =?utf-8?B?dFBvVS9WNlI2S0pqbyt4czhuVGszdWs5N0w3dDRrVEd2bWVpa1ZLL2dodklH?=
 =?utf-8?B?cUFzYlRKMU9SSGxMeC9WY2xxamh4NHo0TjJDRmgyZUhBS21NcHVkbkZWREY5?=
 =?utf-8?B?OUpQTWxYNVBZOFlOUXlWMWtYWUJDNWdUWEhxemowMGNxcHgyMmluVkNtMGlY?=
 =?utf-8?B?MEl5R3dQNk5jQ3BMMXhPQXcyc2VRYWR6b0tCM1VkNVZoTnp6bFBhV0NnN3ZV?=
 =?utf-8?B?Tmx4M09HZmZ5bU0wR2pGdEppTUk3UUdyMjJZNGtTR3Q2S3VoYjNaZzN4MmlZ?=
 =?utf-8?B?WWtoaGRWSlo4bWFtaUFHckZuVGNQS3RJdGJHL3pMWC9VajJUcTlXR1hrS0Fv?=
 =?utf-8?B?VWk1QVYyNGc1a2JlQmRXZ0dDQjVZUHB1aE5aZDBqbWFiamY0dS8zV0xvczNK?=
 =?utf-8?B?Skw3dkJwL1VyTUd5UjJ0c3BORWhCV005UjJ3YlpEeEVURGpjanpwd081ZU84?=
 =?utf-8?B?QW5zSHdVN2VRaEtCMGc4akNZMUo1S3hMaWRERHp0RXpRcVBXQ09vTmI1anN6?=
 =?utf-8?B?dHhrZjlpZ3FZNzExdW1mUlI3aEdyeTByOCtyQU9FWFJNSGI5a2VTZ2N4N050?=
 =?utf-8?B?eTBnWWJIRWc1RUsyTjRoYmYwalNYY1RWYVNJZnJoVlA4czlHNFBNVGdleTNN?=
 =?utf-8?B?dERqeGkzdzVFV2JpdVEzWFQ0ZUNLU3hHcVBFcy80NVoxSWx1b3o4VVpNeFUy?=
 =?utf-8?B?dlJhU0ZMVHVLUmh6b3hwT2pGZzRLRHNLSDhLNHRxMDFRK3l6R3VjaFZyNG53?=
 =?utf-8?B?NTdmYmxaVG5oSVJvNERQWkpHWHZZKytPMFFieDlMMWhWdWt1SERwc2M3MGtr?=
 =?utf-8?B?S2g1Ykx5TlZJWFdudURTOTVrK1lxUmlaVnkwM21WbWxEV1JlcEFUODYvNk4r?=
 =?utf-8?B?NWFFaW9SMGs4eDdGOXJqRjlBS3BiRFVkZXZPbW9FSHVnRlFLa1pFUGtubThu?=
 =?utf-8?B?YjVQNTB3dGIzK2NVMTYyWW5SSTl0Nm04aWg1R1F0ZjFlaktKV2FlbWtvdS9W?=
 =?utf-8?B?Qmpud0VZbGxhS1BXYkFqZExmNnY5N3lHRlFNK3BUNUlERERLRENxN2wrd0dz?=
 =?utf-8?B?SDJsMzhML3ZiNVBGaWZJOTlWZEpmNnV3TmtyZGd0OEszZlZCb01Pd204UnF3?=
 =?utf-8?B?SFZOd0xvYU1nTGRQTk5Kb1o1Qlg4TFlCejRTdVoydEtscmVmOXdpMEtlbEJF?=
 =?utf-8?B?UWxvMS9ONVBzeTR3bXdhMGNhaG9ScGErcGh5VDJCb1FaQUdGeEhSZUhFVG5z?=
 =?utf-8?Q?nyxJGW7048i+aP1b7MaN4ZHnn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e06d89d4-0310-4b9e-8fb0-08dc077f8217
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 08:32:20.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQhk7LB6w+fwPKe74flYHL/0CqAGQO04hSs7RSW5qQp3m+HX+mjoUiq6XAHeLTcnhG2JF7UjA9I7v8E7EXPuJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5474
X-OriginatorOrg: intel.com

On 2023/12/28 14:38, Tian, Kevin wrote:
>> From: Tian, Kevin
>> Sent: Thursday, December 28, 2023 2:38 PM
>>
>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>> Sent: Thursday, December 28, 2023 12:14 AM
>>> +/**
>>> + * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
>>> + *                                       (IOMMU_HWPT_INVALIDATE_DATA_VTD_S1)
>>> + * @addr: The start address of the range to be invalidated. It needs to
>>> + *        be 4KB aligned.
>>> + * @npages: Number of contiguous 4K pages to be invalidated.
>>> + * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
>>> + * @hw_error: One of enum iommu_hwpt_vtd_s1_invalidate_error
>>> + *
>>> + * The Intel VT-d specific invalidation data for user-managed stage-1 cache
>>> + * invalidation in nested translation. Userspace uses this structure to
>>> + * tell the impacted cache scope after modifying the stage-1 page table.
>>> + *
>>> + * Invalidating all the caches related to the page table by setting @addr
>>> + * to be 0 and @npages to be U64_MAX.
>>> + *
>>> + * The device TLB will be invalidated automatically if ATS is enabled.
>>> + *
>>> + * The @hw_error is meaningful when the entry is handled by the kernel.
>>> + * Check the entry_num output of IOMMU_HWPT_INVALIDATE ioctl to
>>> know the
>>> + * handled entries. @hw_error only covers the errors detected by
>> hardware.
>>> + * The software detected errors would go through the normal ioctl errno.
>>> + */
>>
>> * An entry is considered 'handled' after it passes the audit and submitted
>> * to the IOMMU by the underlying driver. Check the @entry_num output of
>> * struct iommu_hwpt_invalidate for the number of handled entries. A
>> 'handled'
>> * request may still fail in hardware for various reasons, e.g. due to timeout
>> * on waiting for device response upon a device TLB invalidation request. In
>> * such case the hardware error info is reported in the @hw_error field of the
>> * handled entry.
> 
> with that:
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

yep.

-- 
Regards,
Yi Liu

