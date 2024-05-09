Return-Path: <linux-kselftest+bounces-9902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FCE8C1824
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 23:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED902283574
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 21:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0BA8564E;
	Thu,  9 May 2024 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvJoCnb7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5446984E05;
	Thu,  9 May 2024 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289122; cv=fail; b=TFkDWeHz4K+Pc/Axlehgt36+OguVRipTIYzoBC4uhGr+r1aOrLZ7lG2P9QDOpLIpzwYu3D2RyhHLyQHZP/O6TKePdKXnbIIvbGf3bFdogd3raEM+3CKElXlIFdMpqZ7whvi3TnuxVm7gLstGsO8EcLvwO/HjKQ2xLXwba4Xospw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289122; c=relaxed/simple;
	bh=ywuOvghb9F/6CKk1BW3GbkLqJZzEyBQTLUJD9VS/2K8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a5gMC1/TuhiWcqi9d+kTgM0vvU4b/y0+mWgDsqI0AdbAUmxu28sNj00jMFU5j6+p9M0ibWA3ne6L1BQaPvtwuaW1KhPghjLD8KzAmIwjm/jg/JtgDeIEFobwcMX9pmNPVj2GkOgWT2tsGR7MTFMX8/HAGYadQo68JHQkaNF2EGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvJoCnb7; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715289121; x=1746825121;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ywuOvghb9F/6CKk1BW3GbkLqJZzEyBQTLUJD9VS/2K8=;
  b=VvJoCnb781GvjP5fcPtZopYXpQJfbv5T4QlhSSk9OjixJ7WCZxPJ208o
   Icp95BMMDUa2PzyUPHmTSTMS7RGCTQ9Uf6+jqo32XXLQr3UVcHsNceO45
   Mmyf7GXhKtobdL86wgGvgvORFRo/7FDlAMLyMxJT8v9n1AfkrJkS4QWvC
   YDDHcR3PyuNZuk4UwsNZwAXK5F91dDhOPnNxLOiAc+m2ZIhv7SumH0R4O
   49dBaMGlR4Pm3ut2D4mg2vIOeGONTEp7VkmJly08N2kp+VTJcCMecGoBR
   ZztEl1lUneEQxgXPpVJT8Y7Nsi7aJfiM+UxBxUv+XhANPVA8bLnhMhPhJ
   w==;
X-CSE-ConnectionGUID: Cnua0Z+HQ0ae9NyKBxAgRQ==
X-CSE-MsgGUID: +L46U6DGR6K4HnzuT8evlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="14192930"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="14192930"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 14:12:01 -0700
X-CSE-ConnectionGUID: GoxRoT9+QPubQaczFtsY6g==
X-CSE-MsgGUID: cP/IyOoqRNajBGZG1xVfzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="29241498"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 14:12:00 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 14:12:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 14:12:00 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 14:12:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPmncAV3PnhDBUx3DkvdujTAlnrK6pUD9VbHI6tRGe8B9Z+voc4oCuBZ7egaR7Q75NYcvWqDj8UAmOTPs9WM7yTSG3h9wUKomM6S0SM2NYnyzcAxfcwlUQ5+qlQuadyhDbKLvoLRChuEiGMqsSS7z1CnzskrDzRwqksGYEfnbyPMQ4cdeh/MRxWPXS6EQy66gpR391evNxMBV7g4GJZCGWXd1OeRqpmBLdtAuLVor+e8gu1hsy2MFlDLBpMc1DozLgUl6/+Dm3Q03Rcz48pjlj2JIJMn2QFWEzqkMcBLDEb3uVJ99fl8AwNvjYT9n7SZdGlwKYwkKo/KNBuXx6DEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEQpnWb3lZmGLuz5iAOd3Fu9y3FkRllm1Xb0ySslvFY=;
 b=n4j+x01IiiBX98mXVyYvgSzmMQvmkDMHxMNeyfwJGhqtRfAqNETn52MsZfIlviNRx7wtoayAhk/Uo5AZD6hwvXpn+fYvOyKXl5ws4Zy2ZdHukRHNtXGk00ve1mDTqSAxROJGBlcAtI9XaM01QSaRH1w9ch0ABPVeUjznpE58r29ZA0DWXgAIcUTafU7FDpEiujyedQZR7eujmwcqWKJMtYkRJ3koLoZxdS9390qnAOYd/COO+IrNJqF6FG+TDjV2o54y04K0sbejzAUThUXYUeRoOcGtyloOeST+s/sUn6Emu0rSdBqzZrOQ8//trf/0rXpmHx54TQuWMmaYo5ux5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BY1PR11MB8008.namprd11.prod.outlook.com (2603:10b6:a03:534::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Thu, 9 May
 2024 21:11:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 21:11:57 +0000
Message-ID: <b5b081a1-9e80-4173-8449-36d5c93185a6@intel.com>
Date: Thu, 9 May 2024 14:11:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Enable MBA/MBA tests on AMD
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Babu Moger
	<babu.moger@amd.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1708637563.git.babu.moger@amd.com>
 <cover.1714073751.git.babu.moger@amd.com>
 <e3bf1fbbe3ab2d9c2dc1d9669a791de140dea248.1714073751.git.babu.moger@amd.com>
 <911547f7-e952-f771-867a-57c1de738c39@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <911547f7-e952-f771-867a-57c1de738c39@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0141.namprd04.prod.outlook.com
 (2603:10b6:303:84::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BY1PR11MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 484bd863-eb3b-40a3-79e4-08dc706ca8f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STFEaG40OGh1VFBSUjU5NFVWeFoveVllS3NZR1EzTGhRN3RmaG10SitNdkgv?=
 =?utf-8?B?bHFCRUNSWG5LM2k0QW5iTDdnYkJKYTY4K0dvMEZFYTJuVkVyNnowamxxUDR5?=
 =?utf-8?B?bHlMYmMwQi80dGp0MGRwRXprSStZd2RTQkFsc0pWQzBEeUM0N1hKVTNheE9I?=
 =?utf-8?B?b0tQK2NqTjQ2MWtxbjJrbDdxZDZwN2JHVDluRWlTRDh1dUI3WkZQZmE3cjdJ?=
 =?utf-8?B?S3dJd1B0SnBZNnlxaTZFcU9EUCtJQ2RIUE45SXBGcnpNMjkwZmJpbE00QVBn?=
 =?utf-8?B?b3AwVUY0QjRuNW5QZkVIVm02NTZRTXM1UCtiSFRYdEZQaGU3Y093eTlQSSsz?=
 =?utf-8?B?dzlDR011bmpiZ3d5bmwvZDF6QkNxeXVzU2pKMGVReS9kTWxsa2dyNSs5dkli?=
 =?utf-8?B?VGlaeW1MY0xBN21jZkNqc2V2VVBNZWZJLzR3Y0ljZjM2Q1VFVHF2OW5TK0pU?=
 =?utf-8?B?NHE2TEhrMGhZVVJCRk1rWTdHei9MRGw3cXpBQnpoN1BmOVkxQ2lNVGZtMGNo?=
 =?utf-8?B?MVlRa05iK0w1MThka0dPWVc5Uk0vRjBpdVhmalFKYmYyNnRaVlAxMDBKTW0w?=
 =?utf-8?B?dVF6Z1NkdENOMk5Lam94NkFFNzl1SXM1NXpmNnlZeENab3REY25FRS9JUVRH?=
 =?utf-8?B?WmpkbVNKTEZOWEpMQTEvNWNtSG9aQzZPT01ZVGxGVzBaa3BsQnNRbDQ1RWtk?=
 =?utf-8?B?YlNILytiZHozRm92NjdRbE9uMTY1NkRnVjNNNnFnNzFaY0ttK0d4WDJPc3Ny?=
 =?utf-8?B?aklNK3dsYWY3Ni80bk54VEE3S2trL3lQdUxCNk9aUHpYWmVTVnY3TUhFUGth?=
 =?utf-8?B?SHZCeU5aOFQyYzR3aVFabi9LYnVpV2dxeEZHakhJMnJNZzJwNW0xdmVOd1dr?=
 =?utf-8?B?T2tacEZlajk4alpyRWlqc1JPNllEemFIaDJ4RUJUbHZpQ0lzdzVyMHJYVzht?=
 =?utf-8?B?eUtubUxlN1d4US8vRVNGU01vV3FvTDEyZWx5eUhtcXNVbjVWNnZkR3FITTI2?=
 =?utf-8?B?b1NxQXhhYnZJdXhqd2FNNmJWbjlmRTRVSTcvM1dIY0ZqaDk5MllHb2JIZmFk?=
 =?utf-8?B?c0pJN01RMVZSc3plZ1YyM0dPZWtEMzdxcFZ1QlpYK2JsRTNWRitHZWxuMk9O?=
 =?utf-8?B?Q0c3Qmd3YW9ZS2RyQ1R1VzNMNGRWUDVSVkd4WGgrN0t2WEtrNCs2K1U4QlRQ?=
 =?utf-8?B?aCs4ZW1VZi96cWN0REliNm1WcmNEbVlyL00xL3NVYmphSEw2Z2JJYjVRdGJW?=
 =?utf-8?B?TDN2SzRDM2gySHlEQWx0Wkc4amdRRk02bVpkaERlemJwR1BNVGVKNTdzY2pE?=
 =?utf-8?B?bEZ3RktHdFNnR0ZlZU1sNXM1WWJOdEo3cElvTkx1bFUwN1UwL2hENEV3M3Zu?=
 =?utf-8?B?Rm54UWJ6VDUyeEZkMWF4enp6dWNqTFBEMFJkSzdOR0MrTGRiUktieFo5QkZG?=
 =?utf-8?B?NnJGcXNaY3dDYUx0clNMc3J2MlgweHNZMmh5UnRFaks0VWFCSWxsSThTYUkz?=
 =?utf-8?B?SXBVQmZQdndYVDlWVnhUSnNNMCszWjFJSG0vZEJxU2c1MTc0YVpvTW5JUk5B?=
 =?utf-8?B?aVh0bGxVaVkyWUUyRDdmRE5QWnBTZkVOcklKZTlrUUNjczU3RHVnQzVvWTlY?=
 =?utf-8?B?RUw0ckVWc0liaTlWNkVOUkpPUmlUSnppWmVIQUVNY2dqaEU2TFZqZlJzTnUz?=
 =?utf-8?B?UWZUL3dUWUNHTWlwN1pKUzVOQ2svRFdxSEdVV2NJamNsY2NPaWlycmRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVJkZEU5UmY5Ulc2KzJKSEpTeWFwSkcva1dsc2lUODcxK2pRZzhmK2MyTG1h?=
 =?utf-8?B?ZXZETEgvTzFRbFhjN0tyV1VWZHllcFMxMGp2YmVsVk04R0tva0FDbElkbUxF?=
 =?utf-8?B?RFhDRThRVzB2b1RXdjFMT3R0VVFvWEJIRi8wNENsYnB5N3p3VnRRS2pjVStp?=
 =?utf-8?B?Q2cxYklkZ2trS3VUM3RXeGlrdU05SmRvZlFqdUh2TkhOYUpwZzhzNjRUKzN5?=
 =?utf-8?B?RGR6N2wxdzA5RGwxcnJhK1dBcFV6cWJxSzYxa1BHbktIL1dRNTlJVW1HWndE?=
 =?utf-8?B?THE4Tmx5YUFtR1VIa2s3RXJRMlY2ODRTaWQwWDFvNkpqdERFeWNJdTNiQnR5?=
 =?utf-8?B?dk0veDEwZFRFOXk2TE5nR0VSa0tiUnovWTA1enJpZTFRZDVycFVNSDRZaUpS?=
 =?utf-8?B?SVNRMWgyVDNEVVN2cm1ucFRsS0RsK001YlIwZkhLTDNtdnUraHJQS2x3ckpq?=
 =?utf-8?B?ZDhqdHpEUkU4anZTSlJteFpWN0w2ZzMyVVZKai9VMjZMMXI2eFI2cHI1MGsy?=
 =?utf-8?B?V015Zks3VDIyMzE0MHJDRVFyZVJ2SGJYL1RoUFlRbHl6cHBmVnpWSHBuTXF5?=
 =?utf-8?B?cjFiSGo1cW9leXJ6MEh5ZUF5UW1LbDdaRmpKK1pHR2pOcDdEdFY2R1VwZ1ND?=
 =?utf-8?B?ODgxdlhWQzBjRzFLL1NtdzQxeERwc2QxSTBmaFNUeDhhWFpQc1l3MHBnMWF5?=
 =?utf-8?B?azR5R1c3cjdhaSsvRXQwL3hscGVndVY0dlArRnN2MmthN0FnS3ZyWVZwbTgw?=
 =?utf-8?B?SEVmcXJqWTlWRk9MYmt5bCtlcWdYZFgwQm41QjJXdkNGcm0wNFludlBHU1Fa?=
 =?utf-8?B?azc4ZnhkOU44Z1hEd3VQa0Z6bnN1dC9vcmJZdUMvLzhMd0tFYnpqQmFYbGxH?=
 =?utf-8?B?cU4yV1NobzltaTBkWmxBSmhBdEFZdmlTUUFtYTVoZGpSb1REZStGQUpzZ3Vi?=
 =?utf-8?B?ekRvTi95OG1aSjV4VG1ENUxZYnd6dDA4MWhqNWxNR1VSZ2hWbzIxd0NsOVJF?=
 =?utf-8?B?TWREbTgzN055SnJ2Z0lkK2NsMnRIL1NxZjNrVUdaOGhxM1V0THNjc2d6YnZx?=
 =?utf-8?B?cnJXNDRpRjJHSlNDN1VtdGdMRzkybDZGUzh5dnNJQS9MNnBZMHJWVFV5Y0V1?=
 =?utf-8?B?NTRma1R0eEYyb1dCNzBmcS9IVlNOdkRqbm4vV3NiNXdJOEFQM3kzRUpvaHR0?=
 =?utf-8?B?NXErUXlIVWhxN3JubHBkVXR1NVpYbWVGVXZMbTl6eUJWY0NINWtrazlPRmxG?=
 =?utf-8?B?UVkvc0NIdEQ0MkY0SVpOc1Y2VnRLV2NSeDJVc012NklMYjNrbkdVakxncVlN?=
 =?utf-8?B?N0I0UWRhM2QvNGVqaEdlTzVkeVh3TU5ISHNLczEzanduQm5qZUQyQVBUb0Yx?=
 =?utf-8?B?OWpraXpWbnJCK2pBTU56K0dkcnVVUnpKWTV6RnBURVpkRGQwKzA1MjdRamln?=
 =?utf-8?B?Wkh4eWZrb1hqdzdPMEpkNTRsNHBzMmVMS0xSNVlEdUU2RzBXajBtKzAyTk9v?=
 =?utf-8?B?dWh4b0k0bzExNnpkeVlDSWlqamZIbVdDYnJwQzFQR2x0T1ZEa3h1a3FRUkFO?=
 =?utf-8?B?V0VLQ2RWQUVzMjhXb2xwYmd0RkYzR2FMZnJYaENERVFTNDRDUUIwVnRJMTEx?=
 =?utf-8?B?ekJ4RlZlR3FycVlHZnllK05pZ0VlZDQwVUI2ZmN1TmUxakpqOFd0SllHVGw3?=
 =?utf-8?B?SEhPNmt2S2ZaL3AyQXk4NXlGTnJueEZQVDVxRXd2ZFNMcmRRM3RzdU1qWG1K?=
 =?utf-8?B?aVRUbkg4LzBWYkx5RE9oRlpZby9xdk9BWFpxdDMweEkrTW5Tb2NoY1dmN3Z1?=
 =?utf-8?B?bU9ydmVJcDBhRkNUOXZFL1lhR2lBNENuVndYVCszMVZZY1RBcFlUWWtkTHF1?=
 =?utf-8?B?WTdlMGlxeExHUlMyVTk1NTRGemt4ZVBJQlhYWjVXc1FoRlhLTkVuWnFXMVpG?=
 =?utf-8?B?QmltZlhDR3B0YjNhdmg4TGVKVlhpQmc0SmtwUjRzMytGclp4eitmWGdGUmRI?=
 =?utf-8?B?bG40M2NPMXQ4eWlXTkpQa3hheU1LZWM5NW9XNGF6cUJPRy92a2RuUXJ1emJS?=
 =?utf-8?B?cnlSRlRMR0RNYnFjYk5lQ3lZaWxDbUxQQmNoUDM5UDVkYjlMcTM0SjY2Q3lD?=
 =?utf-8?B?b3MyZUhwck9EUUJuZUw5UkFwc2FMMENLYlRsZzlQcEgyUU5VdTlYbHZqT1I3?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 484bd863-eb3b-40a3-79e4-08dc706ca8f6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 21:11:57.4459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3nOJ36cawdrCdbYtGqGol8rB17efhT70V/hQLgflm0jH79E7ouRNs6T47SiYIKqbj8g0ch9+Fi/taShs3N/Z1WmKdxeL38vaxiYYICil3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8008
X-OriginatorOrg: intel.com



On 4/26/2024 12:06 AM, Ilpo Järvinen wrote:
> On Thu, 25 Apr 2024, Babu Moger wrote:
> 
>> Enable MBA/MBM tests if UMC (Unified Memory Controller) support is
>> available on the system. Tests will be skipped otherwise.
>>
>> Update noncont_cat_run_test to check for vendor. AMD supports
>> non contiguous CBM masks but does not report it via CPUID.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  tools/testing/selftests/resctrl/cat_test.c | 2 +-
>>  tools/testing/selftests/resctrl/mba_test.c | 1 -
>>  tools/testing/selftests/resctrl/mbm_test.c | 1 -
>>  3 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index 4cb991be8e31..b682eaf65bfd 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -314,7 +314,7 @@ static int noncont_cat_run_test(const struct resctrl_test *test,
>>  	else
>>  		return -EINVAL;
>>  
>> -	if (sparse_masks != ((ecx >> 3) & 1)) {
>> +	if ((get_vendor() == ARCH_INTEL) && sparse_masks != ((ecx >> 3) & 1)) {
> 
> This looks independent change to me which should be put into own patch.
> 

Own patch that is separate from this series. This should go in
as a fix with
Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")

Reinette

