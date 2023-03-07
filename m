Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E516AD840
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 08:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjCGHSN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 02:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjCGHSE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 02:18:04 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34461252BE
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Mar 2023 23:18:02 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id o32so11483985vsv.12
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Mar 2023 23:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678173481;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DLDvNJAiPBjBod3Tywevhuwhg5NQD2WRFvTgKWfFwAQ=;
        b=lo7pVp56On8h6lKWhwpyE7rZyVybr/RrIWClmhtHyeS3KBe5ApdHBg5e5Zn0SxEQjy
         8yGd/1KU+m2owmudlLtbx+oHm5HXYfhMtmHD8ohLbr2CvfbsC4m2gZrIPuwD4JA0sP3K
         AeuZkUnf19OaauuqO4lmm2MHkqqkvu5G2627j6pBM8aDj6XLddsUwyfUbfBJkCVcs1VJ
         Ze/djj6PUGz9utZOpijuNKOrCrugbx/oDBTho5lywXkn+Dcw3UW76cjjHOn50iVoL1U8
         rt35an8XYnZ/1Wqb9CQQJkivMVsV3xOhVvQrlxUM58CcD6Vstp0v54/hgZMM+1qcPWnr
         C8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678173481;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DLDvNJAiPBjBod3Tywevhuwhg5NQD2WRFvTgKWfFwAQ=;
        b=yZWIOOpHccofqKvv4O6LxtPHLtOunGQWtZkai++4n6oQ2fJ5bHZsq/O0KA4cABtdOC
         Q55jOjwFFThc230XIbERiOegygWel/bttj5SbyjRl+dN530Lw8uyXffef3+KrxeiTSUR
         RmAwLhHG1KVMrnmsRuME/UuAXNHUGtNfXFHsbxyOcFPlnwO7uiCAmb18noCait9YUiXP
         OJEeYrN5X/4mh/+RRQ1OytdfqDTn0bzJblT1ZK/9SIyGW1hE1ur79NYJHSh/bhoIZF+T
         Z7IJZi/3Y/wyUKbjifoSdGqQYMm+ndqiFtRWZ/H1T+n6vMFzDd0tVbI85egnYWQNaaHr
         e+Fw==
X-Gm-Message-State: AO0yUKWhWim9MqezcEQwvGvNwz615i0DZcCtEE24WPChpYYo7AqCXf5J
        g8noHRk2c9/Ypue9xnIxI+r2L0NALfvPfimVrNM4kok+xNQwQXsb87E=
X-Google-Smtp-Source: AK7set/hSFs5z9sqcXngWoYn/fTtnV80COrga7eNVdZqF/G9GZeNaDeUwNMX6UrjSgtYThT08G6rXw6Tpp4l3vSwR5A=
X-Received: by 2002:a67:db97:0:b0:412:2ed6:d79b with SMTP id
 f23-20020a67db97000000b004122ed6d79bmr9040317vsk.3.1678173480962; Mon, 06 Mar
 2023 23:18:00 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Mar 2023 12:47:50 +0530
Message-ID: <CA+G9fYt+5tML3BTyk4_z_Ro1Dv+W6OvZqoZcqjc5NRhqBNZrVg@mail.gmail.com>
Subject: selftest: rtctest.c:290:alarm_wkalm_set:Expected -1 (-1) != rc (-1) :
 Test terminated by assertion
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest: rtc built with clang-16 getting failed but passed with gcc-12
build. Please find more details about test logs on clang-16 and gcc-12
and steps to reproduce locally on your machine by using tuxrun.

On the qemu-x86-64 clang builds it is intermittent failure;
you could notice that from the test history link below.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
----------
Linux version 6.3.0-rc1-next-20230307 (tuxmake@tuxmake) (Debian clang
version 16.0.0 (++20230228093516+60692a66ced6-1~exp1~20230228093525.41),
Debian LLD 16.0.0) #1 SMP PREEMPT @1678159722
...
kselftest: Running tests in rtc
TAP version 13
1..1
# selftests: rtc: rtctest
# TAP version 13
# 1..8
# # Starting 8 tests from 1 test cases.
# #  RUN           rtc.date_read ...
# # rtctest.c:54:date_read:Current RTC date/time is 07/03/2023 03:55:04.
# #            OK  rtc.date_read
# ok 1 rtc.date_read
# #  RUN           rtc.date_read_loop ...
# # rtctest.c:96:date_read_loop:Continuously reading RTC time for 30s
(with 11ms breaks after every read).
# # rtctest.c:122:date_read_loop:Performed 2630 RTC time reads.
# #            OK  rtc.date_read_loop
# ok 2 rtc.date_read_loop
# #  RUN           rtc.uie_read ...
# #            OK  rtc.uie_read
# ok 3 rtc.uie_read
# #  RUN           rtc.uie_select ...
# #            OK  rtc.uie_select
# ok 4 rtc.uie_select
# #  RUN           rtc.alarm_alm_set ...
# # rtctest.c:222:alarm_alm_set:Alarm time now set to 03:55:44.
# # rtctest.c:241:alarm_alm_set:data: 1a0
# #            OK  rtc.alarm_alm_set
# ok 5 rtc.alarm_alm_set
# #  RUN           rtc.alarm_wkalm_set ...
# # rtctest.c:284:alarm_wkalm_set:Alarm time now set to 07/03/2023 03:55:47.
# # rtctest.c:290:alarm_wkalm_set:Expected -1 (-1) != rc (-1)
# # alarm_wkalm_set: Test terminated by assertion
# #          FAIL  rtc.alarm_wkalm_set
# not ok 6 rtc.alarm_wkalm_set
# #  RUN           rtc.alarm_alm_set_minute ...
# # rtctest.c:332:alarm_alm_set_minute:Alarm time now set to 03:56:00.
# # rtctest.c:351:alarm_alm_set_minute:data: 1a0
# #            OK  rtc.alarm_alm_set_minute
# ok 7 rtc.alarm_alm_set_minute
# #  RUN           rtc.alarm_wkalm_set_minute ...
# # rtctest.c:394:alarm_wkalm_set_minute:Alarm time now set to
07/03/2023 03:57:00.
# # rtctest.c:400:alarm_wkalm_set_minute:Expected -1 (-1) != rc (-1)
# # alarm_wkalm_set_minute: Test terminated by assertion
# #          FAIL  rtc.alarm_wkalm_set_minute
# not ok 8 rtc.alarm_wkalm_set_minute
# # FAILED: 6 / 8 tests passed.
# # Totals: pass:6 fail:2 xfail:0 xpass:0 skip:0 error:0

Links,

  qemu-x86_64:
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230306/testrun/15287646/suite/kselftest-rtc/test/rtc_rtctest/details/
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230306/testrun/15287646/suite/kselftest-rtc/test/rtc_rtctest/log

  qemu-arm64:
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15302349/suite/kselftest-rtc/test/rtc_rtctest/log
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15302349/suite/kselftest-rtc/tests/

Test history:
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15302349/suite/kselftest-rtc/test/rtc_rtctest/history/

Test log:
---------
Linux version 6.3.0-rc1-next-20230307 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
for Debian) 2.40) #1 SMP PREEMPT @1678159736
...
kselftest: Running tests in rtc
TAP version 13
1..1
# selftests: rtc: rtctest
# TAP version 13
# 1..8
# # Starting 8 tests from 1 test cases.
# #  RUN           rtc.date_read ...
# # rtctest.c:52:date_read:Current RTC date/time is 07/03/2023 03:48:22.
# #            OK  rtc.date_read
# ok 1 rtc.date_read
# #  RUN           rtc.date_read_loop ...
# # rtctest.c:95:date_read_loop:Continuously reading RTC time for 30s
(with 11ms breaks after every read).
# # rtctest.c:122:date_read_loop:Performed 2670 RTC time reads.
# #            OK  rtc.date_read_loop
# ok 2 rtc.date_read_loop
# #  RUN           rtc.uie_read ...
# #            OK  rtc.uie_read
# ok 3 rtc.uie_read
# #  RUN           rtc.uie_select ...
# #            OK  rtc.uie_select
# ok 4 rtc.uie_select
# #  RUN           rtc.alarm_alm_set ...
# # rtctest.c:221:alarm_alm_set:Alarm time now set to 03:49:02.
# # rtctest.c:241:alarm_alm_set:data: 1a0
# #            OK  rtc.alarm_alm_set
# ok 5 rtc.alarm_alm_set
# #  RUN           rtc.alarm_wkalm_set ...
# # rtctest.c:281:alarm_wkalm_set:Alarm time now set to 07/03/2023 03:49:05.
# #            OK  rtc.alarm_wkalm_set
# ok 6 rtc.alarm_wkalm_set
# #  RUN           rtc.alarm_alm_set_minute ...
# # rtctest.c:331:alarm_alm_set_minute:Alarm time now set to 03:50:00.
<47>[  106.383091] systemd-journald[98]: Sent WATCHDOG=1 notification.
# # rtctest.c:351:alarm_alm_set_minute:data: 1a0
# #            OK  rtc.alarm_alm_set_minute
# ok 7 rtc.alarm_alm_set_minute
# #  RUN           rtc.alarm_wkalm_set_minute ...
# # rtctest.c:391:alarm_wkalm_set_minute:Alarm time now set to
07/03/2023 03:51:00.
# #            OK  rtc.alarm_wkalm_set_minute
# ok 8 rtc.alarm_wkalm_set_minute
# # PASSED: 8 / 8 tests passed.
# # Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: rtc: rtctest

Links,
 qemu-x86_64:
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15303767/suite/kselftest-rtc/test/rtc_rtctest/details/
 qemu-arm64:
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15302372/suite/kselftest-rtc/tests/
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230307/testrun/15302372/suite/kselftest-rtc/test/rtc_rtctest/log

Steps to reproduce:
--------------

# To install tuxrun on your system globally:
# sudo pip3 install -U tuxrun==0.37.2
#
# See https://tuxrun.org/ for complete documentation.

tuxrun  \
 --runtime podman  \
 --device qemu-x86_64  \
 --boot-args rw  \
 --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2McWP6obiL1x51zgkgLXRAmI9Ei/bzImage
 \
 --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2McWP6obiL1x51zgkgLXRAmI9Ei/modules.tar.xz
 \
 --rootfs https://storage.tuxboot.com/debian/bookworm/amd64/rootfs.ext4.xz  \
 --parameters SKIPFILE=skipfile-lkft.yaml  \
 --parameters KSELFTEST=https://storage.tuxsuite.com/public/linaro/lkft/builds/2McWP6obiL1x51zgkgLXRAmI9Ei/kselftest.tar.xz
 \
 --image docker.io/lavasoftware/lava-dispatcher:2023.01.0020.gc1598238f  \
 --tests kselftest-rtc  \
 --timeouts boot=15

--
Linaro LKFT
https://lkft.linaro.org
