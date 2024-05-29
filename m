Return-Path: <linux-kselftest+bounces-10840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B31A8D3D8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 19:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9381F22AF1
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 17:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13E31607BA;
	Wed, 29 May 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NllzL45t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A215CD46;
	Wed, 29 May 2024 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004597; cv=fail; b=bvdR3GWCLep0BqKUSeRszA6EKCpMiHOmumHIu2XLTj17D6C41XK68RgCHnemR76XHpX++AKqFZm403CGwdppkYVA4wKRsTGsKu6gGS7dg4OF4wDsHHLp45GkFHWQIw3dmYLYz3sBp0hWl8ptISKXV2lPdjwL94rtTsKwdsXnggw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004597; c=relaxed/simple;
	bh=TpsZiw7hMgJTA5Tn6/+8n8+MJ6JOOCv2nxzC85E0dFo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fWlkb9SgGJUB5bYJgmu91l7n6qRKJ5jI7BQU0at5uLuQ2J267bjL1wVZU5Z7njgcc96CXjaCrPqf7DLGBYEY28/kgVUWFK48GU+ox+/TjOU0cPI4yBtinLJzWequ/irsmAjCA5J5+/Z8rjCTGkmeG7t9EaC3lC32CkdAgy7bu4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NllzL45t; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717004596; x=1748540596;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TpsZiw7hMgJTA5Tn6/+8n8+MJ6JOOCv2nxzC85E0dFo=;
  b=NllzL45t4d4tBUwALWAyi3LWQz87kNEUEannQpYvDtto8l7/3v+urgx9
   beyA93SGgYI5qjfRhnhf9iKOKK1rekIovx9+/qBWOsLPLwH7mDf4lOgtp
   ykzYO6H5PdcPUG06C84PPcNZ2vZu+qAI+MpuVVZYGfn28gnjLan6Q8You
   CjMwR9LZEkmg8WGyeCWLN67Nqf/gkoLj5utsvBr1+3Xx8Kw6DgqIlZeJ/
   7UA3QNePgX/SzddbgQDQiemqhdlfh8v64RaLxIDZ7UA8K6QQ973r2BGDL
   KF8rdGHqAY/L19noDpCUoPjRiO+u+peFrNzQyU6o9F+oZ5VsODwti4KlM
   g==;
X-CSE-ConnectionGUID: 7mzKo9Z4TlOFMqC2Pfc3ug==
X-CSE-MsgGUID: KRUX4SloS/aVBl4FxJb7sQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="30952729"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="30952729"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 10:43:15 -0700
X-CSE-ConnectionGUID: 0JrTEvf7SoGNhJPVttpq8g==
X-CSE-MsgGUID: BzDdYi28SpGHs9TosKFgSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35485931"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 10:43:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:43:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 10:43:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:43:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwZQCfbhajifZQPdIxuLAercHi1/ZKZM5nRtlZeRQSnsjDA8lwO/ArUaQoM+Pvd9/dqQku/STU5aWW9SueL14Y7zlB+eZ3r7wKOywYZCKMJSr+EV7GHt/rAwBmURdYS7H06FXuC1IklWvTOSSxdjFV4/wtDZSZ5ljec4SZvpubQz4f2YXguv3+4Jb/gWxpj8DWKO4MNNurwy8B9+Tw14Ygk0y+QNfi8efK1W3LgpapVecbHSLoCa13LfWqSgA4ks1VoiakYYyENNpGRIZKyVnRSR3a2QD57AdOREAMJIGtZPpAAvrlVfX0zn4W76Nay/5lTU/qZWzuQ2O4HxRAOs8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOSLUkWp7El9fzXIKDRT3OL8U6coYaeFF2L5Uo15Wuw=;
 b=Bra442N+FQq9XZaWQfBrwrwEAfHrU14jrn5egg+zafNBINrhX/rJUCFD+9xBu5KMBYqe0kL2piDlQVXv8u/YpVvTaBmAxAYvWPhxYgc0Z/lTOyYUsVURQLxTGq8l/FHO8AGHC3kObTB/Cjo0143ZMPJCsfo87zUQgn0KB/IxG/coRlfNYbJej16f7A8LUs+N+Ijoe9Z1z9MulLlXs8RD7jp4SzERY+iPUWsCdphRFHE2EpdN3hNxtTVNTBCFIOhZfhX1+7XB7KzlEi3IazQxQzKm8nqm09/U0ouoGxFqmKFuEiXEYIh/fWv/Gu82xjddUiWNQHBVhfEU/i9gPkPkXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7854.namprd11.prod.outlook.com (2603:10b6:208:3f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 17:43:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 17:43:07 +0000
Message-ID: <8046607b-567c-457a-a89f-232c3a86f72f@intel.com>
Date: Wed, 29 May 2024 10:43:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/16] selftests/resctrl: Make "bandwidth" consistent
 in comments & prints
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-4-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240520123020.18938-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0353.namprd03.prod.outlook.com
 (2603:10b6:303:dc::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 748717e7-509f-408d-fae5-08dc8006ccc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEZuVDQzeVE4aTEwTU9YVmZWaVI4NW16Ulk3SUkyS3ZWYkpuazdEQXRQQzJH?=
 =?utf-8?B?S1BTUVNJT21PNXRLbjBrMllleEpZcTArNFZTaVgwM2hBUkd4a0w4S01zcnJt?=
 =?utf-8?B?ZDVGTjNlQi84QjB3bTBaeWEvdFFHTGFuanBiZk9KaGdhM0EwWmxuQmZ4SHhR?=
 =?utf-8?B?dTE5MlhxaE5rR1VKQ3owWktCejA1a1AzU2R1SHhGRWlvaFlXcW1CTkxkL3hZ?=
 =?utf-8?B?ZU10QnlYRnRIOUJhcFFqNzU2NVladGlEamxweFA5ZngxeHhJemtNTXZxMms3?=
 =?utf-8?B?NFhPMzNvbXRTc0FrZ0w0RTFqZFVjZEhZRVFjQTBWb3B4a0dZcUVjR3dyVWxh?=
 =?utf-8?B?U2xPVDZWQ3FKUFZEbGN6R0s4QnkzbGZOUS8xQTNObFNGc2ZTSlhzSUR6c1Yw?=
 =?utf-8?B?K3NrUktrVkx5SmUvcGZmc20wNXlyZVB2WlRLakFBaFY3d3pQQzY3MDdHSjYr?=
 =?utf-8?B?WUt0ZmIyK0lKKytSdjJGMW5IeXFia1JVcmZ4SEtXTVJuaVZXeEhOZ0l0d2s5?=
 =?utf-8?B?WTZYOWJOVjA0KzkrTThUMDEyYWxQREhQY0h3YmVjK0g3V0oxMThWUzgzTzdH?=
 =?utf-8?B?dDRNV1JiY2Zsc1dIS1ZxQi9xZTF0ZGxzSkRJWHdmdHQwNlpTK1FGa2pmZXFu?=
 =?utf-8?B?aW1HRXFOYXNaMlZwVlEwRHFLV200R25sd0pvc0l3WVdYMnc3ekRDcmowd3Q4?=
 =?utf-8?B?dE1hamNBcG5rekFIS0NOUHB4OTNZWFVLdmFiWVQvZDNOaTZHU1Z4a09HSFd6?=
 =?utf-8?B?Z3F1RXl3RVV0cmNxcnllSEtoVFB6MTEwSk9zWnFZTzZSUWp1ckgwQTRodGhJ?=
 =?utf-8?B?eEZCOVZOR1JuVkRYMmxtVGZ6akM0NUNGYUMzQjJJR3IydmUzRlVLOEwxWDFY?=
 =?utf-8?B?MHk0SnQ4OUdjckdLSVhURFlueUM5d09Qc2grQXdTblhYN2ZHS2dtUFd0ZTkz?=
 =?utf-8?B?SmFqaVNLdElObXdRTUp4eHcrLytYRkZWOFVqRWpHYVdvaEVNUWVyZDFRQ1ZW?=
 =?utf-8?B?MG1zWXFodUxmbFJMVFZpM3I2dkNsZEd3N1ZBR2J0a295d2pxS3pUeUdwNDR2?=
 =?utf-8?B?dVlJS3RDTjJTdWpyQk1PcllXS2htVnd3T3QzUGpUZXVSM2p1RnUrU3JvdGxE?=
 =?utf-8?B?WEFNSkF0UnZRSlcyWmNhdFEvcmNKK3ozQnVxMHBJeVJuWVVvMEhOaytTcGJm?=
 =?utf-8?B?dzloUXFmekxiaFBTaVFHdUJObE1mbzhwNlRzS3pna2dCZ3AvYldPQXJQQlZa?=
 =?utf-8?B?eGRaWGNodHkzL2k1Q29ERWFveXdxU1EyWVRLenhuZnNEYkc1STN4Z0kxS0wy?=
 =?utf-8?B?cXVQUjViVnB2RmMrUzBCejBmM0JtUSs3dDZVVjhvbTRpcHF6K2N1RFltb3VP?=
 =?utf-8?B?WnZMayttbWRQQlVIaDl0azFmOXZxVVB1MGtkVjhtK1RRY0pmS2ZxNWJRY1c2?=
 =?utf-8?B?bXYrczdpWTBBbWJTRUtoWVdwSGV5OU9zK2VxSXB5WnJPNWJtdjQzRzJzU2RQ?=
 =?utf-8?B?aTUvZkF1MjVOU21lK0d2M0UrcG4wenc5azFOS3JuZ25jenpYYkxCMGNZaHdL?=
 =?utf-8?B?YkVNcDhQOUIwQUY3V3ZZalRVbUl4OGpvV1pGdDZ6WHBxUW93VC9WTjl4VkF6?=
 =?utf-8?B?QkdOaVJzc3dUdm5TelZLQ09DTlJGZXVGVUIycG5YNWtSWVhyWWFXc3I4UkxL?=
 =?utf-8?B?alNkZnhnNVZUMWhsaHpheTlVV0JmcnpHYzd3VVhtVGhYR2FjZ09iZ293PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDd2M2JoS0VuYVhyWm5maldZSEtSdnE3bkc4dzlzVHFhYk54bm5adDNXcWZU?=
 =?utf-8?B?TEtSM1d5K2NXOTZ2cUt2bDdKQktVcXNOTVVpVVYrb3E2c0JrejJFQktGcXQ2?=
 =?utf-8?B?a0wvWkpnN2NkZy9ZMHVmYytIakY4ckcrWGlFcVpYOXFhN1p5eVhlM2R4L2py?=
 =?utf-8?B?NmNiY3liN1dXeWlQeEZFY1d5NnNucWxVTk0xamViMHFjaldDb0oxN3htdHdL?=
 =?utf-8?B?WERiV05QVnBYdEhNT1dOYzJTOFZRUVRaNmZUMkpkZ1o5SmZsb0c1ZzhaQzkz?=
 =?utf-8?B?eWF5T2ZmaFFwQ3JVOUdiMDdxZzNLcTVXZzh6TTI4YW0zSkcyLytUTUoxODFU?=
 =?utf-8?B?UjJkTmJBTjduQktWV2FNSWNsZ251QUZueU9XQ1d6eTcraEwvTW9kMzNqdFFP?=
 =?utf-8?B?dnYzeEtUL2N1dnpveTdqUmVJMTdFTXlzNlNRK0d3bVNZWERWbHdtZ1Z4a25Z?=
 =?utf-8?B?QTBBUHFiREpBQUVrQ3lFYUNDQWhsdEJvc1pzdzJ0SkJTcU10ZndTMFE5cHdu?=
 =?utf-8?B?RkpkNm15ak8yMmVLZ1JkQXZlMXJmREdqTnFvNXlTRlI2NlNERFp2b2tZYzR4?=
 =?utf-8?B?UzBJSTBpSEsxRUIycXFqZEN4YjN0V2N2UXZZOGs3NDVGa0tORUt4WGJrL3pB?=
 =?utf-8?B?UXdQTjlORjlaa1YyZktVOHIzNFZFVHMydy84K01nRGtNVnZLSFMvNVh3MTBK?=
 =?utf-8?B?VzNrZnVkdFJKdmdSZFRLeWxsZDVYM2tWRXhqa2crSDVXVnpzNlUyTmpxL0p0?=
 =?utf-8?B?eGpLMmN5c1BSQjN5L1lIS2NtN1NRSlNlWUlvbkdxNzk0VWxabWJFL25KWURT?=
 =?utf-8?B?RHBCODNZMEU4RTRCaUY0NFpIWkdUT3BISnRlUStvTGc4b0pNSnVlancwZjZJ?=
 =?utf-8?B?WmY2RkFhV1I4dHVoYzRlamk2NS9MenJ2VmpXU0V4S1VJUGpLYkhGcytGczBk?=
 =?utf-8?B?RDBJRXc1ODdKcFhVNU5ja3cwQkQ4REZTa3RqM1QzZWx3TmZaSDU4WGtGNmlR?=
 =?utf-8?B?SWVQTll5Z3dvVG41MDczUUJCL1ByRUY1aDhqZnh2elRuTjIvYUZLNGZjYzcv?=
 =?utf-8?B?dDNhZEd5VmJmd2RLN09qYnAySFZMN3JGUWNGRVRicEFFdDFheVFkK3BHK2tp?=
 =?utf-8?B?UHJEem10V1k4dFN0VHFMSDNKSWk2VEFQK0pyRllTeUsyZ1lPbXFvYmJsL0J2?=
 =?utf-8?B?QVYzdFpRWHFTTVg4MG5ZeDhHT1hBN2t3d0krRXpBSkFpUC9DSUxLN0lXUExG?=
 =?utf-8?B?bC9ZMEtKT0M2YVcybnRSUzJGU2FDdEZ3UHJOaVJoV1RnRVBRakxqZXZ1cjJI?=
 =?utf-8?B?ZERIdVRWWjlvL2JkTEhyZ3ZYTWNMdHZZN2ViZjkzVGt0RUR0YWtqWkd3OGtu?=
 =?utf-8?B?SmY3Mlh4YTdtbUZsSlhIWnpUVnlvRUREQjVSMWFKK2hBbHozREJEcFlUQ1B5?=
 =?utf-8?B?SmtIUjgydnpTeVgrbUtsUHovWlpmUlhwZjRyZ3dobzBSSVJub1pubEY3UFUx?=
 =?utf-8?B?Y2RQejBFajBRNHlqUG5hUnh4cWlBRlEzcHNTQ3ZkUm5pdjczWU1PcnRUeDBB?=
 =?utf-8?B?Y1YvSnEwZGV4NkdJZVZIOUNEZkNGNWM1T3J2bzRPWUMvY3pFL0VpS1NKVFRn?=
 =?utf-8?B?dGltcms1U05NdWc0RFQ4ejlqQ1ArZndueWVQL3ZmVGhXTDYxQWRUaFVGY01L?=
 =?utf-8?B?QTVmdzJGc3Zkak9SaG9IWmY3NlA5L0ZzUm9NeXRWWFpLYjFBd1hUS0RoMDMz?=
 =?utf-8?B?Vm1uVkMyZWJ3UVo2bXlvSVdtREZwSVUwZFdUdFNnTTM3UjZVbmc2OWkyQnEy?=
 =?utf-8?B?UHMxOWV2UUpCeXZTcGFjWlFoeGtkc1pvQ1dHSVVNZnFEN2hPQ3pqWHhHV25Q?=
 =?utf-8?B?eWp2dzhSb1ZrWHpGTmloTXAvQUJhRVNGOFV5ejVhTkpJbi9jbkMwNy9LUG9z?=
 =?utf-8?B?WXF5bzJCdnZrN2NURGJDeDhEQXg1TUpJZVRMTUF6NmNEVmRSSTNyR2sybTgx?=
 =?utf-8?B?cU9SNE5Oa1BweFpENENhaWhTS2FQUVNkelJXUlRJS0QvNnBkUUdTMDVNWVkr?=
 =?utf-8?B?MTVrMThKbUJUMGFKWStHbW1mbE42MEVnaU1QT285bkVuZVpxRktFSUpOQVZX?=
 =?utf-8?B?TDFNMVFIYzB5ZE90TkhUdFNCbzJYNjNxV1JYWUJ1eSs0Mi9INWh2R3RuQi96?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 748717e7-509f-408d-fae5-08dc8006ccc2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:43:07.4383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agNAx/S8S9w4StM5MYuYi0hn/0FL2eYXzzHN3eYF2n6frxn1EEP5QlKDvqb9HfGxV4RIyxFl+AaVu308/KvszE2fRaw7aMlIgPVytDrLJJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7854
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
> Resctrl selftests refer to "bandwidth" currently in two other forms in
> the code ("B/W" and "band width").
> 
> Use "bandwidth" consistently everywhere. While at it, fix also one
> "over flow" -> "overflow" on a line that is touched by the change.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

