Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FD947F359
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Dec 2021 15:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhLYOHz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Dec 2021 09:07:55 -0500
Received: from a48-34.smtp-out.amazonses.com ([54.240.48.34]:54963 "EHLO
        a48-34.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231819AbhLYOHz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Dec 2021 09:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1640441274;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=Fmql+kMKa6xchEtdxExzA/FauKkv50BVNXBJXlERiXY=;
        b=eYiSyUcwJgiaUq3IdHntcAq6qG4AiRGmgCe65s+Dp1byE3Kd0NZ/6Qg+wde1Fydt
        oZzdZchQhMwqdpY0dOnM4HuvPt5QrE5sSz79Wb7v0S+QLdZonTo1mn+4PcyLctHXtTB
        pHh+FD2AlPHAatD3u1763OOMMJopFA8wt4SvbNXw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1640441274;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=Fmql+kMKa6xchEtdxExzA/FauKkv50BVNXBJXlERiXY=;
        b=kifESm2pHoEQAKO2N6Ul+ZlKiW8bMpEWS4F69fUsX8jFpXDn269ry7ExYGKUOZo0
        +ggDbLRrvXVpx3fU7lmplQLsEHMEYVeTU8L4KX9TIEO/X9l93VWecDjhQo7UQrpwQ6p
        LsSm5hSviIE7MvPqestAmXWBSbSYCTRYNJm11IYg=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211223
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017df1eb5f0a-b0e3a631-42b8-400d-9afc-36dbe232e7ee-000000@email.amazonses.com>
Date:   Sat, 25 Dec 2021 14:07:54 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.12.25-54.240.48.34
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.16.0-rc6
* git: ['https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: 79f063d60c8cfc0c215d342cb7778e2ad402c2d5
* git describe: next-20211223
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211223

## Test Regressions (compared to next-20211216)
* dragonboard-410c, kselftest-capabilities
  - capabilities.test_execve

* dragonboard-410c, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* dragonboard-410c, kselftest-proc
  - proc.proc-fsconfig-hidepid

* dragonboard-410c, kselftest-seccomp
  - seccomp.seccomp_bpf
  - seccomp.seccomp_bpf.global.user_notification_filter_empty
  - seccomp.seccomp_bpf.global.user_notification_filter_empty_threaded

* hi6220-hikey, kselftest-rtc
  - rtc.rtctest

* x15, kselftest-core
  - core.close_range_test

* x15, kselftest-sync
  - sync.sync_test


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


## Metric Fixes (compared to next-20211216)
No metric fixes found.

## Test result summary
total: 3489, pass: 1876, fail: 336, skip: 1277, xfail: 0

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
