Return-Path: <linux-kselftest+bounces-17942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DDE977FB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 14:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3143128D38D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 12:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDAB1DA118;
	Fri, 13 Sep 2024 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZxTMk4/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C861C32E4
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229851; cv=fail; b=ti3GOjhRPRuGbfMLNgrtsjaXCnJOqCPG4/iVljch4Nd9mKpGtfxgdCQKTUBbKfgZdp+eHhG8g/ysuduQf9Qc/w7mKfVWO/voBilRWAWI4ijWcDr5PrFHY9HmjQfXWPtLRYrU29Ubwu+K4S4XciuJ1C1kkVPcLJEQhLHFNkFW/l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229851; c=relaxed/simple;
	bh=AoWJaZj/LnEKQYYEUkKoGnalUEf3gvwqe+EtCajCDV8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b2J9256LJv6KQXha1XYDVwzv38ATUEyWROf1LZCjWD8hVH2s5C2nELvi3l7T7mky6AkXarrFmebo8T5/6l+fJc8WXXzIHFyF/hfs0I00wbUzKeM23AUGrJLhtGjuLRXi3ylH+Aran79iE8BsBtJe7B5rP8o05dsuMCpLbMY1ef0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZxTMk4/; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726229850; x=1757765850;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AoWJaZj/LnEKQYYEUkKoGnalUEf3gvwqe+EtCajCDV8=;
  b=eZxTMk4/vge45jbHtkw0mlK77A9qS6enHbynTgWeR01bnr/HaVLmAYUc
   jlT26w3AcWsA2kUqp5sQiDMOcn54b95NxZr3k3WT9rK/Wsba+vgL2e0//
   pllj+0XjErdJnHhFndSlKTHgbRK/pU8ZLEQEipphtjb58vw/ltWjDChCZ
   Lp1FysLaFUYLu55PwObIz+nMwGnPpfExyyJR6jkO1VFNiFKQyODfxZM6T
   rpD5TJ31VjJLgV4wcSF1UGW/iLxw+F3SRepLoRijjivKCbHOh03q3IAes
   8sSOSC3GyvUsQkdu7PLWVpOl7HA77E9CqslPps7HnEXYy9E1o0fONmywb
   g==;
X-CSE-ConnectionGUID: u/fKCpykQ4Sm5Jidvg044g==
X-CSE-MsgGUID: kveLAUZdQXKqfCH0fCo7GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35793885"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="35793885"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 05:17:29 -0700
X-CSE-ConnectionGUID: FL66cYSMQxGaf74Uu1GZ7A==
X-CSE-MsgGUID: 5AVaNQhqR+OzWkd7VGTahg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="72141053"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 05:17:29 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 05:17:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 05:17:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 05:17:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPyjJoVX6ApCeILe5IvtpGDoxplAW8eWOUdYx2bcJp+y9jNYKn2twbOueRJXrRRkGcEZOnQKR+A+XrR5RrotrrctBZfYzzf5stKGzUskCdXG7ZUBB/ZwGMyEtdoQjrl+9REvh6bB2zsiCRNwpoCtBaZCXCtahQJwxa7wah/NLksjU4n7I1nCh5D1zec8fdQMEx3mF5WTwP4P1geNAdjT7A42DSRlvxCchtOM9O44ilODRJL3msMQAc72GHi5NQ7bjNzqjjcwO8ussFQBPXaQQeZn/1B36jl0yx64PjmBtBVAAP4uXuyPDAOFrkStGdAOSNva2xPDTaH01k184POuMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=175v/F326QNNs3SeRUzBd2gfN2WHwL3r6GWVg21Ws3E=;
 b=VAQ7MN3MdM9w/0C1KoOBftSX3TCI/adkmculTyFLwAWTSQphQr0ObAJWXkYasJio8sLUiQfKVzP2G9sdfnbWLIc5DiYK4rhVkDNAkIRA0Dz4mE/oxIn3x9+lV3su8AL9qO+BNy6vZktZluywwwU0OQJpAGjuutaaZ5nEudNIL2eiBh570Ou3SGwqgq+l/qxTBCfQbIAdrsdQb3bZzzmGI2obShBmx+qk0L/RsMKhASvGoyQ2ShslI0CPasGdQDHCL+RVAt15jrd14RE/fOeuy0od5lSg9mzPKrLqcRSbA4S58nMLaa6eeOJrwnOS72Nj0yICXgC82BBU8r0Q7dqmyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB7154.namprd11.prod.outlook.com (2603:10b6:a03:48d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Fri, 13 Sep
 2024 12:17:26 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 12:17:26 +0000
Message-ID: <69398a64-6c2a-40a0-a088-5fdde956f9da@intel.com>
Date: Fri, 13 Sep 2024 20:21:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] iommu/vt-d: Make intel_iommu_set_dev_pasid() to
 handle domain replacement
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
	<nicolinc@nvidia.com>, <chao.p.peng@linux.intel.com>,
	<iommu@lists.linux.dev>, <zhenzhong.duan@intel.com>,
	<linux-kselftest@vger.kernel.org>, <vasant.hegde@amd.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-4-yi.l.liu@intel.com>
 <08e6739e-762f-4552-adbe-52259747c813@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <08e6739e-762f-4552-adbe-52259747c813@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::36)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: 577ceaa5-4063-4f6e-9614-08dcd3ee0783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QStTVW9sN3FhVnZ0YUVMNU1mZVhTU09WTE9iME8wMC9jUTA1UnFxcVM0Y1JQ?=
 =?utf-8?B?b1NtSUxVS3dCSzZXbDhrL3g2aGRBQmNwRk1FUXAxKzBOR2l3WVcrQkZuQjAz?=
 =?utf-8?B?UzV2ZFNwZzhJQy8vbDJFTDJ2amdkVUh3KzdUWVNIWFdTRWlmbStleGM0eGpO?=
 =?utf-8?B?WVYrRDBQbzNuaFAvL3Z2U1VFQWt6a0dhOGFIV0hXZjJveUwwZVhLd3d4UVZM?=
 =?utf-8?B?Ry8zdXFWYzBObFRzMjlqVmpBMnpwblp6cTVuQ1VMOTF6NE9sUngreGMyOE5x?=
 =?utf-8?B?ZVhWM1pUZGcybUJyMlE2NUdPRC9VSzNLUEZaalBKRTJmMStIbFFOcjNEcDlE?=
 =?utf-8?B?cmlhMmQ4Z0IwdzhCOFhaUHFRTGljYW9wMFcrWDNoWWlYUmk5MmZUOGlXZTRR?=
 =?utf-8?B?cWZkV3J1UXBGN01ueHlGbTY4Y1NJRWdiZ3F1eENCOTVnTmJyS2xLSzM2SDJ4?=
 =?utf-8?B?aVJGNzNKREFRbk5VbWMrOVFxODBkcmFXYTIwT1AxUW02d3drNStvaXFoa1RR?=
 =?utf-8?B?Z2RHd1JzcFk1RkxONWFMbHpudGdOUDA0aC83QnFhRHpCRFI3ejJGbzhWZnJY?=
 =?utf-8?B?QVVmemZ1aVl3d3JQRHlrQU1rQ2MweVVKamJLemJpZDZCcGtuaDlGV2FncDln?=
 =?utf-8?B?aldLZmtySDdKVy9nZTdmazM5R2M2N3B5L0NpUDV4SEV3UGZ2NWJieHBLb2Yr?=
 =?utf-8?B?MU9ub1FFSXQ2ZDJDNzZzcGxxVm5IRjg1ckRNMDVMU3Vhb1pHYnRKUEhkb2NU?=
 =?utf-8?B?R21kSkQ4NVVDbEkyRDVJSVhoNTFSRmF1MG5oVy9rSGcwL1AxSTA5RTF3OGZl?=
 =?utf-8?B?RnJ3M28yMWZzcGlYZnRQbkNMVEZmaHBEclV1emgxRXNUTXZHRTF4UjRoSzhH?=
 =?utf-8?B?NzE4WnJOY0hLWWthNTNEb1lqWStrVmpvWXlheVlkWGhFd3hMOVk1VzYvNnlG?=
 =?utf-8?B?eUt5WjRJek4xaVlhU1J1WkcwSlZlSDhSK3pqTy9UOC9lb2RtVUZkZ2hqdFg3?=
 =?utf-8?B?WjVhRFkvUW8zOU1YdnorRVRUb2ROeWwyMkF2cEpoU0x4TFFxZ1pxcU5tL2ts?=
 =?utf-8?B?b0gwUVZPa3ZnYTBuRzRSZGlTQnM0cFZjK0hYbUwxK0cweVBRM3JmdGtJdjJq?=
 =?utf-8?B?UTI0elRDNmVsNTRvbGJqTEhWeUZrK2dndTB6UHQ2blBVaTE5d0Q1cmh0d2lx?=
 =?utf-8?B?OHNnL2VyYURQVHBPditHUktEUlF4UFhOdzRtTWRHaGl5TnFETW14Tk5yTlZC?=
 =?utf-8?B?NXZUR3hDb1hhRmdqbHZOZHpUWFcrSGdRZXgxMG1NOWtKdWdxTTk3SUN6blho?=
 =?utf-8?B?V1B3ODdjTWVtMnJ2TjJ4U1FYUmg1YStVSDN4dVQ4TTdiaVVwczNuRDY5L0tS?=
 =?utf-8?B?Ny9pdXJxMFA4Q3ZUWkV2eGl6OTBaa21XMnpPeHNuRWM5WnB0cXFQcWpsdjc0?=
 =?utf-8?B?TGU3NFhybDNmNEZjVUc1eUk3dVMrSFdRN2pFOFdpaWhuQndrWVFMc0M2Uk5a?=
 =?utf-8?B?YWpTbUhkZTdobkdkZkY2Wm1DUmhXVnBkenJTbm9oOHpuREJyV0xWdFJHRno2?=
 =?utf-8?B?Qk1qaXhlYjJpUk9Ca1h3V0xsdUVZUTA4RlhleGtPM3UrZVB1VGJ2MTV5MlpE?=
 =?utf-8?B?bjNVSTExMFVBaWY0OTdBT0JwckV5eHZaM3NCY3FVTkhCa0xjcDN2ZGV5TC9p?=
 =?utf-8?B?N0tRTGNMNGlJUUJwSnEzQkE2Uy9rSnEvZjUrcG5GTDBkczZpWC82ZnhGWklX?=
 =?utf-8?B?aVloYVBwMGI2d2lUMlFWckxxYTRNZVBPRGJVckRTQkkybGVmY0tINTBJNEJ0?=
 =?utf-8?B?Sjd2NE41K2pIdEppaUFvZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWN4WFNZbkN1cVhzRXcwZFFXWnQ4TWlLWS9QTUtUU2tZcmh3ZzVYYXBESVNw?=
 =?utf-8?B?ZDlMck42b3ZkNUJzZ05vZHR0YzFxZGJ5Y3cvazFaOVNIUFFyT3FiREV0bEV1?=
 =?utf-8?B?OXNhMGYwZHNjWm5LUHhtTW9sTkQvL1FXWmozZUJiOHcrZFZ1TFNZcVVHSU9n?=
 =?utf-8?B?WE1SZG5qZU1XRkJOcTU5WFZldUVrdVBaTWNIcWZOY3czY1pZWUc1b1VZZHpl?=
 =?utf-8?B?YWF6QnpaenZyNGNoaGdOVUlhbFJkYi9oZGhZZnA4SmhZeGRSVGtmekk3S0ZQ?=
 =?utf-8?B?NkFTdEc1UFlIdTY5STB5MkFPV1VWWUZxZEMyVnFwM3JEMmV2RC8zVm5iRHFG?=
 =?utf-8?B?bHBrcVdNblJUZ2lqZG9ZUWgvMDBobVJXcWdQRWM0YVRkTEpveGtJN2VvQ0dL?=
 =?utf-8?B?VUxJTEE3bnB6NjA4Z3BNR1NsNit5cGxkWGNIQUlQNnBoZTJwbkRQWHNIL0dy?=
 =?utf-8?B?U0FHOUtrWml6WEpNTEtVdEVNYk14U2NUS2tEL0d0MzMvejFDeDM4Tm1uSWNy?=
 =?utf-8?B?R2lVZmlkeXhUcWJBZVNXbXp1UmIwV1JtQ1FWUE5aMGVpMHdVZVh5T3c5Rm02?=
 =?utf-8?B?MTRYcGFyVkh6MDNTWGxkOUpMM1A3YXlaV0dvRnpXT1RCUURjSDA0NlRIazIz?=
 =?utf-8?B?RHlqM3JYTEFIVTVqeDlPWW5yek5WR09FMlFPY0twM0MwcTVBZ1RwQWc4a1la?=
 =?utf-8?B?S1IzQkxaV1J0QWhqejlWKzljVHhMalNIbU1lektsVkljbkh1SUpqcDBab2NW?=
 =?utf-8?B?dnRBdjdNTUxxSmhSNzBvUy9iQ0xiano2UXlXSGF0Z3FZVVlHY2pLTWNBZjlh?=
 =?utf-8?B?RklTYTFkMGFEVGxuQ0sybGc0T0ZmdGc1YlFyL0dubFBjZVFrUkdPZkZ2RWVn?=
 =?utf-8?B?eXQ4Tm9EWGQrK2IwcUNHaVNKcW9OU1MzN0FwZVFRaDFpdTRxWk0wUHNJd1Vz?=
 =?utf-8?B?ditBS2trVldHeE9XY1pDcnBsYWw2L2MzSHB4NndWTkh5WWIyYWtmclMxUU5N?=
 =?utf-8?B?U3RNejl4V2d0Nk9YRnltSnVMTzhLd2FnQjZITE14ZGR5YkE1Y2c2VFYvU0lW?=
 =?utf-8?B?eHFoVnAxUFVGVUNjdkJmeVBHU2sxNldrZTBUOStzZUZoQWtOZG1pTzRwdVBD?=
 =?utf-8?B?SHRRR3VhWGNMaC80Z0ZQUWxaZkNrU3RRY2hobEpqblFGY1pzSkc3VEwrMW4z?=
 =?utf-8?B?ZTlVUUppT0JtN2JYR0NrSGRsREJLbHZHemUxUzQxUVlBSGRUZGd3YVFDWExQ?=
 =?utf-8?B?RUZtWTR5OUtzR1J1Si84MG5sOUM4bVdpUWtCVkNmYitOdnFVRzFYcTRtZUV5?=
 =?utf-8?B?cnVEamc1Z1ZOaG16OENqVUVnK1hKdzZLT21oRjd3Tk10dGZKeGc5bFBwdzNS?=
 =?utf-8?B?S1RwS1pqV2hMQzNlUjd6VUVLM3J3aHVNR2xxQnd0MFN4UG1yaVJyYnBSSFRS?=
 =?utf-8?B?QytmZ1AwbXF6LzdQN1M2ajRWaGZrUTltRlc1T293bXJXVC95RGRTbDJYU3Jj?=
 =?utf-8?B?dkhJOThPTjJSVDNxb3FkTGRqZzBMY2RvNExHanFkcE03RFFVdWZxRytLL09P?=
 =?utf-8?B?d04zc0tkR2hucFZqekZURXZPYnNMVkpyNjltOTlZT3BYNHJYcXVPbFY0OUxx?=
 =?utf-8?B?TVpXSzNMUWRkRmRNWHNPU2xsMlFjNjJRbnlrQmJEeDhrMGxockNvemVCbmNy?=
 =?utf-8?B?U2hjbWQyOGZQZHZHQmp3a1BZbDNPM2xYa1I4MFhKWGdabEpWZFR6dWtSVnFZ?=
 =?utf-8?B?bjhSVitTNzFmZlhDNk5yNENsTmp5dnhOaUlvbEQ2ZDEyNTVqV0gwVlpodXNj?=
 =?utf-8?B?bktnOWQxcEU3UmlxQWI3ZllzajY3THJkWi91SExrbVhYaVpXTGl0YmZ2UXlX?=
 =?utf-8?B?czNqZ3lJZFh4VHd6N0tvOGZxbXRvem0vYVBoMDZUZjZuSityNlFqNUwvQjBt?=
 =?utf-8?B?MW5pZCtiUlFTUTlRdHR4QVJwdzdOaStKa0Z5RVZScmtqRVpSdnZ2YlFSTW0y?=
 =?utf-8?B?N2U4djBHdEVlUEY5Y2daSTdPQXF3NjhjcWJyaGE3MVFwekFKNUpQSTJDQS9F?=
 =?utf-8?B?SlR6MkJleEloOWZNQnMxaGNmQWd2NjkwWG83anlvQ3IvQ3RIR3FxVitGdkVy?=
 =?utf-8?Q?TDCxqzc5UT+z0iD+7rhWNhz5W?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 577ceaa5-4063-4f6e-9614-08dcd3ee0783
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 12:17:26.4533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAjUVO1wnQbq29AqVNz6kQdTV+aDJaj76/WLJk1wIQUr8kCCEDcxSx2Y0uRHz3UCd1k2DgBazB0JB1CgGAFzDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7154
X-OriginatorOrg: intel.com

On 2024/9/13 09:42, Baolu Lu wrote:
> On 9/12/24 9:04 PM, Yi Liu wrote:
>> @@ -4325,24 +4363,18 @@ static int intel_iommu_set_dev_pasid(struct 
>> iommu_domain *domain,
>>           ret = intel_pasid_setup_second_level(iommu, dmar_domain,
>>                                dev, pasid);
>>       if (ret)
>> -        goto out_unassign_tag;
>> +        goto out_undo_dev_pasid;
>> -    dev_pasid->dev = dev;
>> -    dev_pasid->pasid = pasid;
>> -    spin_lock_irqsave(&dmar_domain->lock, flags);
>> -    list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
>> -    spin_unlock_irqrestore(&dmar_domain->lock, flags);
>> +    if (old)
>> +        domain_remove_dev_pasid(old, dev, pasid);
>>       if (domain->type & __IOMMU_DOMAIN_PAGING)
>>           intel_iommu_debugfs_create_dev_pasid(dev_pasid);
>>       return 0;
>> -out_unassign_tag:
>> -    cache_tag_unassign_domain(dmar_domain, dev, pasid);
>> -out_detach_iommu:
>> -    domain_detach_iommu(dmar_domain, iommu);
>> -out_free:
>> -    kfree(dev_pasid);
>> +
>> +out_undo_dev_pasid:
>> +    domain_remove_dev_pasid(domain, dev, pasid);
>>       return ret;
>>   }
> 
> Do you need to re-install the old domain to the pasid entry in the
> failure path?

yes, but no. The old domain is still installed in the pasid entry
when the failure happened. :)

-- 
Regards,
Yi Liu

