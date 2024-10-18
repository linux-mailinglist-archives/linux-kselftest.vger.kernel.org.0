Return-Path: <linux-kselftest+bounces-20164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 082529A44CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 19:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117891C22E4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 17:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B46203710;
	Fri, 18 Oct 2024 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSnWeDFL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB009126C18;
	Fri, 18 Oct 2024 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272880; cv=fail; b=j91D+/thkj3dKppe2CcPkdHYnfevc6Ds1wlvBD8R10TBpfqPBxgROyIplASqORVsG7TB+005QOYZz3C4dYvdlrNxb3SvTOq3obnIIkRAMqjPQY29oosnzkOpZlFDeMTLQ7SGuKRGdZWLD35sTFqy24oPXs5pQcHn4s5afCogtUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272880; c=relaxed/simple;
	bh=mhpJ1Vk3jIFrEzD9G/VhJlNQolb+eT2qHDUcZvV6Nrw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ny8SI7r68/s9JD147lZ9eVlyGXT0xuJomeqEpjsdShiN5GkfX46ZExNS1qKbPq35Q70O/ziA+nxFcBaPNXHQxHIWcGPKkcucGs/2EWUFQ5wXnaHXvHXVz+OIjRP/P/HMRUbe3RDYuTdd+cG784EBzlDrUGqegB7XsBgUtyaAiHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSnWeDFL; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729272879; x=1760808879;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mhpJ1Vk3jIFrEzD9G/VhJlNQolb+eT2qHDUcZvV6Nrw=;
  b=PSnWeDFL7TvfLN36RyE9IA68ZcpXsoE6ONWshhRvw7FKtZgmw2L5O1RA
   6QhkE1SeOxRilMEqh5uINSJhVotitMskFQsrhM7WBTI4UzF/7tNMWv3iP
   QU5wBHCA0UHVO5s3o16Z5q42A8BZm5ZPNAxIDQNvWCDSX17CE7sV4aWJD
   5eUluDp691AiapDjFAeXtlX5YEbog7MGwmLWJ8ltJW8i36mqekV86XpeC
   WH8O7aeKkRcjnsLHGYtYJF0k/SV2Bj16RtwgwdfWksG9X40MyxLttMnST
   scVJoNLLt3gdboTXtV+Q6PHJvO+YsXm0BC2SnsjIAtEDACxjhcPZ20MKB
   w==;
X-CSE-ConnectionGUID: 50ZL9opMSfulj3ysNt2Quw==
X-CSE-MsgGUID: pu3hd2k8TVCHrWkTzi8Cog==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="39439455"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="39439455"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 10:34:35 -0700
X-CSE-ConnectionGUID: Ro5JUmxbSlaZb6jLyQmEsg==
X-CSE-MsgGUID: xlA84YvzRdmIJuFvCpPPBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="83556304"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 10:34:32 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 10:34:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 10:34:31 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 10:34:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 10:34:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 10:34:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5K0AIHnSQYKVQggKIRPFoNniQjo66cPIgF8opRIsIu2mgoJvveeZFsxiOgxPbowVvy4yCKUZW/PndtKzf8Xw2jIjfEY4vlrUC6zo5W8KoUTtVOAGzRZUpOjwsCpCECM8uU953BFcL5icjMvBH1TJsSBbS9+3E3RfYNWgGbVJGAnVIvhCjH0YWl52rL5L3n80xobESnTbZVKmLnGKuQLy6SFVgPJFZAfYO2vAgLZbLy5XHSBO8Wph/CIxGPdsuW1ietqXjySmqBS3zRGpNRh+yrNHutAYPxU8pN2xmmqQt1GgXXDWju0pXUnipZTuoYK85qC2UdtQDhSPZyeZpmPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8pUaLG/+ICBy/aphh/l70o1h2ihaGytT0nmFnHERSU=;
 b=mJOBlxkUOApTCIb2Ywe7B8s8cJn6diDqtNzlEwR64xI4ZFJ9SwDNPbYnDEg7yMM0Mz1/Mhp0Zy6nSGc8n9LhHxzPM2pH/hdUhF+mYnFSWJiR8MK4sgxTlutJF22ltMrJcgxnePQUiJfFip/EqIS6WJIzbQzdTCy9einj+kOE6JanYQdd9Ehl87fhv0jT969yPbw++DgOEoi/1SS7Ijpuq3Bc7ZzlwD+hOSEBbb2kWFe5eZyEeFtcZlW524QMiXPsiRO57/ntBQTbBPCMxle7MIEC3RznO04KD4zJKijU9cvx2vqee7lsFyHQOfNnkfhbjWGT7M79rHKTjhZD6Jp3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB7016.namprd11.prod.outlook.com (2603:10b6:806:2b6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 17:34:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 17:34:27 +0000
Message-ID: <104e159a-80fb-4ad5-ae9e-3e5f549a3535@intel.com>
Date: Fri, 18 Oct 2024 10:34:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/15] selftests/resctrl: Make benchmark parameter
 passing robust
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1729218182.git.reinette.chatre@intel.com>
 <ae8f92a2de3cf509aa9ffebe3d08019999318dc1.1729218182.git.reinette.chatre@intel.com>
 <63a2f1e4-2934-6d02-4621-2d224b9981cb@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <63a2f1e4-2934-6d02-4621-2d224b9981cb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:303:b7::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ade61c7-dfc4-4670-a4b0-08dcef9b1d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVJ4d0Q3cnlZQXBEQjZ2cEVuemY0OUxEVCtzTEcxMWQ0SFZLN0tTMnIycUZk?=
 =?utf-8?B?UFd3d1VQZittcUJPVm1ycmpZWmw4aUhWQUtBbDNuS2RpcmdDRDR4RzRyekEx?=
 =?utf-8?B?NHNHQzNyUmZkc0ZZSzhEaE1mUkZ6T1h4TGJrLzgxUjVpTVlsTDY4enN0dkRi?=
 =?utf-8?B?WkU2QzNFWjNvdzh0bDlRTFZrTUFid1JKOTd2djNTM0NxNUxmejNoUzFRbGtj?=
 =?utf-8?B?SGpOS3h4SlRmMFV0S2Q1SXp2Q2hOam1sY3hFbXl6MXkwcnBjMkN4dEp6YXhW?=
 =?utf-8?B?RDdUNTFMT2czaW1LM211WXVFSDRYU3RzUjZmWEJkdi9DdzRMdXFIdFZOSFN4?=
 =?utf-8?B?M0VBeVdWVWsvWVpTdzV0QndPY21SdzcxdkhFZkU3SnQwUDZiclFPMlZSQTRi?=
 =?utf-8?B?b05maTZhK1J4ZlpCbURaZWxMUWUrdGV2dnpQTWQ2LzRuVWZSd2lEQnBxKzlm?=
 =?utf-8?B?Qkg2djhnU2lKUEJmSWg0MWtmdW8vMWVzUzFoeGFQVWpGNE1sZDE4alhXM1FZ?=
 =?utf-8?B?cU9NR2swMmpKRFp0QnArdzA2K2h5eVMwK3BKWkpqZlVmV1NOekE1dE9BSjRi?=
 =?utf-8?B?Kzhsa3g0ZUI0MEUrMjd0NEprV1lNSVMvRHFuaHBoWmpkKzRUb080Y2pYWEtE?=
 =?utf-8?B?ejl3dWRpS1pTVmNLSktMbldBUGpRbGhBVU05WTdWcFBaMXpvTmxEakpnakcw?=
 =?utf-8?B?Q1YxMmFObktCUXZXSDZPUVJMV282REVZU2pNdjNlUmlpdmw2V08xNDdTSjdC?=
 =?utf-8?B?cFc0UjBhQWZlaVFnaDNJQ1B1U0YyeXNxNm5HVlVFajMrZk5STW02R3JXQmxX?=
 =?utf-8?B?YWZRWUtyc3VUK1dUWUxPaVIzZ2dxMU42S0V6VGt1b2dWVVZrdUh6THRQa09z?=
 =?utf-8?B?TFQxd3JzSVBpVU9YZTVuTUU1YU9BUnYzTDFraDczemc1UkRkT3p6dlBBdHhF?=
 =?utf-8?B?V1pMY0xjYnB5b3IzbU53RjhNZUlrbWJrdXZCL0dvZTJUMFJNYnhXWXJ1TUY1?=
 =?utf-8?B?eU5uT1JzLzVSUVBKYXN0MDNQN1NKSjYwMXEzdXBtblRjWmdjMGdyUDlzTkZW?=
 =?utf-8?B?RVp3NWNJK2pLakNmaWdaMHJOaVQ3SndiajhaYVljRFVkVXRzUnNmYWJ5Y0lD?=
 =?utf-8?B?VEFPa1FmYVVJWTR1SXVZakxXdDF3MnFPVTBBQmtKZ3ZWYngvWitSc0x3SW9l?=
 =?utf-8?B?REpBejlQZExHSWxzeXMrVWFtWlFsaG9YZkp3VnpGdXczTC9wb25RWTg2M1dq?=
 =?utf-8?B?b04xbkVuZEs2d25rOWhocHZxRW5zS2V4ZGdnaEJsNlg4WUNRbzhDbExGZjNi?=
 =?utf-8?B?NVd5QW5zOGZ5bnJ0ZUY2M2dZRnVqM0xEZ2psOE4yRW9xa3VSc29NY2NmRE1l?=
 =?utf-8?B?VzFRRkd0QmdZR0x4NlM4ZDdKbHo3TjI4dEk2K1p0REdReVl1blRiU2tlejZo?=
 =?utf-8?B?anE5SEcrQmhMeU1kY2xTUXFMZTZaVGJQY2NpcFJGVThEOE45NUJMd2E3eHRr?=
 =?utf-8?B?WmUrdTNvZE1yNzNzRDNBMUF6Q2ZaNk4rRmxtSjFpLzkzTzl4c1V1MmF0cVFt?=
 =?utf-8?B?c3RyQ2ZGTGxiZzR5bVBrZlpmL0pVRkZCK2pVa2crTzZjMFBtNHVJeXdQZldo?=
 =?utf-8?B?aDZUZVczcEhEaTNsNkgyVVp3WWZzeG5aYm9MdUpwUEVHS0U0UmxHN25CbmJ4?=
 =?utf-8?B?NDZrbi9tVHNnY3FsMWZGQUVYYzE1RUpFZGRGSktkLzd1a0VRS1NwWmtIMjNZ?=
 =?utf-8?Q?5jYrPWvPxYDweLDoYhjOIsODT9eUY4Pklkhyy5C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEhEdFdodzV1czhib2VWcW1aMjB4UjdwWDY4MW0rNmYrSmFSSUxqbEZsM294?=
 =?utf-8?B?amNKK0NrTWVoNWpsUitINjhGTjR6TThLY2Q1T3h5M0Vkb1BSRHJVeFEvMjgy?=
 =?utf-8?B?YmtnOTdBT1NsS0RWcTl4UHB0M0RIRnFPV3YvQVBDa1hGbmh3UGIzTGFWRGxM?=
 =?utf-8?B?bTNWaytsNmg1K0g5N0p5ckFqOWZEZWVoSXlWUGRBQ2wxdXNwd3owZDVJaCtM?=
 =?utf-8?B?VUI4N1o5ZWZuWjZBdW9LNmRVVEYrY0FvVWNSeHQ0R0xzRktFZTcvem5PME1Q?=
 =?utf-8?B?SVlWbm1OTjJqS1FaNit3NzZSK1lIazF3dEVkMkp6T3EwWjJyNDJuS1hkM2Rt?=
 =?utf-8?B?d3lreW5HZ0hJZ0dwbkVWc3ZDckhEWDUzWXBDY3VwNHV5ZU1ubWJZOFJXZFpQ?=
 =?utf-8?B?YlFwTTFqSG1SZmcvNTJOdUI4Mk5BcFcxbnlWVHhacUFiU0ZRQVNwbSszY2Rp?=
 =?utf-8?B?RlBoR1RuTjFZdFBwUU5XdkhmRzBkZ1Mzb21ZOUw3Wkc0TWUrbFk0TiswRkUr?=
 =?utf-8?B?clNRRk1yNjMvVWozRktZOWhiK09zZENVUkRPWmUvem9hV2F2YmJwcVNzNVUv?=
 =?utf-8?B?eUl6UFZ2Rlp4TXQxL2o3akg2TnpoQ21NVnl5bGlWNGYva2xIS21hVzFTcERj?=
 =?utf-8?B?MUxhb1F0bjMxQnV3Zm9HMjdTclNPbDhLbC83M3RndTgwR3NRK3gveS9VQW0z?=
 =?utf-8?B?QVNUb2g5NFVJV0lLS3NYZlZnRFZWS3dFTWVHZ3hTZUZPTHU3dXVYL0NUTVlv?=
 =?utf-8?B?Ym5IVW53eWlIdjU5TlFTZ1NZenRYZ21HT1QxTjlSell2ZEpocDJOL2tkb3BS?=
 =?utf-8?B?Z3pWUjVKRkQ3N1Y4Mk5zSzV4S1ROQVFBT29zZVh0YzBPUUlwTERSMGZDK29s?=
 =?utf-8?B?bWNMd2JVTWhrbXpIVU90QXRKZUdUVlhIRkpHMnFheXJONkJBWHZma2hQa0p6?=
 =?utf-8?B?eG12cVlJOUdhbFVqcjBrUVJvb2dlS21nY0NTaGZJdTIxczFhaDNTUG82MWhw?=
 =?utf-8?B?Wnk2cWpUaE8vTFNDSmE4ZWdMUnZvajFCRXdHQzZ5clBEdktxRmk3VzZ5YXZt?=
 =?utf-8?B?NXpvUmU1NkhZS3QvTjNBNG1Fa1N4bW5jNUlmcTlJYlFEdjZoSjZZdTlDSFBG?=
 =?utf-8?B?ckV4S2szM3Rob3NFZVdabjJxQjl2N1BlKzllSkhjK082S1llbjl2N1g3ajRN?=
 =?utf-8?B?SDM4Q00vb1R0ZWJSNjVsVFUreHdTMThSTHdObjFQck9zUG4vL3BxRWt6ckQv?=
 =?utf-8?B?ai9TS2FJNkVjVkQyUHo3UXp2TWM0SEVHOFFPVE9NVHJuZVJOdEVwNCs4dkhV?=
 =?utf-8?B?VUJtdmtHZ3ZuS2VlR1FRV0lrZVkzK2hHd2NuTjNrb0FsWFFZdVlNSUhwRTVG?=
 =?utf-8?B?TDQxbkl0SHI3R0NxV1pMVHFZWklHZDhjcUVoSUVzWG9rWjRlS0w2S2p0MUM3?=
 =?utf-8?B?c0lNQnNnam5vdHcyMjB6SkVzUTZQeU1IRUM3QmhRb2Z5UHJUdlJMaCtWSjRj?=
 =?utf-8?B?emlLcFd4QUVkQkJ4My9JMFV1VjM1MFNyNXpOUzdDdG94UitQTmlYdlhNY1U3?=
 =?utf-8?B?cFU0ZUZ5cFRBZXU4OUFRcjdXcmg1UEUxWC9XTkd4WHFsRTQ1alNGQXgyU0Uv?=
 =?utf-8?B?RENQa3h4SzZNS2RZVld5eStZV1JFYmV2VUpDa2dLSnhXQm9MYWxFMzcrMWY5?=
 =?utf-8?B?RHdlamNlaC93U2I1TG5ic2dEWmJMVTVPVUZwalErS2dBTUY3cWNHQkJXczV5?=
 =?utf-8?B?NnhobUxxc2RkRFp3NmRoS1hyWlVxQlpxNjA1U09Ddit2SktVOWs2TmROeTdt?=
 =?utf-8?B?WFU2Nk5OUlAraTg3TGV3bVQ1Qk5xb3pwYTJqNVZZdUZyYWRtUmFQUmlZNE11?=
 =?utf-8?B?MUVmSDllM2t4TG8vVDZMUHdmTTF0VVlkb2N6cVFVOWtJa2ppK1c2SFFseGxs?=
 =?utf-8?B?aU85RVdLdUpGUlBuNGk3NmNFTGJOM3hidnFKMjNMc1VEc1ZFNTNtNFFVcXEx?=
 =?utf-8?B?N0FhMVVURGp2ZnJLQjhhd2VmME9YNVpndnRHSmZyQlowNXo5aysxSzIwZWFL?=
 =?utf-8?B?RHI4cU9mc0FjQVhIR2FweXNIQ3N6amxycFM3VjBRSDJxdkMzcjcyaUtmanEy?=
 =?utf-8?B?eTRZSStKNjhaNGQvcXlMQndyM0IrSWFKb3Axa0V0YTQ0YmU5QlI2UFlKZHRQ?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ade61c7-dfc4-4670-a4b0-08dcef9b1d57
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 17:34:27.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rNBxKgalDpjlaMj5d998AP9q7v18+nB8bjYF64jt6KEz9MUehFVtS08Q3AEvI2wjEqIrwHavCHOWhqmSpWm1Xf89dXo36Yv4Aw7WH99Ay8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7016
X-OriginatorOrg: intel.com

Hi Ilpo,

On 10/18/24 2:03 AM, Ilpo Järvinen wrote:
> On Thu, 17 Oct 2024, Reinette Chatre wrote:

>> +/*
>> + * Allocate and initialize a struct fill_buf_param with user provided
>> + * (via "-b fill_buf <fill_buf parameters>") parameters.
>> + *
>> + * Use defaults (that may not be appropriate for all tests) for any
>> + * fill_buf parameters omitted by the user.
>> + *
>> + * Historically it may have been possible for user space to provide
>> + * additional parameters, "operation" ("read" vs "write") in
>> + * benchmark_cmd[3] and "once" (run "once" or until terminated) in
>> + * benchmark_cmd[4]. Changing these parameters have never been
>> + * supported with the default of "read" operation and running until
>> + * terminated built into the tests. Any unsupported values for
>> + * (original) "fill_buf" parameters are treated as failure.
>> + *
>> + * Return: On failure, forcibly exits the test on any parsing failure,
>> + *         returns NULL if no parsing needed (user did not actually provide
>> + *         "-b fill_buf").
>> + *         On success, returns pointer to newly allocated and fully
>> + *         initialized struct fill_buf_param that caller must free.
>> + */
>> +static struct fill_buf_param *alloc_fill_buf_param(struct user_params *uparams)
>> +{
>> +	struct fill_buf_param *fill_param = NULL;
>> +	char *endptr = NULL;
>> +
>> +	if (!uparams->benchmark_cmd[0] || strcmp(uparams->benchmark_cmd[0], "fill_buf"))
>> +		return NULL;
>> +
>> +	fill_param = malloc(sizeof(*fill_param));
>> +	if (!fill_param)
>> +		ksft_exit_skip("Unable to allocate memory for fill_buf parameters.\n");
>> +
>> +	if (uparams->benchmark_cmd[1]) {
>> +		errno = 0;
>> +		fill_param->buf_size = strtoul(uparams->benchmark_cmd[1], &endptr, 10);
>> +		if (errno || *endptr != '\0') {
> 
> Same here as with the patch 2 (and also in the checks below), both empty 
> string and extra character checks are necessary.

Thank you very much. Addressed with fixup below:

@@ -181,7 +181,7 @@ static struct fill_buf_param *alloc_fill_buf_param(struct user_params *uparams)
 	if (!fill_param)
 		ksft_exit_skip("Unable to allocate memory for fill_buf parameters.\n");
 
-	if (uparams->benchmark_cmd[1]) {
+	if (uparams->benchmark_cmd[1] && *uparams->benchmark_cmd[1] != '\0') {
 		errno = 0;
 		fill_param->buf_size = strtoul(uparams->benchmark_cmd[1], &endptr, 10);
 		if (errno || *endptr != '\0') {
@@ -192,7 +192,7 @@ static struct fill_buf_param *alloc_fill_buf_param(struct user_params *uparams)
 		fill_param->buf_size = MINIMUM_SPAN;
 	}
 
-	if (uparams->benchmark_cmd[2]) {
+	if (uparams->benchmark_cmd[2] && *uparams->benchmark_cmd[2] != '\0') {
 		errno = 0;
 		fill_param->memflush = strtol(uparams->benchmark_cmd[2], &endptr, 10) != 0;
 		if (errno || *endptr != '\0') {
@@ -203,14 +203,14 @@ static struct fill_buf_param *alloc_fill_buf_param(struct user_params *uparams)
 		fill_param->memflush = true;
 	}
 
-	if (uparams->benchmark_cmd[3]) {
+	if (uparams->benchmark_cmd[3] && *uparams->benchmark_cmd[3] != '\0') {
 		if (strcmp(uparams->benchmark_cmd[3], "0")) {
 			free(fill_param);
 			ksft_exit_skip("Only read operations supported.\n");
 		}
 	}
 
-	if (uparams->benchmark_cmd[4]) {
+	if (uparams->benchmark_cmd[4] && *uparams->benchmark_cmd[4] != '\0') {
 		if (strcmp(uparams->benchmark_cmd[4], "false")) {
 			free(fill_param);
 			ksft_exit_skip("fill_buf is required to run until termination.\n");

Reinette


