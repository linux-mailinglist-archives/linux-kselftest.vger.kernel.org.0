Return-Path: <linux-kselftest+bounces-5488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F986869C8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 17:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4ABEB2FC41
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379D44CB30;
	Tue, 27 Feb 2024 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGTNOTrI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A71EB5F;
	Tue, 27 Feb 2024 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051804; cv=fail; b=lTy8C1vDHqWInffgmbf+vANhxyw/YR6PuiWe8BQfY495KdWbbEveUQpWlNYkCDJBIpWivlGLrgC0Pj/Y3UV018zQIlxTXYuhJCEvJRjvXfc/+g8syUMJKiGc/IJX+eyy7OXmcfKzhrDxD3xcfLADYlRAZ0CGSVzw1iSuxAClbOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051804; c=relaxed/simple;
	bh=NJWz9t+nhoTvaFASHruCFrMZZNwNGkJkyJGQOcRx7O0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A392sxJPOsf2YRtArtEsnOHYtcTi4bvmcbzz++CfAERCb0UnqBOoB6JUj25iJNhR/f1lj9NIfOc+9uzkp6qhFUlCYqrBBQ4YUaNmoMSNwaUE4DVfNUOvLdmEPEURlr4aIUM3f2YSQwifaNIcgij4c8MLT3sRubCfWe/exD7FREs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGTNOTrI; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709051802; x=1740587802;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NJWz9t+nhoTvaFASHruCFrMZZNwNGkJkyJGQOcRx7O0=;
  b=kGTNOTrI1rg5rBeQJLyJOJ2isMpkQC26twSlz1FFOdHt9O9BqNXWCUZH
   V/C8BN7pFvYpjtHgVNbGwKrRj7okSNOQPADSsC4UakzivYhnBG6xY2ZR+
   +3SNoecmGkvf83f6Teuh8BVBtpivXmUHelVfWMgsPDXkHhisreZJAr3Zz
   KiYQkMI3VdDmN19TXnnIBBK6YA5jQCJqHhfHKTV2NSGM91pRxRdt23pKQ
   sTlJHPXERKGNd8xEe3GgOS1f/GQVoS+RWGhYQWiYT3ZOZbSMRET/JN6fE
   VIGIBvLxJiJiRA423+m+DO/07Z26doWSVPNb581xGrtfhfoNAUYO8BhEo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3566573"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3566573"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:36:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="30283691"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 08:36:26 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 08:36:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 08:36:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 08:36:24 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 08:36:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES2S71O1HGQTio09lAQzKnSsO5l3r6Jx+30LIgIDQ6Dq5+VB62Xhh5i8urV1MVTJyEXjOP6DOwUwqVQaXE9nTBshdcU3upJUyGOYm+sSnjO1cKJPssJVq/PWrkA70ULIH0iwF+CzZlyfD6fNCn7ei/eB7fvUe3PwAnO9EAlujGsHZvxQsGm5mt1TlkGsSA3gL/454FhZf8tyBsnVVdlJGN4j0LCZP1OVhT6aufVJ9+4sa9U5TsSXHIpexgw4Trgj19Wg0tMR4kLpa2jiU+Pnd0UYmKJRbq5UgBgZrt3GGAXZSHV7lhGAFP1LpTLpqaS00hoG0YCwu7Nf1i4cdV7mUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM3hRvIdLod1Awn2GTlNN4JfsXYpT+3ZxZc/eKJlGdU=;
 b=O8x7ek5JuZFKVoXPDIkWchCjoHTTeM/1RymuCZwEJ9uIIlDskYuPSNYRKZ7wpWOKY8eIdHvyzrHMjVme6zNjBFMXw8HZzaA0zIote+FvMwjDG+uVVX5SG+Rv814B3c+d202FOdI5AP+u67Puy+eCyDsWFAOFCLkcoaQh5tUnB0bUCHCHmdMIIvgf3nccrFMqK+7QkBXnVTrE6tz33M4cZu8VVBMuoTsfODAmG0shWrQX2fcMHsqbk4uY/w4guNY0dyCKD6+g8+aj/DP24YiywUorSMMC+cMhHBcmPZMO3mk3XjbcRN3Cir0NIcQQYApza8JdMpbOGqXHgcHV5g3pjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CYYPR11MB8408.namprd11.prod.outlook.com (2603:10b6:930:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 16:36:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 16:36:20 +0000
Message-ID: <ac887a4a-5647-468a-9696-4a3909e42561@intel.com>
Date: Tue, 27 Feb 2024 08:36:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] selftests/resctrl: Simplify test cleanup functions
To: <shuah@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, Maciej
 Wieczor-Retman <maciej.wieczor-retman@intel.com>
References: <cover.1709018050.git.maciej.wieczor-retman@intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cover.1709018050.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CYYPR11MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e7a8c1-3d4e-418f-392f-08dc37b23a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CE+HyuN8fGh1H9aHp0Ds42wFOLHu9jSmQTNBFyoDIxeYCfKF6ttZlZdrlVQW4ORuE/lS8BwFTNv4202DuAts7RIWJtnv6+YHrHC38a2+8BQdVScYuscRDzRJ+TxBF1SUshFuuQxfqP/h8IjRt+uwAvTso2TQqR/ceWCyDAKObRMWv9Ss5phFff12b1lQ22414YrllGdPSTPozr3L9YwCchTylkImxgAlB1HgSpGLnYq2p+db5WoW7cVYaDkeineIYSPrc2nK3n2TAoRjnu0gIBrGEM49Sg3V/w89AnVFjAi3XBH5Tol3l9Ar2634S76fMtZgRg/a0stKbAeh3QTxf8RwGnNs11xwrWhhmXNeCiI8+m+o2tBC68QVbCM6WdQf0I0gXjzE7yZ+x+2p+PDUGx0t5gEsSf/ariSatzgAHFr5zq/qv6djng/7dsiZFRqUSHb1Ao8B6yphMgvq+sH1LFIeejREDjQKH78itsfPuOp3O+hkkP4rMnSeWKsMpU+df8dnAA1wDmQdcGgqNBrdWYf000oBNvlRfHfCNRelilwKeAQnLWnsZ+kfBonGrv3eshvqJKyDmKGm24ZS2Dzi77ma33rXDuIPD6ShXlpnnyb1PsIcU5+4oV1DNvN9iwE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjhTbjJubFg3dXNIYzE0ZzV5K0R0SEFTN2YrdWV5a05iUHMxaEdkMldLelpQ?=
 =?utf-8?B?L3gyVTE1NXlqZFQyZEZmUHg5NDBkYUhwdmtQYWxJWnFZTnYvcGlFaTFxbUwr?=
 =?utf-8?B?TnlTTVhLeFdqenRKZXc3SHgxdXVqZVFSbGFMRG1TZktUdUxDaVdwZFV2UUsy?=
 =?utf-8?B?NXE1S3Z4ZUk0bTJVdUFnQStoOEo4dUVYVVdXMjRGUEZIZ0xkQmNWK3FYTFVx?=
 =?utf-8?B?djNlbzJxb0lVTk9nOWFtR2RSU0tWMFQ2Vk5aVHhOVGphaVNadUYwRTRFdlo3?=
 =?utf-8?B?UlNqeWtCTEt0SVJvK3pNSHhQUUllN0t3NkpjcWNNTE1DYzRMc0svTSttY0NO?=
 =?utf-8?B?Z0JhYzRCVzJZTWRkY0NKamJlU1lGaHYyWTVibjRGNkFUQnd4TXczOVYrSmwz?=
 =?utf-8?B?UTlqWXhaUndXdDFhYTNoMnhyakx6MHBjWU5IbnFKSXJSNS96VnpGNGEzaG5v?=
 =?utf-8?B?WWVzckszVVNkRk5iNTNvTmRheWptdmhzUWZTdS9ZTXNVckl5MG1EREVyUXZW?=
 =?utf-8?B?WGRwYnhjRk9KR0tiWmpIaTN3Zi96bnB6a2FKcHNxTXFaVk02UGNKS2xwR3Br?=
 =?utf-8?B?VWFBRnNZbXd0Uk1Lb3JGeEdDck9wSHFDUVJNNklYMWgwSERkL25ENXhJb0Vx?=
 =?utf-8?B?Uk1qNVJobHpubVI2UmFKQUk3eG9HR0JLR1BLdFZKbWlwNFkySUhrYTIrSDgy?=
 =?utf-8?B?VzRCdFhnMTVXM0s5UGp4OFROc2R0VFhCaHNGWllsV0JhdHJkeURQTzRFWjR5?=
 =?utf-8?B?UFJvS25jT0VyYjlnaFdKY0hSQ3BwamNTQXRZWExOSUlzbXN6THd2d2dMRjYz?=
 =?utf-8?B?V05jNjRpNWZob1dLWmZTTzdWbzJaRlFKLzRyalpheEJiODc0Q3pKMFdLZGV1?=
 =?utf-8?B?VlJxYmtLdEFHb29pYjF3QmU4STQxTDdFMEREeDM1M0RCYWJpVk1WWkM5K3Ir?=
 =?utf-8?B?MjJGMWFOclJVL0NmcTJIL1NCOUpSQkYrTG5FNEp0clFXWjdkMDF6VFFHUnBH?=
 =?utf-8?B?TUNCTklLTDB0aEcrNzZKK0FlcXBkWDc5Vk5BSjRIWlhBQ3lmOERYY09xRXBk?=
 =?utf-8?B?R1VEWW1SZkhmTEVsQURkUm82UmZ6SC8vYS81Z0hqb3hoTkc1Q1UwM0xvOWJs?=
 =?utf-8?B?aEhaSmlRSFdwMEFBK1BGZEhFbllCcUZmOHUxTStHS0J5Vm9PTGxCZVgzV1Vp?=
 =?utf-8?B?eWFsa1VBUEwrWURXWCtld0FZcE1LcTBicGx1d1RaZ2VMU1RzVTFkN1YvVFg1?=
 =?utf-8?B?VU9mYUw5WXJhNUV3QS8yMHB5ZWVDaS93bzR3MkdHME5SQWlXeXhWN29vQXlS?=
 =?utf-8?B?RWF2c3NyV2dXYjFKWTkwY3JidFc2b2JwN29KeXg4SUJpbHNaUzV1OGdjN0x1?=
 =?utf-8?B?cDVrblZCVHhBa1c3dytYRGNzVmp6RU8ycFZYWHJsRGpNcEpLME50WHp5ZDFZ?=
 =?utf-8?B?QWdoMXJPVUFiNXh1dG9YWFh5SzR2K2hZT2tEZmh3T3dIMU5jSlJNMmpZaEVw?=
 =?utf-8?B?S3MvV1c5QWV4bmxMYnJkd1owWGdoVDUvMnJ6TGcxOXFlTnFDVHVXdER4UmYr?=
 =?utf-8?B?QnhMU3NId1BYaHJyYi93TVcvZDNmMHVlR0ZXYno4MkNPeHdZNEdrQU9vaG9o?=
 =?utf-8?B?bnoydURsQXpZZ0JiTklJa1pvekk3Wkl4c053ZmVONWkvODByVTF3cWVrU0JU?=
 =?utf-8?B?T0xobjZudER0NWFld2dOSWNDcUJLbVJxWDEweUsrRkVCcXh4UFpETndFUVQ2?=
 =?utf-8?B?ZHhFUGc5SGhrNU96dTBKK3hNZjlWNW5zb3FrWXBaRFJQcUJweFQwVXJ1N0dj?=
 =?utf-8?B?QkNDTmFPWWEvWDErcUFxb3FDTjkybm1OaERrQkRkaThtaUMxVjF0WDdSRFNQ?=
 =?utf-8?B?TEZkamVTRkE4ZVNGVFk4ZzZ6b0tUOG9kaEl1TzVRejdxb0d4QWY4UlNpUDE2?=
 =?utf-8?B?ZlNNcTJpWEh4RFB6aXRFeXpxVTB1Z2M2bUVCZXQ5WXg0bmhFMnVDM2VPZ2NK?=
 =?utf-8?B?dnBSZUdubzVpekpJb2lwTlNqa29uZTJ1L2V4ZU1qNTcxYzNPLy81TSs1NmYx?=
 =?utf-8?B?NzF6TzFQOExIeU1DL3VLa0ZqV1NmVWxyVW90TnZ5aFZwWm1ybTZrTTF5Y0h3?=
 =?utf-8?B?N2dGajBGTENrL09YZ1NUT2JyTzIxYVFFYytmRGZSbkFtL0dNWVdMUUJGTHhB?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e7a8c1-3d4e-418f-392f-08dc37b23a53
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 16:36:20.3753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWjuFvEEPtot2PxIMP7U4RKA0irsNEwIYtv7hUBUFZrvm/38Qw0MtrTBoqNCIEIqON9WUbnCN4JLiCOm4onUnWzxBfKF9fLD5LOO+wH3NIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8408
X-OriginatorOrg: intel.com

Hi Shuah,

Could you please consider this series for inclusion? I do admit that
there has been a lot of resctrl selftest work recently. This should be
it for a while as new work is still being worked on. 

Thank you very much.

Reinette

On 2/26/2024 11:21 PM, Maciej Wieczor-Retman wrote:
> Cleaning up after tests is implemented separately for individual tests
> and called at the end of each test execution. Since these functions are
> very similar and a more generalized test framework was introduced a
> function pointer in the resctrl_test struct can be used to reduce the
> amount of function calls.
> 
> These functions are also all called in the ctrl-c handler because the
> handler isn't aware which test is currently running. Since the handler
> is implemented with a sigaction no function parameters can be passed
> there but information about what test is currently running can be passed
> with a global variable.
> 
> Series applies cleanly on top of kselftests/next.
> 
> Changelog v5:
> - Rebase onto kselftests/next.
> - Add Reinette's reviewed-by tag.
> 
> Changelog v4:
> - Check current_test pointer and reset it in signal unregistering.
> - Move cleanup call to test_cleanup function.
> 
> Changelog v3:
> - Make current_test static.
> - Add callback NULL check to the ctrl-c handler.
> 
> Changelog v2:
> - Make current_test a const pointer limited in scope to resctrl_val
>   file.
> - Remove tests_cleanup from resctrl.h.
> - Cleanup 'goto out' path and labels in individual test functions.
> 
> Older versions of this series:
> [v1] https://lore.kernel.org/all/cover.1708434017.git.maciej.wieczor-retman@intel.com/
> [v2] https://lore.kernel.org/all/cover.1708596015.git.maciej.wieczor-retman@intel.com/
> [v3] https://lore.kernel.org/all/cover.1708599491.git.maciej.wieczor-retman@intel.com/
> [v4] https://lore.kernel.org/all/cover.1708949785.git.maciej.wieczor-retman@intel.com/
> 
> Maciej Wieczor-Retman (3):
>   selftests/resctrl: Add cleanup function to test framework
>   selftests/resctrl: Simplify cleanup in ctrl-c handler
>   selftests/resctrl: Move cleanups out of individual tests
> 
>  tools/testing/selftests/resctrl/cat_test.c    |  8 +++-----
>  tools/testing/selftests/resctrl/cmt_test.c    |  4 ++--
>  tools/testing/selftests/resctrl/mba_test.c    |  8 +++-----
>  tools/testing/selftests/resctrl/mbm_test.c    |  8 +++-----
>  tools/testing/selftests/resctrl/resctrl.h     |  9 +++------
>  .../testing/selftests/resctrl/resctrl_tests.c | 20 +++++++------------
>  tools/testing/selftests/resctrl/resctrl_val.c |  8 ++++++--
>  7 files changed, 27 insertions(+), 38 deletions(-)
> 

