Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783BB4246AC
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhJFTaS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 15:30:18 -0400
Received: from a48-37.smtp-out.amazonses.com ([54.240.48.37]:57235 "EHLO
        a48-37.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229992AbhJFTaS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 15:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1633548505;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=e7hLuqiKouck0xO6SAg1QqTnkMpnfaEcSMwizUw71u8=;
        b=YgWPUQdB8S5ftIJrDraUzeRvNyfdDNVF1IWefp4HTIkXwXOW8fQsOMJXX4kyql+l
        c0tFp4MPGoCXDcwVs61+oVb9yYlBYXXAUbhOb7OfjxINV4op2oUXBMXmUWIoeKyr3CP
        3DSygPcYeezkfyDJTNsb6UG/MDo23q45kgpQZHXc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1633548505;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=e7hLuqiKouck0xO6SAg1QqTnkMpnfaEcSMwizUw71u8=;
        b=kpm6nezP/G2fPq2YRNQ2B+cgWw3B5xeJl39b03naOjWa9Pr5i7jvou/GrumIksfC
        X58pjlNGHwBFheoNeVideVbJ0fJb8Gb2kLNpIwteDgNTvH8Oq0IeHUenlCMxX0xTAUH
        mpG80fXXdF1T0bHmtptw51Yaj6MBGynIc3hauec8=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211005
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017c57140e55-d3376e43-4f62-41c6-b71e-a91aeb36e866-000000@email.amazonses.com>
Date:   Wed, 6 Oct 2021 19:28:25 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.10.06-54.240.48.37
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc4
* git: ['https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: 29616f67fcbd6b26242440372a3b0f0a085109c6
* git describe: next-20211005
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211005

## Regressions (compared to next-20211001)
* dragonboard-410c, kselftest-net
  - net.udpgso_bench.sh

* qemu_arm, kselftest-rtc
  - rtc.rtctest

* qemu_i386, kselftest-mqueue
  - mqueue.mq_perf_tests


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211001)
* qemu-arm64-mte, kselftest-timers
  - timers.rtcpie

* x86, kselftest-rtc
  - rtc.rtctest


## Test result summary
total: 4329, pass: 2399, fail: 349, skip: 1581, xfail: 0

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
