Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16944157F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Sep 2021 07:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbhIWFt0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Sep 2021 01:49:26 -0400
Received: from a8-97.smtp-out.amazonses.com ([54.240.8.97]:38625 "EHLO
        a8-97.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229890AbhIWFtZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Sep 2021 01:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1632376074;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=3SX6DvL+6dSye6mRXpQpLiVaLSVQovXRhmITVyTneNw=;
        b=hK90uQLcVSx5D3B70zlDQqSOnM0d0r0FjiVoprvXb5mbUN2+Eu/OFZWcNkpbuapP
        oOWhyxQPiDOU/axkN2W5ZfrdOtcX4RrtxeSzHm2RXZsx7Gmj28ccMplACiJGjzgSzzf
        9SZpBsl/RTkds7/J7VnrfuE9Y1ChxWv7qjLJt3Zg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1632376074;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=3SX6DvL+6dSye6mRXpQpLiVaLSVQovXRhmITVyTneNw=;
        b=IxgpL3q+XXQX0ZKr4vW9UhwPmPmhL2h5p9SdwG3Teh/qMsMvYq58t2QMi7OJNDFp
        kPOQOIbqtkqqOpSftaDVi0J0RWF2M2J4oRi1AtpLBPYsp+2GjwKq1hgkOpBqL+gYA2R
        Bzy8DzutEDiQj3UUxoHprrfSXie3zX1E+18wy+a8=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20210916
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017c11322f11-0823e650-3cef-4126-8e28-d13245670437-000000@email.amazonses.com>
Date:   Thu, 23 Sep 2021 05:47:54 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.09.23-54.240.8.97
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 368847b165bbfbdcf0bd4c96b167893dcdb13aba
* git describe: next-20210916
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210916

## Regressions (compared to next-20210914)
* i386, kselftest-net
  - net.ip_defrag.sh
  - net.so_txtime.sh

* qemu-arm64-gic-version3, kselftest-timers
  - timers.rtcpie

* qemu-arm64-mte, kselftest-timers
  - timers.rtcpie

* x15, kselftest-rtc
  - rtc.rtctest

* x86, kselftest-lkdtm
  - lkdtm.SLAB_FREE_DOUBLE.sh

* x86, kselftest-rtc
  - rtc.rtctest


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20210914)
* i386, kselftest-net
  - net.test_bpf.sh

* qemu-arm64-gic-version2, kselftest-timers
  - timers.rtcpie

* qemu_arm, kselftest-rtc
  - rtc.rtctest

* qemu_x86_64, kselftest-rtc
  - rtc.rtctest

* x15, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* x86, kselftest-net
  - net.ip_defrag.sh


## Test result summary
total: 4870, pass: 2704, fail: 394, skip: 1772, xfail: 0

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
