Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31DC42992E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 23:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhJKV4f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 17:56:35 -0400
Received: from a8-81.smtp-out.amazonses.com ([54.240.8.81]:41859 "EHLO
        a8-81.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235301AbhJKV4e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 17:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1633989273;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=CCgCWjf4P0xLXc9CSzKItfWygAVfhBi5VJaapUyXlmQ=;
        b=CBlAAwrWrTRez5sLn/hb/pIElzi2C2KRVgUTw4SqnRqVKA4laBLt0XmPPgExL9df
        MNUzUaU2Y5znbOo2yXbSHhHRv1yMLzewRa82XrKD3/uTPThP3BcDSrxmI72+MBAdv5W
        tNOnGayFEbYx/z/BEALZeOFRGUsGCJPfrbglKsSI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1633989273;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=CCgCWjf4P0xLXc9CSzKItfWygAVfhBi5VJaapUyXlmQ=;
        b=kOg3nGbyfc2Uk7DWGadDam3vFV9izB0lio5NKhrB2saXBxOw94ovpfC62eL4PBhL
        dsK+g+xqELU1DbbBGwOj7RaFzzje/Dy4ONbi28bhely+1Q1rV3I9bzA01OxU2f32zci
        MhSelRtna4ZhXGIn3GSVsEgRu6gvr8nOkxa5CE6U=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211007
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017c7159a3b4-e4b4a411-85f7-46a8-a8ff-6694b15027aa-000000@email.amazonses.com>
Date:   Mon, 11 Oct 2021 21:54:32 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.10.11-54.240.8.81
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc4
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: f8dc23b3dc0cc5b32dfd0c446e59377736d073a7
* git describe: next-20211007
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211007

## Regressions (compared to next-20211006)
* qemu_x86_64, kselftest-pidfd
  - pidfd.pidfd_test


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211006)
* dragonboard-410c, kselftest-gpio
  - gpio.gpio-mockup.sh

* dragonboard-410c, kselftest-rtc
  - rtc.rtctest.rtc.uie_read

* hi6220-hikey, kselftest-proc
  - proc.proc-uptime-001

* qemu_x86_64, kselftest-seccomp
  - seccomp.seccomp_benchmark

* x86, kselftest-lkdtm
  - lkdtm.SLAB_FREE_DOUBLE.sh


## Test result summary
total: 1517, pass: 973, fail: 98, skip: 446, xfail: 0

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
