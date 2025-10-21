Return-Path: <linux-kselftest+bounces-43654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 538D3BF5F49
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 13:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93E2B4E5FFE
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 11:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088472DF123;
	Tue, 21 Oct 2025 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgIsgCF6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF11DE4F1
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044948; cv=none; b=BykCFJ/RXDLNL6sZ2h5+JFbdyrffwnPFuVmq1aLSDYM2fsHJ0lBVL38mW1LMPmLSya/0YGz5rScsrKr5Xk+0WHPMp6cp2KueNu5PvKbU3PTvX05JWJJeNgu7caV+f1WKuh04WGwvWnKCk7PtkS1IfkoxDpf43CJw5/GSDfCHUSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044948; c=relaxed/simple;
	bh=0Jj/oz3j5238pHi/+PUT7w3mAJ0abt9UDzN0aejE3p4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=srtjgEQWL9mwrZJj8gzyRwHxj3+5uGacdk1+n8/575KgrUzTcO3758I3uVRqDsSueXT6G+7CdVoYfqGtmevOr9HfXtOKYi4xSZxRQgIMRpCTng1X670nPhOyy5Erh+WlWw8ac1bEj90eieO161AUwdsbj7/h5Tv4gHXDG2/+6ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DgIsgCF6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2698d47e776so40589315ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 04:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761044946; x=1761649746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=clvqVveEl4VakYM5nZd2uVSfls27BpwOnq3AhL7nZXs=;
        b=DgIsgCF6HAAgB51XcOkXw9wSe4kQSyViwQDQp0/M1NhrobdURa7+PNtmr/O9lKaZ3k
         2w1lD8jLkmwFFdW3y8v6E3F2+Lo983W0BIf6PHOs8zAvUaVy3/+kRuSE3DT0xiCauDWo
         NKRTvC+G7+IAO0pFur1WpUV+Z03HErhR7Fz3QFPk9tY8UIz0SheWGKkzbLnFgA8WhuSd
         PArn/e61Fzfb0OtOBf71aGfmvJ/FZCaW67aA4GkIJLSjEV0+QsJYlvjK/mkIQUWDTBTk
         JF2s4rlER2ynVr9myjCofPKLSL3zRhHyDDAAASzkLc8VnNt0JDxz281WDLJqygGhVupN
         FSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761044946; x=1761649746;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=clvqVveEl4VakYM5nZd2uVSfls27BpwOnq3AhL7nZXs=;
        b=Uw9Sb5eY2mYTWDFcOHaDMgpcN3xfuoKlvJGUsxKMnwEaZgK27FznGuvPi07hDRR8H7
         O+HdCe6n0xrcoZh146L3tJHJ3w1S9/TkjFsi/B/1W82lsNOw67+DCJus7N6rSHo4lcBo
         QUoe2b11QvQwWQYTO1OWklNlYkrvZn32NIc7Prz4nreIXorDNDpxU/GhOkYQYehD9TQD
         NQapQq8HJtymj/OjTEWKrGK7yWD9RL5+9Onq/pKbqK27K+QEbZZxSdlEAidACgogho1O
         6VsEGI7zYBEA/PqnQN+YWeGh4riyu89pwj/FO52jWY20/CUwhsMYfxkLyoLr0ilQp77e
         ymNA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ428JpNYaR/+VDJqhiHA9F6XeBznKv00WrIv5Qri5tOPFYGq5By4GZHYDokLRTAqSaxZ5w8wynTH3XUFj4WA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65SXJPYiPMxEuRW4ej5aebDDTMyERFJWmb3CK0sdCmQozhd6B
	mP7F8fRplYRzM/K40n1V2ehUE3X3p9DzzNr9oBN7p06nRPPvCPqIrPcMGd6pL3jtjn5oXkA48Ds
	GRAJtr8JTRjWh+WKgh7d4vMy+IyQI0uMj08La/BNWrxyUtcjjWos6uWc=
X-Gm-Gg: ASbGncucoDIX9Lc1Ns/5DBk3sEgBn+ttiqRdgG+91LEmDW4uFjjui/+sAP1Hl/yjB3N
	K3ydFDPKRYvcIsIJgwLE1J292mllCu0U/eE9Ilk8oVNbTDpqUVVa6XpHknGOLonXTq+oSJeldhH
	eejGsUs2UENSk1P0/8LXD2wJFNNGVUpG44AoNdb5xLmL3kNdfxxxbkwuok3sMJK0YHK7MM7GCuy
	tWaTnZsNUazn+ahZ7lKmQrhIRjLQI2l7AF7CkAJmhLaP2jKGZT2rjK/UYZ7KxTdLZp9EF8MrgoN
	pwXvMX4YoS3qqRhoqwA4RoXyHH+Q9foe4pdsKprtfCAdfFOxonj2hiy4ChmOWpcnFahI
X-Google-Smtp-Source: AGHT+IFDGXUp9tKVVOyQcA7+CvoT4bVfCCGV2+qBmOVEr+wXy9Mo7bFJyDSAnV0yMljTfotevCIwB/WqStf9CbjQvMw=
X-Received: by 2002:a17:903:4407:b0:27e:ef27:1e52 with SMTP id
 d9443c01a7336-290ca1218dfmr195009785ad.35.1761044946535; Tue, 21 Oct 2025
 04:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 21 Oct 2025 16:38:55 +0530
X-Gm-Features: AS18NWCNxSm7rurPtBIV1Ywyd2Z1uJw_dWK2NUhN3UHurWzm1qYuCb5CL-5txYM
Message-ID: <CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8PDdz2-EEQd=Q@mail.gmail.com>
Subject: next-20251020: selftests: helpers.h:10:10: fatal error: kselftest.h:
 No such file or directory
To: X86 ML <x86@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>, 
	"BALAVIGNESH #" <reddybalavignesh9979@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The selftests x86_64 builds failed due to following build warnings / errors
on the Linux next-20251020 and next-20251021 tags with gcc-14 and clang-21.

First seen on next-20251020
Good: next-20251020
Bad: next-20251017

Regression Analysis:
- New regression? yes
- Reproducibility? yes

### Build errors
x86_64-linux-gnu-gcc -m64 -o kselftest/x86/single_step_syscall_64 -O2
-g -std=gnu99 -pthread -Wall -isystem usr/include -no-pie
-DCAN_BUILD_64 single_step_syscall.c  -lrt -ldl
In file included from single_step_syscall.c:34:
helpers.h:10:10: fatal error: kselftest.h: No such file or directory
   10 | #include "kselftest.h"
      |          ^~~~~~~~~~~~~
compilation terminated.
make[4]: *** [Makefile:86: kselftest/x86/single_step_syscall_64] Error 1

### Suspected patch
  git log --oneline   next-20251017..next-20251020  --
tools/testing/selftests/x86/
  4d89827dfb274 selftests: complete kselftest include centralization

Build regressions: next-20251020: selftests: helpers.h:10:10: fatal
error: kselftest.h: No such file or directory

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

### Steps to reproduce
  - tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-14 \
     --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/34JgN0fZ9uXj6HVnjvjqzIhgWbQ/config
\
     debugkernel cpupower headers kernel kselftest modules

## Source
* Kernel version: 6.18.0-rc2
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20251021 and next-20251020
* Git commit: fe45352cd106ae41b5ad3f0066c2e54dbb2dfd70
* Architectures: x86_64
* Toolchains: gcc-14 and clang-21
* Kconfigs: defconfig+selftests/*/configs

## Build
* Build log: https://storage.tuxsuite.com/public/linaro/lkft/builds/34JgN0fZ9uXj6HVnjvjqzIhgWbQ/build.log
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20251020/kselftest-x86/x86_avx_64/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34JgN0fZ9uXj6HVnjvjqzIhgWbQ/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/34JgN0fZ9uXj6HVnjvjqzIhgWbQ/config

--
Linaro LKFT
https://lkft.linaro.org

