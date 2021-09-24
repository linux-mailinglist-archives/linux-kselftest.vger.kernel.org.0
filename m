Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9805D417174
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Sep 2021 14:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244801AbhIXMEH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Sep 2021 08:04:07 -0400
Received: from a48-37.smtp-out.amazonses.com ([54.240.48.37]:39795 "EHLO
        a48-37.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244396AbhIXMEH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Sep 2021 08:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1632484953;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=QkTkO2qJ+t0Qo7+dtVkhXfNpLIEzWPuFV8ulqiKnFBg=;
        b=JTz+dZ75a1y+2+bqu7vLgxjDz0ROpiot6htn6ldQaBto7ENYSJ5y4pHIPGAQOY+V
        pknRm/jzyp6OtzMWXJ7gmciNRcMLx9us6UmwmscbdJ42isW12y+W5DQFYaS333xBYjv
        qM+rYf/WbfM54j+DUNP5QyVIHux8nmCq3YwdeQYU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1632484953;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=QkTkO2qJ+t0Qo7+dtVkhXfNpLIEzWPuFV8ulqiKnFBg=;
        b=kgbK3q9i6+lSftskR77D69o+nrUNe9w06Ss2ijXTZh6YH3Dcs4chk6xSE3vm9EA1
        zyfjUjpVxunmE2v7FKppAipeaW+6l/aGdGUPoi2TjSKkaCxSokDaREPrgxUpBOiP+zV
        TVtR5rWst7fiOCR2WZHGU0STlDKp4AAw8+nL6yMk=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20210920
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017c17af8952-21a5524a-e367-4141-a6cd-e6247468eb3c-000000@email.amazonses.com>
Date:   Fri, 24 Sep 2021 12:02:33 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.09.24-54.240.48.37
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 1f77990c4b7960a82d599567c586ceb8289f71ed
* git describe: next-20210920
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210920

## Regressions (compared to next-20210915)
* qemu_i386, kselftest-mqueue
  - mqueue.mq_perf_tests

* qemu_i386, kselftest-rtc
  - rtc.rtctest

* qemu_i386, kselftest-seccomp
  - seccomp.seccomp_benchmark

* qemu_x86_64, kselftest-kvm
  - kvm.tsc_msrs_test

* x15, kselftest-rtc
  - rtc.rtctest.rtc.alarm_alm_set
  - rtc.rtctest.rtc.alarm_alm_set_minute
  - rtc.rtctest.rtc.alarm_wkalm_set
  - rtc.rtctest.rtc.date_read


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20210915)
* qemu-arm64-gic-version2, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu-arm64-gic-version3, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu-arm64-gic-version3, kselftest-timers
  - timers.rtcpie

* qemu-arm64-mte, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu-arm64-mte, kselftest-timers
  - timers.rtcpie

* qemu_arm, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_migrate


## Test result summary
total: 4374, pass: 2377, fail: 367, skip: 1630, xfail: 0

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
