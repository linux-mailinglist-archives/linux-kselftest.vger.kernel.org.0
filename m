Return-Path: <linux-kselftest+bounces-6444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F388880A77
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 05:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD122834F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 04:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E059125B2;
	Wed, 20 Mar 2024 04:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNDh7SE7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2621426D;
	Wed, 20 Mar 2024 04:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710910426; cv=fail; b=HyqQ3eZ/0UiFyGW/mzU/fm0F1gNbYoTSx184puZnptuWa1Dsl4BgkV796647/nJbTgVch+MbKRY7ppAyzksj8a5uOObV65tUPFu8ry8baZDC979GfvPt/Pg7jvmIGgoJUpPnzU82AtqfW6MEb3J3FVaCC/dlitDeagmRmE3UdvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710910426; c=relaxed/simple;
	bh=PBmS/hzFfIobXnV6ZAOK6JDufT7urwtG+Dsj+TncP14=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rxJtLhPgYaiq2cdce2CB7XR5bM31QFp3GNu8te3tonKIJA8sQ1Hw8WHW/BX2Yz2P7JF1XlxGFzROwwokh+eT6HKOey5RJFj2eFPGFbLYNKyyzNyicOOAO3XdaC+5oT8i6iokgy3lJFgmWz7i0fntdK+tBW+1wZhTP23SJDovs8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNDh7SE7; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710910424; x=1742446424;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PBmS/hzFfIobXnV6ZAOK6JDufT7urwtG+Dsj+TncP14=;
  b=fNDh7SE7uuiX4G25JKCWFw3jtELJ+3Luu08FdVQUYhGJCUxzo7jbakRv
   8NyoCuhsoPnsUPpgP7C8OLDPIYSep/EfOCv0zKWf9C1yEkKKYMljb48Xg
   3ERfOrbIOoLO4yaQEw1p0GKcbA4fxOfXgsrMR4o2rRxI0xGrZE9GIg6G8
   idTnj7dqi1QiZ+ixqG8T+rxh5xzyhcLoI2T/wl1dy0Ngztz2sS5WKYra1
   37H5fUeW7Qte+zm/zBuAIdByi4IHA+iFdWA8dcx6yDeRYQeOcjqnhCPeK
   +/vU/Ps1zh5sMVHC6UsRaru6sMQ+GBqCG8Ea5S4cUqWcoYRLcftgLwHkk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5693310"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5693310"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 21:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="37159688"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 21:53:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 21:53:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 21:53:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 21:53:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 21:53:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IA0/ERbI2Dwt9vGQsNxmBq04IXyVq2mOOqSSPRcs2dCSYRzC0JxOByxPk01TJj1nRU7v6NO3knECma2ff/XSMNyG0Zluhysbf7jdu1kRtBoSQG7tFWrwXo3beLTG70KtMjA0kdNBycyezpkrZMTeDVnjHGMfHM4ItQWPkK+8D+D1eOMEw44GWKin3iVTVszLJp7UtRrLyPBCgLuwBzRHqLO8o7svc+aSlZ99gRwSl/KVhtWzYL9kgEPcIgB4UKidfoQP5edR+5VJjJC/oEV8ATeBdi4quudRBQbXomxleQHEwu/YDDXr094Fam+nUUmI9K5Qn6d0zoFassaytUKJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fH/guyuIcgSjx4vtBJAHCXcFLPX2O4S7iBH2dejfhFc=;
 b=Sxu6paTIlK2QnGfIBEkmYkcECZTwfmpRvgrR2fRPMlCSjDZjl4Kn7OEd3Nm68PUM1W+IjGHmr9XMk3jOxMwXCpPMwzcjc2rUd03kaO1AOq7zdiHki+YpFvibf0Uv52Y0ONr16etbj1zwlWAq9ya3MTyayLi4+P1lak2b2PK/Zbm6+Vvy+8hD94NXDZNv/UO/cShcjx+1AJDTHIzu3JMKwtVxle4ZS3bVn41/Rx/hzfV1L/haiRulOEMWw0CyO1JEpbShoW7sqhGt2zvIuhxZg99lnL1QY0OGX42/I9MDPciKLWMXvX7kA9g+OGWyWsZgD9aLxakAFY+1Ro8IRRT7nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7863.namprd11.prod.outlook.com (2603:10b6:208:40c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Wed, 20 Mar
 2024 04:53:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.009; Wed, 20 Mar 2024
 04:53:40 +0000
Message-ID: <fe5c0d10-a57c-4a3a-ae30-a7cfa93bc3e8@intel.com>
Date: Tue, 19 Mar 2024 21:53:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, <linux-kernel@vger.kernel.org>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
 <20240311135230.7007-3-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240311135230.7007-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:303:b6::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 9426ed64-5199-4a85-9f9f-08dc4899b635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /pbptE2T+7O7+ePwfGy4cXjOIvKwMr3rYcG7W4aihlPCWIwSnuPVajnC4TIL3B2uqDYoGpQmhwqKX7HIVWhxKu2lkwCd+iN6Nijh7S0dhDe2MUhlFutawapYm8iRlhZNj3enANV66HnfuSMAD/QJICwfgrcHevYy7AzY40Ga+kqgEh2R1Ke6cW5PIsAXNKNQ3GeJ2zET6N5sYXjYahNPiHgeo7jsK/ha76JD8dHNgzAsKF5ezoLiOPw3y8a1L5iPQ50yviwuBp95okhVjo9RxVcr6l7ZrXmCTgwjqoJWPQ41OUHF3b0Xmmo5r8ke0cunAySoN5TKmygD4LDnipdEXqh0/EkJLwF5JIlUyc4m1iOJlOU29x1xOYIA9s25V9UmlDNQMz2sdH51udJ/aAksjw3Gt9OZCT0wejTfp1Lc/Eu8GijS6DJs9FzCCXJkSXQyzVjiC/QRQ1oYdCDh/VCUpd6iDe8+Kw5Zhm2XnvY+pyVor1MwEtvRlZM5oPqjniw6PHfGRAPyuAcBibe3u1ovLf4bX1J701Li+LgprbOHbAGjpMrmsHrOPEE6vp/SF5pf2xA3524AIpsx02xEG5691uFttXLaItooSDP3MsPpySgkunWNyTi8vEt7ZKuwoOJcxVeKPWxhGHU1+T6mC+JWwLrlcG0aNZpQNrOHkSZOkoQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXFGcDRZc0V2NERBRnZFYXdMU2FzZTM2Ty9KRHE0YW4yMVF1SDd1VG5NSDhI?=
 =?utf-8?B?Vkt0MHFvK29KR2hzcUo5OW4xNEhuaytoQkd2emo3TVF0QVFNejNJalV1bkln?=
 =?utf-8?B?Tm5UUVF1MnkxTHlJTGFiYlozdkNrc3k0RDNnK25ZRjltUUNkaXpvRjZJOUd1?=
 =?utf-8?B?bzZwS3NNRjJGNXVHaDhseGxZZTZFK3FMZGwxcUV2NUFCVVRMN2lQWGEyUWJa?=
 =?utf-8?B?SHYvSjFYVG5iMHdCOWZlMTFmdWxXYUhic0ZtQVVIV0srOVc4TUxQK0VPcUIw?=
 =?utf-8?B?Snk3WCtNZlhuSDgvQ0wycXBYU3JoWmtCTnRxNVJmT2Y0MVV5YWNuZmpUMHU4?=
 =?utf-8?B?U1JBeTRuMlE4dHY1K3lIeUFrRnFqaXFva3NlWDVJaDVUMXJnMSs4dVZMYXZH?=
 =?utf-8?B?MEdIWTc1RjZqOVVoWlFBcmtORTdVdlRqdHBodFZ4LytBTVFLZjE5cjBKVUN6?=
 =?utf-8?B?a3BqUFM1eG1WdXdOMCtkelYyeEtaNy9ldmRoUVh6V2dtd3g0YkJPL1dCRXZs?=
 =?utf-8?B?Q0E3R0sxZmxtVklYekd6SEtEdFY4QTdFYkZSNE5xUEhVUG1tU2lqUEZ2RUJV?=
 =?utf-8?B?SG1hSi9kWFF6NjA5bnhCZjRpcHJTekpJSThlNFVwaERLSkRITjRNcXRiS3hK?=
 =?utf-8?B?Wmd2My8yZlZtZGRZTGg5MnNxVjdVZmNyaFBvYnRCVjZVYzUxQSt3SE9LNlJ5?=
 =?utf-8?B?NUZOUTdTdE9rTFZKZmZSVVArRDRZd3pWcUZmcHBRUVIvdjliVGVGTFZDenNn?=
 =?utf-8?B?RWg4Rm84Q3g5b0NCZ0p5RGJXTWtxZmhjQlk4V2NWK0txeks2aHdUclhjVGJq?=
 =?utf-8?B?VmllVkw1ZGttZGQyelhlT1lCU2RLSVc5UHJjOEowVkNqWUh0VkRwcVBPNDh2?=
 =?utf-8?B?NGZGdlkxUjBrZWhaZHhsMGI2STNXYnNibGVoRmVXdzExSnRpVk5NaXlqS0FZ?=
 =?utf-8?B?M0c1Y2IrMmZLbmRnaU5TcDNoc3owWVdKaTJ2SDJFRk9kTEZ0MVB6NGtESVdr?=
 =?utf-8?B?WmFuRG1TZUhuTUhvOFVYOEdxWW5zVUswVXIwQnl4bGpoUlIzcmFtelNybGc2?=
 =?utf-8?B?aGpxbzdpaksvdDhYdVZIN0dFem1RMFl0VnFHZ1llR3FPMm9aUXFyZm1HYXRQ?=
 =?utf-8?B?L2k2MXd4OGRvSXY4T0MrUUtBRFM5MmR1TUp2ZFczZkNWVnJpWk9DdFI3ZkhU?=
 =?utf-8?B?TWhiNW9KRlNnSnkvbFlIN1dZQ1RWWWR5MzN1NVphcDNndnBhM0NJcG1qOHRG?=
 =?utf-8?B?UTRiMGhOVnd4ZWFzQVZFR0txY3dMV1hYODVFTW8zM3Z1eXVHRUU2bXRZZjhv?=
 =?utf-8?B?TjdVVzhOQXd1aVNiZGxmTVJOMWc0V1hCbm9aRVVWWXpaTENzMnRUL0EweEtS?=
 =?utf-8?B?YmFUZHdVaUM1Y0pGV2FMcVVORW51TllSbVZ0QmFOc3REa3I1RG5IQ1U1S2ZI?=
 =?utf-8?B?K2ZDMmp6N1lkOHNTM2VwNXdORVplZ2RPZHBueDZBLytvV3hyUlRzSkZodmN4?=
 =?utf-8?B?R0cwM3ZRem8va0JISnhFakZjTERNWVUwWStsWFdnSlUvcVFwRy81eTV3V3lr?=
 =?utf-8?B?dmdNSXhsTlRwQktZNDN5VllobU9sZkQzN3FXTHRYOVVLVWY5WXYzdWJtcnZm?=
 =?utf-8?B?c0xOTEJTSnZ2WUEyUTVkV1pta0szWTd4aXdZZWJJdkhURjdwajJKR1FyeWd2?=
 =?utf-8?B?NGJJT2VrWlJMUkczaC9CK0JMc3RuWUsvNmNKN3BSM1ZJM0xGRnBlZlNObU92?=
 =?utf-8?B?OWE1Z25MV0hYdnEyY3pBY2tDV0JYTUxOUHJ0TThsbFRaVVhLcWpkRUgzQnJB?=
 =?utf-8?B?SmxVeENFVTJZN1lWZzlFc3Q5MzMwZEgwRlJJd2hVNFVQUDdsU1I1cStDdk5t?=
 =?utf-8?B?dkx0dFpQRUkvQ0FMemdCb09veXljNStWNUhjNVVqeUZjdmJoTXVsam5yMHZj?=
 =?utf-8?B?OWdIb3prcVplRnA1VDY2TlhnOWw5RkpSOFNKOXN4MEsxVEphYVo0ZWVENy9R?=
 =?utf-8?B?OHVseWM5eDR3UTRPWTI0TmRkNVo1empsamRIdWhPVVNsd2gyd2J1R1FGWjdy?=
 =?utf-8?B?RGRtbG9hZURYbWNUdy9kcERMblNkblJvOFE4bnRjS0RGQ3liWmJUOGY0REhD?=
 =?utf-8?B?bzN2dUxPU1N6djJNQmE0dWE4SktHT2tYSGdLMGRpSVN6YnRzeWM4aFlOSCtW?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9426ed64-5199-4a85-9f9f-08dc4899b635
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 04:53:40.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzM7/bKVKOBPp2Zs5IjhLFzzObXTS2LELqZNVDYeg1BZO0dzSzcWJjphCeU1YCHZsDc86p7gCGmeV0MG0vTCE7L8z69TiKslK2Q4kWf38sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7863
X-OriginatorOrg: intel.com

Hi Ilpo,

On 3/11/2024 6:52 AM, Ilpo Järvinen wrote:
> For MBM/MBA tests, measure_vals() calls get_mem_bw_imc() that performs
> the measurement over a duration of sleep(1) call. The memory bandwidth
> numbers from IMC are derived over this duration. The resctrl FS derived
> memory bandwidth, however, is calculated inside measure_vals() and only
> takes delta between the previous value and the current one which
> besides the actual test, also samples inter-test noise.
> 
> Rework the logic in measure_vals() and get_mem_bw_imc() such that the
> resctrl FS memory bandwidth section covers much shorter duration
> closely matching that of the IMC perf counters to improve measurement
> accuracy.
> 

Thank you very much for doing this.

> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_val.c | 72 +++++++++++++------
>  1 file changed, 50 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index 36139cba7be8..4df2cd738f88 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -293,28 +293,35 @@ static int initialize_mem_bw_imc(void)
>  }
>  
>  /*
> - * get_mem_bw_imc:	Memory band width as reported by iMC counters
> + * perf_open_imc_mem_bw - Open perf fds for IMCs
>   * @cpu_no:		CPU number that the benchmark PID is binded to
> - * @bw_report:		Bandwidth report type (reads, writes)
> - *
> - * Memory B/W utilized by a process on a socket can be calculated using
> - * iMC counters. Perf events are used to read these counters.
> - *
> - * Return: = 0 on success. < 0 on failure.

This "Return" still seems relevant.

>   */
> -static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
> +static int perf_open_imc_mem_bw(int cpu_no)
>  {
> -	float reads, writes, of_mul_read, of_mul_write;
>  	int imc, j, ret;
>  
> -	/* Start all iMC counters to log values (both read and write) */
> -	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
>  	for (imc = 0; imc < imcs; imc++) {
>  		for (j = 0; j < 2; j++) {
>  			ret = open_perf_event(imc, cpu_no, j);
>  			if (ret)
>  				return -1;
>  		}

I'm feeling more strongly that this inner loop makes the code harder to
understand and unwinding it would make it easier to understand.

> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * do_mem_bw_test - Perform memory bandwidth test
> + *
> + * Runs memory bandwidth test over one second period. Also, handles starting
> + * and stopping of the IMC perf counters around the test.
> + */
> +static void do_imc_mem_bw_test(void)
> +{
> +	int imc, j;
> +
> +	for (imc = 0; imc < imcs; imc++) {
>  		for (j = 0; j < 2; j++)
>  			membw_ioctl_perf_event_ioc_reset_enable(imc, j);

Here also. I find these loops unnecessary. I do not think it optimizes anything
and it makes the code harder to understand.

>  	}
> @@ -326,6 +333,24 @@ static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>  		for (j = 0; j < 2; j++)
>  			membw_ioctl_perf_event_ioc_disable(imc, j);

Same here.

>  	}
> +}
> +
> +/*
> + * get_mem_bw_imc - Memory band width as reported by iMC counters
> + * @bw_report:		Bandwidth report type (reads, writes)
> + *
> + * Memory B/W utilized by a process on a socket can be calculated using
> + * iMC counters. Perf events are used to read these counters.

In the above there are three variations of the same: "band width", "Bandwidth",
and "B/W". Please just use one and use it consistently.

> + *
> + * Return: = 0 on success. < 0 on failure.
> + */
> +static int get_mem_bw_imc(char *bw_report, float *bw_imc)
> +{
> +	float reads, writes, of_mul_read, of_mul_write;
> +	int imc, j;
> +
> +	/* Start all iMC counters to log values (both read and write) */
> +	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
>  
>  	/*
>  	 * Get results which are stored in struct type imc_counter_config
> @@ -593,10 +618,9 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
>  }
>  
>  static int measure_vals(const struct user_params *uparams,
> -			struct resctrl_val_param *param,
> -			unsigned long *bw_resc_start)
> +			struct resctrl_val_param *param)
>  {
> -	unsigned long bw_resc, bw_resc_end;
> +	unsigned long bw_resc, bw_resc_start, bw_resc_end;
>  	float bw_imc;
>  	int ret;
>  
> @@ -607,22 +631,27 @@ static int measure_vals(const struct user_params *uparams,
>  	 * Compare the two values to validate resctrl value.
>  	 * It takes 1sec to measure the data.
>  	 */
> -	ret = get_mem_bw_imc(uparams->cpu, param->bw_report, &bw_imc);
> +	ret = perf_open_imc_mem_bw(uparams->cpu);
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = get_mem_bw_resctrl(&bw_resc_start);
> +	if (ret < 0)
> +		return ret;
> +
> +	do_imc_mem_bw_test();
> +
>  	ret = get_mem_bw_resctrl(&bw_resc_end);
>  	if (ret < 0)
>  		return ret;
>  
> -	bw_resc = (bw_resc_end - *bw_resc_start) / MB;
> -	ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
> -	if (ret)
> +	ret = get_mem_bw_imc(param->bw_report, &bw_imc);
> +	if (ret < 0)
>  		return ret;
>  
> -	*bw_resc_start = bw_resc_end;
> +	bw_resc = (bw_resc_end - bw_resc_start) / MB;
>  
> -	return 0;
> +	return print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
>  }
>  
>  /*
> @@ -696,7 +725,6 @@ int resctrl_val(const struct resctrl_test *test,
>  		struct resctrl_val_param *param)
>  {
>  	char *resctrl_val = param->resctrl_val;
> -	unsigned long bw_resc_start = 0;

In the current implementation the first iteration's starting measurement
is, as seen above, 0 ... which makes the first measurement unreliable
and dropped for both the MBA and MBM tests. In this enhancement, the
first measurement is no longer skewed so much so I wonder if this enhancement
can be expanded to the analysis phase where first measurement no longer
needs to be dropped?

>  	struct sigaction sigact;
>  	int ret = 0, pipefd[2];
>  	char pipe_message = 0;
> @@ -838,7 +866,7 @@ int resctrl_val(const struct resctrl_test *test,
>  
>  		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
>  		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
> -			ret = measure_vals(uparams, param, &bw_resc_start);
> +			ret = measure_vals(uparams, param);
>  			if (ret)
>  				break;
>  		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {

Reinette

