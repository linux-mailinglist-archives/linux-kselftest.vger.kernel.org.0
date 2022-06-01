Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1499953A0A2
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Jun 2022 11:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351132AbiFAJf7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Jun 2022 05:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351236AbiFAJfe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Jun 2022 05:35:34 -0400
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com [54.240.48.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B4A8FD5F;
        Wed,  1 Jun 2022 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1654076132;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=9AMtDg2Y5aAkB0Fq77W2ubU91kwlffa/46gFCwaOz/s=;
        b=pi467wzYJC8qTxMOD+/iAUfSzuQIlFThlXWrDuC+LG4PtvnsVbZC5M9GsMIbyKNH
        OD0qzTnYdkL2VrUAW6bZF0bJwhP4RXJrCe5A2B6tu08pRpbdutsLybjHNvfLN/qFhWT
        IcSbXX7zNaAl+3cD02zFBazo43wuwbINI/co2A7o=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1654076132;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=9AMtDg2Y5aAkB0Fq77W2ubU91kwlffa/46gFCwaOz/s=;
        b=NKcab6t1XqbA/C80AdU5w08VqBVSdsCmN7J1papB8CgC3yipYs/GuAHq3usvAMnS
        m2pPrRGQ6uxqq/SXFxBMOwehy6RRPhWzklW1+umH+Rh4OPOYH7e0mFIp1CMiHXtH67d
        liWtfupv0f8dHxucngDdve8bqYPggyQlooD2iUdo=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220601
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <010001811e9ec826-716b9268-d6ba-47c6-b270-5b988f2f99c5-000000@email.amazonses.com>
Date:   Wed, 1 Jun 2022 09:35:31 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.06.01-54.240.48.37
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
* git commit: 5d8e7e3bbaaf115a935accd269873469928848c0
* git describe: next-20220601
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220601

## Test Regressions (compared to next-20220531)
No test regressions found.

## Metric Regressions (compared to next-20220531)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220531)
* qemu_arm, kselftest-seccomp
  - seccomp.seccomp_benchmark


## Metric Fixes (compared to next-20220531)
No metric fixes found.

## Test result summary
total: 546, pass: 266, fail: 108, skip: 172, xfail: 0

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
