Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2833252ED6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 May 2022 15:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349969AbiETNqB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 May 2022 09:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349957AbiETNp5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 May 2022 09:45:57 -0400
Received: from a8-29.smtp-out.amazonses.com (a8-29.smtp-out.amazonses.com [54.240.8.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D72F582;
        Fri, 20 May 2022 06:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1653054352;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=sSqNE0cbxqux9LCwqr3dNaLCGwOyA2ldUkoaFK6bNIY=;
        b=Oprt8BC5TYejaD1BgWHEBqu+1NzfAuQA2wT06tJi9eoIh1a3c932duPlpeL7SX4b
        D1AjN3JYp1b7nc1ykY5iWXZLxZDOsAYFFGsQid3eYOcrDKfsQ5jIZR8dHL4MSVxak2A
        HVFzsl3TFEsK5LI7hKy/000RvWDkH32c36fcxuAM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1653054352;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=sSqNE0cbxqux9LCwqr3dNaLCGwOyA2ldUkoaFK6bNIY=;
        b=KO06sp6pIPFYCuySzLeedQ5e0PNwgbTLtejgUih699PCBjgzM+JAOOWxZnLSpHQf
        EJBS8cb6zUHBCV9wL7Y/tOV9/V7kn/6oiK4gAM6cYSymaPz71sugogqMnGtm8tg8xoc
        i3WnGK9PM5E3OIYgfhX1EZ76J9WcBoN/IQp4+cPw=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20220511
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <01000180e1b7acb0-1299c1fa-799d-4240-abfa-28f0092324f1-000000@email.amazonses.com>
Date:   Fri, 20 May 2022 13:45:52 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.20-54.240.8.29
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
* kernel: 5.18.0-rc6
* git: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
* git branch: master
* git commit: 6107040c99d5dfc920721c198d45ed2d639b113a
* git describe: next-20220511
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220511

## Test Regressions (compared to next-20220506)
* qemu-arm64-mte, kselftest-cgroup
  - cgroup.test_freezer

* qemu-arm64-mte, kselftest-timers
  - timers.rtcpie


## Metric Regressions (compared to next-20220506)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to next-20220506)
* dragonboard-845c, kselftest-rtc
  - rtc.rtctest.rtc.uie_select


## Metric Fixes (compared to next-20220506)
No metric fixes found.

## Test result summary
total: 4368, pass: 2280, fail: 401, skip: 1687, xfail: 0

## Build Summary

## Test suites summary
* kselftest-android
* kselftest-arm64
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
* kselftest-zram

--
Linaro LKFT
https://lkft.linaro.org
