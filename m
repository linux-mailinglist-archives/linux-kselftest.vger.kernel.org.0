Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EFB538EB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 May 2022 12:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbiEaKTc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 May 2022 06:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiEaKTb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 May 2022 06:19:31 -0400
Received: from a8-81.smtp-out.amazonses.com (a8-81.smtp-out.amazonses.com [54.240.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581238D693;
        Tue, 31 May 2022 03:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1653992369;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=a3aOFmgkqy81ADLTe0+YNqiBLGk3o3QNrG8FV8LAgXY=;
        b=Qj8NZiGi0Fxm0U/x+NcDk1XliAx47fJ4ON5cWZfljZ92D1EcCJCyJKBAsIOpzExk
        HHYVwgibq9OrECxrfXYs0WW0KFTHM+G3yzj8f4JuxujZDdhBRZNlGrS7sLDfHlvLCrJ
        Xygy2z+KUwuST6NvzsAYxQeNJx5tujSHtlUsbF0Q=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1653992369;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=a3aOFmgkqy81ADLTe0+YNqiBLGk3o3QNrG8FV8LAgXY=;
        b=jPBn5MRoTnLmfqmcwYiv0sTx8PmfF1RWBdUJ8NnbtCKI9CzzoEqOvJeI9XFHbH+x
        3ClL/OnWtQcZcnIjiYSEaCcRFD5n84omIBO0kALfrzpuw76kFPfO0pap+sIyHmYG+QV
        YJW51VGTTjJVlBcJVUEQ+7pVfiTVQe4K/S8Mj9X8=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220531
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100018119a0abfb-d49f87eb-b4f1-4b17-b086-37eea9088f67-000000@email.amazonses.com>
Date:   Tue, 31 May 2022 10:19:29 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.31-54.240.8.81
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.18.0
* git: ['', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: 3b46e4e4418027a622c17d1b7c40c3f565115d03
* git describe: next-20220531
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220531

## Test Regressions (compared to next-20220527)
No test regressions found.

## Metric Regressions (compared to next-20220527)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220527)
* qemu_arm, kselftest-timers
  - timers.rtcpie

* qemu_arm, kselftest-user
  - user.test_user_copy.sh


## Metric Fixes (compared to next-20220527)
No metric fixes found.

## Test result summary
total: 523, pass: 261, fail: 105, skip: 157, xfail: 0

## Build Summary

## Test suites summary
* kselftest-android
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
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kvm
* kselftest-lib
* kselftest-membarrier
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
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
* kselftest-zram

--
Linaro LKFT
https://lkft.linaro.org
