Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DB952F6E0
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 02:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiEUAhX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 May 2022 20:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354343AbiEUAgs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 May 2022 20:36:48 -0400
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com [54.240.48.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DC28E199;
        Fri, 20 May 2022 17:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1653093405;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=Rt7Ew1/Voq9/2G/8l9UBD0vyEf758zrdXvBTikkVKiE=;
        b=O7iPq1M3rGexAzG22HLXdKAnZ9gDZW+YsEtBH83aAenIDzL4GC/dKhDr2VLMvhFP
        jKccLqQNTwLvsurgOHjqMbuFXa6SyK+J6wwtPqO+/GfdxBUvp0yVfXiiNZasDycMBVN
        fIssQHi8jLf738d8/PIoha3JNRWSZJzsUVzjccXs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1653093405;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=Rt7Ew1/Voq9/2G/8l9UBD0vyEf758zrdXvBTikkVKiE=;
        b=EKhNpuHcPmB5QXxJLP0+hY241BYR9Pp/tC4vvBpg/6AVauiDt3OsJ9vIFfIj7n/i
        9kPz2R8SpuZAkGzioCaak/XzusrSHx2K3vZAy+UdebbmiMJrgC5I4l2BLwM/vG0QREZ
        WY7gLGtFpd9Lb8Xn/Ba4wikadMlAfZSsQW3DFO2s=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20220520
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <01000180e40b91ec-47f72be1-90d6-43e4-b7db-4342903c5ebb-000000@email.amazonses.com>
Date:   Sat, 21 May 2022 00:36:45 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.21-54.240.48.37
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
* git commit: 18ecd30af1a8402c162cca1bd58771c0e5be7815
* git describe: next-20220520
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220520

## Test Regressions (compared to next-20220511)
* dragonboard-845c, kselftest-timers
  - timers.rtcpie

* qemu-arm64-gic-version2, kselftest-cgroup
  - cgroup.test_freezer

* qemu-arm64-gic-version2, kselftest-timers
  - timers.rtcpie

* qemu-arm64-gic-version3, kselftest-timers
  - timers.rtcpie

* qemu_arm, kselftest-seccomp
  - seccomp.seccomp_benchmark

* qemu_arm, kselftest-timers
  - timers.rtcpie

* qemu_arm64, kselftest-timers
  - timers.rtcpie

* x86, kselftest-kvm
  - kvm.evmcs_test
  - kvm.hyperv_clock
  - kvm.smm_test
  - kvm.state_test
  - kvm.vmx_preemption_timer_test


## Metric Regressions (compared to next-20220511)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220511)
* dragonboard-845c, kselftest-proc
  - proc.proc-uptime-001


## Metric Fixes (compared to next-20220511)
No metric fixes found.

## Test result summary
total: 4567, pass: 2439, fail: 379, skip: 1749, xfail: 0

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
* kselftest-net
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
