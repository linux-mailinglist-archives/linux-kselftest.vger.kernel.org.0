Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005CA620CA2
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 10:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiKHJsF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 04:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiKHJrx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 04:47:53 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E0A32BBD
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Nov 2022 01:47:17 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id r3so16744642yba.5
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Nov 2022 01:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ht7aoqC8L+vp9x1FcVPg+kZPUNeEgy80xJGTU+g4ns=;
        b=hRKdatxOnnr2tMhhyTQW7oKQgChMIBUC00toaizTNv9u5Tl1ye2PSVok+HdAC8ZfTE
         /SOqK08lKevabgnhcYPIU+JnknAISrYDQdTF5KgDLThvhyF2dbu8l/+1RPXhsXKNtii9
         CdcS8565bh0aWexgRbYOmseHNy6TBozwVi+UnD3Xk+C0dCA32F8kH6kYMm9vXivgiPR1
         WaTGtfhTeeL04GUyk180Gm3OUxetFY7E54FIChUF61zqLtG2TUWwfuP+wMKubvGOfwo1
         Y9jqXkifyVZ0IClJFwhkiM4WX4Dn5PQ3zqnsA0OYqz5rG38QZpn8AK+Q53tMJux7ltHk
         5nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ht7aoqC8L+vp9x1FcVPg+kZPUNeEgy80xJGTU+g4ns=;
        b=2W4uJHXzXbwaqcrINhnf0XjJwlgW3urqsWHALUH2CAvKq0GVQg0xZ9HMhXoHz1X5jW
         JCRiJuESM+KZ/YMmdasrM0sbqR1fJr1ct5xH55Ke8jt4xaX3du94z7F9iVWbP+M/MHJ3
         E0MjJJzx5JgMvmEsOD9yQIjNGX1lXSNqSwII8mZXO3e6QOK9WFD77y79n2ja+SGt7gGq
         OPlQdnX1ci8oKnl7MAEL19BKw3FDq9Qloii+6ZlvbANHdkBO8yVUTd90rIbL43VhWbpQ
         DvXddzniLXVUTVsxzMlkzwHvYF8154gUK2zIR0rB8G7CXvEZNQSSMPGcFrEFW3MD7qsn
         udFg==
X-Gm-Message-State: ANoB5pkb1LrE+RsuWl252npYL5slN5vQu83fHHZHmwRcC53foPnp+SSM
        x6xIPevj+Adh9iPeQ1ijnPRYzyoeVovnpBSGRiGC8yR8TcYnFw==
X-Google-Smtp-Source: AA0mqf6ARo37GgMWPATx8BKKxWmxqVcERVL8ycUCVP/DgJHu2cBrI/gbhjTBy4EwqL8JS4Vvp/B2nYpBl01r9x9hLbo=
X-Received: by 2002:a05:6902:b16:b0:6d6:9455:d6c5 with SMTP id
 ch22-20020a0569020b1600b006d69455d6c5mr11705938ybb.164.1667900835160; Tue, 08
 Nov 2022 01:47:15 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 8 Nov 2022 15:17:04 +0530
Message-ID: <CA+G9fYvBtwi8jmQZNvYwjR425BXGgCG2ej3iE6gtgfRzZmQnOw@mail.gmail.com>
Subject: kselftest rtctests failed on arm64 Raspberry Pi 4 -
 rtctest.c:34:date_read:Expected -1 (-1) != self->fd (-1)
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest rtctests failed on arm64 Raspberry Pi 4 Model B device and
passed on other devices and qemu emulators. Please refer to the
full logs and test comparison results links.


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test run log:
-------------

[  248.627989] kselftest: Running tests in rtc
TAP version 13
1..1
# selftests: rtc: rtctest
[  249.116824] audit: type=1701 audit(1651167970.071:12):
auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2818 comm=\"rtctest\"
exe=\"/opt/kselftests/default-in-kernel/rtc/rtctest\" sig=6 res=1
[  249.133837] audit: type=1701 audit(1651167970.079:13):
auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2819 comm=\"rtctest\"
exe=\"/opt/kselftests/default-in-kernel/rtc/rtctest\" sig=6 res=1
[  249.151179] audit: type=1701 audit(1651167970.083:14):
auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2820 comm=\"rtctest\"
exe=\"/opt/kselftests/default-in-kernel/rtc/rtctest\" sig=6 res=1
[  249.168401] audit: type=1701 audit(1651167970.091:15):
auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2821 comm=\"rtctest\"
exe=\"/opt/kselftests/default-in-kernel/rtc/rtctest\" sig=6 res=1
[  249.185406] audit: type=1701 audit(1651167970.095:16):
auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2822 comm=\"rtctest\"
exe=\"/opt/kselftests/default-in-kernel/rtc/rtctest\" sig=6 res=1
[  249.202343] audit: type=1701 audit(1651167970.103:17):
auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2823 comm=\"rtctest\"
exe=\"/opt/kselftests/default-in-kernel/rtc/rtctest\" sig=6 res=1
#[  249.219262] audit: type=1701 audit(1651167970.111:18):
auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2824 comm=\"rtctest\"
exe=\"/opt/kselftests/default-in-kernel/rtc/rtctest\" sig=6 res=1
 [  249.236233] audit: type=1701 audit(1651167970.115:19):
auid=4294967295 uid=0 gid=0 ses=4294967295 pid=2825 comm=\"rtctest\"
exe=\"/opt/kselftests/default-in-kernel/rtc/rtctest\" sig=6 res=1
TAP version 13
# 1..8
# # Starting 8 tests from 2 test cases.
# #  RUN           rtc.date_read ...
# # rtctest.c:34:date_read:Expected -1 (-1) != self->fd (-1)
# # date_read: Test terminated by assertion
# #          FAIL  rtc.date_read
# not ok 1 rtc.date_read
# #  RUN           rtc.date_read_loop ...
# # rtctest.c:34:date_read_loop:Expected -1 (-1) != self->fd (-1)
# # date_read_loop: Test terminated by assertion
# #          FAIL  rtc.date_read_loop
# not ok 2 rtc.date_read_loop
# #  RUN           rtc.uie_read ...
# # rtctest.c:34:uie_read:Expected -1 (-1) != self->fd (-1)
# # uie_read: Test terminated by assertion
# #          FAIL  rtc.uie_read
# not ok 3 rtc.uie_read
# #  RUN           rtc.uie_select ...
# # rtctest.c:34:uie_select:Expected -1 (-1) != self->fd (-1)
# # uie_select: Test terminated by assertion
# #          FAIL  rtc.uie_select
# not ok 4 rtc.uie_select
# #  RUN           rtc.alarm_alm_set ...
# # rtctest.c:34:alarm_alm_set:Expected -1 (-1) != self->fd (-1)
# # alarm_alm_set: Test terminated by assertion
# #          FAIL  rtc.alarm_alm_set
# not ok 5 rtc.alarm_alm_set
# #  RUN           rtc.alarm_wkalm_set ...
# # rtctest.c:34:alarm_wkalm_set:Expected -1 (-1) != self->fd (-1)
# # alarm_wkalm_set: Test terminated by assertion
# #          FAIL  rtc.alarm_wkalm_set
# not ok 6 rtc.alarm_wkalm_set
# #  RUN           rtc.alarm_alm_set_minute ...
# # rtctest.c:34:alarm_alm_set_minute:Expected -1 (-1) != self->fd (-1)
# # alarm_alm_set_minute: Test terminated by assertion
# #          FAIL  rtc.alarm_alm_set_minute
# not ok 7 rtc.alarm_alm_set_minute
# #  RUN           rtc.alarm_wkalm_set_minute ...
# # rtctest.c:34:alarm_wkalm_set_minute:Expected -1 (-1) != self->fd (-1)
# # alarm_wkalm_set_minute: Test terminated by assertion
# #          FAIL  rtc.alarm_wkalm_set_minute
# not ok 8 rtc.alarm_wkalm_set_minute
# # FAILED: 0 / 8 tests passed.
# # Totals: pass:0 fail:8 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: rtc: rtctest # exit=1

Test results details,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848560/suite/kselftest-rtc/tests/

Test results compare,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848560/suite/kselftest-rtc/test/rtc.rtctest/history/

Test detailed log,
https://lkft.validation.linaro.org/scheduler/job/5812742#L1759

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: d8e87774068af213ab5b058b1b114dc397b577aa
  git_describe: next-20221107
  kernel_version: 6.1.0-rc3
  kernel-config: https://builds.tuxbuild.com/2HChVOSNxUpvfAfLTnaK7zyTdUi/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/687092361
  artifact-location: https://builds.tuxbuild.com/2HChVOSNxUpvfAfLTnaK7zyTdUi
  toolchain: gcc-11


--
Linaro QA
https://qa-reports.linaro.org
