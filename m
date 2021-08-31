Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05803FC40F
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Aug 2021 10:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbhHaICC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Aug 2021 04:02:02 -0400
Received: from a8-35.smtp-out.amazonses.com ([54.240.8.35]:52095 "EHLO
        a8-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240095AbhHaICC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Aug 2021 04:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1630396866;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=ayeteaioTAEmw+JYzz9ubCQh1/U2zJuzXtHIVllOKL4=;
        b=tt+c3ny0Ctp8MGqUPo7MWMzaTGvQpP+LZFk9E7k1V9vMEqQa2P+lvQiE244u7Vp/
        ouBRhDL9018IGiRdFdHLhMVl3brkZtjVrWjpMGCaPmIxF+bv0ULFIwNfiDtM1q4qo9W
        O8XrxVGGj6oxontyjFSkve6cIKmspgvy9Os+KM6M=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1630396866;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=ayeteaioTAEmw+JYzz9ubCQh1/U2zJuzXtHIVllOKL4=;
        b=ZbQ13P3QP48qbTmxbvavCNkeyTCriiKPJ7PiK8yWy/O1LrZ+G0z/W5MLLewd66k8
        Dizg2YUuXKmNeGIGT5YQJx+jXMpn/bOfU2Pc00QF/2h/+0s9/QMuqgnW6tw+c8cnsoU
        kMh3tmHxv3bfbvR9+t7oe3CrQSRNsVIzGIkYRPZ4=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20210830
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017b9b39df1c-e7c56f70-d95e-4841-8594-c1c843eadc1d-000000@email.amazonses.com>
Date:   Tue, 31 Aug 2021 08:01:06 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.08.31-54.240.8.35
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.14.0
* git: ['https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: 93717cde744f9d26aa1b4561f7d9ba2a230459eb
* git describe: next-20210830
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210830

## Regressions (compared to next-20210827)
* dragonboard-410c, kselftest-net
  - net.udpgso_bench.sh

* qemu-arm64-gic-version3, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu-arm64-gic-version3, kselftest-timers
  - timers.rtcpie

* qemu_arm, kselftest-rtc
  - rtc.rtctest.rtc.alarm_alm_set_minute


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20210827)
* qemu_arm, kselftest-timers
  - timers.rtcpie

* qemu_i386, kselftest-rtc
  - rtc.rtctest

* qemu_i386, kselftest-seccomp
  - seccomp.seccomp_benchmark


## Test result summary
total: 5374, pass: 3047, fail: 465, skip: 1862, xfail: 0

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
