Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BD04102BF
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Sep 2021 03:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbhIRBsm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Sep 2021 21:48:42 -0400
Received: from a48-37.smtp-out.amazonses.com ([54.240.48.37]:42599 "EHLO
        a48-37.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230115AbhIRBsl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Sep 2021 21:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1631929638;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=cy9R2sQOxJdBEE5GzKHYDWCbe9cajHsTcXdhamKHpxo=;
        b=DyQI+b9tiFibP/FWkdpp/cKpr/fyFOjymP46WqVlHaRC/5fy0goB2SqVr0VmMmwE
        hYjGtKfJa1MJAgeroRd5vqI4Ge7doRU7VZFm97JKXSxmr0l1Po/NikkuyPtWEqFVQV+
        mfGr3XRbLjIm+Z5IpvNX/TqToUp4IdzhUHa1mQB8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1631929638;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=cy9R2sQOxJdBEE5GzKHYDWCbe9cajHsTcXdhamKHpxo=;
        b=ecnIpQazyZJkdwETa0Em9yqKdkbOTHWg1UTDVtuZaMN4dM2WBgZzJjiJrFzYJpj+
        23eWWPThttUG4cns/tE2z/sRd4enX1OsGK6eX0s14kn3/tQQwRkANZxWt7wbW0WcmlT
        55L/vMhvW8V1/TrH/TX4/i5JNbXoH0SxlHtmB1HM=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20210915
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017bf6961c3c-c5467228-7c45-4d3a-8393-afcabc45ab34-000000@email.amazonses.com>
Date:   Sat, 18 Sep 2021 01:47:18 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.09.18-54.240.48.37
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 70ced02f322fd5bde59e805e77b19c811950d165
* git describe: next-20210915
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210915

## Regressions (compared to next-20210913)
* dragonboard-410c, kselftest-proc
  - proc.proc-uptime-001

* hi6220-hikey, kselftest-proc
  - proc.proc-uptime-001

* i386, kselftest-rtc
  - rtc.rtctest

* qemu-arm64-gic-version2, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu-arm64-mte, kselftest-timers
  - timers.rtcpie

* qemu_arm, kselftest-cgroup
  - cgroup.test_freezer.test_cgfreezer_migrate

* qemu_arm, kselftest-pidfd
  - pidfd.pidfd_test

* qemu_arm64, kselftest-timers
  - timers.rtcpie


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20210913)
* i386, kselftest-net
  - net.ip_defrag.sh

* qemu_arm, kselftest-cgroup
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu_arm64, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace


## Test result summary
total: 4731, pass: 2627, fail: 412, skip: 1692, xfail: 0

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
