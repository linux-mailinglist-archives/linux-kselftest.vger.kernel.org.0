Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C7D3FF2F6
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 20:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346689AbhIBSEX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Sep 2021 14:04:23 -0400
Received: from a8-35.smtp-out.amazonses.com ([54.240.8.35]:32993 "EHLO
        a8-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346676AbhIBSEW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Sep 2021 14:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1630605803;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=T4Cbe7b/NS2T0otNuFX7RgXIp/W9eQ2lXqssT/RlRcA=;
        b=GHE2IUKAJgkVxguocrqWm8wB0itG3S4JdA8ROLgzJ0Gu7/cFVlvAAqohwXGAMJCp
        KfzbJUrI5BSvPIbYtCjK5U04mS8cJOQ6iUc3i91sDzGLxA/EriBkmNqtuU/YtFZysC6
        n4lPfS4aWIDrByp8VKyDD7SpmdDF+U7ODWhwPR+0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1630605803;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=T4Cbe7b/NS2T0otNuFX7RgXIp/W9eQ2lXqssT/RlRcA=;
        b=KLir9EE8s17lN/gaAa8c8CqFe+L+RvGtZHoM86ibtCRwlnik5QFMZ6O+GhVxLfNT
        5tg4BKuBXzrylDP33gA0F2gTLV9yL8Fh/IlmudcLilG4MvLvAE9Da7yPyYlOcKPlxwR
        VM1lPwT0hfVigL8gpbbXf4c6J1ICDJSsX92OBCiQ=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20210901
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017ba7adfe95-f6a6a231-2261-4b18-b758-d709a73b3b07-000000@email.amazonses.com>
Date:   Thu, 2 Sep 2021 18:03:23 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.09.02-54.240.8.35
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.14.0
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: c1b13fe76e95c0f64c9dba9876dfbdb0bd862d99
* git describe: next-20210901
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210901

## Regressions (compared to next-20210831)
* qemu_arm, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_migrate
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu_arm, kselftest-rtc
  - rtc.rtctest

* qemu_arm64, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20210831)
* dragonboard-410c, kselftest-capabilities
  - capabilities.test_execve

* i386, kselftest-rtc
  - rtc.rtctest

* qemu-arm64-gic-version2, kselftest-timers
  - timers.rtcpie

* qemu-arm64-gic-version3, kselftest-timers
  - timers.rtcpie

* x86, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* x86, kselftest-rtc
  - rtc.rtctest


## Test result summary
total: 5353, pass: 3042, fail: 465, skip: 1846, xfail: 0

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
