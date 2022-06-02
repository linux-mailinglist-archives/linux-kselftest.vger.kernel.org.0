Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1815753B7DA
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jun 2022 13:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiFBLbJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Jun 2022 07:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiFBLbF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Jun 2022 07:31:05 -0400
Received: from a8-29.smtp-out.amazonses.com (a8-29.smtp-out.amazonses.com [54.240.8.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A582A8925;
        Thu,  2 Jun 2022 04:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1654169460;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=lK/qu8KGZmT5KS5aV2M5wKRx6pgj1o3vhJmFcT4qf24=;
        b=Km81dSJCcKrGKeUoA6mAjYMFot0l0rIZcY20faylG5MF/caUQwbxZhpG4L2XNKco
        k/xkq9ui4ND3tfnAfoLk9mVLIo0PGWhSZodk2NNaHctSzN1xb2ih3UFlkokhRb28AIX
        ++1xTIKXJQ5kV+4ArpxSiWMMz8BFRkUrGgiOcY/g=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1654169460;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=lK/qu8KGZmT5KS5aV2M5wKRx6pgj1o3vhJmFcT4qf24=;
        b=UXTvzpACN3JSkD/kJ4OTcjUfr34PpAW/P+ZecpXhGq6N0IfLdibfJSlFvbNN2cZ8
        rTMVibUl6z9dNbS4qSAGdeGL7QcUL/Na3ocNWGMgSYszyzkLH5oGuhxTdYSvlTuPWoa
        jMkg7D9ri9+sEvAddBfDdask8UQET3s7QroP8RrQ=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20220602
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <01000181242edf6e-7c4cb01c-94b3-44e2-ba61-701f642eb5e7-000000@email.amazonses.com>
Date:   Thu, 2 Jun 2022 11:31:00 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.06.02-54.240.8.29
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
* git commit: 2e776ccffa840ce53ee1c21bde54cbe4bc102c3b
* git describe: next-20220602
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220602

## Test Regressions (compared to next-20220601)
* qemu_arm, kselftest-seccomp
  - seccomp.seccomp_benchmark


## Metric Regressions (compared to next-20220601)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220601)
No test fixes found.

## Metric Fixes (compared to next-20220601)
No metric fixes found.

## Test result summary
total: 508, pass: 253, fail: 105, skip: 150, xfail: 0

## Build Summary

## Test suites summary
* kselftest-android
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
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kvm
* kselftest-lib
* kselftest-membarrier
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
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

--
Linaro LKFT
https://lkft.linaro.org
