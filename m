Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9DE4F9DF5
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 22:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiDHUHp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 16:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbiDHUHh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 16:07:37 -0400
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com [54.240.48.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C126C129868;
        Fri,  8 Apr 2022 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1649448331;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=xkIsAgunhRr0neJeqNDS1WM30Wze5PpisrEkUilccb8=;
        b=fqWYNFH7D426KXPYP6E6g6b85IxVw3KA7sn0ty0TpXgC9/x6LOKDyKLjaQennZfz
        qpAA2BnkYMEmt0VGaNaN/WWd7/8Nk6uHKVgBUJAlC/P/5b8Ji/7dRbZKC90o1U+l63E
        F890yP9yFhh76svKQ9CbO9pmnNjAZrUikkW1TWNg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1649448331;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=xkIsAgunhRr0neJeqNDS1WM30Wze5PpisrEkUilccb8=;
        b=AujO4gg0gzN98Q4wNzATEm39RF946/qvrlLVGru97TzQ5YLMaVV4aavUatG3OVmT
        23MJyfIjwWw882S2Mq5xlzT+3SNKL8Ev9tj8xU33G6u2BW1o7AG/vGg1ah++a+qt5/Z
        h3HfczWPUiMuj7pZgUG1Ea4qFxCoLwQMKXG/Ydek=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220405
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <010001800ac828cc-76742421-5661-4146-871f-60ef20034198-000000@email.amazonses.com>
Date:   Fri, 8 Apr 2022 20:05:31 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.04.08-54.240.48.34
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.18.0-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 3ccc916812598a88b427859679ffd1641e67d4a2
* git describe: next-20220405
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220405

## Test Regressions (compared to next-20220401)
No test regressions found.

## Metric Regressions (compared to next-20220401)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220401)
No test fixes found.

## Metric Fixes (compared to next-20220401)
No metric fixes found.

## Test result summary
total: 5869, pass: 3195, fail: 542, skip: 2132, xfail: 0

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
