Return-Path: <linux-kselftest+bounces-47525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0D7CB99F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 20:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9037930680D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 19:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D652FB63D;
	Fri, 12 Dec 2025 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3TUmSoZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8211DF965;
	Fri, 12 Dec 2025 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765566271; cv=fail; b=Yr8Ty+8gY+iyEsx7co5KNQahkVEctZtsD15s24bJvLBhXDaLyWXyyE9Bsa0rGvNwzuR/AYFljWs2johz9yznaD+hGH4PZWiCPrK3hqm2VC9IOnMBpE9YuYKY1IwK6QvysNH/7M8cucaMh4F/1zD3AEPAwH9S7BhnQydVRw9o2Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765566271; c=relaxed/simple;
	bh=7ka73iDYKoZVLt2lzJc1mRpRvyev6WLDOlvnl3GICHM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MCEc2eD++I5tiMtocyMM43+xaR/naOF2VRwSqFk5XgpnZ2Yn6QQB6ODVBm+1aMP6NG6W29VFIUdE3JMx19lNty8M4WtPtBpUwifKHN1Jj/yycrVyyApq/CxkBubEXhISHnJdhAJbD7vvhDPa0k8hiEKHjM6nHlvJiyIycG/nnWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3TUmSoZ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765566270; x=1797102270;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7ka73iDYKoZVLt2lzJc1mRpRvyev6WLDOlvnl3GICHM=;
  b=O3TUmSoZCbs6LJ9OIv9ztRBUUPmUwjtba6BgnmE8r+ikk2fIWNwvB2H5
   8iupcjbA96izBilOEtUUOO/q3FCZVmeYz8ZyT6Le7OmEgvkjSS0pBZ73x
   eHl2XnKoYK/prl0xoOUbRqdEP9Bd72acmKeP8/dWMAlSwcp7Qk1qb1Dbr
   bXCCsI0LfEjQByDwH/YXLXb+ttIn6Wqkgi4dz1Npe5Ca7ds1FA0YQx8rD
   oqM51ivkdxqCe9LSLr6A/u3Xxm/n/+rrJMak1I+lnlkTIbK3sjB8lOTFn
   6Cx/+nxfnlKbXw5/5m0ORGg2uh8Rc/XQ69XkwWnPos9ogeVDCAbEe17QJ
   Q==;
X-CSE-ConnectionGUID: Tm7ayNJ/QQqJYk1oNvhWHA==
X-CSE-MsgGUID: y3WO/NYaRfWhZ8z3WjeiKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="78213232"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="78213232"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 11:04:18 -0800
X-CSE-ConnectionGUID: N/3TZrChREOoAB6U/SS7qQ==
X-CSE-MsgGUID: o+De44tgTyiNjYkesTdkMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="227824767"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 11:04:18 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 11:04:17 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 11:04:17 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 11:04:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfOCcMxeLionvPK3vn/Bm7TPz0+2IjRyUvuuHzPgemsH0+zLRBzdnZhZNKqfNkVfepQ8fRy9FTIbsv2CIHm/lf9V/xo8GE6VdjoSv7e8i+GNQAkokuFRHHCCOln1OKTuo6vmZ0UFFtC2SlWxC1jqMMDf7wjPjJK+uTeswReXwDRh/UI9CL9D7dvsGAe0IuwOFgX3cHcTPyxTvWGwLMQUCd4NBQ0AV5ICdJWsF28kwn0MOQhBpvnANOC4Dv3uzLxVdNVCJjeK4z6DF7SENyapBU4x04yNcUdAJyM1xYy6Hv+JMI6GWZbB/BgfBWS76mZnbEbEwRlq/yiJSSycKl/VGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96KGhJiZ9OhkOjQQEGbeppC6FdfxiOAlCUPmTZpKnsg=;
 b=Oqhg9M67FhzUdpCngC+ftm8s/3Y111+xnB7SQY9NUlFuED/PjEf15xxCc8Ow0JegAm4eTTlNh6dpPiQkBdoIJxDJ6th+8cZppOjhVJrZTh2eZDE/ybQWyVFAjR/P07OnWpwPcdAZscY1q82qsV7MOaxWMdlttU68le9clXc1BxS7WHhB5e8E1aJ6S2DoSLib6pUbNZarmz+rucSAyZu/OoqxVow39/r32Qbn9ONQeraEHcgBmBA1+qP+NaX1aRzAFJdinTI27x6MlcCSysY+una+UlHxSwJchiPrTRJtoWgggDO4mHYBkTD9b4kv1Q0G3hd8fLlmAfncnnDmcDoN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 12 Dec
 2025 19:04:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 19:04:13 +0000
Message-ID: <791807f1-760f-4aed-b1c6-85b3d4dcf7d8@intel.com>
Date: Fri, 12 Dec 2025 11:04:11 -0800
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
 <075748c3-a82b-4e7e-b7e9-6f8900ba2020@intel.com>
 <182c2515-3658-423c-8521-4dddbd5e16b8@open-hieco.net>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <182c2515-3658-423c-8521-4dddbd5e16b8@open-hieco.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:303:b4::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: dbcd21e2-fe13-4e73-a3e7-08de39b13d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHgyUkVmRW5DTGRuRUdZRGxUZmFtS1hKaVd3RW9xR09EaUVFeGRWb1Jva1hG?=
 =?utf-8?B?U3RvcExBZ0tITzVldU5obEh1anBka1VRVnowMXpVQ0s3ZVd1SXFucDBmM2Fw?=
 =?utf-8?B?RWhQK05qOWJzQlFwUVRzc0dBSHhkOUxFZnNiVjkyL3UrU1ZjNFk5SFdFbUtC?=
 =?utf-8?B?a0JieitzS2JGcCt5MU5adUgrTFhmck8wYTJzdFpQOGQ5Z0pwTHZ6dG55MVVn?=
 =?utf-8?B?QUx0SXBIbVRBYzRVV3cwS1puZlRVMFE2Y3ViZGhDdXdKb3ZReTNmQUo5RXAz?=
 =?utf-8?B?ZEhsZEFObHJiRVFKRXF2SGRVajlXaGhkMmJmQjZwOXZIbzd4VFFOVDVzTnhG?=
 =?utf-8?B?R2NYZ3c5RklQM3BFRUpPR2laVFF4MnNUekxCMldFeVdKT2o0UkdLbmxiZG9w?=
 =?utf-8?B?MGxveHEzVDFmTUJzVSszQ2lseXFpKzlRaE8wSndOTi9oZGdtMGtwbi9jN3BC?=
 =?utf-8?B?T1F1MzdNWmdnS1ptR3dGZUt4WldES05xOEpxclpseDViOWRVRURLdDUyNWwx?=
 =?utf-8?B?dDk4cVFnSEdsWkZIYWd4ZyttclZmNzFWNEJuV0NQL1BjYVlDR24zUjV1djkr?=
 =?utf-8?B?REI3MW5KWGlMYk5UQ1NtaWN5aGRCQmdTb1hqamNZWFc1a2ZOMnQ1bmJ6RUg0?=
 =?utf-8?B?ZUpCRFFQdHpiNWpCTVpQeTF5UGx3akVMSXdGOXJqS2tUTTlPOHVLRjhRZEVa?=
 =?utf-8?B?UXI3d3ZMTytPOWt1VFBvTzI3eGI2bmh6Mm9VTVpjUHVMdGdwOGlFVmlDbm0v?=
 =?utf-8?B?Q2xsbG5iMnRoWGZWRlZzVzJ6V3gvWkJ1RlNkcnZ0T2dwbEFEMkhJTyszNWVR?=
 =?utf-8?B?VzYyd0F4OHd2L2srNU5yQ0NGUkxCVFlmcDArSEtHeVhDTGY0dWljZ3dGQWt2?=
 =?utf-8?B?Yk9XaUd4NnlDWDFreFh4eVNsd2JRRC9wRW5pbC8vQmJNRy9RMFJvTm05OHZL?=
 =?utf-8?B?MHlobEo0NGJPNWdlSmc2ZWlUZFdlYm1rb0V2MitkekRqNm9sUVh1NDdYYkJD?=
 =?utf-8?B?UzQyVEZsWkxlMGRxczU0N3JRcURHekdoTnJ4RytEblM5d0pxOUlvNDNkUUVu?=
 =?utf-8?B?dDROejFzODRDbTNUTjlYdWVTcmxKSDl3VElldkJnd0tzcWUxYzdDaHVKVHlG?=
 =?utf-8?B?SE13NkRWZ0Y0Zmt5aE4zdGh5T2RwVW1Lc2RKOFZCM3ZMdVJjZ3JuSlVIaDAw?=
 =?utf-8?B?Y2w5L1hNcy9sTVNJSmN0clRmSG0wQUprMzFkeWdacUVsTFRNVVAyVmhyTkQ4?=
 =?utf-8?B?RmVDbHYxa0Rneld5bjJxVVQvbjhyMW0vd0x4bGRvUHBLZmQ0UStuTjFQYlNl?=
 =?utf-8?B?RDJkVGRZSElZWVBkRktQN2ZvcHBNQVErb2t0SUUxYkQrV3RHRmg4SnRJMmh5?=
 =?utf-8?B?dzlOLzlKNmtTQVFnUmF2ZDNPbExVWm80TFc3ekNTR0NHOU02c2tXOHpEclNy?=
 =?utf-8?B?NktaUmFhVXNxMzZpSk4rUVhmd3JhdlhOOUJHdkEyL21CUUpMbWF5N0dwR25j?=
 =?utf-8?B?T1llSnJlTkM1ZXZ2MzBjMXplUVBVYlF3MS9tekNnVFRxS2IyazBlZDlkVndv?=
 =?utf-8?B?QTFEY0ZFRk1Pbi9IMXpmOXprSEg1M1NUT3hOaFdWZ1Z0WFpHT0hlTGJzdXc0?=
 =?utf-8?B?WWVMR2JGYnd0V0lKd2tqQkJHY2ltTlVsYytjVy90UUdXYjVJWWk2TmRKRHl2?=
 =?utf-8?B?V1BUdTczcCtDcFdjVytNVm0yeXYwNTUxcUNoUGhad21mR2FRZUhzcXhuOTRK?=
 =?utf-8?B?NVZlZlc1akNQTjdPK2poeHkzWVRIaUJOSDdJRTZOdm43Q1p0SlZtVmVCdTZN?=
 =?utf-8?B?Y3BhYXJPVWw0aXFTdjcrQlowdFB4dCtHNFNRSXFmSjJyZ29xTVJLd0FVTzdv?=
 =?utf-8?B?R0hOK01YOTFzYW9neFdyTTJCOE16TGd1a0x4ZFNBOVg1KzFLOHM4M0ZlQTc3?=
 =?utf-8?Q?vSjE9awfJeresVYt6UmxjQ9XchBWboTO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEdIWnZETjBTMysrVndSMjhZYnNvYnN3K0szb1FYN2VOTDJhdEFyRldNa29F?=
 =?utf-8?B?dzhkMmxYdFRtU2JzejFXMGQ3SXlCSDdSWXZSeGJ4WXExWnhIZmtpZ1FSbUZF?=
 =?utf-8?B?RHlIaXVVMzJXSzVWcDhmOUlwL3BmengxSTY1UE9NZURKOWNEZTVjcEErQUNy?=
 =?utf-8?B?NHdrRXgvalpRc0N4Z1hzdzY5OTVIWGhINnZCNjFOZEs0T2N1citRVnhlbGhI?=
 =?utf-8?B?RHoyUUV0b2pQMHNPNHdHbmM0dE9TL0NBaFRHMmlzSFBDVjFvbXMzNW9kSG1h?=
 =?utf-8?B?b0ROKzJmZTRzR1IvVFNpRVQyMk9NdFZSa2RpK2dNR09uUEQxdHpRMlU1ak4z?=
 =?utf-8?B?d3B5M3A2L0djWU4zdUQrMFowcmZSVS9vSkMwbkxmN0JTa1ZHd3k4NkF4Vk9m?=
 =?utf-8?B?MThLU1oyT3BrT3A0SXlaWGprUlhsQXBDbTM4Z0ZicFl5NURXMThtK2QvSE1z?=
 =?utf-8?B?b1p1N3hjd1ROODB2STZVWFpoaGwrYng3RXF3RCttb29LcnNyMExmYU5URktJ?=
 =?utf-8?B?RWRpNnQwZ1NoWGl6TEl1VlY5TkhjYXJDdTM1N0ZRSm9ESzFlTXRzQlZqSkk5?=
 =?utf-8?B?TkF3WEJoS2oxU051OHRIUzMrb1hSVndzY3VCdzhUNTNjbTBwTWluQVlMUVdm?=
 =?utf-8?B?RXVLdlNkK1hLckxoVmxpL3ZUL3NGOGhGOGMvY1lHWXA3dm5VcDFPMnJYSW5u?=
 =?utf-8?B?eG9pajZxOEFMNHJPOTR2dGVuMDhpbGpGUDZ3MThrbG5BN3IveUlldWc2Yk51?=
 =?utf-8?B?d3NPZnFiQXdFaGc0L05IOHF4K3pHWG4xVVpuS3QyS2h1QWM3ZVkwZ1BCQnFE?=
 =?utf-8?B?NmxzZDQweVdYem1neUVOZzViKzQ5TzJsbWs1SjNYT0tzM3IxdkZCOVlSZjBq?=
 =?utf-8?B?R29vOUZzanBTSmx1SHNEa0pSOWhoR0VlZTd1LzcxS3phRVpEREFQcVg5d29p?=
 =?utf-8?B?ZkNqWWludDRvSnNNSHBVSEh5NUorcnIwY0NCOXhhMVZuSzM5UE54UVloaVNj?=
 =?utf-8?B?SFgxUC9COUVWK1dOSGlyZW1jMmpiVXpjNEY5QzZ1NGhET0Z4QTcwS3NQczVa?=
 =?utf-8?B?M3JLRFo3ZG5ZbHNKWUhTaS9ML1llcGJ0SVJ2WkM2d1ljZnpPdXNjRW5FNXQv?=
 =?utf-8?B?RER0UGV2STlNaHpsQTdnaUJYbTZDczJtY1RZVkhLY3B4YStiUFRDa2NvL2NH?=
 =?utf-8?B?K3MzTGVzcXpyRHFRQnRkNmR3UmZiMXFUWHpYRGgyTDNRLzdhR3BCVTQzNWVi?=
 =?utf-8?B?aVY3c2l5V1ZFYTFWNUhTd1hFai82Z2NROWFqNWdDbHpNRTBBOGxWUzl1TytQ?=
 =?utf-8?B?N2U2S1VUZXBPblVkZXJNNkJaSk5wdHVCLzY5eE15cUtua0pOK1FGbFJwS2Nv?=
 =?utf-8?B?UVoyenpLeCsxY0xsSVRKQ2d3SklZM3QzT2VTa0dxeHNsdTVYSVNCTC9reVVR?=
 =?utf-8?B?cGxrdHRUNEpFQWFXazFzV2FLN2l6SmxhbERNazR5cjZmc3RaU1ZSdGVUaG0v?=
 =?utf-8?B?NnFXSy9DV1Z0cWZSaXNaR1FpMnlaSUhrWGlubVozR2xFQUM1UldsNE95clVr?=
 =?utf-8?B?YmkrMXhsb3F6MXp4RXpkRDVTOUlmMFVDNEMwSVhXUWNMeG9GU2d2Mm93NjRz?=
 =?utf-8?B?RmlVMXBtcS92MnZVRWt5dGNsanlMaXMrc21WQU5pVnRPcnlJSEptRS9qcmpp?=
 =?utf-8?B?R0JJdXhNcmhDR1NmRWE1UWt5cUJMVW4xTlRueHUrWWNGS2piUlZuN2RWdEly?=
 =?utf-8?B?Z2VSNjU4SG9lU281MEI3YitHc2JkSXEvTnR6QTBORjA4bFpYMG83QzQ2dEtz?=
 =?utf-8?B?ZW1GbHdYVnBhcEVIWnpVejN2T0NaellrUVVwby9vNU9UVk1zV3NSTnU0NW9a?=
 =?utf-8?B?d3NwMjF5RXQ1NkZvMi9ZNjdBTFhhNDhubEdCbi9ieTdrRmtRZDV1QnJtMzhX?=
 =?utf-8?B?dFJYNlZTajB6d2NQTHlJWitucUJXTHc5SERQYlBzQXJzMUtOS2U0bDVXWXFl?=
 =?utf-8?B?YUZ0UlRYdnUzSko5UGhUdlZCaFY0N3RBMGlCSFU2S1k2Mzhoby9lS1RPL2Iz?=
 =?utf-8?B?ajBtNTJpc2hsWHVmRERrQUEvclVhbTRuOXhjUzZ0VzZFL3hPZlNBZXhnM1B0?=
 =?utf-8?B?Y1hNaFBoTVZFVU94MmZGNXhhZGRxRWpYazFSTytLOVk5V092KzF3SmcxQTRE?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcd21e2-fe13-4e73-a3e7-08de39b13d59
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 19:04:13.5950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdUVxIHUhttqagpVQCcFWDm0YF3OJU0gGAAQvh97xk91+Im+wA1UgT+hppYuvvbReKRAraVeNYiws7TMjMZm2CkBzZCzYDtseqWLF3jC/t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6900
X-OriginatorOrg: intel.com

Hi Xiaochen,

On 12/11/25 11:32 PM, Xiaochen Shen wrote:
> On 12/12/2025 1:22 PM, Reinette Chatre wrote:

..

> 
> 
>> not to consider for backport. Could you please consider how you want these patches handled,
>> communicate that clearly in cover letter, and re-organize the series to have the ones needing
>> backport to be at beginning of series?
> 
> Thank you for your great suggestions.
> 
> I plan to add the maintainer notes in patch #1, patch #2, patch #4 (in original patch ordering in v3) and cover letter:
> 
> Patch #1 (this patch):
> In my opinion, it is an improvement (to these two commits) rather than a real fix:
>    commit 6220f69e72a5 ("selftests/resctrl: Extend CPU vendor detection")
>    commit c603ff5bb830 ("selftests/resctrl: Introduce generalized test framework")
> 
> What do you think?
> If you agree with me, I plan to add a maintainer note that it is not a candidate for backport in v4 patch series.

I agree with you. Patch #1 is an enhancement and preparatory patch for patch #2.

> 
> Patch #2:
> This patch is not a candidate for backport. I will add a maintainer note in v4 patch series:
> ---------------------------
> Maintainer note:
> Even though this is a fix it is not a candidate for backport since it is
> based on another patch series (x86/resctrl: Fix Platform QoS issues for
> Hygon) which is in process of being added to resctrl.
> ---------------------------
> 
> Patch #3:
> A candidate for backport with "Fixes:" tag. I will move this patch to the beginning of series.
> 
> Patch #4:
> Already has a maintainer note. Keep no change.
> 
> Cover letter:
> I plan to add a maintainer note outlining how I'd like these patches to be handled.

Since you describe how patches are to be handled in the cover letter the maintainer
notes in individual patches are not necessary. It does no harm though and no problem if
you prefer to keep them.

Thank you.

Reinette

