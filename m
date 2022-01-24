Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7996E497ABF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 09:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbiAXIwy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 03:52:54 -0500
Received: from a8-73.smtp-out.amazonses.com ([54.240.8.73]:59377 "EHLO
        a8-73.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242400AbiAXIww (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 03:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1643014371;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=o1K0lEEJe4jnf8J45sFmRcP/C6teT5vE0Bfx/oI1YJc=;
        b=U+OYQRM2O+pN2c/+kbXbocfryywv4wFaKd6ovjZ4ABjddFwfalcUZtocILjPC9ih
        R+Ha1Ps8qGNfQW+/Zkb9S9Z6emvLY7lXRb3iw1BfrZIRPDlAldxpjbNpMYNfuaCmSoV
        0MvhtlncpnK33OgyI6fnt42yW5+akf4lf/39DZVU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1643014371;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=o1K0lEEJe4jnf8J45sFmRcP/C6teT5vE0Bfx/oI1YJc=;
        b=Z2VuoUr7LJLFED1p6QKtLX3H7Yg6Kg0Z7fZdbYef+3BxVsGz6hz9vBndflBrqyiJ
        IsXzjBOFh4q9HyBfJXDjJovZ9ObZ6gcojDNWTWHdFKdIE9VU7WHRXTZCy9EP0Aytq95
        jzTvZQxhaliZdxG/JTE7o4pKCx6exTZWwrOia4QY=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20220124
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017e8b49b602-2e1d3f57-46a0-4cd7-9dcb-9087f8de159c-000000@email.amazonses.com>
Date:   Mon, 24 Jan 2022 08:52:50 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.01.24-54.240.8.73
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.17.0-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 74e5dee6a5b9683e4e78aad784c6c807833cb89b
* git describe: next-20220124
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220124

## Test Regressions (compared to next-20220121)
* dragonboard-410c, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_kill

* dragonboard-410c, kselftest-net
  - net.tls.tls.13_aes_gcm_256.shutdown_reuse

* dragonboard-410c, kselftest-pidfd
  - pidfd.pidfd_setns_test

* dragonboard-410c, kselftest-proc
  - proc.fd-001-lookup
  - proc.fd-002-posix-eq
  - proc.proc-fsconfig-hidepid
  - proc.proc-multiple-procfs

* dragonboard-410c, kselftest-rseq
  - rseq.basic_percpu_ops_test
  - rseq.basic_test
  - rseq.param_test
  - rseq.param_test_benchmark
  - rseq.param_test_compare_twice

* dragonboard-410c, kselftest-seccomp
  - seccomp.seccomp_bpf
  - seccomp.seccomp_bpf.global.user_notification_filter_empty
  - seccomp.seccomp_bpf.global.user_notification_filter_empty_threaded

* dragonboard-410c, kselftest-sync
  - sync.sync_test

* dragonboard-410c, kselftest-timens
  - timens.procfs
  - timens.timens

* i386, kselftest-rtc
  - rtc.rtctest

* juno-r2, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* x15, kselftest-capabilities
  - capabilities.test_execve

* x15, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_kill
  - cgroup.test_kill.test_cgkill_simple

* x15, kselftest-core
  - core.close_range_test

* x15, kselftest-sync
  - sync.sync_test


## Metric Regressions (compared to next-20220121)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220121)
* dragonboard-410c, kselftest-capabilities
  - capabilities.test_execve

* dragonboard-410c, kselftest-pidfd
  - pidfd.pidfd_setns_test

* dragonboard-410c, kselftest-proc
  - proc.fd-001-lookup
  - proc.fd-002-posix-eq
  - proc.proc-fsconfig-hidepid
  - proc.proc-multiple-procfs

* dragonboard-410c, kselftest-rseq
  - rseq.basic_percpu_ops_test
  - rseq.basic_test
  - rseq.param_test
  - rseq.param_test_benchmark
  - rseq.param_test_compare_twice

* dragonboard-410c, kselftest-seccomp
  - seccomp.seccomp_bpf
  - seccomp.seccomp_bpf.global.user_notification_filter_empty
  - seccomp.seccomp_bpf.global.user_notification_filter_empty_threaded

* dragonboard-410c, kselftest-sync
  - sync.sync_test

* dragonboard-410c, kselftest-timens
  - timens.procfs
  - timens.timens

* hi6220-hikey, kselftest-timers
  - timers.set-timer-lat

* juno-r2, kselftest-proc
  - proc.proc-uptime-001

* juno-r2, kselftest-rtc
  - rtc.rtctest

* qemu_x86_64, kselftest-rtc
  - rtc.rtctest

* x15, kselftest-capabilities
  - capabilities.test_execve

* x15, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_kill
  - cgroup.test_kill.test_cgkill_simple

* x15, kselftest-core
  - core.close_range_test

* x86, kselftest-net
  - net.gro.sh
  - net.udpgso_bench.sh


## Metric Fixes (compared to next-20220121)
No metric fixes found.

## Test result summary
total: 6558, pass: 4178, fail: 847, skip: 1533, xfail: 0

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
