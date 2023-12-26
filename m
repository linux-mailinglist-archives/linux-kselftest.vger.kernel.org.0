Return-Path: <linux-kselftest+bounces-2441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731A181E769
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 13:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A940283031
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 12:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C8D4EB36;
	Tue, 26 Dec 2023 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPbb3kvs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703A4D5BA;
	Tue, 26 Dec 2023 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703593966; x=1735129966;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=javgje0HYNQU0mVRp/fGPyUA9BlJrs4YXlvbxbiVD+8=;
  b=mPbb3kvsA0jhmxDiIr77FSFLL78FgpXPrkcEmcrK8l8SrYqG16oJ42Ok
   2Mz262A/Y/ZAvq4INdd7uuYgrrQz2YVx3V4P4NStZ4AShz30inHmErXHQ
   Y71vLL1shpdcEICD/ZY6yhHf8eXztAa1r+CVhEG9HJ1+cadSrudcVlVua
   tUd2z8k9rlG7na62csbBmvH4vr85/Q29JinESvBoT5ENYf0EZr5bKBLak
   OisukdNs5XSXq5TO6hz7s5sWD+j7mJ6j4YGaN5RIO3ByxOdn59vKinCL1
   hgvz7mH5K++bnxMXBaI2+n3lJ6EvqyxC8sr+s0C7f+z+9KuuAQCwT3mh9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3158469"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="3158469"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 04:32:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="781465652"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="781465652"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Dec 2023 04:32:44 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 04:32:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 04:32:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Dec 2023 04:32:43 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Dec 2023 04:32:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPr8o50wbKiuoIhIX+1mHgrJO7kEn7nNMNkyg1aa7VWNDFAGEouOommKLeT9mwYmvhf6JAUDSCVnlRW5ICA7tlWq7DAnZvLm+VzrCCfmyjBO21UIBrlZoFcCJp/RjBuGS5cwZFbhgDHfNFh4oHswHATMJYNiR7J6hdKRNejzI4g6P9DB6SOmL5IwmaXNMNx2rrFeApU6p4RMpNf4nXpKddwDQ0v7Ng0fQj0BJJaueEIN41OtdkMcQAdD4FmG1cT7IM6fKfqkLl5RCUXkIgp4Yxps/NHPEap7bEAEFVQGCmS9rWi9hERIaiH8/0cKCCFNnvK/IsVERLAk0cH/0U/abQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZFCtESi4UdHEwg7lrISfahFVlqgAYYY661j6XDFwnQ=;
 b=AolX648HEqGOlDCUKIM1R7QrDSLSJTECt2Refs6NmN7sm4IgEGWJ6gNdU8UzICVNsdEU71Eie19767Iu1ZedUMzMJP9cDONXpaFItNCsj/PsQJoWhfHgLtgdjHyVAT+JvBISQbZrSvDdzk9sExLdur6cP9pq3PlBU1p2/NJheUUyXhNKIjcYoFgEcDBkMUrizoWew9vdM3oz2AkXZCdZ5ur9wBLzAQy5qqeEmx364V3RIw8ToRJwFSz5zJlPJ1uRBZ+W0+7bpt/s6Vb/mHxQHieZeGIqJoqowcYMXJ3NOEU9g2E1V6kQ66MN3u77ImBIEgE3aMMBOKZ9Zk7y/8ah6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 12:32:38 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 12:32:38 +0000
Message-ID: <54b6d7ed-c496-42d6-a4b2-50ba4c4b180c@intel.com>
Date: Tue, 26 Dec 2023 20:35:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
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
 <20231221153948.119007-10-yi.l.liu@intel.com>
 <BN9PR11MB5276A45F5355A6DAA8CBE5738C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cbd97b49-37b5-4445-a8b5-717b8ce99f59@intel.com>
In-Reply-To: <cbd97b49-37b5-4445-a8b5-717b8ce99f59@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:3:18::22) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY5PR11MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd22870-f38d-4674-bcd4-08dc060ebe89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCe5rdJiZhAdnOaJm0l2aeiw3KF+lx9rkA0OuQCobbthnyHg7QREJUVw24AmaGPH7s34fDhrvsrrgDQ3Mlw/RPEA9BLiKPtf7bYqHHYdVN8RhGpQ/hvJphqxfw9BMx7QOx8CtiIKr/wjt59mFNdRhpU/TKXqXiFELxfstQBxLxHiIKZ61zP6Oxzb8kacBXbV27/ETS+ep5mTeizaqAd6DgWxugP3Izsec07MRfvGPzVLmaRUfL+97hp9l3je1pdkSb41K+WzCAxwnAQOTrRrI+1+ETCWCakWF3Y+EcyyTQYWXebjX32nTN3FxYADIcnwOTdxe47TNTo4pSy1xI+V66lMn4AWVVYBY0/s3PEfsVNNK9NDuKHZ8nSAabaoxyHstKyhdaOnFFkGNIwJnlFIfE1JLUBjCBRahyWQLHZRyMC9zapYivt1dK8fyrWDcsvFMnaqc2VY7qki/NCmndMPkyvAmCz22I25DlbpxdvFB10Xh4HLQXK3zHGEKn0D3AoXEg7hAzOQBrECCwQxcYzDOcrL5fSS00cUmqU1gsOTwzGiVe5GtYbqUGLPKn1dPizeEKrwq5Jjn4h2rtAQ8DziWszESFviwy+mrqQ2xzRPcgKbNGO879p7rHSUlwowwPnjbX+Gy3enhfKJNi7RuhH09Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(36756003)(31686004)(6666004)(6512007)(6506007)(53546011)(66946007)(66556008)(66476007)(6486002)(86362001)(31696002)(82960400001)(26005)(38100700002)(83380400001)(2616005)(41300700001)(2906002)(5660300002)(8936002)(7416002)(8676002)(478600001)(316002)(54906003)(4326008)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGlBRUZNbTJoaC9EZFEyU2RVMWFNeDV6VWNhMFBZQ3FrWC9zUkNhZmZsdUZ2?=
 =?utf-8?B?R0FvM3hkOUFLNENndklJemtnaE1yUW1tL1ZKb0haS0xpREVmZ3ZtZXJ2c2JQ?=
 =?utf-8?B?cURVaXJiUm1oT2xKM2UzQTdDQUNVb0ltMXBybFVrcnVVaExPRUh1VWl4ekpF?=
 =?utf-8?B?TVk4eUlIUm94TzEvdXg4M3VPQUtxOUo2WjZKLzFoNnBzbWE3bTFkeEJadXFk?=
 =?utf-8?B?T213N1dvZHB4SEd3SGZXL0o0aEUvZUhqNXhwTEg5N3NjVExTWWk2ZFhHOHlz?=
 =?utf-8?B?YUNhU1JWa1d6bDV3V1hWL1dJZURzRGtpLzJLQkhlK3RHNW43cERYazF2cWJW?=
 =?utf-8?B?K2x4UG1uRU04NW9JWXdya2hWMFFkZXVZNkQrcTJOTzladFFrTzd5L2o5bW5j?=
 =?utf-8?B?SEd2ZkI2VVlDUHI5V25Qd1BNdldXdXNPRkkxcm1rKy9SbkFZeTVPNUdONW9C?=
 =?utf-8?B?RjMxY3dSVzJVVWs1N1grb0d5MVJmeG5lbXZTcERsejRTYlhIay9lMUcrdWFw?=
 =?utf-8?B?WTdsZjllc09yaDJITlM0RWtwL0VRVkRDTWlpTTR4cU15TGpSK3Y0V0NTYmhK?=
 =?utf-8?B?ZGppMFMzenB0dHdYQTlYMXRkSC83MGFCckl4THViaVJybHlMWnNSQ3JlbG51?=
 =?utf-8?B?S2o1VHdBN3VBdy9aeFFkU05LTHJpS0VsSUdTRUNKdnptQ25OL2VFZkZGYlBG?=
 =?utf-8?B?M2dwN0dUMFlOckd3ZWdZaUNVYmFXcm56WXM4M2R6YXJuNWF2WDZUaDBZaE1Y?=
 =?utf-8?B?ek9kd2phdzN1Q0U5cmMvVzNMQ3NIMm5HeEJ5d2llck1xTEVmQkhrSjFQb050?=
 =?utf-8?B?d0JaaW4wWm1wTGNEd0ZBczlQaGZhSXN1VHVyT042NjhSbW9ONDhvMDVLaDdT?=
 =?utf-8?B?dmtHU1cwTEx5M3NxODc5Q3JHR0RKZmVQd3lDR1ZhYWJCUjVNdXd0S3VtWnBk?=
 =?utf-8?B?Tko3QVdUS2UzRXlUQnB3SElMQXAyS2VGQ09PQ0RuYkZVdDRHdWtPWTlOQmZM?=
 =?utf-8?B?VUdUQndLUmxkamNRYVJ2anBoTk5UbE5wdGp6V3NrYXZ5RGU5Y2FRYjdlSW5v?=
 =?utf-8?B?dnNicTBUTmhwN0pjSVczT3hYNng5QjBhOXppSzBERTExYjBsMFpaalVsd2tN?=
 =?utf-8?B?Tyt0dllrVTM5bmcrMmpyckZUMFBoZklGL0M2alVWQ1VZMW03STcya293N1RZ?=
 =?utf-8?B?OGMyQitzeVM4SzhUNmxaZmp6OEFteEgyRnF3b0M4aGtTSk80RjBlQ2lEYjZT?=
 =?utf-8?B?UzJPaEZjZFh1VzFKMUdOYlFVczFXOXBGeldpbjJnV2tVaXJBVDlLb25ESE1w?=
 =?utf-8?B?bXpWM05UeTVYTFpwTEh2TW1WTGV1Vnk2RVZuK0ZCdG54c1VibGIreXl6eHcz?=
 =?utf-8?B?WGtadEdLYXh1STdmNWdEczBXWTAvaGRlcTVaeUt0ZzVJejBsTTlzbHYzV2w5?=
 =?utf-8?B?Ni9ZV0RUSEpHWVdNMWV5eXcvem44QW9TQmM2ejAzRHZHRmJCbkQyVjR2LzRT?=
 =?utf-8?B?WmxPMmRXaEU2YndpbHdUQUE5OXpvWTdNTjdZZEJBNTdDUDBHMGc4YkRrbWhq?=
 =?utf-8?B?ajFBVWJHM0FZN0k3S3NncVd3Q0h4TlpMMllUczA2d09xMXYyaFpGbjFiZktt?=
 =?utf-8?B?bzdVT3dSc0pMbWRhdVU3K0JhUUZHUXQ2ZmUxblVydnVHeTBreFlDM2FVNW1i?=
 =?utf-8?B?YWJ4RTY4Sm83bHNpeHJnWE80S0taM0JvMHRLd1J3b2czblFoUnhXOUZYNkxh?=
 =?utf-8?B?UU5YZ1JaVkk0SXoxa0FGRUdwZ3pGcnpCeWx6YVhTMnQrKzZtS3hvdUJxcGoy?=
 =?utf-8?B?RzBwRWc4N0o4MS82QWx6U3I1OXR5amhaRGRYdksySjdwanZBRkNqYlVrTjBG?=
 =?utf-8?B?ajV2MlA3MExkZzN1Y0FBcDNNSWRmOHVabHljQ1pwQWJ1WTZJTldGb0l6YjdM?=
 =?utf-8?B?N1laeFpXbTVyamY0SThxUysxZHNlM2IvK0tSRU05MmNVSFBpWkliQTRQTTF2?=
 =?utf-8?B?WVNMcGNZdDBlcTJaR05wRGV4Qk1WWnNpUmlDK0tLdm1yYjNIYks0ZEZ5ZS9i?=
 =?utf-8?B?RFVYdTBBajIycFhnNXZjM0k5bFAyUE53Q3pQYWNleDZzUnkvN2xJd3B3SXRu?=
 =?utf-8?Q?9C1I7Nr8qe/SDuEw0ykEQM9mo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd22870-f38d-4674-bcd4-08dc060ebe89
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 12:32:37.9408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bYxhzN28QN96rha613u3OGzjiYCMDWPAHSEoCgWOsSR76zgwyJybKL2rvO+2PoYNkN2oGrxMlBOdgeY7jayDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6366
X-OriginatorOrg: intel.com

On 2023/12/26 12:51, Yi Liu wrote:
> On 2023/12/22 14:57, Tian, Kevin wrote:
>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>> Sent: Thursday, December 21, 2023 11:40 PM
>>>
>>> +
>>> +static void intel_nested_flush_cache(struct dmar_domain *domain, u64
>>> addr,
>>> +                     unsigned long npages, u32 *error)
>>> +{
>>> +    struct iommu_domain_info *info;
>>> +    unsigned long i;
>>> +    unsigned mask;
>>> +    u32 fault = 0;
>>> +
>>> +    if (npages == U64_MAX)
>>> +        mask = 64 - VTD_PAGE_SHIFT;
>>> +    else
>>> +        mask = ilog2(__roundup_pow_of_two(npages));
>>> +
>>> +    xa_for_each(&domain->iommu_array, i, info) {
>>> +        nested_flush_pasid_iotlb(info->iommu, domain, addr,
>>> npages, 0);
>>
>> so IOMMU_VTD_INV_FLAGS_LEAF is defined but ignored?
> 
> yeah... it is. It is named as ih in the driver code. But it appears only
> the below code is set ih. When calling iommu_flush_iotlb_psi(), the 5th
> parameter (ih) may be true.
> 
> static int intel_iommu_memory_notifier(struct notifier_block *nb,
>                         unsigned long val, void *v)
> {
>      struct memory_notify *mhp = v;
>      unsigned long start_vpfn = mm_to_dma_pfn(mhp->start_pfn);
>      unsigned long last_vpfn = mm_to_dma_pfn(mhp->start_pfn +
>              mhp->nr_pages - 1);
> 
>      switch (val) {
>      case MEM_GOING_ONLINE:
>          if (iommu_domain_identity_map(si_domain,
>                            start_vpfn, last_vpfn)) {
>              pr_warn("Failed to build identity map for [%lx-%lx]\n",
>                  start_vpfn, last_vpfn);
>              return NOTIFY_BAD;
>          }
>          break;
> 
>      case MEM_OFFLINE:
>      case MEM_CANCEL_ONLINE:
>          {
>              struct dmar_drhd_unit *drhd;
>              struct intel_iommu *iommu;
>              LIST_HEAD(freelist);
> 
>              domain_unmap(si_domain, start_vpfn, last_vpfn, &freelist);
> 
>              rcu_read_lock();
>              for_each_active_iommu(iommu, drhd)
>                  iommu_flush_iotlb_psi(iommu, si_domain,
>                      start_vpfn, mhp->nr_pages,
>                      list_empty(&freelist), 0);
>              rcu_read_unlock();
>              put_pages_list(&freelist);
>          }
>          break;
>      }
> 
>      return NOTIFY_OK;
> }

I passed this flag to the intel_nested_flush_cache() now as the
helper accepts an ih parameter.

-- 
Regards,
Yi Liu

