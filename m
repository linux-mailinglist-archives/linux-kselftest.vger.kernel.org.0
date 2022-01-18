Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F79B4915B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 03:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344270AbiARC3b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jan 2022 21:29:31 -0500
Received: from a8-81.smtp-out.amazonses.com ([54.240.8.81]:35459 "EHLO
        a8-81.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245303AbiARC13 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jan 2022 21:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1642472848;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=nw8f4TKgi4Wpx6QLC+yCwTh4jbJ3hmnhXHEG+liUSwM=;
        b=PB2M+s5nZjLoT6Z9KrDI728plysqiy19QMQdiAulyhKf0eHUMob7fWjZ+q5Eq+Vq
        ziyDDYiPubeMV/1ks5uuBP8oDArABw5c6jM9eYI/L9U4nEhC7m2jtJ/NPcQx0VMbqGq
        f1jQq4awsB2i7KeQ0SJ1nCTc18KnIxk3NgiI5iVI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1642472848;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=nw8f4TKgi4Wpx6QLC+yCwTh4jbJ3hmnhXHEG+liUSwM=;
        b=i1IqBVAtYypaFVSasoy+9h8y8x++/8psXX0898gs+W9Paswh7ENyVYvIerpR8Zz6
        4/d6i2Y5t57V5OvblNrzV9PfyMSpG1CUkJOe20dWV3IE/gu8XSZOw+20P5o4ZB66VJE
        8UK0gb/S/PG6xaqErUQH/1WNSQQmtU/xkKprhdwM=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20220113
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017e6b02bbe1-9fd85329-4983-4ce9-a2a1-8c00290d439a-000000@email.amazonses.com>
Date:   Tue, 18 Jan 2022 02:27:28 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.01.18-54.240.8.81
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.16.0
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 27c9d5b3c24af29de643533984f1ba3e650c7c78
* git describe: next-20220113
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220113

## Test Regressions (compared to next-20211224)
* dragonboard-410c, kselftest-capabilities
  - capabilities.test_execve

* dragonboard-410c, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace
  - cgroup.test_kill

* dragonboard-410c, kselftest-kvm
  - kvm.get-reg-list

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

* dragonboard-410c, kselftest-sync
  - sync.sync_test

* dragonboard-410c, kselftest-timens
  - timens.procfs
  - timens.timens

* dragonboard-410c, kselftest-timers
  - timers.nsleep-lat

* hi6220-hikey, kselftest-pidfd
  - pidfd.pidfd_setns_test

* hi6220-hikey, kselftest-proc
  - proc.fd-001-lookup
  - proc.fd-002-posix-eq
  - proc.proc-multiple-procfs

* hi6220-hikey, kselftest-sync
  - sync.sync_test

* hi6220-hikey, kselftest-timens
  - timens.procfs
  - timens.timens

* hi6220-hikey, kselftest-timers
  - timers.set-timer-lat

* qemu_i386, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_kill

* qemu_i386, kselftest-pidfd
  - pidfd.pidfd_setns_test

* qemu_i386, kselftest-proc
  - proc.fd-001-lookup
  - proc.fd-002-posix-eq
  - proc.proc-multiple-procfs

* qemu_i386, kselftest-timens
  - timens.procfs
  - timens.timens

* qemu_x86_64, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_kill

* qemu_x86_64, kselftest-kvm
  - kvm.cr4_cpuid_sync_test
  - kvm.debug_regs
  - kvm.demand_paging_test
  - kvm.dirty_log_perf_test
  - kvm.emulator_error_test
  - kvm.get_cpuid_test
  - kvm.get_msr_index_features
  - kvm.hardware_disable_test
  - kvm.hyperv_cpuid
  - kvm.hyperv_features
  - kvm.kvm_binary_stats_test
  - kvm.kvm_create_max_vcpus
  - kvm.kvm_page_table_test
  - kvm.kvm_pv_test
  - kvm.memslot_modification_stress_test
  - kvm.mmu_role_test
  - kvm.platform_info_test
  - kvm.set_boot_cpu_id
  - kvm.set_memory_region_test
  - kvm.set_sregs_test
  - kvm.smm_test
  - kvm.state_test
  - kvm.svm_int_ctl_test
  - kvm.svm_vmcall_test
  - kvm.sync_regs_test
  - kvm.system_counter_offset_test
  - kvm.tsc_msrs_test
  - kvm.userspace_io_test
  - kvm.userspace_msr_exit_test
  - kvm.xapic_ipi_test

* qemu_x86_64, kselftest-pidfd
  - pidfd.pidfd_setns_test

* qemu_x86_64, kselftest-proc
  - proc.fd-001-lookup
  - proc.fd-002-posix-eq
  - proc.proc-multiple-procfs

* qemu_x86_64, kselftest-sync
  - sync.sync_test

* qemu_x86_64, kselftest-timens
  - timens.procfs
  - timens.timens

* x15, kselftest-capabilities
  - capabilities.test_execve

* x15, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_kill
  - cgroup.test_kill.test_cgkill_simple

* x15, kselftest-core
  - core.close_range_test


## Metric Regressions (compared to next-20211224)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20211224)
* dragonboard-410c, kselftest-capabilities
  - capabilities.test_execve

* dragonboard-410c, kselftest-lkdtm
  - lkdtm.SLAB_FREE_DOUBLE.sh

* dragonboard-410c, kselftest-proc
  - proc.proc-fsconfig-hidepid

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

* i386, kselftest-rtc
  - rtc.rtctest

* juno-r2, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* juno-r2, kselftest-clone3
  - clone3.clone3_set_tid

* qemu_arm, kselftest-rtc
  - rtc.rtctest

* x15, kselftest-capabilities
  - capabilities.test_execve

* x15, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_kill
  - cgroup.test_kill.test_cgkill_simple

* x15, kselftest-core
  - core.close_range_test


## Metric Fixes (compared to next-20211224)
No metric fixes found.

## Test result summary
total: 3775, pass: 1936, fail: 489, skip: 1350, xfail: 0

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
