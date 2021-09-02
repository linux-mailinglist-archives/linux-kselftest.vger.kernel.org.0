Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D4E3FF4C6
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 22:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhIBUUD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Sep 2021 16:20:03 -0400
Received: from a8-29.smtp-out.amazonses.com ([54.240.8.29]:37331 "EHLO
        a8-29.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240146AbhIBUUD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Sep 2021 16:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1630613943;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=5l9yd/Xx+Ayncm22q6bq52OrpE1mfSYuLOTlZPSE7Kw=;
        b=RGIrMJ9nwzltRnAMzkNiWJQhw0+IKb6xkqoFifw28YrAiAc5Mo8RUb6P0CgwiusT
        QAvhRt64v+CNoiY0wrmBCzo9sWOndsyjUFTUo32kNPvSY/X47LFUhsOPzrObcppC9IA
        Y5GPQWb5kjSm3ObHeRO2zXbbH5Pzerf1aDxOeQQM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1630613943;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=5l9yd/Xx+Ayncm22q6bq52OrpE1mfSYuLOTlZPSE7Kw=;
        b=TVn5qPbKWUWtbz/4T5FyVYn5jwi6s5mM7GxONG09rySZD8L3osl3yLZkPjgq/MNM
        mRqx/Zwo8fH7TOWvPf4p6UJ4SXWrfbqMynXS8S8Nh+RFzcarmAIPIpjnGUNiiwMvcMS
        CpVf2ljEPBkJ4Ge0IJeR1THtEO9mB/tiU1mr6LS0=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20210902
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017ba82a353b-c7100603-a163-49ea-a90d-4176769fe59e-000000@email.amazonses.com>
Date:   Thu, 2 Sep 2021 20:19:03 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.09.02-54.240.8.29
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.14.0
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 34560ced20599a01660a693f464c7c7dc83db1d9
* git describe: next-20210902
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210902

## Regressions (compared to next-20210831)
* i386, kselftest-net
  - net.so_txtime.sh

* qemu_arm, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_migrate

* qemu_arm, kselftest-rtc
  - rtc.rtctest

* qemu_arm64, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu_i386, kselftest-rtc
  - rtc.rtctest

* qemu_x86_64, kselftest-timers
  - timers.rtcpie

* x86, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* x86, kselftest-rtc
  - rtc.rtctest


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20210831)
* dragonboard-410c, kselftest-capabilities
  - capabilities.test_execve

* hi6220-hikey, kselftest-rtc
  - rtc.rtctest

* i386, kselftest-rtc
  - rtc.rtctest

* qemu_arm64, kselftest-timers
  - timers.rtcpie

* qemu_x86_64, kselftest-rtc
  - rtc.rtctest

* x15, kselftest-rtc
  - rtc.rtctest


## Test result summary
total: 4712, pass: 2612, fail: 374, skip: 1726, xfail: 0

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
