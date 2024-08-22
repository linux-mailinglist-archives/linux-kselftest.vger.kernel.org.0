Return-Path: <linux-kselftest+bounces-16109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 203A395BBE5
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 18:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8368287B9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 16:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4691CCEC9;
	Thu, 22 Aug 2024 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fadUXV++"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D450282FC;
	Thu, 22 Aug 2024 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343997; cv=fail; b=qwN058oHHN/6H0OY+3dioCtAh8nwHlk0diX++e3zfvzdE/iIHgJoVcGrjAl777ga/AbAJ20nyMNarKibVdQeiybsNteIqO5F9wNdpL7Ynqq4GBN2Z83Yot6Evo1lnWEFLKKBLlxncYCRHOhUPbIghUb8q7n88f888kMGQcj3II0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343997; c=relaxed/simple;
	bh=MRay0FAr37Lilg0HKhPr0MUBRF0aV8kYAUmTQd0SAVo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=paffpgfzF/Z2fYThdrA7MIAJO7e1dK8GxMbYoTDzADiGovtQZnB727iXCpmlOTqD5raB1gAw2u4uU62TaDNuAg2No9QEkoqyZqYXGx71jVFYh4nnvIhRvfjR9506IkMcV7wZX5a6bApwc8EMk+ls1bJWNtMgr9HaQuspiue6log=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fadUXV++; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724343997; x=1755879997;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MRay0FAr37Lilg0HKhPr0MUBRF0aV8kYAUmTQd0SAVo=;
  b=fadUXV++QqMHUEbKra4r4YeA8WwlivuQkQV9ZviCtp16mDHFqYLkz+RT
   X+qpLe1fknoG9WHpaq4G/n+Zfy5yCELPpTZEpmhJmI6nMq4zIpOANyz64
   HF7V9l1hL4VMW2E/9estQJ8isGHfPbrclgmfo+4u/ZUSDZ9rw9dUWgH08
   wD6+AQj+dD1kHbfhLQyOyzOmXi6GYZQxT8L1Mx6lcgs3wNQ/cYyXh8ADD
   5k5//RKFg5adN5f98jvsVzsJtXLRTTXZl5ZOJmEBL/crsQAqto8eui/F4
   YBl5GPhXUHNfe76mwW2G2cmCifjwt0VuaGGtQHWNsKnmWV2FvfuQG8ZWu
   g==;
X-CSE-ConnectionGUID: 0MKZLFECQd+zfr710cPtgQ==
X-CSE-MsgGUID: DMuc9USaT9CAWOAS8SRkCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40239826"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="40239826"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 09:26:36 -0700
X-CSE-ConnectionGUID: XMattRhjTHOwIo8A5oZy4Q==
X-CSE-MsgGUID: 0xV3MsEtRfSjUgc/n7gyJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="66428714"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 09:26:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 09:26:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 09:26:34 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 09:26:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtwAkI0faMSi6D0Tf2ogYZby34OCruO3zzBfW4IDZ/hmt3gQXRhTq5WEcqsTkb2rLwzbdYiygp2gfRY70tZewJfhVLaFwCbkdHVGe4FZfFa/wXz6YjHlopGyJtz8hUWmZfV1rgrdbZlPvyH7oSAWDD5wmMRxOjO7HTxZmdGqAot7z8ch+P5MRvDJaCgC9ryX6Qvy8HlmghGdfe9wtTxSYwAFd3BjP/wYkkT4oNAnLRnelwmlFvh2rol9mobWvjRMoYTnvyuqjj86H06YjhcYzR+SUZgg/eayVpye9zTQy45r1RRPCVeEkptARuwLuwVUyXGqG5v2DLhtWnzBVa6MvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho1fEtoay9+3PWH4kC5qBaTYN3bOtTsw3kYklm1uH8I=;
 b=uVYcsERoarDalaiYaEPczs5SCrUUHIRjwCeyFS+sx7dGEWL1yrDUzBNGvXupyiH6cI9yvfzaSG8KfpFc+hWgpdqyO2Ogg4NRmKX0tSYRuYZXr2HDXYutoWPRUMUOujhFojFDimD/CDGH6HZeSzNk+fhKYAVDxgKWa4gDMzyTepqNG27Jg7dPVU+n6jx2cUE2p1athUMRw5GeC3XyEqhxWd+2CicGZ7v9dsLULpTPNhvvmC1KegEKQ6SCqdkWHnEd1cZsSiqujIJaAg8I06VxT0MOO9CXUn0bXLotn9IBmQlkc320gZfAzU+j0Ul2iURSJ9wc5/Zw/zRmozWUjpC2yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4591.namprd11.prod.outlook.com (2603:10b6:806:9c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 22 Aug
 2024 16:26:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 16:26:32 +0000
Message-ID: <c569956b-a0c8-45fe-b51a-92d088407cfd@intel.com>
Date: Thu, 22 Aug 2024 09:26:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/resctrl: Always initialize ecx to avoid
 build warnings
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Muhammad
 Usama Anjum" <usama.anjum@collabora.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Fenghua Yu <fenghua.yu@intel.com>
References: <20240822081114.4695-1-ilpo.jarvinen@linux.intel.com>
 <20240822081114.4695-3-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240822081114.4695-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b1bc3ae-986c-4088-a26e-08dcc2c72ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tm4vRTJ5WDBjKzBuVDBjRzY1TGhyd1ZIME9PSTJmMTBaUjA0NXVJOCsvN0I3?=
 =?utf-8?B?MTZCWXRQaUpKek1pNDVBKzZnNkZidTF3T0k2ckl3MmVLd0pGRGRPYXArK2g1?=
 =?utf-8?B?Y3FmZjBlYndnSmZoc2VUenNMQ20rV1R4UmFHK1VkeWtXVHg2MFVvK1NNaGQy?=
 =?utf-8?B?R0lxd3AwNW5EMVZqTWx4NjZpMWNyamtsUEJYWjVvRWM3c2xOL1R5N3h3VnBu?=
 =?utf-8?B?ZUpVbHNCL2tmYzJza3plM1I3b0piSTZDVi9RVHFJdVJySnV5TnNWNncxY01B?=
 =?utf-8?B?ZkZVQlEzQXJDQWVjWHJwWm53cm9nUkxyY21TbUt1L2x4UURRSFI5Q1BkNTZR?=
 =?utf-8?B?dWNiQUlNOFR5M3ZxSG5BL2wxdm5kaUJ4c0phMlpRc3ZYZnJua1RWNVNpa1Rt?=
 =?utf-8?B?NTNhN3F6dFVoRit4STlSMmpxMmhRbmYwbEgxM2RSSUZTUTVFdXdONG9VRHNx?=
 =?utf-8?B?TzdsZG9aOFhxak5samlhRHFjK2kyT3p1akZsZU1ma0pOQzg5a2RlbE9tUjRR?=
 =?utf-8?B?L1o1ZzE1WlYyWmdLdVZDUWl4Wncyb25UUHBJNFlGM0tEdmVqZ3FuNkIvR3pE?=
 =?utf-8?B?aW1zb1JEb0l0UTN1Tjd6MnBoMXlzNy9sQUdlQjZRVDBlelhjMmFuT2g1b3h2?=
 =?utf-8?B?RWw0THVZdzFyWHhabzQvL3p1dDhKd25Gdk1QdGNYQUxLbG5SSHkxb0txb0hK?=
 =?utf-8?B?UFJ1UEd0L3hIMHBQdDA1RVhlb1dORlk4VjNkMktsdVJKeDQ3b2VnUUU5Q1BY?=
 =?utf-8?B?bGRVRHE1RFRReEYwZzhvaUIvT2xVZVBOM0hxam5FdlFYRnJHbFZyU1lRSHRP?=
 =?utf-8?B?WmZ4UXRyM0VlQ0FVT0M4TXgvMS9McU9Vd2FWdldWY2o3ZHJSZisrMnpSU2s5?=
 =?utf-8?B?UG9lM1RVTGc1dTR1blZIYWFtNGNjcmZFd05NSVFxeW81Z0t0djFwN2NDSWZh?=
 =?utf-8?B?ZHNubjVKc1ZYQUgxUmlMY1Y4NE5sM2t3Vk52OXBmaStDbVFCcGpraGw0czVk?=
 =?utf-8?B?amZZb3NuMkFFOC95ZlZtUmw2VTB6aXhnbmROeHBBbUo1Zis0UmVSRFZidFZF?=
 =?utf-8?B?L1phYXhGR2ZtSWlsbFFGQ2VqWElmWmhkZlRQRmJjdnRrOVBrT2V0S2R5YzBD?=
 =?utf-8?B?L3Bwb01OS01kV1FOa1pZM0FBbFFISisveURpSVpjL3F4QitVVFVzOHA1VThT?=
 =?utf-8?B?S3B6cGhUUDVTL0dNSDZvQzBtNy8rOE9YMGd6VXVrRVArbnpaTFVNdnNXVTNF?=
 =?utf-8?B?SmhSQ2xVT2U1OEs4VzBSaEphUkhDOVp5eUYrT2loNllmSnNGWkZmUFVsSitU?=
 =?utf-8?B?QmZNM1lSRnhicWplTmFwNVg1L0lGUm1zYmw5czNTL1J2cktINkx5aUxIbHlz?=
 =?utf-8?B?d3RtVmRwcThHUkJIbFpDZjFJWHZjZWtyMzdOUFpnS3ltM2RZYXFCTHp4RUll?=
 =?utf-8?B?ZDdxYzVaRE5jWWZzMzBlU3VCUXRBY1c1aXVvZnNMR2RLSGxMQlhrcXlHOGpC?=
 =?utf-8?B?MkIrREY2R0NycjdmS2h0L1BCVXYvZ0JRc1VUMGRzdmduZHo1Y2pyRTd5S1Zp?=
 =?utf-8?B?OWtPVHFyMkd3bkNWS2MwS0x3dkFlMWduT3dsNC9uUDc2R3hpMHRvOHRuRkw5?=
 =?utf-8?B?c05hN3BFeEhNcThHYk1MYmwwdnRTY0J6ZWxjWFJhM2Q4UWluV0pjQzlPcUJM?=
 =?utf-8?B?eWdaVGhVSmJZdS9iQVZQR3VNQnVDNTFraHZyeEcxUUFhZ0pxTDBxWXNhajVE?=
 =?utf-8?B?UmsxdGFyamRpTzRYVU5wSEhVVEREN0tvbUIwSHR3dU5NbU1sSHlUQjlPMDc4?=
 =?utf-8?B?c2tUQWRrcGRWMDZPVWJzZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aC9TeWIyeGpmNE1JUHFKWGtFa2hsdTFqM0hJRzdQVFM0NXRxM1BaNXFLcy9n?=
 =?utf-8?B?M3hYaEd3dVNoZXZhL1ZzeWpkblVIOVE2YTlwcFJmZkZKOXQvdUU5VzlEREh3?=
 =?utf-8?B?SVBWWU5sZldMelg3WnNoRm1WaVh1ekdKeVhpY20yTUxvTlZPWDFxdVBEOXMy?=
 =?utf-8?B?UG5ZRGIwK1E5OHFVL285T24xU2xhZUJwY1dzc2U0VFg0K3ZrSTNpd3ptOEFo?=
 =?utf-8?B?M3ZFam5qSUhZYnhRSmc1Q2RRWlNEU2dXTXVGY0U5ZEpId0h2RkFITzNpb0J6?=
 =?utf-8?B?b1pja2JGTW96SHAyRVE5alJIRGhMa2I5TTR0cnZMd1l5TE9DYWh1QXR6eEUz?=
 =?utf-8?B?RkRSWE0xalcydktvRXc5RTJNWG9ENTBmV1hvdzFBSGtwdzROYTgwYmc0b0pO?=
 =?utf-8?B?ZXdna2cvNzVOQk1wR2RiSUhpNFoyU2hsRXZiSUMrVnF3YVZGOWQvdWY2TnhJ?=
 =?utf-8?B?UmFoblE1eWFEaEZiNVlqRG1SaHpyT1lXZ1g2cWkwTSt6WWI5Y2x5ZGQ4ZHlw?=
 =?utf-8?B?Wjg5eXlBZVhzVFdPUzhmcGVFZUVJU25rTXBaaElUQmRPTThITHF1VTFiZStJ?=
 =?utf-8?B?VEMwTmxVdmE0WHN0SmxybnBhRTZkY05OcDhKbTFyazd6SUJQR3h3NzlWQmxy?=
 =?utf-8?B?ZzN0ekFDNmcyNGlsSjRqb0JhRU9pRE1veVhrdU1HeDVOeWpHcUEvNEk2SU9G?=
 =?utf-8?B?aWdyT1JPMjY1NWhpYnJsM3duYlc5TFBPRktUTUh2L0lyUTlncm5RcTlEOXAx?=
 =?utf-8?B?cG84bTBsRU1xT1l0ZnZzb3EwcFJkZ1JYb05pOGRQNExnaXdxM1EwZFZnTDJN?=
 =?utf-8?B?WW1UakFpa2tGNFM0VjMvYlNINWcwTVkyS082eWNQU2E2bGZTNmwwQVNkMEJp?=
 =?utf-8?B?S1hlQzNLNVhjWitRSGc1REVrQVEyTEpMNGZtZjcyTEhQRCtDdnNXTWlZTnNx?=
 =?utf-8?B?ejl0YjVLSlR6RFgwbEV1V2NLcWNKUktPZDR3aFY1V1VMQVBucmdkeHpONjlo?=
 =?utf-8?B?dGZzdWthdVluQVdVMktndERnMTJJNU13NEprK0hwMnhJZ0t1NVJ5YlFQcm03?=
 =?utf-8?B?ZEtFTGxxTlVwVXB4cWNFcTBvVjYzUCtNamlQejIzYkVuT24wbS9XN2JVanpE?=
 =?utf-8?B?L1pOMU9XZFlWUG5BUUZlenc0ck5iNldKMk1uMzU5a00rYXZOZ1VRbitxQzVh?=
 =?utf-8?B?ckc5d0xKMGphcmpKelVPQUh0OEJCZy9ZYVJCcmJ3ZGtuRXAybXZMdzZRQlk3?=
 =?utf-8?B?UmNpZFVuSjhkUTBaYU9YcHBERFBoRUVlbHR0UmFlTno0Qzh0aHRnWnd4eEN5?=
 =?utf-8?B?NVU1RldZUGtiT0gyUHNOZk5DakpucWdpTWtmRlZyQit3a3hXSEMzdmJmZmgw?=
 =?utf-8?B?dHNhWVZ6bC9UTzJKRUsveVlDWjRxZCtGVlhRSTN1c1NFL3Bxa3haS1A3M1Rj?=
 =?utf-8?B?ZnpqVmxBUTYyUG1nNTQ4a0tyWU5RTEprWTNlZEdELzlIK0JZc1QrdnJJRkRx?=
 =?utf-8?B?UlV2MXFBNm9TbFlObnE2YnUrbWhZc2s4R2toL3JjQVpzeDcrUnpRYmh0dzZp?=
 =?utf-8?B?QTZOQjhrYTJ3NnI2Skt2ekNBL2VBTlVpbVFKalE4QmRYMzRYWXZaM2oycm5E?=
 =?utf-8?B?TVg1STdQem1sRkF5bXNRQXp5Sk5GNTczQm55YkhFWFlMMDVXUmZaT1owOHNK?=
 =?utf-8?B?WTVJQmZHTU5HWmdlUXVmNDRiQzduRHJqQk9JV2V6UWVPU0FuSUR6N0ozV3JZ?=
 =?utf-8?B?bklGYjNBMlQxSU5TU3laV2N6UnAyc0xiNUNRdGVSTE1qdUdqUmpLTFFFV0tI?=
 =?utf-8?B?bVJhZnU3UEFVQ0YrcWFqZnpUZ2EreHZvUGEvdUkyOTNobXFQQ2RObW1BL2ox?=
 =?utf-8?B?bnF5SFdWT2FTYnZlNXBEWkZGNUdROW5UT3lHckdXOEJHeUhuaDgyR20yMktQ?=
 =?utf-8?B?T3ozbVY0aThGVk81cjBGeDZCY0RVL1hHTUZ3b20wWEduOTN1SUVhaVFOL0Y5?=
 =?utf-8?B?eVJOTS90SGJxMnllRm1JVGhpbFFQcXU3Y2REN2ZLc0xHYW84M0lVZVNna1pG?=
 =?utf-8?B?cGsrVnlEUXdseDZVanNPY0NjaUhDdjZZajcyb3pXRURFOHYwUU02dDNzRHF3?=
 =?utf-8?B?cUFFQSt3RTRqUDBJaDNtc0krMUpXc2pFNEdNSHRsNTVZVENENVRZZ3Z4WWJY?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1bc3ae-986c-4088-a26e-08dcc2c72ef7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 16:26:32.3826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZJerbFpH+Q0ANKNuEoE3aPGFH0PAD4mJoXHNMv5uTretfSNcsa4pi60dqI2auv7TwyaDZvu2qXbawtruWJ5N/s20tDFrrofIJyQtr8xyws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4591
X-OriginatorOrg: intel.com

Hi Ilpo,

On 8/22/24 1:11 AM, Ilpo Järvinen wrote:
> To avoid warnings when __cpuid_count() is an empty stub, always
> initialize ecx because it is used in the return statement.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

