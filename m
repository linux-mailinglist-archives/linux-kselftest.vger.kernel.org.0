Return-Path: <linux-kselftest+bounces-37559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62742B0A48D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 14:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9C51C4396F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 12:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C6F2DAFA2;
	Fri, 18 Jul 2025 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evYyQBLM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA72B2D97B4;
	Fri, 18 Jul 2025 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843427; cv=fail; b=rYi37MIlh8E6eJlhHzPwpSt0PAeDue6dgDhwwpGWWLQPkDQWPnpoH4G39Jo/TuG7y1bvU5ZDtMo6kV8ELxMZkpCugxfPaQZwH5NJsHy9FcZ4GAKxJ3TG8cFFGc3BUOhY3pZbwBbQnmnBp5p+SbDiHEyksr7MRhu054FNqG5VK8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843427; c=relaxed/simple;
	bh=WEQZuOunQajLhPsNi/D83V20ufHT4URDmAVH3U0YxY0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IMDz/oy5aNbk8w9jzsj5s5dTl3EWRhAH9kdDEfplonHpYBa835pu9wTpZ+fA9SBotvGTAETbSNhnaePnUNGvfGTHZ7uAD66GnJKiVfFjnRICxEGqSNfDLwfaH/FFVYDmTc+MBSKQIuOjyxhw8gq9e3b/5rj8BUOq/83bRpjNNM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evYyQBLM; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752843426; x=1784379426;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WEQZuOunQajLhPsNi/D83V20ufHT4URDmAVH3U0YxY0=;
  b=evYyQBLML5kPaTS8E0yO4hgiQfko9B83LX1KwacK0Ygbk8refy8rRf2h
   Lj8jNDJ2LMxXPYD7x+PpZd1ZoFcm54yaq3Ynwdd1zvqjZrRi/9TYTacAz
   79ddcP9zNau5IwlzKdsA6QvVKfv1ZMWhWCU2m7JA6tGfyP/OrG05HO6cD
   I9hCU2oejzi+NLOSLlx1SpUlEc0ua+ApCm173X6YbxmVyVKGDoZjeSKEH
   pjB+JwKw0rpCT+8QczVucd4+1jM9THWqgojMIlr+yrRnxjlEXj57Pb/RR
   DgFR4A/uaFsaQ7iwQtySx28OQClf2uJZ/CacPL0v+OdIxYKnbK5uGuQPB
   A==;
X-CSE-ConnectionGUID: LgrfWdwASRO+jJWOL4Zq6g==
X-CSE-MsgGUID: fdNq6tUsRYm9GUtkZjD8IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="66585150"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="66585150"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 05:57:05 -0700
X-CSE-ConnectionGUID: O8gFhajmQlG60RKyo/GwsQ==
X-CSE-MsgGUID: 1+qp/21qRGifvgwiXyjFww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="157721787"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 05:57:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 05:57:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 05:57:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.48)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 05:57:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5kf58GsVVKNTofs9jmS155la5zDjw5uCI8Zw4sN80Z5UwYKE0K1hvi8qZ2iVTFnElD/4Q2J+ESnj+VGRtKJkn3eR86Uek0EMg34xEYZQkpdw4fyW9kj3ggrX0sS90EGL5J3r6Q9yDC5W9k1tdl4K4rAzD/KCZBKk5bNJZQ1TAZxxp7Z3UYA9ZDfUQo/4WLtdh/JuXSuo/2ffPGtW+Mm9QYYvOz173mxQsRSPkaQppInNgsE2ddRifBdKqN8hyH3pU490nlhDTba5hlyFH0XXlGV6nmrX9XV/jXgNVf9TjVP7dnGpOnQmXiPmVQU+05HMFASOdkgbxurMJlc/KFH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvTpzWw35C4ZUh1ItUXW2UjQwuVhOeurdPqCrIi1rhg=;
 b=Z/2PC+TxEIbhWbdiY6ftd+4hpeluO0joKjG0Z+QbsYD/QwW8tGt4tfzaZvQIF6YcvPU/UqrdMM8rbB0n2HVl94hM29gAn3tKHb2bDF/mSFT3NLL2MX7cejL/gN49EvH284zzwRrVCCAfUl5ETNdN5Nf2TulkHz9Wm4hk1FVKh8KMQjMEpnMjsxP8kp1tgBY+7MXxuyFWLWi6VrNy8ExnVHhXJCFiFVP1exSMu3T5qdvTp+Qy2U5oGAJmDdnop/0O6O+dRGJa9Kb6JCpsXKVko0rGzjF49KseTlYftMoYc9W003pVz3MjB2Y4QREjVxD40ifiBrjdaMuAM70ecsZ2Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by SA1PR11MB8858.namprd11.prod.outlook.com (2603:10b6:806:46a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 12:56:48 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.8943.024; Fri, 18 Jul 2025
 12:56:47 +0000
Message-ID: <ce3d1ae9-dd98-445d-867f-1e8d32c6c741@intel.com>
Date: Fri, 18 Jul 2025 21:03:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommufd: Prevent ALIGN() overflow
To: Jason Gunthorpe <jgg@nvidia.com>, <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	<linux-kselftest@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Shuah Khan" <shuah@kernel.org>, Will Deacon <will@kernel.org>
CC: Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	<patches@lists.linux.dev>, <stable@vger.kernel.org>,
	<syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com>
References: <1-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <1-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0085.apcprd03.prod.outlook.com
 (2603:1096:4:7c::13) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|SA1PR11MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 40607c7f-7be1-46c8-492e-08ddc5fa8e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|42112799006|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVVDbUkvN210WkhaOW9MeHZtbDJmdmw3aUdLMDI1VHJwT0xqVzFuTkJiYmpZ?=
 =?utf-8?B?RlBvdjVQYWc4RjNQVCs2UW9pZWttN2dTeDhncTg4WDBHWGhnSXYzOE5nZW50?=
 =?utf-8?B?UXdiVitNUTZocURMaE95aDBKMW9PY2RndERkbUdzVVZEakxHakxQbnFrNUJw?=
 =?utf-8?B?RVV3dkw1aWVLRWk1a2FyelNwREhZT3JrRmYrSUMwQ0NERmhCdFExQmx3ODZH?=
 =?utf-8?B?N3Fla096M3VXUGV3L0RtOTR3MVJIMTZzSHEyQURJelN0YUd4TlRycW5ZcnM4?=
 =?utf-8?B?dVJsMXN2VVBWRXFBc082aVByeE1ERS9jeWp4KzJxcGd5Q3hsQTJRWXRvV3g0?=
 =?utf-8?B?OHczcEFWOHBFKzY4SXF3eGtmMmdwcS81MHVsdmdVa21VcGoyOTF5ZURHVVlG?=
 =?utf-8?B?NE9sc0Rud0dpTGdSbmltaFpDeGo4V2RIQnUwR1REWkhwcjNEVXZWajEySXJx?=
 =?utf-8?B?dmJGSkx4NldSb0wzY1RPUkxEdEZ5d1I4TEM0ZWdPYXRlTkpDRTd0bDlsSk81?=
 =?utf-8?B?b2dqRTd3OGp0Mk1DUGhlR0IyWWJ4RTRJK3FPU0RKaUtoZGhaQVhBSFlUdjNR?=
 =?utf-8?B?eTJKZ3NtWlV2S0FuSFdVQUo3UmJXc1Y4QW5iVlZYdWlyUVRuaitZSWNCNXZC?=
 =?utf-8?B?M2NwYUV1RVdadlR6LzFJd3pIak91TytBcXp0bXlncHFadHgyUzN1elBVZlFD?=
 =?utf-8?B?UmZFcFY0cGFFRXpWS1lkRXRIeENlVHVPN0lDQ0ZNS0FZb253Wlp0emp5cjBo?=
 =?utf-8?B?cnRMMFlrNkFjMlBRWnZ1MGN2R2c0WHN0Q29LL2t6bThFclR1SlZNaFZITVJy?=
 =?utf-8?B?aGtrRHVNWWtlWFBKZGt1b0JzenhKK29mRTkrSWNJcElONURndW96WlU2NHAv?=
 =?utf-8?B?TW40RkV0ckdnYjZ6TDN5TDlkTkJUaHdOVG5mbGxDUlp1QXlQYVlhdzdUa0tO?=
 =?utf-8?B?TjlYeVRRc1lBQ3JtSFd3Y29DZzRpaW9zbWd5RzB4RElBUWdpTGcySFV5cFZu?=
 =?utf-8?B?bjZvQkw1RHBLdzhpVWYxaVh5eXA0UDRPVWVvbUNUaEk0MlU1V3JmNml1bTF6?=
 =?utf-8?B?cVNVWElDMGRUWE9CMU9GTXEyWm5lZlJ6a0dhQ0JIdllERUJtc2hWR2sxVjdj?=
 =?utf-8?B?bjlpRUFPU0ZESmprbk9tS3NybzFZcTlTQkVReTk3YlV3cEJsUFM5MWFOdEtt?=
 =?utf-8?B?Z2xUMmYrUTdlOHY5WlRweUFaQloyTVpmT21sdUJZbTI4UHhuanFDdVlOZ24v?=
 =?utf-8?B?d3ZST2s1aFFmNXUrc2dTbUJyQnpDQmtnKzlNYUlHT0xhVmYyZkFtVFBTQm5C?=
 =?utf-8?B?WEhQOWhSRDJHTjdXWDdpa1JORkNseHBmdklFaVI2QXk1S1JOUUVmbHJIU0lH?=
 =?utf-8?B?aFlCeTA3SmxDeWNGMVZZREdxR0xFWWlSb0JTSnlYYVdpamt5emxsTmdpR3l5?=
 =?utf-8?B?MTQ1bUQ3RlBMUUFQNDZoU1poV3U2R3FxTU9VSFl3SkdDamlQdnd6RVpVeXJT?=
 =?utf-8?B?UVJLNDVXbXhKditmTWIzVGhzaUgxQnNFdmlOODk0SVVpaTNDMVIvNndNMEw0?=
 =?utf-8?B?MFpmSkFQWTFxTWd5TlZhSDM1dkJqVnBwV05lT09OL21rYmVlVFNwK2lzWDRD?=
 =?utf-8?B?ekJMbU4yQUxUL0tPRDRBQit4QmZEWUQ1cm1GaWl2WmJJWThadm45TXQxZUJp?=
 =?utf-8?B?eUZDeXBobGQveDFFczl6b3Z3Yk5MN0c2bngwbmJ3WWFSTm1CcDlwN1dIRDRR?=
 =?utf-8?B?b2JmbDRTbTdpZldmbXViQ3BEN3lYUFpncTVIMVJDWnpFclRGR2VUbDRxWjlu?=
 =?utf-8?B?YkgwbHJUTUNyZ25aMzNxc3IyNlNUZTBwREJVM0lMYlZ4N2kvMnZ2aE5xanIy?=
 =?utf-8?B?QnRqRmdkRHhUOGtNdzd3blQxK1RxeDhPd3hmY3RGQzhDc1JhbCtvQXdwU1V6?=
 =?utf-8?Q?A+1iIg5XiPw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3974.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(42112799006)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmFmaVozN1VLa0g5bStoazUrS2t5ZnlnOEpJSzF0OEdyeFBDdkMyV3RyOGZo?=
 =?utf-8?B?cHZXeDJwRXJuNWNEYVVMQmVwSmJrS29TZWJRcm5GS1d6U1lyZXZLQWxSUTZK?=
 =?utf-8?B?SlJVb1huUmliTDl2d0tOWDlURFgySitJU3EvNE84S1kwTExtRjl6WGVnU1Yv?=
 =?utf-8?B?MGJRQUxtY1IvMXl5Sjd0TUxKZ2owTm1MMlBabGtqSW1wd0YwN1pGSm1Wb0R5?=
 =?utf-8?B?bWtYdUdqTnhCUHJ5Y2Q0SXREMkhxYm4rNGxnZENWanVEU0pLN21WSjUxNnVH?=
 =?utf-8?B?MCtNN2hhbjRBanA1czFRc0c4cGpkT05lUTl2L0xOMnJUaUF6SFY1VHljaTZ4?=
 =?utf-8?B?ZFhjUGJqTHRpNUphOEFXSExxTmR0RmRCRDVOa2YwR1RrcE5DM0FmdkJobmUx?=
 =?utf-8?B?NWVBMW5NMEdPUi9Ec1VGUVZ2UmRPU2h4UFdZYmNYMXFHdXoxa2lzbWpCcmdF?=
 =?utf-8?B?eFdJVTZTQmxRNThFODlHdEN1VHVsMDdBYkpBbWVYVEdhd0tkUGpKQVJ6Ni8y?=
 =?utf-8?B?RFp1bnZFS0ZjOExsKzdMNUpCMkZvNExvZU8wTVR4MWxLcEdGdVlmTzB2VjdV?=
 =?utf-8?B?ZU1zU0dldThZdERLUWU3U0N0dWVGenE4diswd1UrSmhmV1RyUFRDcXlCb1Rl?=
 =?utf-8?B?V21QTkQ2WUQ5QU5mUEovYnVwM0U4U0FSSXIremFTUW5WaWIwbmNmcjVlZXNk?=
 =?utf-8?B?WXQrVDUxMVBjZGlIcTlqdGlBQ3lNQjcrd0pJNzRJVkNCbGJLZ3o0SGphalpF?=
 =?utf-8?B?OW5RdkF6eUlReXByOXNRblBETm95MEJ4dHkzeGhTNzZTL2dnVmwvR0FUSS9h?=
 =?utf-8?B?cWNScjhwZ3NKUnRidVBBd05BL2I3UzJVbW9xeUlIVVhvZlhzT1V6ZDVLN2R5?=
 =?utf-8?B?QjdVQW96U3Y3V3NrYTJFRVVmRHplY1pxb3ptNnp4SlpSemwyck5YRmhwWnlv?=
 =?utf-8?B?MUc5OFJXTEVsM0EyUlNsVHFRdnVMZC9UNytPSTFhUExERHFROGNPMTJFK1dO?=
 =?utf-8?B?ejNLZXBmUGQ1ZnQ5bEM4OFkrWXlaZVBPcVdLekhWelpIU3lFTW9yNnZZOG9Y?=
 =?utf-8?B?K0xhb251dlBrV1owTXNKdnlHRzI3VEYzS0VvcGJ6Z0loc0FYNjNQWVE3WTFi?=
 =?utf-8?B?NUJxclBrUXV3OG9SR0J6NkxGcjZEbDlYVVpkVFcwaFhPUlNSVGlQV0RjeDd4?=
 =?utf-8?B?NURTM2JHQU15cGdldXYwalYxbFIxVHdUU0toc21aSkVIdWxzcWV4R2FpSUhp?=
 =?utf-8?B?cFp5S1FmMFdVVTE5YlBxZ3lBT0tQSTBMcUQ3UlJ6Z1lKS1psNnZQSXh1dXZP?=
 =?utf-8?B?dXRTZGxLTjh5Rytla0djVFNiMEU5QmNHYVMwQ0RsT0ZQV1V6Vy9lQkJwZjRE?=
 =?utf-8?B?Z3lJN0FvNzd4UVg1UHdVVnFHdWdWS2x3NE9nWGZ4UG92ZjdXSlc2azR1dUYw?=
 =?utf-8?B?dGpHdGVEaWhvbjg2MmtuaFhjcFVkOWliaVhUaTRlays1R1BCYVEvMzl3L0tF?=
 =?utf-8?B?Vk94eXYvUitLNmgwQ1E3YkhZZWtWU1JJa0FLUnozUXZPNG1NZTMyZVNzWllC?=
 =?utf-8?B?QjRqSE5mWFM0S28yMWVZbmRtS3lEVU1vaHNuQVhMem5HQUpSeXZuNnhhY1NN?=
 =?utf-8?B?TURKdEpNNitFVlJtSmlKTHFRdHdXTXR1U3gzdjVEcVEvVlFVTnZJQThiUGtp?=
 =?utf-8?B?aWwzaVpZdmk5cnpMZ1dTUURuc3FKc0VaVXdhTm8vYUhTSG9HQis2Ykt0SHZN?=
 =?utf-8?B?ak94aTBMVnhDMmJHMlJzZ2lPcGp4VUd1cDB1ZXJ5dGcrN1lTdE1mSDBHZ1Bo?=
 =?utf-8?B?alpXdWZPaTUyOUZQNHlRVmVQSnAwRlY5WU1yVDN0S1F4WjBhUlpZWlY0V0JF?=
 =?utf-8?B?eldxRllPVFREQ1lzYU1DZ2RzeGNOOGFDVGp6TklGM3NYb01GaVFQZlF4TWdH?=
 =?utf-8?B?amxDTUlxYSt1SU1JR0NBYk5pdnd0MUduTjZhKzNuamtxQTI2QmVoSzRHNkl0?=
 =?utf-8?B?RE5vdHBGWk8yZDRRTkU5cjRROHVYTkRzd2FQUmhiUXo4czczdFZFaUVWVis3?=
 =?utf-8?B?TzlVaHFISFNwTFVOcFBJdHNzS3VUdFAwYWdVSEJveTlLZ2h5TlVpZG9hZlJr?=
 =?utf-8?Q?tbJJNDVzvdTaMiHDrv4Z3OVCl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40607c7f-7be1-46c8-492e-08ddc5fa8e51
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 12:56:47.8449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SZppHVoAzFaZ37wp9igmGY7rSlzcgFYiedpxEiYLdcStDSmDCgY2ouYKZvGybFL7x5FwgdAXjgORuQK6Gt3cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8858
X-OriginatorOrg: intel.com

On 2025/7/18 03:15, Jason Gunthorpe wrote:
> When allocating IOVA the candidate range gets aligned to the target
> alignment. If the range is close to ULONG_MAX then the ALIGN() can
> wrap resulting in a corrupted iova.
> 
> Open code the ALIGN() using get_add_overflow() to prevent this.
> This simplifies the checks as we don't need to check for length earlier
> either.
> 
> Consolidate the two copies of this code under a single helper.
> 
> This bug would allow userspace to create a mapping that overlaps with some
> other mapping or a reserved range.
> 
> Cc: stable@vger.kernel.org
> Fixes: 51fe6141f0f6 ("iommufd: Data structure to provide IOVA to PFN mapping")
> Reported-by: syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/685af644.a00a0220.2e5631.0094.GAE@google.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommufd/io_pagetable.c | 41 +++++++++++++++++-----------
>   1 file changed, 25 insertions(+), 16 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> index abf4aadca96c0b..c0360c450880b8 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -70,20 +70,34 @@ struct iopt_area *iopt_area_contig_next(struct iopt_area_contig_iter *iter)
>   	return iter->area;
>   }
>   
> +static bool __alloc_iova_check_range(unsigned long *start, unsigned long last,
> +				     unsigned long length,
> +				     unsigned long iova_alignment,
> +				     unsigned long page_offset)
> +{
> +	unsigned long aligned_start;
> +
> +	/* ALIGN_UP() */
> +	if (check_add_overflow(*start, iova_alignment - 1, &aligned_start))
> +		return false;
> +	aligned_start &= ~(iova_alignment - 1);
> +	aligned_start |= page_offset;
> +
> +	if (aligned_start >= last || last - aligned_start < length - 1)
> +		return false;
> +	*start = aligned_start;
> +	return true;
> +}
> +
>   static bool __alloc_iova_check_hole(struct interval_tree_double_span_iter *span,
>   				    unsigned long length,
>   				    unsigned long iova_alignment,
>   				    unsigned long page_offset)
>   {
> -	if (span->is_used || span->last_hole - span->start_hole < length - 1)
> +	if (span->is_used)
>   		return false;
> -
> -	span->start_hole = ALIGN(span->start_hole, iova_alignment) |
> -			   page_offset;
> -	if (span->start_hole > span->last_hole ||
> -	    span->last_hole - span->start_hole < length - 1)
> -		return false;
> -	return true;
> +	return __alloc_iova_check_range(&span->start_hole, span->last_hole,
> +					length, iova_alignment, page_offset);
>   }
>   
>   static bool __alloc_iova_check_used(struct interval_tree_span_iter *span,
> @@ -91,15 +105,10 @@ static bool __alloc_iova_check_used(struct interval_tree_span_iter *span,
>   				    unsigned long iova_alignment,
>   				    unsigned long page_offset)
>   {
> -	if (span->is_hole || span->last_used - span->start_used < length - 1)
> +	if (span->is_hole)
>   		return false;
> -
> -	span->start_used = ALIGN(span->start_used, iova_alignment) |
> -			   page_offset;
> -	if (span->start_used > span->last_used ||
> -	    span->last_used - span->start_used < length - 1)
> -		return false;
> -	return true;
> +	return __alloc_iova_check_range(&span->start_used, span->last_used,
> +					length, iova_alignment, page_offset);
>   }
>   
>   /*

-- 
Regards,
Yi Liu

