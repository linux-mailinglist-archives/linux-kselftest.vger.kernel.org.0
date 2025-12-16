Return-Path: <linux-kselftest+bounces-47619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58887CC579F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 00:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C78EE3009404
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 23:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A33339B53;
	Tue, 16 Dec 2025 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8vYxk0r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611623BCFD;
	Tue, 16 Dec 2025 23:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765927632; cv=fail; b=Ui8K00Q2oqeTnjmQeQnaPoSLLPyZpe2/Bl6PddhUfrB1nPoPNF8dscnEL9bk7nIkJNRWPCRWY1nIiX5V7O1bHQrqeaaXa4TGp2wRdByH8E+G5X5lXyxIPUyISp8VWv7ucgo+CuAVdA/hh8ArNHtVFpRrmev0rpdBlMO+u/b+GwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765927632; c=relaxed/simple;
	bh=Qm0Kep+MbIxPc5X/LYNDukxhFnETkGz3xExSqoNer7I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I66++TQYOAbzw1n6SMnkj810XwvauV9I2tytlOjU7PDKYQ5vHMaV5+dtvDkMNl2ApKhyICbM6aLEWT+89RRUgtZskiiiujSOp1hqQPuoddodDCrDvAbrlPS6QIzPMLgUpUTuOaBhuLFLQ0xsAxcCqWGCewns3RX3cZsDyzgZy8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8vYxk0r; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765927630; x=1797463630;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qm0Kep+MbIxPc5X/LYNDukxhFnETkGz3xExSqoNer7I=;
  b=e8vYxk0rCu8h1QI7tYxltL83cBT7t15olsGbkQUyXHbXlolaqTIHX6Ti
   N1Hd3ZlAI2z0nRJn7VK7lo1v3Y4Spvkric8senRo3BAUEgUBaHrMWy6Ey
   foGmsohExVGDZC2UHL6AVGLSQo/U/GXJG4A5KyHZTLr8DVd/7/2NpF07t
   PrTZgQg/NwqGAht0+ur9eI7U4qoY1LwEPO0Qt19wKCyGlIJC1UXIqsqWU
   mX1lI/IVes6VfDSsbbifoS90MGP5Pbwv18crLm9xz2Zl+Z8EqBJuxV89a
   +gQOzqfTDEqEJAt64ijIf/yIjtGhE27xT6BSqrLu11z1SlMK01tug1JFB
   Q==;
X-CSE-ConnectionGUID: KLx6VXGcQqKO1I9MqQb7Ag==
X-CSE-MsgGUID: 3CfonDXbQHu7lljpsXSd6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="67053057"
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; 
   d="scan'208";a="67053057"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 15:27:08 -0800
X-CSE-ConnectionGUID: JVy7ZzjGRgiK4DzHGubCcA==
X-CSE-MsgGUID: gbOpRSwKStmfr63lm7ZVKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,154,1763452800"; 
   d="scan'208";a="202536617"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 15:27:07 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 15:27:06 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 16 Dec 2025 15:27:06 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.54) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 15:27:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8h+fm/xzmCP1QjFLfY/VzzJYh28t9emMEr855nqTSNe4ExU/GLA7pH5H+8JSTpTLPm+zf+dsDGC3Gm1pfbQsjHWZ4862doHy7VsVccd1kxr0pj2/rHdG1bCKN2xYLgu0z2SH6TGnK09C8zBsRIwzg/mWhvSlfNyeoin/VYZkE6j7hNcoFgGhEH2Yjhi8ciGFsEtHJYtiCCcodCBhOae5Kk63A0UpKEGIRXpw2OQWBZLNY2xSo5gXK8wuukQJ43+u3N5Nk1q+1B9x47VOEWXi4ML92/TlywX5MK0JcXKezdrXnaek3Kk04uWPDVQq9172AXKRv2AayQmzrc2e5hXCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ER0ikIyY8I6/DACfxq5hUKx6ZBjqh0YLY7C1H5i0GYA=;
 b=qJ8xaY8vr6AAXeIiP6KYlv0nZrI2hYQVX1qm761Yhiyorxclp1xEPng+USJMqXb7IBo/nDHYdGxO9DzDN0lBCtQ1Og/SmbRDPFM/7lgH7WNKkk7ixe/Pkob3dveB5wk5Vk4HzoPQJSYnJIXMnqSa/J+ih/rnzw2SBeMjdWyg1vHbuorRkZZ40HAVZ9t+81/T0pXR88GtuRAFGH5hS2S4k0pvW8jzQMSoCfqVeXE/r4UNnQjsfnxWKPJHdVBKr1+G/79bYHbCFHSU7E2QofL+plenhfhWcZw/JUqzvdabdyu11RhO4oOenJyfdDzBi8kTajlPAN0hTCjN1VvNRr1++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB6128.namprd11.prod.outlook.com (2603:10b6:8:9c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 23:26:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 23:26:59 +0000
Message-ID: <928c9107-22a9-47de-ba4b-bd1fffa749cb@intel.com>
Date: Tue, 16 Dec 2025 15:26:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] selftests/resctrl: Define CPU vendor IDs as bits
 to match usage
To: Xiaochen Shen <shenxiaochen@open-hieco.net>, <tony.luck@intel.com>,
	<bp@alien8.de>, <fenghuay@nvidia.com>, <shuah@kernel.org>,
	<skhan@linuxfoundation.org>
CC: <babu.moger@amd.com>, <james.morse@arm.com>, <Dave.Martin@arm.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251213073811.3016864-1-shenxiaochen@open-hieco.net>
 <20251213073811.3016864-3-shenxiaochen@open-hieco.net>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20251213073811.3016864-3-shenxiaochen@open-hieco.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: f4066f38-fd2f-487b-e427-08de3cfa9c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZytERUtpMStyTjFBWlJhdHJEemRrdGJqcGxpUVo4dTYydGNiU2t2OEk1VUZH?=
 =?utf-8?B?STJNTnFEd3d6MU9vbWhoZHNSZWUxSG4xdXlRN0pjbEFIRmdPU2QxZnk3aU02?=
 =?utf-8?B?aGoxV2dPVkVSSkJSZWxiMVIwejJCVFEwZjc1dVcrRDVUUWJYV3VyS1N4VXVm?=
 =?utf-8?B?MGVobVBkQkZQMCs0Q01QMGhGdzlWTlBTb0VleXBEQVNNb2g4YnJoV1B6RUZy?=
 =?utf-8?B?NnNONVE0RERna04vVTNXL2NmeTM3QVluYUpDZ3o3YTlvTDNBQnNhV1RPUWNN?=
 =?utf-8?B?WEpKa29EeFBsQit5SGhHZXpGL0IrSCtZTiszMExVeVpndEJzdjE1T1hwVVdm?=
 =?utf-8?B?Y3N5NGE1SUo5VG41bnhicDRmUDhLQmtBTGNrdFluaEcyR1BROWdneTl3OG4y?=
 =?utf-8?B?QnU4dW8xNjNOajFTWHREaUU0WlptS1M1ODBzcFE4VzVkUEtWRjE0L2FYU2FW?=
 =?utf-8?B?QWIvWVhVdkY4UmQxZFhKRlJjTTZBeVlLdklZQktXcTdPa3ZMamY2cWN0Ly96?=
 =?utf-8?B?azBxS3hoQXoxcC9uakUrODV4WHA2czZFSnlJNTM0NllvNFd4V1I2TXdGejJJ?=
 =?utf-8?B?T3ZpaEV4TFFZblBHckd5UFRmVmt6SmhLMlAzUVlQNjBmczN1NEpJbzRqK1Va?=
 =?utf-8?B?aGt1THV6eHYxWFF5enB4cXc5ZlVWV09ZdFRTVFQ2M09XSnp1OVpPV2k0NU1P?=
 =?utf-8?B?ZHVJQy9saXFhQUlaNGVXV2dBSnNXVHV6dHFyNmZ4enVUUU5xcWJ6ckVhTGlV?=
 =?utf-8?B?YnJxc1JxbVJzQnB4d2Zhb1cxV1FzY1FzRm4yeWZCTWJoZmpHZHRHeEJWTXBx?=
 =?utf-8?B?NkNpN2I3d1ZtSVllTlkzYWc0VlVpeU5iSWU1cm1yMTYyS2wyZHk2WTZ0MlYz?=
 =?utf-8?B?N3BDUktQUjB3M0xFVVd6ODlMclArWkFGekhONDE0TEwrQThCVjJxNXB1NGU4?=
 =?utf-8?B?UTBYUk1UVzJtTEgzQlltRG9CZkM4bVlOYitDUjJHejFCUXlHUUxwL2oxSFIy?=
 =?utf-8?B?MWxRcFZIWTF4aWo2QWgwSGFDRDhYaHdiUjczZk9MMWhOQ3RCUVd6U01XSVlD?=
 =?utf-8?B?M0FTemIxd25ua2NuU1JrRi9aVWFOb1R3TG9HaDI2YkNjSys0SzB2bXJXbGsx?=
 =?utf-8?B?WlgxNVF4OEdjVjJrbGpOcVcxc0J6T016ODVEQkpxcTNjLzhlbDFoSmp5Zy9t?=
 =?utf-8?B?ZUN6cklwWGFXSEVUYVU3ZEJkaUdvbGZYbDBUNkNVVUdhaWRrYk05TGRpa1Q5?=
 =?utf-8?B?YVRsaFoxb0ovQXFRU1lEbzVJcUhNbmk4ZzhJRCswRWtKeFNPZWtjQm93M2pa?=
 =?utf-8?B?ck00b00rbUNXNXlOdVhVWXdWck9uVVFpZndFNUZPa1VweUhKdlN2Uy90NjBy?=
 =?utf-8?B?a3QwRlA4WWV1ajRBeEloS1pSZCtRRk9FSW9VMmQvOWZZTDFqRFQvTTY0Szl0?=
 =?utf-8?B?VkdHdjFjcWUxSWZaanREczBkeDJGSktpSHU5WTBVMHhseU1qdFRHTkRNcFVC?=
 =?utf-8?B?bGQvcnA1SFN1aHFjR0FuTTJxM0VuWXN2YVREajE5WmtGQWVpTWhzMVdLaXVs?=
 =?utf-8?B?cjVjS0lmWkUwdDNETEpOUHNndUk3RzM4SHBpM3Z4Z1RVaW1SdEJSdG1xdGdv?=
 =?utf-8?B?NmZ5M2Z3VWNrSWRtM0RLMnFmeTVrcFNMeW52UjVhT0JwZmpBclJ0cGdSTldV?=
 =?utf-8?B?bmtCbFZoN0VkY0xpbzN4cjJ6S2dMT0I5NEkzMmFvYllzR2oxelBUa0lzUU43?=
 =?utf-8?B?dkc2L0JlNDdPZFRObmFXTDRrRVpHczZWckU1M0dSaVEvWDdGNmdGVnNsNDhQ?=
 =?utf-8?B?ZkhvSTBYdjUrN1Z3WWE4RW41UUFNQVpFaXRWdzJSdE84ZWtDc0hhLzUyL0V3?=
 =?utf-8?B?MHdtcEdNM3hUYjhWK1JidWNkaHdYS25Xb2prcUdhYlFxYVA2YW1aNXMzeHdY?=
 =?utf-8?Q?q/OdCLJEncvFDTWJskjZDOpuIBnfqQiE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2N4a0c0aXRlay9GSGV1ZUo0V25UT2NrS1lEQnNuTVZLRy9BTDlBMHZYUURM?=
 =?utf-8?B?VFRwT1ZFc0EwdTkyazZrN3V0OWNobkRUZ3EzN0tUUkJwYXkvWkVHZXJqWHNq?=
 =?utf-8?B?UGZydVVxblpQSXViaExacEpVQThOTG1nU3N5aFhVdWtuZ1VzQlNuQm9YL3JK?=
 =?utf-8?B?a3JJRThPQ09Wc1FrWHgxU1oyanBWR0J4RnhJUDVMbHYyT204ZjR3bW9naTRh?=
 =?utf-8?B?WitPZktxQXV1eEhzMjZFQVR0bGJuK0RKY3djWE5NRnNSSjFkcDQwbDduSWRB?=
 =?utf-8?B?WlE2VVhOT3BmWksvQ2FFMUhTdG93STZBWDg5OVNqTysyeG90cnU5VFhqenVh?=
 =?utf-8?B?NHZTa2hsbmpGWmVYUUZiWkVoT2lCSmZER0NvWHB0Qmwxa0ozWXdiSlh3bFNJ?=
 =?utf-8?B?Q2szejFFOEFybEMzOTdYYW13RXdVS2ZMOWx6Sm9wZjZBcTFMMkhZZGFsbHQ2?=
 =?utf-8?B?UHJMOVVOZVk4cWNIMENka2ZYRk54Q2RwdXV5NTRQR2wzWGtpaWpXZTV0TEti?=
 =?utf-8?B?Qm5lR3dSY1BrTU5MQm1lMW00dTh5L2xlL2xUMW1SMytseWRIcGlvTTczMk43?=
 =?utf-8?B?OVJscjJGOURQd2Z3NTVpV3ZNWW9LZmUwa0FsR1I4MDhIQS9NUmxTWHRjbXVM?=
 =?utf-8?B?QVRQMUU4VzhDODc0VldubmQ3eEJrS0xjY2hMQ3drSS9zeXFmcHpjWkJCVFJq?=
 =?utf-8?B?Y0YvZUxFb013NjQ2a1p0c0lwMzNFblFiSWsvTkJPTWNweVhXTDZTMlpscDhv?=
 =?utf-8?B?YVV5LzBrUG8wSm1NZ2Z2RTVvNGViNGY3dzFudjdxUllMdTFvZmdKbWUxSC9X?=
 =?utf-8?B?YWd5NlRxL1g2NHZpS2FNR3BZZCtvV2lOY01TSitsajduSFNiQjFVSnZaM3dV?=
 =?utf-8?B?VFJyRk4wYzVZa1hvNVphL2FGaWNuNlJzSno0ZGdVakZaLzBVaFFrUVFEOHIx?=
 =?utf-8?B?dUJnWUgrN0V1bm1LSm5qQUp0UTE2ZlJETlFpeko2dHdaYlYrMEgxamRtN1ph?=
 =?utf-8?B?QTBRSlJRc1F4Q1h2RENhTUZCKzJWbGljR2E4a3dDVmpWblJNVUF3cE15Z0oz?=
 =?utf-8?B?WDF2SHVMcjR1N2V2bFJZMml2WjJ5S2ZUSHFGVExaM2F5bmJxbFNhRU1hZjhQ?=
 =?utf-8?B?UXh6UWhob0pLTzB2Q2tpOTBvRW5LeTZCQ0JFYmZMcHFPRVpZWHU0SW9EZHRE?=
 =?utf-8?B?Z2l3dlhyYTJZL3BYVFczR3p3WE1GYWFrT2p3NzA1TTlhamdaR0dyY2VEUDRK?=
 =?utf-8?B?Ym9IZGZFMUo4Z1QzVXhiRmVpdjdKeHJicDJvbGE1Vkg0ZEE1YkpmcUIyeDJB?=
 =?utf-8?B?SHNtV3gydm9UTmUvN2N2WnhKdzAxdVE3aHVPbHl3R1VXamhVODNacUhhYzBt?=
 =?utf-8?B?VnV2WkxCZzFBV0g5Sm1wTXhtMVNNNy9BT0lJUnhsQURwUGFGTlNXNnJhd1hT?=
 =?utf-8?B?akpVbjdBaDdDMkd0Q1BLODVBd3k1b2x6blhnZnYrYWZWeThoL2pPdml3YzB4?=
 =?utf-8?B?blJWZXVuVno1SEFTYjQ0cHdra1M1KzlTazVpTVlCNFp2a3pRcUFXUFQzNnp1?=
 =?utf-8?B?UXFQcmZ4RU4xRHNGdHVzYy84eVRvQVh5Y2dPQlRvMEJzRzdQZ20zeEpCdmhV?=
 =?utf-8?B?TlBKaDVQWmhmQjhNNWo3YnVRcWNmalRjRVBKd3hlM0VXU2VBenkvam9aSWRs?=
 =?utf-8?B?TWhpcTVCMzE4NmxydmVudWxybWhIME10UVNPQXRGbytWdWtuVEJwNW1wSTl5?=
 =?utf-8?B?QmNQc2tVTmFjVlFTODdiOFI3YS8yR3lJeTlMUUZNWS81UmtNYWhwdFNwbmlI?=
 =?utf-8?B?UFFxNG5Vbk5ueEpHQXYybHZHMTllSDQ0dUh1bjIrSEVOZWNHRW45TFFQMDZn?=
 =?utf-8?B?ZnJqK2kreHZhTE1kZ2lOdnNhc2ZoOWF3cEVoL3ZQTmgvVTduWEFQMFcwOTMv?=
 =?utf-8?B?dTZXU2lITFhvSnlZbmNzUUR5K09jc2pVdzVIYmMxcDBrSC9NZFFocS9nczI5?=
 =?utf-8?B?WlVuNXBUZTZSV0dRc0wrUjZ2UXlwaFJqb0VxRXlUbHo3UVMrdVJQUnI1YjBV?=
 =?utf-8?B?VHdsRjZ3bzZKb0tFUzVSYVU0UXdYSTZQQ0w1WVNIb1hBSmdtTXF0Z1QyTENa?=
 =?utf-8?B?aThzTVNaL29zMmt5bm0rTmtySkVRYW9GT3FwK2FmNTIreThzWSt6a0pFaW9N?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4066f38-fd2f-487b-e427-08de3cfa9c1c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 23:26:59.2849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vA3nkoGPMMUyNDQ/E4frVlxcD4xVn+TzpK+GJ4FIqhO5a/UDLMniuw+VQjTED/DdHkrKaWuty6TBNir0ApN+uIzd7l9RC8UYWfBBcYTIY4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6128
X-OriginatorOrg: intel.com

Hi Xiaochen,

On 12/12/25 11:38 PM, Xiaochen Shen wrote:
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 5154ffd821c4..980ecf2bcf10 100644
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
> +	FILE *inf;
> +	static unsigned int vendor_id;
>  	char *s = NULL;
>  	char *res;
> +	static bool initialized;
>  

The changelog incorrectly claims that this should now match reverse fir ordering.
To be "reverse fir" ordered the declarations should look like:

	static unsigned int vendor_id;                                          
	static bool initialized;                                                
	char *s = NULL;                                                         
	FILE *inf;                                                              
	char *res;             


With this fixed:
| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


