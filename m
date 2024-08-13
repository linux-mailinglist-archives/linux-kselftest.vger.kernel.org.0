Return-Path: <linux-kselftest+bounces-15184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D041594FA8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 02:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8743C283955
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 00:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A09D19B;
	Tue, 13 Aug 2024 00:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1taOJ4j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B925E18E;
	Tue, 13 Aug 2024 00:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723507546; cv=fail; b=XQClshanK2ToKctfFalWjMsssKwZZXV7NVejh0mBlMm85Jrgs9NSQMxi+SA7M6QxM5zgC67QlUiB49FTnkKnXgO9CwAP4iaySV28sfW+if9yBDz9s/U2/wmMAD+4PU9cyTCS3D1AYIjCorn6qlQyhYzs8zIU+TIUNpKO0kFXNxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723507546; c=relaxed/simple;
	bh=W4PcVZYj403m5F+x4caHbVtQwX7+nLxW5Z5LfqDWrig=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H4AHOoEXHvDd1pDDZG/d+/1hd8rDls8TcBqd3VEB3Q+B5CvLaPOea79FPJGNzuCtrjBtLNi+0QPZRreJSaKFPbe3p7egWvb52J1FBdXcJt/V2JaJ2hugCuH7S4uvWJmgxb9TsHyTCV31DvpXZgsgftzNV1qFK6K89+tRXHLBYH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1taOJ4j; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723507544; x=1755043544;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W4PcVZYj403m5F+x4caHbVtQwX7+nLxW5Z5LfqDWrig=;
  b=X1taOJ4jpDBAD85v/tDXW6bIg4QG8afibUlGQQxQSQFEM32SP5MIHYgc
   UVVhqat1IxDqbRf97G+LW9xtnWbHlp2zWDfeWQJrILYrqHLDo85VgI4Tl
   q50o6Xng0834WxKpk3JJPnBqUY0rrE7nduJobQdnOlCM/QBqiKuLAwXYH
   hUJnxkdUUlQFaHW2vqI94bfg0EkbDo4jbYZdnB3dyuPaJxCpJCxNxvKZn
   K87/h2kU6h2wNWMGbyA+g526AcgL4aQ8YuKB1SIrlGYxkW+iF+Flqe5iq
   BcwJmCvuh/qOMkgqDiVw1uGx71wi/FOXK5/tiGhAra/iTa3iatfOZ4QON
   w==;
X-CSE-ConnectionGUID: HD4fRFsoTLmSOmuSHKpRfw==
X-CSE-MsgGUID: 0YyQC8L6R1Cjabm7WXd5DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32266013"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="32266013"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 17:05:37 -0700
X-CSE-ConnectionGUID: Qjq8il5NTOGQ+/KNH92SmQ==
X-CSE-MsgGUID: E5q3i+qHQ2KSwLG1tqFQgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="81712153"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 17:05:36 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 17:05:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 17:05:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 17:05:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SozrbukWSdDHygEVg5BoOjtob8oVPZlGOVbh6IkFYdMI4ggD1DCSdmYVZ8eySjju0QgTum3RjUMSP2ueC0wRYScn68gPwb/iL/Y7/2unW523p5yCyPBJBzeF7rVK/mzgMv2G5Gfbd+HSq4v1Pb9pDGelvMzTe6gl1cFNytTrvW0M/jp8A5T37r5NVdeCbzcxdfXw1rYkaWxqUFwddOQswAo8fuyX19UBpqmC0wN8euASWBUCQyHqKG7iMR809p83yEYuMGu8gkTCWnQtbGeFcceQbRUUXZ3BEN9LMxASNyRzHKiwSh7KEHwKEfRbd+NlpEcuDvKZC1SHhesQ5M9LuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8SojgWaAEzRnNYrV8UpzBVeQkVddEkp2/WZ0O7gsUs=;
 b=BzrJskv9mQJfr/gbxcf0csWqF+6AToxdR7ntFffISIINEbtRVwWcdWIfVx92e/7Qvs7nKnS4VL20DhoayOIbHibkHbjKJoEMBLOyAcFvoH+LRn8ypWXzTl8A6BNxkfDKVvM4VB59s6t5UwuRt9uyYAJo7H7lskPoum4mIMTpKbtK3uTpgl4k6XrTvlJF/M8UORQwIJ8b+HFxCY77iSZbvoAp90rwx5H1LI1Sgx4UpgcixByATXngxrXOUpaigSZRiZg1TNfjlUc6VcIQzoIqGxdFB4Is9DgVboHndWaB1CpNR5yP8gjNNEms52ARZSSZcTO9drRJImV9asy81LmWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6148.namprd11.prod.outlook.com (2603:10b6:208:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 13 Aug
 2024 00:05:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 00:05:33 +0000
Message-ID: <6dd1b5ce-2ce2-4d61-beff-a100da213528@intel.com>
Date: Mon, 12 Aug 2024 17:05:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: resctrl: ignore builds for unsupported
 architectures
To: Shuah Khan <skhan@linuxfoundation.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Muhammad Usama Anjum
	<Usama.Anjum@collabora.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, <kernel@collabora.com>, LKML
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
References: <20240809071059.265914-1-usama.anjum@collabora.com>
 <d60cf782-9ab0-ed4a-0b3e-ba7a73ae8d51@linux.intel.com>
 <080c4692-c53c-417f-9975-0b4ced0b044c@collabora.com>
 <f7593344-203a-8e73-d53e-574ca511d003@linux.intel.com>
 <4072bf51-1d37-4595-a2fa-b72f83c8298b@linuxfoundation.org>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <4072bf51-1d37-4595-a2fa-b72f83c8298b@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0306.namprd04.prod.outlook.com
 (2603:10b6:303:82::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bb4a40-3bca-4f2e-7435-08dcbb2ba6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGFNU0MwZDF4ZEZuMmVRU3BGVm1zbDdFNmlDRHZ1dWM5ckZzVWwxSVdWTVp1?=
 =?utf-8?B?SUJoNHRoSEhZblJFb2NmWGNsQ2lYRXh3K0tJM2VrMjMvUGdIeWZEOVRZcmJk?=
 =?utf-8?B?aWlrOEZkNVNTNUxOZGF3ejI3OGJUVXpOUjQxSFZ0TTdWVEV5cFpiVTZYVTRh?=
 =?utf-8?B?RlVmMnZnYXM0NWNtTGVpanc2Q3FpcnN5c3E3RktkR3JSQlpMME1uU0FoYkU0?=
 =?utf-8?B?TGdVMGJSYjVLTVNtWHRPUUdnTTY2R2cwU0xrVEM5cTc2OE9mSGV0bXZFSk9m?=
 =?utf-8?B?WTN6d0J5bWcrU1dQcHJIRDlicHVPR3ZyZEo0OENrTGsvcnlpU0pFVUluWGdt?=
 =?utf-8?B?RWxNSkFyQ2xKNk1DR1pNTnVMcW1Kd1VPLzdSQnF0d0w5OEY1S2R4OHJyS1M5?=
 =?utf-8?B?ZmlidGw3VVYwTk42UG1JYlZUYmh6OVdEL1hQV2hRWDhtYS9rUk5nVjR2VkVM?=
 =?utf-8?B?bzlHd0MrRFNTWEgrNjdSOU1WZDdsZHRkV09jZTI3VVptaldEaG5DSUF4ZWpy?=
 =?utf-8?B?Qi9NMGZVRytSWnNOY0d5YmNwYmE5SnNvcysxbkZpeW14VjR2djdXVDU5eVQ4?=
 =?utf-8?B?ekFEN0pnRDFzc2ZIbXZTRnphcDduS28yZ0g1R3N0RERpd1N6Nk14UTNmRlNk?=
 =?utf-8?B?ZGFOb05SR1d1RmkrUmgzcHM1dE5QMEV3Vm1rQnM1NFdPTTRncEtlaDArN01B?=
 =?utf-8?B?TXJvSDV2cjRBZmhRbEp0c1FLLy92U0EvUjM1NS9EdGlDNHFJWjFYOFh0d3cz?=
 =?utf-8?B?VnVNZmhsRHJUYWEwYWdDWUVsVStjVmFnQUQxQ3RWYk1vMHpqWEFxNDM5SmtZ?=
 =?utf-8?B?ZXJ2Z0VKeFBrU1BRVDNnbzkyYlAxQ0RiVi9zKzZ0VlVZenE3SmErUXlQSGwx?=
 =?utf-8?B?R1BjWnFNWkNEMk5LWFdHdTJXUlFIQmozb2NMaUNSUkRQUDFUaDEzWlJvU0Z1?=
 =?utf-8?B?ZVRXUkxQVWZUUm94RWsyRDNzbTBMc1oyMFc5c1hHQ1pOV3V3US94QWpzT05O?=
 =?utf-8?B?TTB4ZW9OV1dma05jMlgwNllVSmFvMDU2dU1RQTFETXBVRERKSEMxSzFVTkhy?=
 =?utf-8?B?bHI5aVFKdE9va1JISDBhVVAvbGdQL3JMNEFCRXM0aEJ2TEhnQW1VcGYyVHUy?=
 =?utf-8?B?aXhjRnlYSSs3a05ueUdLVjhBanF1N0hBVklzNk1sZVRJcU94WnpoYis3YVk3?=
 =?utf-8?B?YVRxSUVBK2pjdGMxVWhIL2o4V0hENjFWckp2N1lZYUJLYXo4VGlpU2NvS1Fi?=
 =?utf-8?B?cHl2ak5yQUlCS2ZndHRyUEFnaFo0M3VQSHRhWkxrSFdWb3ZyYklhbkNnTUdV?=
 =?utf-8?B?UldTQ3h6TjRXY0pNemhXUUdKQnFoM0lNWFpUVGRQc0hGTEpGY1BwOUVQTDB1?=
 =?utf-8?B?T1NjRGlWakNpWmVNVE1JaWlZUnBjNk8xMlhBQXJYSlpzR1U0NGQ5M0krbkR3?=
 =?utf-8?B?bENPUWJDaVJscVlnUzFObm5aV2p2Yi9RNnoyL1RTZjZQbHVYWHFXN2x6VkVQ?=
 =?utf-8?B?enNZL0ZyNUVmeTYzdzhlRk05YnBBYTE2bzFldDVWckdtVDZ6enhsYy9zL3lY?=
 =?utf-8?B?VEh2ZnpzRkt5N3JJelU4ZDVDWjB3NUxzTHB5em9VdHhTQVB1UVMzYWR0RkxZ?=
 =?utf-8?B?QVNlOUxCL2dUOXJNQm80eUUvM2tnWXNDMm1TTWtTZW1lUldCRmcrNk5RREhr?=
 =?utf-8?B?VU1kN1lUeTRkYTZHTEFIOEhLTzZUNG1WTkdBdktCRGJRc2VtVDRxQy9hOFVk?=
 =?utf-8?Q?ZvZZX3umG4NeIwjr68=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm15N0Q3T2MyY3VmS0lMU3VhdEl3WEhKUmFrNE5jRlp0cWZBc250SGZyR0dx?=
 =?utf-8?B?TXA2Wm51S1hMSTFFNG0waGNtaytiVGVrZFhSUkVxQ1pZS25OZE41dTFLdW1L?=
 =?utf-8?B?bzJrUXZhK2FaMTlnQVVwODdqNDhQYWhIeUlhbWNrNk9ZMHBTS3BKR25rUi82?=
 =?utf-8?B?NFJxTWRGdnBISE12UTFBcWErM1QxbEZndUFwTWRiRXk5Z1h1L2NwODZQbWF5?=
 =?utf-8?B?bkt2YXg5UnBRcDBpODZyckdwUnVUYXQrUTJsMmtMcUMzZnFaek05bE9FQnhJ?=
 =?utf-8?B?b0RlbE9qZ2gyZEMyaGI4dE44OVh6YWllTUJxTmYyTGZMR1BJOHJxaW14eTlF?=
 =?utf-8?B?dDhLWXIrUkhIL1RycHlKN1FzTnZxeDgrWldNMFhQeTNHZmF4SnR2U1IzN0NC?=
 =?utf-8?B?Ymk2aFI1NG8rTmlQU0RGYVZtc3NmamlVbENVUVRRTllwM2phYnZyc2UwWEo3?=
 =?utf-8?B?TzlsZCtXN0NuT3o5WXhCZDY5NU9ob2EyVitaWi9XSkc1Z1JNcVZ4Z1dGUlBr?=
 =?utf-8?B?Skh6SGJWQ3prMDBnVFplWVhrK3VTR0hPcXcvZnBEV0pSeHZmVlgxNU1jTGJr?=
 =?utf-8?B?TWd3OXJSUDZRUzIzdjV4bHVIMHVXRFF3eXQydFEvS0tRS0VhQlQwT1FpWUNv?=
 =?utf-8?B?a0plTVp5RjhjNjJLV0ErZmlGc2xFZDdnemx2dSs5WWpEYnlaTWVjM2tUUG9R?=
 =?utf-8?B?SkFnOElDeG5yT3hDdjNmcTQ3a3NiQThPUGNlTTVUZXBuYWd4SXlLYkI5UWl4?=
 =?utf-8?B?dVpjT0tQdFNVeEc0NGowYU9NNVp1QnozSnVTbllVYWtFUjBsNnY0RTlwUlhp?=
 =?utf-8?B?UzNFdDJJOGdhTTNlOHRNRlR1SmYzODhBRVRtV2toMzQvWmx2amxDOW9sTlI2?=
 =?utf-8?B?Ylc2eWVhOVBLM2tkNCtUd3JuVkRTSzVDMHlaLzUvN1hRZEhlUWlTK0gvNTJy?=
 =?utf-8?B?Njk0YWxBdDFLLzB6dk1CR0pMSzhhdkt3ZXN3OCtTRVlKUGlpclJSbTZpU2FU?=
 =?utf-8?B?cUUxeVFDUUZTRTFJN1dLdUR2MEN1aEhpZEwvdkhZak5BVUF5UHB3UmpzOUxT?=
 =?utf-8?B?dzBXNGMzZWtCT0R2WSt5anNKUmlCZS9XTm9vbUovYWpHb3lMWDl0bjZZMHhE?=
 =?utf-8?B?ZkFJTEpZMXFkZW9WK0RRdzdlRVZOQ3ZnMm82STVON3B4cW1EazJaVm1rdWda?=
 =?utf-8?B?djM1cWtVWmNjRVhrS3czMHF5OWJpazR4L251L0JUMGRoL3BQRXdiOVBJNjJZ?=
 =?utf-8?B?cnFZcWpSeFVHSkxEeExUSEZYSWFVU2NiNkRHRURLNmVGencrdHdmZjZDOGd0?=
 =?utf-8?B?YmhOcU1NM0I5a29US2NWZXZHa0lZbWtkLzNidE9NNEZCKzdoZUNEcUZOSDRH?=
 =?utf-8?B?YWE5dlpTeUs3R1ZqdVJOaGRYa3NRWi8wRDNRaEdya05May9nSXJlUDBnTzlI?=
 =?utf-8?B?WUN4dm5wSVZnSWg4UGVaWXF0dWRkOHAxRVlBT2RrbVJlMyttUFh2bkErSUY3?=
 =?utf-8?B?eXd2L1dyUGM3WHAwTHNzdm1nYkl4TEl0TENWSmd6VXJKOFFlUzF6QVdtRDRv?=
 =?utf-8?B?ZGxNWEFOaTkxSnBsc09XSGxxRS9QYno4S1FUTkVEOG45eHBmMVhmUzNBU2Yr?=
 =?utf-8?B?dzJZOEIxQ1c4Mk83dlVBMjE3aXZJS2wyTk1uemZrMmRDZUNKdzFHNklDZGR6?=
 =?utf-8?B?MWpZVkcwMFFKTCtQY0lZRE9paW9vNSt3aUVLZGRoWk5ua2FEbVJEV2JLQnA2?=
 =?utf-8?B?NUgwQVdSTUIzSDBUMWlVUzJrb1pVRDZnWWJ2WURoYkpXOGZsekFqVis3WGxw?=
 =?utf-8?B?QmZFRjVycjF5eEx0T1lEdGd2VmtSN21CeEMvYmVteUdzajJJeWVuSDBxKzA0?=
 =?utf-8?B?cjhYTGVIVkZmVXdwZkU2SFFFTXFlS3o0Yk5rZmV6dWdxZU4rUEluVmZoVE05?=
 =?utf-8?B?ZmlTTmRLZzBNSnV4elQvc2xVZFVkVkpKMVh0cW1LY20rSUtrd1hMemF6OGU4?=
 =?utf-8?B?WklpMEVoUmFadE0wcURNd3JSaFF6aG0zMzlXdkVTdVZ6TmYrOUJGOEZoQzh6?=
 =?utf-8?B?Wnh6YytESDFDSWU5UnM5bTBmd2hIQnVqWWpNS3o5WmU1dXVhbDcrbXk0dXNh?=
 =?utf-8?B?VldQUWdUQzQ1ZU1BVFk5N0xaSS9HYldLWWcxeFd4MVhPTEIxVDN4cGhrVVNu?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bb4a40-3bca-4f2e-7435-08dcbb2ba6aa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 00:05:33.4972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUyt3SJRPOm2Fd8ZIxuf+V9x6ukNK5306mfSqStorjWJS/Hqm3e35Xw7/bcnLAAeWld0xD00OBbNHeSKNCrAZjbTQpjXLToFY3DF837gTwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6148
X-OriginatorOrg: intel.com

Hi Shuah,

On 8/12/24 3:49 PM, Shuah Khan wrote:
> On 8/9/24 02:45, Ilpo Järvinen wrote:
>> Adding Maciej.
>>
>> On Fri, 9 Aug 2024, Muhammad Usama Anjum wrote:
>>> On 8/9/24 12:23 PM, Ilpo Järvinen wrote:
>>>> On Fri, 9 Aug 2024, Muhammad Usama Anjum wrote:
>>>>
>>>>> This test doesn't have support for other architectures. Altough resctrl
>>>>> is supported on x86 and ARM, but arch_supports_noncont_cat() shows that
>>>>> only x86 for AMD and Intel are supported by the test.
>>>>
>>>> One does not follow from the other. arch_supports_noncont_cat() is only
>>>> small part of the tests so saying "This test" based on a small subset of
>>>> all tests is bogus. Also, I don't see any reason why ARCH_ARM could not be
>>>> added and arch_supports_noncont_cat() adapted accordingly.
>>> I'm not familiar with resctrl and the architectural part of it. Feel
>>> free to fix it and ignore this patch.
>>>
>>> If more things are missing than just adjusting
>>> arch_supports_noncont_cat(), the test should be turned off until proper
>>> support is added to the test.
>>>
>>>>> We get build
>>>>> errors when built for ARM and ARM64.
>>>>
>>>> As this seems the real reason, please quote any errors when you use them
>>>> as justification so it can be reviewed if the reasoning is sound or not.
>>>
>>>    CC       resctrl_tests
>>> In file included from resctrl.h:24,
>>>                   from cat_test.c:11:
>>> In function 'arch_supports_noncont_cat',
>>>      inlined from 'noncont_cat_run_test' at cat_test.c:323:6:
>>> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>>>     74 |         __asm__ __volatile__ ("cpuid\n\t"
>>>         \
>>>        |         ^~~~~~~
>>> cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
>>>    301 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>>>        |                 ^~~~~~~~~~~~~
>>> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>>>     74 |         __asm__ __volatile__ ("cpuid\n\t"
>>>         \
>>>        |         ^~~~~~~
>>> cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
>>>    303 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>>>        |                 ^~~~~~~~~~~~~
>>
>> Okay, so it's specific to lack of CPUID. This seems a kselftest common
>> level problem to me, since __cpuid_count() is provided in kselftest.h.
>>
>> Shuah (or others), what is the intended mechanism for selftests to know if
>> it can be used or not since as is, it's always defined?
> _cpuid_count() gets defined in ksefltest.h if it can't find it.
> 
> As the comment says both gcc and cland probide __cpuid_count()
> 
>    gcc cpuid.h provides __cpuid_count() since v4.4.
>    Clang/LLVM cpuid.h provides  __cpuid_count() since v3.4.0.
> 
>>
>> I see some Makefiles use compile testing a trivial program to decide whether
>> they build some x86_64 tests or not. Is that what should be done here too,
>> test if __cpuid_count() compiles or not (and then build some #ifdeffery
>> based on the result of that compile testing)?
>>
> 
> These build errors need to be fixed instead of restricting the build> 
> In some cases when the test can't be supported on an architecture then it is okay
> to suppress build. This is not a general solution to suppress build warnings

While there is an effort to support Arm in resctrl [1], this is not currently
the case and the resctrl selftests as a consequence only support x86 with
built-in assumptions that a test runs on either AMD or Intel. After the kernel gains support
for Arm more changes will be needed for the resctrl tests to support another architecture
so I do think the most appropriate change to address this build failure is to restrict
resctrl tests to x86.

> 
> I would recommend against adding suppress build code when it can be fixed.

I expect after resctrl fs obtains support for Arm the resctrl selftests can be
updated to support it with more fine grained architectural checks than a global
enable/disable needed at this time.

> 
> Let's investigate this problem to fix it properly. I don't see any arm and arm64
> maintainers and developers on this thread. It would be good to investigate to
> see if this can be fixed.

Reinette


[1] https://lore.kernel.org/lkml/20240802172853.22529-1-james.morse@arm.com/

