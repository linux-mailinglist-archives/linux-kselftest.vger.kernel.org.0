Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52DE404884
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Sep 2021 12:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhIIKel (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Sep 2021 06:34:41 -0400
Received: from a48-37.smtp-out.amazonses.com ([54.240.48.37]:36773 "EHLO
        a48-37.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233370AbhIIKel (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Sep 2021 06:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1631183611;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=NLAHBFkpBfVcepdP4n6unTWH+qW7Gpa3zTYSRlDA05Y=;
        b=kPYBsZXqyTQqlsI1txpDdzZDXoDrLQqKGnFgr0Q07dDgfS090VZjWisjxKf86o50
        dW9KD7pTdPN9UJ0s5z/+InO5cJzDqRCrQuJm39fBnH9ZSTuK8xXdYzwDoct7c6zeBZB
        fTjXmlClk3InhsQuvWPjGhd5pJNfUYqpZ7QiEbsg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1631183611;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=NLAHBFkpBfVcepdP4n6unTWH+qW7Gpa3zTYSRlDA05Y=;
        b=VNVMJX51eU4g9EuciuTJjgNrMjbA/xecWqu2Z5UwFhjFIadNwX7gjHVu5T0wCdpt
        VQQ63kLvtIkHksJojvSOGmqNdNczSnRJdtUBfS/Du2xpPLlNTafEAoCloVIDXFLvjn1
        /bTU1cjhG+xU0HHHqEiEml9doWofn5Lu8YdFM9Sw=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20210908
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017bca1ea508-afc3ea4f-b6ae-4f40-91a2-523d2dca0514-000000@email.amazonses.com>
Date:   Thu, 9 Sep 2021 10:33:31 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.09.09-54.240.48.37
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.14.0
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 999569d59a0aa2509ae4a67ecc266c1134e37e7b
* git describe: next-20210908
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210908

## Regressions (compared to next-20210907)
* x15, kselftest-rtc
  - rtc.rtctest


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20210907)
* hi6220-hikey, kselftest-rtc
  - rtc.rtctest

* qemu_arm64, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace


## Test result summary
total: 6126, pass: 3608, fail: 597, skip: 1921, xfail: 0

## Build Summary

## Test suites summary
* kselftest-
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
