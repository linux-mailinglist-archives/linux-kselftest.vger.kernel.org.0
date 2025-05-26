Return-Path: <linux-kselftest+bounces-33768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDF1AC3BED
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 10:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED372188A1D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 08:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CF01448D5;
	Mon, 26 May 2025 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N85KgYxk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDC318EAB;
	Mon, 26 May 2025 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249185; cv=fail; b=Nvu3Q/LRJpWs+KXKu3eJdcxrK6IIWPq+We+PT6r9RZ7rerW6iOXJeunaQlyja4vhlLwy/6mUZdKnD8hYsNMRJMXv5NUYiAPwfBGzIZ/1UDt14U+zhJJJAin8PCpTi28x/BGw7qjxYyNajmaMnr16HVr84lthC+XnBfd29uYYF2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249185; c=relaxed/simple;
	bh=BRgel/W9VQMHnFqHbKREZs9wEfCALEtT3hwNnMxkCkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nwroKNAGyr+512YA6T3VT5e6VLFRQn4Nhm4EAWtVsb3dohbx64RczQDFJ6f+lkkRbP8EqVW3UgPiUrDpT12SZ1QhJ7+ElHpUjwnpKiT4zpLoaCoidPtbZFfXgzEH1cIkX5pBL+5g3uU0yGjX6O23Sfz53uO0GrCrf5nhWjysy0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N85KgYxk; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwX98gs0plqW0Y46jySoyNbXY4uVZ3h1QTj3TwZ+3iMGAbHrZN5b0MbL2cQ5HjpNcpfeqytNnAzgpuJQa3Y9zJQG0MCUnWAdnfl3UZ22cLsLnDqeUOeMHifvecvisjeuk2mnEKDKH4FMGEsRvGWEYYmLYs/MFvOJakS6BpReroX1fdADApG1mKeSfx8TIJnW1iRXmdUMfN36TlZOioc9IrIQyvG2pmSf/gq+A4P/caeoFcjjULmlJoSqfV7LqPNJDVcdSyOZHBDUuZhEBmSt92gzoHEPaEQIYbkakN5nGsq6/t5i4yBAWRrS+H2FCxEZJ9j5szdeOVyoN4c4PjG5tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlKVHVZuC4z4mhYI5T8OtaRvFfwS7DZhGC8KA5lC/ok=;
 b=e66hb38Fobk11oG7QvObp2jmozTSYvTDSV/CzEwwV2q2oBCijihOCJ5BsV+0XqQirbwyE4k96M3ut8Zja/CuAjxd3sB/YIUOU98G1TqeDORXTW0PsR2XfE5cmKnZ1x58E7mEWUmMKwpXrFN5ROs7KCdBQyW/bBwHWzA1D59xVpZaMkMGn7hL2mOEkmUWyMi/kf1uASAycdbxFgwo+4y0vTiglKzCmxf5HE/mqmVfBLx02qgWxk5/9Tu58hpgreYCnslBSGq0pHwWDM+SKLs4ztWtb2M4FiOO7oZ0eBDxv5z/0IuEYNyr7XjzvhZj8dYPzUNwuUvBEgLd6E74RMOrfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlKVHVZuC4z4mhYI5T8OtaRvFfwS7DZhGC8KA5lC/ok=;
 b=N85KgYxkQevmg/bAO+NJ5oUgPMQk9PMmJE7yx/qhqr/lntbEfGmjkiCB3sdAf+FHZfJWFkKZdFA7a+rjXp/B9ozxAHmMKYpIAuptjgPPn/qMoxyjUSSAFtcxCNGO2gHcgfoNLe33qjRBjJgrYlwMm/0qI3lngVfjQIiq2gWqq1U=
Received: from MN2PR01CA0056.prod.exchangelabs.com (2603:10b6:208:23f::25) by
 MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.25; Mon, 26 May 2025 08:46:20 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::9a) by MN2PR01CA0056.outlook.office365.com
 (2603:10b6:208:23f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Mon,
 26 May 2025 08:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 26 May 2025 08:46:19 +0000
Received: from [10.252.216.136] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 May
 2025 03:46:16 -0500
Message-ID: <e667198e-6940-4702-ac9c-7745f07dbf38@amd.com>
Date: Mon, 26 May 2025 14:16:13 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/cpufreq: Fix cpufreq basic read and update
 testcases
To: Shuah Khan <skhan@linuxfoundation.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <shuah@kernel.org>, <gautham.shenoy@amd.com>,
	<narasimhan.v@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250430171433.10866-1-swapnil.sapkal@amd.com>
 <20250519075854.opnlhjlbybrkvd2k@vireshk-i7>
 <2b7acb5f-65c7-4787-aac5-ebcec83c8ac0@linuxfoundation.org>
Content-Language: en-US
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <2b7acb5f-65c7-4787-aac5-ebcec83c8ac0@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 86278fc6-6c2c-4213-46f8-08dd9c31c933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFB2QVZnemZJOXM5ZHhIbmlqOEd5Z0hReVQ5b2UzdElXbTBvTkMwWmp4RGZ5?=
 =?utf-8?B?TTlXWkNNOGplcTh0U2MwVjVmSzJjWkpWQS9tRW5SN0x6QnBZT0RyR08vMXY3?=
 =?utf-8?B?VG1kL29wWjU5ZEFuaENqUlJoSm5lWVQ1TUg3djgvNHFCSWRqbGd5Q285Um1u?=
 =?utf-8?B?ak9UbC9nVHNPYkM5NDdYa1ZSYUQ1ZElxRDMrbGRVVWVjTFRkbU44Nm1DclhD?=
 =?utf-8?B?ZW1kVU1ZbDV0a1lrZGFOekZ2ekNlazNzZ0FNbS9DNS9hNG9DRHRsM2xBcVNx?=
 =?utf-8?B?VDZSbUFaT1lZYll5QTE4dDJ0WXp1N3ppWHdncUlFVXRWSjROUTFYa2oreWJU?=
 =?utf-8?B?YitWMmF5WHo1QW5qWDg5YWxDRWlQcGliR3lCWDUwN1I4TmdsUDlXeFpmZi9h?=
 =?utf-8?B?U0lZUXZoYkJtZ0RhQ0dwanhnWFhPR3l6WEhMZ1ROZnVJM055SnFIbjdKemVI?=
 =?utf-8?B?YnBJTzF5TW8wWFdpVEE5NXljeUFkUW5UNnc5eWNHT3oyVlNpN0czZVdHZXJZ?=
 =?utf-8?B?NGVDYmFRK0MvTjAwdWt6VEpLVVUvSE9JQXNnR1Z2YndSMzdwWlFSUENmTStj?=
 =?utf-8?B?dzVXVmZVZHh1ZE1jSHpCNmVUV2pkazA2QUYvaEFGRnI0ZmtLYjZ5a1BReXU5?=
 =?utf-8?B?YlF5NWFiYW5TZmlZOFhGVGRYbFR6cG42TVNzb3ZOTTJGRnlNczJIN3RwVXBY?=
 =?utf-8?B?YU9JSW1GaXJ3MjZua2tLd3p4LzlhZ1ByNVIzYUQ5SE44ZTBTSThrRnYzL2dx?=
 =?utf-8?B?Z3VSMVVmVGRkSitEcnRYdHN6b1VmNWpVTHNRaERKbDZ0OFdHTy9GY0JPNVVv?=
 =?utf-8?B?NGNMMmNuVU9SazlYaGNHdjJyQlBNRWppY2pTdTJuYWh2b0swWm96YmdtZXg5?=
 =?utf-8?B?ZmVYeGRYcGhFZjJtMFVOQ2huVXg4b3dpQ1dic1N3QXdkYzQ5eHAwVW1YdVVm?=
 =?utf-8?B?Y0I1TElpR2xZbEJWVTZjMVhHdDBxVzMwUUo2dDE0VVFZSVNVQzhEQ1BuZ011?=
 =?utf-8?B?QktFYzJ6dElVVG0rVm5oZVpsMlQvNnZzKy9QTnliTjRZVlNTTUZmbjE2a3VF?=
 =?utf-8?B?S1BWS1p5RnRnK2ZSNUxpMnlrcGxUcVlTOGpoaFB3bk1DeTkyZ2d0Qm5JbUlM?=
 =?utf-8?B?V0Fvam9XdEVmN0ZBbjEzWUVFK3FJd1ZXSS9VZlBhM1gzNnBjRWRIVFU0WURN?=
 =?utf-8?B?Q1ZObmlUMW4zdXgwYkdLZjM2ZEZhTTBHVklvcXdIeGZqblpsOVlIUUFtbUdW?=
 =?utf-8?B?emh1ZnBFOVgzR1lCNnJNSTFtVG93UERKYlo0Uk1Za2IyV0RPZ2VXRDMxT1l4?=
 =?utf-8?B?bGJSeDNpU2lSMjlGUHZ3cXZ3M3NHVDhVUjRPWWhicm5QYlpqZ2R6RTZyd2lS?=
 =?utf-8?B?aDh6RlJUeUxVYWprL2JhaFBqZVRxVkVQd2xkWXc1WWs5c2t0Ulo2K2ppdWR1?=
 =?utf-8?B?VFpsMHBCclRNWWZMSERlaUpqejFsYlg0bHBKaTJWREcvdWdlUmNaN3gvR29v?=
 =?utf-8?B?SSs1KzdnUWNWYTN2L3VhUTVkWGdTQTl6TzhJWFJYVGlwNC9XeEpmWTZ6a2ZJ?=
 =?utf-8?B?QzRYNm5KNzdvWHBieWdkWG43MUcxRXppZWsvTDhoWjBxajRqZ01mM0RuUzJp?=
 =?utf-8?B?c3k5MGZabS9aWXVjSEVwQ2l3b3B4aVJTb2s3bUNCMlhLVFJGUysrangvcEp3?=
 =?utf-8?B?bEhFSWJ4Yi95ZExVR3BZVnhzaXhoS3hwWVpHeitINUdrMFVsY1I2ZllYV2Zp?=
 =?utf-8?B?WktCblNKRXFYRHNnYXgzZG1CeC9EQ2JTbDQ1WWJuenZLYmI2ci9QemRFSGVY?=
 =?utf-8?B?UktOeElXVVl1M0hCb1VzQWZiRWtVWDd5cWVpYVVQZDEyUGlYY1V3M1pxVkFs?=
 =?utf-8?B?eGZHYVFDZm1Dc1laTTlzNVZJcnYreEpwN1AvMTRxL21OWXlDaXZ5VE0wVmMw?=
 =?utf-8?B?UkN4Vkt1SU8ySThkVCswclIzaUxxVmdPMDFxbitBeGZQQzRQK2JVbkJlZFVz?=
 =?utf-8?B?RE45aklaNzR2aWRvUXFtWTFFZlp1THg1RFBMZXdBcVNKRzA1SGJYays2K2pj?=
 =?utf-8?Q?NRbf7Y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 08:46:19.8949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86278fc6-6c2c-4213-46f8-08dd9c31c933
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426

Hi Shuah,

On 5/22/2025 8:47 PM, Shuah Khan wrote:
> On 5/19/25 01:58, Viresh Kumar wrote:
>> On 30-04-25, 17:14, Swapnil Sapkal wrote:
>>> In cpufreq basic selftests, one of the testcases is to read all cpufreq
>>> sysfs files and print the values. This testcase assumes all the cpufreq
>>> sysfs files have read permissions. However certain cpufreq sysfs files
>>> (eg. stats/reset) are write only files and this testcase errors out
>>> when it is not able to read the file.
>>> Similarily, there is one more testcase which reads the cpufreq sysfs
>>> file data and write it back to same file. This testcase also errors out
>>> for sysfs files without read permission.
>>> Fix these testcases by adding proper read permission checks.
> 
> Can you share how you ran the test?
> 

I ran the basic tests with the following command:

./main.sh -t basic

>>>
>>> Reported-by: Narasimhan V <narasimhan.v@amd.com>
>>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>>> ---
>>>   tools/testing/selftests/cpufreq/cpufreq.sh | 15 +++++++++++----
>>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/selftests/cpufreq/cpufreq.sh
>>> index e350c521b467..3484fa34e8d8 100755
>>> --- a/tools/testing/selftests/cpufreq/cpufreq.sh
>>> +++ b/tools/testing/selftests/cpufreq/cpufreq.sh
>>> @@ -52,7 +52,14 @@ read_cpufreq_files_in_dir()
>>>       for file in $files; do
>>>           if [ -f $1/$file ]; then
>>>               printf "$file:"
>>> -            cat $1/$file
>>> +            #file is readable ?
>>> +            local rfile=$(ls -l $1/$file | awk '$1 ~ /^.*r.*/ { print $NF; }')
>>> +
>>> +            if [ ! -z $rfile ]; then
>>> +                cat $1/$file
>>> +            else
>>> +                printf "$file is not readable\n"
>>> +            fi
>>
>> What about:
>>
>> if [ -r $1/$file ]; then
>>      cat $1/$file
>> else
>>      printf "$file is not readable\n"
>> fi
>>
>>
> 
> thanks,
> -- Shuah
--
Thanks and Regards,
Swapnil

