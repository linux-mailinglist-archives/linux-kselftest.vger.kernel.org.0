Return-Path: <linux-kselftest+bounces-1557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A043380C9E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA821F216E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504C43B7B3;
	Mon, 11 Dec 2023 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDo5NgHc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517248E;
	Mon, 11 Dec 2023 04:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297967; x=1733833967;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gU88qj0IZP7NR/jAJC1g8YzbzBMbIf51xggMI4rHhlA=;
  b=DDo5NgHcJ02ZYgluN2/idSXHpRqzi5ZGQstJMKb2pN9lxPau1IerG3uV
   164dTMp/YIdfN+MHlGNc+V835qVvNJh07ehYUAbCU3zcRfwr1hyBx/kd9
   RGXP9TFoNxAgVxei43VfLM9dmxTsdfglSBktNAO+XEjy2m53C54ju+9Do
   QSZVgZVQIxB2tpGp9E2MnDtVbW7L0oMPy7kWj3IPuYjkcVcRWb8iudkWk
   tVQO0gXx/If5lXRq1SuT+A8H0aqZISUAu9VSgoYTwpcevJBpVQt0EJgAk
   zsTB1UPYpvXNFKqcm3CQHdM7giCanSu4V4r9jMXpbtgLfLHM8LpXJZyOi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="385051819"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="385051819"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:32:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="801992344"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="801992344"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 04:32:43 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 04:32:43 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 04:32:42 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 04:32:42 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 04:32:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGx/9/jq/oQfeRtae+LKFmwFdlSahEwHG3KeuW7/+j1mqlbxgXMdbgAyhBeNpUjTMIdrHlFtwm0HCEecVc91JIFM+mfSsTFkfj13HmQIcjjy44SXg5JMGmw2pIqEFoVfk9/tQx93O8CXeoacsWe43gIxM7f5d89KUsYYwYvBmiJMKEy3t7vrRyFCij/qFpf52/DbsjSbCY8dW0egcJt357WQ6FWJ8j0B6bsdGBSNsSNQRCy1TrEoa5SJUjU3UCxf3pEhUuowf4gH7wO3IPJq1g/eyc+gFghUzhl6Ol9D1SGTczqhp9iIjQVGGrY7eBGi8VLcrI75BmJa1T7gb6UcTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NecTSibqD+7QiDwY/79ESXAf6LzrPxqsdtDfreRNdAk=;
 b=cobXWrAYGIksUbvSZ81v9wX4BJPMes/L+UZLWzpcN4SYoh8CZGwAVl2z6hfvvYdS8GY0Hq19ypC1xORWiuOFvZkzY56QW5cjReRLjMXs4ZqtWYSwenb+z1gyuqJQ+EK5wdc3lldK5Tt/5y/qUq0v8IlRK+9ljtd65rxvRrPaMum2+rA2LWENHSEGkAHnJ5q5E+O5yZsDMljGme2CW0JZWrzb+oeKI7FF+EWXaFOwvczTzfvNicCHmHrOQtEFMtjfZIhhgHSbb78LqbJqwvfQu5KP3kdo2EX4rdcDiZnGepLlCvRJmtJRm3dfDZLR6DYCTUj236kY6Pst2P0VkjN4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB4829.namprd11.prod.outlook.com (2603:10b6:a03:2d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:32:38 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 12:32:37 +0000
Message-ID: <77ac47d0-2ef0-41fa-86c2-091358541465@intel.com>
Date: Mon, 11 Dec 2023 20:35:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
To: Jason Gunthorpe <jgg@nvidia.com>, "Giani, Dhaval" <Dhaval.Giani@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
CC: <joro@8bytes.org>, <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
	<robin.murphy@arm.com>, <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
	<eric.auger@redhat.com>, <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
	<mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
	<yi.y.sun@linux.intel.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>,
	<joao.m.martins@oracle.com>, <xin.zeng@intel.com>, <yan.y.zhao@intel.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231209014726.GA2945299@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB4829:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c56e90-f0a6-4b23-0f77-08dbfa45420e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnvNqrAPaR12EM7Nq0E/FVylyWEAevU/nmjwNV4Uqp4Iqt3qLOi3tmBEA6QImwu9imQOn7TUAt6vm0HYPXzQ+G2CQWUyt6gvdHUSYxUyQR6YAXE9a73+3QOgJWO/e5xWyRbnAg+tWvWTnnJSfBU8RtzaSluyT8oO0IJQjdJ4ItYYZ8jRgAKBATpS+fNg2Zs+aVHVy/+01ZkRB4+rDJW9z7Cw/MC3kk4Xmpl7iFtWiB2lsHWh63vk9wQr1N523Hfx384S0eodivsxj+hbEpYEQX0z0wRTzmMfDdJ285sg/+A/KOMEtilGj1hmoym2mofNTbdimaCOoVrAP4q90uOfrffqjxI6lubZ5qFz13G7G8tf+gHh9GpStq+lL8LX21oITBp5Ors0uPVfld8mXVdzsB2dko+qKFG2R2X7WzUtNfyvifJsaK7KqhDBR1NUSMCaLuwmpLGU8HGr3DDANO8dfCwr5+VSXL7xel8bRGZhYzBzS8Dzbpk3GJd1RG9Qmnz28+xzVTM1N0SrGlgAPQuRXL499Bqev6sxn9MPn43ga/lVXNWCsl+EhN+0IgHV0Ok/no7aXdvRGw2mbT0bqGX7k0elVwxUBZQPw7iZRFXmbJTbWwclDTN5Dwj7a9rtW1EU2V+RWDYgMJYxHXkHDvobhUx/f9fWhe9/0mwLlJnfuuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(6506007)(53546011)(5660300002)(26005)(2616005)(36756003)(6486002)(7416002)(66946007)(66476007)(66556008)(966005)(2906002)(83380400001)(31686004)(82960400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(31696002)(110136005)(316002)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2pYdUdiV2xDTWVpd0NJbzdad01uSWNwU2NUNXhGbk9QRkkzR3puNHJQc3Ri?=
 =?utf-8?B?aGd4U040ekdnSFZlMi9INEt1T2xhYTJuR0l5cHkyZUhrRmJyYlBIK0Fqcldw?=
 =?utf-8?B?eXNxWmVRUGhCdmplWXplZFVqcUN0dk5YRU85S2dGWXJyRkVZNGJIK2g4dkNa?=
 =?utf-8?B?Zlhjb1BMWXdtR3JPd2JQbVRKNGxpdlp6UkdoMGhZQ21WWUFNQTNwWUhpVSti?=
 =?utf-8?B?QjhiWVc0cXorUjJ3Ymw0eE9MN3A5S2l0ZEl3cER2dGF4SW5LZWZwOEI2R0hq?=
 =?utf-8?B?LzJveEhkQTV5QzBPancxUW45LzhwYTZGd1RXQ0RUN256bXhwL1JDS055anJV?=
 =?utf-8?B?U2ZyM0JBNXlzUzVUUjBxQ3NGUThaTE5XL2FXM2dtM05wQmt5K0JtNm81Q2dk?=
 =?utf-8?B?Q01ZQkVuQSs1eUc4OWlCZFpINXVVNEFJMjlsYzNjbldFbUpJVU9ockNOK0lO?=
 =?utf-8?B?MTVCTXZ6c1RzVVBSNGVmMTAwaHJDOWEranVUelVseFVieThRQTlsdkRuUDE3?=
 =?utf-8?B?aTYwdTdOY09tMmhBdTlCT0RVdXBXb09DOEJwNDlBK0d4Y2FGOEV5Q1ZjV1B2?=
 =?utf-8?B?bHdtNzB2a3dlNEVJYlZ4ZlJqZ3h1VHhvNEtCSEpLaVN2dmtsSDdwSXVNM1da?=
 =?utf-8?B?cVBidnRXbGZCTVZ6Q2VvVE9jc2w3cmc3Q0p2dTRha2duTGhkU0FLay8yS3BT?=
 =?utf-8?B?M1g5N2N0SjIwSG5hZUVEQTkzWFAwdGc1akRwbE94QWxmdVFzZ3BsZFBtbHJr?=
 =?utf-8?B?RWxpbzhXcW9raVY5ekFYQ09RYnVERVllcFhCejJvRDlNeTlqWXNTSDVYOUxP?=
 =?utf-8?B?eFVhVlJmaVlZTjZmZTFqRm45RTQ2QzFyak45RDczZGdndHFSWHhsdks3SFFp?=
 =?utf-8?B?RDFoU3NGK0V2bU9FN05xMkE0UXdGS3h0VG44YjJncWNCakxoOW1aTHAwSzZH?=
 =?utf-8?B?dFNUNmlVMlo0UWdJR2hjb3ZsVzhCbVN6Ry84U3J1UFNKTkVJVFdOQkxaTFp6?=
 =?utf-8?B?Rk5aQzN6T1E0cEY5ZC9QQUYrSkhGUzc4cEZzQ0RTVXNMZFFhdytuTk5SZUt2?=
 =?utf-8?B?TVNDcExwSHNzbHMwcnNYZDBEamtrQUNRR0UrczhiOTRZWkpTbWVIYkdoVjE3?=
 =?utf-8?B?YkpkeEo1WURGYlBVdFJSTUZrS2ErbEJYY1BxenhJT2ZtYm1WZDYwSld4QnpQ?=
 =?utf-8?B?c3hwNDdUZkcwZjNEWnRmRVNaTm8xN0hLcjhOdjkyQ0RsUkxxVFlaaGhlWEhz?=
 =?utf-8?B?SWRxbWQ3Z1pDLzIxdHlGWUFWeE5DdEUrOFFMN1cxNis5Y2VRU1lRVHA1TzJw?=
 =?utf-8?B?OHpKWEtBNmlDMjh0R2ZRYVpLVU5NRTY0SGxoMFV2OWpTR3lEWjFub1dXM3RS?=
 =?utf-8?B?a001NnhkSzVhYzlBRmpwV2R5emowWTZzdkZUWDBKbTJpTkVyS3hxWkN0bjk3?=
 =?utf-8?B?WmVoUi9HOWdlbXJsclVxN2taL2FzS3Y2ejNURW8yRlAyNGxVWFpJSkJzS3pv?=
 =?utf-8?B?Qjh0MmgwM0xEc1hJQVM3NVQrNzJYM1paTTBHTWZpaFVTWE1LQk1zTlcvL2dK?=
 =?utf-8?B?RFdIRkhScCtENVlSSVJqUitqV3doTlhNQVhPc3c4cEFrRWJzOUswOHJ5SFpK?=
 =?utf-8?B?OXhEVnBQQVpYOWpVL3Fqa0tTenY5Z09CMUhoT3o1MUNWY3czSndKN0RxVWNP?=
 =?utf-8?B?dHNUTUdwOXI0bEp0TE40MlIzbnpJeERSWFZSOXhFRUh3TldlQnNDWVJQczZW?=
 =?utf-8?B?T2hmdlkvaFZUQmZoNTYyMGVPQTBYcmJ6bHdySkdJTUR6RjNEejVlNzJ2Y1Zy?=
 =?utf-8?B?dVpTcXhlVFRTMm9QS0tzWUcrMkYzYk1wNHpRN0wyR3kwZFNyZnVadTNQZEVJ?=
 =?utf-8?B?MVFscmZqbkZYMDFVa09COU0zSlNOcm9haG1sSVVjNFVSdkxSWk5DS2U5ZXVq?=
 =?utf-8?B?dnNrcm5ZSFhBb3ZQaGpKMnJxUEFVeXRLdk1YcnRCeGVyN0loWThjWnp4Uzkv?=
 =?utf-8?B?eGU1MC9idkxNb0JVL1BUSEFZVGdWenQ0RWpxejVYTks0NE03a0xQa0hNOHZS?=
 =?utf-8?B?K1FnbVhyTk15MG9GVlhLUk9jTGJxMTVPYnhrNWZ6alQ3OXNIdGUyYmNEcTFn?=
 =?utf-8?Q?Nyou0FRxBcrCmq0+vHM3lHb/J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c56e90-f0a6-4b23-0f77-08dbfa45420e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:32:37.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VG+CbzUxUxKk0zq/kWbHdZdSaii2y0LZEpzC1P2zqYrI93ohM2lkMbZl0NxdjQDlVqdCl+dEfLF9bPUz+dKJKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4829
X-OriginatorOrg: intel.com

On 2023/12/9 09:47, Jason Gunthorpe wrote:
> On Fri, Nov 17, 2023 at 05:07:11AM -0800, Yi Liu wrote:
> 
>> Take Intel VT-d as an example, the stage-1 translation table is I/O page
>> table. As the below diagram shows, guest I/O page table pointer in GPA
>> (guest physical address) is passed to host and be used to perform the stage-1
>> address translation. Along with it, modifications to present mappings in the
>> guest I/O page table should be followed with an IOTLB invalidation.
> 
> I've been looking at what the three HW's need for invalidation, it is
> a bit messy.. Here is my thinking. Please let me know if I got it right
> 
> What is the starting point of the guest memory walks:
>   Intel: Single Scalable Mode PASID table entry indexed by a RID & PASID
>   AMD: GCR3 table (a table of PASIDs) indexed by RID
>   ARM: CD table (a table of PASIDs) indexed by RID
> 
> What key does the physical HW use for invalidation:
>   Intel: Domain-ID (stored in hypervisor, per PASID), PASID
>   AMD: Domain-ID (stored in hypervisor, per RID), PASID
>   ARM: VMID (stored in hypervisor, per RID), ASID (stored in guest)
> 
> Why key does the VM use for invalidation:
>   Intel: vDomain-ID (per PASID), PASID
>   AMD: vDomain-ID (per RID), PASID
>   ARM: ASID
> 
> What is in a Nested domain:
>   Intel: A single IO page table refereed to by a PASID entry
>          Each vDomain-ID,PASID allocates a unique nesting domain
>   AMD: A GCR3 table pointer
>        Nesting domains are created for every unique GCR3 pointer.
>        vDomain-ID can possibly refer to multiple Nesting domains :(

Per section '2.2.6.3 Guest CR3 Table' in below spec, DTE has domainID,
and it points to a guest CR3 Table (it should be a set of guest CRs3)
which is indexed by PASID. So it looks like the PASID is per-DommainID.
HW should use domainID+PASID to tag the cache, otherwise there would be
cache conflict...

https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf

>   ARM: A CD table pointer
>        Nesting domains are created for every unique CD table top pointer.
> 
> How does the hypervisor compute it's cache tag:
>   Intel: Each time a nesting domain is attached to a (RID,PASID) the
>          hypervisor driver will try to find a (DID,PASID) that is
> 	already used by this domain, or allocate a new DID.
>   AMD: When creating the Nesting Domain the vDomain-ID should be passed
>        in. The hypervisor driver will allocate a unique pDomain-ID for
>        each vDomain-ID (hand wave). Several Nesting Domains will share
>        the same p/vDomain-ID.
>   ARM: The VMID is uniquely assigned to the Nesting Parent when it
>        is allocated, in some configurations it has to be shared with
>        KVM's VMID so allocating the Nesting Parent will require a KVM FD.
> 
> Will ATC be forwarded or synthesized:
>   Intel: The (vDomain-ID,PASID) is a unique nesting domain so
>          the hypervisor knows exactly which RIDs this nesting domain is
> 	linked to and can generate an ATC invalidation. Plan is to
> 	supress/discard the ATC invalidations from the VM and generate
> 	them in the hypervisor.
>   AMD: (vDomain-ID,PASID) is ambiguous, it can refer to multiple GCR3
>        tables. We know which maximal set of RIDs it represents, but not
>        the actual set. I expect AMD will forward the ATC invalidation
>        to avoid over invalidation.
>   ARM: ASID is ambiguous. We have no idea which Nesting Domain/CD table
>        the ASID is contained in. ARM must forward the ATC invalidation
>        from the guest.
> 
> What iommufd object should receive the IOTLB invalidation command list:
>   Intel: The Nesting domain. The command list has to be broken up per
>          (vDomain-ID,PASID) and that batch delivered to the single
> 	nesting domain. Kernel ignores vDomain-ID/PASID and just
> 	invalidates whatever the nesting domain is actually attached to

this is what we are doing in current series[1]. is it? Guest needs to
issue invalidation request with vDomain-ID and PASID (if it is enabled),
and affected pages for sure. But in hypervisor side, use vDomainID and
PASID info to figure out the target HWPT, then invoke a cache invalidation
on the HWPT with the invalidation range is enough. Kernel can figure out
what device/pasid this HWPT has been attached and invalidate the caches.

[1] 
https://lore.kernel.org/linux-iommu/20231117131816.24359-1-yi.l.liu@intel.com/

>   AMD: Any Nesting Domain in the vDomain-ID group. The command list has
>        to be broken up per (vDomain-ID). Kernel replaces
>        vDomain-ID with pDomain-ID from the nesting domain and executes
>        the invalidation.
>   ARM: The Nesting Parent domain. Kernel forces the VMID from the
>        Nesting Parent and executes the invalidation.
> 
> In all cases the VM issues an ATC invalidation with (vRID, PASID) as
> the tag. The VMM must translate vRID -> dev_id -> pRID
> 
> For a pure SW flow the vRID can be mapped to the dev_id and the ATC
> invalidation delivered to the device object (eg IOMMUFD_DEV_INVALIDATE)
> 
> Finally, we have the HW driven invalidation DMA queues that can be
> directly assigned to the guest. AMD and SMMUv3+vCMDQ support this. In
> this case the HW is directly processing invalidation commands without
> a hypervisor trap.
> 
> To make this work the iommu needs to be programmed with:
>   AMD: A vDomain-ID -> pDomain-ID table
>        A vRID -> pRID table
>        This is all bound to some "virtual function"
>   ARM: A vRID -> pRID table
>        The vCMDQ is bound to a VM_ID, so to the Nesting Parent
> 
> For AMD, as above, I suggest the vDomain-ID be passed when creating
> the nesting domain.
> 
> The AMD "virtual function".. It is probably best to create a new iommufd
> object for this and it can be passed in to a few places
> 
> The vRID->pRID table should be some mostly common
> IOMMUFD_DEV_ASSIGN_VIRTUAL_ID. AMD will need to pass in the virtual
> function ID and ARM will need to pass in the Nesting Parent ID.
> 
> For the HW path some function will create the command queue and
> DMA/mmap it. Taking in the virtual function/nesting parent as the
> handle to associate it with.
> 
> For a SW path:
>   AMD: All invalidations can be delivered to the virtual function
>        and the kernel can use the vDomainID/vRID tables to translate
>        them fully
>   ARM: All invalidations can be delivered to the nesting parent
> 
> In many ways the nesting parent/virtual function are very similar
> things. Perhaps ARM should also create a virtual function object which
> is just welded to the nesting parent for API consistency.
> 
> So.. In short.. Invalidation is a PITA. The idea is the same but
> annoying little details interfere with actually having a compltely
> common API here. IMHO the uAPI in this series is fine. It will support
> Intel invalidation and non-ATC invalidation on AMD/ARM. It should be
> setup to allow that the target domain object can be any HWPT.

This HWPT is still nested domain. Is it? But it can represent a guest I/O
page table (VT-d), guest CD table (ARM), guest CR3 Table (AMD, it seems to
be a set of guest CR3 table pointers). May ARM and AMD guys keep me honest
here.

The Intel guest I/O page table case may be the simplest as userspace only
needs to provide the HWPT ID and the affected ranges for invalidating. As
mentioned above, kernel will find out the attached device/pasid and
invalidating cache with the device/pasid. For ARM and AMD case, extra
information is needed. Am I getting you correct?

> 
> ARM will be able to do IOTLB invalidation using this API.
> 
> IOMMUFD_DEV_INVALIDATE should be introduced with the same design as
> HWPT invalidate. This would be used for AMD/ARM's ATC invalidation
> (and just force the stream ID, userspace must direct the vRID to the
> correct dev_id).
> 
> Then in yet another series we can tackle the entire "virtual function"
> vRID/pRID translation stuff when the mmapable queue thing is
> introduced.
> 
> Thus next steps:
>   - Respin this and lets focus on Intel only (this will be tough for
>     the holidays, but if it is available I will try)

I've respinned the iommufd cache invalidation part with the change to
report error_code/error_data per invalidation entry. yet still busy on
making Intel VTd part to report the error_code. Besides, I didn't see
other respin needed for Intel VT-d invalidation. If I missed thing, please
do let me know.:)

>   - Get an ARM patch that just does IOTLB invalidation and add it to my
>     part 3
>   - Start working on IOMMUFD_DEV_INVALIDATE along with an ARM
>     implementation of it
>   - Reorganize the AMD RFC broadly along these lines and lets see it
>     freshened up in the next months as well. I would like to see the
>     AMD support structured to implement the SW paths in first steps and
>     later add in the "virtual function" acceleration stuff. The latter
>     is going to be complex.
>   
> Jason

-- 
Regards,
Yi Liu

