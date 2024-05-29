Return-Path: <linux-kselftest+bounces-10843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1308D3D94
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 19:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C1F286E45
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 17:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267701607AA;
	Wed, 29 May 2024 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SS7tKEpW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9838C1607BA;
	Wed, 29 May 2024 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004672; cv=fail; b=J4dTh32zr3Q4mrJ6pEFemN5ZB1OKtbcn1ymCo0NYpch/fpnCAtHvzY5NAa/V0+Zs78dmDzA5BvC8NYwbDuaJOgih+hp5s4HCbXUiXwVzzK6EOyaAuSfiLR7Ly8GTcfmAfz+8qsn8n5lGulIeannn5WZWFg7oKSPcSFgDu6SBVjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004672; c=relaxed/simple;
	bh=OvFebMW/ol0ioNOgaz0C/P8hP3e67Al40Ypks7mAkyo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ExpbCpfhp8h4eaS2uf5SquI18D0vFrhaGK8VFNgQzB9nSMJEHmAWY77lnEo8ZsyCW2K0Qfoel5MnPs3vluDfMn2bAm8jsX7QVCeKgr6ym88Q0PjVwIDInoanIPEsyqzPcu+tdmY8l5+IvW/JYcecoR71K+Np9LYvcjisFfeG4Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SS7tKEpW; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717004671; x=1748540671;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OvFebMW/ol0ioNOgaz0C/P8hP3e67Al40Ypks7mAkyo=;
  b=SS7tKEpWhlkfH4h2cqOzoJVhOSIFaTTcrQqo7ACq1axxUQbI5WxRjfyX
   03eOPRHejuxWtClC/zL352XeikBFMAv3eUqXsJVNDJKqfJZhPpTO3kDFe
   gK6I76uD1/w9JRCbC4K8mCcOOffms/zxG69yeKSbcaMOxgAfN1h0dJu1b
   7YcQxMSRmYwekE7lzYlx4oRrkJSW/mNawWRsdNULIj/nMtQlMhnZzjhNt
   +qZXkheLlOLQvL+CVxj0PFQzhYRjyxgS3TNC7DLiViufy75PUny79Onev
   gaI1LDwvYHw+CtiyxS5yCpYWH4JVZHV8rfbmmugrCEwagBYhgNrSG2AXo
   w==;
X-CSE-ConnectionGUID: k4C3R0GUQMKF9jVbwablnQ==
X-CSE-MsgGUID: UYpNDe/YTi66ciEykY5pMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="16377458"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="16377458"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 10:44:25 -0700
X-CSE-ConnectionGUID: F094YCX5SFWAhtWbgx5QEA==
X-CSE-MsgGUID: H4RAI50lQEO1zFkiErq2EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="66392050"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 10:44:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:44:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:44:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 10:44:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:44:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfaVT56EfknTjhFYJTYILMxA8dHoa7hf5s6hVpQuOYVvOIDL7hdYC8Ntg6v1+o8Tr8gE4crdNUukO9rV8/OKWV1wanlUJry4doMxgIYRH8GMyhIG5DfH9IGG3jT4cERaWDsB2jJjDXw/d8tQDuyXdP5+hAjGP+lRATLInBYXvXcP0OpYasog+eUFMEpDX/T7U0XJDXvIZH1+w4V6w9YpEDQY6TOltQFdJ7rFYlGOBu8LKHu6q3zEMC6x9hnNCTUTEIO1xxxYuvR36Ymjn7BZdjprpD7tGIlyq9F60/D3uB3403qNnpU+13adBuBeEenykZg0m9ScwS5UoFV3gw2QDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UP/TR3rqin1TsYbtew0E6mfJRbGt1A8YPlWmqfOSJI0=;
 b=mfBEDIYse3lwdtvQFj37FXqACfIWbA9e51ViOu5MiYYnwchKhQlZcARyoSgcfQeLsa+tkiit1kxn1NytYA5dcKOgGCOvlS9nBCWEPPO8DmCNmeYJNCmcMguNVux7IFE+ITl43IH8it5wbM2H84FFLzH89BZpkzdZM/FJOXgOvyLMGubykfSwBWH/GlwgEa0P7jGs1wvDqQv6LFAqJjb1Idnoc28CEm2C8u8WQMM9mdDZNeLjnw21h60McOp0RzLUARQ+SQ2dcsg/aardNB31LMYfEpRTSxU5lSE8rpYDkbxQBsNp4rBAdq0+wb6Dxt1rgZFZymB9cw3x0VOkFa/QQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7854.namprd11.prod.outlook.com (2603:10b6:208:3f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 17:44:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 17:44:20 +0000
Message-ID: <8b437845-8132-40e6-b442-1b85e5b8aae6@intel.com>
Date: Wed, 29 May 2024 10:44:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/16] selftests/resctrl: Cleanup bm_pid and ppid usage
 & limit scope
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-7-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240520123020.18938-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:303:6a::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: d93be2a7-7bcf-44e5-ee93-08dc8006f887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGR6TnBGMXlQRVJTdWlpR0J1L1V1T1F1azR1Qm5GUTM4aVh2VGZPOUpFT2gw?=
 =?utf-8?B?OE1QQ3pTTm0vdjYrY3plbkZHVExNNGNBWHZzejVrSG0xTXFjU2x5c004eVgy?=
 =?utf-8?B?MEZ6YWRtUERXVDF2YkJzZmxVYjhXQkVEd3FTVmY3NWRpNXlkdXBsTmZtbkJ0?=
 =?utf-8?B?UlBsMFhxeFZEWE54MmdpM2JodDQzazBmaWttNWRjOUw0d3c5a2E4WHBLL2Vv?=
 =?utf-8?B?NE4za2s4R2c0cDZYa09qZ081NDQwM2NlanU5cHUveHM5dHZEQ1NIMXZ5bEJT?=
 =?utf-8?B?a2g1emE1aDQyN2NpMTVGN2c5QlpMN3R2dVRxcWhvM2IvTFZ5aHFRMFF6L2hL?=
 =?utf-8?B?WFlVYjgydThMdzdGQklOUGRzTUhxckFYVGI1em0yUy9nRjQzSzVqVExhd1d3?=
 =?utf-8?B?VzJuSEVHZzFrczQ4NlFYbEdIa0tVR1g3UG9NcHQ5R1dqbjdtMWlFSTkrYjBn?=
 =?utf-8?B?czRTanREY3FES0NyWmhQVm44emtGc0Z5UHhvMlA3T0ZnMDNsSVZ2bWxLbGlX?=
 =?utf-8?B?MkljY29pUG50M2h3ZURTaTVVVEM3WDJyWE1lMmxxZ3hORzFhKzBoaVhpV2M2?=
 =?utf-8?B?NnpsYlExOHVnMlY2dVJERFh0Y3lqOW9rR1hTUnVobkt0cmFRREhtbG50MkFw?=
 =?utf-8?B?K2JCUDIwUmxiSGREOXpvTXlPelFFUElJejg1V25SejZIcGFPSEowQWp5Uk1S?=
 =?utf-8?B?anNhdW51cExISjhTdUt3NGMyTStHRDkyaG1TNjd5VGQvaFA0U05CRDd2a1Yy?=
 =?utf-8?B?ZzVpYW5XZjc1bTgwZGFvSHIzSnlCZDdZa0E0a2tDYTh5R3FnVk8xeGZ1ajc2?=
 =?utf-8?B?bUx4ckxWSkgrQWxPOEdVUGNoOHVVcWVIaWxvejFaZG96eXdLb3B2M3pObjlm?=
 =?utf-8?B?Tm1lMVhHa2NOQnVSN3dJQWdUdnN6Sjg5czBZd3ZqUHh1S3VWeDkzQzgydzB2?=
 =?utf-8?B?L1lWMVY1dHNNTXo5VzBuZ05NRkJBWnVuWHZvWURBVURlWVErQ0wwdGkyc1d6?=
 =?utf-8?B?T3c1MlpTZW1vcnhWVVJ1THNzZGtkdmZ2eitHc2N3VEtxaVZJMXdLR0w5dHZX?=
 =?utf-8?B?TlBwUW43cW5TQkdDK0hMdEJ5ZXdIY0d6dHRQdXErVkpTWmJ2UjZlU1lCSWlh?=
 =?utf-8?B?TndRZEVkeFlUcWsxdThqMHJLbmkyTERTTHlGSHhkRm5nb1IzZVdKcWFheEdB?=
 =?utf-8?B?VUgwNWx1L0hiT2xScyt4VHpNbEt3cUZsK0ZvTHNVYU8wemhUMERKNmFTY0RD?=
 =?utf-8?B?L2dlLzZQY1pXRERkb0oyZC9xSzVvUHkwOG5FU0FoS1M3bWhyL0JnNmp6OHJZ?=
 =?utf-8?B?L1I3S2ZaQXVvU2E5RGJ2MWw0WFBNWTV2c293SXFhSktONTArYytsRmtkU0Ex?=
 =?utf-8?B?Y2xUWXdrV0Ixb0pXS2hUZG11YnFVWm01VFREeEZwRGxVdmhSa1pxQThwTmdm?=
 =?utf-8?B?ekFhWHYrUW5xbUJWMG9Md0dTd2MzZVROQVlKNXFucFVLWkhnUnRneDhoVG9X?=
 =?utf-8?B?WDVXSlVKTG5jYTZhU1E4RTQrSFV0VENncWVnMlV2cTNYSVB0T2RETWlYSXhN?=
 =?utf-8?B?bFljTUY4QXZONTdOdXgzbVpSejBZTHUwR0xZTVlDcWpMcmRjbTNmUndqQzYx?=
 =?utf-8?B?WUc1WTBsM2dlZ2JpWXVwZUxEVU9zdUl1RVhzRTFJWEQzTnJUckg0SjlzVW9u?=
 =?utf-8?B?QjM2VTFMTVhwOU5VSXJnSi9QWTh3NXd3Yzl2UjVIVEV5U2g0T1V4blJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGVTRGFtbE9rSGxiRkNOVFZkcGFIQmFRL1N4Qkt5empZVDVSNEhmd3BZY2NU?=
 =?utf-8?B?WU95RU16dEJPRmxpR2RJL1lSMFFxd0prbE9BdkxTN08zb1IyLzFLNTB4WXdx?=
 =?utf-8?B?UTU1TElkaE9wTDh2djdVTVdNMzJPeDl5LytyNENDZ0xGTXNLS1NPSFpoWWxp?=
 =?utf-8?B?NVpSM0JnOEtrdGFoeUhnTlc2b1VSeE82SDFoSGpnOXRhWTM3cW4zakZiMkg0?=
 =?utf-8?B?Nlo3Y3pmcHZ4QkdWMTBiaHVsTUtYajEvcnMzSlJIUzhEWnB4TW5pK254RjFT?=
 =?utf-8?B?MVJiTlh5QUZPVCt4UkorTng5Y2JhckhjQ3AwYnhxSm1IaFc1eHZTa1lRM3N2?=
 =?utf-8?B?ZUF0TDcrTmNnbUt5OFJxUS9LWlZIZk1wUlBsT2hBSFBGUEFSWllQYkRra2cz?=
 =?utf-8?B?SE82N0VhWm1HTzEvT2FvdzZrRjdmc0VHT1hQcnJlUkE5M0M1RVhCK2pVWXdB?=
 =?utf-8?B?ZVBCcVNUVXFJK0FjazdFYjlNRFdDa2NYU2JUa3JlK216Y2RzQTZCcnBYVWJK?=
 =?utf-8?B?ZGI5SkxVbzNaSnAzRW9aT1MxclpNdHU4SllPMnZEUWxRTGlNZ1IxNjJGMFZO?=
 =?utf-8?B?K21YS2d4VDJkZ3pjRnhFTXd4azUzS1RkVHVKZHY3U0RpWG5zc3REQVlYRkor?=
 =?utf-8?B?SzY3dk1iYko3WDNBQ0lEbXBkZnBCbDc2OWFUL1Zxbkp4TlZDWFBzaTZFa3Fo?=
 =?utf-8?B?QjV2OExLUFFKL0VMYWxwODMxdU9nejFJRytGS3BJRXVDNFBicG1XSncySElp?=
 =?utf-8?B?VG5aZS9uaGZWL2NNRlNQb09JNCszcURSc3A0MVZGbjFMRXppNmtmYnExaHF1?=
 =?utf-8?B?WDRjNm91WUVqcDBLUnBISkoxd3lDL3FvdTUrYkVwZzBjdTBxUnllUjNaaTQ1?=
 =?utf-8?B?L1hiWDdOVjcrcDVIZEhWYmZGc3RmM1kwdnRENXZRNkFOZ2JaeE1xNktPNWw4?=
 =?utf-8?B?UG5vMkxhcXVIQXB0U0lZZHJQOWhFWlkxOHdtbkM0TFlMWFVWeFFpV3hYMmVv?=
 =?utf-8?B?Z0VkMGNkNVZxSU9kNXo4SndzNGsrdGhTNlMvaEVVWDd5a3RWOXhTdUJVVThj?=
 =?utf-8?B?b0hRcmVTSk91ZDJFNDVRODUxUUthMWFNSXJFL1FvYWZQT2loY1QzbU9VbGsz?=
 =?utf-8?B?Q0trcG0rL2xveWVlWmFOcEl5NGNRWGhMVzB5Unk1OGJsbE9oUUZhLzFBR0RN?=
 =?utf-8?B?Ty9aU3pNajhGTGwxbXBha25MSkdpRmcvRm9FQlc2NURvT2tkcit2TjBrejMv?=
 =?utf-8?B?RzRNU0dJUFBPaXZxNksxcTViU3ZkaTZLQ1pDcHExelNoYlpxOGM5aVFYOFND?=
 =?utf-8?B?d2FjQkFxMGtVWVdOSXRTWGN4MUVDbVBEUW9TcmovdkM4VkxIQ3RFVEF3WXQw?=
 =?utf-8?B?S051aGVabVRhbG0wS3czSktCQytWL2RVdTRnbEQxL3hqSUprUGhCcUNwUzZk?=
 =?utf-8?B?RXV4dGYzYW8yUXFJV0JkVUVSajZaL1JTU0E1WCtXWUx6ZU1TM1d3d0RteTJ5?=
 =?utf-8?B?STV2UHNSOXpyQjRUY0JZRWdtZlhTcXl4bU43eVRkeU44T0NJQkhLMjRVVWpL?=
 =?utf-8?B?MzNnbVh3TGJqdlBjMXY4ZldPcHluc0FPUGw4dUhWMk9xdWRhdHlMdXN1YndG?=
 =?utf-8?B?VEgxTXc0U1BlakM4SkJrbkRVV3IrRVZkRG9QcjgrdXNGTjFveUI4TFhUd09h?=
 =?utf-8?B?bkliQkpldGtzME52aWxzV01USW1XQ1hMcGdjUkV3cXZwNFR0dGIrMk43YW5Q?=
 =?utf-8?B?UnE5aXhLQjVpdXBTK0FOZjBBdm5LTyt3c1dDZXE4ckpkeUNGM2pwb2V1SWM0?=
 =?utf-8?B?bndJWnhrMlE4QVJnRDNIbWZ6aGhDRkM0Y2hEck5tbloycVVydENzR1BzS3o1?=
 =?utf-8?B?MnArejlnVzdibm5CN3Q5MVFxM090RFg2ZldUYmg5TGFBZC9PTS9odml1Ym9L?=
 =?utf-8?B?cnJYYzJTL09aVThFb0dHN1FRa0xEYlZOdXE2WWgyYWg5V0JoSWpvZ3FjWW0z?=
 =?utf-8?B?K29zSGRQN25SMnBIRHNCM0duQ3psMzZqbHk0eVNBMm5JdGp5WmlEZ1R1eEtC?=
 =?utf-8?B?RzZjb1dNbm4yOTdzRkwrRHI5MEZDUExsNURZSERJNURUVERkc2dBWi8wajhx?=
 =?utf-8?B?azdFOWRTUmxpMEJER1ZiTmV6WGk5OGVOaEZmOExXOWxCUWpYWGNuVXhtYWgv?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d93be2a7-7bcf-44e5-ee93-08dc8006f887
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:44:20.8797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyCXP9igA1sik5/9MtXOE56cAM9jeoNqaL/GmcCUGeLSCvM8EsXT3K2u3PhzMXp2OLIj4nzOPJYwTjsoh8yl7ZSJMxUo8U7SD/DZcekMeeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7854
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
> 'bm_pid' and 'ppid' are global variables. As they are used by different
> processes and in signal handler, they cannot be entirely converted into
> local variables.
> 
> The scope of those variables can still be reduced into resctrl_val.c
> only. As PARENT_EXIT() macro is using 'ppid', make it a function in
> resctrl_val.c and pass ppid to it as an argument because it is easier
> to understand than using the global variable directly.
> 
> Pass 'bm_pid' into measure_val() instead of relying on the global
> variable which helps to make the call signatures of measure_val() and
> measure_llc_resctrl() more similar to each other.

measure_val() -> measure_vals() (in two places above)

> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

With typos fixed:

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


