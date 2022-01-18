Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A547D4929FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 17:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346171AbiARQC0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 11:02:26 -0500
Received: from a8-35.smtp-out.amazonses.com ([54.240.8.35]:39931 "EHLO
        a8-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346184AbiARQCY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 11:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1642521743;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=NqO7nFTJ0IO41sYZdwqrSkj4k/3A2OFXJ7wlvd+Pmqo=;
        b=MIphy+IC/4Y/abffXRXp5Vpq1smaWYS0oLS0HYDby5LvN85AOanqIEvS69Mr00nd
        g0RLKHIdRUE0Zrj22T8+eWvSbREXDfbjgM5dDE8PCiB0Ld7XJyZMe4bD3G7UH1FMvYH
        xdAZSs+8Lb8faUuNfswRd9UzYm7ONnivmBIXkFvU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1642521743;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=NqO7nFTJ0IO41sYZdwqrSkj4k/3A2OFXJ7wlvd+Pmqo=;
        b=HsHxmXV2PWh9W6M4T1JepWcf4tqe0ARHP4dVad2lD2p8CSU4gkbffqMLRST3nQV2
        UAviPS74htmOaerph6+Dd/2QqYXiVwnbo55QjIi0b5oOXaMfc7XjUUJIGJ6misHdD7w
        PVZV9kfISUhba0Fw2HxCNmNVFJ425uE8CGrocqT8=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211124
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017e6deccd3f-77964da7-0ebe-4914-b2dd-15e0449aa7fd-000000@email.amazonses.com>
Date:   Tue, 18 Jan 2022 16:02:22 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.01.18-54.240.8.35
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.16.0-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 4b74e088fef6ce8cc513f935ce236c38bdf5f67b
* git describe: next-20211124
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211124

## Test Regressions (compared to next-20211117)
* dragonboard-410c, kselftest-capabilities
  - capabilities.test_execve

* dragonboard-410c, kselftest-pidfd
  - pidfd.pidfd_poll_test

* dragonboard-410c, kselftest-seccomp
  - seccomp.seccomp_bpf
  - seccomp.seccomp_bpf.global.user_notification_filter_empty
  - seccomp.seccomp_bpf.global.user_notification_filter_empty_threaded

* qemu_i386, kselftest-rtc
  - rtc.rtctest

* qemu_x86_64, kselftest-kvm
  - kvm.rseq_test

* qemu_x86_64, kselftest-proc
  - proc.read

* x15, kselftest-capabilities
  - capabilities.test_execve

* x15, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_kill
  - cgroup.test_kill.test_cgkill_simple

* x15, kselftest-net
  - net.gro.sh
  - net.run_netsocktests
  - net.so_txtime.sh

* x15, kselftest-rtc
  - rtc.rtctest.rtc.alarm_alm_set
  - rtc.rtctest.rtc.alarm_alm_set_minute
  - rtc.rtctest.rtc.alarm_wkalm_set
  - rtc.rtctest.rtc.date_read

* x86, kselftest-kvm
  - kvm.kvm_page_table_test


## Metric Regressions (compared to next-20211117)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20211117)
* hi6220-hikey, kselftest-timers
  - timers.nsleep-lat

* qemu_arm, kselftest-rtc
  - rtc.rtctest

* qemu_arm, kselftest-timers
  - timers.rtcpie

* qemu_x86_64, kselftest-timers
  - timers.rtcpie

* x15, kselftest-core
  - core.close_range_test

* x15, kselftest-net
  - net.cmsg_so_mark.sh
  - net.fib_rule_tests.sh
  - net.icmp_redirect.sh
  - net.tls
  - net.unicast_extensions.sh

* x15, kselftest-sync
  - sync.sync_test

* x86, kselftest-net
  - net.gro.sh


## Metric Fixes (compared to next-20211117)
No metric fixes found.

## Test result summary
total: 7117, pass: 4386, fail: 737, skip: 1994, xfail: 0

## Build Summary

## Test suites summary
* kselftest-
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
