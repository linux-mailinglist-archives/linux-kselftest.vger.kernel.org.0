Return-Path: <linux-kselftest+bounces-10851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7824A8D3DB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 19:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08024285828
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 17:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096121A2C2A;
	Wed, 29 May 2024 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePZjR1ox"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800FF18733B;
	Wed, 29 May 2024 17:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004954; cv=fail; b=WhKkgJMfgGBy38Zz2bgmeiER3wFf/YAfaEVrzEPWxkt1WURGmdkAKJNBERG7vXnItfxzdE8pchTZACn2oPuFdIbMbV4p+rrhNS72y/ZaY2pGZgW7aWOQTNZ8k/1fKa5/Epi3H0W5C9WHFhX+OzTRlE/B8VOxuMtMmyDWb0DPBNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004954; c=relaxed/simple;
	bh=AWgF6xf335Qo+wBfq+GUAoy1jpRPIZGjI5ojjSwNek4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qp/ahrTcrwBIZz5QeoY/06V3b8poD/2nzY/2/lEceUVJeqQHIX+GDSv2WMDdpG6ECzmi7BxItNQN0tWJWwknHHYey6rxm4YKuaIKZFThFdODHs3FtQOHJCMGcJtPklNKT/eueh/g4uafJXWZEFgyfu5z5aZ/uDJJWzEUvFBbRsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePZjR1ox; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717004954; x=1748540954;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AWgF6xf335Qo+wBfq+GUAoy1jpRPIZGjI5ojjSwNek4=;
  b=ePZjR1oxGz+0nBBPsOW+joQ6FwqGva5gICVWQuTv6r3Rm4XMHVOR2HVe
   pYlzFQNjW0UanwKYAP/okibdAC4fqM2feSZjfKcrzem6PsKLQMSksa3uY
   D4hNw7BQsN/Ti+0H6T4uCMArNZyRI8DVKQ6YJIic46PDoC3u5h2suAW1D
   xbaW9FpXttVmxbhp3FHwo2A3mCi6itrU2Go1IPFVnKVgKamfZMgE/bTJe
   jYGZMs90YRgq8O7ip2n19/LZWMVHNe76ZNxwf8mzmIzSltzwVhzfYIHVY
   y8kB2MNVbZGWsOZdrekv+6QF3pXafKedCK+Hx+0hkC4LV76MSYuEY9PZL
   Q==;
X-CSE-ConnectionGUID: 8CX5EkiLSyOlhNIH9Fy0kQ==
X-CSE-MsgGUID: LGWOotztR1eHWjC64P0iNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="17263843"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="17263843"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 10:49:13 -0700
X-CSE-ConnectionGUID: nXtKok6wROSd9We+HREq1Q==
X-CSE-MsgGUID: OOojuhBFQ2eqghLUyFLKcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35476384"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 10:49:13 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:49:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 10:49:12 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:49:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmP14OfGGnfVXsdrsUroLmDNqHSN0o83yAYrvLmLJR0otdgUxZIj5iElWzTGcPVTnU4Nwc2uEyPV3RWip0YivUgUftgkRGxf5MvWgG4jtCMszOrj/bNbds830+8gR6L3+fgGFpyDManoElqgjqaNz3BJ9UA6nSNPcy/ARlXIAREvCfptQ0sRub/9nA/a18FLosYibL3MYsjZl4L59h+dr6lwvMGD1cbXS34wNmI7y8C5vqBqSwZI3fANGUnzyVt8Lmb97bKm4dMqwlvFU285mYdqW7Pe99bmg7enO1EQ0sMutvD+pjSrFWEqFuBCnWigDwUQTY6r8eVWfdhJkNt3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9jVleinQnQEOU7aAaFkpLh+HOe8hV3b1ppU8yi+RqI=;
 b=StkWOKCtdwhtcJOTGQcSW+XPvV9CFD4+tSPpyGI5Ic0YBt2BmWfGdpPm90b+tZGCH3M0sCwozslpWW0RcANLIMoeV0ApLPbjeLjbzoE97jXsCa+TW1TWWzyTHC9MJQfw8pf6myrB7GSo7wEvQZ+8szsYmv561CRdjq1iYUBVKfIDD+mJlLWPAyg2gKpxZR/engshkvRSG8we+2q04psgMzhCpalAhFlocZX34RGmrCpZDTlJWEKQsmYqIUERuBdSDTEQZKfJQz0CyvkbM/Ja587f3T6glCHrbKWFo0o/kX16hiKeLBvnvp3gpBdHlvupMo4dk984cdaAad871/G9Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB7914.namprd11.prod.outlook.com (2603:10b6:610:12c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 29 May
 2024 17:49:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 17:49:09 +0000
Message-ID: <f2a8e8ad-311c-4302-a200-03fc9f02b20b@intel.com>
Date: Wed, 29 May 2024 10:49:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/16] selftests/resctrl: Remove mongrp from MBA test
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-15-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240520123020.18938-15-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0123.namprd04.prod.outlook.com
 (2603:10b6:303:84::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: b36253e8-be62-4e2a-8b54-08dc8007a4a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlVsTTB0dG5xYUFIRHpPV0xJdHo4OW4vakJBR3BYRVVrY3dkYzV2aHdHNlVl?=
 =?utf-8?B?UkVwNWo5Nlg5QThkOERNek00eEJwVGFVeW5YaXJIWS9Sb29sak8zcWhVMEU0?=
 =?utf-8?B?Rjk0eWVETThzZVU5Y1ZmSzBlU0g4U0p4OHFMRmp1NGpSZjM2MUNUSnc0UEhr?=
 =?utf-8?B?aHdNWFNWcjA1TmlaemZoMHo4T0FiU3V4SzVzajFyUEpFdjFURC96ZzNOaDV2?=
 =?utf-8?B?K0NIZEM3QVNrVFFzTGFLZVE1Mm9OMVFTNzAxNS9BOVRDcjA4Rzk0NEp0cWhZ?=
 =?utf-8?B?cE1CU0IxcXR6KzFmcGN5ZEhJMzl4K3MwWTY1MllpUVBiWXZrQ240Nno3OFp2?=
 =?utf-8?B?a0xLM1lrWFFkNExJMnMycW9jNktXT3IxSXplRGs0UExFQlc5QTd1OFU2dkpa?=
 =?utf-8?B?UmZERHA3N1cxTzJWckN4amFzUnBITnUrMUFyYU1HK3ZmL1FEK0N1OGlxUHEr?=
 =?utf-8?B?ZS94cHZzT3lEMXJDVm9uUy9sS1Z2Mm9iSEgwaHFqUHJmRi9sRUl4ZXFuNkxL?=
 =?utf-8?B?TEI1YVZVdVhpUDNVTVRLNzhrRlNNOGRCV0REVFhvSDk0K0R5VzBlQzF3RmJZ?=
 =?utf-8?B?Y0doMG5OOWdiTEsrdGw2M0VJVnFhMU0vZC9zSThML080UFkvVUpDOGlJd3U1?=
 =?utf-8?B?OVYvaVNVQnZYWXJ0VC8waVdPeFp3OXVwbGlKN3Bld1gzZ1ZyTkRxbDBKZ2lo?=
 =?utf-8?B?VXNITVQwSHF4cjhwTFlmRUpkQWFCNjVCeUJQWjFnVHBoYTRwOTFlYjJkdXc2?=
 =?utf-8?B?b3J4RVNSNStkQXpWRDFiaEhvakVhNktaWlA3cWp0Q3NnL2R0ZEM5UGl3bkU2?=
 =?utf-8?B?RkNQNGY2ajJKeExwUEdkYW90aUdSVE9CTktYUTVIdmMxaDR3UHZJdnBua2pi?=
 =?utf-8?B?d2lJTk5UYnRoMzFSbm1PMjNuYXRCNkN1L0hQZTBIQ1d5bW0wazEvd3F6LzE0?=
 =?utf-8?B?Q1ZaTHdXRTVBNmFCaTErOHJHc3Q2VXVld1dnTmNnNldrQmFGSEtCUkpud2x2?=
 =?utf-8?B?SFg0YlNuMXd2a2MzaFhnQ09uS0J0RkpMZW55UzFNdWRvY08zdEVFTEJjNFow?=
 =?utf-8?B?UW05dHJTeXFqY3g3b3F4b3MyWmZPak9FV0laNjdyb296TGs0alFIa0M4S1Br?=
 =?utf-8?B?MSs3emtqWnM0aUMzVDBIT1I5UEROZUlJVjA0Q1Y5a3Zzek01Q0pEaVE0QTRu?=
 =?utf-8?B?bnFiOWRkMnV4aSs2YUN6aHk0WFI4RTlTQSs3eE5yNm1DM2w5VnlJT0VoRU1L?=
 =?utf-8?B?UUNaZ085eHRyNEVWR2tTT0RVSUM5RXltNUszVXoyRUI1TlV1aWNEMWhTMWho?=
 =?utf-8?B?Z0VnREx6QmRYT1lqRm8yeS9mZnBEM1BrWTR1NnNxUmFkcC83YTVPY09ZMW9r?=
 =?utf-8?B?VWJ4alJkMTBZWVJsT3FiUVdpUGVSWS80L2wxSzBjWFdXVk4vbGExNEJURHY5?=
 =?utf-8?B?Uko2cmNNcHBORWtjRFVya0pUSk1Db0Jva0JZOXFIVmtEaUkvYXlXWEdzNkRB?=
 =?utf-8?B?cjFCZnU3cXVRczBqaGVNdGtXbXdibVluR0hLWlQwN3YralJHZ1dvTXNmZlhr?=
 =?utf-8?B?cDRzek5ucmtaemNvRm02cFJvZUppNzZGTmpCWXYrL2RSTmhSeDJaZW15Yy96?=
 =?utf-8?B?bWROWDNJN1RVNk1udldPTFR0YmN0Tzl1NkZuQldoWUpYanowR0xaYVNLeld6?=
 =?utf-8?B?TDlueHhuRnRGRllmR3BZaWlJeTVaVDQvY2djcDV5RnhoMUNvTDVuWE5BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlpjVERtcGRoWkFzS29Lc3dRNzBuQ1RjMFVja2tUYmJ6bWdrY2F5dFN2VEJa?=
 =?utf-8?B?ZDBIblpWcGhVZHgvSGhubjZCNnZ1NDlKcEc5eVNuN2FCVzJOTk8vak0vZXlX?=
 =?utf-8?B?SWxpZnJ4NmdVSGxlWUJSdDdHSnNwdW8zdkR2MTlmWUhzdmNxQy9tV1g3MVcw?=
 =?utf-8?B?TUd3M0owL0Z0bTZ6cFQ5R3VEWnlBeTA4VTJva09LdWI1eEc2dEgxNmhKYkpC?=
 =?utf-8?B?ckxiRFBsalYzME9tMDFWOHdZOXdHd2pJZXZEWHF4NUVDTGlzQVlCQVUwVGUw?=
 =?utf-8?B?NmdHbUhqQmMvZFY0WmhzTjllV2hqV2hJendZNk1iMitvQ2c5NlY3MkFmZkJE?=
 =?utf-8?B?T1NPMElhQi9mNHRnRGZYUWdQbzBWdkxkTlFPMmV2ZU9MMjNxZmY0QkNpdi9l?=
 =?utf-8?B?bFVOR3NBQ055QVZkU0pXMDMrYlBLcG9PY2lwWXVibTFuR3R3YzhpbkdmbWM1?=
 =?utf-8?B?Um85MVl5K254RFJ1UlhVRm1LclJhaWE2eW1HVXIrRU5ZblZpemdZcHZEVWtO?=
 =?utf-8?B?cFRkNEVDeHNvZU5iZlFTU20xTDRuazhlSWdCQ3FQUXlCcFJjb21hY0gwM015?=
 =?utf-8?B?cFZ5T3M4SFVZWnh6dXhpVzZpencwRE1QNDJRTVdHNTk3N3dRVFVoOTM3ME13?=
 =?utf-8?B?R0FGc2ZMbElLT0dnc1RUbkFEVm5POURGOFNTcThwZk9OUkwveENDamNmUmI2?=
 =?utf-8?B?aWd4UklydmZWamg2RUZ0bWJ4V2NnOXMwQ1ZyVTFjcGlRUjdwTElPc2h5dTRt?=
 =?utf-8?B?cmpxY1hRdUV0RU1YT055dTBLdE9jc2RrZlFwNm5ubnBEY09rNEFUSGdnSC9n?=
 =?utf-8?B?VjFlcEdLcXFnQkZ4K25QcTZVZml4aUtOZCtYWW92dm9paVoraEp0QUdSTTRa?=
 =?utf-8?B?c1BwYmZxelROME1Ma08yMDZIOUovZHpmTTFMdzhYcGRnbUpMck1wSHBvS054?=
 =?utf-8?B?dDMzUTJzT1VVNW90YU5Ja1o5Z00zOElyeEtpQ0h2WWZqR2RMVTV5ZTFmRHhl?=
 =?utf-8?B?Snp5T0tUbFlWSmlIODkxZThMRVRlTG93TW9QRENhaVVwOTR2Z3ZaRVRQTXhY?=
 =?utf-8?B?SU42Q1AvekJvSVlSa0hTZDBnMXUvRlZyTzczVURDaTZFWFZyQU9kbXUrcnp0?=
 =?utf-8?B?YkpXUlE1Wi9kNzFJYUFaVVVSYlRRSjB4NUJmY0JNZjVYTGkrMGgwY1RMQkpV?=
 =?utf-8?B?VDlGZHBjNnF4ckdPU21KTjNpM1V1L2hkZ0pZWWN0eVBLV0RmYzZ4Y3Nmb3hn?=
 =?utf-8?B?WkVVdkpQWHdjMW1HSFdzaHBEVGdjY2hVUENFdnZORGl5UXdadmpRWDZocmZW?=
 =?utf-8?B?R0pod1UyMk9iYWVvcXR2WmN6cnB3SVBhNXl4TUpkbVcyRXMyMVZrOXJsUm1Q?=
 =?utf-8?B?MGJPYVF4L2pFVzVUc1BLN09USDhHNWRGM2d2Ym9lMnplbTgzTXVWNSttR2t5?=
 =?utf-8?B?ZnlPSnk3dEl3V0srbkRmL2xRNDBtNEF6V1RISTQ4RjlJTUo2WG5vNU9qbWlW?=
 =?utf-8?B?cU5OZ2VtNmRKV25DSmFkbDVxN0htaVhFNWRJVURNckFPbHRIV2pwUHAweU9r?=
 =?utf-8?B?WDA5QkNqR2E2OHN2NXFRalBqUytQSVlrZzBheHh2U1FoZytZcFMwQ3FCd0Jh?=
 =?utf-8?B?UUNCTzlGSDJtSUZmak9Idjd3T3VPcllhd0M2Zk5RRlBFWGV3WSt3MlBoR0pJ?=
 =?utf-8?B?cFRaRXVMSUtmYngrVWg1YW1LaERleWc1eU9mNUEwVjJQSFpidkRoZXYwN3du?=
 =?utf-8?B?UTRiYXlmN1lnU1RKb0tmNXhIcmxHZjdPRXNSeTd0UGxqa2pzTTdscVFiS2JQ?=
 =?utf-8?B?NHV2Zys1Tk04RmRQRjc1b1Q3Z2N1MnQwWmNlWllhZ3VqMWpQcDBhZGxlZVFS?=
 =?utf-8?B?VSs3Zzh3WXZRSGdQRDB6YmMzUk1adkVZbzIzbkF6SkFIc0R5RFRsUXBSZUFR?=
 =?utf-8?B?WmF2dXpwMGt0WkNHOWVSKzhXaTZPNzY0aCtjLzZEQTdiTWpUbmcxVmRjRUl5?=
 =?utf-8?B?eVhNRmU2VkdjMkQyRXNiMUxZRDNMZ2xtVVBQNzJCd201ZmRHWGhQN2VjbGE3?=
 =?utf-8?B?MUR6ZS9xRXZUdmFaZXU0S0VSQjlWMTZhQk5wTW52b09vL205QnMwWm1lZzRZ?=
 =?utf-8?B?QzB4bVUxNEEzVXlzREw3eS9pSXEybVI4RVc5dVZWY3Z5ZkYyVEROWWwwT3hW?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b36253e8-be62-4e2a-8b54-08dc8007a4a1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:49:09.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufzyYbSLq+i2fCNKJx245ZuqvdQooLFk/7q7FRF1Mx2JYHRApczWr8umx0vbiNT0N14ZuvU35CHGu2wIxjg2m28jH0V/Wbp6ASN2bYJKG7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7914
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
> Nothing during MBA test uses mongrp even if it has been defined ever
> since the introduction of the MBA test in the commit 01fee6b4d1f9
> ("selftests/resctrl: Add MBA test").
> 
> Remove the mongrp from MBA test.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   tools/testing/selftests/resctrl/mba_test.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index 9c9a4f22e529..5e0b1e794295 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -166,7 +166,6 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
>   	struct resctrl_val_param param = {
>   		.resctrl_val	= MBA_STR,
>   		.ctrlgrp	= "c1",
> -		.mongrp		= "m1",
>   		.filename	= RESULT_FILE_NAME,
>   		.init		= mba_init,
>   		.setup		= mba_setup,

This may explain the unexpected checks that are removed in final patch?

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

