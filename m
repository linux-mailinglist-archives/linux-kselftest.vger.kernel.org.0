Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECA7342D88
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Mar 2021 16:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCTPFS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Mar 2021 11:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCTPFF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Mar 2021 11:05:05 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064ECC061763
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Mar 2021 08:05:04 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id t14so936114ilu.3
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Mar 2021 08:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTdkfzavYsU7uBmZflWHnpMTXrjQ4GrLQWSm3Aw52qU=;
        b=N0RfnUOXW2oeWI9H7WqZV2lqxmfz9BEWPbk4WW85x/gRDtSG676KWxq8ch4mTFLYky
         NYpjUDCoWdzRjqn2MMcMlR3r5LennwHo+BpZFOcFlrsWqit1qT1NZ1gknaAhY2WhGWMm
         ov3K1bIKJ9HRArMK7wX7qdSxxkCcuR8IHmECP35EVfakGrauNX2NPgqQxMTSVf9a4XLs
         43GfMZagjOoxMXfNNzSlTuTFS3t9P0RNAom7YuwY22ttoI0DPphOswCj4r6j/FTYOdPT
         DlLJLszVMS9VXLDsRNOuEuqNuvHrf8CeuMMR/fYMNPuYmwBybopAIpThXSKMe2DFQcpg
         WRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTdkfzavYsU7uBmZflWHnpMTXrjQ4GrLQWSm3Aw52qU=;
        b=RrdPGQ5XkigSFRefVLvUYyk1xYzOmbc8uIOkuIC1lIBgHJ+sn/Kq0d2bJ1JDu8u8ni
         i0wbcX8i0PUGcPYTT/eTdX5oyNruQU3yvOZNoA0tsXeb8c0ryQTfkkJfMDQHXodPzcaU
         +G1SegmdLEZ/e2t2K/yqn1sxbVsihieF5nullpE36WJwDdJfK/SfBu175phK1HT63qNl
         Zzqxr3qVs0L6/X+g75CxqPTz+dpLxXO8Tg6KGmeCkx1NMzja9rR+2MNNjqYq6VfnWM6j
         2MDZAqNzgfgpwP5eoztEA2ySyNg4ff5BDUF22JTNFAuPjFwMkN8ORdTaDzb4QpDgFpTK
         nCOg==
X-Gm-Message-State: AOAM530hzNhag6Dox7PR3ChSJdNCp22NorANlqXsu4MI1G3hi+nvfcmp
        z3YzOz1b4P2FQoyofzsADwiAyJsEyocEwVtPtMFspw==
X-Google-Smtp-Source: ABdhPJxQJeCZORI6jQ94bT1y/U2i0yYOczKeBSfvBGxFvygEBQK7qo8VttFEYHnkfLp8OzctL4NewG/ry/iMrZPYyvw=
X-Received: by 2002:a92:6511:: with SMTP id z17mr6183937ilb.232.1616252704239;
 Sat, 20 Mar 2021 08:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210315114827.46036-1-psampat@linux.ibm.com> <20210315114827.46036-3-psampat@linux.ibm.com>
 <CAAYoRsW-E_Rek-c=e3xr8dTNUWud1AkndNaNySCZpt=h1qSf7g@mail.gmail.com> <5d001a54-68ca-4cb8-4beb-4e5210f03677@linux.ibm.com>
In-Reply-To: <5d001a54-68ca-4cb8-4beb-4e5210f03677@linux.ibm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Sat, 20 Mar 2021 08:04:51 -0700
Message-ID: <CAAYoRsWcLr7E=He8EGTAom5nKgY3OU1E9Reyx10qPwAxsTFOsg@mail.gmail.com>
Subject: Re: [RFC 2/2] selftest/cpuidle: Add support for cpuidle latency measurement
To:     Pratik Sampat <psampat@linux.ibm.com>
Cc:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 17, 2021 at 11:44 PM Pratik Sampat <psampat@linux.ibm.com> wrote:
>
> Hi Doug,
> Thanks for trying these patches out.
>
> On 18/03/21 2:30 am, Doug Smythies wrote:
> > Hi Pratik,
> >
> > It just so happens that I have been trying Artem's version this last
> > week, so I tried yours.
> >
> > On Mon, Mar 15, 2021 at 4:49 AM Pratik Rajesh Sampat
> > <psampat@linux.ibm.com> wrote:
> > ...
...
> > Other notes:
> >
> > No idle state for CPU 0 ever gets disabled.
> > I assume this is because CPU 0 can never be offline,
> > so that bit of code (Disable all stop states) doesn't find its state.
> > By the way, processor = Intel i5-9600K
>
> I had tried these patches on an IBM POWER 9 processor and disabling CPU0's idle
> state works there. However, it does make sense for some processors to treat CPU
> 0 differently.
> Maybe I could write in a case if idle state disabling fails for a CPU then we
> just skip it?

I didn't try it, I just did a hack so I could continue for this reply.

> > The system is left with all idle states disabled, well not for CPU 0
> > as per the above comment. The suggestion is to restore them,
> > otherwise my processor hogs 42 watts instead of 2.
> >
> > My results are highly variable per test.
>
> Question: Do you notice high variability with IPI test, Timer test or both?

The IPI test has less variability than the Timer test.

>
> I can think of two reasons for high run to run variance:
>
> 1. If you observe variance in timer tests, then I believe there could a
> mechanism of "C-state pre-wake" on some Intel machines at play here, which can
> pre-wake a CPU from an idle state when timers are armed. I'm not sure if the
> Intel platform that you're running on does that or not.
>
> Artem had described this behavior to me a while ago and I think his wult page
> describes this behavior in more detail:
> https://intel.github.io/wult/#c-state-pre-wake

Yes, I have reviewed all the references.
And yes, I think my processors have the pre-wake stuff.

I do not have the proper hardware to do the Artem pre-wake workaround
method, but might buy it in future.

> 2. I have noticed variability in results when there are kernel book-keeping or
> jitter tasks scheduled from time to time on an otherwise idle core.
> In the full per-CPU logs at tools/testing/selftests/cpuidle/cpuidle.log can you
> spot any obvious outliers per-CPU state?

Yes.
I'll just paste in an example cpuidle.log file having used the -v option
below, along with my hack job diff.

doug@s19:~/temp-k-git/linux/tools/testing/selftests/cpuidle$ cat
cpuidle.log.v3-1
--IPI Latency Test---
--Baseline IPI Latency measurement: CPU Busy--
SRC_CPU   DEST_CPU IPI_Latency(ns)
0            0          140
0            1          632
0            2          675
0            3          671
0            4          675
0            5          767
0            6          653
0            7          826
0            8          819
0            9          615
0           10          758
0           11          758
Baseline Avg IPI latency(ns): 665
---Enabling state: 0---
SRC_CPU   DEST_CPU IPI_Latency(ns)
0            0           76
0            1          484
0            2          494
0            3          539
0            4          498
0            5          491
0            6          474
0            7          434
0            8          544
0            9          476
0           10          447
0           11          467
Expected IPI latency(ns): 0
Observed Avg IPI latency(ns) - State 0: 452
---Enabling state: 1---
SRC_CPU   DEST_CPU IPI_Latency(ns)
0            0           72
0            1         1081
0            2          821
0            3         1486
0            4         1022
0            5          960
0            6         1634
0            7          933
0            8         1032
0            9         1046
0           10         1430
0           11         1338
Expected IPI latency(ns): 1000
Observed Avg IPI latency(ns) - State 1: 1071
---Enabling state: 2---
SRC_CPU   DEST_CPU IPI_Latency(ns)
0            0          264
0            1        30836
0            2        30562
0            3        30748
0            4        35286
0            5        30978
0            6         1952
0            7        36066
0            8        30670
0            9        30605
0           10        30635
0           11        35423
Expected IPI latency(ns): 120000
Observed Avg IPI latency(ns) - State 2: 27002
---Enabling state: 3---
SRC_CPU   DEST_CPU IPI_Latency(ns)
0            0           71
0            1        30853
0            2        32095
0            3        32661
0            4        30230
0            5        34348
0            6         2012
0            7        30816
0            8        30908
0            9        31130
0           10        34150
0           11        32050
Expected IPI latency(ns): 1034000
Observed Avg IPI latency(ns) - State 3: 26777

--Timeout Latency Test--
--Baseline Timeout Latency measurement: CPU Busy--
Wakeup_src Baseline_delay(ns)
0             453
1             568
2             387
3             337
4             433
5             579
6             330
7             400
8             561
9             544
10            569
11            523
Baseline Avg timeout diff(ns): 473
---Enabling state: 0---
Wakeup_src Baseline_delay(ns)  Delay(ns)
0             399
1             388
2             352
3             385
4             334
5             415
6             320
7             356
8             401
9             379
10            339
11            384
Expected timeout(ns): 200
Observed Avg timeout diff(ns) - State 0: 371
---Enabling state: 1---
Wakeup_src Baseline_delay(ns)  Delay(ns)
0             666
1             575
2             608
3             590
4             608
5             552
6             582
7             593
8             597
9             587
10            588
11            610
Expected timeout(ns): 1200
Observed Avg timeout diff(ns) - State 1: 596
---Enabling state: 2---
Wakeup_src Baseline_delay(ns)  Delay(ns)
0           36386
1            1069
2             866
3             884
4             850
5           55642
6          408082
7            1184
8          406075
9          406830
10         414105
11         406594
Expected timeout(ns): 360200
Observed Avg timeout diff(ns) - State 2: 178213
---Enabling state: 3---
Wakeup_src Baseline_delay(ns)  Delay(ns)
0          406049
1             913
2          410134
3             921
4          406237
5             950
6          407181
7             920
8          407678
9             894
10         406320
11         304161
Expected timeout(ns): 3102200
Observed Avg timeout diff(ns) - State 3: 229363


My hack job, (CPUs always online):

diff --git a/tools/testing/selftests/cpuidle/cpuidle.sh
b/tools/testing/selftests/cpuidle/cpuidle.sh
index de5141d5b76b..70bdacda5e91 100755
--- a/tools/testing/selftests/cpuidle/cpuidle.sh
+++ b/tools/testing/selftests/cpuidle/cpuidle.sh
@@ -86,10 +86,6 @@ disable_idle()
 {
        for ((cpu=0; cpu<NUM_CPUS; cpu++))
        do
-               local cpu_status=$(cpu_is_online $cpu)
-               if [ $cpu_status == 0 ]; then
-                       continue
-               fi
                for ((state=0; state<NUM_STATES; state++))
                do
                        echo 1 >
/sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable
@@ -104,10 +100,6 @@ op_state()
 {
        for ((cpu=0; cpu<NUM_CPUS; cpu++))
        do
-               local cpu_status=$(cpu_is_online $cpu)
-               if [ $cpu_status == 0 ]; then
-                       continue
-               fi
                echo $1 >
/sys/devices/system/cpu/cpu$cpu/cpuidle/state$2/disable
        done
 }
@@ -124,17 +116,6 @@ cpuidle_disable_state()
        op_state 1 $state
 }

-cpu_is_online()
-{
-       cpu=$1
-       if [ ! -f "/sys/devices/system/cpu/cpu$cpu/online" ]; then
-               echo 0
-               return
-       fi
-       status=$(cat /sys/devices/system/cpu/cpu$cpu/online)
-       echo $status
-}
-
 # Extract latency in microseconds and convert to nanoseconds
 extract_latency()
 {
@@ -179,10 +160,6 @@ run_ipi_tests()
        printf "%s %10s %12s\n" "SRC_CPU" "DEST_CPU" "IPI_Latency(ns)" >> $LOG
        for ((cpu=0; cpu<NUM_CPUS; cpu+=SMT))
        do
-               local cpu_status=$(cpu_is_online $cpu)
-               if [ $cpu_status == 0 ]; then
-                       continue
-               fi
                ipi_test_once "baseline" $cpu
                printf "%-3s %10s %12s\n" $src_cpu $cpu $ipi_latency >> $LOG
                avg_arr+=($ipi_latency)
@@ -198,10 +175,6 @@ run_ipi_tests()
                printf "%s %10s %12s\n" "SRC_CPU" "DEST_CPU"
"IPI_Latency(ns)" >> $LOG
                for ((cpu=0; cpu<NUM_CPUS; cpu+=SMT))
                do
-                       local cpu_status=$(cpu_is_online $cpu)
-                       if [ $cpu_status == 0 ]; then
-                               continue
-                       fi
                        # Running IPI test and logging results
                        sleep 1
                        ipi_test_once "test" $cpu
@@ -262,10 +235,6 @@ run_timeout_tests()
        printf "%s %10s %10s\n" "Wakeup_src" "Baseline_delay(ns)">> $LOG
        for ((cpu=0; cpu<NUM_CPUS; cpu+=SMT))
        do
-               local cpu_status=$(cpu_is_online $cpu)
-               if [ $cpu_status == 0 ]; then
-                       continue
-               fi
                timeout_test_once "baseline" $cpu 1000000
                printf "%-3s %13s\n" $src_cpu $timeout_diff >> $LOG
                avg_arr+=($timeout_diff)
@@ -281,10 +250,6 @@ run_timeout_tests()
                printf "%s %10s %10s\n" "Wakeup_src"
"Baseline_delay(ns)" "Delay(ns)" >> $LOG
                for ((cpu=0; cpu<NUM_CPUS; cpu+=SMT))
                do
-                       local cpu_status=$(cpu_is_online $cpu)
-                       if [ $cpu_status == 0 ]; then
-                               continue
-                       fi
                        timeout_test_once "test" $cpu 1000000
                        printf "%-3s %13s %18s\n" $src_cpu
$baseline_timeout_diff $timeout_diff >> $LOG
                        avg_arr+=($timeout_diff)
@@ -314,3 +279,7 @@ run_timeout_tests
 printf "Removing $MODULE module\n"
 printf "Full Output logged at: $LOG\n"
 rmmod $MODULE
+
+printf "enabling idle states\n"
+
+echo 0 | tee /sys/devices/system/cpu/cpu*/cpuidle/state*/disable
(END)
