Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DED51EBEC
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 May 2022 07:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiEHFpx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 May 2022 01:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiEHFpw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 May 2022 01:45:52 -0400
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com [54.240.48.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC2CE010;
        Sat,  7 May 2022 22:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1651988519;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=ZNZ47G/iGXwnCMBtBwZ9v4Bz4MNbeBnlap0WwiKo/Vs=;
        b=GYX4C5G8mB1QS+XivpQcwt+YQOoahL3bOg/YtY2BRSupHhZnM3LsCAWfo/kNyBzU
        +YuVajIlM40I8480Ukqg/AShqPGL2OHpdRbCqJVMXO7gJ7tsbDFrHt96PgGg2Vmre4u
        X3c3u9x/P4GiNRUQU1V5X3QH7hlIHLgLDIZW+jvE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1651988519;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=ZNZ47G/iGXwnCMBtBwZ9v4Bz4MNbeBnlap0WwiKo/Vs=;
        b=Jsayz/UHabU7joCFN38BrTn6i77DmyNaHtLWTS8fvBzxS1ftVIHQuGJgdvSwRlD3
        VTSQ4HHsgSEPE4tKB/FRt/bsuJ/wDTJxRLTczLpkgEZK4wFs2vdlIXPjwUzFLKg1pZy
        moGNJR12cGNlPabHO2bg9c5CjMLtn5PFPfXBFTrk=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220315
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <01000180a230564e-e40f5540-e20e-4365-b90c-2f969ef7a71f-000000@email.amazonses.com>
Date:   Sun, 8 May 2022 05:41:58 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.08-54.240.48.37
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.17.0-rc8
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: a32cd981a6da2373c093d471ee4405a915e217d5
* git describe: next-20220315
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220315

## Test Regressions (compared to next-20220302)
No test regressions found.

## Metric Regressions (compared to next-20220302)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220302)
No test fixes found.

## Metric Fixes (compared to next-20220302)
No metric fixes found.

## Test result summary
total: 2020, pass: 1067, fail: 118, skip: 835, xfail: 0

## Build Summary

## Test suites summary
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-firmware
* kselftest-fpu
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-vm
* kselftest-x86
* kselftest-zram

--
Linaro LKFT
https://lkft.linaro.org
