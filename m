Return-Path: <linux-kselftest+bounces-6166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA31E8776E8
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Mar 2024 14:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BA12810EA
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Mar 2024 13:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55DE24B34;
	Sun, 10 Mar 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjoJH82g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1816FF29;
	Sun, 10 Mar 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710075766; cv=fail; b=GIWxxc5iJSzotGIY/RHhMXGt5nG6VQ2TS3Qjk9fhSxIxLhn4MbVY6MEEVQCgKjSzq1nhIlQfZRuHvxPbKB/+DfzhKGyf3pIFdya0HX+0bxBIZy9sW0MzcooAJeXhHRhFNEqABmmq/kQHdISrMd+P4ltbY4HgpxddKazXbXV4PZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710075766; c=relaxed/simple;
	bh=H7hGMugSbdXs7Xg7CXR8bZM6nXA03PEGiOKBaljG6jI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ifsZSYLA1HAHSBgwXk0a3fwVgHOCEOWZ+HWxi5i4RSRMxxndjfnXADRRjvixEz+pu/KLZch1oUoNGElxYTySHZ8SczdE0IcuABbiiLlMvgZAIQY4qp50vy3MamKiKPpned9WpnGxGUf6wChKeATT+OlJiDeNeV7h4wF7EjBP+tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjoJH82g; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710075765; x=1741611765;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H7hGMugSbdXs7Xg7CXR8bZM6nXA03PEGiOKBaljG6jI=;
  b=mjoJH82gLLy37cJAthEjPI51QY1NBs6SHzuSOBVl9YjQbdMLKXFMoBi5
   hbw5yKT6rGsIfZzVnAW8qwuTt9oRe+UsjAoxlYVEx/2VMtdBEXfsuNbeA
   czg7lli1ncns4VS8g935waKrUiHEddvDEJ+Cbw4uiZwqvHUUiR/voQIMI
   /8C2YwqRqgNt0ml3kIiYbqvkSGFw6za5/kjSNY7XNW22da1xrT7j/830e
   vwe+4jtA4NsGHDMgJI2RYH0pS+fbwnvf/sq4blRfI6p4w+iFKHAfXchyW
   Ps24JOW4baVQW4dvjpU7qFDEoK4wpIhTBMXjAgE8EuAFNqiANfxPQ9/cy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="8560222"
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="8560222"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 06:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="34054467"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Mar 2024 06:02:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Mar 2024 06:02:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Mar 2024 06:02:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Mar 2024 06:02:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Mar 2024 06:02:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHTZgx/BOZ70rPYbLdfv+jO1icaEVvtyrP0OxLDkaySX/XwSelINNOQfgLWOeygAUmSW5S0MdPBdZECmW0Wm1pSOWEdW0nLRtO07W61YgSZclYkmJABsx3813ToVnYo+RIFrT7Ri/0i9uv883OCEl8t5PTuXSAU3itv1jCKW8h8VNv/J2dHvlnGdMg9KD8B1MgPrZvYf6WaVRhbOYa6RXDeqZbxERfbkyHuik8YzPpmMxcBOemCFzhZJo5cdrdMf0prm4kj3rOESWeblmJ7cYvSH5aJ19qsyh7av/D2JP821Up3M/JsgGbHfvG20GMzjBGOC7GB298UyVs+7+N7MHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V642mXmE5xNWk6/pT6xOAdWtg0axiMEBmwwaUESC1K4=;
 b=Epq8CoZ82h1/Pb8r4gdItOdgyYULg/7KtBWe9eYe+OoEsMTAeGRU3GjRbESDl9xsE/ZcfLB1UfI3My4m/YpDkceNA7VNRc3DL2hWtE/NYYiGegYlQDMVXcSRnftwMsngj0UIkQ8Vp2lir6ii0HbBV8ksY2w72lneYLJSSG9UD6EXg3kREis/f0wh2z2bWuslt38zhmkPEpbya9F+oFi1AhEHahmWpnhSEmURQiSvbKepmqPG219K3617jrjZ+liSwyTwLo1CtL7wu5RXVMJvWRYTt/ZP/OpFh1fToPk8uFh+dLu7h02Ia+/lValbE+Z6Gj5/a6pvEzKOJ1dFerkjUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY8PR11MB7107.namprd11.prod.outlook.com (2603:10b6:930:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.15; Sun, 10 Mar
 2024 13:02:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c%3]) with mapi id 15.20.7386.013; Sun, 10 Mar 2024
 13:02:40 +0000
Message-ID: <c831bf5e-f623-402d-9347-8718987d1610@intel.com>
Date: Sun, 10 Mar 2024 21:05:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] iommu: Introduce a replace API for device pasid
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
	<robin.murphy@arm.com>, <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
	<eric.auger@redhat.com>, <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
	<mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
	<yi.y.sun@linux.intel.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-2-yi.l.liu@intel.com>
 <20240115171950.GL734935@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240115171950.GL734935@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY8PR11MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ce4173-23b8-4079-cf18-08dc41025d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3mdjpTYk7ERjdM9HDnzFmBhjyT+7m21Ral6At41HaanZom+dLNeHB4h/VIblMQ6CcapPC+PtfXqVdMkXoCF7/knmZj2zIUMlV9zwwdJNZxouhqv7TuU+0vamUbsmcK1k8DNuqnqQdoAx0UyvEFapxQvlZlurLS7YxlG+oVxCmOKE9K2BzIB1A3R8E42LBUsm3V7T5tWrc0Q9oR4MK5QXoMrahT3NbzP5qgmejbL4VKDxovJ3Pg8pWPydRPwRZq2fr5GVWlJeQmpX4dk3bV7VkJszapzdp9ziGHfcn1rDQ0GfWjH2wzaOntRcU3b+e4peCEuY/N8v76AMIvU+rl2uA6QiK4BonBy9Ys34c1fpiKZz00runTZKdSavBx1dgMLEl55a7VRDAdY9k6FfslHWaJf/z07/RzgR85E35LebAFNCEMNt/WEHDOVIIoxknhf+mxMelxY3DOC7L0tOysTDyFhXEaNa1aEPLaI5QfRWOaCYq9F8FuF7X4HWDfb7HxLhZz0zGZwbiEevmLN9cKT5yKlBY0D9TE0AD0EqSOrrb6oSL+Eg0ZpZzh7eEXkE7FLkNcsDwskTwkuIcz2jFw/UjpN+OdJWYocFwKnWR3HpfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUkyOHZINjZRQmsyQzJBQzVuZS9PWXJMNnRRbTVCYmExQy9DaVJ0SWd0UmRx?=
 =?utf-8?B?NnNuTDRKckdOYTRWbEVJSTZFbGpodU9OS3lyRzBhVjNaWEpPU2dqYUNnQVpi?=
 =?utf-8?B?NTZVVzZFKzdPdW9tLzV2SHpLN29BR2FJakFvNVk3LzYrWHdtLy9TNWdmekVB?=
 =?utf-8?B?YjgxVFpRcHdkb3lhajBKa01JZEUwTFdtNHRCS1FjdWxVVVdLT1J1SlRsWW5B?=
 =?utf-8?B?WnVwa2NMbzIzUnYzRXFqNkhTR1JCWlFUWHVPMno4T05tZGltdEFuc3QzS2Mv?=
 =?utf-8?B?bGQwQ21HQko3TkVxRFNRMmxxb3NaRU5sTnorSGZObHQvZEJZS2craE12Y2Mr?=
 =?utf-8?B?ZVh2ejRpYUltNW9WcGs3YVcvVDFtVnhUaVpXMlF3Y0p1dmQycHRLQ2ErQmd1?=
 =?utf-8?B?S0MzVjFJZm1HNEFXZHFmVnZGZmZjUTA5eHRPTE0zRm5BTGZUMnRMZmVoaU1X?=
 =?utf-8?B?eDdYOGZqZWNrQW5PZzdrMTExeS9ja3BFcUdqbkNRMkRMZ2V4TmtrQVBDV2dv?=
 =?utf-8?B?ekNZVDVQeFFSa3h5a0FQOVZRKzZhL0NQeUpFRWJWKzJTdzBPVXpnT2J5WXpp?=
 =?utf-8?B?THFWdW1sbHlyMzB3N2JLWis0THNxSXNNMy9aVjZPeUptRE85SEV2TllnVWh1?=
 =?utf-8?B?dWJwNkhGc0UyeStKMWRxSTVMbWNVcmYvbVk1eTVhVHAzY3JNUzRJdjNMUHND?=
 =?utf-8?B?dUtEdFZEVHRDSjJzQjU3NUZlMnd3K3NRL0l4aWM2L1ZDOHRVTkZiN2t2Wkdz?=
 =?utf-8?B?QVNJdzZEWTlKdkgyUDNYSUZXWjAxTzNmNkpvT0hwNlN6bGMwM3gwdGE0Q0ZN?=
 =?utf-8?B?UjJja0RtQUlIdkZWa1JCQ2tWcjhnT2xqOGJQOXVxeHZaOE9YcW5WcjZBTzE4?=
 =?utf-8?B?anZuV0tpOC9ha1VWM0paVW1ZejZhS3JRSlNxb2hiUEVxZm5YM0RrTGtMeE1r?=
 =?utf-8?B?UlBaSElrT1NHY09jTitENWl3MU51cE92YjUvamRhYWp0WmdveldZZ1VWdS9o?=
 =?utf-8?B?bWRzVXh2YjJXdlBGdU9BZVpJYkZUbkNDcjd0TXN0MVEzZ1o4THhKbDVZaFBP?=
 =?utf-8?B?MkRzTXQ1aXhFQnNEVkJaOENTS3UvVkNQN2hvV3pZWlMwdG9yK2tPREJqZUNh?=
 =?utf-8?B?NDdPdVRKaUdJazRjckNOc01jY3RROVhoZHByZWJSaXM2bHU2ZjU1VXIxVE8w?=
 =?utf-8?B?SXlVZWtJaE5KaW5WM2tGMlpHb2RlOU9ucDhWbFNLUnRua1AwYlZuSVB2RnA4?=
 =?utf-8?B?Z3E5UzE0TnhNTHdtTnR5ZURGdGtnN20wajRNUWxEZUlMSVRNemJRNExwYndJ?=
 =?utf-8?B?UU1lTXo4cUgvZmNWajRGTEN3TnE2Q3FXS3ZBeEhSMjVBVGZJcFp2NGt2WlNz?=
 =?utf-8?B?UndzZWJZOUNVblIwZkJlQzA1RTRPY2l3MXFFbGtQc2lubzY4cXJGWk0zRkRY?=
 =?utf-8?B?eEFvdTR3OC9kL2wxTXBHWDBnNEVyVDY2R3JWajVQTVA1cGJLR3NaZW0zRnZo?=
 =?utf-8?B?QkhoVVJTVHQvbk14WlJ0OXpBRUVtQ3BZU04yZG04azRnWE5XWmVRVlZxempm?=
 =?utf-8?B?dkRCRWhMbXdTZjd4OHZKOEo2a0srMXlQODRZelRhSkphbzc5KzhkVUZlN3pF?=
 =?utf-8?B?NEhJOXFzNFRhK28xN2NCUHJtWGYxbWdMNDl1MGFMSm5KRzkxRWo0M2w4aXQy?=
 =?utf-8?B?d04xbjZieUNCU2lrL0JkbWwwODFGWlExSW5QS285Zy9JOWVockVsRlBuL3dZ?=
 =?utf-8?B?RVZPMzl1Tmk4SC85bWRGR21UMFRqSVVheVZLYWw1SnB5ZHhsWEhOV2Vqc1pE?=
 =?utf-8?B?V2NPMWxLZFpjbVJTdDJSbVc4RVRkWC9ZeUFnNUtJQ28zTG5DZG5ERjZ1Tm53?=
 =?utf-8?B?aEJVWktXRzFZbDdWYU1ueDdxNVE4SlE3YmZrc1NrcTkvTUhnZGhIbUpkaFhN?=
 =?utf-8?B?WDQxTEswMzBuQjdER3hFcG1MY1FyRnhaRldCOUwzSS9uNHN5bktJYWpsWHIy?=
 =?utf-8?B?QjNNaU5vVXg4bUhGdEsycStLNTU1WWlzUVU1OGpuTTZ4UnduYmxramRFTlYw?=
 =?utf-8?B?NGovYkhMcnRLL29mZ3RaMXluNCtBeTdFTGc4WndJTFM4NGtlaW1lWVpLTUJY?=
 =?utf-8?Q?oSa0a5LZwmSe5bDqzQDpWaJY3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ce4173-23b8-4079-cf18-08dc41025d67
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 13:02:39.6101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqwJAyOr6aWAqe60TYEU9+39XHpcu1batpo8MaGU9TIi4monK8anywH4/YJUH92ZQRxqZryavsLloGIAQCJWgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7107
X-OriginatorOrg: intel.com

On 2024/1/16 01:19, Jason Gunthorpe wrote:
> On Sun, Nov 26, 2023 at 10:34:21PM -0800, Yi Liu wrote:
>> +int iommu_replace_device_pasid(struct iommu_domain *domain,
>> +			       struct device *dev, ioasid_t pasid)
>> +{
>> +	struct iommu_group *group = dev->iommu_group;
>> +	struct iommu_domain *old_domain;
>> +	int ret;
>> +
>> +	if (!domain)
>> +		return -EINVAL;
>> +
>> +	if (!group)
>> +		return -ENODEV;
>> +
>> +	mutex_lock(&group->mutex);
>> +	__iommu_remove_group_pasid(group, pasid);
> 
> It is not replace if you do remove first.
> 
> Replace must just call set_dev_pasid and nothing much else..

Seems uneasy to do it so far. The VT-d driver needs to get the old domain
first in order to do replacement. However, VT-d driver does not track the
attached domains of pasids. It gets domain of a pasid
by iommu_get_domain_for_dev_pasid(). Like intel_iommu_remove_dev_pasid)
in link [1]. While the iommu layer exchanges the domain in the
group->pasid_array before calling into VT-d driver. So when calling into
VT-d driver, the domain got by iommu_get_domain_for_dev_pasid() is already
the new domain. To solve it, we may need to let VT-d driver have its
own tracking on the domains. How about your thoughts? @Jason, @Kevin, @Baoplu?

[1] 
https://github.com/torvalds/linux/blob/master/drivers/iommu/intel/iommu.c#L4621C19-L4621C20

-- 
Regards,
Yi Liu

