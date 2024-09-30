Return-Path: <linux-kselftest+bounces-18660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CFC98A956
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 18:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF501F21C3F
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F7719047A;
	Mon, 30 Sep 2024 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dV79JZ1i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099635894;
	Mon, 30 Sep 2024 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727712469; cv=fail; b=cQR7zWcsQCaeQguAUO9V8ZJ0eYBhaoooHl0VmTyOD3/IP3QJ986vtRIlah3UPAC0dGAQKpMuIlne9Kok+T46CcPLnaJBoNg//ZeaZAPZKXyAXgCCU6Q6bFbVstTvxiGbAYht3MUm997harnAF0HKi3fUgY24ckguBJhCP+U25LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727712469; c=relaxed/simple;
	bh=Iy+Anj0ENZ7Z4cP9v9XN1gntrHDyeJ8TANXGlyo74yY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z4AO6F1ynIX0VdbI4/oJnwceAinPTttRV2sDPmkttt3sIKEGTo7IDfAor+H7Kezw9N08U1UHezizRIOocYmxtZXokxkZla3KB2EQdPGQhTY+C2185TOyqljpM2wVsk88Yyq5CgJbXIIiuvz9cdfd91HVBPq+lIDSsi8+WKAWeeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dV79JZ1i; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727712468; x=1759248468;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Iy+Anj0ENZ7Z4cP9v9XN1gntrHDyeJ8TANXGlyo74yY=;
  b=dV79JZ1i/cD1GIzUWTY8oeDBE2pyQGkq3yjPnnqQ+EqM2RK3pxEDLjbl
   I01p9ONUxIQfwLoe22eeA6fZQ+4belqfNWHRgFnXqRch4FuJHygLaS9Jw
   byq6TjB+rmdA4OTt8lP6kHhUaZcILUR7rwmBLz+m0lRx++xIV4wfQBum2
   6FDHXGMCqjzibTc2fVpbfVBaDzjl3IKZZ6HuxLWT9xLyISY18PaCFgH2v
   ts3EtlAoivyE4SFaxPJJaHWsGkDKYKG8h7RjE4tHxj/HibGobxPlO/34V
   tBt03tTvn3IlghOfcwW1e3HEnyhvgRstsQZpgo0bd04gGSnU5Rk7u08r9
   g==;
X-CSE-ConnectionGUID: tHic28YWTDOtZa8Xs0TQBA==
X-CSE-MsgGUID: zwC4v/mFTvu4sp23kUub3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26938377"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26938377"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 09:07:46 -0700
X-CSE-ConnectionGUID: m4gxch7URQClBd9KA5ebIA==
X-CSE-MsgGUID: vzWAummWTnedokQLtYUJng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73617692"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 09:07:45 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 09:07:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 09:07:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 09:07:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHOv04AqW2AlMwW/VmKjtCC1+0+zpEvzzF7MzivkQrd8GfOOo1p6He1C2TF36HwJjt00L0ht/yAUIQaYADD9Iqv/e4ACz1wnUtxd4fdA10vbUayiXktfHXhVZONHPtsWst+4zWTuRPl4DwmRRVJpaPBRXWvGX7TpoS9MV48HC4YP7Um9qoOZ7SenNTnrm89keGVgrwmCTa9f5twzPJH0MCgELK1NK3Bg4Px2IvoEJDg0uC+KDm/spRCEA9iC/QfB2pPFV2zU0E5YudPFVUryuwzgWA2SzRy7nXIxVKH92ElTEDx/s9QSkNrhZD3BYrTr52qVf6PdgRlrZQCaHrZS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3RAX5uZzv4TtL+NfTa5fJyqpNBvQgwqsk4i/3bk6nE=;
 b=T95tPRswnLIze/toKutBaYRSof4hU9LqVspFf2iXil4f62iy2kTkmX9JseiK1ZvOmaig4cXTMDLNPOlEtZtG2d9UzQl1Mp1O1cJVXdtwqHgkS2g7iDSfwW7KcBfEmX+r0gRy8COhhp1BYX3bS7xqJx/0jk2NeFU1bmO8gjpA2qYnkhJIz8iOT56N3JZQ8WXNx+vL/UM0ccll/ANH0DdoO+eqJms3F4yw9PMhhEXGvNTqV2UWvDq11+ELrLTaQzfVycm3+a+CJtVEhaJ3ZI/23U6GOKdM/KrVjWY2ooHDScep4Fv0I2b3F/YgqSJbuW4uIjgvxxuqGWnS5+mNLA6ysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7534.namprd11.prod.outlook.com (2603:10b6:806:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 16:07:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 16:07:40 +0000
Message-ID: <774e04c0-c62a-48f3-bcef-a2300752bd16@intel.com>
Date: Mon, 30 Sep 2024 09:07:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 06/13] selftests/resctrl: Remove "once" parameter
 required to be false
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1726164080.git.reinette.chatre@intel.com>
 <1f5ad02dc424bfc3cca705ed9a322df8f35f2ff4.1726164080.git.reinette.chatre@intel.com>
 <f692fe7c-e81d-2086-fc1d-f3af436580c1@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <f692fe7c-e81d-2086-fc1d-f3af436580c1@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0297.namprd04.prod.outlook.com
 (2603:10b6:303:89::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: e26af937-8808-4fff-1c9b-08dce16a0299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clZFZUxUSGplaHo3YkR2RnQxblhNMXZkK21YUlhOWmVWSHJzU3pCS1BlSS91?=
 =?utf-8?B?V1hQSGxlcjFnL2dyRTZaUWhUZUdUWkJDMU0wRUgzcDkrR1ZpOGEzSDIyTlZL?=
 =?utf-8?B?a3A4SkhlK0l2bnR3TFpIN1JsS0s2YjI0VExPSC9rTmZZdEhCcEVCaEFmajRK?=
 =?utf-8?B?WXdGU2Zkb2tLMTRhbkJjUWtTNy9IMGFEMGZwdUlTT0NoczJIVmNNelZWQUI5?=
 =?utf-8?B?bzh5TXFWQU8xQSthUEFXQmUvdkZpMk5jR2FzdEJFNHVXZ1RSek00VDhhY3lQ?=
 =?utf-8?B?eW56UFEwQUtkVTB4Mk5rTjZ1WnhSdEF4SUxSYTMzRFBGMU1NK1JRUnJyOGN2?=
 =?utf-8?B?ZkY5bE9kdUwrUi8wN3dLTEVSOXBVa2Z2L3dSSUdhYWZCdTl0TmhSU3luTXha?=
 =?utf-8?B?L1MrUEdKRXd4U21rOHIyM082bWxBMXhJSXJvWUlnbWYxQnRaeU5pZWJxYmlm?=
 =?utf-8?B?SGNmRTc3ZmVxTkRQNzZpc0FTMEx4Vm1wakxMZk5WZlNHWm95SkxmUy8xQ2k3?=
 =?utf-8?B?cVVIYXBNTnZvY2NSM3ZCOWgyZmNuQnNCNFFwT2FnWXdwWi9vdEFtZlhrWVJC?=
 =?utf-8?B?bkVwRkVKOTEyNEMwVnFOenkzT3hYSEYwQ0FOYUU2T29rMFVhSlhpTTdkWkwv?=
 =?utf-8?B?ODJzRDlxL2dnZXJRL3hSSm1nRnFwZHE3TkdRbUFhOEZlMk5rUHU4VWhtR0VW?=
 =?utf-8?B?S1pWK0Y0SFZKYUFrQ1NOaDV3MVZmS25SaWcybnlYakJjQUlZOU5rbGx1ekhE?=
 =?utf-8?B?Y3ZHK2Y2Y2Q1ZmRqRUtmSUoxcm1UMWxMVVh0bTR6V0crMVRwRWlGOUc0cUlI?=
 =?utf-8?B?NW9iNVRJd0JwV21PRmxXTlUzS1Y1cXVPRkl6Y0tXV1pueGF3NE5XVHc4cUM3?=
 =?utf-8?B?OWFGSVNTQllEN3lxRVBZMWNIUm5GNUFPaXNta3JiVVcvMDVQS0NBd1ZCYk5h?=
 =?utf-8?B?bzYySlJ1cjVndHJTV1NEMGx0WnZZMXJQd2xXUzl1NU4xN2ZjcEhNSlpVVGVH?=
 =?utf-8?B?TEJzbkdFcDVWSWtYVlN0a080dXZFM2xVVWVKMmxwRS9mdWhEMzlWdGpEV1k3?=
 =?utf-8?B?bEtlU3gwaFcvcW1JUHFiR1lBWUozZFZzZ1VISG1iNitNbmVkcFc1Vk4xcDJX?=
 =?utf-8?B?TDlOY0I2bTRZVEdRaHZtczJVd2VPUVF0VmpQZk4rcGxkd01nSDhEMktqM2NB?=
 =?utf-8?B?WEJCNjQxNnRmUTdvTmgzTXRvZGNmWEIweGM1R09xSGo5Q0dGZ1FuSFQ1MTJW?=
 =?utf-8?B?VitkNDc2QUFPWi9GVFRxQmFqZ1BxNjhoU0d2WjBUbEllaHBoL05YNjJQRTUv?=
 =?utf-8?B?T290K2ZlbkI5emw5OFVYQzVBc2VNN3B2V3pnWC82NTlVZGwySkd0OTViN0Mw?=
 =?utf-8?B?WkdYT3JQM3pVckg4ZzEwaTZkV1pRK3lKNWVjY0xjNVkzOUNBQ29rTXNvRVNn?=
 =?utf-8?B?L3EyekY0bzJJYjdqT0dQYnZPdkZIVnY0azYxQnRQTUU1aGtWRVBXdHdSZVVK?=
 =?utf-8?B?bm5wSEVvdkxRSDc2NGMxcjNkSytOV2FGS01CR0QwSFlaYU1naEZodGN1ZlEw?=
 =?utf-8?B?UysyS2FwQWtxVzc3Zys5bFZZZ3ZtVWdVMFlnb3pjWDNzVmpvKzB6WU11Q0VL?=
 =?utf-8?B?czUyTU5CUFR1elIvdnk3a3lRQURubC9MWUt2N3JNdExkblZ5SDZ2Z2xUVUhu?=
 =?utf-8?B?VHhlcWVNN3F6T1Q5WTBQZVRTRmMzT1l0VWtLWlllUEt4cFhmT1JENEE3Q0hL?=
 =?utf-8?B?RTBSUFc1TDFMTWpsM1dXMmt4U0R1a05iTkxkNHQyeTlWWTJ3VHQ2Z0VjZDZI?=
 =?utf-8?B?a1h5SDdOWkhnd1VaeHoydz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGpONEhRWVpOWk00b0F6WWpQTjZIODNjVExBQVoxemhhZnVtWDBKb1djZDJY?=
 =?utf-8?B?dFh6UVY4NjIzMG8rVUoxaEJvd2NiYmNLQlV0Y1VKRWtoQnFqRVMwaTZtVHg0?=
 =?utf-8?B?OW9vWFZVQVhibGtqVmFJZklnREJuOHB0UXZ5dnVHU1duRFgxTXdrZ2NhOE5i?=
 =?utf-8?B?K29oTnFVdmIzT2VraEJRRlpOcjIwSmZmZndNT3hMcCt0aVlrcmZpdlB3Rlo3?=
 =?utf-8?B?bkd0S1FHTS9DZDltUnM1NkFIdFF5T1dyazRkUURPV3FneTZ4OTkzc0VmWWM2?=
 =?utf-8?B?RFByYmZMRTlZTHIrb1NCS1pqTldneVh3dTZnQUJlQTkvK1UxdDdtOExCdEMv?=
 =?utf-8?B?NDJkV0dMK1dvL1ZoMFdYb1R0RXpxejBoQ3RGaEtpMnMzTU80eHNTVHdkbEg5?=
 =?utf-8?B?RkRqc1hYRVVTTGhNOTZKMkVJaThtd2FSc1lxSGJwU3k1NWt6cnpTenJXT1dT?=
 =?utf-8?B?emdVeXl2YzNYMStJRzljUHI2WFRXVFUwc2VONWZQVWkzTUdBNEoyM1BwelpR?=
 =?utf-8?B?ZVB0bkRFVFBsR1FzYjJQT0UzOW1tNHpKMC9UV1BubktKOGR3cHRPTmx5bDAv?=
 =?utf-8?B?RWwrRjdnYzEyMW9ORksxWGtqN0NRQkh5aVJxUmZFcWxRZnNKSEprbjdIVUlv?=
 =?utf-8?B?cEx2cktDTTJocTlTVFA1OURQSEdRNmtEdUZVY3ZWeXlJeTI3ZnVYY2Jmdk4y?=
 =?utf-8?B?azRFbXJaaFlQOXNGTUNvYmMxTzl4WklEZFJtenplZjl1QU1LS2RJU1VUSGZJ?=
 =?utf-8?B?ajRYZ1dZVmFTU3UrTGhYTXJtYXJGK3plWWk5UlNoRURQN2xtY0h6VEdYdzBY?=
 =?utf-8?B?L1ZkbG1lem9ROWp5T1RJUlk4SHFhQU1CN2xVeVVRVkFFb3RKN2V0c0kxZzU4?=
 =?utf-8?B?T3l3S2YyRG1JbERWdENVQnZiVmRxNmZpa1NpSExQellHK2hqTHF3NDI0S1FQ?=
 =?utf-8?B?NjRuK2NwTzQ4aUFzRG5ZZXZOTERCZGRmbThxQXY1U2dBVFFGTGpLVHF4blBs?=
 =?utf-8?B?R3F6NkMrWGNHR29ZZVFmRjE5eW1HQ3ZXeVc0NmNLZE5vam14dTR6aFlXcXZV?=
 =?utf-8?B?Z2tzM0pzV2tBbVNDVWdnMlJnUzhad2NzTThFUW5uVzhRb1AyN0FyTmlQYXFX?=
 =?utf-8?B?QW9RSjQrektaQ24ybW5kQWtYcmIvTnFzZkY1alFHejRqVVR0cHMxSUJmVzVn?=
 =?utf-8?B?TTRmMk9YUzNRN1kwV2hTLzFTL3lKUXpac2R5UHRzblZJM0xFK3lpNXFpVncw?=
 =?utf-8?B?aWdhbWFJRzcveWJCdFV1T2ZvRElqMndLbGFkYXpwSFUxOENpd1NsSy9PQXdB?=
 =?utf-8?B?OVpqTVVOUHU0RG50WFhoNTZmU3JuZFZiODI2OGxDNHRGeGgwcVo3b1JFVlcy?=
 =?utf-8?B?RUoxaUE1U2pDTTJWcHRrZEhZRCtSQUY4eiszc2s1ekMrM1RhZGl4OVZ1WnNJ?=
 =?utf-8?B?NUZFc1h2Nmd1dEdFdE9vVTJwdStxUGlNdnFWejhBdDk0QkxINTdTMmIySzZl?=
 =?utf-8?B?WmpWclZjZmFaY3NOeXdqNGdTUEZMM21WNGdKV1J4YlRubnlGNDREdEpyL3lK?=
 =?utf-8?B?dWdPNmtmbjkybnpaMFhDVHl1Y3ZSMHFaZ1hvdUZqREtYMkF6ZTh5d3pyYXdO?=
 =?utf-8?B?akxkMWNnNXVOWlhONk5iU0dpNXFuamNnUVhSNTBBbGp2WElFdlU0d0lYcHBw?=
 =?utf-8?B?em9qZ1k3cTBKS2k0emN5OWEvNnY5MzJRZHdUdUtnUE5tZW04SWhab3lJZDZo?=
 =?utf-8?B?ZDJwOGVjWjlFS1JmVDVnNTMrWGhINithRXg2enF2c0NiaFdMcldvK1h3UVQz?=
 =?utf-8?B?NWxJcDNXYUdxbk1BYVl0ZkVSZVFoajU1Q0JZZW5JczE3czZnaVlMck94aytS?=
 =?utf-8?B?Y21CMGpPY1FqdldMTVpOYkFyTlhUdDlqV1N4djE4UGFGcHl5WEtlUmNzODM2?=
 =?utf-8?B?WDNoOVBsR0JaSk9ZSVJwMFJwcHFrbDhxQlJlRWxyTGRQcitNc0hpR3o1R2FU?=
 =?utf-8?B?UDVyQUtWWlhKcHUrWFJwRWg4OHQvNUkyUTA4aXBJbjJPV05mbGpuZUJ2ZG9p?=
 =?utf-8?B?TkhGUEJIMGIyYzJ0bndIQ3k1VjF1OXNKRGlzOVA2ZWhUMnpRVXFrRndPYVo5?=
 =?utf-8?B?SGdzcUlteVAreVRRZUhjT1RBb0VVdWhSTVJGUVEyem9EY05qL0YxbHlEMlJX?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e26af937-8808-4fff-1c9b-08dce16a0299
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 16:07:40.7226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Byhqj+jMPKVvePgLnImN9VqdjZZ2Pj40PotjaHYRPSBPfM56HAwfu1MEzRm3EPl6YmEfU4P0Kx3nJrzpg3imup4N21/b+AYbNQ9YSD5bFCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7534
X-OriginatorOrg: intel.com

Hi Ilpo,

On 9/30/24 6:49 AM, Ilpo Järvinen wrote:
> On Thu, 12 Sep 2024, Reinette Chatre wrote:
> 
>> The CMT, MBM, and MBA tests rely on a benchmark that runs while
>> the test makes changes to needed configuration (for example memory
>> bandwidth allocation) and takes needed measurements. By default
>> the "fill_buf" benchmark is used and by default (via its
>> "once = false" setting) "fill_buf" is configured to run until
>> terminated after the test completes.
>>
>> An unintended consequence of enabling the user to override the
>> benchmark also enables the user to change parameters to the
>> "fill_buf" benchmark. This enables the user to set "fill_buf" to
>> only cycle through the buffer once (by setting "once = true")
>> and thus breaking the CMT, MBA, and MBM tests that expect
>> workload/interference to be reflected by their measurements.
>>
>> Prevent user space from changing the "once" parameter and ensure
>> that it is always false for the CMT, MBA, and MBM tests.
>>
>> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>> Changes since V1:
>> - New patch
>> ---
>>  tools/testing/selftests/resctrl/fill_buf.c      |  7 ++++---
>>  tools/testing/selftests/resctrl/resctrl.h       |  2 +-
>>  tools/testing/selftests/resctrl/resctrl_tests.c |  8 +++++++-
>>  tools/testing/selftests/resctrl/resctrl_val.c   | 11 +----------
>>  4 files changed, 13 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
>> index 34e5df721430..854f0108d8e6 100644
>> --- a/tools/testing/selftests/resctrl/fill_buf.c
>> +++ b/tools/testing/selftests/resctrl/fill_buf.c
>> @@ -151,7 +151,7 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush)
>>  	return buf;
>>  }
>>  
>> -int run_fill_buf(size_t buf_size, int memflush, int op, bool once)
>> +int run_fill_buf(size_t buf_size, int memflush, int op)
>>  {
>>  	unsigned char *buf;
>>  
>> @@ -160,9 +160,10 @@ int run_fill_buf(size_t buf_size, int memflush, int op, bool once)
>>  		return -1;
>>  
>>  	if (op == 0)
>> -		fill_cache_read(buf, buf_size, once);
>> +		fill_cache_read(buf, buf_size, false);
>>  	else
>> -		fill_cache_write(buf, buf_size, once);
>> +		fill_cache_write(buf, buf_size, false);
>> +
>>  	free(buf);
>>  
>>  	return 0;
>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index 2dda56084588..51f5f4b25e06 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -142,7 +142,7 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
>>  unsigned char *alloc_buffer(size_t buf_size, int memflush);
>>  void mem_flush(unsigned char *buf, size_t buf_size);
>>  void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
>> -int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
>> +int run_fill_buf(size_t buf_size, int memflush, int op);
>>  int initialize_mem_bw_imc(void);
>>  int measure_mem_bw(const struct user_params *uparams,
>>  		   struct resctrl_val_param *param, pid_t bm_pid,
>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>> index ecbb7605a981..bee4123a5a9b 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>> @@ -266,7 +266,13 @@ int main(int argc, char **argv)
>>  		uparams.benchmark_cmd[1] = span_str;
>>  		uparams.benchmark_cmd[2] = "1";
>>  		uparams.benchmark_cmd[3] = "0";
>> -		uparams.benchmark_cmd[4] = "false";
>> +		/*
>> +		 * Fourth parameter was previously used to indicate
>> +		 * how long "fill_buf" should run for, with "false"
>> +		 * ("fill_buf" will keep running until terminated)
>> +		 * the only option that works.
>> +		 */
>> +		uparams.benchmark_cmd[4] = NULL;
>>  		uparams.benchmark_cmd[5] = NULL;
> 
> Why is the [5] assignment kept around? Is something depending on this 
> double NULL termination? This patch removed the access to [4] so I 
> don't see anything beyong [3] accessed explicitly.
> 

In this case this was kept to reduce changes in preparatory work since this will
all be replaced later with the more robust parameter handling. I'll remove
the [5] assignment.

Thank you.

Reinette

