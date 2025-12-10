Return-Path: <linux-kselftest+bounces-47351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 938EFCB17FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 01:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7DC330DF7E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 00:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101BA1C1F02;
	Wed, 10 Dec 2025 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZxFRKvrA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592A21AAE13;
	Wed, 10 Dec 2025 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765326670; cv=fail; b=hIUOEGsLwfZji7U4BGwjupgH6er+6dCKlVHJHET8DLsV4d/Kh+R41p51HTTB3tQKPGiyyQ0BfJkGpTBc/3+an9cvTZqb+RN4IavN4jM/6f0bOafrhdh93lvh66km+BGhd2vfdxrfamqmxCAQDactwvZk5Yyd5CyDXGaSQoc/1YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765326670; c=relaxed/simple;
	bh=Q+NuHYmwHqeRzBKdApjs3Wf/cZDToUgX17Lfvgeq6O8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CxbkUhDT0xO+a9Y9JrIDmQTQq83TBAWCU6v7kUx5SWMBXFIcgdsPKh8Ltu2VgWM/18Jfk1ywBg0FD2nyi9hTUeJ91RcHfjCtpVfEaBgRATpBQ6YdBsz9ixr3gSCdXgJnzsLlCSVgT83wD1HVksqaOTlDsxrfNIX5TYC/HA5aKWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZxFRKvrA; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765326669; x=1796862669;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q+NuHYmwHqeRzBKdApjs3Wf/cZDToUgX17Lfvgeq6O8=;
  b=ZxFRKvrAZzBlL7xtU/krebfDpCJhYLboXppfqY4HOMclg4bibAKvFWNs
   1iHvnU4QHVg4Dv1bjAVOTDJ619FbX8KMJSAUpO118q09nIWQ9Njix5XAj
   xxV9BkC/zQxqNRRcZp/rx2h07qB+gIElyx8sviwLjcJH4pByWAnt2OgzI
   Sfth0Cyzv4gBZEajAb3N4jlhFb6C5teze0kwdYZDZojxOAz1HzEAZQBz3
   bjDaEDFO4mHKtQYVEXTAwvVjnyGLVQG75NTHPiz//D6bz6qKXO5BeRqgQ
   SfbABa7zqvNJPTnOjexXIJVSyUWBktUtusuzf1bbCrFm1FUhnWwUHTko+
   Q==;
X-CSE-ConnectionGUID: Sf0aoDsiQ/Oenx/PCV2bAQ==
X-CSE-MsgGUID: On3wBLCoTXaKCl9DyLVtcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="67368754"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="67368754"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 16:31:08 -0800
X-CSE-ConnectionGUID: Y6zxKnVQTW2kn075RcvZ2Q==
X-CSE-MsgGUID: /f6FdiTOQ0SoWn/inA9wjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="196659424"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 16:31:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 16:31:07 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 9 Dec 2025 16:31:07 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 16:31:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxuc0HI7H8cJl0XFGRz/9t1inBGRfJtEqqNPPeSW1ExO/uEE9Go50r1Bup94OABjdPLlQXRdRy9XsCgdgTlPk4zesCGuO3QSzqQYEheTgQn/oAII/d8N5cDMFOJysiBy+eM+nQHvAY/t8nOjmxmUNkVMY16wsEkEbw2P76AQSOjvX58a+HGkZd46X5lipyipfPFuwVn39oFZFciIga0vk9x3SMI8K3voYSzp5AJjlwlVqc8OWQjtgDDJA5MkCoykOop1ZqeFf23U4hrpV1MlQ6pfCQXXnaFaEIw4cxmhQYiIgi5a7Q/GIbnfVoxEUejFyVz7TvBKTyhtCoaIT8BDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aur6st9wN1G+wm5TazxplzN54txePpOq4krXKZHh7sI=;
 b=s0KYkoyMFmswREpuOyrA758ENK6TnI7BLUpN6gV7bn2F/Mop3mJHR7G9pVWw8UA08WRkEVljduZlpaniSE5bCOiLqn7eV7OOYUTotpSIrpNAW8fTysst7t4gPE//JSjoh/9ZBL44KxFD9bIxx5DCLEFcT9RWKftONVO4+9DTf0/8+7Kzuaud7wCgOIC+z9lIJIGU+CXKb27YwrSp0u7VeZH5jxvKkE5Qp1xE1wOCyEDEsFe976vhxRuSGqhbJ1MMZdshe+qnsw63GIq4p6hyinIuSTl0SgGJSEPUnO6woh4VaLmkBZlM1L7fxzmX1kt+xQKBFmJAz12+NTuJrzkitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS4PPFFAE6AEB4B.namprd11.prod.outlook.com (2603:10b6:f:fc02::61) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Wed, 10 Dec
 2025 00:30:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 00:30:57 +0000
Message-ID: <282c2681-5983-49de-82da-997041881a18@intel.com>
Date: Tue, 9 Dec 2025 16:30:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/resctrl: Add CPU vendor detection for
 Hygon
To: "Luck, Tony" <tony.luck@intel.com>
CC: Xiaochen Shen <shenxiaochen@open-hieco.net>, Fenghua Yu
	<fenghuay@nvidia.com>, <bp@alien8.de>, <shuah@kernel.org>,
	<skhan@linuxfoundation.org>, <babu.moger@amd.com>, <james.morse@arm.com>,
	<Dave.Martin@arm.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
 <20251205092544.2685728-2-shenxiaochen@open-hieco.net>
 <6d68f2c5-4011-4188-bdb4-27f0e6a4d13e@nvidia.com>
 <f2e30c0b-018f-4988-a1ad-9ead6af7994d@open-hieco.net>
 <ca161ef9-c9e3-498a-9e6a-aefcfec46dea@intel.com>
 <1ce7ea26-6e97-4640-86df-c8dd3e623002@open-hieco.net>
 <d713c903-b8fd-4909-a520-6426fabc003a@intel.com>
 <aTizyW7R8Mqj-lSJ@agluck-desk3>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aTizyW7R8Mqj-lSJ@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:303:16d::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS4PPFFAE6AEB4B:EE_
X-MS-Office365-Filtering-Correlation-Id: 831da31c-d50e-438e-ec5d-08de37836334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDN1b254NEZ2cXJHM0VqYXFvUmJDbXc3Nk9RNGMweTlZUXRiQXF0VlIyZHdE?=
 =?utf-8?B?NUxqSU9RQ2UxNEVjejNqNjM5M2tNVDRHdk5tc3ZLZklCc1BING5QV2pJc1FI?=
 =?utf-8?B?SkFoczBzUGdzUjdxTnRoUlhLK2Q5ZmFUOXlBU0U0VFpERHpBZXg0RzB0ckU2?=
 =?utf-8?B?L3RPdVR3WDVuKzlVMVNacTdkWVJLS0tzMUlVSDRhd3dncjNOVmpGTUR4MmRu?=
 =?utf-8?B?YWFzSjVod0lmOWRvZURkTWxmZDV6NkdubERZalJwRW81MmNEczNscUpaL1ZL?=
 =?utf-8?B?eHBHZlozbGlhdW5tUHpOKzZtZlZseE9mUERjRDAweE5tUWlOWk4zU2Y4RldO?=
 =?utf-8?B?QVZpalJ4eFhRQ1ZXQ1hKam9QZ2NZa2hFcmdJQjF1MWFPQlZ4bUtJZjUxR000?=
 =?utf-8?B?TVh1NThmc1JmQ2NkOGlkY0NhYklNbzBDZzBWc1VpZER5ZXc3ejdZbVE1SHFI?=
 =?utf-8?B?Y2dNemhENWI0NFpFQjh4OC9VNkp6S0hOanRpODFiZ1RUTnptUUR5SVExejVE?=
 =?utf-8?B?Q1pVSjlCOUUvRDltaUpJQkRPbUZtWGluQmNVM2FZRGFpQkNqMDlJckVlS0VS?=
 =?utf-8?B?UldTaldqZStERHZoSkNGL1lZN0tEcms4Y2pQcXhEVmNlVU9ialR0cDdGekFO?=
 =?utf-8?B?WmFRS2RLNlozdWFla3ppM3FGK3A4aEdzQ2JZQkZvRXArbkpPSFpGMzhMemtG?=
 =?utf-8?B?RERxYWxEdHF5OGczZ1ZpcFc5RjMrZ3g0TkI0Z1BSYk10SjNoWXhzU1JVQkox?=
 =?utf-8?B?OWFaSGU1UVhuQkdVUzRjTU9MK3haM1l3dWJZVGNKWWx2QW1uelpTbXVDTCtE?=
 =?utf-8?B?MHM1L0NlKzA2MjVvYTJ2cXloazZrOExsY1NXN1k0Si9YMitlRWZhTEpZL1ZY?=
 =?utf-8?B?NDFEVGRib3RTUUU4TmZQQkwzK2JGTERCa1FxRU9vZ2lwMjFXT3FhS1hhRy8r?=
 =?utf-8?B?ZHBFTWhBRCtWZDNOZ2l2SnpKUHcrRHRXYkk5ZFJUMkVJVitvbVZnL2NocG91?=
 =?utf-8?B?NC9WK1FhZENrNW8wYklqN2Izc0dmWGNjTFhZNjc5ZjdXeEJ6N1ZiaS9FSk16?=
 =?utf-8?B?b29TeFQzeHdYTWE0TDB2a1lVc0tVek0zQjBxZ2c0Y0NJaDRON3I1Rjc3ZnN2?=
 =?utf-8?B?a3k0SFFmNDhHWDFWL3IxdTFhMmhNY2E1bHV4RTVMTFg2eWxLMXJETEFQQ0d2?=
 =?utf-8?B?UnNQOURSaElRbXhYZUpNaUU0SVF5c29DR201SnlGdEl5bElSYTB5VGJuaDRi?=
 =?utf-8?B?RlFDdWpWT3dYcDdScjVESzdBaUVSb2hvNTFyb0NadXJuc3B3YmR5bFNwQkxQ?=
 =?utf-8?B?WmordDBSVk1FZGxnVThCbGFQZCtqVDc2TnNXenBwa0FDSngxN294alNjekpj?=
 =?utf-8?B?eGdZaEZvSDMwV085b2pOQzhQWm1yQlJsMnAvL0dMYi9qWGozSWs3dC9KWTQ4?=
 =?utf-8?B?QWdGd0tzNW1NdHFBMFBPeTlrb2FDU1B6VFFFZkt5VzFzcFpmTks0R0UxRWl2?=
 =?utf-8?B?MG1sVXJNRm9qbCtLTWxVQWNPZUQ1NjBEWkFOWEJNdm0rdHhmZ2J0TFdaZUQw?=
 =?utf-8?B?U20xaUhOU2RxSlVJV2g4WE5QbmJuQWptbHlxNERSU1VNODZjMjVXVUIyMnJW?=
 =?utf-8?B?TGRFem9ZcFViVzBiZm9DblFOSTdNVUxiTGt3WExDcjhLdnYwY08wMm9MMHor?=
 =?utf-8?B?SmZmV0dMSFlSbVNodEZTZDRqdnpobmcreElMZ3RwV3BDb1hIdXBOT3J0RXFu?=
 =?utf-8?B?TTdjZjBqYXI4U05EZEY5NTlRZldkUHFYalduTk5BQmZ4R3RxQURaR1l0VCt2?=
 =?utf-8?B?QUE0TU9MWk5PN1ZmbW9ZM0wzUFFXbVZJVkFmd3R3MkMxVjJOUmdlYmVUU09w?=
 =?utf-8?B?am9HckdNN0xaVkxNNGF0RWJnMkp6L3FiUW9kY2pKT2Fqc01EeEJSeUowTlF6?=
 =?utf-8?Q?jQIp2gyU9sufELPvjBijnqM9Dvum7bec?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEo5M2QvbUxCb0pHWFhLcU0zV285d2VJUHA1Qm1rd1U1WmlzV0N4VzJTbXJu?=
 =?utf-8?B?VDVGK0ZNbUlQVy93ck5yR0EwN0VrdU9HdHBkdW1vMHk3NWVhSStzMFBtTFJ6?=
 =?utf-8?B?QkN2SE40UlU2c2gyMm41cnQwaGJ6VEdiN2VaT0hDOUQ2czljZmRmTVYzWWFO?=
 =?utf-8?B?RzFEVk54YnVNcnNBaVkzRGpZQlUreDJTcHNITlkrbkpPR3J6aUV6WjQyeXVF?=
 =?utf-8?B?UURIVm5JNjdta0NDUkZtSXE1T2IxWDVWemExZ01DaWdwTW5WQnVaeGwrM0w5?=
 =?utf-8?B?angvN2Rod1d5ckhHRjlHTDd5UG8wY1ZHK2g1YXdKa3YveEJWZUFLMmRVQmNO?=
 =?utf-8?B?dXJ2TStLRlZYTHIvbkZVZTVUU1lyQXN1TmlVWlIwOVoyZGc5SmFqR2h1ODQ4?=
 =?utf-8?B?YitrZ29aZWFJR2xrb3pyVHhiSzlJbEdjbGdaZzZuUDZXWHQxemRLSDFWeHl2?=
 =?utf-8?B?ZzVBS3ZweVdYL2ZQcjhQSWp1T29BZGJja3djVVBtNnpIUGw0YU9ndk5RQTk5?=
 =?utf-8?B?ZmdkZVZaNzNWRk5JK01VdnBtYmc5Z0RUMUVMaE9JSWZJWU9MbUxCdTU2L3hh?=
 =?utf-8?B?K3JicnIxSHNUajUwK1BNbzlHZFZ3cDJOZGhaVndFQnZManRzdVNkanJaTmhK?=
 =?utf-8?B?UXBpVXB6b2ZtWjZqL2dkZ3R4eHIxSFltR0hlY050T2FYbjNrUUJpUE9mV3pM?=
 =?utf-8?B?VDc1aGs2MHZvdGRPWUxJZGs1aWdHbUxwQ2dDNS9tZlovbkZHdExGZkdWM2I3?=
 =?utf-8?B?WkdZakpncDJKRmp1T3hIMXR5Z2hjdzFWZlJQL0JWdGEyb1Y2d0UrQVo1OWo2?=
 =?utf-8?B?K09tWDJIVHoyWExJMldDL0hVOUVjSUttQ1N2TVlIUTJBUG9EYjVHT3ZERWtQ?=
 =?utf-8?B?MzB3Yi85K1BRbUNGaDRXdTFTMEFsN1IrcnIwclNTaEduVDZGUFFqaFRDN3pw?=
 =?utf-8?B?cGtWYWZJaWlKWEhoMkRTcnltYWxrWVo5MTZlMXVrM1ZocGNGd054ZW9Tdmhi?=
 =?utf-8?B?RUJ1NzFrSWRYRmFMQXBlTWQ5ZXlSYzYvRUppTC9xeW1vc2NnS2NZS293MlJZ?=
 =?utf-8?B?YStURlo2QWpqVXYyRGU5bk1ZL21NQmROdXJaYjlQVTcveXNSS09vL3lvbEVM?=
 =?utf-8?B?c3l2OTFsZ3FnYWVuYXJtUTE2dS96cFJVcEVNUCtONzBnVVJkUjc4ZTdnb29V?=
 =?utf-8?B?UFVVMEd3c3RkVVNic0t4OEg4eHhpSThzcFJMRkZ3azg5V2NIUG9DWW4wbHdN?=
 =?utf-8?B?YkIyb21JbjRVaE5IZ1ZacEF2cC93MDZvOVo1MDFCNWJOT0t5K1RXSE1HRnBx?=
 =?utf-8?B?TFdtcnArelMwOTR1UGxmMUpZNXdUWkZhWnBrdTlvUUFoZk9qMUx5OEFsK20v?=
 =?utf-8?B?ZHJXaktmSjlIdTgzTlN2clFUSzFhQVVlVU50bld6NEI1a1NjY0FPSVJsS1A3?=
 =?utf-8?B?Z0xNcWFYYkw2NUg5Vk1NbDRHSkswaUppNFVsc1lmZlliVjF6bFExbnh3cUJK?=
 =?utf-8?B?ZzhoZVNUQWJ1Zk5ZNStwWUd3TFV5dzZmMEZFNXBjOXRBc1hHN1NlMEg5K1hG?=
 =?utf-8?B?UjYvcVNUNlFRcTRjMmJFdmlEcVgwQ3ZBaVdzY3QvWVFxZFE2U0FqS3YreUIr?=
 =?utf-8?B?M2hpdlZtZzJPRk5GU2l0OUdXaHlyTUx6WjRTQkMwbVh1djdpcjVEeE5MSUl4?=
 =?utf-8?B?MzBQU0hOa2lPV0NFSkdjZWt2V3h6QktLL2x1UEEyM1NSZVpiRVBCcit2aVB2?=
 =?utf-8?B?UjY5eG03WmhUSUZJdXlXMGtBb0FOV1dJRUFCZWNiZHcwRmp3eGlObm1jWEVj?=
 =?utf-8?B?dkpEOUlOYXpUSXZoSFBpZzMvb2xYZWU1QWtnNmsvc0l6RHpxQis1QUZyMjF1?=
 =?utf-8?B?V2dwWnFOczBoSnM2S0Y3KzU2Z1VQdm9QUjdvZnBwd0oxaXhVUkNTcHRoOEha?=
 =?utf-8?B?U0RKZGFKbi9oYVZpclo2VlZ2Z2cwQXZPbVhkWWRuVXJBdUZmaFNNNWQ3dkpM?=
 =?utf-8?B?WkFKSjE2bzg5ZUZVSW9IMjRNRXI1ZVdWRFdiT01KT0ZlbkpRTkxrZWdyc2hV?=
 =?utf-8?B?ZklxZlFUV2lVOHM2ZXBBZnhQMzBNZWFEL1Z3MlhSTk5tUktnUnd4MVhSOE9E?=
 =?utf-8?B?aXZEQkZBaGhNWG5OUVhnWklTOGJRUE91d0Q4TUN6UlFQQjljZHdIWXdqcnBQ?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 831da31c-d50e-438e-ec5d-08de37836334
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 00:30:57.8925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zPA6w4zlilsvnqOtQMto9AZZXrDRww+sSbzdKzOjCTqfGvKr2n/gZUlzh8IKVUIhII5O/Z35F/jmHzl2wXt9cxABQ6zaEJiRks4C10PqOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFAE6AEB4B
X-OriginatorOrg: intel.com

Hi Tony,

On 12/9/25 3:42 PM, Luck, Tony wrote:
> On Tue, Dec 09, 2025 at 03:02:14PM -0800, Reinette Chatre wrote:
> 
>> I suggest this be simplified to not have the vendor ID be used both as a value and as a state.
>> Here is some pseudo-code that should be able to accomplish this:
>>
>>
>> 	unsigned int detect_vendor(void)
>> 	{
>> 		static bool initialized = false;
>> 		static unsigned int vendor_id;
>> 		...
>> 		FILE *inf;
>>
>>
>> 		if (initialized)
>> 			return vendor_id;
>>
>> 		inf = fopen("/proc/cpuinfo", "r");
>> 		if (!inf) {
>> 			vendor_id = 0;
>> 			initialized = true;
>> 			return vendor_id;
>> 		}
>>
>> 		/* initialize vendor_id from /proc/cpuinfo */
>>
>> 		initialized = true;
>> 		return vendor_id;
>> 	}
>>
>> 	unsigned int get_vendor(void)
>> 	{
>> 		unsigned int vendor;
>> 		
>> 		vendor = detect_vendor();
>>
>> 		if (vendor == 0)
>> 			ksft_print_msg(...);
>>
>> 		return vendor;
>> 	}
> 
> If detect_vendor() failed, this you'd get the ksft_print_msg() for every
> call to get_vendor().

Right. This is intended to match existing behavior. The goal is to
only do the work of querying the vendor information once. The tests are
independent so to avoid the failure message about obtaining vendor information
to only be in the test that did the original query it is printed in every
test's output.

> 
> Why not split completly.
> 
> static unsigned int vendor_id;
> 
> void detect_vendor(void)
> {
> 	FILE *inf = fopen("/proc/cpuinfo", "r");
> 
> 	if (!inf) {
> 		... warning unable to get vendor id ...
> 	}
> 
> 	... initialize from /proc/cpuinfo ...
> 
> 	... warn if doesn't find a known vendor ...
> }
> 
> Call detect_vendor() at the beginning of main() in each test.

This will repeat the vendor detection for every (currently six) test?
This seems unnecessary work to me considering this only needs to be done
once.

> 
> Then just use "vendor_id" whenever you need to test for some vendor
> specific feature.

Including the warning within detect_vendor() and calling it in each test
does address the goal of including any vendor detection failure message in log of
every test that depends on it. Even so, from what I can tell this separates the message
from where test actually fails though, making things harder to debug, and I expect will
result in more code duplication: the duplicated calls to detect_vendor() and likely
tests needing to duplicate current get_vendor() (more below):

If I understand correctly this would look something like:

	some_function()
	{
		if (vendor_id == ARCH_TBD)
			/* Do something */
	}


	resctrl_test::run_test(...)
	{
		/* prep */
		detect_vendor(); /* may print warning */
		/*
		 * Do not fail the test if vendor detection fails since not all
		 * flows may depend on vendor information.
		 */
		
		/* run actual test */
		/* do some things that result in messages in test log */
		some_function();
		/* do some things that result in messages in test log */
	}
	
In above the test log will show early that vendor detection failed but it is not
clear in the test log what the impact on the test is by being clear where in the
test the failed vendor detection is needed/used.

I anticipate that tests will start to be defensive and do things like below that
would create unnecessary duplication that is currently handled by get_vendor().
	some_function()
	{
		if (vendor_id == 0) {
			ksft_print_msg("Vendor invalid, cannot do <something>\n");
			return;
		}

		if (vendor_id == ARCH_TBD)
			/* Do something */
	}

Just failing tests if the vendor cannot be determined may be an easy solution but
since not all tests depend on vendor information this seems too severe.

Reinette

