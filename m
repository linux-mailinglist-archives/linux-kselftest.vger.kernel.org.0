Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4597C6453
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 07:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjJLFFD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 01:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJLFFC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 01:05:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011B890;
        Wed, 11 Oct 2023 22:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMHTzrTfWwsIHaMxQZ2MvAZc4aItkbClwEWF+X7DntT2k7EOSu0puwCqiEkmVBj/Hrz1o6hInwJrAgvQdroiPSHqDy+3SgkuSdf7J98ozOvDIQJpPING4qZdf1+jeWn+aRTBi7CiOxZEe6+57rcu2IYspGiLNPK5EJ3f+v1l73CwWWdXwHkXJNrFQpJbdkJTuf8uJhj3K6KUYqHdjSOo8gWydX6viexAsRFGqnknXlN8z07vId9trBOtStrxNyNpjNyCRdCGSZcnOZcFeT7+IZyGcMDzLaT6HU7plGfPiI7NNV3cIu1avwTN4yjG/0TqMdV9CHjpkwvyITOKZjwtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVYHf2twcBJh65WAu0x2OWgWkBgkUdvbSHlb/lwKn8w=;
 b=OgpnK3bGFk+frUpGvnuD8skNCmW/SDc1POuK95s/GuB7nbl6Im2XfYZCT7SIwDttQq2rWvPirCIKnFJwmQ3peVQgnMrWm2cgLroTxqkaxk1Pql/ADNiXW9hPsfqdfBXKX28RXrO5x3ptcZa3UzzeAN2sIRkkK7EmxGzuDOgZfBfZYbb47WVAex7DFwyu+WNQ0wxfN7ugq5l9Lp819oBF9RxKjbSueP9uU8hri66MvQ15bNCJRtEkRdlTp9/fRJphxnSOOW3TGmAJtyyxIZWPBjLTIMWS/hT20cpnBvJJv+qkMmOUugU2YIUqVGMgeoc63NLQJzbbOxDM+hrOXOfAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVYHf2twcBJh65WAu0x2OWgWkBgkUdvbSHlb/lwKn8w=;
 b=ApPH3Ryq29ceU6Dvid3ilNqIvJI7wXR5aMkGKSedaY00qAoyNbjVopRUxN9JBwRr0EvgR83Wg/Z6p+5Mxx5r4oS4LHg0C/gwk2Osat9cF5K1clg/j2ABN5lczGZaGxE1U4lUapPCWSsswrW3Tsg4MLalVZyST4eRYdC5zdlbMJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 05:04:57 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::495c:3afa:1762:efd5]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::495c:3afa:1762:efd5%4]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 05:04:57 +0000
Message-ID: <c780c60d-0957-0931-ef01-f940899f59c9@amd.com>
Date:   Thu, 12 Oct 2023 10:34:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/2] selftests/amd-pstate: Added option to provide perf
 binary path
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>, ray.huang@amd.com,
        shuah@kernel.org
Cc:     sukrut.bellary@gmail.com, li.meng@amd.com, gautham.shenoy@amd.com,
        wyes.karny@amd.com, Perry.Yuan@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20231003051006.6343-1-swapnil.sapkal@amd.com>
 <20231003051006.6343-3-swapnil.sapkal@amd.com>
 <33271bcf-66fd-42e9-9b19-0c1547814f38@amd.com>
From:   Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <33271bcf-66fd-42e9-9b19-0c1547814f38@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0234.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::6) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: c31c2146-7fb3-4fdb-a008-08dbcae0c761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcXnbDvoP09gdXN3ZgylpBXDJd5+PTaRg5jFnhAzwQurUDgAIJCz+srCi4naiLR1Ul0zlGf/GwM2QR/3YTeEEbYXD8bZ48/265qE/qRCGvAaW0GS6/i1My2/k/gohs4/nL7uzXuEV+TfpAu+atxSDGykvHIqIjfSiJvqnaumm6HtT74SGAS7/FqjBya4MBGDAU8ViJiqIkCblPItmk0J4ti9KpBYvPMx77n4tKIJmzEanjI5It82CAd15ygkPk0F4Q8R7zYKyR2Dm4O8VnX2enp4iGkAEHZHMN28UIgmN0/3aT4+Vf9aAcNrcK0/V6YHZKgjiXNLFcR6BUjSeICiV9rDjqp778HRnKfiaUPDKBJoHSQUNLh3Dp44ckb+Ded37jlnPKIF7wRZey1aB+8g51w9rBnNbknfV480Zc4Ra6388S3EdH6TtfHHDLxwD1c3PzyJuiCsKAvOGrv7uLjEIRYdAeJlHNVDDymXOy1yEv/UNXL00pcviXqlvi7jzWuWpVvNJxapJJTku2mcCS3JMB9Teppv3INP4u+gfVWJtDGwcoBOmqJi/R6oL0jGBy9GXgXg9NghdbQuHBfIfg61c+o7iEeefwEvy8mptCLtiHza36uze5dCsXhtZWCJq7M1XNFL8t6qEfvJMPwIiutU9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(5660300002)(41300700001)(4326008)(8936002)(8676002)(31696002)(86362001)(2906002)(478600001)(53546011)(6512007)(6506007)(6666004)(31686004)(83380400001)(36756003)(2616005)(26005)(316002)(66556008)(66476007)(66946007)(38100700002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk5wcHBFT3FxNFBJV1NBREhPTVRwaFpFSWtjZlNTSnNmZ24ydmlXZ01STnow?=
 =?utf-8?B?RXIzVVB6ajczVGw5ZjNNdDJuL2MwY01yS2RIU1o1UVpTQUY0ZTd0SkgyblFa?=
 =?utf-8?B?NVNIZVowS1czSThZVnROck5aSE5tZGJBNDFFd1pRdDFTVTZEN0JOdDVLcmFV?=
 =?utf-8?B?cjRXNmlYLzF4MEhJVHhOY3RFRlBMVS8remVHR09nYkVpSEcyV1ZzNTUwK0Rw?=
 =?utf-8?B?dmNaS0RtSERaRzhXNThFeWZrTXVPU2QvNm1hRkw4TTRHKzRiS0lWb0dsaEJG?=
 =?utf-8?B?ZjcvZTYrTWhuWGVmREE1WkpHYkZYaXZHcU0zeE9hRHpDbE53UkJjc3I5UTIx?=
 =?utf-8?B?dUs2YUs2T2VWait5Q2pFS091SElEWjBuajFVY0pZRFNUYjVjWU1MeTlwSjZY?=
 =?utf-8?B?bmlDcGVRSG8ydkV1VG9aMmRhV1RCbjcyZ21IRXArU2tYU25kTW1MdUU0dDBx?=
 =?utf-8?B?Zk5kbW1BaGQ4OGNUWmI2ckwzbk1ybzRyZ1JnUDZkMUJJVVQ3dDU4WXRIR0la?=
 =?utf-8?B?MzNLSjVoKzcwY1FBT1VUdFozdnJDcGZHckNtNERkOUVyTDFLaTZZTXdOVEE2?=
 =?utf-8?B?WGkyMXRYNHJWSlhBS1pSMU9Tc2lqelB0ZEI4cjJpdTZxcURJSFRhclljSXFO?=
 =?utf-8?B?NlJzS3hvMnVqVEc0elpSNlZRb01XN1pIdU5qcjBObnRTN2hndDFBSXJsSkRr?=
 =?utf-8?B?TEhkQldEUkdlYUh4cFZ1M1RXWkp1SDVMdXdIR2FqWDNLMGliK2VKTE1OU3JR?=
 =?utf-8?B?b1hKckErQU1QSWZySmlhaFlKQStmQ2VEUHowdG9kc1ZxSEhyczFxU1kyMTdP?=
 =?utf-8?B?T2UyQ2dueG14SmptU2NTZEc0N1ZXN0xiaFlwR0FvSkNzTjZ5Um1vY2Vrajhm?=
 =?utf-8?B?QzdmRk43ay9DNkFKRUlwMU1JekhpcVpNSzhISFM2aFhBazROSEM4c2swZ1hK?=
 =?utf-8?B?Q0dQeHVSMFNzTWFVWjZtamxvY2VJVFZDREtLaVdlcDlxTThmUTJXWVZENHJV?=
 =?utf-8?B?YUtRRjEyc2RYMU1hYWdVdVRKMFo2K0ZVd3YrSzl2WWFzSUljK0ErcHoyQ1V6?=
 =?utf-8?B?TU1iWE5XRitpZzlzR3hMaDFpOFZUUXIzbURwaXBER0F6bmJDSlNMWWpJdytY?=
 =?utf-8?B?NHYrU1cyQzVRK0xtaUlia01KWXAyWHoxRVJWNUdJRHdWUFI4dHZzOWJmV2dX?=
 =?utf-8?B?WGduams0UjJVeDJSa3ZpbE1BWGRVVmQvMWtPRFFOVkZTdWVxYWNPZ1ZTczZK?=
 =?utf-8?B?eDlJUFdrSk93U09VVFhGZ1E5SmZ2dXpySjNzcnFDTjUxVFIrbUplYUc0YWo0?=
 =?utf-8?B?RTc5amZjQWRuYTNSOEhMSzVxbG9vbFduZ1pObXl6MnRDSDA0cDhvanBFemho?=
 =?utf-8?B?N2R3VFVUeHdXTDQ5VmozK1VoTUVBWWZkSThyaFJYb3V4Y3kwQlA0NDFtUmxY?=
 =?utf-8?B?cjJGM294R3FFSHpzUytwTGVaM0VvSHJZRFplWDV3WVRjLzNxbGd5a1ZYU2Q5?=
 =?utf-8?B?TVIrMlQ3dmgza1l4TFFVSTd4YlRJZEJoZDg4QTMwQ3BQS1VUN2loanNyUlow?=
 =?utf-8?B?RkV5eWtxa0l4UXBSRjgxL1JxTXVuR3JzK1UyWFRPV0RxaEMxb1ptTmdyQ3cw?=
 =?utf-8?B?Y3cwVUVRY3U2WU1UcW93UWNsS0FRODVOYzBKRThPQ2ZDUXBNWCsrK2pRQUZ2?=
 =?utf-8?B?dy9CT1VreUlRdEEralR0VXRrK1V2Q3drS2luaC8wdU9zTEJqK0RkN251a3Nt?=
 =?utf-8?B?bnZuUDB3RVZnaUwwWFh4dHN2UHh3MXNFWExNUGpXNVRYK2tDTkpWamoyT0l5?=
 =?utf-8?B?V3REVDRFcnpGbVpuK0JUMXdtNFJsdTkyWWpnYWd4dU0ySzNnNUNUeW04NXFU?=
 =?utf-8?B?M2tkaWtrK1hTem93ZXhGOEpkVjVFV0lCQ29GWUZWS2ViY1R5My9FVUoxZ0l2?=
 =?utf-8?B?UGVpbm5iQUdleG9Jd0FBOEsvZlU3R1UydVhKajFFbXJXbWUvS252emdBS0h3?=
 =?utf-8?B?SzNkM1FhcGVZMjVaM3hlZFRRVmdHZUMySUsvaGJXczFnN1lqenV3NDJGdmNu?=
 =?utf-8?B?ZzNuaDFiRDdTN3gzc0Z6VWtQVWVHT3ppWURNcnIxTU0yS3RGK0hmczdQVXk2?=
 =?utf-8?Q?d3ysqu+6FAE27qKsn6Q/uVteL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31c2146-7fb3-4fdb-a008-08dbcae0c761
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 05:04:57.2760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9f0tWF7VWSA7xhVf/gSVgKTgfBqyg6Gqei+ISauhKfGkN1vfP0UwY0SKgkn8SW+/F/ItqldKMPLOwE1KGiuhsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Mario,

On 10/7/2023 12:29 AM, Mario Limonciello wrote:
> On 10/3/2023 00:10, Swapnil Sapkal wrote:
>> In selftests/amd-pstate, distro `perf` is used to capture `perf stat`
>> while running microbenchmarks. Distro `perf` is not working with
>> upstream kernel. Fixed this by providing an option to give the perf
>> binary path.
>>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
> 
> One small nit, otherwise:
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
I will include the tag in next version.

>>   tools/testing/selftests/amd-pstate/gitsource.sh |  2 +-
>>   tools/testing/selftests/amd-pstate/run.sh       | 14 ++++++++++----
>>   tools/testing/selftests/amd-pstate/tbench.sh    |  2 +-
>>   3 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
>> index d0ad2ed5ba9d..5acc065e9e3e 100755
>> --- a/tools/testing/selftests/amd-pstate/gitsource.sh
>> +++ b/tools/testing/selftests/amd-pstate/gitsource.sh
>> @@ -87,7 +87,7 @@ run_gitsource()
>>       printf "Make and test gitsource for $1 #$2 make_cpus: $MAKE_CPUS\n"
>>       BACKUP_DIR=$(pwd)
>>       cd $SCRIPTDIR/$git_name
>> -    perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o $BACKUP_DIR/$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > $BACKUP_DIR/$OUTFILE_GIT-perf-$1-$2.log 2>&1
>> +    $PERF stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o $BACKUP_DIR/$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > $BACKUP_DIR/$OUTFILE_GIT-perf-$1-$2.log 2>&1
>>       cd $BACKUP_DIR
>>       for job in `jobs -p`
>> diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
>> index 279d073c5728..b87cdc5bfe4a 100755
>> --- a/tools/testing/selftests/amd-pstate/run.sh
>> +++ b/tools/testing/selftests/amd-pstate/run.sh
>> @@ -25,6 +25,7 @@ OUTFILE=selftest
>>   OUTFILE_TBENCH="$OUTFILE.tbench"
>>   OUTFILE_GIT="$OUTFILE.gitsource"
>> +PERF=/usr/bin/perf
>>   SYSFS=
>>   CPUROOT=
>>   CPUFREQROOT=
>> @@ -152,8 +153,9 @@ help()
>>            gitsource: Gitsource testing.>]
>>       [-t <tbench time limit>]
>>       [-p <tbench process number>]
>> -    [-l <loop times for tbench>]
>> +    [-l <loop times for tbench/gitsource>]
> 
> This looks like unrelated change.

I will remove this change.
> 
>>       [-i <amd tracer interval>]
>> +    [-b <perf binary>]
>>       [-m <comparative test: acpi-cpufreq>]
>>       \n"
>>       exit 2
>> @@ -161,7 +163,7 @@ help()
>>   parse_arguments()
>>   {
>> -    while getopts ho:c:t:p:l:i:m: arg
>> +    while getopts ho:c:t:p:l:i:b:m: arg
>>       do
>>           case $arg in
>>               h) # --help
>> @@ -192,6 +194,10 @@ parse_arguments()
>>                   TRACER_INTERVAL=$OPTARG
>>                   ;;
>> +            b) # --perf-binary
>> +                PERF=`realpath $OPTARG`
>> +                ;;
>> +
>>               m) # --comparative-test
>>                   COMPARATIVE_TEST=$OPTARG
>>                   ;;
>> @@ -205,8 +211,8 @@ parse_arguments()
>>   command_perf()
>>   {
>> -    if ! command -v perf > /dev/null; then
>> -        echo $msg please install perf. >&2
>> +    if ! $PERF -v; then
>> +        echo $msg please install perf or provide perf binary path as argument >&2
>>           exit $ksft_skip
>>       fi
>>   }
>> diff --git a/tools/testing/selftests/amd-pstate/tbench.sh b/tools/testing/selftests/amd-pstate/tbench.sh
>> index 4d2e8ce2da3b..2a98d9c9202e 100755
>> --- a/tools/testing/selftests/amd-pstate/tbench.sh
>> +++ b/tools/testing/selftests/amd-pstate/tbench.sh
>> @@ -68,7 +68,7 @@ run_tbench()
>>       printf "Test tbench for $1 #$2 time_limit: $TIME_LIMIT procs_num: $PROCESS_NUM\n"
>>       tbench_srv > /dev/null 2>&1 &
>> -    perf stat -a --per-socket -I 1000 -e power/energy-pkg/ tbench -t $TIME_LIMIT $PROCESS_NUM > $OUTFILE_TBENCH-perf-$1-$2.log 2>&1
>> +    $PERF stat -a --per-socket -I 1000 -e power/energy-pkg/ tbench -t $TIME_LIMIT $PROCESS_NUM > $OUTFILE_TBENCH-perf-$1-$2.log 2>&1
>>       pid=`pidof tbench_srv`
>>       kill $pid
> 
--
Thanks and Regards,
Swapnil
