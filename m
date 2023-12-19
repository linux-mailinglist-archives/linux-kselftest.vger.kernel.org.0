Return-Path: <linux-kselftest+bounces-2178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0705818454
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 10:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C9C284E4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 09:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05673134A8;
	Tue, 19 Dec 2023 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sg7W58lI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FEB13AC4;
	Tue, 19 Dec 2023 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702977820; x=1734513820;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jJhpkA/9u4w2OzJLyHvm0FF4aDRQQnIiHjuhuKcU2mc=;
  b=Sg7W58lIfWDxeB9wTQ/zOH41s3T3vTKu8LjcSQAap9Aemf90C+fAYAGo
   /t/HK6T6DTd5VHwSMyjdpONq0oiiXEGY2bLjhVfQ7QXwNWfUVAFnfBpfP
   +LF4eBV6DmeeqDh7RdihHXfbTBbuxP4MZpCwbSFZgjZcqlbXEDgXC+HOp
   hIT9uK+rrwdGMCuJKBsQnMwagaIEbBqd18BpLBUT+uX4EJgA/rqldXNg3
   u+5XE+RHgVhEAx4j6maKMLlhT3/79/OV8ctHRg7yMo47hAqjVd5kKxKYP
   X9c2dcVxypwCY9cBeNfHBhf3mvh28sLddLtJemd1amTF7/oxrAwKVsj4w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="392803979"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="392803979"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 01:23:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="725672681"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="725672681"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 01:23:38 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 01:23:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 01:23:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 01:23:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 01:23:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcgmcfY6oA5PLbiQV4aCnPIpP0eTxHJAAlWc/aue3qis7YFh6EAIrgHjyJkOj6gCX1YMJ9xfO4grcDpjJ5USomJ4ey976VC+XK8HH3TRatZa+Kpw3aAC9XJIY27FzXwtvk/0AP/vTPGlQy2JA+zg3M+yX2RgTGDq95zUT25oI27jmmGNiTSWKV0i3xNjMuVvtFCntWeL/TL0vV6KLqR3bokFaChM0ekCWinj+xwDCaemMUZdoXjmTb55oJjWspA4EKwg+zn7P8BxUb/184WUMV/ITr5uOTsp5sk3S5EbBQ6XC33fvry7QMl56aJawGnvBDgKm/oqPF1qgcvR17L0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bRAJrDZYPUOdzOfpQfQnI8CjvgsqS2xq9YKTUq/+QE=;
 b=e57Cl+RMCGJQAhYI76utN3CQKXBv757MKFo6tAuLeav3BFl5ivEWFHzmaSnm34LQqqDUVxNvc1Ege0uXVyHf2METB+oPDuQ1Ih5qYz7zivcn2Eo1FHNkEbMT06NSfGQ6WqDSERfAk088+o2+dyyq+qt3Ou6WRiwsXX8SMSzyxfJl8khjLPsVSflhvB+ntacZ65wXJdGw4yP64YJPOepTY1AFXWkSXF4/lIIlPiW53Xm/pFbVqVSU7SVuy6mc0wqbcLsCdlHjdYZaSfqnI1oJP1aan3TAFFcuQx8DWI3Aa7nuw8SB9vIifqQRfbo3PHqzQsrgmLtkKZbukApCumdjbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH8PR11MB6753.namprd11.prod.outlook.com (2603:10b6:510:1c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 09:23:35 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 09:23:35 +0000
Message-ID: <c6d88551-c480-4a89-ad2b-b873951fb181@intel.com>
Date: Tue, 19 Dec 2023 17:26:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Content-Language: en-US
To: Joel Granados <j.granados@samsung.com>
CC: <joro@8bytes.org>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<cohuck@redhat.com>, <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <CGME20231217215720eucas1p2a590aca62ce8eb5ba81df6bc8b1a785d@eucas1p2.samsung.com>
 <20231217112101.6mxn42dw62tbj6uw@localhost>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231217112101.6mxn42dw62tbj6uw@localhost>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH8PR11MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bab56e2-fc1b-4cd1-b68d-08dc00742cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cp7+8T2J3bGGvIoBP/YAfAd+SeQnZCdE/tEUtHgOl61RrYNPcf0VEJxEY/RB3okMlqqbjXXuOCMrkr4d5NCGgzoLPhRQTeBRmPJjmNzHF3a/ZAbKfgOPRT08HO4MBrXTIC0UyozKIMCX1uzSlI2yGNeOvY6J+WI4RJi4W0KoAdirYw4H4xRnI0Wvjln7koNPX0UHKFkDRdEi2/hA4ixG3eSQaFvFwZ2JidWI96+6WW+w1FXYQbKMfraGRSJ0mgKluDWRLQjtJsWIDOawdVZLCmwmAL+sDFWar58OcjpTuMaJMi1EbEyHE/KrH/9Mtl0w1Ommd0w2PUkY5d5r1f0+lIFqu9S2k9VWEQS7SIIObDrNftjfOhUCWLFsjTihf4M2cdUiIyBGs1DGuGBonuZ+0JCh+9IuWwIG1kb9qGNpSTxOSYT8NR7vrvYAtyei5tosa9A+0e+2tB7ay7FOyr5/quii8GPowyRavGkhbVjADSftJNcr1NZjgsyyyEj6CVL6PFWo1aWKxMa83Dm7Mwr+qXKM5ico2AwZOXJrQBuxnxg+kzv9m7xXVRIzIkYDfhTn/+p9jOoFMIbVLn4GslA1mZxUywRPBXRfLBZMUKXllDa4wTeaGAKwJVaC+YJaG/FQUuETlOF96XnmcQPoIvvDGnoBsWFcdhyz960axw5OdkQqCE0eMEZIgIKc744DHYjB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(2616005)(66574015)(53546011)(66556008)(316002)(966005)(6512007)(5660300002)(4326008)(8676002)(7416002)(2906002)(6506007)(6666004)(478600001)(83380400001)(8936002)(6486002)(66946007)(41300700001)(66476007)(6916009)(86362001)(82960400001)(36756003)(31696002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWZNR3oyQm1mV0t1aFh2ZmMwV2w4MSsyN1phVGZKVXpVa3FqWXNjWktybVND?=
 =?utf-8?B?N05yQ21oYUM4dVlpRmJmK2hQVUN5eXl0TDVOSHNyb1U4TEpVMVpJSXRGYmlv?=
 =?utf-8?B?UEU2TURhMERpWnlXQmZDVjRGTVhYbDVUS3RybEVldXBMQ3BrM2JkdkZqR0R5?=
 =?utf-8?B?Ui9lWW1hZDhGZFV3WWU5TXRxME04RGVjS2cycnowYWllMEVEVFpjOVAzb0VH?=
 =?utf-8?B?YmpsYWU3THhzc21KSzV0WU43Tkt1bTZEa1FlK09UTzVUM1dzNytGNExBUytI?=
 =?utf-8?B?UzJEL1N3S1AwOFh3clVVdmlFWkNocFZJK2NqQ1A5TktwNXg2NTFzYjhnZU5v?=
 =?utf-8?B?bE5HVlhBSlpleTVucTJtRG0yK0szZnNtYTdkdUo0ZFovMWRPaEJKdHJVUXRE?=
 =?utf-8?B?bSsrZVQwMFhqdUE0cHV0MVVxM1o5cEtLNnBodEdxQzloME5QWTRNeitrMUNG?=
 =?utf-8?B?Sm9aWmVMN1FaaXRnRUx4L05QWjA3UUowNzZxRkc4aXVmMU5rT0NIYXZhQmJU?=
 =?utf-8?B?RDZ2WW11Y0RlUm9hN0FaTXBmUmhGYUJVQXJ6SGVNaVpBSnFlQnQxd0tuVFJO?=
 =?utf-8?B?VDE1YVBrQnlKM0hIQkNCZ0hJY3dYUHZhc1NiUzl0WDBDcnpwdEhDQTRGWE03?=
 =?utf-8?B?SDVZbWIrVm4zRXJuQkRQb0w0dmdYNFByZUlaNGF5SXhaMEZRL1h4Wis0ZHpt?=
 =?utf-8?B?U0d0ODdyYVVOWVlwSHJjNzJlbmxySjZnUzBUYXNJN0ZGMUdxK243VHNzYU83?=
 =?utf-8?B?YndtQVpFRnhJRWw5Wk9SMjdQVlFGdzFDQVlUazllVUlRamNIaThCNGlZcXF4?=
 =?utf-8?B?YjN4UDJqTVJ5OGtkdzB6ZWdpUk1QWG1XYmVSeTVVSTNRWVRCNVRpa1A3bkJl?=
 =?utf-8?B?ZVZaR3VOblU2VjMzVWRvWUplNWU2SnVHSlBnVGxSSEI0SjI4cVBNME9pQ2kr?=
 =?utf-8?B?eHdQN1hPSkRuSnFSWllSV01qUVdsbjI1N1VXQWx2QVRsUjZVUVArN3lZdGta?=
 =?utf-8?B?RVMyazZVVWpkdjVFdFRIWWFVWk1obWVFd0NyOTdnVWdXdVBFa2dIT0Y0UVFu?=
 =?utf-8?B?Zm9hdkV0eW43TXY2QTdMZWZEWVJ3ZzJjQTBUeWptT0ZtOFRRMWRsc1d4R3pC?=
 =?utf-8?B?dkZ6Z0cwVFlxYzFYYyt6eFREVjhkTGRXL3YvaE9TYktwNndqZ1daR2xoV3Ex?=
 =?utf-8?B?YXFuNEFtNjRoWC9leDUwN3FKU2JVMU01NTRRaGhPYzlrbmRDTm5UbXArRlE4?=
 =?utf-8?B?RW5hckJoM29wbVAwcFpyT09DZmZJb0YxK05oS3YydUVKUk9qMTNNemhSUUVo?=
 =?utf-8?B?TFpSL0x6Szk5aDRnd0VmU1NYbGdRMVdKL2FXN3F5RkRqQnRTM3FYdFU5RlM0?=
 =?utf-8?B?eDhFQVlQMmluYXcvYjU3aDZtQVl6SmhpNXEwb3dBOTcrY3RTMmZodmtSamhW?=
 =?utf-8?B?VExEbDhzUUgwem1OcnVRWHB2ZVRVTG1lS0VkM0k4OWxzZnBqTk5HK1lkYmNh?=
 =?utf-8?B?d0RVUGhnbWJqekxLVFlMUXFvTmNZZE9oVFYyNXYvR1RGS09PczkrSXQyNnkr?=
 =?utf-8?B?bGYyaTNtakUzSTNkZTJyOW9RMzVFZGF4UzZZYlVxaXlIa21JYUhrNXZqczlz?=
 =?utf-8?B?MklvNWFISFNOQ21iUmREYStiSmh3aVplVHVNeStpazdob3JTU2RYT0U0WWs4?=
 =?utf-8?B?bWpTU09wNzN2Q3lwL3dHSnEwRnB6Qml1L0FGUTFScURsVmViRUxDYTRvS3k4?=
 =?utf-8?B?eTVGM1hjMjhGeksxZjVxd3dPOWxUUGVzUTQydWJORTc0U2d6NXBxbmQzcWNj?=
 =?utf-8?B?emgvL2Fydk9kdWxZZWRJSDBCZnVBMjFkeFFQaW40UXFoQkkvOTZoTUFDVWFO?=
 =?utf-8?B?TkpuNERFdmEzckdudERCSWwwMWpHK29HeTRWa0IrOWhPUDhVdE9xZms3TzZG?=
 =?utf-8?B?RkNtb2lVMFBVSFpJMmRPc0QyaHpiVEU2aU1kemxJejJ2MUVSSnJxWG51OUU4?=
 =?utf-8?B?REpxZXl5THFPcmxQUjlGVG4wcUZnZkMvbGtKRjNXSmVJemhKZzJBRURTSkNl?=
 =?utf-8?B?Wkx2MXhGT0k0emFrSlBpaXdUR0tFTlJPdTNsbyt1LzF2WHhhcWc0cWZmeW4w?=
 =?utf-8?Q?HPBOn5uLNuxhggaot9K8wFF+d?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bab56e2-fc1b-4cd1-b68d-08dc00742cbc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 09:23:34.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zye1skI1ElDZiQFak1JNhKecR1IVPHKIXn0QpIt4gFbmjtaE7g/aLMk/vrnCeY5jHJ6QqQk6mu1TlKs8/d8klQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6753
X-OriginatorOrg: intel.com

On 2023/12/17 19:21, Joel Granados wrote:
> Hey Yi
> 
> I have been working with https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_rfcv1

good to know about it.

> and have some questions regarding one of the commits in that series.
> I however cannot find it in lore.kernel.org. Can you please direct me to
> where the rfc was posted? If it has not been posted yet, do you have an
> alternate place for discussion?

the qemu series has not been posted yet as kernel side is still changing.
It still needs some time to be ready for public review. Zhenzhong Duan
is going to post it when it's ready. If you have questions to discuss,
you can post your questions to Zhenzhong and me first. I guess it may be
fine to cc Alex Williamson, Eric Auger, Nicolin Chen, Cédric Le Goater,
Kevin Tian, Jason Gunthorpe and qemu mail list as this is discussion 
something that is going to be posted in public.

> 
> Best
> 
> On Fri, Nov 17, 2023 at 05:07:11AM -0800, Yi Liu wrote:
>> Nested translation is a hardware feature that is supported by many modern
>> IOMMU hardwares. It has two stages (stage-1, stage-2) address translation
>> to get access to the physical address. stage-1 translation table is owned
>> by userspace (e.g. by a guest OS), while stage-2 is owned by kernel. Changes
>> to stage-1 translation table should be followed by an IOTLB invalidation.
>>
>> Take Intel VT-d as an example, the stage-1 translation table is I/O page
>> table. As the below diagram shows, guest I/O page table pointer in GPA
>> (guest physical address) is passed to host and be used to perform the stage-1
>> address translation. Along with it, modifications to present mappings in the
>> guest I/O page table should be followed with an IOTLB invalidation.
>>
>>      .-------------.  .---------------------------.
>>      |   vIOMMU    |  | Guest I/O page table      |
>>      |             |  '---------------------------'
>>      .----------------/
>>      | PASID Entry |--- PASID cache flush --+
>>      '-------------'                        |
>>      |             |                        V
>>      |             |           I/O page table pointer in GPA
>>      '-------------'
>> Guest
>> ------| Shadow |---------------------------|--------
>>        v        v                           v
>> Host
>>      .-------------.  .------------------------.
>>      |   pIOMMU    |  |  FS for GIOVA->GPA     |
>>      |             |  '------------------------'
>>      .----------------/  |
>>      | PASID Entry |     V (Nested xlate)
>>      '----------------\.----------------------------------.
>>      |             |   | SS for GPA->HPA, unmanaged domain|
>>      |             |   '----------------------------------'
>>      '-------------'
>> Where:
>>   - FS = First stage page tables
>>   - SS = Second stage page tables
>> <Intel VT-d Nested translation>
>>
>> This series adds the cache invalidation path for the userspace to invalidate
>> cache after modifying the stage-1 page table. This is based on the first part
>> of nesting [1]
>>
>> Complete code can be found in [2], QEMU could can be found in [3].
>>
>> At last, this is a team work together with Nicolin Chen, Lu Baolu. Thanks
>> them for the help. ^_^. Look forward to your feedbacks.
>>
>> [1] https://lore.kernel.org/linux-iommu/20231026044216.64964-1-yi.l.liu@intel.com/ - merged
>> [2] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
>> [3] https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_rfcv1
>>
>> Change log:
>>
>> v6:
>>   - No much change, just rebase on top of 6.7-rc1 as part 1/2 is merged
>>
>> v5: https://lore.kernel.org/linux-iommu/20231020092426.13907-1-yi.l.liu@intel.com/#t
>>   - Split the iommufd nesting series into two parts of alloc_user and
>>     invalidation (Jason)
>>   - Split IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING/_NESTED, and
>>     do the same with the structures/alloc()/abort()/destroy(). Reworked the
>>     selftest accordingly too. (Jason)
>>   - Move hwpt/data_type into struct iommu_user_data from standalone op
>>     arguments. (Jason)
>>   - Rename hwpt_type to be data_type, the HWPT_TYPE to be HWPT_ALLOC_DATA,
>>     _TYPE_DEFAULT to be _ALLOC_DATA_NONE (Jason, Kevin)
>>   - Rename iommu_copy_user_data() to iommu_copy_struct_from_user() (Kevin)
>>   - Add macro to the iommu_copy_struct_from_user() to calculate min_size
>>     (Jason)
>>   - Fix two bugs spotted by ZhaoYan
>>
>> v4: https://lore.kernel.org/linux-iommu/20230921075138.124099-1-yi.l.liu@intel.com/
>>   - Separate HWPT alloc/destroy/abort functions between user-managed HWPTs
>>     and kernel-managed HWPTs
>>   - Rework invalidate uAPI to be a multi-request array-based design
>>   - Add a struct iommu_user_data_array and a helper for driver to sanitize
>>     and copy the entry data from user space invalidation array
>>   - Add a patch fixing TEST_LENGTH() in selftest program
>>   - Drop IOMMU_RESV_IOVA_RANGES patches
>>   - Update kdoc and inline comments
>>   - Drop the code to add IOMMU_RESV_SW_MSI to kernel-managed HWPT in nested translation,
>>     this does not change the rule that resv regions should only be added to the
>>     kernel-managed HWPT. The IOMMU_RESV_SW_MSI stuff will be added in later series
>>     as it is needed only by SMMU so far.
>>
>> v3: https://lore.kernel.org/linux-iommu/20230724110406.107212-1-yi.l.liu@intel.com/
>>   - Add new uAPI things in alphabetical order
>>   - Pass in "enum iommu_hwpt_type hwpt_type" to op->domain_alloc_user for
>>     sanity, replacing the previous op->domain_alloc_user_data_len solution
>>   - Return ERR_PTR from domain_alloc_user instead of NULL
>>   - Only add IOMMU_RESV_SW_MSI to kernel-managed HWPT in nested translation (Kevin)
>>   - Add IOMMU_RESV_IOVA_RANGES to report resv iova ranges to userspace hence
>>     userspace is able to exclude the ranges in the stage-1 HWPT (e.g. guest I/O
>>     page table). (Kevin)
>>   - Add selftest coverage for the new IOMMU_RESV_IOVA_RANGES ioctl
>>   - Minor changes per Kevin's inputs
>>
>> v2: https://lore.kernel.org/linux-iommu/20230511143844.22693-1-yi.l.liu@intel.com/
>>   - Add union iommu_domain_user_data to include all user data structures to avoid
>>     passing void * in kernel APIs.
>>   - Add iommu op to return user data length for user domain allocation
>>   - Rename struct iommu_hwpt_alloc::data_type to be hwpt_type
>>   - Store the invalidation data length in iommu_domain_ops::cache_invalidate_user_data_len
>>   - Convert cache_invalidate_user op to be int instead of void
>>   - Remove @data_type in struct iommu_hwpt_invalidate
>>   - Remove out_hwpt_type_bitmap in struct iommu_hw_info hence drop patch 08 of v1
>>
>> v1: https://lore.kernel.org/linux-iommu/20230309080910.607396-1-yi.l.liu@intel.com/
>>
>> Thanks,
>> 	Yi Liu
>>
>> Lu Baolu (1):
>>    iommu: Add cache_invalidate_user op
>>
>> Nicolin Chen (4):
>>    iommu: Add iommu_copy_struct_from_user_array helper
>>    iommufd/selftest: Add mock_domain_cache_invalidate_user support
>>    iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
>>    iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
>>
>> Yi Liu (1):
>>    iommufd: Add IOMMU_HWPT_INVALIDATE
>>
>>   drivers/iommu/iommufd/hw_pagetable.c          | 35 ++++++++
>>   drivers/iommu/iommufd/iommufd_private.h       |  9 ++
>>   drivers/iommu/iommufd/iommufd_test.h          | 22 +++++
>>   drivers/iommu/iommufd/main.c                  |  3 +
>>   drivers/iommu/iommufd/selftest.c              | 69 +++++++++++++++
>>   include/linux/iommu.h                         | 84 +++++++++++++++++++
>>   include/uapi/linux/iommufd.h                  | 35 ++++++++
>>   tools/testing/selftests/iommu/iommufd.c       | 75 +++++++++++++++++
>>   tools/testing/selftests/iommu/iommufd_utils.h | 63 ++++++++++++++
>>   9 files changed, 395 insertions(+)
>>
>> -- 
>> 2.34.1
>>
> 

-- 
Regards,
Yi Liu

