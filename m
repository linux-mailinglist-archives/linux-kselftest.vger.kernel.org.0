Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFD2436AEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 20:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhJUSwz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 14:52:55 -0400
Received: from a8-35.smtp-out.amazonses.com ([54.240.8.35]:37773 "EHLO
        a8-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230267AbhJUSwz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 14:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1634842238;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=7/tOQ6BFMNpxLJjfhz32pUp9xILxNhV5HDz483NjpcI=;
        b=UvG5/zQ0hTd/jNe6via6OAKTwH18ycjL3DkdpOmwuWZ5Vh8pA1o7QlUXpS1jHc0p
        o5xCNkQ837Lb10ceQLkNYg23iH5KYZzA8lQ/CtsygvsqNpRHaqyDmEzZZcemMn/uMuL
        rv7TnZX1RQIAJxrpwKcb7a3FlMKORwJrzve3oEkA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1634842238;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=7/tOQ6BFMNpxLJjfhz32pUp9xILxNhV5HDz483NjpcI=;
        b=Lx3hHsdouy/1BSlFOnwfWbEevpHL3k/4INmuph9xNwOKFgZXH61bl5rFZ6ndn0Ir
        9MKWa5HX2kG1by1w0bWfsHKoaq0iCjGX/dM4hjWEVIj5w/agUSNJhxS5cYAHTZ+zSNn
        rEHxT8KnSXqVnqwoU2F+T4KpK61Cvn2W4NtNclWw=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: lkft kselftest for next-20211021
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017ca430daed-ea2f1218-d66f-46de-bb25-0045748b1b5c-000000@email.amazonses.com>
Date:   Thu, 21 Oct 2021 18:50:37 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.10.21-54.240.8.35
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc6
* git: ['https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: 3196a52aff93186897f15f1a6c03220ce6523d82
* git describe: next-20211021
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211021

## Regressions (compared to next-20211019)
No regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211019)
No fixes found.

## Test result summary
total: 2885, pass: 1788, fail: 246, skip: 851, xfail: 0

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
