Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1660430053
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Oct 2021 06:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhJPEvq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Oct 2021 00:51:46 -0400
Received: from a8-97.smtp-out.amazonses.com ([54.240.8.97]:47733 "EHLO
        a8-97.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236300AbhJPEvp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Oct 2021 00:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1634359776;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=ZNOhtZa9LyPmWL+SWfry4dnkSnODoOTwjBxIEG7XBnQ=;
        b=bizjB9/ZyfRad0Qwv4erNGDSOqlcq79n/nCsH8+pooMJw0+HAlGBx9HTHZBS7eGz
        WVA0hs0BIbFhSTJbV1v4R4vfZy3mFl9GajcSZN32ZrokDHLndm7zVm3MNQ/jAYNHLuB
        ucNFcmYd6UoxL6zWVuEdiXIUlaQkjaQYYH93Q5sw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1634359776;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=ZNOhtZa9LyPmWL+SWfry4dnkSnODoOTwjBxIEG7XBnQ=;
        b=aWf7tiqXQH9ImZjRJ6idlpcl0MPmX/TdyjHERy0qgdr5fRkcgV/QocylXEc53kWo
        CpMl8Suw/O47Hq3Ay13k+UaTFvbP8nwZH+YoeHpltkJ794V7Vhd6TJC0X3wBKcoe6E4
        PmiYV+SjFp3aKPKXEPTylsoRSn9CMh5H1OtY+diE=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211011
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017c876f132d-fbd163be-a633-4274-ba2a-f0ac4a197c9e-000000@email.amazonses.com>
Date:   Sat, 16 Oct 2021 04:49:36 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.10.16-54.240.8.97
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc4
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: d3134eb5de8546a214c028fb7195e764b89da7d4
* git describe: next-20211011
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211011

## Regressions (compared to next-20211006)
* hi6220-hikey, kselftest-timers
  - timers.nsleep-lat
  - timers.set-timer-lat

* qemu_i386, kselftest-pidfd
  - pidfd.pidfd_test

* qemu_x86_64, kselftest-pidfd
  - pidfd.pidfd_test


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211006)
* dragonboard-410c, kselftest-gpio
  - gpio.gpio-mockup.sh

* qemu_i386, kselftest-gpio
  - gpio.gpio-mockup.sh

* qemu_i386, kselftest-seccomp
  - seccomp.seccomp_benchmark

* qemu_x86_64, kselftest-seccomp
  - seccomp.seccomp_benchmark

* x86, kselftest-lkdtm
  - lkdtm.SLAB_FREE_DOUBLE.sh


## Test result summary
total: 2802, pass: 1736, fail: 237, skip: 829, xfail: 0

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
