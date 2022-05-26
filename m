Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AA7534F1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 May 2022 14:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbiEZMa0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 May 2022 08:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240465AbiEZMa0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 May 2022 08:30:26 -0400
Received: from a8-81.smtp-out.amazonses.com (a8-81.smtp-out.amazonses.com [54.240.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77674968B;
        Thu, 26 May 2022 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1653568223;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=2aZrCzQ1lZS1oPs6ZB6xhhZu1fAUHLlNQ/vday3q0js=;
        b=QgNT6lzZhumWfYtP6JRIu19gM7fOhvq6174CEFZuKcRQ/09usewm/tO6Jx05C4dp
        7eqadaFS1Tnd8h8nAZCGmFcZX784Sak9150QSYqD2YHsBrHC6oL6vX3xSmFI5IB+21f
        rsMOaqlN4zK2duRiS75AO6cyx2+/YIApVvrgDROc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1653568223;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=2aZrCzQ1lZS1oPs6ZB6xhhZu1fAUHLlNQ/vday3q0js=;
        b=LkRMhUoHYYJ2f84Yq6/TVOFBlKPWIyFtDKYRuXgc1NyQCRo6bB354pzY3W2JtSdL
        hDGO4LkkHL4PScdHldN40cGeAjXN23qX8s/8z57kn97Vo7a+vVfAvdPomFgmwSauVeR
        6k8rKANJQLt8S+jgiAFitfDGik5cQEFbHlXVNR2c=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20220525
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <010001810058b9c4-97bfa918-991e-4f2f-8334-4df5aea3f1bd-000000@email.amazonses.com>
Date:   Thu, 26 May 2022 12:30:23 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.26-54.240.8.81
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
* git commit: 8cb8311e95e3bb58bd84d6350365f14a718faa6d
* git describe: next-20220525
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220525

## Test Regressions (compared to next-20220524)
* qemu_arm, kselftest-pidfd
  - pidfd.pidfd_poll_test


## Metric Regressions (compared to next-20220524)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220524)
* qemu_arm, kselftest-seccomp
  - seccomp.seccomp_benchmark
  - seccomp.seccomp_bpf.TSYNC.siblings_fail_prctl
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence
  - seccomp.seccomp_bpf.TSYNC.two_siblings_with_one_divergence_no_tid_in_err


## Metric Fixes (compared to next-20220524)
No metric fixes found.

## Test result summary
total: 385, pass: 166, fail: 91, skip: 128, xfail: 0

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
