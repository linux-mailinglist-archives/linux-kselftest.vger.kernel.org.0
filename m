Return-Path: <linux-kselftest+bounces-33497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC57CAC0742
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 10:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22F787B7B16
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323CA26A0D6;
	Thu, 22 May 2025 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZcYgRtk7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911C7269D1B;
	Thu, 22 May 2025 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903048; cv=fail; b=EM7+JgJIe0qAEOotuz0ksdJgbF/ZfsDpkTXot4tCbDP9APQMWhGjeH9IbMtc98j5EIatRtTewCU1+N9BURvSGhr97wyirtWz0JjEVgtEIosYZ/OgvRCCFWrRED70L935Vbr18uv0+IkvDlgJBUUptnP57GIyDvBjB24LUdOLzKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903048; c=relaxed/simple;
	bh=iQRcpPbNodHSFoSugFmmpo9uAoV7Lp2cao492WOrtps=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ep/usY4Mt5MTwiGN4L3hCInA1ScPk4gIKKzwKhmaayQ5+aDldH+8yVDiBBWDd8zXXPPyy8o7GyzRCmlHp9Zkg1AscWA1BsEMruT275Ccyi5U5FXJCFYoVHjbpfotGOUzQxw0Q+oUfbEM4AisGArB4c7h5A/vzpcjaIjVJrtA+X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZcYgRtk7; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/uiQ9hgUn0uwcfSDnEpKL+tipt1RjlDdOxNvz09+iwKc1aodnehMiExieD02ko2foeS2RMCeFjtdgAoCP+y5egMhkTh3O4WGOkyTuGlTitROQFe2U2pYNZd1re4faFUdPvwXAkH1SxYfMTbFbO4s2q+9gQYHC+tzZL6KkQECsehAjUbVKIgojlnbbETI9x1EICPqz3g3weEPptnerFVKHpLVXIs9XrZyndKGW9ANMn6rQGyKU73atIs1wlCmWnl4ZpwzbAqm4TdQ7PK7UBBUoP5/6Mb4p+NsSYRcKLs6MLOoQ2NbUAEesT6g5yh4UN0cEzONbZ0yFnMhkiW4RFUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O9oy36g3JGmz4VpP/hX9S121errp4ZyvLKjzOfZgKs=;
 b=kY9ajLPjd2vAZ7wSfi1DhapXvxEnx1/C4gK7gdc1TpXLdDiHzOJY58bjwqfv29RWr0AbRqA6FcgnzETQuWss7uWllD7I0rFeCoFGdw/2Y/8f0mIBcBdl5INW7zZHWixxK1WPqdJ2pTuB0bu7lg8Ye2nEf/VaY9PYQyA27IRz8Dc90gNcPEaZ5qwz5mgYOhmcPOEAqQMw4HkmlpTQE3ig+0+TQU8DSQD7t0K0NMUULl3TlttnSwzTcdssiE776FWluscKjmgSvAUuCRbKqOdR4vlsVReqmRRrGVZnnMmcelSULjDA1FEcSK1MCsHCBOLsrQM+FX6PEZCiMmgQ+oER9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2O9oy36g3JGmz4VpP/hX9S121errp4ZyvLKjzOfZgKs=;
 b=ZcYgRtk7IKmATwa1irjwF5doDeyD103vlFM+MFBGtJwtUIH0PTZxgVmjFtzKTf3VN417MRU9bpbCx+WA7JMW6p2ER3mrKoFI3uhM10cWXEuyCgciOz9XJCtZjjXesRa7DKyQBuiAX3i1Lrwx+VLEYJSLUjG9R/nv5So9sd1L8Lg=
Received: from MN2PR02CA0015.namprd02.prod.outlook.com (2603:10b6:208:fc::28)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 22 May
 2025 08:37:22 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:fc:cafe::79) by MN2PR02CA0015.outlook.office365.com
 (2603:10b6:208:fc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 22 May 2025 08:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 08:37:21 +0000
Received: from [10.85.43.148] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 03:37:15 -0500
Message-ID: <8a2149ca-a0fe-4b40-8fd4-61a5bf57c8b6@amd.com>
Date: Thu, 22 May 2025 14:07:12 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/cpufreq: Fix cpufreq basic read and update
 testcases
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <shuah@kernel.org>, <gautham.shenoy@amd.com>,
	<narasimhan.v@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250430171433.10866-1-swapnil.sapkal@amd.com>
 <20250519075854.opnlhjlbybrkvd2k@vireshk-i7>
Content-Language: en-US
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <20250519075854.opnlhjlbybrkvd2k@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 176cf0d1-67f1-46d9-dd8c-08dd990bdeb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHh0bEtQVkZzdWNkVkp6OTVsQ2o5ei9jUEtCTnk3ZmMwaHpiSEc5S3pFYzhw?=
 =?utf-8?B?TWpwUkh6OGZXZ29kQXFydFVWaWlUN3NxZTJwREllYUNXeVZ1aFJnUE9NUnh0?=
 =?utf-8?B?c3B2b3h4UGY2MmVjejlaN01TOGpOdHpDSE0zckNFNkFUaDJKc2VCekJONVpo?=
 =?utf-8?B?OXNtNm9ZTnBNamhXN0FFMkFaQlZEUFpNSXN4UnpuaXM1UWp0WHpkWlV0Yk03?=
 =?utf-8?B?Y2lHOHZNV2RWcHMvM0VHY04yZ2lLb04rT2FjZTlSd0xieTRWTnY5QWYwT1JL?=
 =?utf-8?B?WTVQbTBlRWRCOGhBTTRhYkNTUjYyR3dtZHFpaVdIRVQ3RElsMWtDQlVQMTgw?=
 =?utf-8?B?cmpWN1Zoc1o1ZFNKdTBFSTMxSHJ0KzI4Yk9vK2gzZmV4UTJzQUI3MXN0TURV?=
 =?utf-8?B?b09MbG5Pd2xVdVZGUEVlSW0yR3cvUkZmUkliKys1ZEhkUzdsNGVZbGV0NVNP?=
 =?utf-8?B?RTFtbm04YnBpYW5Ya2xDTWFqU0liUFI3QklCTUxtNEIvam9RM0xlcFRwazdY?=
 =?utf-8?B?a2QzdWxPOXJDZWI2a2k2UzU1aW82OUxMRTdIdG5ZVEM4aHI4NUtnaXlIWVRR?=
 =?utf-8?B?R3FZcVpZd015OVpkbkdiL3hmbTE4RVJwS0NUL2xiSWI1dFo3WTRsVjBqcVpt?=
 =?utf-8?B?b0xaYWpQOCtxN2c0bk1UekM0Uko2dzU4SmZrVzVpUms5enlLRjBITnkybkdS?=
 =?utf-8?B?MkVUWjlnMFVPWm43c1JLTUwzb0VaWFR2RFpteitPS1AweXZEZytOTWkwSXBo?=
 =?utf-8?B?My9vUjVoVTZqU3A0NlBBdGIzUFJ5YWRnWVJsMjhtdWZBdkxWakIvNFc0UkdI?=
 =?utf-8?B?dlM2VmVSNHVENXRzVWl6cERTTzJqbmtUeTRsQ2h4TE1zUTVaRDZGa3Z4bGpz?=
 =?utf-8?B?SFFoc0lJN2JONVgwMXdvdUkzdmFtUk9FMm50U1VuZm0vamZUalZhQnV2OHEw?=
 =?utf-8?B?VnFwWjlJM0gwMmlxZGx4aG9VNi9WcS9wVzB1SWVsUDZSelpMTUxEQVlqQjd6?=
 =?utf-8?B?VGdqVmhlcEgrMmxuSUQyTGNOME5qYlM4UFcrRVowYlM3KytxM0hKUFJtUFRk?=
 =?utf-8?B?RnZrZVlLRzhJdm96T0Z2S0tXWFJ4WmtmOU9NZGlZRXNabVM4dDhsSzNSQ1VQ?=
 =?utf-8?B?Z0xqN2xKUlA1c1AwblY2MkJEZW5zOGsrUXovRnBZbnBYSjM2UzZudGt0bjc5?=
 =?utf-8?B?M2lyTm5tUmhTZlJLSytGKysxTlJ4cTVBMXl1STBWcGl3NUtQT0RONklKc3Jt?=
 =?utf-8?B?VWZ2Yit3RkFySVpoR3BCb05sTmZXM25ZVU16V09LdmVHdlRkcUpBRVkrMjV3?=
 =?utf-8?B?bUx2alhNd0ljRFlNM2NrdHVjQXRPdmVITi9FWXN0ZjlNYTVaNlNUVzdPa1NB?=
 =?utf-8?B?L3ZBK0pEOG14ZGZRd2c5cmo0WTNrS05PNkIwcGRZbjRTYUpWaWxuODRIR1lP?=
 =?utf-8?B?bDBybGUzTVJTUGRlVGtLK1h4Ly83WUsraHBBNmExK2xIbXVnYWZJNC8xN2FU?=
 =?utf-8?B?NzNwVWZmS3RaUmZJcy9rZnU5VGtVazBmTlEzbUF0MmxlQWVWUUtqMzRLVkpZ?=
 =?utf-8?B?dTJGUVo2OU45NDlQOVd0R1NrQVlQSGkzczRZTnYyWnZkVEtHMW1ENnBwb1d3?=
 =?utf-8?B?czFLNFltMnRZRjZ6dzgwMVl6QmYvTlpHOUZpWDgxRzkvbStXR2E0eW1EZEdL?=
 =?utf-8?B?eW1IRmROcnJyay9CTk9DQzRYNEVicU5hMkJRbEhYR1dBbVc4SzZQMEs0QVgx?=
 =?utf-8?B?OGs2NWJRVW8xT0U4SHpQZzE4RUM2dDB1WGVQL3NZQ01uREIvM3psQlhtUzVq?=
 =?utf-8?B?d2pNSlhHZUl6VXpIdGY4SjFKSHJuOFgwYXQyME9yS0JRRGtWd0ZZVzBhaVlO?=
 =?utf-8?B?MkRoc2RqMDZxcDBaSFJSempURVc5Yk4rSEw4SDNtSXdkM0hqTEVxS1ljTVBP?=
 =?utf-8?B?NzNQREFrOFJsVGtkLzNUUElkcVlEd29vaUhmU2RDYit1aHk3SHdKcHdGbTk0?=
 =?utf-8?B?cXI3bkVHQWVmNkRRQ3BmVi9wbmQ3cFl5cmxSKzhicEwwakw1MzVXMmNxRnpJ?=
 =?utf-8?Q?fzJhDn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 08:37:21.5992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 176cf0d1-67f1-46d9-dd8c-08dd990bdeb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738

Hi Viresh,

On 5/19/2025 1:28 PM, Viresh Kumar wrote:
> On 30-04-25, 17:14, Swapnil Sapkal wrote:
>> In cpufreq basic selftests, one of the testcases is to read all cpufreq
>> sysfs files and print the values. This testcase assumes all the cpufreq
>> sysfs files have read permissions. However certain cpufreq sysfs files
>> (eg. stats/reset) are write only files and this testcase errors out
>> when it is not able to read the file.
>> Similarily, there is one more testcase which reads the cpufreq sysfs
>> file data and write it back to same file. This testcase also errors out
>> for sysfs files without read permission.
>> Fix these testcases by adding proper read permission checks.
>>
>> Reported-by: Narasimhan V <narasimhan.v@amd.com>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>>   tools/testing/selftests/cpufreq/cpufreq.sh | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/selftests/cpufreq/cpufreq.sh
>> index e350c521b467..3484fa34e8d8 100755
>> --- a/tools/testing/selftests/cpufreq/cpufreq.sh
>> +++ b/tools/testing/selftests/cpufreq/cpufreq.sh
>> @@ -52,7 +52,14 @@ read_cpufreq_files_in_dir()
>>   	for file in $files; do
>>   		if [ -f $1/$file ]; then
>>   			printf "$file:"
>> -			cat $1/$file
>> +			#file is readable ?
>> +			local rfile=$(ls -l $1/$file | awk '$1 ~ /^.*r.*/ { print $NF; }')
>> +
>> +			if [ ! -z $rfile ]; then
>> +				cat $1/$file
>> +			else
>> +				printf "$file is not readable\n"
>> +			fi
> 
> What about:
> 
> if [ -r $1/$file ]; then
>      cat $1/$file
> else
>      printf "$file is not readable\n"
> fi
> 
> 

Initially I tried the same, but it does not work properly with the root user.

--
Thanks and Regards,
Swapnil

