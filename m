Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5620343420A
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 01:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhJSXZO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 19:25:14 -0400
Received: from a48-37.smtp-out.amazonses.com ([54.240.48.37]:48009 "EHLO
        a48-37.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhJSXZO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 19:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1634685780;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=4LwFvDXo1V2q3PSMdI5AjDy5enOG8bKpDmqfLpVN0ms=;
        b=rZxSGtugHpOekOpY+5geyRlO1seRsKTyVuyLXbLuZKB648+lFlJpWGrR23G4nZw2
        Lppq/6O8YysZ2Eso8RCIs91AAfwOLsjCGgQoj6BgrIjsEh5sksuzHdUw5W5Izj2mJHr
        mceXlOG8XdVyiS4fcMZELDzlA3SMBnxfP24wowUI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1634685780;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=4LwFvDXo1V2q3PSMdI5AjDy5enOG8bKpDmqfLpVN0ms=;
        b=fgUD/cEIdp1bIvl7jAn9Wgoiy983i4jRxIzpORnx5CWPiwMLCV2p37Xqcls/9Uyc
        HL621jWbit89t6HnfNwu7uv5JMNH6F0txhoqwilyzTS4VRpewR7oV/iE0KRPGiz56fo
        ZcjHpCxzUXbmFJSnsWIhpbPxBUx9zg8//8BTr0Z8=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20211018
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017c9add7f0f-9e3cc339-71e1-431a-97cd-bb5038eaeaba-000000@email.amazonses.com>
Date:   Tue, 19 Oct 2021 23:22:59 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.10.19-54.240.48.37
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.15.0-rc5
* git: ['https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: 60e8840126bdcb60bccef74c3f962742183c681f
* git describe: next-20211018
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211018

## Regressions (compared to next-20211015)
* qemu_arm, kselftest-zram
  - zram.zram.sh


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20211015)
* qemu_x86_64, kselftest-seccomp
  - seccomp.seccomp_benchmark


## Test result summary
total: 1298, pass: 701, fail: 95, skip: 502, xfail: 0

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
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-lkdtm
* kselftest-membarrier
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
