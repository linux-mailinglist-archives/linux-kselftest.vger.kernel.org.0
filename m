Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B31340BDDF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 04:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhIOCqd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 22:46:33 -0400
Received: from a8-35.smtp-out.amazonses.com ([54.240.8.35]:57649 "EHLO
        a8-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235548AbhIOCqb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 22:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1631673912;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=NRIY7FIrtkKLxrLe/L942kxXNVjpTv6Nr/xzig9auYI=;
        b=OXzvyhdRGGZk5ambr8Ug0936MtRTNkkgdc3zufQ6HALAvNTB00INSXuM9ZCY/T1n
        XG0f3mQIGDhUgw9Ghnl1KuTFn1V1CO1p4BfsmpbRdUIU8JeuRbrsGFCD99eidlLilDH
        d2mhiCot30Zy2fqLE/vdg3QupuAIavvBRTe90bB8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1631673912;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=NRIY7FIrtkKLxrLe/L942kxXNVjpTv6Nr/xzig9auYI=;
        b=d9BSyhQ3XBsAQ2fq9eA0vagO/MxIyScmG8mrfvczzUY4LZsyDH4rz+8lZH1ZBiym
        IB1nCa0Rf/omNb32eI7feH+imLYNPqxvM0YL6uLyQofNr+QCeO76bfUK6+T+XnZhmU4
        S6rr0LXRnyM0ybcg1G6ybKMmegDiN9NPfEYjLkTo=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20210913
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017be75808b0-e53fad81-649f-4e92-bae1-e910b92f400a-000000@email.amazonses.com>
Date:   Wed, 15 Sep 2021 02:45:11 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.09.15-54.240.8.35
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.14.0
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 24a36d3171e4e10ef19b43db0f18bb18ad3ed8e2
* git describe: next-20210913
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210913

## Regressions (compared to next-20210909)
* hi6220-hikey, kselftest-rtc
  - rtc.rtctest

* i386, kselftest-net
  - net.ip_defrag.sh

* juno-r2, kselftest-
  - net.udpgso_bench.sh

* qemu-arm64-gic-version3, kselftest-timers
  - timers.rtcpie

* qemu_arm, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu_arm, kselftest-rtc
  - rtc.rtctest

* x86, kselftest-net
  - net.fib-onlink-tests.sh


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20210909)
* i386, kselftest-rtc
  - rtc.rtctest

* juno-r2, kselftest-
  - net.txtimestamp.sh

* qemu-arm64-gic-version2, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu-arm64-gic-version2, kselftest-timers
  - timers.rtcpie

* qemu-arm64-mte, kselftest-timers
  - timers.rtcpie

* qemu_arm64, kselftest-timers
  - timers.rtcpie


## Test result summary
total: 6273, pass: 3678, fail: 590, skip: 2005, xfail: 0

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
