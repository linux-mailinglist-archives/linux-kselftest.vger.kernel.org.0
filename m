Return-Path: <linux-kselftest+bounces-5393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC2E862080
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Feb 2024 00:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D83B2206D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 23:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3012014CAC3;
	Fri, 23 Feb 2024 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVYz+LCK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF0710A33;
	Fri, 23 Feb 2024 23:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708729879; cv=fail; b=gNE9P4ft63I8Jq1pGgL+gbkOIy/dGYJe8KWM5TlbZG7sxTzjilQacGY2vDwwoX2c1RpNKNuNlb3cTu2d0T+eOAeWevwjH8+Xy2cSibXR0PfM2kUY5hy7nro3t4QC2oB9GmXj6yDew+ZJlwrOZR0xg3sR6oPbhKMYBMDATDO4lN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708729879; c=relaxed/simple;
	bh=G6Qz8rieLupqlsiJPiRF+/EKoZ9kyczTJYOyMK8WWHQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ymk6rYtVRiu76790/aiI8KOxo6T+5bmuSQI/nLd5OBZxp/SN64OY7ElWZlQjPiNWIEhoc/MNTN37dvk+7NAx5Fhl0q6vUZPI3EWRqNpjDRzRKDoa0z2NloAbb3EtFIZeqcbSSUkVCBQGNzhLYp2VcZtxG8Qx8ZVNCxzRkFwDxls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVYz+LCK; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708729877; x=1740265877;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G6Qz8rieLupqlsiJPiRF+/EKoZ9kyczTJYOyMK8WWHQ=;
  b=CVYz+LCK72N1AiloAVb7J5+wS5+0u+Iu/GlIyz6kadhe1dUI2JXA3u1o
   jhyJ9z/Hc5MvD8OEDA3oMPdheeYgj+rHytKBOOcFHJpUUEO5FGgyRdxuV
   ko1UxdYhsXpBmZ6QG6d7g7O0MkBylspCH08QncXVQmpJLuqRYYwb6o/7T
   YC0yLj2lAlboPgLDchPQ4B4uqrxhdDEgfhGzSTytoCkIPlq0D88VpbGT5
   LxXGvTA6Y89S/ZyXP97Hu7izpFfqJWwTZZ6ye9D6Lzdu1FGq7LMFUMfIp
   n5ZIJoGhYtUaL5Cx3Lst9oj8YrDCy0ihHblN9Eg6p152khyYL5yRSxs8R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="2922666"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="2922666"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 15:11:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="5986505"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 15:11:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 15:11:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 15:11:15 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 15:11:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VptZfcz8Nw8zV+tXaGBwVJhoAn4DexM5KmBQOtLQ3NcIjP18SlRwZxPL1zwn0Hflw7SMUx/TqqaSs7OtPC/YBvIxO2gPiOe5Q6k3ayH9ROHrf4RRywmpDyEEHf2BXZT7tASQgdff1obYwW9r+P5BS/mk2zkCTDTeOupEIyp5/Lmc7nZ0J/RxCy8VWNM3lXcCOR9JNAkbRIjsso8UgYSyThbYHpcG82TcPbXc3X7dPi+knqS705crM1qXmxYxtFOguzPYVLk0PHVEcnNG2F0FB1nQlv529JYZh5RRaLwJt7pQYbLdb2X+i0pdCV62dG0fBpWQi+Q/SXHQDe8IICTwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tfbd7/4+I2ZQ0luReIj5C0yF37GAFgeQokrql/fWJKE=;
 b=bkW7j6cBKIrhJutEdXCw3HTqlkMbW6tXtc+a6gC9nvlhBfVkageejAgyiPzJguPzj52N37vcPufSNTnk9BVjgXq1ZgDtuSYKWLEXCgbw4qxgXEwyBVo/YoRk2lhkEpn9ystNbiw5CHU1XQ8Eug1JeGpxKbxjxcX2uTRktOWhvh/qhq4twvOXQufrClKki2lYqhRA9Z7PItKtckFSGg5mXV1u6MCFoy1BWI78CpZloOPj1somjhugmTMZKQ2vVaOXnbWV/SuwG5dTxflGqY/V8KMoSJgvolYW+B7XrgIytdkSjmthRpxIjRMVDe9hViBfRPrxSsSfPviIVogFckIm7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by DM3PR11MB8758.namprd11.prod.outlook.com (2603:10b6:0:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Fri, 23 Feb
 2024 23:11:11 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::5abc:23ba:d55b:2c2c]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::5abc:23ba:d55b:2c2c%3]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 23:11:11 +0000
Message-ID: <ede77e93-1bb3-4bd1-9c05-919ad512c2e1@intel.com>
Date: Fri, 23 Feb 2024 15:11:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] selftests/resctrl: Add non-contiguous CBMs in
 Intel CAT selftest
Content-Language: en-US
To: Shuah Khan <skhan@linuxfoundation.org>, Maciej Wieczor-Retman
	<maciej.wieczor-retman@intel.com>, <shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1708072203.git.maciej.wieczor-retman@intel.com>
 <f8886683-4f24-47ce-a0c6-ef28466bfec9@intel.com>
 <685828ed-06d2-4a2c-9911-05145e55ea1a@linuxfoundation.org>
 <48dab897-162d-4075-baa9-f5391a23d31d@intel.com>
 <a8f1f104-c5c1-400c-873e-99b01cde1d88@linuxfoundation.org>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <a8f1f104-c5c1-400c-873e-99b01cde1d88@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0005.namprd16.prod.outlook.com (2603:10b6:907::18)
 To SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|DM3PR11MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f696903-0827-4ff9-fc82-08dc34c4b9ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LSG03lHWfKPsoh7XSmJQdPulrGd9ay4x7yAegkBrqsllk+djkkfFZTnDF33AH+j3n72j+g/8FlwRdAc6RP8HrjH/qFaPHkwkLC73/f8mMFQubkxgxMNsmeIkQwZ6Q9Z1mZsGOE5c0WJarBHpVssGzMdrIB/k7AMXWCYJ5V7oYONuNf8A4fFkaHOZ8VG4P6cERue3R0ozsl9FpCF91ZDzamQNvpWnDpmObeYiWGNibCE4W7mK+0oWS9fTEPlMZDFAX7DjPWNXTYMWbf6gVnbdgIb2J2UfoxKXfwxGKWoaWo+64hzNmsv7f76xCOgRx8o0XNAqIAkMpgcbWHuujgyWX1FM6TVZ3hUtKp0WBD3XJmpx6gvemerZx3E2BI4zLrqTPifcWS62gyAXwwvqH5uucIoH7cxCu43KTXM07rxXfwzPtxlKt56SSr0dtX0I0UTayFRt64ouriLj28Z/pSO4RWS3YAVaQ2oXYq0bugHdXvQb3dDsXJ1tGpfSbhKUaKf0SIJA9/u6oGBo1zS9TbHlcpdk+QilO43A14wZQRQ0Acw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmFmRURqMWJac1NxbG9sVlNpZkpTbHN1dlpTZ2QwNU9MMk5rd2I3UlV5V3Iz?=
 =?utf-8?B?bnFyZzZQUm90Ry9CWjJqSHpYVmJmVEtaR2lsTVNJK01MRmNLSVpFODk4NWtx?=
 =?utf-8?B?OEJWTE45ZmxEUnpKdHZWSWluZTZ3c3E1bzNDb00zR282bHBYTEVUOVJPMmRI?=
 =?utf-8?B?TXRxelM1Ni9YZXFNaGZhVUZ1RG5WcUZDVjJoMnJFM0t1Nk9aWEJVcSswSGtz?=
 =?utf-8?B?YlFyVEtVa2o1T2VzY05pek5ZZXlwbUlvcE1ObDJFMmVIU2ZMMTNXWk1tOVlP?=
 =?utf-8?B?eXdleVlma0dkWU1mTXRaV2hXMk5BZ1dCeHFxNWtWZWNsM2I0ZWduUUVzY1ZU?=
 =?utf-8?B?ODM1cUZMaEo1KytqQVFVdDNWbmpkaE9BZ3RVL0FLWUtTL213YTRiQ0t4UUNz?=
 =?utf-8?B?OU1nR3FEUkxZcDFUaGYwT1ZUSU91WTJTakZlcW9NTWZVTVdLcHlnYTN5ampY?=
 =?utf-8?B?ZHJRWFdHZUxyc1cyRWR3ZytZWTVYT0NWZk12aDJvU1NRNUtmbGNRMy8wWkVW?=
 =?utf-8?B?YUo3WHNjckxDWDQ2RWtBVU5ucUViZzlnYWVMcktTN0FUNnI5Z3hTMTVoc3hB?=
 =?utf-8?B?TnVqL2d0SDdqTDIvUVgvRlpmYStqNUJxbTg1b2Q2TGJ4bzNjMDkybUZGWE1J?=
 =?utf-8?B?c3J6UWxHNnFIY2paTVlPMUs4MGlZMDJxTGpEajdDWDYxdmlyeVQwVWdQNTYx?=
 =?utf-8?B?cjQ0Tm56K01BYmZqZTU2ZWRmQ09hcml5UVRweHc5R0UzaGg0dzRxTHhVcmRV?=
 =?utf-8?B?cTFYZHMvd0ROQnZQdUJiU3lYZjRKL00rV2t4OGMyMWYvOWsvWTRQTGVzdzBR?=
 =?utf-8?B?anJMWTduMldRMjFHTnFsT3NDV21XZzdobnlmV2pFcFhFTk9WbVRzQ0xmK2Fw?=
 =?utf-8?B?eHdmVVlHTFpWV2d3YzdvbEY0Z09RVVI4dTRFUk9SdTNJNml6WFVFOVNhcnBF?=
 =?utf-8?B?NFI2WVRqM1RSaUhhWmJlODFjUGw0N1BUejFWUStvaUUxRzQzRUhQS2FIa0Ir?=
 =?utf-8?B?ZHIzQTRzZGttdmNoWjlRVmZOS3k2Q1hDSHEzZUpUbU1IVzNRNFRXZDZ2alI3?=
 =?utf-8?B?cE1KMXVRVVBCbFd3SzhWbXFhRnJTdVl4KzFwTXdVeGRuVkR2OWtMRWRBa1o2?=
 =?utf-8?B?SlhaNi9kR01hUXpGQi9kb2E4aWRMNnZMQ2hvc1IyYjZhNzF5TExvaE1ITVY0?=
 =?utf-8?B?TWFJUHV1RzBseUVJYytGWElsM0JhMXV6dVZmTXU2c085dSt6ZjhDekdiOVJs?=
 =?utf-8?B?WHFvNGhnTTB4cFMyZU8vZTIycWs4c2s5L1lGNW5yRnFnYUFpTzNEblJHWU9n?=
 =?utf-8?B?M01NWlgxbWJtWHl3ZTU3MWlLU040VlJaVnY3bGcvNXoxQnVlcXgyK1ZHWURQ?=
 =?utf-8?B?Q3JWQmRueFlpTjVIZFg3b0VGNlI3ZGRPMHVZbmtGWVdwUG54N1hLM05MUUN6?=
 =?utf-8?B?VzlwM3pSUGFYSmkyRnV1eEtuWElHayt0RmZnTWdUTkMvaTVjcTJaTTZVaUZp?=
 =?utf-8?B?eHhveUtIUmZKclVzTkNFWjlPV3cvVnUwOEN0bEF4aUdHNWNwMjF6eW1wemZ1?=
 =?utf-8?B?QWhsVDdzcGpNMXJBY25TNlozRHliZ2VYaWtYUEJwRFBGS3FTZGVHNVlIMTdq?=
 =?utf-8?B?U21XWFVreGVBU0hzaEZnMHB6NVgyNmdMLzh3UzFxMTRnc2FISW5ZOHd2SFBq?=
 =?utf-8?B?eDdSNHpyM3V5bGJxTGdsSmFHWnM4ZU93Y05NYXRvTFFQYlE3ZThxZFdPWjZo?=
 =?utf-8?B?Z1FNM2FEL1ZmeWlpU1JNSzdzVHhLNlRzbU1rYjdUanFzallKaTc5TVpMempX?=
 =?utf-8?B?OUJuaW9uSVUxOVFlTkg5OWp3bEZNa2k4S0hVRkRlUTJ5MDF5MTUvQUYwOVNE?=
 =?utf-8?B?WXdJbzZlZ1huVHZKRHF2SkRsQUxzMnUyMVJDVXJkbnlyNnVhdWVwRGVlR1hW?=
 =?utf-8?B?TzNwR2V6ckRPWUg4Vk9raWZVVTdmalFObFlpV0VUUFN0VFk0S3g4M3R3U3hR?=
 =?utf-8?B?a011N0d0Q3VSK2tUSU5PeDUyQVQrWnBLd3JuczlwTUxjWWtHaUkyWFN6eEh4?=
 =?utf-8?B?TjdscUNaZDkzcVBNVzVjTlQvNERHUVRqN2NsQzNUOWxZNEFoYnoyN2lQSmZt?=
 =?utf-8?B?R2pLVHhqZXUzbjY2WlFsU0RFamxXK2VWRmh2YzBCbzJ4ZXRHc2RZZkVMYU5S?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f696903-0827-4ff9-fc82-08dc34c4b9ea
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 23:11:11.8321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ym2mUxHRTTYcXBJ3d95mzJ7zLydph209hwnFEY27XUh90UPbiicJf4Wq/6jwmLDV41vlf9OccWQ3Ixz/bSZfBEc90UgholJzR4f2nLluHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8758
X-OriginatorOrg: intel.com

Hi Shuah,

On 2/23/2024 2:37 PM, Shuah Khan wrote:
> Okay ran a quick test. Why does this test leave "/sys/fs/resctrl"
> mounted when it exits. Can we fix this to unmount before the test
> exits?

This is unexpected. The test should unmount resctrl when done and I am
not able to reproduce what you are seeing. I tried with resctrl mounted
as well as unmounted before the test run. Could you please send the output
of your test run to hopefully get some hints about what is going on?

Please do note that resctrl does create the mountpoint upon initialization
so you should always, for example, see /sys/fs/resctrl, but it should
be unmounted and empty after a test run.

Below is what I am seeing when I try latest from kselftest next and mount
resctrl before the test. I see same state after test if I do not mount
resctrl before the test run.

../dev/linux$ mount | grep resctrl #not mounted
../dev/linux$ ls /sys/fs/resctrl/  #empty
../dev/linux$ sudo mount -t resctrl resctrl /sys/fs/resctrl/
../dev/linux$ ls /sys/fs/resctrl/  #has contents after mount
cpus  cpus_list  info  mode  mon_data  mon_groups  schemata  size  tasks
../dev/linux$ mount | grep resctrl #shows as mounted 
resctrl on /sys/fs/resctrl type resctrl (rw,relatime)
../dev/linux$ git show -s --pretty='format:%h (\"%s\")'
ae638551ab64 (\"selftests/resctrl: Add non-contiguous CBMs CAT test\")
../dev/linux$ make -C tools/testing/selftests/resctrl/
make: Entering directory '/home/reinette/dev/linux/tools/testing/selftests/resctrl'
gcc -g -Wall -O2 -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE -isystem /home/reinette/dev/linux/tools/testing/selftests/../../../usr/include     resctrl_tests.c cache.c cat_test.c cmt_test.c fill_buf.c mba_test.c mbm_test.c resctrlfs.c resctrl.h resctrl_val.c  -o /home/reinette/dev/linux/tools/testing/selftests/resctrl/resctrl_tests
make: Leaving directory '/home/reinette/dev/linux/tools/testing/selftests/resctrl'
../dev/linux$ sudo ./tools/testing/selftests/resctrl/resctrl_tests
[SNIP]
../dev/linux$ mount | grep resctrl #umounted after test run
../dev/linux$ ls /sys/fs/resctrl/  #empty
../dev/linux$ 

> 
> Please send a patch on top of linux-kselftest next.

Will do, as soon as I can figure out what is going on.

Reinette

