Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8ED44C66C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 18:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhKJRv6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 12:51:58 -0500
Received: from a8-35.smtp-out.amazonses.com ([54.240.8.35]:37895 "EHLO
        a8-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232621AbhKJRvn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 12:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1636566534;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=RZV+9ipNbCOKdoSrryloxAvl0oPRCjNlkpARxfUHKjU=;
        b=EeTrq4fO2/W/JTyfNyUXmpPl0h9ZgtyXz2yhS1KTp3i/K6eBc+AAGnZRZd4pV4F7
        SY2AF52DHnFKcQ0fEaw28vBElXauWU2fWADDD/k70JPeAI58VbGEf9IRJzexi1LLmu2
        OQd+KgcdpQBSEx3+FJtt8oJZrk/LRVmD1yVec8OA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1636566534;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=RZV+9ipNbCOKdoSrryloxAvl0oPRCjNlkpARxfUHKjU=;
        b=Lnydkd3I/gKAnpMed9iN3/8ok959ZqS65rp1/4iteOiXS1ze/5Z1WT/OLWypS3Sz
        zpw8JrXs+VDrgPlJ+AH12vfLw4v6zJgCQBkuLJlYIZ/qKsNPpaKywHqae0PrDK9q8ro
        AP0jfIiRnm01xtDzeS/8SQk6SsfVV/loZc4p+3sY=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211110
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017d0af7884c-bc757cde-b905-462c-a9f1-c0f61647f3c2-000000@email.amazonses.com>
Date:   Wed, 10 Nov 2021 17:48:54 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.11.10-54.240.8.35
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 73e5c18006f5e1f7d35d1e996609eaff6536ae5e
* git describe: next-20211110
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211110

## Regressions (compared to next-20211109)
* qemu_arm, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_migrate

* qemu_arm, kselftest-zram
  - zram.zram.sh


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211109)
* i386, kselftest-net
  - net.gro.sh

* x86, kselftest-rtc
  - rtc.rtctest


## Test result summary
total: 3153, pass: 1975, fail: 270, skip: 908, xfail: 0

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
