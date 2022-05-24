Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974DF5331C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 21:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240921AbiEXTce (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 15:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbiEXTcd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 15:32:33 -0400
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com [54.240.48.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414EC6EC53;
        Tue, 24 May 2022 12:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1653420750;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=IJedmS05+kboVVK12Nv37a8D22aNWRZlaAOsTaUkhFs=;
        b=FR79051D2hDkrXrqY0oIlrAPi8jxJTDhYOkO0QXamg7zSN3rf3d/qnOZEr3hLj/W
        Zk9fRGUTIE6Oj3HnZAvw9AoDIQzf2L6Ws61Ig4bVS2IiJATTSpfql5CXS3dHrL5tFvu
        MFGxEVKaYtuO50LJUo0hTznNVsQbyM4kUHYDmv4w=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1653420750;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=IJedmS05+kboVVK12Nv37a8D22aNWRZlaAOsTaUkhFs=;
        b=Etu99vIZsRRk6rAtjRp+5hJKbaBKusD5hSs1G2/e6vIwEld0uxRcdPUpOc5+EGdq
        /FasmcWArIdM6aI4MF8W72tFuB8JLnjuujZShpAMc5+Vos+9hZB6+HLEUvRfAk6gRFt
        yqRbZ53WGbxYYW2cO8Hg+ZtmHvoYBy3Kx86x5OzQ=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20220524
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <01000180f78e751a-1e3b8568-cbd3-4ab2-bdf6-53c8c4caac50-000000@email.amazonses.com>
Date:   Tue, 24 May 2022 19:32:30 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.24-54.240.48.34
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
* git commit: 09ce5091ff971cdbfd67ad84dc561ea27f10d67a
* git describe: next-20220524
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220524

## Test Regressions (compared to next-20220520)
* dragonboard-410c, kselftest-rtc
  - rtc.rtctest.rtc.uie_read

* dragonboard-845c, kselftest-proc
  - proc.proc-uptime-001

* qemu_x86_64, kselftest-timers
  - timers.rtcpie


## Metric Regressions (compared to next-20220520)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220520)
* dragonboard-845c, kselftest-timers
  - timers.rtcpie

* qemu-arm64-gic-version2, kselftest-cgroup
  - cgroup.test_freezer

* qemu-arm64-gic-version3, kselftest-timers
  - timers.rtcpie

* qemu-arm64-mte, kselftest-cgroup
  - cgroup.test_freezer

* qemu_arm, kselftest-pidfd
  - pidfd.pidfd_poll_test

* qemu_arm, kselftest-timers
  - timers.rtcpie


## Metric Fixes (compared to next-20220520)
No metric fixes found.

## Test result summary
total: 5813, pass: 3119, fail: 608, skip: 2086, xfail: 0

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
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
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
