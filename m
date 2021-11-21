Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB3E4583A6
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Nov 2021 13:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbhKUM7A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Nov 2021 07:59:00 -0500
Received: from a48-34.smtp-out.amazonses.com ([54.240.48.34]:38533 "EHLO
        a48-34.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234583AbhKUM67 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Nov 2021 07:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1637499353;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=TfsofMTL3hssDvTgVGJDRlR6gefrnvpC0LiVEsNdsgw=;
        b=jiEv0CYjC+gjz/jtbtAfgTPP9fBU9xcPEkD0E1QlRDfZHtk5Wy5jntO/1HEEfBm2
        sxOoqgxmXFq/ee0ChAu/uyQXAapwx5FYvmUShA5SXlB9GxKPixZZxPRM9aqkMPCBESX
        Pw0X9HxHihkPyUqJWaR/4LWZGfSm69f1wh5oCCL4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1637499353;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=TfsofMTL3hssDvTgVGJDRlR6gefrnvpC0LiVEsNdsgw=;
        b=BvV1rtrs6wvegUrRJAcMrh7rviMxpDZAzWU5j35JG5L2QQshCSmvE9/X0A/eLUhH
        0uRD2jEP6+frw4OLd+A0FkGUlaNaB2K/juumtYLXN5JLMKs9muZLb3GyEhDA1ikuAWD
        WWcmfRku5reT8djRQ6gXhuqmAXeYk/JKtOckG8NI=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211116
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017d429138b9-962c5181-88e3-4d1c-91e2-09726f744578-000000@email.amazonses.com>
Date:   Sun, 21 Nov 2021 12:55:53 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.11.21-54.240.48.34
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.16.0-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: a2f3bb245883ba791e46be1f8415186dae346458
* git describe: next-20211116
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211116

## Regressions (compared to next-20211115)
* i386, kselftest-net
  - net.gro.sh

* qemu_arm, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_migrate


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211115)
* dragonboard-410c, kselftest-rtc
  - rtc.rtctest.rtc.uie_read

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

* x15, kselftest-rtc
  - rtc.rtctest

* x86, kselftest-net
  - net.gro.sh


## Test result summary
total: 3204, pass: 1923, fail: 287, skip: 994, xfail: 0

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
