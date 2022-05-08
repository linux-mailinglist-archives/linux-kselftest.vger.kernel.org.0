Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F116651EDF9
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 May 2022 16:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiEHOSi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 May 2022 10:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiEHOSg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 May 2022 10:18:36 -0400
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com [54.240.48.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A95DDFF3;
        Sun,  8 May 2022 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1652019285;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=sx1PSW1HsS8M56WESid55HalPHtnRuAyyOMr+1GUOAo=;
        b=G8+KS+bV1hUPaV+JYqa6TnX2Rvk9wK0nBYyZQ5jCt7Tnxt0YZ1vI+WM8PT1oaXwR
        YSoyB/rTQlUd5XiEvQJIFWrVWU+F5vv4sSutjC0D4PzAn/1GHHN5O0J4u2igHybKM1N
        6t3uLzUaj9elhThs9AlWp2ALCfrfTwctz3VMRT6o=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1652019285;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=sx1PSW1HsS8M56WESid55HalPHtnRuAyyOMr+1GUOAo=;
        b=Zmr3NGIRGMJMqbDVc/RzUmy3LHzeB00HxPTOQWYyrWzA2GHpRZWasGh76adKTzJX
        mxzy2zC1yJvv6c/xwuh/UgMIDrgNQ3u81v0wUUwwJ/Iv0jtheOP+Ck7+jcl92EDGYkd
        anbIh6MUIrtdKQTv0aobD02Hui54TW5c/BOlsuMk=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20220317
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <01000180a405cb4e-8bd09df9-39e5-4687-9686-9510ce5c6df0-000000@email.amazonses.com>
Date:   Sun, 8 May 2022 14:14:44 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.08-54.240.48.34
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.17.0-rc8
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 97add482e9033a9386baa8824fbea34d0cbfe663
* git describe: next-20220317
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220317

## Test Regressions (compared to next-20220302)
* i386, kselftest-rtc
  - rtc.rtctest

* qemu_x86_64, kselftest-rtc
  - rtc.rtctest

* x86, kselftest-pidfd
  - pidfd.pidfd_test


## Metric Regressions (compared to next-20220302)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220302)
No test fixes found.

## Metric Fixes (compared to next-20220302)
No metric fixes found.

## Test result summary
total: 5102, pass: 2816, fail: 472, skip: 1814, xfail: 0

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
