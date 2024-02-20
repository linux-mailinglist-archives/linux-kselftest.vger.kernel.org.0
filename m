Return-Path: <linux-kselftest+bounces-5074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCE085C615
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 21:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468892838DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0227614F9C6;
	Tue, 20 Feb 2024 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4hxTeUj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0B1612D7;
	Tue, 20 Feb 2024 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462306; cv=fail; b=IkGO5dXZ6qnfEuaU2oHbYW2Rr8rjr6EciysAD0O/kKkYj9zMgPNmDJMeIT0mQpiqhgjO/JsVyvforIsfFgA/aJNe5GREt2O7ALe2yxiVeAf9fqDE1GCT6rZPvSCHJjRKgKQcMDPqwf2atU+Xg+cqMvKRJXJPq2a67ZUwnWtr4Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462306; c=relaxed/simple;
	bh=X0LCmOwgVZezZlR2LLDFtW+wZpGYN+2ICscAIVWzSO4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p5kipb7uavUCd/Ya145yw/zBZQD+3vsSd1jzUv1/cCJplZifeya1uxBrSQmRkh6kSYaHB/2netdwI4P/BmM5nkYClNl3V84GYVfE+YuIScvQgJdORf5yMWKRR5ZC3fNXASun5t+AtbDI143Q1VMQ0GxZ1vvH+6b1q6rw1Ye/AB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4hxTeUj; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708462305; x=1739998305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X0LCmOwgVZezZlR2LLDFtW+wZpGYN+2ICscAIVWzSO4=;
  b=m4hxTeUjNAWyLQotve50tnPHAAeHhVV8ckOQemLp47z7brZr30u9d0SW
   dvTVYMuJR5jUA09thKVjPFZCtijVDJBdCS9jzzyxS599la2OvFgsEsCjR
   H+JMvdCh4efBfEU7oRVkSy77UgNOruYBflq1levcWkQY8DoZaXAJA/Mbh
   j0QSFFvFlgiyGocIuienqoojQ25QEZ4HM0tNEP/UCe7fz4puwA/273HET
   cABb7WFjdavrxnSn0PJbQY/94j3G7aCQm8q4cyfyCZGugnQx3O7UFfnth
   LKFugHoMaS9VIRNx1BTPa0r0RZcP3Id3JRq5uSItAuN89VQ3Da6JNhGkI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2726898"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2726898"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 12:51:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="4849447"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 12:51:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 12:51:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 12:51:42 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 12:51:42 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 12:51:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7BOH1/FYgU5QZelgZHIN+AQtr5n/ZG64LuP9yDD7cioF8KsYwCa5GiAKqZV0dHYz7FrQXBBUyIUb+ETGKKfgpzvWxrIbzGvznq7mXap5B3XhEEGk/OmgZMIvLc+kSx6D4ghTmS1+xeonooQqfd5rgDUodOqv4XVSIh2sLEhWOMz93nNUBdzHk+vbnKJHFOsjdQIbPWTxtc6jB7ThVwLH7weCEbgfbgLfgcH50Xwc9h/rVDx/2Asqx84O9OJgQ45QnyKRXaoHI4rJVhDNyUv+X++774tzFKzRFgWnfXFg5JZxrfeMm+9PwsQLxebRypu4TZcu9EvCyJZkV/u+8JdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DBfz2WfI1VtEutwj8lDYIn6U00/49rcSPHV3Gg6bEU=;
 b=nXEwJp7qwZKsgjlulnw4SpPA7foRZrktollg5P9PAOSMNGiDUGrTCxQGZq/TVFpYtz9DQHr9vCwfIYXiPCCSQbHDRADRb1aGur/L0k3WrTqxhFK4CNEvKuZxTgHOmG12sDXHRfGhz9gwPnCcLFeTlKAkY4O4JYrqKmvUsyymVlW8Tno+Rz/gFcGwCRraUc5E12VWuBChZjzP5OK+7ZonsdweFPbkfmztY3x4/6/t3yG3cGADFIqnX7CU8A/4xjvhWW9VwC9nIBvhMEeI8sJI9vPjOJs00MFZcVZZxwdECBMs4YesEO47NavneMUFdUG5kchVv4P23UOlmTjMV/Bxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 20:51:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 20:51:40 +0000
Message-ID: <a52637c3-e5b8-4ef8-b9de-8c7dd0868630@intel.com>
Date: Tue, 20 Feb 2024 12:51:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] selftests/resctrl: Split
 validate_resctrl_feature_request()
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1708072203.git.maciej.wieczor-retman@intel.com>
 <79e6f4b5bcaf36214289e56167fe1d5657cb4d24.1708072203.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <79e6f4b5bcaf36214289e56167fe1d5657cb4d24.1708072203.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
X-MS-Office365-Filtering-Correlation-Id: f3e33431-d47a-4a06-ea6d-08dc3255bcf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A56U5ExnjXqdC+zS9dBuJGJ/Sj59oh/pi6r/tpMDhvknlxOadPB+fMKEPZDZgijbgchTsy8zFdf3XB9xQF90fpiRA6n5ODQS9tQwcf6EC8huYHzL3mxYUZ/lfMDVaSOEWUqZb4Tg/PBxn7T7ZYgVRQ+6EzSPKxI3Ux2klJJRLE0ug5QQbTGwRTCxfi9spuctq5/3HPBw1mn08M5LRJtvKvQMajISttxkw8TS1LtY63tlfBSEL8Y51qAM4uIApQebxZGjtecPvCyLZCc2NT99F4nBrLhOr34fRJiiXDIZf9/R/02l4vGyKAQ0reNvFvuScGq6GVulRiKWcp3yuA6Ws1PV3XsJ1bCaRAcD6jLuVkvM+VeSdE7fM5vNeBpnlQGKw3vmTeRWmDlETbBMhX/khwLmc4U8gXt0JOxo+raIb/qIjGE1GXtHY9D+HigZ4/N51nP98B93/9HLBaEiykZJf2Nw7HIzRvDYmmtZVgjeAMzoZ2EUOLysvwiKpgY+M0iV6ro19th31jjlzthI4F8WvuAfCwgCZ140u9Uh9zK1tII=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1ZISm40TnppSlJPRE9Yekl1Y01Jbi93MkxSUlYrb3A5TVg2VzVVRk1QemdL?=
 =?utf-8?B?R3JyQTVRWS9Ddlh0NWNCT2tKanMyYStsZVU3T0Q2T0NOeEJsU3Y0ZFB0QzBB?=
 =?utf-8?B?K2VKemMrTVpnWTYvS0FqSnNKK1NOK0Rzbis3S3lubmN1V1R1dkhjZ1dUQk02?=
 =?utf-8?B?YWhPSjAvZXFET0ZtS3ZDSnhSUmR1K1RpeWluVy9ISmsxWGRSa1htS2hraGEz?=
 =?utf-8?B?b094WjhNQ2hqRzFubEVkQlNPY2VMMDEwbnhUUTlkNDZGTy9MK2xzbm54d1N2?=
 =?utf-8?B?MnFBbGhDN0crSXVZOW5LTWJnNzYxTzYrYWtIbHhPcXVYdDNyQ0ZvWnpIZnEw?=
 =?utf-8?B?elRUZXVVRnQrSm13QW96WEt3OXR1aDVncWZoaWNMdWxJT0lORStKMkpZQ1Ix?=
 =?utf-8?B?bE4wZUJ6QkpMM1lkSXd0OXpDZ2VjRERKdHN5UzE0Y0pydmNGa0JrZDRBQjBU?=
 =?utf-8?B?Sk9rcndqdGVuTmMzdkVxVHB3MzlkVEwybUs0RHdNTG8wREFsbWt0RWNMZE9P?=
 =?utf-8?B?MER5NXBwNHJ0WXpXcGhWdlMrY3gxTE9WaHNqN2tLeXRRa25aYmlTOE9VQkZi?=
 =?utf-8?B?eG9lZjVlWnhqVmU2cUZvbTgyZWNWaHdYRExkYi9kZlRLd1F3SHFTcFMyVnhC?=
 =?utf-8?B?Y29Kay9DclNYNEcxS2xidVhQaXV4WEtZK1NsZ0JwdkFXSlc4YitBeHFCa0pi?=
 =?utf-8?B?T1dRQjZhWDNIRWRzdkxBSTl6MzE2VmY3bmJrODJkTUZkTFZ1SWRRMmd2cmha?=
 =?utf-8?B?U3EveFBpT1ROUnVIOGpSaUxBWFZIU01NenJHTmwrWVoxdVlVV3VOWUQ1SEdx?=
 =?utf-8?B?ZVNzYXdTYVpPZjd0cXRuWFljdGxNcEtDN0cxRGxUbC84MnU0THFVanRMdlpv?=
 =?utf-8?B?WC9VUXF4QnpCUEFYdHZxUzVuUSs5K1dKRldwQ3BHek8vNTM1S2tWWVJKcHkx?=
 =?utf-8?B?S1QrWHFVY25TQ2tKdXpONCtkMHQvalZHSGxaWnhvSi9SMGNUc0tPSnJFVlYw?=
 =?utf-8?B?eVZHR3RQU3VTNEdESXAyWDNqVnh6Wmx2TVlpWEtWdVNZcXZOL01Ec284ZFZB?=
 =?utf-8?B?MXFNTCtVVW1wTmQxRCtuUGFWVFNlNGNLZHFSbW9TWWVpTjFPUlVDTXVOaHh3?=
 =?utf-8?B?RjNEQW1tVllTa0x5R3lpNDV1QlN4d1REbFlNQnJqRUVEWFZlU0hOWkE5eEty?=
 =?utf-8?B?N1ZWclpVNEpIVnl1cnFidW5VRG81R0JVOUNvdm1aaVR4eW0wQXZhaUUvOEJ1?=
 =?utf-8?B?MjVxaHhmYW1wd2t6RHZXdXFLSFh5Rk44a3AvWFMzYlRWNC8rdXg5N2x3c1pR?=
 =?utf-8?B?U0NLQ01LRWRaZGprRS9FUGNVUnE1Ym90dVkwRjd4dkl5ZVN1WE1PVnlZUUp1?=
 =?utf-8?B?MjdkRDVQVWVjNGF0ZXdHSFlSSENQYjVQUXAxbTVMUFVseHZKZkJVYURsaGRm?=
 =?utf-8?B?djFNcWlXdVJaSG1lU045NGVpOXM2K0dEVzlOYzA1UUNlZ3g0TXVQZGQ0M3V0?=
 =?utf-8?B?eHd4c1NmUXVGRDVqTCtodkdxUVFLOHJISWE2LysySmF1TXV6OUdxcHlDT2VM?=
 =?utf-8?B?S084TlduLy84cFcvS09vY0dPeFJwZGFKSDRWRE5HL1NPNEJaOVRqMEczVVZ4?=
 =?utf-8?B?Vk1pMm5XV2gvRUJwREEyWURJUkxtVmdpT3dhWWc5NldKYnlMQmRmblowNFd3?=
 =?utf-8?B?RlduckFSMDI0K0ZvOEFCcWVneENxcldjYjkrcS9uSlVvOXN1VUs0REFWNHVH?=
 =?utf-8?B?ZFVzb3dtdlB2ekc2M2R2YStaRkdHb0U4SWxOUVQ4L0ZDUmR3L1NQaFdxMzBG?=
 =?utf-8?B?Sm1KT3J1czFBMGVqNGdubGNZaXB1b2RVcFNYYW81R2xxbXRveWMrUGxCTlVa?=
 =?utf-8?B?d1Uwc3pEL3RrTmpLbm5ldjVEbjl4NmpVOG9ZYWg3SzU3L2UwdGFuNEYzRXNN?=
 =?utf-8?B?WXBXOTA3VGcvM2RHbjhFZ1JlOFg1L21KZXRLNlVRYnVTd045cFAvUzVqQWFU?=
 =?utf-8?B?NkM4TC80cENzNnMwRWVtZ1U4b2hRUm9wVGlXem1pOEJaczZhWE4xM3FxalNw?=
 =?utf-8?B?ZmNieEFmdmU0THd2cUVYcmI2YlFrUklDc0p1VE1mSFBVZTRrU3poRE1vZlFC?=
 =?utf-8?B?UnpZSjBmb2xCZk1sYk9aTWZjMVU5SlVaSHp3cDRFNVRyVHcwREg2dTZNQU9C?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e33431-d47a-4a06-ea6d-08dc3255bcf6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 20:51:40.4952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axo4cMhpj3qtorSFKYj4rAeonyQMaa3Epq4jsHLzXbsEEsbyZvDW7Vpr84WlMV9ub0tfvfSCGxHR1deZ8PPvHX/vphsUYBPbvQZdgyDO5Sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5115
X-OriginatorOrg: intel.com

Hi Maciej,

On 2/16/2024 12:35 AM, Maciej Wieczor-Retman wrote:
> validate_resctrl_feature_request() is used to test both if a resource is
> present in the info directory, and if a passed monitoring feature is
> present in the mon_features file.
> 
> Refactor validate_resctrl_feature_request() into two smaller functions
> that each accomplish one check to give feature checking more
> granularity:
> - Resource directory presence in the /sys/fs/resctrl/info directory.
> - Feature name presence in the /sys/fs/resctrl/info/<RESOURCE>/mon_features
>   file.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

