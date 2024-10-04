Return-Path: <linux-kselftest+bounces-19076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABAF991248
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 00:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1741C22E84
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 22:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6495F1B4F2E;
	Fri,  4 Oct 2024 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l2vl0oSc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2EB1B4F28;
	Fri,  4 Oct 2024 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080704; cv=fail; b=B/zcoqhgTV/lYFi9WyvzIL+t9o2/GJtSEkNFdvMEyhnROvHs5ci5/kTFpxOXxsbV6I5o8G5hbfiwgGhbIf9GPyPX99qvSlphniPGgVj8z0zyEjSK5IM9xgReV2sBwEdiscelgBh9r4UnbvNIynXrNhPEYq8d0Kpobkr4G42An9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080704; c=relaxed/simple;
	bh=iR5eIxRcXUcKTArpVIijIiSuKGYG7DnkIgmJ19MHeD0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Aappyz1ZpW5X3exsK3iTIxgqf6voDkyV4CiSa+cim4MY4TKHMztUzdElgBGqCsX67rsTo0DZIIHvG8A1zspfYaaiyul4Oujlp2DYTOs+zXeLqYMk6S2LYZzP2r46mjtOypWzbxT4kwQ8LzTqRaIVSwfLKvNeswSFNbKVPS7PHrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l2vl0oSc; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728080703; x=1759616703;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iR5eIxRcXUcKTArpVIijIiSuKGYG7DnkIgmJ19MHeD0=;
  b=l2vl0oSc37RV/LXHXBpP62SBKlxBohb+vGmuTfyuQpsdRilUx7ekaznV
   PAeQ+N0Ytaj61jkn7SKMZa6ujZ0iDUXLip6j++ZDJ7xFGTFjdG9+/R8ER
   nCywe0tsstLiJE5p9IeDKjJ7hsrjE84mFlCZkbRTnQs89SXG2lYIFMTTr
   gybU2grKuswHKe83E+YCB4kHLUHYBz0pIQFAiFW1zGPI8xCcXFqPmgqiT
   zUeIWcgSAJ/lhnctOVEKVlAKABVaGEtO4Ah1l6dCwqyN7XIT+qnTuuxNN
   vrcedHB7FPUclqz5NOQt0uG67uSd1YVRiRGX+HXe0SpKdieK1dXPaXu4j
   A==;
X-CSE-ConnectionGUID: BGxIWQfsTWC5IhKU2MA6uQ==
X-CSE-MsgGUID: G5QyrTgnTF+4MP2tO4hu1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27447291"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="27447291"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 15:25:02 -0700
X-CSE-ConnectionGUID: aW6eLONTRG2ZBgwhGH4zNw==
X-CSE-MsgGUID: fmOVum5tRpum/L+/S67LGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="75659980"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 15:25:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 15:25:01 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 15:25:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 15:25:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 15:25:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBtL6nrg5+eRiHkZY+2cBFibTTlbockV+fqzyGNiBLpehuFyHkU4dcqc32WY/4A9heUmFRhpNWSrrdm7Vtz/9SW8PoRyqgzJyShAOKMYrCYdkbni9JzY1TPkxE7NBdmuQodvdx8sroYjGLrFhSDG6aw7VnyHD4YV8p8fuhGx85sZIBrZSy4T9OZjbrxaR2LPutqGwU9bwUSRh76EaCPAg0LRy3XxiZvrVfBI91O5iS/+s+IDVItH7IQ+UgEUTEMw7A5FBEQgub/asxlYCkwa8PwjMVhvmUoPkZPxrYLZAyiJujNqamXU2d+06PuSNPKn54gUuix0s+X3HR3kahUmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKPZHizYrZKZeBns/oYtARpcaWgp5n4d64xhyGiLc6I=;
 b=Di8MJZECd6iWzjQCeYzCBEUPi0UGbJHYUl7jZVyN8f2xBR1niwvareKoA08CG5Eu3gHgHHUrqfZgY2xiRVN7xcYnPFDRcI67nLUYXV78tKOQrIf5kuo6+Y32LZSgO3CEayx8S3WTI3ZJstVAPrbidUkmajo5YMSmXr0mmDhc2aM4t+ZWIbuqX+A798yry5RvhHYmjeR8cQKHUqmsy6wYKs94UjbZcAk2xH2FQsf65pYEOsWQH/t4UjJ2wEPWn5qU/ApM7UsFIo8PRhaEwLP+NW6D7QLVUHcIybRUsjRVqpb92/9f/qQt2UnPAVLZ9R9gIf7NWVlt0LQSrZOJEK6IZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB7112.namprd11.prod.outlook.com (2603:10b6:806:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Fri, 4 Oct
 2024 22:24:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 22:24:57 +0000
Message-ID: <17724709-cb1e-4d27-8e02-e5d84f84a10a@intel.com>
Date: Fri, 4 Oct 2024 15:24:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 13/13] selftests/resctrl: Keep results from first test
 run
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1726164080.git.reinette.chatre@intel.com>
 <46200b49e874c69a05538b813852af0e1eeeea4c.1726164080.git.reinette.chatre@intel.com>
 <45af2a8c-517d-8f0d-137d-ad0f3f6a3c68@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <45af2a8c-517d-8f0d-137d-ad0f3f6a3c68@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:907::37)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 9825f37d-d15b-42df-e002-08dce4c360b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3M1Y2hPU2J4YUdKVGpnbEkvN1pqOUw2R0k4S3BYWUlZUW5ETEd5WHNkVExC?=
 =?utf-8?B?SExuQlZ6L043MzRianA3NTdmRVpwbUxoVnd1bnI2aTNlZmJJS2RmeHRMZGtz?=
 =?utf-8?B?L2pINlJ4S0plVzJpWHF5MmxmS1hjNnluR0dwK3dCQUs3Z3EwVUF3cU42Ly9C?=
 =?utf-8?B?RHFCeWRsbUdMZ3VwOCswZXZXcTREV3VpNlR6TUZDMXNYcnkrbmRENEpmT3pI?=
 =?utf-8?B?b2lQVkNhcjF2SEkvRVVRMWNzaWM2UGNxcXFhV1Jkb3JSRDdlUWF5cU9EZi84?=
 =?utf-8?B?SHFZVXpBb3MyK3JFL3VZQUxwdFpJSGxESFlyazV5a3FGNC9yN0tOSW9jT0k3?=
 =?utf-8?B?NFozaVVMMzFRRUdSc2tRR2Q0cytCdEFKbmhrTkErdXViRER2eld5UzB5NTZE?=
 =?utf-8?B?NjNkeTlnQ3kwcXJSMDd2YkY2UmI2eVdxaXdOZ25FNS9rcUFTRkp0aGIxQjJs?=
 =?utf-8?B?UGdydVh3Qythbk9BTUhISFAzZ3ZnMTBZWE5QK2dJdEZyTzJMRWJ6Mlo1M2h4?=
 =?utf-8?B?Wi9QcTFoRTA4NkdKK1AyRkZVVGxTSnd1eEdDUUZmVGZESEVERGZuUUUyT04z?=
 =?utf-8?B?TU4vamRPcG1nek52cFZ6UjI3VlNYOVF2M1VIUnJYNWZadTFaV3VMcHBKMTBD?=
 =?utf-8?B?WmpLSWx2OG9DM1pRZ0MzaUg1VDBxVzdPc2RZL1QxWlNybyswWmpFR2dKOHYr?=
 =?utf-8?B?VXBWTjZxZ3lRbHFaSVRmaE1DbVhsTG9MS0t0UWllbFZiZUhwWU8xWG9GRHhn?=
 =?utf-8?B?NHZsMFV6QStzWUtRejdMTTJGb21VcVAvbnMxRGJVLzFyT1I3Zm90dXZCamR2?=
 =?utf-8?B?bkRaN09JTUNYcXAya3VZUzdYOVV2SlhZQk1ma01qLzU4RG1nekRJamRSa0RL?=
 =?utf-8?B?dnF4ejJnNzg2WnlJZnUzd0ZlR1pVMjVKQ05XcWFvdkVaZUtEeDdjcjdYak9X?=
 =?utf-8?B?WVZUL0ZDK04vRGV1RGRmckZNUER5alI4Z1RXNldoMlpleE9HLzVHcUxZU1J3?=
 =?utf-8?B?dHlrczdZeXhXOUtvUGlRc2pVK2RIa2NZNjR2NzlKZzZwVXVLWFNHNVRQZUNu?=
 =?utf-8?B?TWcxaG1UM2FUdXpDUUxoNzJhOGFLYWZzNHlZdzdScEVYektjMW4wNXN0VFA2?=
 =?utf-8?B?Z21qQmJLWEdHWkdjaTdtVm9rbm1SL0Z5WjN2aVNTb0FUcnoxdEJoUDJMbVVM?=
 =?utf-8?B?dmNVbTN2bjhVYkovZ0JLVDg3OFhxaitMUUN1OWE2UVVSWmUrdmxOUDJXQXY1?=
 =?utf-8?B?OFBXK25xNWVVSHlPZ2FmeFlUUVRpeGxwY0s1aXovVExscDFnbFZWbUNIYXNV?=
 =?utf-8?B?QmJXeHJuNlhWaHowQkliVTNSc1ZsTE53dVFlS0U5eWFIRW9qYjFvSlAza1hy?=
 =?utf-8?B?STZqTVVUclB6bStqTkJEUm4vY0xWdzlFVnc2d0dwdnlkMlovU2Riait5Qld4?=
 =?utf-8?B?Y0dxaEFHMFlibWJjVEJsQmVDaDE5VmdEbWN2VTJqM0VnbWpocklqYU5lYnho?=
 =?utf-8?B?bU9Pc3RBcjhnZnZpTFBmYTR4NDBweXl0VGFwMUxESW9aT0dDUmQySkVFd0s5?=
 =?utf-8?B?WGUvUFRTWkd5enhKeHJBdUpnL3dDanR3TzRmbU16U29QYkJHTlh4WWlML0tY?=
 =?utf-8?B?TFlOUUFDNHFkUWtMZXVGQmhSMy9WWHQ4ZjNqZ25pNFdLbXA1c0ZOSzFjLzVN?=
 =?utf-8?B?clVXS2dEYzR3d2hpMCtTU20vK2VRaytianZhMG16QlJ1RDB2QU04M0ZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUQ5VStJZHdYaklBRERMT01xczVBUFdPdnlSdXhDbEFoT2FqTm5uc2U0T3lV?=
 =?utf-8?B?TG5Fbm1WblhTWXkzcktrSHIrZUlJMmNNcTVqT21Vd2IwSEFXVFM1bzhQVlI5?=
 =?utf-8?B?WHoyYkM1R0JVVldUbTEybjVBOFY0VE9WWTNLZ1ZZdDMwMG9RNCtLUElSMkhW?=
 =?utf-8?B?ZW8xVC9VcjhlWGlZV0tPV1NHWlZFUTVwZGRqcHRieVA4dVI4Q3kxd1dPMEMw?=
 =?utf-8?B?a0gxajRNaFlWN3ZubUJjWFVJQnRhVTgxMjNQSVNGalBDTWFzckFxMUhsaUo4?=
 =?utf-8?B?MHlHR3Q4WGV5cUpUSG9WYXFKa3VHRVczVjVYZy9XYnFzVEhNR3FDcTlZRTAw?=
 =?utf-8?B?dFNuQU1DbEw0RnBiK2lHVVdEVi9tRHY2THY5QzF6RU12NkVIS0dJdXdrbE4r?=
 =?utf-8?B?U2U5NGI0Q1I2VkVNV2tqYWVrbTlZd0IyMlNrQnpIeUFucDdMNXhMemtUV3Rj?=
 =?utf-8?B?OHZrVXA3OTNNOXFkRnFNKytyNFJNS2xhSVVLQjBwU1IxY1dkL2hsY0FickF0?=
 =?utf-8?B?RGlGbnR2ZVczaVpOOC9HU0JpbEllTlpmVklNVWZ1NmFiRUs3WXlXSGFuMUtH?=
 =?utf-8?B?ZEw5azhuZzNNalpUWDdxK1I5Y3AxMFJmeG82Ukg5WENEeWRDQWp1bG91ZnR4?=
 =?utf-8?B?Y001Mko0eWlIenNkMmFudkREVGVyVnJGcEFGRHNDT0dZNE5BZS9OV0hlY0JX?=
 =?utf-8?B?SDcvK3lidWRYQzhCMVVUNUNiWlIwZFBDTUROR2hMQmxDMHFpMDNQT0UyMWVj?=
 =?utf-8?B?b1J0bDNrN3ZqTmkrZVFMMk1IYmhreVBmSFp4NFRaR0pKeHA1bE5GcFB1S25r?=
 =?utf-8?B?SW1yU0FFeWFRdmkrSkc2YktiQ0s2ZlJwWnhLVDVieUxZR0cvNm1nSlpDMEN3?=
 =?utf-8?B?MlBlUWZnS1dCc203dVFSdW1EUUc4S2RrYk1aT01hb2c4QUFya2pkTmlwOHlD?=
 =?utf-8?B?cm0ya2lFTStBeno3aE1QdGlwV044ZE1lUU45eGxBZDhROUU3MndiTUQvdm1Z?=
 =?utf-8?B?ZGpKQ2hkaUFYdXZreDl3Rm5WL0gzVENRRkZKNGwvTkNrWmEyWkRnL3pOSHlI?=
 =?utf-8?B?NWVmb3BOMlNlUmNFRWh4NU1ZdEc2a3plQkJ2MzFiQWlydS9Rc0RVSHVqU3ZB?=
 =?utf-8?B?RDk3eEdqa0tmbzc2WDJCZ0lDVU1rS1VOV00zbVd0dG1NTWhXVVVvRkkvckJF?=
 =?utf-8?B?ZWpRZHRMY0ZPNGM0SUFaN20ybjg5dGRIU3kvcTlIbW0vb3lpa2FoL2xJWjZi?=
 =?utf-8?B?b2R6Z1czRHZlSE5CSjVkT1d1K2JFRTJLSmxxckdQdGp5aVppQ211OGpBeE5w?=
 =?utf-8?B?ODYydlJFR3FUazY2bVB5UWxLNkwwRXBRV0xlNmhpeW95WjVydDQ3WkRGNkg0?=
 =?utf-8?B?cUQycGFRd2dmUzFFaVA0TEVqNVMyRER2NmlDNnp6YzB2ekNJTHBIVTZndFUz?=
 =?utf-8?B?VnhGSTRDOUs0UE1uWnBKUTB4LzZjMCtjcUFBUXQySDlhdEJsM0FwVGpIYkFM?=
 =?utf-8?B?dUxYMkVXYXJxWGZhMmVreXduVm9FL25OMUpTZUVBVmh2Q1FkUHcxdHNlYVRE?=
 =?utf-8?B?dTQ0UEpnWkF3Mk5GZzlSZWY3L0NocXBQR3NEOVBXTCtCeCtESlpuV0U0SFRV?=
 =?utf-8?B?RVBqdVdFYVVqMU5hczJJdzRvSW4xZ2oyNlI1Njg4V3kwWFlFRTNNbkJFR0JZ?=
 =?utf-8?B?NFJSc254RjVvZkJKdC9wYnZIM09FN1dkVHhyYUJRMjdnb08rMGYyL0FPUGVD?=
 =?utf-8?B?M0ZVQzRvdjMwQ2Fub0ZJb2QzZjBWSFNHM2ZOQUErbGdPcGkzdC8xb2lTTmFZ?=
 =?utf-8?B?bnlpc1lYSVBYV3RiZzI0QmZ6VDFHOGhKRXJvVEtmQ3ZyaXN4cnBPU3pQbEJn?=
 =?utf-8?B?aUhCTElNTjRJald3L2hvVGg0TStvZDFVRWVTQTBRWlMrZXNiNVJiRU1qeURI?=
 =?utf-8?B?Y2tJYUQ3Nmx6YmRnNG9NQU1peGEwODBsRGV3QUpIaHdIcHVrVkxDdDlDTU5n?=
 =?utf-8?B?TThOY0I3Z1ZDRm1UeUZPcVJmNEFBcXNXRlpDa05RS1ZZRE5yenJjSmJ4L3ph?=
 =?utf-8?B?bWJYTE1obStXYlVGazRKZkdyN0ttWE1PNVd4UjljaVlaQklrV0NjQXlxMW1O?=
 =?utf-8?B?UjRDNExoY2NjQ0p0Y0F6Um1teHNiaWpGVlVGSlA2N0x6c1VEMi9CMzlhclc5?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9825f37d-d15b-42df-e002-08dce4c360b5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 22:24:57.3080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzbGrcpX90ykU+NHVSYYqmXl6VqCF9qDOEiGj2Z2b7MOZlsNUpPAlkJA9kNgLiGofrEbpLmaD/YcjPN6MftHBO2uBvTHh4Ex+JK2CiAav9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7112
X-OriginatorOrg: intel.com

Hi Ilpo,

On 10/4/24 7:29 AM, Ilpo Järvinen wrote:
> On Thu, 12 Sep 2024, Reinette Chatre wrote:

...

>> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
>> index 7635ee6b9339..8c818e292dce 100644
>> --- a/tools/testing/selftests/resctrl/mbm_test.c
>> +++ b/tools/testing/selftests/resctrl/mbm_test.c
>> @@ -22,17 +22,13 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>>  	int runs, ret, avg_diff_per;
>>  	float avg_diff = 0;
>>  
>> -	/*
>> -	 * Discard the first value which is inaccurate due to monitoring setup
>> -	 * transition phase.
>> -	 */
>> -	for (runs = 1; runs < NUM_OF_RUNS ; runs++) {
>> +	for (runs = 0; runs < NUM_OF_RUNS; runs++) {
>>  		sum_bw_imc += bw_imc[runs];
>>  		sum_bw_resc += bw_resc[runs];
>>  	}
>>  
>> -	avg_bw_imc = sum_bw_imc / 4;
>> -	avg_bw_resc = sum_bw_resc / 4;
>> +	avg_bw_imc = sum_bw_imc / NUM_OF_RUNS;
>> +	avg_bw_resc = sum_bw_resc / NUM_OF_RUNS;
>>  	avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>>  	avg_diff_per = (int)(avg_diff * 100);
> 
> While the patch itself is fine, I notice the code has this magic number 
> gem too:
> 
>         unsigned long bw_imc[1024], bw_resc[1024];

That could be related to NUM_OF_RUNS ... I'll take a look. While this is safe
since both array size and number of runs are hardcoded in test, of course
you are right that this can improved.

I'm also concerned about something like below where there are some
assumptions of external data ... not that we expect the kernel
interface to change, but something like below should be more robust:

static int read_from_imc_dir(char *imc_dir, int count)
{
	char cas_count_cfg[1024],...
	...
	if (fscanf(fp, "%s", cas_count_cfg) <= 0) { /* May read more than 1024 */
		...
	}
}

> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thank you very much for your review. Much appreciated.

Reinette

