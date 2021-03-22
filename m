Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E99534444D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 14:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhCVM70 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 08:59:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232692AbhCVM4n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 08:56:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MCZ1St014561;
        Mon, 22 Mar 2021 08:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0mSfWC59MX+L/ohSdeTAaVYqIXet0qPJIICLvOzvvKI=;
 b=lYEQFjpPnFZXtHaGQYq96lbtRfVsrwRn2LI+Zhcc2S+kxm86oo3lDgUeYoRPMVSuNFMH
 Vjo4Sna8cZn5+L6pLaoOxEk6E2+Iwu4DJTd914mfdk4bPk4rseW39k8GRTdZMapzJ1ig
 tWz+DaIXyUcWIv4syMxsdPUgcjiupgGb0gb2HdWGvsh2D9BScy/Vo/rJr/8Js3oOcBBP
 HMr0f+fLGGcdt9tqwPMuBUNdHB+mKMotJ+CBPhrpbb7m4JIYn8eecgWN6Y6y7v+7le+0
 qO+NiLX1LP9F3WyEImepEvX2+Jt02+4tuDNGX1NJdVNf6CaE1Oae3+Q08yZviuTSUhx7 Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dxjvqvcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 08:56:37 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12MCZ4ao015555;
        Mon, 22 Mar 2021 08:56:36 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37dxjvqvbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 08:56:36 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12MChvai002018;
        Mon, 22 Mar 2021 12:56:34 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 37d9bps7am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 12:56:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12MCuEI035193226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 12:56:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2020F4203F;
        Mon, 22 Mar 2021 12:56:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB46742049;
        Mon, 22 Mar 2021 12:56:29 +0000 (GMT)
Received: from [9.85.90.183] (unknown [9.85.90.183])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Mar 2021 12:56:29 +0000 (GMT)
Subject: Re: [RFC 2/2] selftest/cpuidle: Add support for cpuidle latency
 measurement
To:     Doug Smythies <dsmythies@telus.net>
Cc:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com
References: <20210315114827.46036-1-psampat@linux.ibm.com>
 <20210315114827.46036-3-psampat@linux.ibm.com>
 <CAAYoRsW-E_Rek-c=e3xr8dTNUWud1AkndNaNySCZpt=h1qSf7g@mail.gmail.com>
 <5d001a54-68ca-4cb8-4beb-4e5210f03677@linux.ibm.com>
 <CAAYoRsWcLr7E=He8EGTAom5nKgY3OU1E9Reyx10qPwAxsTFOsg@mail.gmail.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <cc4eb602-4fb8-2cc2-1233-eedab8206de9@linux.ibm.com>
Date:   Mon, 22 Mar 2021 18:26:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAAYoRsWcLr7E=He8EGTAom5nKgY3OU1E9Reyx10qPwAxsTFOsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_07:2021-03-22,2021-03-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220091
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Doug,

On 20/03/21 8:34 pm, Doug Smythies wrote:
> On Wed, Mar 17, 2021 at 11:44 PM Pratik Sampat <psampat@linux.ibm.com> wrote:
>> Hi Doug,
>> Thanks for trying these patches out.
>>
>> On 18/03/21 2:30 am, Doug Smythies wrote:
>>> Hi Pratik,
>>>
>>> It just so happens that I have been trying Artem's version this last
>>> week, so I tried yours.
>>>
>>> On Mon, Mar 15, 2021 at 4:49 AM Pratik Rajesh Sampat
>>> <psampat@linux.ibm.com> wrote:
>>> ...
> ...
>>> Other notes:
>>>
>>> No idle state for CPU 0 ever gets disabled.
>>> I assume this is because CPU 0 can never be offline,
>>> so that bit of code (Disable all stop states) doesn't find its state.
>>> By the way, processor = Intel i5-9600K
>> I had tried these patches on an IBM POWER 9 processor and disabling CPU0's idle
>> state works there. However, it does make sense for some processors to treat CPU
>> 0 differently.
>> Maybe I could write in a case if idle state disabling fails for a CPU then we
>> just skip it?
> I didn't try it, I just did a hack so I could continue for this reply.

Sure. In subsequent version I could write something to cleanly handle online
fail checks, maybe even specifically for CPU0.

>>> The system is left with all idle states disabled, well not for CPU 0
>>> as per the above comment. The suggestion is to restore them,
>>> otherwise my processor hogs 42 watts instead of 2.
>>>
>>> My results are highly variable per test.
>> Question: Do you notice high variability with IPI test, Timer test or both?
> The IPI test has less variability than the Timer test.
>
>> I can think of two reasons for high run to run variance:
>>
>> 1. If you observe variance in timer tests, then I believe there could a
>> mechanism of "C-state pre-wake" on some Intel machines at play here, which can
>> pre-wake a CPU from an idle state when timers are armed. I'm not sure if the
>> Intel platform that you're running on does that or not.
>>
>> Artem had described this behavior to me a while ago and I think his wult page
>> describes this behavior in more detail:
>> https://intel.github.io/wult/#c-state-pre-wake
> Yes, I have reviewed all the references.
> And yes, I think my processors have the pre-wake stuff.
>
> I do not have the proper hardware to do the Artem pre-wake workaround
> method, but might buy it in future.

That explains the variability that we are seeing in the Timer tests on the
Intel processor you've tried on.
Also based on the data pasted below, it means that the IPI tests are more
reliable than Timers.

Maybe it would be better to not run the Timer test on Intel platforms that
support this pre-wakeup feature?
However, I don't know how (or if) Intel exposes this information to the
userspace and if other platforms like AMD also have this feature in some form.

Another way of solving this problem could be to have the timer test as an
optional parameter in the selftest for people to use while also printing a
disclaimer for x86 users about the potential hardware design?

--
Thanks
Pratik

>> 2. I have noticed variability in results when there are kernel book-keeping or
>> jitter tasks scheduled from time to time on an otherwise idle core.
>> In the full per-CPU logs at tools/testing/selftests/cpuidle/cpuidle.log can you
>> spot any obvious outliers per-CPU state?
> Yes.
> I'll just paste in an example cpuidle.log file having used the -v option
> below, along with my hack job diff.
>
> doug@s19:~/temp-k-git/linux/tools/testing/selftests/cpuidle$ cat
> cpuidle.log.v3-1
> --IPI Latency Test---
> --Baseline IPI Latency measurement: CPU Busy--
> SRC_CPU   DEST_CPU IPI_Latency(ns)
> 0            0          140
> 0            1          632
> 0            2          675
> 0            3          671
> 0            4          675
> 0            5          767
> 0            6          653
> 0            7          826
> 0            8          819
> 0            9          615
> 0           10          758
> 0           11          758
> Baseline Avg IPI latency(ns): 665
> ---Enabling state: 0---
> SRC_CPU   DEST_CPU IPI_Latency(ns)
> 0            0           76
> 0            1          484
> 0            2          494
> 0            3          539
> 0            4          498
> 0            5          491
> 0            6          474
> 0            7          434
> 0            8          544
> 0            9          476
> 0           10          447
> 0           11          467
> Expected IPI latency(ns): 0
> Observed Avg IPI latency(ns) - State 0: 452
> ---Enabling state: 1---
> SRC_CPU   DEST_CPU IPI_Latency(ns)
> 0            0           72
> 0            1         1081
> 0            2          821
> 0            3         1486
> 0            4         1022
> 0            5          960
> 0            6         1634
> 0            7          933
> 0            8         1032
> 0            9         1046
> 0           10         1430
> 0           11         1338
> Expected IPI latency(ns): 1000
> Observed Avg IPI latency(ns) - State 1: 1071
> ---Enabling state: 2---
> SRC_CPU   DEST_CPU IPI_Latency(ns)
> 0            0          264
> 0            1        30836
> 0            2        30562
> 0            3        30748
> 0            4        35286
> 0            5        30978
> 0            6         1952
> 0            7        36066
> 0            8        30670
> 0            9        30605
> 0           10        30635
> 0           11        35423
> Expected IPI latency(ns): 120000
> Observed Avg IPI latency(ns) - State 2: 27002
> ---Enabling state: 3---
> SRC_CPU   DEST_CPU IPI_Latency(ns)
> 0            0           71
> 0            1        30853
> 0            2        32095
> 0            3        32661
> 0            4        30230
> 0            5        34348
> 0            6         2012
> 0            7        30816
> 0            8        30908
> 0            9        31130
> 0           10        34150
> 0           11        32050
> Expected IPI latency(ns): 1034000
> Observed Avg IPI latency(ns) - State 3: 26777
>
> --Timeout Latency Test--
> --Baseline Timeout Latency measurement: CPU Busy--
> Wakeup_src Baseline_delay(ns)
> 0             453
> 1             568
> 2             387
> 3             337
> 4             433
> 5             579
> 6             330
> 7             400
> 8             561
> 9             544
> 10            569
> 11            523
> Baseline Avg timeout diff(ns): 473
> ---Enabling state: 0---
> Wakeup_src Baseline_delay(ns)  Delay(ns)
> 0             399
> 1             388
> 2             352
> 3             385
> 4             334
> 5             415
> 6             320
> 7             356
> 8             401
> 9             379
> 10            339
> 11            384
> Expected timeout(ns): 200
> Observed Avg timeout diff(ns) - State 0: 371
> ---Enabling state: 1---
> Wakeup_src Baseline_delay(ns)  Delay(ns)
> 0             666
> 1             575
> 2             608
> 3             590
> 4             608
> 5             552
> 6             582
> 7             593
> 8             597
> 9             587
> 10            588
> 11            610
> Expected timeout(ns): 1200
> Observed Avg timeout diff(ns) - State 1: 596
> ---Enabling state: 2---
> Wakeup_src Baseline_delay(ns)  Delay(ns)
> 0           36386
> 1            1069
> 2             866
> 3             884
> 4             850
> 5           55642
> 6          408082
> 7            1184
> 8          406075
> 9          406830
> 10         414105
> 11         406594
> Expected timeout(ns): 360200
> Observed Avg timeout diff(ns) - State 2: 178213
> ---Enabling state: 3---
> Wakeup_src Baseline_delay(ns)  Delay(ns)
> 0          406049
> 1             913
> 2          410134
> 3             921
> 4          406237
> 5             950
> 6          407181
> 7             920
> 8          407678
> 9             894
> 10         406320
> 11         304161
> Expected timeout(ns): 3102200
> Observed Avg timeout diff(ns) - State 3: 229363
>
>
> My hack job, (CPUs always online):
>
> diff --git a/tools/testing/selftests/cpuidle/cpuidle.sh
> b/tools/testing/selftests/cpuidle/cpuidle.sh
> index de5141d5b76b..70bdacda5e91 100755
> --- a/tools/testing/selftests/cpuidle/cpuidle.sh
> +++ b/tools/testing/selftests/cpuidle/cpuidle.sh
> @@ -86,10 +86,6 @@ disable_idle()
>   {
>          for ((cpu=0; cpu<NUM_CPUS; cpu++))
>          do
> -               local cpu_status=$(cpu_is_online $cpu)
> -               if [ $cpu_status == 0 ]; then
> -                       continue
> -               fi
>                  for ((state=0; state<NUM_STATES; state++))
>                  do
>                          echo 1 >
> /sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable
> @@ -104,10 +100,6 @@ op_state()
>   {
>          for ((cpu=0; cpu<NUM_CPUS; cpu++))
>          do
> -               local cpu_status=$(cpu_is_online $cpu)
> -               if [ $cpu_status == 0 ]; then
> -                       continue
> -               fi
>                  echo $1 >
> /sys/devices/system/cpu/cpu$cpu/cpuidle/state$2/disable
>          done
>   }
> @@ -124,17 +116,6 @@ cpuidle_disable_state()
>          op_state 1 $state
>   }
>
> -cpu_is_online()
> -{
> -       cpu=$1
> -       if [ ! -f "/sys/devices/system/cpu/cpu$cpu/online" ]; then
> -               echo 0
> -               return
> -       fi
> -       status=$(cat /sys/devices/system/cpu/cpu$cpu/online)
> -       echo $status
> -}
> -
>   # Extract latency in microseconds and convert to nanoseconds
>   extract_latency()
>   {
> @@ -179,10 +160,6 @@ run_ipi_tests()
>          printf "%s %10s %12s\n" "SRC_CPU" "DEST_CPU" "IPI_Latency(ns)" >> $LOG
>          for ((cpu=0; cpu<NUM_CPUS; cpu+=SMT))
>          do
> -               local cpu_status=$(cpu_is_online $cpu)
> -               if [ $cpu_status == 0 ]; then
> -                       continue
> -               fi
>                  ipi_test_once "baseline" $cpu
>                  printf "%-3s %10s %12s\n" $src_cpu $cpu $ipi_latency >> $LOG
>                  avg_arr+=($ipi_latency)
> @@ -198,10 +175,6 @@ run_ipi_tests()
>                  printf "%s %10s %12s\n" "SRC_CPU" "DEST_CPU"
> "IPI_Latency(ns)" >> $LOG
>                  for ((cpu=0; cpu<NUM_CPUS; cpu+=SMT))
>                  do
> -                       local cpu_status=$(cpu_is_online $cpu)
> -                       if [ $cpu_status == 0 ]; then
> -                               continue
> -                       fi
>                          # Running IPI test and logging results
>                          sleep 1
>                          ipi_test_once "test" $cpu
> @@ -262,10 +235,6 @@ run_timeout_tests()
>          printf "%s %10s %10s\n" "Wakeup_src" "Baseline_delay(ns)">> $LOG
>          for ((cpu=0; cpu<NUM_CPUS; cpu+=SMT))
>          do
> -               local cpu_status=$(cpu_is_online $cpu)
> -               if [ $cpu_status == 0 ]; then
> -                       continue
> -               fi
>                  timeout_test_once "baseline" $cpu 1000000
>                  printf "%-3s %13s\n" $src_cpu $timeout_diff >> $LOG
>                  avg_arr+=($timeout_diff)
> @@ -281,10 +250,6 @@ run_timeout_tests()
>                  printf "%s %10s %10s\n" "Wakeup_src"
> "Baseline_delay(ns)" "Delay(ns)" >> $LOG
>                  for ((cpu=0; cpu<NUM_CPUS; cpu+=SMT))
>                  do
> -                       local cpu_status=$(cpu_is_online $cpu)
> -                       if [ $cpu_status == 0 ]; then
> -                               continue
> -                       fi
>                          timeout_test_once "test" $cpu 1000000
>                          printf "%-3s %13s %18s\n" $src_cpu
> $baseline_timeout_diff $timeout_diff >> $LOG
>                          avg_arr+=($timeout_diff)
> @@ -314,3 +279,7 @@ run_timeout_tests
>   printf "Removing $MODULE module\n"
>   printf "Full Output logged at: $LOG\n"
>   rmmod $MODULE
> +
> +printf "enabling idle states\n"
> +
> +echo 0 | tee /sys/devices/system/cpu/cpu*/cpuidle/state*/disable
> (END)

