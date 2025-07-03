Return-Path: <linux-kselftest+bounces-36458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F13E3AF7CCE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 17:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DC51BC65C0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61192D781F;
	Thu,  3 Jul 2025 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2TxUMbJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018DA22422F;
	Thu,  3 Jul 2025 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751557380; cv=fail; b=UtylOZgugMsIHyFAijWme6O1HeWaEtQEIptx07O6so66PUZFonowBKNyLJmB4GDWz9k5QByCvf/5onG73St3CJj7frB8p/gPHYYMFu1gaYnBaXhuy3mkFb9AH0SQPzxezB/QRFk90t29x80UxT+y5zlox2Q3r+zGLa6g0PDOjg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751557380; c=relaxed/simple;
	bh=AWbKfMYJ/5MyvfXK5s8Y9iRMTaZYGqV2pTwV6z3OZIA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cPJiEC0C4ukaek55+90KDkQq0oNKkyuJVU/GKAHbGQoVVEUMLIdDyArWcipau/EGXr/6eK7PmVSguETuANjPaGdcqMJsqCIePtjcIujzhY2+s1149gBCNrb7LvzZxxCh3pmwPIgEpOdwsnuHVZUIPmRpHuiOJl/S+3MxLaVve10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2TxUMbJ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751557379; x=1783093379;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AWbKfMYJ/5MyvfXK5s8Y9iRMTaZYGqV2pTwV6z3OZIA=;
  b=P2TxUMbJWkYBhOsqeo+JP82hTtE3BPzG9/d9SW/cmjwGNoEn/mpXIZ5g
   foIBxQb8v9+vYbZTjPno/CGlg1a4zdjPY58MsSpgyBjMHi4q984aERWwB
   BN09JSZwmfQ/yrATrg9hCriHyUit7l/GbEm2Ag6RF6x6Sulk2VHVQVtBi
   mKeNG7s5Hye+wU9GXbgfliBRXCGV/beipiBYitj30CrvSjOGhR5MeePJe
   LwArUvR7Gl2SYM8pPEydO01UjB33KlWe4CkATSXPxDlcEoqLLfaCY9Lg8
   4hh2UZZ3Z7rpqwultCsfdCK/wd2esq6Sb0+n3ZrdSqaQjpGXZKRklT4B9
   w==;
X-CSE-ConnectionGUID: hz4VfndyRSKlvgdjH7V0aQ==
X-CSE-MsgGUID: DgdxTytsQq+7J+gzH0xTEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64941952"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="64941952"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 08:42:58 -0700
X-CSE-ConnectionGUID: YHGmDuHhQpCarWpDNi09cA==
X-CSE-MsgGUID: jNnl14o+TnuwF0kid2CIIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="159913935"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 08:42:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 08:42:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 08:42:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.85) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 08:42:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yw3E1nNVH2tvgeWlwZh81diEUpr8dRhFr2nrWK5HneO2zBcpsFCO5K6lraoXRUFj46QvrigH7l+lpn3gLeGc5EDjt/4oBhxsFEGadD91dOyRKVZ095yixTrS8bTxhbEju5Ly6BGuGm02GIGvJbOWboP4CUl1IytQ3Uz8GXJFj1nJ1hfEg4Aw6RBj2g9qRq8112eTtruibAlhcpeWi733DnURVjNxcegCmQhjTBXHI8g3Va5mfUSab6TIP5bC466eoIgFRY8LBBPhx+oRLO599mUk+nzf/p8X3lJI0KeET64ukrrcVibbwfaRyniaPHKlXa5lWn2IlZmt3ttH+juADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HN8SIz5dm2XUNOVCBq7ACPfD6m/ue49z21c7tsQQAA=;
 b=KybkGRvqQkfZ9J8UBdtWw17Tac7r5hn7IbbrjiXOBoZr2hFWD/oqpBxKXutSmXSe0NLnrdCiizsYTu3OSn3AkXaIYrbv1xbe++PFFvovOBEYIDG9PNbMxTiomZQlBmCnMu524pHisNG8XW8ovE973noqZQl8NeNUhOqtJEbkcN82iXyCmpYMY/TGzhTdOZ0x7/y1+EiUpdYpRRlcvOob+FBXbvcSNouUMKhjBmkARdNg2QPWCyn85sTRzDeaIbPSNqivhv2aVeImQEFFsRr+8DWHIMnLdPhAL1QRaFoW7CB7DSYDI60gknFgH6dkDWJ1JgG5UDI9aX80RpnG6hKN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5136.namprd11.prod.outlook.com (2603:10b6:a03:2d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 15:42:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 15:42:49 +0000
Message-ID: <8dff86d9-18b1-487f-9f75-84735a6815f5@intel.com>
Date: Thu, 3 Jul 2025 08:42:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] kselftest/resctrl: CAT functional tests
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Tony
 Luck" <tony.luck@intel.com>, Dave Martin <Dave.Martin@arm.com>, James Morse
	<james.morse@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, LKML
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghuay@nvidia.com>
References: <20250616082453.3725-1-ilpo.jarvinen@linux.intel.com>
 <0e9137e0-ec21-42b9-98be-af90becc2318@intel.com>
 <6e4aada6-005e-95ba-207d-f867c2405a1c@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <6e4aada6-005e-95ba-207d-f867c2405a1c@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:303:8c::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: 395e538e-88ab-4153-a3ac-08ddba484372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTNsMmlaSzArNUU1Nmt3Qlg0QzRVaUFaNUdxS01aM3hqT1Jic1FObmpJYjFZ?=
 =?utf-8?B?RFYzYnFWR0lKOWo0Y2g0QU8xN1Y4RmgvMjlFanFEd3dlSW5iS0ZsTGszSDBu?=
 =?utf-8?B?STdqekx2OVp2Uzk5eWtITXpRZEEyTVFNc0d4OWQvOTJxa3JSandSV3FTMWQy?=
 =?utf-8?B?ZGRRL1NvdndqaTRJQjhBdkRHa25mdG1YdTRUckxCOVN4MGU5Wm1NMTg4c2ZD?=
 =?utf-8?B?RUVlcWtEZE5qNE9Wa2tJSXBieTgxQWVQdlFOTVQyb09uaHpLcFNRSFl6Sjd2?=
 =?utf-8?B?aU8yM3NYQ3pDbUVFU3FwZ3NuOGZ4cnZKSisrSXdNYWFMMEVzRzZ2UEx6Wmhj?=
 =?utf-8?B?V2JrRHhwN0VGTWJVSmVaSTduVmJFNjlvZDUzL1ZLbmNZZDN2cVloQU1tMDZw?=
 =?utf-8?B?MGowUTN1YjhJRHhQbGhReldSZk5aZS9ZN2Y4UHBPbTdwVFk5UG1JSDU3cm9S?=
 =?utf-8?B?L1pHOU1lTUlFMmhyMHlYdkszS2p5UDlkMmNoejJvSjFMUXpNMnA1Q0R3dXpZ?=
 =?utf-8?B?cGpHTVUvUmdoVzlheEN6bk9Ta09janJCMytPem5WRjBPUHN4SW0wdWV2TkJU?=
 =?utf-8?B?NlZRVHBLemVtcnp0WW5ORUlTM0NDZ1h3cGZpL1N5ZFhVUGZnTUQzbk9SS2hV?=
 =?utf-8?B?RnIyRnlwdkhiZ3N1T1pGdWZHY3RzYXFTQjIrdCtYQXYyMDRzM0Z6eTFqQVVk?=
 =?utf-8?B?bjVXTUg0ZFVGK0daamsxazdxRXE3QkxMNXZjSmFJdG5ScW44eENvWHBYVzVs?=
 =?utf-8?B?eVRsMmwyVGpSVFF3Wkx4bGZxVXVXYkVxbXRiVVhsOHJSSVFCZnp0dUYyVEtK?=
 =?utf-8?B?M09Eb09vVVQ1V0xwM1JtTUM1S1hsNTdFWkxVTUw1N1BZZlRTU1NMcml5TER3?=
 =?utf-8?B?S3hlQURkQ09DSzhTdml3MVIwZmwxQWpJMEEvcTM5S0RLb1ZuMzlOY21YellB?=
 =?utf-8?B?NVdpd0RzUTJBQUNzejdMdmVzQ2dCaHJRS2ZPOFFjUnNabVd1OVh5WDdtNG8z?=
 =?utf-8?B?RDhZSHRpTmZNUkN1RzFYMnRPallPWUFPVnErN3V6S0FzTTRZd0RKaDRLcU9o?=
 =?utf-8?B?WDVDSjVLVXBqK05SaS9EN2Mxek11Y1c5aFRaUnUxeEsrVTZoQ3A3M2FnK1Q0?=
 =?utf-8?B?empyV0JVeDY1amRxMFhmczJFMVk0RWN3dmNteGxiYXpER2ZjNUhpVjRpTG9p?=
 =?utf-8?B?OHNSdjR6TUtobDdKamx3Wm5Uc0NMN2dDUzJTUzJMWnRuVE1nWFc3R1RDMlJC?=
 =?utf-8?B?eUVoamQwSHdvS0pkYkZqb1Q1dnJqcTVIaUkyUE50bG1lak1zSjN6OWVqemNu?=
 =?utf-8?B?TnVYTEcxTjRoYm91YjVyOGxMZS83bzdadk1rMHpRd0poT1ZwdWRJN1FHZk9w?=
 =?utf-8?B?NGlpRXE4UERwY01PYWFQQW1HK0NiKzBnT1Q0Z3g5aks0ZmVlSzJnOU9memNI?=
 =?utf-8?B?ajJiUXhhdVYyaVFuWDJVQVB3SDM2TktrQ1V4T2M4RTYralVZeFRTNC9xTU5L?=
 =?utf-8?B?NFQwVGdFRHNsV1dibXh1OWNXREN1T3l4bEtFWnV6NU0yU1BNSCt2SkRGazdp?=
 =?utf-8?B?dEFFTEQzTjJGSE1jU3FSVFBwZ211SXozTFhWOFZWK1JRenM2eFhHN0pUYkpx?=
 =?utf-8?B?Nzc5aEpCOE84OWkySTVVNk9BcGFYb0dzN3NaSXROK01vTnV5VUFJU1dpUUox?=
 =?utf-8?B?Mk15OUVBZTlyakNvYUkvMkQxcHpUNW5PL2JVUDhPbCtiRmF5N3pPaEk3MjFs?=
 =?utf-8?B?eiszOEZZaFRDUm90VHBURUNHdUwxR2pWd0pKVmtuY3ZYTGMzdUNJN2F1a2dz?=
 =?utf-8?B?WUVWd3R1T1lmcGhWMFlMMGl2ZytaUWpqQlpCQXVWS2UwTG5LRHo4RndyczNL?=
 =?utf-8?B?U3Vsc1RrbW9icG5vRkk3RUNlcEQ1S0NBQ1VCZlgyMkl6MFlIZmZyNjdWZTEx?=
 =?utf-8?Q?8YwvDYugkaE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTE2Wk9FSCsvbDlYVk9GSlI1T3BxZlFFZkJ1bE5mY1dUSXdzT0U0SEVtMXMz?=
 =?utf-8?B?TWJ5NEpHalI0dUdteVF3V09YTUhtZkJUMGhMV3haZklWTXRYdmZUV0k5TVJC?=
 =?utf-8?B?VlVmQjRyakpOcUtvMFpRL2c3dktHRzRYWnROcTFrbHZSVy9VbmQ5eG1DYUhG?=
 =?utf-8?B?RUFZZ1FwR2VmaGhRN2p1dkJkdHE5a2NrL1ZKV0pLQlB1cUJEYmpoMytSQ25T?=
 =?utf-8?B?Nm9UYzUzNzJHcnJheGNRZ2hmSUdVRy9RR0VtWmZvUHFJTUpWVmZZU0JkekdI?=
 =?utf-8?B?SG1odGtlWnh0eEZnWExZQXc2QjJhaTdNRUg0SjNiZlpYT2JCeWo5NEpaRm5E?=
 =?utf-8?B?Vk1mQWxORWdYS0trU2FHT3BFYUt1SDZXNXFYOXd1RmN2eDk5YW5BclRwZmUz?=
 =?utf-8?B?cktudzNHK245SXhCdGRDa2lKUWdia25BbWRDRFVuUExRTDlodlExaFp3blZX?=
 =?utf-8?B?Qmx5Y0xCOHFqTVJzU2xDNGlSdkJFZnhGOEcrdHJWc2F5Zy9TZ3lVT3Y0Ykpa?=
 =?utf-8?B?UEJJUkFKRmM5N0Q5ZFloN0JYS0krRFpPL2ppK20xWlVVYTRmRVN2ejRrL3c0?=
 =?utf-8?B?YWJUbWtJbEZuVlduSzRpZS9UcE0ySit5WjlENXdtUzllR3ZUR3pzUTRJdTlE?=
 =?utf-8?B?K1dGKysvT0k5OG9waGZkODFLa3N5QWZVL0NDek1XeVU5OFQ1UzlLakZsdTVM?=
 =?utf-8?B?RHJDMHkvaWV3N0VNdERlZ290eWVUUTE4ZHk5clhJL1E4N2pIRlRrSDgvSFVs?=
 =?utf-8?B?RU9nS0tNc09mQXo4UmREVjNCODFZcDRndEhNR2EvWHQyZGlsczFHU0lRM2hk?=
 =?utf-8?B?NGQ4cGwzeVNMT3BWNXRKV01kaXgzTEJiK3FSYkZRWXl4WVNUWEZkUERLSHJa?=
 =?utf-8?B?NThwSGFkaUFHYkhyOTJFQk15cXZuN2NLUnhTVXM0VlBXUEVNQTZrbGdQZEJK?=
 =?utf-8?B?dE5KM3M1VHU0SXdaR3JxN3F0a29vM0plQ28wVG94cDJZcVJjRUxlVUs3TkJr?=
 =?utf-8?B?dGJMRUYvZlpUdkxWSUZqekxVaEROcERxSVlDeGJYeXNXZHBxTW5DZzhJZDZ2?=
 =?utf-8?B?REczZ2F4bFVRYWorUGxyV0RyZDZxUUpYcExNVnZKNSsvaFJSZENwcFdvRVdh?=
 =?utf-8?B?dU1iSitra2pUT3pwb3czbW9hZEQ1YVNleHNmajRBMHFyWFAxc1BDUXNDM1Vs?=
 =?utf-8?B?UnM4RnIxS1VVUXlmUEFZSWZBbFdEbkRnQjlHU0ZFNktZU3RJNEd4UkpYNW1k?=
 =?utf-8?B?bC9FT2VSRWk2RCticG1UTkZXZUVGQjBLNTVtTXRZR24yckFmWmNxZDRwYXpP?=
 =?utf-8?B?ZHNBVVZsdnVJSzhxblRVRFdlenZ0dUViRmNQUzdiYjZwUFhxRTdabUdoS2tk?=
 =?utf-8?B?bDlvQ0Y4WFk2aUpiODc2TXZBSW5jL3BoT01rMkhObkZhTERZRkRyb3JxaEc2?=
 =?utf-8?B?aXRHZ1pZYkZQQWtHaGNyNUl0R2F5QXJiMGYrV2NRcTZ3dytpbGhRSUJsb01y?=
 =?utf-8?B?K1dzZEp1d2hDWjdBTEE3WkxPL1hVbHF2aS9mUWV1OEtuSnlhdGo4K1hvcm9H?=
 =?utf-8?B?UHBCWmNBaTYwWjJTTkVEU28vZ1JhaE9wMkJJNlh4TEtKL1RrYnRKWHJLRXk1?=
 =?utf-8?B?cENFR1V5K0lqaHdFNXl2anJuaE1DTzFBaTJmOUdaNHYzQTQ3ZTJibEJ2ZWt5?=
 =?utf-8?B?ak5EcHA4Yk10aDB6dUlLUGF2WWtkOGpabldnMzgxZGRTSUdhZzdrdlZZU0Qr?=
 =?utf-8?B?MTZxa0FPR3pkQ015SzRmd3JYWUd4UEpMS1pveEs5MStjaW1ucWdtZU1BVWtG?=
 =?utf-8?B?T3RQTE9XNDd6ZWk1NWgyNjhySnd3ZWpyOTh3SXlUcSs4WGxGYTArWU9OSUU4?=
 =?utf-8?B?c2tRWnJPaHpQdTQ3UkhSS1NHMHphUUZBQkdOMjhOb29rTE5jSE9LbmtTMzlM?=
 =?utf-8?B?NzkwdE81cHhETFl5VjhsOWhqY0xBZ1pabGZQZkxjTS9jQjV6OUdzYStQUXc4?=
 =?utf-8?B?clV0ZU9aajVVWndka3JzUDdKd3Z6MWp6c0ZGU1VqR2QzbDRTaUkzbU9IejQx?=
 =?utf-8?B?TDg2SmtZMG1USlFCN0hXcFY1U0xSYmxpYlNCNTA3c3Y5cExSRHI0V2ZkR0VV?=
 =?utf-8?B?c1ZVelh3ZTJIZytLWUYyVFpuNkRRdGU4anVlRXVXaEpkQnR0cFI2bVFKamV3?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 395e538e-88ab-4153-a3ac-08ddba484372
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 15:42:49.1598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyPSM9p59klbuX9U7lehMV1vyo3/I2mqrjtBPAUMHlgBRhlwYS+LKN8Y1n3FRJP1FEy3Ku5Z5dSIzIPdaS4bVTQMEgFfLvKFbXlxEIN1IUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5136
X-OriginatorOrg: intel.com

Hi Ilpo,

On 7/3/25 2:27 AM, Ilpo Järvinen wrote:
> On Fri, 27 Jun 2025, Reinette Chatre wrote:
>> On 6/16/25 1:24 AM, Ilpo Järvinen wrote:
>>>
>>> In the last Fall Reinette mentioned functional tests of resctrl would
>>> be preferred over selftests that are based on performance measurement.
>>> This series tries to address that shortcoming by adding some functional
>>> tests for resctrl FS interface and another that checks MSRs match to
>>> what is written through resctrl FS. The MSR test is only available for
>>> Intel CPUs at the moment.
>>
>> Thank you very much for keeping this in mind and taking this on!
>>
>>>
>>> Why RFC?
>>>
>>> The new functional selftest itself works, AFAIK. However, calling
>>> ksft_test_result_skip() in cat.c if MSR reading is found to be
>>> unavailable is problematic because of how kselftest harness is
>>> architected. The kselftest.h header itself defines some variables, so
>>> including it into different .c files results in duplicating the test
>>> framework related variables (duplication of ksft_count matters in this
>>> case).
>>>
>>> The duplication problem could be worked around by creating a resctrl
>>> selftest specific wrapper for ksft_test_result_skip() into
>>> resctrl_tests.c so the accounting would occur in the "correct" .c file,
>>> but perhaps that is considered hacky and the selftest framework/build
>>> systems should be reworked to avoid duplicating variables?
>>
>> I do not think resctrl selftest's design can demand such a change from 
>> kselftest. The way I understand this there is opportunity to improve
>> (fix?) resctrl's side.
> 
> Perhaps resctrl can be improved as well but I think it's also a bad 
> practice to create variables in any header like that. I just don't know 
> what would be the preferred way to address that in the context of 
> kselftest because AFAIK, there's no .c file currently injected into all 
> selftests by the build system.
> 
>> Just for benefit of anybody following (as I am sure you are very familiar
>> with this), on a high level the resctrl selftests are run via a wrapper that
>> calls a test specific function:
>> 	run_single_test() {
>> 		...
>> 		ret = test->run_test(test, uparams);
>> 		ksft_test_result(!ret, "%s: test\n", test->name);
>> 		...
>> 	}
>>
>> I believe that you have stumbled onto a problem with this since
>> the wrapper can only handle "pass" and "fail" (i.e. not "skip").
>>
>> This is highlighted by patch #2 that sets cat_ctrlgrp_msr_test()
>> as the "test->run_test" and it does this:
>>
>> 	cat_ctrlgrp_msr_test() {
>> 		...
>> 		if (!msr_access_supported(uparams->cpu)) {
>> 			ksft_test_result_skip("Cannot access MSRs\n");
>> 			return 0;
>> 		}
>> 	}
>>
>> The problem with above is that run_single_test() will then set "ret" to
>> 0, and run_single_test()->ksft_test_result() will consider the test a "pass".
>>
>> To address this I do not think the tests should call any of the
>> ksft_test_result_*() wrappers but instead should return the actual
>> kselftest exit code. For example, cat_ctrl_grp_msr_test() can be:
>>
>> 	cat_ctrlgrp_msr_test() {
>> 		...
>> 		if (!msr_access_supported(uparams->cpu))
>> 			return KSFT_SKIP;
>> 		...
>> 	}
>>
>> To support that run_single_test() can be:
>> 	run_single_test() {
>> 		...
>> 		ret = test->run_test(test, uparams);
>> 		ksft_test_result_report(ret, "%s: test\n", test->name);
>> 		...
>> 	}
>>
>> I think making this explicit will make the tests also easier to read. For example,
>> cat_ctrlgrp_tasks_test() in patch #1 contains many instances of the below
>> pattern:
>> 	ksft_print_msg("some error message");
>> 	ret = 1;
>>
>> A positive return can be interpreted many ways. Something like
>> below seems much clearer to me:
>>
>> 	ksft_print_msg("some error message");
>> 	ret = KSFT_FAIL;
>>
>> What do you think?
> 
> I hadn't notice there are already these defines for the status value 
> in kselftest.h. Yes, it definitely makes sense to use them in resctrl 
> selftests instead of literal return values.
> 
> That, however, addresses only half of the problem as 
> ksft_test_result_skip() takes string which would naturally come from 
> the test case because it knows better what went wrong.
> 
> IMO, most optimal solution would be to call ksft_test_result_skip() right 
> at the test case ifself and then return KSFT_SKIP from the test to 
> run_single_test(). run_single_test() would then skip doing 
> ksft_test_result() call. But that messes up the test result counts due to 
> the duplicated ksft_cnt in different .c files.

Your response makes me wonder if you noticed the switch to calling
ksft_test_result_report() from run_single_test(). Now looking back it may
have been too subtle in my response ...

I agree that the test self will know best what went wrong. Tests can still
use ksft_print_msg() for informational text.

Doing something like:

	cat_ctrlgrp_msr_test() {
		...
		if (!msr_access_supported(uparams->cpu)) {
			ksft_print_msg("MSR access not supported\n");
			return KSFT_SKIP;
		...
	}


	run_single_test() {
		...
		ret = test->run_test(test, uparams);
		ksft_test_result_report(ret, "%s: test\n", test->name);
		...
	}

Can result in output like:
# MSR access not supported
ok X SKIP CAT_GROUP_MASK: test

As I understand this will keep accurate test counts and the user output
seems intuitive enough to understand why a test may have been skipped.

> 
>> On a different topic, the part of this series that *does* raise a question
>> in my mind is the introduction of the read_msr() utility local to resctrl.
>> Duplicating code always concerns me and I see that there are already a few
>> places where user space tools and tests read MSRs by opening/closing the file
>> while there is also one utility (tools/power/cpupower/utils/helpers/msr.c) that looks
>> quite similar to what is created here.
>>
>> It is not obvious to me how to address this though. Looking around I see 
>> tools/lib may be a possible candidate and the changelog of
>> commit 553873e1df63 ("tools/: Convert to new topic libraries") gave me impression
>> that the goal of this area is indeed to host code shared by things
>> living in tools/ (that includes kselftest). While digging I could not find
>> a clear pattern of how this is done in the kselftests though. This could
>> perhaps be an opportunity to pave the way for more code sharing among
>> selftests by creating such a pattern with this already duplicated code?
> 
> The duplication of MSR reading code was a bit annoying to me as well, 
> although I only thought it within inside kselftests. But I can look at 
> this considering tools/ too now that you pointed to that direction.
> 

Thank you very much for considering this. 

Reinette


