Return-Path: <linux-kselftest+bounces-2521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A27B820002
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 15:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7191C21906
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D57511C91;
	Fri, 29 Dec 2023 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EoQk71s4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AB811C80;
	Fri, 29 Dec 2023 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703861298; x=1735397298;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JSOUdxD8urpOphMZupgai1XXTXL9Znnc/Ch5/HJYmAM=;
  b=EoQk71s4PLDrsxFTj6Pb7UtkD1yYfT4MGGd/xk0+4o8bOqTs1cQ26E8F
   Jr2KoY8Kck7i9F1lyHikX62hYBNCTs3Ajk3CZS/lajVEmCNBj3LpTADyL
   i9Uh4IyQVXQ/UAuzAGd2JR65OefmpCAq9/i4/UPGS7ZaxX/Ouu/SyZS5P
   zj3YukaCUEhMSifRHnWm5Dal01CrBPZw2N712XQ9WvQ+etE+ctOupV1rm
   CI1XqwrVBg/l1TWxi2X3ZuNREqsEK8M7eDZjESbMou6TSXXMrndzJmK5x
   YxQtfHpLPAGS4gFhBJ9xGdIpsBCRh9Llnbg87dsjbBegjQyh5+SvryRVo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="3488797"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="3488797"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 06:48:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="849225160"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="849225160"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Dec 2023 06:48:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 06:48:15 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 06:48:14 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Dec 2023 06:48:14 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Dec 2023 06:48:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYtnxgZJkbrI4gPPHt1VjcWCxjNhOYUvd1ZNe3EFFn/DoZW1r1ESgsKJl9Y3D6dYTbM2Va+C+7I1PMeAq2cJH4CANtRnKnO03M6bPW0Aae8Xtr96CCxFg33Hd2KoovqP+amlapoqow0F2MPypgKOQIzUrlEBjOhZSJhj1FcbyaBpJuN/XHyGAgdqa7v8eGBfFaICEgCxo2dz+OMnlO7Y+0v2o3UQIh9bWSV9eqUQ02DTumiLhma0GnUHPxkJEY1mUnCU+hKAdslTDZ2w7b0jvzqSsb26a/SlvSkBq/6xQaDeOXrT2uB21nWgcsJYCoQ34T8ppnBOk+AUSMxQrfpQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anhv6jPCln6bZ+MmwsuMyNtgNDikQDwsVUrnZdOGMVo=;
 b=N/BlzQzlzkS95s0tTinHCSONYqsrrkem11cd7KRYIyG7tJ6KBPsinvd9Zk6pefucCD7r+qNrlO5AOBrAr2SOqGkKJ7HS2OmvClg2oKP1+0hbHaXS6lu9+28XWoSrtexwyQhYXDtoF+cFE3U7Xc+e6pvhsm3wJ2k7cxA8ZtyD5GKYPMAdRjfsNCTxsOYMvA+tQeb0ndxq1tnxoNkxCpj7nIfQUcfaFwvar8hIBCz+1IEyy5EMooSlF+hrwoGyZMscOQ/41FtxxLMmAe8UHq39cQeD7yez05yF5Sjf8785GvEhX3FKFm6u0CDm7M5TEYP0l7QNoLrycloopDWmv1tnew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7285.namprd11.prod.outlook.com (2603:10b6:8:13d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.29; Fri, 29 Dec
 2023 14:48:10 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Fri, 29 Dec 2023
 14:48:10 +0000
Message-ID: <41efbbfe-0712-4f6a-8bd6-dbae00a83c82@intel.com>
Date: Fri, 29 Dec 2023 22:50:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/10] Add iommufd nesting (part 2/2)
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
References: <20231228150629.13149-1-yi.l.liu@intel.com>
 <BN9PR11MB52767FFD4DD1A4CDDCA782628C9DA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52767FFD4DD1A4CDDCA782628C9DA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 370ce198-8139-49d4-4cf7-08dc087d2d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1QlETXkuAPJrtmkiA03eXOIUixej1U+mkDlv98zmoKUsIrULajMeqABaBd2hbvj242xAFj57s2AXYOOKX6CGS6A21GYG1WFK/6iYPcX3r4SRMopQxeii66+cigU11WTI1RhDiv5XOgfxfmYWq9Tviuq6veT5qErVYDxFhHPGJ94kNlbTfcEsryVqanVBbEzTwC7NSU01yAlKbgBRYDoGNjTb8gtz/Nj3jBtvOo4qlOwMefz7ZRTEWHUrFzHN3E5LzmO1i2YPMIqG/1KJ+gNFDT2rhd0buQPNaHLACVQuMof0Lx856pWd78fR/+/dquKELfrTXosXhqP6MY8lx/yZ77GAKCHMGq11nPvx92kQaA+gbUiNsB77HIYdNZ71GE00mqocutDdY3kf5pK/WlIwuQpnw4zTnGlHttFc1t0K2C/2H2OVSPYl4rfC11yx+1ilGkdXbr4zPiL28OuXcWFj3vUVk8GViDZhfUL+o5thBUzShKo2YfVABOcD+Wv9aBk9CooZRvYAEpZnwq86rkuj38OP2hNRsdtNuo15Ke4xJ3hG+r1sGBpieZ3kxfw1PYMfiHWhzspLyOd/ObmvCMIt+ET5PKkM6dt6qEmyTbCnRhMJ/+tKL8fYmyEwo8qPTXFudL1GhjDziTQCfu3BoxudK94MMPjnMcEyGUZGXuc4bw77khp1DQDDMSj7Tj2628T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(7416002)(2906002)(5660300002)(36756003)(53546011)(31686004)(6506007)(83380400001)(6512007)(110136005)(966005)(6486002)(478600001)(8936002)(6666004)(4326008)(8676002)(26005)(86362001)(66476007)(38100700002)(82960400001)(66946007)(31696002)(66556008)(316002)(54906003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1RpVUVQNHF0amNpWXEycDlSeko1UnErWCtLajBFY2JjMVU5VVhGY0tPWXBu?=
 =?utf-8?B?TU9MQlllVTNUSmV2OW9kMXhJYW8xYXNqM0d6Vkp1cGdYRVVnWlpMaFJ3dzBT?=
 =?utf-8?B?VXVHQlNsc3JnVEV2cG9uTytUUUhPbjVDOXduTEgxNTdvRlVaRyt3S0ovdmtS?=
 =?utf-8?B?YWNJRWg5cG9oMnEzNUt1N1ZVczVoRjloMDF2OHV0TEZLdjZkYlJ1bWpsdU9F?=
 =?utf-8?B?VDg1d2h1dzd5MTQ3blBaMFZpdWYrUjVYendvZEkwb3VtY3BheDByNHVha1Ni?=
 =?utf-8?B?S0k1RVZLR0xFUUlsd1NZa2pzM0toK0ZwbWM0Uk5STkJIMkc2VFY4d2hsLzF0?=
 =?utf-8?B?UE52ekQvM2JJTFExcG9JVUtEcGFKbCtZSkZqS2lGOVlnUDcyTDExVzJ0OFRR?=
 =?utf-8?B?MlF5alZoamVjRHRCNTM1eWdWc0t6d2hZUVNsM1ozMEkrRENrK3RNZGFlb2Q5?=
 =?utf-8?B?cnNCNmhOVld0MkZxN3F5Q2ZicDRtdiszdUFFWm9qL2tadmsyenE0bjY1aE9F?=
 =?utf-8?B?dExpNlIrSjBrUXRrdlVSb2lRT0JReTVZaGhyaXdZNVIyN0l0bW90Z1NTMi9y?=
 =?utf-8?B?dnpGVEJLSXdVMW9oNHRieVhmcDgvSEMvODdtZ2thbC8wSGt6TGdwQ1ErUWU3?=
 =?utf-8?B?M2phcllUdnVLdHBDVEtwcFFXbUQ2RnhUZEx0d2dMUGk1dUNVNFNUU2ZQUzc4?=
 =?utf-8?B?UXhwTlVjNGlIWmFiWVJ2MXN0Mkw4eHNuN0kxUlZpMzducFhSb3RRQkRQTHU1?=
 =?utf-8?B?N1hCMWRDdE9QK1NtaWlreHRaU3hFZldvaHJacndoWDVSQ2lwZGlwM056NURa?=
 =?utf-8?B?Nk8wRVdjdzdVT3VOcDJmeE1Ham1LNThIVFNNaGV3RGFFdWJ0SFJFRlRiUVJS?=
 =?utf-8?B?a0h1Y3M1RnlMTGtUSWNoWFVTOWRpRFFheTdUdVNyeVJOTkVqbnhBYmV4cklJ?=
 =?utf-8?B?aFE5bFdGd0hDRkNuWG00dU9IUmNKOGVJTmVwaFBBOTVkeGkyczMraEdZTzZW?=
 =?utf-8?B?ZmVaV1cxSGt2bnRYTWlsQ1dGMXJQb2huZ1RwUThNQitsdEtSbjlkZUNiQmcz?=
 =?utf-8?B?VVJrOUpzelYxTmVucU4vYnI4MHRha0gzQUJuODMxVjkzenJLRFpjbEwxSVdD?=
 =?utf-8?B?dG5LU3Voekh3NHo0VE1BZk04RWw4Kysvb01QN3N1MUZjQ3VHVDN1Z01nOWh6?=
 =?utf-8?B?UGtBSXhsdEoveG1IT3gvSXJESjhkbzhHTTB1S0N3RDkvSDlzaGp5UkhhcE1P?=
 =?utf-8?B?VFRtenBJQ1M4d1VJaWlybjVwM3VQc1RIRjBKeHdPb1JHUGl2bmFRWjd6VjF3?=
 =?utf-8?B?clV2dEtSRm9sRFFLaVBPME1uRGtVVUZDaEFpMFZCOVRMWGc5STJ4cU0rTzdm?=
 =?utf-8?B?ZHliTld3WnZZOGtBMFd0akdpZ0Z6d3Z5elBIZW1KZlA5a0t4VkNzVU9XOUgv?=
 =?utf-8?B?czBpTVhMYjNvN1ppUGtGWElaRllIaHhjNkI3ZkhwdjFhbGVkMkpTaTFQK1g0?=
 =?utf-8?B?MUhjOTlHUEZsa0RkYVRDcDlPTHlKY09EbnZ0QnduS1dpUHc4VzdxVkJBbnVk?=
 =?utf-8?B?RjhURzNLOUZFK05TdGlzNkEzbk5SbFBVd1dYQ1FZS2FWVmdXd2RKV3Q4TjRq?=
 =?utf-8?B?Nk0wd0VtYXl1ZWxrK0hpMHhBU2VPSEZRa214aUM5QzdLQkxrMzRORmVLVkk3?=
 =?utf-8?B?QXVzaFJKNWFQYklJN1piK00wUlJHNzIwVWJOR0piNkN3QzUyWUV3SERpaW1l?=
 =?utf-8?B?MUtGR2Z1WDA1RFY5SHFJbUNGeVBZZll3Smo0cTFGRDBQY0hnVlAzYk9tbDRs?=
 =?utf-8?B?bUxQOHFJbWkwQTdHZ3VuWjluOUpWaStIUG1TbnM5Y1JQeWpKQ0hKWDd4T0pt?=
 =?utf-8?B?S2Q5YWZLSjRObWRlWk5HZjlIQ04vNDcwc0p4UVpTR3h2WWhCMWNIODdOZm90?=
 =?utf-8?B?d20vWWRTMURJYlRKNEJiZXlRb0JJclBvQk5BWnFSVUI2NGRzZ21VMUVaVDl2?=
 =?utf-8?B?TGFQbHQ3M0NQWEdSanAzNlU1N3JiY3c2YTJvWktxSUNaN3BkODduM3NwTzZq?=
 =?utf-8?B?QTl6Qm9FQXFmRnFMdWF3Qk5aNlcxM0FMTWxOMytJcDFOZk9rU3Z1QU12MTRD?=
 =?utf-8?Q?r9zkRXWOza6mcjr+CpUuu0EGX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 370ce198-8139-49d4-4cf7-08dc087d2d48
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 14:48:10.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuIrfkHWTvmlDEBeyWENZwbK/lecsP1dHS5r6lPrJ70SBZuy44DMX0b8QrjqPvFPuzEp/ojmY047Q3LeeDFABQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7285
X-OriginatorOrg: intel.com

On 2023/12/29 11:00, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, December 28, 2023 11:06 PM
>>
>> This series is based on the first part which was merged [1], this series is to
>> add the cache invalidation interface or the userspace to invalidate cache
>> after
>> modifying the stage-1 page table. This includes both the iommufd changes
>> and the
>> VT-d driver changes.
>>
>> Complete code can be found in [2], QEMU could can be found in [3].
>>
>> At last, this is a team work together with Nicolin Chen, Lu Baolu. Thanks
>> them for the help. ^_^. Look forward to your feedbacks.
>>
>> [1] https://lore.kernel.org/linux-iommu/20231026044216.64964-1-
>> yi.l.liu@intel.com/ - merged
>> [2] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
>> [3]
>> https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting_
>> rfcv1
>>
> 
> this looks good to me now, except a few minor comments to patch7.
> 
> let's see whether Jason may have a chance to look in his holiday and if ok
> whether he wants to see a new version or just change it while committing.

anyhow, I've updated it in below branch.

https://github.com/yiliu1765/iommufd/tree/iommufd_nesting

-- 
Regards,
Yi Liu

