Return-Path: <linux-kselftest+bounces-3640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C49683E3A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 22:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC9CB20DD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 21:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C24C24219;
	Fri, 26 Jan 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJhEFLYk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D3224CC;
	Fri, 26 Jan 2024 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303309; cv=fail; b=AbdpAoAf8DXOPdIfVJmcGsWAKnGpWDPF2tK3OPAe/VdZ4B1yPMiQz4ssoNoduQLordpBQupMHE4oKziKVkUJbbtUnAN/7y4DK0HfjitMzPtngI7YXOfnJWMnvSyA1kHGAv15XT/yQlk64Gzkxc5O6PGLMpbcXlXID8+h8a/jRMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303309; c=relaxed/simple;
	bh=J9O6+va7a9BDNHgGLz4UIWZVVIN4LBXOTCXqS/Pb7Bk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h2FeaRPW9CNJTFXhzSdkeqa3CQEvlupDc+zmyQjqmyF7oEYW7j97YyC+dQ3DReXdxzJ2XZCkwYetaU2AhMtNKExtAMUsFE8WdXBZLBR7CBnlbduNM98hQnl1iT8xXwbE3k4Wz64D3AXhX1f/rQHGh9AgdPwqxoKm0uSEHMPni7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJhEFLYk; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706303307; x=1737839307;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J9O6+va7a9BDNHgGLz4UIWZVVIN4LBXOTCXqS/Pb7Bk=;
  b=YJhEFLYk2mMicPqRGxy/Ll7MCB4AgU3aoHxdnG2KaWSysr+NUQA6NEu+
   GpRdO74PdOEezn+G9U34A6SeBfhna3rrSvFRazC3+ixGhJefoIuToVb+6
   GTXWGIn2VftAmuZWcSOMjd2DiCNPTL+r2HneMHRz7y8YyosjEfgO9tbvQ
   rvAsAjcGqQGUwV0el4UfNdif027NyIhCeW0X4HVgxekSZnVd9HlMmMANK
   Rr9i5YmEqc1JQv8ms4I1e5OEoI8VBduf/dxBGpwmaRVEFNt4xsUwL9xQL
   bFoXAISwsu4Rc0J3+4OSpWoUDwRLperOdPQzkx/v3RrHkAW9VN07RVnum
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2445340"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2445340"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 13:08:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="787231566"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="787231566"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 13:08:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 13:08:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 13:08:25 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 13:08:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ci7Tv0+79gm48BOkRqlMQoJH4aaHJbigrTM/2b5KZUySJ9bmq5biUCaXdjd1XiJOthTQvGbqlV7keL9eRKVUMFeHtL6vI/2nORUPhAEesGuvsYLJG9xsGvSUWu4El1Nks2Gr2gVxublNuiyBv7t3+ebym+5td22k/PCSLfb0uExQf4V+JTq83RbpUyIDe5a6E93vawrDbsUmzanvg36D13uEy5npZNbT1YaWHs6TP9UbKo60xMgpOXTetsMCk2MApKxVzXp3e/QguoV1XwkCHchI9aAvf08XREjQROd6zH/b8opzg76YXHc9MatD91p04hOauYHPjeMk1N22gU/Rtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSX6MiBnUDipxJ2USzENk6aobtTr6SDsPcdaqTv4iD8=;
 b=mPxhUKXhcWekO8Usk5jo3iYwqM1iJ85eynL5IzHfVxub1OSB8Aun6tEgiv4UFV3cC/iX2gilEVdbWLCnFVdMax223W1cjbVnMfC+eQh/yT6kE1YCZLXh6yNoTyIavITz3Gw+HuECaMFkapcSfP5MWV1VdTcPtSSv3q4PkQtvmOEVV4Bm1ib+lh7+Nt0JjR/lL/QnT+O0wPQh1mM84a8okGYBJuCqBBrmMg3gkQW0xkIkbWiV8qD/7S+ukuEoC8tKl0Fho2KlWeW08WmxumNjM415mMSYAdMWNxJO8vl6kvBUUtr7CrcFuwQy0z0vMd1jJqyG/yyLFAy+l5dfSJU7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7570.namprd11.prod.outlook.com (2603:10b6:510:27a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Fri, 26 Jan
 2024 21:08:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 21:08:21 +0000
Message-ID: <e486cafe-86f7-47d5-9d11-eaca2007e5db@intel.com>
Date: Fri, 26 Jan 2024 13:08:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] selftests/resctrl: Add helpers for the
 non-contiguous test
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
 <85b1efc3ddd698b3ac81aa72a6dc987ee17da3e2.1706180726.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <85b1efc3ddd698b3ac81aa72a6dc987ee17da3e2.1706180726.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:303:8e::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e8b13c-1c87-49e1-a6e1-08dc1eb2ed16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hhwFPATR3jXsUuBQwU5h3tds8s37TLBRP68iKUGyVX2gEkjZT9WGL/cfW69wCxwWMe5K6aLV33DBo7KjUwy7bjqSMyXcoP+G3Ic9uN92sdVJ/WAc9AARS7G4LzmPJFZTpsGXu4rEMNjH9Dhktpd7au0uBMZLk2VwYlXlzzYZo0+OjDMq52XxbgndvKUFeC8COSvkkq6xbZWT3ztau4+S4xrwXsL1QApeFuaNq3vgt4mI7ia3sVLA/qnYvsPPIlNJrRJ/OIrJGC7fjzIMKkf6p0nc8WMJfiaHp1RibyU2hxT91dlOUIZuAtnTMSI2kf+GPnwtkRybqmctzNyH5a0w0ns/OiI5kcrlRnyTWhnJJYGgM1ab7yap7JDM46OEWek72vS21R2vwHTtT6i38F+4QCzoDb/51gAtPX8PGPp+dSl3si+5laFmX5DVSnUxAkBVqBa+OXmXdHKxoFkr4XVxC/CR4Sz9V8dCSt5JygqwWK6Drc3THufyFMfSya33VXu/TFPAa8asyL6/wyGcy6rv0h/QqLSLa2lpycnf3NIzrMYszKXda2ZHjc+ahdmYFClshC7pNbuY5Y64pwVY6SO++SYd6Zb6TUpEWFbJTjUJBSb+iPjt0qm6wCLrxhSkr9UrUdtoPtWuAg/x9bZhQHcfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(83380400001)(6512007)(66476007)(38100700002)(6486002)(26005)(2616005)(2906002)(5660300002)(4326008)(478600001)(316002)(44832011)(6506007)(8676002)(53546011)(8936002)(66946007)(66556008)(36756003)(31696002)(86362001)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1ZkT0RZS1JSbTVqREllWi93ejJ5WCtVcWFlV25mMklQbzBNK05MbmQvaVJL?=
 =?utf-8?B?TlRBYlF0dE1tTjVLcG5GemRwVzVRYlJCZFQ4ekgwTDM1MDJaa3RLZEV6VlV6?=
 =?utf-8?B?ZVRBN0NtK21LaE5qSXhkbkRZZklVWExjQWVmUVhQUnk5bkpNbmVFeUJzbHN1?=
 =?utf-8?B?Vk5sYS9rZngyZjlCeXdibzdaeU14enFRVk9OaXBCU21EVWZIVitGUEJLcUlL?=
 =?utf-8?B?TEtGQjM1OUt4K3hsaEdSMGYzcFMzQzdTdHQzcmVTdE5KLyszM2pYSVBlKzgr?=
 =?utf-8?B?VWtmRXVnNVhOVHVkMGVyYmdHbGJVUUhUTFVtSnNxWWsyT25odjg3Q1czS25n?=
 =?utf-8?B?ZTFyZjNGc0JUbFQ2N2ZuTFVnVlROaWQyYUl4YnpraXhQNm5tTXl4TldOa1hI?=
 =?utf-8?B?R0Z4cDBSTGtPQ2htS01xd1NIbDVFZUdPVVBBTSs2SXZmTlU0azd5dFIvNDY2?=
 =?utf-8?B?dFR3blBPM28wQllxbnFlaThzSEZPUkd4ZTZybUhLZmdPaGdPeE00YVhzQm52?=
 =?utf-8?B?cFYxMGRRbEVGbW5kN0daYlArWUF0VSszdUNjdmo5VkxGeVgraURUUzJyMVlD?=
 =?utf-8?B?N3ZWNDBjQjBjQmcxSHgvMVNiNFBtZmgwOWk1VzBPbXRkSnVXWEFzUDBOaXNB?=
 =?utf-8?B?am1CUXJaZXJDTVI2d1AwQzN0bExoZVBUa2Q1WndqL2ZLWW1yZ1RxQVdiMWhw?=
 =?utf-8?B?aytVOFZBcldLNEhKUGRkTGEzWW1lM2dyRHBEWmdJb3BFakh4UGRtcSt3SkRE?=
 =?utf-8?B?U01XZ2tDb09lWkdBMlBPeVpZdWtZdFM4QmhOQ0JSSHF4dEZTMVB1aUo0ZXRI?=
 =?utf-8?B?Y2VlcXJPS0JXaGFyanhjbnNJU1Jtbi9CcFc0TGhuM2hxSDRWMSswd1VWWlQ0?=
 =?utf-8?B?WE93MmY3a29FSlU3cDNTck1mMVBVbzJjWnRYWHdFNmhTMHFmb25taitUMkQ4?=
 =?utf-8?B?bG9RcFBEdG81cmNtV1J0R2lLOWxlbXVUbHFXUC9BUmFtUnhlSEFKOEtrVEE1?=
 =?utf-8?B?aHZLbk9uS21BMGwybXZDTW9OUmV1U0ovNk9ST3pLZnl2eDczRDVMdU11ZzBM?=
 =?utf-8?B?UjFldDh1VFFRcWF4N1dPTVVUdWRyQkdZRTdQUHZTZEZTeE1HZXlUR2NkN0tI?=
 =?utf-8?B?UzlRYno4MVNmVDk3cWFsa2pwQ1Q1cy85bDNhRE1rbFhxYUhzVklhajBYSjJp?=
 =?utf-8?B?SjlvTjVaZ2JFblAzVWtHeW4xOHlpUUxILzFITDdIaUZwN3ZPQTZBNHZURytG?=
 =?utf-8?B?RUppN2VFTnVQanNUeE5rcmtVNzFNZGpFTTQrcWFSTHhqSFlaMEEyWklLWXJV?=
 =?utf-8?B?OVk1enhuSldNSFRqMCtFdXcya21wZldUSjFVUVZ0QTJSU1g2cTNLd1luRlM0?=
 =?utf-8?B?OEl6TGVsZEM3bkt5VmtLQkFEMGQwQU1uL3pJODJLY29HYTI5UGcxR3NaTVpS?=
 =?utf-8?B?WEdGVjhqQTdFbGYrWUUySFNpNG5WRXhzTzd2NTVyL1hkMm9tRmFLOGtzRnMw?=
 =?utf-8?B?VER2T0w2MlEvdTNLNGVwaGs1UkxGQ09FVllRNG5UTjkwWWJRZng3Wng3WW1Q?=
 =?utf-8?B?a3FXdU9IUHE4N0NXSUpzNURtblRRaGF5M1NUTEFQNm5GMWROOUkrV1FNQWhT?=
 =?utf-8?B?QzVMN0UwNWh5VkQrdVZGeFdvcFA5dlpPNjhrVWFHTzNRanhGTUdjU1kvN0c1?=
 =?utf-8?B?dDdNUWtxS0NQWmVFZmhVdDE2UHVpSnZtRXNGNFp6bFRpd1ptL0Q0eW1xaHBW?=
 =?utf-8?B?aDBHNUE4clc1RnFWbHI3b3pzZlFJZlk3cXhsMXVxdFk2b3RldnBkeWM3cDJY?=
 =?utf-8?B?VlhPd1pKWEJXc1BRcmhtZWVYRTVXdGVyNXYvRGk1NENxRDl3MllkRlMyL3RZ?=
 =?utf-8?B?QjIvbnBwVnUrUklLWHNQb0VIcjRkaUFkMFhJUWNBb2tJdzdvUzVERFR0UzNC?=
 =?utf-8?B?dW9Sd1ZhR29MbXVDUTJ0OXFYaXdlSCtKWGVOK05HOWxFYXd1clVYc3dCeE91?=
 =?utf-8?B?OVZqTFIva1N4S1NpVHRzc3BOalcyaXBuUU9Xc0N6SFJsMFZGYW5BQ09aUnox?=
 =?utf-8?B?T2ppSWdJVUtqT09pczR0UGFDcHRXbVBJV2kxZS8weDR1a2pYMXdhbmlhSlFP?=
 =?utf-8?B?bnBTdDRMS20rWnU5M2lha1lmclFUYTR1Z2k1YWZheEdTd0RncXdJQ0xMSk5p?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e8b13c-1c87-49e1-a6e1-08dc1eb2ed16
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 21:08:21.2041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KH+HYRnqTDTfsoJtOye9RcY20kRjImCe1VPegUzEIghSdel5c1//Vq6tJJaKJML5+UJjJjMq7QyffofBF/u3K3veR6dCNzgTxOh2V1Qbve8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7570
X-OriginatorOrg: intel.com

Hi Maciej,

On 1/25/2024 3:10 AM, Maciej Wieczor-Retman wrote:
> The CAT non-contiguous selftests have to read the file responsible for
> reporting support of non-contiguous CBMs in kernel (resctrl). Then the
> test compares if that information matches what is reported by CPUID
> output.
> 
> Add a generic helper function to read an unsigned number from a file in
> /sys/fs/resctrl/info/<RESOURCE>/<FILE>.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v3:
> - Rewrite patch message.
> - Add documentation and rewrote the function. (Reinette)
> 
> Changelog v2:
> - Add this patch.
> 
>  tools/testing/selftests/resctrl/resctrl.h   |  1 +
>  tools/testing/selftests/resctrl/resctrlfs.c | 39 +++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index a1462029998e..5116ea082d03 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -162,6 +162,7 @@ unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
>  int get_full_cbm(const char *cache_type, unsigned long *mask);
>  int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
>  int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
> +int resource_info_unsigned_get(const char *resource, const char *filename, unsigned int *val);
>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>  int signal_handler_register(void);
>  void signal_handler_unregister(void);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 5750662cce57..cb5147c5f9a9 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -249,6 +249,45 @@ static int get_bit_mask(const char *filename, unsigned long *mask)
>  	return 0;
>  }
>  
> +/*

By not starting with /** the following will not be interpreted as kernel-doc
but the formatting does appear to follow the syntax, but not consistently so.
I think it would be more readable if the kernel-doc syntax is followed consistently.

> + * resource_info_unsigned_get - Read an unsigned value from a file in
> + * /sys/fs/resctrl/info/RESOURCE/FILENAME

"Read an unsigned value from /sys/fs/resctrl/info/RESOURCE/FILENAME"?

> + * @resource:	Resource name that matches directory names in

names? (plural)

> + *		/sys/fs/resctrl/info
> + * @filename:	Filename of a file located in a directory specified with the
> + *		'resource' variable.

I think this can be shortened to "File in /sys/fs/resctrl/info/@resource"

> + * @val:	Variable where the read value is saved on success.

"Contains read value on success."

(no need to refer to it as a variable/parameter, it is implied by syntax).

> + *
> + * Return: = 0 on success, < 0 on failure. On success the read value is saved into the 'val'
> + * variable.

"saved into the 'val' variable" -> "saved into @val" (since syntax indicates it is the parameter
there is no need to elaborate). 
Also please let lines in comments be of consistent length.

> + */


> +int resource_info_unsigned_get(const char *resource, const char *filename,
> +			       unsigned int *val)
> +{
> +	char reason[128], file_path[PATH_MAX];
> +	FILE *fp;
> +
> +	snprintf(file_path, sizeof(file_path), "%s/%s/%s", INFO_PATH, resource,
> +		 filename);
> +
> +	fp = fopen(file_path, "r");
> +	if (!fp) {
> +		snprintf(reason, sizeof(reason), "Error in opening %s file\n", filename);

(apart from other discussions). "file" in message seems redundant. It can just be "Error
opening %s". It may also be useful to print file_path instead of filename to be specific
of what the code tried to open.

> +		ksft_perror(reason);
> +		return -1;
> +	}
> +
> +	if (fscanf(fp, "%u", val) <= 0) {
> +		snprintf(reason, sizeof(reason), "Could not get %s's contents\n", filename);
> +		ksft_perror(reason);

filename -> file_path ?

> +		fclose(fp);
> +		return -1;
> +	}
> +
> +	fclose(fp);
> +	return 0;
> +}
> +


Reinette

