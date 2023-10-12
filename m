Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AA37C6445
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 07:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjJLFAu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 01:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbjJLFAs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 01:00:48 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB4E90;
        Wed, 11 Oct 2023 22:00:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IU8I12sTUcnQ0ofSKXN5itn+jxlsc4uGKkS7tLaVFbJEu+/s9l2dZ8vCRKnEoJG8KJyF44kjcE5TFOPc1u1k+Y3nnvNd+0pk40lmub4P76Djjhad+516jJjjoRZ/v091uNoTTSZJYgoyo5XLIzuFQ9JZ8NGsfqnMK1SX5yufPiBLYyXDfK3CDrzxdIZxlm28F3dRcNaXwjdX5MnZEGJMoAu8zftLSYVTTJCi0tcozE/rtvp/as2RutImxMrqzgHxVuzEfO4YGQz56fRCjA8EkNhJ80j2HQy98ED7uMXFjuSSJjYIE+TmQBkU9M7aGcPUlqjy+ZMiMylnoQcOkls+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMnLpjJmtW1tvJtYlghDYEhnpJDQm+EmXnqUIHuxy/g=;
 b=Zn0hloJmVXKDwPLHnCZRBrhPPTuHOUumRGmDaIY2pRsfbmgr04bFgW/RGKf04SHT7maDi6XAgCV9HHmeDk9u16Gk/XlNVytzOIlwF3kaDuamH5EhJpOvP+l90e3NDRj/bbalXP72w2EdpA7DFYPTCbcntNFTqtaXRMSLuozhI1ybZbgXb6JHfC7leizIYuRJ75B2tmD26rb+sGS/5sI0rhfgpkCOmhac65FBawosu4LKTHA2SYX1qMP5MnzGt2KzASpStM+bVbkj/5+SO0HfB35udzVg8ebC1d5ESDcKngPFT4otRdJAX2j8gDjaTm/AND17etlmHBl4ZoW5KlgC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMnLpjJmtW1tvJtYlghDYEhnpJDQm+EmXnqUIHuxy/g=;
 b=SGJjVlpvpMgR8chTDEpYBYdK5cgixXqcfCfNUum5p/EXI5GA/s/Drw6DdzlcUZE6HJIu5uOCzDfJt3YE5UDTegG8kudCVYoVlFE2mfR8jZ+pCw4/fNRvYa+t9OaKir9cvKQ5Sa6VX9NnAg9V3dqAG3XEghiBL9bKdTFyZEZf36E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 05:00:42 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::495c:3afa:1762:efd5]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::495c:3afa:1762:efd5%4]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 05:00:42 +0000
Message-ID: <983f78b0-3461-7ecc-b1d4-652aa554fff0@amd.com>
Date:   Thu, 12 Oct 2023 10:30:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] selftests/amd-pstate: Fix broken paths to run
 workloads in amd-pstate-ut
To:     Mario Limonciello <mario.limonciello@amd.com>, ray.huang@amd.com,
        shuah@kernel.org
Cc:     sukrut.bellary@gmail.com, li.meng@amd.com, gautham.shenoy@amd.com,
        wyes.karny@amd.com, Perry.Yuan@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20231003051006.6343-1-swapnil.sapkal@amd.com>
 <20231003051006.6343-2-swapnil.sapkal@amd.com>
 <81dd0b57-107a-4954-966b-c2f98d4b1bec@amd.com>
Content-Language: en-US
From:   Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <81dd0b57-107a-4954-966b-c2f98d4b1bec@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0134.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::22) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9eeb07-5c4d-4870-77cb-08dbcae02f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ZKhj5tinXH74B0JaVmKWn/hjhaIhH+c69jPVUWCqsSRL7YkiNgjDpvqB+BgpwaaehftKNfwmHeReNLJtWaG3+f+vCVzW2gZ5V34X8NZ+M8WNJU7LPVZnWKepe25ZcT+7xnqIxUDVqesKyMEXwSqnohmnya0SHDcAVLq667DkDyovVjQGFU6SR/bBj44FF4YjrZFlhbohDGNh9DG00VfCqceileeDJq/7b2yzQwmQ8PpnhtIE8nT5FRRdX68LxiQqFybm2RiifCN1tDFto5BhqdGXXmF4ibDPQB8yDOv06POeWPLDyCApWTbnbBkHOffnea1fjDYJNyW1s+SQXUNi9rIsFF7tHxoUtttIInkS3FE+wwvQgtBFsP9HfOOucEgO1ExD5XIj90fRqQDltAmGIBw6r/vjUwvmJrZArY9HqjFBJzmBh0blLYoSkobP/UGqjcJGrXd4zbXgceHtvEAHbNnau/5e1TBY1BYEcykKOiUWu7ld+ix+GLJF66cqjiQJ6GmN5w05SnGURu3UdP0H5JMUg5zcs7bxTgyG24ESbR1CKLemYYbDCBSBSaUoFXEMOjbazsbCVmQpdhqp3yJa//5D6bUuvL5IzOynra1n7WLtigh1VRHe1BVBVlZc41KG6+ghmsb0JXsYh+4A3HvDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(2616005)(5660300002)(6486002)(36756003)(6506007)(478600001)(6512007)(31696002)(6666004)(86362001)(53546011)(66946007)(38100700002)(66476007)(316002)(4326008)(2906002)(8936002)(8676002)(41300700001)(66556008)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVZvdmNqNis3M1d2bjltcHNQb0Irb0lZNkh1ZW9BeEcxcEhjTWdsVGlwYStv?=
 =?utf-8?B?WVVkb0JXZXdXMHpwSk1BZm5YN09IdlA4aTVtMkYwbnYxZEczVDFIbi9hejIx?=
 =?utf-8?B?b1gwTGJIU2xhclB3TWZDQjRad2NRSVRHdisyNkxQZTdLMjNHTnllR0Qwa0NX?=
 =?utf-8?B?UjIzNThON1BldXdDanBPTjRBSHNjNmJsWFZhaFFXeTF5OTVDNklBSVBLSEVP?=
 =?utf-8?B?OFZuWWJUWGFNZFhoSHNJVWRKU0hxb1pKVUF5ZHRBcU9BQ0F2T2Q4S0pmcHBp?=
 =?utf-8?B?bkdkbmxFV21SeDhQQ3VodVkyZ00rZERDTWl3WUVNWmZWbWc0WTB3TmpBY1F5?=
 =?utf-8?B?UEdHc0s1SHdaZ2xzN2FNTmJvT0JSTEkzcDdRY2Z6eHErd2s3ZDkzeWEyRjRx?=
 =?utf-8?B?UkxBMmFTbVJQajgzTmNjL0Y5VVNtVzhCbi9xL0NNSmlmUUFROU9VaFRXV3Y5?=
 =?utf-8?B?V0t2YXp0WkQxTXJEQnFjNnYwbTNlWXNWVEtQTVd5TjZQU0txY3dEV25UTW1J?=
 =?utf-8?B?SlI2a2Jpa2ljZ1VCNDl1N20zYXd0U1dkQmxVM0svRFpISTdVdkJ0VnJWNzdo?=
 =?utf-8?B?MFZUSEhyQ3FwK1BxajlYN01DbmhSR05vcmpHK0w3anpxZkxYQmMxU3gwZzZB?=
 =?utf-8?B?WVMxRFBnajE1aXVBSzIxbStydGtWWDRCbHBkQjBTVWZ3eUhRRm8waWg1c096?=
 =?utf-8?B?UXhBbjRTUEhCWW9jOHByZHIvTnRTamxYZFZkMFdVWXJOSlB1WjN1R1oxN21R?=
 =?utf-8?B?WmQ0K3VaZzVocHVNY09oNGJYNmlvK3JlM1VuTUFRdkVLTDdhUDYydVd3cU96?=
 =?utf-8?B?aGdvbFptYlhDSmlMQ0w2ZDRZZU5SYnI2L2xXMjZIT2NsM0ZjQXZ5UTRYMytn?=
 =?utf-8?B?OUJwL1dxV2RVV29uZTdDVUJlWXRuUEF6WlV5NHJCWVNueC9nV2tvdjhXb1I5?=
 =?utf-8?B?NUZwdFptYmFnV1J6MElUcnBFWVJQbkpFZFB5c2hKU0dPRDhGWldYY1FlVWtY?=
 =?utf-8?B?NkFmMVZvZEtGTmNSS0dlVzNSN0NZTzhkNERrVjhqZEZaazZpdExFK3ZyQ0Rz?=
 =?utf-8?B?dzdDazZvczFJdkV4ZFgwSTdPWElYb1Z6eVpqOHcrSlNVUTJ3dXpoMDQ4Uklw?=
 =?utf-8?B?c3czUWhpWlUyTzYyaWQ4SDhlOE04am5YMkpJRk9HUUwrbU9RRGRJeXZCYisr?=
 =?utf-8?B?eHowdjdiT2l4MExYT3pMdEM2bGxHOHlsb1AwLzBha1J0WHRlWExkT0hpb0FH?=
 =?utf-8?B?eHVEeG8xekNPaGxVNDd4NDVHWTYyanNObHcrczMrNWhWNHpReDJOMjJaN3hN?=
 =?utf-8?B?Z05VRUxBNTA5TWI2K3RoVWxvTldaSnRsdXM4UTB2bnp1UzF6cWNoTDlpZkJl?=
 =?utf-8?B?WHA2VnhDWGxZU29weU4ydVNyc0FhTk4vZ0k1dXhTM0FLQ20yTkt2enBSbU5i?=
 =?utf-8?B?YTlacUNYdW81QTRqOUtrcWt6ZWRYeldzUFZtUGZPL3Z6dGFLY3UyZkhEMVhB?=
 =?utf-8?B?dTZ4YUJ3VUpqYUxjcmhMQnFkeVZVRUJkYkdYcDJ3VldjMzFkM09Pa2xZWlJj?=
 =?utf-8?B?NWFPSWU2UFpyeFV3R1pyM0s3bnh6YnFHSENmbUw1RUlyYzVMb3ZTUXpPZ3V1?=
 =?utf-8?B?MmtyeTl1ZS9KbTB2Skh4cWFjSzQyREQySjRlSzZPOUdBNlFRWWhBRGJnZzNB?=
 =?utf-8?B?UW9kTHp2cmpvV2J3ZmJTVTFSeDU5VFpYS0lXUGxRdnlLa0tRZGNoVEl2Tmo2?=
 =?utf-8?B?Smk5aGEwVXdqUkNDNkFma0ZTYnQ3a21PMVJmSkJEUHV6NVkzTVFvTU9oZkJI?=
 =?utf-8?B?ZHBLc2xKbU50L1hHYkN1MTNDcFhsYjFsOVFuZUwyT2RYK25McWhEenZ5WHdC?=
 =?utf-8?B?UVlqUGxrUE1JeTh5WkVYS1ptWTNRckVzWC9VbWtDWDQyWHZKUUU3WU9hbEdh?=
 =?utf-8?B?eHJtNktrT1l3TGVRN0lCZjNWMFhINXhkZGh2bVhyQ0ZjakpGeW8zTVIvUWJG?=
 =?utf-8?B?cHRVYXdDeDhhRnJ0enVMTWQ0dWM5ZmN0NzlnTzdrNmh5eEpTVnowL1ExOGNG?=
 =?utf-8?B?WkZHOWI1ci9TK0ZJZWVRLyt6cXEzamxxM1RMWVBURmFFTzJXaytSL2UyajRT?=
 =?utf-8?Q?sZfVw4MeHlPzxYH3E3WqeDAXF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9eeb07-5c4d-4870-77cb-08dbcae02f57
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 05:00:42.2325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLuCy2W//bMQ1sap4HJ4EmPjA9r+zChIee3WI1JVNNQMEc/daPnGlHHxcHn5WjfU0f16MzrU1mI5fU3HpOBZXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260
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

Thanks for reviewing.

On 10/7/2023 12:35 AM, Mario Limonciello wrote:
> On 10/3/2023 00:10, Swapnil Sapkal wrote:
>> In selftests/amd-pstate, tbench and gitsource microbenchmarks are
>> used to compare the performance with different governors. In Current
> 
> s/Current/current/
> 
I will fix this.

>> implementation relative path to run `amd_pstate_tracer.py` are broken.
> 
> The plurality of this sentence needs some work.  I suggest:
> 
> s,relative,the relative,
> s,are broken,is broken,
> 
I will fix this.

>> Fixed this by using absolute paths.
> 
> The tense is wrong.
> 
> s,Fixed,Fix/,
>
I will fix this.
  
>>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>>   .../x86/amd_pstate_tracer/amd_pstate_trace.py      |  2 +-
>>   tools/testing/selftests/amd-pstate/gitsource.sh    | 14 +++++++++-----
>>   tools/testing/selftests/amd-pstate/run.sh          |  9 ++++++---
>>   tools/testing/selftests/amd-pstate/tbench.sh       |  2 +-
>>   4 files changed, 17 insertions(+), 10 deletions(-)
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
> 
> If you're using os.path.join, shouldn't you not be hardcoding a "/" in there?
> 
> IE it should be:
> 
> sys.path.append(os.path.join(os.path.dirname(__file__), "..", "intel_pstate_tracer"))
> 
I will fix this in next version.

>>   #import intel_pstate_tracer
> 
> I think another patch should remove this commented line, it conveys zero information.
> 
I will remove this line.

>>   import intel_pstate_tracer as ipt
>> diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
>> index 5f2171f0116d..d0ad2ed5ba9d 100755
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
> 
> If you change to /bin/bash instead of /bin/sh you could use pushd/popd instead.  If your goal is to keep compatibility with things like /bin/dash then this makes ense.
> I will update this in next version.

>>       fi
>>   }
>> @@ -79,12 +82,13 @@ install_gitsource()
>>   run_gitsource()
>>   {
>>       echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
>> -    ./amd_pstate_trace.py -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
>> +    $TRACER -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
>>       printf "Make and test gitsource for $1 #$2 make_cpus: $MAKE_CPUS\n"
>> -    cd $git_name
>> -    perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o ../$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > ../$OUTFILE_GIT-perf-$1-$2.log 2>&1
>> -    cd ..
>> +    BACKUP_DIR=$(pwd)
>> +    cd $SCRIPTDIR/$git_name
>> +    perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o $BACKUP_DIR/$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > $BACKUP_DIR/$OUTFILE_GIT-perf-$1-$2.log 2>&1
>> +    cd $BACKUP_DIR
> 
> Similar pushd/popd comment could apply here.

I will update this in next version.

>>       for job in `jobs -p`
>>       do
>> diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
>> index de4d8e9c9565..279d073c5728 100755
>> --- a/tools/testing/selftests/amd-pstate/run.sh
>> +++ b/tools/testing/selftests/amd-pstate/run.sh
>> @@ -8,9 +8,12 @@ else
>>       FILE_MAIN=DONE
>>   fi
>> -source basic.sh
>> -source tbench.sh
>> -source gitsource.sh
>> +SCRIPTDIR=`dirname "$0"`
>> +TRACER=$SCRIPTDIR/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
>> +
>> +source $SCRIPTDIR/basic.sh
>> +source $SCRIPTDIR/tbench.sh
>> +source $SCRIPTDIR/gitsource.sh
>>   # amd-pstate-ut only run on x86/x86_64 AMD systems.
>>   ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
>> diff --git a/tools/testing/selftests/amd-pstate/tbench.sh b/tools/testing/selftests/amd-pstate/tbench.sh
>> index 49c9850341f6..4d2e8ce2da3b 100755
>> --- a/tools/testing/selftests/amd-pstate/tbench.sh
>> +++ b/tools/testing/selftests/amd-pstate/tbench.sh
>> @@ -64,7 +64,7 @@ post_clear_tbench()
>>   run_tbench()
>>   {
>>       echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
>> -    ./amd_pstate_trace.py -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
>> +    $TRACER -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
>>       printf "Test tbench for $1 #$2 time_limit: $TIME_LIMIT procs_num: $PROCESS_NUM\n"
>>       tbench_srv > /dev/null 2>&1 &
> 
--
Thanks and regards,
Swapnil
