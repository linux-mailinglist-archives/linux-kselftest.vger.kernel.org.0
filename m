Return-Path: <linux-kselftest+bounces-21460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDEF9BD314
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 18:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81071F23285
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 17:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E3B1DD0F9;
	Tue,  5 Nov 2024 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwTwEOfV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D4F7E591;
	Tue,  5 Nov 2024 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730826637; cv=fail; b=oCWz3dx4nBbntGNubkxAB+sus5YKvmeMONVt8F69BVoUZgoXztDgwwRR8cKguNkZK6iJn7WF+UD93vNji+XaEMBW4NylYOYOZ+Y7sj9VgZ7Z39XGTc6cNlgOb7jyCYy+rzQ51RRi9kliH9e3YrcmGIn/XfiK4ESJSX6jfM4kwAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730826637; c=relaxed/simple;
	bh=bAXhNFBTa6VAxDGmBxweTYJiA1F5IBPyWl0I+iynnOA=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hs1D7Wg4+KWLd0I6dj+wPDc2zYW9hrH/Ourt1yORq64/pVtHGG0Emm4uic2LlmdZzixGYfnpVYpFTNWO85JQFEcKuW16k0sX81SifkOeJRasaiS42nckCDtgzV1adR4Q5Jx7q+48wal2HlhQVENgKWMwfOieowsmr+GhKybbHDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwTwEOfV; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730826635; x=1762362635;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bAXhNFBTa6VAxDGmBxweTYJiA1F5IBPyWl0I+iynnOA=;
  b=QwTwEOfVbVO4CaGwFos9oqD/y/5z6twMV0wfUcEWYy3mFHLu8cx6GHA0
   Vow4Pyvrpt7/bS/a19T2t8g8bC/T1e8XouaXiPZeDF0xGECpsvFtDPQBW
   rn4uGOfOS2B0R1854JZRG9OUbLuikUD7CZFEZxHK/a4UgPRYljH833oR7
   PHpKXpT6CAHyDwSMX0ug33nu706dpqoyVhapJL4nP4g+fPBqHKukOFJ7p
   /osAV7Fp05y/8jp0A2cB2nHojzMBZgd2+9buXmAMpHDc6cyi8f/5TYOIY
   wNG3G2GN7fqvWIzaQWESAVME0yrAU202TNidFsqLuDqvY/+0MJNlmOXXu
   A==;
X-CSE-ConnectionGUID: OzfXHyDlT/aKSmDG+7SEJw==
X-CSE-MsgGUID: zHTzTvsLRkK3lCjll6DX7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="34373207"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="34373207"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 09:09:03 -0800
X-CSE-ConnectionGUID: tg0pcjtQQ+i0GFItFmItSQ==
X-CSE-MsgGUID: 5AJvaV1oQDmuHR0docVl+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84483727"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2024 09:09:02 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 09:09:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 5 Nov 2024 09:09:01 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 09:09:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoRSNtJ2nznGLfZr7xazhvd/11dYR9aGmg6onBlB7pxY87QMCrPEmyCgrzpAA5w3LEpePmwbvvY4Hb8nIIHuzSraWDs8Jy68c4WPVilQ2DLYKTVNZ45B0rcOucwJuBlcVGlaLP7xeVJrzFnmZkoI02l6iYLyvkyVmvKXUMOEUNjWEXkhgrdtWDKlATwsj2RRrxFCTU5eR+6jC3pP826u0gjQ2N/qX+E0KVRAB+y+1xNSJse6O6eQPKYBpxi4xAFijk3ea6RcMt/mwdGsATSJKLBSv8sWeeQKByXrMI2AzLVy8Mw0kiwynor2QoRf+z84UKK/VOsrk6EaYEm4as8euQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTYMDTvsQ9Od0noY2q78UH4AcJMECo3zHrifsD6PzZ8=;
 b=K92uxK1OcBZ5MyGHmUIpt49fNe88QixWf9+yiDFwm2wRlv/acQxnAl4WgoycwqIAoLETDtfAJpiN3DeaYUKhmCiE/3J7mMViMkEjsCKRv5SwEoBFglzp25iokVrdrWt0kk6hKvcc4XOdZhqHWFe29dfDT4POng/ha+nEkcdDo0NKTfhpNqteYNE8xwAVAdn3EDiwjYPVmcXQv3ak/eh6btaXlqU0+nechUYYTrgFXrMUvehpUG5YbBiqvJHqOuNwDTLiq0a0f3qqPhU7q14dZwK5fSpwqcVb3kFyOuo4dUcv/HTDxR+SYrbfxx8A84N6W2QNWYYaAy9w7oOE24Dcxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 17:08:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 17:08:54 +0000
Message-ID: <b7578f5e-bc60-43d3-90c2-491e203a937c@intel.com>
Date: Tue, 5 Nov 2024 09:08:52 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v5 2/2] selftests/resctrl: Adjust SNC support messages
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1730206468.git.maciej.wieczor-retman@intel.com>
 <adeb1b7d2998bba69d1a57e38300f83e646ee849.1730206468.git.maciej.wieczor-retman@intel.com>
Content-Language: en-US
In-Reply-To: <adeb1b7d2998bba69d1a57e38300f83e646ee849.1730206468.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0129.namprd04.prod.outlook.com
 (2603:10b6:303:84::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f3e37b-2265-40df-1b5d-08dcfdbc870e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VG9oMWV6dHR5ZTlxSDFaMUt1ajNBaE5xbkJrTWJ4alJoaEN0cGZ2Wm1RSVg3?=
 =?utf-8?B?VVZTME1EUXVvalVuM05nRXdVSHQzWjlkREx5K3FOVmVPMTVPclkvaUVFQ0xY?=
 =?utf-8?B?VVc1OGhOejJmcEgzSkZ5aEg1bzZsM09mUTh6K1Z5Wnh3aWZZSnZFSmpsRXIz?=
 =?utf-8?B?K2pOd3pMZHlhRWRDVTJQR2RQS09PV0NWSUlMSE1oYU80TlZNcW9sdUFXWjYz?=
 =?utf-8?B?QitqczY2V0IrR3VoZFRYRTRkaXY0N0UzdkNvWjBXbWJYMFpNRHBhNWxLNGhH?=
 =?utf-8?B?bExCQ1dFaDE2Vkcxc0FYMGJHRTRlYkkwVDNwb0lYQXdRYk1ZeWU3dUlVc0dJ?=
 =?utf-8?B?cG1kZTZnWTFqNDF6a0JsMG5zc2VJZXJqSGFPRTZjUFo0NUMvRnRmNFM0OStD?=
 =?utf-8?B?V2NQQmZzd0pKRENpZ1ArMWVkbjlDQitMU0RYUFFmYVhkZmRMTHRFd04rWkQ0?=
 =?utf-8?B?LzF0KzMzZ2xUdU9yNUxXNUo3U3l0NCtmUTJyaTVMc2NKUG1EaWlETWpXcG9M?=
 =?utf-8?B?SGxyS2pSRnZqM0UwZy91cTQxRTBiNGkyWXREbWVnQzBXZFhzeG90NHRTV25Y?=
 =?utf-8?B?bnVTcHRqSnQ5bFhSaXVkYWxMaUhzbVBod0ZGOTJia3dvZUpBOHJBbFg4U1hq?=
 =?utf-8?B?NVJqa3l6MzZWWmEzdThVanFEUitWUDJObU1yNGhIR29RRTFrQkVTT2lzS2x6?=
 =?utf-8?B?clpqZHJUSmZLLzdVMVFHSTFoNVhZcmV5bXMxbnJRWDdWTFVubENPSzFNbnJD?=
 =?utf-8?B?RUJFT3lZZTZpZVNnWElyY2pWKzZ6MlA0NklRMFlzLzJoRU8rSGNaWWFnSXht?=
 =?utf-8?B?M3JRbHlpbXZOcS9idk9VeWtaQ2Y4MkhqVlVqcGF3ZFRZTkpkMXNiMFFyTkM3?=
 =?utf-8?B?Wmp2M0RIWUVpSHRINHZuNWIzU1U1d3ptNjN5U3lsSGRYNk5CdUZ4Q1hGRkJ1?=
 =?utf-8?B?RE1aWTRDYms4Zm1jK1gweEV3aGZEZjlrLzVVcy9qaTk3ZGY4NzV5UENKOXVL?=
 =?utf-8?B?ZFNNSk1lVjlnY1pDOHh1dGZ1RndYVXliNk02eWw5eWVLZDBvQzFpSTducDNo?=
 =?utf-8?B?ZXovS0pIY3NtUDRkUzBYR1MySmplN0NidllsMHpVU0p1OTVuZ0FKNHNzbExm?=
 =?utf-8?B?UDBuazlXSTBUTmRxYTA2MkR2S0VSOTMrNURJS05iQ0taM1REUlRJUldJYnhr?=
 =?utf-8?B?b2xVMDlaMWMyb1FZOGQ3YjdDU0NiL0RLYnJ6eVdybEV0SDIrRHVhV3JBbjRj?=
 =?utf-8?B?aUN3K1lVd1V6YWsxclMxVFZmcEtDL3ZnTFA0eGdCcVo0QnVUOER3Q2lMOXRX?=
 =?utf-8?B?NFZLclVOTUpEcDgvM3cxTDNvazZ0UElQM243TGpJQlBCaDhZaXdYUk04UTJz?=
 =?utf-8?B?cWUzVWxPRHFFVHVYVXlzOVBMSWFuMjNtSTN0cGVpS1pmTlc5Mm5sWkN0eE9H?=
 =?utf-8?B?bldWVkRvQUpTOEd5M3YraGVTUVltVTdrWklBWXBrQUJOVkN3bUVmY2V1SDg0?=
 =?utf-8?B?THp3SnY3QmZpdlRqcHl0TTRITkZQU3lRc2NUNWFNallhOTZuby8xeVF2ajJK?=
 =?utf-8?B?L3JZVFZkNGJxZGhuWjN0MmhIb1N0WTZzYlF5ZUV6VnJlMUhWdlozdzdvZWZr?=
 =?utf-8?B?ZUdabFZqUFYxa0tOVlNvaG5rNGszVERPdXBtWUlxS0xBTkFXSmpvTHBkS3E2?=
 =?utf-8?B?OFU2c1lxZklrZ1k0MU5aamNFZU9VWlE2cGdvc1VTQUNhSEVNOGhmdjZwZ2ZX?=
 =?utf-8?Q?3lDbzjh5NaHO2sYz8xj2akyru5mDFhcfqvjwF6e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0RYa0FtM1d1WFNOcjBmYU5YMDFTZW5MOXJQVHFocFBtUllQZmRCL1NuWnR3?=
 =?utf-8?B?aFZTdlY0cFljRVFNMlZpcUxoS3ozTTdiTzhzK1lxL3NrSEp4dS93L05ZbHd4?=
 =?utf-8?B?MXBXbm1aa25TdU1XQVRaa2NueE1mSTl5ZWRmNFZHNThXbEJYSEt2S3NsNUw5?=
 =?utf-8?B?d2thSS9HTklnTFdad3l4bDJmTGZnOCsxYlJrcE9IYTB5MlhYc0F5aGZTSnF4?=
 =?utf-8?B?RmxHUnB5UGpmL2loL0pHT3VxeTd0M216SjZ2cWxYVDNDNElZbmxuU0ZUUERu?=
 =?utf-8?B?NXl4cVBISSs3d0l6RTJQbGlmdlBOUUtNTFo3ckVxSkwwTS9XNVQzRkVaejUx?=
 =?utf-8?B?TjhVM1Z5UVZZbWNWZEhsbGo2QWcrZmdTSE9xbGo0UGtSWmNNOVBmSWMxU1ps?=
 =?utf-8?B?L240em9pdUNNR0duWlpUM0FFVGpWR3QzMXZLYXdIdVA4VUc5cmdldHRzdmQ5?=
 =?utf-8?B?bXhIdnlVQTJvVDJmellDRWZ0NFVXMmsybFdmU0ZHejErYTJMVC90SEVQREpL?=
 =?utf-8?B?L1M3SU9oZkhZVjArTWdGdnFKSnExSXRvdmFtNmlIRTVGS2RUaU16UHpHMzMw?=
 =?utf-8?B?K0QvWDRCOEg0aFQyNm92bWF0L1JtRkwvNnlGWkF6TXdaVGRlSFA1dm9BU2ox?=
 =?utf-8?B?Y0c3OTBZSGVSajFzczlNOHVDR2doWXV4RlAzdzcxdGUyZTRnQWw4dUhkeTBw?=
 =?utf-8?B?UWVIdDBLRHFUdUtrUzZPVVJaaUpxaVNuaDNDS2tKc01EazJhanBwcTRuTnkz?=
 =?utf-8?B?NTRvRmxrTkFBQVVzUjcxZ0pQTG44WDd3ZTZvdUd0akZKK2JuOVVRWXgwMjNy?=
 =?utf-8?B?WkJnM1M0TTJzU0xpc0lWK2JkRUt2M0Q0SG5ENDNJZ045NGlleUdGbzZHUFBC?=
 =?utf-8?B?MjBFYmVzTmFqMXV0REhjTi94OFFmZ1Bwb3M0NWYrMVZ2UitUNnBTcW9DMlpz?=
 =?utf-8?B?ZG9mL3VBRENTdFZtNW1BcXF6QUpIY0NIMFoyR3QveXpLWkxoR1FlNGVvSDE3?=
 =?utf-8?B?TzBvRFByVk5CT0YzcXFjamEybFRNdVNqTk5Vd0pxbDN0Q1o0UFVPRmpLZDk4?=
 =?utf-8?B?TmFkdFVqNWQ3OWJ1ZHhPY1gycERiK1B0b1RmS25XSnZOUy9TRHlnNzgyaXJt?=
 =?utf-8?B?UnFhZVQ3RXZ2eUkvNzQvS2hOODU3aXRMcUNjdWoxRHFWd0Q2UTk0TmVKUHNp?=
 =?utf-8?B?VCt3di8rcmZMSXNOL2V5R0NUTHhPRmJqd3p4dkFoK2hBTkFiN0l3ZjZuWHZL?=
 =?utf-8?B?ekY1MEV2NVd4Nkh1Z01qUm0zbnRwV24vTXE1QlI2UzIxTVN0VnBOQjNkK0Rq?=
 =?utf-8?B?T29RSjNlZXJvVndxSXkxTkFiRTBQVmxaMEdab3JxczU1OFpRZXZzSDNEVXlN?=
 =?utf-8?B?ajlrdUlXYXhNbkl5dG50LzFXMEh2VWRsZ3cyZTRPazNEZGhZVzQ3Yk9HMHhM?=
 =?utf-8?B?cmFjbGJHTHRhUmxWUDd4bUw0K0lsM1dQd3FHbC9iNmJ5dUEzRTBaREs0NytJ?=
 =?utf-8?B?UWM4eSs1bko1TmhwbTR5RktQNno1cGRsc1hHalpiTzJMTVNMYzVmZlhvTTJr?=
 =?utf-8?B?d2RsajU5Q01kR0s1R21CZjNQbysrd1ZkbEVEcVZaQURwcGQ1Yy9tVnhwTUhk?=
 =?utf-8?B?V1M0YUZ5bTh1SGlnc1d2MGYwNFVkZ2ZaQjVrL1ZGdDVVUlY2NjA4N0RGOGd2?=
 =?utf-8?B?WHFLOHp0alFxOGpYeVZXNldKRzRsR0xDSFYrUnA0Tlh5c3Y3SlZvU0dVWnFZ?=
 =?utf-8?B?SVlKdGdzUjlCL1lEMFlxMm9sazF0RnNBRWdGOHhWQ0xyMHVaRjZVWnorN0c0?=
 =?utf-8?B?NGwrZENFbmlGeVh3bGpvczhId0dKOUFlcTZ6SkxRUkpFYnN4NGpqcUd2eDVL?=
 =?utf-8?B?ZG5PVzI1M1k5Nk9SUURMa0dvSHFPU2JucEFGUzRlT0JwM1NGVzZDWTNaYjUw?=
 =?utf-8?B?VXl4M05RbktxdWlaLytmMUtzN0NZSzVBOTE2NWczcTVpak80RnhEYU0xWkJs?=
 =?utf-8?B?d2JaQ1UwRlgyREYvbGhTYnA0Z1dseWhZbUZQU1MydkFSZWJKR3BmdjRkN1NX?=
 =?utf-8?B?Q25NeHkxd3BFTnY1a1VWbllmSGJNOXNmQzYzYTVJMDFXYTFzeUNVM2IxcENV?=
 =?utf-8?B?U3E5azVQcG81dXVKVUN6U25XaDFyWXpoNjFyK1E5eitFTVpmOFJUaFRNSnFJ?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f3e37b-2265-40df-1b5d-08dcfdbc870e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 17:08:54.2511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKQWCxztNgWCsBZLTZGSdpuguvW9NPui4H0ZYnZ9ZnsnD6mttRFXWtiB4X/kzwpfk6R+s30UwLTCQkRfHETNcjpxRiD7X2naUzRKzeFjWcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7765
X-OriginatorOrg: intel.com

Hi Maciej,

On 10/29/24 6:00 AM, Maciej Wieczor-Retman wrote:
> Resctrl selftest prints a message on test failure that Sub-Numa
> Clustering (SNC) could be enabled and points the user to check their BIOS
> settings. No actual check is performed before printing that message so
> it is not very accurate in pinpointing a problem.
> 
> Figuring out if SNC is enabled is only one part of the problem, the
> others being whether the detected SNC mode is reliable and whether the
> kernel supports SNC in resctrl.

Starting to sound like previous patch ...

> 
> When there is SNC support for kernel's resctrl subsystem and SNC is
> enabled then sub node files are created for each node in the resctrlfs.
> The sub node files exist in each regular node's L3 monitoring directory.
> The reliable path to check for existence of sub node files is
> /sys/fs/resctrl/mon_data/mon_L3_00/mon_sub_L3_00.

... this is about previous patch ...

> 
> To check if SNC detection is reliable one can check the
> /sys/devices/system/cpu/offline file. If it's empty, it means all cores
> are operational and the ratio should be calculated correctly. If it has
> any contents, it means the detected SNC mode can't be trusted and should
> be disabled.

... also about previous patch ...

> 
> Add helpers for all operations mentioned above.

Not done in this patch.

> 
> Detect SNC mode once and let other tests inherit that information.

Not done in this patch.

> 
> Add messages to alert the user when SNC detection could return incorrect
> results. Correct old messages to account for kernel support of SNC in
> resctrl.

Sounds like description of what earlier version of this patch did ...

> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v5:
> - Move all resctrlfs.c code from this patch to 1/2. (Reinette)

Please update the changelog to match the changes made to the patch.

> - Remove kernel support check and error message from CAT since it can't
>   be happen.
> - Remove snc checks in CAT since snc doesn't affect it here.
> - Skip MBM, MBA and CMT tests if snc is unreliable.
> 
> Changelog v4:
> - Change messages at the end of tests and at the start of
>   run_single_test. (Reinette)
> - Add messages at the end of CAT since it can also fail due to enabled
>   SNC + lack of kernel support.
> - Remove snc_mode global variable. (Reinette)
> - Fix wrong description of snc_kernel_support(). (Reinette)
> - Move call to cpus_offline_empty() into snc_nodes_per_l3_cache() so the
>   whole detection flow is in one place as discussed. (Reinette)
> 
> Changelog v3:
> - Change snc_ways() to snc_nodes_per_l3_cache(). (Reinette)
> - Add printing the discovered SNC mode. (Reinette)
> - Change method of kernel support discovery from cache sizes to
>   existance of sub node files.
> - Check if SNC detection is unreliable.
> - Move SNC detection to only the first run_single_test() instead on
>   error at the end of test runs.
> - Add global value to remind user at the end of relevant tests if SNC
>   detection was found to be unreliable.
> - Redo the patch message after the changes.
> 
> Changelog v2:
> - Move snc_ways() checks from individual tests into
>   snc_kernel_support().
> - Write better comment for snc_kernel_support().
> 
>  tools/testing/selftests/resctrl/cmt_test.c |  8 ++++++--
>  tools/testing/selftests/resctrl/mba_test.c |  8 +++++++-
>  tools/testing/selftests/resctrl/mbm_test.c | 10 +++++++---
>  tools/testing/selftests/resctrl/resctrl.h  |  3 +++
>  4 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index 0c045080d808..1470bd64d158 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -133,6 +133,10 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
>  	ret = get_cache_size(uparams->cpu, "L3", &cache_total_size);
>  	if (ret)
>  		return ret;
> +
> +	if ((get_vendor() == ARCH_INTEL) && snc_unreliable)
> +		ksft_exit_skip("Sub-NUMA Clustering could not be detected properly. Skipping...\n");
> +

This (inconsistent) duplication can be moved to run_single_test().

>  	ksft_print_msg("Cache size :%lu\n", cache_total_size);
>  
>  	count_of_bits = count_bits(long_mask);
> @@ -175,8 +179,8 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
>  		goto out;
>  
>  	ret = check_results(&param, span, n);
> -	if (ret && (get_vendor() == ARCH_INTEL))
> -		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
> +	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
> +		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
>  
>  out:
>  	free(span_str);
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index ab8496a4925b..8f4e198da047 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -170,15 +170,21 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
>  		.setup		= mba_setup,
>  		.measure	= mba_measure,
>  	};
> -	int ret;
> +	int ret, snc_support;
>  
>  	remove(RESULT_FILE_NAME);
>  
> +	snc_support = snc_kernel_support();
> +	if ((get_vendor() == ARCH_INTEL) && snc_unreliable)
> +		ksft_exit_skip("Sub-NUMA Clustering could not be detected properly. Skipping...\n");
> +
>  	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
>  	if (ret)
>  		return ret;
>  
>  	ret = check_results();
> +	if (ret && (get_vendor() == ARCH_INTEL) && !snc_support)
> +		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
>  
>  	return ret;
>  }
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index 6b5a3b52d861..a68f70589b91 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -138,17 +138,21 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
>  		.setup		= mbm_setup,
>  		.measure	= mbm_measure,
>  	};
> -	int ret;
> +	int ret, snc_support;
>  
>  	remove(RESULT_FILE_NAME);
>  
> +	snc_support = snc_kernel_support();
> +	if ((get_vendor() == ARCH_INTEL) && snc_unreliable)
> +		ksft_exit_skip("Sub-NUMA Clustering could not be detected properly. Skipping...\n");
> +
>  	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
>  	if (ret)
>  		return ret;
>  
>  	ret = check_results(DEFAULT_SPAN);
> -	if (ret && (get_vendor() == ARCH_INTEL))
> -		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
> +	if (ret && (get_vendor() == ARCH_INTEL) && !snc_support)
> +		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
>  
>  	return ret;
>  }
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 851b37c9c38a..488bdca01e4f 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -121,6 +121,8 @@ struct perf_event_read {
>   */
>  extern volatile int *value_sink;
>  
> +extern int snc_unreliable;
> +
>  extern char llc_occup_path[1024];
>  
>  int snc_nodes_per_l3_cache(void);
> @@ -167,6 +169,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>  int signal_handler_register(const struct resctrl_test *test);
>  void signal_handler_unregister(void);
>  unsigned int count_bits(unsigned long n);
> +int snc_kernel_support(void);
>  
>  void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
>  void perf_event_initialize_read_format(struct perf_event_read *pe_read);

Reinette

