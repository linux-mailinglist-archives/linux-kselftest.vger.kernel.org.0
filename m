Return-Path: <linux-kselftest+bounces-10926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F035B8D4EBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 17:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80D6286107
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B39D17D8A0;
	Thu, 30 May 2024 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FnISHNeQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54598186E38;
	Thu, 30 May 2024 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081876; cv=fail; b=P2MTP4s9vejGnB79RhvHe2W5oqtpAE/TMh42WLSxfpM4TjnXIbZyH2lFw8AhfASHIw9zKn4CPJ7iflh/oA6jdr0QswIh3IdSoWguDoZKDR154rhDIyuYPGO3QJogc3sh4VrVcLvzdOx9haB9CvyCMpx9eTBeUPK7xWHkOvyC1jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081876; c=relaxed/simple;
	bh=g1YEcwFwD3dtu8XcBhdirQtJKvX32PAZ9ZBKgAHa0f4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bamt0QrFg1K8+mMm8eBbNdFRW7SEwT/2w9AQCDSgJZ/GQ3mKf2km0D8iZgCglhqAOrJQ6GwsvovfXiuLxPrDtUyJzahgWEDkoEwH+oUV2/5wBIZb1Tic9PzgUwYLnIdzWkFyGxow+zco7sTth0MRRusnEVShqeA2TAYdqeHarYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FnISHNeQ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717081875; x=1748617875;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g1YEcwFwD3dtu8XcBhdirQtJKvX32PAZ9ZBKgAHa0f4=;
  b=FnISHNeQky5ep0EUsLUCbwGWiNWyOo10W0KlebNrt53PPkWA2IMwWIsc
   n1QiirSc7axklZ7UiSlPPYCcB2/LoxdCkGI0udOi798q4csiNsBW9jmsl
   Yj9+C0e2v1dTyUgk/6ynfynvznC7Ra8pb7Cvr+ybOgCCF5jNF4oncqUto
   0SalEe5fIeVwmd4/lGCuGigRlOXu4UQ0VtYrNkJbB80jKOhrkhLs8/iJs
   dqR9exIhRqJajIVb06BRm9uvh2hAhPR1m25lmS3J90B/BnC7+K1XC2lo3
   dOiYVikDygEmv/7mZ6wU7o9ciqahWInE7M2RdriIxEK9mSjCGliMjsGkh
   w==;
X-CSE-ConnectionGUID: CM2o4qMDQhqtSWXxlt0jpA==
X-CSE-MsgGUID: UqefrQgaQlWdDoTZN2B6BA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13755866"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="13755866"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 08:09:15 -0700
X-CSE-ConnectionGUID: ZLzstzC8ReG2vlXYKR84AQ==
X-CSE-MsgGUID: k6QfzW/iQZinlIboa54KWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; 
   d="scan'208";a="35917287"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 08:09:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 08:09:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 08:09:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 08:09:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 08:09:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbweYl3z72p9PHVCdY5kMILvFUJ5FGSr/dq2lI0rIVAGPTSUPRuJ/UVCxAgen0KUPlH2kUWlrHMLrhBj88ko2dO69W9KbMAVcWfH9BJ2jmoHIGI/pMW8AmF0KOb3UbBdiuvenDNc1Hp7/vyPGl7wewTFs7xB22CkTObaEHyDFOFkxHR6qCtRyToJ7KwLZYlQ3FB+lGdZa+1EqcCWkkAOOOojv0iGh89C0+E9zJGsFf6/NUiXZ9b/kUJJ9ESyxcMi0ywAye45LlTZvjZ8/4Afr8d8zC/CkvVnqwoU48vEqS5ArCVUVGXt0F6udn89XLJkBetsrHW2ETysqKJfx7gRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq9jK9mJN43FYgOjtq1fCfxtf1aXfxmNMJhif4K3PGw=;
 b=O/CodLW0VAoufDhn6p2OLxY8mN/NrWRfaIvkVCFH2ZqSjWoQdTgIPjYSNqB0qzQUuUMVKfk0VJR37YJG2W9j3COt0J0ZdbuyTOdJH+NTAKwP+4C0pku/qbNf4LZk7TxVwduYnKF39qr2sZVkd6MG1a3HLsXfeuXjy8NJT2Zvi1IC//VgGg5H+ogsUYxtoyNAYwUrn7qMPE6PomB+8YonI6M/sHb0EeGvn2+L7Df1j+nqAJbMm260zhJ8zn7wPOnVrhcvC7lb8eyLpKL1BGJtq4qR0bzP/6glD0odVhGuZjHRfXUnesKdN2H6N8eKLIwl57r1JO2SwterLd30RQTsUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4788.namprd11.prod.outlook.com (2603:10b6:303:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 15:09:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 15:09:05 +0000
Message-ID: <851fd0e0-17d5-4b2e-b99a-d14b49161ca5@intel.com>
Date: Thu, 30 May 2024 08:09:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/16] selftests/resctrl: Remove mongrp from MBA test
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Babu
 Moger" <babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-15-ilpo.jarvinen@linux.intel.com>
 <f2a8e8ad-311c-4302-a200-03fc9f02b20b@intel.com>
 <feec5ce3-cad9-6ace-3588-67e7da9641d6@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <feec5ce3-cad9-6ace-3588-67e7da9641d6@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f06854d-b989-48b4-4a68-08dc80ba7251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3ptekxLRjhYdTVxVDNJbW4vVjFlc014UkNOd1JmakxHQ1pBOGw4SEJHZE1w?=
 =?utf-8?B?djlzMDg4YWVOYzNCNWlnNG9mY1NHSmdDUkNyZS9YMVZMT3VSMGtYVzh5dUZJ?=
 =?utf-8?B?YVVNeTM4UnRFN1dSdVdHU0tOMzg1b3IrMG51a0ZoQU11TXpia3lFTlVSdUt5?=
 =?utf-8?B?d1gzTlNYMFR3bnVua3RBZUZVdXlKTEhPTHB5dWZNcFNuNCtwOVFsUGVmZVBL?=
 =?utf-8?B?NjNoV2treEZyeVI0OVhMUlk0dDcvR3BYQmkzTDRwRXBDbHBONW9iQWYvRk9R?=
 =?utf-8?B?UVl3QzQxemJ6L0ZyMVlkOGkxMUp3cXpTbk5iblBRL1J1ems1ajRxVEFPMExB?=
 =?utf-8?B?NWhLTDBzMWVrSDBLTnV2dWdrZVVoYVFsNFJuOVk3VXI5SldMSGVTL1lJb29V?=
 =?utf-8?B?VFF1LzFxbGdIcVBxUjhPWXozMXBBME82VFdGWlhwVzU1ZE9jU0pKWXllQUl5?=
 =?utf-8?B?VXVMZmxLc3VNSWVCWFRRaEE4eURmTjhCTXBuSHhLSERKd0dWZ09Db0ZteVNq?=
 =?utf-8?B?L3RaOXVWL2Z1SElTNFhGdzltNWRmWkR5Yk5YcFhzNTF4R3RYR05zSTlheHNo?=
 =?utf-8?B?M2tTRS9veEpBWWtlMk41czlJdW9CNkQ4UllUQmNFanlURkJTcU04Y0kzNlJa?=
 =?utf-8?B?LzJsbFcxcFUyUjQ2MDFGUE5Ld2c3K0tJNUkwanBMZ2JCbnFkbjZZMVhHMmxq?=
 =?utf-8?B?K05INEZQZkFoZmtrU0xuMmQ5QVlzdHh1dnpOUDJJNzhOUlUrT1U2cXUyWnov?=
 =?utf-8?B?b0pWMjljbjQ3eEhnQWVLNGk1UlZ5R2ZVQ2pIMzVrR3hic3R4bkhOK1FIM1Fn?=
 =?utf-8?B?N1NiM3lYTjhJaFhtbHFUTjd4Z3dmU1cxejhWTUxteVU3YW9PNkZRbDdwc3Nr?=
 =?utf-8?B?Tml0OUNzbmMyTW0vcmdqVCt3UUo5WTR2a1JaczJLdVRCVys4VlZtK2QraWRm?=
 =?utf-8?B?bUJqR3Zjb2xnZnlGWkI4bS9xNlArNGFaM3I1RU5xZVlEWjZZZlpqUFp6Qjd6?=
 =?utf-8?B?K0RRdmxTQ2RXMjgvYXhYV0xMTFo2RFRqMExadzczQWN2M3lsNnM3M2lvd2w3?=
 =?utf-8?B?ZVdXd0twY0tlcEtsSDF3NDBMS0NHSzhBaVRRRWpZSmFrWlJPRjYvT3ZSNStk?=
 =?utf-8?B?bU5CbUlieGFtbVk3OUdkTWRPMVBUdXlQSTVNT3FjejVCeGRkUHVpczhLRFNx?=
 =?utf-8?B?K0dmd1lYaG1xaSs1WStEem9ObWJZLzdOVEF5VzVNeHFLWWtYS1hZcTlBVyti?=
 =?utf-8?B?d3NPeGgzcmtJUzlzbWhoUGp1Y1BZQWlIRys1WGVEU0lTcUlGZ2wzSXpicUZr?=
 =?utf-8?B?M1BSN2w5OVhIQW5oMEtnd3lvQmNyWG4rV3ZsVThMRUhIbjZ4Uk9GVnM2eFk3?=
 =?utf-8?B?L1hTc2JseUxNQnIxb3J4aElxRzc4QmlxVnNuUTN0VU9DcmxvMnhPOHIvbUdm?=
 =?utf-8?B?bGV1OE5KYStPZC8wWGp1S3R0cHpQL2JXZ084WkVSUnhTZDgwMnJvaTBDV3pF?=
 =?utf-8?B?RysvMkl6Yk92Q2wzNCtLRmJiTFR3aWQ4bmJ4RnNRM2s5RWltckFCcDVYazJy?=
 =?utf-8?B?Myt1ZEFubEx2eUU1eG9pWWpGeUxtYWpwNEJWUjdiM3BwZ0lzNWdoU2VSYXJH?=
 =?utf-8?B?L2h5cnYxTW5wcnJ1cC9sNFk3Wkc0a0FMZ2NMNEdKTFYrQWlUcU95YkpjdGFI?=
 =?utf-8?B?MDFnRkNCR0ZSTHdJOGN0YmNYejk4MzIxNitSaFZuM25lbjhEOWxEam1BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDl0QTV0SUhnSnZwcTJwdHNDcVM2V2NOM3pjYlZaRkhqbVJ5RFIzYWRJQk83?=
 =?utf-8?B?UzNFL3lzMHUzVTU0b25wRHBURGhka295YkJFMkhpWngyZk1YR2p5YmZTV3F4?=
 =?utf-8?B?anlXenoxTjRFZllKMWdZZmtMNkFCZ2syTm9peFlRamFKOEVkMjZua3lJNUZo?=
 =?utf-8?B?OGZJelZiTElkRXlxcmt1UGNQRkJuSXFlbm5vaGdyUHNKa0hNUG1XQ1BqQVNp?=
 =?utf-8?B?YnpneDZmUFA2SnZRLzFHOHErMTk0S2V2cnpMeTlYbG1yMGE0S1p3V09oTFIz?=
 =?utf-8?B?T3RsbXNJekx4V2lQcHBvQVpOZ00yM09HU29hYlB1eWE0c3ErQitkVFBNQWJr?=
 =?utf-8?B?bksyb056dmFqb3doVGU5aTdRQ0lteDRsdE9TNnJqekdwVVZRM0MvL2lIU0Fv?=
 =?utf-8?B?VXpKRm9sbHovYUkxNG8yTm8vc1lXRGt3Qm9xbG05ektkZ1RISU04ditwaFk0?=
 =?utf-8?B?WHZablJrdzc5RmdIK2ZmejRFTWVrWmlGL1JIb0U5Y0ZpVDhxL1NBQi9zMWRw?=
 =?utf-8?B?TVhWazhhTkpKaEtFOW5seFJBaDFEVS9JQjcreTYzUVhNM3NBSUhGZ0tBYTl2?=
 =?utf-8?B?RVc3ZEtWWkc2KytkSis1MERsQXZjY1k1c0VDK08yd0FwU2Irb01YV0dQWXlw?=
 =?utf-8?B?aDdvR0ZyY1ZNZDZWNHdjQUdyOVkyUEk4NnR3eGVXeW04SWFRTW5mNEFCSE9D?=
 =?utf-8?B?aEtuUHBDZ0lDM05iV1djenc5WWpjWkNwa0ZMMFhiQm5GYzB4S2V2bENodWxG?=
 =?utf-8?B?RlJjM0xpdDJUNkt5SzYrTjBKVW1kY2k5RndxQ0JGSU02cWVKaytCOXBHRjdM?=
 =?utf-8?B?NUJFR3BSaEdXdjA5OFl0clUxUHV5YUtSajM3R0hMazJpTkdOVG5vZE4rM0FK?=
 =?utf-8?B?ZnlSbGV4eXpQZzdmR3NRTmxTdGJ1L0JIRHpEQW1DUURYYTZZTFZ3TXJhblV4?=
 =?utf-8?B?M3hlalJZVDRlTWdmMHgxYko5UEdyU0NRUHZNeW0xOFhXUmxqMXI3L0xCWDhr?=
 =?utf-8?B?UUdUYXhrY29LcEdlWWFCRVhVRDBydjNod2hjRWl4dnV0c2ZqdUY4YWUzbm9X?=
 =?utf-8?B?c3YvYW45TnZXZGlwRkYvNk1lSU9pVndBdE5Fck9yNnh5K0NlSE5zM296NDRY?=
 =?utf-8?B?SHk5LzdPeHZCK0dXcFBMa2lwL2VJL2pqbjBKVHFla0tFSlVObHdBd1IxUjNW?=
 =?utf-8?B?aUJxK09oNEJxUnBMZUk1bUxpdTFPTGo4OXUrMDEyYVpFN3Fjd3BCNFA4Z0tr?=
 =?utf-8?B?bWhORjhQR0JWaFJvU28rcUZRbXRoZnB5Rk8rdHhHeGxxbVhQNmRZbU5MOWll?=
 =?utf-8?B?akFuN2ZHMU9XRWJHdDEwditpVFhxMGY5NWpYaThYZG0rUUJWcmJUN2dEU1pa?=
 =?utf-8?B?RFJ2bzRKVTQ3d25DeVRuM0EwTXhuVXJYWElaOThGQTZhZ0lQdFNVblliZE1Q?=
 =?utf-8?B?OFE2d0hEdFZwT1F1em5JamtDRmI0WXBTeTJNSFhDK3AyN1hsK0lwc2xJV2pu?=
 =?utf-8?B?YjZ6R3FjMEk1dUFrUWVxbG9XbnY0UHNxTkZ6R09EV3d6S2VYbmExQWUvY2ty?=
 =?utf-8?B?WllyMXY1Um5rcVdvNjE1ZXNuK2VjL1ptNy9kenZGd0pQKzA2UDRIRUxER1Nl?=
 =?utf-8?B?OUJiY2F4Q0lIWW9OR05McXBPOTBWbjFPNHlRSVRDRjJzd1BWZ2ZuWHlCazJH?=
 =?utf-8?B?UzBMYktxOGpPbDFBM25neE9kTnBIdFpvVkl1RFcwdE00UFVPa1lpTStmWmk1?=
 =?utf-8?B?NDlkVkZwek9iRlZuZmVlYm5Qb0Rnc2JVUHkyT0VrQ1FRV0g2OUxmb0RZQlF6?=
 =?utf-8?B?S21DV011ZXljb0lsT0lmd3FQcG1YZmZ2WFk3U053RFZObXlQbEpRNGhOeGlm?=
 =?utf-8?B?bFROT0YrTDVqRTBFaWVvZE5EK3FIS21zVlQxN0xNTDdPeVRaK2QrUFJ4VUg2?=
 =?utf-8?B?OHZCdEwrTThISk1vbTdvTFVyaHJqUUg5aUpHRTZQMDYzcDFTYjFMcGwxVCtF?=
 =?utf-8?B?dm9UU0wyTzdMLzVFVjJkKzE5V1RwcitHU1ZYNmVpaFNCS042VEs5bG1pU3R6?=
 =?utf-8?B?SXcwV01KamxGb3ZXcnhuL0tvQ2U2TTByTUl6dkZqL0FYVXBDdDJLNksvSktr?=
 =?utf-8?B?RHU5aEU4K1QrN29BaUpYWXZjMVZ0NWxlV3lYeUlXb0FmSGlVLzNYYWhONFpp?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f06854d-b989-48b4-4a68-08dc80ba7251
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 15:09:05.1016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzZDyufiP/tSlEu6SlQYVC9CcAlY0DvJEPozq5ak29ps5eKaY6fwrR9jPcy0beRhQopbBf0Y6puBddSM3pwu4RwN3oSVAeqOuZlComdMUbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4788
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/30/24 4:56 AM, Ilpo Järvinen wrote:
> On Wed, 29 May 2024, Reinette Chatre wrote:
>> On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
>>> Nothing during MBA test uses mongrp even if it has been defined ever
>>> since the introduction of the MBA test in the commit 01fee6b4d1f9
>>> ("selftests/resctrl: Add MBA test").
>>>
>>> Remove the mongrp from MBA test.
>>>
>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>> ---
>>>    tools/testing/selftests/resctrl/mba_test.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/mba_test.c
>>> b/tools/testing/selftests/resctrl/mba_test.c
>>> index 9c9a4f22e529..5e0b1e794295 100644
>>> --- a/tools/testing/selftests/resctrl/mba_test.c
>>> +++ b/tools/testing/selftests/resctrl/mba_test.c
>>> @@ -166,7 +166,6 @@ static int mba_run_test(const struct resctrl_test *test,
>>> const struct user_param
>>>    	struct resctrl_val_param param = {
>>>    		.resctrl_val	= MBA_STR,
>>>    		.ctrlgrp	= "c1",
>>> -		.mongrp		= "m1",
>>>    		.filename	= RESULT_FILE_NAME,
>>>    		.init		= mba_init,
>>>    		.setup		= mba_setup,
>>
>> This may explain the unexpected checks that are removed in final patch?
> 
> While possible, I just have gotten a feeling that not much thought has
> been put on generality until now. Because of that, the solution had always
> been adding new ifs, no matter the place, instead of thinking how to
> parametrize things properly instead. It has lead to fully overlapping
> checks, dead code, and incomplete error handling which is hopefully now
> slowly getting less and less.
  

Ack. Your work is greatly appreciated.

Reinette

