Return-Path: <linux-kselftest+bounces-2428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376A181E4D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 05:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1334B21B0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 04:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0981A29C;
	Tue, 26 Dec 2023 04:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1p1wLn1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B61A700;
	Tue, 26 Dec 2023 04:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703563918; x=1735099918;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2Yq+YcWK9VhlgrL46AhP3LCIPc3CrpkKhdDgihNVfHs=;
  b=K1p1wLn1/uBgttFd8GOOZCOvoga2kL4lY+oRhZvDEO1qmpzLWsSGJkIl
   yGiKQGHhL4Z0ArYp7OKj6BibzlyAqniZMusxYt4ZoD9WxzFrOJ7ZDE7n+
   ETs4SqZkVXjQt4fUXf20gKG0y17EGPqIOq4NCGCQmWCQIKFy3wSmqdll9
   INke0FFxjzBbtACBjLqD/KvLEgoZsl2C3tj+rSEm/m7/LwDEqiO11jFBJ
   RaIsAm//ZJ1l/I/7aTkV6+D3btqoZXz+wxm0w8v7Qaj1JhPUwjBkBwQxs
   FdZAAw30VClWpynGJsB6Rjv3SpxKhTpmWtfpr7JnhnHlBgwLAVn1krUnr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3151550"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="3151550"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 20:11:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="1109282157"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="1109282157"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Dec 2023 20:11:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 20:11:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Dec 2023 20:11:56 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Dec 2023 20:11:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFtrImUxfbhBpGRa19oaAv5+XvLXa3reR9I0Tz8jbgOvgOoNBI0OMXT8c2O0X1qVoCHxtYSafcRhPV8H1bSZ3Iu2ToFSPGjCGTv5fYvGS2czoUB1VFjG4CzTTFV4boiZngBW+omElvDME8O+uBkVlgxoND11tTCH4dDKVvHMnit0GOrPDPwHueQkfEgWAn/4wtmfOGdv8hrBv+pzfvSj/unn+EmdYD8BMikoWbgutMd0Vuw7liTih3/5Nfz0tQhG9Wo1Z7abUHLVMppgDMCsS/+3MAxGX7sVg9EsymszRd+DJdyVmAU25uUowpMpTbe2pdCw+fGWz+BjBiNtygTodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+KT6v3508+3sfULP3Zz8yy0dame5yGhS/HA0vXFgF0=;
 b=jnfioiHTe4bJ7PX+zElG7hMy5QPlJ/A71PFet9/YdNXi3wESG4uUSITvH9S4XRQFtf4OZFYnXEAgP1WRpvyQI8GAoxcYbLx2vNUx7nDb5udlZcB3HmGoUfJExwp9SKeA5c85vlxhlrCVkDoyoBeXZN1upQ5+AlUcOaeveiRqgIpkwR+Ghqnj9O/jhCl1lJhg2/3aEvR//U8IYuaQ1g6vDixoaA3AEeAXqhly4+0m07gYZcg/ssd6KNtOHIttKXD7cuNKZ2JPRnQbFYKsjEr/MsSJMli6kq0IzVGIYYkx4J2AgoA0LGI+LzGtz+wkySX+EFee46BHeUpvNUY/IXbg2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB6696.namprd11.prod.outlook.com (2603:10b6:a03:44f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 04:11:54 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 04:11:53 +0000
Message-ID: <ce341fcb-cdb3-4ab5-8720-faf9d8de1ce4@intel.com>
Date: Tue, 26 Dec 2023 12:14:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/9] iommu/vt-d: Convert pasid based cache invalidation
 to return QI fault
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
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-9-yi.l.liu@intel.com>
 <BN9PR11MB527600A6E4F860C3273B3B098C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB527600A6E4F860C3273B3B098C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: a1048cb0-97a6-4fc9-af71-08dc05c8cad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18F0mk7tzI+c/td9PGv6cdcUIqUfuusZhnIpP/mDTRLZFjIeRwwpPwjSywLLnGj3b/1eTsWJR7frd1EbaPSD7BHTbH8gOQay74znp5JKpQJm6EEOxx2dU+LXh1J6sOx05DpsjlNekD9D1ZDxDSabRqi5oX2M+B5OzoW8w9coliva55FnjW/KF7oAu6ywR61j9r9kCI3oWJTm13hN2k3fTLGQLrLBiKlKQJH0KNHUARP7JOU9bULKDtZz1laYGzR9mv6v8S0HDBKFqycrXJdJe+yjbTmFxvbIv3uz4q52Sm/6RYUxwlyP6jIHO97O9/SKX1NJ51GA7NriNUCi+HhgCL2VKMKUxjPQ849q66YRMUwHTeU83gAA8PCLnfHJ+5AxQszxSUkwfaytz+0jDtW193icUdCYs+kYZR97q5ebRmfd//l1ZoqaiqRuong4EC/qNEykvp4wAPJeY9F9K4TK7DZ0F58sUyV9nimkcJ1hKkQCdXcQoVmHN5itP1VreKiz21COsPT8HDKk0ywX/HOX7m8A6q0fJbhoFw+3M08ehVfTpfTsd2VhHnqk0EgtEW/0vV6sZfzrBRsfqYyh2v2h8awH+CYIfp2TsBDLwPix5ffF82pDZb489WsKtdQ6ZFKXXZqNdTef9cMHFTNTKpyAnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(2906002)(66556008)(66476007)(66946007)(5660300002)(4744005)(7416002)(4326008)(8676002)(8936002)(316002)(54906003)(110136005)(41300700001)(53546011)(478600001)(36756003)(6486002)(6666004)(2616005)(31696002)(26005)(6512007)(6506007)(86362001)(38100700002)(83380400001)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UENhL1AvVHJENHJ5UDFWME45c0N1VmF2YVRHWXp3bVBRSVE3eVhqaDVhaUJQ?=
 =?utf-8?B?bnkyVVJvS1p0b2JhcU9ONWpVYnJMd2J1Q1hRL2J1SHVDWmtmTDhrUnc4WG01?=
 =?utf-8?B?L2lzaTVoRXI4T0JQNjZsRTRxd3VzNDRmaHR1Y3FhSnJxQzI4cEhjUndSeUpk?=
 =?utf-8?B?cnJUdWJXTm9SdEloSWtGQmJiZHJwNHJvK1BQRE9ZTldnekxROWw3UWo0aUF0?=
 =?utf-8?B?OFpnY3Mvd0dmMXBVMTVJc3REUjh4ZkFaZnZkbTlPQXV1Z1JyUHV5RWJXTlY0?=
 =?utf-8?B?RWdJRy9kaXlTZExLTWRTTHJZdVNiQzcvWmZ0U3JIN2hnZklsaTNiY3BKS1VS?=
 =?utf-8?B?d3UvUXcvWU1ScHdmeTV5dUxTRU14bHBmOVFBSkpYdERXL1FVNjF2WEUxdWlo?=
 =?utf-8?B?RHA5bm9RVG9YNEN6N0l0b1NKYkY5TUVyckorM0RtZCtndDFadjh4TEhDYS9B?=
 =?utf-8?B?R0JHUjFpUExXUHUyNGRzRjJsRVo3VUV2QUNjeFJrbFp5NTJsK3diKzBrWDQ0?=
 =?utf-8?B?c0ZTM2UxSWF2Q3RQVjVVQmdFR0ZJZzhaNEZnSy9ORlpMVDJOcU9zcndYNXFL?=
 =?utf-8?B?YTY5VkRYWUVJT3VTbXBqMHpGK1NxekZteENCQ242cUszbzFaREszTmZzQ3Ba?=
 =?utf-8?B?MnhJT2tIVjA1czYvR1hSQVBmUW1UNVQ1NlArVXlBZTd1Ry9pYWVMTTZvQkU5?=
 =?utf-8?B?aGJoRnpsanNQME05dVhxclRLMjdWYVZhMlhzWmc0aHJlbkNxTWcxNlpRWW16?=
 =?utf-8?B?ckZqamdSMmZiRlVpN2ZMelpWSnB4a2hGWUZjSXRyQW1aWUxpR1J1c1dRYTFo?=
 =?utf-8?B?TzlDcjFWd3VQZFNhUEptdjFOSGtNaDZxZW5XOU9yRUdZRnd3c2RRMklBVzR2?=
 =?utf-8?B?MEdhZy9VYW4zdDJmT0lnTWNzcEwzK2FyeURtVC9PQ2RpakQxUXp6V2RhZ2lR?=
 =?utf-8?B?dUREUDIvVUNSa2tnTHE1bS9CVHU4NUNwdlhDb2psUm9vWTRaS256RWZKRjFp?=
 =?utf-8?B?L3RFV2diZUZxSC8waGR6UStkbHR1RXBneWR2OXBIdDZYSHBiR2d1MXVDcVV3?=
 =?utf-8?B?dE4veXdSVXk4VlFJZUNpdWFHT05razV5ai9TSzcyYU9XTTJuenR3dmV2L283?=
 =?utf-8?B?ZFdTU2s0YkZjTmV3eHFVcm93eUZDQlhzSjg3b2tGeDRSNWQvaGVidi9GYmVQ?=
 =?utf-8?B?aHJ1R3cyVzFwa055Y0lUS3JKbExvQXo4STBySHVQVGYrMXluYzcwTDN2ajAv?=
 =?utf-8?B?ZlEya1ljVlByUDhCVlI2QmhaSHQ0ZTFkbVpMQjkrU1hxTTZROW1ZZ1JUSUpT?=
 =?utf-8?B?dFZvN1FKdDNhOWdWN0wvTmFYa0RHaWpWQ2FwV2pLL05OajFKTzNvUXFZTXFm?=
 =?utf-8?B?elVrV0lScE9vZi9XRTNmSjNpaWdSdUdtTWRGN0R6eS9lYW9Gc0FudUZHOFF1?=
 =?utf-8?B?L1AxNituNEF4SmFRaEFIM3JKL0x1TlAwSDErK0RTS1FqVkNLNjBuU2d1UE5v?=
 =?utf-8?B?VEozN0o5SVJUVy9WK0YyVk1zZ3g1WTJMeEplNVlPZW9LeFZEdlMvRU5RVmdR?=
 =?utf-8?B?NzJCTVQ4QllmQ0pyQVFrWi9KUys5ekgvN3c4ei82ZFZ1S2hEOGdFR3JyYTRQ?=
 =?utf-8?B?M2p1Q2dEYnFNYnRiK01jY2VGQ2ExWmtBL3ludXdheFhBOFlTYURVc1dEbDA3?=
 =?utf-8?B?UFNza2JjdjAvZlJTOG1QTDIvNVhhR2hPU3RXbFJlVHdkbDJyQkJOSmFyaVJC?=
 =?utf-8?B?SFhuRDVuMlJKcU9HVU1IVlB2RTJSRG1Zc0dUdzVtN0d5SENvWlN5dEhRbGE0?=
 =?utf-8?B?SU1YaWt6WnRLR0xvZ1JjcVNxOGU4QUUwNmthVkx2WTVKQlVrZTI4MTdjSmQr?=
 =?utf-8?B?UmpRYThzcWRJUGZjbURBQkxEazlqVmx0THphM2haOG5LM2NacnVNNTlLV2JC?=
 =?utf-8?B?MUlFaEQ2a3V1bmRyM2ZQekpudDliYTVWR09VSGwrWXNtWXBKa3VVNW9idUho?=
 =?utf-8?B?RWh2R2c1U1d2YUEwU0F5RmpvWTllemZON0MzL2VHTkVHMkVSUHJ2Ym9FZDJx?=
 =?utf-8?B?TlU3eWh3Vzh4UTlTSDN2QlF4M0tlN1hxaDVNOUhPKzB5dHFvcjROMFUxWUYx?=
 =?utf-8?Q?MudcCjcx3C/zrfff/AQVj81QE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1048cb0-97a6-4fc9-af71-08dc05c8cad0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 04:11:53.7547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlh4tSzm8s/wpS+D6GYUnDFZsjLHUWbOEVHhVfNOL7FxUHhYcExXdzEcpKdk4mdyLJiOHkJVEES0mzRFUDm6UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6696
X-OriginatorOrg: intel.com

On 2023/12/22 14:04, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, December 21, 2023 11:40 PM
>>
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> This makes the pasid based cache invalidation to return QI faults to callers.
> 
> it's not just for pasid cache invalidation, e.g. there is also change on
> qi_flush_dev_iotlb().

yes, it is. May be as below:

This makes the pasid based cache invalidation and device TLB invalidation
to return QI faults to callers.

Then the subject may be:

iommu/vt-d: Convert stage-1 cache invalidation to return QI fault

> 
>> This is needed when usersapce wants to invalidate cache after modifying the
>> stage-1 page table used in nested translation.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

-- 
Regards,
Yi Liu

