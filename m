Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93FB4009E4
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Sep 2021 07:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhIDFed (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Sep 2021 01:34:33 -0400
Received: from a8-35.smtp-out.amazonses.com ([54.240.8.35]:46861 "EHLO
        a8-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229965AbhIDFec (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Sep 2021 01:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1630733610;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=xGDmKueMKYPT/1IKkWZwv/xsidojadURtn6wJF0TpEw=;
        b=b7KFOL7jxFDzreEFO1606ezEVKJbdVdzry03/vADs34w9/95R6+lVMqvsEiQFPaU
        EK3FdPCGo8s6RCqXyMa162bWflEDQVoyrsonFtfklw1CUIEYCNvuFpzTiwYmQR3UW64
        j3+pvO50NFO/WHOtmLLE4F//djwpaZvH21DM4qOE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1630733610;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=xGDmKueMKYPT/1IKkWZwv/xsidojadURtn6wJF0TpEw=;
        b=c7XggCa9Tcbaar/jwkBdsPjxXEshWTS1HhUKAQnPXKiL7IJrce1ADe8DPeXuWgY5
        gLBcLa0ATJqM2M/0NT0NolGkJc41Nm+sCy1mtjMi4Zl6UwOAFMdExf6bq4HedXYjigr
        JB+fx1yScSoWAvR7qi0490oBFrQuF+OvofgPN39I=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20210903
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017baf4c2ddc-e7c4f771-69dc-44dd-885f-605cf0367788-000000@email.amazonses.com>
Date:   Sat, 4 Sep 2021 05:33:30 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.09.04-54.240.8.35
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.14.0
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 14c6345e6e6ca0570f3897214f24748ef6009761
* git describe: next-20210903
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210903

## Regressions (compared to next-20210902)
* i386, kselftest-net
  - net.ip_defrag.sh

* i386, kselftest-rtc
  - rtc.rtctest

* qemu_arm64, kselftest-timers
  - timers.rtcpie

* qemu_x86_64, kselftest-rtc
  - rtc.rtctest


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20210902)
* i386, kselftest-net
  - net.so_txtime.sh

* qemu-arm64-gic-version2, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu-arm64-gic-version3, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu-arm64-mte, kselftest-timers
  - timers.rtcpie

* qemu_arm, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_migrate

* qemu_arm, kselftest-rtc
  - rtc.rtctest

* qemu_x86_64, kselftest-timers
  - timers.rtcpie


## Test result summary
total: 5548, pass: 3276, fail: 566, skip: 1706, xfail: 0

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
