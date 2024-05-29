Return-Path: <linux-kselftest+bounces-10849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732D08D3DA7
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 19:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6625B251FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 17:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911A0184110;
	Wed, 29 May 2024 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1/Bi6Ru"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD33B18734B;
	Wed, 29 May 2024 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004903; cv=fail; b=YIA5ESkjMqLRMTGYz5nA0PsLcYzAMuf9v0I473W8r2v/Y4G2gif4gEs4r1Gn/LInbwGFTz3kNGK/CXG/UqHixk446PsAWxVf0EOgcNIuwlIDbRxeaB0WyL5wUAFh75NQT2qjbnXFHfo5iUm3FEnxMLBLe1Q2mQL23p6DDzZXFnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004903; c=relaxed/simple;
	bh=ch4xJdqEMLJ4xqciEwuaBNR6snh8/s7828VrHwh/OfE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QgIFVuBBsNDm8+D/k3xv9d9K3FwOQA0xIjp8nuUj1mzBd4B4xHLrSXGNiBUH0S3H+kte4jds2nQ6t2QekvpZXNEqjOne3gnrFIVQVafzyOGSr/T7og3FBOVT9/rzUjOBxx4rYKO0jr5Byz4IJgKFvO3Pbff1WzNfwGPMi98x5UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1/Bi6Ru; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717004902; x=1748540902;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ch4xJdqEMLJ4xqciEwuaBNR6snh8/s7828VrHwh/OfE=;
  b=I1/Bi6Ruthz616H4fAjoSMoEDZJjpbVbDZFNz9uzX+1jypbBejGpBEH/
   qrPOui9OSolEAGRbx4n7Ko8ecGSaGGU57W368ktDhnZrX6d2cg0ogsBXN
   +Iytr20ERwkZuKjEP/IUFvun4lfNBsP+fbSKhinEuxUWzHCXGAe8VdFV2
   b7qOCm7TN5jdblrTOvkgmwf2BvmmRPdXzEm7IR81X2lCTBT+apBukEacJ
   fSgXoHgMdM4bdxZAGdLOCHz1YvK2Ud4OAiig9XoTf7BNyanBSq2mu2+KD
   JFRCIhxSHtPog/Xz+ZzA6z87p4ykRiIClnbaljj3GT1wLbYecHQD7+56q
   Q==;
X-CSE-ConnectionGUID: aTuWpSNhTE6fxmvt4cnxNQ==
X-CSE-MsgGUID: X+pQH/onTFu0R5sbfg2cCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="16378311"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="16378311"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 10:48:22 -0700
X-CSE-ConnectionGUID: tP4+pwLASC2t4qLo6p1gJA==
X-CSE-MsgGUID: DVdNAKX3S22pjKDGYDeJDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="66393497"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 10:48:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:48:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:48:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 10:48:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:48:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3mvhIGEAYnmO8Y91qoif2VzFoZ/xzwK4lw/Fb1HkKx5NQqsMCDnoHSs83Tfab2tcjjssiA642eV08pj2mBPoIKdzrvCN/NKtbcznKUgzcgOlyCIdwVybTlU5R6++biYyeagVOaeSjqKVCq2zj98vaC73S4Vhbzj9P80RNSSvbNbpYPdIT564FZ7ZjBs6olzGmxooKKooQBiOISrWDg0OBYT6kvGLDUNRaT4rh7yW4PbDUOW74X0lzkZlgFVGfdKghrztUQBU7tFM/D/WQ6lmMjFRMateteOqaHuoXaWXWTQZt9tu5cLqmOd5czKuFvFyO6SUsaa3fDg0IgXR6sa0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chjtHlyi+dKpz9zF2czqJUQAtZbtBYR2Z93p50eSez8=;
 b=Zzq0A2GwFnelpgpvIg1XsbXHAxJpeQSO9jdC1kFkXujyDcv8gnnjy89HeghDqWcG5FEqtn97Qr57woeD54aIvOcrGhd1yq5RwIqwJHCf7pCMo42CziOxHnC2y7SDA9i2QCaasM8HMs1nacGIhHah36KS3bP8ZZH3gC620QNeFGGBGeJbb+P98tnbP2W3CwznstByo2TEbQ727qRLG9H3EoGq/piPJZPtsMmMulK8+vlPljaAbqJlZGZ4m6x5KMMlZw425MjsSdJKJmCN06VR1mCDm1rqLe8QkuT41dnP7A3u2B4COWDH1fGORWCw7JZhpfKS7aomm1jSRNJwV6KE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4587.namprd11.prod.outlook.com (2603:10b6:303:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 17:48:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 17:48:18 +0000
Message-ID: <fb5b4f70-a983-457a-84df-59a237055f5f@intel.com>
Date: Wed, 29 May 2024 10:48:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/16] selftests/resctrl: Add ->init() callback into
 resctrl_val_param
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-11-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240520123020.18938-11-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:303:85::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: 0590e152-7994-45fa-8b91-08dc800785fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEVrVDJlVlJjVkZ0UzNTYmo3WC81OUVCUVU4eklpT3NEeUJRYTQrV1lob3JL?=
 =?utf-8?B?YVhzTHBKL0FHczBvSjZrQmEyOGdUYm5QaUllS2hJRk4zT2d5TEFQd1Z5Z2NB?=
 =?utf-8?B?SEtaeUlrWCtnWnFPQ1dla3VXZFVIM0RaWERDcTZGMTl3aEgzTFU4NllaTnNB?=
 =?utf-8?B?VVFpbTZQeC9VL1FwVitQSmt4eWhHcE1DWCtwUWdYb1AraHFpNmpTWUhySFZ4?=
 =?utf-8?B?VUcwQ3hQNGE4U05jNkZNY1A0VFhHRUVHbDQ1Qk8yRHRzcEJuc2JnbmN3TjV4?=
 =?utf-8?B?QUU0UnVDRldOZGRsa3FQL1Rsd1l5ZFkvUkFua0dkQjZQcWpxUG40aUNDWFpi?=
 =?utf-8?B?cHZ3N3N1OUM3UmxzMWZIV1IvaHNKSnlibVJSMnE4Nk9UUlpobkdZSVNrL2FN?=
 =?utf-8?B?YUZiRUpSVmJ0YTF2cUUzM2dta0hTN002UEU5ODBiSHQ2NC9nZW0wMGRTVGIy?=
 =?utf-8?B?TjJIaFVPMjdIaFlubVAxcC9hTW1aTGNLOVJGYW5CYmh4UmlETjlURFdaRitD?=
 =?utf-8?B?S2EvS2NBdkJHSlc4cWV2SHJTS2JLazFVSjdiZW9pQlNCbG0yNGNYU3UrQlVF?=
 =?utf-8?B?RHlFOEsydC9qckVtZCs1aUl1VGVJN0R4WFJ0NmxZdXRub2J2c1ZJdTlScDha?=
 =?utf-8?B?RUgzVVFsb3hyWi9RRGRMcWZGZjhZN3NPUWY4cldEY2pEcTMvZVhrdVN1NDRJ?=
 =?utf-8?B?MDFVaW9ROXIvTkprRDEzeWxvaTBmVmFLbTBKaENpQXVHTTJUMXpvYWxSM2VO?=
 =?utf-8?B?M2xjalhqdmcycXN0N3lDODZLeCtMUUprN29zV3BVWC8zc2Y1MVFFa1V5aWRS?=
 =?utf-8?B?YnpQcFFhOHFhRnhkT0VaVGgvRXVjbHdnR3BKUU9sbzZKbUl0RjZRTjB6VVpB?=
 =?utf-8?B?NzE4WmJtRk13a1lmeXloSU9oRlpHdm1qTUR1NzdEWm9OenJIUUttT0h6alRs?=
 =?utf-8?B?NEE4aXhEVTY3UXAyM1N3cjdUQUpNdFg1cTVHbGh1SHZMbCsyQm9LaDdHZkFL?=
 =?utf-8?B?OVNwWWRnd29rYWE3N1hDc1hpdnJkWUlsMFV1dlpBeWFlVkd3dWE4TTNwUVQ3?=
 =?utf-8?B?bXJRcG1UR0xuWUhRVHJwV3NWNUJQQUlyZEx3VHlTNkFkZlZIbEZ4QlZsZC9D?=
 =?utf-8?B?U3JKSkpRaU5LdVlubldyNVVwQ0lPemh0ak91aW8wbGI1aUdPczJKMFU0U29X?=
 =?utf-8?B?QTFIVmo1WGpSRGxjYVFCYitRalNrVnMwcGFCUENLYUVFOUhDYm9mUG1qV2VS?=
 =?utf-8?B?V3owc1RENjA0VU4xRGhWRTVsVDEzeVhJbkZORi9pS0owaklEOUJCa3JYNTVq?=
 =?utf-8?B?WDBwcjFvb1VHQnRXZWltT29OU1gvYWhsLzRMR2JrejM0N3pqOWtEZFBEQTBa?=
 =?utf-8?B?NHB2SDBWTzFWMUxZcEZxcUpVckZDbU9yZ3VVWEtQVXJiN3paWUlWQWpOcFNE?=
 =?utf-8?B?bENyL1ZJRHpjK1JGK1gyUUF1aTdSeTNKWnhFUWRBVkFrTXR6OXphSnN0dFNG?=
 =?utf-8?B?MFdYVEZybnkyUys2S05mNUdtNUtRWHo0YkNuY2c1b3R5UFFvOXR0U09NNVRi?=
 =?utf-8?B?djJMb3FwTGFlcHJueGQwZjNZZ0RtbVgwSS83M1JpbjhDMWkxSXdjbEpNeDMw?=
 =?utf-8?B?b2Y0ZXBwdjlyUUx5Ui9jbWwwVUhhU015SCt3c0VvditlaXR6YnJzTkIxWXl5?=
 =?utf-8?B?OUNOemlpdkE3Y2dlNlIzOGpFb3JlY3QzWnM2RUVUUlRHbXN5am9hZ3dRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGFqdlpkZnFXZTRRWDRBeDBhZUpTYzhKMjVJUmVRREVtMTRDNVlUUmVrQUhm?=
 =?utf-8?B?M3AvU2t1UlV0cS8rQW5odW04ZjlIOUFGeW13Z0gwbWRKOXNjWnhERXd2Ykdy?=
 =?utf-8?B?cERpcXRheG5LMEVHN2QyMllYYzMvTEgzSzMvNXVUbFd5UGFOL0JMREVScm9U?=
 =?utf-8?B?VW1UL09waFBnL21DMmxTWlo5K3pBNmxhRzAvWEVLSnJ4NVkycU8wNUlUTFpt?=
 =?utf-8?B?L1RPU3J6OHNkUDA4d3drSy9Fb1poZXNocU9NaXZYNmdhMVN4Q0VDckdoUXNV?=
 =?utf-8?B?SG5zN25zcmF4cXB2V0JYZnAzcDErcnFJNm82VVRMMmo0NVIwcVpqSzRyRjJh?=
 =?utf-8?B?MVZaVG1rUHhja28rM0x6czhLVjNIWkt5Q3Q4bUpTUVFheFZlblh1Nllla25y?=
 =?utf-8?B?ZGFmTmZ3ZnZtSjlrTzlBTitNcDFuNTFyaFRBcjlsYkJGSm9pblRNc1N1bnZm?=
 =?utf-8?B?OW8zMWtBSDBxVjFreGljcWRtUzJTSFFyQmw0ZGxCN3ZTcWdJc2VoVS9BRzR2?=
 =?utf-8?B?UGl4Unpvbkt4cTdwRDVhdGt5b015WUo2OEFtZlhzQzlMR0xKc01zNXpUOU5W?=
 =?utf-8?B?L1BsQmVYNlczWjZhWlhaanlERTZOaktZL2lSRmV6bU9QTG9SQTNaeXhWdGNr?=
 =?utf-8?B?aGFRTEM5aXdBY3IveGhMZWQ4OU45eWVtc0Z2blI0MlMwQ25kOVExL3N4R01w?=
 =?utf-8?B?TUdkOWwwdFBVdnYxUEc3WkgvbjFWakRJT25oMkFBOHV0Y3k1UzlFbW1lcjRM?=
 =?utf-8?B?RmxLZ1BEODVGMXI0WS9jZ2pVWkplUkJEUXNSTDJ0bSt0c1cwOEk2U05xQ05o?=
 =?utf-8?B?N0o3Tlh5RmhzT3RrRGZUMEpRRThnNFY4Z2lNcFRSYTN0NGxheTh6K2xZM2cr?=
 =?utf-8?B?ODJGK3R4WEUvdy9VSGR6OGNPVmhLUnptUmJSTXVQU2F2dk5rMktOUUdiN2Vy?=
 =?utf-8?B?M2lLM1EzUk1CaG44a2FXbFBBaWNUSHBHU3FNNEdFdHFpc0gralVlUjc1YWwz?=
 =?utf-8?B?UTduVnhZYlgxNTlSMWMxNjFoTEZ4bndnUHZaR2hpZEZ6Z2ZjYjVxNjdKYUlw?=
 =?utf-8?B?UFV4dm81U29sb1lEM3k0VUhwdW5kMFR0WFJIMVFqaENydlNqZmJxUFRpRitm?=
 =?utf-8?B?YStDMlR2Y0NidXRYOWN0b2NxbnhnNjIzZWRzMnBCdSs3dTNGYmdDdUN6SEFk?=
 =?utf-8?B?NmRDUGhJSE5TVzFaUDE0bE9TSmxQYmNERWRjNHQ3WGtJSzh3cHZVMU8ralVs?=
 =?utf-8?B?YVUvUUt2WWFnVjVHYXFEVGh2Z2R2SmZrOExscFE0aE1jdVhjSldycGQyVk1m?=
 =?utf-8?B?TFhBYUFmcnpSL0JVMzhHNXllUHlibGpWMk9sM0lVOTdkU3U1Q0MyNGpOMjds?=
 =?utf-8?B?U0VNN3VPaDB4NWdiZmRGNW5KYXd1eUxIaHFZb2k5Y2Jvc2VZQ1JBdGtFQmxF?=
 =?utf-8?B?b1ZFa0lobEl2VFN2eGVnQklncmFKMUpVVzV5YWZqdHk2eThFVHd3dVVOUE9r?=
 =?utf-8?B?WWZqaEU0K1RpbW5DeVNnNjR3dWFQMnlyV1VMMjlGbjdUNkc1cWlJaDNJWTZs?=
 =?utf-8?B?WWRoWnhIOFdXSlFIaVV2YzhyTVU3d0l5UFR3ZkZvUk1zZzhnbkZKTktBcEtp?=
 =?utf-8?B?M05QSytkaWUzWFVpT0lvN2VWN2dRVXlsY3NHWlc3eVpRR0JuU1htRm5EaHVY?=
 =?utf-8?B?WFFJOEg0KzJ3VXk0TlpIVG1RRXgrc3JkeG1acklKN2NsRzZPSjFsdWc0K2pM?=
 =?utf-8?B?c2t6MkRXb2h4OHhhMWlhRzRkRlVoWlZJUGZhcTdHNVMvb2ZOSlFqZFJoeXNr?=
 =?utf-8?B?c1EyWmtvbmNZaTUxL2JWNktYc0dZSU5EV1d6RW5uSExBNXJGdllnRktiSzJE?=
 =?utf-8?B?TlhrcE5yR1k2Vi9YSldCN3FibDFmdXFrNUJTL29rL1U0M1NNODZ3VXlxRjJj?=
 =?utf-8?B?cVhGSG1jMFczcU95L1JxQjhyVGZMbDl1V3lwMVVVWVh0ZkVjeGNia29iMjNs?=
 =?utf-8?B?T1o4TFFURXlQQzM3OUordFZaWjR2RDBEZXA4Ri9GWEFMeDc1dXgrRm5WYTZa?=
 =?utf-8?B?RE5VcEY0cmRSaTQ0cThkMC9CNVQyM255VFJYeFVaMHNVUkt2b1hGeHR2RDZa?=
 =?utf-8?B?MEo5blRTaXdBYTFtRk1jQVhkdlJ1YVdCN2ZmaS9yY2IzcUV4ZmNlRWVZOHdL?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0590e152-7994-45fa-8b91-08dc800785fe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:48:18.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1G5OVzPpmkg+KFMrUaTIbIpkapZ5ou1yw03CN1eKkt+4h2R97KG5n/vyCYyYON2U23HzEJxvZ+RUxEy3LYIH92PLeeEKiUhO6eBAwBTtce0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4587
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/20/24 5:30 AM, Ilpo Järvinen wrote:

...

> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 5dc3def70669..d3fbb957309d 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -86,7 +86,8 @@ struct resctrl_test {
>    * @mongrp:		Name of the monitor group (mon grp)
>    * @filename:		Name of file to which the o/p should be written
>    * @bw_report:		Bandwidth report type (reads vs writes)
> - * @setup:		Call back function to setup test environment
> + * @init:		Callback function to initialize test environment
> + * @setup:		Callback function to setup per test run environment

hmmm ... ok ... this unrelated change could sneak in with the stretch argument of
making the text consistent.

>    * @measure:		Callback that performs the measurement (a single test)
>    */
>   struct resctrl_val_param {
> @@ -97,6 +98,8 @@ struct resctrl_val_param {
>   	char		*bw_report;
>   	unsigned long	mask;
>   	int		num_of_runs;
> +	int		(*init)(const struct resctrl_val_param *param,
> +				int domain_id);
>   	int		(*setup)(const struct resctrl_test *test,
>   				 const struct user_params *uparams,
>   				 struct resctrl_val_param *param);
> @@ -149,8 +152,11 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush);
>   void mem_flush(unsigned char *buf, size_t buf_size);
>   void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
>   int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
> +int initialize_mem_bw_imc(void);
>   int measure_mem_bw(const struct user_params *uparams,
>   		   struct resctrl_val_param *param, pid_t bm_pid);
> +void initialize_mem_bw_resctrl(const struct resctrl_val_param *param,
> +			       int domain_id);
>   int resctrl_val(const struct resctrl_test *test,
>   		const struct user_params *uparams,
>   		const char * const *benchmark_cmd,
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 76ae89e1aea3..23a82bd547a3 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -23,18 +23,6 @@
>   #define CON_MBM_LOCAL_BYTES_PATH		\
>   	"%s/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
>   
> -#define CON_MON_LCC_OCCUP_PATH		\
> -	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
> -
> -#define CON_LCC_OCCUP_PATH		\
> -	"%s/%s/mon_data/mon_L3_%02d/llc_occupancy"
> -
> -#define MON_LCC_OCCUP_PATH		\
> -	"%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
> -
> -#define LCC_OCCUP_PATH			\
> -	"%s/mon_data/mon_L3_%02d/llc_occupancy"
> -
>   struct membw_read_format {
>   	__u64 value;         /* The value of the event */
>   	__u64 time_enabled;  /* if PERF_FORMAT_TOTAL_TIME_ENABLED */
> @@ -268,7 +256,7 @@ static int num_of_imcs(void)
>   	return count;
>   }
>   
> -static int initialize_mem_bw_imc(void)
> +int initialize_mem_bw_imc(void)
>   {
>   	int imc, j;
>   
> @@ -430,24 +418,18 @@ static int get_mem_bw_imc(char *bw_report, float *bw_imc)
>   
>   /*
>    * initialize_mem_bw_resctrl:	Appropriately populate "mbm_total_path"
> - * @ctrlgrp:			Name of the control monitor group (con_mon grp)
> - * @domain_id:			Domain ID (cache ID; for MB, L3 cache ID)
> + * @param:	parameters passed to resctrl_val()

Please let description consistently start with upper case.

> + * @domain_id:	Domain ID (cache ID; for MB, L3 cache ID)
>    */
> -static void initialize_mem_bw_resctrl(const char *ctrlgrp, int domain_id)
> +void initialize_mem_bw_resctrl(const struct resctrl_val_param *param,
> +			       int domain_id)
>   {
>   	sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
> -		ctrlgrp, domain_id);
> +		param->ctrlgrp, domain_id);
>   }

With typo fixed:

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

