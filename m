Return-Path: <linux-kselftest+bounces-5299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E5C85FEA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 18:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498201C23FA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 17:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D43153BC5;
	Thu, 22 Feb 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFXQn+zs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7918657;
	Thu, 22 Feb 2024 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621570; cv=fail; b=CIKy3jZftZ3yr0ka3Xw3gAoZ4Uk4be/+nJ+wMnKD8AQ1B8awbkjpOk+i4PQYYJeYvZNdQZ8khd/U3DeaaoqQ0TWly0foERKm74aK67aPUDQIHFnRqYI3jbJrk3IGt1yzQP2Dn4k3UALNdWjVINQdwUEUrphBcx0OePSuswt3D+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621570; c=relaxed/simple;
	bh=VntIWYxHls4mCq5j2xqhbzEcZgouTCrFiEDr1SqluJo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sHq1qnpOvEwmjplXQ8ANOXhX+H58CsgMtqcRApmA32VP0v2bUPc2GOkUVZskZs4K9L2N06DtQmpnHg9r2yRVxAPz/OEacHT23ede+wjM9iHxGzSpgPzNdcppYd7wAiof+eeZErtO+p1kvvUMQU9ef8WMKb2xyUz2Q4wBD56/R9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFXQn+zs; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708621569; x=1740157569;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VntIWYxHls4mCq5j2xqhbzEcZgouTCrFiEDr1SqluJo=;
  b=GFXQn+zsj6guRfE/V9FfcaPtbsAkn04RF6w3yU1Kci99OB43q6I5x1Zr
   ZeKTOwkeEiOkt775rthcU/7/aB05ulqnaK4qE6JYdDm6A+eE9+FGlkgMY
   A6AQxHOFs2C/eW1o3uphb9cCF3IhOr17uwYx+gSZLfkK9b/Du1OZXvSDP
   WOKhTf1zWAkejV25LwtP1ozPebdtT4GVWxK3pifS9QSJKHTEDXg512YMh
   uTffvl7V3KoBe2qpLS3ACgF0trzaPkHdWV8pZBLkbouoHPfeIBAIYEJSI
   60LjARwdMDn+i7h2KeCOVASRTxq6PZBCHR6TBPu51shusKdUROzNwjo+S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="14284240"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="14284240"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 09:06:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5492827"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 09:05:57 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 09:05:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 09:05:55 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 09:05:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbQ8vOBJ0Dez+4u3ySgdkyh8N/iLjc+M2vuvG/cCwQZp17oxCdpxtFGI7S0b/BZdrROXWdYbkbSgn6Xp2zOc4Y568rxnEOauWRJ2b46VMpDpM+ACsGrzwmzFdMMXfL4JarTbLk+N4I+o2I4vSudjS4FsWM7v7JeKvSNsVOc4sEZo35sOrcNjC0wbVQsPTT04wNE0KR80I3GbNsiF1M1fF1mVNDgWttJPwsTlMdjeTUd+ow18s9JIO7RMAJdnXtl4op2cd6KKnf8QaN6KefGysVLgiVQiOjevRWGE6UyZGgkITB5jO63y3WhT2toX1GAt7Jd6tP0KrStqIPQ0Tte/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AllpVrS6xuC7qbZGAjVV7H5FA/pfymvC4bbutGFnho=;
 b=SA/7lSD5XhFDT9v4LSHO0TEMK0U+jGZLL3lMh6gJmEZiWsbujRWS30FnCKZQS6YPi5zdvZpDKzlIVQUKXlh4pXs+guuDROyOYjbRN8sFNSYUZk4JDju368RyGCZHqyxqZHXbvNZ4yyRwE3zYOZ0ni1Wg5c9lnDIIykjuOrzGmmKgA89G3VbMxugZ2ftrTa1NMR1lzOyMKbWMWLS2sd2AEIl1KuOJ81J6NgI7G9Y97Vc06K8C5pU4/1JuAT5tFFtackN3HZloHZauOLn1ZndBrwB7VKdstmh79mQlpOjem/jtrrJvXg8aAvqrL+ubgSsnJDNd99YMbt5KlFS5W1Hupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5938.namprd11.prod.outlook.com (2603:10b6:a03:42d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Thu, 22 Feb
 2024 17:05:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 17:05:52 +0000
Message-ID: <f8886683-4f24-47ce-a0c6-ef28466bfec9@intel.com>
Date: Thu, 22 Feb 2024 09:05:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] selftests/resctrl: Add non-contiguous CBMs in
 Intel CAT selftest
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1708072203.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cover.1708072203.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:303:2b::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a78620-f706-479b-0aba-08dc33c88679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNJbCB7lF3c3kn+M5WOFE8cF0CRPgvBnSPZy6xrC4SN0BL/+2OZNn9a8NE6kRgJRH/9HfZ2ZoCMtodNSvsKy1N0cdwovc3GMwOx562xY40jzmVyuK3g9xpc/J1IKLLtXmF+SsIX4MYdBLPzAPUY3fQCh19wZsAiRsVGztDtdO0fAujwzk+VJpwgBJIYn643+baKA2fAZu1SCGPTD3fyAypCLiM+MTtUzZMcz6eBcsUbsL9zaEPKhLp4crSWwHxurxAitByINpEm1qKlCvA5B0wLiiraQ05NH0Ekoxmgx+y7HcJuoUY7a8TjnntwYzS2axdZ4ew/5f3UEAbk3//ls2x1YovfLK0I4He0KvRqYZqBYcAeS2Led1o0PCtIEz+lVVPi4jk8S3p0CkjTJS8ZEM9IDyJwUHQhOUoln3hHcMjiEfNvdMcN4QnmAVz238dwFK+uN4qp8CHgsh2lv0YCFl8XCgdczsYsmyk8QgYta4CptEvYu/PyTUkZR25SFiniQdEROcZclTID60w9hBCzAag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a09lUnRIR2orcy9zMGFadjBXN01aUWVjbUF3cC8wN2ZBZUE5UGFLcGd4cjNZ?=
 =?utf-8?B?VDlyUnlib3JBN0RrMWlTa1hyTXE4TWNUK256blc4a2J4RlZLYjR4UjcrcVla?=
 =?utf-8?B?R3ZyZHBkcW9EbDg2Q3NIaTBGMzNmNk83K1BOMkhrbnY3d2JlS0h5QVk1TzlE?=
 =?utf-8?B?TWhxNXJQRCtPMkJMWDlqaGtxRFU5MWhCbjhqOG4xRU81UklxWGQzdldXcTNz?=
 =?utf-8?B?bTB4dEJvZ3JyYllJWmpWem5qeld2dUFZOGNWTnlkWUE2a1FObHAyc01UcXd3?=
 =?utf-8?B?ZEZVMFo2QVU0VG9jS0E1UUhKZDlhNmhWNTZnenFmM1dhTnhIQ25CVFhISmxR?=
 =?utf-8?B?MUc2SUs0SzF2VERqU3hickJGbUllbGFtdmlHK3RabmtudXVLZVkyUU1aS2xB?=
 =?utf-8?B?ZkErTWVMSS9CSzJtRUZkaFluT2FXSU9BaU42SWdBWDIxNnI5MmtWV3lFaXJk?=
 =?utf-8?B?QXgrTExNTDJ3ZzFvWG5tWlowTlFETmE3ekJJN0xXRWw0cmI4TDJxRU5HR2Zt?=
 =?utf-8?B?LzBubm1xK3p1U2RpNlFRK2hQUWZFcXh1blQramFQT0hxQ3pxMUZZMWlxcGhx?=
 =?utf-8?B?ZHZTaWJrQ1gvb2RWanRVUExYNFRRc3NwU3d0UkhrempLS042RHZ4di9QS0JC?=
 =?utf-8?B?WTdHM3hTbEhqdjBxRVEveHR1YjFYQ2FLNTl0US85cTlzMTdZVlRjVDljNEZv?=
 =?utf-8?B?K3BZV2JzdThRd2Iva1k5VWJpYTRyc1NFNFVCeXF1cXFiRVZzYlRBeW1scmxl?=
 =?utf-8?B?QSs1MGFpdDIxSTJZc1hMQTVOTWE3VTJmQ01wcVhSY1JWVzZwdzRqWVYzK3Yw?=
 =?utf-8?B?dU43UWRPK0RyTDFiMHY0dkFRb1g5QlM1dFFHY0hWSTdTdzlIZ0Z6TkZ3Misr?=
 =?utf-8?B?SFQ0Lzg4L3ZZdGl5U2cxWmhTRG40bjBBTmg0WTFPRVhlTFVGNHNoc3AvT1Fn?=
 =?utf-8?B?d0lDWnMzTDVsOTFkMlExSzdjQ21JTU5hV0RkV29hRXp2ZU1WcjNyZzQrMmpu?=
 =?utf-8?B?MFZNNXBINWhwV2RnNW1BTVZYMTBJWUlEVFBlNjZMWWtWbmtmclc3WGtBZVBy?=
 =?utf-8?B?Zmc3U3YwS3dpOEUzVU9hSEw4RnAzQ3ZkajdNUzc1NlFMaE1obGFPNVNSeDhJ?=
 =?utf-8?B?VGFheTJocnJMVmRIUW5GTmJ3ODhaS1Y2MDhyWmNJckkxRE9MTzNsN3BNbUpy?=
 =?utf-8?B?TFFDcysxQ09UY1JhZ1g0NUZCdk16V29Ub1JIRyt3RXZpVUJvMjlmdFBQM3ZM?=
 =?utf-8?B?UUYxYithMkE4ZDgxdHJtT3g1eWFpa0NTMXpVVzNoNDN5anFRSm5pR3JOaWpq?=
 =?utf-8?B?dlNvcDdzTm1vS1RPK0lGL1lzRHE3Yzl2VDkwVnV3c1hlcDZFMk5MVmw3TlF0?=
 =?utf-8?B?MGNzQnFOZk82RGttWkdFdmQ5ZElSVHZPMmhya0J0UmFmNFVwbzIyUmRTRDRC?=
 =?utf-8?B?bG5PNThOQVlrV0xuV21oVW91bWRHdTl4ODBOR25zZHIxU2ZOK01VcHIvVlhx?=
 =?utf-8?B?UzBacElUanlKRGNYY2twQ1l5dU9IakRhODdnc3lDc1M0eXhnbmlLam1TaHRR?=
 =?utf-8?B?V3lIS3VDK1pRaUp2dDl0ZWt3UDFxMTBIanpsQzdqbFA0dWEwNDNJelJocXgr?=
 =?utf-8?B?bXVQdkNrRzB5eURUbGVldG1lRjZ4dEZ1ZW1HYzlqNGFlZC9wdFVqV0ZSNVVY?=
 =?utf-8?B?b0xUaFU5VFFncm9Pbnpka3FIV1ArSmd0amR4TDFLeFNXUnJxc3JrWnNwckM1?=
 =?utf-8?B?UHdhb0Y4ZnNUZUVkNnQ2MnRuY2Z5VWwvS2x1TU5OK0ZlekdpOHNIMGN5dFNR?=
 =?utf-8?B?THNBYXpjRUtVcFo1eVRwTXdIK2ZxUTlqSGxKWUJJQWtkTWlhaktlMThwMy8v?=
 =?utf-8?B?Vkl5ZnVmb2tJOWRBb0xDcDNPUlptUWtUMGlJc0RlTFRKeDRFYlhEVnd3U0U0?=
 =?utf-8?B?WkRtd3JKcjhpTGpjZm1VUzRsV3dRbmViVVV6VERhaTl3UGJXOWhlOSs5NktU?=
 =?utf-8?B?L1pVMEw1c0lhUjFPT0hnczg4Vjg2bFVhTlMwZjV3WUE3OUNwSE9XTHYzQTRm?=
 =?utf-8?B?OXFXUDlxMXRYckQ0ODYxTFc5Tmh4cytJdDBubHdTaWUxaVVTanBYcStTVWRB?=
 =?utf-8?B?bVpydUpxdXJkR2xIODNubVpHMUpXWFZVbVVLazZ2NHc1MHYxTGFUcEFqYWMx?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a78620-f706-479b-0aba-08dc33c88679
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 17:05:52.4138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGoC8ItOx1mG/vVciZY0vu0sXJmk3aNTz7FfLRsBs5TnynLCsHo7+WjZ1UzgyLk5lmF5qbJWdcJ1RHMAJGrTpGxETCjCOx6KVaf2qqIoajY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5938
X-OriginatorOrg: intel.com

Hi Shuah,

Could you please consider this series for inclusion?

Thank you very much.

Reinette

On 2/16/2024 12:34 AM, Maciej Wieczor-Retman wrote:
> Non-contiguous CBM support for Intel CAT has been merged into the kernel
> with Commit 0e3cd31f6e90 ("x86/resctrl: Enable non-contiguous CBMs in
> Intel CAT") but there is no selftest that would validate if this feature
> works correctly. The selftest needs to verify if writing non-contiguous
> CBMs to the schemata file behaves as expected in comparison to the
> information about non-contiguous CBMs support.
> 
> The patch series is based on a rework of resctrl selftests that's
> currently in review [1]. The patch also implements a similar
> functionality presented in the bash script included in the cover letter
> of the original non-contiguous CBMs in Intel CAT series [3].
> 
> Changelog v6:
> - Add Reinette's reviewed-by tag to patch 2/5.
> - Fix ret type in noncont test.
> - Add a check for bit_center value in noncont test.
> - Add resource pointer check in resctrl_mon_feature_exists.
> - Fix patch 4 leaking into patch 3 by mistake.
> 
> Changelog v5:
> - Add a few reviewed-by tags.
> - Make some minor text changes in patch messages and comments.
> - Redo resctrl_mon_feature_exists() to be more generic and fix some of
>   my errors in refactoring feature checking.
> 
> Changelog v4:
> - Changes to error failure return values in non-contiguous test.
> - Some minor text refactoring without functional changes.
> 
> Changelog v3:
> - Rebase onto v4 of Ilpo's series [1].
> - Split old patch 3/4 into two parts. One doing refactoring and one
>   adding a new function.
> - Some changes to all the patches after Reinette's review.
> 
> Changelog v2:
> - Rebase onto v4 of Ilpo's series [2].
> - Add two patches that prepare helpers for the new test.
> - Move Ilpo's patch that adds test grouping to this series.
> - Apply Ilpo's suggestion to the patch that adds a new test.
> 
> [1] https://lore.kernel.org/all/20231215150515.36983-1-ilpo.jarvinen@linux.intel.com/
> [2] https://lore.kernel.org/all/20231211121826.14392-1-ilpo.jarvinen@linux.intel.com/
> [3] https://lore.kernel.org/all/cover.1696934091.git.maciej.wieczor-retman@intel.com/
> 
> Older versions of this series:
> [v1] https://lore.kernel.org/all/20231109112847.432687-1-maciej.wieczor-retman@intel.com/
> [v2] https://lore.kernel.org/all/cover.1702392177.git.maciej.wieczor-retman@intel.com/
> [v3] https://lore.kernel.org/all/cover.1706180726.git.maciej.wieczor-retman@intel.com/
> [v4] https://lore.kernel.org/all/cover.1707130307.git.maciej.wieczor-retman@intel.com/
> [v5] https://lore.kernel.org/all/cover.1707487039.git.maciej.wieczor-retman@intel.com/
> 
> Ilpo Järvinen (1):
>   selftests/resctrl: Add test groups and name L3 CAT test L3_CAT
> 
> Maciej Wieczor-Retman (4):
>   selftests/resctrl: Add a helper for the non-contiguous test
>   selftests/resctrl: Split validate_resctrl_feature_request()
>   selftests/resctrl: Add resource_info_file_exists()
>   selftests/resctrl: Add non-contiguous CBMs CAT test
> 
>  tools/testing/selftests/resctrl/cat_test.c    | 92 +++++++++++++++++-
>  tools/testing/selftests/resctrl/cmt_test.c    |  2 +-
>  tools/testing/selftests/resctrl/mba_test.c    |  2 +-
>  tools/testing/selftests/resctrl/mbm_test.c    |  6 +-
>  tools/testing/selftests/resctrl/resctrl.h     | 10 +-
>  .../testing/selftests/resctrl/resctrl_tests.c | 18 +++-
>  tools/testing/selftests/resctrl/resctrlfs.c   | 96 ++++++++++++++++---
>  7 files changed, 203 insertions(+), 23 deletions(-)
> 

