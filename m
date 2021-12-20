Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE6247B105
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Dec 2021 17:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbhLTQXc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Dec 2021 11:23:32 -0500
Received: from a8-29.smtp-out.amazonses.com ([54.240.8.29]:53221 "EHLO
        a8-29.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232820AbhLTQXc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Dec 2021 11:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1640017411;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=XjiyVZaFbLi2h66Aj1qbMD0hDfXgpAnyES5/H5AujKY=;
        b=OEICyY9tgQUnwe2mAxSFa2NmyZfwH2SYQMdEwOkomXZP6K+k56nWq2j8n1wlmook
        WzTuavzO/YP2nNLmajNfZI805jj7WlsPcDdTxq6ONCni+Zrh+SuUAvk+bnqT6p34hvY
        yf9/ke8fI7doYjD2YsCjI7PQuwl/4LPxXDTTa3PE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1640017411;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=XjiyVZaFbLi2h66Aj1qbMD0hDfXgpAnyES5/H5AujKY=;
        b=B/E7aBJ25rtVdPp8Y/2L3fMNtSGUuenBmDjfIm+78lAMB93Hl9DAYv6xEyhh9YjV
        NTyD+9MIeOuva1yYcYw5mVMA+Wx/UjFUKhdoIoLUxVy2o1fO4at0qFYyMoTLfy6+dfD
        QPjuueXDdJLOTDlWxRxpD/6h+vWE5nR1Zb0GjKcc=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for v5.16-rc5-6644-gbcd5ddb85fad
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017dd8a7bc29-bc6946f2-134e-4119-add3-c661782772d0-000000@email.amazonses.com>
Date:   Mon, 20 Dec 2021 16:23:31 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.12.20-54.240.8.29
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.16.0-rc5
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: bcd5ddb85fad453da26afd5b3fca8ad931b5253d
* git describe: v5.16-rc5-6644-gbcd5ddb85fad
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/v5.16-rc5-6644-gbcd5ddb85fad

## Test Regressions (compared to next-20211117)
* dragonboard-410c, kselftest-capabilities
  - capabilities.test_execve

* dragonboard-410c, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* dragonboard-410c, kselftest-kvm
  - kvm.get-reg-list

* dragonboard-410c, kselftest-proc
  - proc.proc-fsconfig-hidepid

* dragonboard-410c, kselftest-seccomp
  - seccomp.seccomp_bpf
  - seccomp.seccomp_bpf.global.user_notification_filter_empty
  - seccomp.seccomp_bpf.global.user_notification_filter_empty_threaded

* qemu_arm, kselftest-zram
  - zram.zram.sh

* qemu_i386, kselftest-rtc
  - rtc.rtctest

* x15, kselftest-rtc
  - rtc.rtctest.rtc.alarm_alm_set
  - rtc.rtctest.rtc.alarm_alm_set_minute
  - rtc.rtctest.rtc.alarm_wkalm_set
  - rtc.rtctest.rtc.date_read

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

* x15, kselftest-sync
  - sync.sync_test

* x86, kselftest-kvm
  - kvm.memslot_perf_test

* x86, kselftest-rtc
  - rtc.rtctest


## Metric Fixes (compared to next-20211117)
No metric fixes found.

## Test result summary
total: 3495, pass: 1960, fail: 324, skip: 1211, xfail: 0

## Build Summary

## Test suites summary
* kselftest-android
* kselftest-arm64
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
