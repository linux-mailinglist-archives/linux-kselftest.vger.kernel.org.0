Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1944C47B6AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 02:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhLUBFF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Dec 2021 20:05:05 -0500
Received: from a8-29.smtp-out.amazonses.com ([54.240.8.29]:39611 "EHLO
        a8-29.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229551AbhLUBFF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Dec 2021 20:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1640048704;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=6XIgwuvRADkn4ciQLoOHtaaDsCIpj1CIotsWiFDNO5M=;
        b=Ernz0XqZMwHuNraHy0eVcQEFF7zjUhtlqmHi3N5QXgvB6XE1NQopx9L+R4PPuZHI
        orF4+qr8fhHQ+ucyTePvSj96UuIH4dWddfvtSfDZq7imfjUPMiy15RfSEBaSFKhL/Un
        QDcrxw5fiLxHBEBaOQjhRbQSpxF5nYjv4WE0eTNY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1640048704;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=6XIgwuvRADkn4ciQLoOHtaaDsCIpj1CIotsWiFDNO5M=;
        b=I3Ocey5Sw5f02e9hBA3RwNYnTritsTvvKe3opbw+nLKExrt3IsKsgMQ0wtCJNZYx
        3XtQ7wojYUsiVAf9xr3FLj7eN22r/qM1WUJmWucmQG7wi9s1LjiSzoGYVpxDUFZUXP+
        qtVuZlLTsx98P6LM+hXQmM+xk78neRJuZ76YQ2kI=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211216
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017dda853a3b-3b264601-3389-49c0-88f5-015dce7c676e-000000@email.amazonses.com>
Date:   Tue, 21 Dec 2021 01:05:04 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.12.21-54.240.8.29
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.16.0-rc5
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: fbf252e0967821ce890e23359d00c30132876014
* git describe: next-20211216
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211216

## Test Regressions (compared to next-20211117)
* qemu_i386, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu_i386, kselftest-rtc
  - rtc.rtctest

* x15, kselftest-capabilities
  - capabilities.test_execve

* x15, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_kill
  - cgroup.test_kill.test_cgkill_simple

* x86, kselftest-kvm
  - kvm.vmx_pmu_msrs_test


## Metric Regressions (compared to next-20211117)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20211117)
* dragonboard-410c, kselftest-sync
  - sync.sync_test

* hi6220-hikey, kselftest-timers
  - timers.nsleep-lat

* qemu_x86_64, kselftest-kvm
  - kvm.set_memory_region_test

* qemu_x86_64, kselftest-timers
  - timers.rtcpie

* x15, kselftest-core
  - core.close_range_test

* x15, kselftest-sync
  - sync.sync_test

* x86, kselftest-kvm
  - kvm.memslot_perf_test


## Metric Fixes (compared to next-20211117)
No metric fixes found.

## Test result summary
total: 2498, pass: 1396, fail: 246, skip: 856, xfail: 0

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
