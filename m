Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B907BBF6D
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 20:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjJFS73 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 14:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjJFS72 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 14:59:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0185C83;
        Fri,  6 Oct 2023 11:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfCtSpc2+7AXD3I4dxDvzzIQhw+vr2gMrZX3ZyUMmhgo1sD2QC2W+otQjk5ctf/QAA/XuJyapyL2GGpXyhSIm07rYhY1Lm4PUM8qCHG5xKB75RX6UO3O/CCw2eIsN0AER1vDaaIcAOKzEZlHkdOBiw+oz3uhwDkh/UJhoYGvvrth/qDSlOLXIrWRTOHytCV5tHKWpqY/Ocp844LRrJX7CZX7kRz++MjJozAeXftuTQE6NccUXKwdHXP74VIMnVcetkqH341Auzv46TRRJzaYxsdWwW341RkaV6Uel3JooCckXxUvltbFw2DSp+tC9n5L1bvvJlu6ondBe4Xl/Ed9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBF9sETB2xGoJQJmafUN5R2VsyDb6nfpikckuxolt0s=;
 b=FhA6qOP8Txiwb4LRjtSrHUnF6QwJ0AeftGKs1RucS8+9+3SUVwanD9t3CZuj1uQ+E84YwRxaSsgpVqqP0GvOLxVW9z+MQzmInE4JwaGQQo03zr0a6aAgIv33L+aN6JhoD/eb5K5Ubsbk/XJLUBNcNIAeC+NNzQhf2/8kfWzeZY4Xs+NJkjPZZY3xB+ig+/cKs1hlBJFkcWkg0/VRPkuQLG7cWuZ5LizjEch8XgFtxkwgT2rPwNIcFO79mSigZO5tGnoMGMhCHbAJdUmgbXgT8xoXZEhwP5P6G+9zAhqbO/8F/r8mOIt0m3Ds6nGMP2KzoKAYu9iWnK88XsOrCPolrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBF9sETB2xGoJQJmafUN5R2VsyDb6nfpikckuxolt0s=;
 b=Ef/Ed+WuXObplvttk+2nmXYr8tr5sEUOvCK+ZX28fZDx0eUG1bldqsjoNDeX0LpnUBtCHTYogDPfE4oI5QIGbKwIv/Jy2nM+xO7rs1vH4uKfwR5S7maRF2OJx9OlCzjCzfhWL13t3L7EEbZTutJogBHldArRyDaukUfUa89YhIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Fri, 6 Oct
 2023 18:59:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 18:59:24 +0000
Message-ID: <33271bcf-66fd-42e9-9b19-0c1547814f38@amd.com>
Date:   Fri, 6 Oct 2023 13:59:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] selftests/amd-pstate: Added option to provide perf
 binary path
Content-Language: en-US
To:     Swapnil Sapkal <swapnil.sapkal@amd.com>, ray.huang@amd.com,
        shuah@kernel.org
Cc:     sukrut.bellary@gmail.com, li.meng@amd.com, gautham.shenoy@amd.com,
        wyes.karny@amd.com, Perry.Yuan@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20231003051006.6343-1-swapnil.sapkal@amd.com>
 <20231003051006.6343-3-swapnil.sapkal@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231003051006.6343-3-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 733ab3e4-af2a-41bf-55ec-08dbc69e5b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIydNYvPOzmpiaNnSxNxuRmqZ1qosyw8ZGaoJbu/8ob1QSg07SFO4YCYHVI+JIjra5EjG2S+ey+U6YvpufAxh/n/ueYBL8d5aHbZ8oioTPZlCs8XTyyvjAdd/KJaz630CvtOtYEJd0KUeillUv/iXFFyA29NMDoq15uoVLTggzzZjg5HzLD2Fkmk9jQ+ay5rs4l6egBD9tYocN2Ja3k6idc9y7sqnJ0odjKN6XQ8JikKWvAqrJawJJveUCm0Q5SQyk5LncnynstJL4VqqcqRAwphX0YFxi1D1+ucIU0EDzBUzEABluxVEnOJcWEAmyHsTOb9p7Sowch/klYEh/aWj/0S4ITei9JuYTtlKMOqSNF/UN0zolQGAI2VWUOwasKKO0Z589MX91DNoFhCf0edk/fIQlBSsLoiKL4dvjoNlDlAUOYLv+MNvvygmc+6Oxs2rzzL4NBi/sz6bOp1mF6rhe/iGVv2xFsmK+e9a1uzyJcReWv6B/3N3duK1/uIGmJJDDzERZGu3UJlB0iCTU6GXvXYA5oBY7J37BvaLBYVu8mWH9iNrGcS379/t1IGmnB5DAKkC6zUQlY5wxaTOPZYXAz9uO20YbUFVQjFp0VAst/2OwlBYcHDYZCLMHXkAKx65GcNfjxn+jjlOYLyrDuKgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2616005)(66946007)(66556008)(66476007)(41300700001)(316002)(53546011)(36756003)(6512007)(6666004)(26005)(6506007)(478600001)(6486002)(38100700002)(86362001)(83380400001)(31696002)(44832011)(2906002)(31686004)(4326008)(8676002)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjgvTEw4VGU5WTBwUTlZcEJncEVJU0RzOE4wemp6L3hBMjNSUkxGaXExelVv?=
 =?utf-8?B?OTJ0cnNGMzJoWWs5QkptZEdoZlRUNWlBV3VrNWlTbFVTdnFBWDJRZkZJSXZr?=
 =?utf-8?B?enBab3lZTzNYVTFEZGVrNUQxMDBTeWhZUHpWTjZscmlhTXZ6NEZYbmlkQTFj?=
 =?utf-8?B?NHBZWFg1MUtGMlJSZGVqTFlEWUFxS3hpMFdBZlVnTEZEajU4YnloUGJPcmsr?=
 =?utf-8?B?ZnJJVWNPMDFDRHZ1aTh4M3VHaUtkbnpRa2pJOExHcEJDaDUzcWk2YUxWUHZw?=
 =?utf-8?B?MFNVY3ZGbFJOQytHeGxtdTY0WFhCZ1JRMHg2cWpZSnByeWFxK3hlNkJTS0lD?=
 =?utf-8?B?NGNlSDQ5dWozOG5VS2VLUzZob3VTYndBMFp2Rk9Nc3RJeDBKT0g1TURTWERo?=
 =?utf-8?B?VDdHbGErdDRYb0VrZ20zQ2M3OVZndWxCS0xPWHkyTmxGcjRpOVNZNkZBbEJn?=
 =?utf-8?B?cWx4ckZ3UjBqRW8xVUROdzBFVXQ0eXBGMVYrWThmSzM4YlY4M3kyU2w0NEVN?=
 =?utf-8?B?Mlc3dXlKZmQ1UmpDTDNYUXlXZC9teW9haHFwbGtCbDZCMzIvZnhPZWNOSWU2?=
 =?utf-8?B?WDV5N1dsSyt6UmRFTHFzZDgxd2RPcmtpWm5oRm95RWlPZEpKZW8xKzA0bGhk?=
 =?utf-8?B?MVFiaTVoOFNOSitOM2o4UVRoV3MxUU5oTHBEOCsrNHBKU3plOFc2S1JJV21X?=
 =?utf-8?B?bnNFUFoxK2VFVm14cVF0cC9XdkhraEpIUGltSUJLQlpxMzhBeGNuSG9OdkNN?=
 =?utf-8?B?RVZocDJDQmNvZmlCSFZEL1FmZml1VG1zazZnaSt4ZENmTWJkbElCUDQyVHMz?=
 =?utf-8?B?ai9VTlRUb0h4R3haNzk5WFBFWGRxSk1FcHp3YTNCZ3IwK2lXK2pqWDZFSk9r?=
 =?utf-8?B?MUdJVy9nV3RNUzg3QUozYUMxUUY1Z2pyNHNBU0dJejA1SERFMlV0cXlXcStp?=
 =?utf-8?B?ai96RzgwMEVrWlEzSGJBMXBUTTZLRjFCZXdvQzdYUW5UNDhUQ3JLY09nNzhm?=
 =?utf-8?B?VytuRE9PYysyK1o4SWxmeEVtK3ViTXZKTjZPY2hqb0NNdzJrZmpDRHVjeTBM?=
 =?utf-8?B?Wm5neVZvSDRzaXZKQlpSSk1CckxzTktUYjhHdGdWSy9HWHp5aWtMN1h2eWVh?=
 =?utf-8?B?NVNvdjczSnk0emRoZWxmWlFKUW1EQ0M3c29ySnM4U0lrdlNyQ3dPcHlRU3hV?=
 =?utf-8?B?aXV2LzNkR0tTNTA5YUpKRHYwMGxJblA2d1NvQmVOUklsaGswSGFxcGpZQzJF?=
 =?utf-8?B?b2dZZVdDeXlsakFFdm9GSHFnd1Z0RzEweUhLdHU0K3kzWGxLaVdYZzhCSWY1?=
 =?utf-8?B?SzlGeXRCdzAxSHBUd09nRU0wYTYzWTBBanlLRUJOSTNXNTlSbVY4ZkNQNGZO?=
 =?utf-8?B?dFo5WXNCOGpUMkduajVQeERKTTVmZ3VhMmRhSUNKV1NxYko4RHV4bUZSRkpp?=
 =?utf-8?B?dGx3WjlNVnpObWE4L1d5R2IwMFA5eXRMMk9hbk9GaVlIa2VLY2NsZmZQNWky?=
 =?utf-8?B?MCtqQVB2UWxIdDVMeWxMb3dCZ0hhTllUc2dkRll0UnNJYWtpU0NDZGI0UGd4?=
 =?utf-8?B?UzB3QmYyd29DdTdUWmR3L2p3VXRNSUJ5cGM5dG0zcHpXeTl0WnhkSGQrQlA1?=
 =?utf-8?B?SUp2b05zSUl5bEwxVzQxY0E1dDlOM0ZqU3VxV1RiWVlpNW9keFlEQVBCM3Jp?=
 =?utf-8?B?ODB3Z0k1bzZDWXc5UWF5QnBWU3hiYmNsWkt5eUw1NGVoY0VHeUFSVW1mTTRm?=
 =?utf-8?B?QkZ6bDhBRWMxQmJHdUp3VjVMRlJZbS85Qm45T3RzKzJSNFJLUE50dWxiM3NC?=
 =?utf-8?B?eVpmdFlWUFJFOWg1RzBRWExnRjFoNmRqL1dsaklnb3ZvUEdyTzBlb2F1UWFi?=
 =?utf-8?B?TW5jbFA5eHVYVEpheVZjVWFVK3pYZXdkT1QzcFZLWUYyMUE5NUptS3VlWjBy?=
 =?utf-8?B?M1VtcFlIblR1RWxncEVkVG5ybFFYbGxZNy9PcEFJMGpUYTRFdWtHTTZkTTYx?=
 =?utf-8?B?Q0p6OXM0eVp2elcwRWtOMUxtM2RaVXZrUXhPbGI0YXZIa0x2MFNzM013RjFW?=
 =?utf-8?B?WXhrZjZJZko2UlVYRVE1bTVjMVE2WitHRU8zWWlYMlhreDVYMnNqbmVJTzNW?=
 =?utf-8?Q?tT/SCp2R8E9PzfusTtAlFsZp7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733ab3e4-af2a-41bf-55ec-08dbc69e5b24
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 18:59:24.1925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+Pbf6NK6NLC6bBJYjJNDjgInFyQnvxtCGZb5XzYehfFQZgN1AxlVW55uXqxqiXPcMigEsYKITkRwFSpCsv2UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/3/2023 00:10, Swapnil Sapkal wrote:
> In selftests/amd-pstate, distro `perf` is used to capture `perf stat`
> while running microbenchmarks. Distro `perf` is not working with
> upstream kernel. Fixed this by providing an option to give the perf
> binary path.
> 
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---

One small nit, otherwise:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

>   tools/testing/selftests/amd-pstate/gitsource.sh |  2 +-
>   tools/testing/selftests/amd-pstate/run.sh       | 14 ++++++++++----
>   tools/testing/selftests/amd-pstate/tbench.sh    |  2 +-
>   3 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
> index d0ad2ed5ba9d..5acc065e9e3e 100755
> --- a/tools/testing/selftests/amd-pstate/gitsource.sh
> +++ b/tools/testing/selftests/amd-pstate/gitsource.sh
> @@ -87,7 +87,7 @@ run_gitsource()
>   	printf "Make and test gitsource for $1 #$2 make_cpus: $MAKE_CPUS\n"
>   	BACKUP_DIR=$(pwd)
>   	cd $SCRIPTDIR/$git_name
> -	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o $BACKUP_DIR/$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > $BACKUP_DIR/$OUTFILE_GIT-perf-$1-$2.log 2>&1
> +	$PERF stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o $BACKUP_DIR/$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > $BACKUP_DIR/$OUTFILE_GIT-perf-$1-$2.log 2>&1
>   	cd $BACKUP_DIR
>   
>   	for job in `jobs -p`
> diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
> index 279d073c5728..b87cdc5bfe4a 100755
> --- a/tools/testing/selftests/amd-pstate/run.sh
> +++ b/tools/testing/selftests/amd-pstate/run.sh
> @@ -25,6 +25,7 @@ OUTFILE=selftest
>   OUTFILE_TBENCH="$OUTFILE.tbench"
>   OUTFILE_GIT="$OUTFILE.gitsource"
>   
> +PERF=/usr/bin/perf
>   SYSFS=
>   CPUROOT=
>   CPUFREQROOT=
> @@ -152,8 +153,9 @@ help()
>   	     gitsource: Gitsource testing.>]
>   	[-t <tbench time limit>]
>   	[-p <tbench process number>]
> -	[-l <loop times for tbench>]
> +	[-l <loop times for tbench/gitsource>]

This looks like unrelated change.

>   	[-i <amd tracer interval>]
> +	[-b <perf binary>]
>   	[-m <comparative test: acpi-cpufreq>]
>   	\n"
>   	exit 2
> @@ -161,7 +163,7 @@ help()
>   
>   parse_arguments()
>   {
> -	while getopts ho:c:t:p:l:i:m: arg
> +	while getopts ho:c:t:p:l:i:b:m: arg
>   	do
>   		case $arg in
>   			h) # --help
> @@ -192,6 +194,10 @@ parse_arguments()
>   				TRACER_INTERVAL=$OPTARG
>   				;;
>   
> +			b) # --perf-binary
> +				PERF=`realpath $OPTARG`
> +				;;
> +
>   			m) # --comparative-test
>   				COMPARATIVE_TEST=$OPTARG
>   				;;
> @@ -205,8 +211,8 @@ parse_arguments()
>   
>   command_perf()
>   {
> -	if ! command -v perf > /dev/null; then
> -		echo $msg please install perf. >&2
> +	if ! $PERF -v; then
> +		echo $msg please install perf or provide perf binary path as argument >&2
>   		exit $ksft_skip
>   	fi
>   }
> diff --git a/tools/testing/selftests/amd-pstate/tbench.sh b/tools/testing/selftests/amd-pstate/tbench.sh
> index 4d2e8ce2da3b..2a98d9c9202e 100755
> --- a/tools/testing/selftests/amd-pstate/tbench.sh
> +++ b/tools/testing/selftests/amd-pstate/tbench.sh
> @@ -68,7 +68,7 @@ run_tbench()
>   
>   	printf "Test tbench for $1 #$2 time_limit: $TIME_LIMIT procs_num: $PROCESS_NUM\n"
>   	tbench_srv > /dev/null 2>&1 &
> -	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ tbench -t $TIME_LIMIT $PROCESS_NUM > $OUTFILE_TBENCH-perf-$1-$2.log 2>&1
> +	$PERF stat -a --per-socket -I 1000 -e power/energy-pkg/ tbench -t $TIME_LIMIT $PROCESS_NUM > $OUTFILE_TBENCH-perf-$1-$2.log 2>&1
>   
>   	pid=`pidof tbench_srv`
>   	kill $pid

