Return-Path: <linux-kselftest+bounces-10669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF368CE799
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 17:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68269B20F0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D382C12DD87;
	Fri, 24 May 2024 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cy35KIeF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626C112DD9B;
	Fri, 24 May 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563706; cv=fail; b=aPC8JjvDxA9ap/rSd9UTde+exPh5FCGX1dYr9p51HeTBwr/Yjlnn8obWgcH5tO2mB/1sQWiY9YumIeoKOBcEQKJw7+ZST8zct+qxSj2zE9yOwNb5RLw6i5ml+x/2YrW/rTp7vc8ik9nDaSYVFcNlYTybnHyFznXXnUuNlEfTBZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563706; c=relaxed/simple;
	bh=8c/VFctNpvWUi/nz5gP1IJo9NCA+aPScWORoMEb0e+E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DIWkQu4G3t2z1VSEjSFsf1jfks6/3l5NwqxquJzUl5URd347upKhErQAI1UJKfx908oniHXHU9JWmk+EElzUeLq+6kT6qByrH/+hZVbEfqhy5i8FlhJnL9/3omBocjS8L5aFmbSiHolG00tVj6RkAzOr8NM2jIeXU7dUFqGCCM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cy35KIeF; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716563705; x=1748099705;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8c/VFctNpvWUi/nz5gP1IJo9NCA+aPScWORoMEb0e+E=;
  b=cy35KIeFq7LAxDeCYab7GEiKFH9B//RLOQOR6vlus0tCRvWZQKiI7TUb
   3Q+lRG4nUHeAw86vi7wt/Bcnw2+VBbuxCOXRSAAXfM8SvNURH8Svtc+Au
   uEXXKkkozxLLuHKYUfqVioFCzNyWVdUDQTqXaIAgJjDTn49GQd7HNwh9g
   GxKaNqWB64PAejaFmIxh8uTVZ8AAbI3u2YcPOfXpE8VQ+c6ZrtCTBbNRt
   8LEsCHuyP5tWsw9+mAbLotmS1SkmrqeL5+tozqWORtDrdrEaPArUFwKMD
   mlKdkAswgWlzHhyjPuuwXDgNsL/qqfEIvC8GUc8l6Lp/xlB5+rUPJWUqs
   w==;
X-CSE-ConnectionGUID: IZs+EX0jRfqIpEcHfq7uOA==
X-CSE-MsgGUID: 6+Z7bK+DSPatGpgJGurfmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="23513148"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="23513148"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 08:15:04 -0700
X-CSE-ConnectionGUID: iwpkM06MRrmg3neCqnWchw==
X-CSE-MsgGUID: UZeYrjNKScCDqpD6dIHmfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="65272598"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 May 2024 08:15:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 08:15:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 08:15:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 08:15:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 08:15:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6l6V85nWzvAIR8I89CGdOx9x4Atm/PuT8lVwCU3SNpuLy126LeqDmH8SRaGuUeDp8/JkAkYSpBHrlHJ3uyLO/LeR3Vl5j+dGlcCxM65DcsmiBKbGP0NAdK81yNQCYJ+lOhxV48bclR3uNUF2uok+6xLeOJIQ+o0EPk+A6bmXn0ZtWCoyrt1ZU8a5v9wInVanhxxPP/K9ibcZl6yHAbS6KxEjMiNHEJmrwuDxoiJGmx/LgQFyz8iHSRowdL3yKypVzEYTXu9aJVx2LF3FODsmju/X7UcNtHCTwvP8JM41AJtrwP5WzawtSCcAKJb0OCq9w60AHEmLqHt4cyRtMI1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku7injN4T7GT8wsEtWIvSlobyzwI8YgkGBzNGuxiF3w=;
 b=kRXMs5X6MYpXhvEOUzNM53YTes8e4IGqnY1b/7yCXTZXCABNIK7lHhqjfAWxVlrNm7A6y6V34ViQr65Xiy31jz/i/5Ql4KnoF7LnZjgHZ75ogueRqQMDIeS6fT5O1vbhuIeYPbVopJPooK/4vOa4iNrsuKyrRna9PWygci6UVpgGxVCuWaGJTsya/d3Sv+pQDkzXGifs92BKNgOamX1RFOQ3eFdcBKMNC7mC85Et5W3Vm+jTyq9JCDyHz3Etb49WXRFAO7kFaIA7nqEW1IAoVUZw0lW3j7OPasXN791sw4+TwCW33Y5/wsgN6oABusKxpJNXIoF8q+qUO/Yg1l0QFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6737.namprd11.prod.outlook.com (2603:10b6:303:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 15:15:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 15:15:00 +0000
Message-ID: <d8063ee7-1744-45a2-b6b9-506e68106baf@intel.com>
Date: Fri, 24 May 2024 08:14:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/16] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Babu
 Moger" <babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-3-ilpo.jarvinen@linux.intel.com>
 <04d0a5d6-82fa-4cc7-bd80-ee5cbd35f0c3@intel.com>
 <ea0c86b9-ae77-c2d9-b52b-239ae42603e8@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ea0c86b9-ae77-c2d9-b52b-239ae42603e8@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:303:2b::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce4d343-450c-40a2-a1c9-08dc7c044776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkJrL0FHR2dmZjhjVzdveDk0aStKbVZndkpiczA0bFN3OXp3b0o1aG1Ka29u?=
 =?utf-8?B?SWx4cEN4eDRnYjNDbkZlMEpCR0N5L3poK0lOQ3pXNWZWYTQ5elV4YVlLT0ZX?=
 =?utf-8?B?c1hQVFZrZ0hGN0FoZU45T2paY3hxMGVacmpMangwUTQ2QitYNllyYjBZUkV4?=
 =?utf-8?B?N1lKVVF6UmlDT0p6WVF5ZzArMjV3RmV3MTVBVkp4QUxqbVQ4eE1MdkpGRHVp?=
 =?utf-8?B?TGJIL1dUQ00xay9jcjEvVHU3TW9sbWpHL2xhMDNySm1KekNIMHZSMHFUbEo0?=
 =?utf-8?B?OGdWZlJxUUMxVE9OOEpUblREVmIyV1VLZmY2THRWMnpzaUdDYU1yaGtMWUZI?=
 =?utf-8?B?dXpPSytoN2ltMHFTRmZsQ28xeWtEd1BPd21iWEZJM082U2VuT1BhOXlHKys3?=
 =?utf-8?B?OWxsZ2NzTWt4VE14UG1VN2dUT1pmS2xtSW9DRGREbS9uVjJMRjlKSzI4M3hJ?=
 =?utf-8?B?Um00N29xWVo0aVF1RmNYdXpoZkdYWExpa1BFMjBYZTk2Nk1mWmFSYnZrT2ta?=
 =?utf-8?B?c09Ib1g1RDhyMU91aStvbllhdGhOWXJ5cUROL3o1UnhhRTJISENxd1haOEtn?=
 =?utf-8?B?MDQ4K2hBWUtVNHYza0NlcFgxWmNXNzB5Yi83dHBJZHo1MS8yWnFzT2tnNW43?=
 =?utf-8?B?bWh0cWlHQWk2M04zKytvbFVuazZpRG5IM2V6d0JRZUtOQ2creEN2S1MrRHcr?=
 =?utf-8?B?VGhlMWU1aGRweVNZYjNicGhoQ25ORTAvcS9ZUk95bVNmQkhQNjQySEptdUhh?=
 =?utf-8?B?VCtvRTNpMWk1cDlBMVlLYTVOV2hydXRyMmdqdjcrdG51ZlMxOG9RRXVVTjVJ?=
 =?utf-8?B?SEFIZG04cWhhSWlnc1d1Sk44ZC9iZk1uYU81elZNMndhTjZpeTRxa2l0SmtU?=
 =?utf-8?B?a1JaZkF3V012OERWUStvMHRPU05mQTFFZ2JKaHg4UmtrT3hadUx3OUZlVnJx?=
 =?utf-8?B?bklBYmdCcytZUGdyMDNNWk9Na2F6cUh1VFFqVWlkTmJlS3hVaTBSTjgvUkZP?=
 =?utf-8?B?eVdhYjVnYnpRVGhHZmlBK3M2LzJpMGNqUncwanl5cWl5WnFyb3pJT2VTOEpk?=
 =?utf-8?B?MzZKYWZhQjN6eElGRnhlT0gvQ2docUw2SmFzMlRUUUxEKytLanF2Y09NWkZy?=
 =?utf-8?B?R01FcGFDbkZZYnY2TzFMcGlvcytwdVhZYVlmVjQ2d1l1WlIwRWpjeHNQdU9W?=
 =?utf-8?B?NUJEdWR6Z09rTHhlZ1Bna1ZpZ0dlSU1jMmNxVUpJKzZvdnlXMWVLdkpzSS9J?=
 =?utf-8?B?OXJHRWNGblRxYWdQMlBvcUx5Q0twUnRFRDBlZmpRRkUwbVhCNDkvajk5MjUr?=
 =?utf-8?B?VGlyd21mOVhvU285eGNPc3NNTzFYaHh2V3RZREVheDJIK3k4VC9RYVBPWGdV?=
 =?utf-8?B?c1JEaHd2c0hseldFUEhjNlBBeVhFN0ZKdDRHQXFhZis4Q1VKK01FQnZ2aVRF?=
 =?utf-8?B?emxObkFqOXBDa2hxRS9VZE9nb3ZSblJqM0ovWFdSNVdKRGVrTFlDUFJGVmY0?=
 =?utf-8?B?SE5Mc2FDYlFUUlhBem9zQVNrY1ZyS1VsN0Q4WFBkc2ZSa3V1dmQwVlFybjZM?=
 =?utf-8?B?RnUvdFlybnp2bmJxR1pPWUdIUlJrNWJaU0didk9BSnREbm1BTTlaemduQjM2?=
 =?utf-8?B?OWE3dEIvdnJRVS9JbHFpVEZSM0NtLzZWRFBaOHV2ZVNMNkNJZzdZN0lENHRq?=
 =?utf-8?B?djZ2QVp5aG9PYUhQTVA5T0V6OTFrWlgxSTFsekM5UFJxdjAyQytudytRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWZXdmtWOFNSK0VNeGIxQm1GR1NHcnVBMVdYOXpEb2RaYzJzYVZtdVo0SjRT?=
 =?utf-8?B?UHphMDhSZmpvODB0bTRqajA3UzdNLzI2VXA3NEV6RzRidWtobllaT1FRa2g3?=
 =?utf-8?B?andQdDFSZ25BYkZDZ3dOY3cydU0vQUhIdEFFYlVrNmZuOERMdStpV1UyMUkv?=
 =?utf-8?B?NmhTdjJHcis0blRBbkZrQWY5bGg5dXM3eHhRb0U5Rm42U3NHRVRhVjZqZDNS?=
 =?utf-8?B?UjJJNTRvMEtkdStpVER0UmJYTitucWg3eXJaU0xUYlNtUnk0ei9TSTBpamtC?=
 =?utf-8?B?Qi8yY0I4YWFWazZOQnVzTXNpekZDK0kxWTBpanJIaTNadDZSeDJ6Qi9UMGwr?=
 =?utf-8?B?aWN5YWkvS1BFajFhdnhHN3d5K1NobjJ4Nk5nNDcxRmNKbm04QkZ1bVRuUGky?=
 =?utf-8?B?aWNVUGo2ZUV6WjFKenNQTWgwcVlDbndlc0t2ZlZPRUo4K0tiS1hxZFQ3ZFVR?=
 =?utf-8?B?alFRQjYwWUEwc2FDQkNLOVFtRTBNQmUyM2ZHMmt2M1RzS3VtY2NiRU9BUkRO?=
 =?utf-8?B?WWdNMGV4NjZxWjg5UFlLRFRnaUZtN3VlZTRvQ2FuOXlyZkZKRVRjdkUzYmJi?=
 =?utf-8?B?eTdyZHpLS1ZNYW15YXFmOTd5RTgybmY0Rmhta1p5VURIQXUxZTV0d0pvN1o2?=
 =?utf-8?B?c2FJY01yOXlobWRvVFJLOVUyMWlhOFVUOStzNmttek84dW5ncStHQnlFcVFQ?=
 =?utf-8?B?am9jaEtCRlQrenIyVU9CbVVCTTFuS3NIM1Q1eDVpSThMTEFTbkovRndWbUM3?=
 =?utf-8?B?ZG1JQjFqRC8wZ1ZzSWhGOGVLYnlacjBwMHdWODNSV2h2bkduMmV2cXFWWU1U?=
 =?utf-8?B?T2lySVZkTjVjZWxCelZIdlAxVGFiT1ZHa29hQWV5dit4TktJY3hBdmpHaFBs?=
 =?utf-8?B?RndxZm52NU9UeDluZk9MY3RTS3g5eHo3bzE3cmczcUVPL1FNcXE3ZnA2Ukl5?=
 =?utf-8?B?TkxwTmM4a3NMR0Y0dUM2VUpaOGFwaThDTjZEUThMcGY3dUMwbUZoR0I4Z2pj?=
 =?utf-8?B?T3lxWm54UjZRSkw4RmRhWHZZREtRc2daNmFTTlFxYVFaWHhwWTBBR2NOWXFk?=
 =?utf-8?B?ZlBndVYrNFc0eTM0RmpnUGQrS2JIMTNEMUlQeGtkRnlhK0RVMXF5d250SFM1?=
 =?utf-8?B?VzNRVm9ycG05cnRsZGtzdkV2b0R2dWVUQnF1RW9Jd0Y4TTByOGlPT2N0VWdN?=
 =?utf-8?B?bFordmZBV1NaMnNib2tYNlQ0b1d2VXczditIZ1NyK2hJN2NSQityb3RYbWdV?=
 =?utf-8?B?a1FqdnZzT3JOTmo0ZmlsYXpCR2ZHZlVhV3FnR1JVeER4YWJ4RSttbnBQbFRw?=
 =?utf-8?B?ZGhvZFhTQlZxdVhhMWtESFV1RjNjVGd1M3g2Q0cwaXF6N0t3L0RBQ1NBbGla?=
 =?utf-8?B?c0hDWVo5UkYrQVc2bThIelVUNFdseWVxdE01LzJaUzI4V1BNMkRCdCt0bkhV?=
 =?utf-8?B?cVlLU0tQNXB2dEtmZGFuUDVvM2NSQTNPdHdrWEVVN1JONldhY2w1dDIvOUZy?=
 =?utf-8?B?RVluczNzUWxmVndDZTJDOHl2N3NyMzd0YlNNMktKRERaUWoySkU4ell6OHN1?=
 =?utf-8?B?VjhITmNNN3FraFpoZWhPQVNSUHNsbTFWbTBoYjl4ajJtZEpEZ0E1d0gzanhy?=
 =?utf-8?B?SVVneGt1bVc0cFdPakN6aFU1VFVONm1RL1lHZitjU29sTzA1NnRwRFg4UDBT?=
 =?utf-8?B?YnM5aGR3Q1kyRkpqdjExd3Q3UWVPRHVvTTR6ajNyRllKU0ZYTFN6RkkvVFhz?=
 =?utf-8?B?cDVjZmM4Y1NSdHlpajlwUVd6R2ZCTDgzc25BT1d2OWJRSjJkZStkbjliQXQ2?=
 =?utf-8?B?SFZ0ZVc2VFc3T2JzczNKMWZ0R0VmQXF5UDhsQTd6SHNQMjNRRjIzaTllODcx?=
 =?utf-8?B?dkR2T21VMFBFV3I2MFkxbVBxQTVnRStKZWExaW9PQWxvK1BWK3BkRGdaK1JL?=
 =?utf-8?B?MHhlUVpBZ21nbGhZMTROc09SVkowM1hQNXAxTEd1Qi9ReHVPV2Vpa1NHMFpo?=
 =?utf-8?B?ZlQwN2s3WFVuYVh5ZGNqc0NaTnBzTVUvUFBQcmZ4SmgrRS90UTQ1dDN4SzhO?=
 =?utf-8?B?ZUNRUHdLYW5ZWmN6TWFwKzB0SmFncitNRkEwaU50UnJ4dG0yL1dKTHdPMlhl?=
 =?utf-8?B?eWdQcnVSdUcvWGM3eDdwOTFsU3ZVM0xHNkV0V0VQaVR6aE1tdHIxc2pJakM3?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce4d343-450c-40a2-a1c9-08dc7c044776
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 15:15:00.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ckBRWQKjslABGdtUSyK40t1xAbQBVyuKeu24ALBsUzp9RXCtlUQoY6p32qn8nRhXWjALj82eNbrfjoQD8LSKQUdV4xuefXwOLHbx8BbwBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6737
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/24/24 12:57 AM, Ilpo Järvinen wrote:
> On Thu, 23 May 2024, Reinette Chatre wrote:
>> On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
>>> For MBM/MBA tests, measure_vals() calls get_mem_bw_imc() that performs
>>> the measurement over a duration of sleep(1) call. The memory bandwidth
>>> numbers from IMC are derived over this duration. The resctrl FS derived
>>> memory bandwidth, however, is calculated inside measure_vals() and only
>>> takes delta between the previous value and the current one which
>>> besides the actual test, also samples inter-test noise.
>>>
>>> Rework the logic in measure_vals() and get_mem_bw_imc() such that the
>>> resctrl FS memory bandwidth section covers much shorter duration
>>> closely matching that of the IMC perf counters to improve measurement
>>> accuracy. Open two the resctrl mem bw files twice to avoid opening
>>> after the test during measurement period (reading the same file twice
>>> returns the same value so two files are needed).
>>
>> I think this is only because of how the current reading is done, resctrl
>> surely supports keeping a file open and reading from it multiple times.
>>
>> There seems to be two things that prevent current code from doing this
>> correctly:
>> (a) the fscanf() code does not take into account that resctrl also
>>      prints a "\n" ... (this seems to be the part that may cause the same
>>      value to be returned).
>>      So:
>> 	if (fscanf(fp, "%lu", mbm_total) <= 0) {
>>      should be:
>> 	if (fscanf(fp, "%lu\n", mbm_total) <= 0) {
>> (b) the current reading does not reset the file position so a second
>>      read will attempt to read past the beginning. A "rewind(fp)"
>>      should help here.
> 
> (b) cannot be the cause for returning the same value again. It would
> not be able to reread the number at all if file position is not moved.

I know. This was not intended to explain the duplicate answer but instead
describe another change required to use current code in a loop. I
specifically said in (a) that "(this seems to be the part that may cause
the same value to be returned)".

> I certainly tried with fseek() and it is when I got same value on the
> second read which is when I just went to two files solution.
> 
>> A small program like below worked for me by showing different values
>> on every read:
>>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <unistd.h>
>>
>> const char *mbm_total_path =
>> "/sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes";
>>
>> int main(void)
>> {
>> 	unsigned long mbm_total;
>> 	FILE *fp;
>> 	int count;
>>
>> 	fp = fopen(mbm_total_path, "r");
>> 	if (!fp) {
>> 		perror("Opening data file\n");
>> 		exit(1);
>> 	}
>> 	for (count = 0; count < 100; count++) {
>> 		if (fscanf(fp, "%lu\n", &mbm_total) <= 0) {
>> 			perror("Unable to read from data file\n");
>> 			exit(1);
>> 		}
>> 		printf("Read %d: %lu\n",count ,mbm_total );
>> 		sleep(1);
>> 		rewind(fp);
>> 	}
>> 	fclose(fp);
>> 	return 0;
>> }
> 
> Okay, so perhaps it's your explanation (a) but can libc be trusted to not
> do buffering/caching for FILE *? So to be on the safe side, it would

Coding with expectation that libc cannot be trusted sounds strange to me.

> need to use syscalls directly to guarantee it's read the file twice.
> 
> If I convert it into fds, fscanf() cannot be used which would complicate
> the string processing by adding extra steps.
> 

It is not clear to me why you think that fscanf() cannot be used. Could
you please elaborate what the buffering issues are?

It is not necessary to open and close the file every time a value needs
to be read from it.

Reinette

