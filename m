Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ABE53287E
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 13:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiEXLF3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 07:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbiEXLF2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 07:05:28 -0400
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com [54.240.48.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D2074DE7;
        Tue, 24 May 2022 04:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1653390325;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=iCVv0HQG+I2p0iamvcAJap0aqR6e6Ae3Ce4H8XOmrKY=;
        b=IlS4Y06uUD88GLuA8HOSmy9zthDll/bsD6eTE+kDt5S3/Woz1RDlWguAwe3axS51
        9YAwsyEfWgT42NZ/cG24Xw1MVfisg5Z64tBzj8NkaeYQEiLexnHmVRuwdG7QVSlF6+c
        JkuWzXhVdCvQ4fDgWPA266hP/8e9p/T2pPx9PDqk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1653390325;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=iCVv0HQG+I2p0iamvcAJap0aqR6e6Ae3Ce4H8XOmrKY=;
        b=iwTDULtCN6clQ2uKKcF77UoFjoaYVXqraVI/HgKeGaHi8QIDdMrBBnWsGXoVHiox
        gnJYRxdqIYOqcIah3MmfczNYLmqKXXcdned667irwTT9PpenBfTrz3uVSn/1RwtToGZ
        u714eJJRPQa8eqWZkmpb1L0esbsu3JWcWFUs3eTA=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20220523
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <01000180f5be359d-1937280e-1193-4195-9757-74d4bf0a8083-000000@email.amazonses.com>
Date:   Tue, 24 May 2022 11:05:25 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.24-54.240.48.37
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.18.0
* git: ['', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: cc63e8e92cb872081f249ea16e6c460642f3e4fb
* git describe: next-20220523
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220523

## Test Regressions (compared to next-20220520)
* dragonboard-845c, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace

* dragonboard-845c, kselftest-rtc
  - rtc.rtctest.rtc.uie_select


## Metric Regressions (compared to next-20220520)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220520)
* dragonboard-845c, kselftest-timers
  - timers.rtcpie

* qemu-arm64-gic-version2, kselftest-cgroup
  - cgroup.test_freezer

* qemu-arm64-gic-version2, kselftest-timers
  - timers.rtcpie

* qemu-arm64-gic-version3, kselftest-timers
  - timers.rtcpie

* qemu-arm64-mte, kselftest-cgroup
  - cgroup.test_freezer

* qemu-arm64-mte, kselftest-timers
  - timers.rtcpie

* qemu_arm, kselftest-timers
  - timers.rtcpie

* qemu_arm64, kselftest-timers
  - timers.rtcpie


## Metric Fixes (compared to next-20220520)
No metric fixes found.

## Test result summary
total: 5547, pass: 2993, fail: 526, skip: 2028, xfail: 0

## Build Summary

## Test suites summary
* kselftest-android
* kselftest-arm64
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
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
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
