Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EE3492B8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 17:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244204AbiARQvO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 11:51:14 -0500
Received: from a8-73.smtp-out.amazonses.com ([54.240.8.73]:39511 "EHLO
        a8-73.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239060AbiARQvO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 11:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1642524673;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=J6DXW3Tz+URePxKKgqGa79l5TLNeBu0DvOkgDErrT74=;
        b=IeFu0czD6pRyy9+mt1RZ+eQ3vPalb4RrCquT89LkyTUYCIYqsziAhulmj7CKxUa+
        O6xN4O6kWCxu80iHTbcV0BGlB0jrarteR7EBdViAovu0jDqjMmEsNssUBW8jQx4DtcM
        z6vcB4g/rTS5hyKR9MMDiXHx+mX1JlqwMlJkq6LA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1642524673;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=J6DXW3Tz+URePxKKgqGa79l5TLNeBu0DvOkgDErrT74=;
        b=hMUy62R1UQgeoJbX8R1/cr6BWKoQQ8VP9RSKVMphf/6U6LnS8zA+1xFs/UYN87h9
        Q6ehO/KgtulaeU/5snAHC2Fcjq/ngmW8ty/xN46OrVwj7oIkm0v3Lpvg1fmDArty2D3
        kAKN307S92uDtd1rJbfuaBVemjTRRDqL7Fa+ePOg=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211130
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017e6e1983e1-1002ca40-7108-40ea-8426-c33dc7e61f19-000000@email.amazonses.com>
Date:   Tue, 18 Jan 2022 16:51:13 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.01.18-54.240.8.73
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.16.0-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 34f255a1e91ab44ff8926cf8294ff9144e62e861
* git describe: next-20211130
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211130

## Test Regressions (compared to next-20211117)
* dragonboard-410c, kselftest-capabilities
  - capabilities.test_execve

* dragonboard-410c, kselftest-pidfd
  - pidfd.pidfd_poll_test

* dragonboard-410c, kselftest-proc
  - proc.proc-fsconfig-hidepid

* dragonboard-410c, kselftest-timers
  - timers.rtcpie

* hi6220-hikey, kselftest-timers
  - timers.rtcpie
  - timers.set-timer-lat

* qemu_i386, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu_i386, kselftest-rtc
  - rtc.rtctest

* x15, kselftest-rtc
  - rtc.rtctest.rtc.alarm_alm_set
  - rtc.rtctest.rtc.alarm_alm_set_minute
  - rtc.rtctest.rtc.alarm_wkalm_set
  - rtc.rtctest.rtc.date_read

* x86, kselftest-kvm
  - kvm.kvm_page_table_test


## Metric Regressions (compared to next-20211117)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20211117)
* i386, kselftest-rtc
  - rtc.rtctest

* qemu_arm, kselftest-timers
  - timers.rtcpie

* qemu_x86_64, kselftest-timers
  - timers.rtcpie

* x15, kselftest-sync
  - sync.sync_test


## Metric Fixes (compared to next-20211117)
No metric fixes found.

## Test result summary
total: 4544, pass: 2455, fail: 420, skip: 1669, xfail: 0

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
