Return-Path: <linux-kselftest+bounces-30155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8E2A7C7D9
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Apr 2025 08:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0753C17C37F
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Apr 2025 06:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B52A1C5D70;
	Sat,  5 Apr 2025 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zxtVHvYq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C0E1ADC7C
	for <linux-kselftest@vger.kernel.org>; Sat,  5 Apr 2025 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743834076; cv=none; b=quNwigydGwlsz8QI62y60noQtJtcL4Ra5L6QU6JkMu+DZCDypKrZ3P9A85VP3v1W6EeEykvh8NK6RElSM3RtE8dF/bUcmD+8KAvfuTkejKsiAq1bZ6WE/yZkWJ5gOinkjbSBSrgpRVo5KU5ZjkV8j7pQwmV8tke800J+eXi/lFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743834076; c=relaxed/simple;
	bh=7ogc9KoTqihDm0BSPWxVNdwPASqfsI9zHNcq7KvFYk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBaCYQD56PPUG3etMZ3zuS0O3OJyUdNz739KlWD5GAnwN3xd4rv4UNoL5zAqCxmhPJLt2fhaNP5UE2aemPT1lcvDld9Jc9srOMZ9X5AxKk/UZIeBRiSbAeQfLCvLK9DXuYuDBRGznJK0paLjq/IyapWK9lstoL7rJmzzTcYh3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zxtVHvYq; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-525b44b7720so1267590e0c.0
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Apr 2025 23:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743834072; x=1744438872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=25wsr6cWnXWcVgGRjI/IcnvMayo89bRxfKsHC6L0fgU=;
        b=zxtVHvYqAttGEk4mTt+W9Xf4vl7YDMPg9EULhF+xxNKiUBEFcWanJdUOOOoRSPgu2D
         TtjDPUHm+bkf6BDrS7Y6eWQYzxDhNM9Ch24xXrKzNaPh2baYsHANfki0dZI/M69rx4v9
         btBj6dTWApl9kjqAAYoGCsdmanj/Ypc+9EH81tyG+ydD2q5aN2O0lYo0OEUaQYxPImvV
         GT8y/kGSX6HuzPybrdTCBmTF/cbZZENMRtrUf2kVhLwRWwUjA3TSEFJ/6WVVlr01xouq
         M7rSyY/AjGCxACyIS9LeX9oWQGl73QcmPZYj9Xt9H9b3DSrX/CbGU5Vxbq2SgJ9XV/Ko
         ipcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743834072; x=1744438872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25wsr6cWnXWcVgGRjI/IcnvMayo89bRxfKsHC6L0fgU=;
        b=lL5Is2c9hn9nYzToV6FgZdteWvlB6yJIi0H9/F6qfSdfQKhT1WgnmajH+wvYzeWmRw
         MQ+q+QzaN+k3kwNRrariAKaHcpYQC3R2NFJLK90L8NP1mR1/bWC1jjGA+prgxKZRDFjz
         IP7O1VQGYRpZu5u+EFd0xjpBl2IkBOSshhuE+IpoyZCxgYQUGGESeZtAMsp617aJa1Pz
         ihNuRFiB0ylf6wvJvsHpEDbv7wEagbWfhrBetka4LIEfRZQpFysymQ8o2U58JTiQfNfP
         NhPyq2M7cmJa+dAiqzT9jYlax9lmEVsxkP64yZBGF42BMaWhpl/HDpYGg++DrXK05MoS
         zcdA==
X-Forwarded-Encrypted: i=1; AJvYcCX7LgSS3joQapmmT9u438kxAw4opcv/Bn8rZbkdT72x5aT7B1WFNfaXW8jtRWQXw+xQsGNd1qgw58Xqv4hOGwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFb+sbl8NpfS76jGFUltJPfJyMHUE9/nOmXEG/5FqlnEnthMQD
	9EwZNwt9aH/OhYM1Mzd3PpTTLsfRXQzfBNkw4a58sDgLBenPXD77eQmY2LrrG065Oi48wbXBqPt
	XxzeF9CVVc+WNB35Jz6845maFFyNqEmRablVwag==
X-Gm-Gg: ASbGnctqt4HaHSRBxoMFT+/IggOj0PeV6u9vZIXsOa9E54owvp0EYCwGTBKo5A+N3Pn
	K9tKWHMP7lVoTBLzKaoKE9hdlvmbHZj4VtAoTYxpRifjZ6C/vQ5/xOm+h108y7cAIkXrUVLtYCf
	pLjlAIyayMTVVQjdZtBIKcbounYfm62fJTVlDadJJlLRJ5UoEJrvZ1YkRa6UZUtbfUqBrtDMs=
X-Google-Smtp-Source: AGHT+IEv9iWYa+WC0bcktoDP+5vlokhZ9KA314M4SO+JtnfF49cPfNgs9Auth64ZNoxOmETRSkIwFtyc5YfVDr+m+sE=
X-Received: by 2002:a05:6122:17a7:b0:526:19e6:fa34 with SMTP id
 71dfb90a1353d-5276443fbf8mr3881721e0c.1.1743834072078; Fri, 04 Apr 2025
 23:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403151622.273788569@linuxfoundation.org>
In-Reply-To: <20250403151622.273788569@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 5 Apr 2025 11:50:59 +0530
X-Gm-Features: ATxdqUFa79ZEOWI_jWtdqZsuM0-WuEEPMkgxAHV30cmqug45NOw5y4qIqAXuxtc
Message-ID: <CA+G9fYvPdt8CETb7cDmraiZPpG3YX83en8SKO4ac+-83TQY_pQ@mail.gmail.com>
Subject: Re: [PATCH 6.13 00/23] 6.13.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, clang-built-linux <llvm@lists.linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Apr 2025 at 20:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.10 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Regressions on arm, arm64 and x86_64.

1)
The selftests rseq failed across the boards and virtual environments.
These test failures were also noticed on Linux mainline and next.

We will bisect these lists of regressions and get back to you.

* kselftest-rseq
  - rseq_basic_percpu_ops_mm_cid_test
  - rseq_basic_percpu_ops_test
  - rseq_basic_test
  - rseq_param_test
  - rseq_param_test_benchmark
  - rseq_param_test_compare_twice
  - rseq_param_test_mm_cid
  - rseq_param_test_mm_cid_benchmark
  - rseq_param_test_mm_cid_compare_twice

2)
 The clang-nightly build issues reported on mainline and next.

* S390, powerpc, build
  - clang-nightly-defconfig
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing

 clang-nightly: ERROR: modpost: "wcslen" [fs/smb/client/cifs.ko] undefined!
  - https://lore.kernel.org/all/CA+G9fYuQHeGicnEx1d=XBC0p1LCsndi5q0p86V7pCZ02d8Fv_w@mail.gmail.com/

3)
 The clang-nightly boot regressions with no console output have been
 reported on mainline and next.

* boot
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-kselftest
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing
  - gcc-13-lkftconfig-debug

  v6.14-12245-g91e5bfe317d8: Boot regression: rk3399-rock-pi-4b
dragonboard-410c dragonboard-845c no console output
  - https://lore.kernel.org/all/CA+G9fYve7+nXJNoV48TksXoMeVjgJuP8Gs=+1br+Qur1DPWV4A@mail.gmail.com/

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.13.10-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 8cbfaadfa0ec371208123554d6ad9994433929bb
* git describe: v6.13.7-385-g8cbfaadfa0ec
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.7-385-g8cbfaadfa0ec

## Test Regressions (compared to v6.13.7-362-g3d21aad34dfa)
* arm, build
  - clang-nightly-nhk8815_defconfig

* arm64, build
  - clang-nightly-allyesconfig

* dragonboard-410c, boot
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-kselftest
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing

* dragonboard-845c, boot
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-kselftest
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing
  - gcc-13-lkftconfig-debug

* e850-96, boot
  - clang-nightly-lkftconfig-kselftest

* fvp-aemva, boot
  - clang-nightly-lkftconfig-kselftest

* juno-r2, boot
  - clang-nightly-lkftconfig-kselftest

* dragonboard-410c, kselftest-rseq
  - rseq_basic_percpu_ops_mm_cid_test
  - rseq_basic_percpu_ops_test
  - rseq_basic_test
  - rseq_param_test
  - rseq_param_test_benchmark
  - rseq_param_test_compare_twice
  - rseq_param_test_mm_cid
  - rseq_param_test_mm_cid_benchmark
  - rseq_param_test_mm_cid_compare_twice

* dragonboard-845c, kselftest-rseq
  - rseq_basic_percpu_ops_mm_cid_test
  - rseq_basic_percpu_ops_test
  - rseq_basic_test
  - rseq_param_test
  - rseq_param_test_benchmark
  - rseq_param_test_compare_twice
  - rseq_param_test_mm_cid
  - rseq_param_test_mm_cid_benchmark
  - rseq_param_test_mm_cid_compare_twice

* e850-96, kselftest-rseq
  - rseq_basic_percpu_ops_mm_cid_test
  - rseq_basic_percpu_ops_test
  - rseq_basic_test
  - rseq_param_test
  - rseq_param_test_benchmark
  - rseq_param_test_compare_twice
  - rseq_param_test_mm_cid
  - rseq_param_test_mm_cid_benchmark
  - rseq_param_test_mm_cid_compare_twice

* powerpc, build
  - clang-nightly-defconfig
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing
  - clang-nightly-ppc64e_defconfig

* qemu-arm64, kselftest-rseq
  - rseq_basic_percpu_ops_mm_cid_test
  - rseq_basic_percpu_ops_test
  - rseq_basic_test
  - rseq_param_test
  - rseq_param_test_benchmark
  - rseq_param_test_compare_twice
  - rseq_param_test_mm_cid
  - rseq_param_test_mm_cid_benchmark
  - rseq_param_test_mm_cid_compare_twice

* qemu-i386, kselftest-rseq
  - rseq_basic_percpu_ops_mm_cid_test
  - rseq_basic_percpu_ops_test
  - rseq_param_test
  - rseq_param_test_benchmark
  - rseq_param_test_compare_twice
  - rseq_param_test_mm_cid
  - rseq_param_test_mm_cid_benchmark
  - rseq_param_test_mm_cid_compare_twice
  - shardfile-rseq

* qemu-x86_64, kselftest-rseq
  - rseq_basic_percpu_ops_mm_cid_test
  - rseq_basic_percpu_ops_test
  - rseq_basic_test
  - rseq_param_test
  - rseq_param_test_benchmark
  - rseq_param_test_compare_twice
  - rseq_param_test_mm_cid
  - rseq_param_test_mm_cid_benchmark
  - rseq_param_test_mm_cid_compare_twice

* rk3399-rock-pi-4b, boot
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-kselftest
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing

* s390, build
  - clang-nightly-defconfig
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing

* x86, kselftest-rseq
  - rseq_basic_percpu_ops_mm_cid_test
  - rseq_basic_percpu_ops_test
  - rseq_basic_test
  - rseq_param_test
  - rseq_param_test_benchmark
  - rseq_param_test_compare_twice
  - rseq_param_test_mm_cid
  - rseq_param_test_mm_cid_benchmark
  - rseq_param_test_mm_cid_compare_twice

* x86_64, build
  - clang-nightly-allyesconfig

## Metric Regressions (compared to v6.13.7-362-g3d21aad34dfa)

## Test Fixes (compared to v6.13.7-362-g3d21aad34dfa)

## Metric Fixes (compared to v6.13.7-362-g3d21aad34dfa)

## Test result summary
total: 125983, pass: 99795, fail: 7289, skip: 18899, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 136 passed, 3 failed
* arm64: 57 total, 56 passed, 1 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 40 total, 35 passed, 5 failed
* riscv: 25 total, 23 passed, 2 failed
* s390: 22 total, 18 passed, 4 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 49 total, 48 passed, 1 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-efivarfs
* kselftest-exec
* kselftest-fpu
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-rust
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-capability
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

