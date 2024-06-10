Return-Path: <linux-kselftest+bounces-11608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7126902B12
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 23:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFA01F235DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 21:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37FF1494B9;
	Mon, 10 Jun 2024 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M24K3IzU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA251879;
	Mon, 10 Jun 2024 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056702; cv=fail; b=qmWGxnCANVtH7vy8aLlDto0VGXh+ULG80h3XSi0x6689LAiQknuCN6JLLCUgpF6Sd8p+WzUyJ3X/0NeVQ0XN4SG4LmSLgoNIqqADDyYYmK2sb2HD9cts7CzK2hJLuNHzBj2w4faTXcXX7ryWHwbGAu4/XHZHJC0SB2iFzZZtKAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056702; c=relaxed/simple;
	bh=/WLagHD9Dr97RwE74AVBCn92lzQ6MxZMi5SWTKoJf4g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H8jW73u+s920riY/SHtjRqWi+4sCiAC7Vb5DhbmWy0giTTiGRYUXvM49dNVDvX43Oen1oMLMghXAR8pvmDqcm54+pzebSSSMXNajLo3MOQn5xhYmC8htpNq3U7NN3/1WfZIOfxA/I0OhDoyev3ZI5qDTScUCeS4Zo0clORkR6K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M24K3IzU; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718056700; x=1749592700;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/WLagHD9Dr97RwE74AVBCn92lzQ6MxZMi5SWTKoJf4g=;
  b=M24K3IzUS0E8Aq0X/TOZZMcWZjupr8beiwgzwgVgR1DimAb5i9Zkce0a
   PMrgJOBEaqhO2+O99a3KIlASfl4HH2Xj9egcy5ugmmk+ufV+FNZoFMxvv
   G1rHokDtRuY6Am/X3ZpnRw898R+Sf6LxOL9fv2lYhnTW+TwHF0dmdsjIl
   F7+lmUzuKVC9Jq+T6ww2+i8wt3FqOqjeVETPEkzjMRhItDqI5/HdIZq9C
   td6vrfFEqH2oHHoMH2QMVMSK0aCN8+hubWP7I9xJmYeB/eazLOvOvuulv
   QL+igrygx7Z+d41LQ8nGzqKvMdnbjchFkuksgR5cb99M1hKmGZpzi1unm
   A==;
X-CSE-ConnectionGUID: oKe4sp7XRNeX3FvzE09q/Q==
X-CSE-MsgGUID: NLFgI9C3SMyuBsttfJ7VQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="26156445"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="26156445"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 14:58:20 -0700
X-CSE-ConnectionGUID: tDDghV1uQeqS1Kf6Lfx9iQ==
X-CSE-MsgGUID: t5UmiXdhRT+/RsI2cRxKbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39872617"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 14:58:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 14:58:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 14:58:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 14:58:18 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 14:58:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OghuozQz2dhIoKIWrG9YHgjjfaYd1fE/l9L7HfrhNYx5dyvzUOM/fg1jUTlUNAV2d784iA1BN0DM7prw+f7hUwRK2Cyy7FTLF1htM9fZw0P0wOhBHOjLkWF7ZU7CUoRWg0afxz/3UvDwxYg2hobGPW3nZRxzpx5L8mS2KbiFcuY7XBhIEIWg/ADyyQLfbgtZmriBVRSDOylh9auroE761KnilZ26X3aL+LgqczveblALoLVKPPv5sPFlPLWjuigj3vX0Lts5dvqmrSbSyRZmhQ5KouzXHjvIyQ8XsmrjPu/8TMvvnnsKi7WE33VwF+6ggmiN2RoHliidbVkrv1R0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeSB16QjBecWWcsnmyCV96QZxh6ZanRtHGZ1PY0RS0I=;
 b=kqoCHHGCnUofs35iURv1rIVjkwAnCkamaKRCsVgavzQBl51a9hFN7QBvENnBEKQPwvhDg3haiJo+FHkSTimOZMYLVU6FVpMJxLrtoePukDMVlyy6s6Zgomif78wWbPtntQAwhJy25isYXlRvmsfMVfTefSkr8qp13OK/jN3GbpmPtW430DK9yhNGohNzhYjMGCZIxjvGD3uMOq5X5bU3do1iaV/Z77gXS83GR8Jx31z5M15o8+q8sibdhdGre+GsIWsvPnYMEnJHSxez6HLdE9infl2JTwB9FDhtzmz71tHskkVCuEpVOTxvwBWoKIOGsmgbQbPVb50tZ8H8vV+n0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4688.namprd11.prod.outlook.com (2603:10b6:806:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 21:58:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 21:58:17 +0000
Message-ID: <a673b421-0857-4220-a7db-2d58bfc07981@intel.com>
Date: Mon, 10 Jun 2024 14:58:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/16] selftests/resctrl: resctrl_val() related
 cleanups & improvements
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, <linux-kernel@vger.kernel.org>, "Babu
 Moger" <babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, <linux-kselftest@vger.kernel.org>
References: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:303:6a::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4688:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f76b8e6-0ef1-4972-fc1f-08dc89986ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2hZV0ljQmRSL0FhQmpIMmVvWHZUdEZ2ODFsM3VjZVphdVI4WFIwd21wWThq?=
 =?utf-8?B?VVJKd0t1aG9hTDRPS3pCQUF2Vy9UaGFiN21kODE1bk9wM0Nwd1U0TWlKcFdN?=
 =?utf-8?B?MVdPSVBnL2R4TjR5bTI2ck9GT3VER2htQnRNOEdVei9JZjFkN29wV29RU0hu?=
 =?utf-8?B?RitiZVZCaithVElIbmVyYmxLYk1PSzZNNnFnczB4U3FhcEhjYzlTYjM5QVpZ?=
 =?utf-8?B?UUx0V2FKTlhZNzN1SlpyUTJUWFlkTjFzOW5WM0xQWUUranJWN3FLTjdSaE5p?=
 =?utf-8?B?bE9ZWTV6MzFBMEZMQmE3azVlMFFrcFc3Yk5EUGg4Vk9vbmJOcDI0Tkx5ZzBX?=
 =?utf-8?B?U293M3JDdjhkNW5iMkxqbDJYUVYxZVkyb2dVaERCRTY2S1NJTEl3TEY3RW5u?=
 =?utf-8?B?UzBPZGRBY1QrSmhibjRLRmpLYm12TjZCK0Uyd3VOTWhDMUlaQVg5enZ0dTFi?=
 =?utf-8?B?ZzJ3aEdPYVByTEdGS1lLV1BDd3lnOTNmNmdwV0JHaTM5NTFsMENmMndFenR5?=
 =?utf-8?B?NVBNeFBIdys5Q0hnV0ZDSWw5RFJ5Q2RrSGtSZzI1L3dNcGVRcnA3V0hMWmdy?=
 =?utf-8?B?akdIMjY5eXVlMlE5RGgySnBZTzF6NUpOWVRZRjR1N2pUeUViR0pTREV5Ykg2?=
 =?utf-8?B?NmgvSFIyd1dqblZMbHNTaS9jYlNSVVhyTEtoZmF6WHFVeng3VVphTUVGUVBL?=
 =?utf-8?B?bXdJT1Y3NkJJcjNSVW5uZVpWRjJzbTBLdGpTbk9mT3VGNUZiSGxiYy9aMC9X?=
 =?utf-8?B?dUhLQTBHdk80M0hySy9GbGxlNklzTnRsVFRoYkNhNFQ1bGs1a2h6RXpZMzlQ?=
 =?utf-8?B?SUgyTmJnZm9HSlBMSTdwSUFsSEcybzY2OXF4eGswODJFS3NwNkUzbnlIYXA1?=
 =?utf-8?B?LyswamVnM1lod3plOWtmZjVTZXBxRzZOSkx4cmt2ZzZNTkNxdjB4VnRXV21N?=
 =?utf-8?B?NEtFRzc0V1kyanZobURFMG1NQXZ4TFBucFMwSGgrVGlsWnUveGc3NDhINHRJ?=
 =?utf-8?B?S2ZOT0FCOFJjbDFWUGhTZGhGbzAxNGtvWlJwSGhuUDZlVEJVNmlZNWt2Mlpo?=
 =?utf-8?B?UDFOVHRIU3NlQzRKeGpWMHVQVXk5aFNMSzc3UDBCSXQxbG1MeUpXZVpHN2VM?=
 =?utf-8?B?elNzR0NicUcwS0c4blZ1YXJpSHliN1ozY0lPKzdHTVloQmVybGtKZWxGbzNj?=
 =?utf-8?B?eENvT1BWYWh5WXJhaHRTbU01U01mSnlNL21QUGRTT29PaU5YVC8zVUR0NmVp?=
 =?utf-8?B?S09aK0o4c1d5UTRFTXlGbDNwQkluOXJ4c3p1TmJsTjdvVFNsZ3BTaTRMcmsw?=
 =?utf-8?B?dDUwcnhYS0hUdjB2M0ZIR014QjdxM1R0bW8yY3dYVEZFbkFnTkNKYy9oZmtr?=
 =?utf-8?B?ZXpnQUZNekwybUdpWlhVay9BeE4vclBWeEkxVmNwdFFRdTZoN3EyUXp0T0JW?=
 =?utf-8?B?bE43S09lb3kvTkNHV00rNFk4S2x6aStwV1BEUEYvbXduRHRqdll5OTUxOTI5?=
 =?utf-8?B?R0pBdTRqemZLRjBwNE9QNFZ2b3loUDJIbmJjK25pYWl3d1lpbWlyL1JlVVow?=
 =?utf-8?B?bmhqTmNTNXdBZWw4Y2dseWpwNkxqakJmaGo0cTNuTURKdlgxVDk0dDhweWFu?=
 =?utf-8?B?Zm5YOW9sUG9pQmFDdU8wWlRYdWlGZnFBL0FQaUdOODAwbThNR3NwaDJrOEhv?=
 =?utf-8?B?NkltclI4d29md1RraDBHM0oycTAxSTcrdVBoMEQ0TWVIcXg4SEhaTk1VL2VK?=
 =?utf-8?Q?lcoMm501yMSrkRS6tHPSTOpnUsUy70L9YofD2KO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2R3TWgxbGUwOGVYeEVOKzhJamRWK1ZNckQwVjF3Ty9jL3g0Zy9CZTVNcHBG?=
 =?utf-8?B?b0FwVGJ6UGZCem9rL210VHZQOEw4ekY4UGk5OFdHMVoyUFhQbUt4ZDl1NzB2?=
 =?utf-8?B?T3pVUEY4ZFhJdEZaalAxeGJnNWNCUjJ5dlFTS1FndEkxTUFXNyt0Tlp5OEVw?=
 =?utf-8?B?ZEl0anVUSG82N2wxdXFCMG5KN0hHSkU3R01oeHpadU9YUzdtajZ5T3FnUW9R?=
 =?utf-8?B?cGZqRStzOU5OWGVXNVJOSkZyTDZhdVMwUTlLMmdXRGVKTWNHaWNtSUlVUXNm?=
 =?utf-8?B?WnpvOG45bkNOaGVZc0M2M0pLRjViY2QwUkZldkJQUHN6VS9kNEM3MVNsdnQ1?=
 =?utf-8?B?b0RGYVBPbFVpdkh6bHZhZTk0SWVUandyTjY5Qkl3bDIyTnJZYzhEK2p0MjdO?=
 =?utf-8?B?QlZZSG9rZElobFdoeXR5R1AweGZ1eHZMc0ZYdHBIM1lJb2hDbElPMW5ST1E2?=
 =?utf-8?B?c29HRWY0ZVZnUXNnV0lRWTVsN1BWUVJuSkdqc1I1ZGNRZjdPVi95SHg1WER0?=
 =?utf-8?B?cTdneXpXb3lHWUpBSHVpWFJVTEk2bGRuWENzcmd6U0xVN3Y3TGlFQVhKQmxw?=
 =?utf-8?B?NWFsb0Y0c1FJZWNMcGpVdDNqcVBETzVBZnNkb3Q2RXpDb1dNdmRUK21rWDZ0?=
 =?utf-8?B?dlVqZm1EdFpTNkgwbHdLVzZCbC9YcWlkZHM4VG55QUxaVUJDak5qTS92QnhH?=
 =?utf-8?B?WlMxOERKRitsQ0xLdUhsSE5FeE5ZUkVBZnk3Y1Y2YWhNRUU5U1c1WDRxZXVx?=
 =?utf-8?B?OXNDT3NHSm9GRGJmeStBT291ZzRjdEZsSlZ2VUdwWk9ZM0ltQXFFUTBNYVdD?=
 =?utf-8?B?QWNpdllBdFRpYWxnM1pZWFhOY3orbVRVZG1HMXRidUY0UnlkL3o4YU9KMm9a?=
 =?utf-8?B?dkZmK3o4R2R0dWg4MHVhdFVOYnJ1bEdsNS92aGVNOC9UTE9XeGx5U01rUVRF?=
 =?utf-8?B?ODMzUnUxSlRGaGdCZSs3K2c3MEVla3pIYmVnN2IwaGZYSEFtOGJRcUFOVm5Y?=
 =?utf-8?B?T1RXdks1dmpuMGxOazF5UjZ4aXhJek8yaVF2d1dzOXB4T0UzeGNITnFZcXdM?=
 =?utf-8?B?QkZOakx4QlhMa0gzbVlWNWpzM2tsd0xOYTNkNHk3M2J4Q2s0OU1YNEtrTXNl?=
 =?utf-8?B?czhrM1p3aU1sSmUxTkV3b0lOekpXOGlyYkJ3QVRNVzBka25COWc3Y1pTWCtR?=
 =?utf-8?B?Y2kvVHBmNVNVRkhqaUFraGY1ZTJBd3VFcjdBUHUrTk9BOFgvY0t1NVk3RDA1?=
 =?utf-8?B?MGJ0Q1crY0tPS0N1VGI1MW9KVnBRRGFZWlpLaEJiU1hHR0J1amRTSWJqNHFa?=
 =?utf-8?B?VXFCNG8vZTVXSGx5SVFYQ2IyaHlXVTJldVlMNmJDOXJFS1Fvc2xmekU1cHps?=
 =?utf-8?B?MUFzOXBIV0U0QzFXU0pIa1NrbkQzRmlaeWxwL0RrRXg0OHNUVDN6Y3QyWHZh?=
 =?utf-8?B?YlltSFIvZDV4bWhrS0gzMndxR1dPOCtTbmNvZEQzWXF2QTlVZk9kNHZqaURw?=
 =?utf-8?B?cVhKQ1oyUWJKd1Y5S1hPN25uOCs4YVZHUXlLNTRTQkVxRGo0ZFhuYndIQ0pD?=
 =?utf-8?B?RjgwQ08ySWNNZ2VPeDU0VWFMNFpodVdPdjFIUEI4NS8rOHpsYmdlbVBZckUw?=
 =?utf-8?B?NnBNYkVPTkFpZTFqNVNDOEs3NGVWZkM2VXo5QWtSMlBKYTBxTEtmZGRKNXNn?=
 =?utf-8?B?MVkrVFY5LzRiSURReUpXSTY4RTNpN09qTUhrUUtRMVdWT1g1QjhFTWw2d1Qx?=
 =?utf-8?B?VWlDUkNVWXRzZWFRNHhSU0o1YWRJNnhvWjcvVUxIOXVUU2hRbnVHSk5odUd1?=
 =?utf-8?B?aW5JWm94Y0RISG4yaFVNSlNta255blVDc3pnTXlRcEg5NjNBVnJ4L1VMUWU0?=
 =?utf-8?B?UmIza3JQV2kwZElnRW83R21XbnRRL25QS25nVnEzU1I2cVR0cFZSb0JvdnZm?=
 =?utf-8?B?eXNNMlY1NHMxZU40QzcraDVDQWR2U3ZVVTRXN05JSWtwTlhLLzhjMkhTd3B6?=
 =?utf-8?B?a2QzNmw4MkRHa3pQMDBlaVd0TWRLWWNsQkpleC9Fb0t4ODgzL0JHMFJMMnJR?=
 =?utf-8?B?ZTZhOGN1ZnZ3a0VaR2FFK1cwcUlXYXJzUFh2SGp3SGZkWGZzQnI1dFcrcWl2?=
 =?utf-8?B?eVJpWVA5SFhqYWUxTzNORTBHTWgrSkVXUTNwcnVqdlFlekVlRzk4alZlRnhK?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f76b8e6-0ef1-4972-fc1f-08dc89986ed0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 21:58:16.9447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ffl5TIG8Fm9zpFk3J4jO1c2WPIEOwABLHJ8hxJKXlbN+8OSN5ZMrhVjSsDsBRWa0jUP9HPSGxNP1pofiNBG2M/QV01g3vHfThOwofvht21M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4688
X-OriginatorOrg: intel.com

Hi Shuah,

Could you please consider this series for inclusion?

Thank you very much.

Reinette

On 6/10/24 8:14 AM, Ilpo Järvinen wrote:
> Hi all,
> 
> This series does a number of cleanups into resctrl_val() and
> generalizes it by removing test name specific handling from the
> function.
> 
> v7:
> - Truly use "bound to", not bounded to.
> - Fix separator to use 3 dashes
> 
> v6:
> - Adjust closing/rollback of the IMC perf
> - Move the comment in measure_vals() to function level
> - Capitalize MBM
> - binded to -> bound to
> - Language tweak into kerneldoc
> - Removed stale paragraph from commit message
> 
> v5:
> - Open mem bw file only once and use rewind().
> - Add \n to mem bw file read to allow reading fresh values from the file.
> - Return 0 if create_grp() is given NULL grp_name (matches the original
>    behavior). Mention this in function's kerneldoc.
> - Cast pid_t to int before printing with %d.
> - Caps/typo fixes to kerneldoc and commit messages.
> - Use imperative tone in commit messages and improve them based on points
>    that came up during review.
> 
> v4:
> - Merged close fix into IMC READ+WRITE rework patch
> - Add loop to reset imc_counters_config fds to -1 to be able know which
>    need closing
> - Introduce perf_close_imc_mem_bw() to close fds
> - Open resctrl mem bw file (twice) beforehand to avoid opening it during
>    the test
> - Remove MBM .mongrp setup
> - Remove mongrp from CMT test
> 
> v3:
> - Rename init functions to <testname>_init()
> - Replace for loops with READ+WRITE statements for clarity
> - Don't drop Return: entry from perf_open_imc_mem_bw() func comment
> - New patch: Fix closing of IMC fds in case of error
> - New patch: Make "bandwidth" consistent in comments & prints
> - New patch: Simplify mem bandwidth file code
> - Remove wrong comment
> - Changed grp_name check to return -1 on fail (internal sanity check)
> 
> v2:
> - Resolved conflicts with kselftest/next
> - Spaces -> tabs correction
> 
> 
> Ilpo Järvinen (16):
>    selftests/resctrl: Fix closing IMC fds on error and open-code R+W
>      instead of loops
>    selftests/resctrl: Calculate resctrl FS derived mem bw over sleep(1)
>      only
>    selftests/resctrl: Make "bandwidth" consistent in comments & prints
>    selftests/resctrl: Consolidate get_domain_id() into resctrl_val()
>    selftests/resctrl: Use correct type for pids
>    selftests/resctrl: Cleanup bm_pid and ppid usage & limit scope
>    selftests/resctrl: Rename measure_vals() to measure_mem_bw_vals() &
>      document
>    selftests/resctrl: Simplify mem bandwidth file code for MBA & MBM
>      tests
>    selftests/resctrl: Add ->measure() callback to resctrl_val_param
>    selftests/resctrl: Add ->init() callback into resctrl_val_param
>    selftests/resctrl: Simplify bandwidth report type handling
>    selftests/resctrl: Make some strings passed to resctrlfs functions
>      const
>    selftests/resctrl: Convert ctrlgrp & mongrp to pointers
>    selftests/resctrl: Remove mongrp from MBA test
>    selftests/resctrl: Remove mongrp from CMT test
>    selftests/resctrl: Remove test name comparing from
>      write_bm_pid_to_resctrl()
> 
>   tools/testing/selftests/resctrl/cache.c       |  10 +-
>   tools/testing/selftests/resctrl/cat_test.c    |   5 +-
>   tools/testing/selftests/resctrl/cmt_test.c    |  22 +-
>   tools/testing/selftests/resctrl/mba_test.c    |  26 +-
>   tools/testing/selftests/resctrl/mbm_test.c    |  26 +-
>   tools/testing/selftests/resctrl/resctrl.h     |  49 ++-
>   tools/testing/selftests/resctrl/resctrl_val.c | 371 ++++++++----------
>   tools/testing/selftests/resctrl/resctrlfs.c   |  67 ++--
>   8 files changed, 291 insertions(+), 285 deletions(-)
> 

