Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAA7424BE8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 04:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhJGCuB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 22:50:01 -0400
Received: from a8-73.smtp-out.amazonses.com ([54.240.8.73]:60861 "EHLO
        a8-73.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232254AbhJGCt7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 22:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1633574885;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=EqFG7Btd6Vmpw/YcXSmMd6LpA3vOePUL53XxUo/XV5c=;
        b=RXmibPpS1KrwO+JGzYUb1+ROC0bMXmSux1DKbUB0OE10Y+8ig7WX1vi03eFKjYHZ
        hctN7p2PHAXzutusMcIpCP4/+9aKPcxoI6Uj3mX5z1Rom2s84/ESO+AnXTSYreOLBMH
        BlPfQWJ1DjTiRvs1l6NQefSYhUL6yKFMK83nJKdI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1633574885;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=EqFG7Btd6Vmpw/YcXSmMd6LpA3vOePUL53XxUo/XV5c=;
        b=XIMgFAO8OY9UsSPhPXpSUTMqf6EI6DQU/lzvdDUKrA0oZLiVRcdV25gi3KCc7QGq
        skQDlYfgMfIoXs/YDEZxnWURXmUJxuXF74YKHPJPOP8Ri3Wjn+yH1dBf2RtlzUeLN1q
        Awqf9m1WO6uPvcEvobgwO+abS2HIf9VCPsh/AMY0=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211006
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017c58a697f1-a764d5a1-92e3-4d60-b202-db01d96744a7-000000@email.amazonses.com>
Date:   Thu, 7 Oct 2021 02:48:05 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.10.07-54.240.8.73
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc4
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 0dda5ee37364eb58a960d7a031aebd7fa3e26384
* git describe: next-20211006
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211006

## Regressions (compared to next-20211001)
* dragonboard-410c, kselftest-net
  - net.ip_defrag.sh

* dragonboard-410c, kselftest-rseq
  - rseq.basic_percpu_ops_test
  - rseq.basic_test
  - rseq.param_test
  - rseq.param_test_benchmark
  - rseq.param_test_compare_twice

* qemu-arm64-gic-version3, kselftest-timers
  - timers.rtcpie

* qemu_arm64, kselftest-timers
  - timers.rtcpie

* qemu_i386, kselftest-mqueue
  - mqueue.mq_perf_tests

* qemu_i386, kselftest-rseq
  - rseq.basic_percpu_ops_test
  - rseq.basic_test
  - rseq.param_test
  - rseq.param_test_benchmark
  - rseq.param_test_compare_twice
  - rseq.run_param_test.sh

* qemu_x86_64, kselftest-kvm
  - kvm.steal_time

* qemu_x86_64, kselftest-mqueue
  - mqueue.mq_perf_tests

* qemu_x86_64, kselftest-rseq
  - rseq.basic_percpu_ops_test
  - rseq.basic_test
  - rseq.param_test
  - rseq.param_test_benchmark
  - rseq.param_test_compare_twice
  - rseq.run_param_test.sh

* qemu_x86_64, kselftest-rtc
  - rtc.rtctest

* x86, kselftest-lkdtm
  - lkdtm.SLAB_FREE_DOUBLE.sh


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211001)
* qemu-arm64-mte, kselftest-timers
  - timers.rtcpie


## Test result summary
total: 4010, pass: 2387, fail: 331, skip: 1292, xfail: 0

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
* kselftest-bpf
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
* kselftest-lkdtm
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
* kselftest-tc-testing
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
