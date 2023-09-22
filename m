Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2EB7ABBAD
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Sep 2023 00:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjIVWWx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 18:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjIVWWw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 18:22:52 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0378C19A;
        Fri, 22 Sep 2023 15:22:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBlmktSdubqGBgaa4MVpAqp6LEYgalhaEJPwdZ1+tk9ah+U+hWaKCL2aBWW7qbv/CBbR5MT7V0PWVnGDvi7bN6EPPQ97Uv1G4nKWfPqxJNiayDE45sFXsVnYVCwBdkWXUsObLECE4dZB4OKNBf8uIlNxQx4tWYRAuS9nyy96jrJ4XU4pc3MOyCRstGaES99tBxrtVXRYQvTy/iGEAAR3We+mam0j3YZTWaVYI9O0L2gqcFTc0WMF+ooT8FF/cQDkyi+ALwlSi3ISZKChAnIuv6Kr8bYx845bTubmbERp22QsF8UyLatLZckZDX9A4pED8/VoqShLbGhL6w4DlqqVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZnDWZolIYziz/Vby8feVaEylWGJg1CT+IC4l0OKWhc=;
 b=i9/9ILT/bc/5b/xPeriLpp62krH4+8o64NdGHBhd7tz/kHnL9tnUGoEYuzU8XTx2+ZqURBNL/5y8/woDgxphDkeJI5GqZFK38EHkkVUICLF8eVyrYcquoj4DKsxR4j6HaH6cfE18BzKHslW73IFSltkwY7sHmsCy4OIs59fU4TC7Bz0yaP3o3L2Uu2YxSizopawMpItCOpB8IN3aBpz2d15torfh5BJtd+CLT3Wnd48TYiqoZGn703MFpUaqIzXXra+zrKssNcKdg8haf6I4alqeT5AT9KSjyAvGn//aRVGqfDJBU+MnEwBgIHj922orllqHvj6B3uFki1br+dHuMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZnDWZolIYziz/Vby8feVaEylWGJg1CT+IC4l0OKWhc=;
 b=gZRZ5rF5LT1yM9UFoqZUZwZheYTHp66d2bXq6G7+dP4S/1k0kyCOpNZkK3cNsLlw6OWrd3OPN2LqygQXci6r0HPOqJZeMeDfn3P+BQcCfBwQB3afrbCyhdbFSnaU2rSkWifFxnePuqc17pqIGm2XxJtcm42QSQvidmALSbZwA9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 22:22:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 22:22:40 +0000
Message-ID: <2d5a83d8-2101-4c36-ac37-be0375b0067f@amd.com>
Date:   Fri, 22 Sep 2023 17:22:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/amd-pstate: Fix broken paths to run
 workloads in amd-pstate-ut
Content-Language: en-US
To:     Swapnil Sapkal <swapnil.sapkal@amd.com>, ray.huang@amd.com,
        shuah@kernel.org
Cc:     sukrut.bellary@gmail.com, li.meng@amd.com, gautham.shenoy@amd.com,
        wyes.karny@amd.com, Perry.Yuan@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230919103351.48681-1-swapnil.sapkal@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230919103351.48681-1-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e454bda-5164-4e99-4f9e-08dbbbba6edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jdnw6HkF1er7pBBz6J4UiNQ0HP91YAwoIGUmLRyw1WLsSAgZN5rBEhoqmSeK2XaJKJqbcXigl+T/DSCSFUk2NlqQzw63Zqe5LTMkm13OoHSSHiSEOCmdIlbC3pKFFotF952cYtveEDEgbweru5eKe0JTLAN+k165vj8eQz/zjGNO7+nVweb82pO9XDqQI6xi7Vgu2Pv75/G34WVbqM6toiPi/NfE7DKYbVh5GC2p/DlfwL8Qw/TNirI4SejsFMaIMCvrbaXmqeexReeRD9BjYTGDDbvG0wW4kTlSX05rtyVwbVQm0m/eqNpn5Sz4p9+WYABKtEVDPEmuzJuPNzdD8CnMTtEXKcr1/P83+YTjfQcYQzZrwE749fH0u9DHnqMt+M2lCks65w7cBZMV1OFg4XslgGBp9c0yAB1HU1dvmocVy4Mwk0s3gn9lIDstJJoCYyRRZGAd6beoUt4/t8s9V7Skn4EYeQKrx+2DnhsnVC/tmYpcMMsGaSjr3bWQqFvkIdCMIXVV2T7vfW50lcvg8EgiPI2eqGXK5pDdxIrB8VH05bKW6KzqoG4V5MLFa9rqbUd6TpNmB0GVM+D2uFAuQ2WokEHOVnzfR5RjDtSIZNjvN7NcMJhPzNfmffrjLeLSBRisQz8dqUZfi1zEanKyqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(186009)(451199024)(1800799009)(2616005)(5660300002)(41300700001)(26005)(2906002)(31696002)(4326008)(36756003)(86362001)(38100700002)(8676002)(8936002)(44832011)(83380400001)(53546011)(6486002)(6666004)(478600001)(6506007)(6512007)(316002)(66556008)(66476007)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUQyNnE0WStaRTZXajR1alNyZ0pUZVBUbXpjcXhrWjdHVnhNL2lJVWhNVHh3?=
 =?utf-8?B?c3B5bnlOQUhMQ04rUGFidTVZSmdFaEphOW1rWHVDWWhjUDBpekxKVmoxZXhU?=
 =?utf-8?B?TFdZSjNDMEUxYlJ2UHhsaUUwN29ubzRDektYWnZkZzJtZjd6SUhxMURmVkxw?=
 =?utf-8?B?L0pLZDNQbm5KNmFjNXBLUE4xdnJwUW9xQ3pneU1DbFB3dkFjZXlMcVFYN0o4?=
 =?utf-8?B?dGI5Wm10OVJZdUcxakJNUmlwekRJeUczK2RTMUUvZS9LRmRSc3A5eGNVY1dv?=
 =?utf-8?B?TGZOdHNmM3RXQkZ5MVhQN2F4NThhKzd3NDVndE9JaFl5QlJmVWVHbGcyNWtF?=
 =?utf-8?B?UjFFS05pV2dKWWd2cTlmWVdNNU5FYjFKVE1GeVZkdWJvWDVIN2grWmNEOGRT?=
 =?utf-8?B?TEFveFZ6TEFhM2NiK3J1alRNcWdJYXNhUTh3bTlOYVArUndraDR0R2ZBL1VT?=
 =?utf-8?B?K0pxMHhhVGszSm5vSk5RZ0cvMXFrbTRZamZGWG5zTDhLSDdVSEhuaGNOU0Nt?=
 =?utf-8?B?dVY2S0pyKzFrSVp1Zkx6cnZtWHRGelNYSml6QXJIelFoSTZidE9DVS92dVVa?=
 =?utf-8?B?TjRlSVMrWVJhVW1Wb1pBR0VQNUVjQm85b2x4RE1sQVcvT0pWS2RHbHV4TWdQ?=
 =?utf-8?B?VmNKd0hHb09Md24zenduUW9zbUoxMFhCSTN4cm9sOG13bzY0QkhyQmtvMThL?=
 =?utf-8?B?TFRZVzNqSzM0dWlBVC9zQk1uL0RuSm9CaXJVakJmUzZJY2pBdzNIandkMzdo?=
 =?utf-8?B?dGhYeFprcHlxR2E5MHdrKzk4MlIxaitUeUJCa1VjT3I2dndtSERiendDZi9z?=
 =?utf-8?B?VjlVZjg2OUpuUGZKcXFmbEFFemlpVWREbU1uQUhUZUV0MnJUN0xPVmFBd1Jh?=
 =?utf-8?B?QzN3ZlU5OTh0SmNGeEJYUERVV2JNaTMyZzd0d0lNL3FGcnNvREY0NHBoNFpW?=
 =?utf-8?B?YW9zRjRMNElNTHNiZ3U4dmdTY0g4eldndGtRdlYvZXZyT2l1TlZHaDNtRmVB?=
 =?utf-8?B?ZURuNjhBaGc2Z3FOUWJNVzh3dFJ1SEc1VkExMmpnTGh1VTdRa0gydUxPZHVE?=
 =?utf-8?B?UEpBcDM4SzFWVnI0eVFULzkvR2U1WVNhUk15bEs0YTVkZ1pLaWRRZXpKWXJi?=
 =?utf-8?B?R211aXlFd1gxUVZ1enViL0VqVzJ4LzBYK1o2UU9oTGFZZHBQMW9GOHprUGlL?=
 =?utf-8?B?ZFZFUXlRd2NBaUVDRDI3U2tSWWtNb2hFZHdFMktadkNyNTdEdUJPODNHZzVS?=
 =?utf-8?B?cEVrcjBJYWd4WklvNlJlbEp4NGlBaDF3b0NYTmpVbkQ2L0VQYUVlUXQxQm5I?=
 =?utf-8?B?em1sOENHMlBvbWMxSm16RytOblRmemJaNmNIeFA4SlUrNGZLdmVNbjJNZ1VV?=
 =?utf-8?B?L1NhTG1KM0c4ajdCWTg1WkZqZTErbEsra0tJVzd5WXF4L0VrbE9mbVZQaFIv?=
 =?utf-8?B?eUJwNG1HQWpxWVNOSWtzVHZoYURXa3Zvc0NuNkI4cGpXcFVDWGNlMXZuUitj?=
 =?utf-8?B?ZnFPS2dRaDZEWFgyUFg5SGdNdXdldmpRNHpaUExKZnY5Ny9LWGJkSEpjdlpI?=
 =?utf-8?B?Uk5xbmhqelc0Q2krK1VuMnlkaVZURzVLajFPWDdsNVRsTUsxQnlZd25KRGhH?=
 =?utf-8?B?ZCtWRGN6R3NhL3Y3WWRLMkFBOWI4RW5UWTcyeWZsVmhsaS9FWFhEczdQenNa?=
 =?utf-8?B?ZDJkMktPVHJReEExQ0ozT3lQeHZwYksxaXRsMGwzMEM4azQ0YnJCNU1xYkkv?=
 =?utf-8?B?TjU4bDJJQnJra2hTM3lQalVJelZTOFl6SnZlUWVrVXRvZnFHVE1YNXFkVlNq?=
 =?utf-8?B?eFpDNFNoQTlmSUpkQjdOK0psTnNlc0RTWWd2QmJRZmJRbkFkTEhKVWdTKzFz?=
 =?utf-8?B?aTlkS1lFbXZ1eGRWSWt3c2wxdnhyWC9xNEFOcW5DeXJ2N285NmlEWVlmZkxD?=
 =?utf-8?B?NGlPUDhFNjZBKzRkc3RnL29qQXdvZnJmQ3I5Rm05Q3J5d0V3UHp1QkxMZGIx?=
 =?utf-8?B?TGlaSUdLbVB6LytSbWx4UGVuRWhONVNuREx1UHhDd2I1RExGa1AyclRTRS90?=
 =?utf-8?B?eHJzTEQ1UGZsVXJxeDgrd2loNUlkV0o0OWNLRmQya2xGRk9HaUM4a3NZSFNk?=
 =?utf-8?Q?1uaHezPp7b7EiOqFSAx61437i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e454bda-5164-4e99-4f9e-08dbbbba6edb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 22:22:40.2869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oapwFZI4u9z7gIxKK9C75oQFi/Z/pB1sjZdmTK7ZzcVsOmJKmDq4sv9/ccvJFrSBg5SGpzrbVZfn66UMJpjEeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/19/2023 05:33, Swapnil Sapkal wrote:
> In selftests/amd-pstate, tbench and gitsource microbenchmarks are used to
> compare the performance with different governors. In Current
> implementation relative path to run `amd_pstate_tracer.py`
> broken. Fixed this by using absolute paths.
> Also selftests/amd-pstate uses distro `perf` to capture stats while running
> these microbenchmarks. Distro `perf` is not working with upstream
> kernel. Fixed this by providing an option to give the perf binary path.
> 

This should be multiple separate patches, at least two.

> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>   .../x86/amd_pstate_tracer/amd_pstate_trace.py |  2 +-
>   .../testing/selftests/amd-pstate/gitsource.sh | 14 +++++++-----
>   tools/testing/selftests/amd-pstate/run.sh     | 22 +++++++++++++------
>   tools/testing/selftests/amd-pstate/tbench.sh  |  4 ++--
>   4 files changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> index 904df0ea0a1e..2448bb07973f 100755
> --- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> +++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> @@ -30,7 +30,7 @@ import getopt
>   import Gnuplot
>   from numpy import *
>   from decimal import *
> -sys.path.append('../intel_pstate_tracer')
> +sys.path.append(os.path.join(os.path.dirname(__file__), '../intel_pstate_tracer'))
>   #import intel_pstate_tracer
>   import intel_pstate_tracer as ipt
>   
> diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
> index 5f2171f0116d..c327444d3506 100755
> --- a/tools/testing/selftests/amd-pstate/gitsource.sh
> +++ b/tools/testing/selftests/amd-pstate/gitsource.sh
> @@ -66,12 +66,15 @@ post_clear_gitsource()
>   
>   install_gitsource()
>   {
> -	if [ ! -d $git_name ]; then
> +	if [ ! -d $SCRIPTDIR/$git_name ]; then
> +		BACKUP_DIR=$(pwd)
> +		cd $SCRIPTDIR
>   		printf "Download gitsource, please wait a moment ...\n\n"
>   		wget -O $git_tar $gitsource_url > /dev/null 2>&1
>   
>   		printf "Tar gitsource ...\n\n"
>   		tar -xzf $git_tar
> +		cd $BACKUP_DIR
>   	fi
>   }
>   
> @@ -79,12 +82,13 @@ install_gitsource()
>   run_gitsource()
>   {
>   	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
> -	./amd_pstate_trace.py -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
> +	$SCRIPTDIR/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
>   
>   	printf "Make and test gitsource for $1 #$2 make_cpus: $MAKE_CPUS\n"
> -	cd $git_name
> -	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o ../$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > ../$OUTFILE_GIT-perf-$1-$2.log 2>&1
> -	cd ..
> +	BACKUP_DIR=$(pwd)
> +	cd $SCRIPTDIR/$git_name
> +	$PERF stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o $BACKUP_DIR/$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > $BACKUP_DIR/$OUTFILE_GIT-perf-$1-$2.log 2>&1
> +	cd $BACKUP_DIR
>   
>   	for job in `jobs -p`
>   	do
> diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
> index de4d8e9c9565..0803e70b04da 100755
> --- a/tools/testing/selftests/amd-pstate/run.sh
> +++ b/tools/testing/selftests/amd-pstate/run.sh
> @@ -8,9 +8,11 @@ else
>   	FILE_MAIN=DONE
>   fi
>   
> -source basic.sh
> -source tbench.sh
> -source gitsource.sh
> +SCRIPTDIR=`dirname "$0"`
> +
> +source $SCRIPTDIR/basic.sh
> +source $SCRIPTDIR/tbench.sh
> +source $SCRIPTDIR/gitsource.sh
>   

Rather than hardcoding 
$SCRIPTDIR/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py in 
multiple places, how about you delcare a new variable here?

TRACER=$SCRIPTDIR/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py

Then all the commands can be called with $TRACER instead.

Furthermore if there needs to be flexibility for multiple calling paths 
in the future (say in tree vs in filessytem) then you can easily add 
another case right here that is:

if [ ! -f $TRACER ]; then
     TRACER=foo/bar/baz
fi

>   # amd-pstate-ut only run on x86/x86_64 AMD systems.
>   ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
> @@ -22,6 +24,7 @@ OUTFILE=selftest
>   OUTFILE_TBENCH="$OUTFILE.tbench"
>   OUTFILE_GIT="$OUTFILE.gitsource"
>   
> +PERF=/usr/bin/perf
>   SYSFS=
>   CPUROOT=
>   CPUFREQROOT=
> @@ -149,8 +152,9 @@ help()
>   	     gitsource: Gitsource testing.>]
>   	[-t <tbench time limit>]
>   	[-p <tbench process number>]
> -	[-l <loop times for tbench>]
> +	[-l <loop times for tbench/gitsource>]
>   	[-i <amd tracer interval>]
> +	[-b <perf binary>]
>   	[-m <comparative test: acpi-cpufreq>]
>   	\n"
>   	exit 2
> @@ -158,7 +162,7 @@ help()
>   
>   parse_arguments()
>   {
> -	while getopts ho:c:t:p:l:i:m: arg
> +	while getopts ho:c:t:p:l:i:b:m: arg
>   	do
>   		case $arg in
>   			h) # --help
> @@ -189,6 +193,10 @@ parse_arguments()
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
> @@ -202,8 +210,8 @@ parse_arguments()
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
> index 49c9850341f6..70e5863e74ea 100755
> --- a/tools/testing/selftests/amd-pstate/tbench.sh
> +++ b/tools/testing/selftests/amd-pstate/tbench.sh
> @@ -64,11 +64,11 @@ post_clear_tbench()
>   run_tbench()
>   {
>   	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
> -	./amd_pstate_trace.py -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
> +	$SCRIPTDIR/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
>   
>   	printf "Test tbench for $1 #$2 time_limit: $TIME_LIMIT procs_num: $PROCESS_NUM\n"
>   	tbench_srv > /dev/null 2>&1 &
> -	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ tbench -t $TIME_LIMIT $PROCESS_NUM > $OUTFILE_TBENCH-perf-$1-$2.log 2>&1
> +	$PERF stat -a --per-socket -I 1000 -e power/energy-pkg/ tbench -t $TIME_LIMIT $PROCESS_NUM > $OUTFILE_TBENCH-perf-$1-$2.log 2>&1
>   
>   	pid=`pidof tbench_srv`
>   	kill $pid

