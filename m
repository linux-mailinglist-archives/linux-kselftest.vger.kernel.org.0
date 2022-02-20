Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485204BCE5E
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Feb 2022 13:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiBTMJW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Feb 2022 07:09:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBTMJV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Feb 2022 07:09:21 -0500
Received: from a8-29.smtp-out.amazonses.com (a8-29.smtp-out.amazonses.com [54.240.8.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991D7427CE;
        Sun, 20 Feb 2022 04:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1645358938;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=G8hRDruforIKzwsEyd3c3gZSeQje7/UXc9DJOMk75T4=;
        b=UQdUqi5NkRJXU2Ip1KXYboKr2TzAfOy62LzteBJZaB6YiFsheRw6ujL9aBFvQ9eg
        uYOX2NnSk4etvnURKsS8lJJoAlLtEabxJszpRVC3bd5n+tU+9N8LLq0YV89ExaHJMaq
        3b1IM+P8fuUuygOQs1TSUi/ezfIGJItECgK6ovHo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1645358938;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=G8hRDruforIKzwsEyd3c3gZSeQje7/UXc9DJOMk75T4=;
        b=iX/eKVoSG+TA4OU0q0WPiiDwdr4w8MEKMyE+dmG/LXawQXeUBoh3hilrAQl2bYh+
        +snbeHE+hrMe6QocEk3R7Bsu42yV1MmWSphgXXOXUog2rDHsjR68o2E4oly+mDoGty3
        Te6sJOFMEO0sbtF9ugl3f+mdayNaQi/07JalWs3o=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20220203
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017f1708f8b7-35d5c7a4-9e80-47bf-8fe8-4260155cb63d-000000@email.amazonses.com>
Date:   Sun, 20 Feb 2022 12:08:58 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.02.20-54.240.8.29
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
* git commit: 2d3d8c7643a56bfe2e808f97d5a4360d49f3b45b
* git describe: next-20220203
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220203

## Test Regressions (compared to next-20220124)
* hi6220-hikey, kselftest-timers
  - timers.set-timer-lat

* i386, kselftest-seccomp
  - seccomp.seccomp_bpf.TSYNC.siblings_fail_prctl
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence_no_tid_in_err

* juno-r2, kselftest-net
  - net.tls.tls.12_aes_gcm.shutdown_reuse

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
* hi6220-hikey, kselftest-rtc
  - rtc.rtctest

* i386, kselftest-rtc
  - rtc.rtctest

* juno-r2, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* juno-r2, kselftest-cpufreq
  - cpufreq.main.sh

* juno-r2, kselftest-mincore
  - mincore.mincore_selftest

* qemu_arm, kselftest-cpufreq
  - cpufreq.main.sh

* qemu_arm, kselftest-rtc
  - rtc.rtctest

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

* x15, kselftest-sync
  - sync.sync_test

* x86, kselftest-lkdtm
  - lkdtm.ARRAY_BOUNDS.sh

* x86, kselftest-rtc
  - rtc.rtctest


## Metric Fixes (compared to next-20220124)
No metric fixes found.

## Test result summary
total: 5110, pass: 3395, fail: 609, skip: 1106, xfail: 0

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
