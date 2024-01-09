Return-Path: <linux-kselftest+bounces-2746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF5E827E8B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 06:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB1F1F24531
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 05:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46801873;
	Tue,  9 Jan 2024 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8yLMnvT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04317C2;
	Tue,  9 Jan 2024 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704779853; x=1736315853;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B2LoJHhZ6LpzdHgueqtWKZMssCqFCqcDqHXGWnDCjOQ=;
  b=L8yLMnvTG92U+Cl6NltlVp8OtQVg1YnwOPTLb0JyoEuPKExMjUphk3P2
   3YgALBCwDSmxuHayZJMqek8ZCG3B6I9O0DYRbgQ4feOaWN/e/Um3yK2h/
   4EvIHVcgAJP1IK5UymzVw1jfsKXCVeKaPEluznniKCs4S2wpnb5mym0pe
   3bZOY2VsmIlyYkIzegBZRn1/wFEDJ1GVJRFKu/K5PKw6ZKISOwvxgN12y
   O6KecTV5HIHAfzgd3oWq5MDQUZ99GZ0u3XSTm4jiWU8dJqc5LCZMqQ5xg
   0EIdGIQQ/RwkyW3e3rgA6MT71a+dQfx5Lr7xFJ04EhMXUFeMCjcI9tRy8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="429275823"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="429275823"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 21:57:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="954899278"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="954899278"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 21:57:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 21:57:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 21:57:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 21:57:30 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 21:57:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jADmV+bkFlbqfkkvyPPDqwMCEPQ+CtIQ9qD+iKBjOeYKo4GaHCwLOPm7fKQToLqoEH/ZunfUgAYQUPiL0QvHISEnQQ9yQARJ7lo01TYvj2riJqf3RVqDRt+wl6z95fMuAwXnrwurTlCBvjmwC6FLEufhIeK6a4QWBqsgV8ddO3d7zxW+8RRGbI3PLAeWVH0rfz4O29EadVUekxzRPIuCdv2aKIo/VwEIH4HCWL4JvDv2k7kS5eZ4V9PkkFDxl+54cq+/JkuJ7rKa54m6swdW+4sLCM+s5YbEWEao4BhY3Bo6sD9pjT/qSeADF/1GgYVYxwn3mQ+fqlKnFJHEIISOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XK1isnS9t5pmap9DjbW+lFN4gOnQRDlZX0hYAj84hLk=;
 b=bqpm7OScPQPfdDYxd72eLBeYn1w0Okpn35D/1O1KphuNxJaJVoknqfX8wDYShfza09n6hNtO8r/Rxqh7omAQWnBZcBOZbYglCOLKx7Gv3MFCUcB7t67PTSDn5FsqO0LiZgL8GleEoVOJBWnGS4IQsS4VCwLARLFxlx6xwej/WM5vctBzF2E1bHX4R8ftWuJbzDQxUd2Pn/zC6n5CrW7pYSUFIRiVQR7OvaIbSYoXLarP5gAPvzBefrQgPB2QU0fVEBqh/xyt2mxsjyir82909ObOhySkyjo/KrC/pZXU6ODkOXKpAJY8csP0WEXN690eZgwPG1/58Vxv24sLGqwR1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DM4PR11MB6093.namprd11.prod.outlook.com (2603:10b6:8:b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 05:57:22 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::142b:924e:5300:e004]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::142b:924e:5300:e004%6]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 05:57:22 +0000
Message-ID: <7c83d666-beef-4c4c-935b-2e8df1968561@intel.com>
Date: Tue, 9 Jan 2024 14:00:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d stage-1
 cache invalidation
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "kvm@vger.kernel.org"
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
 <20240104143658.GX50406@nvidia.com>
 <BN9PR11MB52769EEDAE2783426144E2588C662@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240105144516.GC50406@nvidia.com>
 <BN9PR11MB52765C91893A28A7D21D324E8C6B2@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52765C91893A28A7D21D324E8C6B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0190.apcprd06.prod.outlook.com (2603:1096:4:1::22)
 To SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DM4PR11MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c60cce-373a-4ca3-66ac-08dc10d7d8d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vMyMi1SYDJoIiaxKoxtqihBfUqEWIN1VzuV50yxtyROuF7eKw142/RSFZaL3/DICJdCpqgYF7bG6QQUdPz/NmMoFS/rjEyfgLc4yEFcaF027FRhs3smAhx9ynQ9Fiq9O/JGX2eD9g5UCOnUxBmCokLhPelHw6j5TbHSJuVwbEOHipMgseLss7VsGmcS7Fbea1i8lwD8f8emyzhr0ovsVJON+7oQGnxrbtf7NbN1x9bBo2JawMqDxchDHI9m1MEJahdyGmEkMcGJbHwHWMDq/0Zn1ucC5I+lmdkfzk3JHl1pcL2lyZWXGf/lXFJeruYDrCctfEXhck/AuWO/YnrOmEKMPv1HWy3TtmvTnxGLBJ1vp8HJMOsNUF3JLF48fdQAJr9DoKD6goXOL/m0/MfEFngZVt9h+9i9kbdZje2Wba4MBOiCZouuoY7Q938lbqy1EMKaT3rmO8P3OfwQqdx/03YREF14qWg0UR1HIcc/UH+L+S3HqtAAVO7KnN7qXhmtFWquWGI8Cahyj/LnLqg4k9/5rpiRCbUlHUgBbhJxWFlXDgimzLJeRO4tJnOSpeIzPPEaUtAYxgCXn0Wn9M2n6U5cKyLn+Wb9rWoQ6VUtIqREeGLd8Ze8EhdCEExudSmRlj0791J4Xyq0gSjYETsk8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(26005)(5660300002)(4326008)(6512007)(38100700002)(53546011)(2616005)(31686004)(82960400001)(6506007)(6486002)(31696002)(6666004)(478600001)(66946007)(110136005)(66476007)(66556008)(54906003)(316002)(8936002)(8676002)(36756003)(41300700001)(86362001)(7416002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkFpZUw0b2hLZXJIY24zTVdlclhxZTgzT3lndGh4MXJTU0NNdGw3T005dHh4?=
 =?utf-8?B?ZmpUNGR1NTlnb0tjREMxVTk5MkVNeDBPSmtTNWdoR2svYTRXYW5JMEExYXEy?=
 =?utf-8?B?SFN3MlgxQWJhTnRFYjhrSlNwU0NMU0J6Nk9jSG1xMmt2aThrakFyQTZlTTlJ?=
 =?utf-8?B?ZzJhdG5qMXlHTUVrVEN5cUR1WDllVEZTQ3J0TGxNTmYxMittZ1R5d0lubnNy?=
 =?utf-8?B?aVhSMzd0N0VVYzZidGk5dzNmbzFxYk9QTnJHOWtpOGg1Zy8xMmtmNmNFOG9m?=
 =?utf-8?B?OHdBRi9Rb3JrZzA3b21paytsbk10a21EY1dqODZIYlF4Y1EwMDEwWFEvT2tW?=
 =?utf-8?B?MForUFc2V29VTlY1eVpOS0lrdzBzZWZBNmJIdVF0K2FQQWtKTWlmb0oxS1Rh?=
 =?utf-8?B?aG1VTVZvVVNTTFRtN2NEbWs0QjhUZHVtLzlhUFVvMU1iS09NZlpXSGN0L0pv?=
 =?utf-8?B?Y1c2MmxzTFZaTU5kc2xTRkxoUENrQkJPYzRFSjBpQVl6K2hXb0NWY3JHeWgy?=
 =?utf-8?B?TXRtdC9scFBDN3JMMG5FSy9UTVV2OEUvNE1OcmRlNkFqUkNaMUhSMEt6NXh0?=
 =?utf-8?B?Z0Z6VHFqeXFPR0RRTS9jUmE5bk1KbHdkNHk5bms2cGVWNzBTam1NWHBzaU1r?=
 =?utf-8?B?VmZMWjNsMkMwOGY1bEpNeWtBd1dONlZSK09jYnlZNTVSWElaK3h2VzA4MHMz?=
 =?utf-8?B?SFNnY0RyNG5kSmNXU3A4VllVY0FhMnNnM0tCOG5IVFJ4UlVqaS9GeXkzTjdn?=
 =?utf-8?B?cmd0SG91aEZkNjBqNjJPUGpEUC92d2hhbmp6ZjRBWkhSZ01oMlNwS0htcVkr?=
 =?utf-8?B?dis5c3pjYU10amROUk54ZHZvQjR3R2xjbDJPV2ZvSU5KVDN6Ri9tQlBESlI4?=
 =?utf-8?B?ek9JY0didFhGQTdpZ1NqUjBZYWpUZXVOamNhRTJxOXRPcDUxOHNOcmtmeGNs?=
 =?utf-8?B?K3Z6ZDJxTCtzR2FCYkt4MEpoVld0TXMzNGV5YUo3VkJJc2ppRWIwZnhUdlph?=
 =?utf-8?B?am9MajR3U0JTUGJ2VFNaV1FzbDdkM1o0YVhlRW90SXc0TmY2RHkyL2V5Kzgw?=
 =?utf-8?B?UHczM2dNT0VUTHdPSlV4MzNhY2Q4Nk83UWliWWw3bkp0K1RKR3JkNkRDdGNX?=
 =?utf-8?B?ZUVYK0Z5TXNmMlRlOWNIT2x3RE5pdktXcncva3Z5eXVqN0tyOWM1SVdWOFFo?=
 =?utf-8?B?RDBrTVNOQXV0N2dUR1ZxSzJoRWxwOVI3S3NDQ01hRi9yUDFBcllWbHRKZDBI?=
 =?utf-8?B?TjFzTWdyek9PREV0WlJjZ1M4Q2RBNEphbml1N1Z1c3ZXSU9GTlkrL0lydHZB?=
 =?utf-8?B?T213bkNnL0EvYlV6QmtuTFVFL1JQUGtldVhna3BaZmZLMlk5akxkOVIybVpM?=
 =?utf-8?B?QmJZSTgvMEd3WFVxZWU2K21YQXJPWGwyREpkZHdZM1NZVVRMZHQzUXkzKzEy?=
 =?utf-8?B?ZFQzR2d3UkFQWnVxZXF2VmlQRHRRZGFESndacEVvZEtjbnB5ZE5VMkNXeHZS?=
 =?utf-8?B?c3lER1NpY0lrdVg3YzZVN3dMU0NHKzR1OGh1L29FSUpCc1A0bEwyWWpZMkh2?=
 =?utf-8?B?WG5sK3lkVFZud2I3T01rMXZIMXpHTzlkTmFmVDUwcThsZHdIMldGYURmS3Rh?=
 =?utf-8?B?YkVmL1BFWS9GMUxqbUdmRGZaRWZncEpLb3c0L3M5TGpjMHkzVWZpWmdyaTFi?=
 =?utf-8?B?WUZuOXRBV0tYWTN5eklRSmN4RzRIT3BuMWEva3FudVM2OGh2d2FLMkpWR0xy?=
 =?utf-8?B?Sk90TzlhNVUzL0VKS1JmVDFjS042WS9nQ0lkeHFadDVWajh4M1RaSUkyS0Vo?=
 =?utf-8?B?K0RqRDR4OG1GRG5hR1pzRjI0TkFJeTZnSzFaY3FibTFmcDZvNGNsYVl5dUZl?=
 =?utf-8?B?UCtremhvbU4rTzM5QXJ6bkRTN2tuKyt4OWxOT29ybFZhU3lPcUlFOEpQKytW?=
 =?utf-8?B?cnA4VEZnNXRPdW10QWhiVUFlSE5BRWJWTU11QkgwUVpuSitDQjN6S0s5aTFE?=
 =?utf-8?B?UVB6YjI0T2dJQ3NuM1E3aTNUbjQwYXl6QmlzeXFYdUlkSnlURi9waCtPSGpL?=
 =?utf-8?B?UEpyeDdpM2x5alBXVExTOGdsUWMwZVgwK1Q5MlhIR3pnRFlVU3hJVk5DME9G?=
 =?utf-8?Q?KmbBGmOlMe27S8ms6pQSSJo/w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c60cce-373a-4ca3-66ac-08dc10d7d8d9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 05:57:22.5037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLSsJI/FKBYgpiDdrC0jzfbb99G7ntVCmEF4k0NwAQiE+lmNavCP2sbmMaHp6G+zFqYXHlS3TTDNJq6BMHsjvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6093
X-OriginatorOrg: intel.com

On 2024/1/8 12:07, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Friday, January 5, 2024 10:45 PM
>>
>> On Fri, Jan 05, 2024 at 02:52:50AM +0000, Tian, Kevin wrote:
>>>> but in reality the relation could be identified in an easy way due to a SIOV
>>>> restriction which we discussed before - shared PASID space of PF
>> disallows
>>>> assigning sibling vdev's to a same VM (otherwise no way to identify which
>>>> sibling vdev triggering an iopf when a pasid is used on both vdev's). That
>>>> restriction implies that within an iommufd context every iommufd_device
>>>> object should contain a unique struct device pointer. So PASID can be
>>>> instead ignored in the lookup then just always do iommufd_get_dev_id()
>>>> using struct device.
>>>
>>> A bit more background.
>>>
>>> Previously we thought this restriction only applies to SIOV+vSVA, as
>>> a guest process may bind to both sibling vdev's, leading to the same
>>> pasid situation.
>>>
>>> In concept w/o vSVA it's still possible to assign sibling vdev's to
>>> a same VM as each vdev is allocated with a unique pasid to mark vRID
>>> so can be differentiated from each other in the fault/error path.
>>
>> I thought the SIOV plan was that each "vdev" ie vpci function would
>> get a slice of the pRID's PASID space statically selected at creation?
>>
>> So SVA/etc doesn't matter, you reliably get a disjoint set of pRID &
>> pPASID into each VM.
>>
>>  From that view you can't identify the iommufd dev_id without knowing
>> both the pRID and pPASID which will disambiguate the different SIOV
>> iommufd dev_id instances sharing a rid.
> 
> true when assigning those instances to different VMs.
> 
> Here I was talking about assigning them to a same VM being a problem.
> with rid sharing plus same ENQCMD pPASID potentially used on both
> instances there'd be ambiguity in vSVA e.g. iopf to identify dev_id.
> 
> we agreed before on preventing sibling vdev's in one VM for above
> reason, but only as far as vSVA is concerned.
> 
> then given the new finding in err reporting I wondered whether this
> restriction should be applied to all SIOV scenarios (but irrelevant now
> with below explanation after another thinking)
> 
>>
>>> But when looking at this err code issue with Yi closely, we found
>>> there is another gap in the VT-d spec. Upon devtlb invalidation
>>> timeout the hw doesn't report pasid in the error info register. this
>>> makes it impossible to identify the source vdev if a hwpt invalidation
>>> request involves sibling vdev's from a same PF.
>>
>> Don't you know which command timed out?
> 
> unfortunately no.
> 
> for errors related to descriptor fetch the driver can tell the command
> by looking at the head pointer of the invalidation queue.
> 
> command completion is indirectly detected by inserting a wait descriptor
> as fence. completion timeout error is reported in an error register. but
> this register doesn't record pasid, nor does the command location. if there
> are multiple pending devtlb invalidation commands upon timeout
> error the spec suggests the driver to treat all of them timeout as the
> register can only record one rid.
> 
> this is kind of moot. If the driver submits only one command (plus wait)
> at a time it doesn't need hw's help to identify the timeout command.
> If the driver batches invalidation commands it must treat all timeout if
> an timeout error is reported.
> 
> from this angle whether to record pasid doesn't really matter.
> 
> intel-iommu driver doesn't batch commands. so it's possible for
> the driver to figure out the timeout device itself and identify rid plus
> pasid to find dev_id from iommufd.

based on this, even RID is unnecessary. Software should know which device
it has sent a devTLB invalidation.

-- 
Regards,
Yi Liu

