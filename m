Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE01B42FFD7
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Oct 2021 05:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbhJPDMx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Oct 2021 23:12:53 -0400
Received: from a8-97.smtp-out.amazonses.com ([54.240.8.97]:39727 "EHLO
        a8-97.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236426AbhJPDMw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Oct 2021 23:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1634353844;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=aaCcuqeOVV/z9i9kki6srn9Ko39Dmi4E17M9uaPpfBE=;
        b=bNKKN3OWAKP8OOcXW6V+ktzLAKlhgWUQyxiF10fVIgZ9LrxcAtyzOGrNa0rkXH3B
        BHZld+e92Cnyrrmu4ynn7R1zKM9Ny9qu+I24qcwM4hj6w8fJ8t5hnVDhE1H2IhZnHFA
        aA9gc+2/M3QubFeWiMlVS3jatvRNNLsitWVkk/Fc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1634353844;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=aaCcuqeOVV/z9i9kki6srn9Ko39Dmi4E17M9uaPpfBE=;
        b=LHLSlDBGDcHvfrKSXar13VQmBRQP16Y6JJ8fOtKHkiEeBoq5+974C7Bdk8yesyBq
        sXp5NZ5YKk1iMyOHNUYPfay6IazFOtM6Wn++usoivbIGm1IWvo6Ksj+nilFk3dDNDXd
        oJspFoALzOIX4v3ZQor9LXtNyf/46GkJSBIH/F4E=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211008
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017c87149017-adcaa936-d323-4474-8b3b-486daef4acde-000000@email.amazonses.com>
Date:   Sat, 16 Oct 2021 03:10:44 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.10.16-54.240.8.97
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc4
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 683f29b781aeaab6bf302eeb2ef08a5e5f9d8a27
* git describe: next-20211008
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211008

## Regressions (compared to next-20211006)
* qemu_x86_64, kselftest-pidfd
  - pidfd.pidfd_test

* x86, kselftest-kvm
  - kvm.hyperv_clock


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211006)
* dragonboard-410c, kselftest-gpio
  - gpio.gpio-mockup.sh

* hi6220-hikey, kselftest-proc
  - proc.proc-uptime-001

* qemu_x86_64, kselftest-seccomp
  - seccomp.seccomp_benchmark

* x86, kselftest-lkdtm
  - lkdtm.SLAB_FREE_DOUBLE.sh


## Test result summary
total: 1652, pass: 1005, fail: 105, skip: 542, xfail: 0

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
