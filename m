Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AEE43DFF0
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 13:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhJ1L0d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 07:26:33 -0400
Received: from a8-97.smtp-out.amazonses.com ([54.240.8.97]:55973 "EHLO
        a8-97.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229578AbhJ1L0d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 07:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1635420245;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=a4jd+z40r50V+36Jg1TVYvrjUQd0AJwmibbFWFAJ69M=;
        b=pOXHFQAozKgrCqfkuC/CvC9Kp/9xRGBzOXd/1Orna+3fyV9w4BKjD2v5Edn9BQiP
        JU17DI6HMJ3cI0qZ5nuzEZeKV79ykWrGJR6LoGzZE1qZ7j61biEohl+hfEY/ASFUsM5
        CGdGehjE4PCeKR3/j5Fd7O7pFgLDKQkUuFIWopOg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1635420245;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=a4jd+z40r50V+36Jg1TVYvrjUQd0AJwmibbFWFAJ69M=;
        b=YhlwGT+txTFm1Y4G0fPN7/utkRJvdWrR+tL/rGIgzCkz04nSHylMvUfaIW3prAZR
        A9Iu69RjTkKObvfO75uaZZfYfIWLy89ibBVXr+neibOcZNPoTA57K/iaFOLN1KzOi8M
        cdtfDaVO9rz7tr26HRepamufgiwb2gK8KAF7ZgZ4=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211027
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017cc6a48d52-9552d97d-a421-4ab1-a533-a480abfd3d11-000000@email.amazonses.com>
Date:   Thu, 28 Oct 2021 11:24:05 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.10.28-54.240.8.97
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc7
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: ae5179317e794160e471db0e122c6ac811a97235
* git describe: next-20211027
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211027

## Regressions (compared to next-20211026)
* qemu_i386, kselftest-rtc
  - rtc.rtctest

* x15, kselftest-cpufreq
  - cpufreq.main.sh


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211026)
* qemu_arm, kselftest-rtc
  - rtc.rtctest

* qemu_arm, kselftest-zram
  - zram.zram.sh


## Test result summary
total: 2581, pass: 1595, fail: 220, skip: 766, xfail: 0

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
