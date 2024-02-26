Return-Path: <linux-kselftest+bounces-5432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EEE866FF4
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 11:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357B91F276FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1B06087B;
	Mon, 26 Feb 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8nBpyJ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2D0605BF;
	Mon, 26 Feb 2024 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940625; cv=fail; b=LuaVukU68CbqtzEe8AoxIniZRn4TQs/de/JXNGjNDsJB2vMi2csqrx2siQ0U1/vwJwAS8y6t/0LBe4w1Emfa66RhG8vhr18sHOARQ5+ueZoZ8fUUFkgvHAWIjy2r8brISWCWsYLAPxMA9tzukuJ2ACZku2hLseaACouJU8Ez3+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940625; c=relaxed/simple;
	bh=OnNcejwjMd5lgeA6G6Xh48UEk52uAmeGSD14ZZ12nvQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nyqekBMKK7Os1dFvj6I/oHABZnLqQ6hrRuwMIzi5fAspJTZuP1IaxyFfJFrhpUux1Yv/AI8+ShwPCTR+b7/pPqnkSI/4pCf4adDU7yXf48bil7kttMz2p4r2WTzjXZ2nqwL9rqIlSTV6UNyeR+F276hrtZPevmYuyYkFqmnq56Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8nBpyJ7; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708940623; x=1740476623;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=OnNcejwjMd5lgeA6G6Xh48UEk52uAmeGSD14ZZ12nvQ=;
  b=l8nBpyJ7u27FJjG72uIXTRjYkUOBBA+5K49f40yrrkZuxOt3MhKjPdgl
   LdnmCs4kqUsegygYwkRewpGgROmMsoUOeyzSgaiDYRsObTl+x/C5uqKgJ
   iskx1sWcXCsirH/0mHOA7NXeCjlBCRd+VR1F+/MHMZtBl5GdaADlz6dug
   fjWx61ShQeu95QTKMJsdXMk6mwc1FCv2fJ8AuiB5crfYy/nNQkpSfxCCZ
   PGSLcWypsbitXW8ND71bTHR3G5gJoT8sqgAVFNNsWBoY/bfsEaVgVuliE
   oJ1eaD7GrjZ3ANVPCNCYQCfN4HPK1KCAgfvmWQVkDAER+MUVC5guydDf9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14346910"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14346910"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 01:43:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="29791145"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 01:43:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 01:43:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 01:43:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 01:43:41 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 01:43:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z964BZdCsdGHxY8uLscDfPwhwpOLmUvf93HA1KP3ZyM5Y6GuHMAtbOyeTdMchM4DjyHvHb6KloyErkw2PB1WqcuoFLn8IcHcKWoF/Hu0zbGLigEG6JsIjk29WW5H3p55rjTsl4zdUq2mxcxT7G8V4FZG4616PabT5SEUcllcOJLn4YeAbEpzr5Pos++kVCxNNgeI9ZrFqTmiGF538KyYHnMccVjYTgCR+D/2ELN5s6B2rDFvfLmQ8ZaR0Sfvivfrxo1Kwu7QF+vpgf0giV7Bgzqh+OVNGGkgL+K6Iqcq6T/i5ED5yNeY/PXvSQiH0DPyaR6Lj/oKbnEpn6Fb4wMjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHPvINdd+NTJDDZLP3ob/B2yeb7uzcmd+jPCKE75hlE=;
 b=lRqdEXnGwx3FiIPEPK1V4QKF3kmD5VQo3JcznByusdNEXYuZ6laht39HGLWa7ervTb1pzE7E41liIlZkEi0zMr1ef073vTUC5JIWegCCKZFFREBst9GPI5EQWAKo67ha94Us3tvS36SWZR3ivyQzJ3nhsM9XYrfcNTYgunRM1Rgs0RCDqd9Wn9ba97NfexClwTgU9StpR/4D0QXQGIyw8kC+WVzRxU9UQ8M6f/p6MMMng0TIocEAXf4fHDfNWv9dns1R5r0gPIN4RCIy76OW0ewfBo8z/WdLcVKyWhOomAIAni/5q9erCMzv/tuK8lFyFVFHV9Rnb88bzOXtrSL4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CY5PR11MB6140.namprd11.prod.outlook.com (2603:10b6:930:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Mon, 26 Feb
 2024 09:43:39 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7339.024; Mon, 26 Feb 2024
 09:43:39 +0000
Date: Mon, 26 Feb 2024 10:43:35 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] selftests/resctrl: Simplify cleanup in ctrl-c
 handler
Message-ID: <qxn5tpm3gkv7l32rbcjapik6mn7uzmv24zw7hyrvp55mngyufb@3fgphjebxkvb>
References: <cover.1708599491.git.maciej.wieczor-retman@intel.com>
 <e84995d79debfa8775a1535a82c6ca637f6891da.1708599491.git.maciej.wieczor-retman@intel.com>
 <635699af-4abc-491e-9528-66ebfe9eaf6d@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <635699af-4abc-491e-9528-66ebfe9eaf6d@intel.com>
X-ClientProxiedBy: WA2P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::28) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CY5PR11MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: c04f7f20-0795-43f7-5587-08dc36af6947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r38cexJc5sduoOxMLqL9xRsujncCBqymkDb/lnV9NFll1OPE/TZ8HkYHGaEESnejT43KXcL3fP+LPhgoUyM2K+rvUqmgwvl9OuMIQNhnhnN/w54WbMeJddGc/KzEZCW3aru6DbWYuaNyX6TP3KdGqlTlUhOO3xo+QS+rndG7rA9rWPlRBKgDzVtuLebqzwuwmopvlJ1QMLAdOadqrP70yrZzC0sAsE9Sm3RJQA58hOJuOV++B9UeF6NVCbJIt+O20ti9o1i2QTB0eLZvqq2pSMknYucJ1VfTk+YZwCt4PJiszIT3ZHo3rBdSEx0Uu/iyKzkhbpRMP3Pa6/SR8V1AXqU7CYId5oLSVV3oPzFaP3k7GD2F9Nd1q0JGvRM2cDrymqwNe/YnWIsgL9BiZcUl/BB5hPgbXrYsCAOc94i3W8tnFCtD5c0i4HT9X+po5TkPZXhzNy0qrr30iHq4/7BetZQ7Xm43WI7yrDcniPDcXeFC0Fgjs/X9hLHSXk9eAxqc2JQnwaGnoy/PjBzKPSbFd+Is73MYDmXyu74DTYSQk622vIIbg4gKHuq4vIyJDAP9BQOC5LaHBN/ldWNDCzoVxxI7UySGEVS9KUlvIzW1815LuqTFXSFKG1mXZr4Bp1eX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zW+GA0f1vojNlviYvKjL027UY+RtQzL/oJLSVIR6+ZGLJgFoabPCZqF6I2?=
 =?iso-8859-1?Q?uFRr7JmyX1nsyFHZdXZyjBRFhCRLpFI8YmPAyZS0XqNzgAjJbhmNcYP3nv?=
 =?iso-8859-1?Q?NuJDASwoatUpDKaLTTGYHXcr+tBkujq6cG8HMxzmetGo4KyW2o83asKvZs?=
 =?iso-8859-1?Q?xz2y4692X3Ao9wRIxtVD27lFy93W2RZVxjBl9iTT/Q831Xb1Tr8TnBIAbn?=
 =?iso-8859-1?Q?f1gezI8A143coADC/xhtXBQOw7RDnAGSalyEHoU7sHwSTU89L9MycWA4QM?=
 =?iso-8859-1?Q?N011XTniPWbOqW7iPF3T2a4/QUfP5WKaM/2zJ8X0crPeStSwNZRHJnxJYg?=
 =?iso-8859-1?Q?jBP1XSvwwb3YVsKw4fgBJFT+0lNISuT7OQ31EcAwUB5JiVkKln8CWSujK4?=
 =?iso-8859-1?Q?U7Njde//KL4KUV3WL1Gc49Ha7FC8JF5mOam/1IbjwxzXFctfyDtmxF6pjf?=
 =?iso-8859-1?Q?530X1aAP0FK/vXXqQ/Kh0c6DNKuDkZaZsMlzrY2LFdFPrVVbeEz1mbOwLe?=
 =?iso-8859-1?Q?3y/LuIHdtEn1Tx1aloFhInnxRuqHZRenWtPErwdZ3cfvtwq8hM6YQ2P9Hk?=
 =?iso-8859-1?Q?9ZtySFUXURWYjl/pTvF9uu3TrVdtOrQuV3Teeey2hS43QujT+W5QulI7qr?=
 =?iso-8859-1?Q?MwylM1eG+YSPu8BLZUEtl2cOnCFpHlseq4h4AU6G91E/64HGeWyB7vTlz4?=
 =?iso-8859-1?Q?jGyHcqtNBe2ycxRTUpes6JE6oVXc3C8Lpvi4dbruX2PqK1hHm27koW66fF?=
 =?iso-8859-1?Q?tlz1N1uIfmROgqZPvTaDWnkcoY8h2e+jyYN/xVODguiBqJq015AJcfLyJY?=
 =?iso-8859-1?Q?CYf3pp9+dMhBsZCvVpsCjJuNBpJdphjVxjSklMszAdyGSVfhtYxqv9ZwEf?=
 =?iso-8859-1?Q?UfHFN81Dx3Get+erIHzlBVr2Lemy3DmUddlM5toOOThMHjjcqawmdgAyea?=
 =?iso-8859-1?Q?+zSZZEKxTkS6PpLFTyiKn2fsmD1TzycDt23rWoVfGpRIqqK2pQuN1U12is?=
 =?iso-8859-1?Q?q33aAM6qN0MlgQ+MJP3Z5eJzbPrtma0on1un0ctwIzJZHyeEp6vpI4QAWg?=
 =?iso-8859-1?Q?F8tf50HA/CLSmCqN2z/jG7456sE6blafkxM8TbB9AdE+exNfbDBORI2e7G?=
 =?iso-8859-1?Q?GBUWj4OzU8hRkZ4Ely7Z+d8kZ7ECqTyw0ik2MoftqiMBnHCdqnIAockfao?=
 =?iso-8859-1?Q?TqZysPXnqrZXzJqZ6cV9wSkrH3EPlwkHkSKIimNeGqCssQWT5WXOJcd0DD?=
 =?iso-8859-1?Q?FqRP70ZEgFn2LvcGlgyD2Ot7ARyQbJSazyd1NCy0rYN5o7CEp9vZ5+6fLt?=
 =?iso-8859-1?Q?5xG88UCTCHOZNXW4SxbyBXaT5wLhO+oeFfT54lmfy8P9DJTw0d8DwKQDrS?=
 =?iso-8859-1?Q?zydMUyG/bA9/lAWg2ZDu2ElYA2eY5L/6xzVJP35Q3FEQkIsuxby3NCBoZC?=
 =?iso-8859-1?Q?G45+h5ItvClDG3vkaib2n8kVWBBVw4T656t2o862prtPf0URXFEl0LsVhu?=
 =?iso-8859-1?Q?LjFdo1raPquEzvUaKbDSCfPLSPv7SE1O44IuoeFdpZswsUpIV7AEIwsdOC?=
 =?iso-8859-1?Q?YlW0nTyDnwlB9K3xECrcDzot2TqpgWW+LSIgSP7f9yt1P+kgzhR1dUbkYN?=
 =?iso-8859-1?Q?SgR/W0dBHXmTHFa0NQm3WjHTYp1dIDdjldmUVAE2iIepzBKuWOCKUNdiZ4?=
 =?iso-8859-1?Q?YYuK5rUL57XcsMSrTgw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c04f7f20-0795-43f7-5587-08dc36af6947
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 09:43:39.3928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfwuGqrZEP8hTD9l4V3pTkYn/OoGKdjpUMBI04T+y0SfwOQa6+ID2lbo8QIGFSQRqm+CfRqIyYIVSHaxn1s3Xot+e4kDIlwy5oZKP8tKp4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6140
X-OriginatorOrg: intel.com

On 2024-02-23 at 13:18:22 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 2/22/2024 4:07 AM, Maciej Wieczor-Retman wrote:
>  	}
>> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
>> index 5a49f07a6c85..0134aa2f896a 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_val.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
>> @@ -62,6 +62,7 @@ struct imc_counter_config {
>>  static char mbm_total_path[1024];
>>  static int imcs;
>>  static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
>> +static const struct resctrl_test *current_test;
>>  
>>  void membw_initialize_perf_event_attr(int i, int j)
>>  {
>> @@ -472,7 +473,8 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
>>  	if (bm_pid)
>>  		kill(bm_pid, SIGKILL);
>>  	umount_resctrlfs();
>> -	tests_cleanup();
>> +	if (current_test->cleanup)
>> +		current_test->cleanup();
>
>Could you please make this more robust with a:
>
>	if (current_test && current_test->cleanup)

Okay, will do.

>
>>  	ksft_print_msg("Ending\n\n");
>>  
>>  	exit(EXIT_SUCCESS);
>> @@ -482,13 +484,14 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
>>   * Register CTRL-C handler for parent, as it has to kill
>>   * child process before exiting.
>>   */
>> -int signal_handler_register(void)
>> +int signal_handler_register(const struct resctrl_test *test)
>>  {
>>  	struct sigaction sigact = {};
>>  	int ret = 0;
>>  
>>  	bm_pid = 0;
>>  
>> +	current_test = test;
>>  	sigact.sa_sigaction = ctrlc_handler;
>>  	sigemptyset(&sigact.sa_mask);
>>  	sigact.sa_flags = SA_SIGINFO;
>
>Could you please reset the pointer in signal_handler_unregister()?

Okay, I'll set it to NULL here.

>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

