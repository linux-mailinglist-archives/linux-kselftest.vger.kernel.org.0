Return-Path: <linux-kselftest+bounces-17435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BA996FEA4
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 02:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79EDB21DC8
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 00:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B5F367;
	Sat,  7 Sep 2024 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJwqheBW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A85C28E8;
	Sat,  7 Sep 2024 00:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725667526; cv=fail; b=XZtbnZV+GnXYid4StHwk4YUzkCp+rD42jgfQxAl78Vv+jHVDQ8ZcfueOnbJEGWo8YfhgZaeByqLcI1tTQDcA+W3ayMx5Ba5+iOL6RYV429Y0jKrUjMkt3hM1IvKmPDngPo799vUUvq2lxwQpOIrHmyeDH1nYVBhyAPNWmIhcbm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725667526; c=relaxed/simple;
	bh=xblh2vQz/Bjbys3/PYPvPwJ6ltR9ACEVsQuC6vw+2V8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BtybBI6V/NF28zo+xTQxtss+KgOhdaeKFH72yEjnRAF4tu7XX4yAkvkDFcBLJe3P5QO4Gc2Om6nEm5M4M7mWRCQN0Y0HhhokNqF2KgRhf9ND1smUJ8HG0Fdt7ELmFgYtV90DA9lYys3z9C8yiw4GeWKRzGuTpdqIUkRUv4s7Q2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJwqheBW; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725667521; x=1757203521;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xblh2vQz/Bjbys3/PYPvPwJ6ltR9ACEVsQuC6vw+2V8=;
  b=HJwqheBWp93iYmQg4CbBPj3qQm1BnWHLFeeA8o6mNrdZBKi4x9FjJKLZ
   s6/WQ4vPV7WqCzJBqmDufXDEGCahUMHiQltEmMVOMe0Hh+YVEOtRSgYqV
   a6THblQBvmhKof/zv2UQaKBKtU1+y1mbjQSCXnwC9KOJ+uPx2dQhpbtp4
   js7sh5wxOPNptDtrKn76XvFemHulXYQzwvtsquS3mpjC3DuX0T/udEGXr
   Kh8yfiEBYFHrEbW+UE1uOIR+g1WLg5caJaX4NMVmgLuYrpA7rTrjO4g3L
   FC2fWCRV0ARpfIcTcSXRQzQTkaz5qU+UIyMD3R+1DLU5mPzBYIdsX+WiE
   g==;
X-CSE-ConnectionGUID: 7UDTMWLXRK2mTNOCsDKqtA==
X-CSE-MsgGUID: W4D+cXJuQPa+5w26EQ7JQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35036439"
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="35036439"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 17:05:21 -0700
X-CSE-ConnectionGUID: lpqGWTeSRuyKlkCqQlVYLg==
X-CSE-MsgGUID: SDe6auXjTYuTLSF3LUDSCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="103571391"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2024 17:05:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Sep 2024 17:05:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Sep 2024 17:05:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Sep 2024 17:05:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Sep 2024 17:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKALTQe0ubQB8S1/2F6TcATtpvyQGheIGK789j1cBxLNOlph+gtodToa1Qe7+fKDAu2m8Q5O1KaYf0hsGGOAMM40hfjubbO8K/Cx4yXg8rCqTl8TuzfUZ13PcrsW3PvhTYROombdoaeOrjFX4OXT5Gg6JlaZulZMsSjisbpA89F/9KGW8nj3U7UpA5CjztyV3xC0y7TEJWnXaObSCFOD1AlMAfToINs7vA46Q7VLOTkCTKWIopkuXzonAu5arCSMDBLXezhWurhD+YeK4fYqEoPmKnq39Db61Iiq8KKEXR+ycI+CLPtn/CnTFgyeqiV+y3+4eL7EeqRjDC3nHwSxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kguywTCUNttvqy5hiDgpxHnK/lcvwK59hK5JACjiDuo=;
 b=MpiDo9gnsg7Lupxxlc/SvFUvhJwG5430Rzyr9h6tG5jkiYq06YZGIP7ygfTN912NvJ/PERC0NscOMx/CkUu3oV24QSILcUE86D8aN5PKKmJ6eecV31dyoiqckswt0dcYoF5hEFlbCxCXjhZZp277A9ljli9jeCEub9kSBKSdDdkcRzTUbGkSgr1AQBdESBchsFJWwonhUBP+yeJqMU1t49F8fpkqjB9RjJrmwoZQkDdHExEchry95kx5xyzADI6OdBnpOCwlzeBB41CNmbzGIJDoM1SGR1x/usgSlWyBiSxt6mkG8oiwSHXmbRCnIVbN5udjRADviWdTdo2jV//ZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7259.namprd11.prod.outlook.com (2603:10b6:208:43c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Sat, 7 Sep
 2024 00:05:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7918.024; Sat, 7 Sep 2024
 00:05:17 +0000
Message-ID: <3325de04-6e59-4c7a-ae44-c245c8edb93f@intel.com>
Date: Fri, 6 Sep 2024 17:05:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] selftests/resctrl: Ensure measurements skip
 initialization of default benchmark
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1724970211.git.reinette.chatre@intel.com>
 <a0fe2be86f3e868a5f908ac4f2c76e71b4d08d4f.1724970211.git.reinette.chatre@intel.com>
 <3add783b-74cf-23c0-a301-aa203efdd0f6@linux.intel.com>
 <0ae6d28f-0646-48b2-a4e7-17e2d14f6dd5@intel.com>
 <85a11091-3c61-2d8b-28d4-2a251f3b8ffe@linux.intel.com>
 <156ad739-3f80-456f-92df-74da9266dca0@intel.com>
 <da06ea9d-5081-b81f-5d2b-28200527f419@linux.intel.com>
 <86ca3bcd-de60-4784-8a32-8df360a4ceda@intel.com>
 <0e5078b5-509f-38ef-fa71-821c5f7b5944@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <0e5078b5-509f-38ef-fa71-821c5f7b5944@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:303:dc::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3055e2-54e2-44d0-c7e2-08dcced0c10d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUJrSk9EQXdvb2ZSRU5RcFZkQWk1R0lUSmlmcUl1ckFkVlgxT08wODA1TVd2?=
 =?utf-8?B?QXR2NFptaWJPeVh6eWQ4aWF2NGRzc0gvRlg4Ukc3U2pvQXBYeUVkd2dERHp5?=
 =?utf-8?B?YkM0VUxyRHIycExPeEJlQVNyN2VCa243eTN5b3dDVTJSSXJUdlFXRVgxdXVr?=
 =?utf-8?B?Y0gxY1B1Z0RXaEhSZXhVZGtRS1IvdmwvSGFqbUtpam9IWlFlV0pYb254OEJP?=
 =?utf-8?B?aDlpbUNHZVdzYUU1cmc2b2RudWplZTZtM0FTeUwrbGdkOU1qSXV5U3Z4TVFn?=
 =?utf-8?B?MmIvSTNkRFovTGErL0drckNIL3RGMEEzN3JnWDZrRW5BR1lzbDczZTFVaHk5?=
 =?utf-8?B?K3hTdnhhbk5PVlJCOVR5WDgwY21JbnR0eFZMTmI5cjZnS01GdlVzQ0FhQ0VH?=
 =?utf-8?B?NW5vVzhxaFRnNkU5eUl0VDdhWnhMMlJyK01MbmVKbk93RDl1dkd1QXlwT1lv?=
 =?utf-8?B?QTJUY2hKcUtWQkM4T2t6MDBremRhbGd0cUZQSzFQVG1sYi95Mkw2dzlHY2Zv?=
 =?utf-8?B?Ukp4bEJraGVsL3VoN3luSlJmdVRPWHpZcFMrSDlaVWZrcmE0cUdzRW9xUGlY?=
 =?utf-8?B?VDhLWmE5bHhpTTRmZkljaUFweVZQN3U2aElnTVVXTG1NOXNMZW11QjA3WC96?=
 =?utf-8?B?WGlRbHlGMkt4TldCU05NYUk1cDFTVWt5MnYyR1VqQ201d0hDZ20vbXZHcHpG?=
 =?utf-8?B?YWJ6TnNwRG9jYkN4c2RKbC9pMEhUcGUxRTZXaHFkYThEeFJNbDVTOXBWSmpP?=
 =?utf-8?B?ZWJ2OXhac3RNYmVScHRSYzNzUXdRaS9wNHNRcDB2aWRHVk1Mc1JyaWpmYlRj?=
 =?utf-8?B?Q0Z5NlFiNlRpYnBqVHh1VXVwVndHY0ZIZnl0djJaaWRISGVseWpDenBUbVBh?=
 =?utf-8?B?MnVjQ0RoWXF6ZzdTNGlVQUNGcng2c3BlN3Ntcmh3UVJ1eU1NUGROckRPM3ox?=
 =?utf-8?B?a2M1cnVYVmJrOUxtTWZVdkUyd1hORnZYK1Z5TXZ1a3Bhb29tWW5CKy9hYlpv?=
 =?utf-8?B?ZFp6NGNxZVc2OW44bVJaTmUvcDlDbm1XcWMvektmSXNmcEZHRTlvbW8xQlVH?=
 =?utf-8?B?S0x1WG44dzhXZHpzMFduN1VNNHMrdjcwVFhVOXFHTE9Md3JLNkxyMUhXZU1B?=
 =?utf-8?B?djVITHE3VVlrYzhMaXp1TnFiYzQxUE5kam80Tlowenc2bFMvdEkvZkRZZWFT?=
 =?utf-8?B?Vkd5OVVSaE8wUXdwMWNReFA3dUR6K3dOTlZDeHVmZ2pSdlAyd2JPVkRyQzJ1?=
 =?utf-8?B?bUlVRGxPSWswVnZxYkRtNi92ZDFDKzVlTUovRUpTUzcwWS8yZDl2NUEwMnQy?=
 =?utf-8?B?TXhEcnFzUmQ0NGJRam0zWWJBSGdsWmsvcGdyaUNZdUNWOG1ibGpaeVdFREZX?=
 =?utf-8?B?L2R3MUo5V0lTRENNRWNTZ24xaGw4YmpJWnhNZlEwamFJTC9xZ3FBWmxFYVpR?=
 =?utf-8?B?RllTaUVkdEFpMU5MSDY4YWhtdDFoQ0ZuTWEvU3hKSEpGdW9PV1RXNW93STRk?=
 =?utf-8?B?ZUtnNUZjZ2FFdTVWMysyQzZJS3o4SWFPTHVibjdveG94QzBMaGxpVjVBZWt3?=
 =?utf-8?B?ZHF5WEhWZDdEaTNwZTZXMnBKVHQzOEw2Tm1mRUdMbnFmWGw5QVVrTGJSV0RK?=
 =?utf-8?B?VEdUODlaK1dOZ3dPZ1NBSkRiNHltUTVNa3FONFk4TmtOeTJyM290Z3RkcmJM?=
 =?utf-8?B?U2ZpM0tpM25zM1JrYWMvYU9nL3BmUElvdDhSVVBxcXJJUU5uUHhVTHVUUHNW?=
 =?utf-8?B?UDR3OWNBTnI2dVh1ZVlnaGM1L3VQOHJ6eWZGMkNsMWlzd0NIdWIxSXdmQTFi?=
 =?utf-8?B?RDhNSkR0Y2l2cUpZcnF6UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkR5b2VZQWNuSmMxcXZEWW1SMHE0SDNHVTZnYmVBR3M3OUpEK1EyTzJxcmla?=
 =?utf-8?B?b0dnRmVvY0RWRTcwSnFOZzRnZloyQW5jclNZdXZKeEZSMlE0eUYrMVcxdGpl?=
 =?utf-8?B?bGVaMUdiYVY5YmVmdllsQVlLLzdPdVBnYXJqL2pjVEdtQ09YTVA5VTlqbDN0?=
 =?utf-8?B?SVhidWJvbXNqRU1UZlBTZVBhZHVIWHdyblUvb1dPbGp0OExqZjdCMnRvR2Nw?=
 =?utf-8?B?OW8zNTZpLysvb3VYOUc1ZTc3VVVMdy9PVlFvZDhNTE1MYWMrQVI0ZEFEcWRX?=
 =?utf-8?B?MDd4dkJCbnFaTVZNNnB5YzhDZjBKa3NLRVBPYWxsOTA2TmIwazRWaVRNNEVx?=
 =?utf-8?B?N0ZXMUFCSW1YVC9VMU9mQzRWbjJsc0tWUzNsMENvaG96dlBTN0JpQklVd2Zu?=
 =?utf-8?B?R0ZKYnA0WThLbDlKNldWdmlUbGx6SlErZ1JIZHR5RzI1Z0s3di9HTyt1TGlD?=
 =?utf-8?B?ZWRpdkVJcjJRMUdFek91MG10Z0dOQW9xNFpNUkZYV3Rud2JnU1k2TWNFamhN?=
 =?utf-8?B?akNjc0tpVWphaVRpZzJxOEZ4cUZVUjAxdnhNd0JDMmh5ZlZhQllPL0xocDRM?=
 =?utf-8?B?bDRoaWFmcW9nbXd1ZEJKbTRQZkRsTmhNRWZIczU3NXhCbzZOWnFHck1hUDhx?=
 =?utf-8?B?WjhMeEEwcVB5d3QwQlN0RXZwcEdHQWp3YjlnOTEraHBwKy9HTmdUdWxrcTVp?=
 =?utf-8?B?d0p0ZkxNM2w2VGdXSWVrb2ZSZ08zUmg4SFRnN0pwbHQ5WlZpT3J5dlhXYmV0?=
 =?utf-8?B?TkJvYW8xSkZYVkgyZDdHY0ZCU3BhYnJsaW1BdTQ3dWd1SlNZR29mamI5L2JX?=
 =?utf-8?B?Nm5vVnBVWnB4MTgwRGZwanZlMFZGYk5TdnpuQiswTE13TjNKZTBHZXJHcGZS?=
 =?utf-8?B?ZTRpellKeU1qRFB6TkVVaGlHUTNZMG91ZzdVN21uTmpOUlJaV2Uxa0d6aDNa?=
 =?utf-8?B?aEQzUm93MHM5NFEwT1llN1Z0REFrMHNuSU5TUmJ0Mzg2OVdWc2JjbW1XTTZO?=
 =?utf-8?B?UUtzNHpJV3JaamFKRTFnNzRnWE5UMW0wc0d5bFpvUnYyY3FwbElHbU1PNksr?=
 =?utf-8?B?MFRrcnM2ZXJPcUFsL3pXTjFVSGpGRnowMFlVZ1BFanpNZGNjYzR4MDlaQzdO?=
 =?utf-8?B?VVpJdFd2UUwzcG5JajFWdUh5Q1BkbjNHZnRhbU83QlR2OU16MEk4SjQ0czlO?=
 =?utf-8?B?ZFZtRUdVM2hCa1dWbDdMYWJIT0J4NkhLZERpUmRwUHlldm5FeVJJcmh5eW1D?=
 =?utf-8?B?OWdlZU01QUlmczJFRkVaQ0JjQ0N1SndFVXlXN2tCNUFQYXp0a2N3RFUzcXJs?=
 =?utf-8?B?SDY0VTFYYk9vZ3d0TXd5NzJZUXl6VXBHekwvNysvdzI0VHpkdVhiUWZIajRC?=
 =?utf-8?B?bVRmbjBpb2dEQnVkQXU2bXhGcDJBRzd6aU40MElCejM3aTIxUlJWd2FCRm9M?=
 =?utf-8?B?Q1FSZ1BMOFpFT0xBeEdQZ0I0OS9ZUnhxbTk5S3l5dUpvOERvY2VIUDUxNTVn?=
 =?utf-8?B?Mmx0SmRvT09ib0lQb1N6UGw1ZGxaV243MVNJNC9yZzBOSHdYa011c015S2M3?=
 =?utf-8?B?OC9JdHpvenhWWGQyNFAzU2xDVlVCbmY3Q3lsQkRMOThqdGFhU2tKUGtaOVpk?=
 =?utf-8?B?NVhabUlzVFZidDQwbWtHMHFvVWZtMVdPcVpId1pDOTRUUzk2MHNtaEdpVGcv?=
 =?utf-8?B?ZFNZYXlSWFBJejZzSWpENHFIRkM4VWdZYmFha1Y3cXVDbUR0V2hmcG5rcWpP?=
 =?utf-8?B?VkNHWWRGNFFETENDbWtBSHg0eHBOQllXVGxhWEV1N0hSTUdGTm41Z01ZdGF5?=
 =?utf-8?B?dmlpRytmTFRCT0JTRVhuUndSRUQ4TGorUTcvZzFGR1JRVE1NRTJYNFJOOXRh?=
 =?utf-8?B?OUo3SHg2UUFMMXR5OG4yTUI1QXNXZDNTVThySkFiSTRGQjRSTGZNaDlob0NX?=
 =?utf-8?B?TWh2NkpzKzdlY1NySG5DZ2s0ZVpvcTRCOFlqNlo4UmpvUXdrMU1DVEFNK2dx?=
 =?utf-8?B?M21JaFBZNjlkM2JOZlRXVG1qY2x0TSt5SHZrM3B6bEM4akVDVjFjcmVjNU5n?=
 =?utf-8?B?ZzVrNDYyT3FGTXFIVUhPQmsydlhsVDFLbUtSQlYySmRNUjR6ci9zV1FLTE4w?=
 =?utf-8?B?aXZ2My9PYXcyaDIwWnI0dEpTRDR5Z2h0dnIwL1BqRFA0Qk9nT2FKaEhDeldl?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3055e2-54e2-44d0-c7e2-08dcced0c10d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 00:05:16.9131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnhqK1vX1UXCNYVHCz+ViAsqx06a0LMJgnhUJno7cWg8PB2/6sEKo2zR+dF5yhVcrxg5qHBjFnyu1hks1ioQOb7EqpOSDvF1ZSMEEFpzy6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7259
X-OriginatorOrg: intel.com

Hi Ilpo,

On 9/6/24 3:00 AM, Ilpo Järvinen wrote:
> On Thu, 5 Sep 2024, Reinette Chatre wrote:
>> On 9/5/24 5:10 AM, Ilpo Järvinen wrote:
>>> On Wed, 4 Sep 2024, Reinette Chatre wrote:
>>>> On 9/4/24 4:57 AM, Ilpo Järvinen wrote:
>>>>> On Fri, 30 Aug 2024, Reinette Chatre wrote:
>>>>>> On 8/30/24 3:56 AM, Ilpo Järvinen wrote:
>>>>>>> On Thu, 29 Aug 2024, Reinette Chatre wrote:
>>>
>>>>>>>> @@ -699,111 +639,80 @@ int resctrl_val(const struct resctrl_test
>>>>>>>> *test,
>>>>>>>>      		return ret;
>>>>>>>>      	}
>>>>>>>>      -	/*
>>>>>>>> -	 * If benchmark wasn't successfully started by child, then
>>>>>>>> child
>>>>>>>> should
>>>>>>>> -	 * kill parent, so save parent's pid
>>>>>>>> -	 */
>>>>>>>>      	ppid = getpid();
>>>>>>>>      -	if (pipe(pipefd)) {
>>>>>>>> -		ksft_perror("Unable to create pipe");
>>>>>>>> +	/* Taskset test to specified CPU. */
>>>>>>>> +	ret = taskset_benchmark(ppid, uparams->cpu, &old_affinity);
>>>>>>>
>>>>>>> Previously only CPU affinity for bm_pid was set but now it's set
>>>>>>> before
>>>>>>> fork(). Quickly checking the Internet, it seems that CPU affinity
>>>>>>> gets
>>>>>>> inherited on fork() so now both processes will have the same
>>>>>>> affinity
>>>>>>> which might make the other process to interfere with the
>>>>>>> measurement.
>>>>>>
>>>>>> Setting the affinity is intended to ensure that the buffer preparation
>>>>>> occurs in the same topology as where the runtime portion will run.
>>>>>> This preparation is done before the work to be measured starts.
>>>>>>
>>>>>> This does tie in with the association with the resctrl group and I
>>>>>> will elaborate more below ...
>>>>>
>>>>> Okay, that's useful to retain but thinking this further, now we're also
>>>>> going do non-trivial amount of work in between the setup and the test by
>>>>
>>>> Could you please elaborate how the amount of work during setup can be an
>>>> issue? I have been focused on the measurements that are done afterwards
>>>> that do have clear boundaries from what I can tell.
>>>
>>> Well, you used it as a justification: "Setting the affinity is intended
>>> to ensure that the buffer preparation occurs in the same topology as where
>>> the runtime portion will run." So I assumed you had some expectations about
>>> "preparations" done outside of those "clear boundaries" but now you seem
>>> to take entirely opposite stance?
>>
>> I do not follow you here. With the "clear boundaries" I meant the
>> measurements and associated variables that have  a clear start/init and
>> stop/read while the other task sleeps. Yes, preparations are done outside
>> of this since that should not be measured.
> 
> Of course the preparations are not measured (at least not after this
> patch :-)).
> 
> But that's not what I meant. You said the preparations are to be done
> using the same topology as the test but if it's outside of the measurement
> period, the topology during preparations only matters if you make some
> hidden assumption that some state carries from preparations to the actual
> test. If no state carry-over is assumed, the topology during preparations
> is not important. So which way it is? Is the topology during preparations
> important or not?

Topology during preparations is important.

In the CMT test this is more relevant with the transition to using
memflush = false. The preparation phase and measure phase uses the same
cache alloc configuration and just as importantly, the same monitoring
configuration. During preparation the cache portion that will be
used during measurement will be filled with the contents of the buffer.
During measurement it will be the same cache portion into which any new reads
will be allocated and measured. In fact, the preparation phase will thus form
part of the measurement. If preparation was done with different
configuration, then I see a problem whether memflush = true as well as when
memflush = false. In the case of memflush = true it will have the familiar
issue of the test needing to "guess" the workload settle time. In the case
of memflush = false the buffer will remain allocated into the cache portion
used during preparation phase, when the workload runs it will read the
data from a cache portion that does not belong to it and since it does
not need to allocate into its own cache portion its LLC occupancy counts will
not be accurate (the LLC occupancy associated with the buffer will be attributed
to prepare portion).

I am not familiar with the details of memory allocation but as I understand
Linux does attempt to satisfy memory requests from the node to which the
requesting CPU is assigned. For the MBM and MBA tests I thus believe it is
important to allocate the memory from where it will be used. I have encountered
systems where CPU0 and CPU1 are on different sockets and by default the workload
is set to run on CPU1. If the preparation phase runs on CPU0 then it may be
that memory could be allocated from a different NUMA node than where the workload will
be running. By doing preparation within the same topology as what the
workload will be running I believe that memory will be allocated appropriate
to workload and thus result in more reliable measurements.

> 
> You used the topology argument to justify why both parent and child are
> now in the same resctrl group unlike before when only the actual test was.
> 
>> You stated "now we're also going
>> do non-trivial amount of work in between the setup and the test" ...
>> could you clarify what the problem is with this? Before this work
>> the "non-trivial amount of work" (for "fill_buf") was done as part of the
>> test with (wrong) guesses about how long it takes. This work aims to improve
>> this.
> 
> I understand why you're trying to do with this change.
> 
> However, I was trying to say that before preparations occurred right
> before the test which is no longer the case because there's fork() in
> between.

If by "test" you mean the measurement phase then in the case of "fill_buf"
preparations only now reliably occur before the measurement. Original behavior
is maintained with user provided benchmark.

> 
> Does that extra work impact the state carry-over from preparations to the
> test?

It is not clear to me what extra work or state you are referring to.

> 
>>> fork() quite heavy operation as it has to copy various things including
>>> the address space which you just made to contain a huge mem blob. :-)
>>
>> As highlighted in a comment found in the patch, the kernel uses copy-on-write
>> and all tests only read from the buffer after fork().
> 
> Write test is possible using -b fill_buf ... as mentioned in comments to
> the other patch.

Yes, it is theoretically possible, but looking closer it is not supported. Note
how measure_mem_bw() is always called with hardcoded "reads". Reading through
the history of commits I do not believe modifying fill_buf parameters was
ever intended to be a use case for the "-b" parameter. It seems intended
to provide an alternate benchmark to fill_buf.

I am not interested in adding support for the write test because I do not see
how it helps us to improve resctrl subsystem health. Considering that
nobody has ever complained about the write test being broken I think all
that dead code should just be removed instead.

I prefer the focus be on the health of the resctrl subsystem instead of additional
hardware performance testing. I do not think it is energy well spent to further
tune these performance tests unless it benefits resctrl subsystem health. These
performance tests are difficult to maintain and I have not yet seen how they
benefit the resctrl subsystem.

>>> BTW, perhaps we could use some lighter weighted fork variant in the
>>> resctrl selftests, the processes don't really need to be that separated
>>> to justify using full fork() (and custom benchmarks will do execvp()).
>>
>> Are you thinking about pthreads? It is not clear to me that this is
>> necessary. It is also not clear to me what problem you are describing that
>> needs this solution. When I understand that better it will be easier to
>> discuss solutions.
> 
> I was trying to say I see advantage of retaining the address space which
> is not possible with fork(), so perhaps using clone() with CLONE_VM would
> be useful and maybe some other flags too. I think this would solve the
> write test case.

clone() brings with it the complexity of needing to manage the child's
stack. This again aims for a performance improvement. What does this fix?
What is the benefit to resctrl health? I would prefer that our energy
instead be focused on improving resctrl subsystem health.

Reinette

