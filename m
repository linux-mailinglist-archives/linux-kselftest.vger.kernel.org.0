Return-Path: <linux-kselftest+bounces-20591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0280E9AF596
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 00:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4581C217D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 22:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2C221730D;
	Thu, 24 Oct 2024 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yga4K9Kh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2232322B644;
	Thu, 24 Oct 2024 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729810292; cv=fail; b=G7+lokvTbPdUz8X3WMGrkOEqxsFRVoDu9QjqvlfCJmpbrKN34hhijEh/3rYN9l96XGxTn1stLSsizqIcba9l3ECDetpTU49q6xpJBtWQsSq6C4Z578XlYD0U52MQsm0ojLOrXDYyPIxXR3RGk6BAZiKSWh+Vw3EJFI1ZHeblViU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729810292; c=relaxed/simple;
	bh=F3VaF9lKVgk4rhWysom2FAfKKzYAzG+cWpVH4YQ21uY=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z9M2HAW51dBP6Rcja/k3yXrzLyhyCqtOreQ2DfDuRdrVbGzPU5+cK2F5RO132MIAujMOGmrSb64NU5VV0plPVuBUKZs2aNIJuPSgfWPowKEUxFcb169WZK2ZrBP6kC7a3Sav0onnENnVOymYMYL000ujNFKFMlavdc+BDl1z4Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yga4K9Kh; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729810290; x=1761346290;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F3VaF9lKVgk4rhWysom2FAfKKzYAzG+cWpVH4YQ21uY=;
  b=Yga4K9KhqNrdsg/KBzQTbnleUwrqQbkv2P2cpGus+fDrGl0CJAntlrbL
   xFR9Cxyv18UspXH9QtO5R0Ot8sYZ6oG06acwd6zFs1q/foLyT8eJA0h3C
   3ZEnkHxCC5PR4McSw9FrRc59Z4PBH25+siK8Zr29dZj4gFZF/nIb70LJZ
   ZUio+qHzIW4VPP73taiDhgu/ZHfxhKD4cu7MEEFAcVbhqUXsVR+reUwUL
   u0xRZGgWLJScJ+PkKeFTX+ibed6fJu2L6kCelQ534MNCRkMsipXIrV1K3
   hA+w+OKf022UEEepyHRTX0ht90bMtNli5/pcsodzt1wdUO89Ke5hajz/q
   A==;
X-CSE-ConnectionGUID: HL9ArYX6RYOMEljldU/00Q==
X-CSE-MsgGUID: eqzEihqgSJawgS3wscxqxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40058438"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="40058438"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 15:51:30 -0700
X-CSE-ConnectionGUID: ddOX8heuQqSarVG2qAigPQ==
X-CSE-MsgGUID: HM3M+ie7T2+N/+b2SE5afg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="104050645"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 15:51:29 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 15:51:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 15:51:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 15:51:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wf5KzWB98iP8RVd0HJOndH3AeuoO79WExchjP38j5DBZhnuI7JU51KeNul8xJUHPeA5CeNWPC9E+2kCBwutcSHsHJkQoNlR0OkO5aE2scoXgcSgPbIDdSoiMvkMcvc5hta/8afxMTOaXX1NuVx4nRlalmNvTIleQv+4OMX4Bn6Fqldw5+PjQtvMceRqVDhlbtwiIavhGvGXvQwnrno2XY9wBhd1grkBsJwasrudJrKXwZmFeP/472z/sRWPA9QZuPSZvd8DGG8oYQyrwcbBsEsz7ZQZPSUBdwIIElVHW/eLuQIufrc8OeA+8bbGXAsBKRxRTT9cKJ3HUM+aaczMdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmTh6ZeBisPfzyD0P6Y/nTvJ3hBn7JzktYvXe2qVTaU=;
 b=iz82wb2VJ04fhSCJUp5gjcwjOoCPozG4qSTkwdBk+kQnZ6o8nt3pclOld7NUwPJfagR71G1coEO0XOC0OA9VVo/n3PXnrbscfVsnvnbSOqqG5/GaRe6DF3Lw4+AR1E2g5LNt8DH7lYgMR49I/ovUrf1K6YsS2G1VNHNS+Dn4rWXMvJVR6+EMXlHs8qkcyzrT1DXD9mHAzI64n6ypxcXdSpWfpLPQLs3H9Onx2MG+Fgr/WwjIBz9E2V7pKvaUYDosT18CNzhcVtoksjkUjFrXBAUvxhf7Fe2TADiA17axTn8gKxUB9Nx3vXvCJATEmZA1rgUI1aomd+LGGYXtFXWm1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8744.namprd11.prod.outlook.com (2603:10b6:408:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 22:51:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 22:51:20 +0000
Message-ID: <b0ff78c0-2fe5-4350-94bc-cc6b21960cdb@intel.com>
Date: Thu, 24 Oct 2024 15:51:18 -0700
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH V4 00/15] selftests/resctrl: Support diverse platforms
 with MBM and MBA tests
To: Shuah Khan <skhan@linuxfoundation.org>, <fenghua.yu@intel.com>,
	<shuah@kernel.org>, <tony.luck@intel.com>, <peternewman@google.com>,
	<babu.moger@amd.com>, <ilpo.jarvinen@linux.intel.com>
CC: <maciej.wieczor-retman@intel.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <cover.1729804024.git.reinette.chatre@intel.com>
 <aa643c9b-8ce5-4cb1-98f6-645224aafdf8@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <aa643c9b-8ce5-4cb1-98f6-645224aafdf8@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:303:b9::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: c25770a3-2325-4f0d-0fc3-08dcf47e60c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2lJZzNUaGhiMDRGem9YZ1dOOUUxNW5BWU5ES3hUVDY2SHhkWmE1bXZWTFlu?=
 =?utf-8?B?YVhSREtRSGdBTm1hV3BTNEdzZ1BxTHRJYThVeDEwS3oxTlZLRGtXUnQ2VkU4?=
 =?utf-8?B?c1JSSmRkMitma2diV0tkU2pmd0swb0IvN1QwTDU0Z01kTFhYTjgweGJkNWg3?=
 =?utf-8?B?T0czUzBjVWZnckUyTlZrbXRuZ2JuUnIvUEhXd0N4K1EvVk9PcFVxSi9sTW5q?=
 =?utf-8?B?SDhYTUZyTFhxbGJQd1g1N2lNWjN4TCtPN0lqWjJvM1dyL1dWRkFsQTFGSmkz?=
 =?utf-8?B?YzVjMy85Mkh3cFpwR3VXeFFQaFVIQnIwa2FBNms2QTU0b2pNaDZ5TUthYk56?=
 =?utf-8?B?Y2F3TTloTXNlKytkZjRucWlFUFR2bm41NGp3dHk0b1VrK2hiWEgrbHNlSWhS?=
 =?utf-8?B?a3ZpUk9DRzZJcDk1YzBHTHV5NVE5TklWWDdUcGdOWGxZbm9KMHNtODh4VmFj?=
 =?utf-8?B?SUlCTkdnQ3hMeEZWSFl5cWlGZTdsOG5JZmt5cWJzcENqbEJmeGlGWU1sQ1R0?=
 =?utf-8?B?Y3EzVkVPeDI1dGxML3A0LytrdENvWUpLZHJsNlFTNnNmUmRJYUp2RFEremo1?=
 =?utf-8?B?d0VNVFNqWU16N254V3B6QWF3bnRuUCt3YTJCMzVVdGgydDhyaGt5L3RoUXo4?=
 =?utf-8?B?Z1dIbk1VZk1nSmVJT1RoMHFlTzI5WUxKa1ZXRHEwQWFkOExEL2liV1ZsVXJK?=
 =?utf-8?B?eklzSW53NHVlYjdQVVZ4TDkzTDRpV3VUUlRHVytneGU3dU9iMC9veVlxK25L?=
 =?utf-8?B?MzN3V01Mc3p6Z3ArVUNVYkFoTG9ESU1KM3RFNFV2cVBZMFAzUU5yWmtKdHRE?=
 =?utf-8?B?eDFCZEhFRGhIdnFaYURQU043MDVtcWNFUmpqb3ArVGpsTG9KR2E3dXA2WFF5?=
 =?utf-8?B?ZDdwMTFpWThKejVHd1d5a3BYdkt5RjFOUG9RYVVmQkVwcmxpLzBiY0V4RWVL?=
 =?utf-8?B?ZVlHSDZWV2NFeHlOTEgyaDNscVVGM21XZCtkQ1hmZnJRT0twYmhhdTRPbXpL?=
 =?utf-8?B?OVo5WllzelcrQkhkc0dnekJVKzFaQjBNdTNzMGhIZjF1cUcvRGc5LytoVWpz?=
 =?utf-8?B?b21sQTRHZytaaDlWZytkUGYwdlgxT2ZmMTkxK0xsYWcydjhSdFZGSHhUYkdo?=
 =?utf-8?B?d0FPRnMvZXRmS2xDV042bkcxbDlCU0g2c1Yxc0tHTCtKd0FjcVozVVB5TkZx?=
 =?utf-8?B?RXk1ZElpaDVhbi9TMDNlUm4rWGoxdEtTR0VKbVZ1V05VdWhNUHFPZ0lzOGVW?=
 =?utf-8?B?a0tuTWwvTmpBR3h0ejBLWlB1OThMTHpoMWp4MytLUk5leWVBcmI3aHNlZVVU?=
 =?utf-8?B?UjdQMHdOVkUyeE10dDkyU2ttR0FEMldTL3JpbnRUNkJFMmZEa1pQSjMwRzhN?=
 =?utf-8?B?cGJoVmVIbnl2dU1nbUcxWjVrZHlTekZtOVRaSnlvaER4NWF4S3lUUEcyaUdh?=
 =?utf-8?B?MjJ5ZE9OSlg0TnRGZHBQMHI2YXhPZXlwZm5QSFRycnhGZXoxVkkzSDFjWHJT?=
 =?utf-8?B?TDhCL0ZFVGdWMnZ2Ykd6YVBIKy9LRkwvZ0ZoVFptdGprdmhUUEZJdXhzb3Ev?=
 =?utf-8?B?QVBLWFgyTHh1ckRqekUxUGQ3UDhEOXBHVUhpSzN1ZExKcVVaMzdKVXJwcFZ0?=
 =?utf-8?B?S1ZkanVFbUFUb0RNRXhjdEVlYXF1a25CajlCZ01zZC81c0twd0ZQbmlBSHZP?=
 =?utf-8?B?UlEzRGJsUHhkNnIwTFh3dUkxWjFEbHk1Z3BZblFDS3gxdVBPSFlkdTUzc1R4?=
 =?utf-8?Q?Wxk/J1wWac2RN6eQWczssi5L5As57twBXSKz6Lg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGxVc1BGV1JtclNMenZpWFBCU1F1SWVQLzE2R2lTclV4OXVKVWFvNFc4Z3Rl?=
 =?utf-8?B?V0h2L0NqT0IyYUZRUCtVMmZZRFBjSStMMHVnY3dXK3hrc0dPY1NkSzMxcFR4?=
 =?utf-8?B?VTc3RmJwVGRFYlNZWnYxOUVmNHo0cUh1YnJiV0txRXF5RGVIK1ZwZTd1MmVQ?=
 =?utf-8?B?blNUSHBraGM3Z3VJNDFpTjNOWmc5SzBBZTdnNEwrVjVsZ1BkZTdER1NKZUpa?=
 =?utf-8?B?bW01SnB5QS9MUFM0bzVSN0szV3Fsd3JuRWxpdFhwaHM2UlhGZWJVRkUvaVow?=
 =?utf-8?B?YnB6QVZmalFObHkxWGN4VDdtYkRQY3k0V2Jpem5mY2Irand6MjkxKzRXcmZL?=
 =?utf-8?B?NC9TOE11YkQxYUdBR0pIWHdpQ2k4eWRMcUQrbHhKTXh2djRnSHZoaFZ3VUs2?=
 =?utf-8?B?OUxYaTFyZ1lEa1M0NmNLQWd3VnJ6SVRnT2dDa2xPUzJTeUErUDhUeFI1ZW5a?=
 =?utf-8?B?VUVWeXNYOVdmL0l3YzcxeU9KQ3B1bGhBS3JIZ016U3FiZGl0eWxPaDVleTlz?=
 =?utf-8?B?MGRXR3pYVGRGcVpjN2hSVHU4cmM5SDJscEI2ODB5b3Z0d0ZDSkY0Z05qRlUr?=
 =?utf-8?B?NUFtSEM1ZFhjYzBuLy9oZnVqZCszaXZ5L05kbzN3Q0Zhc0NvTkNnWmVZREdX?=
 =?utf-8?B?NWpVZTJxaTgwR2l5a1hWaXkwYnd4blFLajM1YlJTdW1pYzgxaVhQUTZaZmxy?=
 =?utf-8?B?OVJYMW9iQlBVTnlDRHhiWlI2ZkhqVFRjb2ZaUmdMRGFaZnprRW5sMktvWFVp?=
 =?utf-8?B?SXZQbjZPUkpCWGVDRTl5cHJRQkw4TTlwVFhwZ2ZkWEx5b2FHRnNCd2ZldGhz?=
 =?utf-8?B?RmFVSUtLcm5VWFdjbXA0OG1vcVNhT3hsMFd2d2xmMXJCS0Q0Q0VTSjA2KzUr?=
 =?utf-8?B?SDB2ckpHU0xZamprM05ZTkZvMitQM3laQkJ4ZWpKSTUwZm00MGJsNk1ERkJT?=
 =?utf-8?B?QjVIOHdzOWEvclI2MGk5ZFBrZDhob3l2Qkg4bVcvSmRKcUFYVk1ESXNDV2VU?=
 =?utf-8?B?V0VsdEQ2NU92Q0pxNkJTOVQ2WE1mYTRKempWWTVkaXpqc3J1VjdtNGxBcjAw?=
 =?utf-8?B?WFg4K21hV1lBN0NFWEUxajh5NnZIRmRzalZqMEJVUnJ5eitxbDludld6VXNQ?=
 =?utf-8?B?RGUzQzlFazdyaEJLM2t1Zmp2Nklld040b3lXK2NVNG05bExON1M5dVlqZWdP?=
 =?utf-8?B?MUJxTlZZWjhkVlFIU0d4UUs4Y0hnd3hXZjFRTkN1Q3p6cjFyM1VVMVMvUkYy?=
 =?utf-8?B?alRUSXpoWU95NWY3K3NiSllmbDNOVkZndElTS2pwL2lqVDFmelVQeGVUdUdr?=
 =?utf-8?B?VzFrczFmWVJFeTluT2lhelYwUEtCdHF6VmR2cEwzSDNBWkxjTW9RUjh1Y2FY?=
 =?utf-8?B?d3FHK0Zva1crQk96aERudW9lZ0J5NE1heVhpbk9QN0c5WUtTbVV2U2RGN2hx?=
 =?utf-8?B?MnZWOERscDdjM3YzanN5NTFLY0gzMjNhRGZuT2pQSHJqT3VPbU40bTZ0K2ww?=
 =?utf-8?B?N3FCdlhYSWtCZXQyaldTTjR2eU8wVDJRejVnQkxrNGdyaVhMUDZYVkVQcGNn?=
 =?utf-8?B?VkUwajd6c1gwcm4xcCtlMm0vUE16dzRuVDA0eFNGdmR1K2FCSlMyWDNZblhE?=
 =?utf-8?B?WUdXa1JaTGpLMnJJbTA2ZnlxaVMzbk9PY2lUWE5LQWNpanV1bGh6c2NMV2Ry?=
 =?utf-8?B?aG1tejEyQllpcER5a0ljVDc1Z2hkMDF4ekxyMWtMY2VDM2lDVG9kN1h0aHdI?=
 =?utf-8?B?QjBJNU00Z1JyeVh1SEVMSnczV29PUDF4bE90cjY0cTlTRFYyZ0FqbGF2Sk1S?=
 =?utf-8?B?YlB6UVRUTE9YcnhwR2l2MmdDYnF4bUhrbDIyMDg3Vk5nczBrcW5oakxreVpS?=
 =?utf-8?B?OWZCbjQ3MHljSVRldkVseS9ZbTQ4NDFTZHhHY0JwNEtMLzMrVUUrdFZ0K3g5?=
 =?utf-8?B?UEo3bVRqSm9kYjI3VDJmTlJOemtjTU52WVdaSzZCSmVqWEVRYVE4cFdBYStM?=
 =?utf-8?B?UXFqSklJenpJOFo1NlVGMCtNUkcwQ1VwYTV1SERLcW13dTNkK2NNdVFHLzBn?=
 =?utf-8?B?SlhkUzZUUEl0QWRDVDQzT2xmM0d1RGhyN1FkQXMxd2JQYnBQOCtjOWJEc0I0?=
 =?utf-8?B?aGxvUFNDZzROOXJkUk4yaGo2RkxidXZVaWxsbTNtMTZ2Z2pqQkpacEdiU1Vn?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c25770a3-2325-4f0d-0fc3-08dcf47e60c8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 22:51:20.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDw8ELGHPuEeFN+9y4HikSrgvx126sAKp6tAArR5L1248m2XKFlBHeklxstO7uMUmZVtCcqeQfEf33H2lkjXy6sYI0I8M8ZAlJxsyY31xcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8744
X-OriginatorOrg: intel.com

Hi Shuah,

On 10/24/24 3:36 PM, Shuah Khan wrote:
> 
> Is this patch series ready to be applied?
> 

I believe it is close ... I would like to give Ilpo some time to peek
at patches 2 and 10 to confirm if I got their fixes right this time. The
rest of the series is ready.

Thank you

Reinette

