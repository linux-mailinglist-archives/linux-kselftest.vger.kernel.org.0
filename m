Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2831A7B2D35
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 09:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjI2HtV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Sep 2023 03:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjI2HtU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Sep 2023 03:49:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45D319F;
        Fri, 29 Sep 2023 00:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q94M+is7q3waojNwcQuWE2XeNChhs0GuC7BNl+0H6ujwbD3RILejKG3F88DL/Vjr6eOYfeF9qMMUqGc5pocWhBfY7rhU/r0cg6X++anChX/7J2chh3efBw6cTcpTZ9NLBcqBJe+6+5gjL5C5ZmdbHe354pzAUnnUNVbvFcSoafF8QC7nSt1ByMxTZRoR1ByAIWCt9FtUNM9q8Y9G9WGyTeldF9NgX35StF5SFGGih3JS5l//4iNAPuwO7tYIwExEkKDpdK+Vb4UGiZCStR0v9Z6c4ftYGxHx+1FryUahuFivkt+ZFj9pE1zSa9rOu7gbW7cD1PGEWiNTsDvbRc9quA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2RdSw+xQvJS0O0O4bMwI1IERweMkCzXhgqJmmk6V4Y=;
 b=jqIwjmEwUi7f4N2H5M/vPiGAudnrkhTe+m+8xU6Bmj2guIp6gvMIVLJobX/35EqJoYFRQbhBNCtI3TaTGpDDhSuxhZzwbIzFvPY0oMTh09PBXukl3HtUieeZ/Lh9VdbjdfP5+5poJC/XTp8W4eGqaU5yCcfLjRjoZVaVvJvN4vNSbQ+esDlGhAm9GFH5FcLfE0MXJ7stD4fhACPQQEIeWBk9gPhyzKnD1Z7lsTCeaahCLoR01yAogk1Q6eCyPOC/l6fFNc95eJtevktTE9tY8M8uzNFLuFdFp7bwXEHBXkGGKntycdFHJTvesMzVNCJAZMovsQ76/EI+Nmju1GkHYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2RdSw+xQvJS0O0O4bMwI1IERweMkCzXhgqJmmk6V4Y=;
 b=1t3r1rlmE+JI/08A50cGeRZpTeviPr8O2ijwBX80+ah2SDH6xVqjHQg9LsG9dZh/LgUH1R1/skva5d5nOdYxAYwFD1lvyyDWfVIKaU6uLqfVoc0idarNyKsPGjT4X7fZ2hizEbgPuHfdTgX7EPk/NnJCF0fQggUlgV3V0ygp1Es=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 DM6PR12MB4529.namprd12.prod.outlook.com (2603:10b6:5:2ab::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.26; Fri, 29 Sep 2023 07:49:11 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::495c:3afa:1762:efd5]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::495c:3afa:1762:efd5%4]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 07:49:11 +0000
Message-ID: <438bb1f9-8663-690b-6696-15233b0ef100@amd.com>
Date:   Fri, 29 Sep 2023 13:18:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] selftests/amd-pstate: Fix broken paths to run
 workloads in amd-pstate-ut
To:     Mario Limonciello <mario.limonciello@amd.com>, ray.huang@amd.com,
        shuah@kernel.org
Cc:     sukrut.bellary@gmail.com, li.meng@amd.com, gautham.shenoy@amd.com,
        wyes.karny@amd.com, Perry.Yuan@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230919103351.48681-1-swapnil.sapkal@amd.com>
 <2d5a83d8-2101-4c36-ac37-be0375b0067f@amd.com>
Content-Language: en-US
From:   Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <2d5a83d8-2101-4c36-ac37-be0375b0067f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::33) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|DM6PR12MB4529:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb92118-9b87-41ba-8e84-08dbc0c09136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0258XUeRSZzOnE3lzSDwQ2EnQReK7LflY/5GhB90U9iyxN7/0cGp7Ez06DkZduXnlKHOKbLF+Hbb5hfwfXCAKRN3zY/JEEs9UFoknc4ukrXU8sUywupjVLrewl+zcwOfwUYfDh2MqAasxmZ72pVndYJ1zJRviJlgJh9aaJM8OYTYEbs6TxExEODOrPX2WAt7cZD+R1gOYhNKAfV3sAOcjDtm8y5VZmNEC9zXXgEZWpGil4zsu6qcDQJxD3JO5fgNrR9nh6VSLw4SrLhnlhSioi6AlF40klHAos8U3CEVTjzDpcGLvXIK/4BxBuIcIa/+1SEYbPy4kv4sLpvW0WWmz+85IkzDByXQ4goSLefs11fULuWtQvTh9llmwH0AEV4G8pEFR1jjWNMWaI37xUW2L1dI9n8Avf199vvZTfFyRcAb8vmGIjKbpmlpXFmGpZ3E+jYhjoqNbaCPAB8bK3rMRrxB4eBgjz6R38R6Cp7tocqO74lX6XYZ2wjoZrimhT9EUHKAg5hhAvpQBIrRPSYTTd6qnJ2HbMpoKCilbQDkhRvUjtemOlOatfsVYV7I6EzenCLLBd+N8t/B9nXP2z9Z9rVDNsPrOzjMdbs+sxtzjgI5jZThNpW0Pbjlh3riDA9paEQdt1YZPTmVb1rz17svg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(5660300002)(31686004)(8936002)(4326008)(8676002)(26005)(36756003)(2616005)(41300700001)(66556008)(66946007)(66476007)(316002)(53546011)(6506007)(6666004)(83380400001)(6486002)(478600001)(6512007)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWVwYkxwdDZQVjlXS1o4NFZsOUp3WXNMd2Z3R0Ixc3kyN1haa1FnL2NDRlF1?=
 =?utf-8?B?SS9tMm9sNHFXQ0NaaE1aK014Sk95RlpObmtIOTNySEpkd05WdUVwVnFSYTI3?=
 =?utf-8?B?U25Mc1BydDBHZjIxYVRzSDgwMExoZm03amo5QkpjdjRqdHQ3Um5xdERLWFNF?=
 =?utf-8?B?VDBhdHgvK2NweTBYbmhHV3dlN0FVUjF5S0NBcmpsRTNNc0FvQ0hWbEFyeXlN?=
 =?utf-8?B?MHlhT04rNE0vM1dBTmJVYmtXS2VTbWFpZkNpZ2ZGbTYxWTVvT0IzRU9UVlYr?=
 =?utf-8?B?VkdwWllSMHVpOTJwZVdIZnZPN3JMemx5WXY3aGpSTHlRek1MY1BMM3E5WXVs?=
 =?utf-8?B?aDlid2NxM3Y4UU5vZWNDbG9BcUNUOXMvd25UdHB6ZXM5QzZSNVZBbmU2MFEw?=
 =?utf-8?B?Z1RoRFlmNEhLcnZMMVRLSTgybkRhMTVKUS9oWEw3ekljb25RdjRicDAwZjAr?=
 =?utf-8?B?L3I4akdjNUxDdmkva1JDWWdvUzBSTzFMZCtYRG5lbU1lMFJVNFpXa0VBNGxu?=
 =?utf-8?B?LytFS3NSNTg0YklkWG9BWDc4UmtUMUlZMEEvbmZwalVONHprQnVIZkM2OTg0?=
 =?utf-8?B?YWdUYk9keHMvc01rUVlIcTQ1VXl2Z1pQYzkzckNJVGdIc2I0QXZGSUJXVjIx?=
 =?utf-8?B?VGxqZy8yS3RIbEpCTFJ5Y2ZVTFhPN04vaTJlYm5YeHUyQ0dGRFFRdXdTR2h0?=
 =?utf-8?B?S0psdy8xb25DR1cvanUyR3JHK09MZEE0K0xmK1U3VXJ3bS94eUs2L2N6eXRF?=
 =?utf-8?B?cmpVQTB3Rm1zTWtmb0tQN3ZockhOOEZKLzNkOHJESUVEK21CWDlFNzl0NEQx?=
 =?utf-8?B?UkUzYUQwc1djVFl4Y1V0WW9RRW9CeTlLU2lZM0Uza21teTc0bU1XWHd5RFFV?=
 =?utf-8?B?SkdmV3k2L0NNYTVNT3lBM3prNHdoK1I5OU9HMFRiRDIxdGJSVFl4S1pvT21s?=
 =?utf-8?B?YzhiamZ5TEwxUHhVK2kvOWY0UGR1aERha05Md0NpUUdpbGh0Sk5QOUpCV0to?=
 =?utf-8?B?cXQzK3NQMGs0end3cVlkOHFFeGZRVEx3enk4OXkwMUNPandpaklLM3c3NGJR?=
 =?utf-8?B?UmFRclhjcE5nYTBFTDZOTTBnei9DVy83OTJjZzBKWnZ3WlYxTnJZc2dydnA5?=
 =?utf-8?B?SkliR3dBVHZRRnJzU1hvSTdTYW4wSjgvcGZIdm1NM1FrUmJhOEtwcmFLYU91?=
 =?utf-8?B?YnNuUHB4MFh3aS9XUWF0WXpWUVc4a0k0R3Baa2JIQmdEeUtSbVdWOW1USkx4?=
 =?utf-8?B?cHV5L09JbnFDQ0RIVkVMR0tzcnFTNU9YcE5vRHVSRXBJdHVDcXU2eTlDV0FZ?=
 =?utf-8?B?K2VnYlZUSXYrRWdSUGlicTV3MkoxMXdVc2Y1Wjl2WWNCekEwZnVxZzRWN3lx?=
 =?utf-8?B?dDU0bG5aRGI2eUxsYTU3eG1sbytPb0NsYTZsbzkydWw5a2g1NlhWWHdrWUhR?=
 =?utf-8?B?amhXbFMyZTlhcE1PMnI2ZnFNZy9zajhidEQ1MEN5WUZ0OFo2TTAyZnJoU0ZG?=
 =?utf-8?B?Z0dsMUM4MlZXMEV4SWFYVWNhTnd0OXZZelpQekN3UFNVNmlwYlRzdCtyazc4?=
 =?utf-8?B?ckw0c0p4N2RvTWdybnJ3WktzeS9ZSG9lRFNMZUhJNTh1NzhDN1VtdGcrRFFp?=
 =?utf-8?B?Nk9iQmlyYXBTaGF1SkVUQVRiK3dWWUhuN3BXKzhZcVhnbHorb2tJS3VpWnN6?=
 =?utf-8?B?L09oa2hLNHRUcXVxa1lCMlpXSWlCNmpHdU1KaXJKdlhFS0pOYUE4RXlSUmJ6?=
 =?utf-8?B?a1E2bCt5VzhLaVdkWjdIUTZXQjM1M0hqMzRDd1BMVC93eVF1cHQxVjUxeG93?=
 =?utf-8?B?MW5qVTFhMS9pajVpNWRnT3ZHdGJyQzVLekpJb1FRQTFZZ0dIaktndDAwVG5F?=
 =?utf-8?B?ZDJVajNCTnNJVDhmWHVhU3cxVHNEbDJUN2hwWXYxT29WNUJTQm1uSFJiVVY2?=
 =?utf-8?B?WDlQS2EwOVIrUStGZ2JOYmZhT3d1cW5JN3NDSXRVQVl5dFV1OFVWVmdJZFdG?=
 =?utf-8?B?QXozaFgvZVdKTCtKeVJNMDlZUXpWUTNKQXFoeGNxK0ZlSjUwWWVDWHVYZ2dZ?=
 =?utf-8?B?RjJFVVo0c1pjUnpwN1R1VzllTmVMY2NaSW03UG1wdW1HWC9jVndEVnU0VGQx?=
 =?utf-8?Q?prpdCcttqKGwVj2dqDDWA2IVL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb92118-9b87-41ba-8e84-08dbc0c09136
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 07:49:10.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvVBS55XHhOVsU/sIwU8m6GqqgcsUTAIpG5sb7FZJzv3X0BD8oy3EhP0a3BinI8c40hCe4szq005AH5OqYlYWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4529
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Mario,

Thanks for taking a look at this patch.

On 9/23/2023 3:52 AM, Mario Limonciello wrote:
> On 9/19/2023 05:33, Swapnil Sapkal wrote:
>> In selftests/amd-pstate, tbench and gitsource microbenchmarks are used to
>> compare the performance with different governors. In Current
>> implementation relative path to run `amd_pstate_tracer.py`
>> broken. Fixed this by using absolute paths.
>> Also selftests/amd-pstate uses distro `perf` to capture stats while running
>> these microbenchmarks. Distro `perf` is not working with upstream
>> kernel. Fixed this by providing an option to give the perf binary path.
>>
> 
> This should be multiple separate patches, at least two.
> 
Sure, I will update this in v3.

>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>>   .../x86/amd_pstate_tracer/amd_pstate_trace.py |  2 +-
>>   .../testing/selftests/amd-pstate/gitsource.sh | 14 +++++++-----
>>   tools/testing/selftests/amd-pstate/run.sh     | 22 +++++++++++++------
>>   tools/testing/selftests/amd-pstate/tbench.sh  |  4 ++--
>>   4 files changed, 27 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>> index 904df0ea0a1e..2448bb07973f 100755
>> --- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>> +++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>> @@ -30,7 +30,7 @@ import getopt
>>   import Gnuplot
>>   from numpy import *
>>   from decimal import *
>> -sys.path.append('../intel_pstate_tracer')
>> +sys.path.append(os.path.join(os.path.dirname(__file__), '../intel_pstate_tracer'))
>>   #import intel_pstate_tracer
>>   import intel_pstate_tracer as ipt
>> diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
>> index 5f2171f0116d..c327444d3506 100755
>> --- a/tools/testing/selftests/amd-pstate/gitsource.sh
>> +++ b/tools/testing/selftests/amd-pstate/gitsource.sh
>> @@ -66,12 +66,15 @@ post_clear_gitsource()
>>   install_gitsource()
>>   {
>> -    if [ ! -d $git_name ]; then
>> +    if [ ! -d $SCRIPTDIR/$git_name ]; then
>> +        BACKUP_DIR=$(pwd)
>> +        cd $SCRIPTDIR
>>           printf "Download gitsource, please wait a moment ...\n\n"
>>           wget -O $git_tar $gitsource_url > /dev/null 2>&1
>>           printf "Tar gitsource ...\n\n"
>>           tar -xzf $git_tar
>> +        cd $BACKUP_DIR
>>       fi
>>   }
>> @@ -79,12 +82,13 @@ install_gitsource()
>>   run_gitsource()
>>   {
>>       echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
>> -    ./amd_pstate_trace.py -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
>> +    $SCRIPTDIR/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
>>       printf "Make and test gitsource for $1 #$2 make_cpus: $MAKE_CPUS\n"
>> -    cd $git_name
>> -    perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o ../$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > ../$OUTFILE_GIT-perf-$1-$2.log 2>&1
>> -    cd ..
>> +    BACKUP_DIR=$(pwd)
>> +    cd $SCRIPTDIR/$git_name
>> +    $PERF stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o $BACKUP_DIR/$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > $BACKUP_DIR/$OUTFILE_GIT-perf-$1-$2.log 2>&1
>> +    cd $BACKUP_DIR
>>       for job in `jobs -p`
>>       do
>> diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
>> index de4d8e9c9565..0803e70b04da 100755
>> --- a/tools/testing/selftests/amd-pstate/run.sh
>> +++ b/tools/testing/selftests/amd-pstate/run.sh
>> @@ -8,9 +8,11 @@ else
>>       FILE_MAIN=DONE
>>   fi
>> -source basic.sh
>> -source tbench.sh
>> -source gitsource.sh
>> +SCRIPTDIR=`dirname "$0"`
>> +
>> +source $SCRIPTDIR/basic.sh
>> +source $SCRIPTDIR/tbench.sh
>> +source $SCRIPTDIR/gitsource.sh
> 
> Rather than hardcoding $SCRIPTDIR/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py in multiple places, how about you delcare a new variable here?
> 
> TRACER=$SCRIPTDIR/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> 
> Then all the commands can be called with $TRACER instead.
> 
> Furthermore if there needs to be flexibility for multiple calling paths in the future (say in tree vs in filessytem) then you can easily add another case right here that is:
> 
> if [ ! -f $TRACER ]; then
>      TRACER=foo/bar/baz
> fi
> 
This is a good suggestion. I will update this in v3.

>>   # amd-pstate-ut only run on x86/x86_64 AMD systems.
>>   ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
>> @@ -22,6 +24,7 @@ OUTFILE=selftest
>>   OUTFILE_TBENCH="$OUTFILE.tbench"
>>   OUTFILE_GIT="$OUTFILE.gitsource"
>> +PERF=/usr/bin/perf
>>   SYSFS=
>>   CPUROOT=
>>   CPUFREQROOT=
>> @@ -149,8 +152,9 @@ help()
>>            gitsource: Gitsource testing.>]
>>       [-t <tbench time limit>]
>>       [-p <tbench process number>]
>> -    [-l <loop times for tbench>]
>> +    [-l <loop times for tbench/gitsource>]
>>       [-i <amd tracer interval>]
>> +    [-b <perf binary>]
>>       [-m <comparative test: acpi-cpufreq>]
>>       \n"
>>       exit 2
>> @@ -158,7 +162,7 @@ help()
>>   parse_arguments()
>>   {
>> -    while getopts ho:c:t:p:l:i:m: arg
>> +    while getopts ho:c:t:p:l:i:b:m: arg
>>       do
>>           case $arg in
>>               h) # --help
>> @@ -189,6 +193,10 @@ parse_arguments()
>>                   TRACER_INTERVAL=$OPTARG
>>                   ;;
>> +            b) # --perf-binary
>> +                PERF=`realpath $OPTARG`
>> +                ;;
>> +
>>               m) # --comparative-test
>>                   COMPARATIVE_TEST=$OPTARG
>>                   ;;
>> @@ -202,8 +210,8 @@ parse_arguments()
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
>> index 49c9850341f6..70e5863e74ea 100755
>> --- a/tools/testing/selftests/amd-pstate/tbench.sh
>> +++ b/tools/testing/selftests/amd-pstate/tbench.sh
>> @@ -64,11 +64,11 @@ post_clear_tbench()
>>   run_tbench()
>>   {
>>       echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
>> -    ./amd_pstate_trace.py -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
>> +    $SCRIPTDIR/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
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
