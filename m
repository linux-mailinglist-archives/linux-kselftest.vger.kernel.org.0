Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0BE6B82FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 21:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCMUmS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Mar 2023 16:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCMUmQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Mar 2023 16:42:16 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A02235BE;
        Mon, 13 Mar 2023 13:41:55 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BF8EAFF803;
        Mon, 13 Mar 2023 20:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678740108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DwOQUIXnpFoKCIrGTMaLUibdWxxZk5kTy83/Zjo1/tc=;
        b=PGDinJQSKTzw4zDuBFxN0uCq4dyA8/ZVNlZjS9q2LloWauVU04MkrBWZRUzPQxHrTjyzaR
        azNwpPZhY51QHC+oQYatXUl9X5xA1WSyRewgsD6p4YjMuTWlc1Vr2ec5PwtZJOPc+CQ2/k
        h1uvKa62kIcqbviCZ9FnXemHEUQh/8WOHA5Xxrap/TR6QRiuECGgBlPCQjBYhQdEB7EY0t
        3FWXTQtFNo5kEgze0cFRYnz8ZvVNkf7brycGHvIb83vnuFUSzaM0TANfz9IQ+UAFeF7ywf
        TzNgXOEFkTzXwXIyVuL9iXlErNZcoNigTpCgBaCMHib3zw73E1Mob5hdNSfZ6g==
Date:   Mon, 13 Mar 2023 21:41:46 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: selftest: rtctest.c:290:alarm_wkalm_set:Expected -1 (-1) != rc
 (-1) : Test terminated by assertion
Message-ID: <202303132041465686d750@mail.local>
References: <CA+G9fYt+5tML3BTyk4_z_Ro1Dv+W6OvZqoZcqjc5NRhqBNZrVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYt+5tML3BTyk4_z_Ro1Dv+W6OvZqoZcqjc5NRhqBNZrVg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

This honestly looks like an infrastructure issue. How loaded are your
workers when running this test?
Also, I'm not sure how good is the rtc emulation in qemu (which is a
good part of what is being tested here).

On 07/03/2023 12:47:50+0530, Naresh Kamboju wrote:
> kselftest: rtc built with clang-16 getting failed but passed with gcc-12
> build. Please find more details about test logs on clang-16 and gcc-12
> and steps to reproduce locally on your machine by using tuxrun.
> 
> On the qemu-x86-64 clang builds it is intermittent failure;
> you could notice that from the test history link below.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Test log:
> ----------
> Linux version 6.3.0-rc1-next-20230307 (tuxmake@tuxmake) (Debian clang
> version 16.0.0 (++20230228093516+60692a66ced6-1~exp1~20230228093525.41),
> Debian LLD 16.0.0) #1 SMP PREEMPT @1678159722
> ...
> kselftest: Running tests in rtc
> TAP version 13
> 1..1
> # selftests: rtc: rtctest
> # TAP version 13
> # 1..8
> # # Starting 8 tests from 1 test cases.
> # #  RUN           rtc.date_read ...
> # # rtctest.c:54:date_read:Current RTC date/time is 07/03/2023 03:55:04.
> # #            OK  rtc.date_read
> # ok 1 rtc.date_read
> # #  RUN           rtc.date_read_loop ...
> # # rtctest.c:96:date_read_loop:Continuously reading RTC time for 30s
> (with 11ms breaks after every read).
> # # rtctest.c:122:date_read_loop:Performed 2630 RTC time reads.
> # #            OK  rtc.date_read_loop
> # ok 2 rtc.date_read_loop
> # #  RUN           rtc.uie_read ...
> # #            OK  rtc.uie_read
> # ok 3 rtc.uie_read
> # #  RUN           rtc.uie_select ...
> # #            OK  rtc.uie_select
> # ok 4 rtc.uie_select
> # #  RUN           rtc.alarm_alm_set ...
> # # rtctest.c:222:alarm_alm_set:Alarm time now set to 03:55:44.
> # # rtctest.c:241:alarm_alm_set:data: 1a0
> # #            OK  rtc.alarm_alm_set
> # ok 5 rtc.alarm_alm_set
> # #  RUN           rtc.alarm_wkalm_set ...
> # # rtctest.c:284:alarm_wkalm_set:Alarm time now set to 07/03/2023 03:55:47.
> # # rtctest.c:290:alarm_wkalm_set:Expected -1 (-1) != rc (-1)
> # # alarm_wkalm_set: Test terminated by assertion
> # #          FAIL  rtc.alarm_wkalm_set
> # not ok 6 rtc.alarm_wkalm_set
> # #  RUN           rtc.alarm_alm_set_minute ...
> # # rtctest.c:332:alarm_alm_set_minute:Alarm time now set to 03:56:00.
> # # rtctest.c:351:alarm_alm_set_minute:data: 1a0
> # #            OK  rtc.alarm_alm_set_minute
> # ok 7 rtc.alarm_alm_set_minute
> # #  RUN           rtc.alarm_wkalm_set_minute ...
> # # rtctest.c:394:alarm_wkalm_set_minute:Alarm time now set to
> 07/03/2023 03:57:00.
> # # rtctest.c:400:alarm_wkalm_set_minute:Expected -1 (-1) != rc (-1)
> # # alarm_wkalm_set_minute: Test terminated by assertion
> # #          FAIL  rtc.alarm_wkalm_set_minute
> # not ok 8 rtc.alarm_wkalm_set_minute
> # # FAILED: 6 / 8 tests passed.
> # # Totals: pass:6 fail:2 xfail:0 xpass:0 skip:0 error:0
> 
> Links,
> 
>   qemu-x86_64:
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230306/testrun/15287646/suite/kselftest-rtc/test/rtc_rtctest/details/
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230306/testrun/15287646/suite/kselftest-rtc/test/rtc_rtctest/log
> 
>   qemu-arm64:
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15302349/suite/kselftest-rtc/test/rtc_rtctest/log
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15302349/suite/kselftest-rtc/tests/
> 
> Test history:
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15302349/suite/kselftest-rtc/test/rtc_rtctest/history/
> 
> Test log:
> ---------
> Linux version 6.3.0-rc1-next-20230307 (tuxmake@tuxmake)
> (aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
> for Debian) 2.40) #1 SMP PREEMPT @1678159736
> ...
> kselftest: Running tests in rtc
> TAP version 13
> 1..1
> # selftests: rtc: rtctest
> # TAP version 13
> # 1..8
> # # Starting 8 tests from 1 test cases.
> # #  RUN           rtc.date_read ...
> # # rtctest.c:52:date_read:Current RTC date/time is 07/03/2023 03:48:22.
> # #            OK  rtc.date_read
> # ok 1 rtc.date_read
> # #  RUN           rtc.date_read_loop ...
> # # rtctest.c:95:date_read_loop:Continuously reading RTC time for 30s
> (with 11ms breaks after every read).
> # # rtctest.c:122:date_read_loop:Performed 2670 RTC time reads.
> # #            OK  rtc.date_read_loop
> # ok 2 rtc.date_read_loop
> # #  RUN           rtc.uie_read ...
> # #            OK  rtc.uie_read
> # ok 3 rtc.uie_read
> # #  RUN           rtc.uie_select ...
> # #            OK  rtc.uie_select
> # ok 4 rtc.uie_select
> # #  RUN           rtc.alarm_alm_set ...
> # # rtctest.c:221:alarm_alm_set:Alarm time now set to 03:49:02.
> # # rtctest.c:241:alarm_alm_set:data: 1a0
> # #            OK  rtc.alarm_alm_set
> # ok 5 rtc.alarm_alm_set
> # #  RUN           rtc.alarm_wkalm_set ...
> # # rtctest.c:281:alarm_wkalm_set:Alarm time now set to 07/03/2023 03:49:05.
> # #            OK  rtc.alarm_wkalm_set
> # ok 6 rtc.alarm_wkalm_set
> # #  RUN           rtc.alarm_alm_set_minute ...
> # # rtctest.c:331:alarm_alm_set_minute:Alarm time now set to 03:50:00.
> <47>[  106.383091] systemd-journald[98]: Sent WATCHDOG=1 notification.
> # # rtctest.c:351:alarm_alm_set_minute:data: 1a0
> # #            OK  rtc.alarm_alm_set_minute
> # ok 7 rtc.alarm_alm_set_minute
> # #  RUN           rtc.alarm_wkalm_set_minute ...
> # # rtctest.c:391:alarm_wkalm_set_minute:Alarm time now set to
> 07/03/2023 03:51:00.
> # #            OK  rtc.alarm_wkalm_set_minute
> # ok 8 rtc.alarm_wkalm_set_minute
> # # PASSED: 8 / 8 tests passed.
> # # Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0
> ok 1 selftests: rtc: rtctest
> 
> Links,
>  qemu-x86_64:
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15303767/suite/kselftest-rtc/test/rtc_rtctest/details/
>  qemu-arm64:
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15302372/suite/kselftest-rtc/tests/
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15302372/suite/kselftest-rtc/test/rtc_rtctest/log
> 
> Steps to reproduce:
> --------------
> 
> # To install tuxrun on your system globally:
> # sudo pip3 install -U tuxrun==0.37.2
> #
> # See https://tuxrun.org/ for complete documentation.
> 
> tuxrun  \
>  --runtime podman  \
>  --device qemu-x86_64  \
>  --boot-args rw  \
>  --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2McWP6obiL1x51zgkgLXRAmI9Ei/bzImage
>  \
>  --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2McWP6obiL1x51zgkgLXRAmI9Ei/modules.tar.xz
>  \
>  --rootfs https://storage.tuxboot.com/debian/bookworm/amd64/rootfs.ext4.xz  \
>  --parameters SKIPFILE=skipfile-lkft.yaml  \
>  --parameters KSELFTEST=https://storage.tuxsuite.com/public/linaro/lkft/builds/2McWP6obiL1x51zgkgLXRAmI9Ei/kselftest.tar.xz
>  \
>  --image docker.io/lavasoftware/lava-dispatcher:2023.01.0020.gc1598238f  \
>  --tests kselftest-rtc  \
>  --timeouts boot=15
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
