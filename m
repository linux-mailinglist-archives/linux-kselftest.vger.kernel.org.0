Return-Path: <linux-kselftest+bounces-17180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AE996C971
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 23:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5731F2368C
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79EF1547F3;
	Wed,  4 Sep 2024 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FEJQ6a0D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E7014D457;
	Wed,  4 Sep 2024 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484561; cv=fail; b=OKQe7VjE4CnblREblE97vEPoCpvDMT27HgL91zdton35wqpMya4I1S06yfrGWCwtChU4+MnXNMrqkwMIdKe5nkIM3LEfWJzb1ZM0AkJIUmRY8+kV+DqaVJSNA7biA9wUsI0EGTW0JBgRUsSr9PAvMxhJpvsBiUHGK+e3jOV1Wzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484561; c=relaxed/simple;
	bh=2ODKb3mYU+mLiQl9qhPXN83qUCjVGmXDVH8cyWnI1Dw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ez2wWR6n60E0jOy2F7s+wqynhYiSS5ei10eZuXRITPVkUK5536nW2zcUBFfAUt/oj5wALMG+1SIbgg+j1yhJ3LS4kdXMhYmiMXYmTW8YH7NF/k3RqsfpbP3yEykHsfjArHwFTnt/1xLHH/J/9s9Tn3b9AYwxVjaO2kidiOleKBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FEJQ6a0D; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725484559; x=1757020559;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2ODKb3mYU+mLiQl9qhPXN83qUCjVGmXDVH8cyWnI1Dw=;
  b=FEJQ6a0DKxjR0ziYxn2iIiS7RUFTeobzTwGQsUxJg1GnBPzhzcMNi9Fr
   DLFqdQjelynqaEc53/3pKKrBPooXLDPXk5P+vd0+W8VUl0An/OQSZsv0Z
   Fxuv+XvQW28NPBE7LL5dS2To6VaxQGyOkLCQYsZqyOn0+bwY1PeWXbJD8
   hNLIgiaWqHBxfj+tXjcLeJ7hsHELyy7VdVfGtTh5o2vl2mJ8mmZMyJUeJ
   s+2vBi8+1yZ/RH0Fx5p5V3rP8tR9oo39sBHmS6TXqbSO4k0n7LgVXYfb4
   gSfKBatRnNpOqoih4D2QIf8peDdJNLMykR3u3ukvguZLz/7iqAT//Yacy
   A==;
X-CSE-ConnectionGUID: WV39504URqapr2sR2N9qeQ==
X-CSE-MsgGUID: zypIxnGHRlyq+1JpQOaoYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="27091572"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="27091572"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 14:15:59 -0700
X-CSE-ConnectionGUID: X01Kad93SjSnBERA+k0gwQ==
X-CSE-MsgGUID: WbCrS47ARDSkUKv6RUtXIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="66141762"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 14:15:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 14:15:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 14:15:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 14:15:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYBpq1s4J8GygPVLFud52BV4VCH+500ZogTOiJRTtqWctrzxnO2Qxd598BXLsgeO4xdktlaP5lvjG6BnRP2h+zU4oJD3R/1i6vSMLUca8C2Z53hGxt9DbqDS7EThGZ3tVVhuQho7BnBZlKz017CtTVDhi4JSQpyj+svmtEXHJ/xtHEX/PZQJiL+BBcvcnd7pWFeDRoR5R+vp0iM7/FauMLtV+9UEF/pIlEU2i6N9dpQpeCE1LTQqn9LssndtGjy139+IJVdJw1vzHjN3WjF3m5efbEEA+hRMZR373c4Lrfkp6rpKVfuCKKsvzamo7MBDhkgEGpM6Pxp1vhwytm03XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFuNKcqGmZUEZJT0BBfI+EdtBNoekwWiUogESpj+SP8=;
 b=X7mRYMlZBS7ZRq4ykinfmkEVouok5wFzP0NHE/i5untWXpFF0RLjNCxDYw5ZMw3LzKn0iqeAw67M5zq8U8dXnBh5DCPmMJKQkbdqsCqXyd1oa2WOHfu/ryggMSNneWodRXmGvljZFAfX7z5DGbMg7S/3ru0kiTpLleHpaZGO6STkF1SyOFjkZh3yY6R3QachtKpdh4oNS8Ka9CyWWSFLSfUWRXkEfWAnv/ZsAz2w8TvfjSNFEsB4fjX07QeMQoJgrQtp4lBqqh2nKekyQ/Tn2frgHyuxC3YTa6uc5DSH2w5FTT+5Kb2QE58UmfNYcfZ+nRvavoB1GmsNbEg66pyHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6266.namprd11.prod.outlook.com (2603:10b6:208:3e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 21:15:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 21:15:50 +0000
Message-ID: <9b2da518-89ce-4f9b-92f2-d317ed892886@intel.com>
Date: Wed, 4 Sep 2024 14:15:47 -0700
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
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <238af9fe-0d7b-9bc1-9923-35ef74aad360@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:303:b9::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 60eadd0e-4a04-4ba6-fc1a-08dccd26c05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3hvcFNCTTh3TXNyWWRqeHlVT3R0amhEalE4Q1AvTVo3NDZCWG1hendlUEM3?=
 =?utf-8?B?dHJUSVhDMy9URnlVWkJMYXZpeU9xcDUwaWZNWlVtVVBUckJkempEN2ZVcSt0?=
 =?utf-8?B?VXhId1VNTWNZTzd3aHFNaC9XaFpYb2RzT1NhajVQWnZEcG1LeXFScmV3YUhu?=
 =?utf-8?B?U1N6SnNMTjY2VHBlNXBVQUVRRkN3UnA2MTBQZTVrMHJuZGQ5Y3lyaEhsUXJv?=
 =?utf-8?B?OTUxK210WFFHWWoyOFFvMmwzeW9HUUQvM0pIQnZvNnhHMklUbXlZUlJSMW9k?=
 =?utf-8?B?TXNrWEhPMDRMYzF2TUpPYk5FbnBpQmhCTVBubndKN1pWanRVNzBrbDB1RTNL?=
 =?utf-8?B?bk40cTUrbzdLZkMrVTQrc2NDOERwSEFKSkROTGROa0VwKzFibDRGZzZ6Ujh4?=
 =?utf-8?B?TUR3UzBhRFBBaGFHU1pabEZGbjlYOG81bE5qbGVKR0p5K1kyRDI0U3lidXF0?=
 =?utf-8?B?dDA4N1k4c0h0VzhGYysrcnZCSnFWN2pRWnFZYXB5aWVUR0p3WHFnUFNLYWxx?=
 =?utf-8?B?U0Q5SGJwYURjSjY5SGdVSW5hVjZyV1VTSndLa2lZczM3SlRsYjFab0Z5aEUz?=
 =?utf-8?B?MDZxN1g5Zi9Lc1RMSkRMeEJJVHk4TzViWFZDVCtKSXFZaHhBVTJGUytJQ2Zw?=
 =?utf-8?B?SjhOQUFzZ2t2dEw5UnNVeGE3cEU0anJsa1lwaHpLVU9kbWdta0pwelRQK3BY?=
 =?utf-8?B?TlNMcExFdmZzVFptYk9iN2hQVDdsTTVSc05LMDYyNUM0SmNZckcyczhNV3Bm?=
 =?utf-8?B?aFdta05IYWJYclJETTh1U2FPRFMrdGcrYXJrdUtmK0tlWXFkV1dueTR5QnpO?=
 =?utf-8?B?RTBEY08zNHd1ZmRvb0NnaGJJY0FSY0QwbHVTcXZLTFVLUjNtTjJyczVlL1Zs?=
 =?utf-8?B?SnNqSEVYc2JPU2JXWVh6RGhKTXVJMzFDbzdjNERZYlptQ1FrdmY3TDA4SW9o?=
 =?utf-8?B?bzVVdXZuT2V6MFNLVG52d2Nia1NhOEIyeVBOVC8zMkhCUzB5UUdlYTZGWTZx?=
 =?utf-8?B?aUJKYTZ2NStSV3FnQjhiS245d01kM0M3TjYxeDdKbUhqV2d1UHdPTVZ6cXZu?=
 =?utf-8?B?b1VzOFoxdFJKYlkxKzNtOHZrb3cwZDdMaGYrUzhpNVkvbXFrazY5aXorOXhp?=
 =?utf-8?B?VlplUzJNdzR3UnVwMC9UY2RlcW5oUzJ6SGJ4bVVXcVVQMEk1UWZRRjR1K0JS?=
 =?utf-8?B?S0FXcWNuRll2Vm9zMjVkYXVrdWdDTFE4YXhlQ1NGN1daeDJuVEc4K1plRjAw?=
 =?utf-8?B?Y09ZRlBYc3ZpRmRMQ3Z1MVFENi9td0x5alZJU2ViSUhGeGhpcVdwdVhrNlpW?=
 =?utf-8?B?SWoweU84c1ZENWFTdkRWNkVmNDVhMDhneHRFcEJEbHlyeFkzeVZaeU9XNHpr?=
 =?utf-8?B?L2NZblBYV3VrYXFoLy9hWmhHdlBuekpLaGxKNmRNUktReXdFY2lWZm5FSWJ1?=
 =?utf-8?B?T21YSHJ0UWZHZDd2OUF6SzNXR3U0cGc0ODZFcXdHa3g1KzNjOW1qSDl0UnBW?=
 =?utf-8?B?UUJyTEp2dWlMVXptSDdMTjhvUUxUNkJWRS9TekFLYmlaMi9TQU9rU2pGQkxN?=
 =?utf-8?B?WFdGaHR4bS9xZXl5UG5DZCtpMHVBR3lUODJOY3ZqaVIyU3d4OEFHVGlwcXJX?=
 =?utf-8?B?ejdVR04xRWE0YmNoMFV2VnJiRlhxYlorRmlMVmR3N0Q1aFl4MEx2VHc2blRZ?=
 =?utf-8?B?cTh2Lzg4QUhqUzQ0aklmaFR1NmRRbEFUaFVneDFsREVmZkF5R3NCT3hHVlps?=
 =?utf-8?B?ZDVDZHlJS09lZ1Y4UVVCOTZxMDVESEN6dEhId2FWODRJeFJOTTd1M2xzMjdY?=
 =?utf-8?B?OTI4UTA0eUxiNDVYL2g4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STB1WFJmTFo4VWJLb3QxL1dSVTBFSHZwZG1XVWNraVNqbjdxb1FiZENJaE03?=
 =?utf-8?B?WTZ6Y3pVa0JQTlBqRWJwMGhXbVVzTnF2T3E2NFk1SkxBTWJvNmVQeGxmbkVW?=
 =?utf-8?B?UjEvZ3BBNjFyQ2ptUG5nQ0xqcjlmelVnMS84a2wxWjlGQ01EY210Z2h1UUh5?=
 =?utf-8?B?T095aXhnTnNJOWhsd2JLUGxDcm5GV1poQmRaMUxiand2cFp6UDFheVRYTkVU?=
 =?utf-8?B?SjY5L0VKZEE5bjlLOVVTNXZyWUc1ZUZJb2IvSUpoUDc0OE4wSGJsYjY0Qzlu?=
 =?utf-8?B?bmFMTzZvemJqUWl0L3JTNjRac2toYlp5VTMvZGlKT0Vpdm9rR09nS3N5RXRa?=
 =?utf-8?B?NFN3QnljbFBkc3hHNGNnUkdkb1Avb01RZi9JUk43aFIrUHNpUjdZcjA2LzVa?=
 =?utf-8?B?SFo0Sm8zZEdxakl3enJxMGJCQkhQalRJclFwYnlHamhiYVZOYmZtQmJCRjRB?=
 =?utf-8?B?NmpycjRZeTQyY3FsMW5kaWtuemFtU21mUThPdDZkWnovcTk4SjdwVldlSWdT?=
 =?utf-8?B?dmRTd2p3dGx6YVMyODRBUmVUZU1VN0R5azRGUHIxajZIbkl0bmNHTHgxelFS?=
 =?utf-8?B?L3BTb0pLd1RWVngxYTZkR2VNWnlYakJjRFQ5Vk1KQ0dGUjZRVDhWQzNpSHNJ?=
 =?utf-8?B?ekZHT3gzOVE3aWM1QnZEZzRwSVd6K3RGbjI5VlFoWFFPTEdOZVFUK20zYVRC?=
 =?utf-8?B?MDNOdjNrVDlTM0RSMWh2YWJiTzFlOTZlaTBnUWsrcERFWnQvQ2Z4OWRtaWNR?=
 =?utf-8?B?Y3RSQVFPcUhuUDFra25zS1htUTl2NlNNN0FEdjd0SGhFVytZRHI0eVd0ME5h?=
 =?utf-8?B?Z1NSMEpGNHh1dUp5NDNLVmdZZ1lCZHFtMHdSRUV0MjlKem5KOTMySXFEM2Vo?=
 =?utf-8?B?RmJ0YkRKelIvcytDb09Tc1ZEUnpkOWt5d0N6WVh5bFpycW9UOUhLVUtQNmlK?=
 =?utf-8?B?elJ6TXZOUlVnbFZBZW55UnI3TStoTEYxR1ViNU16dUFqZS8zR3dHT2VrNHIy?=
 =?utf-8?B?cHRzenBNUGJUZVR3UmRBMjRVbXVXc2NBZlU0cGdsWnI4UzZtSHQyRVlpeERm?=
 =?utf-8?B?NEg4UmpqaTJaRFZJcFpPMm5seVlwYXY5cmFvdVRibWNyWUlQTlZQV2VCR0xL?=
 =?utf-8?B?bDI0QXlSVHZJVjFiNlRRd0ZGRFA4Q3ZTVnN2SWtyNDhyVE5CcHdXb3VybjJk?=
 =?utf-8?B?NGVGQzVKK1VSN2dPNit1dFFWZ2tsTVhyN2NkWWR4NjEzWGtTQXJuNnVPa3lM?=
 =?utf-8?B?MlppRWp3UTJ0akpyYVgwa3UyUFFQQ1ZsS1VHUGRFeUdRNEFkcFZBakdRa1Jh?=
 =?utf-8?B?eUxFL2JMbHA2UWM4Rk1ua3IxMTNocDM2YXdxZE45OVZta2wrdGZzRFNsLzlM?=
 =?utf-8?B?bCtZeVJQM2lySCtsb3MyTXpMQUhBdG9hYWJscDV3b05pbytVV2JkdzZiajhr?=
 =?utf-8?B?RFVBZkJzYnUwaUc3VVBXeWtjMlhyZStvZWRna0s2UitCL3Rlc2RYNktIL2Y0?=
 =?utf-8?B?S0djQUthdmFCbDE3M1hmWUMwUElhZW5PcHZLUWY4Y3ZhV2ViekF0RER5Zi9Z?=
 =?utf-8?B?TzNEQWMxVDFKUUJPYi9yUDg1anVYdFdGYVJxT1FoZHdZWHE2NGJKek9tcWN6?=
 =?utf-8?B?alJOUEduZ0dvbU1BZitPY0J3NG5pT28yMW82Mk95Wk9HcGw2YTZZaFBjQ21q?=
 =?utf-8?B?NW1SOEZmWEpFWEVRakhWNFdvOGVxMGMxczhsVDlyM2JNOU9HZGdRZTdrd1BY?=
 =?utf-8?B?Vm9vNWlHUnVRcm9Oc2lkNVlsZWRuWG1HSFJ0RmFUMGJoNzRLdnJQRElBTmZI?=
 =?utf-8?B?aTBQS2pzWE9oVUhSN2M0RHFZSmdPcGRqRk9hb3d2YTNMUVFEWmFrTlAzUnJ3?=
 =?utf-8?B?OStYWFQ2S2gyQUtFSzM5anRpb0J0NHZZVk04aHo4U3l3aTNER0cxTUtjNDZE?=
 =?utf-8?B?NVpsUVFhd3VuRHhEc2pzdzh0UXNOOVdZUnVQT1J4ektHMjNPbk1BWU12U3hw?=
 =?utf-8?B?dWY3cGZYN2pPUlVEK0FOVDlCb0FTcVJuTGltN1A2TTdNRFNYc2FGeHZLNXZV?=
 =?utf-8?B?UzRTT1RtaVlDQkVFRWpmUVFhbC9KK1VFeEtQVjFZV3hSc0dDVTJxaG1hTjNT?=
 =?utf-8?B?emluQXlQNVRpY2ZYR1dLUXZvY21CNUVzSjd3cUZ3TGQ5MnFncVI1bXBzb1Ev?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60eadd0e-4a04-4ba6-fc1a-08dccd26c05e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 21:15:50.0748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlKJafnuR7b3GrxF4QDkNhhGZse9npy/5hiDt+OQJ37v+BF1AMQOgwHRiGx21SK7wgqPZge5sUy8IjKWgesyYKxMchFw8ZWioc1M/JIVl1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6266
X-OriginatorOrg: intel.com

Hi Ilpo,

On 9/4/24 4:43 AM, Ilpo Järvinen wrote:
> On Fri, 30 Aug 2024, Reinette Chatre wrote:
>> On 8/30/24 4:42 AM, Ilpo Järvinen wrote:
>>> On Thu, 29 Aug 2024, Reinette Chatre wrote:
>>>
>>>> The MBA test incrementally throttles memory bandwidth, each time
>>>> followed by a comparison between the memory bandwidth observed
>>>> by the performance counters and resctrl respectively.
>>>>
>>>> While a comparison between performance counters and resctrl is
>>>> generally appropriate, they do not have an identical view of
>>>> memory bandwidth. For example RAS features or memory performance
>>>> features that generate memory traffic may drive accesses that are
>>>> counted differently by performance counters and MBM respectively,
>>>> for instance generating "overhead" traffic which is not counted
>>>> against any specific RMID. As a ratio, this different view of memory
>>>> bandwidth becomes more apparent at low memory bandwidths.
>>>
>>> Interesting.
>>>
>>> I did some time back prototype with a change to MBM test such that instead
>>> of using once=false I changed fill_buf to be able to run N passes through
>>> the buffer which allowed me to know how many reads were performed by the
>>> benchmark. This yielded numerical difference between all those 3 values
>>> (# of reads, MBM, perf) which also varied from arch to another so it
>>> didn't end up making an usable test.
>>>
>>> I guess I now have an explanation for at least a part of the differences.
>>>
>>>> It is not practical to enable/disable the various features that
>>>> may generate memory bandwidth to give performance counters and
>>>> resctrl an identical view. Instead, do not compare performance
>>>> counters and resctrl view of memory bandwidth when the memory
>>>> bandwidth is low.
>>>>
>>>> Bandwidth throttling behaves differently across platforms
>>>> so it is not appropriate to drop measurement data simply based
>>>> on the throttling level. Instead, use a threshold of 750MiB
>>>> that has been observed to support adequate comparison between
>>>> performance counters and resctrl.
>>>>
>>>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>>>> ---
>>>>    tools/testing/selftests/resctrl/mba_test.c | 7 +++++++
>>>>    tools/testing/selftests/resctrl/resctrl.h  | 6 ++++++
>>>>    2 files changed, 13 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/resctrl/mba_test.c
>>>> b/tools/testing/selftests/resctrl/mba_test.c
>>>> index cad473b81a64..204b9ac4b108 100644
>>>> --- a/tools/testing/selftests/resctrl/mba_test.c
>>>> +++ b/tools/testing/selftests/resctrl/mba_test.c
>>>> @@ -96,6 +96,13 @@ static bool show_mba_info(unsigned long *bw_imc,
>>>> unsigned long *bw_resc)
>>>>      		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
>>>>    		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
>>>> +		if (avg_bw_imc < THROTTLE_THRESHOLD || avg_bw_resc <
>>>> THROTTLE_THRESHOLD) {
>>>> +			ksft_print_msg("Bandwidth below threshold (%d MiB).
>>>> Dropping results from MBA schemata %u.\n",
>>>> +					THROTTLE_THRESHOLD,
>>>> +					ALLOCATION_MAX - ALLOCATION_STEP *
>>>> allocation);
>>>
>>> The second one too should be %d.
>>>
>>
>> hmmm ... I intended to have it be consistent with the ksft_print_msg() that
>> follows. Perhaps allocation can be made unsigned instead?
> 
> If you go that way, then it would be good to make the related defines and
> allocation in mba_setup() unsigned too, although the latter is a bit scary

Sure, will look into that.

> because it does allocation -= ALLOCATION_STEP which could underflow if the
> defines are ever changed.
> 

Is this not already covered in the following check:
	if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
		return END_OF_TESTS;

We are talking about hardcoded constants though.

Reinette


