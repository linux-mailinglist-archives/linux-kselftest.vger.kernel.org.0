Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE66405A26
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Sep 2021 17:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbhIIPYN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Sep 2021 11:24:13 -0400
Received: from a8-97.smtp-out.amazonses.com ([54.240.8.97]:59723 "EHLO
        a8-97.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236865AbhIIPYH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Sep 2021 11:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1631200977;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=/62tsyL2E1/xK7osPvmgAeiFEDXec4QXMpUsVth13hg=;
        b=QWk758cpZTH2ABXEULc7ICYmexTxyxgEvrT378ml1dER5WjaD87kYexavxTkfFSc
        a/x4IK8NZpIAoweUlkwmzSXyNaYNtf+GsnCUfBS/7LkkYawoCGfHBCzkVWjgU7F5SGf
        6Q2b0R4ZllIRdKEMbvn0PJDtY+n8nylNfoVK9980=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1631200977;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=/62tsyL2E1/xK7osPvmgAeiFEDXec4QXMpUsVth13hg=;
        b=UG2qaeY6wP2jH1oHEJISOlx3vm4Sh0+aDj+hNzy5QCUc9JSdZDgkjVCVcXZNxtAV
        9BkEcnJUJB3rGHnhO+qPCt9Rxp0gem/ZBIUVGziDlO9GpIF1cXjET4C8R+ZTH5PiTYl
        JE8YZfE6A7lb09oRg8HJFhRRVLsziHq8KlA9tbl0=
From:   lkft@linaro.org
To:     lkft@linaro.org
Cc:     lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [REGRESSION] lkft kselftest for next-20210909
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017bcb27a095-3fa09b23-571d-4ce4-b120-33f6e7ec779f-000000@email.amazonses.com>
Date:   Thu, 9 Sep 2021 15:22:57 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2021.09.09-54.240.8.97
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Build
* kernel: 5.14.0
* git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
* git branch: master
* git commit: f7f581157d1c8a2f14bef2739dd34135c9e6b233
* git describe: next-20210909
* test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20210909

## Regressions (compared to next-20210907)
* qemu-arm64-mte, kselftest-timers
  - timers.rtcpie

* x15, kselftest-rtc
  - rtc.rtctest


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Fixes (compared to next-20210907)
* hi6220-hikey, kselftest-rtc
  - rtc.rtctest

* qemu-arm64-gic-version3, kselftest-timers
  - timers.rtcpie

* qemu_arm, kselftest-pidfd
  - pidfd.pidfd_test

* qemu_arm, kselftest-rtc
  - rtc.rtctest

* x15, kselftest-cgroup
  - cgroup.test_freezer
  - cgroup.test_freezer.test_cgfreezer_ptrace


## Test result summary
total: 6381, pass: 3846, fail: 617, skip: 1918, xfail: 0

## Build Summary

## Test suites summary
* kselftest-
* kselftest-android
* kselftest-arm64
* kselftest-arm64/arm64.btitest.bti_c_func
* kselftest-arm64/arm64.btitest.bti_j_func
* kselftest-arm64/arm64.btitest.bti_jc_func
* kselftest-arm64/arm64.btitest.bti_none_func
* kselftest-arm64/arm64.btitest.nohint_func
* kselftest-arm64/arm64.btitest.paciasp_func
* kselftest-arm64/arm64.nobtitest.bti_c_func
* kselftest-arm64/arm64.nobtitest.bti_j_func
* kselftest-arm64/arm64.nobtitest.bti_jc_func
* kselftest-arm64/arm64.nobtitest.bti_none_func
* kselftest-arm64/arm64.nobtitest.nohint_func
* kselftest-arm64/arm64.nobtitest.paciasp_func
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
* kselftest-lkdtm
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-netfilter
* kselftest-nsfs
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
* kselftest-tc-testing
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
