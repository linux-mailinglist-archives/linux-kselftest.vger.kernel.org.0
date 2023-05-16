Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E52704FF6
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 May 2023 15:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjEPNyo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 09:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjEPNyn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 09:54:43 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F004693
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 06:54:19 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-4348416ae45so8421440137.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 May 2023 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684245258; x=1686837258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhWShmDJ2D9NIRvijbp0Qn/QaA9taQvDt1a8RmXcogw=;
        b=O57DIxjy1Xc3sNHH0MrW/WE8dMYKOZhPCEm95bbd6gXjAe7C3Hf9/JdwDat3Qo+I6C
         QJh2GRdeODfjeM691TTXSLJ7YtOPMzeQX8AcJsWpVQ2O9ts95Bd0HBHISkK1GnlfyHns
         ntIZg//0TjIvnp7qNpfiOSMkkW1MqAPn7LP7hKDQF5MiVNG6KAu1Pir6d3RnL8BVUpOY
         46WTugftDmyMr2PvjeXEuFKd/MS8TRoBpBdueHya/lVJNlnn+eii7FUN7pRj7Oxh9xSk
         gKNyXY94vWKQg0KJI2sa6KCO7cIPNYoOyZkxoiNgsHNrRh6JXg7g8vPxPSeybyzSu5MB
         +3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684245258; x=1686837258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhWShmDJ2D9NIRvijbp0Qn/QaA9taQvDt1a8RmXcogw=;
        b=delfIA7wWyudEEIGvMFw6a//n9HX7XbMgaAxDb3HA6KLp5Z8xQelUSYHwziyzR96Vk
         r3kDOCjdXrUBJSL6g4tM8Y6OinmI1gNmWQQmRjoIxASrJBN+rRl6+tT/3n3kIyu51VpY
         IiohCPSpE9I7idW8c3E4EyZox0xmJfhFFjdB95c+yCN2yU4uKrVWJsWLAJGxYEWzKX6h
         r38nnQ4qaq6ZC/NHjPYcSxeRcYJH4Kz18hqW99/bxxjv2vGdERJabe7saFpXrOGBJSVK
         fDGNqSreqJyHIUCqvQYASQQO1/lvkYwPp9Ztsc4oNryr1a8KqMXCn1OHq7nY1O68VaB1
         Kn7Q==
X-Gm-Message-State: AC+VfDwNnTqe7+xJm/VNMtzMU4kDCPxcovZQ+4scqU+C6O3Azk3rKZP8
        UBMLnwCv/KYjgSgSnPnSG+VswfqvxLzuRhdkmUlbwQ==
X-Google-Smtp-Source: ACHHUZ6PPXq7zfVMp+g4ZtdyK7QvqxUi0r8kPWInCXLO7YN83y3cyeiX80bd2YkHWnNP+WAscugxKswDI1eA0AvyprA=
X-Received: by 2002:a67:f3cb:0:b0:434:4deb:e89 with SMTP id
 j11-20020a67f3cb000000b004344deb0e89mr14769682vsn.12.1684245257777; Tue, 16
 May 2023 06:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230515161721.545370111@linuxfoundation.org>
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 16 May 2023 19:24:06 +0530
Message-ID: <CA+G9fYu6ZOu_We2GMP0sFnSovOsqd6waW7oKS-Y1VPrjdibu5Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/239] 6.1.29-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        Michal Clapinski <mclapinski@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LTP List <ltp@lists.linux.it>,
        Aaron Lewis <aaronlewis@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Rudi Heitbaum <rudi@heitbaum.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 15 May 2023 at 22:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.29 release.
> There are 239 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.29-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
Regressions on arm64, arm, x86_64, and i386.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

We have recently upgraded our selftest sources to stable-rc 6.3 and
running on stable rc 6.1 kernel.

List of test regressions:
=3D=3D=3D=3D=3D=3D=3D=3D
kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

kselftest-memfd
  - memfd_memfd_test

kselftest-rseq
  - rseq_basic_test

 kselftest-kvm
  - kvm_hyperv_features
  - kvm_xapic_state_test

ltp-commands
  - mkfs01_ntfs_sh

Details:
=3D=3D=3D=3D=3D

# selftests: membarrier: membarrier_test_single_thread
# TAP version 13
# 1..18
# Bail out! sys membarrier MEMBARRIER_CMD_GET_REGISTRATIONS test:
flags =3D 0, errno =3D 22
# # Planned tests !=3D run tests (18 !=3D 0)
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: membarrier: membarrier_test_single_thread # exit=3D1
# selftests: membarrier: membarrier_test_multi_thread
# TAP version 13
# 1..16
# ok 1 sys_membarrier available
# ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0,
errno =3D 22. Failed as expected
# ok 3 sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags =3D
1, errno =3D 22. Failed as expected
# ok 4 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered
failure test: flags =3D 0, errno =3D 1
# ok 5 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not
registered failure test: flags =3D 0, errno =3D 1
# ok 6 sys membarrier MEMBARRIER_CMD_GLOBAL test: flags =3D 0
# ok 7 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED test: flags=
 =3D 0
# Bail out! sys membarrier MEMBARRIER_CMD_GET_REGISTRATIONS test:
flags =3D 0, errno =3D 22
# # Planned tests !=3D run tests (16 !=3D 7)
# # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
not ok 2 selftests: membarrier: membarrier_test_multi_thread # exit=3D1

=3D=3D=3D=3D=3D=3D=3D=3D

kselftest: Running tests in memfd
TAP version 13
1..3
# selftests: memfd: memfd_test
# Aborted
not ok 1 selftests: memfd: memfd_test # exit=3D134

=3D=3D=3D=3D=3D=3D=3D=3D

kselftest: Running tests in rseq
TAP version 13
1..9
# selftests: rseq: basic_test
# basic_test: rseq.h:204: rseq_current_node_id: Assertion
`rseq_node_id_available()' failed.
# ./kselftest/runner.sh: line 35:  1709 Aborted
         /usr/bin/timeout --foreground \"$kselftest_timeout\" $1
not ok 1 selftests: rseq: basic_test # exit=3D134
# selftests: rseq: basic_percpu_ops_test
# spinlock
# percpu_list
ok 2 selftests: rseq: basic_percpu_ops_test
# selftests: rseq: basic_percpu_ops_mm_cid_test
# spinlock
# percpu_list
ok 3 selftests: rseq: basic_percpu_ops_mm_cid_test
# selftests: rseq: param_test
ok 4 selftests: rseq: param_test
# selftests: rseq: param_test_benchmark
ok 5 selftests: rseq: param_test_benchmark
# selftests: rseq: param_test_compare_twice
ok 6 selftests: rseq: param_test_compare_twice
# selftests: rseq: param_test_mm_cid
# Error: cpu id getter unavailable
not ok 7 selftests: rseq: param_test_mm_cid # exit=3D255
# selftests: rseq: param_test_mm_cid_benchmark
# Error: cpu id getter unavailable
not ok 8 selftests: rseq: param_test_mm_cid_benchmark # exit=3D255
# selftests: rseq: param_test_mm_cid_compare_twice
# Error: cpu id getter unavailable
not ok 9 selftests: rseq: param_test_mm_cid_compare_twice # exit=3D255

=3D=3D=3D=3D=3D=3D

# selftests: kvm: hyperv_features
# Testing access to Hyper-V specific MSRs
# =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
#   x86_64/hyperv_features.c:498: false
#   pid=3D1043 tid=3D1043 errno=3D4 - Interrupted system call
#      1 0x0000000000403722: ?? ??:0
#      2 0x00007fc1e890157a: ?? ??:0
#      3 0x00007fc1e890162f: ?? ??:0
#      4 0x00000000004037c4: ?? ??:0
#   Failed guest assert: !vector at x86_64/hyperv_features.c:58
# MSR =3D 40000118, arg1 =3D d, arg2 =3D 0
not ok 10 selftests: kvm: hyperv_features # exit=3D254

# selftests: kvm: xapic_state_test
# =3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D
#   x86_64/xapic_state_test.c:147: apic_id =3D=3D expected
#   pid=3D2175 tid=3D2175 errno=3D4 - Interrupted system call
#      1 0x0000000000402bac: ?? ??:0
#      2 0x00000000004025ba: ?? ??:0
#      3 0x00007f0040cd457a: ?? ??:0
#      4 0x00007f0040cd462f: ?? ??:0
#      5 0x0000000000402624: ?? ??:0
#   APIC_ID not set back to xAPIC format; wanted =3D 1000000, got =3D 1
not ok 46 selftests: kvm: xapic_state_test # exit=3D254

=3D=3D=3D=3D

tst_device.c:93:[  147.226163] loop0: detected capacity change from 0 to 61=
4400
 TINFO: Found free device 0 '/dev/loop0'
mkfs01 1 TINFO: timeout per run is 0h 50m 0s
mkfs01 1 TPASS: 'mkfs -t ntfs  /dev/loop0 ' passed.
mkfs01 2 TINFO: Mounting device: mount -t ntfs /dev/loop0
/scratch/ltp-zKu0Zn6L6o/LTP_mkfs01.ULVi9nN6XF/mntpoint
modprobe: FATAL: Module fuse not found in directory /lib/modules/6.2.16-rc1
ntfs-3g-mount: fuse device is missing, try 'modprobe fuse' as root
mkfs01 2 TBROK: Failed to mount device ntfs type: mount exit =3D 21
[  166.420602] I/O error, dev loop0, sector 614272 op 0x0:(READ) flags
0x80700 phys_seg 1 prio class 2

Steps to reproduce:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# To install tuxrun on your system globally:
# sudo pip3 install -U tuxrun=3D=3D0.42.0
#
# See https://tuxrun.org/ for complete documentation.

tuxrun   \
 --runtime podman   \
 --device qemu-x86_64   \
 --boot-args rw   \
 --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2Pq4UnS1BC=
krcnT51kVe9rFF0k1/bzImage
  \
 --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2Pq4UnS1B=
CkrcnT51kVe9rFF0k1/modules.tar.xz
  \
 --rootfs https://storage.tuxboot.com/debian/bookworm/amd64/rootfs.ext4.xz =
  \
 --parameters SKIPFILE=3Dskipfile-lkft.yaml   \
 --parameters KSELFTEST=3Dhttps://storage.tuxsuite.com/public/linaro/lkft/b=
uilds/2PeR5CFkuV3xkzzYLrOV8JHT9ie/kselftest.tar.xz
  \
 --image docker.io/lavasoftware/lava-dispatcher:2023.01.0020.gc1598238f   \
 --tests kselftest-membarrier   \
 --timeouts boot=3D15

Test log links and details,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

membarrier: test_multi_thread:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 - https://lkft.validation.linaro.org/scheduler/job/6427965#L1776
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.=
1.28-240-gb82733c0ff99/testrun/17020997/suite/kselftest-membarrier/test/mem=
barrier_membarrier_test_multi_thread/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.=
1.28-240-gb82733c0ff99/testrun/17021028/suite/kselftest-membarrier/test/mem=
barrier_membarrier_test_multi_thread/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.=
1.28-240-gb82733c0ff99/testrun/17020997/suite/kselftest-membarrier/tests/


memfd_test:
=3D=3D=3D=3D=3D=3D=3D=3D=3D
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.=
1.28-240-gb82733c0ff99/testrun/17020879/suite/kselftest-memfd/test/memfd_me=
mfd_test/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.=
1.28-240-gb82733c0ff99/testrun/17007742/suite/kselftest-memfd/tests/

rseq_basic_test:
=3D=3D=3D=3D=3D=3D=3D=3D=3D
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.=
1.28-240-gb82733c0ff99/testrun/17020993/suite/kselftest-rseq/test/rseq_basi=
c_test/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.=
1.28-240-gb82733c0ff99/testrun/17020993/suite/kselftest-rseq/test/rseq_basi=
c_test/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.=
1.28-240-gb82733c0ff99/testrun/17020993/suite/kselftest-rseq/test/rseq_basi=
c_test/details/


kvm: kvm_hyperv_features and kvm_xapic_state_test:
=3D=3D=3D=3D=3D=3D=3D=3D=3D
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.=
1.28-240-gb82733c0ff99/testrun/17020070/suite/kselftest-kvm/test/kvm_hyperv=
_features/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.=
1.28-240-gb82733c0ff99/testrun/17020070/suite/kselftest-kvm/test/kvm_hyperv=
_features/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.=
1.28-240-gb82733c0ff99/testrun/17020070/suite/kselftest-kvm/test/kvm_xapic_=
state_test/history/

ltp-commands: mkfs01_ntfs_sh:
=3D=3D=3D=3D=3D=3D=3D=3D
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.=
1.28-240-gb82733c0ff99/testrun/17019910/suite/ltp-commands/test/mkfs01_ntfs=
_sh/history/

## Build
* kernel: 6.1.29-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: b82733c0ff99435bb7eb5ed4ea2e1c1fd69e7ebb
* git describe: v6.1.28-240-gb82733c0ff99
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.2=
8-240-gb82733c0ff99

## Test Regressions (compared to v6.1.28)

* bcm2711-rpi-4-b, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* bcm2711-rpi-4-b, kselftest-memfd
  - memfd_memfd_test

* dragonboard-410c, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* dragonboard-410c, kselftest-memfd
  - memfd_memfd_test

* fvp-aemva, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* fvp-aemva, kselftest-memfd
  - memfd_memfd_test

* i386, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* i386, kselftest-memfd
  - memfd_memfd_test

* juno-r2, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* juno-r2, kselftest-memfd
  - memfd_memfd_test

* qemu-arm64, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* qemu-arm64, kselftest-memfd
  - memfd_memfd_test

* qemu-armv7, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* qemu-i386, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* qemu-i386, kselftest-memfd
  - memfd_memfd_test

* qemu-x86_64, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* qemu-x86_64, kselftest-memfd
  - memfd_memfd_test

* qemu_i386, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* qemu_i386, kselftest-memfd
  - memfd_memfd_test

* qemu_x86_64, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* qemu_x86_64, kselftest-memfd
  - memfd_memfd_test

* x15, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* x15, kselftest-rseq
  - rseq_basic_test

* x15, ltp-commands
  - mkfs01_ntfs_sh

* x86, kselftest-kvm
  - kvm_hyperv_features
  - kvm_xapic_state_test

* x86, kselftest-membarrier
  - membarrier_membarrier_test_multi_thread
  - membarrier_membarrier_test_single_thread

* x86, kselftest-memfd
  - memfd_memfd_test

* x86, kselftest-rseq
  - rseq_basic_test
  - rseq_run_param_test_sh

* x86-kasan, ltp-commands
  - mkfs01_ntfs_sh


## Metric Regressions (compared to v6.1.28)

## Test Fixes (compared to v6.1.28)

## Metric Fixes (compared to v6.1.28)

## Test result summary
total: 161145, pass: 139501, fail: 3428, skip: 17949, xfail: 267

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 151 total, 150 passed, 1 failed
* arm64: 54 total, 53 passed, 1 failed
* i386: 41 total, 38 passed, 3 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 16 total, 15 passed, 1 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 46 total, 46 passed, 0 failed

## Test suites summary
* boot
* fwts
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
* kselftest-livepatch
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
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
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
* vdso

--
Linaro LKFT
https://lkft.linaro.org
