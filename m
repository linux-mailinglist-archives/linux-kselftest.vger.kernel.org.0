Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794AD47B10A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Dec 2021 17:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbhLTQYD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Dec 2021 11:24:03 -0500
Received: from a8-35.smtp-out.amazonses.com ([54.240.8.35]:44271 "EHLO
        a8-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232694AbhLTQYD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Dec 2021 11:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1640017442;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=EAWe71h8BQAmwPYFMYpGw/kfEf/sOFVhRtCqo2zdCEY=;
        b=m9UTDw0zMkyNFPEeFwHpZd6RKzuV3DrYDrqp48LvLWvaHNb/7ZnwlRVsXWbdOPJx
        mExa9+U2oJhB0qyMsbJw9vYt76KS4YfIHz5pRaKQRS+H9VP5F7Jbj4IRSYkdtJoLYDy
        ve5Dz1O61DExG9qF68sqUa/mpAmHhw/t/RL5u1MY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1640017442;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=EAWe71h8BQAmwPYFMYpGw/kfEf/sOFVhRtCqo2zdCEY=;
        b=OHSoTmgdAsutlAgP46XX5XP3gDwWFuylrSEZP81VUtDY40FySfnrmET3znMEyq5F
        tZp6IFWmEfCKGusP5UyPyI60D3GAEahkYVx1rBLmjJw5vUripfHE2oRscSChPA67lHv
        9jGPhcg2ZBZWI0aImu+oZXpeiEIQB9nRzAbc9p44=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for v5.16-rc4-6579-gea922272cbe5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017dd8a8347c-a79028c5-7bb0-4549-acc3-7c36ac72a873-000000@email.amazonses.com>
Date:   Mon, 20 Dec 2021 16:24:02 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.12.20-54.240.8.35
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.16.0-rc4
* git: ['https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: ea922272cbe547bdf58da2aaf240d59782c6a009
* git describe: v5.16-rc4-6579-gea922272cbe5
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/v5.16-rc4-6579-gea922272cbe5

## Test Regressions (compared to next-20211117)
* dragonboard-410c, kselftest-capabilities
  - capabilities.test_execve

* dragonboard-410c, kselftest-proc
  - proc.proc-fsconfig-hidepid

* hi6220-hikey, kselftest-timers
  - timers.rtcpie
  - timers.set-timer-lat

* qemu_arm, kselftest-zram
  - zram.zram.sh

* x15, kselftest-capabilities
  - capabilities.test_execve

* x15, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_kill
  - cgroup.test_kill.test_cgkill_simple

* x15, kselftest-rtc
  - rtc.rtctest.rtc.alarm_alm_set
  - rtc.rtctest.rtc.alarm_alm_set_minute
  - rtc.rtctest.rtc.alarm_wkalm_set
  - rtc.rtctest.rtc.date_read

* x86, kselftest-kvm
  - kvm.vmx_pmu_msrs_test


## Metric Regressions (compared to next-20211117)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20211117)
* dragonboard-410c, kselftest-sync
  - sync.sync_test

* qemu_arm, kselftest-timers
  - timers.rtcpie

* qemu_x86_64, kselftest-kvm
  - kvm.set_memory_region_test

* qemu_x86_64, kselftest-rtc
  - rtc.rtctest

* qemu_x86_64, kselftest-timers
  - timers.rtcpie

* x15, kselftest-core
  - core.close_range_test

* x15, kselftest-sync
  - sync.sync_test

* x86, kselftest-kvm
  - kvm.memslot_perf_test

* x86, kselftest-rtc
  - rtc.rtctest


## Metric Fixes (compared to next-20211117)
No metric fixes found.

## Test result summary
total: 3939, pass: 2058, fail: 419, skip: 1462, xfail: 0

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
