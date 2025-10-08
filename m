Return-Path: <linux-kselftest+bounces-42905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5172DBC6DE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 01:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317FA189CCD0
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 23:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3372F2C11F4;
	Wed,  8 Oct 2025 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPIsLoxp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A00C24166D;
	Wed,  8 Oct 2025 23:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759966354; cv=fail; b=hfYBFwhjYB7oLekAc32/utuCmOIuiC4IMmdUEvQg894OVdPL715BQjuHDfzCczxGwjqhkX5ncKprB4om1nC4Jf/Az0KFbOU4J2y5jLt2cA79IYuVZcElxBRuIoa5TJikC2khUevMq6DS4clSt1fO0T89rVP48/UH1RG7PnJkD34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759966354; c=relaxed/simple;
	bh=QmWYULW04GIMSstQIwpoLNvuM/fma7EmLPYmNj4Ob3Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LTWP7lRxHgAfgDa6z6bqBNXBcjwu82WyOzBmOmKqRIvyWNtuD6ODy0mJEX6jA/JkdczjOVV7sHfj5y158+ltxdObMZCCxN0ArgnmDsrkeXX5zTsolSKyPzWsjC5y3ykUCbI7s44uCTEcJqcuYmimXLyo9H/AT0o8lAxUKHhzTfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPIsLoxp; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759966353; x=1791502353;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=QmWYULW04GIMSstQIwpoLNvuM/fma7EmLPYmNj4Ob3Y=;
  b=gPIsLoxpX7E5t4t5kqnUBgWTt8VlRqDyDjbVBxE+ATCrS+jLdubgMBfX
   W9GvV4bm+E2ZN0MuqC2vG5KBQlNVUL2alsBvOYdgQakdrvDtW8K/dZ1cB
   ghJ9Z42UzzbWsbL/1dIslb4OnIWRsawK+7Tn72LzbLAWMsB93Imoa5SC6
   G812y9uWxyJGYWkPOXOQc4yfEQalp7VohadW2eA0I7XxYvduPpjzOhsed
   tsXhKkYWXA9/ISIN4acxVY7ng1dfq1gkXw1Y01xE+LcvI53l6dNZfdbpe
   PhWR2Gl6B9DeyrUmyBeFEjtS4c83haUBBbrX4NUvjKCS8V9ap5vNIHxiR
   A==;
X-CSE-ConnectionGUID: yzrkxef5Tk2Se9ski0whHQ==
X-CSE-MsgGUID: oqe82vL8RrC4QyVHbGr3rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="49733430"
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="49733430"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:32:31 -0700
X-CSE-ConnectionGUID: dLNhxLAaQNy06QKlWUOTdg==
X-CSE-MsgGUID: NuXbvAFqQhepTXR09b0PHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,214,1754982000"; 
   d="asc'?scan'208";a="181324366"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 16:32:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:32:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 16:32:30 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 16:32:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgA74GwmPS5PnQxNEYPI6SHb/I89e6vEaKoXS/uXQCbH+ezgPDPnFoOZjmlgxfr6ajJWT2wHlalJXgW+N3qw4ymiOkQXzpye5raQbTmcHAbxr33+NN5LZZl+CDokXihyNSV1Qeslt3OVDFKtr39f68J8C7ciAl1XvuvX8whzWdOzRqSdrv25fMpfk0gsZvjKjIvbHOUcatqf18x3/f4/NEdfTwVkHP4oM8JB/F82apSZ2peTwj3SoUm0oVo1IpCTZmGP8+ToRG90qfQW+05xqeWlbYfs9MfbRoDV/Ce2sziBbj/4NJm7Y088mgjut8yovdAQcsRu4WJZSjE5oTVwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmWYULW04GIMSstQIwpoLNvuM/fma7EmLPYmNj4Ob3Y=;
 b=EPI0vWVa4HmREkYjVSs5bJLvR+LP4OHhJjQN3P/ATs5TEvXpTK+bobfeb1j7iBGRhZz8Fh5YLZ889Y041ng2z3MV24hegomrCimt63kfzlNb6N9VOeZ+0TXCo0wVEJ3v/D6irfvgy+054HRA9+YHv87qvaXBXCwHlvFnwxqHiC7sxSJ9BgjX5bGFL19TWHT8XKNi8caXIkG3GJyP6PkDVnd40pEVusMWFWbdcPjaA3ShpnTHCWkKjuSJwGr9mPU2shXjx6IgMsSNC/ZM7+u6xg1aqx4tfpZlZqjmDc+cffYlxn5koxQXCYYrGiWkQQ9lqx7FxuNDQrr10x42EVgoag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by IA3PR11MB9226.namprd11.prod.outlook.com (2603:10b6:208:574::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 8 Oct
 2025 23:32:24 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 23:32:24 +0000
Message-ID: <7de22593-5878-4d6d-a90d-1a25b6639cee@intel.com>
Date: Wed, 8 Oct 2025 16:32:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 5/9] selftests: drv-net: xdp: add test for
 interface level qstats
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <bpf@vger.kernel.org>,
	<shuah@kernel.org>, <sdf@fomichev.me>, <linux-kselftest@vger.kernel.org>
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-6-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251007232653.2099376-6-kuba@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------w3FxNh3rG0lYPcAeDjFmxv2z"
X-ClientProxiedBy: MW4PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:303:8e::16) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|IA3PR11MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d30e802-e2ca-4e1a-0358-08de06c2ef92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODIwd2N2TlBpQW1Fd0V0VHozNVNZdXBTVXdtcE1DK3Ywdm96Q3F4RE9pbnJZ?=
 =?utf-8?B?TXdMVyswQUI2TUZlK09IN09aYXJmT3dhV0JuN2VXbDNVdVFucU8xNjNjN0Qy?=
 =?utf-8?B?cHgxT2lzNGhPWUlhZDhXMTVRSFVXZGVMcFdEdFZ1M1lXZmJneUU2d1Jkc2tp?=
 =?utf-8?B?bEY2MXBDWUhKNmZIajJCVk1WSWJZVDVoTFpCWUk2dEhETjNtdkhmQTBUbGsz?=
 =?utf-8?B?aUVhWXN3T291R0plcFlBRDB1bjNYTzJ3amwyYWI5cHdVMHRYbmxTOVZmRUt0?=
 =?utf-8?B?TWFQY1Mwam9Gc3ljTVRwVlE4T2FsYmhjSEN4TW9HWVpQdGczc1hFei9vdzZF?=
 =?utf-8?B?Rk9Qd3NZeVY0eUpqdTY5dnlLQVhkNjdpYmZVUzlOU1pSWTgxMDl4Sy9pYkh2?=
 =?utf-8?B?MjMxaGlzdWdDeHBMV3Z2amZscHpmbEJJS2hJdW1QdXhDUGtkeG9DWmFMc3FU?=
 =?utf-8?B?L09VME1uNmExQit4dURORDQxSTd3M25sZ2ZQN3Rta1R1WEVDcUU2YS9HN0Jl?=
 =?utf-8?B?ZGcyWXd6VHRZMi93eUp3R2Fseit6aWxWVFpZWmlrN1o0MVN1VWtuS3crSytK?=
 =?utf-8?B?M0Yva0Vkc1g1VkUrVU5iQUdRUDBab3N3T2tUTFJJbkIrN25kZEhaS1BCMk1v?=
 =?utf-8?B?dGhNZzRVaWVRay9TTXc2RERFMW8vaFRtK3pmYjdhSTdoZXpYWGRLdWE0dGxh?=
 =?utf-8?B?TklPS09PMXpaVVZKZ05QSlpEY0M2RTFMWWROWERiOEVvUm0zSzlJWUVHN2xT?=
 =?utf-8?B?VDF2RUlsL2dTd2doMnRTQzYwRkRJckpmSEYyOG5OdTFQOWRLRm1McmdvREV4?=
 =?utf-8?B?ZXlHN0ZPY1VGQ1lGRGtMZXhDZW5yU3EvdWtXRS9sRU5ISEREOE5LamMzb0Za?=
 =?utf-8?B?VE01clZKMitqWW81Z3hOcEp1TjcvejV2QUpHNkZZSlhwUDd1U2tlYjBVQjc5?=
 =?utf-8?B?Tmk3d01TRmRVR1kwQkszOG56aEYyYUYrL3JsZTNYSkZKc3RkTnpuRzhxOHh0?=
 =?utf-8?B?T1R1eE9SQWd2RitzK3JkM1RwbDhncUVuZDhhcm8rOHlpY3dMcGJuTy9CSGNG?=
 =?utf-8?B?WEdJV1paRVAzOW1qV1Z3cGZhR3lhWER2ZEI2UmpVODJoc1F4ekM3cnNGSk5N?=
 =?utf-8?B?c28zdDdUMGxVbFlHb3R0d25IRHBjNDFTR0drdzZuOE1yUGlxeHJRdm02RVhk?=
 =?utf-8?B?dy84RHFvSFF5VncwbHVUV0Jmc21nbUMvUjVKZHVLdkpHbHZmK0d4aFQvWFcx?=
 =?utf-8?B?dnJya1dFZ0tGVllqVmhwbEhJUkRPMnByMnhnbEgreElXaERCZ1cvTzRWZjRH?=
 =?utf-8?B?czJhZW80WVBjZ3o1U3FCWi90Q0xXN2ljUWJ1VitLMWRWTkJxa0NzWlpjdy90?=
 =?utf-8?B?bkd6WFJ3SGVHajJXTXlnTTYydWkyRmtUWUQ0K3N3T1NNelBMMEF2alBIOTgv?=
 =?utf-8?B?OVRQcE5yaW1yTllqakJ5aHl6ZGdZNWEzeWE2QU02M25PQ01vdDYrWnUyQ1Z5?=
 =?utf-8?B?VlE2QldENldCcXlsaHZjMERCcXVPL1ZxY1YzQnlreTIxVUkxcVFveSsvaXl5?=
 =?utf-8?B?UUh5ak1rL01XWGJtYzF5Z0hDWnd0U3FZS05wV0k3OTVqWnFSZWFNeTNZWEt6?=
 =?utf-8?B?TXNwNGhJUUJaUGdCcnVHaEg1MG9QdS9aWGVRbmNzVktwSzZDSHEzNVFoRWpW?=
 =?utf-8?B?UmQ4SENOK0NmTXZOdHd4eXA2NEVLUmxRU05NMnF0czdQUnNNdS81cmdVRUsz?=
 =?utf-8?B?a3R2Y3l6dlNJQVRGTW9lT0FQb3l6Vlpwd0c1bUpudTFLQ3o3d21yY2hhVjlq?=
 =?utf-8?B?YjUyc2Z1aUdzUURYWGNqeFNqQ2xXV3VyTElaRy83TXpSeGFaZ3F6czdPaWd0?=
 =?utf-8?B?emtscE5FYmUzdnN2TTlJZk5WL05uMXZVbHNLWjI0emU2ekc1bDJKRitJU3Na?=
 =?utf-8?Q?maQ/CNVGUXMIXRTIRCNu4YgP8SP+c0FU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVBhR0hsSnBLUmZNRVl4emllUW93TERYZXBWWkEvamFUVG9mVVYwWjVHTmNa?=
 =?utf-8?B?NUhVNERIcHJLZkFFWms1VENCZWhIalptU1VhRkNCc3llakk2cythN2dyamV1?=
 =?utf-8?B?YlhIT2tYTHh1Mjd4b25JaEtMNEJYRlRkTFBTdFNoWUpyczVwUC8rQzZFWUdj?=
 =?utf-8?B?TUgrcTRlRVFsd0JYTWNhMGJWU3VmTXdIdGIyV2VoT0VBcTA0MWdmT1lMYkN6?=
 =?utf-8?B?TnJZL240eTRNYXpjd1Jud0o1ZWJ2NzZ4ajFmcHpZR2hoS3J6ZjhZbHZFTkd2?=
 =?utf-8?B?alVtdjM2Tk5hZ1lENjNNekdaZlRDL21FWlY3cTlhSkZOMnp5cEVjZ2U2d1Ix?=
 =?utf-8?B?WlhpTndZa3kvMzN0KzlQMVdOOU1iQ3ZSK2dBUHpCaHg4MDJ6ckRDeXFDQ1JD?=
 =?utf-8?B?NUNNZWJ5dlk3dCtYd0wxaDN5VGt0T2x6cXg3aUZYTFJiNnFyQnVSRy9oWWJT?=
 =?utf-8?B?Wm1iSVBjNWIvRkhBWFM2MWFidDhpczN6TmY3Rm1ZZ0hxaWRMY1NHd0VzTklj?=
 =?utf-8?B?UUlEUDRnNStEZ2RXSVFPQ3l0MEhYUXluWTdSMVp0TjgreExGcml6dGZQM1Ez?=
 =?utf-8?B?UGc3WjYvaHN6b3B5SDlTVzhrS1NhZExuSXA4OUQxK0U3MDFHT0NZTzJHVUlh?=
 =?utf-8?B?Tm1kYXpvTmpBLzQ4SlNjL2xBU2dBUHlRSkdLUXdOeUVHTUk2blhZd09hclJK?=
 =?utf-8?B?VGRkU1RteFdldGlhaFRxVElwaVhTREVTcGtOZTdObWFQdWY0UnJWRElHRHZw?=
 =?utf-8?B?UUpycjF4N2JrM2dWRVY4SjJxRGcwYTJ4QmdRRzNPR1B6R2NpdS9WUlRPb3Nt?=
 =?utf-8?B?SGI0NmNhQjl2b24wWVdNbTJmdStON2w4TytwVWxkN2NlNlNrek81bnh4WGRR?=
 =?utf-8?B?VXNTeGM4Sy9JMkxTVkhCK3ZEZzIyUjV6NVdKV3lYd2pGMCt0VEtLbmNVcUtG?=
 =?utf-8?B?eXdQTE16a1FRYVAxYkNTQ0hKR0U0QUpGTkFQSU9GOG5sUjRCYXZMcDkwcWpv?=
 =?utf-8?B?bWRLSHdBemVjakljdDFMWDVRQ0NGS0lZeUExSWEwcmliVDZyR2NJMndhNG96?=
 =?utf-8?B?ZDJxY1Nqa25kRWMwbmpBVytmRXJPYkVnVzJUZ3VaZEZMSHhjVmpOSHpGZHI3?=
 =?utf-8?B?ZG1MdEp6NVN2REg3YkFDejZkMEkxMmZ3bVkvWExqS3NzN2JqWXNZNWJoMFNv?=
 =?utf-8?B?N2twTlJQRUlVU291S0VvZkR2YVNMeU5UcUtxVmd3bzFRb3JQc2JWckoxMDkx?=
 =?utf-8?B?VFJDUzZxcSsxM0lBNlp4RzhmR2lkamhNUTBiUUFyY0hmZGV4SFZNZktlc0xr?=
 =?utf-8?B?S1FuYXlXcGk2bnoya21lWWFudFVEUUhPYW5SZUVZUDZHMFFiUmkwdGlaYWk5?=
 =?utf-8?B?VmVVbllhUFBicGxUQ0tDODdkclpKYWJya1NaREdxUDcyR1dRRWNKMTlybnRT?=
 =?utf-8?B?K21pZTBzWDk3VGVqbHErUEMwUTRzL0ZWUTdhRURIclZHb3paTVJ5Z2p3R05t?=
 =?utf-8?B?bmR2dzJjZVpOTkl2NnNPaVp4WVQ0YnJBYWwwWi9uVUQ3SzZrUUJMMzIzN3hD?=
 =?utf-8?B?U3J6OXJLc0hRTGRsZWFXaVFaU2ZETncyVEYzdG80N1h5Y0tXc3QyWEdYcFhJ?=
 =?utf-8?B?ZjNPMHh5MS93WWY3R3B6dklpTEhFNGl2bklhajFmZW80S3ZTMGZMdHp4RFZC?=
 =?utf-8?B?M29wSFJ3VitESk9oVWYwMGhxV09xWk02c2JKUGozdXlIamZLRlM4ckM4dXFL?=
 =?utf-8?B?ODNMYTVTL09HK2o1V3FKZG0rMHdKaE52WlNQRERPZERuQ29DYUo2V011a0pu?=
 =?utf-8?B?ZDhqOU9aMHVQSWpaVEJyNUZ6cjNOMWh1RXI5NUw4eGp2NGtVVlpuRlh0R29G?=
 =?utf-8?B?anVvVFpxN25ZaE9jdjFOejlpODRlOE5sQldVWUVnWUZ5NkRzNXptU3NoamU4?=
 =?utf-8?B?QjRyOURsU0g0M1RZR2Jpa2FhSEp3MTJ0NWVOQkMwTEVMQ3hVeFZiTi9xSjN4?=
 =?utf-8?B?eEx0aXJGdTJwTmlWd1Jkbk1Ea1dSMUlOeE5qalhCRE4xWjg4czIwVVg0MXJX?=
 =?utf-8?B?eWYxWi9ob0RBMURQc2lKTlJQell1U1RDOTVNZm1ncktMUGxZelRSR25QTUtl?=
 =?utf-8?B?QnR0TzJzT3crT3IwNXJ4UG9rV3NjNllJOHMwYjV4WkNJYnBGRms5eTdxNmFW?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d30e802-e2ca-4e1a-0358-08de06c2ef92
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 23:32:24.7260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mBghcGgBt4WEcPvOV6ko9bU17c1abojVRwXeehVLnb4Mf5Fx5XfMkNHOHE6GNVQvaRZSLrcF6rHhKWo0X/3svJIckFj59ZWgQ6moJKGXpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9226
X-OriginatorOrg: intel.com

--------------w3FxNh3rG0lYPcAeDjFmxv2z
Content-Type: multipart/mixed; boundary="------------wTGcZMvPKef0RO499jk0kBrR";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, bpf@vger.kernel.org,
 shuah@kernel.org, sdf@fomichev.me, linux-kselftest@vger.kernel.org
Message-ID: <7de22593-5878-4d6d-a90d-1a25b6639cee@intel.com>
Subject: Re: [PATCH net v2 5/9] selftests: drv-net: xdp: add test for
 interface level qstats
References: <20251007232653.2099376-1-kuba@kernel.org>
 <20251007232653.2099376-6-kuba@kernel.org>
In-Reply-To: <20251007232653.2099376-6-kuba@kernel.org>

--------------wTGcZMvPKef0RO499jk0kBrR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/7/2025 4:26 PM, Jakub Kicinski wrote:
> Send a non-trivial number of packets and make sure that they
> are counted correctly in qstats. Per qstats specification
> XDP is the first layer of the stack so we should see Rx and Tx
> counters go up for packets which went thru XDP.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Good to have this covered in tests as well as doc.

Thanks,
Jake

--------------wTGcZMvPKef0RO499jk0kBrR--

--------------w3FxNh3rG0lYPcAeDjFmxv2z
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaOb0hgUDAAAAAAAKCRBqll0+bw8o6L8W
APwP8amcN45XIXzNMpMSsOyWx6ddsuVYJHjRJchznYKCSQD/SZFP0gNpVQOdg1dHqjhNTaIp22Q0
uZdnhZQwIMdURQA=
=UWw1
-----END PGP SIGNATURE-----

--------------w3FxNh3rG0lYPcAeDjFmxv2z--

