Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303CB4C133E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 13:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiBWMws (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 07:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiBWMws (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 07:52:48 -0500
Received: from a8-29.smtp-out.amazonses.com (a8-29.smtp-out.amazonses.com [54.240.8.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960D191AD0;
        Wed, 23 Feb 2022 04:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1645620738;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=izKnJRCLNiPMGRNo3KCn2XC7xEro2/ksCoYE2Pf7YCw=;
        b=a/3zz/apyHvqCeRDPEg9FeXckmsRGEwE+jU3HWnwrxRNtq5DlTgd27LaBHkNzDz5
        WLmjRS+UjErH9HPAtDcGAhoYSyr92CyS41d0RR0tY8MZ/tKipFZsY6E/0i0aETa4tGP
        moYfsTUhDGXTULozq3AjqzfOC/5/GpMsyx3HZkZw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1645620738;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=izKnJRCLNiPMGRNo3KCn2XC7xEro2/ksCoYE2Pf7YCw=;
        b=Y2SO2j5/8KBvui6VzH8WYt1GskC+s10XGu+c4jA6q7hBWukAhi3Dm3eZ7igQqO6N
        13qKlIFYApZg9dD1ucc9EWmFfDqJEoabg+6ZtZoni6S7EqDPl5S0wgPlltgX7cdtbwf
        fuV3rrvzqMAxoFg3OzIkpBXQM0UZoMtykrGbmI7U=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20220216
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017f26a3b874-bbb06e37-5650-46bd-a26b-6d511d0f3701-000000@email.amazonses.com>
Date:   Wed, 23 Feb 2022 12:52:18 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.02.23-54.240.8.29
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
* kernel: 5.17.0-rc4
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 763a906a02e961eedabab7dbedd16904a3bd0184
* git describe: next-20220216
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220216

## Test Regressions (compared to next-20220124)
* i386, kselftest-seccomp
  - seccomp.seccomp_bpf.TSYNC.siblings_fail_prctl
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence_no_tid_in_err

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

* x86, kselftest-net
  - net.gro.sh

* x86, kselftest-seccomp
  - seccomp.seccomp_bpf.TSYNC.siblings_fail_prctl
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence_no_tid_in_err


## Metric Regressions (compared to next-20220124)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220124)
* hi6220-hikey, kselftest-rseq
  - rseq.basic_percpu_ops_test
  - rseq.basic_test
  - rseq.param_test
  - rseq.param_test_benchmark
  - rseq.param_test_compare_twice

* hi6220-hikey, kselftest-rtc
  - rtc.rtctest

* i386, kselftest-rtc
  - rtc.rtctest

* i386, kselftest-seccomp
  - seccomp.seccomp_bpf.global.user_notification_filter_empty
  - seccomp.seccomp_bpf.global.user_notification_filter_empty_threaded

* juno-r2, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* juno-r2, kselftest-cpufreq
  - cpufreq.main.sh

* juno-r2, kselftest-seccomp
  - seccomp.seccomp_bpf.global.user_notification_filter_empty
  - seccomp.seccomp_bpf.global.user_notification_filter_empty_threaded

* qemu_arm, kselftest-cpufreq
  - cpufreq.main.sh

* qemu_arm, kselftest-rtc
  - rtc.rtctest

* qemu_arm, kselftest-zram
  - zram.zram.sh

* qemu_i386, kselftest-cpufreq
  - cpufreq.main.sh

* qemu_i386, kselftest-rseq
  - rseq.basic_percpu_ops_test
  - rseq.basic_test
  - rseq.param_test
  - rseq.param_test_benchmark
  - rseq.param_test_compare_twice
  - rseq.run_param_test.sh

* qemu_i386, kselftest-rtc
  - rtc.rtctest

* qemu_x86_64, kselftest-cpufreq
  - cpufreq.main.sh

* qemu_x86_64, kselftest-rseq
  - rseq.basic_percpu_ops_test
  - rseq.basic_test
  - rseq.param_test
  - rseq.param_test_benchmark
  - rseq.param_test_compare_twice
  - rseq.run_param_test.sh

* x15, kselftest-capabilities
  - capabilities.test_execve

* x15, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_kill
  - cgroup.test_kill.test_cgkill_simple

* x15, kselftest-core
  - core.close_range_test

* x86, kselftest-lkdtm
  - lkdtm.ARRAY_BOUNDS.sh

* x86, kselftest-rtc
  - rtc.rtctest

* x86, kselftest-seccomp
  - seccomp.seccomp_bpf.global.user_notification_filter_empty
  - seccomp.seccomp_bpf.global.user_notification_filter_empty_threaded


## Metric Fixes (compared to next-20220124)
No metric fixes found.

## Test result summary
total: 4565, pass: 2481, fail: 568, skip: 1516, xfail: 0

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
