Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF4E40250B
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Sep 2021 10:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242215AbhIGIYy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Sep 2021 04:24:54 -0400
Received: from a8-81.smtp-out.amazonses.com ([54.240.8.81]:37341 "EHLO
        a8-81.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241498AbhIGIYx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Sep 2021 04:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1631003026;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=mqDJB5QSzE5uy34oPHFeD7QhM9qsekfPmL2EBVnHIRc=;
        b=o+GnPLrw3nubL2ebUe33wiX0lUyfy7oXjcyN6N2foX+JWGEYsDL58J7KNZOLpB6P
        FCFzseKGERHVsczXZu/go1EShEF1zS80ubez3Gl1ZA5pV8CvaInmTNTtUF0nPDjpIb6
        peVaO0I6/FyLA2beqD8VrZuVD8GmtrTSDJ4amDlE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1631003026;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=mqDJB5QSzE5uy34oPHFeD7QhM9qsekfPmL2EBVnHIRc=;
        b=XiwiWSj0IR9/JfkQ9scA4SfkkK9mh0jIuEd5W85X4dWeOdNAE+kEc1Wk7T3K0DEn
        xNOjYItqnNbWa5XYP0kcDU3/apNhP1Chucbby0BwOKJI9iQtyInyzmr/wMWiQwNDUH6
        OA1Jf6z+ULyk8t7/jUT/RHig3kPwY193a/PSamOk=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20210906
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017bbf5b249f-56121498-870e-41a1-a255-33492e7d63bb-000000@email.amazonses.com>
Date:   Tue, 7 Sep 2021 08:23:46 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.09.07-54.240.8.81
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.14.0
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 7800ca95d0ed11b492962dc3abc2181c9d5f7f82
* git describe: next-20210906
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210906

## Regressions (compared to next-20210903)
* hi6220-hikey, kselftest-rtc
  - rtc.rtctest

* hi6220-hikey, kselftest-timers
  - timers.nsleep-lat
  - timers.set-timer-lat

* qemu-arm64-gic-version2, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu-arm64-mte, kselftest-timers
  - timers.rtcpie

* qemu_arm, kselftest-rtc
  - rtc.rtctest


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20210903)
* qemu-arm64-gic-version2, kselftest-timers
  - timers.rtcpie

* qemu_arm64, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* qemu_arm64, kselftest-timers
  - timers.rtcpie


## Test result summary
total: 3570, pass: 1917, fail: 288, skip: 1365, xfail: 0

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
