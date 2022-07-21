Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E703C57CDBD
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiGUOel (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 10:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiGUOek (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 10:34:40 -0400
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com [54.240.48.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCC67D1D7;
        Thu, 21 Jul 2022 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1658414075;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=PG2qkkGH+3URLpHWBiKi5giOZ07YnvDih++ZIHc39wg=;
        b=NbSnxHxBDJ/9uYTtB4ULDF7Q/3aMzpv9X3qbDKBgJsLn9pcazgDV6zmtaRwdjlwV
        CDtHv0F9c24CqVBgyKZ0t2dCB85sLVWJJBNMRLSullCeqd56nLCDLC4NXEPEAMb6Cxw
        3HuEwwcO+ZNt59YDsToVBmnqS1guKrRXChLYY0xw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1658414075;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=PG2qkkGH+3URLpHWBiKi5giOZ07YnvDih++ZIHc39wg=;
        b=Xudzm3Lt/bhCmOFMVITh9LnQH2JoC2BFwYejFl65uTjJmkVq1ASYyJFJL+NMXNCK
        MdosmJFgtgVGUpZ05YYS9P4iwWKOrTSUGOu3Q4Ak4ySAgQdckmOFOa34jhChlK2SgH0
        XqjHnd5Xio9Jyw0qAhtjTYc0HuCMVaKE+t9zSa6s=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20220721
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <01000182212e8e03-8e41f951-57c0-4802-b961-584f35ba4fbb-000000@email.amazonses.com>
Date:   Thu, 21 Jul 2022 14:34:35 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.07.21-54.240.48.34
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
* git commit: a3fd3ca134d9485a0f9a7bdcffd7f8bae27f79d3
* git describe: next-20220721
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220721

## Test Regressions (compared to v5.19-rc6-12429-g4ee7eaa411ee)
* qemu_arm, kselftest-rtc
  - rtc.rtctest
  - rtc.rtctest.rtc.date_read_loop


## Metric Regressions (compared to v5.19-rc6-12429-g4ee7eaa411ee)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to v5.19-rc6-12429-g4ee7eaa411ee)
* qemu_arm, kselftest-seccomp
  - seccomp.seccomp_benchmark


## Metric Fixes (compared to v5.19-rc6-12429-g4ee7eaa411ee)
No metric fixes found.

## Test result summary
total: 345, pass: 167, fail: 44, skip: 134, xfail: 0

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
