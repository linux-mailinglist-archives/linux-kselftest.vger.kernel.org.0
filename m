Return-Path: <linux-kselftest+bounces-9901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEB78C1822
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 23:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C292C1C20BED
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 21:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525F084E05;
	Thu,  9 May 2024 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLXSE0XP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC8480034;
	Thu,  9 May 2024 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289118; cv=fail; b=Z4v1JWZFtHrv9eTTddDfSYd2cV1gspI1DgckaNLr2/raXBSBymRwlsDzJBU5lACScHSwEjlB4+4rcPm5U1zrc6qjd+C0OyzZ+K1kAzIlZ7SmrRIeW1tNo8SkPe7zacBpHTWsXTGJrp/MNPcXF2DHcIQVoZGJwCvC6KdxGN9ZP30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289118; c=relaxed/simple;
	bh=5B0u8MX+w7H4dGvKdrWkl1EEnpbq2EMrrC3yWk7T1kA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YmXu3cJojPq/tYvusJmmbYUzQnCdBNYJRAdI3WD4kMn4oiA/AeOhqP2ch2Fj9e8+Ao+EM9xH2C8i8UfF14Deq8VwhP+iSvv23fvLrvV/hAk00YHcy2SLe5BRlQIULjARNNsxLEG/kW6tqTS0bwc5B7uQ7N/h2dwCIrGJ8YTZV4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLXSE0XP; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715289117; x=1746825117;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5B0u8MX+w7H4dGvKdrWkl1EEnpbq2EMrrC3yWk7T1kA=;
  b=GLXSE0XPGGg4xIvaXGb+9gONsWEx7lpWOTolqdrhFrltCYBRuHY3OSPN
   hXqVxtPl+OrfLgaKXTnbuTeaeU25h1btW1vFb2L0xfRzPC/yEW1N3VDLs
   VQUPvkHIeDjIwkRCD2iZyTassk/1Hnrv3Ss5RDdqCXWNMMsTKCzfaNVTn
   WcVhx+X93c2WYl6NR3/SeWR0LCnnGOhKhYpaOvL5hj3ThcBitIKd6jLtz
   LrKAxds+CkHbJfSKJ0ZS5Qpdzp2zVLyXIg5KQ6PInTzgCtRCouyMBKH/Y
   Ic9eVfi6LLZT3EPHrPK8wk6uRafSOPuonWfGKzEnzgqxQnG7ciLGEHan9
   A==;
X-CSE-ConnectionGUID: 70CYyylQRnGQVjJHTlyEcQ==
X-CSE-MsgGUID: PXbW4bi5RsmroA+KNNffcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="14192903"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="14192903"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 14:11:50 -0700
X-CSE-ConnectionGUID: ylc2oazTTUWOqx4ody4zcg==
X-CSE-MsgGUID: f/T4DUtiRNuqH70S00IMJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="29241469"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 14:11:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 14:11:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 14:11:50 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 14:11:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIgygte3r/bcl62wsca0P55RWroAoIi+9spkWHtSKaULnQWuv8HvwDwrcYsYUshyvLnE0IWuvG3+DaCRzaB+RrHdzMWkAC1ysXQ7oJaZx5ZA1q5DiMmBMzrVyXjWhcG9+1On5VfYRFxKxDgXBZrdTuytQkbEdTWugt0JbxcWNjcbt3IIvPwyaWEZaIWubeR7kdWCC5SyHbR3YEMaeUJfBiGgOveHhBQKQH2PVYxYpR9dCkaT4F+lXZBHcZhr3tFkdEWu+KwBxFUa1qAtZd63TjX2s8LV/hoopNIg1I4KK0cv2TdsVRGmZBziSUF6a8oHzAZONAf9fWnQJAejTTxT5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwE3lu+v8qZF2naXpUqz7KC4IzsBdYEEtNnwvdHsvuc=;
 b=S53+KSvczngUGF05eTQecz/MZ9qUp0vyaVzfEtpUXNqc09NmKU2T/nixEYB2l7XTh7mIjeCeDwU0e4+u36ntVYL0CgqD2RLLsXIAtRpW0QKLU2L4zjtPT3VgCg2usvYSVdTLabAZLzhkbLY+mcvOaGKIbxo7ZqyC5NpqkMvRzKTDM6kMGT1xcsCgCdxRW3p8f2VraV5SL2k6GkyU6bL7T+UVj3VHOGKTbdZk7gRfFUMXCy0IflvuOtt22KV+yALU9G4vBw26syHE/6p+NAJlk9eaNTpQ+GgsC0D1IuJUsghe1FB/UAF+krEOyN1TtoQWTmvjFEdHdGuJ8GzIsdzxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BY1PR11MB8008.namprd11.prod.outlook.com (2603:10b6:a03:534::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Thu, 9 May
 2024 21:11:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 21:11:46 +0000
Message-ID: <91eeb2d6-e0bc-43cd-8641-ddede63f3786@intel.com>
Date: Thu, 9 May 2024 14:11:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] selftests/resctrl: Add support for MBM and MBA
 tests on AMD
To: Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
	<shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1708637563.git.babu.moger@amd.com>
 <cover.1714073751.git.babu.moger@amd.com>
 <0367b45170fbc7411aad12c28802284a298c1c6f.1714073751.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <0367b45170fbc7411aad12c28802284a298c1c6f.1714073751.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0329.namprd03.prod.outlook.com
 (2603:10b6:303:dd::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BY1PR11MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c10efd-c2e9-4c7d-2b4c-08dc706ca26e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3FuU3lNbjNiaWZ0QzNOY05WcGV3VVVDdHlIR0gwajVmRnFnMWcvOWpsY2xo?=
 =?utf-8?B?ekZ6c0NsL2RaUnNuTGwzS3duVmNUTUc4Qyt3ODY3WnpEYjVZRkYremNyRDBY?=
 =?utf-8?B?RnptWHlQcUM3bncxN1RETTg1UnZrT1FoWHRYMEhCY2dLRHpoUXBEcmx5S3Fl?=
 =?utf-8?B?TFVpWDJHZGhxajRadXV2a2lLRERMOXFYRnlUTC9yeDdnZ1l3b3EzS1UwblVt?=
 =?utf-8?B?TEE3WWFLUCsrQmxuUXd0VElTSVJ6eUw4V091UGQwY2xKQmJVanNiUHlsVjBT?=
 =?utf-8?B?WXlKSHl2RjJZS1dzSWRuTEV3UXBVNlJDTVFoSkZnR0wyQVpQbHdFNU5hcXJu?=
 =?utf-8?B?YzcyR2h3a1FUWERRYVhZZEtTVXV0WW9SQXphcmk2ZXRhMDUzNG9jTFdJcmIr?=
 =?utf-8?B?L3FYRWlJcWg1OHNKK1hiL2srNUNzUmdHR2xSb1lEZXlqdkxyYnQwRHNXQU9i?=
 =?utf-8?B?UkhyNkk1b3hSRitCdmo5c2dwcDJjZzMrS2x0WVBESVBMRVk2ak9HUU1uWlYy?=
 =?utf-8?B?bU56eGZrWjBKdUx2bFlubmVQeDBUUzZMclh6ejliYUV6Mm9rYStKRmlYUEZj?=
 =?utf-8?B?QS9tbm1sVXB2OU1xQjZVWWVGRHhzYWl2VHZWRUlFUWFqcTl5aHNvVm1lRG9P?=
 =?utf-8?B?ZEJCc0pOaEk5VlYxV1RLclJqRTREQ0dSL3FUdW9MMWJXcHkxVmpsakpHdHNW?=
 =?utf-8?B?eXJiZHpUR1huL1lvUmhNMHZva0ovK2RodU5tL01ZR3NrNEYvTGV2U0Q2RTM1?=
 =?utf-8?B?MXdvY2pTSG9NNk1aNzBGUmQvT3NSS096a0t5bW9yV2NCYTllR3V3VDdQd3Bh?=
 =?utf-8?B?elREZ05LUjFtYlVYWEZsd2NjSDhBSmpFZTM0ZEJSLzJjY21EQ0pPU2VqaGQ3?=
 =?utf-8?B?K1pTZG1MSE9uNXBKQ1ZOcEo5Qjc1UUNDYVB4SUJMOWM1ZXN0ekFUYkg0NXoy?=
 =?utf-8?B?ZGZocmZzZTFpeHBKcnlrbkFkMW1aODBHdVRPVGhBUWtucWlJVFRTZlpzMkhI?=
 =?utf-8?B?cVpvZG5OMjlkRXlCaVFCaWp2Y241N29lZ3VrYUNpWVlSaENtSERTMjlHODZ5?=
 =?utf-8?B?VTYwaElmTjVqQTQvV0NjZ0dtTm00Si9TeWNhV0xPSVpPUXhsQkphNmpwUWRI?=
 =?utf-8?B?NFdOSUQwSTZna21FSjJtSDN1VmJKUkdCSlZuc25YRUVCam9RTU1nQkJPbkk1?=
 =?utf-8?B?dG9hR3BOTkE2OTJCeUZWNCtHdzY5TjI5MXRORjFrWUpFdmI3Q2lwQ0pCMndI?=
 =?utf-8?B?aUpPd3plQW1ySGFjNGhCVEZzbFlqV1A4VnkwM0hsVnhtOGpOQ3pWeW9BNEky?=
 =?utf-8?B?N3JzaHpCc1ZmbFJUNzdodXQ5S0V2NXpTRkhaS01yUWZNNW9MaS82WkIrcURG?=
 =?utf-8?B?VmpLQjljRDZsNjZ4S2VveFFDcHVUS3htdjhXYUhOUlVUNGZCVjhVSVRDV2Ry?=
 =?utf-8?B?WkZPU0N1WWNSVDBGMzVKQU5wTitCa0IvcGlYU1B6ajVmU3RWaVJjbUlhRXUy?=
 =?utf-8?B?cU0xbktEZ0x0VFpwWXU4eWJ1aHV0anNIbWRkc2xRM0JCMUt0dzJ4WGRrNnNl?=
 =?utf-8?B?ZE8yenNpdGQ0RENFSmFpVkloRy9KNVkrWmJJRlhpb1lZTlBZNnRSSkUzQVBM?=
 =?utf-8?B?bFJWZVhVbUVkWmg0NkxqZFMxbTBaaEJZZ09PYXNTUHVaamJWZThXQzMwMlJ6?=
 =?utf-8?B?U1RxbDd3Q3NlcGE1cEQyY2dXd1preTc5Sml0Q2RUTzdaU0loejRleUlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzJKR290d1dTditTNWw1VHJsejlmR1FWbGtsSEhzY1BxQm9ER3dzK2drbGlv?=
 =?utf-8?B?eTlLUDk0US82bW5JNDZ1YzJQUVdXN1JpcWJaczlsYytJMU9zL0dTZ3drb2xC?=
 =?utf-8?B?S0hNTk5NTk80WStacmV2VnpZU1FMN0pwdWtLdmNWV3o0dnhrbm94a0pTVVdu?=
 =?utf-8?B?czJhaG5Kc2hmcHprM0lVZktPR1c4c2sxamNtTGt3allLMjFDKzlhdHozZytm?=
 =?utf-8?B?VjN6WnFGZ3kvcFNqb2N5TnJocGJVUjNncVJ2T2huOGY0OG52R0pPeWlxT0FM?=
 =?utf-8?B?aXRtY0pyTjhsT1BjQUVyRHpxYmVoeDRRem94SjlyL25xYTJhb3RKMk1LYWV2?=
 =?utf-8?B?OWRad1cybXdZSndZZ01ubUErK1NoYytaekZDY0JscUMzQmZrYnVFcmpJZHpC?=
 =?utf-8?B?MFJhRnA5bUxPVFVlRUFtM0c3bFlsS2dlQWhKWS84eHcyS1YwQkhXdWd6Mzhw?=
 =?utf-8?B?TndOMmxVYWJCS2JWeVpGOTBiU0RlMEp3Sk00MFV4Q1g4T1QwTk1nYlYrSTJs?=
 =?utf-8?B?V2VRZTE0T1pQSzh1dDAzZExqcUgyTW9kYnQxdVVPRmNKdnVIZmNiVVh6Q3RK?=
 =?utf-8?B?bUUrbVpNSkNVdCt1Y0R3Uk9iVlZaQWtxNEkxQys5QVgxaHJLeG0vOWlKVDFt?=
 =?utf-8?B?clFEakpsZ05VWjBFQlU5VVhFQmtrQXFVZkhLMmN5czQ1NzNUOTJvc3JLcWlo?=
 =?utf-8?B?OGxVVjB3TjlCSGEwVlJxSFVKeE40dHpHaWdDVjNWaWxTSjMxVnlSemJNWk1q?=
 =?utf-8?B?a0tjNE8zeW56a1dWTTVGaGJacFJsem0xbVdtQkE0amRzMStFYzZiVVVYeS9p?=
 =?utf-8?B?c0EwcVhzOWh6dkFZUjJDbHRCMklUcEgrR1BlSS9GdmRJRllGckpWMHBscjBD?=
 =?utf-8?B?WFNTUzE3N25KR1N6dEhONWxLYi90SXpBWUN0RzdRU2FuK2lHWUlHcVFLblg1?=
 =?utf-8?B?anZ1TjNBWGp3YXBMbVFXVUc2eW9kSk94VUVXSmRHMEg0WE9sR2NzY1dKR3VR?=
 =?utf-8?B?RlZkQ1A5eEF3WmVlVXgzMzR0aDdodXpseUtwdkxFbEsxSEZZdFRBNHA3Q3di?=
 =?utf-8?B?aFVoMnY0ejI5RlQySklwQ2gvQ0hSbytsTnVVa1UyTk1aS3M0MmF5b3JINFhk?=
 =?utf-8?B?SU5yWnhKUkxMc0lWWWdrUWhVY1Jreklzd3QxdTlBVUZFY05BbkdvQ1hRa2h3?=
 =?utf-8?B?UWhGcUtvenZaenY1S0FpYUJ5cXJVMG16UkJDOGNxcVJpZldOaVpHY2p0N2NS?=
 =?utf-8?B?T01ta3JoeERsTDE3SExhZStCWDRmZ3o4NkloSllEcmFDUzVRVlZmajJzTDFR?=
 =?utf-8?B?TWNadjNIbjhoeWR6MVl0THJDb1U4QW8wQTJ5UkFrOStHd1NGS3ZLQ0I4NlQz?=
 =?utf-8?B?L0tUcWpRTng4U1dkaHhUY0FmcU8wQ2ZIVkdMSC9jSlg5TU1zUEpqd28zcXdk?=
 =?utf-8?B?TDVhUHR3UnMrdXZPWUwvYWg2MFo5SlBKY0U2WUl0QW44NkVyVlBmU256aG9a?=
 =?utf-8?B?cDBvSUt2a0R0WHVLUStQdFExOGEyT2o5SVpMOC9qOXk4aTYzTWhmS1ovVVpu?=
 =?utf-8?B?THFnSXNVbHNjaW9LSEphZWYzWjg1b3NMS1pwZG1YdzRIZldEZzRreG1PNFpI?=
 =?utf-8?B?RkFuVHVQbkZCVTRBSmxlMVVGRHZ4VkMzTHV3S0Z1d09hNG9yVjBDRGVMbUty?=
 =?utf-8?B?cHJ2dU5sMWZ4WENuVE9zdlk5ZXdjZ3lsUWpacktVNkZaQXJIVmliY3FPTE9q?=
 =?utf-8?B?WXRCT3VRTndLcllCRFhzQ0NjR0pjSHptMnRycXk1OXIxVm9ockVEemRXYVZ3?=
 =?utf-8?B?UjZ4NU02TnBYNFRmUjM3dUIybmVpNlVJb2pEN2w3Y3VSMkNpblAwaHp5aVVO?=
 =?utf-8?B?RndxRFpvTFNHdlJ1NE5nZWR0TDVhQnNoeUltMUxzajBLQXB0UHBIWllTV3pz?=
 =?utf-8?B?UThZd0pMMUZCUG9SSzFzYzhzUUdhT2R2UHlxRDBzdzMzemVNQm12RzF1OXlR?=
 =?utf-8?B?dnZRckNvUzVtaDMyTCt4dnhnZVUzTGhoc3lBakNYZTVVUnlpTGVpSmw1WldK?=
 =?utf-8?B?SkRnTllhcDZUS001ZVpuYzBTVVFZczJlbXlicU5GMXZETHh4Z2k5YnIvV0Fx?=
 =?utf-8?B?SUtDMGFsY3hUMjZpbTRzQW5Ka1BXZzhFb1BsV0dqTnQ2cWtlZWtLNVFWTFJj?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c10efd-c2e9-4c7d-2b4c-08dc706ca26e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 21:11:46.4916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWVbNrmrXrfrcA4ykPFii//sntgWkcUnad2MJOueocjbTJn7XkPszGbr2iEuALICte20chdTLOtzUKSwC59IGkzUbIIqLZTeax9UUCpJdNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8008
X-OriginatorOrg: intel.com

Hi Babu,

On 4/25/2024 1:17 PM, Babu Moger wrote:
> Add support to read UMC (Unified Memory Controller) perf events to compare
> the numbers with QoS monitor for AMD.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_val.c | 67 ++++++++++++++++---
>  1 file changed, 59 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index e3b09128ec3d..d90d3196d7b5 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -11,6 +11,7 @@
>  #include "resctrl.h"
>  
>  #define UNCORE_IMC		"uncore_imc"
> +#define AMD_UMC			"amd_umc"
>  #define READ_FILE_NAME		"events/cas_count_read"
>  #define WRITE_FILE_NAME		"events/cas_count_write"
>  #define DYN_PMU_PATH		"/sys/bus/event_source/devices"
> @@ -146,6 +147,47 @@ static int open_perf_event(int i, int cpu_no, int j)
>  	return 0;
>  }
>  
> +/* Get type and config (read and write) of an UMC counter */
> +static int read_from_umc_dir(char *umc_dir, int count)
> +{
> +	char umc_counter_type[PATH_MAX];
> +	FILE *fp;
> +
> +	/* Get type of iMC counter */

iMC counter?

> +	sprintf(umc_counter_type, "%s%s", umc_dir, "type");
> +	fp = fopen(umc_counter_type, "r");
> +	if (!fp) {
> +		ksft_perror("Failed to open imc counter type file");

Why go through effort of changing to generic names and then follow
by using Intel naming in AMD specific code?

> +		return -1;
> +	}
> +
> +	if (fscanf(fp, "%u", &imc_counters_config[count][READ].type) <= 0) {
> +		ksft_perror("Could not get imc type");

Same here.

> +		fclose(fp);
> +		return -1;
> +	}
> +
> +	fclose(fp);
> +
> +	imc_counters_config[count][WRITE].type =
> +		imc_counters_config[count][READ].type;
> +

Up to here seems to be a copy&paste of read_from_imc_dir(). Could you
instead split read_from_imc_dir() so that AMD and Intel can share the
code to determine type?

Reinette

