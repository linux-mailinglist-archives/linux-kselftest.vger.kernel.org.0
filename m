Return-Path: <linux-kselftest+bounces-10841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267248D3D90
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 19:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F51286E61
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C23215CD6E;
	Wed, 29 May 2024 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ev+kyWiG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C450615CD46;
	Wed, 29 May 2024 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004612; cv=fail; b=HLFxbfbtWXYDfbKbfH8z4wTOATVwSHVpETsTPt7H+vJJ262FiyhpxOIKfQ2o6jYl2OWevqfGbyF9EqlZeN9nYhK5cK5gsUsyRblWpl3pafpcuylUBuCqreP+dsrf4Vc/V33nkdN6G7/X7QL9OHO5qjUcKOK4FFz3JmXJ3CkR54c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004612; c=relaxed/simple;
	bh=Ziflq2Szhb9e5nyeJef6hAH+Zd/8n892jVEgOWJBHFA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nLaoHgQzkSGkhNpDI8Qc95B87bydOB3Ax8GCNIetNYlMmhww6S9Txcngw9pPCtBt30wbUUHUj0cRCYDkZPu8Ridks0YpqbMrRNMuo+08/BRA4iDGhO2WhNeqtJVjA2xMWtaFCkMumqe0hISxZxmP9RwbWnIYW1yfMQYhFKTfNrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ev+kyWiG; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717004611; x=1748540611;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ziflq2Szhb9e5nyeJef6hAH+Zd/8n892jVEgOWJBHFA=;
  b=Ev+kyWiGFWFTv2E3d9DTDirFxTF1WqiBbtn1YHYt3PFVcbdboF3Q/uiX
   nke5+nqT3ENtDPygHHaWQkDPn6zKoPP9sJ5Fm20J1gsgNEPpIVdoOEaKZ
   HXxtYDOGHijDEnXKYr4DPGjz0AQZghWVrZTljcm/F4JZ1aB/xPa95R5CM
   XYqWMBFB96L7GZGdmkxVkSgFHOG9rgxQaFAw6JppjWYRZraV10mLz/uHC
   /+bPAIjllmry/KzJ8h2DCVDpp626/N4P+uwLfIAz6uLfDHH9CQQnMlSD7
   lnIsjDFybsuZP6635FDFnhy5M7yVVG/LJ/qcAlJE4+8S4WDuOxt2BBLz1
   g==;
X-CSE-ConnectionGUID: /VBgm7DlTcmeJduxRBeCRQ==
X-CSE-MsgGUID: 7rPFiWrbTpCB/RjWgaol9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13202395"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13202395"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 10:43:30 -0700
X-CSE-ConnectionGUID: JB5HpqiTQm2n0gEWeD+GZg==
X-CSE-MsgGUID: o9M8o8TjQdmyNPIMdpTkWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="40414831"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 10:43:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:43:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:43:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 10:43:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:43:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSl3GhF2xMOkWfgGdzv3V0D9ZniFFj/QT/wGKd7ivv8xqYL2LvRYLcMWRYDGlNk/W1SXZfDaOWVvR7q3KoACOvaC2H77euo9Be0m62cAenz94Sn6Iyv8UMy02EkuPaJdSPnXgP/ZzCVCuhUTbOC/t/yU0BLW9WLS1Sk3sWzK/mcqNXCwkPSXixqsj9C7qzwoOe4tZ5uZWRpxbSFeY+hUfeeIafTe0bUMxLqUPRZ0uBayXjTxheBaowRZCrMoGdSULEigMA102UGsaA9Sy0zNmPtwjLw+VAhNOM19+cR2HN6Sd9Y8TqDntXfhifdlXnMa66qUyKNH5OhEBr2q0aAilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11/KEKHyFL7EpDHb3zIwsr1lUQY9f36xU4GX4MyP/qg=;
 b=QqiZu/U8h1AxCTx/nfwH+n7xd6r+WmNokG2a0r9c1m/w6FebMDbsikUJmAhBrc048pNzz1swKzWfvbr7wMg2SF3PEbP05EZOgE0UhZE6v9bOq+XA+qsbRERf4rg+mKYpoMV0n1k1FmT7prCVWGCoy6XKyE8Thm2DJUS8fv4yroxzED5BccHYXEFDhw1VcsHk77harU/ns3vS1Cl0Ik3BCloUFcgAE9x7OqBsf3fRm8zYSUIOaAwl4Hw97Kumccu7f92kcQwh2GzV/chGm1gj8ZpgwC12zfiatC4XlZS0UgX1T+MUTuRyADOfeZXMdUPKQb/6MOKet4hQ+X1zN9/6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 29 May
 2024 17:43:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 17:43:25 +0000
Message-ID: <0e931356-abde-4118-94cc-6905f409cf95@intel.com>
Date: Wed, 29 May 2024 10:43:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/16] selftests/resctrl: Consolidate get_domain_id()
 into resctrl_val()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-5-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240520123020.18938-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:303:dc::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: bae612c5-f9c3-4012-beb5-08dc8006d767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3lBTU9KeFNpSmJXZTRLTG40bjlwSVFIcEJ3SlRVSzVacThLUWdPNGRmU2NX?=
 =?utf-8?B?QTNFSDYrUThzamtyN2N3TXNuNVFYWEl4clEwNUFwTXNhbEhsTHJvakRZNGFy?=
 =?utf-8?B?L1NmSWNpY21FWG5QdlZYam9oS1d5NFBrMTBFa29XMmZJNkJWd21qY1c1d0JD?=
 =?utf-8?B?Y2FCSzZlazdabG9SSk5iU0tDS2hQV3JHcGl1QzhZc3kySkpCdkEvcmE0a1Y5?=
 =?utf-8?B?RjJGUzMrblFwWHVYM0tGSVRoZml0UXN4cDBjdWlYcytpWWNSd0ZaK2tuMHRD?=
 =?utf-8?B?TDZXdVd5aGNpMFZFWUgzV2VKd1hwbTFMRjBNR0JsaGdGU0RTdExMMHpDWndB?=
 =?utf-8?B?bEJ4cG5CVkQvNkgzRHJFdG03azJOQ0JVOTBMZDY4ZDhMVDRiYWxlak8vOGhR?=
 =?utf-8?B?dHhHUC9PbWErbzJFbDMzSkl2ZkY3bzJtdVI5enN6OEhFeHBkRW5kUkVJUXBJ?=
 =?utf-8?B?OGFYVmE1RmhGbUtFc3lMdjUxVHo2ZEpDQ2xNNVRVcTFtTkRGN1k0S2lTa1Av?=
 =?utf-8?B?NWdDeEQwbnBEaHhaQ013cEdYYlN3WVoyeDhubzR5Vjc4NWhVV3hHbW9NbEd3?=
 =?utf-8?B?czZxQzJqSG01cFA3S29jT2xxL1g3NDFUdXpKVWMyZENPMDJIRXJXUXhUOG5h?=
 =?utf-8?B?N1dmenlxa1ZXalUzRENpa3JTVzdPUjl4ZmhKU3VQNDhFcnJFai9VTEVBOXBH?=
 =?utf-8?B?V3E4YlFoSlo0T0N6MHpDTmlvSk9xQ2pRcGpVNDZBU09GcDQ5SUlTWE00Yjkx?=
 =?utf-8?B?U3dCck9adzQvNlM1WEo4NlF2QzBNaFZwMDA5c0U3UHMxemhWd251NDVFVlFL?=
 =?utf-8?B?WGNsN0NaalhWcUVuMkdZdnR1NVZBU2JqdWNKYnc3R3FJZkRleWZOdVRzWVdy?=
 =?utf-8?B?MjE1VzVLS1pPQVF4NlNSVTd0bjlWd3p0T0gzaldoVk8wSEZuWXZPS3lhMGY1?=
 =?utf-8?B?bjk4TEVIRy9laGFaZENzNFdZdWU3UURLbEFyUGRIU3BDWkU0dW81Q2ZjbkVl?=
 =?utf-8?B?dHgzMEFkYWVFeVBOS3VvOGZNQVlGWjMwMms3bXlmdGw4TnNrbHRUMHVUTit1?=
 =?utf-8?B?U0hzNys1NGl6YWYyMDhXV2R2WTBTTVhBUFZCMEVOYWhCZXplZVR5b1JjY0k0?=
 =?utf-8?B?ZzZFa3oraDNrK1BEc3krV2kvdFJjZEYxTUh4U0s5bGQwekdPNWUxYjVJaEdS?=
 =?utf-8?B?YkllRUhyNDB5bU5kYTFLdkFEM2tCTDVlY2NiK1BhdUJIZTZTMnJQUm01eElE?=
 =?utf-8?B?OXg2L3IxUk5uamFpVDJ4MXZXckowRmZVZXF3ektJbUtMVmIrQjNFMlBlaWZD?=
 =?utf-8?B?Z3NMcXVWdnVtYU1mdEQ1elNrYVhCZUVyZk40OVFjOVpXRGNnbFZXK3FTSzJC?=
 =?utf-8?B?Slh1YmRTZHVZVkpKTFlxc0RNblhkeVpLZVBpMkNZUHF5cE9UdTJ5Zm01UzlI?=
 =?utf-8?B?WjZLOVdmazliMTZtaEhMaXhSWlNudU0zM0w2K21yZWQ2R0Fjb3FrdEVRN21D?=
 =?utf-8?B?LzRBQU5xUm0rK1k1V0U1VERMWGhreU5zQWxRbVd4KzVNS3lnaUo3L3pyc2Z5?=
 =?utf-8?B?bDVjcU1RQmMvQW44T0hMMy9MZGVJd1FhN2laRU1CZk9YcFhURCtJRllGQVJi?=
 =?utf-8?B?dUtRazBPMk00Z2dueC9lcCszL1FWSFppTFI4SWU1RGRRTVE0ZXFVeGhwaFYy?=
 =?utf-8?B?STBoMkF2N1FkeGZ5Z29xa0dOUTI3ZUYzOTRxaURDa3FDR3NxT1RzUzBRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFNmd1ErNUtGQzRiMi9rNXJWN0JnOTBKbFRBbWJSaVRDTFlnNCtWMDV4MnJF?=
 =?utf-8?B?cUxqOWtJZ0RObjRUNVFaRmxPaDZyTVBCOTRkdDJHcHp4THczazdwbDAwMmlC?=
 =?utf-8?B?WUlaSFFNeFVsNURJV3R2b3Q2eEsyanFKV3pMc2NNNnVwN0x0dk9pNVVjVVM3?=
 =?utf-8?B?c2tMaDNMYWxPMUFrNTVOYTNJY2F6QkoyUUJYaTBCV3BIbnZBSnRwSzRIdlNw?=
 =?utf-8?B?N1JKTnRjbnZpQUxOMGRjVisyK3BoV3NpNThaT2ZKZGF1eDJ6RlpGMEFQSzJH?=
 =?utf-8?B?UXJpYlpqT1lJSUF4T1BaSlFaYmpYb3RMMmo5V0V6ZjBQZGxGa0puUVYyczFz?=
 =?utf-8?B?VUpZL3VubTV1aC9MRGRsK0pEMWxrM1Y3a3lpSUZ6WnU2MjVIRE5SSG1paEpl?=
 =?utf-8?B?ajRpTjduZVJleHd5QkVzMktYT2FWQ3RTd1QwdEhheEVmR1pvdUxUOGllVit6?=
 =?utf-8?B?NldHTVJ6MDNzaFBNZGtpK3FNTlhjajlKOGxQNmUrdm0xd0ttQysrQndKMWJL?=
 =?utf-8?B?U3A3Ni9WODU2WDBZMjFwL3hFY2IwN2pUb2FwanZ4RXhFUklzM1Z1K0RBNWxB?=
 =?utf-8?B?Ym56SUZaOThRWkwwMmRLR0daRkVxcEZ6VTBlcTUxR0NjMUZ3dmttdks0aE9q?=
 =?utf-8?B?T2dxMzUxcVJSQnlUUHdCNG9FV1BNejB0c1IvMjZUL01DZ1F4b2ZDanFmVjg5?=
 =?utf-8?B?NTQ1Yzd3cnphcW8ySVZwckZiM3NnT3Z2OEs5S01zdFZsWTNOeVIyVTFFYzNs?=
 =?utf-8?B?MjQzaVFLOHhicTBIODI4VHJOQW1HWjRWMmZ4STRZckc0SzZvcHFEc1k3dHd0?=
 =?utf-8?B?VytyazJBRGs3elllenMrSU1YeE42ZWVBUTVVQ0FEZCt6SExuL2dWVXRZRjN4?=
 =?utf-8?B?OGIyMzdYVlJFVVM5WG83L3kxZ0UwWGhyaktFVTlwbmF6cExzdE9uZlp4Rkx6?=
 =?utf-8?B?SGI5c3ZLMzdHaFcrVE10Tms1UzJEdTUwTzFRbyt2Nk45MXVQY2FDY2VZZDdK?=
 =?utf-8?B?dkQ4bUtUVi90VU9XNGRJeS9hSXJrdUtoeTN3RWNoNStjN3ExdzhMZWpiN2VP?=
 =?utf-8?B?TS9nN0U4VVphVUp5NlEraXVRRkJJZVBMZno5QXdUMmtab1B6Z0s1WjYyU05r?=
 =?utf-8?B?bzducmM0RVZqNmRMUHl4MG0xQ3BkQXRtYWxLaFVDSkJob0daS0J3ZDlWbU1h?=
 =?utf-8?B?dkRpMThHbzVOenZhSU1kblhKY3Zqcks1SjFuRG82YVNKQUUyZkhUeUZNWlg1?=
 =?utf-8?B?Q1RTdE9WWk5ZdTZFN3JudVIrVTUvOHlEcktuN09LN3hjeVNXMVpHcnN4TWJW?=
 =?utf-8?B?N3ZTZ2VXaXFSVkQySFBEM1NXMFR0dFN5bkViMTdWWlpyc3hVaFZQYlNwejRH?=
 =?utf-8?B?NS9GM0hHZWhldDVKMzhyWTVqR2NGYUptR3ZYWEs3TDdWbHZjTk9aaHpNOHpo?=
 =?utf-8?B?ODVESXlmK3MzdXZnTFU2bXRDSXZSa0NCOGNHUnVZYmxIbjE0WVdTRnZRYnNR?=
 =?utf-8?B?UyttSXJtaGhNeXBmUkFSYVVDaVZpNmpVTmNSSEJwcEZnMFkvclFrOGFGVjBz?=
 =?utf-8?B?c0F2THlOU0d1d3Z3TVMrdFQ5Y3hJTG9zWUdNQVFpdlFsaURja1RudTB0TUpC?=
 =?utf-8?B?UThyVWJTeVBxaVgvNG1XVTd6eDNGbm1PVlNjejVuTDJQay9jNm1scFZUWUt2?=
 =?utf-8?B?RUx6NFVZOFZMNGJMdDY0dlRWU2dLRGE2Z1VRbzZIR0pSQ2FBTmdCTVpFaHM2?=
 =?utf-8?B?a0swOENCOEh0UktLSTZmVENCWitvL2RSMUp6a2c2M2U0S01RTlh1NlVIOGF0?=
 =?utf-8?B?RGthL0NGQnErbFBxNWFrK1pJdStteGJ0TjU2SmMxT0dyS25iMmVxeElQa3ND?=
 =?utf-8?B?bnJlTkJ6Q1ArQUtiTDVqTk1HOE5JeUlydG5MblZlbmZURjBlSmhoeVNna0Fi?=
 =?utf-8?B?UEc5RkVVNFN1bFlPYkdrVFpBMEdDVklMRXVCRmloS3l2YXNTVXg2NkFhZE9O?=
 =?utf-8?B?dVJ4VHRyUFZmZ01Tc0h2Q2ROc2N6Y2NtZjYzeXRMS0NlZXN2SHNub0hORzNK?=
 =?utf-8?B?Qm8vaUxrWFkvVjVEOFltNW9TQTNnTGk2aVVNNnlrRE4wYlVMWEdkeU03cmpk?=
 =?utf-8?B?ZEUrdEZXNURlSGxTSUhqQWpZN3BUMUlnUHAwa05uTVBielRUa3c4bEt5Z1FX?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bae612c5-f9c3-4012-beb5-08dc8006d767
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:43:25.3049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtIGQ/2vuL2pCh/wZVu2HGUdSMfWbPN+iP1gD3MBmup79Om9wR9Gt3in2KQAK6cdWqO00Ekt2h5Xo8ePjKPgADiu8oCETMOsquOwR5qK+Dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7378
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
> Both initialize_mem_bw_resctrl() and initialize_llc_occu_resctrl() that
> are called from resctrl_val() need to determine domain ID to construct
> resctrl fs related paths. Both functions do it by taking CPU ID which
> neither needs for any other purpose than determining the domain ID.
> 
> Consolidate determining the domain ID into resctrl_val() and pass the
> domain ID instead of CPU ID to initialize_mem_bw_resctrl() and
> initialize_llc_occu_resctrl().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

