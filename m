Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B664F443672
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Nov 2021 20:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhKBTZh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Nov 2021 15:25:37 -0400
Received: from a8-73.smtp-out.amazonses.com ([54.240.8.73]:34359 "EHLO
        a8-73.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230295AbhKBTZg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Nov 2021 15:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1635880980;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=8h9GI46I52yCBGQp3aEXgvqRkh0640YEZ/3uecX1HHE=;
        b=aD0RqpvdmTo3VU2KNU+jspT195WGk7eyCIYHiKkVlVQP5uYajBQuH6pxS8kHhLVb
        45viQcNiD8DaCbjNImOVDGXo0mxVzT1EHcmI0Iit+HxoqIK0pE528CR15Vu1R/db9a0
        cx59OWn0m1fO4ZqwtYuAAMmRRunVdL2jWDbInKDU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1635880980;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=8h9GI46I52yCBGQp3aEXgvqRkh0640YEZ/3uecX1HHE=;
        b=bL2xLfuwlzIikkVSdHCJxKktSk95/VWiGtYzdquPZHnN0Ox8ZV9pnh9ooe27tvXV
        yllJJ1CNdOtQ9jhJFHTPxVUYWKdIlFWzNuSy+nRc5eaTZQufPhKcCDry2AOjZPrJfG/
        feRmD0wvC6xW0w5cjpXiS0lseiXeoyqXf7zHd5P8=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211102
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017ce21ace17-3e98450a-ea8f-45b0-956a-3ceedbd0cc7e-000000@email.amazonses.com>
Date:   Tue, 2 Nov 2021 19:23:00 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.11.02-54.240.8.73
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 9150de4aac1eb6e6441b2b086f6ca8132aaea040
* git describe: next-20211102
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211102

## Regressions (compared to next-20211029)
* i386, kselftest-net
  - net.tls
  - net.tls.tls.12_aes_gcm.send_then_sendfile
  - net.tls.tls.12_chacha.send_then_sendfile
  - net.tls.tls.13_aes_gcm.send_then_sendfile
  - net.tls.tls.13_chacha.send_then_sendfile
  - net.tls.tls.13_sm4_ccm.send_then_sendfile
  - net.tls.tls.13_sm4_gcm.send_then_sendfile

* qemu_arm, kselftest-timers
  - timers.rtcpie


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211029)
* i386, kselftest-net
  - net.so_txtime.sh

* i386, kselftest-rtc
  - rtc.rtctest

* i386, kselftest-seccomp
  - seccomp.seccomp_bpf.TRACE_syscall.ptrace.kill_after
  - seccomp.seccomp_bpf.TRACE_syscall.seccomp.kill_after

* qemu_arm, kselftest-rtc
  - rtc.rtctest

* qemu_i386, kselftest-rtc
  - rtc.rtctest

* qemu_x86_64, kselftest-seccomp
  - seccomp.seccomp_bpf
  - seccomp.seccomp_bpf.TRACE_syscall.ptrace.kill_after
  - seccomp.seccomp_bpf.TRACE_syscall.seccomp.kill_after

* qemu_x86_64, kselftest-x86
  - x86.iopl_64

* x15, kselftest-rtc
  - rtc.rtctest
  - rtc.rtctest.rtc.alarm_alm_set
  - rtc.rtctest.rtc.alarm_alm_set_minute
  - rtc.rtctest.rtc.alarm_wkalm_set
  - rtc.rtctest.rtc.alarm_wkalm_set_minute
  - rtc.rtctest.rtc.date_read

* x86, kselftest-seccomp
  - seccomp.seccomp_bpf.TRACE_syscall.ptrace.kill_after
  - seccomp.seccomp_bpf.TRACE_syscall.seccomp.kill_after

* x86, kselftest-x86
  - x86.iopl_64


## Test result summary
total: 2893, pass: 1766, fail: 200, skip: 927, xfail: 0

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
