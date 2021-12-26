Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D60847F4F0
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Dec 2021 03:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhLZCnK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Dec 2021 21:43:10 -0500
Received: from a8-73.smtp-out.amazonses.com ([54.240.8.73]:60991 "EHLO
        a8-73.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbhLZCnK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Dec 2021 21:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1640486589;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=n2xQG7AzStU3nPVNrQazQNLCRsViieocpVPPwnvsgLA=;
        b=XyVouobvN+Jq4FBf+H90W2UNiEkR3NG2aNSSAYBb+GY4RozGlWUfKKAjshDrLJ/o
        umSHy7YzK10GUEoM5yIuB5E4SZx+VmQg3kk0/DoFnTSiEpdTq68fIst1D65ri6Ht/Ix
        dCVWIemVtmHiJWP6DJ6fuws/gcLQrJtX7OrlEGxs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1640486589;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=n2xQG7AzStU3nPVNrQazQNLCRsViieocpVPPwnvsgLA=;
        b=CAwVR6BDG1Dz6nvpJ9r6hW2j/yttxX9hSpfUUKW0JYC7KpM8S+p6WCG3qtONI5K1
        2QJepXXEQDu7hK2+HXOL7gg8nYD1F/oMfC1h6xYKMt+oKSSbRBV8xt13UUNM0mKn/fS
        zvcKWjCXPlOw1S76ZtxJ/tG0WOlmHFPWW/5xF6Uc=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211222
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017df49ed2e3-d87845bb-cb42-4d40-91be-5793496d3d86-000000@email.amazonses.com>
Date:   Sun, 26 Dec 2021 02:43:09 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.12.26-54.240.8.73
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.16.0-rc6
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 2bd48302750c652889a2604b3df8b591c1d3af08
* git describe: next-20211222
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211222

## Test Regressions (compared to next-20211216)
* dragonboard-410c, kselftest-rtc
  - rtc.rtctest.rtc.uie_read

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

* hi6220-hikey, kselftest-gpio
  - gpio.gpio-sim.sh

* i386, kselftest-rtc
  - rtc.rtctest

* qemu_i386, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu_i386, kselftest-gpio
  - gpio.gpio-sim.sh

* qemu_x86_64, kselftest-gpio
  - gpio.gpio-sim.sh

* qemu_x86_64, kselftest-rtc
  - rtc.rtctest

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
total: 3109, pass: 1694, fail: 305, skip: 1110, xfail: 0

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
