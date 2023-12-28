Return-Path: <linux-kselftest+bounces-2494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A2F81F5F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 09:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D161C227FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 08:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7BE6FAD;
	Thu, 28 Dec 2023 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4rHcCQQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D99863CA;
	Thu, 28 Dec 2023 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703752257; x=1735288257;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Of+QGufFkc4iiaJzxEx1lWsZteBkTXyi0qJeJF04j4=;
  b=b4rHcCQQg8lca8JQGW/HVw76aERBsIzg+bgYIxgXSoFwUqXk7mvRoyjQ
   0ovklaxTyrPiDh7/I84dKfQ5K1ONPrYf4ZM9I62qm6tCk/EO20gLOJsOp
   flTTLgfwZIYM6V1TVCn28PnBC6x2xIQc320uZV4vj/MoLXQepLsRRfMWX
   w8uQ/tvBF15gzRMciDUAYZC4K8XlWM1EbQYisbIslFylRzhV1/EaWME5u
   dIyk0TBmFeb+yT9H5Ici39vsDWOVhUq5XQaVxgvyEp+BzvawHCQY0FLL4
   sTqz1v5MqGPWKebEDzREqaFL7+bGDwJOSOvABH1Ky+vimMYZ/R2v4H3SK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="381496738"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="381496738"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 00:30:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="728254207"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="728254207"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Dec 2023 00:30:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 00:30:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 00:30:56 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 00:30:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BduLJbezBiD+Sy2rX6FwQXKkH3btzDs51Q+UpVvgPwuGsaSHUceoKV3HDpjabUUvGWkiFNgCzlx0jMFjwUr84gww9NRQohxe3boP9Jmoj+EbEi0tWaYyVilUvkL+mhpOKw5YvJs6WQZ75PiYVLSltDOzgTHpqPk2NrnE6pOamkKH2obaOGqNQqhxPi0MZV5YDjIonVtP3dBLhIb7ekR0gwCl4YAXhl0Lu01sObDs9OXnSW6cr6k/zrLxRfIxwRrI0rtV78dXC9lz0MPsRkG7hXuPSWs8bEL1pCGh9HMPney8rE+JX4kv7Op3crXIx3JR2Qt8ps/XymgoVSh+ms5Luw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwPm3r8Di7ThTLNSMg7vY0Gc25TmIW7XyJGLHseRULg=;
 b=L5Rr7VLJGRk3zoyEmhMle/Q/ezelBCc81VxHihnzVVYVAg4xT0CkrXwOWmc6fdCPjeJF4MCkjpQN90e+gXbmr98F/iG+blBlX/oEEm1UWOOxAHo18eqBAsVFvlPzZwHfxCRgSuh1JMw71Hn64lE1cIme0eCLqULgFkkqRa3DKlb929b/NgASdNy61baN75WFRdazOn0xg63jUA15l8jT0Q1BwhTGXqfAxFF+mGSPc/FMADH/3q0Vgio4po02DgGcWfCJU5K7qwYKJJoVvEBLqZwvm/0OmyImr6rD0TcQ0tZ3A7h+8cgIF5arbCAt4vcTAMudLUo8TbycTgyBhwJlkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH0PR11MB5474.namprd11.prod.outlook.com (2603:10b6:610:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 08:30:52 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 08:30:52 +0000
Message-ID: <9370a5a7-6050-47f6-a3db-e042461a383b@intel.com>
Date: Thu, 28 Dec 2023 16:33:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/10] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
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
 <20231227161354.67701-8-yi.l.liu@intel.com>
 <BN9PR11MB5276429906ED56258BB433068C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276429906ED56258BB433068C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
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
X-MS-Office365-Filtering-Correlation-Id: ff017082-c698-4c1f-5824-08dc077f4d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ja5DBhsB02pZHAgCsqY/wQ2WiuIfKP9PZJVcCnGNbSFCkUI85ySVFPaPwXADNvVpaGPHvJXX7b+diCFsLqj1jvnF8r1z280bIB4IxK8SOIQPE884XofsdjJFMU/pxWJtxR/y4T2xDFzPb4QNAVs9oaah2eOnG0qoC3SSLU1A1sU9qGO1tCi1XjNi2UsYqbjx4j4BbUxtOWiaSCD80Bp0w03M3KvP0hNkMMufXG16kowRxHUB3ui7ffHmLp809UX9zPVJcJLXee2GAFixFF1NaBq8Z5SSasaXOzqFkPmnAZBXyKv/iM1wF81JYPGu6Jy6JG6A8iKOD78QLINs3aUjdaQFnxHCO6ClCdwpexwnfqd9jEaky89vRRXoZ4WMvO/iTaLwaKiXGuhZhwqijC7k3l74wSUxxy2JNvx5z6At2UR8AehV4XWUZfFTLokcmSMA69+vE5fqeDGR1sAi653x+DtFAjthV0E40pUdc1/s2EQsWG1ZUT7fJKj8TTQPNO/H5XKyGLSD1H8ATWEU0B7VanEWIHzKNuqCtjQ8Jj3BVaR5NMfd/0BPx3NnofslGYX1MTNO1WleHrm4i+XNeZY9DDeVsx7XGYD7cE1xIC9F44bmYQ14FRp5hN3HxcrwYCebFSIsLod4JQts/eRKEEzBZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(6512007)(6486002)(86362001)(4326008)(66556008)(66476007)(66946007)(53546011)(7416002)(82960400001)(6666004)(36756003)(2616005)(6506007)(41300700001)(316002)(2906002)(54906003)(31696002)(110136005)(4744005)(478600001)(83380400001)(5660300002)(26005)(8676002)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHJDSGxObmdreXplMFlkaDZPemxCYTRBbUZqSjdreTk3a2ZDM05UT0sySE40?=
 =?utf-8?B?d1Q4WnF2WDdzZXBlcTc0UVVUeUw1Y1hDQVZ6T3drSmxTL3JTZ2o4dEFZWFBX?=
 =?utf-8?B?ZGVWK2dZaDdzWXpRTGhGRGx3SWNydGROc2hMdmF5WE1VMlZkR2JPNFNVWjdG?=
 =?utf-8?B?Y3N3Wlhxai8xakNXeVNXMjBQbHVpdkxiZnZUaTdDNmdXYmRiU2FiOWJSaVND?=
 =?utf-8?B?QkhLQW43VE40WUF2WlNsU2NvV0V0ZDNreTNSS1ZRZ25mRkxHc3lDamZSNFla?=
 =?utf-8?B?clc1Sy9YbVl4b05pNDRIcUdmbmhsWVdHYTZ4WXgvSGZNNHR4RWIzYUZ1YlY0?=
 =?utf-8?B?S1BGeHE1aWFGVDA5VzhDN0pub3hWOWFDQVI2bHhDdDJCSE1UTWhxYWFqVWha?=
 =?utf-8?B?QWpIYmIvUElyblMrekdySE5UWjkxUStvZ05YRUZSQ0x5d0hpYTNFTGFKMVJt?=
 =?utf-8?B?blQ5L2l3Y21XU0RFNU1lMUFFZ2RjOUhST01ndGx3dGM0Q3JFaVZVUThWdmlM?=
 =?utf-8?B?ZENOaWxVZ2hqUkN5ZUpjZGtqUW50Y0czVUh1bVExVGg3R21qYmpPaGVRZ2lE?=
 =?utf-8?B?NHJGWGozT1J3RW5vanJFTHRmakJRYS9UcjdaU0dwSGxrZXB3KytNdFRmc0sz?=
 =?utf-8?B?OEdyYWVtWm1wRE91K0wvbVhtVER3b3NaZmwyN0g0aU1NVnJ4UWl0aUxkZTZW?=
 =?utf-8?B?bTVMeWhsT2NhQnN1MHNYd3Q1UThPYWkrbVhiYnZNeWx4Y3AwaEdMOGZVRGw3?=
 =?utf-8?B?bC96Tm1HclpwZWljOTIvYUUvNHI3eVIxQU5zcVBwRmlMM3lmTVdPcVY4RElj?=
 =?utf-8?B?eTJGQlpuU1dkM2tTSEZ4NGp4L20wZ3RPNUxVRk1zV1ppOHovRmQ2ODVmanFX?=
 =?utf-8?B?UGVWbEJuVCtsWjJCNTJhZzBqZTkyaUpxYjkwYm9zZHhEVnZ1UzM3MmhaaEk0?=
 =?utf-8?B?cVVqV1pNSjR0Mi8vS3RlSm9JajVUQlNBdU1YejI3L1JPbmVsa3hFTjNyMVVK?=
 =?utf-8?B?QXVZZGFJeHV5YzRtaUFQdkE4VnE5ajRpU0FRWC83ZXlZc3ZNZXI5am05aHVT?=
 =?utf-8?B?dGFLUFl1SHhhK3VGUmJiK1l6b1piZklzblJkNW82SGhnaXZudGxaNnFPNHNj?=
 =?utf-8?B?Z3QrbHhKZXgvYytPME1nYVFvQVh1NFZ6d0tkODNPRjcwYXBPblYxRGdPNk5L?=
 =?utf-8?B?WS8rQ3FJdE9vZjhHUWxZNUtYNHgwaWY5dGZJR1NlaVMxYjgzeEsvbFNzUU01?=
 =?utf-8?B?NjB5bEpoUk1sbmtxVnNwcGswZnVvZmhHWFdvT1owakxkY2I2Y2VRMUExOGhZ?=
 =?utf-8?B?T0pLY0ozSmdzYUFjM05hWFp6MnAxYkhnam8zTFVyUkVtSFdCVTBmK3JtVWtS?=
 =?utf-8?B?eG80OGhnSWFQYW9DMHN2UEpqU3I2SkI3QURncUt2Yy9WYXFzN25RTk5Ic20r?=
 =?utf-8?B?ZWUyVkZHOWc4ZVpQTm5pUHpnMmdxSTVQaHY5VXRIZVZxZnp5RVovd0RDaDIr?=
 =?utf-8?B?dzJXSVA2OGt6b2pNVkxQaUs1MEU3djFCWXlKNnFaQlpSeVJoNW5vT3VqVG93?=
 =?utf-8?B?dVFpYjJidVZ6cmxjVWVWd2VucWhBNFBPeWorbldkaEpnUEU1M2xiT04ybkZs?=
 =?utf-8?B?ODJvV3FscitDQVdDNE9aRStNdDVLcmRmbjgvTmxsS0hQbElzNlc1TTg0N1Ba?=
 =?utf-8?B?L2dWcC9tMEpQbFdtbDhTekh5TE1UY2tML25XWE1hVGF5OU80eVdJNXdad1ho?=
 =?utf-8?B?K0ppbzUreW5XRFRMNk1GdVBZL1BIbTNRVjJOc2J2YnVUZGxDSkwvRzUrVW9P?=
 =?utf-8?B?Rnh0V3NxZ05nZExPaFVndnc5Y3d6U3NlenVadjF5WGwxTXBlcW0wZDRrWHR4?=
 =?utf-8?B?TmlOVGY3dDhrSDZiakJoVW5YdXZXM0lRbitKY0dBNHVJU3p3ZXdzYk92WVhU?=
 =?utf-8?B?a1J4RGZyb0M4c25YUFdnQ0F3Rm5lTnZOdG1JTDdTd1BYWkFCZmZULzgybXk1?=
 =?utf-8?B?R2NpT1JXK0JkYlUyaVR4VWJadGl0ZitHd1A0ZU96NW4wd0JYdlNLcDY3T0Fo?=
 =?utf-8?B?Z3o1bDgya1JVT3JUME5KK1F3V2hTTm9FYktzcGZHMkwrZzVDYnQzdHhVVGZi?=
 =?utf-8?Q?xUZDgy/GabStoprgpmlZvs45s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff017082-c698-4c1f-5824-08dc077f4d25
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 08:30:51.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9CBLM9BzZJZJMQYLpJTgB8uV0mSA/inFly0Zys8Xr63kSGliA+K+fVAtsrVAuULkrqg08PggSHirtEy6DqFNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5474
X-OriginatorOrg: intel.com

On 2023/12/28 14:17, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, December 28, 2023 12:14 AM
>>
>> @@ -1376,6 +1383,8 @@ int qi_submit_sync(struct intel_iommu *iommu,
>> struct qi_desc *desc,
>>
>>   restart:
>>   	rc = 0;
>> +	if (fault)
>> +		*fault = 0;
> 
> move it to right before the loop of qi_check_fault()

ok.

>>
>>   	raw_spin_lock_irqsave(&qi->q_lock, flags);
>>   	/*
>> @@ -1430,7 +1439,7 @@ int qi_submit_sync(struct intel_iommu *iommu,
>> struct qi_desc *desc,
>>   		 * a deadlock where the interrupt context can wait
>> indefinitely
>>   		 * for free slots in the queue.
>>   		 */
>> -		rc = qi_check_fault(iommu, index, wait_index);
>> +		rc = qi_check_fault(iommu, index, wait_index, fault);
>>   		if (rc)
>>   			break;
> 
> and as replied in another thread let's change qi_check_fault to return
> -ETIMEDOUT to break the restart loop when fault pointer is valid.

sure.

-- 
Regards,
Yi Liu

