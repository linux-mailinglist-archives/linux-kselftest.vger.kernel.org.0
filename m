Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5242495994
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 06:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiAUFsn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 00:48:43 -0500
Received: from a8-29.smtp-out.amazonses.com ([54.240.8.29]:46895 "EHLO
        a8-29.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230443AbiAUFsl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 00:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1642744120;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=wa9B77AxJdGF5IZDL62GeRVUTJh8sxGhaigBYNZCgcE=;
        b=befjTWObVDwhcXGNKPKqcXwNLQ5YocLwkuvBQTQtti0Qvv1Md6uy+E8DVmMBES9G
        ilT45CLh6fjd4FOjFbm8yWJlkGRfJ31ATyoIMqi0E1HE8lHtB5XZ4Hhs1jCrx2sQ0cJ
        fI6AFka7qP2yGIKMzHowYlkVyovciB+1UgMz/lNE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1642744120;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=wa9B77AxJdGF5IZDL62GeRVUTJh8sxGhaigBYNZCgcE=;
        b=LMyv8mbmKhxTgHJC38bfuB+JvP9uU9n/dcDbG96BuljyBOc0cOE6VF0q0u4KDHcY
        +3wgEkBQ/ha7zOQgv6Pz/lPrMGBayRRADPNGFQZ7DPWSqdv9TCr7NtKpGf7/lmk6+BG
        OSLgiHavg+ceOYkog4nwsaQBkyrqz6GlquxPNGOA=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20220120
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017e7b2e03a7-6d395f9e-09d0-4576-a095-2b356b79dc1e-000000@email.amazonses.com>
Date:   Fri, 21 Jan 2022 05:48:40 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.01.21-54.240.8.29
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.16.0
* git: ['https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: 7fc5253f5a13271e9df35d6b936ff97b74540a59
* git describe: next-20220120
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220120

## Test Regressions (compared to next-20220113)
* dragonboard-410c, kselftest-capabilities
  - capabilities.test_execve

* dragonboard-410c, kselftest-cgroup
  - cgroup.test_kill

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

* dragonboard-410c, kselftest-rtc
  - rtc.rtctest.rtc.uie_read

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

* juno-r2, kselftest-futex
  - futex.run.sh

* juno-r2, kselftest-rtc
  - rtc.rtctest

* qemu_arm, kselftest-rtc
  - rtc.rtctest

* qemu_i386, kselftest-rtc
  - rtc.rtctest

* x15, kselftest-capabilities
  - capabilities.test_execve

* x15, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_kill
  - cgroup.test_kill.test_cgkill_simple

* x15, kselftest-core
  - core.close_range_test

* x86, kselftest-rtc
  - rtc.rtctest


## Metric Regressions (compared to next-20220113)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220113)
* dragonboard-410c, kselftest-capabilities
  - capabilities.test_execve

* dragonboard-410c, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace
  - cgroup.test_kill

* dragonboard-410c, kselftest-pidfd
  - pidfd.pidfd_setns_test

* dragonboard-410c, kselftest-proc
  - proc.fd-001-lookup
  - proc.fd-002-posix-eq
  - proc.proc-fsconfig-hidepid
  - proc.proc-multiple-procfs
  - proc.proc-uptime-001

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

* dragonboard-410c, kselftest-timers
  - timers.nsleep-lat

* hi6220-hikey, kselftest-timers
  - timers.nsleep-lat
  - timers.set-timer-lat

* qemu_arm, kselftest-zram
  - zram.zram.sh

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


## Metric Fixes (compared to next-20220113)
No metric fixes found.

## Test result summary
total: 12757, pass: 8812, fail: 1528, skip: 2417, xfail: 0

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
