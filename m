Return-Path: <linux-kselftest+bounces-47491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A479CB7F1B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 06:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 343923060A60
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 05:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757E427E1DC;
	Fri, 12 Dec 2025 05:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0HmgogQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA198231A23;
	Fri, 12 Dec 2025 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516984; cv=fail; b=AT1a+pKP4f/6xOrQWNQ88tWbb7qDCTQnnPfUL6wRsF+Vap3GSgYphaPowasQtHmF07X2OcERZrW7baEsgvqVcwXjCjzHUGgKWMi4LzGwH9wA5snkMqCxiBG4gsKIB5YMfHSZA9xBzQXBz4JAkVRqlGfiqMYC+pmHO5jURUbbc6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516984; c=relaxed/simple;
	bh=EVeE6ZetX6KS22UncaLww0V9XlmWBzF0W+J/byjBKBc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TvoDKlOYVmOB6ChsZMglTjm/SXIQQWQHiGXXvbrExwXpvBibruEVJXXhtaF36j2diym17zmIbJ3u0Ax8pRrh0JDFft1YguY43piev8V5UIsBm0WQ8EcrjeRuq4E8zEJi4NJW9yBzA7kh50pG+iWbUBHlJlUnGq6MWll3h3RHiQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0HmgogQ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765516983; x=1797052983;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EVeE6ZetX6KS22UncaLww0V9XlmWBzF0W+J/byjBKBc=;
  b=D0HmgogQqe+E1njH5CkecLwqY9Iyy28KsOIQdS1HpCGdBrstVeIHtY5u
   7uS805PKYDEglYnDAtiUpMmkJJV2JvGDAomIJ1HBauZGjwtozbpHNVRQ4
   8iUclck+BeOGo6GE2rKQqVHw+mh4FkWUTN7ZBIeb0yrOj1NCDHCnf/RaL
   wcQIBjj6n4bkDCgCjB3YUH7Q0l2CjaRWFLnlUoNAI7E/1BdzlLzK5cvyC
   H1RD3tBqFUBzLCSTo861ryjjlMRX+zecdd8VMvSFDOYBlM7iJpaVdFF7x
   eAD6VWNhIzB7EAkYw8LoF5dgkbOZENN6KcXzY1fUsKXuyuwgf093EakCd
   g==;
X-CSE-ConnectionGUID: wdPVmo86QFuH3IF4+5xxWQ==
X-CSE-MsgGUID: 774zbPZ9T2uhdWxqxPC/pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="90158212"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="90158212"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 21:23:02 -0800
X-CSE-ConnectionGUID: etPWkvn8S0iZEOgohjC5Rg==
X-CSE-MsgGUID: C2iyJZM/T9+TKxCKuDIV0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="197474617"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 21:23:00 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 21:23:00 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 21:23:00 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 21:23:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnmF2Kc36ONnQEi7Q0PhpMzHEgJaai21LFQnAxUrU6TI9iSPu1vVE+6DWpRiPi8UeRJQMaVKMJtyvKgqJnxaza+6k/bxkFrx5yso+bTb94b31U654hHCevig0bSPQfpm2Hz8DRZDp/OxJxaoD0fxqItGD0WyFywf+K3u/hyd47+xW2naYnX4WLBMBB4IYEyRlqszxOKC9UjtcxGiEBkeWlmK00F06YrU8gjXgIO4SsGW6/OfMbpD2pSRd2J2qhiWJ0iK8vD6vZdzZhhSPBIrjBeW1h1NjbNPJcWXygIDoclXpBQwmHeJ4pdkvTfbC4amYflImXKIGL4GjSKsrfG18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLeL+r2znf1vYScRHat9b4KL7CmfRswluG5+f8RlsUo=;
 b=WOtOXlzANJybnppJA0Yghlp718k5dJB+OxNhP+TvhP6eoVo1OQP+5YAht43fyrLcbtvEZNKZppZjld2tXC/Tc+7QCT8qDWJVJ3zqYqRgQenIwmxxnU4elFFd6D4xx8lZh50UEiojuBOd8P4E+4zcdnGmxnI+o/CNe85lrZDhAGG5e9rlJulD2TcrtDS4RvwXU+MZ6zv6I2U5LWixr3kvnfMR0RayhoOfzoTg47W1fqGuqPttufw+4nchJtApomMDRe/IfnsV+OM3YGMIl5V9H5Wj04zgM3X7Kas551pQSYbITO9FrYvVTlYys3/VOmS/kLuPpiRGJLBM/5jdvIIFaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7548.namprd11.prod.outlook.com (2603:10b6:a03:4cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 05:22:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 05:22:57 +0000
Message-ID: <075748c3-a82b-4e7e-b7e9-6f8900ba2020@intel.com>
Date: Thu, 11 Dec 2025 21:22:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] selftests/resctrl: Define CPU vendor IDs as bits
 to match usage
To: Xiaochen Shen <shenxiaochen@open-hieco.net>, <tony.luck@intel.com>,
	<bp@alien8.de>, <fenghuay@nvidia.com>, <shuah@kernel.org>,
	<skhan@linuxfoundation.org>
CC: <babu.moger@amd.com>, <james.morse@arm.com>, <Dave.Martin@arm.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251211064632.2344393-1-shenxiaochen@open-hieco.net>
 <20251211064632.2344393-2-shenxiaochen@open-hieco.net>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20251211064632.2344393-2-shenxiaochen@open-hieco.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:303:dd::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f5f9129-2c22-4cff-9899-08de393e82b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M24ra1EyVEFLS1J2ckZRUmMzMjAyNE0yZmRzaWlFMGdvMDRLSEtxT2N5QjJS?=
 =?utf-8?B?NjJGZ0FJWitwWUtRc0dBSFJIemh2V243TEZHN1d4Nk14UnowbUpOL3ZNUHh1?=
 =?utf-8?B?L1NzNVdNalpISDZIekVEZ0F0R1dCSUsyZHJHVWhqd1RLNEJSUHB3SGh3Rlk0?=
 =?utf-8?B?VGVlYXkrYmFvNmxGM1pONjUzVmhmMnhMOTF1eVJKSi9NNWhFRGY5N1JtNHVl?=
 =?utf-8?B?STBjV1hKT2xOSjVydkNmWVJiUlh5b2VrN0wzLzBuTTFWa2R6a2FMcnVhMGs2?=
 =?utf-8?B?ZW92bDM2VXZROG5yZGx5KzFEMXk0cTlqMkR0NWZZK2p3VXR4a0wxNGdGL3VE?=
 =?utf-8?B?anAvUHN3QVdNanBudzNQM2tSaDlENExkc2xRMmxWRXN0RDBzN0tqTnJPRTBz?=
 =?utf-8?B?aUVTdm94Z1IzNk54UEJMYythRlZoWGU4WjFqdjkrZkwxOW03MjV6ZjJHVnFs?=
 =?utf-8?B?alZCbThJY2w1elBDYU1ERHJiYmJ1N1BkT2k2TDRjOHlqQVZNYkRtdDZUREJQ?=
 =?utf-8?B?U1B2MDRVc3ZoNzFMSis4ampweTVhM0ZIdFUvbzRTNW9TcUFzUU9wZmF1U0t2?=
 =?utf-8?B?WVZldFJ2T1R3LzFhOFpMUFcycjlqMFBaZDQ0L0VLcWovZDROdko5aERzRFZQ?=
 =?utf-8?B?cHpqN1RMaXhBbkl6S0I1OHdlMHplUytwT1FLZ3p0RWVwNktTcEtjRnZ3RlRM?=
 =?utf-8?B?VkdNSmZCNE90NkdkbG83b1NIMWNwdjRsZlM5cHl3MVZvME9jZCtaMWhuRTFB?=
 =?utf-8?B?Nk5kcGlya08xK1A3N2hjVENUZFlKK0pJVXljbUxpMmtwdk9IK1JMRmtPU0VV?=
 =?utf-8?B?cGpzdjFQVEhwUzh6RUZNdng1Qk0zckdQc0VibWNQaEhXQXRnTGlRV01oOXlr?=
 =?utf-8?B?dEhOZGRPNW9oWWVjdEYvYjQ3VjlNcjhDRkFCNVlBWW1TV1gyN0JtSWV4SlRl?=
 =?utf-8?B?elJKeUhFeXFQZUMyL3Y1Nkl4azluV2hSbTdaSVIweXFpL24zWkVtL0s3b1dt?=
 =?utf-8?B?YjdZb1N3T1J6TGo4UnJnUm5SWlllL09wUWlwNTFjdFJzRHFyL0dRa2VEN29i?=
 =?utf-8?B?czlCbFJ5djhIbzhkakRRVVA5MnlqcTJmdmg2N0hPMVBGemp1NFFTYStPV09L?=
 =?utf-8?B?USswTUt2d2VHNFczQVZGWWp2RWJTK0dEd2lyQ1A3ME4rNGZ4QjN5Nm8yOWRU?=
 =?utf-8?B?UzZaamNDeXVPWVRkc3laQVVlbVVJdCtpa0hXblpMMWtpSVpJeHJWQWxQL25G?=
 =?utf-8?B?YWlMaVlpTStGbk9LeTVPcmc4RGMwQ0lDanZiU01GcTUrNTU0Tm5zSGxLNEJC?=
 =?utf-8?B?UjlOelphWUcwdEU1dXNlaC82MGNXbHBFaEdzQ0xoUWU4ZUZmVWRMZFNsand1?=
 =?utf-8?B?NDdCRGNBYnpNUG56emRPMjkyalQ1TUtGcE5QZ2t5a1h4QWkybEthR28rT2Q2?=
 =?utf-8?B?TVU5THFPcnVGQjIyMnc1by9DZHdHKytteHZud3B5NXU4YmpseWYydnAxNnVD?=
 =?utf-8?B?bnpqNWZ1REwvWTN5dFhTeHhOSFRTNU1wdis1aWpzWDhBdEk4UE1lYW1nYXJO?=
 =?utf-8?B?TEpoT01SQXJieklDUDFQdVdqMnlKK3VtaGZMd0wzTlhzTXVFa3hxaUVmbUQv?=
 =?utf-8?B?VloyMDlSL3FZelNhY3VJZHozRDljZVJ3QmVkSERlWWgrSTdLNGVMK2F6c1pN?=
 =?utf-8?B?MnM3Zkt2Y2ZaaXFmejBQKzR6WWl4ZDQwdWtrMFNZZmNac21FaTlVSHExcXJw?=
 =?utf-8?B?dTM5V0tjNy9GMWg0TENkTmx4RXVZbHFLMzd6SkJrY0l2QVZEZWE1OGpGRXZV?=
 =?utf-8?B?TDRMWTJvOHF0UW9hajgvOFlhRXI4WjBZQitEYVcvdlBWTjZ1K2xNdThBSFha?=
 =?utf-8?B?aktjbHpINTBNdFhrYmRoNjJLbGIzWUVkVkJWd01JNFlkWDRvcmtiR3R1aDA4?=
 =?utf-8?Q?i5VI4eNfvvjWiPasM6+WKTB6AaA1zd6I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2xGcmNIUDlpcnRzL3U2Y2c4TEFDV0U4OEhSWnV1YUJ2NkI3a1Z3SXJjWlJl?=
 =?utf-8?B?WnZvZE9xdVdZeFo1NS9jWnVGZ1B1cHJxN2JPb0lVdFFxc2RYK05XclYvUHJt?=
 =?utf-8?B?NDVIN1hVRFgzVitRRjdEWi9wam90Q1lBOWZtejd3NkZQTzZCMWxVdG1DZlBX?=
 =?utf-8?B?WmxXNlJXSmEwSFFKL2xoUGx5eFhQUHVGQTFmK1pyd3ljSXdFZjNUWXdndlFl?=
 =?utf-8?B?SWUxVEF2RWR4RDZ3YXBkZUdhbGtiYmdxcHF4UHYwNlN5TVV3d0pWR2h6N3RP?=
 =?utf-8?B?RDFMb0dPOERab0tHbTNqbGxkRTA3cHZrblg4a2hCV3pHLzVkMVdmRHg3cXlR?=
 =?utf-8?B?djRpK0d2SlZ6aVJqc0R4RHBKbjJ3MTF4OEY3Y0lRN2tLRXQwR2dDWFA4WUl5?=
 =?utf-8?B?WkZxSWNnUy93UDg4RzhBak12cktSSjBka1FSeGNKblRKakwreUx1MGM3WHNq?=
 =?utf-8?B?OFpxc2F1Ym1aT3JtUmZJWHQ2SmpYR3krdHN0aHZUT2pGWkNhbHFUL2lzSWtP?=
 =?utf-8?B?WncxMFNpT0Y5RWU2Ym9PNHZSeWtPbXpmVVcrVS9ma29zZ2p3TDhoK1k0MHoz?=
 =?utf-8?B?YnpPOU9GQkN5ajduMWRnNUZLMmhQRWRPa2hmcDNYanpxaFZuSzNRWXR3THY5?=
 =?utf-8?B?Wk9GNUEwKzQ5OFJhaGp0ZFZGV2UwMFhsTEIzMW1MNVBuWngydUc0V3I5b3BV?=
 =?utf-8?B?Wjk1R0xXNDE1M052TlZIMkNVR0ZXODN2MUNRdDJtcU1YRmFNdU9qQ0dDWWIw?=
 =?utf-8?B?UlF0NFRGZVRId1RHdW4rem9tMnh1MFl1ZWs1enI4Q1NjOEpkTXM2aElySk93?=
 =?utf-8?B?QUcrNzBHRUhhZWNmT3B1TDdYWnZHZEFhMnR3V3AyMWcyTmo0dkxxVXl3TC9B?=
 =?utf-8?B?VjB3V3hCcmsxMUp2YjJONFU5OTBqdUJSRW9yaE5obUNldTFibHRHall0NXI0?=
 =?utf-8?B?NGdYUFdoancwMHBRWUtEai9pKzlPUVpNVlNHSytpY2VNRUthT2lITU1kWkZG?=
 =?utf-8?B?TjhkZUpHTHgyUnpNTU05bXhnOW0xcit3Mk5XTTBUek14R0hmUjZCS3ozSnYw?=
 =?utf-8?B?TktVVkoybUp5YjZCbTRZTSswL20zUG0rS3Z4bUxWTlBlaFhNZjdza2xaaGJi?=
 =?utf-8?B?RlhEam5ka3V5OGh4SXdRWWROMUtmcFQ4aVB5Zm4zaVRVZTlYSFJVc1BteWlU?=
 =?utf-8?B?SDFTSW9aT0c0YS9ucm4vaHNrUzhHWERySm9uWk15WlJkRzNwM2lJeUtVbUxs?=
 =?utf-8?B?TVRJampkRk1iZzlMTlVTcnNTNWsxcy90VDAzWStvRDhaTndBSVB2K2g3U3Vh?=
 =?utf-8?B?Nk9UbHFXMGticjBoNFZKekJxZmdUTTVaN0pGMlJMOVpEcTJYeHE3aDViTEhP?=
 =?utf-8?B?UFlyUU9idDY4aFFjR2QvS1hRb0I0SFFHMlk0cGRhVnVvOVpWZnZCSFVOY1hO?=
 =?utf-8?B?Tm5RNXRtbEZ0c0srUldSV3lOVFBhZTZ0UWxhcnV6K0c3WVpYSGZrRUhtYkZX?=
 =?utf-8?B?c2dMSmxxWlpLUm5ZSzlMM2JLM3FmdC94NHFTMlRKU1JWUG5qV3ltcVl5UWt4?=
 =?utf-8?B?c0RFTHRGUGlyMktOb0REdUVYSURUMHRPSHpKMW5tYm8zS2lIWmZ6czhYRTNM?=
 =?utf-8?B?WE9YNEZER0liMXZ6bEdqeGc4Q0J4Q24xNVRUVEsrdGhUd3JuRVoyR1ZNQmp3?=
 =?utf-8?B?bEQ4Y2xScHFpRm5mam1Cci9oU25wbG9zVGQ3blNmd2FHdUFOYTlKMm0zcVJ3?=
 =?utf-8?B?L01ub2FscThWVmkvRnFtRHRET3EvNHZ1VHJWRW8wcm40Qm1sc2tKUUtLK2xv?=
 =?utf-8?B?Ym55NTNJSFloU1NzOG80cW92UEsxMnJnOENncDdRQVJUNGhmcHg0emt4SFMw?=
 =?utf-8?B?dDFmNUpuMlNaRmZueSt6Q1hZZVl2THF4a1V2cGFsbmt1Q1U4bDFpT0FXbWQ4?=
 =?utf-8?B?amg0YjZsRUttc2Jwb2lsQXhMSDRMcjhtQ1h0b0VVUU9KbnpZM2N0VlVDdzFj?=
 =?utf-8?B?dWZLc0t1cE1ncXFTR3M1VFZ6QUhBb2tyN1V2Wm9YdFV6YjZRY3VNY1hXdVhU?=
 =?utf-8?B?Q29GM25tZjIzU0E3TUd6akVMdHJVTU9ubGkzaVZDcjVSNzltZlhjTEpnNGU4?=
 =?utf-8?B?K1d4VVI4bHA1dmNuRkliT0FRS1poNk9UQnBwd2tyZlZRcmhWUVhpaWFZU2lz?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5f9129-2c22-4cff-9899-08de393e82b8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 05:22:57.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ptXrpgr+AqQUUiR4CJILAmosPvYAEnanT9eLiSTdjNVqVVQmEl78sYrPDZGcfJVf7c0SJ4Rkm+rxsuXPMumUkUybNnbIFey/8LDHTXwGvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7548
X-OriginatorOrg: intel.com

Hi Xiaochen,

On 12/10/25 10:46 PM, Xiaochen Shen wrote:
> The CPU vendor IDs are required to be unique bits because they're used
> for vendor_specific bitmask in the struct resctrl_test.
> Consider for example their usage in test_vendor_specific_check():
> 	return get_vendor() & test->vendor_specific
> 
> However, the definitions of CPU vendor IDs in file resctrl.h is quite
> subtle as a bitmask value:
>   #define ARCH_INTEL     1
>   #define ARCH_AMD       2
> 
> A clearer and more maintainable approach is to define these CPU vendor
> IDs using BIT(). This ensures each vendor corresponds to a distinct bit
> and makes it obvious when adding new vendor IDs.
> 
> Accordingly, update the return types of detect_vendor() and get_vendor()
> from 'int' to 'unsigned int' to align with their usage as bitmask values
> and to prevent potentially risky type conversions.
> 
> Furthermore, introduce a bool flag 'initialized' to simplify the
> get_vendor() -> detect_vendor() logic. This ensures the vendor ID is
> detected only once and resolves the ambiguity of using the same variable
> 'vendor' both as a value and as a state.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Suggested-by: Fenghua Yu <fenghuay@nvidia.com>
> Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
> ---
>  tools/testing/selftests/resctrl/resctrl.h     |  7 ++---
>  .../testing/selftests/resctrl/resctrl_tests.c | 26 +++++++++++++------
>  2 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index cd3adfc14969..d0f094360e6f 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -23,6 +23,7 @@
>  #include <asm/unistd.h>
>  #include <linux/perf_event.h>
>  #include <linux/compiler.h>
> +#include <linux/bits.h>
>  #include "../kselftest.h"
>  
>  #define MB			(1024 * 1024)

I tried this series against latest upstream kernel and found a conflict with some recent kselftest
refactoring via commit e6fbd1759c9e ("selftests: complete kselftest include centralization").

Usually the strategy for resctrl tests is to base them on "next" branch of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git ... but I notice that the
conflicting change was routed differently and thus difficult to have anticipated.

Since we are in merge window the maintainer repos are not ready for new features yet.
Until the repo is ready, could you please base on latest upstream?

Looking at the series it is not obvious how you want these patches handled though. Patch #3
is the only one with a "Fixes:" tag (and thus candidate for automatic backport) but it is in
the middle of the series. It is usually best to have fixes at beginning of series to 
simplify their handling. Even so, all patches are fixes but only patch #4 has a note
not to consider for backport. Could you please consider how you want these patches handled,
communicate that clearly in cover letter, and re-organize the series to have the ones needing
backport to be at beginning of series?


> @@ -36,8 +37,8 @@
>   * Define as bits because they're used for vendor_specific bitmask in
>   * the struct resctrl_test.
>   */
> -#define ARCH_INTEL     1
> -#define ARCH_AMD       2
> +#define ARCH_INTEL	BIT(0)
> +#define ARCH_AMD	BIT(1)
>  
>  #define END_OF_TESTS	1
>  
> @@ -163,7 +164,7 @@ extern int snc_unreliable;
>  extern char llc_occup_path[1024];
>  
>  int snc_nodes_per_l3_cache(void);
> -int get_vendor(void);
> +unsigned int get_vendor(void);
>  bool check_resctrlfs_support(void);
>  int filter_dmesg(void);
>  int get_domain_id(const char *resource, int cpu_no, int *domain_id);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 5154ffd821c4..08cbd094e936 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -23,16 +23,24 @@ static struct resctrl_test *resctrl_tests[] = {
>  	&l2_noncont_cat_test,
>  };
>  
> -static int detect_vendor(void)
> +static unsigned int detect_vendor(void)
>  {
> -	FILE *inf = fopen("/proc/cpuinfo", "r");
> -	int vendor_id = 0;
> +	static bool initialized;
> +	static unsigned int vendor_id;
> +	FILE *inf;

Please maintain the reverse fir ordering.

>  	char *s = NULL;
>  	char *res;
>  
> -	if (!inf)
> +	if (initialized)
>  		return vendor_id;
>  
> +	inf = fopen("/proc/cpuinfo", "r");
> +	if (!inf) {
> +		vendor_id = 0;
> +		initialized = true;
> +		return vendor_id;
> +	}
> +
>  	res = fgrep(inf, "vendor_id");
>  
>  	if (res)
> @@ -45,15 +53,17 @@ static int detect_vendor(void)
>  
>  	fclose(inf);
>  	free(res);
> +
> +	initialized = true;
>  	return vendor_id;
>  }
>  
> -int get_vendor(void)
> +unsigned int get_vendor(void)
>  {
> -	static int vendor = -1;
> +	unsigned int vendor;
> +
> +	vendor = detect_vendor();
>  
> -	if (vendor == -1)
> -		vendor = detect_vendor();
>  	if (vendor == 0)
>  		ksft_print_msg("Can not get vendor info...\n");
>  

Patch looks good to me.

Thank you

Reinette

