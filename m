Return-Path: <linux-kselftest+bounces-399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AC37F3CA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 05:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4D3281551
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 04:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE9ABA5D;
	Wed, 22 Nov 2023 04:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rw7zyL5F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3526B193;
	Tue, 21 Nov 2023 20:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700625616; x=1732161616;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=745B+CrCLV2K6dIub8w7trjC97TD0nt6yHzafoJ4ge0=;
  b=Rw7zyL5FL9q0yNzpmGQAT0LLsKCDK+P5OEHCq9ctcGEjurvx5x3wiSFr
   W4IsGP+e0697ijF8t1oFdDmOITwyDPTW4TJw0W+tqdVcTA1zf93M/h/zx
   AuSG6QmYhcUaJrhk+cuADyvbN8Fq9Cy+yZuviPIsRVh+YbhPWi8ygErOF
   f/b1K1S7nK07vGwZw9xMzu0V4m0gYtXWCTrO39apHZ2tf7SN6IOJT6NJa
   726IZvlvOt5B+X0DuGloZjym3uckPThJE6P1l5W3UvK76m9dnW4TxGAt0
   qSSTkkhJowfCUM80XQZdJWRbMh6/LffrWby4GEYyprIuTseGEZUeYJCZ7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="371328000"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="371328000"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 20:00:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="716720498"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="716720498"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 20:00:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 20:00:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 20:00:02 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 20:00:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1qvobF2nQl7D53zd4MR2wGYfoy32bB400XFZc+ORaAm7yzg74+pCDg534X0nML3yy6B5w68ydx/mQOHyaOVXmT8fbKQ13bzrXtGYp1aEG9Ihcw3cTxDVtNqv+WvjJaz4suibylWvdRtYKtKrWz6QyRZYkvGzUnhpytWyJulhhXN0eNs5vG1LKU0rkSzXYOw0W2K2tjlgrX9+E5hd40tkq5Hp9KdMg39pmb+eJQOcptKqBR6yQ692R39nHcZBM0lBkzITCBzpwPXHxZILbGGHg4y7jEThFKyjIpjJCIguXomBFOiMpCVNvstpVNoghmzAJgxs29lh55pX3NE3z2ZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkSe1g2X753DHwMYQuIPRaBzsB8mUrhPnn2ZnrOwF4Q=;
 b=Kw/1YOrJzE1upvB5beN5gxJGlW6eDcvhXM6NGJ92WQyfg6rhvBzRWSFK6mJBBBQuYeZJL/VyI2tYP+34ZEFY46v0aLbE2K3lV4dy2jzL4QpXYqFjoQG6v/dxhDwpCuTFEEgsGk1OttciWlK6b6beVcuiptTAMYUbUjHB9qMPyC6FsgjROiSST++Ml2lN7b+ONyHYN0smtcG7D5NL32EtQvICG4MLRkewklsdQreD4NgNKCgQBQV7SNcPQUY3FuYBjBjFZIjltm4Q3DN+nODFgok65bhJjUDDm3RbRHAHLeQJnro4uKhxXQHsrXePybCgdCyMpOzXM+FmApd6n0CLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7838.namprd11.prod.outlook.com (2603:10b6:208:402::12)
 by MW4PR11MB7079.namprd11.prod.outlook.com (2603:10b6:303:22b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Wed, 22 Nov
 2023 03:59:53 +0000
Received: from IA0PR11MB7838.namprd11.prod.outlook.com
 ([fe80::cbb6:48f6:d69d:f657]) by IA0PR11MB7838.namprd11.prod.outlook.com
 ([fe80::cbb6:48f6:d69d:f657%5]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 03:59:53 +0000
Message-ID: <e8400a3f-6ee8-4251-89ec-7d54b7f03365@intel.com>
Date: Wed, 22 Nov 2023 11:59:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/7] Add SIOV virtual device support
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
CC: <joro@8bytes.org>, <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
	<robin.murphy@arm.com>, <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
	<eric.auger@redhat.com>, <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
	<mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
	<yi.y.sun@linux.intel.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, <jacob.e.keller@intel.com>
References: <20231009085123.463179-1-yi.l.liu@intel.com>
 <20231009132115.GA3952@nvidia.com>
From: "Cao, Yahui" <yahui.cao@intel.com>
In-Reply-To: <20231009132115.GA3952@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To IA0PR11MB7838.namprd11.prod.outlook.com
 (2603:10b6:208:402::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7838:EE_|MW4PR11MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 4087d307-1a28-4cfc-a749-08dbeb0f7af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PNvDEIBQrcptl4yCES0KQHUv7rUnQkDMKI9VHAm3kk2anZq/KXpHtPOWlyTTq5UU5c0TXcBsPQVV85J3kMjh5942/mx+Tw+eV8l3Kpwdrmf9b7kuIpx1sVuCfj5afgX1gjolxN+WfattuzhEsux2x4NUehO+t8FAWNlzwQHiJr6134qk1jM0fGHweNerjRePiy4BpZ9gsllILyjF4LYnmUhvDMorusHZWf0cs8MTIWfyAUad1ekRQVDM4rJ7SStD+/NlTTxS/1qve3I9/VyeEAG9eEYYsTYeu0YgOb4oz9ClQfqC/zjxdtUeHUUvdK5fksvCi6LJ1qh+TvWuIX4hDnsPp1iSxAZFd1swTAtveCleuHWovT/kIx2WChvzyjEF5aO3iJPfT/BVcY9TfvVyjaa5ve3+bNyuDql+KfPcM40YdBc1fj5C3HHQVCSbCOzoYDA1IUcMJAhvgTqXJBU92ETZPqHM1mAv/65dzVLi2TY+pTbKXEa6EU7eWkKaCNT07DnWBDMg1Ose8eLX/AB2C21zsrQ/t1hAKB3V5flahX+UpPEWXeXFofLbTdOJBtuh1GiEUXG8uqxM7dshusSg7z0ntcblN9em0H7AiqjvWfcHdD28AwbDaiK4aYevDyMYwADLLa2C1ZumPYaHz8knTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7838.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(82960400001)(31696002)(86362001)(31686004)(83380400001)(66946007)(6636002)(6486002)(110136005)(6506007)(316002)(66476007)(36756003)(6666004)(66556008)(53546011)(2906002)(7416002)(26005)(6512007)(2616005)(8936002)(478600001)(4744005)(41300700001)(5660300002)(8676002)(4326008)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJBb29tT2ZFWjdKNk1XUVk0cXlsUk9sLzdEM0c5NitoQ2tsY2dMa2h1ZDNs?=
 =?utf-8?B?Vi8rSGRKcFRlRlNuWHk4UmszVGJVdVRkeVNUUWhnb2t6WFZNaUZqaStRY2Z0?=
 =?utf-8?B?cVdqdjZRK2pZeHVDMnJrLzhBMGtpeVF0TmJpN0EzTXpQTndlQkpWKzl1YjY5?=
 =?utf-8?B?bFRXQjJJUUN5aklKQ3RMUGdhdjZ2VkpPeTl4UEpHcVJES0R4NzMrbUdrN0Nu?=
 =?utf-8?B?VmFQajQvVzFDejNjNFJEKzl5alpmNGNxd0dDVGY2TElSbFBtemJwY2dLTVIv?=
 =?utf-8?B?WCtHZWludUlDUXBRcHdHK1JPbjNTTkMxalhxbjBUVnc1REIzTDVuZWd0S3l3?=
 =?utf-8?B?MXVpVU1nK05pZWVEaVRaTFNvd29mUXpNWHJaWGd6QytKUWQvd1JHTDhkTFFL?=
 =?utf-8?B?alNkYjVxeWhUc2dFV0JaNjFlRERYOXYvTlBwOWQrUTJIYnpqaDRoY2lJMU84?=
 =?utf-8?B?N0NnMnNhU2kxalpWQW4yTldBeUJ1dzVibGVPQnJhOGNkYk1YZkdFaERLaHg2?=
 =?utf-8?B?NXU0RllwT2VkOWpqNFZKZ3NmcEVBNnR6K0VhdlF6Q3I1dnRIbDVXRTBlTVRZ?=
 =?utf-8?B?Y1dWVjVkQ09ZOG81KzNHR1VrTnJhelJoVlEwZ3liQUx6cVNpVXdwQm1ML0xz?=
 =?utf-8?B?bm9MVnZXeVdmNUtPTFZhalM3S1RLTjEwT3czbmJHeVM5Mmo2K2gvM0N1aFor?=
 =?utf-8?B?eHlKRGVETXJUNGlLR0lsU0JiSjRWMmUvMU8zeUV1KzFXc3ZKNHZKcUF2SzdZ?=
 =?utf-8?B?cXY5Q2hzL1JoVFlmNEFqcnRsU3ZvSjRkYzBoWFJyTUdFNEZ2bHFidXdNODRr?=
 =?utf-8?B?R05wTEFObXJ5Vmh6Y2swK2pSejlXSWdVOVJsT3IreSs3a0x3T3JLYjFpYSt2?=
 =?utf-8?B?YWI4aXJEK2RINEVLeGRoOWFXWGQraDQrbCt3VFU1Q1VHWDFIc0pVOXl5dTl6?=
 =?utf-8?B?ZnY5MGhJMXc0MDMrZHpKMFhzOXZSSGRMUHNPdkJrb2ZtOXF0ckVsRTRXemlH?=
 =?utf-8?B?YjU2TGJZWCtzd1d6UGZISFhNRElKcnpnM0JhbHhmTTY5UlBSTzFTZFRHanQz?=
 =?utf-8?B?MW5JcFhjZXhGdDRJc0c4eVJjWloxR3hyR0VsZ08zS3o1Qi90T1I3ZFdRNzd0?=
 =?utf-8?B?K21hbzAxRzB3YnBjbWhmSW50eVZFY3ljMVc1alVaYzhNeXRvODY4d0dSUUZj?=
 =?utf-8?B?dlY2OUdscFdEd0EyZDUyK2pSWHRrcW1CMEJWeGFrdXIrM2swY2ZXZ29YZ1J4?=
 =?utf-8?B?a2paSER2RHdMNXl6dFc2Y1MyRVR6MWpMMzdjOVF2Q3ZVNVVwdEJRZ3ZZQjEx?=
 =?utf-8?B?aHZ3dXZEd0tRNjZaRGViZVVTNmJwNnQrMm4vVjVUR3VxeHU2U25sNEZ3WXVJ?=
 =?utf-8?B?Mkx5cnRnSjJyZ3hvOUtRd1FYT0Q2cUJnN2lGOHlKTlB0MVY5NEtFK25xUzRi?=
 =?utf-8?B?NmhPZ1ZJZzRYd01wQVRsS3JGZUpyeklycTdYS2NZYThmbWY0OEN2WllHZEE1?=
 =?utf-8?B?ZUQySENJZmE3YkwvVTVEaDc1Qk9JSzZHNlNBbWhTbVhEYjg1YWtKYmc4SG9i?=
 =?utf-8?B?WmRXME1qZ050VnArNDNSQ3pkRS9TWWNVTUdlM1hwWVN3UzhjTDJ5MUxZalRI?=
 =?utf-8?B?UzlwMHhOc2F0MWxVVGZ2TWJ0NXdiRnUyTytZZHR0b0hFVjVCRFZNNXhWOGpy?=
 =?utf-8?B?Um5YV0FvOU1UWTNQNU1hamwxZnFCUlRIRXMyOGxQczZxSHhBSzdLWG1HM090?=
 =?utf-8?B?Kzd5QUpFQ3NPUlV4U2NIU081NEVkWkh6L1dDeS9rWG05MDdoQm5sQ0Q1ZXg2?=
 =?utf-8?B?UVpzSDlORUh6dXkycHBDMzdDakJtdDBpMTVUNlZlbEtPSGlCd3J1SnN6dmND?=
 =?utf-8?B?VnlDcGdZaC95dGRNcTREOEdLTEVzeitDNFc3NnVZTDFtc3lPRy9MZmk4Q1Ev?=
 =?utf-8?B?MFpRSnVtaDJURzIwd1NOWnFBYktqemc5ckNsS05Qaks1citMdi9ycFF1RCto?=
 =?utf-8?B?QmkrRTdEaXJBaVpyZkpmMDFRazRMelVtczJpcyszZVI3cjJWcGRRQ25EOUNC?=
 =?utf-8?B?aWRaNXdySzNKc0FPN1RvblNpYWRXUDhCamc1bEUvdGVHRU1TNVRGZjNzRHJC?=
 =?utf-8?Q?AFibeFy+zI0fwa9xAZX6kKl4S?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4087d307-1a28-4cfc-a749-08dbeb0f7af2
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7838.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 03:59:52.8670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9uU3UkjsXMnesfQoFbj3/1DyZODHON+4+KI8eB6rAAmjHT/slWIsjzLLhBECxVe1W3iKs7GghnnCflwV25bAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7079
X-OriginatorOrg: intel.com



On 10/9/2023 9:21 PM, Jason Gunthorpe wrote:
> On Mon, Oct 09, 2023 at 01:51:16AM -0700, Yi Liu wrote:
>> Intel SIOV allows creating virtual devices of which the vRID is
>> represented by a pasid of a physical device. It is called as SIOV
>> virtual device in this series. Such devices can be bound to an iommufd
>> as physical device does and then later be attached to an IOAS/hwpt
>> using that pasid. Such PASIDs are called as default pasid.
> 
> I would want to see the idxd implementation too..
> 
> Jason

Hey Jason,

         ice(E810 NIC) driver implementation for SIOV virtual device is 
also working in progress. We are working closely with Kevin and Yi on 
the patchset.

         We'll send out the ice patch for SIOV as lan driver user 
example once it is available. (There is some format issue in the last 
email, re-send again and sorry for any inconvenience)

Thanks.
Yahui.

