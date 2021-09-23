Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25496415AFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Sep 2021 11:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbhIWJdd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Sep 2021 05:33:33 -0400
Received: from a8-97.smtp-out.amazonses.com ([54.240.8.97]:50725 "EHLO
        a8-97.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240166AbhIWJdc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Sep 2021 05:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1632389520;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=U2nlz7BP5H1aA7VdA6cI2yp+6geRrlnSkXKmQFtAFvA=;
        b=Mn8BHFUhLk2Bwwt2Hv/fjyJr4Xq701mXTbGkIBn1xFCbnVH+ToST2THgsebc1ctI
        qonkH7f/FzMOmSW4/oeapYM85xn0FvvMq21Xl4rs/OqPxq2tRwZ455JdZbeyz6fW3Jf
        2xc1UBYfDIqHzF5gAUTrKGDkSeSeKAFj/BIooJBA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1632389520;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=U2nlz7BP5H1aA7VdA6cI2yp+6geRrlnSkXKmQFtAFvA=;
        b=BKYa2r9wn+dfgXXtfWo0AewRt47eJy90BKSjnPMqaNohzTbfrNv0TY8kkXpjSd/m
        /xxJoSPmxy7E0VU1aqAa05mU8UQu1x4sTQ0/rU+JAKEQnqKTBfdmK4/X79nnqLrLgN3
        1jah1B8K+u9tIhz8eueu/gIEoXQfd6HwVwSAarS8=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20210917
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017c11ff5c50-97a26794-63e1-468e-82b4-7833a478c912-000000@email.amazonses.com>
Date:   Thu, 23 Sep 2021 09:32:00 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.09.23-54.240.8.97
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 9004fd387338b1104499b2c52ef5729a32c408f0
* git describe: next-20210917
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210917

## Regressions (compared to next-20210914)
* hi6220-hikey, kselftest-proc
  - proc.proc-uptime-001

* qemu-arm64-gic-version3, kselftest-timers
  - timers.rtcpie

* qemu-arm64-mte, kselftest-timers
  - timers.rtcpie

* qemu_arm, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_migrate

* qemu_arm64, kselftest-timers
  - timers.rtcpie

* qemu_i386, kselftest-timers
  - timers.rtcpie

* x15, kselftest-rtc
  - rtc.rtctest

* x86, kselftest-rtc
  - rtc.rtctest


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20210914)
* hi6220-hikey, kselftest-rtc
  - rtc.rtctest

* i386, kselftest-net
  - net.test_bpf.sh

* qemu_x86_64, kselftest-rtc
  - rtc.rtctest

* x86, kselftest-net
  - net.ip_defrag.sh


## Test result summary
total: 4894, pass: 2675, fail: 411, skip: 1808, xfail: 0

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
