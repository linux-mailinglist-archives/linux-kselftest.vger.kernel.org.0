Return-Path: <linux-kselftest+bounces-48542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A02D045CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 17:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77EAA3062527
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2EA225397;
	Thu,  8 Jan 2026 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WoPQp1sy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56341DF97C;
	Thu,  8 Jan 2026 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888196; cv=fail; b=P+XzT88xLiTuFqZ6ImdX3DavDp/B4vFxVngGIuvQTSehrirKcJtUJ5fAFUl+myz//ACwjVk70ph/AJL8+zaFiNtaVDBvat86rSAonMfi5vqYJaJtcSdHj1dMkCtc9GXDH6rliX81oXBmPdKeVZzcGRPk12d9QbIMnoPHkGoJLiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888196; c=relaxed/simple;
	bh=TjBYhmw0kbKyKm5XvDhTVWI37pbr3sMWFhLjytiIUUQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uqh6XFc+tTytmjDPuKyo6zL3w9uyx5VTtO7AwrEp0Qf+80eOugVLoEBsVvVDRzaPGEfa+jMlfwPRNQw6AYnx9RWbDFWNsfNCgg5OM4LMds1cpmndQgCUNA+XBs5N0DQQ2hSs9Ntul95OOZYh54beSRAISv8pNdrkxt58T0nHtJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WoPQp1sy; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767888195; x=1799424195;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TjBYhmw0kbKyKm5XvDhTVWI37pbr3sMWFhLjytiIUUQ=;
  b=WoPQp1syZYA2MtEYbdbzqfcSil+jXfj9V0xqwN/ArmprCLakla7Ipaf8
   XVT5v6jv/76wPzHPyosy1NJD+GlW1OHELHvHHUd/3+scDP08arwiFcSKO
   6JSwddeMK9inoeICL7LtLG+FVVSZtuFN3gZtG+wus45D8L5vg4Bsd/7vK
   JSgq8r/eP5LhdZthMzakuTol14RufDg8catG11ZyYQuEcKHn26NCmxuI5
   v2CHsvDxQquzRRMgiFEplmNqcIDCay70STgXyx5R099sKOQvv5/V9tnul
   v/3i8ki/nh1E0P6lDp3PXloh2g2+pRrNyS7benb6kRUfI4uUQNf/SGPlo
   w==;
X-CSE-ConnectionGUID: 5S7cK5xNTwKB0Pzgyf1P3g==
X-CSE-MsgGUID: BIsN5e16RYiQ6v9+YdKkOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69248375"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="69248375"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 08:03:13 -0800
X-CSE-ConnectionGUID: oUHxjFONSm+UucmvU+ncyg==
X-CSE-MsgGUID: Igvl6rMcQNCnNF3Xg4Z0Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="202361126"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 08:03:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 08:03:07 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 8 Jan 2026 08:03:07 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 08:03:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNUHTkNB8iHdScSaMcrVRIzRSTA3hBozVMW4YZscfzBwdqiueIU82EB4Lre+/4d6wVHKV813+TSj67R6kuBkJk7AlDOYSk0ZA6AUb0CF1WYUelLmMkly9oLmxQsNOeGAExTY5QfeTXnR2Jw7I7/dcUtQ9f685eaWHipfKo20i6TYGkhEyTwBd7hFYqkwdV+yNsm+AAuoaxnse8MIdCJOnlbATMP5oT7ziUQjOgHREOjhrHPM88XyQHgVf6px0+0HiI80lQnQCZL1j9G7w96ARQ86HbiP1E25quVrlsbEfAsQWxu739EeCTr8yEQ+zqlSgNt/wiI2TfOJa7tWeIdpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av/oBT6iRwylrpBmG0JBhdz+ge3TW2QnurqI8C/Tht0=;
 b=vFbvLK+KOQCqsxYsOW+1IN1WojsH9U0LZeJxVyBSv3UGpEBA7vvPE5/oerX/0vj0OuS0dP7xwNq/Ibu20WUp/kdoUDf+Zm9VhVWMg4NlOWd9DSF1zqBBQXGzG/zRrg+RWEzkr9tb1Mufl13Xr8yse4YORa5h4chBVQkdp7IDIWdHMvYTlMkZbQv6glxE07Ib0TMbSzoyKWb0cZzMKBhtgepzm9FDUma0G0lIui3nUpMNT1Bu5wV/fYXPhyIUwVooH2t2pPqyqfKrwMRvVyoDFNOEeMR4eFNe7hIwaH7MzbhulZ0tTOSpQdZmd1uyxhXNHjrxtsbzOdaWpKYfyxjU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BY1PR11MB8125.namprd11.prod.outlook.com (2603:10b6:a03:528::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 16:02:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 16:02:59 +0000
Message-ID: <bdecae64-5f6e-42d4-a05b-3334b95e6ec0@intel.com>
Date: Thu, 8 Jan 2026 08:02:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] selftests/resctrl: Add Hygon CPUs support and bug
 fixes
To: Xiaochen Shen <shenxiaochen@open-hieco.net>, <tony.luck@intel.com>,
	<bp@alien8.de>, <fenghuay@nvidia.com>, <shuah@kernel.org>,
	<skhan@linuxfoundation.org>
CC: <babu.moger@amd.com>, <james.morse@arm.com>, <Dave.Martin@arm.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251217030456.3834956-1-shenxiaochen@open-hieco.net>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20251217030456.3834956-1-shenxiaochen@open-hieco.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0040.namprd08.prod.outlook.com
 (2603:10b6:a03:117::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BY1PR11MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 02757752-0e0d-46d0-5f3a-08de4ecf648e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEY1Sy81VjluM0loeGpRdUFKcnZUUFlDUitLVWZQcWJ3ZG5JY3BwdkVONFF2?=
 =?utf-8?B?OHpvZ1l5bmxvK1hqMk4zTU1xVC83YVNCRk9udWM2WWFEcVNaZlFuS3g2VCtK?=
 =?utf-8?B?emRWMk9Pd3RXem1HdXZSQ21LSGF3a2NnVnVMbExzaWxaaUs3Z1dQMkg5NHZN?=
 =?utf-8?B?eVlpVXdCd2hVczJYQkpzeHBBTy9BYmthYU56RU4xUWR0M00rUmdwRzl1V2Rv?=
 =?utf-8?B?ZGFsY3dyajZtZGtyZEJhYW1hZ2phR05EOEt1Ly9idzFjaFhzSHBzQlBPaE5K?=
 =?utf-8?B?K1E3Szg2RzFOZE5jNWQ0TmIzY3lFb1BzNzk3NVRQNWVwdWhpemVHZTd3ckNT?=
 =?utf-8?B?ZDBKb05xYkRBWVptRUtxS2U2eTJsQlg3OXFZUjRJOFJpTEtiekJGdjhhVk9x?=
 =?utf-8?B?SEQvNXo5UktKM0l5SjJuMkpsL3F5MTFuUVJjT3A2a25KVkx4YnBHTWcrN21m?=
 =?utf-8?B?K2lIbVExSzFBcTBBOEI5Y09Oa3ZmeHAvMGFNNFl5ek16anZNMis4NkN4bmh2?=
 =?utf-8?B?SWgvWkd6VUFtQlBteW9FNS84QU5sTDdDb0phY1pBWXp2SG9lNTBlSVZqb00v?=
 =?utf-8?B?ajU0K2lBUHRsQ0ZCM285SGhYQjZOV29SWkl0K2ZuaWlxWWpaemIyUStpN3k5?=
 =?utf-8?B?bWM4NVBrYVcvaGN6cy95aFROSlB0WGxVN0pLR1dlU1FNWm5pYWFVb0lQMXFV?=
 =?utf-8?B?d2hmZU5NWFVheEtOcWR3MkplaGNNK0gxNXk4WDd5WmU0dGVJalJtck1HNlVV?=
 =?utf-8?B?bUxxN1ViS2VlV0hHVjJvckF2UEZrMStDem5tOTJhbHM3bkg0SG5UaER6S0ta?=
 =?utf-8?B?a1ZmemRtZHRzMVhweHJ0NnRqZnNPdkh2ckZlY0JRL2tiQ0J0VFdPTXVLY2VY?=
 =?utf-8?B?dUNQbzkxS1d5TnV3SjZHRFZ3S2V6RkROam5oc0E4Rm01enU5eTRtQ2pKUTB4?=
 =?utf-8?B?RStmdWpkVHd4YkZ1V1RRWHQ0ZUFkODM0cXNJVkdDQjNZT1ZJVGZpeGJiTzFt?=
 =?utf-8?B?RlVaL0JTWFVVNWN0dVpsNzl2SEdZKzY0UTZPU0tBeFY2RkRYcktOWU9QZXBa?=
 =?utf-8?B?MWIwVGI3b3QwY2JjbDlGancwQnExZlM2UVpIa2NKNWFQQXpHMFRCNloxNkFE?=
 =?utf-8?B?Q1Zyc054TDJTT3Zxb1FUdlBiK0RhSTdDRVlESldVaEhiS21wZTN1eUtlSXQ3?=
 =?utf-8?B?Szl1dGJDRGNwbVdEdXJBbmwyUmRhNDgwbFdremladmM2THdNRUpBUkZlOFJt?=
 =?utf-8?B?QWVYV25vbGFhSGdzektCVHpQUGZxSzBwNWlsRjQyUHY1UjJlVXU2Rm1rZmg2?=
 =?utf-8?B?L1gyb21RQWRZVVZpR3l5VkUxY0NJd1VTY3o4N1E5cTVyNHVzem9BcUJXZXpF?=
 =?utf-8?B?NEhOY0s0ZlM4V0l4ZGJUUEpHQS82NGFBOEhFWW5ZREd2YjVLM1BBeVFDbDdr?=
 =?utf-8?B?L1V5OU9LQm14NmxTcnRDVnpSaVJ1OFNPdzM5NSsyYWk4V3BoTFFLQzgzd1FQ?=
 =?utf-8?B?NVhrblFIck5wRnhuejBnMG43aW5EbEVpU1NJZEk1WTVFZS9sbXVWODNhbHBw?=
 =?utf-8?B?M0FYZFNYUmVYN0pnUTNjdU9iMXB6ZFJTRFhQRS9MeGlyUG1SN2MreVl1c1Bn?=
 =?utf-8?B?TFdKSWZjek9uMDVMRy80Z1BxTkN4a2pDblpsU0I0UnRIb1dqUVV6OW9uQVBi?=
 =?utf-8?B?SVE3V2RLV3ZsUWIvbFNacmM0d3lObHdjQmE3YjhneStGZ1U5OWpndVZUeDJD?=
 =?utf-8?B?TjI4Qm1RcitReENJU1Y0UUd2K1pQOUlxOUxLNUkzMzFQdlRjNU5taUk2Z0pu?=
 =?utf-8?B?VC9aN1lDbm1GRG81QWlaZHhhNHVVcUk4ajRBTDlZNlFheVBCVXZjY3QvVmtm?=
 =?utf-8?B?MEVreWlCUVpoSTlvM2VianYvR293dnFWMWRwTFpvOTRWNFg2Y3dkYW5aRkF0?=
 =?utf-8?Q?HbzLaZMavZCiVYwSsngePQI0yVcl0exr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVljUkxKaW9iZ1l2bXNxeU5kTkkvSjZCclRDd09HQlh2bVRwOE1jdWEzQ0o2?=
 =?utf-8?B?VGx2a2duK0xrVitjNnMxcitObjQzbC9XaWp0V0F1dWl3RUtJZ1M0akNINmw2?=
 =?utf-8?B?dVZHTHp0UU1LVk40V045bEdlbmVlTWRoamJPMEEzVEd6cWRoWGQxcnlJMmYw?=
 =?utf-8?B?ZkZoU2NudWdTeTg5UmtMaVdTd05ESGZpSUtEUTdZMktOZVBna2I5TFBmdFcv?=
 =?utf-8?B?QmlhK1I3aW5HSUc1bTArSnBjaHJlUDFyMVp6Mm9UV0xYdzV1VXNyQzcvOCtC?=
 =?utf-8?B?OEZ0WjdLTUxIMGpUa1VhcUhHd05xTzUwc09VOERaVCt5MUVvK2NTemt3Zm40?=
 =?utf-8?B?YUROV3FOK2RUNkQ4TzdRcmlkdG1HK042MHR0NDJMSUlMTlRnT1c0R21mcEhI?=
 =?utf-8?B?REprWUJXODN5K0xaZFU4SzRadFFyd01OWEJxZzE3RE1icW11azY1M1FRLzI4?=
 =?utf-8?B?L0Q1cUdyd0EyUkY4ZW1GNzY2Y1JHNGQ4U3Y5WHRiaVZkcHAyUkJKNFZMa0hL?=
 =?utf-8?B?WGJIYXRYU0VMUmxOSTRiNnFFdE92a1NYSnBKY2dRaE9pS2JwWTZjai9pd0kz?=
 =?utf-8?B?VmlreUFRSjVjaDI0dUVJMnpxWlpncm54YUkxQ095K0d0b0krdy82Zk1NeG9T?=
 =?utf-8?B?WVErOGZzVENnbHdiQUgxQVhERjY0ZG02eDR4b0FGclVtRjRyZ3RkWFJ5cnp6?=
 =?utf-8?B?aXF2akVLNHBDWmNNVVJVQTJtSU1XUEF3VGN2VFFnTDBHeU5GSFdhN3pXdGhP?=
 =?utf-8?B?U0RhVjJsYlBjTy9LMDNNUTRjOFdic3pLVmNNWHhXZHdzYnhxR0dNV2trVUNR?=
 =?utf-8?B?TFRaSXJwanBHY05rbWxWSkVOZkFBeG9wVEJIaVFWajVaUm95TitDRW5XY3hL?=
 =?utf-8?B?M0k1NDdJay9PWjd2bCtDWjB5T1VyYldLT3k3SThBVGpWNm5VM0pGM0pYSk5P?=
 =?utf-8?B?MnQ5VDJJV0UzZnpjZndDUTAvUUNKS1JDa3R2aTNiNFc4aXFDYm5GMXRmWjl6?=
 =?utf-8?B?RitGUGNpeUxYNFdQUEt6OGZqQTAxN1NNaVVYQ1BRU0JSSDFpQjZrRitnaXU5?=
 =?utf-8?B?MWpVUEdJdUhjaHFZMGx0YXFTa0QzVUtYVFdtY3d5QU45YXJQYUVVQkJFa1JU?=
 =?utf-8?B?TjFvQVpIdTNwYWtkREliZVNFek5ZdkI4TzNjZURvRHkzWGJNMHZLZGhGWjY1?=
 =?utf-8?B?ZVJwdC9UNVdING01TjhTRkV3UjVOMlp4NXQ1U2R4bHFtSlVxa3JIRlZKclZu?=
 =?utf-8?B?YlRjdjhpOTBzMUlidUZtaG1NVGIvYXREYmJIajRqaXppZ0RaNjdvYlFIdm1n?=
 =?utf-8?B?MXowb0hiRlFid29IVzV6Wnp6RFl2MjVFYjhuREVZellvZEVIMUhUM2Y5aExj?=
 =?utf-8?B?R2s4TmgxcWF3NHBQZGhndFg3anFYdGN5c1QrZDB4aUJueGQyL3NMalQvckxY?=
 =?utf-8?B?YUVUOE1QZmsxN25sRmo3T3RlcDhKeHJGSG5zTHJpeUNCNlNEd1psMmxzUGpu?=
 =?utf-8?B?Si9IdjBNay9jS1dsQWFoTG5SRGRQS0NRR09nNDYxZWhJQnFXeDhycTJyTzZ4?=
 =?utf-8?B?Tm92OUdXY2J1TTlja01PRlhxcDJ1WUt4TFV5N3dlcmZlZjloZ3J4RldvUTR1?=
 =?utf-8?B?MitzQ3VycFFNd2hwcFovOE9BRStpdDBCYTlqL0xQRDVUb2pseEN0WFlPOFFx?=
 =?utf-8?B?ZDc4U3JpL2ltWnJaeXNiOGM5RExiaStZOTRZaFltVE5XdlhUbHlNb25JQldW?=
 =?utf-8?B?SHZHMlNPdTVwdUszdjZBd1VxWitYLzVtQWYwRVlvRllIMmNBMTdjMm9obkd3?=
 =?utf-8?B?NENyMXB0MGRCUHMyM0tYNGEyWno1cktmM3FjcU8vQkhpUUdxcTR3RnN1WkFx?=
 =?utf-8?B?OWhxZ2NidSsveFY0VHFMY2ZKM29tU1dCeVNSam5vc1FZMm82cCtmSU9XOE5R?=
 =?utf-8?B?YlFhaXpMaU5ndWhqOE1rMUJYV05nOFZPa0xCeTV0NDBXNmlxaUdmZVhqTFlw?=
 =?utf-8?B?UENTUnhaQlIvVTI1MGR1ZU1HN1ZJTVdPVmErMVpDbkEzNHZ3YVZETHYvdGNW?=
 =?utf-8?B?bzhKNHkwVC83VmtFSmRJWUN5Z1VVUXpPYXY2eUxMdkVQK2pLcVAwb2YvWC84?=
 =?utf-8?B?ZGd0UmZ2Nm5vODdZUjNQSWZzY2tCSy9pZm5PVld3OFhvWE56TDU0eWtkSFpy?=
 =?utf-8?B?RUZrREdKZW91cVloNjJSdlhwNktreFZuaHNwU3VCUkJKdzRMaTNYUXlaWkY0?=
 =?utf-8?B?Vm1Hck5YdHFOR2FSc2tFTzRVVFdEcGpyNkJIZzlUaGdjS3FPRVJVYnkzbTV4?=
 =?utf-8?B?Y2JDS25JeVFWNlRkQzNOQVdmdGEwbUttK2ZDNzJPd0liSzFxbnpBWDg3cUx2?=
 =?utf-8?Q?Y0K1+um4fbxBXVto=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02757752-0e0d-46d0-5f3a-08de4ecf648e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:02:59.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /k5wiIYYSi53ayfxdn5YhcjxqFq7zMq+NIDJObCF6swBxlEA9ii70FxHTZ+DqMfIEFcPkSz3qvn6xO9XoFwJEazR59mJxZ1huYpgbAv5mQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8125
X-OriginatorOrg: intel.com

Dear Shuah,

Could you please consider this series for inclusion?

Thank you very much.

Reinette

On 12/16/25 7:04 PM, Xiaochen Shen wrote:
> The resctrl selftest currently exhibits several failures on Hygon CPUs
> due to missing vendor detection and edge-case handling specific to
> Hygon's architecture.
> 
> This patch series addresses three distinct issues:
> 1. A division-by-zero crash in SNC detection on some platforms (e.g.,
>    Hygon).
> 2. Missing CPU vendor detection, causing the test to fail with
>    "# Can not get vendor info..." on Hygon CPUs.
> 3. Incorrect handling of non-contiguous CBM support on Hygon CPUs.
> 
> These changes enable resctrl selftest to run successfully on
> Hygon CPUs that support Platform QoS features.
> 
> Maintainer notes:
> -----------------
> Patch 1: selftests/resctrl: Fix a division by zero error on Hygon
>  - This is a candidate for backport with "Fixes:" tag.
> 
> Patch 2: selftests/resctrl: Define CPU vendor IDs as bits to match usage
>  - This is *not* a candidate for backport since it is an enhancement and
>    preparatory patch for patch 3.
> 
> Patch 3: selftests/resctrl: Add CPU vendor detection for Hygon
> Patch 4: selftests/resctrl: Fix non-contiguous CBM check for Hygon
>  - Even though they are fixes they are *not* candidates for backport
>    since they are based on another patch series (x86/resctrl: Fix
>    Platform QoS issues for Hygon) which is in process of being added to
>    resctrl.
> -----------------
> 
> Changelog:
> v5:
> - Patch 2:
>   1. Fix a nit of "reverse fir ordering" of the variable declarations in
>      detect_vendor() in v4 patch series (Reinette).
>   2. Add Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>.
> 
> v4:
> - Cover letter: add maintainer notes outlining how these patches to be
>   handled (Reinette).
> - Re-organize the patch series to move original patch 3 to the beginning
>   of series. The patch order has changed between v3 and v4 (Reinette):
>      v3    ->    v4
>   patch #3 -> patch #1
>   patch #1 -> patch #2
>   patch #2 -> patch #3
>   patch #4 -> patch #4
> - Patch 2:
>   1. Resolve a conflict against latest upstream kernel (Reinette).
>   2. Fix a nit to maintain the reverse fir ordering of variables in
>      detect_vendor() (Reinette).
> - Patch 3: add Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> - Patch 4: move the maintainer note into the cover letter (Reinette).
> 
> v3:
> - Patch 1:
>   1. Update the return types of detect_vendor() and get_vendor() from
>      'int' to 'unsigned int' to align with their usage as bitmask values
>      and to prevent potentially risky type conversions (Fenghua).
>   2. Split the code changes of "define CPU vendor IDs as bits to match
>      usage" from original patch 1 into a separate patch (this patch,
>      suggested by Fenghua and Reinette).
>   3. Introduce the flag 'initialized' to simplify the get_vendor() ->
>      detect_vendor() logic (Reinette).
> - Patch 2 (original patch 1):
>   1. Move the code changes of "define CPU vendor IDs as bits to match
>      usage" into patch 1.
> - Patch 3 (original patch 2): 
>   1. Fix a nit of code comment for affected platforms (Fenghua).
>   2. Add Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>.
> - Patch 4 (original patch 3): 
>   1. Fix a nit to avoid calling get_vendor() twice (Fenghua).
>   2. Add Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>.
> 
> v2:
> - Patch 1: switch all of the vendor id bitmasks to use BIT() (Reinette)
> - Patch 2: add Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> - Patch 3: add Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>            add a maintainer note to highlight it is not a candidate for
> 	   backport (Reinette)
> 
> Xiaochen Shen (4):
>   selftests/resctrl: Fix a division by zero error on Hygon
>   selftests/resctrl: Define CPU vendor IDs as bits to match usage
>   selftests/resctrl: Add CPU vendor detection for Hygon
>   selftests/resctrl: Fix non-contiguous CBM check for Hygon
> 
>  tools/testing/selftests/resctrl/cat_test.c    |  6 ++--
>  tools/testing/selftests/resctrl/resctrl.h     |  8 ++++--
>  .../testing/selftests/resctrl/resctrl_tests.c | 28 +++++++++++++------
>  tools/testing/selftests/resctrl/resctrlfs.c   | 10 +++++++
>  4 files changed, 39 insertions(+), 13 deletions(-)
> 


