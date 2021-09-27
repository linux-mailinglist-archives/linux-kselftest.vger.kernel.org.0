Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7687418D4A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Sep 2021 02:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhI0Aar (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Sep 2021 20:30:47 -0400
Received: from a8-97.smtp-out.amazonses.com ([54.240.8.97]:37013 "EHLO
        a8-97.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232113AbhI0Aar (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Sep 2021 20:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1632702549;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=VrCAw0M2TSCOPJ2yqB+ST2keDACLKH38LqHD83yCNRc=;
        b=hEqjOOTqGUfDh6K0SdaDWdwOKpIPjdD5xk5ENNHSrUv75QaAq/V4q7EMPqCdfoS0
        zs6jowcEbcuepIEXwL93KNvkiuULcoGx8To1FEifQLREc0AHBT2yFGbSpmiSfFVyQMV
        qkXgvvCaSOou2beIsJVicakGig56cQCHD623UuX8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1632702549;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=VrCAw0M2TSCOPJ2yqB+ST2keDACLKH38LqHD83yCNRc=;
        b=cf0gF7/7E5SYIc6Q7jjtACfw+9b7YiAot3+9O6Quoy2McNgirVGYkhpAJoqdwy2q
        dLY5olrXZYJFb0nhrR/Qj7k45SgRQho6VPPZ+YvTQ5ahczuf2Kmn8mGgbu8N/kQAQMb
        SwyP59etfV9wmIXZkUH5sEiuZDSrz1teIm0yIFy4=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20210923
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017c24a7cca8-4999c0b3-3cb0-4333-a5a4-65d62dc8cd49-000000@email.amazonses.com>
Date:   Mon, 27 Sep 2021 00:29:09 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.09.27-54.240.8.97
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: bc5aa70f26995791074a00da8b57ead3a9c1a646
* git describe: next-20210923
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210923

## Regressions (compared to next-20210915)
* qemu-arm64-gic-version2, kselftest-timers
  - timers.rtcpie

* qemu_i386, kselftest-seccomp
  - seccomp.seccomp_benchmark

* qemu_x86_64, kselftest-x86
  - x86.iopl_64


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20210915)
* qemu-arm64-gic-version2, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu-arm64-gic-version3, kselftest-timers
  - timers.rtcpie

* qemu-arm64-mte, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu-arm64-mte, kselftest-timers
  - timers.rtcpie

* qemu_arm64, kselftest-timers
  - timers.rtcpie


## Test result summary
total: 3678, pass: 1997, fail: 324, skip: 1357, xfail: 0

## Build Summary

## Test suites summary
* kselftest-android
* kselftest-arm64
* kselftest-arm64/arm64.btitest.bti_c_func
* kselftest-arm64/arm64.btitest.bti_j_func
* kselftest-arm64/arm64.btitest.bti_jc_func
* kselftest-arm64/arm64.btitest.bti_none_func
* kselftest-arm64/arm64.btitest.nohint_func
* kselftest-arm64/arm64.btitest.paciasp_func
* kselftest-arm64/arm64.nobtitest.bti_c_func
* kselftest-arm64/arm64.nobtitest.bti_j_func
* kselftest-arm64/arm64.nobtitest.bti_jc_func
* kselftest-arm64/arm64.nobtitest.bti_none_func
* kselftest-arm64/arm64.nobtitest.nohint_func
* kselftest-arm64/arm64.nobtitest.paciasp_func
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
* kselftest-mqueue
* kselftest-net
* kselftest-netfilter
* kselftest-nsfs
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
