Return-Path: <linux-kselftest+bounces-12476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB087912ED0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 22:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E291C21CC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 20:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C48E16D4CE;
	Fri, 21 Jun 2024 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyFD1vc9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB0155329;
	Fri, 21 Jun 2024 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002964; cv=fail; b=PaxEQ3Qyw5wSnwZmUxyVx6C0WUJPM3NZ2UBxTgMZ8vA+FIKurkB61JatjqJwwhq3w/slovkMAErRT6P1iyRff0zwIl+Y96OpTTrh5riuTNS1EHr+wlbqSc81aqWOxY746A6KtK+D4rZEzx0w2AiFCFIZv9K/t4GNVMFPTbHcSE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002964; c=relaxed/simple;
	bh=zLhnTi+miCRjb+B0gqOOmoTCTl6e6qdr2Mqri0716lA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CihfzzmwDg5PZhE40aZbSjpe3jYiOtaoiBG3clZIF7kF/BNtXEy9Z9bcKNyxH5JomnVlIbYoup01InkoeiJwwfwu8HPEf/DsGMQpftLP5g60U27gCJ4x1ryzGxn4ZgUGSslnrr5pTNNKwJnudk4HLPjsna+vzMfRjOCYWX5sB0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyFD1vc9; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719002963; x=1750538963;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zLhnTi+miCRjb+B0gqOOmoTCTl6e6qdr2Mqri0716lA=;
  b=fyFD1vc9f39F07hTRr6uWXrlFs6wDarAq51dfkK+kxVTbPNVPg1/Be0c
   wa6/kVBMAbGnLkEWcVcDXAoP6Ccdj2aTordbCAXLMd85AalAXX3n2Po/4
   PsaP5vQuCCNSn5o8GD71IHZnQQ9GVBxluhukEIeQ4K1LJ8colBZ2Mycau
   Z4z1ZpGgTPfRxSwioS0l2bNDmdOBWXwPWHNovFTJjiw2UJs0gPdJF4BXw
   2ZzOcaBZThSa2iU0/ghSz0F01c/uwQABb1iIzOOKcJ+yWdDqPkU8J3YR/
   FqQTLK7V8IJkhUWXaNi4VzKMqp+3HB7u4hnawuJP6aDJfTPhLb9rB+fa2
   A==;
X-CSE-ConnectionGUID: uw4Q3/ppQfamJ7sRfhtBgw==
X-CSE-MsgGUID: H/ElfG+aQ8S197JZmjzh1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="33598513"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="33598513"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 13:49:22 -0700
X-CSE-ConnectionGUID: hDMEtAcPTTy9cnAx4LIDMg==
X-CSE-MsgGUID: rLgD1plxSe2iuTtIG9sOsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="47640978"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 13:49:22 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 13:49:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 13:49:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 13:49:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKxX2QXZzulXeTN/6sQegjFBLlFZifevhYPfK8StiyzkWBGzUZ1qSOczhBK6UEaVWOZPdGdWGiJPwdi7IxAfuzswfxvgLXj0qkUdEvk/wnhm09V1RHLlBalpkFmnwz3VARhISrQYqtyvGs9i/cwu4WO2NQzf5EanOJS/i4q/w62zYOf0Q9o/5VzzXWkBXXkccBBwpZJ5GKfEy9HPI3hLrIiS5IjXDEiQUyKA7KpgEp0RkIhAXXNDU3RJBhhdXF+dM4/REH6d/ZGLsl8jQ5qWjVFs77X70dacWW7d1JLdvBxfR24DzEF7YliMWSYFg2YYFoAJBu97tNf9+LixFuSD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8WkEXAvKaxQWVVXY6dZK7y/ssl+AWnvsLfzf9Qjq6g=;
 b=UsbQjf0XnxnVMwqX1o2Jo5L1FS66eAD+IDGFMwSxf9oPXLXmeDSClUDExRD++5oMSFxyZYywOhWgC77eKTFF0TJZ/PsGNSiuIwgLccmVJPvihwwxDH+TUbYywzOtsFv8miWjNxmbO++PBgCwPbow4MARWTlggKRg8ZvcyncpP0t4TI0S2cX5T2tdDt/c+XYrXCXCygcYWQ0ssZ8Klc3jT1PEv947nxsx2G8fowXXjSxpvRh4vOO+36tI1S6IE50KHzUg8PwR5FKj5uAQ23G0brHvXjhTSwiIFANAikpxUDU6NPtat1GbgcmWdsFaVsB94CnIQbH3GWu5aVLlmBeLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 20:49:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 20:49:17 +0000
Message-ID: <283eda50-9fa1-409b-bb3b-94fc4723e86e@intel.com>
Date: Fri, 21 Jun 2024 13:49:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/16] selftests/resctrl: resctrl_val() related
 cleanups & improvements
To: Shuah Khan <skhan@linuxfoundation.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, <linux-kselftest@vger.kernel.org>, "Shuah
 Khan" <shuah@kernel.org>, Babu Moger <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, <linux-kernel@vger.kernel.org>
References: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
 <e19e3512-6b6d-4c89-9924-d9f6899fff1e@linuxfoundation.org>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e19e3512-6b6d-4c89-9924-d9f6899fff1e@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:303:b6::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: e03ee3c5-f9e8-45d1-2fce-08dc92339e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U01wN2xWelk3ZTEzeEZyKzhtZ2krRFVobjRmVStteFQ2amlOcGxHWm1zaXBB?=
 =?utf-8?B?cTI5SEhNeGlwTXVzRWZYYnJoWm02aERxNThnK0FIOXdTL0JFajN0eFo5dmti?=
 =?utf-8?B?VjVKUW9zL0hsT2tDWXgxUEt3eEpRLy82Zy9FQ0JXLy9KYjdOdUlwQlQ3NUpM?=
 =?utf-8?B?MUhJcU84V01tRUZxcmd2TnREdUFmd1Zud0pFeG44UytJZVdHWTd6ZHdyU0dk?=
 =?utf-8?B?Z0IxNytkQUlQQWhnY28rQmFYSkExZjY4UjBkUFNXWnEwbmJsQXIrQ2xiOEpU?=
 =?utf-8?B?bVUwNXNjTFVpQ3ZyVm9vV3dmeS95MGRyU3VTL0tGRWIrZmo5M2V2T3FLV3ht?=
 =?utf-8?B?MGd6QzhwU0ZYdlh2K2c2Mi9yT1ZQN0pGcnRoT2Y5RG9VUXVBN1BZR0E5b05s?=
 =?utf-8?B?M3hxUmpLdlFGcGhMaXV0UVJteXpibldva0svbit6SjdnL2FKRUorN2x4WXdU?=
 =?utf-8?B?dzVybHFzclhSOHF2MWpVWFc5Y2UzUjQ4NExpYmszVjMzZEtzM3RucHhEVWU3?=
 =?utf-8?B?Ty9nWVJaenFWd0ZzcGVUcnFkSkVTTy9Od3pVOEovVTE5M3dHaXRTenBXR243?=
 =?utf-8?B?Nm04b2tGNU03M3ZJY2lMUjJEUFpNTVhYUk5nRG9mRkRPeFFYZUg1NC82RTE5?=
 =?utf-8?B?cUR0SVlmSlVmV0c2ZnI4REQ0ckVyY3ZZWDArSHd4M1F5RzhHY01zV3V1SEU5?=
 =?utf-8?B?dCs2ZExaUjNyeEcvZXBjckFlZHB6NFdGT2Y5c3pZMkplSDczanFERnhvNFVz?=
 =?utf-8?B?aVRDSWJRVDBVTXlTS01maVl0WmpMSW9YTndqcmprSVNaZy9IRXZmQk9nQ3hN?=
 =?utf-8?B?TituQ1c4M0ZiL09UZnRzRlJGRW1VMVREcC8rVU1SNEVDQ2ZSQWYwVVRiempt?=
 =?utf-8?B?MlFHM1VFSTlzbVg1SHRxcmphc0Faa090Lzl0aEE2QldtTUpiM0d6cDBZa2FM?=
 =?utf-8?B?dUxVUmNRRTlUNDdUNVhJRU0rU3ROT3FjdHpJUXlrcjZOVjVXSno0QlNma1hY?=
 =?utf-8?B?OHRzaE5wdmlZRjJBTmJxNDgyZlFqZTc5ZzJQbC9sRE5DUnpnMlNTUEdkSmky?=
 =?utf-8?B?T05vRHJPZjdMakdvUU5ETW9MYXV2NE0rUDU5a1dvK0liRWpENkI5Z1dWZVBL?=
 =?utf-8?B?RTdPSmF2SjRoMTVoVHNPODMwaHVaL3JNLzZWQWhZYUlXb0lRUkErY2tNc0x1?=
 =?utf-8?B?eXVsZkpVZ0UwdWhVS0czdndTNDNYODczRXdWY2plZDZsOWJOTUU2eXlmTVZK?=
 =?utf-8?B?QWdyYlV5RWV2NlJLcEwzd3A5Vjl5d0dFZHltSkdDL2ZQcktyRjZKdlhLUjhj?=
 =?utf-8?B?MlhSMm5CWWVLdm1oSUhnSGRqZ1pWc0gzQVFEdXljMlV5WERBUjVzUk05ZmFH?=
 =?utf-8?B?NDc4WmtqRGR6aXl4N3k0UmRQcVMxZ2ljakFUUlJ6WHBCWFZlYW00bXhwVzc0?=
 =?utf-8?B?dG1FbHNZbmk3dGxwT3hJQkJIRDZ2d2V2TXZTbS95ZkJSV05VVTlBYTdyWlZW?=
 =?utf-8?B?d2VJQVloZFBXcE5YWVNLT3ZVK3kxVmdRMUh0V0g4YndZcHRtNWVMWElzc2Zq?=
 =?utf-8?B?cjhWY2lkTkVtTzNHRXFteEJnUENpbllkdXV0R2VOUTlZOUVUOC9ZQytNMGpN?=
 =?utf-8?B?c3k4Qnp2aHBPR0M4ODBHYVFFOGh4bTlXak52UDYrR0RXdGRiOG1jc01jUlNK?=
 =?utf-8?B?dHBGZDZScGp0OXI0U1J0T0hxVXNYSm0xNStmcExvSFI3b2dNL3dzTTFIRlg4?=
 =?utf-8?Q?ZI9Vll7VJH5Efm2Zu1QGM2TFuEHQJEbzYP+Q9nm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmlVek1SVStkb1NiSlFCclZ2c2lEL2hQU2xkK0tGM25ud24xSVhVeStIVFR3?=
 =?utf-8?B?N3FRQURPSC8vSm9HZzMzV3hSYjA5ODdUVUt0T0grOUpxd2c5NmttanRTV3B0?=
 =?utf-8?B?L3NzemNYcDY3TkEvdGxnNnRTNEhJa25GYzFQVUlkUjhuT3A5TkdpMGhjMEp4?=
 =?utf-8?B?MnFVS1o2QWI1bThQU04zZEYwNWtyWHowSEdLREt4VkRkWTJjZGJ6bFduQVR2?=
 =?utf-8?B?ei8yTXBGYnJjdHl1R09YNGpDRmphN0xkeU5iOEpwdkR2c2tpOWtQYkhad3Vi?=
 =?utf-8?B?d3lISFJ6OVZmdmNseG1NaDRXWUNvbFRoZC9KSk1DM2UzcFhzTlVlY1dVSWxE?=
 =?utf-8?B?ZDE2L2lDcERmY2JQMUlqKzlMUURhcCtFb1lram1Pa1ZtVk1jNnVVd1dzOFZv?=
 =?utf-8?B?UTRnTzlsMlZJMnFRZXppRWVGWGdaaVpVdFdLUktTWVYrVVZIbmZOelB6MTlY?=
 =?utf-8?B?b1FjNk42SFo3aEZBYTBDZk8vdGJrTlZBMUgxOFNiNVF6SFRnaUU1UElHUklT?=
 =?utf-8?B?Sk5zd1g5dGhhNkdOVUd3cFVYejRCNUJSZlFNMkFxT1JqUU5iUmgvRVZlUWFz?=
 =?utf-8?B?cmxqTDBtbDlhQ280U3Z2RHdRdVJwNU02L0w5QkZCVTFidUx0WHp2aXpEYlk2?=
 =?utf-8?B?ZSthakVXbkp1ZnMzeTR5QWE4WnZoUXloUm5OeW9CZUczUTRPaWVUdU9JaFVP?=
 =?utf-8?B?a2J6dURUaWg5UllZUElHYmY1YmozU09uTGNNYUFuSjZNQ1dFdkF4eEtBdVEv?=
 =?utf-8?B?RVVEMnIwakVvT1BUWGo3K1pQWm9jOERNbngwbXl5QitxdjdERUpzSFBjOFh5?=
 =?utf-8?B?UU1GajMvUHgyeVBYR2F5WXJIamgycGtTMlQxWTRzYmxNeWVtaVNLbWltUy81?=
 =?utf-8?B?ZGVJdi9vUm14KzdlOUFxSncrbFQxVEtsZEcxR2sraGtGSVAwVW01R1UxRktI?=
 =?utf-8?B?WUVUOW5vc09aaHZNK1BrOUgzUlBYeEY2L3FCZVBNYWVaTm5ERTNiWHVVK1Fw?=
 =?utf-8?B?cHo4MjM0d3IwL2JkUEQ4bmEwaHF1ZTMrR21ySmZZMy9CQXBwZkdoSXB0ckEx?=
 =?utf-8?B?SWtwMlliZmxRZDV6Y1JIQmc1K3pyWjkvckFTaU84Z0Q4blZqNGlSTTExcWFK?=
 =?utf-8?B?eVBTNFkraHd0WVFMOHlpNkg1ZnlzU01Xdm9GcjI2eTk2ZmFGMHllaUV5MkpZ?=
 =?utf-8?B?bEQ3Ynl6aHBZeWVtKy9uM3o0V1N5RFVWSFJuamdISjdIMURyUVh5ME92dThN?=
 =?utf-8?B?ZFNOL1ZoYnByUjhuMjBEQ1ZwQVBlaHhxQ1RDaXV4M2tRK2IzcGFlRG02VUIw?=
 =?utf-8?B?VTJKYmVibzFCUy91YXJzeUlEeU5iZVMycTZaQXdIcjZ1dk1mRDRINGNKazRF?=
 =?utf-8?B?V0lhUEV0a2Yydm5BMFlNOTFjT0FOdXp0T1pDV3VnSVZNdlU0bGIwMFcxcXNP?=
 =?utf-8?B?S2FJQmZhTHEzTEZyMDkweE9HMWxIMXY2dkNTWjNxc0FmaXJlWkpoNTEwOHJZ?=
 =?utf-8?B?T2NNWjlleU52N0x6V090WFp4dDFpNEZYUjhjeEZML0I2R2FobWhLL1BMeitx?=
 =?utf-8?B?aS81WittZW1EV2JvNnAzbDkrSjl3WThIWmRIdXJJMFlNenVjWDJ1eENBb3Ja?=
 =?utf-8?B?NG8vL0ZPd0JHT1FSWDluUGlwTGpyMXNLMzVScXNBdjhORFBZWXMwQ2J0U2Q2?=
 =?utf-8?B?YnA2cU9rRUdkZ3pGekdWaWp4L1hiL1U0cjJ2cGo2aUpPMGhnRHdaTVhmaXJj?=
 =?utf-8?B?MEowZWNrKzlHcWFjdDZTd0lUbjkwZ2RxWHZpYzNmamNzODE3bFlVdkVTTEZm?=
 =?utf-8?B?aWVPN3NUUWJFVnFmSUxRM0NqRjVhZHZPS05RdkhkU0t6eXZ4VHV0QkM0eXVV?=
 =?utf-8?B?ZXpIWk9iSTExUmJ4NkdBcVVqQ1JvTUFTUTdqQ1dUTFN6cFE4aVl3OW5DVG8z?=
 =?utf-8?B?eXRkS0VOb2lsb0lWV3Vvc0lWQ0c2RkJxMEN3NStCcTlUUVlWRjQ1em1hMDB5?=
 =?utf-8?B?NndMbTlVbEplajR2UjNJeW5MMFo0OFRxWmc3NSt2bVMrWDdWelUvNGFDL2pH?=
 =?utf-8?B?YkhGSXhkZStsOEFmY2pxWnh4WWtlSUpScTdtMVNZczNVTW1IRk55bmF2OVFV?=
 =?utf-8?B?QmZHVzBtUUNsV3hpaU1hME8vZkpBVjR0U3dqNk1rc29qTjFWdDR5N1dTZW55?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e03ee3c5-f9e8-45d1-2fce-08dc92339e2e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 20:49:17.6378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGyFkZdKokHo7DdQtxAiEV1PUyx00LNTvgR6qCiKUPFGfLuGRPgFc3fL627ICkspXThVOt7agSEaUqwpCW+4Utkp1kGRpo/GdDIqOn0kjDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6206
X-OriginatorOrg: intel.com



On 6/18/24 4:44 PM, Shuah Khan wrote:
> On 6/10/24 09:14, Ilpo Järvinen wrote:
>> Hi all,
>>
>> This series does a number of cleanups into resctrl_val() and
>> generalizes it by removing test name specific handling from the
>> function.
>>
>> v7:
>> - Truly use "bound to", not bounded to.
>> - Fix separator to use 3 dashes
>>
> 
> Applied the series to linux-kselftest next for Linux 6.11-rc1.
> 

Thank you very much Shuah.

Reinette

