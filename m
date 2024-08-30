Return-Path: <linux-kselftest+bounces-16825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6BD966657
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 18:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA241F25D90
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3E1199FAB;
	Fri, 30 Aug 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BhPNOx4l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F824D8AE;
	Fri, 30 Aug 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033626; cv=fail; b=YEsNtdVxJPfj1UvN4LI8ohnLO7e7jJiK0jLSGyeF2alsDIc/wLvW1FCqzgY7k2qUIZwDiFP8UBhOew54ra+4OdM1dsEFAgfnIUqZzC5k+bgDH7GdQMa51GrJxYDcgsMF8UBObSHWVsQVrxiZp0SUsV+yqsHa3YCW/Q8QxRnLEE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033626; c=relaxed/simple;
	bh=ge7/NTnqJcJXJ7oY27Gmx47vtyAgbwghi5NCJCIpZUQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pYI3Nn48VldwVMYkhqIuz7gd9tiSyAyVt6oMkoaA1y3sc5YaYWEiD+X5SupatndLRJ0f8h9GejicsffhfS1BjtsWTWq1jLtRKJQz6jPWc/2QzA4OGjnvXfCDlLo2cHfQ8/nTn6vSMsCvPT9UyJTe61YhCHS9xvfCpZrQ3o6D7YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BhPNOx4l; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725033624; x=1756569624;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ge7/NTnqJcJXJ7oY27Gmx47vtyAgbwghi5NCJCIpZUQ=;
  b=BhPNOx4lrxuOt2OEC+/JpfQLQnV+1XU3DJaL0PLX1vmg38jHAZjhPNqt
   cEsIHMbwPspdHs4gNmvYja/4tRrwuUOYM6pZZO0732OsAG8f+sCenF8kd
   ynUAxezB3HYY+9rsGUG6L0mGORWklOWsLBKPfx/5QxJAIpD7WLGSDeDuK
   UWntcoHhe9oJbpfxhqyZyuafNLjg3VZIsPn4VrIZB3Sk/tbPaeY/r/QiY
   InHQetTOiTxsE6A+kqkKnA+nF9XtSYQmifiVdetLUvcjTi0gtyCzg0CeJ
   wvoYincs1NFRXtoLeAcsqI3CoHm6GZswQlbRxfF9J6vPM18/hX/svMHKE
   A==;
X-CSE-ConnectionGUID: 2MItF9DCRw+g8uqS8kqNlA==
X-CSE-MsgGUID: cAdgC5PVR8aPW3m6VPk2aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34253895"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34253895"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:00:24 -0700
X-CSE-ConnectionGUID: FayD/GkWRDe3iNzZkh9Y3g==
X-CSE-MsgGUID: w6LUfT3tToC5PY0wVuqGrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="94672944"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 09:00:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 09:00:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 09:00:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 09:00:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2weYpfZrJCwA9hDokGgRwjsWEVTsB1b4KUKpRMMsJfnTix46ufduc4qQFLEgXuxVjzpRXRuDWP2jnsP3BUobOLGPrIDVOAA4eDm8yuRSzEKygcAwKmCM31Wac/mFY3x4SNTdNt3fR5QbxlW0J7/2TawZBKz30H8Gpw5HisB1LgNr1gdtx3DS8AQkGJ6Xi+QHQm5sX51qlqsC5GbpcOXAjuI7e56nU+w2/Nj3NfFNFy7V2y6c/bCV6qq+Kl9FjUAAC63UBhB//g8SNGto+mykJOgXOXFIKoUTUKUYWYzo020Vz72rhtqjqo9h21HhJWm/vtTiR/osP7zshyDDdwCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzd8xyjY2jTjDocFzjJWp8eDfF44jJZEV+Xad9XDIgs=;
 b=G4PiKrAVHlZpltLISUxwuHaBOrvsr92+QAGHYKqbRfNZ+as5X6Y54ewJg+sJ4vs23qnetPbceZCojt7Ztw1EvjspgrEXKFNdmI3VRjDYTI2SnUNVrV7xnqOfU3HAQE3L7KUY2hHOJAWnxrQryyL72+Endg5kEx1GRuqw9beX98wucWmsdesDCVRw5mVSefL2QlXuGSdR4+WbVsxqKUERtHWz7BC2uQt8vaskM+EzR8cjI7S5+UhJPyF+K7jXwMgqbdFlsyTweE5B3culoAVFjz4E2CTjzqda1GvBtWjeAts0LKCUPHo6hnWSlA4ZOB5sgBX1znWQIZRH+LIzmoGnZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5934.namprd11.prod.outlook.com (2603:10b6:303:189::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 16:00:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7897.029; Fri, 30 Aug 2024
 16:00:19 +0000
Message-ID: <0ae6d28f-0646-48b2-a4e7-17e2d14f6dd5@intel.com>
Date: Fri, 30 Aug 2024 09:00:17 -0700
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
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <3add783b-74cf-23c0-a301-aa203efdd0f6@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:303:b5::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 245a9a37-240a-4ecc-b29a-08dcc90cd8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDFrS2lDbTNYdU9Lck5MRjN3cjBxZlpienZVUUo4K0xMMzhVTllGTWFLR3lx?=
 =?utf-8?B?TWUwUVdRYVdWM21zdzJVd1hkaHJnSkp2d09YMzhyRkdqZHcrN2pwY3Z4OEtt?=
 =?utf-8?B?a1lnM3QxcGlta1BSTXNpOFNGL2JvclFDVmVvNDI3N1JpRmFmM3U4Wkl2YWhV?=
 =?utf-8?B?cXVBUjh5ZWJEQlQ4TVAvNHNtRElDRm1lM1ExUmp5UHpnVlZYeldZV3dIU2hO?=
 =?utf-8?B?RHJEWXFBQzh0L2dPUnBXTG5aR2tjNHhqejYwWUNBMTBPTEVzQkZjWlZ0S3hX?=
 =?utf-8?B?L2dSOUtYNHRDTHNEeHV0ZXA4MGNEWjY2QU8vLzdjUytPSTRhaGRJM080dm1q?=
 =?utf-8?B?RC9OL0tpb3JWcFIyTytUSXI1eU56QVZDV25ySGR0MytKazhSYzFTWEdVSFhL?=
 =?utf-8?B?TjVxVlRMYTFuWjZkRnZ6T0RZSENaQXRUVlFnTmZsY0VuVStXVHRDUzZjY2o4?=
 =?utf-8?B?Mm1LWnRHTURaYXN3NVRic29pa2V5KzZRMjRkRERna21oSC9MRXZaMWx1R2NS?=
 =?utf-8?B?dFdwdjBtVnlrZWgwT2VEbmVpZEFuWEhoa29CaTdZd0w1VVN0TUtQaFU2TmdR?=
 =?utf-8?B?d3g1eFBCeWZHSnN3RkdNeHV2M0Y3dFIyaVk2WU11OGFPVnpwTlplVnlQTTBx?=
 =?utf-8?B?dXcyNkRuWGV5QTdpM2NSblhkbnh3ZlcvQ0FIK2tkWm9Zelp0aUN6RzZlalQ2?=
 =?utf-8?B?aWpOckVLa0h3aFNHSTgwUmtLUk1XRXpvQ2tmdE10RUlBUUlqZFhreXlKRXFQ?=
 =?utf-8?B?SXpTa1JoVThSMzZmNjIwMk90bGlrMk1jUlAray81cE9OZUNoNXZSN3Z4dFBh?=
 =?utf-8?B?a1dMeG0vbE9hNkxWZ3h1U0J4SW90NENlRVFraVppa2xReFRIMGJVcmJEQm1O?=
 =?utf-8?B?cHJ6V0JoLzRsNFJ2ZHBnNmdCcnpZWHVxRG9wV3hhS2RYaHpUQWZMMTRMZ0x1?=
 =?utf-8?B?QXNSSWE5ZlNvb2VHQXMvWjFyWXVoUGdBemI3WERITjVNTy9nY2Jtb0lGY0c1?=
 =?utf-8?B?dW1ScHB0TzhaUE5CODJTU2llZkY3KzlkOTlYblMzTVJFZmxLWnJ6VHJ0akpW?=
 =?utf-8?B?QTNhOUZRU1FXelkrcExWcTRoL3R0T0ZZUmpHYUVIbDh6RU1jSlFvY3JtRlZK?=
 =?utf-8?B?WVNORUhLdjJiZndhaTBkTElsVldSZ0ZhaG9ZWkZkUk5yR2lMUXZSbVFTQ095?=
 =?utf-8?B?TnZCL1JoWFp5OENWcmcxV1VsMk1yN2pCZk9pNmY0M2pSWXR0ZWJ4cG5rSWRR?=
 =?utf-8?B?U1BETkhoTm5qUGhDTkNKaUIrUHk4ejRTZnRlNnN3cGVnUGR4R0YxMm15aW9Q?=
 =?utf-8?B?WDJLVFpJd3pZcXhTTy9GVzBjK0I4dUs4d0xoT0xVV2pCd0JEY2ZJNEhvR0ti?=
 =?utf-8?B?NjdNSnp2R3A0QkdBWDlESEN3dXlJZFYwUWFnTkJrTDRTUEdTeEF4VCtZc054?=
 =?utf-8?B?Qnc2V1BJQ2VMYnpnQVhvV29TRW5mY2Q5RWxpWVdHYktNeFFqcXp0Q0hDek1x?=
 =?utf-8?B?M0p4V05QbDAxQ3lsaGJpRXc1NU1Pa3d5VFVGMlAzSFF1R1d0R2JTWnMyd0FL?=
 =?utf-8?B?NGF0SVg5WnBlczFrMkRLdlNraTJyeXd0TkErbDlwakV4UjJ6aS9nUmNJZVBW?=
 =?utf-8?B?aXYxV0Y2OVpKdy9qMlhKbTRrMi9aaEd6SGNZZGdGajZscjhXb21HN1I5WWEw?=
 =?utf-8?B?d3FkakZMNFFYc01RV3FuTDBadmJnSUhJRElqZldiank2OFRSd0tpWkN5RndT?=
 =?utf-8?B?QkRRU2ZEaEh6SGdyWllhRVB6dk9sbU1aUW5uTDgvM0p3dlBaYWRDTUJuVmNB?=
 =?utf-8?B?anlQcy9MZU85NWFwS1YwZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjltalpqSldKOWh3THFwTyt5MUZ0ODJsTXJOZEsweW5zd0ZCNHJPVkk2N0Fo?=
 =?utf-8?B?bTVXVVROYXpsWmE1ZXo3Z09lUjVPYUY2OGtCdnpaVVdDYThQQUpoOWZwQk9o?=
 =?utf-8?B?cHB2NXkrT3BqOVY2WThES3Nqc29NaEU1b2hDQzZlUWpwUFBoMERySCs3Z25N?=
 =?utf-8?B?QTZZQVFqTlFoSVdnKzZOaCtNNWhDYVd6dTNRa0pxeUYxOW41WDNrRVVJd0VP?=
 =?utf-8?B?WTdxR0xLZENtYW1TT05peVBaY3h3UE85ZFBqZlZ0MHg4aHZyK3pvS0VqUjFI?=
 =?utf-8?B?dFpTcnl1NWtNc005SytzTTYydld6VzFYeGxJYndjSUZCbnJxQy9ubFEzLy9r?=
 =?utf-8?B?UG81bkV1R3JGWGtMbHJ6YW8vMGFvZjFKaGZTZnFubVZ6NS8wRjdzTncyVSti?=
 =?utf-8?B?Z2hJQmFZa1NKYUdQUTY3UitVb3I2NUFkRVRuUURoUXV2bVJiWHUzWnZSNmw3?=
 =?utf-8?B?WWIveXE0dms4R0dzbXpiaThmNlJ5VjRTcGJkRks0aHlTWXZSNUZoemxzZ0NX?=
 =?utf-8?B?ZGVScE5SL2gzMG9FUU1pWVgxdld6aEpxYUVYQkhlalFMQjNZRm1wemVLb1VM?=
 =?utf-8?B?djdzVk91U0M5SFpsS2dhY2s3UVVFd2xvRStsR29rRFcvMHFmTTdJN1FJK01Y?=
 =?utf-8?B?c0hRV1gwRm02YUZWK0lYTnJRSUhoTG5YS2FhRG9nVUJYMFppSW9XSVA5L3Nr?=
 =?utf-8?B?c2Z0dFpOL0lqZG9xUWVpN0hnVDdjcjh2dVF6YjZLZXY3ckZERGlZbDFnZUIw?=
 =?utf-8?B?azk2cUhsODF3K3dhTCtzYWd3alFicW4xUkQwNnpFYlI4WERXMDdxM1pPSE1Z?=
 =?utf-8?B?Q3NKd1RSQ2xVdHZlN3RHQVZGMGQrQkZiWDNKZEdOamVRTVdIVFBXNDAyamdQ?=
 =?utf-8?B?K1NVUThWNGQva1dmamNxSDBRd2FzR05CZFlXYnArbms3Y2YxN0FRWnA3c1lk?=
 =?utf-8?B?TWdDSk1mWHBSaTMrQ09OWk10UmpkdkJUS1Q3MGxzYXpxTXdBNDQ3L25heWJk?=
 =?utf-8?B?SFZmbldZcURncTF0R29YdWx3ZzlUNjZNUjg1eSsvTVB3RXAzT29jdnVNZzRq?=
 =?utf-8?B?cTJhUGlhMmQxdEw5SVg5SXZJSGl3UllMdFQ3bnVWS0tIRmEwNmFQVGFzSWF0?=
 =?utf-8?B?Tk5VZmZRMjNqTjg1eTdjRE9xSVZmY2Mza0RTK2pWWFVBSVByczZoQVFmUjdE?=
 =?utf-8?B?UHBRcXdHcnpaL1BDT01MUEs2YkNBSE1kb3duYzF4V3VYK0VUSEc2YW9VNFVR?=
 =?utf-8?B?ejc2YWprdmtKUnMxbVFwTmZaM1pxRXNXNzZ6bVFiRytkOFZqNk1pTTlWaVBo?=
 =?utf-8?B?Mk1tMWNOQlJIRmhoZFNQaWdwb2RlUnFzTHZFUXpzNE9HdURJRjQrd01EVEts?=
 =?utf-8?B?LzlDaEd0Mno3Nzl1RUN1ZmxnMmVNS3UvejhmODZIK0xMeVZtbUdUR0MvZ1lO?=
 =?utf-8?B?OVk1QU1wSkFIYk8vNzArYSt2NE85VFpDVEZvdTJ2WGhwODBRc0l5TTJkMzJL?=
 =?utf-8?B?Y3FwWHl5SGZKRFhERzNwZ1FZVWRETmo4N1dzT1U2L3pKVDlsbXVsc1lsS3lV?=
 =?utf-8?B?bjFCdCsrRkN0N0k1bGhROEhiSFBUZ0hLek4xazlCazJkbkJ2TkpMSVFYek5j?=
 =?utf-8?B?alRNT0JRVTZjUkgvdCs5cHBmNFVMbzA0SzB0VVVDOFdUMmtGRC9SVWpJWDQw?=
 =?utf-8?B?RXo1RUJhTVpmQ1piSHVxMFovYjhuS3NNOSt2MmVuK2FVQlFlc2s0Y3hXNHRs?=
 =?utf-8?B?dzNsT3lHYUVvNW94a2YyWExoSmsvczIxL1Z2L0lUREdYdUxaVVA4Q1FmM1g3?=
 =?utf-8?B?b25yZjRCWTZkNnBITXBFNEIwUlJGc2tKTU1OOG5mL05qL3pIMVNzMWdnL1c3?=
 =?utf-8?B?WmhBSFFTTEVIVUxubTlQcERZeWRsNGVyRUtCeThld3h3QzJlZ05OMTNYRVhS?=
 =?utf-8?B?NGNqRDdXKzIzbkFiSE93RGM2Rko5Y0t5bnJyNmMzd1hveXZvMjlGK2RFNFdJ?=
 =?utf-8?B?RzBUTGUzYzVYNy9vZUdqc1paVWdmbG40LytvLzliSE1OdnZxVlBkcW5ob0pu?=
 =?utf-8?B?UXM1YXpOby9aakNMVHUwblNUdzN3ZjZnaUpzSy9KWnlmRVpWT05KazdkOHA3?=
 =?utf-8?B?ZTNRcnkzQ0FlcitDZFhXYUkrcjlEZU5DK1c4MXBBNkN6b0JRQ1dKQitLNWc5?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 245a9a37-240a-4ecc-b29a-08dcc90cd8eb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 16:00:19.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KX8spE9Ch8d41xFRAyVv/pYi3u+RUjU2mSJUEOsXIjHxAYQhkm6guJaJe0d3nQqu4TOLGTX9GJytrzVpYPU3hVmZPCg3jcPUaeA5J2OX6OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5934
X-OriginatorOrg: intel.com

Hi Ilpo,

Thank you for taking a look.

On 8/30/24 3:56 AM, Ilpo Järvinen wrote:
> On Thu, 29 Aug 2024, Reinette Chatre wrote:
> 

...

>> @@ -684,11 +622,13 @@ int resctrl_val(const struct resctrl_test *test,
>>   		const char * const *benchmark_cmd,
>>   		struct resctrl_val_param *param)
>>   {
>> -	struct sigaction sigact;
>> -	int ret = 0, pipefd[2];
>> -	char pipe_message = 0;
>> -	union sigval value;
>> -	int domain_id;
>> +	int domain_id, operation = 0, memflush = 1;
>> +	size_t span = DEFAULT_SPAN;
>> +	unsigned char *buf = NULL;
>> +	cpu_set_t old_affinity;
>> +	bool once = false;
>> +	int ret = 0;
>> +	pid_t ppid;
>>   
>>   	if (strcmp(param->filename, "") == 0)
>>   		sprintf(param->filename, "stdio");
>> @@ -699,111 +639,80 @@ int resctrl_val(const struct resctrl_test *test,
>>   		return ret;
>>   	}
>>   
>> -	/*
>> -	 * If benchmark wasn't successfully started by child, then child should
>> -	 * kill parent, so save parent's pid
>> -	 */
>>   	ppid = getpid();
>>   
>> -	if (pipe(pipefd)) {
>> -		ksft_perror("Unable to create pipe");
>> +	/* Taskset test to specified CPU. */
>> +	ret = taskset_benchmark(ppid, uparams->cpu, &old_affinity);
> 
> Previously only CPU affinity for bm_pid was set but now it's set before
> fork(). Quickly checking the Internet, it seems that CPU affinity gets
> inherited on fork() so now both processes will have the same affinity
> which might make the other process to interfere with the measurement.

Setting the affinity is intended to ensure that the buffer preparation
occurs in the same topology as where the runtime portion will run.
This preparation is done before the work to be measured starts.

This does tie in with the association with the resctrl group and I
will elaborate more below ...

> 
>> +	if (ret)
>> +		return ret;
>>   
>> -		return -1;
>> +	/* Write test to specified control & monitoring group in resctrl FS. */
>> +	ret = write_bm_pid_to_resctrl(ppid, param->ctrlgrp, param->mongrp);
> 
> Previously, this was done for bm_pid but now it's done for the parent. I'm
> not sure how inheritance goes with resctrl on fork(), will the forked PID
> get added to the list of PIDs or not? You probably know the answer :-).

Yes. A process fork()ed will land in the same resctrl group as its parent.

> Neither behavior, however, seems to result in the intended behavior as we
> either get interfering processes (if inherited) or no desired resctrl
> setup for the benchmark process.

There are two processes to consider in the resource group, the parent (that
sets up the buffer and does the measurements) and the child (that runs the
workload to be measured). Thanks to your commit da50de0a92f3 ("selftests/resctrl:
Calculate resctrl FS derived mem bw over sleep(1) only") the parent
will be sleeping while the child runs its workload and there is no
other interference I am aware of. The only additional measurements
that I can see would be the work needed to actually start and stop the
measurements and from what I can tell this falls into the noise.

Please do keep in mind that the performance counters used, iMC, cannot actually
be bound to a single CPU since it is a per-socket PMU. The measurements have
thus never been as fine grained as the code pretends it to be.

>> +	if (ret)
>> +		goto reset_affinity;
>> +
>> +	if (param->init) {
>> +		ret = param->init(param, domain_id);
>> +		if (ret)
>> +			goto reset_affinity;
>>   	}
>>   
>>   	/*
>> -	 * Fork to start benchmark, save child's pid so that it can be killed
>> -	 * when needed
>> +	 * If not running user provided benchmark, run the default
>> +	 * "fill_buf". First phase of "fill_buf" is to prepare the
>> +	 * buffer that the benchmark will operate on. No measurements
>> +	 * are needed during this phase and prepared memory will be
>> +	 * passed to next part of benchmark via copy-on-write. TBD
>> +	 * how this impacts "write" benchmark, but no test currently
>> +	 * uses this.
>>   	 */
>> -	fflush(stdout);
> 
> Please don't remove fflush() in front of fork() as it leads to duplicating
> messages.
> 

Indeed. Shaopeng just fixed this for us. Thank you!.

Reinette


