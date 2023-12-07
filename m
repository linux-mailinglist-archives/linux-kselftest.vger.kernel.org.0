Return-Path: <linux-kselftest+bounces-1336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B6680812C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 07:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B7D281843
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 06:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB37413AED;
	Thu,  7 Dec 2023 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvpgXgH9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF2F198B;
	Wed,  6 Dec 2023 22:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701931842; x=1733467842;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8j+BnTwvVq+Bibs41zIel91zbmrCT4gCcwpXjdTVpQU=;
  b=EvpgXgH9JB2sXAHkVv+56EBE5hC1bF7UG0wWvCpYzSoUb2Xv34eK5zYx
   mCNvA8gh0o3BbTJGfMm/PCYsWClN87/TcAJxL5wRBzl4HXSxXn+oG6FNP
   bB6IfJ9ObVZTWQk4cI157vAU+idvG4qgBl+QtvPsiIYs3fYoOscVCDJf1
   N/fjbbT9rutzuI7hJAiHKj5c/wCf/8d30/putCKbVFLZrpgOfcTcuZQg2
   cIIRoH4cJ0C7E9WUidqOX4xyKaVuaqGcQlgWDzgkqgl9m3sKzOAA5yMFP
   S4ZHDG40t8OzvzuO1UAJous37k+o5UpUyGRmqDYz6/MDkYBf1JYSA9hZH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1055025"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1055025"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 22:50:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="800628748"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="800628748"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 22:50:39 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 22:50:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 22:50:38 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 22:50:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqDG8c0Drkz3qU6l7qIS0mDw7Vj4klBbMZKZ5d9VKJlI+qoY7wbpkJRxWZS50FToILUZOJ0HqeFDTFygSDrnCn6pX33LoTnB92QmCv957Mdha0rlrPRkdBcGQnzFx0pb98rsK2ZSssI09D6GhxMLu4JLkX5XBDdlVA4+QzQevSyR3Kxma0ri/dNnMPoYbHWpqtDWzsWZAuI3sIW6jAejfU37jnJI4JXYQDCPVsOWneEPb1vlbno4TQ+hiMxQH8TE8E2N6c9AFI7lvf2Zv9dUqjRWzw6gGyehMzIYlzvyXOx+J4n1mJIK9HdTlyQk/sazpGOYhR7KhHE+uo78PKPmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEdYgpoGbJmwR8qnXPa9aJkZqQ0LcGnwZWuorOblP1w=;
 b=EpOUBwY9bqZEmu5QYyGyfJXSao4qry3RldHNS8lXLWAYuQ7lpBk96YqDSdSPkeS1cEE8J/oh/+md/MEu1Dmskm4u5OFTsResSHN37V3aSsv6/7ZZPNoNXQ+d3iV+DaotgeYbuhzM8mcoXTb7xk4jOcw8pCYIeZYbjxNqsqHD+INedKgFLI9eajsx4ncGDlNsyNL9UJ7I+1ekcwtlPpdmc84cl9l+TPYsnKu+t3Te6tgJs/Ev4pO+393FaBVcnulZcyKsTWHKdHWbyv4WtI9FcOcPsq+kNLUY7Ew/oIJjlPbWaWww3mT3JlQWCyEZl5V525nbaUeoDEDPUZndDzigog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 06:50:35 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 06:50:35 +0000
Message-ID: <a9699f71-805a-4a5a-9282-3ec52e5bc81a@intel.com>
Date: Thu, 7 Dec 2023 14:53:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] iommu: Add cache_invalidate_user op
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: <joro@8bytes.org>, <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
	<robin.murphy@arm.com>, <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
	<eric.auger@redhat.com>, <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-2-yi.l.liu@intel.com>
 <20231206183209.GZ2692119@nvidia.com> <ZXDA1uUzvxmLf/o4@Asurada-Nvidia>
 <20231206185031.GB2692119@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231206185031.GB2692119@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 2096279c-bc06-4d7c-53f3-08dbf6f0cefc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cyZGejlbxpgxXgpvglOom/yy5yZa+hpzOiseYEwVn6vOriO2wSs7sQKIeojhJnMBcmZXWMsQty7Knry+bSnOTrJ5CAktKjV3YgrNgwFZJBKkAhsVi7WCTp6uIXX5EyD97mMDSxWzbvysQFI5oqK0/2ALqAYy5D3IKqJJEQdHMNPNkgMUXY2UBuHcKIc6piY2Vr4KUYnkmridBuyC+HZwet2lexXdU4b/QQn3aThI1R+pp3q0xYz58PjoD5c7AJvscY3BXqY4kzBdGP6vS+7H7N8FQD42CXEcq5ymBAVMJ0sJiz3iPumOQc5LJ3ekN5q1wOhVbICCe4QqMgjW/3UwBySvyKld7LJ5ugVzraDXa7Ag+OzHlV12/kIxQTTG8hUkeeGkl2HiY6NP1rPfFaR+u9AlEynUg26FR2s808eudRZ2ghYgjn/kIFMeOM+XaeuQj3VkDhPm6hK001bZHtcqObJlGQpTh3ol5H4zwHO6vLy2X6htuRYYC8fRF9299LPU/CfgsuxL49n/PrBfJTnnnXPog4aOht2EejZ+5qRUsEaUPuDUDvZC60cfCRywy904J2P0Mp8SkgDHOKOtn51UXemE5l4fom8RKAmSQOwUUU0g0edtXmVlPldkCYn5J8YsJ/J4S6EUyQK3yPEpfqPZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(38100700002)(7416002)(2906002)(41300700001)(5660300002)(82960400001)(6512007)(53546011)(83380400001)(36756003)(6506007)(6666004)(6486002)(2616005)(26005)(66476007)(110136005)(478600001)(66556008)(8676002)(4326008)(66946007)(31696002)(316002)(86362001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGVNUHZqbjBUWXA0Z1lEY2VEMVZSYVJRRURMU3VrVnBlMThLdkxQSUVFUUVp?=
 =?utf-8?B?OCtoNUVaZlJQUmRNblE0d0Q4Z2JIWkhtRmJzRlFxOGExUXJrZzN6VU1IRGpk?=
 =?utf-8?B?QVluUWxiTFRhcFAxMUNWZm9ybERXU01uQVR4S3pSK2NFY0JsOCtaOFlRbTcr?=
 =?utf-8?B?YWRySkhQNUpTT2hLcEk1dzdNclBXeHJmVlljVnIxaHgyRlRnUkc5TGtSak93?=
 =?utf-8?B?cG5kQWJtU1plOHdZNE8vZDY1MzZ1UXpLY0o0ZVJQVUF2ZGRCaEdueGdMTU4y?=
 =?utf-8?B?d0xqM1krYjkvaEZiUXNhR1dVdzBTbDlhTitkTUVXbisrRXc1L1JXSS9RUWdj?=
 =?utf-8?B?Z3Q4WEhWcmNBa1ZYa1lqcmZGM3VFOXdpUUtLYmNuVk5UaDc3YkZkT2NhWmJM?=
 =?utf-8?B?WVZnaTVwR3NRMjZuMitGejhIK1Z2WEtmd2JoUWNzcTJGc0dlOXRXcVBEZEtl?=
 =?utf-8?B?WEtta3hvVjk5VDRjN0NpaGgyWGg2em4rL0Ercm1DbDRZa3pIVG1qWWJSQUtB?=
 =?utf-8?B?V3dBd1dybEFzMk9pTmFmellJMlpzR0FEdnRPZXp0aEQycS90YkdaTHBCMklS?=
 =?utf-8?B?SVU5bi9abUZUeXArS0RRUGRZWHpKL1ZjTnVqRkFVbDlqMXdyVHBsei9JR2pY?=
 =?utf-8?B?RVBWMzdOc2poN3VRbktzbjlocWVkbnROMEF5cFFBbFdSZ2VleTdEVWdJaGVI?=
 =?utf-8?B?Z1MvZjJvYVFobzBsZ2doOWpycldzU3NSSStqY2grOThFbDhHVlJWclVvVmJV?=
 =?utf-8?B?K25zQ1JqTVREc2tTL1U1ZUV0RnFlMlFYaFZBTnFLR3ZyajlGMmZYcGxXcjZL?=
 =?utf-8?B?UnBzV1BVbzV1WEIyaEZKc0pudGhodXZnSktlYlVZNXFEcitwNWFWcmsyNDBm?=
 =?utf-8?B?ajNBSDhhZFV0UmlXZ0wwL2RQNUttUVk5blJTWWNZbmpsdno0RlFSaWNZVXRz?=
 =?utf-8?B?MnVVYzZlQzVwY2FTbkQ0TDhvemViS3IxSnVPMEZyNlorZXp3S25kWVdxNDNP?=
 =?utf-8?B?UTRyWGxaUUNuU044UHpwc0VGZGFyMXhZcmFXM3F6clpMZDhZdnlvc0FERWY1?=
 =?utf-8?B?aWhZVE1aTGk3VU4yUnpGY3BlMmdVZWo2bzNMVzVDSXZZcUJ4bDYyRzdrcjVG?=
 =?utf-8?B?QUt4ZU91SFo2SlhNRlhIV0ZtRlBrZ3JFT2M4THZKL0trcFdORlQ1d1VLUVNU?=
 =?utf-8?B?N1hsZXBIeWQ0cjlPRjQ2UXExdVJyVnYybHlqekF2MS9ORFRoUFFSS01xZ1pZ?=
 =?utf-8?B?Y2JVU3Rqd3pLa0NwU2pkckw0R1h4cnc0Y3NSYW1zajN5SHErTXJaK25tZmdo?=
 =?utf-8?B?RUwyUmJEWTVjdDVabmpBMzVFZC9LLzVNQkF1OEtqcW10UldHakpJN0tBUFZO?=
 =?utf-8?B?QUc4Qk1FN3lKVXEraVFrc0ZWQ3c5TmJWYUpDZ1c3T25SdFE1bkVmK0xwR0Ro?=
 =?utf-8?B?YzAzNWprNHhla1dBNjl1TnV5Nm13dVJRazdrTEpTMEdjd1ViWEJzWGJFWTdz?=
 =?utf-8?B?ajIrd3pkRXFTSWpkQTNkNEhyY3YzdHZMaXNRWFArRXlORkxkOUlyL0hJUFhB?=
 =?utf-8?B?cDA1WWQ5VWZvekV6eDRpMW1LbjRSd0pqaFpGSXBuQzNVbnplR2QzUC9WZGVa?=
 =?utf-8?B?elRtWExQYlliRFcwNVptWDdrQkRvcWZvS2RKME4zUnRIMEtuK0dGSlg0cUFU?=
 =?utf-8?B?MFFvdWxHa0RBd0s4MjNQb3FPdGtDSFQ3Z3BnVnNnUEtnNFpibDlNTlZDSklo?=
 =?utf-8?B?cmlPclBPdi9GRTU2RnZwV3ZiYlQrNUNmYXVoU0pkUkJEd0UweDYzaUx6TnNp?=
 =?utf-8?B?ak9KT01aeGVOdkxUQWdYT1EzY0JzY1ZJQmpodHY1MWU0dXRpekdQYUpvQ0Fp?=
 =?utf-8?B?d0lyL1IzYThTSk9ZWlV1Ry9EZFpVMkdQNGEvYk1sZHU0YTJ2NERwRjFkeG85?=
 =?utf-8?B?NXdFQVZFenc3dlI0TDlzVys4dDJrQlVQWnlIeHpzdmdycGNMNnlIbjl1S3Qz?=
 =?utf-8?B?QW1tSDlvNDhXR2plRXlQYStueXd2QmlvMW5RSldhNHdTanNiM1NxZUpQWFd2?=
 =?utf-8?B?VzFEVXVkZnNORDcwS3hZSWVtSk5Zcm5RNWliVVZEQjlxdjM2Z0JyWkVxbS9Q?=
 =?utf-8?Q?JKZqOSrODLFU2vewTfq8VXkW9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2096279c-bc06-4d7c-53f3-08dbf6f0cefc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 06:50:33.5616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOQgYYA8wpVuvwXYEPdxH8dqVC7CMAQaDIDgO4y+rUxUX5QAS4NekvMPOFbkjTAlY9fBk/4Fpt32c8d64WraEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7312
X-OriginatorOrg: intel.com

On 2023/12/7 02:50, Jason Gunthorpe wrote:
> On Wed, Dec 06, 2023 at 10:43:34AM -0800, Nicolin Chen wrote:
>> On Wed, Dec 06, 2023 at 02:32:09PM -0400, Jason Gunthorpe wrote:
>>> On Fri, Nov 17, 2023 at 05:07:12AM -0800, Yi Liu wrote:
>>   
>>>> @@ -465,6 +492,9 @@ struct iommu_domain_ops {
>>>>   			      size_t size);
>>>>   	void (*iotlb_sync)(struct iommu_domain *domain,
>>>>   			   struct iommu_iotlb_gather *iotlb_gather);
>>>> +	int (*cache_invalidate_user)(struct iommu_domain *domain,
>>>> +				     struct iommu_user_data_array *array,
>>>> +				     u32 *error_code);
>>>
>>> Regarding the other conversation I worry a u32 error_code is too small.
>>>
>>> Unfortunately there is no obvious place to put something better so if
>>> we reach it we will have to add more error_code space via normal
>>> extension.
>>>
>>> Maybe expand this to u64? That is 64 bits of error register data and
>>> the consumer index. It should do for SMMUv3 at least?
>>
>> I think Yi is moving the error_code to the entry data structure,
>> where we can even define a list of error_codes as a driver data
>> needs. So, I assume this u32 pointer would be gone too.
> 
> Oh, lets see that then..

yes, I'm going to move it.

-- 
Regards,
Yi Liu

