Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D71275DBC0
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 12:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGVKap (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 06:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjGVKao (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 06:30:44 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEA4270F
        for <linux-kselftest@vger.kernel.org>; Sat, 22 Jul 2023 03:30:41 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b9c90527a0so2299407a34.1
        for <linux-kselftest@vger.kernel.org>; Sat, 22 Jul 2023 03:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690021841; x=1690626641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOKl5MdBmvMSYXKLCi5t49QAL09Br/Pxi868eSGFh84=;
        b=VVu7q7ucD2XFv5rZNuZA8D/e0dguqQKpujw+u6Qu9i5hDemofQ2rfD30TWZi0SZWnl
         m0nwUPMmN1ZV4NxEGWzW0KzS0YFB2L9Uie+xNlXoJen7/coHvNw/Q2bo4eyHP9DAJmin
         676XUuKib8GAnB/Q2bgRB5QeQlXEJB3JAnKHFhL6hzjVjS0/paE/lC9gyTkUhiIVWXZM
         HKj5zVuTVAf2d/C7vUhsPowFUn8hdTa/82Fr6fbLTMbdVGlcAjxabmMlKSjunIk/VR+9
         DyAODGiVMQksGs/XQ1m48U/fbSq2tLmN4Q96+kwO4MV/cdA5COxbC1ZHDEpimUN9ZN93
         9zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690021841; x=1690626641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOKl5MdBmvMSYXKLCi5t49QAL09Br/Pxi868eSGFh84=;
        b=ElM7wmVLVmhDHeQon//KmIpyPFHpWsX39UOx5+hvYg0h3fKvO16kPCZ02EI1aeVR4o
         RUWjf51YmwZmxs4yZKqA3xVaEDBvh0qdudOe85XZftrD0xrnCSG5solA95yfL6H0uId+
         PXioUUa1vrCzWkpH3hWctoWrsRFRiWmRvVQL9nn/I/pj+bylhlk1yttwDB17uuWgo7YV
         S7AhWN6zGkb/P4IaGxgpK/6xPAGpt5HRQcT/yLxC1lnjJJyBZ+NA6VvLovl0kGMftH7c
         Tp+0QX2G7wTj5DRxUul8s9e3rZY48WK/yIcC8VL/JQOrfqTNtIOLK0i98ihlwjhfKjVI
         bHjg==
X-Gm-Message-State: ABy/qLbRCl4ZvY09bZ4esoFp3VhRlQ2Htpf/aNlC4uBZKJmAaOgSwvP3
        xiU1Zzhrqzbij0q4qvoDG8gLWF6SMFrhB91EaEF1sg==
X-Google-Smtp-Source: APBJJlHxGRblosjMH4p2+lBC0j3tCcLuo+BldGrVBQsh613zaQjS0djs0GLvvduIJXDNq2dWqwjVUicaWzgXrmoBc6M=
X-Received: by 2002:a05:6358:5e05:b0:134:ed9b:15a7 with SMTP id
 q5-20020a0563585e0500b00134ed9b15a7mr1648429rwn.30.1690021840866; Sat, 22 Jul
 2023 03:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230721160520.865493356@linuxfoundation.org>
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 22 Jul 2023 16:00:29 +0530
Message-ID: <CA+G9fYuoo8OPNGemxxcWjaGeO3U+xm2+aGOiC=8DiyzETG+1Jg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/223] 6.1.40-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Arnd Bergmann <arnd@arndb.de>, Vlad Buslov <vladbu@nvidia.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 22 Jul 2023 at 00:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.40 release.
> There are 223 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 23 Jul 2023 16:04:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.40-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTES:
These are not kernel regressions as per the review,

Following kselfest build regressions noticed on stable-rc 6.1 and 6.4
The selftests sources are from stable tree 6.4.y branch and version 6.4.4

selftest build errors:
---------------------

1)
aarch64-linux-gnu-gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE
-pthread   proc-empty-vm.c  -o kselftest/proc/proc-empty-vm
proc-empty-vm.c: In function 'main':
proc-empty-vm.c:350:2: error: #error "implement 'unmap everything'"
  350 | #error "implement 'unmap everything'"
      |  ^~~~~
make[3]: *** [../lib.mk:147: kselftest/proc/proc-empty-vm] Error 1


2)

make[3]: Entering directory 'tools/testing/selftests/tc-testing'
/bin/sh: 1: llc: not found
clang -I. -I/include/uapi  -Wno-compare-distinct-pointer-types \
-O2 -target bpf -emit-llvm -c action.c -o - |      \
llc -march=3Dbpf -mcpu=3Dprobe  -filetype=3Dobj -o kselftest/tc-testing/act=
ion.o
/bin/sh: 1: clang: not found
/bin/sh: 3: llc: not found
make[3]: *** [Makefile:26: kselftest/tc-testing/action.o] Error 127


## Build
* kernel: 6.1.40-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: e54fe15e179b2cc0f0587e2ef1549295ae7bc3be
* git describe: v6.1.39-224-ge54fe15e179b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.3=
9-224-ge54fe15e179b

## Test Regressions (compared to v6.1.39)
* bcm2711-rpi-4-b, kselftest-proc
  - shardfile-proc

* bcm2711-rpi-4-b, kselftest-tc-testing
  - shardfile-tc-testing

* dragonboard-410c, kselftest-proc
  - shardfile-proc

* dragonboard-410c, kselftest-tc-testing
  - shardfile-tc-testing

* juno-r2, kselftest-proc
  - shardfile-proc

* juno-r2, kselftest-tc-testing
  - shardfile-tc-testing


## Metric Regressions (compared to v6.1.39)

## Test Fixes (compared to v6.1.39)

## Metric Fixes (compared to v6.1.39)

## Test result summary
total: 149107, pass: 126633, fail: 2237, skip: 20065, xfail: 172

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 150 passed, 1 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 41 total, 38 passed, 3 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 16 total, 15 passed, 1 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-exec
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesytems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
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
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
