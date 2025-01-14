Return-Path: <linux-kselftest+bounces-24528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0F8A11417
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 23:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D08127A0519
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 22:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAD21D5142;
	Tue, 14 Jan 2025 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtYpnRKA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD98F23245F;
	Tue, 14 Jan 2025 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736893862; cv=fail; b=gMnfn7GRI3xYSXkdUFtEin4C/BauE5if4TF+0V4DV4T6nW0hA1gmIMbp3saBh+wiJVyGVAmHXGMi/kojRF2O26/Snme8BB7fEnAPS7SGKhNA3e+9vZ1uaUA/v8Xam9Dr80/L1RseGOnytwPNipMl+7gdKTdzW/dmGJTnb3LMUNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736893862; c=relaxed/simple;
	bh=x6f92l35YqB4H16ESruQVTABTlYVE1KlQ8pqshAP4fE=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VbhTDfrni+ajSD49JTzmg5mLVSPZYC2jAPyQFxDRthsHW8XiBhah51evp1+G1TmWa5yFOAPXvaiiaOT5GgoMS+oHrHmIJ3SI02Vpkf7OcCZUH4pkkwQxaXkUSrmRu4mXKjKO59clXipBkhvgkFXpwAPrMrbSp67WngynXLZCIGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GtYpnRKA; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736893861; x=1768429861;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x6f92l35YqB4H16ESruQVTABTlYVE1KlQ8pqshAP4fE=;
  b=GtYpnRKA2cFas+d1zF31/+Rz/ezNiivxFbOR+4fwNVmRVn6F54IVyb53
   kbfvNBhwXzZj+E2/AjP/q1RXCnUe0b0YD4NVAq/p/0dw6/gkeSdO2Mrl9
   /nRNykb5DcqIDgZl0hbcKaJ724AGylykEusQsegTbBpI4CTYPnWlaZMmi
   OhSWPYKPC6MjfcnFvMzbsJGhraQQ0/WfEQadh6lKrzn9GRCikacVayl1M
   1A7lbhqoxNrb1CnCgw8bov9nCIVPSDjPoe11xNMBoZwrSYJHI+TIDJE6T
   vz6Ip7Yc2QiD1lHfRODa+1zrm+2nm6OmXzCNs8Yl+Y1H/8WrjLhp4MscV
   w==;
X-CSE-ConnectionGUID: ZBIPfEOcTJmccN90/rSkzw==
X-CSE-MsgGUID: UO6cG44wSUq4HWP8DsQDYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="62582201"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="62582201"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 14:31:00 -0800
X-CSE-ConnectionGUID: Ado52aXlQiCaG8qaO87T5A==
X-CSE-MsgGUID: WpeEgxXzTLW6JbPaQta2JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="105530469"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2025 14:31:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 14 Jan 2025 14:30:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 14 Jan 2025 14:30:59 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 14 Jan 2025 14:30:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdmV+Zezuf0ma+BZjNBCe4aVwkh7KuVt4xTbKEuXDKMpyg9wUPaEfsAW9qyDNG3yJCbDXCOUDKsJDbLDNINPiWgQByrRRFw0iOyz3H1TLIlOsx2ECVdoX1jYFmfhc8nzHqGKLr9YZfxtBG3duCvGdjq15C7VVSycLMRSE7wKiNFnWw7wCs54RKQYkMwbBGROazYLyhYw1mr61wGM/8ZmTXoq/mtn82ixZL8DnARWI22SQosGp2nd0B7cbbemc3aEI/4dzBUGlr7e1zB5MAPSSSjJFe5FkVwZ6kdIGSYgtE5Gi05fcVmDI3U5+gRp0b688Kgpa3m/WNUkAPpSiC/KvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGfaYgTYTnaUBCGFPHi5CWs4FbO1ef4wi147QJ/BDu0=;
 b=fElq6pvplsQfRWf6UjHLKUd8G2OVkEfxqZFvhF92qFDZ/iIVKrPKIfXbILalRD2JFumXvVZq43P+UZRFKxqdwfsbV/Fv5I667X6Y2HF7OQ5YazBGKLARPLQU54Fzafg4D72BnQsti1K7+7T+dR+1B3Ul0XkjBbvZ4zP83XQmiuXC3EwtANnTn371VOdyQizCb+kaA2rKnjWJkJ/NEcnjU5Tdc5Jer3hBKLW9l8gYyUgnpCm6SPPHpOxTgmJvZsLPE6pvkYbuQ6N3xPeH095odqYLN/j4l4oOj/nQCJJX+hcrm9KBUaMtMxAozvY2zYUTsX5T2gA/OkSqV8kFecri0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB8236.namprd11.prod.outlook.com (2603:10b6:610:184::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 22:30:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 22:30:56 +0000
Message-ID: <9223d698-d16a-43c8-95c1-9839b81c2c23@intel.com>
Date: Tue, 14 Jan 2025 14:30:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] selftests/resctrl: SNC kernel support discovery
From: Reinette Chatre <reinette.chatre@intel.com>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1734361935.git.maciej.wieczor-retman@intel.com>
 <808036fb-9a2c-44c3-ac6c-5406313a232a@intel.com>
Content-Language: en-US
In-Reply-To: <808036fb-9a2c-44c3-ac6c-5406313a232a@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:303:87::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5c9340-a307-4521-4128-08dd34eb1cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEJwRDhwdUVzbkIvRnliTmJsT0RsUnZNemRDTVpGb3M4VGlsN3VnL3pKNU85?=
 =?utf-8?B?Um02SGRCcUpGTGpOeDM1NnVlS3g1QnFDckJPaGdPSVhkb1hCWnhBRUJEaUJ0?=
 =?utf-8?B?RysvMHJQUFZHMmkyVkEvSnVQUHVXK2hsblJ0YXl6cFMrWUFYNldycHRTR0Jy?=
 =?utf-8?B?VUFOLy96emJUWTRPRzZtRXRzd3JjQW8yeS9QbWxtRjMxNXQ1UUs4N3U1SGQ4?=
 =?utf-8?B?blV5ME5KbitMQXhqdU9qV2dPRU5LUHQ1am1UdkFqNEdmbS9uaTRyamN0UW9M?=
 =?utf-8?B?aUQxeEJtSExZc0FMUkdxK1hwd1lqUklibHBXeEYza3YrNmNLTlk5R3BHKzR2?=
 =?utf-8?B?RGlUMW1vZFFSYkNaV3ZabUFIOG44VmZucTE1NkpqUU4yVDEyZVJtNGFSUFBC?=
 =?utf-8?B?cWthKzZocmFTT2VjYkVHUWh2Mk15S05IbHhiUVpJZHRIMzhxdzlESWJQZHJ1?=
 =?utf-8?B?eGxtNlNXbWk0WFdTWmdKRGxDSytiYjdIcEZEUGxuYlY4RnhnWlhXQWdON3Z2?=
 =?utf-8?B?NGZEWkFrMUh4a2ZxWDhNRzVTa1RTNWFveGxEMm5IOXdFbkNyMFlNZlN1ZEly?=
 =?utf-8?B?UzZwWjFMMU9ncVNaYkdBdUFSWThVa1FVbDdaVUNqQ3RtSTBVMnFnVnd5aHh1?=
 =?utf-8?B?YmltbDZQSnNuUkdsbTVHV25TTnVjeGFtSnM3cnR4dGRJeXB1RUp6WDJseksr?=
 =?utf-8?B?Tm1RR3NMVm5xbVJBaFNCVUU1VzZkRm1EcElnbzg3TjdxYVE1M0lLNkJvYTdC?=
 =?utf-8?B?dm1ZZ1ByYWZUSDY3TlRrazhQdkVRS0xEbWRHbTVkUzRad2xoRlhMZWZ3cjNN?=
 =?utf-8?B?MVBmaU8ySm5DRWE2MmwrK1JsaDlhUVY3TlJGcG54TjI3NXArM25tMWQyYzIz?=
 =?utf-8?B?OFNpMWJZZEkzSjhhM1J1SkhuNExlb1R4T0VWVi9ncVZrbWNhVWpFYy8yQTIr?=
 =?utf-8?B?S1VGanJ2cnoyMURuSlFwRHJTenpsanFKZTdzenBZaWNKVUh0MDd0SHVSbUs4?=
 =?utf-8?B?V0VIOE52eDNFc3pvTkNFU2V0M2xZVVl5Z2lxem5XS2FCOHlYNnRLUzNDQ0M4?=
 =?utf-8?B?bkg2Ri9zamw0ZzFUSDk2R3RRNDRYdXc3QmlWd20xYnR4YUwyRFN0STRoUDlt?=
 =?utf-8?B?bDRia2gxWFRFVU1mQXZ2WjhQVVBUbk9CTllSWXhsU0ppK3ROWmhQRDRKZm4w?=
 =?utf-8?B?cEtJYUJvT29zWVlPRzNGWTdMQTd6OC9mWGI0ck95UHBFOUVoQit6TzhHcUxG?=
 =?utf-8?B?Ynh2Wld0a2Z0REtPa3pZeDdibWNyUm91VTMrMzRDMkxXWExQRzFuTzlxWmdL?=
 =?utf-8?B?c0hobDBYNWlPbmgvWkt6ajkrZVJqMU9OOGo4QW9rRkFGZTdXUUVyK1JGbVNk?=
 =?utf-8?B?YUtvSkdVSmFYUlBVd3ZjcjFuZHZpVEtWVE1wMHBqYnIrUjNZbnprY0kyWTJh?=
 =?utf-8?B?NGU5dkVCTG95clZmdU0xTUpFU2pnM3pMcTkwaDNlcThqeC9ibHNmT0hGSEM4?=
 =?utf-8?B?SnJSYmkxdWZLbVp3M1BEODRsZ1JUSGFKSk1JS1pneW1NcWJqbHJ4RnNvMWRS?=
 =?utf-8?B?dnEwR0ptVW5YNXFkT2Fwb29rUytiRHB0ZGsyYk9MSC9zNFM0L0hnQUhyVnVa?=
 =?utf-8?B?eTJjdkQrTzBWYXY2NzZUSW9mVmdXOS9wdWNJK0lmcnVwbG4zajBJaXRTN2xV?=
 =?utf-8?B?K25MN1FNU0ttZXQ2QWdkcW5PVHR5RGtDWFFaNklsWkE3QmVZd1JuMVJoclYz?=
 =?utf-8?B?MmNjRnN5MDVGT2JTRmRQdnkxU3BzQjJlTmNncFozdHBYRHdCcCtXelJqeTR4?=
 =?utf-8?B?Y3YxMHoyYlAwTThod1J5eDVpRms2L2hnRTR5SWJ2QTErWW1VbldQdWQyUnk0?=
 =?utf-8?Q?Kh81DtPtB8P6A?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjBOLzNxaHQzK1pqQ3psaU8zTmkwN21wVytQRS9GNnNoYzdrSVp3bWpacjVn?=
 =?utf-8?B?SjRVdy9jR1dDU0lrSzNiUmRXejNUNzZybHp6THpVVW1KQ2VxVXhtdDZuOGdX?=
 =?utf-8?B?TWluMGZ0a2hQNm1hY1RxZkZHamdneUUzZ1Irck4xY1dvQ2ZQdCt1VGlUdllq?=
 =?utf-8?B?ZVJJL2lGYkc0NDNnQm1ZSnE3aVYwVGlSWmdzODNDenZMZnlQZTJoSkQ5RGR2?=
 =?utf-8?B?WWhhT2Vzby9NK0ovRndIZzZxekxLamR4bXp0VnRTSUg4Yk42ZU8wekJmM0tQ?=
 =?utf-8?B?ZndUUm43REN5dUNaTjFzaU1ZQzBOZTRBcVozMytFNStCTVh0RnZ4bGZRNHhI?=
 =?utf-8?B?QTYvVjJ1ZVZTcFVZWGdscXE2azdkNWNKa0wvZ0lCeDQwczNVdlBYeUVwbCtz?=
 =?utf-8?B?UUlhaldRWktXcUp4SGZ6U0RKUC9KT0lFcndxV0hvTGduKzluMjBzUG5vRHhE?=
 =?utf-8?B?dk5ybkM2WThSU1lwQXA1UlVLWHhNTkhETXdIdjJlVjV0b0FZQ1pHVGlZWWZM?=
 =?utf-8?B?K2pJSFNtS3ZlRExORzdoSksrY2xBV2ZJZDFmZkRZUDVMQmlJRG8yeWJ3djZk?=
 =?utf-8?B?VWRhbHliY2kyRjNlcGdhVlIxYkljbU91dUlBYzgxZkZvNnNCTDJ4eUxlM2ZP?=
 =?utf-8?B?eDJjeTlEQWVGT2FWY012U2paZWlyZXd6Zm5Nd211NFBYaW1OV1A0NXVLbW1H?=
 =?utf-8?B?QzZhZ1dGb3V3VG1nNE55aEhCWjVCdUEvY2RmRkJtRjhUaDBXRHdJaUVHTVU4?=
 =?utf-8?B?VWU1cDRuRGlkYlFocE9qV1dOUDd6MDNCa3dOYWUySFZGaEZtOEFPMXQ2Q2pp?=
 =?utf-8?B?cllPREVIK1lrTU9SU2hvUzc5QjYvTDB0aUFIMUxPQ1BVZUtOT3huSkM1Ym5k?=
 =?utf-8?B?bm9YY1M1OTZTQ1oyVWNtWlhLTWErUFBHVFI1dVp1ZVdkQ2lvdkN2YndWTlZN?=
 =?utf-8?B?ZEFaZU5jK05pbTNWK0VuTC9mY0xCR0Q1c2pwNHpGL25aaGhrSVJLTjcxTUhy?=
 =?utf-8?B?U3FPcGh3S0FlZGtySjdWbUZ4V3RTNnFURVVHVzY2U1hxbUMxaDFHZGoyZVhr?=
 =?utf-8?B?MzlXWUZaU1VEWnplQVJFNkNRWUYycnZreXZ0WXVIZWE0bEd0bFVXUEtDL1hM?=
 =?utf-8?B?SEw5YjlqQ2JhekFXSno2aDhDMWdmQU9Gdm0rYUhhRDBNZjd4b05DTWlZUytm?=
 =?utf-8?B?NWwrNTdMVHEzNzhDTjdIemlZVC9VT05LSVBCNGRLemUyNi9pbnMzYmE3Ny9I?=
 =?utf-8?B?NGVjTE5JbjhMQ2JFU3l4bW9wWXc5aGtpb0ZNc0hPNU1FaW5MKzY0VGx2dEZk?=
 =?utf-8?B?QTVDQkpEWDVEdzVNUk9rcmZ4UTZaOUhKbGlCMGgyM25uZVNFY1NtNlpxK1dE?=
 =?utf-8?B?bVVyZjdlREh1aW9HbkFkNkVyZE1ERHpRMk5iRER1a09Zektva1VlTVp1Nm0w?=
 =?utf-8?B?VkZYOHBuNm9uMzdLRk4xb0E4aEZxOFNDYTIzTVFhWFd1ZkU5V0dmamJFTU5r?=
 =?utf-8?B?c09KTllzdW5LUDZDR0lhUm43N2kvd0VROTZWd2thR2JKUFZVUUJzSlZtM1RD?=
 =?utf-8?B?ME41QTRiOC9FcGwrK1JYMXJ1MGQxTjYyMWNjV1lTQTE4NE1KNXpKNFZHSGhm?=
 =?utf-8?B?alRPU2tNUEMyY0dBQ3J1a1hUZkp3cC9wRm1SVkVPdzVOUmVCTUxnK3g2d0Va?=
 =?utf-8?B?VnN2NUExdGRzTVIwMmp3Ly9xcE11cCtTRHhjZjRPSmV0YnBZcDEzSW52T0Yw?=
 =?utf-8?B?NlVvN0lYR2oyL0hHMEUzeUhQQkMyODZpMmN0c3VXbEt1TUpmWU5sTCtZbndr?=
 =?utf-8?B?KzYxL1JwMmp2N3VxMDB1dk0ydURyMUJPN2Q2aHROMnJ1b0o4a0VXMzE2R0tz?=
 =?utf-8?B?OUtPV2xWa0RGYUVwbytGT1BmZUF4NnZxc2xZTnIyWGxON1kxMmZJbWF2Qm40?=
 =?utf-8?B?dm9UMkU0bEF2ZVRBUGpXMFhCWmJOQVZqQ0IranpmVmIyaHdWSmIyS1FNSHVq?=
 =?utf-8?B?NVVHQ1ZaaENPSGtwMnJ3UFhCY1lUQ3E2MEhCS2FkVVNrNmpoWXNXaFNzRWJM?=
 =?utf-8?B?K0NDc1NYRkF6N1ZucXVDQkpIUkgzdjZVd01SR3I5c1pQVFQ4ZkJPRnJLL0lG?=
 =?utf-8?B?NG83Q2JQSzR3bzJhaW41RGNCSWdYNjJsVlZoOXY1Slh2cmVOaXI3WW5iUFpZ?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5c9340-a307-4521-4128-08dd34eb1cd4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 22:30:56.4800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3ySXASvMHva2S7WK1aHpiOxI50W9pejafEw7V/qKHFUZLhBUNZyiXTlQfAj7V6nbbo8N+Wn/UWArtTJSX/Kd2h4vLOxLvecY4d1S0RX4uY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8236
X-OriginatorOrg: intel.com

Hi Shuah,

On 12/19/24 10:35 AM, Reinette Chatre wrote:
> Hi Shuah,
> 
> On 12/16/24 7:18 AM, Maciej Wieczor-Retman wrote:
>>
>> Sub-Numa Clustering (SNC) allows splitting CPU cores, caches and memory
>> into multiple NUMA nodes. When enabled, NUMA-aware applications can
>> achieve better performance on bigger server platforms.
>>
>> SNC support was merged into the kernel [1]. With SNC enabled
>> and kernel support in place all the tests will function normally (aside
>> from effective cache size). There might be a problem when SNC is enabled
>> but the system is still using an older kernel version without SNC
>> support. Currently the only message displayed in that situation is a
>> guess that SNC might be enabled and is causing issues. That message also
>> is displayed whenever the test fails on an Intel platform.
>>
>> Add a mechanism to discover kernel support for SNC which will add more
>> meaning and certainty to the error message.
>>
>> Add runtime SNC mode detection and verify how reliable that information
>> is.
>>
>> Series was tested on Ice Lake server platforms with SNC disabled, SNC-2
>> and SNC-4. The tests were also ran with and without kernel support for
>> SNC.
>>
>> Series applies cleanly on kselftest/next.
>>
> 
> Could you please consider this series for inclusion?
> 
> Thank you very much.
> 
> Reinette
> 

(bumping visibility of request made close to holidays)

This series still applies cleanly to kselftest/next. Could you please
consider it for inclusion?

Thank you very much.

Reinette


