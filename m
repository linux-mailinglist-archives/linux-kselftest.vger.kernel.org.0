Return-Path: <linux-kselftest+bounces-39715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C991B321E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 20:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B60FAE02EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 18:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FFF29ACC0;
	Fri, 22 Aug 2025 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="bowIBjw1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB6B661
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885602; cv=none; b=rxycrTvj779bqlqP9rpexoen1DScYeLg0YbQ9LLa+bSInoUSEbrZLBIrV3WMmN4hBddtSAXTkr6leGyvIDxBgTTKgBU3SB/rqDkL2gGNHZU0gvxIJcCJ5y2TFkD06Na/gUepcVEKwpo18q6Sh+iSjD3ZGQ7HkJOflf+lgAOdIvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885602; c=relaxed/simple;
	bh=QjGUX/IavHKYnweyZiQnCgeIEp0Qa7sid7tkHYHTpno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJjc+D8Nz9Z+ARhiiH11//ImOrn2GfuN3aKB0qzkd0QdvLVWZgd77E0zxTpkQTyZ+2nRHAJUWk+u4Z++15XnZtk8qP8pb6QupKmcxV1tR62156SDWHDuvkM3BF1vFFMFn7V6WrxuB4Vl5oaReR1X7kYvKANQxJltAQOAbwm3lhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=bowIBjw1; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-53b173717beso863840e0c.1
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755885598; x=1756490398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9fNzpGQYiY8hUTovQusQUuPvFziC263n9KoSaKQGOM=;
        b=bowIBjw14hcCMcXEFQelP3F/IgxTFZDchFVES0znmztlohD5OqknGtwUauveTSnrWI
         d+g9ASlXmk6+S6w0s3lsxdo6K/nufGMQFXIZwbw9iynSEugqPGnB9tqXpw0Hcih9Onui
         iijzOiiuMaPBArTtbShD9NF713MkistmOXciz2PZKEmS10o7BfeUpLVebc5fgDvwRzKP
         xg2jY+GCeh9VBOPo2w7FXx5csbaTRSS94Be+Y1ueb3eVtMPtYQMLwwwYnbRwA83bIx5T
         3xrWnQYIygkpgtWfsU2DBLyYmw2+EVYgNGEEnHrWCUL7dgBJzqPflfVugdJwqWJfRBi2
         TVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755885598; x=1756490398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9fNzpGQYiY8hUTovQusQUuPvFziC263n9KoSaKQGOM=;
        b=YiwotNCopUzZxVXvx2x0Zl9ZVjwHT8bIZn5l5QOAiWNcaRkw3M9z6mpLSgpt1SjRdY
         LQEPaaJ2tETP5s8YknBXcm6JxBSmYDKg2tTT0gj6M5OQARRmLV581A+gvmnS5u0jstHK
         3RexpMP/dzfwZC0gAgKbAY85ByLLmwk8uohhi+JdOVfHAH7Bc+V3yISegtndiBDOkzC3
         ZiVG5sSKpq+UD+YR3vbmfBIOPEXgsJqb+ddizH8Uwq3oEdx270+ta6yvUPjjci40NrMr
         gAu/D5r2XJviQgYxkriAG6fYqzlHFDrcebgAAi06iRHrgtTWr6RtgOR1vjR3h2iZSuCJ
         bo+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMjXWcdo2nn3gRIRMDz8w8FPykpLs4gKSUsEbnjv2Vs+KbMDYl5fk+MH7UWqOzNNB+3/ZUDeD+YkQUsjMLHvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycJWWZRnD4c6Qb/vvmSp0iWI5mkw1OVKdRsN9HDnmNx3HSAwV9
	hra0eRqTnN6YND7iAmXM2+HWGeoV2f0TzTkrOf3jF+PNgBZAPpU74LUcS/ccVD8JM43F9NLc0e8
	dJXSgExyk+6VD1eSph0lCRs4gwCPoc8jQDFFI8Y1UJA==
X-Gm-Gg: ASbGncvw+AWPVboGxEYfk1t3adHlQaYVMO1MUnf4xqtqtTz4zH1/bShgloKKdoeczbW
	wJOrROi3vb7dmUY5rtA7RqQAUEQwlzVXdJ/H86AvZFoPeYbfo87vWcEHYbWBARcuylX1Sj0iWOZ
	W7JMc5MLFpZcAqg1b3soTAEwOb9zZ6RdDGdZThLaUrcpd0tAPvYu/sC5CKIju1LmuiGNfIn7u/s
	msgOa27
X-Google-Smtp-Source: AGHT+IGn5vdUvXU42asTYKNQVZYOTWSFQylr/vzhKnTrBq4lq3wiMD7MVYIp2kAGpgvKTA1X/43JEESbQNKODDhNtrQ=
X-Received: by 2002:a05:6122:2502:b0:539:27eb:ca76 with SMTP id
 71dfb90a1353d-53c8a2ea9admr1107586e0c.5.1755885598348; Fri, 22 Aug 2025
 10:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822174715.1269138-1-jesse@rivosinc.com>
In-Reply-To: <20250822174715.1269138-1-jesse@rivosinc.com>
From: Jesse Taube <jesse@rivosinc.com>
Date: Fri, 22 Aug 2025 10:59:47 -0700
X-Gm-Features: Ac12FXx85Q9pdAS3tmJucpDWbmumN5hD5YReh0RpBOKeYl8mPi6vXHz7zLBXbxM
Message-ID: <CALSpo=aQyb+E0HHDRoXs0f5vvxJtMpCA546ROkq0e3B-ur9QBg@mail.gmail.com>
Subject: Re: [PATCH 0/8] riscv: add initial support for hardware breakpoints
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, 
	Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Shuah Khan <shuah@kernel.org>, 
	Himanshu Chauhan <hchauhan@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Deepak Gupta <debug@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atishp@rivosinc.com>, Anup Patel <apatel@ventanamicro.com>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, Evan Green <evan@rivosinc.com>, 
	WangYuli <wangyuli@uniontech.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Nam Cao <namcao@linutronix.de>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Joel Granados <joel.granados@kernel.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Celeste Liu <coelacanthushex@gmail.com>, 
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Nylon Chen <nylon.chen@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 10:47=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> w=
rote:
>
> This patchset adds initial support for hardware breakpoints and
> watchpoints to the  RISC-V architecture. The framework is built on
> top of perf subsystem and SBI debug trigger extension.
>
> Currently following features are not supported and are in works:
>  - icount for single stepping
>  - Virtualization of debug triggers
>  - kernel space debug triggers
>
> The SBI debug trigger extension can be found at:
> https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-debug-=
triggers.adoc
>
> The Sdtrig ISA is part of RISC-V debug specification which can be
> found at:
> https://github.com/riscv/riscv-debug-spec
>
> based off the original RFC by Himanshu Chauhan here:
> https://lore.kernel.org/lkml/20240222125059.13331-1-hchauhan@ventanamicro=
.com/
>
> Second RFC by Jesse Taube here:
> https://lore.kernel.org/lkml/20250722173829.984082-1-jesse@rivosinc.com/
>
> Himanshu Chauhan (2):
>   riscv: Add SBI debug trigger extension and function ids
>   riscv: Introduce support for hardware break/watchpoints
>
> Jesse Taube (6):
>   riscv: Add insn.c, consolidate instruction decoding
>   riscv: insn: Add get_insn_nofault
>   riscv: hw_breakpoint: Use icount for single stepping
>   riscv: ptrace: Add hw breakpoint support
>   riscv: ptrace: Add hw breakpoint regset
>   selftests: riscv: Add test for hardware breakpoints
>
>  arch/riscv/Kconfig                            |   2 +
>  arch/riscv/include/asm/bug.h                  |  12 -
>  arch/riscv/include/asm/hw_breakpoint.h        |  59 ++
>  arch/riscv/include/asm/insn.h                 | 132 ++-
>  arch/riscv/include/asm/kdebug.h               |   3 +-
>  arch/riscv/include/asm/processor.h            |   4 +
>  arch/riscv/include/asm/sbi.h                  |  33 +-
>  arch/riscv/include/uapi/asm/ptrace.h          |   9 +
>  arch/riscv/kernel/Makefile                    |   2 +
>  arch/riscv/kernel/hw_breakpoint.c             | 763 ++++++++++++++++++
>  arch/riscv/kernel/insn.c                      | 165 ++++
>  arch/riscv/kernel/kgdb.c                      | 102 +--
>  arch/riscv/kernel/probes/kprobes.c            |   1 +
>  arch/riscv/kernel/process.c                   |   4 +
>  arch/riscv/kernel/ptrace.c                    | 169 ++++
>  arch/riscv/kernel/traps.c                     |  11 +-
>  arch/riscv/kernel/traps_misaligned.c          |  93 +--
>  include/uapi/linux/elf.h                      |   2 +
>  tools/include/uapi/linux/elf.h                |   1 +
>  tools/perf/tests/tests.h                      |   3 +-
>  tools/testing/selftests/riscv/Makefile        |   2 +-
>  .../selftests/riscv/breakpoints/.gitignore    |   1 +
>  .../selftests/riscv/breakpoints/Makefile      |  13 +
>  .../riscv/breakpoints/breakpoint_test.c       | 246 ++++++
>  24 files changed, 1641 insertions(+), 191 deletions(-)
>  create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
>  create mode 100644 arch/riscv/kernel/hw_breakpoint.c
>  create mode 100644 arch/riscv/kernel/insn.c
>  create mode 100644 tools/testing/selftests/riscv/breakpoints/.gitignore
>  create mode 100644 tools/testing/selftests/riscv/breakpoints/Makefile
>  create mode 100644 tools/testing/selftests/riscv/breakpoints/breakpoint_=
test.c
>
> --
> 2.43.0
>

Oops, this meant to be V2.

Thanks,
Jesse Taube

