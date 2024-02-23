Return-Path: <linux-kselftest+bounces-5364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F37861C8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 20:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5ADD1F24A51
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 19:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F01140362;
	Fri, 23 Feb 2024 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PZnH9vpA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76689179A8;
	Fri, 23 Feb 2024 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716652; cv=fail; b=hGdvkuw9a0PPrnyjU1pOUEFU+B93lob9lLJuZaTkkU69y5HdGM+u6xIDnMSC9N00O67dU3jmaFNpHKS5ihRKelLaTvCWapjYKuJcLeOmlvJ+RqlF9x58vGCg8awmwkfdBN7yV2fiAIDAJetaQtt0/Jz/muwEZNFfGsWG8gmKZvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716652; c=relaxed/simple;
	bh=PpQb7AogowIQH0Ht41FDlIapEOO0CPoDPhPDZcyyUJk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QgegO2bQwvUgLbH83GbqJsYXPj53k2GKdSrXvY7aX1dETx9u1jwwQoiZBKEoIBsQygvejz43oAZ3YO+cdDdZsvOlCe83db+rzAf9ANY8u1PZF+ZwxVbN0chjVjBOxMN8NfmLApjj9JOvUUyUl89ncttjX3t1Zq+VCLVyglMWDSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PZnH9vpA; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IITgVR7GdslXuve8eUwVp1PZJAbs+G+R7muoXnuWjzTWz4d84AYlim1ljVHuBIKGalQBVsOYvUZiZxFYR1oJbDhRFVJK5U4ehSIhNIL2csnzosWpnTOdrrqBdlFUKLtxUYjnNtowaNbvWlDp6ZK61Bl1DBMP7Ja9qfpMdmxYR0qB2i50W09AgvaFHuOZ22Gtvg0owMtsexbJ4aCSIIUFPtZPGEF+zm+fND9LqIH/DPs7xrFh44j7Ic3o+p+4EGjcTmnOAfvANRQMjUEf3Xq6dex9AV35Hrdj6MSdQuvaI6e7EnvNeepZNek8mh9ijkMowj1w7mKEoVGZEbXea3eOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJPKbDbY31D5Y+1zVUpgzlAMGwfDo4JU8YNxI6tXoNg=;
 b=F5lYDQcpUzq+bQpBrpmAxsUJgblfaLI0MDlW53LJWCP1jfvpHtbDg54fdsjm+7jwcVrIKHF0XdIEs6sPkXnZ3wZqzoOLO3ZsDHj5zGow/+lILGMQPceAWevr7hmflmSRXDCweBwzIoIrsitBVD8ynAEAhRSDriez/mK9gKNDSJ+J9p07kejH9rnt4nMeO/G+1vDEP4lWXPcU+TwI5mrYvqr3LFfG/tHwvdWc1A5Vs0F55QLeuKNH5IgYkbjutQ4QTZXLKGolTpvNL/hRrc6j4D+qdM2Db1Kq49Dguc5o1CHQH4uZW+LpGeeN4+eDaF0thVaRTo4xlf6bsCYGxTSC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJPKbDbY31D5Y+1zVUpgzlAMGwfDo4JU8YNxI6tXoNg=;
 b=PZnH9vpAI8MhykAfdC1YuJvpVltV+MFmUsYyTg38LEEyPLnkrqJEF26xwgYHFgH83diGYsuyAH/wIFXoNOPx95S17qenlbU5T1BABHp0mTxY1OeoE7IzuvUIIvsxWU9lpQUt+4OjHryuGiZJtp0bVY44KSZtubZGqwhMwEwEZaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.26; Fri, 23 Feb
 2024 19:30:44 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f4aa:152b:b46f:80a0]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f4aa:152b:b46f:80a0%4]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 19:30:43 +0000
Message-ID: <efab7efe-d043-448e-bc7e-4a756b4f3367@amd.com>
Date: Fri, 23 Feb 2024 13:30:41 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 3/4] selftests/resctrl: Add support for MBM and MBA tests
 on AMD
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>,
 shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
 peternewman@google.com, eranian@google.com
References: <cover.1708637563.git.babu.moger@amd.com>
 <cc22790173de9978a6485baca5bc96a8ad8e05a4.1708637563.git.babu.moger@amd.com>
 <6f611a0a-f2ef-1017-07c0-5d805abb80d4@linux.intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <6f611a0a-f2ef-1017-07c0-5d805abb80d4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR11CA0019.namprd11.prod.outlook.com
 (2603:10b6:5:190::32) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fdd75cf-7435-4eab-cbb2-08dc34a5ed73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mXcUGH8fDvb1Dym7GQA7Ak78litQ2QW/irWlbPp+qr5K+FQ1craSczJzdKsd5/3In66QfS2TL0iKuueT4sFLgM7iXM2X28G1AclJpMH06UmCx4hfanwnhZ8AdT+lzYwA5BsiflEoKlludyYldqFrmkdnRKrC843nELpVZ001WXUFpp7EZYKcXgHX0F5gwc3W7DHeu/Z8FdTmf+wgY3glk4gMFkxZfwLxiMqnpxE3g7JETybJKylh5p4STLXFEuQmP1cpRZpLB6NNl+v/tnyny3kjiG8t1yIm7OyHJYOG5wVJaDyxo54sTWLpFm+eKJie+aG/gBp5mW4hrHeO2ocBXgz7utvg4SjO8XiQ+gTgmYAlma6OIVJkYL+ZGGeqtXCU8dkc79wPnS/7vvqvxLrTmqL9fu1c7r/fKyrMVO6g11FXljJMdUzJgO0HlIngzDXcTSQWar/19sq0GZCtXcwA7dQfimgB21vNqYkGHcioI7t5glx12fUg7gAhganE6sG6FHeRuXngSf77QWHNg1P5g1GR3TJOYrw8LJbfT/7NKGw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlFScWpmbzMrdE5kc0c3RXNrK0MxWFhCR0xlUkV3V0ZsdFVNYWl0ZGVkUjlC?=
 =?utf-8?B?dGF1dUNzTW5oTXdVODJtOERwU3UzTklVdVYzbis5VTk5Qk1wNjVMaFNWek8v?=
 =?utf-8?B?K2xYZkVJYjhJaWhYbDNPajVjUGxqZTJuTVVyUnlsbDdEQXJwdjZVWnlxR0Fy?=
 =?utf-8?B?ZzJkc1ZncUp0T0ZQOS9MNnpUUk1oWGx2NW5Gdzhaa0txbkoxYUMvZWVyMjV2?=
 =?utf-8?B?NlJiUjRmaVVrVkZxUG1Nb08xMDRnK2VWUVA3bEFxM0YzOU4renY0VHFQME0y?=
 =?utf-8?B?cDEvNUI1c1VzYjVyUnlaVkpBeWw0UENQN3VGSi93VVcxamVPK05SOVdMbGg0?=
 =?utf-8?B?VTRIOG1zWi8xOC9VNWVXWHgvVU1UKzZ3TDl4S3laVHg2MGZCb2lLZnpNaHRC?=
 =?utf-8?B?djZyamwrazhQRnhmYndwblV5em5OK3kzc0tUdlhSMlhuSHA2RXY2eHhONkJU?=
 =?utf-8?B?N3JQY3hORDRIanhYWnRGcGNZUEc1b21aU29EYU50Tmx5Z3Z3Q0V5a1dYRTR4?=
 =?utf-8?B?ZEQzaHFab2M1MFkwSzhCelRScEFMUVQrTmNUVFRsb1VuOElrNTlCQ0Jtblhq?=
 =?utf-8?B?VXZJK3BEc1BQQi82MHFXdkc0TGVzVEdHRFRNLzhocXFrN3lTMHVJU1I3VFJy?=
 =?utf-8?B?dGJHM3ZDTmFkRktHM3NKSmphWWlOV2Excmd2c0MxQ0MzelZnUDBtREdERTZM?=
 =?utf-8?B?Y09ZUFE4T0d5cUs3TTF6a3NSb0tGV2pnVExBclM5QUR1SUtKcG9qZHdUODBG?=
 =?utf-8?B?enRxNlQ4TGpqVEFvMUw3d0lLTjRHclJuWllPWHVVWE54V0hGOVREVitKOG96?=
 =?utf-8?B?OTM1c2dGUmZRZ213VzB2VDlBR1IvVlpQNkdyY0RLa0VvK0VTcGRHYVh0ZTJP?=
 =?utf-8?B?bi85aEhUTjYrZWU3SmxrRm51b0tKQm9GY2Y2ZTVEWUJGR251czV3UTU3dDlW?=
 =?utf-8?B?MXFEdGRQc2VIR1FtQi9SNStKTGtTRlVWc1Y4Qk1ZTG1CTS80RnozZEVzbGpL?=
 =?utf-8?B?R1M2YXozTWFqVnMvbzAxOU11eG9NRHhTNmdKcFRIUmJKR1JoMGY0Mng4UTYv?=
 =?utf-8?B?Rkwwakc2Ni9Lbk5sblkxTUpuVU91ZFVTazRrS05xS08rL01DQUZhbnN0enQ1?=
 =?utf-8?B?SFUxL2lvWkY0UjBLNmRlYzNsTXl2cGNqWXQyOWVrc1JPV24yekp1ZWdhQzds?=
 =?utf-8?B?M1VQUFhQRVY1VnNqQXFRbEhYUTJFS2xPd0N5TlR4dnVOcWZNdDd0U0lyejBG?=
 =?utf-8?B?cy9ZMjZVRkxoMm0yWmM5RHJWL0hpK2RkQjFHS0xKTVFwaWp5L25ZSzhmLzN2?=
 =?utf-8?B?SjZKVjQ5eGJ2QTg5UWRQR3RsakxyZWdKc2ZUeitDb2JiSnBmNTE4SW5NczFw?=
 =?utf-8?B?SUY5RzA2anNhYzZqeGFJL2Z5YWl0dDVZVEgwd2NRdnhXVDhxRWRGRDZOb1Fw?=
 =?utf-8?B?YnR0Tm5lVUFPckZwUmMzcjhzU3UrcXhpNklZWTQ3RFFWMWR0Smw2RWtZRVFw?=
 =?utf-8?B?eTlWcXdpQUR0TTR6SUxyUzAxanNtZWxrQUxBUkllQlc3VzRGZWYrN3hpWFgx?=
 =?utf-8?B?WDZ4eUx1aWhOV01sNWxneTdVTVFaSlBXZjVqMHRySUVWd2taMmVudlFHVStt?=
 =?utf-8?B?Nk1RcWgzanBFditEVnV4VDNjSFZIU1Y3Q2tRd2JOL1Z6SGVvMHZCeGtENXlv?=
 =?utf-8?B?ZTl5OXVuamFOaFRFRWtWbitYV1FMbmVObmVLTW1GaWxXcmM0SGZaZVpqTGp5?=
 =?utf-8?B?RlpLUmVHWVVId0hOWGpKeGk0OEJIZ05OWkkxODdKL2xVL2w1RFBPbXZmSWRZ?=
 =?utf-8?B?RXNzNGlmekFuWW1ZNjRxbEd3bVp3WXVWRjdKbnNiVEwxckErM016MXQvSWRj?=
 =?utf-8?B?TGRXZkQrcTZ2VmY0bzVIN0VMTVhEMktIMVRKcWZjcWVkZHlxNnZPVWwxeEY1?=
 =?utf-8?B?dUE5ZktPUzlhckZwMFF6bkU2N3lXb20rUlJzb2JudzBlY0sxbEJqUWo0a29W?=
 =?utf-8?B?bG5wK1IyWVdFK0hsWmpIdlpPYzJwQUpOZWcxdEdCUzZEUDE0REc3c0JJUUxK?=
 =?utf-8?B?QTFObVR5WnNYOW1Kck5xUWdoK0VyY2EzWGhZY1FCNXREbTEvUXNWbTBVaTdx?=
 =?utf-8?Q?N6x4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdd75cf-7435-4eab-cbb2-08dc34a5ed73
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:30:43.9118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HamJVB2l+QBlkbsKT78SVujx5gVfSOQzvhICNpitLAkINRLGPIWLIGKnXSMG+GV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315

Hi Ilpo,

On 2/23/24 04:53, Ilpo Järvinen wrote:
> On Thu, 22 Feb 2024, Babu Moger wrote:
> 
>> Add support to read UMC (Unified Memory Controller) perf events to compare
>> the numbers with QoS monitor for AMD.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  .../testing/selftests/resctrl/resctrl_tests.c |  6 +-
>>  tools/testing/selftests/resctrl/resctrl_val.c | 62 +++++++++++++++++--
>>  2 files changed, 58 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>> index 2bbe3045a018..231233b8d354 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>> @@ -104,8 +104,7 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
>>  	}
>>  
>>  	if (!validate_resctrl_feature_request("L3_MON", "mbm_total_bytes") ||
>> -	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
>> -	    (get_vendor() != ARCH_INTEL)) {
>> +	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes")) {
>>  		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
>>  		goto cleanup;
>>  	}
>> @@ -131,8 +130,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>>  	}
>>  
>>  	if (!validate_resctrl_feature_request("MB", NULL) ||
>> -	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
>> -	    (get_vendor() != ARCH_INTEL)) {
>> +	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes")) {
>>  		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
>>  		goto cleanup;
>>  	}
> 
> These need to be rebased as this code moved into per test files with the 
> generic test framework. The .vendor_specific field is the new way to make 
> tests limited to particular vendors.

Hmm. I picked the latest code from tip/master. Where is the latest code
now? Is it yet to be submitted?

I can wait for your code to merge first.

> 
>> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
>> index 792116d3565f..c5a4607aa9d9 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_val.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
>> @@ -11,6 +11,7 @@
>>  #include "resctrl.h"
>>  
>>  #define UNCORE_IMC		"uncore_imc"
>> +#define AMD_UMC			"amd_umc"
>>  #define READ_FILE_NAME		"events/cas_count_read"
>>  #define WRITE_FILE_NAME		"events/cas_count_write"
>>  #define DYN_PMU_PATH		"/sys/bus/event_source/devices"
>> @@ -146,6 +147,47 @@ static int open_perf_event(int i, int cpu_no, int j)
>>  	return 0;
>>  }
>>  
>> +/* Get type and config (read and write) of an UMC counter */
>> +static int read_from_umc_dir(char *umc_dir, int count)
>> +{
>> +	char umc_counter_type[1024];
> 
> PATH_MAX

ok.
> 
>> +	FILE *fp;
>> +
>> +	/* Get type of iMC counter */
>> +	sprintf(umc_counter_type, "%s%s", umc_dir, "type");
>> +	fp = fopen(umc_counter_type, "r");
>> +	if (!fp) {
>> +		perror("Failed to open imc counter type file");
> 
> Please don't add new perror() anymore, I just managed to clean up those
> in favor of ksft_perror().

Ok. Will look into it.
> 
>> +
> 
> Drop this newline (to slowly move towards more concise error handling 
> blocks w/o all those extra newlines).

ok.

> 
>> +		return -1;
> 
> 
>> +	}
>> +	if (fscanf(fp, "%u", &imc_counters_config[count][READ].type) <= 0) {
>> +		perror("Could not get imc type");
> 
> Ditto.

ok

> 
>> +		fclose(fp);
>> +		return -1;
>> +	}
>> +
>> +	fclose(fp);
>> +
>> +	imc_counters_config[count][WRITE].type =
>> +		imc_counters_config[count][READ].type;
>> +
>> +	/*
>> +	 * Setup the event and umasks for UMC events
>> +	 * Number of CAS commands sent for reads:
>> +	 * EventCode = 0x0a, umask = 0x1
>> +	 * Number of CAS commands sent for writes:
>> +	 * EventCode = 0x0a, umask = 0x2
>> +	 */
>> +	imc_counters_config[count][READ].event = 0xa;
>> +	imc_counters_config[count][READ].umask = 0x1;
>> +
>> +	imc_counters_config[count][WRITE].event = 0xa;
>> +	imc_counters_config[count][WRITE].umask = 0x2;
>> +
>> +	return 0;
>> +}
>> +
>>  /* Get type and config (read and write) of an iMC counter */
>>  static int read_from_imc_dir(char *imc_dir, int count)
>>  {
> 

-- 
Thanks
Babu Moger

