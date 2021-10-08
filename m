Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D98F4267B2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Oct 2021 12:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbhJHKYk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Oct 2021 06:24:40 -0400
Received: from a8-97.smtp-out.amazonses.com ([54.240.8.97]:54849 "EHLO
        a8-97.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239720AbhJHKYk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Oct 2021 06:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1633688564;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=Nz6S0PXFL+AAcvxf+5aZ8ru2WtBuAqSQq3bgpnPP+8w=;
        b=n/wQX5U/ObkYUqwqwzKIBCj9slo0DfzCJ+4vpA8Xgj1878MUntrT+02270Lo4gRr
        zZTpi+H7S2mpLBTYBTAq6FufqSAuDbPtXK7hhcd1H91LeiCwbp9FFKOKptAMWLeo/qi
        xbKy0g4xpU7+vXhzV8my8nsC5o3YupP2Zbc5kRq0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1633688564;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=Nz6S0PXFL+AAcvxf+5aZ8ru2WtBuAqSQq3bgpnPP+8w=;
        b=DnBPJ3VoA3X/mA6jNybhlN7on+utRnM/oLeY84Kcrgb4CCUEoK31ApLbOLqQ52e/
        AhLSseB8poOkX83fin2F6N1vpZFY0G6W78AhbOxWQQZXo/goKRQyed6jMsGdjgtj0J6
        walgt/JlKmiY4NuLdYscHojpVjxy/zOlYuWY/uPs=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211008
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017c5f6d30a7-4052566a-e07c-4ff8-afb6-eb5de999d355-000000@email.amazonses.com>
Date:   Fri, 8 Oct 2021 10:22:44 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.10.08-54.240.8.97
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc4
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 683f29b781aeaab6bf302eeb2ef08a5e5f9d8a27
* git describe: next-20211008
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211008

## Regressions (compared to next-20211006)
* x86, kselftest-kvm
  - kvm.hyperv_clock


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211006)
* x86, kselftest-lkdtm
  - lkdtm.SLAB_FREE_DOUBLE.sh


## Test result summary
total: 734, pass: 504, fail: 45, skip: 185, xfail: 0

## Build Summary

## Test suites summary
* kselftest-android
* kselftest-bpf
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
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

--
Linaro LKFT
https://lkft.linaro.org
