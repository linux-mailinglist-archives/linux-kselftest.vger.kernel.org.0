Return-Path: <linux-kselftest+bounces-8352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AD08AA0DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 19:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2912815EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EAB171E54;
	Thu, 18 Apr 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXGGw9Fd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21816191A;
	Thu, 18 Apr 2024 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460451; cv=fail; b=LEfr9bDY/fpckdAoGhXYpKfxvkDkw/uZKG05VyEMjUmFX3zk4AAiVGeBsnJOduN/xTmoFAhfbMbNDpN+Glb+xM0oZ7OcoARDYZfcrb+jP4Cf+yuaVG52tZYIFFReyGcpfHBkUj22UO1/NIRp6CFC0oBYThHiAZvfULP919U5tXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460451; c=relaxed/simple;
	bh=LlVpdODKNLA6xE+wBNwrXppemU+J4P+KKEFpInFO58s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Za19utNkBJdiu473UxUIPxdxGArxz6uQ2SDuZFPArXJql/J7lMRa75WppjBsTscjGoLjejLhAPZX27YTDXxiZVaggVkhiQkHL0FfFZgVfUW0KJL9Yzhv65iQogd8G4Q+CEyy11qMtMMTQYLuJMIn74+pF2/sAS0amsoIBnW3VDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXGGw9Fd; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713460449; x=1744996449;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LlVpdODKNLA6xE+wBNwrXppemU+J4P+KKEFpInFO58s=;
  b=DXGGw9Fdtx1YrWj4aBfW3aWKsKdRKknqolESGs3kFgReOGgG4ocDbdqo
   TVmkUk4z7QpRTQK4YTDx11qWsSn1jBvRZzyxTaGOZe8H8SQRsZ8uX9mx+
   RCpjX9QfIPIkns5kz+dZAVsu6+ACWssM6TLafUvadEHusKdMXXhiouOgn
   tDZdAUhOCl+BG+Tcg6bD2czBL30gwxKZTds18pa33aMSBoX+rMvnE1i/j
   z1oO5knIjyQAv1Y0kNuyed1pxYa5wnoXU3tO2DvxZMGvj1nOWaS/yL/Ai
   fCY7gKNQY+vlWxilqB1N5cRJ2vabtAoULcQDb6qfS47WT0DClMpe+Cy+W
   w==;
X-CSE-ConnectionGUID: QL180dp4R0Sz7qZ4qL1whA==
X-CSE-MsgGUID: CL6Ea5Q7TDOHlr55A7R8Kw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9153746"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="9153746"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 10:14:09 -0700
X-CSE-ConnectionGUID: NXjmpubET3+O2c2KSwl5ig==
X-CSE-MsgGUID: 4e0qYtRyREq5ZHBayjIJCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23081448"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 10:14:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 10:14:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 10:14:06 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 10:14:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAfbqBVHcjhzmdSWl+AkQoLPs75KUQ80TfqxPdzvNEBwRwTuwT0dE8tP09XkuM8T9qICpuxlRHTjkgm7oyUVxRx9PIu6KT9yU08tTa6Z4N+XA7pA+8VMKCdlCeC+I1BTLzxgXAIzGlh5AaFdPJy0e5sukKSgjN3TeF6Wfz1jT3xYcpZ7FX647MoZ0bYdnXPHvM26laVQ1KvQHc4g+kKKjSoQfBJr3WNBkDY8ub12v+n6NcYa3TInai9x+sYrBJN+I0saqNwHNlsfDu9JIAhkxM+IjnBH0WxmYPnH5WB+VF3duHROYujke4oQFkZiQRz3gLml4OcpvS+7AxaKyltdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4uXlNifwkKcgyY8rwAIpYa7jyKCjq4c7pfz++j6oWU=;
 b=PMZ7UMQEC646Xo2G7SmJHz5+IZhYUDKYBkEAAnsYcdP6PWT/xnQKcHyReDMEvAufr0Ap8IRL9pgypYrYTBKIhbJWL01t70wbTHfg2mCu/Do6NBO+5VTGcTayJwGVqsyhuaBqYRPWO2QQQep8jgC/ArWkYd+YQMzxHsigRJIRqfEVazLHjTA+klDftXTEqLZMleAZfX7rdCPsmB32ENVKvfbGRwupO8+i96moWXBnTEbCtNdoLjQ/wI95SWqWT3m78ND8BDe+MWASdw9ZToQzQzzeEodPuiUZcAJxAdvAl4gWwGSubtdGX1eWJ9eUqjhjP1vbl7EEjaj8625U+OJNzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8442.namprd11.prod.outlook.com (2603:10b6:610:1ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Thu, 18 Apr
 2024 17:14:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7519.010; Thu, 18 Apr 2024
 17:14:05 +0000
Message-ID: <5e5d138f-c9f0-4d0a-b116-8dd6879c7872@intel.com>
Date: Thu, 18 Apr 2024 10:14:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: selftests: resctrl: cat_test.c: In function
 'noncont_cat_run_test': ../kselftest.h:74:9: error: impossible constraint in
 'asm' 74 | __asm__ __volatile__ ("cpuid\n\t"
To: Naresh Kamboju <naresh.kamboju@linaro.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
	<linux-kselftest@vger.kernel.org>, <lkft-triage@lists.linaro.org>, "Linux
 Regressions" <regressions@lists.linux.dev>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>, "Anders
 Roxell" <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "Dan
 Carpenter" <dan.carpenter@linaro.org>
References: <CA+G9fYvJ7=rahqJ9g35=XzEvAq9+zAiq8PNhBE-ceb2EED2gnA@mail.gmail.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CA+G9fYvJ7=rahqJ9g35=XzEvAq9+zAiq8PNhBE-ceb2EED2gnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::36) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 1622152c-2190-471d-a986-08dc5fcaf343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KncY6k2+hl+mGu+nbxINvUnPbA3/8KT+IKH0g8DdcvPJTNqb7voaEnbPShXAEub47Mrob4FPUsi2cdYEWkdetA1/2ODKV1kO5yRtOjtpurf1Qx49ggMMOedsbrDuzriBj4ESr1CAG9Nf6VtD9ZaakYvvEcLIyBy1khwyAIG5VblWwqoxz4gNBFDn0c1kWhQczQXideJ6aFqAErQTpTMfNre8JJvE7hNqgJe2jKJEhQoEl239ghN+1YT0I946gZmfiHQruP5iUgrRlbMVBbzuL1nsTt9OF5sQE3kGj9J4kgT2gYIYSfR5s/Rqdqh/bDuhFDVf4EVQfHz1KNrqjQPuwSdXnPtG8f54Otuq6hCVv4aGzTXmCLWY8Sqh53bzBK14OwVnQn+dt/+Cqmx6q+SU5uUWOPAEglYsmhn524JkcuUF9RVboyWsucj/oPXnkHe+4EunoBiJgZE5cilPZEvpIUpCQkOWkhAP71kLqfzMd681CizN5KfTiVYLKmAenssbFpWq/GjM1DiCMIG5rUVbRY51PQJhrrPQNAG5/MhqmAMDAuzSaOOlaRISKiecCxjKiMS0xr0p8kBD78grcZrgRGxTfcSFABnO8DIy+Ad4u2L6NBtqlHfX2qxyr44yHrqWoyfCAhU4smn3ZmeIxn7p5bb+hz9CsrIcD/u91MdMwds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cis4SWdLdk9OMWdFNENpS1llSFg3OC94UTVGMEtIZ0krVEFHS0VpS1puMlQ5?=
 =?utf-8?B?ZHk5c09xOXNOV2dMUVBGR0lZUmxkT0R1VzFOUjFPaVpOZ3hNeVNvNzhEaG1D?=
 =?utf-8?B?bzJuTnRManE1aDcwRHR6TmhXaTUyNnE5bHNkUm1KbVUzMWFqeHEySmRIbU9w?=
 =?utf-8?B?N3VQUzNPWThiNjFVVG9aSHFmQ1AwUHk4YWtUV2tyWEhFQ2hiYnhKem1Nb2dh?=
 =?utf-8?B?Z3RWTktFeXFreEJFd2V4czMxejVLLzltbExvdGZTMnlFVHMzekNBNVZ4Qzdp?=
 =?utf-8?B?cjRscDl1SGJtVjE4V3dpUDdDTnp1bDBkdHBMa2VSWHRYamRURlEvWk45dEc5?=
 =?utf-8?B?cFQ5emRWczBuR2ljdi8xS2Y5bmwrdEVqQ3Fvbk9pZ0NQNFZVQU5vdVBrZ0p0?=
 =?utf-8?B?YWY0d3lST0lCQWh5RHIrd2dkbk9PeEdOdVpmZGhReUNCdCtvUXo5Y3E2c2FF?=
 =?utf-8?B?VUJTOUhlU016dm9lWHZKMEYzWDZGNVdYZ3lVMnFLYnlyb0tBbzVDL0ozcjU1?=
 =?utf-8?B?NHdNTkQ2ajlieWZPK3BVZ3VGcUFYMTVzb2o5bjJaTkVMWlJFMkFkLzg4UjZv?=
 =?utf-8?B?aTBpS0J5UGd2TGdEY1hobnM0enpYTStvd2NZNmMwV2U1OW9WRm85N1hmdUV6?=
 =?utf-8?B?Z3FRYzhSZnRsREFXVWNXdExTb1JTbW9ad2pCQ1NrWllGSGpoQ3E5MEVXb3Bm?=
 =?utf-8?B?anZSb0RpMWwrc2xYNjJzeVUzNEtyR25IdU1mVW51Vm1ma29vQXphTzlWT3Fn?=
 =?utf-8?B?QWU1eFprWmN6d214MXZ6ZHBkL2hEVE1CT1RENFBrdVluajBGQVp1S04wQXh4?=
 =?utf-8?B?eS9wcVBEeVlNWEhYbG1yaVBWQ2ExU3Npd1FDNkJoNVdUQ2JEQ0dRL1poaytq?=
 =?utf-8?B?eEo3dWY2NmxobXRjTjM3bmRXWUxtN1pnZVRVYUgxSUFDSUhkRWt6b1dFTTZj?=
 =?utf-8?B?cEdXQTdaR29PYTJORzhKcEFubEtrcUxhY2Zsbi9jamlqb1h5YjJ5RlVjVWhM?=
 =?utf-8?B?K0dHdHRpUlN3MXoxcDZveHc5NlhQcmRzKy9Ma0V5VnViSmE5WTJWUDRVdXBQ?=
 =?utf-8?B?cGRNWUF5YkhtWW1xUWRyNUtmQWNNbHdNOTRaUmdsZWptcFZ3RnFRVjR1c1l6?=
 =?utf-8?B?NTZGdXFZZUtjdkU0WlNodmpPcktVSzVDK3ZVdkdLNzIwOWZON1Bxa2s4UjRW?=
 =?utf-8?B?R1BBVzJTenJNeHB4STFFazZwbExZbWR5Z2JHc0x0OXBSUmh2TVVaaGZSWWs3?=
 =?utf-8?B?NlQ0ajhvU0NmVkNkdjVvR1YyLzRVNHZQMVpjVmZkM2N1UUF2b3gwU3BzZVhk?=
 =?utf-8?B?R3l2RnM5dmNHeHRXUFJVeFhXeEpwMU0rSHlMSkZvSUVuRktZR2VzdXVYVzdN?=
 =?utf-8?B?by9jSkF3emJodXdLZlM3TnpFak9PeU01MXp5bnhaOHVtS0RsZkVKL1RtQmVS?=
 =?utf-8?B?bm5pRlFWWWRjdjhQMkkxTTVUekRtZmxjM1ZsSUliMU9yWW5nbkFVY0FkNEh0?=
 =?utf-8?B?b1B3L1NiUUxjSy8rcmNMckJXZGFoa2NETjYzR0REOVJ5cVJ2R1BUbDhZTUd0?=
 =?utf-8?B?Z0RSbzA4VXJYcWNZZWwxa2E0czFXdm1Kc0NubStKOFlOZjUvOXF0bkV2M1Bk?=
 =?utf-8?B?NkJOL3pyaVJCU2pFNmcySjdDdFBrT0RSZ0tZU3ZQK25PRHVGR0QvTEZTRkFY?=
 =?utf-8?B?Rkg3SnBUR3hUV2gxdWs2N202Mk5XZmVoZEp1WUJzUFpNaXgydFgyZ3lYOE1N?=
 =?utf-8?B?UnRXdDJYNk5mYm5WcTVOYnltVlRTaWZIdWI0VkNGNWZTK3pzQkdSMktsTFR6?=
 =?utf-8?B?d2tVWDc0NnZ5Q3ZVMGU5a2NSN1ZHako2VDB5SXdiQnVzTUVqU1lJa3dJSzh4?=
 =?utf-8?B?UFg2MmlzcE8zcUZOQVYrUDBQN2FORDJMTFV6blpEeVVmUEJ5MnlQOTFvUVk1?=
 =?utf-8?B?L1JxV1hxeGtjckRxVFIwUHdlS2M5eWc4NElnTGV1TXpyMFlHcnh5UVd4LzlX?=
 =?utf-8?B?V1YvcnhMMm5PdGNlclhpU3hCbmpqY0tnMFVsQ0dwbEh4Q2tyY1ZpTEZsL0dZ?=
 =?utf-8?B?L1kvb254aXFYNkJYcENtOTJQSmRHYlNIbUhFMDlpMnVsNlRVazdEbVRpb1ZI?=
 =?utf-8?B?R0ZZVStBTW1jRnVZTUZkWWZhV2lsTEs1ZUt1dW9EaWFobHVmNWg0NGwwMjJG?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1622152c-2190-471d-a986-08dc5fcaf343
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 17:14:05.0404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRkd5h8dtQKq+3yukfBnKAt9tUf8bKXNR1LOEaeFoHOe6nwwCbDsbQzUCDALc7qH/CXIJSPSPPI8wA6sByx23Ujhk0f8nyhk80oPu8hW5BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8442
X-OriginatorOrg: intel.com



On 4/18/2024 2:37 AM, Naresh Kamboju wrote:
> The Linux next building selftests with gcc-13 found these build warnings
> and errors.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build log:
> ---------
> Path:
> selftests/resctrl/resctrl_tests/
> 
> In file included from resctrl.h:24,
>                  from cat_test.c:11:
> cat_test.c: In function 'noncont_cat_run_test':
> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>    74 |         __asm__ __volatile__ ("cpuid\n\t"
>          \
>       |         ^~~~~~~
> cat_test.c:308:17: note: in expansion of macro '__cpuid_count'
>   308 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>       |                 ^~~~~~~~~~~~~
> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>    74 |         __asm__ __volatile__ ("cpuid\n\t"
>          \
>       |         ^~~~~~~
> cat_test.c:310:17: note: in expansion of macro '__cpuid_count'
>   310 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>       |                 ^~~~~~~~~~~~~
> 

This is unexpected to me. kselftest.h intends to and still does define
__cpuid_count() exactly the same as gcc does (in gcc/config/i386/cpuid.h):


 255 #define __cpuid_count(level, count, a, b, c, d)                         \
 256   __asm__ __volatile__ ("cpuid\n\t"                                     \
 257                         : "=a" (a), "=b" (b), "=c" (c), "=d" (d)        \
 258                         : "0" (level), "2" (count))

Reinette

