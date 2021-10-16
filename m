Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9830743022C
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Oct 2021 12:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbhJPKoC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Oct 2021 06:44:02 -0400
Received: from a8-73.smtp-out.amazonses.com ([54.240.8.73]:48469 "EHLO
        a8-73.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231240AbhJPKoB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Oct 2021 06:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1634380912;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=w3BaOdoYzSaicIKBJjv0sJuFWiGPe2wyAuXyFTmahMo=;
        b=UP20gGbVCiKE382koPiacvle9W4tdR8U26NDEa4QJLmrlcN3K5xpt3NzQgb1Zm/6
        MC8eih6EaBDSMDsQpq7fQa6WTf65w6nxynNKQFFK1X/4Joxci2h7BAvWt12Qs/Q2v7Z
        vNrsMhbuwyvJYIpTp3WtVbW0K8eVrjYWwpZMw4sg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1634380912;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=w3BaOdoYzSaicIKBJjv0sJuFWiGPe2wyAuXyFTmahMo=;
        b=eHOJ2imz1Ea1C/x7qRVfw5nl9UAdyW6QgH48r8CrKAS1nn07TK0JQOHYZsQ+ElGI
        rOiSv7Lkqv58fzS+4+A6Oikq/irYIit/9M0Qt1Qv5uv2EUnJ6AK341wd8nqJ42ZtSg6
        1VADKOIT4YZKainWVcOvACXDLfJ4G5DaGzoI2mfY=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211013
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017c88b19807-e709b4a1-f981-4ecd-a2fc-daab88c46b33-000000@email.amazonses.com>
Date:   Sat, 16 Oct 2021 10:41:52 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.10.16-54.240.8.73
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc5
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 8006b911c90a4ec09958447d24c8a4c3538f5723
* git describe: next-20211013
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211013

## Regressions (compared to next-20211007)
* x86, kselftest-kvm
  - kvm.vmx_preemption_timer_test


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211007)
No fixes found.

## Test result summary
total: 3126, pass: 1889, fail: 242, skip: 995, xfail: 0

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
