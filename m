Return-Path: <linux-kselftest+bounces-5365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA02F861CB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 20:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4484B1F23DD2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 19:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87C5145355;
	Fri, 23 Feb 2024 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PbpcRNIF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ADF1448F8;
	Fri, 23 Feb 2024 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717152; cv=fail; b=iI/LT6D3IBIhhH+FImYuX9BtyKhelRB51098SG1kO6TOPUrk3XFmwfNRc1vVGtAw/xZBoAetaFFoIY0YW6n4gpAXL7sH58PQfw/V792JFhC8wd7Nad1dEzVI5T/3+pKDv0pCBLKyXDncpkiUxUKpU8YxsdZPBlZd/wffamhZKv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717152; c=relaxed/simple;
	bh=IPMGfsKDSvDuhhIQxSllb5iS1CSBDejTDOXSblNEmtc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cKUi5nd0go2i9PXlawN8wooWoNkFX0rPs+m+xNPHscvpR0YMBzhUZCi6r93qmQhFNlyZ5JYJPux/IzTHNQV4Ui3AT/OwbTMhy0TTNdEjP2E/NOvU02y/phrXWBE8zbNGwbJYzXXg+ZGg8p8GntsSnc4/Dc8ccCaLDDwJrxyRcxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PbpcRNIF; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeQdvKM+AAXe4LBfePuhpHWzeS9BO1eRc9QcxVVxShmODm5DAJN25EXukqoVlEnKtJ1Z4yD8fphX+XJSAUnfoT5KoX9lHNqPiXc+FlKCzyCrME7qKpfVqxY+/pKcQIYRmV4bi2t41CgNmJMZ4BceXRsmmpfoK7fItm1W9UaHGQbfcvOD0zAc67wPjY+qj72/Ks1qHS4vh1Dq+5Y5Tk6oAaP+qKahDFMNot0sfwl//wdkqG9It/KUrirhBv5QQ+qPplySbhJNTu55rgdGTW8VXDyixtATTbq+PRrdCPG+ccIL/IP/l+taCgCGrwY4Il6NK2B/PgDl4FwRJPGq3wB9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9mO4BQawUDYUGo8SQ0qAuEnxGAbggtLBpjS7sF4Q6Y=;
 b=H1U6xtuPo8Ydq/FZsXkF/IpsT7WIX6osM6g/qRyQn2w0rOAuiTe1v9Lk2Vu9+TokeRZi+kUSdU4YrP5Q9J45MjsrxrTZQ2KLv4h518AG9g0+YAuDvR2X3hmAy+npODesWd/BrOi9PqIuUFzUNAUVbmXxL1YZRHKxoaEvzV4/dojS2ssS4pJHEaXZGvjjXlxH2dmGxvhg8Goj4/072Jdrr+cvC3pAhoWZ1/KSdAhasEec60mDxkziKRvl9QG05Pxcz/4OLNAN++gsc0JeiQbtGYKZJ79xY6mhJvjumnECCfVyah+1F/DrayVM/VWSRNEqqIMmJOTWfOLsrfb9WumbeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9mO4BQawUDYUGo8SQ0qAuEnxGAbggtLBpjS7sF4Q6Y=;
 b=PbpcRNIFgbqzOpo13YZc6HCIq89sqrPhjoblgwKz2eYqpr4HFnq/frLtM3dMOOUsND3oA9fRLrdumJWw8sFYhPcN+l5QVCFPHZ8jc/qSEHvpxSjwz6OHfZshcFgz5pEnhPx/pVkJ01fsuoATbX85o3YwrgVaLfdI+k+JFo9PJBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.26; Fri, 23 Feb
 2024 19:39:08 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f4aa:152b:b46f:80a0]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f4aa:152b:b46f:80a0%4]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 19:39:08 +0000
Message-ID: <2c07415c-78fa-460b-8aa5-9a40536ce339@amd.com>
Date: Fri, 23 Feb 2024 13:39:05 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 4/4] selftests/resctrl: Skip the tests if iMC/UMC counters
 are unavailable
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>,
 shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
 peternewman@google.com, eranian@google.com
References: <cover.1708637563.git.babu.moger@amd.com>
 <f5c74072d96b57b10a66c01381139de453187327.1708637563.git.babu.moger@amd.com>
 <a13f6e21-9929-a16d-bda1-533eaed8f875@linux.intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <a13f6e21-9929-a16d-bda1-533eaed8f875@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR11CA0069.namprd11.prod.outlook.com
 (2603:10b6:5:14c::46) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 4395304b-ebd9-4c71-0532-08dc34a71a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v9u1l8BVjjri40QtbqXqGISF8OEK6ctgFB3HPhfF0RXJQpC6Mvf/DkgaKnTpxUVPxLuYW/rVLivQFeB4Mk+C4bysnlaHhxp8xgyUv9x6fhFkXzvlUtaaIx6pbnaYfWUDBDsANqOXPHsRUtAzttI5mYDZ05PEfF1V8R+OUWRvi/qnLHOhAA6QiF0JTG76CQhXhmByqL0vuIim4DI6jVRdv2NHlfhvLVhm2OQCi+3Aww/DzHGpZc4g0b5vmeD8BVRSewbg0F7z6BrfN0CgOJzxoPetNit1VAeDlTDlO5Q80nNEIvbPNOyue+bPkxXjWs0vlkZJdP+xQC1qNHb/TN5ZuQQVl4XFwngLPJXn5kKyGRTsfYrUpVkGV+W8d7tTD7BwXg8eDx4FDDJS93dnjLQwp16OpHs7uPuxJkd5nEs4KritVlpjEWCi8UcdZCefLgSQlw3TWfIrTcGhATBti0fk+TnskftCpMUfWBDKBQQrDlZqBHn78dvelLtFDJ0CXkS4AjO+wEorn4Bhyb27pDsxQctEsMQBaUPIiOhRveBiaB4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFNqeHdQWnZPK0YvT3F4TTJSb0E2MHlvb1dITjFEZVV6TDRENDZlbS9DaUIx?=
 =?utf-8?B?aVJramtmd09rMDhhTlJtZlNZRzdZdXJyZlZmTnNTd0JHclAzd3cxSy9EQW81?=
 =?utf-8?B?VUNzcmUzdlo5WmVxNFFGblpNREdUdlpEdGkzdWgrbkdWZCt2bFhPQStFUVJw?=
 =?utf-8?B?cGFKRlVJakF3aURQTWR1ZUNLMGU1RDlyWlZ6Ly9IZ0t2YnVmVmRLOVFQNWM0?=
 =?utf-8?B?bnFuOERPQWU0YzFobEQrUDJESTFyRTN0S2NYd0NXQlkxNUpkUk9laFozQVZo?=
 =?utf-8?B?N1lsMHpwNEhwWCtCRG5uVXNIenN0UU5lQkdqYjA5NktYOHV1NE1kUytBaFNk?=
 =?utf-8?B?NVFVckpTclB0djk4eEJHV01qK0o0aDQ2VTdiallTeldDUi9IdkU2TGNDcklY?=
 =?utf-8?B?RGtrM3RCd1NzSEN1Tkc0ZzRvQVpRUmxWdm1sS2RyVE5qbytoK3JwbGhkSWsx?=
 =?utf-8?B?bVhPZjFyeFg4SkVOUHpXengyUStRZEJvOC9FY2xiWDJIUmluTDltVTVtNE9D?=
 =?utf-8?B?aE80dFNjS05tUWdZL3lPUGIrOXpGRU52cStybVdFODdVV3ZWSi8wcFJ5bEdh?=
 =?utf-8?B?T2lJMmwwUUo3N25YRUZsc2ROUFFPdm03aXY4Vzc4amtoWWRITzhLUDV6SlEv?=
 =?utf-8?B?OXkzdmRaSDFWcEd1VGNLaEZ0MGJldmhPSjY2SFlzbFovU3BaU3pFaXcxbkhi?=
 =?utf-8?B?ZEQrRWYxazAyZnlEVm5Qa2ZNeWxoYVY1TE5ObGVyV1VPdWQ4TTI5MDNrdXUx?=
 =?utf-8?B?QVphN282eGtqaCtwQWhsUlJWM2NnWlVkMEgzd0NLTTBiVzRCSFhrMFZqaUtv?=
 =?utf-8?B?R3hDMVBoVHFmRWZ0Y2lLNUd4YXIwME9NWkxqZUdTSzlCbS9qcDZmTm84YzdW?=
 =?utf-8?B?YlFJSUhEaUM3VHlmKy9sa3o2RzY4Mis1TG55WFExRWZDanlMUkVPZVRuWlZP?=
 =?utf-8?B?eEdxSkRCdm9QT2xyS1NVUzlmY1RkM0pnSlB0aTUwN2ZyckYvSUJJcXlDTmpX?=
 =?utf-8?B?RmsrdmpkdGpSMHBLa1h0NTBoblJWaGNFRnBKc0k5TlZUbXV3OHhNTEsvT2Zw?=
 =?utf-8?B?U09wSXl5Ymc3RWI5S1dSVUxLWHNyYUt4RDFFTWVYaDE3NUl5MW91Zk8zeWk0?=
 =?utf-8?B?anRnTkxObk1oQ3o5Nmc2Q05vNTZOU01DZ1poVUh2cXR1RzlwTVE4czNKTUZz?=
 =?utf-8?B?ZVI5WWgzcUFHN2VWSE1XRVpGMGJ4N1hzYTNnMjhDYlE0QlJhTS9KbHBDdC9j?=
 =?utf-8?B?TnpLd1BvZVBPK2c4bUIyUWZLalgwYzVPTGgwekxLVkcycE9VMW9heXVudTd0?=
 =?utf-8?B?M1NpRnVaQUF0MmpBLzJneDlBby9kWlhKZldHaHNyKzNNNGpVZUFDRkRvSDl2?=
 =?utf-8?B?dm5JWTNGNGlvRHJyUU9GTGo5cTQwR1RKOG5JVzJWS0JPM2xicGZjTG5KTXQz?=
 =?utf-8?B?YTFUYmZtbWZUY2VCT3JHeVBDbURtZGdGV1d1dlJMTDYwTXNkY29VTm5aMUhy?=
 =?utf-8?B?cXZ4cjcyQmY1MTdUNFpqMmlOb2VFdnBUYUlhdy96WVNtRXhGWmsrTTVJVTI0?=
 =?utf-8?B?OG11WVpaZmNXcnZTaDdKeDQ5UEVuWVdZdnBpY0JXZjIwRlJKYitzWitGSUZW?=
 =?utf-8?B?Vmk2OUY0VzFsRjRtZGl2a3Uwa2JPYmF6eTBpamk4aG9tV3N6cThHU0NmVDJO?=
 =?utf-8?B?Mk1BcnFrOG01T2pyNmVGMGdsT0ZOcC9vL05Db3N0TWRRdHp1RDVFRHZSUEZh?=
 =?utf-8?B?bzVrRVM2VEV4VjhrSStScGhhaFlCSS9xc2hlanN1VnFMcTJ4MUVqNDhhbW5P?=
 =?utf-8?B?VmgxRlljWFhDeUMyOVJOMDByMXR0cUFDOW5DV0VNK2RPOW1ZQkpYbHhFWkxF?=
 =?utf-8?B?L21GZkUxalgvbUU5V00xZklFY0JkUy81ZUJaNmpOMXVGMmlTaXpqOG5aWUVL?=
 =?utf-8?B?WUFtYVpxMzdUYU1rUUJrS3VEUldKeGRTNFM0Q2xXL0J4Rk54dkdrMSs5VG1Z?=
 =?utf-8?B?bi8rMHh4SGxtajV4MjEyZW9BeERvbTJpczdjOEVRaDN4Z2xqaGJMNUtEU2Fv?=
 =?utf-8?B?RTlwaW1obEtNdzFOODZnNUlMbWZBTCtkaVBXQkdmUU9KeGoyQVF0UXNYb1pm?=
 =?utf-8?Q?41TI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4395304b-ebd9-4c71-0532-08dc34a71a30
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:39:08.4859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrZI+qFMSFQDliXcccvg/sG4DxihbJYH2Lqy60ep4weeEeHzOcbG65E1y+CDyRQG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315

Hi Ilpo,

On 2/23/24 04:56, Ilpo Järvinen wrote:
> On Thu, 22 Feb 2024, Babu Moger wrote:
> 
>> Older systems do not support UMC (Unified Memory Controller) perf counters.
>> Skip the tests if the system does not support UMC counters.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  tools/testing/selftests/resctrl/resctrl.h       |  1 +
>>  tools/testing/selftests/resctrl/resctrl_tests.c | 10 ++++++++++
>>  tools/testing/selftests/resctrl/resctrl_val.c   |  4 ++--
>>  3 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index a33f414f6019..5c2556af0649 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -116,5 +116,6 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
>>  		    size_t cache_span, unsigned long max_diff,
>>  		    unsigned long max_diff_percent, unsigned long num_of_runs,
>>  		    bool platform, bool cmt);
>> +int get_number_of_mem_ctrls(void);
>>  
>>  #endif /* RESCTRL_H */
>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>> index 231233b8d354..5423882529ec 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>> @@ -98,6 +98,11 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
>>  
>>  	ksft_print_msg("Starting MBM BW change ...\n");
>>  
>> +	if (get_number_of_mem_ctrls() < 0) {
>> +		ksft_test_result_skip("Unable find iMC/UMC counters!\n");
>> +		return;
>> +	}
>> +
>>  	if (test_prepare()) {
>>  		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
>>  		return;
>> @@ -124,6 +129,11 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>>  
>>  	ksft_print_msg("Starting MBA Schemata change ...\n");
>>  
>> +	if (get_number_of_mem_ctrls() < 0) {
>> +		ksft_test_result_skip("Unable find iMC/UMC counters!\n");
>> +		return;
>> +	}
>> +
>>  	if (test_prepare()) {
>>  		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
>>  		return;
> 
> This also needs rebasing and adaptation to the generic test framework.

Looks like I need to wait for your patches to merge first.
Thanks
Babu Moger

