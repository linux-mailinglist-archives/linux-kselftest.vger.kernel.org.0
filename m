Return-Path: <linux-kselftest+bounces-8846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EABF28B1A01
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 06:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E44E9B22002
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 04:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5420A39ADD;
	Thu, 25 Apr 2024 04:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxyahNoG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750235F0C;
	Thu, 25 Apr 2024 04:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714020394; cv=fail; b=MQk6NwBw5bsHv3XeEhFYh5o4uLhicM4VmWG0Qap17XCBr+hQdDuGm+NXYTK9m55nUdQLI7Blp7BpKY6IjJAF5L78pGJvYWBPK7oH37VEWBLnklSJfzhIRt8htW/bY7QCbVzFJkbn7khjj5YVkhEDeKDk7SEpDJb1zhuy5kLsa5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714020394; c=relaxed/simple;
	bh=MQ6uH9WWOfqfADZzZIwOIiY7CsFeHqQqU401C46onxE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R6bFih1ILWVkcw91IPqiOt4FkeVzDxFKKxq9Dp5GQWi1Wye4AnLh2ZlrY7XeuQKMWMkQIa31ImhTEXQ9itiBfg3NOYi4nRXWSAnQPvb4lrmmosyVzhN5MDdg1frqTJ1nre3vxHuBRJbvIqara53gnMl8qVN/jQWUYoU4TWmi8CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxyahNoG; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714020393; x=1745556393;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MQ6uH9WWOfqfADZzZIwOIiY7CsFeHqQqU401C46onxE=;
  b=LxyahNoGBg1+lZf5XSy4DykWJz7XL3PANjAkz+LNSP4Tx8O7kdRm1IZw
   T4GVzBhwfA8wji4Bifbx+cJZtiQk79RZ+itZ0yAmyI4DjxLSwZud/jbZl
   5Y23YJwvN3g851NAHGt6Nqxb/RQcf6FEZqIZ44DzDl4XV+ZSnXeIYVKni
   miDHsa0GOA/P5pcEACeVseaGIMc6/YHQT4R4070HMsMmrX7qneBQgczWn
   l66ptRqHdIf79Sm1kHRs7wR3g+DmZXSkn6Am7iteVhQ68uySIGGJ1jvcp
   CnE9rt+Nb/ZwvUHYK30KAdT3uRB+bwOaMRtS1RLN22EUeFjjrlGZe/zeB
   A==;
X-CSE-ConnectionGUID: k+ItVWOJRxWN0a5HWwW20A==
X-CSE-MsgGUID: vq8KqbRwS22qwyqn90jk4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="27198769"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="27198769"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 21:46:31 -0700
X-CSE-ConnectionGUID: P0BzXmcpTfewJxdzqrAeMg==
X-CSE-MsgGUID: DB4tuvXtRwSQXpC56hGJ1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="29731250"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 21:46:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 21:46:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 21:46:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 21:46:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSChKH3V8u5Sdlla/zAT/F+D/lBUTMDgwbpS+THPikEFwWvXA3x8CinxqArPbvCSZ3gKJStMl5URAaHDlEIcsun28FQWMRuFC65Ya+WNL1JvS2eeK8zK4tyOWZdNqEAm4AuhIvgXFP7gZyqd51gMYpHa0+TOX5Zl3+mR4HoMvtZOkYZ4hCRCDGbxMve9uxDSa+7MPqLCLBatXWG2DO9gL2+NAkx0XO635iVtXttgqwo3PmIkLQoEDqajVKP5vfzZGz645KYNj34kTbl4srdL0NJaNSM27nAA9ccZOQRa3hS15BfCun0p8lqlgIMo3ahw8BirZ4HMvkKIVfDJJfZ0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/dWTjBfcnlQZLWo389xuPQDk0y38Sqji4v1NcW3yjk=;
 b=Q+TD0wZQ7RIFe+VaTAVQjOoT3cx59Ash3CUXePHf4euN0iIGF1cYiiLbUWcFXaE/MUrtsJr04uPMfQ2tlkEqDaeZyvBiQbY/GHOGln5/8hVar0L24TFesqqygJ35z81EXbtaF+W9tgGdUFaZbJwhAKMTbU83OqUufTha8mlNZYKklFdVp2mkttS6/2Hl9jqF/XABv+jVAz4d4MdP/TzQs7iBgQfNFGkwXf1vqWAKLW2OQlQRY9w9D08Kcd1o2XfA5646vgd51nj7twt1w8a46YDWWITiMJhqAk1Jb2+9uudoBWD3k7Ag0F99Z1IaAgEXM3wdij8YkfnPAODXkcmgrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5940.namprd11.prod.outlook.com (2603:10b6:a03:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 04:46:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7519.023; Thu, 25 Apr 2024
 04:46:23 +0000
Message-ID: <f865d91b-5e1f-45e2-9f1a-cf9feb8c9c59@intel.com>
Date: Wed, 24 Apr 2024 21:46:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/16] selftests/resctrl: resctrl_val() related
 cleanups & improvements
To: Shuah Khan <skhan@linuxfoundation.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, <linux-kselftest@vger.kernel.org>, "Shuah
 Khan" <shuah@kernel.org>, Babu Moger <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, <linux-kernel@vger.kernel.org>
References: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
 <cc46c002-c771-499d-96f7-38db978ae975@linuxfoundation.org>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cc46c002-c771-499d-96f7-38db978ae975@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:303:8c::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: a24314d8-5c7b-48b1-922d-08dc64e2a855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHN2RnR6Tzl0LzIxZGpuWFNiNXIzcXJhUjNQekwrNDV4YTZabXJVemZjUFhu?=
 =?utf-8?B?cW5aNFhwSlJhNm9iakZYQVNVRnV2QlprU2dpOHZmNlRPcWtiV1RzcWpaM0NI?=
 =?utf-8?B?d2RaN2hXcDVBUWcwT2ErMlhDL2lKYkdCOW5PWUkySisyYy9tTEg3TUpIbjBC?=
 =?utf-8?B?WHRiS1hFbFY2NXhJNC9tRTYvL3lwOWMrczhlYlUxWHRUZURnZUNqaTFpclh1?=
 =?utf-8?B?R3QzVkx1SjVUZ2Npc0l6M1VlU2M3TmR4ZFFKZDBvMEJsOEx4ai9uUEk3RVlG?=
 =?utf-8?B?c3VFa1dKeGtHZDhMT3hQTlViWVhuM2dodHlUZmt0MzFCc3BLTExiMmxEV2FN?=
 =?utf-8?B?aTNxTlZxZER4L2QwTjgvMVAxblAvVG1MQ3pUQjNSMWgwd2xkdCtrRTNpZ2E5?=
 =?utf-8?B?TXZOQUxxN0VDWGllTkxjVndUT29VSCtWT2J1NmxnL0VvSjhjbXBOc2FGYzhk?=
 =?utf-8?B?ZW4yNHBDWFA2Nm5acnZEeFl2cnZubSt4cXYvdFBWalFzR3FCNDhnZlNQRGNq?=
 =?utf-8?B?S3FwMm42NHAwWlhlTHRyaHNGa2pyVHN3UGdYWEJGV0huUXhXV0NzSWZoa3JY?=
 =?utf-8?B?TXBYNFRRL3Z2YldMNGN5MURyMkd0YlJOY1dlcFRUUUp1ZWFTUURnSHAyYmhi?=
 =?utf-8?B?bTNidnZVTkx6T1hzQTI2eTZKVGVyQkN1MnVsZUFwQTVOa1BjY3JVczVENnVr?=
 =?utf-8?B?MXBJS1h4RVF1dmFOYWtiRWZnN1FjSi8vTmEzTVUzREtIK0NjSkU1TGdjamla?=
 =?utf-8?B?SE4rMnRqOWduQzk1WlhZai9yUXBZMkFma2JDa0VRQWJISDJrMTF2S0gzZkR5?=
 =?utf-8?B?ME15SDlWZ0hUV05TNDlMeVRPcDV2M0RtTVBQYjFEbU1VRlVxdUl1bzFvQWhX?=
 =?utf-8?B?NktxZnZveTREMGpuUDFjUmpkdlM0dWxJTXZERDNNWmRnejExMDdZK1lFQlY1?=
 =?utf-8?B?RExkMkU0UVNNc0F4RTdIeVZSSjFkY1dSWVNwYTBtc2pYOER3NXBDTVd3YXBl?=
 =?utf-8?B?YVZJQ05adXJwK0pPY3hjbEdqRkxBM0g1dFcyQVpkWUtvL0pTUU1nbXR6UEx1?=
 =?utf-8?B?aWJ2UTZQSkQ1cnkrVlN1SkQ5NnJYV0JlT3NibU10SUZ5S1NmY0M2dzU1R0hH?=
 =?utf-8?B?NWNjcUVQN00rZmE0Nkpsam15U2pmRE4vcFVOL0cvNjVhMjY2K2tDRTV0VmxL?=
 =?utf-8?B?ZGU2SFpCa2VsZjZDTnVRNXB3MUxYR0sySVBRODllVVNGRkx3MUZWN0RjYU5F?=
 =?utf-8?B?enExd3d5RmNmVy9uY3lYU1VHOXN0MjA1TVhhQmZUN2Y5bXFMWFpTaXJDZy9i?=
 =?utf-8?B?c2w5ZlMxWHNQTHd2UzdOcUh0WHJRM2ZHaWlvN3pab0xoMEpXWUEwMUxqQlVn?=
 =?utf-8?B?SmtGb3B0aWhxMTc3UXZaS1hhbjZaNHZnUXU1clUvOTJKM0tmNmdCaXljL1lX?=
 =?utf-8?B?MzVTWkJJOTk5dGdTQUltcXNkeEJ4OUJNOHcrdFRCZXhtT0F3WkZKbnZiNFc4?=
 =?utf-8?B?Qm1lVUhVOW54NzVwS2dkME9mdDNUWFRpQUdvSXJWQ2VXZ3hEaCtsK1ZYaUF1?=
 =?utf-8?B?WnVzcmdlTDZ3YWxNeEROTmNqMHJSWklPbWVscGVyMGYrbkFaQTBQVkNZbEpG?=
 =?utf-8?B?V1pZTHFOS3Y4Y2pIRVVGbjJXZlNHMURISWZBWGI4MWh5SVhMRStKTmJqdmh4?=
 =?utf-8?B?aWR3S09hRERwd3dGUnhrNW1sV3hmMEJ4bzMwRi96MkZ6QUN6MGpuRW5RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlFYUXplWmxHYkNuajlXbmxjWmJKVi9EcTQ0TDFVNEZnV3ZRVnU1emFmU1Z6?=
 =?utf-8?B?dkJkZWVqR2VOTVBKTjJqQTNadGRoUG9zRUlkSzVrc09qaHp2aTdGdTdFMGlV?=
 =?utf-8?B?elAvcG1ha3NWcEx1cjVQaU9WMlFLdnhsRnFKK3p2dlVvYlZNZDdkSU1JOFA5?=
 =?utf-8?B?NWFJaVA4c1RmQk9VR0N0QWFNS2xiVEphTFdZMVRHQ0FRcEdZRjJHa01Md1NR?=
 =?utf-8?B?ZTNzcWNZYlF3RU8xNHZmamc1Tzl4Wk1QSVNqWHRaQUxXTUhZY2l2eUFMd0Mv?=
 =?utf-8?B?cmZlSUpldmhuU3Frc1U1R3BrOCsxZmdNUElYT05nTnVua2JJbEJRTTd0dkRr?=
 =?utf-8?B?MmlBdUM4Z1hYd0Fqc1FKTXVnZFBEenB4S3VBcnJaZ1F3Q2h5bUQ5ODlaK3NU?=
 =?utf-8?B?blluOXZGemN2azA4TnZGMlY1VjRLeG1wSGNuY0JSZXpjRklBU2o4MTlsZDUw?=
 =?utf-8?B?Y2RBc2dHdFlnYmJnd2ppVUdmQWZGMVUybDFjdkVtbi80cWczTUJRalZUUlBk?=
 =?utf-8?B?TWlCc0ttRUhLQWs3QWdUbm5sVndQMjJBdkNRZ0dybjNvMHZwK3JVWE5zdjFP?=
 =?utf-8?B?eUtzNzljUnBPa3p3aWNMZWNFcHM5ajBMOElaQVF3YS9CclBTVnhSSHV0clQz?=
 =?utf-8?B?cjFZU0ZxZTRuYVRFY0tNUjVoYkxBaFBIMXhPSHNwVlpXV2pLY2hRV2VwVmZw?=
 =?utf-8?B?MGZHOENweVduYUQ0dU9ENXc3bERYUzJoRkN6MEUyb2p2Z2lSWFpiN2E2dGg0?=
 =?utf-8?B?clZtMXIrblJYNVJlWWJhNUFBRXhScnNBVXJqS0M4NzJiSElsTlNCVFRmM0w5?=
 =?utf-8?B?SUwrakRhQjN2REtVbEhDTHpubWxZY0JnTDZ1dytJVElEcG1tM1JBcHpGYjhE?=
 =?utf-8?B?bElEY0R4SzRsRzF0MEtjM0Ixamdqb2ZYclYvNkVOSzlZUnU2UXI3cFl6U0hG?=
 =?utf-8?B?THNjQnJIRzdwbHE1MXdnT09lQTVydDduVlorTHl1NkRzVFp6c05IaDBWZEFT?=
 =?utf-8?B?ckR5NjYwRG0vSFZEdHdzdHh3QlZYQXZZaVdqeHhaNG5yOUw4TVllMGxFN1pk?=
 =?utf-8?B?S09jQUhGZGdCT0hRQUF0Mi9MMU12ZVZEbFJMNDRtT2oySkVqUkpYM0xoZ2F1?=
 =?utf-8?B?dnBDQlYrZFEramMweCtXY3Joa2FuZ3cxeDhrc3gwM25UVy9QMDhUcUw3Ym1x?=
 =?utf-8?B?YTFPcjBqcDhna3hSa2YrNndoT1RpT0pSTllZL2hvQlRtdTlxT2Z6Z0pVb2Rl?=
 =?utf-8?B?V2w1dFdZRVRLbjgzYnNSOHl3SExWM09CdU9zd2xhOWpwSFB1VkFOZDBsOE43?=
 =?utf-8?B?UjNhSGFQL29jbmh4U2dON24vT2owMEFJZWtDK2dsOEJTa3NzU0tnWjY5dS9M?=
 =?utf-8?B?bXBKY0p0cTM1MkNWdDE3T0pHQnpWeGtocTE5UTg1TW03cU9QejBiQThXaWJs?=
 =?utf-8?B?aGtZejhucjU1SmJSeTFLRHNBQ3B6cUZGT0JRWURsZHpzOUpYUEJ4cUJ3MXE3?=
 =?utf-8?B?SWxWejkvdE1aTGhJdm9XbEN0dytDYnUxSm5CMUtEenVFOXhTNUc1ZlRjaWYx?=
 =?utf-8?B?TCtDRGVhSHk5ZXk2SWdUMmV1SXNzcTFtVnpsaTQ2ckhtUE9od1ViY05CVDJU?=
 =?utf-8?B?cWlCMVJSZFg0VHAvYzZacEJ0RElvUDlOMkU0VVRjQ05JMTFlcVE5U2FPdXFy?=
 =?utf-8?B?M1V0UEVxZzFZRWVrQjBPQWhxMHFIOEhIK0VQc25UWmphcnF0U0tUekUzRzhI?=
 =?utf-8?B?SWR2UVo5bm96V3hBamxiWHJmeGlOaUQrdkFHUFRlOUJhRmNGWE4wQ2QyUDFF?=
 =?utf-8?B?VWJZSFdoaStPc09iWCtFdmNreFcrUGl3V3IzMEs5MlcxTFNjK0RzMWtVcE5P?=
 =?utf-8?B?Rm43aHI1M2VWN1BLRDZzYWpnNkRRdTB5TVhYWkkzN0luUkpPYTRrZkVYYXFl?=
 =?utf-8?B?UHV6eU4xaGxNelpqS0o4RC9NVUxoS0NGL3pFSkNwa29ta0FPcmFySnVGQVAv?=
 =?utf-8?B?S1hvbHBEL3Z5bE9NWnBBOG1yUVEvMjgwa2NsL2VaQlpraHVDZFFjaExjSXpi?=
 =?utf-8?B?YXh6N0MwbmplejYwejFUUFp2bEVmSTJwN2lkVkloNXlOam9hTk5IcHUzV3Bn?=
 =?utf-8?B?WTd3NSt1NVdWM3h0U3lEMEtjaWJJaGVVenlVR2JQb2dseXRqdGxUaEc0ZkRQ?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a24314d8-5c7b-48b1-922d-08dc64e2a855
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 04:46:23.0648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6m/rL0pXpxiDzJfphDzJVGVm5n12cZCWrcgXwttvFlbi3871B1LSf8yEp4mtLl0py6381OlFLKbiZp4OjgSioZA2V4POpS3RxjJdG3TTwng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5940
X-OriginatorOrg: intel.com

Hi Shuah and Ilpo,

On 4/24/2024 6:49 AM, Shuah Khan wrote:
> On 4/8/24 10:32, Ilpo Järvinen wrote:
>> Hi all,
>>
>> This series does a number of cleanups into resctrl_val() and
>> generalizes it by removing test name specific handling from the
>> function.
>>
>> One of the changes improves MBA/MBM measurement by narrowing down the
>> period the resctrl FS derived memory bandwidth numbers are measured
>> over. My feel is it didn't cause noticeable difference into the numbers
>> because they're generally good anyway except for the small number of
>> outliers. To see the impact on outliers, I'd need to setup a test to
>> run large number of replications and do a statistical analysis, which
>> I've not spent my time on. Even without the statistical analysis, the
>> new way to measure seems obviously better and makes sense even if I
>> cannot see a major improvement with the setup I'm using.
>>
>> This series has some conflicts with SNC series from Maciej (Maciej has
>> privately agreed to base his series on top of this series) and also
>> with the MBA/MBM series from Babu.
>>
>> -- 
>>   i.
>>
>> v3:
>> - Rename init functions to <testname>_init()
>> - Replace for loops with READ+WRITE statements for clarity
>> - Don't drop Return: entry from perf_open_imc_mem_bw() func comment
>> - New patch: Fix closing of IMC fds in case of error
>> - New patch: Make "bandwidth" consistent in comments & prints
>> - New patch: Simplify mem bandwidth file code
>> - Remove wrong comment
>> - Changed grp_name check to return -1 on fail (internal sanity check)
>>
> 
> I can apply these for Linux 6.10-rc1 once I get an Ack from Reinette.
> 

Apologies for the delay in reviewing this. I've now provided feedback for
consideration.

Reinette

