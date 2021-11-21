Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D5A4582C2
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Nov 2021 10:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhKUJbh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Nov 2021 04:31:37 -0500
Received: from a48-37.smtp-out.amazonses.com ([54.240.48.37]:57443 "EHLO
        a48-37.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230459AbhKUJbh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Nov 2021 04:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1637486912;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=kKRWo32vrk+yuNlqww9gySJ3Rs3bcePnDdJspBNA7AQ=;
        b=Xo2QtpGQwG+QpWsLLUZBfHkvhKxuyVAdl0N7/wNto1R2KfIJOkG6vXUwGd+60CCn
        alK+XydtqPMiIxB/WHMt7TCeL2yCHbr/XeO64KLUzp7C9YNh0d3U/xggR6LcxbWhaIg
        mEskzAskBTackHhD1NEaYN5B4EAl+vo1j/C+sCnY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1637486912;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=kKRWo32vrk+yuNlqww9gySJ3Rs3bcePnDdJspBNA7AQ=;
        b=T8MTi8r8YYbFfd6j/xar6U4dOwNvxUVtqxXG4sm4tAG3eY0iai1GoH7ksdfAaAhQ
        Kfe82wPWogWOG8wDfIEJ4wSIJjcJLq0fmMSdIl3ATLaYEjdwxW+G/bYJ+IMcoY4ytL5
        icn6+7rtM3AMTMprjnIV+LgwtcIqB7Rb9b+MPHQE=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211117
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017d41d36138-496e8b33-5be4-4f63-9316-3e7be15c2fe2-000000@email.amazonses.com>
Date:   Sun, 21 Nov 2021 09:28:31 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.11.21-54.240.48.37
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.16.0-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: fd96a4057bd015d194a4b87e7c149fc2fef3c166
* git describe: next-20211117
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211117

## Regressions (compared to next-20211115)
* dragonboard-410c, kselftest-sync
  - sync.sync_test

* i386, kselftest-net
  - net.ip_defrag.sh

* qemu_arm, kselftest-rtc
  - rtc.rtctest

* qemu_arm, kselftest-timers
  - timers.rtcpie

* qemu_x86_64, kselftest-rtc
  - rtc.rtctest

* qemu_x86_64, kselftest-timers
  - timers.rtcpie

* x86, kselftest-rtc
  - rtc.rtctest


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211115)
* i386, kselftest-net
  - net.tls
  - net.tls.tls.12_aes_gcm.send_then_sendfile
  - net.tls.tls.12_chacha.send_then_sendfile
  - net.tls.tls.13_aes_gcm.send_then_sendfile
  - net.tls.tls.13_chacha.send_then_sendfile
  - net.tls.tls.13_sm4_ccm.send_then_sendfile
  - net.tls.tls.13_sm4_gcm.send_then_sendfile

* qemu_arm, kselftest-zram
  - zram.zram.sh

* qemu_x86_64, kselftest-kvm
  - kvm.rseq_test

* x15, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* x15, kselftest-net
  - net.so_txtime.sh


## Test result summary
total: 3399, pass: 2048, fail: 292, skip: 1059, xfail: 0

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
