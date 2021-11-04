Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C9C445347
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Nov 2021 13:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhKDMtk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Nov 2021 08:49:40 -0400
Received: from a48-34.smtp-out.amazonses.com ([54.240.48.34]:38477 "EHLO
        a48-34.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229809AbhKDMtk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Nov 2021 08:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1636030021;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=VAa+sdJxFlonQMtUvSa0Idujxrgm3aZfDvU2spfOX+8=;
        b=MUqcAo5PrvAw/eEmnJVketxQOaxKiZHQJoaM3r4afeb312A7FkWg2FTDlwcrqaMj
        VyPLhsEdI/zvfMyjVrZOryYwUYzzRowTywbImP93SImE+BsUrSCHwKSpHC6CbLpXeWp
        YqlD8kMMA5wD4LGOgIAv0Nb8M8PliKH9pr8UEdKg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1636030021;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=VAa+sdJxFlonQMtUvSa0Idujxrgm3aZfDvU2spfOX+8=;
        b=M595huthKheJ2FtWqVWhFQjHSrEYqdIrmxTMRfcqkrQfgh1MQKsLtbdQGQOYQDPj
        irxGzMeAbnjk7EHs3yzc+xgNTgOB4xCfFnXihliFp7/Q3m3PcEaudJIMqGYtwkdWcuN
        MI3htZ5kJn4mz6o6CnzJQtohjl4oB0dEEUOYWZ5A=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211104
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017ceafcfeb6-58833ff5-aed0-468d-b7e1-fe892a804767-000000@email.amazonses.com>
Date:   Thu, 4 Nov 2021 12:47:01 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.11.04-54.240.48.34
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 8a796a1dfca2780321755033a74bca2bbe651680
* git describe: next-20211104
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211104

## Regressions (compared to next-20211103)
* qemu_arm, kselftest-timers
  - timers.rtcpie


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211103)
* i386, kselftest-net
  - net.fib-onlink-tests.sh
  - net.gro.sh

* qemu_arm, kselftest-rtc
  - rtc.rtctest

* qemu_i386, kselftest-rtc
  - rtc.rtctest

* x86, kselftest-net
  - net.gro.sh


## Test result summary
total: 2903, pass: 1719, fail: 259, skip: 925, xfail: 0

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
