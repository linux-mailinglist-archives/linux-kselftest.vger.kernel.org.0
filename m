Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9EB4300EE
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Oct 2021 09:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbhJPHpD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Oct 2021 03:45:03 -0400
Received: from a8-35.smtp-out.amazonses.com ([54.240.8.35]:33879 "EHLO
        a8-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239843AbhJPHpD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Oct 2021 03:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1634370175;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=9vJZeoEpkV9mMJBDKzN4wORIOffHfCPZHQ5ejPyGBos=;
        b=oyp5GyAlEXmseHpAUQ1prjZMlIi0y8rrtoOywz1jO5FWjOrlZ/V9bxOM3vyjNcxU
        t5llvtnAsJobcF6zH2V1JjBlLxy+Ka8XVPfQdkZH6qw0yJ6FclOKGLKo3+EOIkEicDs
        znJr5qERVXUW833AdzHVF37moVNhO5/0sUM/2I8s=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1634370175;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=9vJZeoEpkV9mMJBDKzN4wORIOffHfCPZHQ5ejPyGBos=;
        b=cxB2Gs1UUHGwvMBl/f85gWDop+UaMiapSStIgZstl5763Moz09r7W+2JbdB3hl1y
        LTk00xSq8d0MnOzfx2vRL+EcaOO/oSMcFwJ3ib2OY3zPRC+ql/s/Q+B5vZIn9HUC9wN
        wZoxn6uLZlo1JJn8M/8XEmOVPOBTgKzvTMyj6+Sc=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: lkft kselftest for next-20211012
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017c880dc028-6c3e7879-8a66-41b9-9ddf-3cc3a761de34-000000@email.amazonses.com>
Date:   Sat, 16 Oct 2021 07:42:55 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.10.16-54.240.8.35
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc5
* git: ['https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: 6d3d22efa090e7a5d3691613297aab12c6d2708a
* git describe: next-20211012
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211012

## Regressions (compared to next-20211007)
No regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211007)
No fixes found.

## Test result summary
total: 2849, pass: 1736, fail: 238, skip: 875, xfail: 0

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
