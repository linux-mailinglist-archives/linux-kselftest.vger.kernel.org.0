Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008374BCDDC
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Feb 2022 11:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiBTJyy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Feb 2022 04:54:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiBTJyw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Feb 2022 04:54:52 -0500
Received: from a8-29.smtp-out.amazonses.com (a8-29.smtp-out.amazonses.com [54.240.8.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECEB43ED6;
        Sun, 20 Feb 2022 01:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1645350869;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=CI7aPjbCMIJBhrg99NXNcQ0AYlHUSTFnv/QzuHedZCo=;
        b=NJ1QMRCQv8d9BvVKqbUXRZjaFNEhVSqfYdBX9cE5p/Mf1R9i9dfDXUv9f2ZggJNj
        s/jQOaTH8w5MzFvVlh2EOJ6Qc/Y+s5VgGBMLUw/UkgVVdkBwlwkfrj0BXt/89NOpS4X
        0tChhej+t1cD99fjzizxcZ9odd7umKQQEs9/aKGE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1645350869;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=CI7aPjbCMIJBhrg99NXNcQ0AYlHUSTFnv/QzuHedZCo=;
        b=RCGoW1NCh+pG4oHMD4dX6Cd9dD4CdLIgQMw51/cbI2YnZiWBQaaRousW6ZqHSn4c
        2Sj6sTxp+MUWhV3vJKQuoEkOxxpF7dItDA5lHWIpaMab0mfM2ZEwN3yT3i53iAdE6zc
        AkyFBJiZGQBRNTXmCcAacTgKhyW2VmseRXQyVU9M=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20220202
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017f168dd90e-8efa765d-3d26-4762-8ff1-f8feef2453e2-000000@email.amazonses.com>
Date:   Sun, 20 Feb 2022 09:54:29 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.02.20-54.240.8.29
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.17.0-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 6abab1b81b657ca74b7c443e832d95c87901e75b
* git describe: next-20220202
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220202

## Test Regressions (compared to next-20220124)
* i386, kselftest-seccomp
  - seccomp.seccomp_bpf.TSYNC.siblings_fail_prctl
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence_no_tid_in_err

* juno-r2, kselftest-net
  - net.tls.tls.13_sm4_ccm.recv_lowat

* juno-r2, kselftest-seccomp
  - seccomp.seccomp_bpf.TSYNC.siblings_fail_prctl
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence_no_tid_in_err

* qemu_x86_64, kselftest-seccomp
  - seccomp.seccomp_bpf
  - seccomp.seccomp_bpf.TSYNC.siblings_fail_prctl
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence_no_tid_in_err

* x15, kselftest-capabilities
  - capabilities.test_execve

* x15, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_kill
  - cgroup.test_kill.test_cgkill_simple

* x15, kselftest-core
  - core.close_range_test

* x15, kselftest-seccomp
  - seccomp.seccomp_bpf.TSYNC.siblings_fail_prctl
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence_no_tid_in_err

* x86, kselftest-seccomp
  - seccomp.seccomp_bpf.TSYNC.siblings_fail_prctl
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence_no_tid_in_err


## Metric Regressions (compared to next-20220124)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220124)
* i386, kselftest-rtc
  - rtc.rtctest

* juno-r2, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* juno-r2, kselftest-cpufreq
  - cpufreq.main.sh

* juno-r2, kselftest-lkdtm
  - lkdtm.ARRAY_BOUNDS.sh

* juno-r2, kselftest-mincore
  - mincore.mincore_selftest

* qemu_arm, kselftest-cpufreq
  - cpufreq.main.sh

* qemu_arm, kselftest-rtc
  - rtc.rtctest

* qemu_arm, kselftest-zram
  - zram.zram.sh

* qemu_i386, kselftest-cpufreq
  - cpufreq.main.sh

* qemu_i386, kselftest-rtc
  - rtc.rtctest

* qemu_x86_64, kselftest-cpufreq
  - cpufreq.main.sh

* x15, kselftest-capabilities
  - capabilities.test_execve

* x15, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_kill
  - cgroup.test_kill.test_cgkill_simple

* x15, kselftest-core
  - core.close_range_test

* x15, kselftest-rtc
  - rtc.rtctest
  - rtc.rtctest.rtc.alarm_alm_set
  - rtc.rtctest.rtc.alarm_alm_set_minute
  - rtc.rtctest.rtc.alarm_wkalm_set
  - rtc.rtctest.rtc.alarm_wkalm_set_minute
  - rtc.rtctest.rtc.date_read

* x86, kselftest-lkdtm
  - lkdtm.ARRAY_BOUNDS.sh

* x86, kselftest-rtc
  - rtc.rtctest


## Metric Fixes (compared to next-20220124)
No metric fixes found.

## Test result summary
total: 4318, pass: 2787, fail: 524, skip: 1007, xfail: 0

## Build Summary

## Test suites summary
* kselftest-android
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
