Return-Path: <linux-kselftest+bounces-12871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9727291ACD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 18:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD16A1C260BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E388E199E85;
	Thu, 27 Jun 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="el4hKOkG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABAA19A2AC;
	Thu, 27 Jun 2024 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505838; cv=fail; b=n3lrk6mZbqBNZzZE0jPWr5Xbi+l61I7DEZyQivcwjV+3vus0xo9fHPpIIVxYs9bKZqXc6vwIS8qBw7YM1bK/2jqOoUZsnb/97462sJvS8mjTlkITxo44MzXbLihMWvLptPLvS2gLTkFazhdD5GhmrDRyhnkfW3qoSOKdwxRhcPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505838; c=relaxed/simple;
	bh=AWdiiJH/tNI4aPJyk7W3yFPAh5UtLV6YedFcMZQNIZA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IqxuBEmQOw9VT6/aZP4vrYFYtYkL96dQACXTvzk89rhp04zjbJq+DWk0W2GD1H/89lJmywW2HflZRYzsvcyL+owV4Li7bvOZbimjs831oJDXeRXnVFPpGbLLWL8pbanXfvXWMWTww8oR0UiyOS5VnkxBgIeS+kBgQdZGSOJdxGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=el4hKOkG; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719505837; x=1751041837;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AWdiiJH/tNI4aPJyk7W3yFPAh5UtLV6YedFcMZQNIZA=;
  b=el4hKOkGStwgFGVz9cNf9m2973FFd+HpeeOvG1ryOZze2Epr6zLkG6kY
   wcKi7Gs5bRTjgzJ7bleIWRoaj+gfXX5bxfj0mp0YQvGkD78LbAi9ETg5G
   3T0YlxRoIgL1GGoPo3pWwP04ChYML7sdBhLkY7uBHNqO6SJYuqP/bgi9h
   qOoATP4VGwWMj76/T83W9jogjKId6UXK1nutBeYRQkkAZrauqyUVrHT1j
   oTGmgHoBJ1/h2hzGHL7tl052yOgwLvxd0+yD25NDkkkUa2bcgcyCU8tDZ
   L/L+Pu+W15XLfpI8FqLNmrSv+HTMSlu0oLJwrLZfRzOMtmu6KTSZqZZVJ
   Q==;
X-CSE-ConnectionGUID: 8wUKF2mmR5yFAz7Nfkr8TA==
X-CSE-MsgGUID: 3aw5w0kBTn6YBZ5ba9RxvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="39168160"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="39168160"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 09:30:30 -0700
X-CSE-ConnectionGUID: L8EqTZKFTviXn+owzKf6DA==
X-CSE-MsgGUID: aOjM5zqJRSK2pHj3L6QfuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="44839577"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 09:30:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 09:30:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 09:30:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 09:30:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 09:30:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih6J/jN0fY1wCG0fKcU0Rm2hOri9UcyHXpA8LR8Vo00SRvmncBJU/Wyb1cQR5yV83JA2Cw4pC6S+Drbo7SMDqykVDn1KetdIFySYSYAZMJqqPr/nL334vPfDgZtTzroyVLPeRCALMbM7dU7r1e8LGs26GAgFrK0qvwuw1DWOuMVLZgqJxiLewbVA93EH051eMqPSXLsXK/uOzmz4XzySfdt5moCxPclLv9UkzIxBkpJWMg62M/+b+ilPKE37N/jXt70blT4pyiXHB4bTIaiQc4ccXkBDvbbfmdYBzGWFekwDb5srInUv/aoCE9/GlbScB1/PIY2fIvVVPkblKeDYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XlnUpyAlDqAUz8NrJtuUp7DQe4fxk0tcVpvP5LOjto=;
 b=W7UBQi2jBa21sMGoy1EIwfe0hV9s0kq+BhzYvG5tmczi5vzMU4ICLJydLXB+SXAslK3D6I0LfQfcawXt9ijU8ljc3+aOtIzMWaJn4WSgfR77tK2nROvqUuig117BGkXxHZYx67d55cYJFaV6qE+PF6aOyZc4Ij0cduz1+3SNHKmUExj+3Uh7mBIaPcvVjGhxDPWMu0T5r6WpMOIiwoboMZze9t2lDMd8k1p5Ksm2JkZh7nGCmYIBYLN1a9h7HhyP6szUfE/yRkkcUshJIXjpxpAx9HqoHs/8BKDPiWGkTeTT3dzpF2/55p6LGjFt4hQje8opBEgcxFFSFkLJirRlNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 16:30:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 16:30:26 +0000
Message-ID: <ded7afa5-7197-48e1-98bb-066b9df285fd@intel.com>
Date: Thu, 27 Jun 2024 09:30:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
 <fe9295c6be677d187b1607185e23993dbfe74761.1715769576.git.maciej.wieczor-retman@intel.com>
 <9fa47acf-86b1-4602-8790-39ed80fd775a@intel.com>
 <n2el3evhluilmjhrwgpkkb7ld2g26zhmctxvm77b3ome6u6egf@hym7rnr3h2o7>
 <9b976e89-0320-430f-9f0f-48e25612ec98@intel.com>
 <b5xggwzdvavhqmxpaeisovp3e2xzjjhvkoqcbt6hg3sv3wzh3i@a7qaatwfpbf6>
 <5bd8e17a-5810-49a2-a07b-88c05ca21af7@intel.com>
 <ewkiaarsl4s4aofw2uykhup3eyutnzitlow3muzbaqqf4xp53g@6lgc5o2dkmor>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ewkiaarsl4s4aofw2uykhup3eyutnzitlow3muzbaqqf4xp53g@6lgc5o2dkmor>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0124.namprd04.prod.outlook.com
 (2603:10b6:303:84::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 902517b4-2cca-4120-c89c-08dc96c67377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmtON0RyOHZnOFNRRE1NYnQ0eWxqYXVNajBrSXkySkN2UTRHdzRzc0JqYkhP?=
 =?utf-8?B?TWRmR0JJK3JuM2tuS3NhSWZrK3NPNXNlU3JoL3RpaFZSZ3JvclFxODJGSzcv?=
 =?utf-8?B?VjBLV2Vkb29OQlhGMC96U0FOWkhrNW5WOUFzRVBQc2JlOUlSdllBQXNBZWVW?=
 =?utf-8?B?bHJIMmRJV3MrU3o2VU1mcThSbE1yS0sxb2krTkhxbXBDS0RST1NOeFJHL2VS?=
 =?utf-8?B?Sm1Oa1hJOGZUbGc0VWkvU3IrU3VYd2dQbnFCbUJDUnM2bmtqa2laVkNtN1lj?=
 =?utf-8?B?QUNBTktaNzI2MFlTNXVSYnVZWWVqN09vV29Ici9PRy96ZGRSVTdBRWJGNVl3?=
 =?utf-8?B?Uml1V1c5OFZBNDc4MFl2QlVEaWtmdUJaRWR6VDIrTXhzOW5oUXRGMzJPS1U1?=
 =?utf-8?B?a1R1NGVnNDEwMjAyMXFQVzNKZGx2QmNBaXRxT3M0MlpQWDRYbVZ6SGZ1YlJq?=
 =?utf-8?B?Vm9HeGdaMDNLVFgzU216TW9MVjNGaDRkdktQODVQRk5zUXhtNHdjdk44VmhZ?=
 =?utf-8?B?TFhvczNwM3ZUUjYvajJOUGxMNTNBTGlDcXNVRHpZSVIxMGprQUtmR0hGS0RD?=
 =?utf-8?B?OUFEU3kvWHkvUWlpSlRSR2RndnNzOXBqZFF0TFNmYncwc3ZLNnIwdnQyZlNZ?=
 =?utf-8?B?c0dGNzN4UWVMckNueU9YZkhMRStyYWVKbzBVRGVaQ3hXSzVRejVoOGQxNVJs?=
 =?utf-8?B?M053cHN6bFkwckt6cHBoR3dXWXI2ZGFlSXVMeVl4WGdNRmxsNFFOSHdPaG1r?=
 =?utf-8?B?U0VsL3R2YzdIcVlYTWdGdnhQNlRSdnhXOXJZamJkSjFLNjllVUh4WDE0VGdE?=
 =?utf-8?B?TjdPYUJoYzdCZTlob1Rib05ndHRIMDVweERBYUYwR1E3bFE0S3E1Z2sweHVP?=
 =?utf-8?B?NXExUzcwQ3dWem1hVXJZZ0YwOUtxT29aeVkxQXc5RUJDY2JPbzlnTkVIRU5j?=
 =?utf-8?B?MysrQTdsaDVicUlGNk01aElsOFB2bGYzVlYwSmwvbWJqSU9rNWpOUHc3T2Z4?=
 =?utf-8?B?YkVWdGNPcXBFTVV0SE1BYlRpK0dWbHAyM0tIYlFaRCtnMUU5NkZrZGtkSUZX?=
 =?utf-8?B?alRETzJvNmdUZG9pSENxb0w1TFVVeW1nTUs4S21NNDZUeU1VN0FZU3VLTFR6?=
 =?utf-8?B?MGNsSVEyeEFIVUVRRjUrMHZlRVFGa0dPNkY2Smt2Q1lXRzJ5Ri9nRVhlQnJr?=
 =?utf-8?B?ZE1JTm03Y1oreVR1cXg2bE11VFE3eHU5T3lUaWJ5dTN1UXpHOUIrbWREUitV?=
 =?utf-8?B?Q0ppeG9GUVBxNU83elpkeUExRGxZQ0pEczM5VUJ1MHhWY0JvOXhKOEtuVTlF?=
 =?utf-8?B?am5qblRHTWlBbVE0R3JCSlFvd3ZrSEJPZFdkN1kwTlRKdUJaalJmeFRSbEhs?=
 =?utf-8?B?QW1UMElTenplUyt6WWZWVkZON3U1SFVoazVsS0xvYlpPZHozM2JmY1ZtZDV3?=
 =?utf-8?B?YVNldmNVWU1XdnkxcVVNSTR4OFB2OU5BUkxDYlIrSWtsUWFBb0xNLzBXdzR5?=
 =?utf-8?B?dG9CT2lCUy80czAxaDlIQzNDaTlOSzZTN1MyK0xmU1o1T2lNMU1MdmlodTg1?=
 =?utf-8?B?MC9wRWkwTE4rSGphcTBRWVpLK1R2ZExFditTS3JIaUFiNWJ6aEViOGFjVzdV?=
 =?utf-8?B?bUZVRVZPNHU3bFBqejNVV1RXdlNiRVVYMDVwbko3WFcrVzhRUTVSQ2hyZ1Bl?=
 =?utf-8?B?MWVGS0FCRnNTUjdPai9DdWZQNmtIQXE0bWdaTnQydk93eUo4OWRWU09XRlk5?=
 =?utf-8?B?bmJQcDJKaEQ3ZjJYOVcxQ1FPaDFObzhvMWlWMGxqc0Rvem41UlR4bzNFSG9Q?=
 =?utf-8?B?dXNmOGt3MHp1b1RaQVZMUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlRidUxBOFp1cXZ4bEhCUFhEN3Yrb2laOVdDLytkRU5XbWY1Y1l2Mk41bkt3?=
 =?utf-8?B?Ulg4TUVJUmNLYi9iMmo3T0FaYlptaXUzWkdCTm5UaENXTXB3dkx5NjRyMldN?=
 =?utf-8?B?YmZpclFJa2FCeXYyb2lGUHV4NXYrTkRlM1laMnN0L01SVzJzdXlxQnIwdnp3?=
 =?utf-8?B?WUV6dDBvNTJCU3hUUUt2K3B3RnZpTFBLaDk5VktLdTE1TDBLQWVSY2Y1RlMy?=
 =?utf-8?B?NytsYlQ3ZytoQWdSQ2RZY0lJSWQyeU1ZdW9wVTFkOTAxTDUxVm9VdDQzMkh6?=
 =?utf-8?B?NEdtM1BwQ3YvNzd1d3hwYWxHNnU3b2NqMnJXUnFpKytCQ2tpR3hBczh6a01l?=
 =?utf-8?B?NEZhb2YyRnN2WlkrRmh5U0hkTVAzdjN0TzJ4WG5EOXRQZjB1d2ZsZ05IdVRU?=
 =?utf-8?B?dkltSldZb3ZLNFpOK01YQ0RVOHJmbFR0RmpVNzNvR1ErMVdEOTNNNU9GaDBV?=
 =?utf-8?B?Y1BMcTlhOEJNbUpwbGcrNTBqd3RDNnlqbWNnbTNRT0NHN2luc2FnbUNJeUJB?=
 =?utf-8?B?VEh3MVNZQlRxY2JHQW1iaXdoaUx2R1JiMHo1ci9HZ0tkNnFVZ2VjT2xES3BS?=
 =?utf-8?B?VDJ4eXVVSHRLQVlPeCsrNEM2aCtkMDJEZ0dPOUthUFYxY2I4eG5kd1FOY1px?=
 =?utf-8?B?WUdPUjdaTXVOSXZ4dno3aEFzemp6K0RIbklROHVuVThKVXpPNy9FaCtlb3Br?=
 =?utf-8?B?bjVHMVFGNS9LZFdiRDg1bUVxVElXaW9RRjlNdjZ5dkFCNFhxUTIwMVk0UklO?=
 =?utf-8?B?ZmhNdlgrS0tjUXJhSU1GWnRVTHp2LzhKamY3WFRZaGRsSXcvaWI4NlNNdkZO?=
 =?utf-8?B?eEp1S3FyNHd5aUY0MHExL3IzWUVvM3o2OFdQZXByTkxXbTRMc3NBUEp6Qm1a?=
 =?utf-8?B?QWl3OHQvQjhVQ214UXpOOWtrQ1M4VkE1b2lJUStVTi9scTQvMnBaTStRTDBW?=
 =?utf-8?B?K2JjYlZhbHNpRG03cnVkWCtoSG41bkhOSU5wZjB3U0w4MjkvbnVEdGNnS3Nw?=
 =?utf-8?B?UGtRM1pXQ1dwZXBiVG8wYWJnaHJzdjQzbUF2aGNBSHI2ZlMrTjdHTmNkbXpa?=
 =?utf-8?B?Kzh6MFhSdEZmM1RzV0JJRUFKajJidGVLR3kyeGZoS2tjNkZNRFdJNGRDZ2Jo?=
 =?utf-8?B?eFpaTFVJekhvZVdSV1BEbTZmNy9SeDJGWnY0QUxMOXVaT1Q5T3lOUFJFZXla?=
 =?utf-8?B?YUljeWs5QVJ0VnJNMUd1eHEwYldhaUhGMWt2OTlMNEhnM2oxWFc5andob29o?=
 =?utf-8?B?RU5xV24yendyNFlxYndRZkxuVDVKR1dCUTNnQk1XNmtGcmEvSVJRaTlzdENh?=
 =?utf-8?B?bGRSZUtMWVN4S2h3ZjA2dU1rSlc1L2J1bzFxV20zM3NVbmg3MUVtVlVVU0tq?=
 =?utf-8?B?bW92UzNUaGZwOFR4TUZSYXkwNHhkTkpkUUJweCtOcWJqMGNHeTFsU21VaDcw?=
 =?utf-8?B?bFNZQ3lScmJhZUlSNWE0YWlON1BKd2U1cnBTWlQrOElKMTVKR0tGV2ZYWTlo?=
 =?utf-8?B?QkpDeFhxK3h5cENZbU04YlhhUU03UnlTam5DOVpGQU1CaGJGTzZ2c1lTbGk2?=
 =?utf-8?B?V0hqbzV0ZjM4SjhsRStWckxXRUJ1NDJzVWFRcWpyd0U1bURtMzJFRFNVaXM1?=
 =?utf-8?B?VVlKZ0V5WUJGUW1ER01YSVJPbXZ1Tk9mQUwrbFNZYXlQRGR6UDVCSXNmNkhT?=
 =?utf-8?B?ZElJM2hMN0JJMDNwQ0NMSFY3ckV6cWw3bkxJazYzNDFqOVRQV1lzVjBEOTND?=
 =?utf-8?B?S2tpSFdJTVdIWmVSVXIxN0JHV0V4ZEpoM1pjS3J3ZmVoYktZaDdZZEUvbUp5?=
 =?utf-8?B?NlQ3TkhSb0czZWUxajhUVXQ5OFZZMFBCbnc0UHdWKyt4cDl0QUV3VXp1Yy9l?=
 =?utf-8?B?QnBKeUpJYnVqaE5PMmNxZjBFRVVTZ0hBWFlCcEdRS2Nwdlc1cXAreGhxZVZ1?=
 =?utf-8?B?OXRwT3Z0V3pzMEVrcDFsbmUydE9hVDlyQThyYndHdVZ6Tk9UV0svOWlzOHNW?=
 =?utf-8?B?clVGL2FBcmV2Q0ptcHFyRGZMQUZWMW9EUGljRzVHMklOU212ZWdmSVp0K1Vx?=
 =?utf-8?B?R2lPRUdIellLQ0piZmRQVEJuZ3lHYVJaZm5tWmVESU1UcUp3QVNuaVhkeXB4?=
 =?utf-8?B?N2RiSlplazB6alVvakFJdHhnV3ZFZ2ttRUhXNjlFOEExb2M5YmVBNHVoMDdM?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 902517b4-2cca-4120-c89c-08dc96c67377
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 16:30:26.6451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8doduaWFDEinFCdw+xRGi1mJ2Z84Hgd4nOmxci9Be5b0Azf9M5Zs22m3iikyCFcl/1J34kTGhhFS4IhBiE3cf7d0M+bGVFAd7OIf1b2w8SE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8081
X-OriginatorOrg: intel.com

Hi Maciej

On 6/27/24 2:50 AM, Maciej Wieczor-Retman wrote:
> 
> Yeah, I've been thinking about what is the best way to display these for a
> while. Maybe you're right that messages at the top will be lost. What about this
> set of messages:
> 
> 1. First run of run_single_test()
> 	1.1. For all tests:
> 		- detected snc mode (if > 1)
> 			- check if cpu/offline file is empty, set the global
> 			  variable and print a message saying snc mode might be
> 			  wrong

When SNC detection is considered unreliable, everything else becomes unreliable also
since kernel support for SNC is only visible (in future kernels) when SNC is enabled.
I thus think that if it is found that SNC detection may be unreliable then the number
of SNC nodes should be hardcoded to 1 and a default message about possible interference
by SNC should be printed at all test failures.

> 2. At the end of tests
> 	2.1. For CMT, CAT, MBM, MBA:
> 		- test failed
> 		- snc detection reports it's enabled
> 		- kernel version doesn't support snc

Sounds like the "all goes well" scenario when SNC support is reliably detected.

> 
> 	2.2. Additional message for CMT, CAT (since the cache size is divided):
> 		- test failed or succeeded
> 		- snc detection reports the offline file is not empty
> 		- kernel version supports snc

I am not able to follow what happens in these scenarios.

> 
> The 1. message will be printed at the top since it's more informational (what is
> the SNC mode?) and then 2. messages will deal with possible issues / failures
> and will be nicely visible at the end. What do you think about this?

It is not obvious to me what the messages may be but the times/locations when
messages are printed sounds good to me.

Thank you

Reinette



