Return-Path: <linux-kselftest+bounces-11722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E272C904797
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 01:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FAE2855E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 23:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336A5155CA9;
	Tue, 11 Jun 2024 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X70fHHcM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44091553B5;
	Tue, 11 Jun 2024 23:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147702; cv=fail; b=XmmK9N95FhbhW2iZcyrCMO+uWtZa3gSHTATGxBzdZU0n5Ubx0ZVgqFSDPFpPtMx/wY0oof6VorcWZhcPa9C75ngt6LoLM2v4MoaODNVE5P5XBydMLFfqkg4WaEkmjVBRGmp6nsGveMUpDmEwpM4LwkZ9kdmePfqpX3AYLII5eFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147702; c=relaxed/simple;
	bh=dWlEltJbQpuDtLmeUAhjQWpJz9M67g7jzH7xVYqNbsE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DZ/Br9W39fRRMPC8GGiIVBOBKz5+kDrNXXnH5Xuh0thEd2qhZnrhBiIMCrN9TSWWpXarJHW/KWfBH9JhaHuADYn+JKKYcVdBsWy6NyeuG7H8u86ZMRr37cJEpsRDKHfx61Fp3iWjMigpeGqw8S5rHD9ztK+t84wLN8cdksZ1O5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X70fHHcM; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718147700; x=1749683700;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dWlEltJbQpuDtLmeUAhjQWpJz9M67g7jzH7xVYqNbsE=;
  b=X70fHHcMidKBh70bwcZ57n0W0f1tNV1WdXfXvmsdFVvd5maR6otXtV17
   iQN8/Rb0CTn7T5ot3YwvmOvxh6mA0rCs1dyOGQO1wDUkUjfYPKk+UEiEL
   3aftAdw2LIS8KZRZ7dtnhZMqadoPBkY54w7MOD4iQ0Kv14dEUXdLomzAw
   A7XfRQTJdFik3gOJMKpjj3w83hDCEwQyoMRnkjeEOsZOpd7g2/+d1J5lE
   vO70r3vJ0xYf/i3nQFRsfwgj03mO0C2Uzk0Xx7EtgB3/6vxl/qYbel4Fh
   vIWOddqUZpzLqxKVgPL58MbUMO4G1PhGa2+FFn7DI7maBdkSrIRfdoIPd
   Q==;
X-CSE-ConnectionGUID: h4PZNGiFSzit4KH0zQgJ+w==
X-CSE-MsgGUID: pTASHcIBRxGYAWTlJFzpxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="37413590"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="37413590"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 16:15:00 -0700
X-CSE-ConnectionGUID: fWCryzLER2GrfwjpgInTUg==
X-CSE-MsgGUID: 4JIh8b05TSabJ0QQjJaOyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="62761328"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 16:14:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 16:14:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 16:14:58 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 16:14:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xrg7oRFOfmyD962YkbcDM0D9UfgMikEhgNIwY6H0Yb+taEpWH9C+qNYZXY3LaWWaJgsXLlEbNLmOoNuVbfMCO78arLUhy3zLrGDVM9aw+zJoimLFZG9/vcm+W1ild3ih0NY8BmCRvv53jlmXw1uElVytV86Lt9cd4vVNOmhClifiA65WYhlKYKBEWuBzcM5R8wcT6lEx/p6h7Az0gYrV3HKYFEk6PoplSXl2ZRYTTu589dtHOjVjwmK0SuYvxIk/9KM5o4+Wlgxzpj3bXXtpo9Bloyzydo7K29Od7eGraBrcqK9rxAReYWZkba7OEprxkNaqlCDKuU1iLDLNpAv9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HawHJKVtuzKgYrs37/8YrHTY5U+m/n+aqWE7e5dis8Y=;
 b=g6Jw8J0EARK009/VWJ4lLIxckTlOzxqO+f1SvrS/ipAYDE7E75TKqSnxmvSCEtjZ9L/qOTNpbcMr7JulUkgp7ZIS7oniVpIg/Gie2fv3ygWXlEfGukzekP2MDq/5K9Pm5p3w2sd2XxBarTu00SjA4fgd2hAw0Sy0OGtOwWZlSsc9WHfKqEVvCS6+l1mF/vkCOqzdEEoLWw/58FUjD6xguPPtznL1ftkDSrC77lNHCgkGwVkj86w+RWBfqMLMg6j1LYwx4/cykZS3RMH5VM5JDCJ/IGQZvyvi5o9a82V1MMTqHy2qUDMJlNYVBbAzRkLNRbw12Hzf3c7Xcg+3KZ0mSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 23:14:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 23:14:56 +0000
Message-ID: <32126f62-6ec3-4416-a503-e858cc4a84fc@intel.com>
Date: Tue, 11 Jun 2024 16:14:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/resctrl: Fix noncont_cat_run_test for AMD
To: <babu.moger@amd.com>, <fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
 <7679d70a0ea939db13ae9dac20de56644460d6df.1718035091.git.babu.moger@amd.com>
 <6a78de4e-8d36-400c-9eb5-d3d6aa9e1e23@intel.com>
 <3078aee7-acbe-f912-9a99-941154dc4b13@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <3078aee7-acbe-f912-9a99-941154dc4b13@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:907::24)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4896:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f15033-723d-40d9-0bbb-08dc8a6c4ea3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnE0RUFaQVdUQU1lRFdtMHFlaEQzV2dtWmN3eGk1SHFhWFRUV1dsWHFUdjUv?=
 =?utf-8?B?VlBkSllRY1JkcDg2N2ppa2gvUFFVZmp2ejlHQWFXb1M5ZDFpaWZ2YXJNR3Ns?=
 =?utf-8?B?ZnFzS3dLcUtlN1VkeE5GMjJuY1pod0txaWFTZU1odVpEODNidERQZUpJNmtr?=
 =?utf-8?B?SGpYY002dVhYbS8zRnEvUkhmK0FMMnduWEJ0Mk55L0JPQklYUzA1T2IyNlN6?=
 =?utf-8?B?WmJOS3kySyt1d3JudVBOYmNuNmx3NExRbWp6YkNQejZ3NmVYYVlQMFlZZXZt?=
 =?utf-8?B?a2VJZEgzRmpvNUNzcm9OaWhEeEtqMi9sNTBjQzN5UU5BOEY4Z3daWERZTmVR?=
 =?utf-8?B?eWFEcVdvYktKMXpucXZTTklCL2tSellFWXlJRk1obmhxVHBVcy9OdjNoT3Ay?=
 =?utf-8?B?V2FhL0RwajcrQTBBOXNib3pRdFhCOU1UeXdpZmgzZExRSGJKdkYyN3c2aTc0?=
 =?utf-8?B?REl3UXF4ZzhZMFlCZW40ZEdPTnlzTlQ5bGo5SVpWQkt0bFhwKzF6Uk92ZmxJ?=
 =?utf-8?B?TFBxU0prTXRSN29QRmZ5TVBiUkxIU0dEUm4yclp5WnFhN2kzZk1Nem03bHVo?=
 =?utf-8?B?ZER6ZnZlZGxENVZVcXBDMnN2KzNhTVloMWc5SjJzTEY5TkZNeG1wVEpibWkx?=
 =?utf-8?B?UEJJRWZtVmpQMENvdWdBT1lZRFpxcjNuSEtXWFN0TlM2elRGWDhQdXZrTnJO?=
 =?utf-8?B?dGFwMXdzWWQvM2Q0dUpkL3R6UEVhd00rZDRjM2poenYwa25LczVwMkhBMzVX?=
 =?utf-8?B?dlUrYzR1MHU0VytkSSthYUJjZzRtUUQzWXJhSEptcDdJWE1oR2dqWDZZL1ND?=
 =?utf-8?B?MERSTVE1WWdmMEN4UHhBRWlPVHRxSktwR1hWMnNGQ0lSWWdBTlMzVjk4anlk?=
 =?utf-8?B?NXMzRVV5aHZzKzlzTEU1dWNtQkxwZmd2aEMrbnd1QXgrK1puSlVxTGJ1Rm54?=
 =?utf-8?B?bU9JeGRzRjc1bncvZkYzU0lZU2ZYVkpNVVkrR1ljU1QxcXVFMmpaOGNlbllQ?=
 =?utf-8?B?a0JNZnpVanpWWklmOTRnMUxlSWlET2tNNmtRMkNWVW1mODdBMXluRFRNY0Ux?=
 =?utf-8?B?WmhHcEZSMm1PdTArSmg1d3JWSkhUNWh2ekp1NHpMdzAvOXNzeVVRTU50OWtO?=
 =?utf-8?B?MnVjWHRhYXJrQjRZMDJkbFBFSDl2TGNLdkpjSHBWbmdRTStCMkx6eHpxQ0xv?=
 =?utf-8?B?Y1JrSG9WU2NZMk1iYWMrY0JIdUVKNjZzZ1hjTThXdG4wYU9NeHZya08wNFBO?=
 =?utf-8?B?WERlalZya2VmTW1VakR5UHc5RjQ5TGl2OUQwN29CRzFmOStCd3BqSkFPMXA0?=
 =?utf-8?B?bHRMa3VDekNjUjJUQmQ4TFZwM0NYbEg3a1Q2K3BXS1ZOQTNGQmcrbVNNdnpP?=
 =?utf-8?B?VFVkK043NE93NGhCY3pCWHFQYVpXNHUvTlRPekVKWFF4UzZTVTVoWnlleFZq?=
 =?utf-8?B?UVZUYWZKOGpCTGxUcTk5YWpXZFhpS3JjYzhZSXhCTXdOSVc1OTVaTXJEMVkv?=
 =?utf-8?B?cVZ3eDRWWlJXNllvd2h4emhTeDdOc0pycSt0cnlkcnlKY0IyOE9DY21tL1Mv?=
 =?utf-8?B?N3lUR1IrREpJWFdzUU1SbWl6bW1vcGNrS2F3ZXdIUG9pdW44TXhSbFJ4ampy?=
 =?utf-8?B?aU5xTThHRk1halFSQUwrYm9zT0lDKzNhNGpTWitUYVRRaUlraER0dnVnMFdI?=
 =?utf-8?B?Y1RhUzBmd2dQQVVPTC9KR3NLMFQ1MmtwcEtMK1FXUmorN0lvOWNPMDhwSHB0?=
 =?utf-8?Q?eDd8Cc3CfdXVXO4vaxMMjJel2YbD8xguz4hofU2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDFCSUQxWDg4UzkzUERhbEZpc09ybU93VEV2OHlXekNDb2VaZ25xR1NteVN1?=
 =?utf-8?B?Qmt2a1VLTkxzSmFROW4wREdhb29TWStLS2JLV0Q0K2dHUDhDb0xUbjFUWk1w?=
 =?utf-8?B?c0RtcHNXaHFPUVlTYU03VXJuR1kzWVBxeG94OWt1UllNeHVFOE5GMmtSejlJ?=
 =?utf-8?B?ZFo2M3huWkFEMUpnb0Vmbmx1eHpLY0RuelhSdnFCNGZ5eC94empaVGlMQm82?=
 =?utf-8?B?TmtUalJKdDZPL2p3MDd0aHVYTFR6MDlJUXJEMjY2ZVdnd1c4aWZDd1RIZk1Z?=
 =?utf-8?B?MDZLNXlScnl2SndLYU9TdENVSk52SmRYai9LZnMya1FSZnBVM24zNzhIMHlM?=
 =?utf-8?B?VEdpT2NnZWUzYW1OdStRVFpWTUszejRXUksvL3pxYzRjVU9qaU5CN3NlQ3Zl?=
 =?utf-8?B?Q2Z0bEcvK1VUdkkrbXNUSzdvRWJLWnVLM0sramtmNm9PZ0JCMFFzUkJ3R3Zp?=
 =?utf-8?B?dE04VVJ6QnRzYWsvSlF1eFpaSjVudGpQQ09uaDNpa2UyaHQ5em1Yd3Q4bFAx?=
 =?utf-8?B?aWdpUFo5QVAvTmZkWmF6ZytKQU10OWRkM3NKVWJKTm5uYXN3Z3ZoUXdaSkpq?=
 =?utf-8?B?Wk5nWFRJdWhITmlaR0IyL0ZiSVl6VEF6bFZ6aW5NSkxKb2dDa09aV1RxTGhB?=
 =?utf-8?B?c1V3VkJTcVdQcVVZbzlxcTRIblJPNEZIRjlVOHo5UHpuRnBoMDNVMGpuK3h6?=
 =?utf-8?B?QzFXZityLzUrbTJiZlVTS0VDcXFITkFRSThueHhnUXFtT2hjczVCT3Q1L0Y4?=
 =?utf-8?B?QVJHdkR6YTE0ZzgwVWZDSnZjdmhDQ1lISFg2TmUrbG9HQWhQWkxrdXlrdWRu?=
 =?utf-8?B?OEhzQVY2UXlzejUrN2l2bmJmbGc3VzFZMWFoWmkzMWZBU0NISWxiOERkVHp1?=
 =?utf-8?B?WGxDeUV4dkxQSlNvSm5iREFyZDZoVmM0Q3YrWGhWTG1ReWhXOGRoTzNUMjFF?=
 =?utf-8?B?NjZCQmZRQ05aYmExOGFuMkdTaFZ5M2wzT1lOeEFKUzM5SVZpbWZsTTJSVWxF?=
 =?utf-8?B?ZHA1K2N2YWM2VHBNZVliVjBJSlprWWRyTnZuZXBHOXJzYWtNcUFsUG5NUlNk?=
 =?utf-8?B?T1I3cE5vRTBGZlVXK3MyMU5tSzh6OHo3MDB6N3RGZHl1VHJaQXUvMkxXaVJ0?=
 =?utf-8?B?K09tTHc3OHVTWXJxQlFWNkpDOEJnVFRIVENSVWVROVliRjh2cXpZRFduN0p6?=
 =?utf-8?B?emtNL2hoV3ZoV0hwZDZoMmR6bCtyd3hrWGZIRjNBVFBTMm40SVlyaVVnRzQ2?=
 =?utf-8?B?VGY1RkQvK3BLUS92Y2hhTGJxemlJMUFBZ08yRCticVFVUlJjL2lFUnBJR2V5?=
 =?utf-8?B?U0VndzFwellhOVNSQndYd3ZkLzFXcjIrTUoyaXhFNjdvaHdFVy9KbVJSOWRW?=
 =?utf-8?B?SE01SzZQbHhjOUM5K2xJeTlWV0lMQlBjSDh1SE9BckdhUHIwSFM5V1V5Yndw?=
 =?utf-8?B?OGJhbVNrZzQ2Slo3bXJlYXVoVmlIdVpLa00vUUljbkE0eUxKem5YK0NQbm5F?=
 =?utf-8?B?TmJqcDFaaGlGWVRpZGl5TTVmTHlXSmMvSGdaZzZHSld0U2ZuajBOMmhOenEw?=
 =?utf-8?B?ZkxFNlRpeXY4YjUraWdia2dMN1pLNHpJUlMyclFHK3BJaUN0ZHZzT21GdXVi?=
 =?utf-8?B?S3FNZklGTzhoWTl1dGtSK1NQUzlGMGFzSE5qSUtKMFRhRUpkWkFrVkl4azRX?=
 =?utf-8?B?dHl5clI0eEFrSEdPTGFSdmdKOU5ySzU4cURHWEdwM2tWU0RiQ2VNc0NIMzRq?=
 =?utf-8?B?UXByd29henBSa3FpK2U5OEZtUHZBMExsTUNBYkx5dFVNQjc0VTB3NVVzNkNF?=
 =?utf-8?B?UU5ZSlRPQ3hVN1U3QStCSk9OdTdXMS9RTFF1bHRsT1JMeVRUenhBMm5KMW96?=
 =?utf-8?B?RHZ0VndXUGp0eDhtanhFWEt4NloxdTAwNFNKaitPV3dXS1lkQ3M0WnViaGZ5?=
 =?utf-8?B?bHZZd2pKRElmS090eDNDMm05azVPUFZ6dEVZNzJPZCtzSDlXR3BheEx2bXZo?=
 =?utf-8?B?eS8vSlhRVHdNSzYwVkNJRkFha0FqOEJiWjZvbk1aQXRjL3owTDNNU0xQdXpw?=
 =?utf-8?B?ZmlBSEdpRm5RRGdCTVBRK21rQ3RXVnBwa2JtQXEyM0ZRSi9Pb25zTlFhOUlj?=
 =?utf-8?B?SnFISUU3MmxjL3c1ejFIMkx4UWgvMEcxaVVLNzBERGtidTR6WG1jRG9NMzVq?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f15033-723d-40d9-0bbb-08dc8a6c4ea3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 23:14:56.1664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8vUsL91QT35v4O8G3936IWW5blqBrG6PYTpToqRdXj/IZx2COiHqlXkyK2teqCLaLY82AfLBVk/12IhglwWBlAgkUJluL06lHJrwM8/Tfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4896
X-OriginatorOrg: intel.com



On 6/10/24 4:11 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 6/10/2024 4:32 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> (please do not send new version of patch in response to previous version)
> 
> Yes. I saw your comments on other thread. I will take care of it.
> 

... and yet you proceed to send v3 in response to previous version again.


