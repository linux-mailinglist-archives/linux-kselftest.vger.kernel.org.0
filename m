Return-Path: <linux-kselftest+bounces-6453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C4D881466
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 16:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317F81F23578
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296C5524B7;
	Wed, 20 Mar 2024 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTIvDmOG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348E53392;
	Wed, 20 Mar 2024 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948039; cv=fail; b=rBUKyolsCW918crbs3/AFPxki6iqkkdzIPaMZucpuWumku9Co0pqyB4mrYaOdXtaX82eVXqOGN8pG1AE4AeJ2w5hV23z5PgRMa2qFqEUE5WRCUqhkEOsYipPD47gLYttMiO7jiFy4o9hsu61ezHqBthmIn4lWbgWQH3b5aLJZ/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948039; c=relaxed/simple;
	bh=GDHAF9eYF9H5yUvug6/OmYuiZtFLOLh248+q/NuEuig=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P9+gFslf+6Ym2DT3vTz20FccR88ci2GDvHcx8x11YCrz/X+gKdWt+sv8/CZ2P//earazMydWgZP9E/hPhD5lD7Ssd+xrlEiYbOjNAevnxsbU+ouUojhwoMnr6amskU1I2rPiyx72hYymkvAZYzbHPGrhK0Yk1/YeCiDrURuh2+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTIvDmOG; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710948036; x=1742484036;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GDHAF9eYF9H5yUvug6/OmYuiZtFLOLh248+q/NuEuig=;
  b=lTIvDmOGdWNOoBLwDy0hkSiaKD2sC7c2I+ORVBAbl/JCCex8rsc7SNWt
   BgBzHEhZDvUDb2DYFElJav1TJ5zcO4TXt/0lX47TdiY639/EAcxRy262a
   kArZ/rNdsA8AHoX5p/a03oOwbEkxdW4SZsb/mhCnYO31vJcamjYrWi4WV
   aiRgsdbgFVTOmgclEBaHKc0tenDliIsveKM96WPR4WR1miz7EsaTiLyED
   Whq4V2QnNPuU036e1BcZRitNpPngwfDzxPRYhtLimeya/dWDKiLD/xr4l
   KhxoD8YJwIxhf2Ra7+vi5e4i73uF9rvMUoL6Yjs1+isPKdoC3CkyT7ena
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5715940"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="5715940"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 08:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="14163996"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 08:20:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 08:20:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 08:20:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 08:20:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUuF+jeE0dnmgODFyrEASNCqXInChZoNHX36foRkWfzzE3dWsx9ywZxagPZkWuZl22uJlM5FmXesf4hNlDdRYsrW99QB+3dlbq3EgeGm5/4m13f013nh5g0hYZwxeAKuvZXVa/YPfUEaKE9wFDvV9WjRehEWTcCEvx9TjF3SRteWCdfmMr9QxQRTZ7NSxh7m6fY7zpUi5attc9A4S/DijwNuPFcgh31FsMCvkswXwZ0ZHCdVrKsL2O1WJDO5BOnIUSsuS5bmZr7hlOqPF+K+fcaMBy6DTjUlvG0De7KavK2wEY9zvruuzijl4AVRQPFYQRdyGAPMAGoFeKaLzSzLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Js4xJEEilEWxS5kfxLFcmnJ8YuEhpLGHNNtXGIqTZDs=;
 b=EMEZp0xVgaa+ff1dZ24Zcie9u/OE5JgbqAMcdRTnKu02Nw1eSdw8/EafJuAdysPz/rA8DOVW+OdX0kVa0gI03BRrHAFLJD20dY/mYFzW9FQw+wXy/Dl7v9ulU6GcQ7bRdhscglaYWf0I0AZZYT++XMDndyJe5Cs1MOttNUcjVbyZ9rfJakep/KL0Trb891sakjK0c8TuQF/X02e94zw+sKM8mzMzwvyFvUS5UE6YXnyiRASnMhSZhZx2hiBjx6WFkrWELEDSg0986S0293j4u/zacixAqlLxT6QOCdLj7Kwj5GpFlJvQAlaWM/gob0JLTvsJGSB5D0uDZ25nRDcevQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8516.namprd11.prod.outlook.com (2603:10b6:a03:56c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 15:20:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.009; Wed, 20 Mar 2024
 15:20:30 +0000
Message-ID: <578d0b55-c51a-49d1-8f54-989215a3a4b8@intel.com>
Date: Wed, 20 Mar 2024 08:20:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] selftests/resctrl: Convert ctrlgrp & mongrp to
 pointers
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, <linux-kernel@vger.kernel.org>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
 <20240311135230.7007-12-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240311135230.7007-12-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0257.namprd04.prod.outlook.com
 (2603:10b6:303:88::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 917a589c-2fa4-47e8-9af9-08dc48f1472b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kE4BQW8/+tMcE/idB6C+tkUrFiH1yfnx+OAiPehJNk1mAeLC/lV6TYZH1qrFVNC1vhUxW6+ikdZYQ6iT7J7is3hQZrO1N1UM2vhyVpJ/CaM6PTSm5R+M7XvN+YZIB9tQxjzR1ZCT7R4gD4r/RicNdkBRKDVSlE/J3dS2+UoJYlMyWQ1DVVQ+E9oQ0+hhU+onmRxt5DZgN1kfyghKIzeh/MZvj0E32d3b6c2VBWI3BjoR7mTWXyZ5yNTrvOfoCKGlff5KnxPQLZ0Zhr9tB7KDuszLBgGr+JbLo3f1oGcqQDfmzT09fFnirXGan0SmFvJtX6poONYoXaq3jN1jccQQMdNc1nthru2rLMA0pcvtvxxdcKRMerlz7dK/IHxJ8+qthzV6g2Vxhvoym01VcvUCei0TfRJAUrBFFX/Ab01CHV1qyVBXFQ2agTTnF+enMxNq6NsUUAwRwELoMpQmRF4CIlhC14q154MOrW6uujtvwZ8Ezzx+ms81VWKJZx6p84KFEsTxJEJpkpeZJIYZdyimS2IF7kN7AtdP19aY/RcYtpcTXbGHtZCA8gTYw1VP0OWLVuY46QToxeCws4aZIwO6+Otsi9aZT18Qq+vaobcY/7yThHUkDz7TuBXHxvRJTyY+jzcOQ2Gw+SYjzZGPpLmlj1tjjmfUMyLSRHFRukGvmfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enVmNHdEWWZFNVVTa3FmK0lEYjFBTHRqSVhXa1FCVjdCeDVlcFBpVkV2VW16?=
 =?utf-8?B?bWI2M3I2T0hxakZRcEUwSEcwNFJ4NCtzeXZlQ0JOTjJhK2N1OTFaTVIxd0NF?=
 =?utf-8?B?ek1nMlZqbk5nKy84RUpjaGtISkpLc242eHlId28zVHZkcVdLNjJ6UUpPdmdq?=
 =?utf-8?B?RnM5MVExOFZXZW5YbWx2Vng4MjVZSWZKUFltc09ncnZOZ0dIRWVOV0RZRXVL?=
 =?utf-8?B?aC80RWVOZCt5Mlo0S2NOVmJ2amFleGNsR1p0cUpoZ09HWERwMHZsY3Y2NU90?=
 =?utf-8?B?SDMxQ2J3Z2o0a0RRQW5kY0NFZFpmdkJBTHBkQnlXbEM2QktJOStubE8wWCtY?=
 =?utf-8?B?a2VmUWJtUjhYOEdqUFJPcHh6VTFrT0QrTVQ2eXBIb3Z1ejMvRU82b2ZZQmdS?=
 =?utf-8?B?TzJ5S2MvazdHWERPZEliWEhtWkxLZC9yZVQ0WURvNVFhTEZoTHU3R1Z2cUxm?=
 =?utf-8?B?cU5zTXMwUzVreG5jOTRra1BKcEk5K3BiRkpVKzhEMmlPWGc1U2piOGZxOVRt?=
 =?utf-8?B?SlJaTkwzOWdMdkM0eFFVTlkrYldoS2Mrd3FCVjVTR1VwZVlzMGtOVHlzaFNl?=
 =?utf-8?B?aUdGR20wUDgxdXdWcGtGUTBiYWdmdzJMSnJCRVNuekR1N1hHcGdjc3JYVkZq?=
 =?utf-8?B?SFJhaUoyYWR1NGZzdStOTStBU0RxaGZwUVI5SmdLV2NaKy9lQ1lXZ1hLNnVa?=
 =?utf-8?B?aHpSYlR1cHlSM0c0d3U0c3RUZHZlZU1XUnVIZm9mWnQvWUswdGdaN0owcEMw?=
 =?utf-8?B?NlVvNVRic2pDR2IwcVMzZ3VZbERqL1pwQlZsZHlOMlVuczEzMEdZcXc4elJG?=
 =?utf-8?B?bU1oZm1Nb0c5ZVhuaEFadkRlekd1ZTRIMTJVUXh4RllPRUMvcDdJSXVjVnF4?=
 =?utf-8?B?R2hmRWdvQUgxLytEaC83S25rc0lGMzNmRHdXZXcyb1UrQUtsT0pBY3E4eGNz?=
 =?utf-8?B?dUVBdmdLTGdsYlpENG5CdkNYemRZRmJoL1A3Wkd3Uk1ZUGlpMGZIR2FhRVRW?=
 =?utf-8?B?cjZHNlJPS24yQ1B1d2RYb0d6MUtVU1FsNm9RZllnNHJIaFhhU1ZSR0xTZHB5?=
 =?utf-8?B?aHlYSE5NRXMvM2RCamJXMHRKT2dScklRTzBQSzBDZ05CWmlzN1V4RjhROGZn?=
 =?utf-8?B?RWNqV0dLMFJjMGJxWjJ6NnJHZ054L0c2N1JXNlgyT2lzZmMrU01ldE15L2RF?=
 =?utf-8?B?Q2RROWJLVHhST25CSUVwbHF4UXVqS1pSU0x2SHNMdXhXekJPZHNIY1lBMS80?=
 =?utf-8?B?TlZ4cHNXckNyelFzTFFsYUtmMWVOSDBCdXl2UzE0QmJpdks0a3VQV1J1WDBQ?=
 =?utf-8?B?djRNaG9CR1QwUzBHMThxYXAwajZIQnhybjJJVHU4SEhEMDV6bWpVN09pMWRr?=
 =?utf-8?B?UTRpclJuOTBubXBxZFRJUE5YV1BSSkVMRWUrRjJjbk16ckR0VEQvanNRSHhN?=
 =?utf-8?B?OWtsaVBrVXJKdmEyRzlScnVRMTA5NmYyaXpaRDlIY0IrcjluUXpRS0ZvQ0p1?=
 =?utf-8?B?ckFwc29HYjJCeWJOcG5nR2J6azk5eHh6TFJtWm1TcGtad1poRlYxRjV2M0U4?=
 =?utf-8?B?dmZ1c0QrbmZQQUFKNjdwSFNTUDU0Mi9ydnpLWldlSU9BcFE1aDZDYUxXaFp4?=
 =?utf-8?B?eWk4MHh6NlU3cmpuNG5qbGN1ZlNDa1NWRE9WMlhWVmV0MCtMY1g1alZkZS82?=
 =?utf-8?B?UmtXL0IxOStOK2Y4RHByaHZ0dllzTFhQdWs5OE1RaW5BOHoyUW5xcG5rWUY0?=
 =?utf-8?B?b0dzZUlIdDFlb3JPc0hIN3liMG5NT25UTzdTNElGZDVhamR4QzNQb3NFbFd0?=
 =?utf-8?B?dlRKL1MybXB3N25Qa2Q0VUlOazBIbVcybVNyMzdLWHh4VTlhdHp4eGxueGUz?=
 =?utf-8?B?dUErNTVacU55NzlHVnJmcWhlMWtFZytld1FzSFU1OEVrQ2J0TklJWUJNNytt?=
 =?utf-8?B?RVBnOVF5MzNWcitMKzVsUW02SklaNlZZdytwaGoyNU9OYkRsRE91RGluc3ZG?=
 =?utf-8?B?UGdQbVFralJyOHJaSlVEUFF2LzFtcHJ4YVAvYSswVlNZYzMvUGo5V2pFMTB1?=
 =?utf-8?B?Kzh0N2lpZmpsSjJ0emtDY3lvc24vemw1MWRTR205a3pMS3NXYkw2NVlQTlRM?=
 =?utf-8?B?TkJBRjNrQ013T1IzT2NsazVKaGkzVWVXWU5zYk1tQUMrNEIvclBJdzBrME5w?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 917a589c-2fa4-47e8-9af9-08dc48f1472b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 15:20:29.9725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQNetYwoFsZKt6sSy/E9raVtGE5PoRkfQld0HuH1LyqsxbY1q3JjK1QMNRAcRgK6NYJ38TUaXecTgsVpwOb0mDwhi1cOKEv4cFbBPQhLloM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8516
X-OriginatorOrg: intel.com

Hi Ilpo,

On 3/11/2024 6:52 AM, Ilpo Järvinen wrote:
> The struct resctrl_val_param has control and monitor groups as char
> arrays but they are not supposed to be mutated within resctrl_val().
> 
> Convert the ctrlgrp and mongrp char array within resctrl_val_param to
> plain const char pointers and adjust the strlen() based checks to
> check NULL instead.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrl.h   | 4 ++--
>  tools/testing/selftests/resctrl/resctrlfs.c | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 52769b075233..54e5bce4c698 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -89,8 +89,8 @@ struct resctrl_test {
>   */
>  struct resctrl_val_param {
>  	char		*resctrl_val;
> -	char		ctrlgrp[64];
> -	char		mongrp[64];
> +	const char	*ctrlgrp;
> +	const char	*mongrp;
>  	char		filename[64];
>  	unsigned long	mask;
>  	int		num_of_runs;
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 79cf1c593106..dbe0cc6d74fa 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -469,7 +469,7 @@ static int create_grp(const char *grp_name, char *grp, const char *parent_grp)
>  	 * length of grp_name == 0, it means, user wants to use root con_mon
>  	 * grp, so do nothing
>  	 */

Could you please confirm that the comments are still accurate?

> -	if (strlen(grp_name) == 0)
> +	if (!grp_name)
>  		return 0;
>  


Reinette

