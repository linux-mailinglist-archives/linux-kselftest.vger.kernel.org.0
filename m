Return-Path: <linux-kselftest+bounces-21502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60619BD9B5
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 00:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BC91F21D44
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 23:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED45216A1A;
	Tue,  5 Nov 2024 23:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lsKI3aNs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9208F1D415B;
	Tue,  5 Nov 2024 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730849338; cv=fail; b=ISXYbap6Ixq9lJ6WIYcgfdgTQcuZdPN5j5UGeGoRgKU1aDoAr4acZKT1Un41EFMrV0gIgkbepw93TFJPVoSrUVALN9nHiiLpWCi0ZnxJDBI1VE/Z3Cb+dJXCzQ0MF6A3YrqsNLRlGQgflOPT9JLy9HT62rzvg0SHoF19HXCTOeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730849338; c=relaxed/simple;
	bh=BfrRKS0sQ7qJ5EYHn2WySaTmCHYTY41/6CarlWwwHwM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NzjKXrItmgtx0alwkDETEoL+tC0AWIM3ronpeMPe3LiuyQDle4cuAmXcHCHEdwAeXB2kolNhkBGwGPIKkB+YpXsPaBk0znANSJwP3HpPHSSpILdJSpXDgIlDyc9J5LqEGg+6rTOCYm8Aa/m00rLNKOYHsFQ6ZvPcbv0fgXbT9do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lsKI3aNs; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730849336; x=1762385336;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BfrRKS0sQ7qJ5EYHn2WySaTmCHYTY41/6CarlWwwHwM=;
  b=lsKI3aNsAKL+a+ZwPTff/A7kZSKluZJRrSBB3dShaR2ftr18nj9mlWih
   H8CLfOaMhare2idf4SfuQcdQQ/YLB/+j0y5n5ztC+5KtuTcBtOlIrLeBp
   ooByxxqCXwnemZclLL3C2Y7Fs4LVXIHynlEXBVDBupo+5/b/cjf0bbqsA
   EsQcZ78yn++GeAMWnnjIZbQH/XExhMafQm7EqC54QnCwDfL7NAse+VpRC
   ykaxLP1ksXIWweJ4AEMwrhOlDX2mSBlYzi1c7CCdgVo5FTVCb4b4V60KJ
   7e9APBk6AwJiEE4iX3bSN38zYkv5VhqFAQRw5Sh+Pax6wd3wqWW1FybJU
   g==;
X-CSE-ConnectionGUID: lnU2G4p+RfubyKlk/rYr5Q==
X-CSE-MsgGUID: g+cSYzDkR1a2gC0tQawFfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30788476"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30788476"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 15:28:56 -0800
X-CSE-ConnectionGUID: KRksm7OhS/SOaqTovUf/bQ==
X-CSE-MsgGUID: K84IeHYmTsuSIW18Y/QJjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="85041840"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2024 15:28:15 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 15:28:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 5 Nov 2024 15:28:14 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 15:28:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gn4gXfRBc+zH/ay8rU5iO8GL0v1U2dPmFslUaxwyJucX3x71oHyM60NTEN+eTGjw8kcn89EJH/7F3FS+qKxcKNRtqplbK55DvL3yVJJWo4FwUxvuZBDkCrLt27Kob2b/lIbb1Ivcw89EoHHeFdLYc0cuTDYXHTrnnbFijf9vuI5WhDyb9p9w2xoEUQAcrLPhdeyWf07JTtMMGjpvhDAZW9Nuca+Kep8fM8aMnkf15JJwREdsDNfwUaqMxpNXUky0Bujpq10N+BsF+6GomjyDKjxhesU+rj0UvYtcCnqnJu98VFn6//B4AKV8YQuhS17USfP4F4eIsi9rNJgmN3YdYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XK1i1Mk9HNlkVwsYhW0DqBG/Hl0z96ihCMec665SFX4=;
 b=w37nr8nEZKP3jmvB5Ng9xcAt8/5q1iubCShAi6ZoFgafyLkAD9iqEd9mGBF+OOIW/NSJx9NhslHvNwOo9sNuc2FMghtcNFkLfjRcYKZ9TRbeqWX2xVEd5KNlisRqYbm8JRHm9fm3LD1SyF2Yk2N2Pq4CWYnnPuchYOK5F0UUrV1lMis5bvWajP1YbXiqPeTcrQZYNxoztRtFDjFPjZ+Jid0COGTsLypbXdB9Xk45PFrS6qXwSiarYXFLqJq73giXsGUj44Vc5/fR4oQTgMWx/UVuvYFqIjtRlgTZtdJBPUvfQ84a0d6qPqH5l4UORSuuw2D5dgXklfheHtjn/RQR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB8133.namprd11.prod.outlook.com (2603:10b6:8:15b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 23:28:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 23:28:11 +0000
Message-ID: <e382e6f9-a9fa-44a5-aab7-64c1152eaad1@intel.com>
Date: Tue, 5 Nov 2024 15:28:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1730206468.git.maciej.wieczor-retman@intel.com>
 <06c8f3e64b8e59e031fc16a919373a0dfaa9516a.1730206468.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <06c8f3e64b8e59e031fc16a919373a0dfaa9516a.1730206468.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:303:8f::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: d26581dc-a60e-4b82-1d76-08dcfdf1833b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blgxcG1CbnBYZWcxc0E3ODAzTWlDamU3Y0dISHpUNXg3V2NQeG45N1RQdUp5?=
 =?utf-8?B?UjlaOTZidGl1d0dYS1YxTVJjcC9aSDBma0hxdXpqTkdudmcyRVF1SnFlUk1s?=
 =?utf-8?B?NXgrRWFpOHlUckFpRDBNZWVHS09xc1E5RTNJQWE0b0Y0bmh1ZlNJeEJtVE9m?=
 =?utf-8?B?eXh5eklXM3J0THdQRGYyNW9BTm4wR3JxdVA2eGQyY3o2Y25rYVpDcFk5N1Av?=
 =?utf-8?B?Z2pLaWZHWnF1SXVoVjRFRkZJQ2xtUE5wVkRNZ0lVZTdYQSttTGRRT2s2a2lL?=
 =?utf-8?B?YzNvSUxnQTZMTkx1cW5WNS9QN2xORzB5ejdUNGlWNzlwekVMcGlmdFdWNlRG?=
 =?utf-8?B?Y0g5NmsyQnRqUGpkQVEwT05YcjNWQnlJdXFzVFlpb0xnb21rUlQ4Y2tCdzdG?=
 =?utf-8?B?OGhmQWN4U01HZStzM3JVQytHc2FndzNPa3NGNUsxZXg4Z3FKWkg3R1JoeWhz?=
 =?utf-8?B?eXREZjYvTXdGdXNtMEs1NHFETjdSVHRyU2taMmhmTkdGY1p1MWtsYWZDRWo3?=
 =?utf-8?B?a0hNRTBVelJEQWFPckxHQW5LUWNvZ2k5SXE4dUQrbll3Sm15bC9OeC9GN1kr?=
 =?utf-8?B?SFp2V3VVZmpkYXFkUTlQb1gyWVNBSWtBS1pmS055OHVmRWhLaGhQR3FsNWN5?=
 =?utf-8?B?RkJSWm9GY29NK1NYa3d6aWNlVHJKZ05DRHFFaWNRaDZnelVHbTQwSEw0ZTJW?=
 =?utf-8?B?R2w5eXZFR3hjTTVWRDZNS1BMcHA2N3o0cysyZk1mWUhMMTAySGt2QWk1NExI?=
 =?utf-8?B?VmY1WEp6YXdiTTZFbzZmVEphWnMwN1Btc05HSzQ2UElLWWM1Y2hHVk10NzBY?=
 =?utf-8?B?cVVIUm1MTDJKMjhQNFdqRzlIMnZmVCsvK2J0V1h0N2dWQWNjVXpKNitRNi9r?=
 =?utf-8?B?aG9pVkhtcDFsZisrVmc5eHUwNTNOQ01wVFVyRCtRakNsMTRsOWtNNmdBbW1Y?=
 =?utf-8?B?Vlo5M2ZuNWc2c3pGM0NUeUl2NFlULzhmU25OSHdJVTJVYUVicnB5YUxKMWg2?=
 =?utf-8?B?WTU0MXp1TWFocWNXRk5VZVg4U0cxNzdxL21GQUVZbVFURVVMKzY0RHdwZWhM?=
 =?utf-8?B?dXBiemh0NVIvSjBxZFduNklIYWlEOTRCV2FOZHQzMU4ra0Y4U1ZpSHZGOVh1?=
 =?utf-8?B?Um9NKy9ER3hicjhVZmNYSW95RjNKT1JQUkFzM0lxSFkrQWpCRk9RNHF2Mksy?=
 =?utf-8?B?UHBuL2k2TkUrcFlJekZxR2g0LzNoOU1GTThpWEYzOGgyN2dEdTJZWCtRUS9m?=
 =?utf-8?B?dFVKU2NvcWltemtFcVppUmJ1bnJlVzcvdkZtUEtHbDA5NVNoU0ZnaVdWMGVS?=
 =?utf-8?B?Tmh4aFp2VHE5T2dRakRNaElxRDdqSEJQOElLNnh5NUJYeGVicUdhaGd1UkUw?=
 =?utf-8?B?MFl3c1dqT0VRR3FyZnBPZHlZOTNxQ0x0Mnd6V3BKNE1jT0hZZ09QdEtENXhk?=
 =?utf-8?B?QVFuZ2puYXIyTDYydUxIOXg3SDMwbGZUeE9mdmRwcEZrZXJjZEYvbk1BQ2Zy?=
 =?utf-8?B?QUhQdnhBNnVMNHY3ZFJ0d0ZFTWVtV0xNNWttZmVSbWozc052eUpNNUtHQVRu?=
 =?utf-8?B?aWIyUVlSdGhndGdoS3hXalZBcmc4S1ZVRjVacU1VbWVHMVlJZzh6d2VvSzgv?=
 =?utf-8?B?ZndTWEZlaFJIdmJnK3d5aTRHWnEwaFdyb1dxOVBJb3ZUTFE4WnVzZmtDZ1Ev?=
 =?utf-8?B?TE5MUGxoY3V1N202aDQvNlRoMnQ0S2JZL2ZVWi9adlNMTTVJbVo3MGZDWHVD?=
 =?utf-8?Q?whNDjQ4Kl+xHvojpfTfhsl2MwHy+MoA8f2ZshXM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFRzaThvTGpNbFRWWDlPUEFOMnVlakVLS1F2TlBOR0Nscm1MeXFIU0F5SnZG?=
 =?utf-8?B?eFlhRy92U2lKeUxRMHZOSENsVTQ0VjI0VVdMUDFPZVZveGhnZnpkWjdpKzNO?=
 =?utf-8?B?Zzd3c3RWVWg2Q0tId1liZ3ByTi9CQW83cFlFRlFWbTFzeTA0WTA5M2JDZElW?=
 =?utf-8?B?R0xOd0lMOGd2Zk1iUUpXVmtkb1dzRWxoRG96S2RlZytEa3BYZWMvb2hFL2J3?=
 =?utf-8?B?TmMzN2RJQi9IYlRXQTZiZkNHYmZPYjk4dGdiTWpsbm1qSjVxdnRHMzBjbjBI?=
 =?utf-8?B?QTE3YW1zY0xyMkEvZ3JnRXFpc2Y5YjVDSCswc1hkQXJaM2lMUVhRQnJUUUMr?=
 =?utf-8?B?WDNQQ1E5eFJTZmY5eEZHTlZ2TEZYY1pRVG5hYjYyS2RTOTFPY2JQcS9haDh2?=
 =?utf-8?B?bnFuMkFuL25JSU1PQmxJZGlmcm9zakFJcW5oamhmbnhDSTYyM1Vqbm1DaS94?=
 =?utf-8?B?TkVuUk9rYmVRSG0wcXF5VHI3cEtTV3g2WXFud2M3U1FrQm41YnJiWXJ3WVcw?=
 =?utf-8?B?emlwdnpOb1FyaUNSdE1WK0JZL3J0Q2ZmbTl4N1V3R2xMZkY5KzRHVVl5Sksr?=
 =?utf-8?B?eFQ1V05WOGxpb3QrWHdFelpibkZUSDZBeUFISXovWWlYMGVtbXAxbDFGZzZE?=
 =?utf-8?B?bnRQMFIxM2kzbFNOYzc2Y21rQ3g3c1RBTWtPRG5vVzVkV0NKVUhUWmY5NGdG?=
 =?utf-8?B?TUNDRUFsQzlFZEdQeDdWSW0zVUk4MS90RWJNaVoyYWZtekljSHIvVmJBNktk?=
 =?utf-8?B?QXRjUEd0dEd0Wm9lUm9oNzRaMjNqUmRDczVEelZCUnNiMy83ZndTbm5tUkk3?=
 =?utf-8?B?OENpVGVCSHIweXZwZW5sdERIRDlHUUdqY2ZybnUyUlRWVHV1T2JlSlEwYTl4?=
 =?utf-8?B?Q1NsSG5zMWRBKzRqVFNYUS9UWGNoSUxKWENvTXBuaU1ueDZ2MTN1YTczSXBr?=
 =?utf-8?B?b3phQkdSWmdxVmM2N1U0blYrMjhBZ3NGbUpsakxkeldqRVdEM1lQSFVzNUF1?=
 =?utf-8?B?K05pdFgxQXF0b1UvRE42a0Q3dnJudTJ4RUx2NzBidlJNY21tZTYyUHdUV3kv?=
 =?utf-8?B?Mm5SNGs1NDRpb1RFdVJzN0tiNlgzQlNPaExWQU1tUE82dHFuMHpjMlZ3OUpM?=
 =?utf-8?B?UlJDNkxnM0VUUDVGRHoxYW1TR0Y0WEdtK0dvL0kvRlhDTy9Wall5T1hQd3M0?=
 =?utf-8?B?NytLbjBsQkFMSndYQ0tkbjdudFZwK25VZW1GQVJueFBlQ3V2RzJNMnhCQTJq?=
 =?utf-8?B?cjREWWdFM08yUUhFNjA3Vm1tTjFYU25wMmcwMS9PZGlVM0g4WksxdzFvRDNZ?=
 =?utf-8?B?c3RrekNNOGpmaGllSTJGalgwUnRtYXJrdzVSQjhKQTJqSWpEZXFJMlNHaUxm?=
 =?utf-8?B?NlVQdDgreTlMTDVtMGczRHJISUoxSlhjLzdZRC94TXcxcnNOS25EL1VKQWFB?=
 =?utf-8?B?cmpxWnFoeHB6UGk5ak14RnVzb2wza0U3d2MzTnhhb0wvS2plVDlJZzNYMDZM?=
 =?utf-8?B?Wkt5Sk9rL3FKWWpHSjVwMmpxc09SR2RERVlYdnk3K3hac0tYUS9ZVE5lSUdF?=
 =?utf-8?B?T0JuYXlmQXA0SzFHaHprUkZQSG1lRE1laDBLM3pNTndKMFlnM3JKM0NHbUw4?=
 =?utf-8?B?T1NFU0w5MmpINS9UL0NjckpSYm5mWXh5TzhKSnRJK0JEMjhmQUNOTC9kZnJ6?=
 =?utf-8?B?a0xyVVBsbHg4V1NzajIwK2hzSnRoTHovdDhpdnNtNStvODlKekYxbk1qcmIz?=
 =?utf-8?B?NDFlNXhuZ3k4UzZpclpwY21BUHZuYUR0ZTFvZVh0Y0w2NHVQNXhhUmdyVExn?=
 =?utf-8?B?TzZjZFlCTHN1dGs3N1NYVUI5NW5FemZ3RXZQL2NzWUlYNmJVeTErS2h5emtF?=
 =?utf-8?B?WGo2djB6ZnBTM0RUTFF6WlpESHZtZVJ2c2VUR1QzQldsbzZ5UW93ZHN5M0E2?=
 =?utf-8?B?bjQwcWUwU1RNMW5Ock8xa2ZsZkhJUTJEUmJIQ1FNOG9uUkt5QTNGVVlGaVd1?=
 =?utf-8?B?a0hBY09qNEIwenczcG5uOXNXbEpPKytwUXBPc0RwOEYwS2NCWGY0TEs2Lytz?=
 =?utf-8?B?TlBzT2ZEaE9qSmxtZ2RKQkhjWHU3b3l5a095TXA1RytsdUpBVnJ4RGNPK3Fu?=
 =?utf-8?B?eEFGaVRORzEweHRWTCtvcWE5aUNvdTRKMWp1RTJyN2tUVlZwRitHaEU1UkF4?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d26581dc-a60e-4b82-1d76-08dcfdf1833b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 23:28:11.1622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdNauVAz+bWkFgyAaUXmWOxXdHnRzGLAZxlDt0eqVGU0WXjLgDWyz35D4jbM6k6Zfpb2Z0tUqFB9vV8/x6ceDi/kaPWqNU3wbOjrHkU/sIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8133
X-OriginatorOrg: intel.com

Hi Maciej,

On 10/29/24 6:00 AM, Maciej Wieczor-Retman wrote:
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 2dda56084588..851b37c9c38a 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -11,6 +11,7 @@
>  #include <signal.h>
>  #include <dirent.h>
>  #include <stdbool.h>
> +#include <ctype.h>
>  #include <sys/stat.h>
>  #include <sys/ioctl.h>
>  #include <sys/mount.h>
> @@ -43,6 +44,8 @@
>  
>  #define DEFAULT_SPAN		(250 * MB)
>  
> +#define MAX_SNC		4
> +

fyi, it seems that 6 is the new max:
https://lore.kernel.org/all/20241031220213.17991-1-tony.luck@intel.com/

Reinette


