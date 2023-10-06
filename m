Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4544E7BBF85
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 21:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjJFTF6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 15:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjJFTFr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 15:05:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1029D1A4;
        Fri,  6 Oct 2023 12:05:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jG+C0lpPYS1JVtqvYRBA5ANbuRXGBDT6ZxlSoUDufbP/l8lK9xEbJExm0+xhl6Ib2ZvWP7nMqH066GedvoKYE0vzgzrBsRT9z1aC/qF+7C94ttQs9r7QjUrwwCpZ26dL1AVhvMhIDy8u2L27lIz2C9zQeo5xZwpk+Tp3dD+oOnkg6lXnZJH77WbYsfwIBn350z9SslGDCS6bSZcC3Efk0vM5GvWVnrkCpTlXm91AFSTdntOC2yEl3VQfn7E2jt3BS+xBuGvtDN5HPIHcja/YARB2+xa4OuX4k2QjTFgsFc4pPEWflZcu/TCy9yEDZu8hxHQNOsfxTtj1cWtLEpzKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwUcnRwb5OJsHAno5oCv+fx2M70GFCqTTmd9JU1rm6U=;
 b=FG0X/BQIjKCelxwoP/moUzyCHSMmxqJyKJr9Qd6OvoLpR+fxqS/Wtkpi/uadMXJcoxniZ5ywLZ6g09T63LalWWAq35/VKzCO+Vp6Q2q7rvIv+M/DMqpPi4ei06yiZSybGm4FSGLQM2/1wInYoe598tCwYsHe9Mn/HaaiZQ5CWCsX2hufKIc1VNxHcLXGSVa0PUdhwIsVuX/It7do+c+2i1o/L+RvnnoELOAqIwagP/915dKKt8/BjGz1CIuk0O7geTNO7a8DZlKmt+d52dhGUaELwsxpTKs7Tl0X66StDonZ0WjIkXc97zKZ2dgxEWFxwyPqyzEBbQTiPgrb3LQDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwUcnRwb5OJsHAno5oCv+fx2M70GFCqTTmd9JU1rm6U=;
 b=GXGHjspVWz6vTTHtMBEh4vwmrPIYcq1iyH1AYLGIOxTpmOWXqhXn7fzNR43UIgzw4PKdgE1/bQSQ1DCK2xGKbiu7h4uXhgBAbxC00ymJWbXNTbtbvkcf23kENdGZTFAukOw5xM6eXRlZYFnoOcWTuH6cqG2Sqec8VtPdcpybibs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB5122.namprd12.prod.outlook.com (2603:10b6:610:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 19:05:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 19:05:34 +0000
Message-ID: <81dd0b57-107a-4954-966b-c2f98d4b1bec@amd.com>
Date:   Fri, 6 Oct 2023 14:05:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] selftests/amd-pstate: Fix broken paths to run
 workloads in amd-pstate-ut
Content-Language: en-US
To:     Swapnil Sapkal <swapnil.sapkal@amd.com>, ray.huang@amd.com,
        shuah@kernel.org
Cc:     sukrut.bellary@gmail.com, li.meng@amd.com, gautham.shenoy@amd.com,
        wyes.karny@amd.com, Perry.Yuan@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20231003051006.6343-1-swapnil.sapkal@amd.com>
 <20231003051006.6343-2-swapnil.sapkal@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231003051006.6343-2-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0173.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: ff93cb03-8829-4d35-5370-08dbc69f37e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmLGyA8Z281XDU6/vPeN5Coni2b/OqkTCMLe1maAvr//zwxokUO0enXBOCe/XOd/py7fZmCDNME7Wc2T+jY2p3nbhY1qTj7GePV54/RQYzFGUnA3qIYFz3gAysW9DkbOGE5RyuF+AHQfxqnjk9jpPLPMsNFAVaF7hW+2PgURf3rEKqEneJt5fwHMzMtBiuZ6V4AFXUNtAY+LR+KSAZ6sGKkHhebqjtw0wlzBlfF40jyjLlbT/OHP3uZgwN/0CCr/9BhKXNXG9Z98JLOcd3sI0XDwBzmj5RNOAMrzFBlyG27OTg1Lq5hpMEcdELVhcW0IwXwwaFydxthdePannJ/o+nfk+l2eideRGvPHQ9hjneHTkVqdOSBt2x89dRQkyvukH1rz7k1/Kl+v1dUHQ3EqOheamskyK1Gc0cemyXItrmPzXSxkZ4IOoXl1i5Hx54Q5xbsdH62jAB9X+uNBuZSWMpwZoPytZGC/nOdI2ZtcMiA+q57rKf+riRTU4TyzXIwrpHueBtSAtQgY89JbQo4eGg2Gs+HiDU89YEWgoPgalfSuAA1Af2bMRUDZ8x1JdFcVqNX6gz2TMFb331S0EIsGuAxyUQHWZvw5rHiR1QsG+MZjUEuxLBPSwufN58QBnmQu5juRM+ofqbuVcp1bcfUCug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31696002)(2906002)(6486002)(6506007)(53546011)(86362001)(41300700001)(31686004)(83380400001)(26005)(44832011)(6512007)(8936002)(8676002)(4326008)(316002)(6666004)(38100700002)(66556008)(66476007)(66946007)(5660300002)(2616005)(36756003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajhscUtUM1lhY1dlT1hHT0txNUpLSWxOVk1TcG9IVFQ1NVZCek1XZ2FxTjR1?=
 =?utf-8?B?bEcxTE85SXJzMldJYWVNYkJycTBpUkhrNFdiQnJGeUZhNlFKdm9mMFgzK2Jt?=
 =?utf-8?B?YTBHak5NcllYd3QzVDQ4UTZQV0ZtNzl5ZDVEejU1bEYzTXJJRExZUnN1bHdI?=
 =?utf-8?B?bUNaRzhYWk5La2QyM3dJemlLY2lIMW1Dc2h0MDVlMWE0UmFMKzgzNkdiYm5N?=
 =?utf-8?B?RHFSSUdtYWlJazBNdkVKWjNIbmpxZi9tN1E2dzR4cWdXNHMzRm5PS2dOc3Bk?=
 =?utf-8?B?TmUyR1krc2RGWGlhdGRTallKYyt6bnAzWXIzSlpMbUxCUjR3T1JyWWVsTy9p?=
 =?utf-8?B?c3FGMzlQd1dHc0xaK2Q2UllvUnJKNEE0STQvN3UvNTdaNGVhajVvaFNwMzhz?=
 =?utf-8?B?bWd0SDN0NDYvOTdoTGNlcVpUR21zYlNyQStEbEtWMFQ5NUNtMmNHVFdia1Y1?=
 =?utf-8?B?YkdORzFDdHRlZUYrMEt3emxCTktTSDcxS2xBOHRlZkFYUFM2QTJ1c3ZFL3Bj?=
 =?utf-8?B?Y05raDlqeDVaZDNCSHcxVTd0bXhqYnhIT2MydlBhbEx2MTVLRXh1OFZHZERq?=
 =?utf-8?B?aHJxTDRKSUJnNzBMMW5oZXlUVTlJRFpUNnlWbjNrR0g1OUZucWx0cExRR0hr?=
 =?utf-8?B?MUNRMnFGMm11dExESmdpYlFkNCtZZThRNGhQWkY2K2xWeHBtaWpTekVYaUhR?=
 =?utf-8?B?MjFZYXlHdDRnRlkzaEp0cVJidDZUSkRkVVFNMUxzd2RvSTFpeUg1Zzg4YUJB?=
 =?utf-8?B?SGRjTHFmSThTYzdFUk9NNVBpOVNwbWxTemlVZDJLcTVoNDBiejRydzh6c1FC?=
 =?utf-8?B?TTUwbnRZcFN4NFVaWDFIVWlPZTJDOVBBNzFLeFJza215TFpFM2xrTVpPZlFB?=
 =?utf-8?B?bUVDcHZ1bEM2WHJ6dUFSVnBkSHZnV0tyaDUyQW9QcllDWHExR1dyc2M1ZzJu?=
 =?utf-8?B?cTJrVFJLeUtOdldHRnpPVkhGRGI1YXJ0SDM5dUlFRThTc1hUZHIwNjJ6VElP?=
 =?utf-8?B?VjRaaG10NGkybUpBK2lrcEpIMFAvS0VwLzZ5czBjTDVHMDJUSUZCc1JMUnI3?=
 =?utf-8?B?MkFWb093TmNFdGhLR0NHSmRuQWd0dWZDRU1YN0ljZ2RDN2JKWktOOEF3Y0lI?=
 =?utf-8?B?VjAxa0NOK0JBV01RZ0pZSjVMWTd4Yk16RmRxM2FSZFIrRzE3bTVuTzJQRkVO?=
 =?utf-8?B?NFpoS254bEhuODlWbFRCUUxFT3FVWGl2OHpRRUlRdm9ZV0l6cjgwd29PamI1?=
 =?utf-8?B?TUF0WHgwWTMxU2R1Q1dBU3lnUWtheWpMOGpocWdwaGhVM1AyTDlyV1pTUW5i?=
 =?utf-8?B?cGx1TjRaQXJESTE3VG14OWliYlY4RVpCUUVvcUdaaC9veXV4RzlpRWJFbkp3?=
 =?utf-8?B?ZUM5eXdSci8rQmJBVnRWRExXUEUxRHRjZDBOVmd4RFRxZG5Iblpab0dLQlJi?=
 =?utf-8?B?RTdETU1DVDBBS0dBUHVjUlByeERNaSs2RjZkZmtNNzFGUnhNWlFkcWlNM09j?=
 =?utf-8?B?YklGWlNtcnhTOGZXRmJDR0tPOTQvaDdLZ0toK2hIMDF2Vy9kUSsreDJ6Ky8y?=
 =?utf-8?B?elBnTHMrYmkwZXlhSXpueEtvSkFCaWhZSmFnU0dvQUZQVUt5UzZpNVpVei93?=
 =?utf-8?B?d2VYUk5pMjJiakc2ZkluOGduRXNUVHFCVUFYSjFybExDZDhUcFhlblo2Vk1T?=
 =?utf-8?B?Rms2ckpuc3l4L293MFVlanJ5L2FxVmRQTHJ6bmpscG1hZHBNVlA4MWt0cnpH?=
 =?utf-8?B?RnRJWHdDWDVyS2EzQm9OREdTSWxvNTZLblZXT2ZMWG53dVRkeTVmbzlTVCtY?=
 =?utf-8?B?K0pSRllQb2xlUTBqNFp1M3NRbXlGY2cwdU43cDRUQlBrOExYbTQ2d0JjY0x2?=
 =?utf-8?B?cUErdDAzVlVMV1daTW5uQk53RGlmSEcyMFBXZFNRQlgwVUVrcFFHd3Z3b2R6?=
 =?utf-8?B?aWdDYXEwUXRCRnk5WDVxdThZQ1NnSktubU9GeGJqVXR0OU9XL0JtSUpFZzFL?=
 =?utf-8?B?RXlHN1VKdXY1K2Q1dUV4U0lTSWxkRis4MmNjeWwxaENRTHNQcFZINUQxU2d4?=
 =?utf-8?B?L0tpK2gzTDFzRHU4a3R1Uk1DNSt2amUycm9GWEJBMC8rK051Q1lMcGRCRHBU?=
 =?utf-8?Q?L6Ha9+Zr69Bu0T9U2GzlAhQ+Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff93cb03-8829-4d35-5370-08dbc69f37e6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 19:05:34.6148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQ3t8Ty0pfX3fnQtvvJD9qz6IyG5YkfKxbOSpxNjbLbFmn2gmvvq9+irjfHnpaR4UqGXcLN1KNBaLek8HDCtvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5122
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/3/2023 00:10, Swapnil Sapkal wrote:
> In selftests/amd-pstate, tbench and gitsource microbenchmarks are
> used to compare the performance with different governors. In Current

s/Current/current/

> implementation relative path to run `amd_pstate_tracer.py` are broken.

The plurality of this sentence needs some work.  I suggest:

s,relative,the relative,
s,are broken,is broken,

> Fixed this by using absolute paths.

The tense is wrong.

s,Fixed,Fix/,

> 
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>   .../x86/amd_pstate_tracer/amd_pstate_trace.py      |  2 +-
>   tools/testing/selftests/amd-pstate/gitsource.sh    | 14 +++++++++-----
>   tools/testing/selftests/amd-pstate/run.sh          |  9 ++++++---
>   tools/testing/selftests/amd-pstate/tbench.sh       |  2 +-
>   4 files changed, 17 insertions(+), 10 deletions(-)
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

If you're using os.path.join, shouldn't you not be hardcoding a "/" in 
there?

IE it should be:

sys.path.append(os.path.join(os.path.dirname(__file__), "..", 
"intel_pstate_tracer"))

>   #import intel_pstate_tracer

I think another patch should remove this commented line, it conveys zero 
information.

>   import intel_pstate_tracer as ipt
>   
> diff --git a/tools/testing/selftests/amd-pstate/gitsource.sh b/tools/testing/selftests/amd-pstate/gitsource.sh
> index 5f2171f0116d..d0ad2ed5ba9d 100755
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

If you change to /bin/bash instead of /bin/sh you could use pushd/popd 
instead.  If your goal is to keep compatibility with things like 
/bin/dash then this makes ense.

>   	fi
>   }
>   
> @@ -79,12 +82,13 @@ install_gitsource()
>   run_gitsource()
>   {
>   	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
> -	./amd_pstate_trace.py -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
> +	$TRACER -n tracer-gitsource-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
>   
>   	printf "Make and test gitsource for $1 #$2 make_cpus: $MAKE_CPUS\n"
> -	cd $git_name
> -	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o ../$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > ../$OUTFILE_GIT-perf-$1-$2.log 2>&1
> -	cd ..
> +	BACKUP_DIR=$(pwd)
> +	cd $SCRIPTDIR/$git_name
> +	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ /usr/bin/time -o $BACKUP_DIR/$OUTFILE_GIT.time-gitsource-$1-$2.log make test -j$MAKE_CPUS > $BACKUP_DIR/$OUTFILE_GIT-perf-$1-$2.log 2>&1
> +	cd $BACKUP_DIR

Similar pushd/popd comment could apply here.
>   
>   	for job in `jobs -p`
>   	do
> diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
> index de4d8e9c9565..279d073c5728 100755
> --- a/tools/testing/selftests/amd-pstate/run.sh
> +++ b/tools/testing/selftests/amd-pstate/run.sh
> @@ -8,9 +8,12 @@ else
>   	FILE_MAIN=DONE
>   fi
>   
> -source basic.sh
> -source tbench.sh
> -source gitsource.sh
> +SCRIPTDIR=`dirname "$0"`
> +TRACER=$SCRIPTDIR/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> +
> +source $SCRIPTDIR/basic.sh
> +source $SCRIPTDIR/tbench.sh
> +source $SCRIPTDIR/gitsource.sh
>   
>   # amd-pstate-ut only run on x86/x86_64 AMD systems.
>   ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
> diff --git a/tools/testing/selftests/amd-pstate/tbench.sh b/tools/testing/selftests/amd-pstate/tbench.sh
> index 49c9850341f6..4d2e8ce2da3b 100755
> --- a/tools/testing/selftests/amd-pstate/tbench.sh
> +++ b/tools/testing/selftests/amd-pstate/tbench.sh
> @@ -64,7 +64,7 @@ post_clear_tbench()
>   run_tbench()
>   {
>   	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
> -	./amd_pstate_trace.py -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
> +	$TRACER -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
>   
>   	printf "Test tbench for $1 #$2 time_limit: $TIME_LIMIT procs_num: $PROCESS_NUM\n"
>   	tbench_srv > /dev/null 2>&1 &

