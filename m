Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480B657EC16
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Jul 2022 06:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbiGWE22 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 23 Jul 2022 00:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGWE21 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 23 Jul 2022 00:28:27 -0400
Received: from a8-29.smtp-out.amazonses.com (a8-29.smtp-out.amazonses.com [54.240.8.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6331812AF6;
        Fri, 22 Jul 2022 21:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1658550505;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=GGJWt9rFSxw6NTvnki0eUanQBBApejilO+ZQi+JxA7Y=;
        b=tY5Ao8Nbwwn1lANPY2uzzttEKC78ZlSG2rHKuANjrNuN60ah96+qDdWiKBOheG+1
        9JgsoB4WAIfnrhAhvyQk7ugaNXOLMpVvBb4ppJAJgtO39uGtJzfNszXK4VwceTD5WxH
        CGBP6QJp+M6nYXCOwXDk3WQ/AYzTCdGpygdUGQhw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1658550505;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=GGJWt9rFSxw6NTvnki0eUanQBBApejilO+ZQi+JxA7Y=;
        b=RqkWgV8w8lIuBNwZGc+UxxUrjO7wf6s80oUvtgRsy3KnbFnkkh3S3QEyR+vejKul
        lCMKNaj4aGoEtKDMfqpLR6IZL1To16VPivEDut4K009YLt48gzhy7jeZ2zGRbJSQasW
        eMZ0H/BhWW7TwoRruc3uoRcLUi6YJPL3jnEq/ZXA=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20220722
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100018229504f6c-f5ff9662-0f95-4090-a6ef-d8701de534d0-000000@email.amazonses.com>
Date:   Sat, 23 Jul 2022 04:28:25 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.07.23-54.240.8.29
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        TO_EQ_FM_DIRECT_MX autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.19.0-rc7
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: 18c107a1f120d095404d141dfad8f594bdc44020
* git describe: next-20220722
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220722

## Test Regressions (compared to next-20220721)
* qemu_arm, kselftest-seccomp
  - seccomp.seccomp_benchmark


## Metric Regressions (compared to next-20220721)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220721)
* qemu_arm, kselftest-rtc
  - rtc.rtctest
  - rtc.rtctest.rtc.date_read_loop


## Metric Fixes (compared to next-20220721)
No metric fixes found.

## Test result summary
total: 345, pass: 168, fail: 43, skip: 134, xfail: 0

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
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-firmware
* kselftest-fpu
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-lib
* kselftest-membarrier
* kselftest-netfilter
* kselftest-nsfs
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
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-vm

--
Linaro LKFT
https://lkft.linaro.org
