Return-Path: <linux-kselftest+bounces-5075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A76A85C61A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 21:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FEB1F239CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 20:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F85151CE4;
	Tue, 20 Feb 2024 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HH0aESLu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E02151CC8;
	Tue, 20 Feb 2024 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462334; cv=fail; b=ti2QU0mdRczue2tLuVp5ARaZluiV75qMNmYEpDW+1bQnKeGdydcKcudNqi2TGZlobzrN8eXDHQXohxNXMil5YFyVkiaCcz073vR4zW7kn19szK3aSA0NIdCigFxOXiYfj1OERen1lGDAEM+Z81wMYUB/v5ucqfQrOdaGPYRLE6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462334; c=relaxed/simple;
	bh=1n/DqZputpO4U5JHHQZ7c5NNbQ67UFIiaYyRep+ayMo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TR7Rkw+AFsNjQsn9pltFAgsx63pZqehMdEIsNPFZkipF7qJK4Tq+C9PRRra+AvzljSK9oRC90raQGpUt00zDABSeAWQmMaEr0V/ex7AdgtO5hoZaRF4hy6IKEGBpyFwQMmCnnYeblTgCdG6nJcthAJfDnvZ8GaW+IhON0mj157k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HH0aESLu; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708462332; x=1739998332;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1n/DqZputpO4U5JHHQZ7c5NNbQ67UFIiaYyRep+ayMo=;
  b=HH0aESLu1TPovYl4s0VhKOSiviLISvgOSb69hFxFOd0IAhJ5QVSyCg1r
   NnNyJ1HwQaETESihjeCOCNWmlh6Kr6ziIh3kMb05bSSRpmNNEXfi5mWlm
   GR9eHad4+A/Ds1DakNNQtj5JI4rZfCxYwR+EQX9BqAnIiO90jyUEMcSUp
   Tin77wrpCqtJRzdbLDpy2Snu7s82BMZDAbaeIKwUTw6TvLZkL5h+SGVCS
   Q4srNGAVpRvgulfgJj8qKAOtMEvr1dVEBATM5pKWgeX5Eu6F7/IiJna/L
   ncXT48e9BRboWy3LUcxRN68cDGkvfh41mgze+TtfIgk3GUH4MFNnBbYYf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6367936"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="6367936"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 12:52:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="35666216"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 12:52:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 12:52:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 12:52:10 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 12:52:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+M/eSL+c7y+ViLQtQMidbyrqWLeAAY2LGOWAWBDSWQHuXdzLZYe2jB1nu33zVl7y3+6aCTYnDvZ8OQji6OY4YwxaUAJenDq/1gsg5T5D+jQX/wkKWn0RmmmlJ1AHDXd36HLxygd8FlEhZhn/wG2aHStUxFvUZ4jwl1G3gP/uMYAeEO0jBmmHmc5MaskkfhLY0uuMv97FEs0LFPRoJxiPcp2HmGERbGliXnJ7pWF9gb3ANh3OS5K7PQDLLVVY2VS/Q7MlrHFkmsJaCpj8vN8aeH1hvi0HKRTJnMxzg3eIeGXnn6ONgJIW5ofNBNFCndxILTU+uqW2NGOjpnRJB4ing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0iYlpCmmrYmm0sm3+wtCfQTH9tpN8nX2lACnt/CQSo=;
 b=lbjwLj/Q0tq53TsNzB2mRg02rG6C5LaaTbv3slvLTp97Ti+wxmPJFw53xdVCuSwGGpJseHqRhJQPuXLu96ousuF7kdrOm7Es97FAOCNpTqy1BMoCu4Mk9jfw3GnR4TMLQx9CckWJkyh1tfcmuDBgki9/WCCYTuqHrFPm5akZd7ipZM6J+6HLwEkPB+aI9DY4XnWoZ1baz2+cBGpe6EbWKKJ/tGjYxGaQnm+yHNpd+QQeTx7SvUevpSzVPq3+XYKJ2U/X+NeZJzhUf2nvOzs2zEbmnf5WJWbDLdu9EXJa57KpukIUylgsuTvyuCBIvLj7HR4OcuO3hNse5VwT9BqCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 20:52:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 20:52:08 +0000
Message-ID: <542aa1a5-85e1-4b09-8bf7-7027e45108a1@intel.com>
Date: Tue, 20 Feb 2024 12:52:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] selftests/resctrl: Add resource_info_file_exists()
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1708072203.git.maciej.wieczor-retman@intel.com>
 <c32b59c8826216a0841d8499038fcc2e965927be.1708072203.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c32b59c8826216a0841d8499038fcc2e965927be.1708072203.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0185.namprd04.prod.outlook.com
 (2603:10b6:303:86::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c641df-1ef1-4b4a-fe81-08dc3255cd92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: En+8zFre8QGS2wwEtvlyZPrUK1K1u0fHY0SfeSFpYWdeEAaVjDBbKyl7rloR00e6Dc24YHh6qy/5ohs1enyMY1zfa/u07OMl7+ep7Zy8bCoPsve7v7Aywm8vdL6+MehhBEj9vHhTOPtT7G3JqeGsuX4asp/gIpG/XZ0LL8QuNq8m36DOos67KCkzSstwi7xcq7q8DtRYyC3zu8dV3pQiFJZPLMBVn9MqmlrxXNIYuusRl0CY0bwdDOyEp5QZNiaXkp/LtAair4SLYkAqC052i7npwk7BoUkXwjbbp65lMo7LB18kCntF0rwARI9QEd7wKwUIYTcGMm5hQEAtsfoy+VMPIbAxVQShFcT9qEBq/eJjXzq1/5vNBziGsWxEUkF/XyvutTDVgcHmRk9Zt30idpc+IRI4GbxHKJz1j+A4Tvhn9dSpGSkL1fSI/ipvoHA3zp/YEGsMQkX1JwpeiU5b9sB1DqbnLy5ZzikxUOloSNTNuzW0to7kKkIOzVJzhDTg8JkDR7Snw5CJ9oVwlzd52OQgijZJMDkCdNE+L0yffQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2hTUitOV1VBRTdrYkdZcmVaTWRYZ3Q1WnZzUkNXcHVBYzhGRVhtN29Xdlho?=
 =?utf-8?B?U0x6c1QzZEZDbHNOaWNKbW53aGp6UVFjdklqZnZJMG5udTlvOFp4aHN4bExN?=
 =?utf-8?B?MlhOUTVPVWkvcmVaU0hueHgxalJuN3c1dHZidkRHazJhb3F2OVVGb3daTjM4?=
 =?utf-8?B?Sk1veDJGYVJ6dW45aVdlZVh1Y2ZibE92aS9zZnlCSm5HYXBOdzZMcWE0bmJN?=
 =?utf-8?B?QjlWR0srYUx3MTUyNkZvamk0d3NwcDZ0RWtscGMwOS81RUR0RS9IN2JWY3Zo?=
 =?utf-8?B?VEx2elBWMmtwSytSMWV1eUlxaDRMbGVMME43TU9sQjNFdjZqZkx2OGZoSVh3?=
 =?utf-8?B?SllvbW1EbTRVT3lyZmdwWG5uWmRDaHI5UmRoOXBDR1RJU2dyTlBDYnhvNzRo?=
 =?utf-8?B?NkJrTWlUb0ZuRllxS28yVTJnTldwaXRWcnpqUkFQT1hHY2RzK1FTa2drNnMr?=
 =?utf-8?B?NVRmOWlnT3E5akRCdmVON2N1U0l1djduUlQwUmZjS3VyMVFRSkZxMkhpT0hh?=
 =?utf-8?B?RFc3c0ZwMEhDYUIyRnd1NDAvQkRtTkJZTnNkQjBOMjJTcmhHeWV2R3ZIK245?=
 =?utf-8?B?REsxcTBNeFJ1d3M4RmJleTdHWUlQTUJwdHZjQ0RvL0JjTW1vOXFaRXZKME9l?=
 =?utf-8?B?SkZTejdvMC8rRkV5aWYrcFBBZGpWUnRZOElOaXhRVFhmZ3c0aEM4NWVoS0Vt?=
 =?utf-8?B?MlV3R29Kb3J4bjF0dDNwODcyVEF4N0sxOUlsZ3Zkb2NGWHRwQWdWMktVb3JN?=
 =?utf-8?B?T1F3eXpMeWU1Zkl3QmFJcWd0OS93NUVGY3ZaNUFqcmZhd2xWUnNvN2VMa1lw?=
 =?utf-8?B?T2NSbEpMNTQwZHlPMHRmNnRkNmRObXR5MU5NMkRRL3B5bElUU3FwQmlnbmU4?=
 =?utf-8?B?Qi9PRjM5RUJucDIrdUlRbWN6bmpWUDlWa1o0UjdHN0Rzc2xSc3p3NlVXVGY4?=
 =?utf-8?B?Z3lwN0F1QmhVcXBkK3BXQVIxQktsZVdkYkFPeTFYbWhpQks0Tk1tVkxtZGR2?=
 =?utf-8?B?dzExNUtWQnRzM0pHcmdoajAxRzBiZG83ZEw2TUpyQlkvSEs4SXhudE1KaHdB?=
 =?utf-8?B?aFFNN01zNEF0Qm1pY3M5bm8yTHFjanhsRmQvTjVWR1ZPVUUzMmptQ1lyWWtn?=
 =?utf-8?B?RnFOakozaDlNZFk4MHBIaWRYd210MWhpT082M211aFdXNTByQWdMN3RTd0Fq?=
 =?utf-8?B?YlA4OXErSmlOS1UramhDaWFSWjh5UXlyRzJ4NDdqdjB2di9KS0E0OVIwQ0xK?=
 =?utf-8?B?ZldSOThkV0lwVklBTFBsWDhtRFU0Zk5zeW9PejdqTjFIM1drVUdzcmp4Ukp2?=
 =?utf-8?B?TXF5Qk1UbWFHYTc0UnorN08rSVhsT3RmdG5xTmM2M1JUbWRxc1JRb0Y3Vkpr?=
 =?utf-8?B?RDRPSjFuWEhUUzhvdzJHbWw5WGlMMjdHYmRWQmRDbXhJWitDaXh5UjhWMjE4?=
 =?utf-8?B?Y2ZCUmwrNHVJSWU0Q2xNbys2TmdZRWZxTjV6U09MeHRlbUt5QUhKV0dHUUQr?=
 =?utf-8?B?WFdsYWsxZE9VT1hRekpjc3V6NWl6TXNZc0xXTTF6OEVIaVlNTWtCaEI2ZEZS?=
 =?utf-8?B?WFV1Z05tM25SZ29RRTYwTXJ5SUQ2QWxMYytWTENHcXZIZmJtam1yUTdneldH?=
 =?utf-8?B?Ymg4N0VlL2xCbFJ1ZkZZUmtabGtWb0hXTlRtY0Nrdlh3ZnNBQytRVVhFYVVk?=
 =?utf-8?B?NWVIUk8zb2pibHltMm5jZm9Wa1BVcG1uaVEzeVRLdE1TbUNZU1VYcGQralYx?=
 =?utf-8?B?MVlvUDlFem5BWUJYeHB3eGNldzY3dWU0Zk1uc1g5SjdCbTl1WlV5YjRVaFgw?=
 =?utf-8?B?K2N3T3lRRjJTL0xxZ2k2OVpkQXk4bllqNzhmVE8rb1VqNmJCZmpYM1p0aTcr?=
 =?utf-8?B?Mm8vdHlleHNEK1Y1T3ZaYXRtdGJnYmhyZmJXbFZDWm00VzJwRmtNY0trR2Zt?=
 =?utf-8?B?NUdKVkw4R2dYN0FXaW1LMUphdmY5d1U3QzVTNURCU2IyR0JiL3lSYWIwVldQ?=
 =?utf-8?B?MDRhRjRQN2tRMHBNK2I5RDR5WThWNnpqRjZjdnZjTzdGNTVCWk9XVG84Ylh4?=
 =?utf-8?B?R3ROQ1FQMzkrWUwzd011UkVaMFlyd1R3Y0s4TUI0b1FRbmFrQ1A2d3p2d0cw?=
 =?utf-8?B?cElCc1UzeVBnWEQ2aWxPbTNvaTgrVmFzdGcwUVRkaXdtSThrVXVwMlZPSTFJ?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c641df-1ef1-4b4a-fe81-08dc3255cd92
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 20:52:08.3531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOs3ay0lceuvaOEz43XZDsaar7tkiQxZVL4XlVxDLraJ1P98zJxoePXUFbhveBe7LfPjDDy/zAPfD3sk4yltCVGn9SAK1pZ4N1iFCJZ0RE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5115
X-OriginatorOrg: intel.com

Hi Maciej,

On 2/16/2024 12:35 AM, Maciej Wieczor-Retman wrote:
> Feature checking done by resctrl_mon_feature_exists() covers features
> represented by the feature name presence inside the 'mon_features' file
> in /sys/fs/resctrl/info/L3_MON directory. There exists a different way
> to represent feature support and that is by the presence of 0 or 1 in a
> single file in the info/resource directory. In this case the filename
> represents what feature support is being indicated.
> 
> Add a generic function to check file presence in the
> /sys/fs/resctrl/info/<RESOURCE> directory.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinettte

