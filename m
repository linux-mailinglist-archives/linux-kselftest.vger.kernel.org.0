Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C9247B103
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Dec 2021 17:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbhLTQXP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Dec 2021 11:23:15 -0500
Received: from a8-81.smtp-out.amazonses.com ([54.240.8.81]:43041 "EHLO
        a8-81.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232820AbhLTQXP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Dec 2021 11:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1640017394;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=BIv236UWFr8LBp2QV7Pqk2d+JFnxm3rPvPrELP6PP3k=;
        b=aKxV/Av2XuTByotFA36YmQuh6K/wnDLIyi2o0gPnBeyxPh0+dWw799wWkwVkCVOc
        GuiDztHZOyyVC+IW+TegSRuU4BRswUG3alX/RCZthyn17fgxQ3WDKcScUDnD0on19xa
        ZMGujJduXVAYFFDRtlrUErv+IbsUAZJ+dsMTG+Tc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1640017394;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=BIv236UWFr8LBp2QV7Pqk2d+JFnxm3rPvPrELP6PP3k=;
        b=gKndlwklMUu+VHgkBX15PF3tcBC9UTw3s837qHU5Dwy14eKIOwiL3oZsM1zM/w4g
        woEH9OBMwcXMF1Emra3Js9+GP30yLaB0YK08L8LpFNjAp0c8s7d4cyc7ZdOufjJoixI
        nKtDfhcj6isXOqEL6z4Lzp/eVcLbTdzZdTj9SRLg=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211207
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017dd8a779f5-47b88b14-3123-4b96-8fa3-e656d6ceba1e-000000@email.amazonses.com>
Date:   Mon, 20 Dec 2021 16:23:14 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.12.20-54.240.8.81
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.16.0-rc4
* git: ['https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: 04fe99a8d936d46a310ca61b8b63dc270962bf01
* git describe: next-20211207
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211207

## Test Regressions (compared to next-20211117)
* dragonboard-410c, kselftest-capabilities
  - capabilities.test_execve

* dragonboard-410c, kselftest-pidfd
  - pidfd.pidfd_poll_test

* dragonboard-410c, kselftest-proc
  - proc.proc-fsconfig-hidepid

* hi6220-hikey, kselftest-cgroup
  - cgroup.test_freezer

* hi6220-hikey, kselftest-timers
  - timers.set-timer-lat

* qemu_arm, kselftest-zram
  - zram.zram.sh

* qemu_i386, kselftest-rtc
  - rtc.rtctest

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
* hi6220-hikey, kselftest-timers
  - timers.nsleep-lat

* i386, kselftest-rtc
  - rtc.rtctest

* qemu_arm, kselftest-rtc
  - rtc.rtctest

* qemu_arm, kselftest-timers
  - timers.rtcpie

* qemu_x86_64, kselftest-timers
  - timers.rtcpie

* x15, kselftest-core
  - core.close_range_test

* x15, kselftest-sync
  - sync.sync_test

* x86, kselftest-rtc
  - rtc.rtctest


## Metric Fixes (compared to next-20211117)
No metric fixes found.

## Test result summary
total: 3578, pass: 1828, fail: 395, skip: 1355, xfail: 0

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
