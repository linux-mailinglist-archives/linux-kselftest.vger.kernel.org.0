Return-Path: <linux-kselftest+bounces-35122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B70ADB7CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 19:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2036816A2AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DD4288C8E;
	Mon, 16 Jun 2025 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zjTW3cwE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2E7288C36
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750095148; cv=none; b=BQ5kfE000Zj4oWMsHY0D90jXU5s4FmDjFhLVgFmPJ91mWDA6Z5EWk3dKuZWcV2oh7KfWBgR23a2LoeJBvp5gwTg3veLtQa/LkmygqBaKpwrEUg+dfqcMdh1L+CXwgV6VBiYgLLN9iS/sLBwpSmmB8gsYL83HRfQjVnIE1mzd99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750095148; c=relaxed/simple;
	bh=53oFqP2M2cmobE/ugaCFp+IPUxUA0YjUIe8mxp0VACQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IrGDFAqKw8/0Dx6XOSIReY8DPQgN6oceGFzlzARp7IhJRiEFGU4ETKCfCnZ9iUTwj1eJHIG1UlCByw4acA+4kCQIwt9bfLX6+29wb53ekViB6djuO9JX0H7JR3zWqyJfG4qKe5g7vpIrH0lQ8QQ4QT4bC4tz1lJZTjLnx1XGeqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zjTW3cwE; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-525b44b7720so1096779e0c.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 10:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750095146; x=1750699946; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nOL9B0ArRDJ2HgV9zgRwhBeaYRAdymIm6FiPuyILxyE=;
        b=zjTW3cwEO4K9E87KNylaz8MLGrbucnXeVTgeUxpXP0X1r8EurH66e+/6+tA/f58+gm
         Qx/Ck3CpiiklYNRlwQbV29pJ9y3WjxVugEW8R2wxWw6cIILpzq6qXjQU33h+1ztiORJu
         10wYQYwkE6F9gDA9A9Wl0myfUPr+LfaxI96b4Z16Jr9rsjV9XkNw+fziaKgFshBF4wz1
         cl00vuxGZzKhwieTThUbrwPYh1PPW0l4pGV939M73kWvegNdVK2cgRdlpbvmrzbFi2YY
         j3HRVepZHzHoU46FJja5XOKUfX0bLwiJy0SwD2ENbWk5Cj/qp96TWptNHqh3IRSlIwqw
         qPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750095146; x=1750699946;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nOL9B0ArRDJ2HgV9zgRwhBeaYRAdymIm6FiPuyILxyE=;
        b=aLkBpQHwWTrYHVlCjuvY735SDm8o+ygTenRHa028h2mhRfSlmA6gDHtyIGlKGEJBBU
         vyChAfMBGYNZCpTnyTaoAGr50vHzJ0olTIM5+o2ZupIli70Ijn500XwjxXjGM20CdBtf
         LDCkGylCKI+kuRPqHn7yyYazFNp59YX4dU5NM1WmgOyxkGqOGtLpS84J8rzs0Td3UWGT
         wYtLq40G8eMhwhLrTKcLM33xdfnGGyD8M2UXXVgSVlGwg0w5pC8JJj6aXgY29TfCOzKb
         N+84+caiMOvZIWCQBCVtba5HAaYBSmpXWsb+8X4oQ6pBmijiwwwP23LZSFXMW5XCoii6
         78lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQyih7slvMWRkTbrO2oEVQUI9vn0i4mKnKl+w+n4RhpGzM3c33gsv8pLCnKiHMTDA1NuGOluewr/RmYosKFmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVtsB4OR3D9+vx9yyI3EwKI9Ep5Vf0yTUD2ylDpYCSmy8w0Isz
	fvT3+gI2z+NI77qkyZ9vU/Hkyi9Weyr1QC6dD25uiq3ZZvn4vhz7IEL2E6kc+e1i+y9trLKwfRB
	kQMwTRKcWbWN59VoOIvHq+0w2H0qBFuzkql+QsiaV1w==
X-Gm-Gg: ASbGnctWeScomodqdB8K4XkwHYiAJDNh5dUAdIR/mWnXrS3Dn40eQqOIewWkZCJJTNb
	4MfY4M5kFP4e24OvLlh9n05pzT444Ir8ZDYdSQa301h1YW7MvATUkYayVy5o4gg0ZUju/BK/lDz
	9MgseLvgWlBIsCmXndUA5VWeSfr8YPU3WNWTVmG8YjjP7SxQl+cBEN063weWvw8CtMxqC/7Zs8p
	H0S
X-Google-Smtp-Source: AGHT+IHDbuGGx7FLDHd6SFF50nhpSRXNoX9Bm2Q2spE2ZR4tp7m+F74+pbpAxOfBAdUothMPOUPzPvXxKAsnmN6gtsw=
X-Received: by 2002:a05:6122:8c19:b0:516:18cd:c1fc with SMTP id
 71dfb90a1353d-531498af39fmr5799138e0c.8.1750095145850; Mon, 16 Jun 2025
 10:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 16 Jun 2025 23:02:14 +0530
X-Gm-Features: AX0GCFtIN6D4edi0dQDj2abPdHOYRSZcQmAsmVEcy9cnxJDmABW66gpRHqdgLtw
Message-ID: <CA+G9fYssELHcYKwgGNBMLrfeKZa9swGdLrH7gxqzd4P0kaOiZg@mail.gmail.com>
Subject: clang: selftests/mm gup_longterm error while loading shared libraries
 liburing.so.2 cannot open shared object file No such file or directory
To: clang-built-linux <llvm@lists.linux.dev>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>, lorenzo.stoakes@oracle.com, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"

The following test regressions noticed while running selftests/mm gup_longterm
test cases on Dragonboard-845c, Dragonboard-410c, rock-pi-4, qemu-arm64 and
qemu-x86_64 this build have required selftest/mm/configs included and toolchain
is clang nightly.

Regressions found on Dragonboard-845c, Dragonboard-410c, rock-pi-4,
qemu-arm64 and qemu-x86_64
  -  selftests mm gup_longterm fails

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Test regression: selftests mm gup_longterm error while loading shared
libraries liburing.so.2 cannot open shared object file No such file or
directory
Test regression: selftests mm cow error while loading shared libraries
liburing.so.2 cannot open shared object file No such file or directory
Test regression: selftests mm mlock-random-test exit=139
Test regression: selftests mm pagemap_ioctl exit=1
Test regression: selftests mm guard_regions file hole_punch

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test log
Linux version 6.15.0-next-20250606 (tuxmake@tuxmake) (Debian clang
version 21.0.0 (++20250602112323+c5a56f74fef7-1~exp1~20250602112342.1487),
Debian LLD 21.0.0) #1 SMP PREEMPT @1749190532

running ./gup_longterm
----------------------
./gup_longterm: error while loading shared libraries: liburing.so.2:
cannot open shared object file: No such file or directory
[FAIL]
 not ok 14 gup_longterm # exit=127

./cow: error while loading shared libraries: liburing.so.2: cannot
open shared object file: No such file or directory
[FAIL]
not ok 50 cow # exit=127

running ./mlock-random-test
---------------------------
TAP version 13
1..2
[  311.408456] traps: mlock-random-te[21661] general protection fault
ip:7f63210dbf0f sp:7ffdff6fca28 error:0 in
libc.so.6[adf0f,7f6321056000+165000]
[FAIL]
not ok 23 mlock-random-test # exit=139

running ./pagemap_ioctl

...
ok 53 Huge page testing: only two middle pages dirty
ok 54 # SKIP Hugetlb shmem testing: all new pages must not be written (dirty)
ok 55 # SKIP Hugetlb shmem testing: all pages must be written (dirty)
ok 56 # SKIP Hugetlb shmem testing: all pages dirty other than first
and the last one
ok 57 # SKIP Hugetlb shmem testing: PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC
ok 58 # SKIP Hugetlb shmem testing: only middle page dirty
ok 59 # SKIP Hugetlb shmem testing: only two middle pages dirty
ok 60 # SKIP Hugetlb mem testing: all new pages must not be written (dirty)
ok 61 # SKIP Hugetlb mem testing: all pages must be written (dirty)
ok 62 # SKIP Hugetlb mem testing: all pages dirty other than first and
the last one
ok 63 # SKIP Hugetlb mem testing: PM_SCAN_WP_MATCHING |
PM_SCAN_CHECK_WPASYNC[  241.731600] run_vmtests.sh (456): drop_caches:
3
ok 64 # SKIP Hugetlb mem testing: only middle page dirty
ok 65 # SKIP Hugetlb mem testing: only two middle pages dirty
Bail out! uffd-test creation failed 12 Cannot allocate memory
12 skipped test(s) detected. Consider enabling relevant config options
to improve coverage.
Planned tests != run tests (115 != 65)
Totals: pass:53 fail:0 xfail:0 xpass:0 skip:12 error:0
[FAIL]
# not ok 48 pagemap_ioctl # exit=1

running ./guard-regions
...
RUN           guard_regions.file.hole_punch ...
guard-regions.c:1905:hole_punch:Expected madvise(&ptr[3 * page_size],
4 * page_size, MADV_REMOVE) (-1) == 0 (0)
hole_punch: Test terminated by assertion
         FAIL  guard_regions.file.hole_punch
not ok 80 guard_regions.file.hole_punch


## Source
* Kernel version: 6.16.0-rc2
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 050f8ad7b58d9079455af171ac279c4b9b828c11
* Git describe: next-20250616
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250616/
* Architectures: arm64, x86_64
* Test environments: Dragonboard-845c, Dragonboard-410c,  rock-pi-4,
qemu-arm64, qemu-x86_64 and x86
* Toolchains: clang nightly
* Kconfigs: selftest/mm/config+defconfig+

## Test
* Test log: https://qa-reports.linaro.org/api/testruns/28766026/log_file/
* Test log 2: https://qa-reports.linaro.org/api/testruns/28743077/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250616/kselftest-mm/mm_run_vmtests_sh_gup_longterm/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ya0viPHafKAe0u89drIv5fcwu2/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2ya0viPHafKAe0u89drIv5fcwu2/config


## Steps to reproduce
  - tuxrun \
   --runtime podman \
   --device qemu-x86_64 \
   --boot-args rw  \
   --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2ya0wmVl0eHb9koWyQYC7myXjpX/bzImage
\
   --rootfs https://storage.tuxboot.com/debian/20250605/trixie/amd64/rootfs.ext4.xz
\
   --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2ya0wmVl0eHb9koWyQYC7myXjpX/modules.tar.xz
/usr/ \
   --parameters MODULES_PATH=/usr/ \
   --parameters
SQUAD_URL=https://qa-reports.linaro.org//api/submit/lkft/linux-next-master/next-20250616/env/
\
   --parameters SKIPFILE=skipfile-lkft.yaml \
   --parameters
KSELFTEST=https://storage.tuxsuite.com/public/linaro/lkft/builds/2ya0wmVl0eHb9koWyQYC7myXjpX/kselftest.tar.xz
\
   --image docker.io/linaro/tuxrun-dispatcher:v1.2.2 \
   --tests kselftest-mm \
   --timeouts boot=15

--
Linaro LKFT
https://lkft.linaro.org

