Return-Path: <linux-kselftest+bounces-12823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C64819187FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 18:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9E0B249DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 16:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF35018FC63;
	Wed, 26 Jun 2024 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Okiawf0s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9C18F2F0;
	Wed, 26 Jun 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420952; cv=fail; b=W8tJZ1OXywVHbaMpsWEqLjVJTTR6kO/5Yytk1cxt1E8VnSOsfmwCLU7vZXjcKsW/7JfUP5pVMxZ5Ey/J55fXCQdsWL/glGTYowJF1q0M8ZfPWseQNV/U/zIs0Kxv5Kwa8z5GMVJsILtrcdrt8aCi2ZYiEbfQ2tNbpHmmYKpgy1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420952; c=relaxed/simple;
	bh=7sM02mcG3eENmIbvLi6ZWFJn3/F8spVaf+KjMhMQU7Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SLPpYFXcEoVEL+W7hQHd/dzJO7Ve/Hi97RrZqpl95mlk7mxjlGWJ/SmIAFa+dQSdOG37xvs9BAYKZFa43lf2MjbcOQHELJNChuYaJPfQSMy+BUflClyrbatsJ7EtTEwpw9XHXM1im/zoXQ1mnwCNwVeDO8SCmoDxHw63ZSujKvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Okiawf0s; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719420951; x=1750956951;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7sM02mcG3eENmIbvLi6ZWFJn3/F8spVaf+KjMhMQU7Y=;
  b=Okiawf0sSteZ5JydU9qtvQWiDSKqPnaJHm2lxm6tL5sqNSoXuYLjXof0
   uehjKgVhsIIiYeRTFmF+SPWNMCPzWP37v9gE89tHMK0Bjrw6zC+jlDdJA
   SPsdE/bA/4uGubtmEZQkOsHw3onuzHetZ5/Op6QX4aQWa16PPAOM5CLAI
   7RjvCoCEXOgdU+bfNrrnVYbXhb7DdII7Tukw0pjdbXuOIJU9cW/GS1v/C
   3qf01RtWjTD/OVtvyCeWpU3ep5Fv9qYGEbld/9NmjIOSybQCZCbHg+M52
   iuMsv7nBcKeBSKndmO9uk1TsRJb5dB4eoZjKWJ4N2w1MzRonw1l8iJ0eR
   w==;
X-CSE-ConnectionGUID: JqiXRxXoR86cwSjfvJo2PQ==
X-CSE-MsgGUID: hyZZKsMrQFGZ4eayUQ8okw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="33962079"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="33962079"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 09:55:26 -0700
X-CSE-ConnectionGUID: I5RXeB4wSl2VcJNy7Ir+ww==
X-CSE-MsgGUID: lhs7oDk9TiqbypnI5HXhyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="43959329"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 09:55:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 09:55:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 09:55:25 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 09:55:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlaCXGxAFC/Drv/t1Yb4XQdceGDsIutVtRfvNhqKhEPeF8UpuYwwJh3EWyGUdd32L76j4QG5njxZpzZsrZSzqdfOnNn3uXKUIle44IOb3GlVq98ccNlUC1VPfajstp7T2eyrS6e9H+nSRHOlojIqQbM69rhRbyO/3zH1Yk7TWFL/c3hSMwZymVF902+WIoUr7CZ1EbtCeJTm3zQzL60Lvb7KTN4v8BbprWOaJZVfew7MtV+l5Gzcr7txinke4D0iwjO4tiOlwRIuvMOVE5LLQpBTSDbzwlG7JHmwk2cHV3QGd6J3TEF7edbSqSb0b7ji/NO3WUWl8M9pDi4d4Wz4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccctpF3cDuo1sknS+4I8HVCdhHkMPHpujQ4am0gE9c0=;
 b=djk4mqBsh3s2A/FmXsr5dEMWYjciJCEHapeNwgsuGx3K+X+KhK20XRdBMDlNC85G+0JKMfVZ6ls3NvODFjrkNaupFmp/2RPzPXYLRa0NTX89ZqIIq91RlBPrHImsvhf/6lkBcT+LdG53ngQrUWHLWqclcHEf+aXL5HcsfbecmQMfoAFAuYVbcivo+NVyApzJCuZemowIcH9d7BiPrg5TqYAgOEXdYsVmLgGmmHa2Pnh9BLySTmvlByODmmhHsssLNGgB7q1qFatp2B4Dg21XdzK8Zjqrp3qnucCkLga1qomWAeInJVhPl5CdiBx9YmzLMwCqW0PLVLUB+x0PUF9HbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB7128.namprd11.prod.outlook.com (2603:10b6:303:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 16:55:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 16:55:19 +0000
Message-ID: <4be0449a-1337-4fc6-8ed6-fec10cc74bd6@intel.com>
Date: Wed, 26 Jun 2024 09:55:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/resctrl: Fix non-contiguous CBM for AMD
To: <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>, <fenghua.yu@intel.com>, "Babu
 Moger" <babu.moger@amd.com>
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
 <96d276c11e69cfb1e29d50a12c8043555c06b404.1718144237.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <96d276c11e69cfb1e29d50a12c8043555c06b404.1718144237.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 9568ac6e-d944-4a84-7a67-08dc9600c29d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjNVUTN0OC9oTlNQdWdkZGhhbGZ6MElsL1IycWF4NXZYTHNmcE9uQVgvN0Zu?=
 =?utf-8?B?N3pHR29JWStXdWNDdVVYOUVvUGMvWjlsY09RSzAwTTJSSjFyMVZFRWpwVUlR?=
 =?utf-8?B?cERLZ0ZrNnI4aStxNXNRbE5MR3hOZkhseGxvSjZldDYvRE42NUNHRXdXRFM4?=
 =?utf-8?B?amQwUWdkMG41cnR2WEwvOVo5MWphV013Q0RYUDRkRnU5YUp4cmtCai9xMHRY?=
 =?utf-8?B?RURvNkJDYk13MVFvdnRJNHJSSXpJR0hPUE5VeXB6R3NNeGJERzUrWUJLQ01Y?=
 =?utf-8?B?NlMrUnZLOTFEcTZTSSthNTI0Wm1GM0tqRnJCcWZlZ1RoK1VyaTdFQ05yYUlO?=
 =?utf-8?B?Ty9UQ0t6RUMySGZzWDVnVlQzVlZxU29pbThBSkFCVzd6RVVOSHpDeXZNNmVP?=
 =?utf-8?B?MzFCaHNCMUluVDNrMEdtanFaelQyNWJxUjhIWmMyRCtRRmdxci9VSGpWamVG?=
 =?utf-8?B?ZFVlcUUwdzBYaCtXN0N5VlNLVlJhZnhXUzJRVVlmTFZaNFJuS3hYc2xBWi84?=
 =?utf-8?B?aWVTR1NuZ2FzdXFiL0kxdVN0clI1UVY0YmtZVEdkdE9rTlZOdXExRGx1cmg1?=
 =?utf-8?B?RThsME5nTmpRSXV2WTBNd0wzcHNwdmpmNzBnQWlnbVJKd2pSTEtuSGE0ZStU?=
 =?utf-8?B?a0tJZzZvVXN3bHdTd05CTmZKVmh5N2g5eWRlSkl6M2tXVW40cEVFZXVKN2RR?=
 =?utf-8?B?bGI0OEJzR2o0TCtpanUxbkhuek5kcW40UUV4YkdTd3piZTdpZDBCbDRGZm5n?=
 =?utf-8?B?eE16djRJZHhtWGsrcmFKSXdlMWxleHhpZGttTWkxR0ZzMERwMmJzdHZNQTVD?=
 =?utf-8?B?ZDRBeDlvYm1HTGpnSW1TOGYrNiswWmdDblcwWENOcjNqT3dmWThkYTVFeTdI?=
 =?utf-8?B?dnZ3WTNaM0doOXRxS250ejNvRm43M0p0ZmlxTnd5MW5Fb0t5a0I5QmdCVW1V?=
 =?utf-8?B?ZHBERHllbWNJZWxtSjJKY1kzbTl1cFlIbkx5NlZGZm8rM3RVUEt5Y1lwKzNl?=
 =?utf-8?B?QTVqK1pXOW5iNktZekZ1NWdJYUxlY1JwdTJpT296Q0tKc0hEVDJmZk8reUtt?=
 =?utf-8?B?OTFJRVMwNEIvWDJISjJiZk1tT0JKMzdGU2FrdFAwWks3Y2UydWptaVV4Qm9D?=
 =?utf-8?B?bVZ4U0M3enZvTnFWZ2hFUXFvOEhnNjZGeE1SZSs2am0yZUdpWCtHSVluSnl4?=
 =?utf-8?B?WWNKTHpRZnRLUThoa2p4Mkt1NDQwQzVZTVdydXZnRk9UOUFwUEhXK1lFaVo3?=
 =?utf-8?B?SFpiN2FUeTQ3RktpZWkzNTkrMmpNUXc4YnNXQ01ZK0ZoVVNkbXg2eHp4TFkr?=
 =?utf-8?B?ZVNPUGdaTTJaSW9YOGhOdzY4RjI2VzJOUitwSFFESG1Jem9JVDM2UENpZkpt?=
 =?utf-8?B?dnY1Y3lYQnNXWTBQb3R0NFJuRnhoRitCengzN2pxbHB4a2xLQ01QQXExcThr?=
 =?utf-8?B?b3dqRy9iUytLaXZkQUh3UGJ5NEZGVmRtRFNTdUtYcVZVVHhwUWVNay9XOTBq?=
 =?utf-8?B?eURCK08xWGpFTmQ2YmRRZFJCMzRleTg0OEx4WXlXZlFheDFzRWtBYWFxaEhM?=
 =?utf-8?B?Ym05SWg1N1ZNcVQ5STB2am5vMm1XNXp1VGxtUWdvT1kySUJOL2J1N0VSZ2NP?=
 =?utf-8?B?YTM5SDNDL1FKMmlKZjUxRzlUWWtYVGNzZEhZblhjc01qMDJvMmNrV2VEZTNJ?=
 =?utf-8?Q?LPnrWlEXTVH+VppcPdbc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0t5Z3podzdHZGZsRFRpdzZTdU5TbTFJN1E2ajg3M2dOV1dCaVd4V1lFcElz?=
 =?utf-8?B?SU5Oc3dtU2VEYzFJZTRBVlhNUzIvVDY4YWluTVI1T2p2VW9RWWFWc3REUWxu?=
 =?utf-8?B?RWdBRFpVYmRRQ3dMenQyOThmNmRUS3Vudks4YThueFUrWWhvVmgyVFNEOHdV?=
 =?utf-8?B?bmdmRGNxblpHcVVIb0JvZFZZeWtOUlVhdFRjNkxjbi9CQ1ZSN2RkK2NZQ0hW?=
 =?utf-8?B?VXM5QlJBWG1uTEpmTlRFQXcwTzVMcTc1Ry93czJjbWhzWjlRc01jY3VDUGpv?=
 =?utf-8?B?d050QytyVFJIZlIvRWttN3RPclE5WkwzNTFRNmpheU1JVHcrR0U4Zkw0U25x?=
 =?utf-8?B?QjdFb2hKajdFUU50VXJsMDNMeUs4a3JSTnNUc0ZTbTlRUThXclVpZWEzSlZt?=
 =?utf-8?B?Q0JjY2xMd21VRUJzYTJjMlhTZUF0cXJJMW5ZTGtHUFBHaEhOV283Yng2VzRH?=
 =?utf-8?B?RzZadmdNN3IvNVc4WTNUWlNSUnhETzVQUDBMTU5TTFo5QWVpOVJCR1ZSd2VL?=
 =?utf-8?B?bFNYcTdUMW8wY0lzUGQ2aVdXZmtVSmptNmZjcnQ1WDBFb1VpdlNNWVFhZ2wr?=
 =?utf-8?B?ZWpsYSs2b09kdTA4SWt1WHdKYnBjK21icDB6UklwdVI3VjI3MTRJWFdPMW4w?=
 =?utf-8?B?VDZUWlhtYUNCNUx6c2plMU5KdlRncVZPak81VytjbW5RN3B6Mkw5RDlmNXJv?=
 =?utf-8?B?MDI3SjVRNVVreFdFcU12VjV4b1ZkRDdZYlp4QmFBdTVXQSt2b2VvZXJmZ1Fx?=
 =?utf-8?B?WHV5ZXM3U3JSVEs4ZkIzK1ZnU1JCS1lGZTJZaDhTczRHNnF4bkpKUlVMWEt1?=
 =?utf-8?B?czlheExZTnJzdStjd1B6bDhqMnlEYktXdXFlVmJhMU5LMkZLR0p1TFRnM01H?=
 =?utf-8?B?TnpqcXVUaXRGTTBZYmR0TWx2NkduTk9pV0J2ZTZZZmpxSEVHWTR0V0N6VDR4?=
 =?utf-8?B?clpydTA2dFZpT2xVOHhvMXNNU1B0VmZ6RmVPbExHMTZoK3BnMFlRTFRlajlC?=
 =?utf-8?B?cWw2WFl2VlVnNFRnT1VoTGNzQ21IMlVBNVRrZktjMEUrY1VDWmZKNVY4bnFl?=
 =?utf-8?B?NFpMUkQvaVFVZUYzVytZZkdBOUkrcStmTGxCVXVzSitwbmRML1FONGlxS3Jw?=
 =?utf-8?B?WkRJVlFJRnpGV21tbEVneElGcjhrUjZWYktiVUlqU2orL3AvbWRpNVJ3TDl1?=
 =?utf-8?B?bEwwZkhxclBqVXlFM0pSd0NXYldmNW80ZkdmQVlQb2szVGhjZGRDa2lEZmxa?=
 =?utf-8?B?YnV2bnYxaTc2ZmFUN2IzSjBCWUlRVDUxK3lZMTFiNVRCZFV0aDl4WXZ5N3Ru?=
 =?utf-8?B?YlFleHdtM1dsbTRXcWUzZGJjOGdTY3RPRS9ucXFhNExZeEVsc0ZWSXNUb2Mx?=
 =?utf-8?B?ZTZSZEFzaVUvTDFjaDh3ZDdIcTUvTmZuKzh3YVo5bWtoTjIzaUszQjBwOXdw?=
 =?utf-8?B?UWExRm1BdzE3WHJXZ0puekl3K3pmNkZuenY0YTVOZXlGSnpFa1gxd0E4SlBo?=
 =?utf-8?B?RFh4THhPemo0NTdKbmRpM1Jhc1hyZEJ4dzFHOGM4MERmN3c0Y004ZHR3YVpJ?=
 =?utf-8?B?WUZraTBhU1dUNVN4RDhJRjZZcUdRN1hxSWFYbVY1WjZMYmxMMldQWjQ1YWxm?=
 =?utf-8?B?TG5aYjlRVytMVGlMN1ZUVE13a0ZnYnUzYXpuMjZiRjVvaEFLL3RxVVdTMVB5?=
 =?utf-8?B?Z0dNV25ZdFNBamhoNDRxRUxFcll0VEl4RTBQNGprVmkzbXg1T2xHOXp4Rkgr?=
 =?utf-8?B?ZHJkbVZsKzlDdUNTNmJaZThqWmluZWxwcXhKbjA3WWRSZWNRcTIycTZ0bjht?=
 =?utf-8?B?OXlSRDRXLy9qODV0ZzhBeEZQTXJNbC9pVy9Rb0tvRGdoK1haM0hNNDFCeDZO?=
 =?utf-8?B?Y3dTeGZsRnJOUDdyZXROcEtrVnNHN1ArRC9sS3QwZElGR3BSNHZsUnZEeW8x?=
 =?utf-8?B?eGkrVExtWDRNT0poYVA4am9VdkUzaFJnMmZ5YjhGN0U5bW1zK1R1RVBaZ1dQ?=
 =?utf-8?B?SkxZNlYxendNZlVINFhzTVNjQ2NXcVppQ0xvdlhZNy9iWEFydUczbXhERlhp?=
 =?utf-8?B?V3BIQzFZY2N3QzJKZVovTXVNU3oxdW5FR2pwVStoem52b29PSzJlUFA3ZlRr?=
 =?utf-8?B?RjcrblI5QlVWQ1dxZDUxaXR2TktkSFY0dlZOSjZwQVlwTnZhV0U1RUsza01l?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9568ac6e-d944-4a84-7a67-08dc9600c29d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 16:55:19.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xPlI+OLxdqz4XGG0OfDi8NehIxO5p7vUMgIRROvSvCr+RezXaGLZx5U7yAxONRdt2K5nDIdVjcUYHhKCNMTOccstQwfQDJ3ukVgrXlwE4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7128
X-OriginatorOrg: intel.com

Hi Shuah,

Could you please consider this fix for inclusion into kselftests?

Thank you very much.

Reinette

On 6/11/24 3:18 PM, Babu Moger wrote:
> The non-contiguous CBM test fails on AMD with:
> Starting L3_NONCONT_CAT test ...
> Mounting resctrl to "/sys/fs/resctrl"
> CPUID output doesn't match 'sparse_masks' file content!
> not ok 5 L3_NONCONT_CAT: test
> 
> AMD always supports non-contiguous CBM but does not report it via CPUID.
> 
> Fix the non-contiguous CBM test to use CPUID to discover non-contiguous
> CBM support only on Intel.
> 
> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> v3: Reworked changelong.
> 
> v2: Moved the non-contiguous CBM verification to a new function
>      arch_supports_noncont_cat.
> 
> v1: This was part of the series
>      https://lore.kernel.org/lkml/cover.1708637563.git.babu.moger@amd.com/
>      Sending this as a separate fix per review comments.
> ---
>   tools/testing/selftests/resctrl/cat_test.c | 32 +++++++++++++++-------
>   1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index d4dffc934bc3..742782438ca3 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -288,11 +288,30 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>   	return ret;
>   }
>   
> +static bool arch_supports_noncont_cat(const struct resctrl_test *test)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	/* AMD always supports non-contiguous CBM. */
> +	if (get_vendor() == ARCH_AMD)
> +		return true;
> +
> +	/* Intel support for non-contiguous CBM needs to be discovered. */
> +	if (!strcmp(test->resource, "L3"))
> +		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> +	else if (!strcmp(test->resource, "L2"))
> +		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> +	else
> +		return false;
> +
> +	return ((ecx >> 3) & 1);
> +}
> +
>   static int noncont_cat_run_test(const struct resctrl_test *test,
>   				const struct user_params *uparams)
>   {
>   	unsigned long full_cache_mask, cont_mask, noncont_mask;
> -	unsigned int eax, ebx, ecx, edx, sparse_masks;
> +	unsigned int sparse_masks;
>   	int bit_center, ret;
>   	char schemata[64];
>   
> @@ -301,15 +320,8 @@ static int noncont_cat_run_test(const struct resctrl_test *test,
>   	if (ret)
>   		return ret;
>   
> -	if (!strcmp(test->resource, "L3"))
> -		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> -	else if (!strcmp(test->resource, "L2"))
> -		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> -	else
> -		return -EINVAL;
> -
> -	if (sparse_masks != ((ecx >> 3) & 1)) {
> -		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
> +	if (arch_supports_noncont_cat(test) != sparse_masks) {
> +		ksft_print_msg("Hardware and kernel differ on non-contiguous CBM support!\n");
>   		return 1;
>   	}
>   

