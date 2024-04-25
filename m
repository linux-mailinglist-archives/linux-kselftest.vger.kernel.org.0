Return-Path: <linux-kselftest+bounces-8841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA84D8B19F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 06:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5AAFB2486B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 04:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0348374C4;
	Thu, 25 Apr 2024 04:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyGco6I7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B232B381A1;
	Thu, 25 Apr 2024 04:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714019838; cv=fail; b=kUxo7GgRgtzZWjr2WX+OtYc20ub24BrR3hi82s37sovtuRijEn6OLk0tH7qALsWgVz8tnlX5CiF5o4beu9CZJs8gTp6on9TmYftN+PcnLnev3c8a2qbKUuN2QXyXreVxPbDTGVSazBYwMf1fNKxJjzBmhxjnf++k1XwHcExbbE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714019838; c=relaxed/simple;
	bh=pllXv/uT0T+nlJ1GPdeQ1umLY/UdTyxh85VDi+RtrXU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r6fTOpajHpjCjJVAH0JnsKR66Fz9uQYGNQbiflTuZmvw3XY6aTIJoMNdaAKrFZvr1IcF9WqW5TO7Cma/VCLvAXP1bqXwBCpbJ3CTp9uMO9k2n0X2X1HtIZ3b4i1jMgFWi/lyO9hrbNWuN5C+tdc6CQiBq24VjBrAG6uvneNNipQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyGco6I7; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714019837; x=1745555837;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pllXv/uT0T+nlJ1GPdeQ1umLY/UdTyxh85VDi+RtrXU=;
  b=jyGco6I7Qq59zWE9SGWcO6aLOyvoX49deFR3KlS0GjiO0tVQioxFBoIH
   HEa5ULoLKPXeqi/LojeTXIOuk03cG3jZ0cODsDqHsoxpNeaCvnhOnjVXw
   TDsLYEq1NmwK/SwDflWuLZpykyI8T7nCgjsQ/06F9dudX/1FLeaSuvILZ
   REdoTp+Q5mphoRHK0QcanYP3OXwCpH8UG9ksdqbAToOZjDL+H/ew7N9I8
   7SxXuxVc4ZuLINlYPA56qXmght30zrP9u8j7YPSF8DUrUbVSRMNfjgV5U
   UflBIaQsMoon2Cuu/+2Luq06G/S450wAPSnfP7PxANC+vjWEJX4LsnHod
   A==;
X-CSE-ConnectionGUID: EKsTUVEJRByILB/iAFmzDw==
X-CSE-MsgGUID: Jv41k3fyTwCQxmUtgXnqjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="21094257"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="21094257"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 21:37:16 -0700
X-CSE-ConnectionGUID: 0gnhQw6eTEyLRfupXQN7Nw==
X-CSE-MsgGUID: YlA8LXzlRHOeqn7o1caa1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="25366467"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 21:37:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 21:37:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 21:37:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 21:37:14 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 21:37:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDY2Ps/1INze/TM1f5RL2s6XQUQBASAeppW/dkvDf95wB7QYVBjtmlVUPAtwd1A66lq6Cx8qdLEEhi4rVb+I+A2m/BMhExOjvOHMczFI9VtFiRhcs4Oyssg5M397vg+EGj5rQswxG91i4tVxGYunvUuc4TvEylo8ldKkXV7BW7RxpDYi/bVM4vWWiojG4kM3XvzlACH8KTOjaKnnWl7sKU4ne+kJ4cHegLhXtjz+TM6WfhkkY3p2fhsBfRajzexmlGBJ/4ipYBI7pHHFqWYg/qvFEbQDX1TteQ3Bw9QKJreSlxCpbdNtVGeRXFw4em/itiRKNR5O0X2nSLKiWn6XXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/AMJByr2r8REPvCzQ8T9VZY8J7MYZTWn29+Zq9Ge8g=;
 b=FE7Q7iz0kiGnHTRPbfoX8IKsDMksz4jodtDMX1dEH6RFox3Brq9CYi0hI52gvLbKQr54lEna+rLA6jViZ58G/dvgXX8qjd9Wwj94xjuAzJrm+5LKcNQqPdu74mz2iaYZLXZW14EvXJ2wmVoWLtLXMxop9kyl+TjMWe7Z+ozQfPGh5QAQkDak97N7v+pxFdfnxmuQo4OZp4zuPxTRkO03hXTnuGF/6iHtculQ1bymcuvNh6K+P+UtSTqGFwa+JVCI0V1irtlwA5/EbTd0G2z5lSkkKmf9c7EdC5PVZZDi+dSu3d0vkFzKCCWA2tz80r/4xHUjOp7aE4PCNfbiIAamOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7330.namprd11.prod.outlook.com (2603:10b6:208:436::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Thu, 25 Apr
 2024 04:37:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7519.023; Thu, 25 Apr 2024
 04:37:04 +0000
Message-ID: <a35a663a-090c-45f8-84cc-1f575ef107c5@intel.com>
Date: Wed, 24 Apr 2024 21:37:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/16] selftests/resctrl: Open get_mem_bw_imc() fd for
 loops
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, <linux-kernel@vger.kernel.org>
References: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
 <20240408163247.3224-2-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240408163247.3224-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 51464050-2913-47c2-2848-08dc64e15b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjdmUTR6SFZJTlRvRUNRY3JiZjQ4YW1TT09vaVNDc3BCZ1dTTnVBV1BQVzRw?=
 =?utf-8?B?REVENTVralR6SFo5L1JmYjYrZFdLdCtRVkxvV1drVUpYYU9MWjlFckJFeEFw?=
 =?utf-8?B?UXg0aW1qVEp3NUlLcDVtNVhBQXNoODNzM3IrUVpSMlQ1RHBaUTd1eVZ3TnZL?=
 =?utf-8?B?V3pCMjd2WjltZU5ycWFWNEFTNWY2V25VV3RscEJlbTh2Nks2NUNsNERqSjNB?=
 =?utf-8?B?c1VVcS9ZKzlMdmF0dFlyVDRPbmdZS2FPeWZZMy9mb082S1FDdnBqSERZNGp4?=
 =?utf-8?B?dS9xOEtjVitsR3pSYm9pbUdhakV2dGtIVSt0KzJXSVhUeWsxc3M0d0hWV1V4?=
 =?utf-8?B?RW8vcEFSMGErNE43WlhXUndyUmluQnJ0TzVBc1NFOG9IczZUaVZRWmFVM3V2?=
 =?utf-8?B?UklEdVdGaVNNWVoxK0p3MTB1WmhHeTkwem9FK0Jhb0h1NmV4eS93NDVYMW1u?=
 =?utf-8?B?cHhKQ25YV1dUS0VZVzZoZlVmT2ZvY3Z2bURCQlBXcTZWSmk1RGZEKy9DeEdY?=
 =?utf-8?B?ays0NTBwU3ZWT21NV1lCQXVGV0R2bDJRc3NVOEQraVVDZkZUK2VnUjhqZnJp?=
 =?utf-8?B?VUJ1VzA3OGl3ZkR4ZlUxS0pxUHdpK21kSmp5U1VyZW1kRDkvaHhLSklsbjdB?=
 =?utf-8?B?cEVacUV0ZUY4Qkt6RUZkYVBlRWpIYWw5UTQ4UlI3K2ZuY2pLVFhFSkgwQXFn?=
 =?utf-8?B?aFB6SVY2cnFKR3lVc05IRzBGL3lOR3pINzRENjh3TWhneXVXZ0lVZnlFOGJE?=
 =?utf-8?B?NmJDT3FqSjZaVml5MkNYVThTNXpWMjJWWTMzaGd2OXdMMFdicWxKT2FUMWNC?=
 =?utf-8?B?bEkra3BLeHIyUVJsTHNubmFwaWd1OTE0L2FDT1Fhd0gwNkVTWmZMMGFZdDAr?=
 =?utf-8?B?anB6eHpmc3VhRExwYWY0RFloeEZVY0dSeXkxSnMrS245NmpUcGxGUHhJcTRn?=
 =?utf-8?B?WDBIYmQxTEsxa3ZzN3Vyb2hBWFRZc3NBdi8zRURjQlIwT1NvM2hjRVUrSmlX?=
 =?utf-8?B?TXhCTWlMaVJSZVQyWkIraEtQeElpV2o3cjVnY2kyWnFhNy84SWdZY3dNOGo5?=
 =?utf-8?B?NlBURG00TnhqZzkvM0JlaERxRDV4d1ZvYjJnVVFNWUJaUEJVVGZDTzVXL09Y?=
 =?utf-8?B?OTdiRHRFeHU2Z0pjT2VOQmFFZDZ2S1ZnMzJyVWxRdFB4T3NHK0dLLzgrdEpx?=
 =?utf-8?B?ZE96MjdqNG9DVWdRTTA1RlBiSXpidkRna24yYisvYUtuSDluU3dTdHp6UWZv?=
 =?utf-8?B?NDRUMHJtTVpBaTdmMExkdlRvVlp6Vk45WU81MzhjRmMwV1hXQm1VbVUrVC9Z?=
 =?utf-8?B?WVZ3b1A0dWI1U1I0RytsOWpRcityNFdVSWhZb2pXR0dXV3hMNTREUmh4aEtq?=
 =?utf-8?B?bG9HVEFvZ2dUelpSUXhZSXRyRHM2Z25zT2VSMDR3eTlFblVRdVlkR1V5MStu?=
 =?utf-8?B?TkIvSEd0eUpDUldkbk1JSVVYaVJYTWJZa1FNaWtYa2wybHR3VXdNSHVKanZo?=
 =?utf-8?B?VS9UWW1ERCtPTnpVbTE3N09sa2krcW5iZVJyVVJ3U2hTNjRSQXRmYzJmMDI5?=
 =?utf-8?B?MitkTXp2a2FVeEEyMlZQZEFiWFVzU29pSjZSWFBsSnYrODQ1TG1Fc3VPZ1Vw?=
 =?utf-8?B?eTZHRDVpcm9aT0VIWlpmMGhIM3hYeDRzL1p0L2VXWDRJRWt4c2duMThyVmpi?=
 =?utf-8?B?QnMxaEVvZ2w1cDd5cncyZitRTmhQeFJVdkRGdzBNMkpKTGJvMlEraU9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXp3dlJzU1luUitaWk9iZFpML3IzdGdROTVFUWg2SFBTZUUzZms4ZUo3R2NW?=
 =?utf-8?B?Mm9KYXFaRmFZSlNZZUhjYW1mOEJkeUZnSkJzN3p0TVZ5dU1wWHNPYVhBOUVr?=
 =?utf-8?B?S2J1WDg2UU5HQWt6MDRRdjdRNUI1NEcxRm9PQWNxY0Fvc2lWNjYzMHlSN1NW?=
 =?utf-8?B?T0pVUDVPZDZBNEg4cUR4M1ROUE91YnFKelBXbGtQVXBpMVVvNnM2cG9BTGE1?=
 =?utf-8?B?RGpDRk85ckNRU1UwSUVlMjkrSElSckpTQnVvcDRUclhMT1hYQnNETll2WThK?=
 =?utf-8?B?M09KSXFqMldBV1VjaVhvT3ZhQ0xudUZxWFY3Q0xiWnArL2JFVjRPMlNWVDgw?=
 =?utf-8?B?dGZiTHZ6QXpZaFU5ZW9rdzFET25VQ2NQcHg0U3NCTktjdzg5bGxRWCttR283?=
 =?utf-8?B?RFV6b0RReDE5TGNRUzJGRkVBOFFKSS9YR1BTTVdXQnNXaDBiY2xmQytBdXRy?=
 =?utf-8?B?OUFYcklUNmNLZTRpZm9idFNOUWVzYzg1Y1ZzS2lvL3FON3RMUldibDZKNEkx?=
 =?utf-8?B?LzVzYUVIbm1pb2lteGlrWGdJSy9WTjlNM0luY3plbENpUk5ZU2I1NDVQZlFY?=
 =?utf-8?B?VyttNFgvQ0JxM2l0c3FiOGpQY09TYjN6MmVBWTJhL0tqYzZPdk9zRnB6UFBv?=
 =?utf-8?B?MUt6TmFWTzRURENER1JXYTBGL2Zxc0lhWGN5ZkpTUUc1MUlyajhTY29iUEFS?=
 =?utf-8?B?WXEvTEFaempnSmVIMXNEZUdlUHphZU1NQ0ZEcEVQc1JFYkREZjhnb2dtb1Iy?=
 =?utf-8?B?TitrR1F3a2xtbkkxanpZcEFhUUdwQVY0dHAwdDFwNWcvRzZLb21nK21MN2Z0?=
 =?utf-8?B?SFUwbEU5dXJpWEVHUk11TDVWWnJwV3NyNGZVS09CSEt0K3lhaDdkODhCTHpj?=
 =?utf-8?B?R2ZiZHpMUktYN0Q3SVJiNGNPSGNNR21sQjdIUGdKQUM4ZHZoNWxrQUdUMUlN?=
 =?utf-8?B?a3FNenJWbVpSVDBEZjZMaUF1cG9DOVp0bFh2QmI3WnlDQVU3Szl1SnRHay9R?=
 =?utf-8?B?dkhTdnl3YWJtRUpzSnk0V0VpMUVrcmkxejJ5LzFHM3gyK2tlMUhvOVV2NU0y?=
 =?utf-8?B?OVhXK0JqU3E5dm1QbFpsN1BPSXlDcnpuelVGMnY1MmhiN2xha0VITENXMk8v?=
 =?utf-8?B?cGErQlpRYXp2U2Q0aE9hek0zc2tLVjBmelZUamdBeXI4ZXVRSlVLSG13NlV2?=
 =?utf-8?B?ZU1UZWdSTnBEb0lBNXlOT3lDT0hjRlNDVVJ4aXYweWNpUGtpVWdOdzN4ODhi?=
 =?utf-8?B?MVl6S0l5NE9xa29pRFBnYWxuR0NDYTgvVDE5cUFBNmFKVjFiNGZ3eU5qVkRG?=
 =?utf-8?B?bzNCQjhmOSt1ajRYUDBsLzBGU2Iya2txNlA4ZExZakU2Yml6eDh1cHVpbm55?=
 =?utf-8?B?dlAwbHRlWDNsVTVJMUhsUitkVmlma291QmNKcDdaR2NPaGZxbXhjYk0zc3lN?=
 =?utf-8?B?MWhRSkpJWGRVS0NudXVGc2VlMS9vdVVPdDZrTmRkdW1RZmxlbkU3K0F4czJ5?=
 =?utf-8?B?dEc0VzVDNVl4QlcrR1NDdTROY01JakZzcTVQWVJpQWFaRVhrekZ6cytCcFQ4?=
 =?utf-8?B?ZmFvbnAvYzlQZzQ0T25zNFhtVWNkMlZZUW5JOEM1VGpPYWZobHdWUjNIOXRQ?=
 =?utf-8?B?NWZVYmh1WUZSQ2pkL3dKa3JTV3VvNHAwMXBMak5KNzJpZW5NTWJ0WDVrRFNW?=
 =?utf-8?B?LzRRalJkRWxZYmxjM0lVNDVET3l2UkpDSkh0M0gzakU3T0NsU3JKZzdzOTFH?=
 =?utf-8?B?OHRUSklMbStzTDZMRlBKaitVd0ExSk1MR3FicWVEeElncW9lL3RwQkVaMTVN?=
 =?utf-8?B?MEVoVTNTdHdNYVZ6eCtsNVRmZ2Y2UkdZbE43V2t3WkxjYTR2L0JLdXFEaDJw?=
 =?utf-8?B?WlpLbFVmM1NNRjZsRndMWmlpSUhNbEI4MkdvOEFDRndNTEQxUjlab3ZlNWJq?=
 =?utf-8?B?WkRFenJLZFlGUnRrTDV3QmRoRU91ZWJ5SmJHbjNUSEx1NTBhaW4xU1NTUndr?=
 =?utf-8?B?MjZwcmphQWZBWjU4THdoZmNaZ0xYS0UwemJ0SVN1OVZWVXJMYUdMVXFSbzhS?=
 =?utf-8?B?YmFIa2NtcklIdjZlWHZPVXI5dEFhQ2pIMllJTHRHWlFOeUhkYkc0OGxHeWRW?=
 =?utf-8?B?UisyN1VCQVF0Tmp2c01sTkxzOENxUkQ2cFludVpnNjBoalo2SGVSb084ZDhx?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51464050-2913-47c2-2848-08dc64e15b60
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 04:37:04.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLz0HWY3ROYRe2KWGtaYcIRiuUKunQzjs7mRoiFyaE1TZX1DNy/SBfWflxyqHkBGpqbH6tirLMOs74TSklTApzgVuyJe6tg1r/r8WTW3UQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7330
X-OriginatorOrg: intel.com

Hi Ilpo,

On 4/8/2024 9:32 AM, Ilpo Järvinen wrote:
> get_mem_bw_imc() handles fds in a for loop but close() is based on two
> fixed indexes READ and WRITE.
> 
> Open code all for loops to READ+WRITE entries for clarity.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> v3:
> - Rework entirely, use open coding instead of for loops for clarity
> ---
>  tools/testing/selftests/resctrl/resctrl_val.c | 22 ++++++++++---------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 445f306d4c2f..456cf0d0b8ca 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -306,26 +306,28 @@ static int initialize_mem_bw_imc(void)
>  static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>  {
>  	float reads, writes, of_mul_read, of_mul_write;
> -	int imc, j, ret;
> +	int imc, ret;
>  
>  	/* Start all iMC counters to log values (both read and write) */
>  	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
>  	for (imc = 0; imc < imcs; imc++) {
> -		for (j = 0; j < 2; j++) {
> -			ret = open_perf_event(imc, cpu_no, j);
> -			if (ret)
> -				return -1;
> -		}
> -		for (j = 0; j < 2; j++)
> -			membw_ioctl_perf_event_ioc_reset_enable(imc, j);
> +		ret = open_perf_event(imc, cpu_no, READ);
> +		if (ret)
> +			return -1;
> +		ret = open_perf_event(imc, cpu_no, WRITE);
> +		if (ret)
> +			return -1;
> +
> +		membw_ioctl_perf_event_ioc_reset_enable(imc, READ);
> +		membw_ioctl_perf_event_ioc_reset_enable(imc, WRITE);
>  	}

The above highlights how the error checking is broken here and
leaving this code like this until the later fix arrives is confusing (to me).
Could you please squash "selftests/resctrl: Fix closing IMC fds on error" into this
patch?

Even so, I do not think that this addresses all the issues with error handling
surrounding these fds.
If I understand correctly these fds are currently (and remains to be after this
series) closed within get_mem_bw_imc(). In this series there seems to be
many occasions where open_perf_event() succeeds but later failures encountered
before get_mem_bw_imc() results in these fds not being cleaned up. What do you think of
having a perf_close_imc_mem_bw() to match with perf_open_imc_mem_bw() that
closes the fds and can be called from within get_mem_bw_imc() as well as
earlier if a failure is encountered between perf_open_imc_mem_bw()
and get_mem_bw_imc()?

Reinette

