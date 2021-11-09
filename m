Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0DC44B09F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Nov 2021 16:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbhKIPta (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Nov 2021 10:49:30 -0500
Received: from a8-35.smtp-out.amazonses.com ([54.240.8.35]:56201 "EHLO
        a8-35.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236469AbhKIPta (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Nov 2021 10:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1636472803;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=TcrJl4Zk7c8c3GmhON+9wbI3TbFUO0qSB4q+4TXC3aY=;
        b=aNl2yDXDYuDVzy05X6V3z7g1dugWBLHcOVyZtHVe3LgUFGgzyJHEaHHnG7x70jen
        8qHh0If6t/TfEkHGlDYcWZ4pk33YqALbpkqE9Tz6nRmXPBd3Hd0TMvE/G6mZSmZNDcr
        mzbevfy0FpSLYhIxS3C7Bhg0A0e7jr6Zfigep1LQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1636472803;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=TcrJl4Zk7c8c3GmhON+9wbI3TbFUO0qSB4q+4TXC3aY=;
        b=RoGA9mW07i9lPPLJxJjeTPfqZMCj9YM9bXzDeHDSDOZAuU1vC8omzsys3LMo0j6r
        AK/IbTzURLKkvduQpHqxJFhu1GeGjBSvqKDjFhXLxhdox/M1jsHpW1eJrvN3I6SPKRT
        hG0XTBsazS9xnXc18KKTHl6uqBhr6nvzlnY+LFcQ=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211109
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017d05614f56-6cd94894-2f72-4412-85d0-f007d5f8d7ff-000000@email.amazonses.com>
Date:   Tue, 9 Nov 2021 15:46:43 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.11.09-54.240.8.35
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: c8109c2ba35e9bfd8a55087ffb1f42cc0dcf71e6
* git describe: next-20211109
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211109

## Regressions (compared to next-20211108)
* i386, kselftest-net
  - net.gro.sh

* x15, kselftest-rtc
  - rtc.rtctest.rtc.alarm_alm_set
  - rtc.rtctest.rtc.alarm_alm_set_minute
  - rtc.rtctest.rtc.alarm_wkalm_set
  - rtc.rtctest.rtc.date_read

* x86, kselftest-net
  - net.gro.sh


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211108)
* i386, kselftest-net
  - net.tls
  - net.tls.tls.12_aes_gcm.send_then_sendfile
  - net.tls.tls.12_chacha.send_then_sendfile
  - net.tls.tls.13_aes_gcm.send_then_sendfile
  - net.tls.tls.13_chacha.send_then_sendfile
  - net.tls.tls.13_sm4_ccm.send_then_sendfile
  - net.tls.tls.13_sm4_gcm.send_then_sendfile

* i386, kselftest-rtc
  - rtc.rtctest

* qemu_x86_64, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace


## Test result summary
total: 2965, pass: 1817, fail: 249, skip: 899, xfail: 0

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
