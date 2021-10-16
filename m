Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A054302A9
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Oct 2021 14:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbhJPMwu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Oct 2021 08:52:50 -0400
Received: from a8-29.smtp-out.amazonses.com ([54.240.8.29]:46311 "EHLO
        a8-29.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236685AbhJPMwu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Oct 2021 08:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1634388641;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=1RxQHtXA9h7i0uhwY5a9sxr4XQ3c5/3mBGQLC45/Ycs=;
        b=p2P5jrfwM34lmazIlEn9ZfejTKCkBITtqD5kglKeKW056cEG+0buG2bD5lDd7nXh
        4Tc+spfaOCTlC/LFpb2kSCR5W7vluaYV/KXaJt+Sltp6FJXqzBNmgwNIu7u4ZNqOCs+
        I0d/4S6bfEkfP6exAu9iOODzP4AeLn1uVwLQpNOY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1634388641;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=1RxQHtXA9h7i0uhwY5a9sxr4XQ3c5/3mBGQLC45/Ycs=;
        b=YhAtS1kHs1cNw1VwqObVLiWfXenzJJ6csuIaWysHp7VU9wSvA32gEur/iLLg+mY9
        8v5Tj881mWyR2le30JheErcNEwUmhzENut+DDCIUfCg/vPiwwg9hOWfrELOQuZPmY5D
        p5k03YOlG2PA8I3hOgFHiGQg0aHLDvMHAmAo2A6E=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211015
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017c89278568-9d0a1317-f55f-4e57-95ee-45350fe39a39-000000@email.amazonses.com>
Date:   Sat, 16 Oct 2021 12:50:41 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.10.16-54.240.8.29
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc5
* git: ['https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: 7c832d2f9b959e3181370c8b0dacaf9efe13fc05
* git describe: next-20211015
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211015

## Regressions (compared to next-20211007)
* qemu_x86_64, kselftest-seccomp
  - seccomp.seccomp_benchmark


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211007)
* qemu_x86_64, kselftest-pidfd
  - pidfd.pidfd_test


## Test result summary
total: 1723, pass: 882, fail: 180, skip: 661, xfail: 0

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
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-lkdtm
* kselftest-membarrier
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
