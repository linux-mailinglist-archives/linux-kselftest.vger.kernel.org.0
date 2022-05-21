Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D390D52F6D1
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 02:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiEUAah (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 May 2022 20:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354249AbiEUAaa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 May 2022 20:30:30 -0400
Received: from a8-35.smtp-out.amazonses.com (a8-35.smtp-out.amazonses.com [54.240.8.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409841AD583;
        Fri, 20 May 2022 17:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1653093023;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=maWc0kRJAX2HXPzHI78tqJbDV/r5vgS9S7bSd3VrmNE=;
        b=PXkZWmxaJ+RmQK+yhyPyvYN4qNXnajiy177fjSFyTZUJqRpiWYBuZylLnmS0ssBI
        OySTmgjPYQSnvTNue1nmo4A+ZhuVqrH0icJWDq/OHZV1v5M2uY63J1YwPYjkcCV1kVL
        9hmmjjcSAyirkfwdYCgVRo+OGyUYwjPs58iVnWNU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1653093023;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=maWc0kRJAX2HXPzHI78tqJbDV/r5vgS9S7bSd3VrmNE=;
        b=SJdr32739XGPL9zyQE7NuVl2nAkABQVdOqYvnibhFtS2zr2AKRXYTaRBwRsjtlDy
        zTs+skZlTRCLj5wY2jvtZ3ovqH8Z6o525CzBdmy7DNvQHNBdMLCxEn4glIOXaEMnrpe
        5HWjHGnC/ck2grkSeQ9Uc13F6K5AnCu3+3jBez5Q=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20220519
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <01000180e405b9c7-492eea0a-913a-4d30-a8e1-380018c2bcc9-000000@email.amazonses.com>
Date:   Sat, 21 May 2022 00:30:22 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.21-54.240.8.35
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.18.0-rc7
* git: ['', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: 21498d01d045c5b95b93e0a0625ae965b4330ebe
* git describe: next-20220519
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220519

## Test Regressions (compared to next-20220506)
* hi6220-hikey, kselftest-timers
  - timers.rtcpie

* qemu-arm64-gic-version3, kselftest-timers
  - timers.rtcpie

* qemu_arm64, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_kill
  - cgroup.test_kill.test_cgkill_forkbomb

* x86, kselftest-kvm
  - kvm.evmcs_test
  - kvm.hyperv_clock
  - kvm.smm_test
  - kvm.state_test
  - kvm.vmx_preemption_timer_test


## Metric Regressions (compared to next-20220506)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220506)
* juno-r2, kselftest-pidfd
  - pidfd.pidfd_poll_test


## Metric Fixes (compared to next-20220506)
No metric fixes found.

## Test result summary
total: 4356, pass: 2345, fail: 339, skip: 1672, xfail: 0

## Build Summary

## Test suites summary
* kselftest-android
* kselftest-arm64
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
