Return-Path: <linux-kselftest+bounces-35123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F11ADB7D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 19:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC433B67C2
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82033288C29;
	Mon, 16 Jun 2025 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KD9JUpA9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7309286408
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750095165; cv=none; b=mM/n6lXvwS4rz+e2nfkrQvLRN7DbkDNpo5uDdVITZ6LfP63m3PtXxIkneaW0xr8ujpTogyZHZRXv2eJ5lO1JtkultjS7lqJoXjzS4vgHdYFdGCLp/CMDO3mgJWH+x0huXzomEU02wzqT3QevaDYgbVJoLmNINA8vnTGK9AD0mVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750095165; c=relaxed/simple;
	bh=Q7Ges5P1PVYHwy+iNtt6pxwf3UmEQp/AJtPeqBac0pA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bxK7256QW7MQO0+Nr94p7sXKmLmOGrWd9ok81Euo6m/dAHsCuylBDgGnbpnGakifj0xM40ThqZHOTnRfkBKaDQwvkzWi8uOpescONJUT0DQugWT2U/GY+YvwP/FOH0Ipilbsm4HzNCzjfvyXNKI8NQK+Y04gtkobhpfqFLqDqBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KD9JUpA9; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-87f30519147so261360241.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 10:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750095162; x=1750699962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ynk8wNhlj9yzC6y9Kpo/JK+rurY2Maqm6+QVk7hFPII=;
        b=KD9JUpA9mU5T9+IPv4qf4Y0mK+ihja9bcrgjWXQ5DGGjo9dLP+wJvyeqK/qEbrBPpV
         xf+a/4Q1G4guro6prBKcvz6KQ1zQ+p2vecON5DLsOoDwFlroQABOFGok1ud6X2413pK8
         EuUZ6SkeMOIzVAHF3ftuOhm/HsDgn8kaJDVlAr6guWPdsMbR5ZrJIgZSWRywyc6N/+Q+
         c2jF3e+mdd8OpwjMFkLPktRmFZOXQLKRGb9HwejKhVMeLkH75SYyJrCZmffnDiuihnw0
         +ZUjbY2ZUtA8U5TQE/tME4kno3dGZvww3kQV8HnUJZiv3Id7v9xiZuQ+s2OiliBYSr9K
         FoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750095162; x=1750699962;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynk8wNhlj9yzC6y9Kpo/JK+rurY2Maqm6+QVk7hFPII=;
        b=SgfXUOtGukkM1Rl29MIUONbUovFeU10mrhccdxnOraxf2dU7grjUHDL4123jyTiDwn
         BUmDlo5ghtt4vMGOCOpBWFE3n31QQg/PX30cbx3wSfJihD8+V2y9N3dUz0Kpk5HAEKmI
         tZApBIMbqb0U+A/20tosFOimxusFQDsPqE9lYm4Xntzneyth1CdKI8bQERC5dZ3jNVmx
         4eo0DRoBIBtqXRP8G1ZfMhqNCcwL3gxw4xVKqtfPlxqJ60mE1u+q11GDfBR5n4Ca3VdR
         eq7x9jXwe7RHtMqLyv40lu92p1RpJ2b4NCvflkAiZKGfjaiUPvlZZQYga3OKTq62Tglk
         Li+w==
X-Gm-Message-State: AOJu0Yy6boZoeXy/iXkJOZfkOml5STnGxWR0i8TF9ycXSDHZ1n/I9zf3
	rePKXbe9R49YmNt8gKwWEiYFTDbn+zhsc1t49OM7zdhXtbAOpZJvPW0HounVy9R+VOFWNNyRxNs
	VrgsIuamBfsJJaRgmizW04w37p+yoCMMPp31a8ghM1e5NcLzkwj/QBimKsA==
X-Gm-Gg: ASbGncuuGIZIj0MYaToSWW4H22iQRFuUTapD8oOv0xb/FCDfiJPPiyTh9rePKiyFsDM
	+2wGHJEA+V2OqgXMcf+4ZhZ2Fzl5/ch/FB6WL72NNSt1u+BPRiWN+PpOG9GjLoNKcmqvVI5IG+n
	SkWUjFF3HISJsluxEqhi4AlzrfhE8fMkqnrTsv8l0Tx0PF/HlwQjbLREx5ER5Md0eMp8w5CBImW
	lCU
X-Google-Smtp-Source: AGHT+IHtQaJV3ItFaoD7sYxOhigOsQpCwUUKXe1/pzTGG14U4Q2oyXyV0Gt4uPDyhvzpx97Ct8N1h2Gb1D7zC0JZ1x8=
X-Received: by 2002:a05:6122:30a8:b0:531:2d3b:44d3 with SMTP id
 71dfb90a1353d-53148f33d17mr6217406e0c.0.1750095162234; Mon, 16 Jun 2025
 10:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 16 Jun 2025 23:02:28 +0530
X-Gm-Features: AX0GCFvvQJbkAKVmZhMTmTp-xwc52yagBdapT86oaeKvv4z6vLbcUy5yZzQCsI4
Message-ID: <CA+G9fYsqRYU31QyuXUxbcFT7586wyhSM_DFcdWeFJH=vwPcWJg@mail.gmail.com>
Subject: clang: selftests mm pkey_sighandler_tests.c warning duplicate
 'inline' declaration specifier [-Wduplicate-decl-specifier]
To: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	open list <linux-kernel@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, lorenzo.stoakes@oracle.com, 
	Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Keith Lucas <keith.lucas@oracle.com>, 
	aruna.ramakrishna@oracle.com, kevin.brodsky@arm.com, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings were noticed while building selftests/mm
with clang nightly toolchain for arm64 and x86_64 architectures.

Regressions found on arm64 and x86_64
  -  Build/clang-nightly-lkftconfig-kselftest

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: selftests mm pkey_sighandler_tests.c warning
duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]

Build regression: selftests mm mremap_test.c warning pointer
comparison always evaluates to false [-Wtautological-compare]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
make[4]: Entering directory '/builds/linux/tools/testing/selftests/mm'
/bin/sh ./check_config.sh clang --target=aarch64-linux-gnu
-fintegrated-as -Werror=unknown-warning-option
-Werror=ignored-optimization-argument -Werror=option-ignored
-Werror=unused-command-line-argument --target=aarch64-linux-gnu
-fintegrated-as
  CC       cow
  CC       compaction_test
  CC       gup_longterm
  CC       gup_test
  CC       hmm-tests
  CC       hugetlb-madvise
  CC       hugetlb-read-hwpoison
  CC       hugetlb-soft-offline
  CC       hugepage-mmap
  CC       hugepage-mremap
  CC       hugepage-shm
  CC       hugepage-vmemmap
  CC       khugepaged
  CC       madv_populate
  CC       map_fixed_noreplace
  CC       map_hugetlb
  CC       map_populate
  CC       memfd_secret
  CC       migration
  CC       mkdirty
  CC       mlock-random-test
  CC       mlock2-tests
  CC       mrelease_test
  CC       mremap_dontunmap
  CC       mremap_test
mremap_test.c:425:31: warning: pointer comparison always evaluates to
false [-Wtautological-compare]
  425 |                 if (addr + c.dest_alignment < addr) {
      |                                             ^
1 warning generated.
  CC       mseal_test
  CC       on-fault-limit
  CC       pagemap_ioctl
  CC       pfnmap
  CC       thuge-gen
  CC       transhuge-stress
  CC       uffd-stress
  CC       uffd-unit-tests
  CC       uffd-wp-mremap
  CC       split_huge_page_test
  CC       ksm_tests
  CC       ksm_functional_tests
  CC       mdwe_test
  CC       hugetlb_fault_after_madv
  CC       hugetlb_madv_vs_map
  CC       hugetlb_dio
  CC       droppable
  CC       guard-regions
  CC       merge
  CC       protection_keys
  CC       pkey_sighandler_tests
pkey_sighandler_tests.c:44:15: warning: duplicate 'inline' declaration
specifier [-Wduplicate-decl-specifier]
   44 | static inline __always_inline
      |               ^
/usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/include/sys/cdefs.h:424:26:
note: expanded from macro '__always_inline'
  424 | # define __always_inline __inline __attribute__ ((__always_inline__))
      |                          ^
1 warning generated.
  CC       va_high_addr_switch
  CC       virtual_address_range
  CC       write_to_hugetlbfs

Warning: missing Module.symvers, please have the kernel built first.
page_frag test will be skipped.

make[4]: Leaving directory '/builds/linux/tools/testing/selftests/mm'


## Source
* Kernel version: 6.16.0-rc2
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 050f8ad7b58d9079455af171ac279c4b9b828c11
* Git describe: next-20250616
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250616/
* Architectures: arm64, x86_64
* Toolchains: clang nightly
* Kconfigs: selftest/mm/config+defconfig+

## Build arm64
* Build log: https://qa-reports.linaro.org/api/testruns/28765515/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250616/log-parser-build-clang/clang-compiler-pkey_sighandler_tests_c-warning-duplicate-inline-declaration-specifier/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ya0viPHafKAe0u89drIv5fcwu2/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2ya0viPHafKAe0u89drIv5fcwu2/config


## Steps to reproduce on arm64
 - tuxmake --runtime podman --target-arch arm64 --toolchain clang-20  \
   --kconfig defconfig  \
   --kconfig-add
https://gitlab.com/Linaro/lkft/kernel-fragments/-/raw/main/netdev.config
\
   --kconfig-add
https://gitlab.com/Linaro/lkft/kernel-fragments/-/raw/main/systemd.config
\
   --kconfig-add CONFIG_SYN_COOKIES=y   \
   --kconfig-add CONFIG_SCHEDSTATS=y LLVM=1 LLVM_IAS=1 debugkernel
dtbs dtbs-legacy headers kernel kselftest modules

--
Linaro LKFT
https://lkft.linaro.org

