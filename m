Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5AC4C5615
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Feb 2022 14:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiBZNa5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Feb 2022 08:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiBZNaz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Feb 2022 08:30:55 -0500
Received: from a8-29.smtp-out.amazonses.com (a8-29.smtp-out.amazonses.com [54.240.8.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466E74D62E;
        Sat, 26 Feb 2022 05:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1645882220;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=fC6smFVHLRjxytFRyQyAyDL9rrTwoYdz2RM/SJO46Jw=;
        b=p81P0gNuH74gUF8pLEnmOqAPVRo7V7+bgB7wMZgPFTlrquh1Wgl26+ZicEZez2mP
        S3kf+z6K5b/QcdwgWNzH91HQH18+UR1Fhb0PP61Hgdx8ieDZTaBnZT7sY3mXVYTH2SM
        VmRTtbWkSgQ5xESkYZN5JOC33wbFsL/F9CO9ZpkA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1645882220;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=fC6smFVHLRjxytFRyQyAyDL9rrTwoYdz2RM/SJO46Jw=;
        b=jpeEbpqETnhQ58yNSwo4EzoM2Fwx9fIGbrxDXcuaDACCJNQoeqOLc6vbqR8UojKM
        AulPF3sPwLc8uD2D25onK6Bs7DhL9Aj5RMYjIECUTpxrkSADEELXa5g+TGEf17m/13X
        ysA1ldiLOYMz0gqVu8QMIgisrdtFfP59TTD0hGuk=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: lkft kselftest for next-20220225
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017f36399c8a-6d5ad838-77ba-4951-b354-fcd7cf2ea4e5-000000@email.amazonses.com>
Date:   Sat, 26 Feb 2022 13:30:20 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.02.26-54.240.8.29
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.17.0-rc5
* git: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
* git branch: [None, 'master']
* git commit: 06aeb1495c39c86ccfaf1adadc1d2200179f16eb
* git describe: next-20220225
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220225

## Test Regressions (compared to next-20220223)
No test regressions found.

## Metric Regressions (compared to next-20220223)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220223)
No test fixes found.

## Metric Fixes (compared to next-20220223)
No metric fixes found.

## Test result summary
total: 1720, pass: 1139, fail: 169, skip: 412, xfail: 0

## Build Summary

## Test suites summary
* kselftest-android
* kselftest-bpf
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
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

--
Linaro LKFT
https://lkft.linaro.org
