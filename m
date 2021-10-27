Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D85C43C2FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 08:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhJ0G3s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 02:29:48 -0400
Received: from a48-37.smtp-out.amazonses.com ([54.240.48.37]:47611 "EHLO
        a48-37.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230342AbhJ0G3r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 02:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1635316042;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=nwZas2kyVRqntbwWYevctH0P/I7R7DBfP9/Sk5R+ius=;
        b=gY2hQJC4Yl7kTxe2Gyy0c5qFlGpxEcEOuGIoA92DXBR6GqPjoxacA3z4lYa/r0+G
        fRLT5FZgAgxbqbRfUf58XNZyR/WAI+L97rXFCJB0OPDcUObqFtzVQzkif+rheWNSWP+
        xS2n796RXsUFqJXQnmt3Vchoi8ApCq3CuUPWnaNs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1635316042;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=nwZas2kyVRqntbwWYevctH0P/I7R7DBfP9/Sk5R+ius=;
        b=i2ANB7hp2k0oGWc2Ses4yo5YhlfY8fy6Y7bViLjvKb82nfdFUH1JykxGlMtyqQp2
        GVf0r5VM9CAZc6MUR0p+X6z2ILodf0g2usMptCJuNRjzlANcleNivg1U93ouML60zBg
        ml4fL/C8d+oQwl+qQ9ZoQcM90W+jP79lMjLFc2KE=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211026
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017cc06e895c-495217de-58e3-4d59-a7b9-6fb9f6b12901-000000@email.amazonses.com>
Date:   Wed, 27 Oct 2021 06:27:22 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.10.27-54.240.48.37
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc7
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 2376e5fe91bcad74b997d2cc0535abff79ec73c5
* git describe: next-20211026
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211026

## Regressions (compared to next-20211022)
* hi6220-hikey, kselftest-timers
  - timers.rtcpie

* i386, kselftest-rtc
  - rtc.rtctest

* x15, kselftest-rtc
  - rtc.rtctest.rtc.alarm_alm_set
  - rtc.rtctest.rtc.alarm_alm_set_minute
  - rtc.rtctest.rtc.alarm_wkalm_set
  - rtc.rtctest.rtc.date_read


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211022)
* qemu_i386, kselftest-rtc
  - rtc.rtctest

* qemu_x86_64, kselftest-rtc
  - rtc.rtctest


## Test result summary
total: 2936, pass: 1722, fail: 259, skip: 955, xfail: 0

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
* kselftest-vm[
* kselftest-x86
* kselftest-zram

--
Linaro LKFT
https://lkft.linaro.org
