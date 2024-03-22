Return-Path: <linux-kselftest+bounces-6507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2EA88720F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 18:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6C21F24405
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 17:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0FA5FBBB;
	Fri, 22 Mar 2024 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Prp9SOxt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C65FBAD;
	Fri, 22 Mar 2024 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129467; cv=fail; b=WiJu7T+eClWNygRCZOngZfC+boO0xSlXPnN0h+++DZ0ctyPY3JGZOFXlmKX20cwrydOggJpk93c8fgLI9s4SNn33FcQMlewOi1ii+387UB6UkkeRS+bwS8z001XE6wF5zXkHF1MWVDbeFpRAzWgCIY9GwfoH70N1B2O0xglJkiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129467; c=relaxed/simple;
	bh=WWY755VbsXiAd4BTlYNGfcIC1cP9NKWszwcXmq+s6Ck=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ya6+oReCh6jmYvCAnkFZ10D14qMi+XMEofjXK7krxl8hIrQUht9tCBV0GD5GA28pXgcB4NAkpJaBrajZSs5mkev3cVgZS6gsSwslfLuBOCko+LUt1rgNNiVWvSFSVcXk9Yx4kin1ZaLUtm6vcrDU7nCcWaYBE59lEic9n2pXzO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Prp9SOxt; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711129466; x=1742665466;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WWY755VbsXiAd4BTlYNGfcIC1cP9NKWszwcXmq+s6Ck=;
  b=Prp9SOxtY5N20p0UEQcFNHNc5zfJ3Qg6CVyJLdBfPBR9rel9qH4F9Ry4
   s05mFtb1Vw0oVvc5Sx5XE3nvo3rkykf0Y/mtaUzNtmjrZIRFw2K9d6sSS
   a40HdWmNFnd2YppAIb4RjAW9DLJpVxm6DA3rlc9zHlKLnj10RakHrn1O1
   g7lk2yltjT5UmobDks4wssZ/AeaTkFgd/Wuu0pUYkmfkoqhaqmG9VVZ8H
   VcDfzP3Wl2AtNKTk8AS7dHKabex8uBv6EqYZ3d7I3EZc4VKiC99A5HJAj
   T2CJ0RIqDSjIdprVQnYywRwg11wAyv2qTRGrnWAnAAmT4GkLtuLZMXFDd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="17335880"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="17335880"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 10:44:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="19657190"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 10:44:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 10:44:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 10:44:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 10:44:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muNHT6QMLeF2avazQdrMgYdCPTFpqofVOkMh2joI8kRrMPVQsL3+rSD2uckvMnpxuEhq513AWxvsCMaCBTARRfzO1pdMmeDLVQ9YgH2YT1eYUnvDQpP/+XiKMd90WCveqLJG11GJAFBvuNwO/9fZMzmB9a58pwhkyIPh3DJPBziOmFpqO6UtpP6bP9pqICCt7vphfxDkzt/5BMHwFtBjCpe7kIWFWOMb5qwWrnJ84jkvMTiFa+3vHOUPAv0Ytm9zpow8CR+lnzY5PZtWieKkZJF+QgT5d+8xkAk+/EYUQ404PpYawQIGD2S2jizE1C984kTN7nIZn4Eg26lOV/lAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3o8fzYPQG2IzgwDJ1/OS89P9W5j5bAj5p1QVenLIWUs=;
 b=j7zlomEMKQaJZGFF82SAaEPDNsDejAwvb65Q9E8k3kDwj4IGsyl2uBCsZPPvOxr2MC11JNNjLGFnJBXAleQu9fBaWHDcSSdyw2N8kOeVh8d1dDLErwcVHzI6cnlj3ddf7mxVg5sdNBQoWfVBP+P4IRcVpglrcDF5JCuzdSrOsgwjk9DAPO3DeLwVlUAHOBMNFf41FnU6WZVyfTTszXZX8Vm0n1lgz6QXFRNxK5mIIz+o84dlNoJ0/GBVIyekoMhUYbLlClZ/TDBYlTCrB1X497zC5P/pdVkklSOtoc0kT/m3ZrbHCsUArBDdBxvscxQoZpSUpCYginkUvl9FLJuxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB6950.namprd11.prod.outlook.com (2603:10b6:510:226::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 17:44:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 17:44:20 +0000
Message-ID: <0910f9ed-2312-46b7-9c64-2982709da3d8@intel.com>
Date: Fri, 22 Mar 2024 10:44:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Babu
 Moger" <babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, LKML
	<linux-kernel@vger.kernel.org>
References: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
 <20240311135230.7007-3-ilpo.jarvinen@linux.intel.com>
 <fe5c0d10-a57c-4a3a-ae30-a7cfa93bc3e8@intel.com>
 <f214c635-500f-43ea-fce8-0a7083bc1606@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <f214c635-500f-43ea-fce8-0a7083bc1606@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0303.namprd04.prod.outlook.com
 (2603:10b6:303:82::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5a2a66-7e72-4895-4be3-08dc4a97b408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WvJEK63RgGh4Yny9RyMJK5hPZ029r3EZJlOgyHyq7VM3rucqBhNb832fN97xYWIiE3J7oUzusl1c/nonQQRFsXaAHEpfOnZ10TxSNqTFCpAjA5i7JAJ79GDV4yskiDKb9DAM/hPsXxwg43hOEQBQrwHRS18WE0uRsqJfC317WQV9vtGG7zjTAKQPDDH8gOUvdtqfXr3DngBFfRiR+5QFy9zo1gSjh4Nq/YYi/Y8mRGBcwzgqw2GL9fe5Dly0+m+/LVoSeXKUcTCqsqmULoMVDcRQC2cJVat2YbuTTP+N9yaJSMXpJ+P4iymqDW/lEaAvaHQq9arWUNpA6vpQ9rFnmjwMgZ79d3hm7zNVb6E5ypoSUdrPdUTVolNQfJgKLelpZHdm35LjlRhnoe6+eg+z41F5csQZQ+XEroYU5b02+CZdgfIpgeqwE94Z0uYBN3cbruVdMtLzRvHtB3yZ6x49UQDkalfkYDE38NwuVQ41F6IwrlmuNJrDL0sG4N2VSfOVNVP6vSNkOp1YUAjYowRIhwkdWdijWBTz/udTf2iVRHvyu2cGiRi8qT1mvYKbmliE8pKNKvmaupx4vITxWvRjNFpgEmymHedsivT8husLCcsW8gVkmnL+A7eBBtHPCOpVg192tlYAKWfWJHUNVCJ6gPeFao5ZqKeaxDUhQwwOlD0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHdBdnBTWm9YeFh4M1FIalhReXBHT0xkYWNBYUZ4dUZoUnFocEF3bWxvNDVq?=
 =?utf-8?B?eW5HN0FhVjVxam5IYzR6R0xwZTNPQXF1YTlnQnRvN3E5T0kvZVFhT2lXM2xC?=
 =?utf-8?B?djdSbEpiUXlicE5KMVh1emlWeHVJYldqQmZXWngvci8rcE9YZkJLVi8zT3Fp?=
 =?utf-8?B?TUZaVHJkQ2h0eWRXWFVLZXh6SENUcWlQSTdaVWhwOWxnMm1KZDdpRVlMV3VP?=
 =?utf-8?B?NC9NYmZNY1BpSzVOSTNQR3NrTkgyRXk4YzNjb0VydVNTLy9ibnVYNmhibEFy?=
 =?utf-8?B?RklDVXpiYTdXM2xMV2t2V25PQ1lEdkdmU1FaSjkvQmIrTVFzZFNhdlhabGQr?=
 =?utf-8?B?REdNRGc3a2hZbVdtdDRPSjdEdUpoa0FtaFI0L1RuYVplRERvQUxaekZPUnl2?=
 =?utf-8?B?UG5zUWlqSlpGUmJZVkdrcmNlaDBLZkFwMnFIY0p5eHhUSElnV3AzQkZDWThW?=
 =?utf-8?B?ZUJTbjg5ZUpkUjNNRW5NVjM4cjZyamNaeXYzNFUyZU1PMWh3VStLblVKb2lo?=
 =?utf-8?B?d0JGUWNGZnVhMlM4aVd2UGZQYUN5aUhZWnZ1SUtJWXRjellia202blVXRDFO?=
 =?utf-8?B?WTVHcUhZR29wbmUvSkpvUmpoTTl2RWcyOHFycFJwczZ6ZU1TaFFvSmgrMlRn?=
 =?utf-8?B?MmErL01mSjZsTTlHNEg2SU5jWU1mL29vdlRhbFI1SlJsa1VMUUJoNldYbFha?=
 =?utf-8?B?N2Y5Tk1HVlRKUi9Nd0puamczbFJzQ2tUZjQ4TUtvbm1PNHNzeUZ0eWkrUWJi?=
 =?utf-8?B?VlhIdUxxM0NERFB6K0tZUldIQUIxQVpobVR5aEN1R294eWQ2OGduNS8raHht?=
 =?utf-8?B?OHF0cFdBb3NPcnB2OUVicmJnT1BRdm9NVUk0YnZPUjNheE1LN2ZhMHJjQUFy?=
 =?utf-8?B?YU13Y1VBd2M4Qk5WOVNxTExqeTRXbkxIMGxxaGtLRnRvSnQ0TElRekNScGJH?=
 =?utf-8?B?NEJRQW1zL0FsMWRsOXkvWE13cllXT3hDMzhRZytRM1VZSjRWYzRaRG5EcWwx?=
 =?utf-8?B?cDFNZndGNDk0Tkh0Z25SWDNoTjJCa2phYjVGejArekFpbUljSnNEYWhOL3VO?=
 =?utf-8?B?SFB6NWpQM1FJVWpvTmN2cDFnLzMvL2w4alJ6c3pVa1FPOTQ5RlZmdEZJbkNt?=
 =?utf-8?B?Ukt1WnB2ckx4Q0Fqakt2UUlHZ29tc21KcTVycU9jRzNqcGVmNGVJdWlUTUNi?=
 =?utf-8?B?U3pCbG9YbTNWaWJGbHRBQmpwNUpuMXBmS2JhM3FPTVRES1d6UENkYk4wSVJU?=
 =?utf-8?B?TjBnRElTVUZBa3NQeG5helQ2Vmphd2l3QXN6V0JHUUR2b3hwaVduZUlkWUJX?=
 =?utf-8?B?a1hodzVKOVRRZVZKeERNUENsWVlBeVJZWFNWUFd1bjJnaTlPSFo5cWJrWkRk?=
 =?utf-8?B?ZVVIWGsrZ3poVVpNNTJMb3Yyc2EyQS9pMGM4SXp6MFJpQy8xaTZJOEJOSzZs?=
 =?utf-8?B?eGQwSTQvZzZpR2hta1g2TVBFWHhUSy94L0ZLRUhtUTBMUSsvTi9mUTRUZi9y?=
 =?utf-8?B?Um9Wbll5VkdoUTlJWnhYRGZrcHlYYklXMGpibUxzRkpKdGoyMjdDSWppOGUx?=
 =?utf-8?B?dTFpZGtDS2JWc3FEa1F0ang4RnhUYlk3blFCYWd0K2pJaXhXZUF1R0FyV092?=
 =?utf-8?B?d3d2aktTSkMxZHFwMTRNdTBVTmZEYlVuNkNoaG5QOUlsaXQvNW5Ecm52ME1Z?=
 =?utf-8?B?VFY3aE80WDhGaVF2Z1drd2w0WkNmT2VOTnlFakx3em02MW93b0YxeUN3bXNJ?=
 =?utf-8?B?dGtXT1pOZ1AvbXNrR0Y4bTlsWG0zemR3OGdFYU94T0tjTS9obVRhRUdiUmNq?=
 =?utf-8?B?UmhsNytnajhHZTRlSzcvMXhCcTdtTVBzaktIY0ZFRUlibk90QzBWd1NjLzc5?=
 =?utf-8?B?TlJCck56Uy9nb1Q1ZWlXWVJOck1FWjBrbEZNRUk5VnJQMnVRRWZJdTN3K0Ru?=
 =?utf-8?B?TWVWT1dPeVBxMVVnR0pJdGw2bk4xUkdPU3g5UmpEdXBpTXJJM0pab0lxaHZn?=
 =?utf-8?B?VllVcWI3MmR3eVo4MTJDU25vOUhldTBKd2RjVnkvY2dJYk91amhJMEJNL1or?=
 =?utf-8?B?WXQvRDQrc09FRnh0TTY1N3V6Rm82SVdlOGNiT3gzbnJ1YVZFSmtwc09VTTk0?=
 =?utf-8?B?dWQ2TlNkUURmR1lhSVRScU41aVFnc0NXQnZJUGRQWXRxc20zamE3T29YRWZW?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5a2a66-7e72-4895-4be3-08dc4a97b408
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 17:44:20.2220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +9zFuc58IwELfA7LZAr18/wbIfh0tYLpQjQ/J8GPypXtRXSxxtqDuCvDaE7hompuvrJA/kalBglp0xLv8v+Dh6lw6UUgje3/YeRLITbZnbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6950
X-OriginatorOrg: intel.com

Hi Ilpo,

On 3/22/2024 5:11 AM, Ilpo Järvinen wrote:
> On Tue, 19 Mar 2024, Reinette Chatre wrote:
>> On 3/11/2024 6:52 AM, Ilpo Järvinen wrote:


>>> -static int get_mem_bw_imc(int cpu_no, char *bw_report, float *bw_imc)
>>> +static int perf_open_imc_mem_bw(int cpu_no)
>>>  {
>>> -	float reads, writes, of_mul_read, of_mul_write;
>>>  	int imc, j, ret;
>>>  
>>> -	/* Start all iMC counters to log values (both read and write) */
>>> -	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
>>>  	for (imc = 0; imc < imcs; imc++) {
>>>  		for (j = 0; j < 2; j++) {
>>>  			ret = open_perf_event(imc, cpu_no, j);
>>>  			if (ret)
>>>  				return -1;
>>>  		}
>>
>> I'm feeling more strongly that this inner loop makes the code harder to
>> understand and unwinding it would make it easier to understand.
> 
> Okay, I'll unwind them in the first patch.

Thank you very much.

> 
>>>  	}
>>> +}
>>> +
>>> +/*
>>> + * get_mem_bw_imc - Memory band width as reported by iMC counters
>>> + * @bw_report:		Bandwidth report type (reads, writes)
>>> + *
>>> + * Memory B/W utilized by a process on a socket can be calculated using
>>> + * iMC counters. Perf events are used to read these counters.
>>
>> In the above there are three variations of the same: "band width", "Bandwidth",
>> and "B/W". Please just use one and use it consistently.
> 
> Okay but I'll do that in a separate patch because these are just the 
> "removed" lines above, the diff is more messy than the actual change 
> here as is often the case with this kind of split function refactoring 
> because the diff algorithm fails to pair the lines optimally from 
> human-readed PoV.

I have not used these much myself bit I've heard folks having success
getting more readable diffs when using the --patience or --histogram
algorithms.

> 
>>> + * Return: = 0 on success. < 0 on failure.
>>> + */
>>> +static int get_mem_bw_imc(char *bw_report, float *bw_imc)
>>> +{
>>> +	float reads, writes, of_mul_read, of_mul_write;
>>> +	int imc, j;
>>> +
>>> +	/* Start all iMC counters to log values (both read and write) */
>>> +	reads = 0, writes = 0, of_mul_read = 1, of_mul_write = 1;
>>>  
>>>  	/*
>>>  	 * Get results which are stored in struct type imc_counter_config
> 
>>> @@ -696,7 +725,6 @@ int resctrl_val(const struct resctrl_test *test,
>>>  		struct resctrl_val_param *param)
>>>  {
>>>  	char *resctrl_val = param->resctrl_val;
>>> -	unsigned long bw_resc_start = 0;
>>
>> In the current implementation the first iteration's starting measurement
>> is, as seen above, 0 ... which makes the first measurement unreliable
>> and dropped for both the MBA and MBM tests. In this enhancement, the
>> first measurement is no longer skewed so much so I wonder if this enhancement
>> can be expanded to the analysis phase where first measurement no longer
>> needs to be dropped?
> 
> In ideal world, yes, but I'll have to check the raw numbers. My general 
> feel is that the numbers tend to converge slowly with more iterations 
> being run so the first iteration might still be "off" by quite much (this 
> is definitely the case with CAT tests iterations but I'm not entirely sure 
> any more how it is with other selftests).
> 

From what I can tell the CAT test is not dropping any results. It looks
to me that any "settling" is and should be handled in the test before
the data collection starts.

Reinette


