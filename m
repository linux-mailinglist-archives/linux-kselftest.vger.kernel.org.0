Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC19444CBC
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Nov 2021 01:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhKDA4E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Nov 2021 20:56:04 -0400
Received: from a8-81.smtp-out.amazonses.com ([54.240.8.81]:58765 "EHLO
        a8-81.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230030AbhKDA4E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Nov 2021 20:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1635987206;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=OeyNVKB2oPsrCOJr/qoLmmM933IBejt2LhFK8SiPmuE=;
        b=Sk4FCRgXTlUzDcsXBTg/9ocoS8N9F61TV/1EUZPnYiX8kJYss5m6t/WmJ5sClSnj
        WpdBblNUSyj80W2mfIjn2sejucmjeZgVmZsxsvKttvQrxhdgTyGa0hkhK0RdX5sWDdF
        URzyLYA3tk8+C8kOGgEBJqUAzxu4nAw0189KQ2RA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1635987206;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=OeyNVKB2oPsrCOJr/qoLmmM933IBejt2LhFK8SiPmuE=;
        b=MWdyRxqd5+HmAPAw3M7qjMjYUr55cthPS5lhoNZbD8lVzGsxBG/fhg90FYnqI5Dm
        06/9FHcCAGi/nyMqJ2lsr21KIWgCF87agEmt3YH0Y43bVagUv4pORnX35VZOqWkpdKt
        8xC5nBk+YJQxMukQXTb3tq1tsFnnpXiA3SP0/4nA=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211103
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017ce86faf18-05a6239b-4165-4743-bb85-4334d339aee6-000000@email.amazonses.com>
Date:   Thu, 4 Nov 2021 00:53:26 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.11.04-54.240.8.81
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0
* git: ['https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: 8ccbda2840b77bb6f029151df5ab92dd04e4f3f8
* git describe: next-20211103
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211103

## Regressions (compared to next-20211102)
* qemu_arm, kselftest-rtc
  - rtc.rtctest

* qemu_i386, kselftest-rtc
  - rtc.rtctest

* x15, kselftest-rtc
  - rtc.rtctest
  - rtc.rtctest.rtc.alarm_alm_set
  - rtc.rtctest.rtc.alarm_alm_set_minute
  - rtc.rtctest.rtc.alarm_wkalm_set
  - rtc.rtctest.rtc.alarm_wkalm_set_minute
  - rtc.rtctest.rtc.date_read

* x86, kselftest-rtc
  - rtc.rtctest


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211102)
* hi6220-hikey, kselftest-kvm
  - kvm.rseq_test

* i386, kselftest-net
  - net.tls
  - net.tls.tls.12_aes_gcm.send_then_sendfile
  - net.tls.tls.12_chacha.send_then_sendfile
  - net.tls.tls.13_aes_gcm.send_then_sendfile
  - net.tls.tls.13_chacha.send_then_sendfile
  - net.tls.tls.13_sm4_ccm.send_then_sendfile
  - net.tls.tls.13_sm4_gcm.send_then_sendfile

* qemu_arm, kselftest-timers
  - timers.rtcpie


## Test result summary
total: 3058, pass: 1898, fail: 241, skip: 919, xfail: 0

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
