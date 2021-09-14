Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A8940A8C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 10:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhINICg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 04:02:36 -0400
Received: from a8-97.smtp-out.amazonses.com ([54.240.8.97]:46809 "EHLO
        a8-97.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229650AbhINICG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 04:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1631606448;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=8cEO6j2p8T8EMB3yyNv/pGzqLdYy7sLG/Q8nHX32wxc=;
        b=kLTq5Z0FD1N5wq8k+Ma7RGprjalriA5f9YYc+rlJlmtvOFIOS7k/ismBGZb/Wk7W
        12GwOWI2XPrvkrWTbQvNc/2EYiyKu228C+Kv6sScJMs9XOVDGBhh8WCve+M73xvpanF
        KoE3Z+6672TisQin/nUrd55AdMKxjrvVFXwtbiN8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1631606448;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=8cEO6j2p8T8EMB3yyNv/pGzqLdYy7sLG/Q8nHX32wxc=;
        b=TxJrH9afvO0gfXdFYpMiWMODnD027c1QPbu1qOi5Ow1DM1wr36gxFg4+mnYr9aoT
        fDCQJdXcTdw3WEcoszM2+UXGeqTVHo6WWAUN+0GEKMl0S0WQtxvUGZYFKvkoImQQSmU
        y7+n+/jgZzQdcyCjXwddsv5RFFMk1jcxuBE/QSsE=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20210910
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017be352a016-4ed4291b-f97d-4fcc-ad84-452397ca60f1-000000@email.amazonses.com>
Date:   Tue, 14 Sep 2021 08:00:48 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.09.14-54.240.8.97
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.14.0
* git: ['https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: aa14a3016182213f022068500486ef3bcacb9006
* git describe: next-20210910
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210910

## Regressions (compared to next-20210909)
* hi6220-hikey, kselftest-rtc
  - rtc.rtctest

* juno-r2, kselftest-net
  - net.udpgso_bench.sh

* qemu_arm, kselftest-pidfd
  - pidfd.pidfd_test

* x15, kselftest-rtc
  - rtc.rtctest.rtc.alarm_alm_set
  - rtc.rtctest.rtc.alarm_alm_set_minute
  - rtc.rtctest.rtc.alarm_wkalm_set
  - rtc.rtctest.rtc.date_read

* x86, kselftest-net
  - net.fib-onlink-tests.sh


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20210909)
* juno-r2, kselftest-
  - rtc.rtctest

* juno-r2, kselftest-rtc
  - rtc.rtctest

* qemu-arm64-mte, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu-arm64-mte, kselftest-timers
  - timers.rtcpie

* qemu_arm64, kselftest-timers
  - timers.rtcpie


## Test result summary
total: 6624, pass: 3951, fail: 723, skip: 1950, xfail: 0

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
