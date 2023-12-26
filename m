Return-Path: <linux-kselftest+bounces-2424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB6A81E4B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 04:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8384B1F22562
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 03:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82692171DD;
	Tue, 26 Dec 2023 03:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hR3QYlGj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586E8107A6;
	Tue, 26 Dec 2023 03:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703561583; x=1735097583;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S48KkEV3YNefCI06HpnnxTYLppFP9Eg/6cJuFaOv7f0=;
  b=hR3QYlGjOkHQR7qXLE3UYyLt4pXL2r/68BcLjXkri6Ee4j+q4wvw0nDI
   ze0j2U0iyYPiHwSfs1WJrYCtUVeJ0nul8TMvjmYwJl0pM8rwdgvreCW8+
   QVr6o8RukMnjYBBYzZGpN11gj5KL9qhSdInQYqfjVNo20J3diDzOAI4yr
   7u2yHmnBq06K8e9QcEt1TirL6SuUSxuQ+/5YkzE1BeN53u6jFD12dG4x+
   MTxYD3TRuA5ZwUaC8fUeOKLmG9P9iVTA7dhKpXpurlmJxzb0tFPg6KP/3
   St8P7EppjuvZG1CC9BQcwx86KR7ZZZu39POO5xIIN+BMQwvDL0c4zatzO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="395209406"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="395209406"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 19:33:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="1025026931"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="1025026931"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Dec 2023 19:33:01 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 19:33:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 19:33:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Dec 2023 19:33:00 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Dec 2023 19:32:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYsj0QNthIaiC3eCex38/v7UK4TsNXrZgTVVu6ucNgOd6IyMuHfCoOoDoaCLzeOoQdDZTVv3164Rz379JeLm+FYdGPgQ2hu3w8V03BK46uSzhfz1kv7naLdWjSUnlRz1bl0t6t1DfhTNmgjPLOTSEOfqXXanF21o2OdhW9mDqKL5XMyd7JfnCI+8Evo72PI5YGqXakT8w+3shUNK0RosFVQze7/JpWvJlnvfpYSWE3lZ8fvFs19Bhy8ruBmipbfbO/boQQhUMjvO6uc75Xjp8FEVY0utMh2NicoL4hVqKpEX7XQwy87Tuo5XQqUtDvxzqUc49aEGrzYH2VpBSfzAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3HDIPZB+zyHzc41NRmHdkmLyXHm+wsaLTpuo8GZljk=;
 b=OxIU4nyq0sTues+eKDBKFKQzzpG0KvT0jnXa6QOknvJb92cDwj9RwyYL9dS2DIISqKyq3OvLp39TDt5OgUDGPQoaC/Y23vtnilJigbGYV5zkEQrAANURNjIURjRaeqwAopja5Tg+zEe5F63OD/R2MgqPhSzoDsvw/vIIQTzWn/T4GXMBD0HLkF7MdAYblBzCnjUZEkBvj1lfouCvxim8rTIH6ibPVISpoZbSe+/YbOyUxdAb7kaYe6NNBooE3LHGDI+FZcLQbE3zIVTBQlrp844WB6gvmdisv3dTZT3yj8SgWUa/2k7ic5SfXxJ/Rhmcz5aYxHiooH88VtzEhiiXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH3PR11MB8517.namprd11.prod.outlook.com (2603:10b6:610:1ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Tue, 26 Dec
 2023 03:32:57 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%5]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 03:32:57 +0000
Message-ID: <351d4ede-9a45-4f2f-af41-b08f5bd5b673@intel.com>
Date: Tue, 26 Dec 2023 11:35:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] iommufd/selftest: Add
 mock_domain_cache_invalidate_user support
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
 <20231221153948.119007-5-yi.l.liu@intel.com>
 <BN9PR11MB527659B1FD68C7FADEBD04548C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB527659B1FD68C7FADEBD04548C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH3PR11MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6a1903-7e3a-4ca0-a957-08dc05c359f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1tEnHUsy4VIVTAYZOHoNOnVhbq09zgyfnoZtSVEdMf/cn+Ga+xG9yPrxfo46Y6A67vmOf6SMqPYvs1BMKHxp+Kx2DggjqvL9iQg5BG9SSmNmtudckWSD1g1r53TwZqC+rBlSzuRLFFWPO2fOvvLOjGtLpyXIg7fzl2m24FmO8gHKwLkjWvUKfCtOhtxY60mfpQyWLveIgYSC8IcZTH6ZLv8KhhvfBn8FB1fZ9vq4NYpOLC9k87p6z3aaRQce/0GrcPOkWJGva2kiwTlXKmjTk45JyoTmK+NHH/b/i+E5tf+aByjtfzcPTMWcHu+02etM8W9ckLgKnXEznj2LwTBXtFLVbecFey+gNv8dfxXNSfh7cs+kKrEE/dksZOP384gT41KbLPsDxZDgNV1B5tuiuV/DM7HWJ8Vo6edFXEJWyslhK73Rq2yNRekq8hru//3yeqm7k1P/+XcoqHmJT6u7eDfJfzBwF4SHb2sYnVacrbpvHae4j71awPXNxANtYYVS1O82+o08zFWDyzkPovx/WrJfA6rHJfg3LyoKQNu18HlXM/rvAiQDFuh4zBe7mliaGtA1U/v/kPYTHRwbVX058qk5Y8fzSOprx7UvKUXOTFPbI/gZzA4YGyrZ85bQIEweWXnPLlFqx+LmnXPuG54nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(36756003)(82960400001)(38100700002)(41300700001)(83380400001)(31686004)(66556008)(66946007)(66476007)(316002)(4326008)(110136005)(54906003)(8936002)(8676002)(2616005)(5660300002)(6486002)(4744005)(2906002)(7416002)(53546011)(86362001)(31696002)(6666004)(26005)(6512007)(6506007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGFpNzVLaEtnQXhyb0JaYXJIQ0ZOOHc3UzRaMDJJUnNBQVpwZkFxL1M4UzZZ?=
 =?utf-8?B?N3ZRR3VCWWtBZ2ROK3doUUs2UXExSTE2RE9uUW9Wb2lkdThRcWZaNmxnQ0hl?=
 =?utf-8?B?WGRPcXNkalhab1BVR1EwWnl2eXF5T3h5a3V5RG1GUFhRZlFUM0pyMTJQSGZn?=
 =?utf-8?B?c3pXVDFzQ0IxMUkyVkx4a1dwMnA3QUFta05XeXoyQnI5Wi9qV0NrYXNGTTBU?=
 =?utf-8?B?eGdVV2R1RjFCK1BmRWlVU0lvSGpLUm9uMzhEdjlEVjNCa3ZTOVNIYnZwWXFM?=
 =?utf-8?B?UWoxdmxySExQa016QjdhT002bjBsem5QbWxxMXZ6TWxoMmRLdkZrazI5a1B2?=
 =?utf-8?B?MDg4SWsyejA3NWRyZ2lPSVZ2eWprdWtSRzYvZGw3Ri9oSGpEcmQ1UHdpb1VI?=
 =?utf-8?B?NzFhTmJnRFh0SzZPSTVQUkFlQjVFTjZJekZMT2JuZ0hzdHRDK3JNRlB3emxB?=
 =?utf-8?B?RkxzSysxNjV2MEdxaDJ1TElIVDlDTE1rbmxHbDRjeHJpY0U0dG11MUdwR210?=
 =?utf-8?B?U2l2ZzdPdU44emJSQmZ2SjdsVC8vZ3lOTzVYUTJmeFdZZ2pPOTJJZjZhUWdX?=
 =?utf-8?B?cGFPR014S0tmNjkyaFRTUXdyRFpPWFk1dnc2Wnppb1dXNHlwM3hhdWdmbklw?=
 =?utf-8?B?OUEzWnFiVE1MQzhxZUJLVVI0TmJ5ZzZ5SW1nRERHZGVOTm55UndwYndmNGhJ?=
 =?utf-8?B?ZWE1N2JrMkZuU1ltVE5jTEZNVFlLeHlZcG5nOU9JTmJlemEwdmxhWTE3U3VE?=
 =?utf-8?B?OXovalFQSlpDeEdWdithTzhLMkpaQ2hiL3o4bkFBQmF3TitBdHF0LzhNY3Vi?=
 =?utf-8?B?RzJOeXBaUUZUNUNzSUE4MURDWnNYcjYrMUJvNXBHMGEvUk5VVXcvTzBIZURI?=
 =?utf-8?B?RDNkWm5WMWlqY0gxTys1ZGxCUUE4TUxQNkZkZi9VMFNRU0tFME5xbWtqZGt3?=
 =?utf-8?B?NHVST1VKRmVyVEtYeWMzODQ4R3pFbHNkS0JyZ0JWdVdWcC8yYS8xQ0FhNEhK?=
 =?utf-8?B?VUtMb05MM3FTWGFnbElXVVM1MG5iN291MmdHb1VnVm00OFdzVEt0ZWtWUFVu?=
 =?utf-8?B?cHVWdGl0ZE85N25RbklxdnZIczBEa3c1eDl6OWJNVW9hNk1DRUhTdVFVY0Iz?=
 =?utf-8?B?enJSS1NLVkxOYURyeTh5Q3lXc1VRWmN3KzRMUzFHR1BOUndYMGlzWTRRdmNw?=
 =?utf-8?B?SU5wK25TQ01yd3Bkd3h5a2JyaGVRbEdEMjd1YTZ2SU9yWHkyUnIwYzlmSG90?=
 =?utf-8?B?dUx4cTJBZGlyWkUrU0tRcDNJczRyNTJjWDFUdFlra0NuN3d6d2pvWDVzZVBv?=
 =?utf-8?B?V2Q0RktCbzhRR09KRWt4eFd2bHE4R1ZZTFhmVjFzVlN5SldXcDMzcGE0TnpY?=
 =?utf-8?B?TVdWUHpodWNnNlI5RW5vRDZYaUVwdGU3bmRLMk1Oa3lNekhBVnlhdnFlWTQ5?=
 =?utf-8?B?cHZQZUVqbzRzSUo4bTFILzBZSWtaQmE1VmtVRXF5eFk3NWZLb1RnYW5PV3ZU?=
 =?utf-8?B?MG9TMDV3RXBwa00zV2hnbEh4Rlo2L0MxNUFGUjNneHNxN1NJV1dxZ1p2eFBX?=
 =?utf-8?B?MTNuUDZaWHZJN0ZKV1owTWJzc3J6V0U3aXp6VkplODZLRkh4ZTd3Z2plWDIr?=
 =?utf-8?B?UGdwUElQZGxWeGhZOVpGdklvdUIwcmd5ZGpNOURzTkh0MzF1OUJsaktxT3RF?=
 =?utf-8?B?ZWU4dmJrcG0ybTNRSzM2anYwWWQ3YWtsVDFsRVVlOEhNQWFQcEMzS0RkNjhC?=
 =?utf-8?B?ZEpGd0VBcVJTekpYeE82NURkMkFaMWs0UFlDRi9IMTJPU0tBdkZ1UGR1YVZP?=
 =?utf-8?B?VkJBRUxOZnpORlhVaVI3OWs3QXdlU1VVNEIranZHbXBjUW40ZmlQb3JFeHZv?=
 =?utf-8?B?NllwZHVjcGk5TnRRdUgvcS9hMDdYRGNIVUpKdzlaUUVobUtyQkE2Z3p6N0dh?=
 =?utf-8?B?Y3hLdzVCQjZKTFVPNExzWXoxd2pYU0diSmpDMHovVDlsUENsdkRlT1ZlanBC?=
 =?utf-8?B?NkwrWForMGhWRmZsSWJYSzVjRis3MHJJZyt0bURyeVlMWEdXR2Q0aWhKQXN0?=
 =?utf-8?B?N3ZNZkdMRUpEUEF3S1d5SENmMUYxL1Z2K2w4cGIwSjQyNS9jUzdUV2F2bmZt?=
 =?utf-8?Q?MoqQFrOV4Fokwsjg0rux3LRfu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6a1903-7e3a-4ca0-a957-08dc05c359f5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 03:32:57.3583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cthQRx6+RTUXlkxA9AUoN+eXQ/Ezws+U6qxhhL3kfbAQfeqd77pzQrqDJNP8bJrPubaVB1dM5YIdz2zx22GtRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8517
X-OriginatorOrg: intel.com



On 2023/12/22 11:39, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, December 21, 2023 11:40 PM
>> +
>> +
>> +		if ((inv.flags & IOMMU_TEST_INVALIDATE_FLAG_ALL) &&
>> +		    (inv.flags &
>> IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR)) {
>> +			rc = -EINVAL;
>> +			break;
>> +		}
>> +
> 
> a  nit. is there a reason why the two flags can not be set together?
> 
> in concept a mock iommu error could occur in either invalidate-one
> or invalidate-all.

I see. I'm ok to relax this check and remove the selftest case as well.

> otherwise,
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

-- 
Regards,
Yi Liu

