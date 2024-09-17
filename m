Return-Path: <linux-kselftest+bounces-18080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6890097B227
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 17:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3BFE1F2A409
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 15:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6903C17ADE3;
	Tue, 17 Sep 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4/+kUvO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5D3176FD3;
	Tue, 17 Sep 2024 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726587141; cv=fail; b=mzUgjgzrc4CcQWnlYQ9knRzNiLdM38da4WfL4vhtrrsAfXjXrxmeBCCu6E0eTKOm+y8yKj6eEIFiM4fhkg9vW4+y8uD4RhGwxvYgj0RT5Q1hKlU1oHwcHBtGVTXG265QSxOnz6qTu/zrWhOzU1QGicABkMzOasQFRq/2RG3EhCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726587141; c=relaxed/simple;
	bh=RIPKMd1HQPkfWcCOP5WmD+O0hCdStlEPahkBQEekQVQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VlAPOQ4pExL0JV40Tm39keTL9dBdF6H6VJ6a7pDgFb9zv3dafGv1vzeLsrjH3ky2p4XATGoB+CONIiWFc4vHrSYwVtj9K8AjUWMclR5TFw3Mj+p4NUEgCwNpSFE7xxinVr8Za7IAV8nxQ+/c73FLeoyxnQXjFqc5+Gg2syxHp84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4/+kUvO; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726587139; x=1758123139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RIPKMd1HQPkfWcCOP5WmD+O0hCdStlEPahkBQEekQVQ=;
  b=C4/+kUvOgbeSQkXTH4zOJh9nMA/cSJTBVLLHt3kPSJQMr8+z8qBK5DSt
   Sh4oFrUWRlXPx6sdq9RuqyZvTEryMM/NM1tprTLY7gvsMuD3zQz1fVbs6
   xp846xmH6N+i1GYIi9iovNdxUfLp8lK3VKwDWF36p3IISFWLWtG3zc/RR
   aDl3CpxSvKWCJjIDDSLosN5Qg+pxmyeDjESczGOjXMytxIa0LbdKruUOF
   k3G+gvVLwxKotApPpJuJV5/yrgoAUAhzox3tUHVyq3dWP1ZNnB0//OAC5
   qMyfCnhXOY0+Gmi0iFfPhK6XVgT6Dx9bDe1tvvKI/tN2M+KUVhFzTl9H4
   Q==;
X-CSE-ConnectionGUID: 8DD5WNXjQ/e8G6+09l858g==
X-CSE-MsgGUID: tuz5zAbMR7iA5e4hnpOXGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25392850"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="25392850"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 08:32:18 -0700
X-CSE-ConnectionGUID: ze/OLIxqSq+Jg3ruTmCBBg==
X-CSE-MsgGUID: 6T0x+it4RKu/Ie8upax9qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="100063434"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2024 08:32:18 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 17 Sep 2024 08:32:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 17 Sep 2024 08:32:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Sep 2024 08:32:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8n4nZ09HpxltNBwqtbrHcNqb9hIqmEDCA5H0QIJDFBtDvvOzdFcVDq7fNMXOdTzfob8u2/k/UdBDsx4gXaotZSFa75+G/vVVU8xs7IPuyHBEsb6aWxVrdbotlmLcYm4Zz3bDqV5RcPTI6OFzOUYOKKYd0XKRiIeTd5x4/YO+5x9Uduc/tjjBxx6IvAKhZoV+JDrYSWGenAdoZgBpmIP1s7+qU4oRxgKNHJ1oY9Y3N9Z7MP58Q85h0aNxCAkLnL6TRDUPuHkiV5I7kXFJzVcV7P3K9qFce4uqiTTUM8wrmxtzRkwYMFgVev7zjahX4P8yHsZ+jVlptZXO/ST12r7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLqaYYbflm2VTGucr4XURTmCxBkcq9cy8+pZfGAeBTI=;
 b=RakBIxZAMSyiGUe/d4sC5qOJX65gwuiPw+gmWKhVAuk34V0P3puzaUeQXA6AgaYaohlSH3VjClwKkt8piv7nRNvRAjI18G4Y4CPRObk5IgXk6D0RrEigPjbpE0vuZr3w+SOO0ExWtxqiyiziTB1MURpGkeQnOjeHNKPGoezo9mf57wTf6sZlph9RgCZq4K+re4ZJflrD0HHaES0cwUwG2z/Z6szaTYCb5z/RHAg7a2bXRGmUWjtAFwTSK5UGV47ixIRRQxXeLg1sL7+54PSKm/l7n0BdVwLeqSff+e5HnRsmtSBA255J3tMWc8ebzsxv4TvIAH57oy7FuDNN5Vjnsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB8739.namprd11.prod.outlook.com (2603:10b6:8:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 15:32:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Tue, 17 Sep 2024
 15:32:13 +0000
Message-ID: <7ccac5b3-cfba-4f31-804b-45da60b0c08f@intel.com>
Date: Tue, 17 Sep 2024 08:32:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] selftests/resctrl: Adjust SNC support messages
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1720774981.git.maciej.wieczor-retman@intel.com>
 <1fb2703ee27a0dfa13a7aa501b81439c433521ea.1720774981.git.maciej.wieczor-retman@intel.com>
 <2048036f-332b-49d1-a753-3653136d728c@intel.com>
 <zrcau5572lcuahcbntk6bcqh4dcin3jkcjeesvltz7zutriu3c@5v6puvyzayqc>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <zrcau5572lcuahcbntk6bcqh4dcin3jkcjeesvltz7zutriu3c@5v6puvyzayqc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0362.namprd04.prod.outlook.com
 (2603:10b6:303:81::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a2c489-7e0e-4355-10e6-08dcd72de6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTZLVmhwSkJuYkt4MzdBaEtheHRBSmZwTnZIeG51QS9aT21sNEtvbUtKZ2ZT?=
 =?utf-8?B?TWhxcktleDBaOGNVRzhtNitRVkVLMGE0UXZydWFMV3hBUkw1WGtpd1lscVVv?=
 =?utf-8?B?dEJyNU42emU4LytOSVFzYytJKzZYZmZOaTJobkJFU21HTmcva05LQ2I4Mm5j?=
 =?utf-8?B?YkZHOUI4K0ZjR0NWMFNUVGhuL3IvNHZUayszeGJRVHcwdTVJeXhISTNmakkv?=
 =?utf-8?B?NW01M0FjTHgyUmtPRUNjVk5nWU1Tekx5am5XY211aU5NNld0cHdpREdmM0x0?=
 =?utf-8?B?QnMzL2IwSTIwcFFybjFUeHk4TytjcWV3b1FxdVAzL3FLbE4rMVFJaitjTnRu?=
 =?utf-8?B?RjExSWVkQ3VTWVg5dlhHR01EeVNrRlBGRmFRUXdNcmVWWHo2b2dRNVVNYmRE?=
 =?utf-8?B?T2RKUnlGUVdRVWJUcnkzbEw0MTRwT1lyTWd5R0lldEtFUlE5UjJaVUI4ZSth?=
 =?utf-8?B?OEs2dW1uVFl2ODZLMUttVGJwdnBZUXVORHRELzJqVTJiWjlEU0s3RHZRZFRj?=
 =?utf-8?B?TjB4TnFpUXF5RENUSG1tRWprRWhQaCs3VWV3YkhpbnphTVZLeUR4cHpjVWVQ?=
 =?utf-8?B?ajhlQXNLNE1rRzRHMDcvUnIyZjRZT240NG9BZ01SRzVKYnJLNXN3MlNtUExG?=
 =?utf-8?B?ZWUxa29vdGorSk01SVFTd0pLRFJRenBUL2RRQk1wZmJod3lIK1N2OVh0NElB?=
 =?utf-8?B?aENZNDJJa0pIVS8xVjdTZE9Qb0RBR08ycEpkbktSQURuTTlPRC90NnNsMUdK?=
 =?utf-8?B?STQwYTlVQ1B1VWQwZGFVRFQwdEFZQU5ZZCtDWE1sZkxhVEplY0xKbHN2WlpP?=
 =?utf-8?B?eWpybjJncGFkOS9mclMwa2VqK3N6aHFNNGFzMG4zbXkzK0tIY2FNeGc4ZWNY?=
 =?utf-8?B?LzMrOEFMMk5ya212eDJuRVptci9EZ3dBMjI1ZE5GVEU3NXJ1RjNIUlJ4WStL?=
 =?utf-8?B?Z3VYUkwvb1dNdU9ONEVjR212S0UxcUI3MFNGT1BSQUVaenpkU0dEck9HVFhi?=
 =?utf-8?B?UEwyRHZuS3ZzRHh5RXpiN3czczMyY2lXTk14a0xBTThjWHVyUFVDblhpUmlq?=
 =?utf-8?B?Z0E0MWNSVS9hdU5iY0ZVU1FXU3BPRU5KRGdCR0xRMHFXRUVaVGJEUXIxR2dH?=
 =?utf-8?B?T2diOSs1dURQeG5wa2FZOGg3Z0pCcFdFSVd6T0FHV0tSM01XaGFIT0hZY1hn?=
 =?utf-8?B?eVFCWERrVE54VldPRHdvTGNzalgwak4zUnpLbm5URjFLUk5RK3FzcFFGZGZa?=
 =?utf-8?B?U1IySitPaitrZFgxRzJJRTRWOGYvWFkrdTY3SUYwSmVqbVNsbXBwbHo4enFE?=
 =?utf-8?B?N3JacUJrSGt5RnJaYnJzWGFXUHZGYnBJNTVMZzZkWFhVQ0pHZS9xQms3TThN?=
 =?utf-8?B?NG01SkxFbkZQQkM5KzRDN2dhRmd4RHNTZUZ0Q2pMU2pEK1M2M1pkZVJLOTNn?=
 =?utf-8?B?WXplT1A1bzIreTdIL21PZ0Y2cnpRbVREREx4Y0U2ZDBYM3NvczR3T3VCRFl2?=
 =?utf-8?B?NnFlRXF1c204UEZRR2xVYWtXK0UxSENJWVYwV2VGaTFWeHk5UFhGb3AwaWJq?=
 =?utf-8?B?cHl3SE43M0Nxa0w1UERKdHh3MTR4Z3B5L21TVml3dVFJc2VNaTAvd0IwaEtI?=
 =?utf-8?B?YjhpazRJQnJkNDNYTXBIL1JvN3dUN0xJUFBrZnBFYU5pb1htNmZGZzJYVHkz?=
 =?utf-8?B?VTl1Z3p5WmpQMC9NVnZVbWxJTlFGekhkNld4Q3JoeVFvMGdFbjUrRC9KTXNq?=
 =?utf-8?B?TnVLTm0yR0oxTzN1djhWNndDVmlweHgxbzBtRnRJMFpsQTRScGVqSUkzbDVG?=
 =?utf-8?B?SURjQ0tRWTlUMXk2dTN3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2ZzRGkwT2dPSnJkd0RPbW16Q2hZV0RkWXdDT2xRamxERkV5bCtRWDFKRmNU?=
 =?utf-8?B?dG0xZVZ1VlVqRWhLRmhwRGZZN1hWY09WUTBOdCtWSTBMUWlpV1ZhVE5OTFk3?=
 =?utf-8?B?U3J3NXZKMmtaK3dBSDkyS2N0LzJBV0JZZ3J5Z21QZ2xzVlB3cGRjWGhhS2Y2?=
 =?utf-8?B?Z2lIaUdIM29xcGlTMk5QSFVVVEd2bmxqQlA4RENkcmhQak1HbU4xekx1NUNv?=
 =?utf-8?B?Z0t2Zmw0Vk9kZ2RnQ1BuOVBrb1U1eFZXY1l4SDVUNkZhNXcxNncyVnpuc1JN?=
 =?utf-8?B?LytvK1Z2R0h3bU9JQTdIVnpLeFFZbEREWWJsNDByZEFIV05Ub0s0bHFaM2hK?=
 =?utf-8?B?QUhrSGtTOHgzRks1cFJEUEFxcitMb0J3bEtwWERWa3o4bzZtaC9MOXMzZHZL?=
 =?utf-8?B?bnlZazZ3NCt4eFpKZTVNdnAvbm1RWU5JaEdMTWJSOEFIR3JLeUZEak9oZjYx?=
 =?utf-8?B?UG1QQTFkVzQrMjBzY0YvYmdKQlMxeXNuUUdkYUt0a1hiWWUwT3RUT09ZVVNl?=
 =?utf-8?B?MkI5cmpaOGt2WDA5bjM2aHF1VzB0TWk3Tk1oZWdsMjBHT2VaQVVjQStSeko5?=
 =?utf-8?B?OCs2SXdKT2UzSGovL2dlUE1zb2xLMWNYZ1lBMVBKT0xxTk1OT3dsajd3cGRk?=
 =?utf-8?B?S29DRXFDS1BGRTdVL0ZKQjg5V0RmbjBYcVRpUUNHRU5qUFc1WkNiYzBzU0da?=
 =?utf-8?B?Rkh2b01WQktyaVVVMWlKRzlWT0dYTFF6T1IwMldYcEhLWC9menpIT21oSUtI?=
 =?utf-8?B?UGlvRUdkajl3NlpuNFFidC84NTBEMkhpTnR5N2l0SFd2ajVoV3VIaFFCWTRD?=
 =?utf-8?B?UWlyeU9LNXd5eDlGZ2pid2JYdURRWUtKUlhIdStJZkVadmREUHd3WVgxRlda?=
 =?utf-8?B?bEdIUCt6Z2NFUE16UGYwZU51UGZCT3I1UVJUQi9MVDlMNnVDWE1hcmVlYzhQ?=
 =?utf-8?B?T3hDYU5KMjdUWDNZa2taVUc3alN3T3JZODUzbzVpMEV0dXIxTG9wT21WSkQ5?=
 =?utf-8?B?QmpGQU1aOU4zNjZmUE1uaFM5VllWTG1oYnp6RkJneXk5RjFVTTZpUWJpUmN2?=
 =?utf-8?B?RmxqTTgwV2tSeXNJTHY4eTRaTWxaQy9uWFJXemJoVUg5cnFjMldKMFdiM2o4?=
 =?utf-8?B?RmUrM1BwUEhaa3RuQXFLV09EY1ZYZkN5TFNlRUlNbjFMdlVzcW94Zm1qQldn?=
 =?utf-8?B?RWQ4TEFTUE9aNkVXV0oreHdTTlFUNTFMNmYxMUMvV3RjQkJpR0g3MzdEL3FR?=
 =?utf-8?B?eFhRK1YxblMvYTE5S2l4SERBZGU4aTNFWFlqT1JFRXhyQ21aa1d5bkZjd0Jo?=
 =?utf-8?B?bFZ5MzJJanRtazdTa0NmN1FUNnNiNkFObW8weG5Cb0xYOEZpMGVMQy9Kd3B4?=
 =?utf-8?B?ckNTazF1bzRzMnhXbnJIZkVCV2F6SzBVTGxISVZTbHVCcWFjOUpEc2dCWi9y?=
 =?utf-8?B?Z2NEd3FFRFVYVENja2ZGNGRQbkNtdzk5eTBHMm96V2N2enpXMzl2S3d3clZJ?=
 =?utf-8?B?VG5KdjhralpUallNaW0vQlVhR0o1NXBPdlQ5aXh3YVU1dXlpSWxjTGxvbnhh?=
 =?utf-8?B?d0k4S0FBVkFoLzdPSExIdlh0Yng2MlNGbkdmZGFOaGZiYW5YTUFKUm83MTZa?=
 =?utf-8?B?b1B6YktObGN0MjFCWlRXVEprWnBhWmJHT3gyaWVCVzI0NCtqNzd3S2VsVmEy?=
 =?utf-8?B?VzFQWnNvZDhyUEQxK1N3eTFGQWp0clJIU1VlTkdqcmRSbEZtaS9MZEVWd2Fz?=
 =?utf-8?B?ZXVHT2VqN2lWVTMxV3ZJNkRleU9EdWtaUVVESlk4TCt4SnpCOGxMU1BLL05q?=
 =?utf-8?B?bVJzUjNNVHJHVGtXLzRXS05sSTdXRUt3Qkc2ejJ5TFRzRlNtcDBzSVUxam1V?=
 =?utf-8?B?N2NKTWpEU0pTSzZLa1g2M2FYU3JPcS84bGdMbVRIR1pzWm4yQm5VZThROTE5?=
 =?utf-8?B?Vm5wYXYvcitobFpkSExsYzhSdmFzRnFLRmU1Z0JEMHFraEVWVEF3Wno4bHdO?=
 =?utf-8?B?VWdqSEM2OE9MSkIwMnRCRTBhUnRtakMrRUQ4OVQrM091MEV0dEJLdFUzbGg3?=
 =?utf-8?B?YmpYRGdGK3FaTi9ZYnlnMGhIcGJCU3Rtb0l5UEdiaktFaXRBQ2FWSUVQT2VE?=
 =?utf-8?B?Wmh1QVlTdk4wSWY2LzhPU0pQaTJ2aThIRldzamF0d3F3QnVULzFPS3dCL0Zr?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a2c489-7e0e-4355-10e6-08dcd72de6f6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 15:32:13.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Wsu2dZKKwYJLd8WjH+ulEUrQbJcdETzE43USf7OmmMjUc6KYD5udopIyLt4sB4ioZfy0dAnEZARkWGAsON4590CnJp2WpeniedeRq/bRdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8739
X-OriginatorOrg: intel.com

Hi Maciej,

On 8/27/24 1:15 AM, Maciej Wieczor-Retman wrote:
> On 2024-08-12 at 16:40:10 -0700, Reinette Chatre wrote:
>> On 7/12/24 2:04 AM, Maciej Wieczor-Retman wrote:

>>> +
>>> +	if ((get_vendor() == ARCH_INTEL) && snc_unreliable) {
>>> +		ksft_print_msg("Sub-NUMA Clustering could not be detected properly (see earlier messages for details).\n");
>>> +		ksft_print_msg("Intel CAT may be inaccurate.\n");
>>> +	}
>>
>> This is still relevant but unclear why previous message checked "ret" but above does not.
> 
> The above check tries to explain why a failure happened.
> 
> This check is a reminder about a false positive - the test passes but
> "snc_unreliable" was set. I guess we could make this check to test "!ret"?

Thinking about this more ... if the test results cannot be trusted at all (whether tests pass or
fail) when snc_reliable is true then it seems more appropriate to just skip these tests when
SNC detection is unreliable.

> 
>>
>>> +
>>>    	return ret;
>>>    }
>>> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
>>> index 0c045080d808..471e134face0 100644
>>> --- a/tools/testing/selftests/resctrl/cmt_test.c
>>> +++ b/tools/testing/selftests/resctrl/cmt_test.c
>>> @@ -175,8 +175,14 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
>>>    		goto out;
>>>    	ret = check_results(&param, span, n);
>>> -	if (ret && (get_vendor() == ARCH_INTEL))
>>> -		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
>>> +	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
>>> +		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
>>> +
>>> +	if ((get_vendor() == ARCH_INTEL) && snc_unreliable) {
>>> +		ksft_print_msg("Sub-NUMA Clustering could not be detected properly (see earlier messages for details).\n");
>>> +		ksft_print_msg("Intel CMT may be inaccurate.\n");
>>> +	}
>>> +
>>
>> CMT may be inaccurate in both scenarios (no kernel support or unreliable detection). Why only
>> check "ret" in case there is no kernel support?
> 
> I guess the same thing from above can apply here? Test "!ret"? Perhaps then make
> this check into "else if ()" instead of just "if" since they will be exclusive?
> 
>>
>>>    out:
>>>    	free(span_str);
>>> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
>>> index ab8496a4925b..a805c14fe04b 100644
>>> --- a/tools/testing/selftests/resctrl/mba_test.c
>>> +++ b/tools/testing/selftests/resctrl/mba_test.c
>>> @@ -179,6 +179,13 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
>>>    		return ret;
>>>    	ret = check_results();
>>> +	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
>>> +		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
>>> +
>>> +	if ((get_vendor() == ARCH_INTEL) && snc_unreliable) {
>>> +		ksft_print_msg("Sub-NUMA Clustering could not be detected properly (see earlier messages for details).\n");
>>> +		ksft_print_msg("Intel MBA may be inaccurate.\n");
>>> +	}
>>
>> As I understand there is no change to MBA when SNC is enabled. These additions thus seem unnecessary.
> 
> I just rechecked by installing 6.9 kernel (no SNC kernel support) and using this
> series selftest. MBA seems to fail in these conditions. I think it is because
> MBA pulls values from resctrl and from iMC and then compares them. My guess is
> that iMC works on the halved cache while resctrl (without new SNC support) uses
> the whole cache. Here is the log from the MBA test I did:

Apologies, yes, while MBA is not impacted by SNC the MBA selftest relies on
MBM that is impacted by SNC.

Reinette


