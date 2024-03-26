Return-Path: <linux-kselftest+bounces-6674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6503F88CFE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 22:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977A41C3392A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 21:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2260513D53A;
	Tue, 26 Mar 2024 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnwMbH2f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1ED13C9CD;
	Tue, 26 Mar 2024 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488026; cv=fail; b=lrk/cIZxlkd4mojgccOqm9TOJ0tAUHAVZ/u+E9yRaactGftDWKEBfD12StFSQvrLLELIN1c7zs2g7PT5dK1okoCRjVjTMmdCH/7ZJ50mMF/IsEj2L9ogRWOxO+uUcVMXfT02E3uPdXLVg+Ar9eCbKvt6SwlHK+EHs/VJOYUyqDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488026; c=relaxed/simple;
	bh=Mafk1qidWxOQFPZpBYFYowhehpYD6ZU5kfrust7sOUM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oz9KaQt1kMbUr+UXNm2T8JnlOfSZWwZKYUCGxCjW/P+/NTj2LVvAYBv6WUedw+HGojsb8GZnndRFutPF7ghFS8ChhUnZwU1YZ/1jb/xh6EVUECMZcRpByD0HNMfZoOiad9FVCOS4P6tEKR9IpaG/u8Jsv3ZSOah/eIs7mA/2du4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnwMbH2f; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711488024; x=1743024024;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mafk1qidWxOQFPZpBYFYowhehpYD6ZU5kfrust7sOUM=;
  b=LnwMbH2fBdexDb/EeFwK+4ofW4v8AM5yB3tz548z+3K42U1pKmnnM14F
   NXzWtJpiEFPfm8uTqwBpxd9kpsS00v/ESJSd2JpbK5InSEOLTeODGKXYO
   yd+9qhQjRoX6Z8eYCKoyELCZiCBOLtVzPFU1DNrPR2kcXwPzycdkyoFIF
   XAlKeUe3G/VX+HB+wws45D7ooMzskthff2d//G2VXUqQ3UMQKdiftwyje
   B1BYD4i41L8Larh4ACVVXb9+m5LE9bfUhYgTawSe8yyrHOLBDA8d/Mfey
   wsWv0fg6ljYLrr5apLspvMsR3eCJ+N34EluI8lqgadeNr+yrl5bLjtWYo
   g==;
X-CSE-ConnectionGUID: rl66/rKITeqWjam+sht1CA==
X-CSE-MsgGUID: E/ovHTJHTbiJ95xPWM3tqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6674481"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="6674481"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 14:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16147944"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 14:20:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 14:20:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 14:20:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 14:20:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfFokiHf6Vv6gkmsysE+4FnzU2+Xn8SYAzjm01ILWSCtAE8GAdB0qbDTl81OrjrsorfaGIvy7m7rq80fqdF87mBLzsirdCYKWrK8NC/U7Yq1j99XGkawlu0Qgv+QBAyqehlj/mnXgfSwysFWBf+rILI5vGkSUr2+AoKEPnnjylIR3K6rHRyJdAHEFSeLRT10/njLm3plOgmkFn6bB9ivvbW9r1lnV3ka8FfcHx/47NTk6rILzKAeqJEyJp8RQnGMtb34D1D86ZQqed5nbSBiA3Wn36wC3rCLvj/FYYLOyJNPgzgGaUEaSOzp+VnAawOy2hL0XL+pwuSPGSmhFyCm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQxtJgQSDm8MaUkUriB9UmgJl6hIlCHQMYv02juC75o=;
 b=TSVT5hDD0FWd6pOhyNyAdTFj+XNs9QX8xVInSSDGg3mTKfdKqqRM3QCDVv60n/CIBghTjSizOKEx83NEfyGfXYVQC/Ye3sA9lQcKqGe2nu3GJ5hKJAN12Lqe6Zo0ENtVztsE62bCH9tqEUxTAi4yEiOowHamnvRvDGiG/IBVlvB49L/HNYIqkaW5hxy5s1CcASE2I35QsdWOd+AYE3oH5Vd4eA8Swky9SkvK0D/yaTvbEBtfIA5PhdqTjRr/fyX2ufpEWR4MJaq8hHwGd0qPengQXtaNHsI1LFN8XMEjMVew4KhhflK2cLkUcSR5fOaHhI0X4tEKKVcgqC3i4+flCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by DS0PR11MB6328.namprd11.prod.outlook.com (2603:10b6:8:cc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Tue, 26 Mar 2024 21:20:19 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1%7]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 21:20:19 +0000
Message-ID: <a2b8e7b3-2f38-40a7-9e3e-c2cfa2ba8892@intel.com>
Date: Tue, 26 Mar 2024 14:20:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
To: Shuah Khan <skhan@linuxfoundation.org>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, Shuah Khan <shuah@kernel.org>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, Weihong Zhang
	<weihong.zhang@intel.com>, angquan yu <angquan21@gmail.com>
CC: <kernel@collabora.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240314114502.466806-1-usama.anjum@collabora.com>
 <9b30d5a7-1a23-4f48-b6c3-4908535a998b@linuxfoundation.org>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <9b30d5a7-1a23-4f48-b6c3-4908535a998b@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::35) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|DS0PR11MB6328:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mmba6l2Tx/KFLo6IOZwtvHxIZtq/9az6lAFspV+ta60E7VmKsE406/3Ij2BpRX6pV25HDNTD3YBVzzut8wX+63TKy776EEsZmzgfAczqKr6SJAhjwWgRclwdlmbdOwTkTH0Hu7ka2wXpg53v5bMuteBtaGIsGxo3rYqsIyY/UBrxAyTaqXqQsORHbTNzMLAwkKn5MIlGSOgI80SJCddx7QPQmek0ddNU2E2avFyLNX/KKpWXzq+O9v6Ci881q7InMljAkare0Hyb3GdUTexb3KR6KtIm1m6ssCySNAtj/qmCfCCan17OGV9UCH3Nr6Q+xGBelfhXEcS39jYwSEY1z1bFoQxyaQUYpBrBO4Ikrn8mPF0ghslge3a+xTvUczMKU3uje+1SFt0Kcqv9x5Tnm9rpOsfwepz1UApsLi1ioQ3Bk+e1wBU6EfWm/wlxEv5Hgyr9hd++kOTPU9qcCG4czvyXm1J0wwmRmew4WGYAp9rxYcr793qD4aacbacBlUwp+XZzGvJT5UvOHS8OMRaaoJW+RsVyxg9CpB+hLhzTLm5vBkTSaxOpYg9JkNAsv36kjEyet2ow7m8cIB7EBwxvQLcYreMjSWTFFO3gDzcvXTnk6u/MCUP7+tfbIfVKVJ1E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OThaZXloc3FLNFNrczNvU0M3Q1RTNzM0amwrakJnUEhBWXVMWkVQVWI3SmZz?=
 =?utf-8?B?dDJzSktQQVpUWHBKVnBaODcvdWszUWJOc05UdjhaSUlHcDJyRWhhdjIzRDVW?=
 =?utf-8?B?RFpJbWlzdlU2SVRpUUZFSk5rY1Z2dDJ3OEVnSkRxNzhFWWFydUtTZGVoT1Ro?=
 =?utf-8?B?LzMwOTAwdHFYMTF0VUVNQ3I1Sy8rU0s1TjVhZnc3UmZGYnpnSk1oRENVT1Fi?=
 =?utf-8?B?Z3lrK055Ui82ekxlUnEyY2hoTEVnUlRpeEZvVWJLbW1SdGhGUkNTQXhJUVkz?=
 =?utf-8?B?U1NVV3ZqV3IwNStnaFJsSW81Y2ZOaHNYQ1ZPUWd6aW9vTzVzM0lPc3ltM1lM?=
 =?utf-8?B?d1ZwOTNYemYvVjRkRVg5Q3ppbTVPbGI4dXUyVU1Bamx6K29GRnpnZVVuaDhN?=
 =?utf-8?B?QTMwUER5RnU5cm9EOUNUU3o1WWZjMXozcHQwTUpDMVdYTEV3dXJ5OVU3MGl1?=
 =?utf-8?B?eHh2emNsdStmTUxvQnFkTFpaVFlKTkN5b0h0bGRkZnpXNXlkRGdXQnpjOFcv?=
 =?utf-8?B?aFAvSVFLSk9nSUZva2tKdTcrUnVaQUNEdDJzTFVrcW1NSWY1Rjh6MEVydjQz?=
 =?utf-8?B?dkt5SkhsQmNwU2VWS1BFSmtiUnJnV3pFTUZiUkZnY0hLcnZnVlVxZ1JiVDd4?=
 =?utf-8?B?ZTVzb3F1amJmUVovTmhKZDlrcisrdnRsZURoVzluMGNIWXBTbzhvU0dNTHJK?=
 =?utf-8?B?MXVCcHpCUFlPaGVZQmdwb2xHU0kvQmR4a2V1T2l6TFpXaGZOYWlZdCs3WFhB?=
 =?utf-8?B?NVNlYkorWTl4TzUxUElvWU5pd3g2dkJOTElQNnR1UjRpajhNcURDZkU3ME5S?=
 =?utf-8?B?eTFqV3NIVzBkZ1A2cno0SDNUMldUQTd1YzBPa0pIMExZZlJDQ0p3ZkNLRUJJ?=
 =?utf-8?B?T0k2TU9tNVZMb0ZzcXd2OU1iTk5vRE1MQ3ZDOUg0dXJuQys0WW5qSVJ2NTg5?=
 =?utf-8?B?eFR2cW10Y0RtblF0YkY3enhyQ1BZdjBDRzU2UndhK2ZLQ2xieENwcThDcUVa?=
 =?utf-8?B?bnlOeFVualh6NnVTVGVaVE5aM2ZVdW1Gb2lsN29Tb0U3SW9OL1JtbWlaNWVz?=
 =?utf-8?B?NlNNTTgrOGNST2ZpQTBzMFprM0xjQ0ZtKzhZZkdmdWRlYXROYmVlR1BPaHhs?=
 =?utf-8?B?MlU3WjBjNHpZenN5LzVVVFZFdDViSkx6RGxmMjF3SmdKdGpqK0VBQ0hvRlo4?=
 =?utf-8?B?UjhYckxFaE5xVTk2djRWNVFGRjRUTEdKOFNIWFdoM0x3eXlYY0RpZ0MxbWFR?=
 =?utf-8?B?RFFvNmFsSWhMaUdvS0krYnZIOHVWTzdQalV2OE81YmVpNEh6dERIMVh3WWd0?=
 =?utf-8?B?MVRob24ydTRMSnFaWFFrY1NzZHY5cXM3NkV6TmxkZVVxTlZxajlYR2RJVkV6?=
 =?utf-8?B?SHoreFJqdzlUNHhFR0RqSm9GVW1IN3A0dm15YWZlNER6b3JXUDJ0S2FzMGVa?=
 =?utf-8?B?NC9FbHAyM0plditQZDVaYjUzMmp1bFJubTJJbnpPeUNSc29USWhkSkc0blJl?=
 =?utf-8?B?T0NURmRVc0tRVVgzQlRXT2NIRUlFcE9wVmpqTXg3MTcxdzMweHA4MVpkalRP?=
 =?utf-8?B?V2M5RmNiSkZzYS9PcmozTnNWUU13SnlQbFRWOTNLOXh3ZHJGWXE1VXdLYjBF?=
 =?utf-8?B?bUp1VzZuYkljWkRUSlFxczZNVVZHODZBb2E0WElYYklsaW5EazNwRjVXMWZH?=
 =?utf-8?B?Wjl3WDVLZHY3MkVDbVJMeFRxZ0dZZFRkU1JDeVQ1djF1Wkcva2Faam85K2Zw?=
 =?utf-8?B?YXB5UlM0eEpHUTN5MWxCVHBzWXpGUGw2anUwS2xENitrYlpmMWN5TFR6UGcy?=
 =?utf-8?B?QjFjeDJMcENVV2ZTUE53V0tLUmFKZ2g1QUIxd2xHWDdiQkc0a2I5bzErZ0Nl?=
 =?utf-8?B?ZXQxaXdtY0xVWFhPL3NsSGlNV0cya3cwYk5NSzFlc0Q5M0grRVhlSXZYVXpO?=
 =?utf-8?B?TjRVVnhiUzBnTS84WTE3VW52aUx6ZitRZFhWUUEwS0tBNHN4UUgvY2FlcEE3?=
 =?utf-8?B?bXRabmV1ZmZSRloyY3ZZQm1xM1VtK01sZlpHR014MU9PTWNxYjMxYS9iMTFE?=
 =?utf-8?B?QnVLMzMzVmJNRTgvZXNDUW04Y2Rtc01rSjBOcTd1RGR0c1U3ZzRWY1NRL3Qv?=
 =?utf-8?B?N0hnc2FQQ1U3VDdTdm5sWlRacHlpL2paRnNFWmt6QTNKTzVJc0xPVkUvZVp0?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce4678a-bc2a-4127-9974-08dc4dda89c5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 21:20:19.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJsTsotowcRExdZ9wzR55+gN0W4rV/C9XJZHv4fb9jJlCzVR9O4hF/xGQCRkrmmlJeKsIHGYe1efB9hq1DuaWqkmIG0zEwmAi3cqriLI31A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6328
X-OriginatorOrg: intel.com

On 3/26/2024 1:51 PM, Shuah Khan wrote:
> 
> show that there are bo backwards compatibility issues
In older kernels lacking AMX support [1], arch_prctl() returns EINVAL. 
With AMX support, the kernel will properly set 'features'.

It is also worth noting that this simplification was previously 
acknowledged [2], albeit some time ago.

Thanks,
Chang

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=db8268df0983adc2bb1fb48c9e5f7bfbb5f617f3
[2] 
https://lore.kernel.org/lkml/de61ffdb-638a-ca84-31b5-55f6a8616597@linuxfoundation.org/



