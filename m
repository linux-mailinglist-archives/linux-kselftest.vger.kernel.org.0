Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D130A47F4BF
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Dec 2021 00:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhLYXnc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Dec 2021 18:43:32 -0500
Received: from a8-97.smtp-out.amazonses.com ([54.240.8.97]:40331 "EHLO
        a8-97.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229905AbhLYXnb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Dec 2021 18:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1640475810;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=TbFg1AV95/Yu8ccauAwwDeLnP2EmnL0SzL0mH1/w2pk=;
        b=Jij0d2/1xcmz9yUKcQ9oPkclbitfnfzovBZHjlRS0N6/vuxUrf3amwF79sMw9jA9
        KX7hX1glzFVMNh2XX4Xx80/KX9PfkkeE2TjTmKb5q/SRBQXz9/rmSLSDwR8sVw+f1wO
        InnzEQemGcatF7f8wmi0PawsO5cClRZ1KuBXNLgQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1640475810;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=TbFg1AV95/Yu8ccauAwwDeLnP2EmnL0SzL0mH1/w2pk=;
        b=QUgd5s9DwYpYhWusQyxNakkrGRbZzMl4/OxFpL95uurrd1EIPK738n5ybQ/tHnxQ
        3KpFqVpa+e8Z+rDJSY2O+nul9KnsP7Iat5lzBgGh1uSNC8j1CGZpBc1lO7A/lUBuYrq
        HJ87JT6roOd3JYcB7u2vstAgH/51/WCahtDKKOUU=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211224
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017df3fa5ac1-beaa32ec-00c9-449f-aa5a-4927f54ac5a6-000000@email.amazonses.com>
Date:   Sat, 25 Dec 2021 23:43:30 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.12.25-54.240.8.97
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.16.0-rc6
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: ea586a076e8aa606c59b66d86660590f18354b11
* git describe: next-20211224
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211224

## Test Regressions (compared to next-20211216)
* dragonboard-410c, kselftest-capabilities
  - capabilities.test_execve

* dragonboard-410c, kselftest-proc
  - proc.proc-fsconfig-hidepid

* dragonboard-410c, kselftest-seccomp
  - seccomp.seccomp_bpf
  - seccomp.seccomp_bpf.global.user_notification_filter_empty
  - seccomp.seccomp_bpf.global.user_notification_filter_empty_threaded

* hi6220-hikey, kselftest-rtc
  - rtc.rtctest

* hi6220-hikey, kselftest-timers
  - timers.nsleep-lat

* qemu_x86_64, kselftest-kvm
  - kvm.rseq_test

* x15, kselftest-core
  - core.close_range_test

* x15, kselftest-rtc
  - rtc.rtctest.rtc.alarm_alm_set
  - rtc.rtctest.rtc.alarm_alm_set_minute
  - rtc.rtctest.rtc.alarm_wkalm_set
  - rtc.rtctest.rtc.date_read


## Metric Regressions (compared to next-20211216)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20211216)
* dragonboard-410c, kselftest-gpio
  - gpio.gpio-sim.sh

* dragonboard-410c, kselftest-rseq
  - rseq.basic_percpu_ops_test
  - rseq.basic_test
  - rseq.param_test
  - rseq.param_test_benchmark
  - rseq.param_test_compare_twice

* hi6220-hikey, kselftest-gpio
  - gpio.gpio-sim.sh

* qemu_i386, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu_i386, kselftest-gpio
  - gpio.gpio-sim.sh

* qemu_i386, kselftest-rtc
  - rtc.rtctest

* qemu_x86_64, kselftest-gpio
  - gpio.gpio-sim.sh

* x15, kselftest-capabilities
  - capabilities.test_execve

* x15, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_kill
  - cgroup.test_kill.test_cgkill_simple

* x86, kselftest-gpio
  - gpio.gpio-sim.sh

* x86, kselftest-kvm
  - kvm.vmx_pmu_msrs_test

* x86, kselftest-rtc
  - rtc.rtctest


## Metric Fixes (compared to next-20211216)
No metric fixes found.

## Test result summary
total: 3543, pass: 1923, fail: 357, skip: 1263, xfail: 0

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
