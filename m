Return-Path: <linux-kselftest+bounces-2484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B380D81F3E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 02:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82481C20F8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 01:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8FC15B3;
	Thu, 28 Dec 2023 01:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViSJcrW/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA214401;
	Thu, 28 Dec 2023 01:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703727931; x=1735263931;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n1oDn5ESzm+Rj4IxpNbt38m4vzkT8oAd0v1do83acIo=;
  b=ViSJcrW/7/ptqTiN6PFosenMzSYO3gIjkAyUSjzx8hFOYPiEbj9MaF+Z
   hqWMvtUIK09enxwuTj5/KdBeySeNnh1HIqmB7YjIPBqbBX5zV0ZsDPDx8
   VwXpRc9aWi02143ZflWojEItB36wILcq3NjuPF7/CsNi1rYdKJ6hNoQpo
   bXg2s1xTzYGEVUE376cpHpv7ogJmT53+FDAUojLUK6K9tL+yUIxhzalA2
   cUBW6xyqkV78MKhYNnXKiRMedfGXjnZlPxZibL2QWR2YNFOx9YQnL+vf9
   XZIEUtfzJHRmmzcZr1+ZiXYXZJWqmsi35AQYl+1O7ZmOPf5JZY23qR9Jm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="482681073"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="482681073"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 17:45:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="901836932"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="901836932"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 17:45:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 17:45:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 17:45:30 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 17:45:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBPqw2pR8a3lNf90wPtOiDLvBjT4QHvod6AImkwpD7qGz1frjzmtbLXLR6dhuneyle2B6LIIEwzFf348tlGlMtTKmwGA1/WEFGANPXGZBe46lQRGf+akiHlnegMA/zXAqofb4wKAUUvj/efweNlLiYmoJSnVGNQbX14adGUgleCsLXfFknHuNhCYlcO8A9i96syb2Mg6bVECE7kgOyF5YJlFiXc2tuaf/zKUC/rlqUFst1y8e7hmiVwFYMEMKUm+j5inyY/ws49pKDoh9TElSlknHhqvucopEKXn2xL+f0MrICpeBi+ZgOQ6WpRiguXyoM3Hk4JM8hvy4MfIh5KjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09kBkpkgJ898EcI5o02D76iJWbyRwpbsvrF1LMY+Z9U=;
 b=PmyrekOUKi6jawti6kS8R7Yx9DtEXZB3kKBcxogqUCT3sDKZGzNLJwTReSLjedIQ6YOaSE6LRyNCDXpfKIum/RPlwhuSQlCdHNxTWLbs10p4yF/nklz0FNN4bvowV4cgjKgSOjIaS26F/tHeIWnUJa7nTtoCog9R0NT57dxLVPDMRL845HSKhklJQnkOSLUmjyugrZwCNQK++RcawXu+4zPWJfhqz3mSl0C6QVxbVHSfwpwJZmh7gWkIulREK0ZNhG45OcCUaXbLRoZ66r5Nrn0ResNpzC+E3X1owxAVfUCZeXOlDkrgQPqf41Doq3E7gjH39J/XecgjqdlThTwGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB7399.namprd11.prod.outlook.com (2603:10b6:8:101::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 01:45:29 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 01:45:28 +0000
Message-ID: <3889564d-e5b2-4950-9d0d-bade1faad0e1@intel.com>
Date: Thu, 28 Dec 2023 09:48:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Add iommufd nesting (part 2/2)
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <joro@8bytes.org>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<cohuck@redhat.com>, <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
	<mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
	<yi.y.sun@linux.intel.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>, <j.granados@samsung.com>
References: <20231227161354.67701-1-yi.l.liu@intel.com>
 <ZYyP5OXxsIjIzhKt@Asurada-Nvidia>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZYyP5OXxsIjIzhKt@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 275e64e1-3180-4f32-ae9c-08dc0746ab58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4OprSS7nMT3VzJm3NqYycujtrzkRSS5DWmoe0mopV7NrcZmaa1cTI6f+EpJal94FVvCFePmSyrtq6LM1anRBXEQiCxUKrPgWjt6efttg97+JCYDgU4u8nka+QxrWLxE7r5cf38m4bcdg9Wp7oXuL3Ne+wtDOIsWn9KPhJXSkVHGO4Odm2nVhCz5tPKxd20nUmCB0IVBr1SvWtk8kthPdYZxpXG1B6++83PyAGeYu6KQok8ZNHwyVRr5J3u+oAGy2xokpkDPQR6rWYb8RvqW3VW5/Ri6R/gLu5lZ+HKxiW0LzeCJJUD7fPrUZei48eKWbbn+K9kEWVHf0r0/WrpJloR/R5IclJgLbknSljH2T6SZhgAcP2vjtK+rN+orz5BiKh83Wf5jlkMlavMibuni0w3CA4AorHfAtVxPtIcF1O0e9DFH6awAesbucjWhlQAtq2sUdVg0fJFTl1CTOOjov0BHspoY1DP6AsAku7kh72Og3/zCc5gil2rfvALCqYyVPIbpMoqPUr9D0VJ7Mg2TrfAGSoybRJ2ZK0CpSZG24eSJAyrvx3aYNEDqe5fVQrYIksD/QDadnZfatdYdM6qFPzn0JLrHBZNAQPWhRdqXhVYWDDUzdniG6T66JxCIQ7+vye2xAmhD2QcFPmAcosf4Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(6666004)(6916009)(6506007)(53546011)(6512007)(966005)(66946007)(66556008)(66476007)(6486002)(31696002)(36756003)(86362001)(82960400001)(316002)(38100700002)(26005)(83380400001)(41300700001)(2616005)(8936002)(7416002)(2906002)(5660300002)(4744005)(478600001)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEVod3pubVk2T0xOdmhqMEp6OXAwUkVwK0t5NlhVR2x4SFBqeGdMNGZvN0dt?=
 =?utf-8?B?N3YyWllRcnlkMmNLVTRja3ZXcnBGRkJoZFNSN2ZwOVhCVk5wNDMvZTFNNU4v?=
 =?utf-8?B?dFg0Y0ErUEh3S28yMnlQdFNNQ2ZHZHRRZUxrbTk3Yy80MEU0ZkJ4c3RGWldE?=
 =?utf-8?B?VmJkNk1vL0F1bWV1MFlFbGtIN29DSVhSY3RkbWZoN0tsOWc3b0tIc3BwRjFO?=
 =?utf-8?B?MXAwN0wwemh4emU2MGxBd2NmN1M5SG1mSFBPVmU5cDd5VU9WUG1VQlpKbkhi?=
 =?utf-8?B?T0M0VVFBdEFvT3d3akw5cE5jemJ3NWk0YytZVGRyM2hBOUJ3cnllVVhBTkZt?=
 =?utf-8?B?Tys4NUxjSHllVEpEN2d4RUNDdTdmdmNWbkFPZ0JLWktFRlAwbGtMdktuSTZn?=
 =?utf-8?B?emM2Q09mbFBkb2huVkVvdVR1cG9QaThXdlVWbE9wY3Zuc1RlU2tnbkluSFBJ?=
 =?utf-8?B?UWNRSWRBWEZMZXVWR3pxU1pheGl3Zno5VHhORWkzVUszK2hVS1RoWDIvSVBr?=
 =?utf-8?B?MEs5OUtmN1Q3OGV2RUI1MjRhN3FnTzIrWTMyV1BNOWFWZG9TdS9tK0puTnRV?=
 =?utf-8?B?WHptV2VSSThWYTA0cWdIaEZ4dVBBQXd0ZXBBSVJrSWhLSHo2Ly8ydVNyTTdC?=
 =?utf-8?B?cWxZd1lRa2E4WlN3VlBYbDVIRitidDgwR1pTRG5YYjhkQ1FFQUhwMitldUtq?=
 =?utf-8?B?VlRJbitiRU0xVlB1aDFhMURuSUc0c3FhQnNiRC93ajd4NkgrUkUvaWQzeDBy?=
 =?utf-8?B?aHBLN0ZmQnVWMW9Ya082V1VYRXIvaXZyaHUzbVQvMzVqTmU2RHYzVEFNWU9E?=
 =?utf-8?B?U2JoTWRWdUwzKzY5NXJDUlMrT2YwWmZlWXRsZWFiaCs3MTA1TkR2TGpMK1BG?=
 =?utf-8?B?U0JHY3poa1R0VUJzSzJUd0J3ZGxiVUNDUkJRaFZpRzl0MjBIb3J4eXdvdjNz?=
 =?utf-8?B?ZFVCOXBvV2V2OE9UdktXRGwyL3cvdzJWd3J2elZFdjlVSWY2ZXJqdERudWVS?=
 =?utf-8?B?aXpOaDdNMVdrdS8rSE5LZ3cza3orb0J6ZTB6K1kxSFUvckk4elpzL2ZhbHBY?=
 =?utf-8?B?dzJic2hnTmI1cVZNdXE1dzBwcU50T204OFMrcVVZRGFrejZSclJHanowZEQ2?=
 =?utf-8?B?SG4xazc4RlhJMlRDMzhFS3BZY2E5WkdqY3BFZUFDQjR4bldnOElhZGR1RW96?=
 =?utf-8?B?TnRROXd4MlRNbng3WUVGaDFYMDBnOWRtVGppSC9mR2xjRHJ6Z3hwU1BCUGtL?=
 =?utf-8?B?bVZ2dmRpY0NmVUc4N0xyUEg2RkZIbHNqenZUb0VQZFRNeVh5a2l4TGdBMFdw?=
 =?utf-8?B?cXQzOTJsV1VZaDF3ZVdLMWhBU0ZlblBzSVFjK0hBSjhQT2l6S2Y5SHByaVhF?=
 =?utf-8?B?N2pvSUZwNmt3VExoekl5Q2ZVZWdpelQyNHkzd21lN1NRZ05OM2hqSStxSzVR?=
 =?utf-8?B?alp0Ti9VWERLNmFWYzdLaHBEeXBBNmhsYjdBSTRORnZrTGl6OWh3c0NQdDR1?=
 =?utf-8?B?S2pLUWZ4ZlhQTE1jaXEvOEJLak01anpEU21YQ01iQUtLcmU2VWc3K0c3dHRv?=
 =?utf-8?B?elBRVnZRdHhHU1R0VXVYWU5vWWZ4Rkh2c2xiRVNpdXpvanVmWmRTMTRZV3I4?=
 =?utf-8?B?RG9lZ3RWcHhzKzd0MGxBZWNlSSthdVZpcG1qZ21ycWpvdTdNelpaMDc1Uy9N?=
 =?utf-8?B?b2xqRGNraVNSdUJlbUZGQU1QRmR2T3dOK1cvaWJ0d0NrazJYQ1BmM0RaeDJR?=
 =?utf-8?B?Z3hDbTR4bmxxQVc0bDdjL3kveEo0cHJKYlFyTW5kQTZBaVlsSzNOWk1aclMw?=
 =?utf-8?B?Z0dDcjJXNytuc0wvMWRhaTlIRGFZZzFUVVpGTEdaK1psdUxKNDFUMFZGc0NM?=
 =?utf-8?B?MHBPQS95OVZtbEpFYkZPdi84Q241TGUwenBWN0ZaOHFLR1RDanJZQUREU3A3?=
 =?utf-8?B?VEFiUTNkZnpVZ2ZYd1o5Rmwrb3hGa0wrZmgzb0lVUFpxZ21TREhCdTQrK0Jt?=
 =?utf-8?B?MFNONjNUbFcwVW80ekQ0VlI5UGNWaEtwd0I0UExoSXNPNE5pMjRYb3hMdnhB?=
 =?utf-8?B?U25mbGFFVTRmL1hTSTY0TUFnQXdNNEszdXJQTjh3cDI1cGtPSERSQWpuNTRZ?=
 =?utf-8?Q?oMXdHJrtHwzd4KmN8u6yCmiiA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 275e64e1-3180-4f32-ae9c-08dc0746ab58
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 01:45:28.7440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOhLs3ocPG8E+jvZJv3atyWF7x0nOkE2f+x6hw32LoXGJyPHUqQC9omimxcNSKYu6IOHNiT0ru0C3D/7Lh6exQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7399
X-OriginatorOrg: intel.com

On 2023/12/28 04:58, Nicolin Chen wrote:
> On Wed, Dec 27, 2023 at 08:13:44AM -0800, Yi Liu wrote:
>   
>> [2] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
> 
> This branch is still pointing to v7's iommufd_nesting-12212023-yi.
> Likely you should update it to v8's iommufd_nesting-12272023-yi :)
>

yes, it is. done! :)

-- 
Regards,
Yi Liu

