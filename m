Return-Path: <linux-kselftest+bounces-17318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B8C96E193
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 20:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B85B28ADE7
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 18:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8E317C98A;
	Thu,  5 Sep 2024 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cd+k33dX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F617ADFC;
	Thu,  5 Sep 2024 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559747; cv=fail; b=BKBb6w8MBaE8foYTZklEz2m3QuVRNc/QEeM9eBTssHcOMfVYFQlOhCPabwzgJ3AhrP4yveqo2hCjgbZ0gAIg+qJqLIvw3abYaaJ7691Ygkb3lIQeukC9CECKaT6dXBreFnoUnXRYinowrgI9D45mDlwNDG09BonfhoAFDIjREXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559747; c=relaxed/simple;
	bh=RF7Eo4LPgEdQILwClK52LwyVGtEpPMSFB1QSaIkNlRg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j482lJdgkUy4JeE4RnkQ2P2/KxzOT2hPGCbwDQBOxV/eQMTwK6uzpEvflArCBAn2IMo8TUHTSdQvzHdY3i6jGD6PcDl8St/F3TCD45I1DwSMJwYdYGivQekU24SW/2ct02Q9Ul2qUUZcYCv5L/D45lZWCYodq6kvykrcS7iR7Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cd+k33dX; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725559745; x=1757095745;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RF7Eo4LPgEdQILwClK52LwyVGtEpPMSFB1QSaIkNlRg=;
  b=Cd+k33dXUKBuFyS6mJFh9r8AMBVdOizQIf/gQqsIjY0Prk3fCIZHxKYn
   Edg/bWflSthpahuQHqSNuQjbk3i1Fbjn6ccTMjDgIm9isvkGhacU3HVRs
   7csgb1yljzmck1KTmwau6akG1QPzCwgRRpI/EsLvxod89WIuU+AJhHhCR
   lyvWNEcIKcFG+VhrtNIif7cUmXwe4y2fbRs7SDKVvjTj98KmyWqUnkQvP
   YAWGXm+UNtqevcKtY296Hu53IWz3RyTH3whj7RDEVHzwR40Thmgyv1O4y
   At2Fy1vqQHnEOqoWpYF3MxINNvIqSy2QGULLiSxXlTVsSIeBkDbFrxUrG
   w==;
X-CSE-ConnectionGUID: fguSIwuZSxmcYwtyItDyJA==
X-CSE-MsgGUID: j8M4bhRSRx6BIln/ot68hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="46827027"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="46827027"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 11:09:04 -0700
X-CSE-ConnectionGUID: zw3nHIi+T9iH4zcrZE82XQ==
X-CSE-MsgGUID: OkKTUc1aR165YoDLW+i/zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="88951091"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2024 11:09:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 11:09:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Sep 2024 11:09:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 11:09:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rS7crfK69CalOAllyKVX1Eyw1AX7VdAhH8HL9MdYhfQDvrnB29u2bMjrsjdFpMVCf3GeT5HxpPcnXNFq7G+fm3gEiV0WyouFsJXK7JqKNN72XPggMaeThpuyl25jKbs8/DJQ9quu0BW9rADYcDkvG/NTh3SilqTUA6edwxI8Bb8cIbmXlt89Oue10SpFAlEhiKflUx1OgSxue1cvLvKfCHMgfBc2nWCwfAaFkPqqXxsKYG5tYfgUv4gXF+S4UNxe7dNiR0TfgcNQcsmNrNNCgNRAAr8j0m8AcJcVHP4umYdD6V1YM19OUtfi6/w4JpF166Eb+FYYRJsuPPzzl8wKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcVbK/LOv/5OW2dMgF+qanVYllPdfib6ha/+wsmvkU0=;
 b=qOz3s8/QYqk6tP9CIt/KfIp9hW10g6FRttPhLVP++K6q6/lnfPSmeZjh0xkb1Uu2gjMwrS/plWl6wCrFLzz7/vXJy+SEAujghwRN7zKF6SPnht4C6yu7s1FM43IzsMzMKkZLxu/nNSPG5ul626XtKGabgI5QvtJr5NvJt1jAx+eR4trdM3XI23nOUN3gevnkGCDWzSMH1GgbXuY52KKagmHoy/A0BHxq2tqArnXywtUa6F5UPzy0I8ouSRJGJ05NTWv71Jz2uAJWpPAqrXRbCfRC7gse5ZhnxyT5UMiLpUKs2NneJWxrIOresyCCx8XVhR2Vky65jZc4fqAyBbfqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6849.namprd11.prod.outlook.com (2603:10b6:806:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 18:09:01 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 18:09:01 +0000
Message-ID: <43b71606-be6a-495f-bec7-279bb812d4c8@intel.com>
Date: Thu, 5 Sep 2024 11:08:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] selftests/resctrl: Do not compare performance
 counters and resctrl at low bandwidth
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1724970211.git.reinette.chatre@intel.com>
 <9bbefa3b9a62319698907d10e8b78f1b999c311b.1724970211.git.reinette.chatre@intel.com>
 <5d063290-9da4-c9ca-e5c5-cb0083d7483f@linux.intel.com>
 <87e4788c-6407-41a8-b201-e3f05064e5a6@intel.com>
 <238af9fe-0d7b-9bc1-9923-35ef74aad360@linux.intel.com>
 <9b2da518-89ce-4f9b-92f2-d317ed892886@intel.com>
 <1903ac13-5c9c-ef8d-78e0-417ac34a971b@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1903ac13-5c9c-ef8d-78e0-417ac34a971b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:303:85::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 4691641c-833c-453a-677e-08dccdd5d1b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0IzUEtQa1RBK3lhZ29qbmZlcWV4Skd5dGw3SnlkMHBkVjV5OEs1M0YraG02?=
 =?utf-8?B?RVF0MjN5WXY3QklCQS9CMDVsN1Z3b3ArL1pRSFlOckpySEJ1Q3NPVzJKUEJ5?=
 =?utf-8?B?STRRUHd3K3g1VWhaZWZTbzRrdGZsbDBXL2wyRXJtSFZrb2lEZkh2NGd0dVlV?=
 =?utf-8?B?dEJYZGdScEFSUDRKYnpjeU9iQUVUN25KNmVDKzZJRmlRcVhnSjhwQUNJSlo4?=
 =?utf-8?B?akRndHNCQ3dxMUdZTzdMWTRRQ3RFSjRhbjdNUExLdVBpeWpUWXorOEQycXdT?=
 =?utf-8?B?Y1Q3cTBlQng2OXdGSi9Ia1U5M3ozUzhBZDdvVnhNZDN4V2VCUC9OamNweVA1?=
 =?utf-8?B?WERmaFVnaDdlcFhXMlJPY3VRNFRwZWY1VTQ3STN1aDBqaGxsblBuRTZLRERv?=
 =?utf-8?B?VHJESnl6WEY3cnFIWTdZN21KcklTR0hMbWgzNzM0ZnJiR2pvWkVhYmNHR3NE?=
 =?utf-8?B?ZGdzODNNN3NDM0xoRDMvdXdueTJaS2dNemtRQ2JvazhlZ1ROeVV5ZExZYmho?=
 =?utf-8?B?a3dzbXRmbkFnanhGUEp2dGlLTyt4dmduZlpxbDVxdEt2eDFRWWMrVXMvL3kv?=
 =?utf-8?B?Z3o3Z3B6M3pZMlE1OHh5ajdoTzBrblhkV3FoNHVyL3Y4RmV5Z3AyTnZwVmtr?=
 =?utf-8?B?SXRMaytKSS9wZ0lvTmdYcGV0R3YvTkE5L0hRRXdUSWxZQk1tNTNyZ1VFNEJ1?=
 =?utf-8?B?Z3R3RUlyNE1jRU56c0piVEtuQXVUUHAvYzB6VFJneHlTZ3pDN1cwTWxrS0pE?=
 =?utf-8?B?Q2Q0VWk4YjFwQlVZdjhaSnBUUVQvaXJxaXI1T3R4Z2J2OTZibTZoYk9TZGw1?=
 =?utf-8?B?R2oxUy9jT2lTaGpWQXNBOFlrcTQrZGYxZUNqUERNcGY5WC9QenN2YlR4QUhr?=
 =?utf-8?B?em1iR2tGcFB5SnkzckV3ZGZzMnpkN2dESkNyZ29SVjdQLzB4RURzazVsb3lz?=
 =?utf-8?B?NDlWVmdhWTFFTnhkM05JbVhSQnV5dVRiNXVxdUh0SjZYTjlONkE4STR3MjZn?=
 =?utf-8?B?bDZQQWFFejMwRWN0T3ZTT3dYdElRZXVTVnA5dFprZEpEM0w2a2hXQStOdXBp?=
 =?utf-8?B?N0JDc01icVVxQnBJbCtna1BjSDkwTkN0Mnh6VHlHUjJnaVJES3EzWXVhaW13?=
 =?utf-8?B?WDgvNENHTGY4UWh2ZXlONkZpdURSNjAyWHk3WUFlTXhtOVdyZUZQRFZEOGU3?=
 =?utf-8?B?YkEwV01nTzV6N1R1UExTQnBYVkROT2RDZmRsMHFjYkxHRGJlRUlKbEVzeStC?=
 =?utf-8?B?R0pic3hqR2t2YUN4QWJZaXh2YUJrU0lTUER5N2RITndnRWFSWGZBRVpKZEJk?=
 =?utf-8?B?R0lDNU81U0Z5QUtMcmdSVEx3dmtjTFgzcXFhdHJhZnBTQm5ITEVvLzFDWXA5?=
 =?utf-8?B?MGVLQm9kZExZSUJ5SDBhSlJaUCsxZXRLUG5FQ2x3TjIvZnRnWlF1NHdyRFZh?=
 =?utf-8?B?dTlES2JDaGVBaWRYUlZWSklzSGtzckRHbWlZczRYYU1MOGdUZUYxUFNoNlBa?=
 =?utf-8?B?Y1Z4TCtTd3JSb3JEc1lFajRjWm9BNkFCSVFLR1F1alp2di9yWHV6aTlqdlJK?=
 =?utf-8?B?eVNSWllXTmMvTUxwMlhhVnBVRzBxRmlnT1lGOFBIWkQyeHJtTmpVN0FPcUpz?=
 =?utf-8?B?dEdSbnd0K2NFMkkrZURlcFpJZTR4bUg2b0ZBWHk2N2hTQlJPR0hCK1BJWEc2?=
 =?utf-8?B?b1ZRZGVsdEVSRWFQS2RDUjZZaTQzUVpvcllpcW9HL1BTUitQc3RJWmdoMnVl?=
 =?utf-8?B?bEd5RDcyMGJDRGZCRE9ZSVI3cmFiczVWOTdwQ1l3WTAzK1Vyb2dKanpmZTJa?=
 =?utf-8?Q?2tJ2Yirv71RRNHuoTFWWJ2IU19XbdBn8tsjIY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1dheFAva1YvdC9XdVR6UW95L3JvY1BLUFU5Z1NIbi94dmMwVm9FQk5HRU0y?=
 =?utf-8?B?WmhLOTBZeXhOcEhjWHVXSEU0RjhZSkdvVlNuSnJWcURvdXNDNnk1MDdpc2VB?=
 =?utf-8?B?UkRxdzBWQUF0VkUwbnZNeHhLVi9wSkxzOUh2S0JteHBrbHNETFpvY2pwVCsx?=
 =?utf-8?B?UDZmcGo2QmFiV0I4b1hKSmxHcVhJY0Zjd1dLdHJLTkFnRHc2ak9IVis0alFs?=
 =?utf-8?B?VERCb0gxNS8yQU4vd0Q5TDY1VHNHM0d5OHYvTTdMc3JOcXJzd0dSUWNrUGtE?=
 =?utf-8?B?RjJlbFROTEpiYkY3ZmZNTTBsb3loVmRaMjIycG1RRFUyNHY4RDBjUmtHRWNW?=
 =?utf-8?B?SmkybEgxSkJzUUNxRFJyV0tFM1E1NGZQa25xUllja3RrUnJ5NWFoLzFYc01G?=
 =?utf-8?B?RC9ZU24wbzhvOVlOK2lSZGxkNDAzaWdJakpab2tBaVgyaTNGN3hKcHZLQVpo?=
 =?utf-8?B?Tk0rakNWUGh2c0Roc1BvWjVWODVENjNZTkN3SGQxQU5hY085NlpVd0daZWdY?=
 =?utf-8?B?RDFaRnRWOGNHRkFxQmxWVXgzWW84MDRycFBnT2ROREpnaTJvSTZvZE5uUXlk?=
 =?utf-8?B?d0lDME9EbGtxZmgxaXlhRjgyendQZVdpTTlKZEhZTDM1SXdTZG5hSEQrNjB2?=
 =?utf-8?B?SkhVSHVseGJ1ZkJBdStrcmNmMzZlNElwYlJKOHc0WEF2SWRYOXVlb3JxZGU3?=
 =?utf-8?B?NzY0U0szc0tZQkVvUkVrMW5aNUtPcGNhaUEzMXlWN2ZobENUUjNvSXJhVDNP?=
 =?utf-8?B?Tk5wWFR6MHZYRXpLTmJVYzlRaGtoTkVsb2JsRXM4THVIWTdKTXpKc0NadlVQ?=
 =?utf-8?B?enNuc1Q1a1BqU0J5T2kyY2trWXZoMm9UOC9NV0hINVcwSVNIei9vVmJIbFd6?=
 =?utf-8?B?b0JTd1BtTkhTWG9BakRDNi9xc1Q2REZjVDdKTzc2dTJEU2ZFNXdnaEVqbVUv?=
 =?utf-8?B?cnVnUVJlWkxMNXVaM2JndWIvNENUenBWUEVFcUxjV0ZVZTJvRXdoUFB6cXhW?=
 =?utf-8?B?c2VYR2xSa2cyZUJuSUkyMU9CVUdITlcyTDcrZXFFVzNROGNnQStJNUluUDRQ?=
 =?utf-8?B?UUVZVFR6VG45cU45YWx1WnJlNEFaV3pKZ05NZGF4WlNVZGZPVm9uOEgzVzZx?=
 =?utf-8?B?MEt2RmhTdnJqZ29uUzlaQTNhSE5YbkpHbitGc29tS2lXQ3lITnd2aVJsdDN5?=
 =?utf-8?B?SXE3cmMxaThNMzNjZU1VOHdSNWoxdXJMbFA5cE9OWDNrZHN3bUE4MGNNbEJz?=
 =?utf-8?B?dDMwVXk2R0FQK2tWV2RTYjN2V0xsTzRNL2FaMS81ckR5ZmhNMDB3aW1TOGRO?=
 =?utf-8?B?RWpIVEFodWljNXhXNXJSR3hKcHAyWXNwVS9VRTdxeE5UTTNPNXVBQUptV0lV?=
 =?utf-8?B?MUF1K0taQjBvaGNXa3VaN1R1aDVxaElyVXBad21rOGFibnZ1MmlIRmorZTNU?=
 =?utf-8?B?Mmd4Rk1SMkNYQm9HT2pOeEh4NCtZNEZRR1VMSjFyVW1mQ2VsR092RjdFbzVF?=
 =?utf-8?B?N2Q2TTRCQW5TbGpyNU1sQzNaMzE4SDVPRjFvWHlPd0F0cTJPTFZ4NDZKUnJG?=
 =?utf-8?B?TDRnR3lHZTdrdzZsSlM4ZVdvMUZFK0VTM2pkV3R2WGlnNi9Kc1dNYjdoZ0R4?=
 =?utf-8?B?SU5yZmN0RjB4bG1yYnYySlhpL2ZQdDlqNkZlSjFWcUlUMERwUVB4bUxhWjZh?=
 =?utf-8?B?SzExZ04wQWxIMDhkbHo1VVdnMEE0eTQvZXZSWXJlYUN6aWhkV0dUSnY0d0cv?=
 =?utf-8?B?ZjRFMUViZnJxWlNKR2FMalRMOFJnYUxzYzlqUDkxbHRXcjQ4TFpXSjE5RW45?=
 =?utf-8?B?WW9mVjEvaGpMcG1HSHZJemtacVhmSlp0bkI0elRPaUh3cGwyS2NjUWw4NjR1?=
 =?utf-8?B?ZVJCb1Z4dW00b2lpTlNuRkMrRk1ua3loRUdtVlNGOEZqeXpnY1FBUUVxK0Nj?=
 =?utf-8?B?SFZKK1dXYStjWWFnUnRSNlh1RHowN2IwM1ZMUlNHcXYvS1pCNnd3c2YwVXJR?=
 =?utf-8?B?WVI0MmFwTFhGcnAxcno2MEpJZEg2Q3NFWCtGcGxlR2huY0VWTW95Tmo5b3BX?=
 =?utf-8?B?eWVLaGZaYmkvTjhidVhoQytvR2dzK3NBRWFsaVZmOUNrU3ZWQXRxOFJMTWpX?=
 =?utf-8?B?RklqZEtaQUZxSDduaFhndHJKb0xrTVNLMklQN3lmU2hkMUVCQ2lYb1NMUVFl?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4691641c-833c-453a-677e-08dccdd5d1b0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 18:09:01.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76FdcAv2sAIdW3aMLgctJMzwdalPhSfePl4C3ghxIIjG3ts5NjQpy9UmYqQcELkc/iWQtKOEEqtE6k1RioAMQNwvSOaOuBN9uHokx18xbas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6849
X-OriginatorOrg: intel.com

Hi Ilpo,

On 9/5/24 4:45 AM, Ilpo Järvinen wrote:
> On Wed, 4 Sep 2024, Reinette Chatre wrote:
>> On 9/4/24 4:43 AM, Ilpo Järvinen wrote:
>>> On Fri, 30 Aug 2024, Reinette Chatre wrote:
>>>> On 8/30/24 4:42 AM, Ilpo Järvinen wrote:
>>>>> On Thu, 29 Aug 2024, Reinette Chatre wrote:
>>>>>
>>>>>> The MBA test incrementally throttles memory bandwidth, each time
>>>>>> followed by a comparison between the memory bandwidth observed
>>>>>> by the performance counters and resctrl respectively.
>>>>>>
>>>>>> While a comparison between performance counters and resctrl is
>>>>>> generally appropriate, they do not have an identical view of
>>>>>> memory bandwidth. For example RAS features or memory performance
>>>>>> features that generate memory traffic may drive accesses that are
>>>>>> counted differently by performance counters and MBM respectively,
>>>>>> for instance generating "overhead" traffic which is not counted
>>>>>> against any specific RMID. As a ratio, this different view of memory
>>>>>> bandwidth becomes more apparent at low memory bandwidths.
>>>>>
>>>>> Interesting.
>>>>>
>>>>> I did some time back prototype with a change to MBM test such that
>>>>> instead
>>>>> of using once=false I changed fill_buf to be able to run N passes
>>>>> through
>>>>> the buffer which allowed me to know how many reads were performed by the
>>>>> benchmark. This yielded numerical difference between all those 3 values
>>>>> (# of reads, MBM, perf) which also varied from arch to another so it
>>>>> didn't end up making an usable test.
>>>>>
>>>>> I guess I now have an explanation for at least a part of the
>>>>> differences.
>>>>>
>>>>>> It is not practical to enable/disable the various features that
>>>>>> may generate memory bandwidth to give performance counters and
>>>>>> resctrl an identical view. Instead, do not compare performance
>>>>>> counters and resctrl view of memory bandwidth when the memory
>>>>>> bandwidth is low.
>>>>>>
>>>>>> Bandwidth throttling behaves differently across platforms
>>>>>> so it is not appropriate to drop measurement data simply based
>>>>>> on the throttling level. Instead, use a threshold of 750MiB
>>>>>> that has been observed to support adequate comparison between
>>>>>> performance counters and resctrl.
>>>>>>
>>>>>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>>>>>> ---
>>>>>>     tools/testing/selftests/resctrl/mba_test.c | 7 +++++++
>>>>>>     tools/testing/selftests/resctrl/resctrl.h  | 6 ++++++
>>>>>>     2 files changed, 13 insertions(+)
>>>>>>
>>>>>> diff --git a/tools/testing/selftests/resctrl/mba_test.c
>>>>>> b/tools/testing/selftests/resctrl/mba_test.c
>>>>>> index cad473b81a64..204b9ac4b108 100644
>>>>>> --- a/tools/testing/selftests/resctrl/mba_test.c
>>>>>> +++ b/tools/testing/selftests/resctrl/mba_test.c
>>>>>> @@ -96,6 +96,13 @@ static bool show_mba_info(unsigned long *bw_imc,
>>>>>> unsigned long *bw_resc)
>>>>>>       		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
>>>>>>     		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
>>>>>> +		if (avg_bw_imc < THROTTLE_THRESHOLD || avg_bw_resc <
>>>>>> THROTTLE_THRESHOLD) {
>>>>>> +			ksft_print_msg("Bandwidth below threshold (%d
>>>>>> MiB).
>>>>>> Dropping results from MBA schemata %u.\n",
>>>>>> +					THROTTLE_THRESHOLD,
>>>>>> +					ALLOCATION_MAX -
>>>>>> ALLOCATION_STEP *
>>>>>> allocation);
>>>>>
>>>>> The second one too should be %d.
>>>>>
>>>>
>>>> hmmm ... I intended to have it be consistent with the ksft_print_msg()
>>>> that
>>>> follows. Perhaps allocation can be made unsigned instead?
>>>
>>> If you go that way, then it would be good to make the related defines and
>>> allocation in mba_setup() unsigned too, although the latter is a bit scary
>>
>> Sure, will look into that.
>>
>>> because it does allocation -= ALLOCATION_STEP which could underflow if the
>>> defines are ever changed.
>>>
>>
>> Is this not already covered in the following check:
>> 	if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
>> 		return END_OF_TESTS;
>>
>> We are talking about hardcoded constants though.
> 
> Borderline yes. It is "covered" by the allocation > ALLOCATION_MAX but
> it's also very non-intuitive to let the value underflow and then check for
> that with the > operator.

My understanding is that this is the traditional way of checking overflow
(or more accurately wraparound). There are several examples of this pattern
in the kernel and it is also the pattern that I understand Linus referred
to as "traditional" in [1]. Even the compiler's intrinsic overflow checkers
do checking in this way (perform the subtraction and then check if it
overflowed) [2].

> 
> You're correct that they're constants so one would need to tweak the
> source to end up into this condition in the first place.
> 
> Perhaps I'm being overly pendantic here but I in general don't like
> leaving trappy and non-obvious logic like that lying around because one
> day one of such will come back biting.

It is not clear to me what is "trappy" about this. The current checks will
catch the wraparound if somebody changes ALLOCATION_STEP in your scenario, no?

> 
> So, if a variable is unsigned and we ever do subtraction (or adding
> negative numbers to it), I'd prefer additional check to prevent ever
> underflowing it unexpectedly. Or leave them signed.

To support checking at the time of subtraction we either need to change the
flow of that function since it cannot exit with failure if that subtraction
fails because of overflow/wraparound, or we need to introduce more state that
will be an additional check that the existing
"if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)"
would have caught anyway.

In either case, to do this checking at the time of subtraction the ideal way
would be to use check_sub_overflow() ... but it again does exactly what
you find to be non-intuitive since the implementation in
tools/include/linux/overflow.h uses the gcc intrinsics that does subtraction
first and then checks if overflow occurred.

It is not clear to me what problem you are aiming to solve here. If the
major concern is that the current logic is not obvious, perhaps it can
be clarified with a comment as below:

  	if (runs_per_allocation++ != 0)
  		return 0;
  
+	/*
+	 * Do not attempt allocation outside valid range. Safeguard
+	 * against any potential wraparound caused by subtraction.
+	 */
  	if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
  		return END_OF_TESTS;
  
Reinette

[1] https://lwn.net/ml/linux-kernel/CAHk-=whS7FSbBoo1gxe+83twO2JeGNsUKMhAcfWymw9auqBvjg@mail.gmail.com/
[2] https://gcc.gnu.org/onlinedocs/gcc/Integer-Overflow-Builtins.html

