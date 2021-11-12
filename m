Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C5444E7F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Nov 2021 14:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhKLN4c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Nov 2021 08:56:32 -0500
Received: from a48-37.smtp-out.amazonses.com ([54.240.48.37]:36581 "EHLO
        a48-37.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231553AbhKLN4c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Nov 2021 08:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1636725220;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=Wd5m69BjWjWUbdq6M1Bz21M00Z0lWj8+tyuLpPWQV88=;
        b=PG7jKrhqUN5E0Z/oLY+HdJWWuSN1UF8UgKL9uuPEHORX+8o2wjSnanHyuytVHoVB
        4777mp4Y8Hbt8enH5K8EnuC969DA2aV7XgYTKpiMSLWS/efpt/htSje2m3Ni4n55BsZ
        cE/FhgclS8WQAIrUKPioOF6tmyTir09EKRS524+Q=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1636725220;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=Wd5m69BjWjWUbdq6M1Bz21M00Z0lWj8+tyuLpPWQV88=;
        b=fEDxzFdGhcidHTXwCHJ6TBa0Mkz5+Pk0TzMSVTFOXwetigiKenvAplh25ivHIlvv
        lEXMU5/4hHBZu78XAXkokLjrcH9xzWh5/qIw3knDDdyGiAo54479iiGl/ADsmYI8Wak
        UCH7g3sbTPvtf5bt/DOZDByQ4lrLSa2uEohmryE0=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211112
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017d146ce429-65049a49-a5aa-4c3e-b496-4250cd5dd2fa-000000@email.amazonses.com>
Date:   Fri, 12 Nov 2021 13:53:40 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.11.12-54.240.48.37
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: f2e19fd15bd7cba347ce50be71955f5cd28a6019
* git describe: next-20211112
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211112

## Regressions (compared to next-20211110)
* i386, kselftest-net
  - net.so_txtime.sh

* i386, kselftest-rtc
  - rtc.rtctest

* qemu_x86_64, kselftest-kvm
  - kvm.set_memory_region_test

* x86, kselftest-net
  - net.ip_defrag.sh

* x86, kselftest-rtc
  - rtc.rtctest


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211110)
* hi6220-hikey, kselftest-timers
  - timers.nsleep-lat
  - timers.set-timer-lat

* qemu_arm, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_migrate

* qemu_arm, kselftest-zram
  - zram.zram.sh

* x15, kselftest-rtc
  - rtc.rtctest
  - rtc.rtctest.rtc.alarm_alm_set
  - rtc.rtctest.rtc.alarm_alm_set_minute
  - rtc.rtctest.rtc.alarm_wkalm_set
  - rtc.rtctest.rtc.alarm_wkalm_set_minute
  - rtc.rtctest.rtc.date_read

* x86, kselftest-net
  - net.gro.sh


## Test result summary
total: 3144, pass: 1904, fail: 262, skip: 978, xfail: 0

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
