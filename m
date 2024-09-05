Return-Path: <linux-kselftest+bounces-17328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CC996E44F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 22:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7059F283CCD
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF672188017;
	Thu,  5 Sep 2024 20:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/WN+0ji"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE7D17BBF;
	Thu,  5 Sep 2024 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569146; cv=fail; b=fxPEM615aqmGccieTOkm4PgZmK+dVEmPGJ4ITs46tEf7si3UGEU5p3GoXnCHS/EEB8ROzXEJMXOprNKtM2GRRwU35fsDHgiwrTBC0xyQZsuN+Gq5Yd46mh9QguUQ2hbLTl1DkYFd1D9qrYxk2s9cDPLBa0CGRBFCR1svbZhRZ2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569146; c=relaxed/simple;
	bh=3wPeSF6dCk6xZlkXdHnBhZLaZL7/LAaHcW+yM64ZsE8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Im5cwlKPGv4Wg+UJxG/pHCzZMhf/UDdvPGiW4AUD0TEhpv8H03MLTBWRt+/V8IwNaIwZh35SyQQbdZ3dNcrzeS+oh8W/4fDI+vcNzGRcx5GWOfKVyOU4VdMGswZ5onH734dAXXY/k+CEVxJMZwBNy1l0iJ6kH5JzLo7mj5RpxuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/WN+0ji; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725569145; x=1757105145;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3wPeSF6dCk6xZlkXdHnBhZLaZL7/LAaHcW+yM64ZsE8=;
  b=K/WN+0jiYBT8J8TtwOTvgrP9fyVy0H+bzI86W8yYHBwJhS4ez5SP8QcA
   bC5fUCm1rGYbILcrmZfCudX6yDGFPXn2OGTsSkAxTHHevDcmgiW5JNR/k
   waQzO89U3N9ISbcR50/NwdVZQAS7xrRSMvlc907Qlp5LoWjyNwPdlvres
   17ILQKkivu+1h20j956oozE8fNG8XyjWtekjXQiH5cWk6v/ZcXNR3E7Zg
   mgk+4I10gEqhNDUInsOQ69EaTh9BrMjoeNybfCD4O7t5sE36V6hENscw0
   kKXVgfPKNkar/4f7jxsO4JA0rphEJ/3YxI58EbJB1VcgwRF6k7wbZhAVA
   A==;
X-CSE-ConnectionGUID: lyM/wLxAQHGJFazbImyXHQ==
X-CSE-MsgGUID: BJQjYQJvRmSvKSplnoB9qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="27239720"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="27239720"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 13:45:44 -0700
X-CSE-ConnectionGUID: sF3YyN7mQsGVFz0r6ckYsA==
X-CSE-MsgGUID: IdDi24ROQ9K76pvogLnpnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70549991"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2024 13:45:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 13:45:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 13:45:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Sep 2024 13:45:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 13:45:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsV2p3dt7/IZ0JHoC6yZoORwd/cU32slGXTX5AnUWmig7vk7lrLRLeWh7Puu3A0SisbjThaN8SPgyGjSlr0jg5/YpNy/tnhQyKGBIZ+ElmtdjDcIjCEpwt/aEtsAt3+Y5lXbR6fNRfmR2/6qVuqy9e7eDw77BNEbyUy7/f7o2nXIU505Jy3Y2Uj81IUiEyuxKSYMMaJ0E4PgvTPNCTqpbv4uQlI/MC/KupyofPWgjbNU5QGM3rhi1RDROVj2E+Axw4qDDr6xNIfFj+dkWD0zT9hgZjfXyQ1gXKy7DwVOPTRatBz2mpgd9uNLqrp1AGLSQFgVwPr3MXpLVtcDUpFlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgt7vBxUpXnERGw6t8YF3AKr5UEADN+8K1+4dHpI400=;
 b=EdqnXK+gZLTlVk2UuzSMiV8ugTvfD92+K2kNy0W27B16tDEopQjpxpD4i6u1UfmeRmWrJRUtS4/I2Lz7kCm9t6JP9h9+O72N7yvB5St7yRGu0rI6ZN7SswtQvGt/8Vhq2dPGCJpoQ5I+BOahj0Sy9hRlUYwTDvGEEjVXUIvxBkGEs950967ZaArqep4qPmGMTlUiVZOP3rg0IbaWQ9eXKX88xuxsZSkXQaO8ZEE4CAwy018Fwba9Ge0m5Jevi0vR2JY/IQqQ+iulE0U/pHF88gz/S7ySt6pAhOuyQO6RHPe86OKAs47F6I/VrYjk++mZTMOah2UoGd4ft7ym1XaKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6391.namprd11.prod.outlook.com (2603:10b6:930:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 20:45:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 20:45:34 +0000
Message-ID: <2af94be4-95f1-48c9-a552-88352cd5d44d@intel.com>
Date: Thu, 5 Sep 2024 13:45:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:resctrl: Fix build failure on archs without
 __cpuid_count()
To: Shuah Khan <skhan@linuxfoundation.org>, <shuah@kernel.org>,
	<fenghua.yu@intel.com>, <ilpo.jarvinen@linux.intel.com>,
	<usama.anjum@collabora.com>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240905180231.20920-1-skhan@linuxfoundation.org>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240905180231.20920-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:303:2a::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 8633e597-2269-4831-19e7-08dccdebb0df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXdCQWJ3Szd0aXY5b20vV3U5VWQrcXV3dWVuOExydkJrbWFkZGVKcmRoWEpo?=
 =?utf-8?B?ZC81MWwxaVJQZ1QvakJRNTdDUzRTTU9YVDY4akp3cnNuUU1ucmlOTnVWNnRq?=
 =?utf-8?B?YjFGQ0hYY2lQNnFqZndxSVVHRmR4bFEvdUZVbFdaaDFSbm1xcUk4TGVENktF?=
 =?utf-8?B?eEQ2RW1YK1laNThTL1MxY0lSK29tcjgzeVJrd3VvcXd2VHZvZDNKS294VDNC?=
 =?utf-8?B?UXVhNTZPQlEvSnJtWHNhUm5oeTZlOUJlajhXekw0UENabU56ZVRlbDl3SThl?=
 =?utf-8?B?RmtMUDlieFhRaGVhd3BXOFkzNTJZU2s0by80cDBUWHBpNVFid0lPUm9CejNB?=
 =?utf-8?B?aUdVWXdPUVlndUU1MTZtWkdSYTkvTXdHZEg3WjRNMmlIcjhsdjhtSHRYcjJB?=
 =?utf-8?B?cVQ3Q1VmQmd3ZFJVbTJCQVNlNDNaN3FhNFByempBUUpLOW5Gc1phNUJRRXQ1?=
 =?utf-8?B?YWgyYVZuQVZ0OEFSTmVWekNMdU1SS1Jmb2xXZ3VJY25LVVFkWG5OdmQ4QmJD?=
 =?utf-8?B?NU54bzB1cHlJSmpnTFhya1h5VnhnSnlxbjlnbTM5empYNDNnV2k2cktaSEdu?=
 =?utf-8?B?TFdjWFRONkd4WnZ0UnovNTZ1V0NkODBFTFJRWklzcE0yQ05QSWx5aXZFWkcz?=
 =?utf-8?B?WGxqT3Jvbm15Z2tBUnZoaHVzRFBIYVlkTEwzQVJnRnk1cTN1K1dOTnpRRi9v?=
 =?utf-8?B?KzYvclZBNEFOWm9wSUtpbjBrS1NKM1BCKzN0QnNmZXdqZzFwS09RdWxPNUE5?=
 =?utf-8?B?QzhGNVRZaXBPblQ2Z3hRQ3VmaVRpYmsvcTROSElqZ2NWQzNuejEyRXFoa2JM?=
 =?utf-8?B?RzhjSGhmUEhjMGtyMWlCVWJNVUZSdDRyRlpwS3lHdWhXaWRXdnRZMmtzNith?=
 =?utf-8?B?MjZpc2twOWMrdG5TRHBBNm5kdUtiUHcrOGdMRFg1YVlyalIyQ3dIL1VmMHVY?=
 =?utf-8?B?RU9xdm5nTnorWjdFd2xWc2szSGYzYmEwamFLbnZzZWJQUGFRYjFHZFljNGlD?=
 =?utf-8?B?aGFYQjhOY0V5UVh2ZGJjMFlDSklzTHFNQlU3ZTllSG93NjJ3bUZuaHNaR0M3?=
 =?utf-8?B?K2lFcjE2RHBOblRtOUgvdVJ3WVNzSGcyQWRzQjhZVGxPUkNTNGY5NEJQQ05p?=
 =?utf-8?B?cXZncnlDTWMxZGx6RWt6dHNNZzBzTFkwYmJYdEJsRGthWkEzTWtRYUx4eXhH?=
 =?utf-8?B?V0ZnZDNmZGlzV0ttRkJLenI3TCt6K29ZOWVJdjBPYUpKaUVWSTBONERZSzl5?=
 =?utf-8?B?eU9BVDFKSlBidzRmZEJzcEp6cnh5eFJaNnJhREt0a25xTHVETGo1cXBMS2c4?=
 =?utf-8?B?WlJFbm93TExRQXNpa3B6cnVXWUNySkxkd3l1U1RxZmlsTGUrYU1OWUNib1FQ?=
 =?utf-8?B?NnVJem9EY2wwVG9wQldpQ3BhYkhTclhTTWFXd05YVUt5bGJKMFNNY1J0SFFR?=
 =?utf-8?B?M2VMRXZQUXFqZWMzL3Fsd0JSWWkvd0t4WTRXaVpUSHArUjdLSW1JOVppM1l2?=
 =?utf-8?B?OG4vUTFkSHZBeitUcG1LdXNRREdlanRsRnFCRTlSeXB6VlYzRjhGYllnZVRK?=
 =?utf-8?B?UkthWFAzZTdIbTUvU2pPbTQ3VHZJdVNSUStkNkZZbUFlYlM5YlBIVWkxR2lo?=
 =?utf-8?B?aHkzZEptdXdDMU5saG0zYVk3L3MxTkE0enl3MlNDaDRzcFBMNmVRZW5YN1R6?=
 =?utf-8?B?Ty9yRE1GcmRBZ05GTGNkNXZUbEZiVTZiSDZ2YzN3SFFSNjVkTXJFV1NpTmd3?=
 =?utf-8?B?cFNLTm45Ni9qbEptcy81d1g3Nm8xSkRaSWp5M1dRNHBSaTF0dDRhM1JEd3Fj?=
 =?utf-8?B?ZTdVZDZBZ0RZcTRyU2xaZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0taKytFdXBOaWI5YlNkaWdEMEh0N0ZoeFJYMzRZRG1mMkJmZDFwTjVTbzFC?=
 =?utf-8?B?cnFYV2p0L2M0ZGxhOWEzamRGY3hsczFmdnFITUU1N1NRSUkrbm0yd25nUFBw?=
 =?utf-8?B?dDJTOHNnODg1SExVcHpJcU1aZEIydkRHandNd3FoU0lCaUJBYWhidk9CT2hZ?=
 =?utf-8?B?cHhRNVJSMU5uck5OK0NYRWRhcU40eEg4RzVrUFozb2VPZ090Q1Qxc2ZSWk1D?=
 =?utf-8?B?OGp3aU44RG9SakFBMUp2QlpIVVpibWhNNkJjUUxmVFVwMnhCL0V2V1ErYnA0?=
 =?utf-8?B?SWFDOThHMnhHWS9XemVxdHlRaU9PME9RcFBDeVl2VUlTcmVEU1ZiWlloQUFE?=
 =?utf-8?B?NWV5QjQxVm8vSmxnMG5VTmdXQnZwam5NanloajlNekNjYVNvSGFBcDAyeER1?=
 =?utf-8?B?L0M0TEQ2dDkyL211cW54UXNqZ2VNbzV0QXVlZHA5UVFpTFdpUkhqbDllSGx3?=
 =?utf-8?B?WHJBalBYVW5xZkhKVlFTTzEyRzhvY1BHVmtRSDVhYTBhVDdmQ3FPeXdNK2dz?=
 =?utf-8?B?NE9BUHhVTkR6Wkd0RWtPRUNGbjJTOUJCVlpTOEE3OW1oZEtzREFGUGdMMlBl?=
 =?utf-8?B?VnJ5RE8vcWtFZ0FiMzJpOU4zb0tFZUZ5UFJHNTcyK2xRZEZRZmc1dVVvSmhB?=
 =?utf-8?B?VXZWM3hEV1VmbWZJdXlGeW1UUlU0dkQ2NjhGRlV3Q0htYjNiZmxta3BseVll?=
 =?utf-8?B?ZzdiVWdobVVUZFVuMUZTcXViT3pRWDBlNm5rR0trSXJwZVNYR3pROUFMRjV1?=
 =?utf-8?B?QmZqcElZL0dGRko5YzBaWlVwYi9hOU51T1hORGJ6cWJiTlRhemVVMXVtQ1VV?=
 =?utf-8?B?MDN3dUxjalZmMXR6WUFmTWhlRy81K05wRXZaVDJTZ0tBUis5dE9tamtrUW5O?=
 =?utf-8?B?TkNOSW43Yjh2RnkwUDMrZTRaZGNrajRPamJJOW45eE5iTi9DU2ZtM3dOYjdP?=
 =?utf-8?B?Mld1UFNPdmtlOS9kYVZnOVZzQ3Y4S2kyZGZoaXZQdDdZR0dzS1hkdkZNNDFI?=
 =?utf-8?B?N3gwRmVGN1hJOE01RVkreVZveGNwTXhFNTF2K3RTbGhoMzl3U21zTTVhaVlv?=
 =?utf-8?B?UFZGSG41SkQ1OGlPNmFTc1pTU2VqRERoYWRnYUpNK3VTL1FHRHZkMlJ6OEkv?=
 =?utf-8?B?dUtJamVCay9jQnVYWG04Q3FvbitLaTg2L2tFbFhuZUlpbzhjWWZEN29yUHFs?=
 =?utf-8?B?NmUrSGJJM2w3QnFsM2kxd2kzUHdEemVJVllwa1BSZlVIMis0ME1FU2JXRk5N?=
 =?utf-8?B?bXFGVEN0UGFNcVlsSkRKOXZ1c0t5TmxRK2o1UDRhOUZ1MGVQVXM1alpoZURZ?=
 =?utf-8?B?c3BQTStTdkFCSXpGdGtoWW5hT28zNWFza2dqK2dlUFRoNmd3Q0dmUjhHSUNl?=
 =?utf-8?B?dnF2OFcvSzA2aDE2cmw0ZWMrSDZCbFdxNzBvTjJKSnJka2dHb2hjQ0tjcW4v?=
 =?utf-8?B?aWZ2MlhPSS80NSt2OFpVTmlvNWhXVGd5Zlg0c0wvVldIK2N2Uk9MN1Z5ZERD?=
 =?utf-8?B?WUxhZTYzWTM2VnF4NmVUYkcyaHpZSHgvaUJITmQ0VnNQRzdUZmFDejRrWkpW?=
 =?utf-8?B?TXp6MWhjcUd1Q3NDQjZFRUxlVDNnRnNlRmNPZ0Q5Zk9SZXdkMXlXaGc5aVhm?=
 =?utf-8?B?MmVYVkVtb3lKcHNVYUdycDR6NGkrcW1DY243a2dsTElCRGFZOWNFZVgzOXhH?=
 =?utf-8?B?Q0F4dk5taGRqYnMrS2dKa0xOZUppWmg3TjhmS29jY1ZDRVp4WHErbDRmcHBX?=
 =?utf-8?B?bUxLMzQzNWNhenp2UnMwNmJTVlYzc2RnVUFndXhrVlh0SzhpZmdCTHl0aStS?=
 =?utf-8?B?L0tEek5zQlNQSVRDcFB1MEpNdjJxSk50OUcvQlQ3eDY1cWRzTUZuRzVpZVNr?=
 =?utf-8?B?ejM3SlhON2VWemhBS3BSeDRaUTNJMXUvNE80NE4zQW4zNklVbVgxZ1dSQjFp?=
 =?utf-8?B?K3VuSERGUmZhZW9ENzZjSDcwcm5rdlZKeVFUQncwMnp4N0NaTXVBd1p0bmw4?=
 =?utf-8?B?elQ1c0hxU3VUT200Mmp2ZHh6NWlDT0xsVjhLUndLaWowcUxwR1lFc21wWnE0?=
 =?utf-8?B?VnM2ay9VRzc4b2tySjhxV1VVSUJQTzZYWnNtV2FRQjB3VWVkSjIzV0VXS3Vq?=
 =?utf-8?B?b3Z1dVNpYms5eXEwbVc3Y3VMQnBsUS9OTjdtZEFtMDZJd29Pa0orOXpvN2M3?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8633e597-2269-4831-19e7-08dccdebb0df
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 20:45:34.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzTQHfPZHEyO0eUKrw7UxDpoHFa8oFavpzIt94I8vztkh4wUsTVnGU9odK73yBil5ezLH2AE1YFCVnumHycnj+/Ipa4wN5pFTmBTY8s6TME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6391
X-OriginatorOrg: intel.com

Hi Shuah,

Thank you very much for looking into this.

On 9/5/24 11:02 AM, Shuah Khan wrote:
> When resctrl is built on architectures without __cpuid_count()
> support, build fails. resctrl uses __cpuid_count() defined in
> kselftest.h.
> 
> Even though the problem is seen while building resctrl on aarch64,
> this error can be seen on any platform that doesn't support CPUID.
> 
> CPUID is a x86/x86-64 feature and code paths with CPUID asm commands
> will fail to build on all other architectures.
> 
> All others tests call __cpuid_count() do so from x86/x86_64 code paths
> when _i386__ or __x86_64__ are defined. resctrl is an exception.
> 
> Fix the problem by defining __cpuid_count() only when __i386__ or
> __x86_64__ are defined in kselftest.h and changing resctrl to call
> __cpuid_count() only when __i386__ or __x86_64__ are defined.
> 
> In file included from resctrl.h:24,
>                   from cat_test.c:11:
> In function ‘arch_supports_noncont_cat’,
>      inlined from ‘noncont_cat_run_test’ at cat_test.c:326:6:
> ../kselftest.h:74:9: error: impossible constraint in ‘asm’
>     74 |         __asm__ __volatile__ ("cpuid\n\t"                               \
>        |         ^~~~~~~
> cat_test.c:304:17: note: in expansion of macro ‘__cpuid_count’
>    304 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>        |                 ^~~~~~~~~~~~~
> ../kselftest.h:74:9: error: impossible constraint in ‘asm’
>     74 |         __asm__ __volatile__ ("cpuid\n\t"                               \
>        |         ^~~~~~~
> cat_test.c:306:17: note: in expansion of macro ‘__cpuid_count’
>    306 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> 

If needing to know where this fix is needed, there can be a:
Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")

> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Perhaps:
Closes: https://lore.kernel.org/lkml/20240809071059.265914-1-usama.anjum@collabora.com/

> Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   tools/testing/selftests/kselftest.h        | 2 ++
>   tools/testing/selftests/resctrl/cat_test.c | 6 ++++--
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index b8967b6e29d5..e195ec156859 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -61,6 +61,7 @@
>   #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>   #endif
>   
> +#if defined(__i386__) || defined(__x86_64__) /* arch */
>   /*
>    * gcc cpuid.h provides __cpuid_count() since v4.4.
>    * Clang/LLVM cpuid.h provides  __cpuid_count() since v3.4.0.
> @@ -75,6 +76,7 @@
>   			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
>   			      : "0" (level), "2" (count))
>   #endif
> +#endif /* end arch */
>   
>   /* define kselftest exit codes */
>   #define KSFT_PASS  0
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 742782438ca3..ae3f0fa5390b 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -290,12 +290,12 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>   
>   static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>   {
> -	unsigned int eax, ebx, ecx, edx;
> -
>   	/* AMD always supports non-contiguous CBM. */
>   	if (get_vendor() == ARCH_AMD)
>   		return true;
>   
> +#if defined(__i386__) || defined(__x86_64__) /* arch */
> +	unsigned int eax, ebx, ecx, edx;
>   	/* Intel support for non-contiguous CBM needs to be discovered. */
>   	if (!strcmp(test->resource, "L3"))
>   		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> @@ -305,6 +305,8 @@ static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>   		return false;
>   
>   	return ((ecx >> 3) & 1);
> +#endif /* end arch */
> +	return false;
>   }
>   
>   static int noncont_cat_run_test(const struct resctrl_test *test,

Thank you very much.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

