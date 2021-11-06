Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA73446EA4
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Nov 2021 16:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhKFP2V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 Nov 2021 11:28:21 -0400
Received: from a48-34.smtp-out.amazonses.com ([54.240.48.34]:59921 "EHLO
        a48-34.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230023AbhKFP2V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 Nov 2021 11:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1636212339;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=8nCcxBHhzg9WsjUmE0y5+36JS3vG9banP9aqtuh+Hbo=;
        b=ShYuYL5QriZUhhxMupK2urNb7L8+GHT/OWlVHvXaAZ1SeY5QvCKOvQDBgSyUe16i
        f7DRDWRbUSqlTcN/3heQDktUg6uzHlzNPS+GI8oDlKdFpnzirlrOHDeA5vZQdSE7Kzs
        D4yJ9Wo/LCHovZuCErZoQkKb5hzOvGYzLxZ6XF3g=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1636212339;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=8nCcxBHhzg9WsjUmE0y5+36JS3vG9banP9aqtuh+Hbo=;
        b=HKtST18MUmnswRZXM9VvQnx3aXOL58nLh1hzG2zJaBbYCvMDL3AmrhJf1DJ9aSoV
        +m0qOY9CNLumH1p+dJJSpUT++oOCVntrYQyTNKr9UxL7S1MlfgkYnIkf2ZHnRMl15UE
        EZnpUsFPWHoKmLJ5woW5abyk9kOIpNa4vCZCIHpY=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211106
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017cf5daf04b-098268ca-2fd8-44a1-b3c4-588a1b7e36f5-000000@email.amazonses.com>
Date:   Sat, 6 Nov 2021 15:25:38 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.11.06-54.240.48.34
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 6a37ebbe07bf72cd5fd791d67a664f37c8f17a13
* git describe: next-20211106
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211106

## Regressions (compared to next-20211105)
* i386, kselftest-rtc
  - rtc.rtctest

* qemu_arm, kselftest-rtc
  - rtc.rtctest


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211105)
* i386, kselftest-net
  - net.so_txtime.sh


## Test result summary
total: 2855, pass: 1688, fail: 254, skip: 913, xfail: 0

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
