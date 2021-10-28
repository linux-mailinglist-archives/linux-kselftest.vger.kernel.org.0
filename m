Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AE543E61B
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 18:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhJ1Qbj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 12:31:39 -0400
Received: from a8-73.smtp-out.amazonses.com ([54.240.8.73]:42917 "EHLO
        a8-73.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229594AbhJ1Qbi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 12:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1635438550;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=oWwCjAhq0AIf/2g3ThSGDooy9TKd/af4TTznc0thuds=;
        b=jXJUh4tt1aCXshNb1T6/CnyR5mNtkukfdAI2CfUpr6Nwar/ywB32Xvdb0Xg5RUt4
        27qRoJRfky1tlxiAp0VZAHMoOTA3RybVw9g1ys4cei9gqKGRYifsk0YspF8Hnx3DMdW
        /0//UXToNC7jnLAgkY7qFeXxShJg6tD6vfwMf0II=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1635438550;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=oWwCjAhq0AIf/2g3ThSGDooy9TKd/af4TTznc0thuds=;
        b=DAuhQVxyvjsZ8tC/FX4KBUtVyvGgm8EvRnm2U3UkZbef0ypvrIQ9x3LqEzjrz5aB
        q22AKdilPtLFFEh0vHBdAMGXcyY0fzRbaYVNGnqFl50N7XB7Qf6DoTmh5ojZwkS+/7T
        8p9BoMYctT0YIx2oOVCE+9icZosIk2oHLWTCM968=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211028
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017cc7bbdcf2-be80ab04-344d-4afb-9961-94c75a925b35-000000@email.amazonses.com>
Date:   Thu, 28 Oct 2021 16:29:10 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.10.28-54.240.8.73
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc7
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 503f375baa99edff894eb1a534d2ac0b4f799573
* git describe: next-20211028
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211028

## Regressions (compared to next-20211027)
* qemu_arm, kselftest-rtc
  - rtc.rtctest

* qemu_arm, kselftest-zram
  - zram.zram.sh

* qemu_i386, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu_x86_64, kselftest-rtc
  - rtc.rtctest

* x86, kselftest-lkdtm
  - lkdtm.SLAB_FREE_DOUBLE.sh


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211027)
* i386, kselftest-rtc
  - rtc.rtctest

* x15, kselftest-cpufreq
  - cpufreq.main.sh

* x15, kselftest-rtc
  - rtc.rtctest.rtc.alarm_alm_set
  - rtc.rtctest.rtc.alarm_alm_set_minute
  - rtc.rtctest.rtc.alarm_wkalm_set
  - rtc.rtctest.rtc.date_read


## Test result summary
total: 2629, pass: 1618, fail: 236, skip: 775, xfail: 0

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
