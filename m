Return-Path: <linux-kselftest+bounces-6445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CFF880A7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 05:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6471F2268C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 04:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EA7125CE;
	Wed, 20 Mar 2024 04:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJUrhqpR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F63AF9FD;
	Wed, 20 Mar 2024 04:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710910705; cv=fail; b=TVKHuIE3UK8rdxQEIgkklD7KykhwBMRfvL+d571KJMTK5I8E1+MTaYz9BAvzFOQxRN38lLZHphyUf/B1uLTNENzRJczJHTUVciNzdswUzem/og7A6IrLAWa7579YbwNSEfDCgmY/43hIj/fKhKiCtw6nngb18hnag4XMkezyIyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710910705; c=relaxed/simple;
	bh=VkFPra/EPfYzwHs6BpLZmKKrsUtTRHnuYi7xnCbWtqs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eZHOrvlVbXMZ2LMZxayY63BQz04gYmsYcU9HkRdBKuEoEr5EsmnDC/2hAF7DX4CYDFqfTwb4J04rB4ZAVtfK+bxvl8JbDiaeutLMcAS9AiwbMocNh8tPzAxLOIvjOP2TcqWZi0e2V8BppNXo4bVmiowzFEP8jiKXX0s4zFVCa1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJUrhqpR; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710910704; x=1742446704;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VkFPra/EPfYzwHs6BpLZmKKrsUtTRHnuYi7xnCbWtqs=;
  b=eJUrhqpRrx+k9hz5XKDiSDDSf+Ema7AF4dVNLncvjOgg1cv32A7vEfVs
   6XdXGc0kliJBVAimK2GelBO573Mu6jdyTWI8B7L4/e86aKc1bZDV58n1o
   am18T2xMvqibx4MlbU64byVvld2YefGZ3N1wPsYt3sElUYUNQ/FpIs7y5
   CWPhYixuR95M71EUChJkhrEXepZFEjsE29dknNZkZ9xKsT6VXGcxOeDVi
   P8epd/QAVLa1+UqY18H4XwJBeV3mpyknpZZWd5dI0uDwvvs1lLBGafOB9
   Tj0t+l2t59eKjx66Ii7iINUfeoxQH5d1QyOKEUmzYtDKZ6T/RsB5+bIZD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="8763772"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="8763772"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 21:58:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="13929591"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 21:58:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 21:58:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 21:58:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 21:58:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjJySN0g2mm0czIcDSfKmrmgenLBoVWEC+nmv6Scj/2nnrlMDBBGW+vaCrif/GnLlaDhq/NtkL+J3g0M69u0KnJg7ladat++OpBPXv4lMt7tlxZC5xUMhwXNqjbhvD6J60QDU0SD7p1nBnCHEzX2rVCYWffO7TrWpafV7a+C32xLta+t3GFwj+wpG/Otao/Xh0fNdhxs5ew5z4PfSCpcR18NWjgfhAg9eOeDMQ1HN5N4A40VoIJgWs4V2drnpZPKoPwo2RqKyQ25lkKPDzTHAYwFQhV+jN3Wqp91hG+URm84Ba1I16nYPdiq5tD/ZBPmqucV50nhyyZL7S7+wgesWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RMmklGOVH8eLsXG92lMGp/RInap/xWaYTyC/m1uwhU=;
 b=an3gt/vnFEBRK+AOfkzLgA1Cqw5yR+kzhLhCx5WQlyeb7FZbc+ykKrP144ByBkb26mvkJtLTZsH9a7dWhOoKb2PScuGihAKKiabxe2T+urgXQSbwihYV3Pr4z1OvnNB3A/LoF9f0QNaO2NlkCeJv1E2/AMyZSQLvvZ/4KwrL9uyuweLyvjZlaL2D+RGGVzSO19+JR8v8O4W3B71SuB+kKnNG8tGo9g4g5+X/RDgBbXF4/IouEtN4bWuIKCqjTq3Wp264pWqLanNC8UwISTakPKlxLwE9Gxkop0yDpuHEPAgaVsteg2/AW1rduwYbEGWbLj1Q2RB9yLihLpCv7bIm9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7714.namprd11.prod.outlook.com (2603:10b6:a03:4fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 04:58:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.009; Wed, 20 Mar 2024
 04:58:19 +0000
Message-ID: <a3d11ae1-0ea2-44d1-953c-0e9296582865@intel.com>
Date: Tue, 19 Mar 2024 21:58:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] selftests/resctrl: Add ->init() callback into
 resctrl_val_param
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, <linux-kernel@vger.kernel.org>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
 <20240311135230.7007-9-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240311135230.7007-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:303:2a::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 619ad169-ed61-4c0b-0cfa-08dc489a5c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLasRCC2YCLwpqgJqO/lMQv5NlRzTgCmkQH1ZjrS+zJ/dR03AFVL2xgvnkP+3DPGP0vWmY5rpHtfF3cMg/4Y3mO1+uU2ibtEUJd7zRDD4UjsHx/vE6Ql5weAWpAj2fUHqqe2U1goIpk3pnZETb127buz17mPn5z1CKuf3cJ9KysoE4yqFwd9ukJ9Z0gTiKKWCgZyJZuKqqswFfjpswIbGG1zWNu8sSWfBSGSLFk78eulk4nuGbXYPsSlbKRE0izW0AWCqLMeHSXyzqPVdI0oEZZpoTbBOqwOoveIAXSV/MqGNwtzLqU83XbiY31F1DwicO6oHFvsiLcM8mgXaGU0C4heCV5R/zlkHDKWxp53V9Dhs8nMiCnxAcGpxc3WzWp8fOE8t4sf6p3H/+xu7Gtf1ACpwBjqZh3ko6KjgaNv+TOt8vlwf7Q8acT+nJJLxHnZBdOWI1bNcXPOCg5sXeGxnfEWvBVLSe/oCcy1P93rEpnWRWD81qfLDZ6/wBaij4RKUNz5JCYiLklq9QtYj6ZPJqnlDFn0kbl97wZRWWdvoBMDiwl4xjeAh1T6+qXLAdDMmf+GgLesX5HVz+CNVlVOXSCI/2Fafpu2aqoKSyfDyRittGStU4lz1vGYYe/sYEdLylCSbXWM0F9zdzZWZzcFn5fBMPAOSeGfGKN7nAb9LWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlFuV2lwdWFCeEZEZld3bDNOR0pZdDFoaDcrYm9KelY1TlNjN1pJTkpaUWZW?=
 =?utf-8?B?U0NnU0VlS3lxTFFDMWthaTlBZVdIaFpKM2UwelRBRno2TGN5b2Q3TVE4RU44?=
 =?utf-8?B?NjNxZldPNEdIaWRwWkJocWVqbElLQVU1eFZ2WnJLbG1lK05CZUZYamF0ZUxm?=
 =?utf-8?B?dU1TZVhJMEQ1VklQQm41OUhVV3lZUXRjdFlibC9yVnZ5UHY0OWR6bG5wZGcv?=
 =?utf-8?B?elVoUTlvb0VINGFpWTVrbnhYc1drTHhmR1dpMndwZ3RTNkFISG1ESzczais3?=
 =?utf-8?B?dGhsMHhpZ2JqczdkNjhzcDZZMStuNGpDMHFrZEU2cEdLUk5scVFqOE82cm9r?=
 =?utf-8?B?dWlsRTFjbkhaQ2RxUkFrRHhRSHhHb2JQdGNhamI1VEN4QUdHcHdrNVdjcnVq?=
 =?utf-8?B?Zlo0dkNwSFJ6RlBhQkhDV3Q1UjdWbEtEYVBVMVV6NWxwUndLdTlSS1p4cDZH?=
 =?utf-8?B?WG1hbFlBODlkN0ZRUjNic3FnU3dXVTRLUWdpcExxUE1SY2tHZ0htYTRkZEpE?=
 =?utf-8?B?VWpjY3ZnQ1Q0dTRvTm5lQmt3ZDRic1F1ZlA5ZXAzN3ZPbngraTl6ejdBREwz?=
 =?utf-8?B?VFNMZ2ZzRm4vajM2aGd6aGJQZjROWjI4cG5iVEM1eFpIS2NrWGRoajVmZGov?=
 =?utf-8?B?aVUxdnhyZUxCVjBXajM4K3hCNXoyWnR5aDhSVmFLdFA2Wk02Y1gvWHVyL2l5?=
 =?utf-8?B?enRLcEd6YmJ4bzV0Y3gwSFE0Mk9zOExrMmR5Rng4QjMybVhLdUVHNjJKVDhi?=
 =?utf-8?B?SVVlYWMvMlZxaEZKam5GUkZnY2NiR3J2OEcxa0NRc0h3SXB0M1VQNEtLTkZO?=
 =?utf-8?B?RVZwajVuUGd5WHdsVFFVakw2bDlySE92ejI3RmpyQkNRWjNadlVPbnE2NUNj?=
 =?utf-8?B?WWtFOVNibCsrNUhuQ3l0aVJESWFQeDVYbno4Nk1kVWNjMFhhUHN1eWdCTWZK?=
 =?utf-8?B?WExmK2pvNjI5OVJUMHZYK2NaUHQraCtYZk52dDUza3BiYU94ZFNyUkxBTW12?=
 =?utf-8?B?TFZRMk1DN1FFNHRFWGNraUNPQ1hBREYycDU2bHZyVStITjNjOVFqM1R5Y2hR?=
 =?utf-8?B?clFpOUtiZ2tSN29FcG94TFRmWkg2YXdVL1ZQNm5nWDJQSlliK2lrMS8xck12?=
 =?utf-8?B?djlUQ0tEU1oyQkdlVVhxWGF2MDFORjlUT0RQa0U0Z3JaZWxUajBOVGEvUVFO?=
 =?utf-8?B?MmRWem91QXJnczhoTGhNNHRIUndCaVZNUXRZWHorSE9UR0g3ZTlsUURGVVQz?=
 =?utf-8?B?ekVIN3RIeHAwUE5mOFZ2cXQ3QWIvSExPcHIzcDVoRDBhak1NcGxPeU9wUGxQ?=
 =?utf-8?B?OXh6MmVaOU9KUGNubDdOZkZvbEk4WlVJTyszc0xFK25obHh0Q3Qya1ZKRUFN?=
 =?utf-8?B?dllFWXJ0M1Y1QnN0WjkxbnRkR0tOZmQ1UG9YNENYRzVoY21tL0J5NGFiSENN?=
 =?utf-8?B?b2xSU3pOd0xVOUxNRll5SEhCYW5NcWFwSys0OUJGRFJEM0ZYK2JTSGtlTGVu?=
 =?utf-8?B?MHZMUlpqbkFVNk1rSU9PY1pmS081R3ZhaWdCaGM1OC9QYzIxbDBWOU9pS2FC?=
 =?utf-8?B?STFQUU56NitmUlNnalp6VjdOSzJhQVdHSGV2eWJIeHhKTE04TDJVdGowRU5O?=
 =?utf-8?B?L1FMUmREOTdUdXNMZzlVZ0FDU0lzeDZiWktkSndEUWIwRmtpUkRtcUwrcndQ?=
 =?utf-8?B?SUNPNVppMHdVMUk2SVVZTENjQ1ovekkyRGwzaTBLbDVxY1c0U0FZWlhRTDc4?=
 =?utf-8?B?STNCT3hWeVN4S0UyYS8yZWkrRndJcW1FVlNDS2dXZE9wNzl5UjJ0alNjU0pw?=
 =?utf-8?B?SytiMUJaZFNaeFYwWDBjd0ZZNEZkMldhZEJvK29HY3kvTkxBcVo1WWpBZnZw?=
 =?utf-8?B?VWFLeVZjU2J6MGxickNPRnpXVzlPVWl0RjlUK3BBV3QxRkxJN2JkZjVDUXNR?=
 =?utf-8?B?a3FDME1LM2JTZ1Z5YXJ6Y2ErVmVwdzdQWTFZS1JPNEpHS1dlSy94QVNFVjMr?=
 =?utf-8?B?MFg5MEZ6RzRTN2J5TzBSRVZhd1FzWnpHak1DT2xuUFVEdzN0Z1NDSUhHZjdz?=
 =?utf-8?B?VENnUFhjc0dMUEh2ZVgrbnZhbys2SHJXa0MxTHFJcnhIcHRlTXhvaEVYUEZU?=
 =?utf-8?B?Ykt1Z2llWXhnS2w4UU13RitpT0dkOEVJeG56RXE2ejA5NWZmbGloa1crVnRT?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 619ad169-ed61-4c0b-0cfa-08dc489a5c70
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 04:58:19.4088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XD6T9VvYqSbX4OGgsSUrjHA/nYPl/0zr6nU/CRNhtQ2+kvcWg+SIpyfcf5AetNcaFsTP8ibU4bdPYGt1ATh1b+oMFi43yxJd8DPrsh0yimM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7714
X-OriginatorOrg: intel.com

Hi Ilpo,

On 3/11/2024 6:52 AM, Ilpo Järvinen wrote:
> The struct resctrl_val_param is there to customize behavior inside
> resctrl_val() which is currently not used to full extent and there are
> number of strcmp()s for test name in resctrl_val done by resctrl_val().
> 
> Create ->init() hook into the struct resctrl_val_param to cleanly
> do per test initialization.
> 
> Remove also unused branches to setup paths and the related #defines.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/cmt_test.c    |  12 ++
>  tools/testing/selftests/resctrl/mba_test.c    |  24 +++-
>  tools/testing/selftests/resctrl/mbm_test.c    |  24 +++-
>  tools/testing/selftests/resctrl/resctrl.h     |   9 +-
>  tools/testing/selftests/resctrl/resctrl_val.c | 123 ++----------------
>  5 files changed, 75 insertions(+), 117 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index 241c0b129b58..e79eca9346f3 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -16,6 +16,17 @@
>  #define MAX_DIFF		2000000
>  #define MAX_DIFF_PERCENT	15
>  
> +#define CON_MON_LCC_OCCUP_PATH		\
> +	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
> +
> +static int set_cmt_path(const struct resctrl_val_param *param, int domain_id)
> +{
> +	sprintf(llc_occup_path,	CON_MON_LCC_OCCUP_PATH,	RESCTRL_PATH,

Strangely some tab characters sneaked in above.

> +		param->ctrlgrp, param->mongrp, domain_id);
> +
> +	return 0;
> +}
> +
>  static int cmt_setup(const struct resctrl_test *test,
>  		     const struct user_params *uparams,
>  		     struct resctrl_val_param *p)

...

> @@ -826,17 +729,11 @@ int resctrl_val(const struct resctrl_test *test,
>  	if (ret)
>  		goto out;
>  
> -	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
> -	    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
> -		ret = initialize_mem_bw_imc();
> +	if (param->init) {
> +		ret = param->init(param, domain_id);
>  		if (ret)
>  			goto out;
> -
> -		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
> -					  domain_id, resctrl_val);
> -	} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
> -		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
> -					    domain_id, resctrl_val);
> +	}
>  
>  	/* Parent waits for child to be ready. */
>  	close(pipefd[1]);

I am trying to make sense of what these tests are trying to do and
it is starting to look like the monitor groups (as they are used here)
are unnecessary.

Looking at resctrl_val()->write_bm_pid_to_resctrl() I see that the
control group is created with "bm_pid" written to its "tasks" file
and then a monitor group is created as child of the control group
with the same "bm_pid" written to its "tasks" file.
This looks unnecessary to me because when the original control
group is created on a system that supports monitoring then that
control group would automatically be a monitoring group also. In
the resctrl kernel document these different groups are termed
"CTRL_MON" and "MON" groups respectively.

For example, if user creates control group "c1":
# mkdir /sys/fs/resctrl/c1
Then, automatically it would also be a monitoring group with
its monitoring data available from
/sys/fs/resctrl/c1/mon_data/mon_L3_XX/*

PIDs written to /sys/fs/resctrl/c1/tasks will have allocations
assigned in /sys/fs/resctrl/c1/schemata and monitoring data
/sys/fd/resctrl/c1/mon_data/mon_L3_XX/* ... it is not necessary
to create a separate monitoring group to collect that 
monitoring data.

This seems to be the discrepancy between the MBA and MBM test ...
if I understand correctly they end up needing the same data but
the one uses the data from the CTRL_MON group while the other
creates a redundant child MON group to read the same data
that is available from the CTRL_MON group.

Reinette 





