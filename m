Return-Path: <linux-kselftest+bounces-2000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968BA8140D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 04:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE1628425E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81AD5697;
	Fri, 15 Dec 2023 03:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/gUkfol"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D172CA66;
	Fri, 15 Dec 2023 03:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702612718; x=1734148718;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E2Q5mR3Nq+ylBpds7LuGW6aZWrY1I9MJqjIyvGrtPPc=;
  b=e/gUkfolZwdyGGnC5mAtZQ7o1cXPTxMysxvwk5hfIJGZiMLaHW69uNVX
   zwW3xJTOtsqKWf5sey+oe2a2cyLLfZh4rjnwB+SDpu/LwylGEbFWLCfek
   +vMhMDl1JSH2BTreQThWlTH/dapnqf8yzL7uRXlieXbOxBT8igClm58Fs
   s6+agDmH8Vcb3xt2P/SsVm9/7igbvtx+5+doGCKj/FvT9LZO2vjvUs3cT
   Aq2aDZM67Ycio7LWzEKDrE8IMynm6Fx7uTay46roTVs9iHfbsaGjnB000
   I/bDvGrCO47G+npzIQKijjqw//jWYCBpsQgJCzllA/RZqE5TAuvamfgUQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2314390"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="2314390"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 19:58:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="724310938"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="724310938"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 19:58:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 19:58:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 19:58:36 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 19:58:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjUeylmhnnHKGFOuSzlOzX7w+5YwsXC6jnUCcwe+cWmFtYxSK5aUFtijUr78aD2ejPSN2zL2R6PgArBBjRbfb8IkohK1Q98T8LQAR69GPUGz1DiFQlM/aLSsIFgu73qc+eW9D3TFyEJszqtP1v7HCiSvqJHf/+MxG8dW+rDXOa0ntopqIO4kkVMyLMoikNKlZt5U15w2r+1dY/RF7AlhAvkCdmM1juPQESOVz50HG8q10u1P/JMBDC9FKRpgh4Z9V+4nUs/HLs2ZUYIoAYFfnQkO8UOX7gnuJUaUYf0/YCIpnIzysuQYmET+4CZlaCLLLaWTa3qTJkEP73RFkxseng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Emub2psSpmI+xoeBzX9EBfLg7n86j4KCLCcqlYdvpI=;
 b=fbG4D3Ft1nzZZRg0fq+RctDWw10+l+CulGS/SbU7PNRMdop6HjQ+NYSHbG6MedUDRAYYM+wyjSvMaxu0aTmgonERBtYoRKqNZtsKtyBubmoA+E76pliiff64kmKZbh+mMzxYhI/R/mfoK5WrKjQQTFjswBdEOIVVvaele3AXhWGuSCg8+t59bzSxmzvV7xtcV/3wCr3KTV1Kc44BZGMj8FtD7WuLxDD6+WKkQIFvuawtgZC8PSwmjjADq1dtPoyqzG9VzMy6JdWk/VLf+alZIM+Is62N5re0jWxeBwdY1uIrfvLHD6QC09NtRIRjgzMMdyGS4oVuo7bLhEsjCKwL0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV3PR11MB8696.namprd11.prod.outlook.com (2603:10b6:408:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 03:58:34 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 03:58:34 +0000
Message-ID: <7c398efc-8a2f-479d-bcff-ded8cc1ef3d0@intel.com>
Date: Fri, 15 Dec 2023 12:01:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d stage-1
 cache invalidation
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
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
	<yan.y.zhao@intel.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <BN9PR11MB5276D14D2A7FF60B41A6A7B48C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXu5whlIGfiq16wF@Asurada-Nvidia>
 <BN9PR11MB52766D7F774510E0181CC89B8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXvI2IiXwwuHRE8V@Asurada-Nvidia>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZXvI2IiXwwuHRE8V@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV3PR11MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 4081d4c4-7a4c-485f-fd20-08dbfd221b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10B+2jJAVqhGUYE0nfMthL4IuRa8XCx9Iba9mIsJHv+H1ikqfnHeekda4F2fndjQacnk+aPeHSarC2ytmQnCWZaW9cWthMafEbZLMFqM3bbb0N7DMwbOexaGfKDZw2yHfrpvdkS0wgPG6OzODIbBV0PeRApwU6iBf58eyFjmaKDv8ceWaeaMwQ2fRO06FIkBLyzKrsNSvMSIG4HZD89PJJAUGxqrazHUmsDc1U5LqVA3YklwJE6IQfOXcCNFCeAI/9lhP9CcL0YxWbniBW0KUlzd1TlyWNL2CROGKlm/AwfWXdKdRQ8KgawSt3Eo9K75tb4LEqWfmNU4RfO3AOiLcJyiz1gEASc2mLO4pthUWFezyYSz1lWCVpCT8Su536zAtZS+/ZzMtbzlOWVePJrX4a/18Bngn6yHK/sLGGGYmuumEzFKXKsEM7X1kO4X0AVim/MCPCtqGj7rXQGothS/dnJAzt5KcMl6PYrNl+PAEomP3OKMJyY5TWtMZwZs7ccm4ByT+yR7S5WipmP2hsm3CcMWEvOo87Lax/fjXh1vrtrruFS66UrheWIzy0tOZ+wV5Y4EZfGUeVhnKkNTFrSsFEyiESOeFezyE9kM1HFBRF6lRdmp7ITeC1knxUD3pAiwn3ZiWOf2yf5Z62sKq4j3Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(31696002)(7416002)(6486002)(478600001)(41300700001)(82960400001)(31686004)(86362001)(5660300002)(4326008)(110136005)(66476007)(66556008)(66946007)(2616005)(6636002)(316002)(83380400001)(26005)(8676002)(53546011)(8936002)(6506007)(6512007)(6666004)(54906003)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTVNSjN5a21veEI5d2NkVVVIa0dmLzVKbHRuMGN3c3dwNCtEa2JrcTE2K3JX?=
 =?utf-8?B?VmRjdGtNTUwzK2xHcC9nenRySEVPQXF2S1ByNE82cXdmbFoyU2EyV0lxaHlI?=
 =?utf-8?B?WmhZMHVEUUFHNkR6WTRPQklQSk8zcHpUNkpOZ2ZlenZiV3NEOEZzRkJMdlBw?=
 =?utf-8?B?V05PbEsvcHZYd3NYQXQrbHJYbWI3S3AyR0tERTZWSlQ5Z2p1ejE0KzNTU2hP?=
 =?utf-8?B?dnowN2wrOHMvL1VXUDJ0L2cxR09YMStUK2pQbEdhUkdSd05YT21sZHBxT2Q4?=
 =?utf-8?B?SFJGVXBla0tIbE5vOXFxc0dmRjYyRzhkOGVHNUduanZlM0dmZmg3WWtZVWpW?=
 =?utf-8?B?TXV4VEo4Mmp5VmRCUFZvNUVCOVZ3NEFBNSsyWWNEbEpwMDhjU2FWU0MvSEdl?=
 =?utf-8?B?M1NiSkVXSStTQUk2ZG0zRE90NU9wTitwQ0pnQThZREtJV1hhdzJId20ybndl?=
 =?utf-8?B?TjZsUWp6RnYyRmRDaHZWV2JLT0FoNGhLMjViUW00emorb21kUmpwUGRGQnpL?=
 =?utf-8?B?ZXV4MDk5ZlArRGdCbjc2ZWUydmIybVorMlcxQWpwSkxWeFVKMURCRFgwek80?=
 =?utf-8?B?c1BrYUZ1T0Q5aXJTcCtqV3JwcldSQ0Q2Nm1NVUtoTlMvREllcUxwNmJKMUNL?=
 =?utf-8?B?eHBjUGdpZXh3MDNYd2o1djRWL3N4WnBEVy8rdENaSk9lUUlUVkdzZzJHd0FY?=
 =?utf-8?B?VVNiNTQxRE9QbHc3QzRvMzV6VDZ1bW9xbGdaSnpSTWJKU09JVGNoc2ZNcWRK?=
 =?utf-8?B?YWlTeHM5UnEvaW9weS9EQWJaK25WeEF6OG1ReEk3bERRYmcwMXBzWmZvU1FT?=
 =?utf-8?B?V1pNSkFMZFpCRWh6bFVvUGkwSEN0ZkE3VkpNWW5LVVk5Z25tcUdIWjZZMUxt?=
 =?utf-8?B?NVMyTHdZeFZ1dklSZ2JCb1RGYlpyNlVuUlBTQVhlVEVRM0dJeWFQTlRIK1Bo?=
 =?utf-8?B?aFpqOFZ5cXBKQjlxOHYxUGdqeGhCdTZrSEhrdVUvWjZja09ONEFML1BsNXho?=
 =?utf-8?B?eWJWaERPckp1MUNXVmJGdm03V0JhY1hZc01TbzM5eHFKWFdZTFpJTXV0RU04?=
 =?utf-8?B?VHZ2by9xN0YxZzhmQ0dudEY4ZHVBcmlhS2pVMlZqOS83c3VPVElsbGVFbnpS?=
 =?utf-8?B?TXM0blhBajVXNmlOOUN3SHlScVRudSt3UEdFbXU4TkVxd1lDL1hZUXM4VmRT?=
 =?utf-8?B?VTYrQkZxNkxYenEyNUE0TFBEQWVJY3llU0V3V3lCeHNaUVdYWGVFOVZ0ekJo?=
 =?utf-8?B?RzFDYnQ0aGlzdWVraElQcEhwREJBUHIyYzBoajFEK2dydmxsT1pJc002SmF3?=
 =?utf-8?B?amRXSmxERy9XWVJZTDF4ell6cWRJQzBER242bHJFNzFIRStxRDZyRlVVY1dX?=
 =?utf-8?B?aDBPK3g5OTNnVFBpcFVJWEFpUjk3QnZncWFMMW5CdGhxcDA0Q0E5dndiNE1o?=
 =?utf-8?B?cUNkUGxDQmtmSm40WnZxdWpwMWtUSXVSRGNCREV5ZUthcGRWZG13RllYdjdY?=
 =?utf-8?B?Skw1WGVoMmlWWVFGVnJ0ZzgwQ3hNZTU5Q01NamNmMlhVNXEwRnN1V24zZXNv?=
 =?utf-8?B?VU12SGxGOG9zRDN2RGtYL3Z2Lys3V1F2WkZ6REFxNGM4azFRNENpbmFtM09J?=
 =?utf-8?B?NEdVVnIyWXUyRzNmdU1heldYaTdBSDQ0Z3VLM3dIYlVsR3dtVjFpVmQxYld6?=
 =?utf-8?B?dU1QeXphU2k0VVJuamJ5ejVLYkdqZ01OaSsrOVpZQUhFRzlqTUIrUkpwMllm?=
 =?utf-8?B?c1JnMFJSa3BzemNsa01tSDRtRHBKb2xta2swOGNIK1RIdnh0elJmdFNOa09O?=
 =?utf-8?B?MmVxcXBVSEpRbE5GOENVak9SU2NaVzg1YW1UN3NwTU53a2NoMFZ3WkNiQ0Yz?=
 =?utf-8?B?YkR3MXprazJGNkNWTGM3VUp2cFg2VzFMT0ZUQ1VVVHU4cmR6aEFVMmEyYnFJ?=
 =?utf-8?B?S1gyOWpsLzQ5UUJORzZkdWtnR2V2L2NRdWoyVnA0T2JYMkpiMlRFUkthUE5h?=
 =?utf-8?B?VFRPTVkzOGV0UzhXMFh0RjRENDdCaUdxV25TY1BuLzBBYXptY0xQeStKd1RS?=
 =?utf-8?B?dXZqSjJqYkhudnRRUmdYWEZlUzlxWURab0h0Q1VhQmQ0M2w0WkNPaUVJZUdJ?=
 =?utf-8?Q?Tsjyv817d0WA3Hg0AZoxACwKf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4081d4c4-7a4c-485f-fd20-08dbfd221b49
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 03:58:33.7864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7Tu+2x0wv7WQOAXMgvRN70SprRglQc2NXiPbUm3rXS2x3jN9nXGy1jTLIyhpKK37Hws4kuFxOS3oJrIzVJQBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8696
X-OriginatorOrg: intel.com

On 2023/12/15 11:32, Nicolin Chen wrote:
> On Fri, Dec 15, 2023 at 03:04:44AM +0000, Tian, Kevin wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>> Sent: Friday, December 15, 2023 10:28 AM
>>> On Fri, Dec 15, 2023 at 01:50:07AM +0000, Tian, Kevin wrote:
>>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>>> Sent: Thursday, December 14, 2023 7:27 PM
>>>>>
>>>>> On 2023/11/17 21:18, Yi Liu wrote:> This adds the data structure for
>>>>> flushing iotlb for the nested domain
>>>>>
>>>>> +struct iommu_hwpt_vtd_s1_invalidate {
>>>>> +     __aligned_u64 addr;
>>>>> +     __aligned_u64 npages;
>>>>> +     __u32 flags;
>>>>> +     __u32 __reserved;
>>>>> +     __u32 error;
>>>>> +     __u32 dev_id;
>>>>> +};
>>>>>
>>>>> dev_id is used to report the failed device, userspace should be able to
>>> map
>>>>> it to a vRID, and inject it to VM as part of ITE/ICE error.
> 
>>>> and for this error reporting case what we actually require is the
>>>> reverse map i.e. pRID->vRID. Not sure whether we can leverage the
>>>> same RID mapping uAPI as for ARM/AMD but ignore viommu_id
>>>> and then store vRID under device_domain_info. a bit tricky on
>>>> life cycle management and also incompatible with SIOV...
>>>
>>> One thing that I am not very clear here: since both vRID and dev_id
>>> are given by the VMM, shouldn't it already know the mapping if the
>>> point is to translate (pRID->)dev_id->vRID?
>>>
>>
>> it's true for current Qemu.
>>
>> but there is plan to support Qemu accepting a fd passed by Libvirt.
>> In that case Qemu even doesn't see the sysfs path hence is not
>> aware of pRID. otherwise yes we could leave the translation to
>> VMM instead.
> 
> I think I misread Yi's narrative: dev_id is a working approach
> for VMM to convert to a vRID, while he is asking for a better
> alternative :)

In concept, dev_id works, but in reality we have problem to get a dev_id
for a given device in intel iommu driver, hence I'm asking for help here. :)

-- 
Regards,
Yi Liu

