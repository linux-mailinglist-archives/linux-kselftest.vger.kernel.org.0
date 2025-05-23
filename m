Return-Path: <linux-kselftest+bounces-33665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBAAAC28F7
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 19:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9934B1BA3430
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 17:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B961C29825E;
	Fri, 23 May 2025 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wFCldTnS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD35298984
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748022156; cv=none; b=KlymkTGJIdjR7krenGixrYoVb3xQv6IwiQyqW2mkLBTp5Fflwtc6Eloc4A3rStr6xqaNwkEQ5KfKQ4Cch6Btzd3DCb149zoHVBmcqvJDWyaRov3Tyu+K9x1J3/SOrS3ifGPueJQbsKDJgLJlZEpYHj1z7Qpp8XOmAhIWVpPv8r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748022156; c=relaxed/simple;
	bh=9jiCxUVAwyY70Q188ndyJGVa6qTBQb/J/dQxowyTzYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxQ1xdNUnzsQ5jM+Z8+rIPC6o3Qk4fBW8Uo7PM0Hui4LcGjIlwx1+khAQizrnL0ea3WTcQBpBzL60IV0TJDKR/OkT8pKmPiFFBUYk7xOaUvBPQN+7glqnK0wAlo4hCfUfO6Je+ULHf6q3vQRK6NvM33YElw2EXUl8MYGp5JTZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wFCldTnS; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2320d06b728so1207205ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1748022152; x=1748626952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mel6TLnUXWO4rMDPVdcafANgjZH8JLsy2cnPGxWq4Z4=;
        b=wFCldTnScPxUj3uUGFg0P7lL9k3URKWSkHs6Ewg/bHACRoXNyTf89EBA2Q+Gu2BDJC
         +4Q+MEDwQLBEcQ5yMlA5olVMxotdFiz8pjnT5AAYuVI0pFKowqSg5/V0XourXRWlfu6h
         TR9UGdHjNg38UwMCCyYi5f0Cl/XPv3rSukdWBp1JaPCeqHDXQBnYnXhq2kt6/kWv7Kj7
         NysK0DvABE/LoWoQyCb8F6g1CMCEvrYdznnikbbb9T+2nFX2nBMGxuqPIdxfVwH4u1xB
         ENDM4OzWNSpvUOPPTathp4/V0iyq6CQ36LJLszXpXhRgmG5aFfzzYArIiq6ug6M+QBHd
         2coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748022152; x=1748626952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mel6TLnUXWO4rMDPVdcafANgjZH8JLsy2cnPGxWq4Z4=;
        b=dcJMu5dRjjujTNR7+GA6JW10GLSbMliS/zUrf2WQA/nHIxm4+XMeJ2aDVNSZomO5xL
         Fb2IEW0mUvMU2kXp8b1t37/Fil/RdqHea0a7f0cCYz8+315qPbJnoeRqWK0Z8lWb071+
         BBJ4wHb86lVUF+4bKN4Ir3y4uj+ZSytYC1iopcLHu1kGyxJ5C8RGS0sVTi+xI6eNrGRG
         ekwqn0RKetWjBRibHSVH9Rp8Z2zofzaTI5ob5d/QvRkEpvqeV2IzZ0qrtxtmDzWR+s2w
         Quv5ddDcO5GYEbWONMV7z9ONf7CCe5xW6m0Lo7EQM9bAtrpmJFiODTAQYwK4YU6GC5yc
         hV5w==
X-Forwarded-Encrypted: i=1; AJvYcCVNo+hwgV3O2hvkkBuLPDb+5RVxZlyM2RMA9HKLDjmDdRuN+al1l2r8aVVDkvXcFDPBK2xXg19lPojkp4Qtz50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpjo6w4f2eDL5xxaMub+225YFXqFNhayuu5jlqQE+GwnU2nVWY
	YFufPjLOVLHjMecAIjT+jeOPocP/LC5OYLt+cVydE0tcGUKCHlrILGCSgrchOCiyp6M=
X-Gm-Gg: ASbGncvnL4r9mRCNH3uEfa8TO2brqvle7L+bsmrpsnHX1ZS1iAbn9rfW4GUMyMCNL9M
	zTcZZDJjPyDUogNyCoC7zbf0E17CP/Rx5ha81xcIMqaOfqQs31d0oicfcIiJ4NrHfQXnZ12CJuk
	DzxZ34sr49ehw7dbp/i2O8cuYmKRRhUfa+8lNK0hcPBJjBukvScTDgTBfpyk6aklD6tSt4Jxh2D
	NYTuH9YKb0EIZAQOOhZjJ5pFvr18WEok2a7ywFi3q5cfojLzbT3lSb7EQ2IsmXSPPtV4AoL/6tJ
	1p9Iq0kuMBexAD7tC2IntTfy+lLJJqmSY12U6NXw1ATBu7Q=
X-Google-Smtp-Source: AGHT+IFC4CjDQzD2g3eMtniGUzTSXdlpS1IhtDFB76MnMOdP+PhHoqmOkyr5T7UhWwg0jTXBTO5SWQ==
X-Received: by 2002:a17:902:f691:b0:234:934:649f with SMTP id d9443c01a7336-23414f86f81mr3721425ad.28.1748022151998;
        Fri, 23 May 2025 10:42:31 -0700 (PDT)
Received: from ghost ([2601:647:6700:64d0:bb2c:c7d9:9014:13ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231e26d83c6sm122943455ad.47.2025.05.23.10.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 10:42:31 -0700 (PDT)
Date: Fri, 23 May 2025 10:42:27 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
	alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v16 27/27] kselftest/riscv: kselftest for user mode cfi
Message-ID: <aDCzgz-Ve9oLvPSF@ghost>
References: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
 <20250522-v5_user_cfi_series-v16-27-64f61a35eee7@rivosinc.com>
 <aDAwKVMGhY3p8-En@ghost>
 <aDAzJw52QY11YD1E@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDAzJw52QY11YD1E@ghost>

On Fri, May 23, 2025 at 01:34:47AM -0700, Charlie Jenkins wrote:
> On Fri, May 23, 2025 at 01:22:01AM -0700, Charlie Jenkins wrote:
> > On Thu, May 22, 2025 at 10:31:30PM -0700, Deepak Gupta wrote:
> > > Adds kselftest for RISC-V control flow integrity implementation for user
> > > mode. There is not a lot going on in kernel for enabling landing pad for
> > > user mode. cfi selftest are intended to be compiled with zicfilp and
> > > zicfiss enabled compiler. Thus kselftest simply checks if landing pad /
> > > shadow stack for the process are enabled or not and executes ptrace
> > > selftests on cfi. selftest then register a signal handler for SIGSEGV.
> > > Any control flow violation are reported as SIGSEGV with si_code =
> > > SEGV_CPERR. Test will fail on receiving any SEGV_CPERR. Shadow stack part
> > > has more changes in kernel and thus there are separate tests for that
> > > 
> > > - Exercise `map_shadow_stack` syscall
> > > - `fork` test to make sure COW works for shadow stack pages
> > > - gup tests
> > >   Kernel uses FOLL_FORCE when access happens to memory via
> > >   /proc/<pid>/mem. Not breaking that for shadow stack.
> > > - signal test. Make sure signal delivery results in token creation on
> > >   shadow stack and consumes (and verifies) token on sigreturn
> > > - shadow stack protection test. attempts to write using regular store
> > >   instruction on shadow stack memory must result in access faults
> > > - ptrace test: adds landing pad violation, clears ELP and continues
> > > 
> > > In case toolchain doesn't support cfi extension, cfi kselftest wont
> > > get built.
> > > 
> > > Test outut
> > > ==========
> > > 
> > > """
> > > TAP version 13
> > > 1..5
> > >   This is to ensure shadow stack is indeed enabled and working
> > >   This is to ensure shadow stack is indeed enabled and working
> > > ok 1 shstk fork test
> > > ok 2 map shadow stack syscall
> > > ok 3 shadow stack gup tests
> > > ok 4 shadow stack signal tests
> > > ok 5 memory protections of shadow stack memory
> > > """
> > > 
> > > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > > Suggested-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  tools/testing/selftests/riscv/Makefile             |   2 +-
> > >  tools/testing/selftests/riscv/cfi/.gitignore       |   3 +
> > >  tools/testing/selftests/riscv/cfi/Makefile         |  16 +
> > >  tools/testing/selftests/riscv/cfi/cfi_rv_test.h    |  82 +++++
> > >  tools/testing/selftests/riscv/cfi/riscv_cfi_test.c | 173 +++++++++
> > >  tools/testing/selftests/riscv/cfi/shadowstack.c    | 385 +++++++++++++++++++++
> > >  tools/testing/selftests/riscv/cfi/shadowstack.h    |  27 ++
> > >  7 files changed, 687 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
> > > index 099b8c1f46f8..5671b4405a12 100644
> > > --- a/tools/testing/selftests/riscv/Makefile
> > > +++ b/tools/testing/selftests/riscv/Makefile
> > > @@ -5,7 +5,7 @@
> > >  ARCH ?= $(shell uname -m 2>/dev/null || echo not)
> > >  
> > >  ifneq (,$(filter $(ARCH),riscv))
> > > -RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector
> > > +RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector cfi
> > >  else
> > >  RISCV_SUBTARGETS :=
> > >  endif
> > > diff --git a/tools/testing/selftests/riscv/cfi/.gitignore b/tools/testing/selftests/riscv/cfi/.gitignore
> > > new file mode 100644
> > > index 000000000000..82545863bac6
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/riscv/cfi/.gitignore
> > > @@ -0,0 +1,3 @@
> > > +cfitests
> > > +riscv_cfi_test
> > > +shadowstack
> > > diff --git a/tools/testing/selftests/riscv/cfi/Makefile b/tools/testing/selftests/riscv/cfi/Makefile
> > > new file mode 100644
> > > index 000000000000..55165a93845f
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/riscv/cfi/Makefile
> > > @@ -0,0 +1,16 @@
> > > +CFLAGS += -I$(top_srcdir)/tools/include
> > > +
> > > +CFLAGS += -march=rv64gc_zicfilp_zicfiss -fcf-protection=full
> > > +
> > > +ifeq ($(shell $(CC) $(CFLAGS) -nostdlib -xc /dev/null -o /dev/null > /dev/null 2>&1; echo $$?),0)
> > > +TEST_GEN_PROGS := cfitests
> > > +
> > > +include ../../lib.mk
> > 
> > I'm sorry, I just realized I messed up this patch :/. This line is
> > supposed to be above the ifeq line to get the proper definition of
> > $(CC).
> 
> Okay that doesn't work either, this does though.
> 
> From 8aacab45ca9a2402bd6b65e7f5d9529e0bcc184b Mon Sep 17 00:00:00 2001
> From: Charlie Jenkins <charlie@rivosinc.com>
> Date: Fri, 23 May 2025 01:32:52 -0700
> Subject: [PATCH] kselftest/riscv: Fix cfi selftests again
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  tools/testing/selftests/riscv/cfi/Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/riscv/cfi/Makefile b/tools/testing/selftests/riscv/cfi/Makefile
> index 55165a93845f..41dbb4a263e3 100644
> --- a/tools/testing/selftests/riscv/cfi/Makefile
> +++ b/tools/testing/selftests/riscv/cfi/Makefile
> @@ -2,6 +2,14 @@ CFLAGS += -I$(top_srcdir)/tools/include
> 
>  CFLAGS += -march=rv64gc_zicfilp_zicfiss -fcf-protection=full
> 
> +ifeq ($(LLVM),)
> +ifeq ($(CC),cc)
> +CC := $(CROSS_COMPILE)gcc
> +endif
> +else
> +CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) --target=riscv64-linux-gnu
> +endif
> +
>  ifeq ($(shell $(CC) $(CFLAGS) -nostdlib -xc /dev/null -o /dev/null > /dev/null 2>&1; echo $$?),0)
>  TEST_GEN_PROGS := cfitests
> 
> --
> 2.43.0

Okay another version... Also need to pull in the definitions of
LLVM_SUFFIX/LLVM_PREFIX

From 9f1eb1be3d1a26f394016de5513696147d2e9810 Mon Sep 17 00:00:00 2001
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 23 May 2025 01:32:52 -0700
Subject: [PATCH] kselftest/riscv: Fix cfi selftests again

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/testing/selftests/riscv/cfi/Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/riscv/cfi/Makefile b/tools/testing/selftests/riscv/cfi/Makefile
index 55165a93845f..d5600cbb8e32 100644
--- a/tools/testing/selftests/riscv/cfi/Makefile
+++ b/tools/testing/selftests/riscv/cfi/Makefile
@@ -2,6 +2,19 @@ CFLAGS += -I$(top_srcdir)/tools/include

 CFLAGS += -march=rv64gc_zicfilp_zicfiss -fcf-protection=full

+ifeq ($(LLVM),)
+ifeq ($(CC),cc)
+CC := $(CROSS_COMPILE)gcc
+endif
+else
+ifneq ($(filter %/,$(LLVM)),)
+LLVM_PREFIX := $(LLVM)
+else ifneq ($(filter -%,$(LLVM)),)
+LLVM_SUFFIX := $(LLVM)
+endif
+CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) --target=riscv64-linux-gnu
+endif
+
 ifeq ($(shell $(CC) $(CFLAGS) -nostdlib -xc /dev/null -o /dev/null > /dev/null 2>&1; echo $$?),0)
 TEST_GEN_PROGS := cfitests

--
2.43.0

> 
> > 
> > > +
> > > +$(OUTPUT)/cfitests: riscv_cfi_test.c shadowstack.c
> > > +	$(CC) -o$@ $(CFLAGS) $(LDFLAGS) $^
> > > +else
> > > +include ../../lib.mk
> > 
> > This include can be removed as well.
> > 
> > - Charlie
> > 
> > > +
> > > +$(shell echo "Toolchain doesn't support CFI, skipping CFI kselftest." >&2)
> > > +endif
> > > diff --git a/tools/testing/selftests/riscv/cfi/cfi_rv_test.h b/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
> > > new file mode 100644
> > > index 000000000000..1c8043f2b778
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
> > > @@ -0,0 +1,82 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +
> > > +#ifndef SELFTEST_RISCV_CFI_H
> > > +#define SELFTEST_RISCV_CFI_H
> > > +#include <stddef.h>
> > > +#include <sys/types.h>
> > > +#include "shadowstack.h"
> > > +
> > > +#define CHILD_EXIT_CODE_SSWRITE		10
> > > +#define CHILD_EXIT_CODE_SIG_TEST	11
> > > +
> > > +#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)			\
> > > +({									\
> > > +	register long _num  __asm__ ("a7") = (num);			\
> > > +	register long _arg1 __asm__ ("a0") = (long)(arg1);		\
> > > +	register long _arg2 __asm__ ("a1") = (long)(arg2);		\
> > > +	register long _arg3 __asm__ ("a2") = (long)(arg3);		\
> > > +	register long _arg4 __asm__ ("a3") = (long)(arg4);		\
> > > +	register long _arg5 __asm__ ("a4") = (long)(arg5);		\
> > > +									\
> > > +	__asm__ volatile(						\
> > > +		"ecall\n"						\
> > > +		: "+r"							\
> > > +		(_arg1)							\
> > > +		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),	\
> > > +		  "r"(_num)						\
> > > +		: "memory", "cc"					\
> > > +	);								\
> > > +	_arg1;								\
> > > +})
> > > +
> > > +#define my_syscall3(num, arg1, arg2, arg3)				\
> > > +({									\
> > > +	register long _num  __asm__ ("a7") = (num);			\
> > > +	register long _arg1 __asm__ ("a0") = (long)(arg1);		\
> > > +	register long _arg2 __asm__ ("a1") = (long)(arg2);		\
> > > +	register long _arg3 __asm__ ("a2") = (long)(arg3);		\
> > > +									\
> > > +	__asm__ volatile(						\
> > > +		"ecall\n"						\
> > > +		: "+r" (_arg1)						\
> > > +		: "r"(_arg2), "r"(_arg3),				\
> > > +		  "r"(_num)						\
> > > +		: "memory", "cc"					\
> > > +	);								\
> > > +	_arg1;								\
> > > +})
> > > +
> > > +#ifndef __NR_prctl
> > > +#define __NR_prctl 167
> > > +#endif
> > > +
> > > +#ifndef __NR_map_shadow_stack
> > > +#define __NR_map_shadow_stack 453
> > > +#endif
> > > +
> > > +#define CSR_SSP 0x011
> > > +
> > > +#ifdef __ASSEMBLY__
> > > +#define __ASM_STR(x)    x
> > > +#else
> > > +#define __ASM_STR(x)    #x
> > > +#endif
> > > +
> > > +#define csr_read(csr)							\
> > > +({									\
> > > +	register unsigned long __v;					\
> > > +	__asm__ __volatile__ ("csrr %0, " __ASM_STR(csr)		\
> > > +				: "=r" (__v) :				\
> > > +				: "memory");				\
> > > +	__v;								\
> > > +})
> > > +
> > > +#define csr_write(csr, val)						\
> > > +({									\
> > > +	unsigned long __v = (unsigned long)(val);			\
> > > +	__asm__ __volatile__ ("csrw " __ASM_STR(csr) ", %0"		\
> > > +				: : "rK" (__v)				\
> > > +				: "memory");				\
> > > +})
> > > +
> > > +#endif
> > > diff --git a/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c b/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
> > > new file mode 100644
> > > index 000000000000..486a2e779053
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
> > > @@ -0,0 +1,173 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +#include "../../kselftest.h"
> > > +#include <sys/signal.h>
> > > +#include <asm/ucontext.h>
> > > +#include <linux/prctl.h>
> > > +#include <errno.h>
> > > +#include <linux/ptrace.h>
> > > +#include <sys/wait.h>
> > > +#include <linux/elf.h>
> > > +#include <sys/uio.h>
> > > +#include <asm-generic/unistd.h>
> > > +
> > > +#include "cfi_rv_test.h"
> > > +
> > > +/* do not optimize cfi related test functions */
> > > +#pragma GCC push_options
> > > +#pragma GCC optimize("O0")
> > > +
> > > +void sigsegv_handler(int signum, siginfo_t *si, void *uc)
> > > +{
> > > +	struct ucontext *ctx = (struct ucontext *)uc;
> > > +
> > > +	if (si->si_code == SEGV_CPERR) {
> > > +		ksft_print_msg("Control flow violation happened somewhere\n");
> > > +		ksft_print_msg("PC where violation happened %lx\n", ctx->uc_mcontext.gregs[0]);
> > > +		exit(-1);
> > > +	}
> > > +
> > > +	/* all other cases are expected to be of shadow stack write case */
> > > +	exit(CHILD_EXIT_CODE_SSWRITE);
> > > +}
> > > +
> > > +bool register_signal_handler(void)
> > > +{
> > > +	struct sigaction sa = {};
> > > +
> > > +	sa.sa_sigaction = sigsegv_handler;
> > > +	sa.sa_flags = SA_SIGINFO;
> > > +	if (sigaction(SIGSEGV, &sa, NULL)) {
> > > +		ksft_print_msg("Registering signal handler for landing pad violation failed\n");
> > > +		return false;
> > > +	}
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +long ptrace(int request, pid_t pid, void *addr, void *data);
> > > +
> > > +bool cfi_ptrace_test(void)
> > > +{
> > > +	pid_t pid;
> > > +	int status, ret = 0;
> > > +	unsigned long ptrace_test_num = 0, total_ptrace_tests = 2;
> > > +
> > > +	struct user_cfi_state cfi_reg;
> > > +	struct iovec iov;
> > > +
> > > +	pid = fork();
> > > +
> > > +	if (pid == -1) {
> > > +		ksft_exit_fail_msg("%s: fork failed\n", __func__);
> > > +		exit(1);
> > > +	}
> > > +
> > > +	if (pid == 0) {
> > > +		/* allow to be traced */
> > > +		ptrace(PTRACE_TRACEME, 0, NULL, NULL);
> > > +		raise(SIGSTOP);
> > > +		asm volatile (
> > > +		"la a5, 1f\n"
> > > +		"jalr a5 \n"
> > > +		"nop \n"
> > > +		"nop \n"
> > > +		"1: nop\n"
> > > +		: : : "a5");
> > > +		exit(11);
> > > +		/* child shouldn't go beyond here */
> > > +	}
> > > +
> > > +	/* parent's code goes here */
> > > +	iov.iov_base = &cfi_reg;
> > > +	iov.iov_len = sizeof(cfi_reg);
> > > +
> > > +	while (ptrace_test_num < total_ptrace_tests) {
> > > +		memset(&cfi_reg, 0, sizeof(cfi_reg));
> > > +		waitpid(pid, &status, 0);
> > > +		if (WIFSTOPPED(status)) {
> > > +			errno = 0;
> > > +			ret = ptrace(PTRACE_GETREGSET, pid, (void *)NT_RISCV_USER_CFI, &iov);
> > > +			if (ret == -1 && errno)
> > > +				ksft_exit_fail_msg("%s: PTRACE_GETREGSET failed\n", __func__);
> > > +		} else
> > > +			ksft_exit_fail_msg("%s: child didn't stop, failed\n", __func__);
> > > +
> > > +		switch (ptrace_test_num) {
> > > +#define CFI_ENABLE_MASK (PTRACE_CFI_LP_EN_STATE |	\
> > > +			PTRACE_CFI_SS_EN_STATE |	\
> > > +			PTRACE_CFI_SS_PTR_STATE)
> > > +		case 0:
> > > +			if ((cfi_reg.cfi_status.cfi_state & CFI_ENABLE_MASK) != CFI_ENABLE_MASK)
> > > +				ksft_exit_fail_msg("%s: ptrace_getregset failed, %llu\n", __func__,
> > > +				cfi_reg.cfi_status.cfi_state);
> > > +			if (!cfi_reg.shstk_ptr)
> > > +				ksft_exit_fail_msg("%s: NULL shadow stack pointer, test failed\n",
> > > +				__func__);
> > > +			break;
> > > +		case 1:
> > > +			if (!(cfi_reg.cfi_status.cfi_state & PTRACE_CFI_ELP_STATE))
> > > +				ksft_exit_fail_msg("%s: elp must have been set\n", __func__);
> > > +			/* clear elp state. not interested in anything else */
> > > +			cfi_reg.cfi_status.cfi_state = 0;
> > > +
> > > +			ret = ptrace(PTRACE_SETREGSET, pid, (void *)NT_RISCV_USER_CFI, &iov);
> > > +			if (ret == -1 && errno)
> > > +				ksft_exit_fail_msg("%s: PTRACE_GETREGSET failed\n", __func__);
> > > +			break;
> > > +		default:
> > > +			ksft_exit_fail_msg("%s: unreachable switch case\n", __func__);
> > > +			break;
> > > +		}
> > > +		ptrace(PTRACE_CONT, pid, NULL, NULL);
> > > +		ptrace_test_num++;
> > > +	}
> > > +
> > > +	waitpid(pid, &status, 0);
> > > +	if (WEXITSTATUS(status) != 11)
> > > +		ksft_print_msg("%s, bad return code from child\n", __func__);
> > > +
> > > +	ksft_print_msg("%s, ptrace test succeeded\n", __func__);
> > > +	return true;
> > > +}
> > > +
> > > +int main(int argc, char *argv[])
> > > +{
> > > +	int ret = 0;
> > > +	unsigned long lpad_status = 0, ss_status = 0;
> > > +
> > > +	ksft_print_header();
> > > +
> > > +	ksft_print_msg("Starting risc-v tests\n");
> > > +
> > > +	/*
> > > +	 * Landing pad test. Not a lot of kernel changes to support landing
> > > +	 * pad for user mode except lighting up a bit in senvcfg via a prctl
> > > +	 * Enable landing pad through out the execution of test binary
> > > +	 */
> > > +	ret = my_syscall5(__NR_prctl, PR_GET_INDIR_BR_LP_STATUS, &lpad_status, 0, 0, 0);
> > > +	if (ret)
> > > +		ksft_exit_fail_msg("Get landing pad status failed with %d\n", ret);
> > > +
> > > +	if (!(lpad_status & PR_INDIR_BR_LP_ENABLE))
> > > +		ksft_exit_fail_msg("Landing pad is not enabled, should be enabled via glibc\n");
> > > +
> > > +	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_status, 0, 0, 0);
> > > +	if (ret)
> > > +		ksft_exit_fail_msg("Get shadow stack failed with %d\n", ret);
> > > +
> > > +	if (!(ss_status & PR_SHADOW_STACK_ENABLE))
> > > +		ksft_exit_fail_msg("Shadow stack is not enabled, should be enabled via glibc\n");
> > > +
> > > +	if (!register_signal_handler())
> > > +		ksft_exit_fail_msg("Registering signal handler for SIGSEGV failed\n");
> > > +
> > > +	ksft_print_msg("Landing pad and shadow stack are enabled for binary\n");
> > > +	cfi_ptrace_test();
> > > +
> > > +	execute_shadow_stack_tests();
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +#pragma GCC pop_options
> > > diff --git a/tools/testing/selftests/riscv/cfi/shadowstack.c b/tools/testing/selftests/riscv/cfi/shadowstack.c
> > > new file mode 100644
> > > index 000000000000..53387dbd9cf5
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/riscv/cfi/shadowstack.c
> > > @@ -0,0 +1,385 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +#include "../../kselftest.h"
> > > +#include <sys/wait.h>
> > > +#include <signal.h>
> > > +#include <fcntl.h>
> > > +#include <asm-generic/unistd.h>
> > > +#include <sys/mman.h>
> > > +#include "shadowstack.h"
> > > +#include "cfi_rv_test.h"
> > > +
> > > +static struct shadow_stack_tests shstk_tests[] = {
> > > +	{ "shstk fork test\n", shadow_stack_fork_test },
> > > +	{ "map shadow stack syscall\n", shadow_stack_map_test },
> > > +	{ "shadow stack gup tests\n", shadow_stack_gup_tests },
> > > +	{ "shadow stack signal tests\n", shadow_stack_signal_test},
> > > +	{ "memory protections of shadow stack memory\n", shadow_stack_protection_test }
> > > +};
> > > +
> > > +#define RISCV_SHADOW_STACK_TESTS ARRAY_SIZE(shstk_tests)
> > > +
> > > +/* do not optimize shadow stack related test functions */
> > > +#pragma GCC push_options
> > > +#pragma GCC optimize("O0")
> > > +
> > > +void zar(void)
> > > +{
> > > +	unsigned long ssp = 0;
> > > +
> > > +	ssp = csr_read(CSR_SSP);
> > > +	ksft_print_msg("Spewing out shadow stack ptr: %lx\n"
> > > +			"  This is to ensure shadow stack is indeed enabled and working\n",
> > > +			ssp);
> > > +}
> > > +
> > > +void bar(void)
> > > +{
> > > +	zar();
> > > +}
> > > +
> > > +void foo(void)
> > > +{
> > > +	bar();
> > > +}
> > > +
> > > +void zar_child(void)
> > > +{
> > > +	unsigned long ssp = 0;
> > > +
> > > +	ssp = csr_read(CSR_SSP);
> > > +	ksft_print_msg("Spewing out shadow stack ptr: %lx\n"
> > > +			"  This is to ensure shadow stack is indeed enabled and working\n",
> > > +			ssp);
> > > +}
> > > +
> > > +void bar_child(void)
> > > +{
> > > +	zar_child();
> > > +}
> > > +
> > > +void foo_child(void)
> > > +{
> > > +	bar_child();
> > > +}
> > > +
> > > +typedef void (call_func_ptr)(void);
> > > +/*
> > > + * call couple of functions to test push pop.
> > > + */
> > > +int shadow_stack_call_tests(call_func_ptr fn_ptr, bool parent)
> > > +{
> > > +	ksft_print_msg("dummy calls for sspush and sspopchk in context of %s\n",
> > > +		       parent ? "parent" : "child");
> > > +
> > > +	(fn_ptr)();
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/* forks a thread, and ensure shadow stacks fork out */
> > > +bool shadow_stack_fork_test(unsigned long test_num, void *ctx)
> > > +{
> > > +	int pid = 0, child_status = 0, parent_pid = 0, ret = 0;
> > > +	unsigned long ss_status = 0;
> > > +
> > > +	ksft_print_msg("Exercising shadow stack fork test\n");
> > > +
> > > +	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_status, 0, 0, 0);
> > > +	if (ret) {
> > > +		ksft_exit_skip("Shadow stack get status prctl failed with errorcode %d\n", ret);
> > > +		return false;
> > > +	}
> > > +
> > > +	if (!(ss_status & PR_SHADOW_STACK_ENABLE))
> > > +		ksft_exit_skip("Shadow stack is not enabled, should be enabled via glibc\n");
> > > +
> > > +	parent_pid = getpid();
> > > +	pid = fork();
> > > +
> > > +	if (pid) {
> > > +		ksft_print_msg("Parent pid %d and child pid %d\n", parent_pid, pid);
> > > +		shadow_stack_call_tests(&foo, true);
> > > +	} else {
> > > +		shadow_stack_call_tests(&foo_child, false);
> > > +	}
> > > +
> > > +	if (pid) {
> > > +		ksft_print_msg("Waiting on child to finish\n");
> > > +		wait(&child_status);
> > > +	} else {
> > > +		/* exit child gracefully */
> > > +		exit(0);
> > > +	}
> > > +
> > > +	if (pid && WIFSIGNALED(child_status)) {
> > > +		ksft_print_msg("Child faulted, fork test failed\n");
> > > +		return false;
> > > +	}
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +/* exercise `map_shadow_stack`, pivot to it and call some functions to ensure it works */
> > > +#define SHADOW_STACK_ALLOC_SIZE 4096
> > > +bool shadow_stack_map_test(unsigned long test_num, void *ctx)
> > > +{
> > > +	unsigned long shdw_addr;
> > > +	int ret = 0;
> > > +
> > > +	ksft_print_msg("Exercising shadow stack map test\n");
> > > +
> > > +	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
> > > +
> > > +	if (((long)shdw_addr) <= 0) {
> > > +		ksft_print_msg("map_shadow_stack failed with error code %d\n",
> > > +			       (int)shdw_addr);
> > > +		return false;
> > > +	}
> > > +
> > > +	ret = munmap((void *)shdw_addr, SHADOW_STACK_ALLOC_SIZE);
> > > +
> > > +	if (ret) {
> > > +		ksft_print_msg("munmap failed with error code %d\n", ret);
> > > +		return false;
> > > +	}
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +/*
> > > + * shadow stack protection tests. map a shadow stack and
> > > + * validate all memory protections work on it
> > > + */
> > > +bool shadow_stack_protection_test(unsigned long test_num, void *ctx)
> > > +{
> > > +	unsigned long shdw_addr;
> > > +	unsigned long *write_addr = NULL;
> > > +	int ret = 0, pid = 0, child_status = 0;
> > > +
> > > +	ksft_print_msg("Exercising shadow stack protection test (WPT)\n");
> > > +
> > > +	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
> > > +
> > > +	if (((long)shdw_addr) <= 0) {
> > > +		ksft_print_msg("map_shadow_stack failed with error code %d\n",
> > > +			       (int)shdw_addr);
> > > +		return false;
> > > +	}
> > > +
> > > +	write_addr = (unsigned long *)shdw_addr;
> > > +	pid = fork();
> > > +
> > > +	/* no child was created, return false */
> > > +	if (pid == -1)
> > > +		return false;
> > > +
> > > +	/*
> > > +	 * try to perform a store from child on shadow stack memory
> > > +	 * it should result in SIGSEGV
> > > +	 */
> > > +	if (!pid) {
> > > +		/* below write must lead to SIGSEGV */
> > > +		*write_addr = 0xdeadbeef;
> > > +	} else {
> > > +		wait(&child_status);
> > > +	}
> > > +
> > > +	/* test fail, if 0xdeadbeef present on shadow stack address */
> > > +	if (*write_addr == 0xdeadbeef) {
> > > +		ksft_print_msg("Shadow stack WPT failed\n");
> > > +		return false;
> > > +	}
> > > +
> > > +	/* if child reached here, then fail */
> > > +	if (!pid) {
> > > +		ksft_print_msg("Shadow stack WPT failed: child reached unreachable state\n");
> > > +		return false;
> > > +	}
> > > +
> > > +	/* if child exited via signal handler but not for write on ss */
> > > +	if (WIFEXITED(child_status) &&
> > > +	    WEXITSTATUS(child_status) != CHILD_EXIT_CODE_SSWRITE) {
> > > +		ksft_print_msg("Shadow stack WPT failed: child wasn't signaled for write\n");
> > > +		return false;
> > > +	}
> > > +
> > > +	ret = munmap(write_addr, SHADOW_STACK_ALLOC_SIZE);
> > > +	if (ret) {
> > > +		ksft_print_msg("Shadow stack WPT failed: munmap failed, error code %d\n",
> > > +			       ret);
> > > +		return false;
> > > +	}
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +#define SS_MAGIC_WRITE_VAL 0xbeefdead
> > > +
> > > +int gup_tests(int mem_fd, unsigned long *shdw_addr)
> > > +{
> > > +	unsigned long val = 0;
> > > +
> > > +	lseek(mem_fd, (unsigned long)shdw_addr, SEEK_SET);
> > > +	if (read(mem_fd, &val, sizeof(val)) < 0) {
> > > +		ksft_print_msg("Reading shadow stack mem via gup failed\n");
> > > +		return 1;
> > > +	}
> > > +
> > > +	val = SS_MAGIC_WRITE_VAL;
> > > +	lseek(mem_fd, (unsigned long)shdw_addr, SEEK_SET);
> > > +	if (write(mem_fd, &val, sizeof(val)) < 0) {
> > > +		ksft_print_msg("Writing shadow stack mem via gup failed\n");
> > > +		return 1;
> > > +	}
> > > +
> > > +	if (*shdw_addr != SS_MAGIC_WRITE_VAL) {
> > > +		ksft_print_msg("GUP write to shadow stack memory failed\n");
> > > +		return 1;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +bool shadow_stack_gup_tests(unsigned long test_num, void *ctx)
> > > +{
> > > +	unsigned long shdw_addr = 0;
> > > +	unsigned long *write_addr = NULL;
> > > +	int fd = 0;
> > > +	bool ret = false;
> > > +
> > > +	ksft_print_msg("Exercising shadow stack gup tests\n");
> > > +	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
> > > +
> > > +	if (((long)shdw_addr) <= 0) {
> > > +		ksft_print_msg("map_shadow_stack failed with error code %d\n", (int)shdw_addr);
> > > +		return false;
> > > +	}
> > > +
> > > +	write_addr = (unsigned long *)shdw_addr;
> > > +
> > > +	fd = open("/proc/self/mem", O_RDWR);
> > > +	if (fd == -1)
> > > +		return false;
> > > +
> > > +	if (gup_tests(fd, write_addr)) {
> > > +		ksft_print_msg("gup tests failed\n");
> > > +		goto out;
> > > +	}
> > > +
> > > +	ret = true;
> > > +out:
> > > +	if (shdw_addr && munmap(write_addr, SHADOW_STACK_ALLOC_SIZE)) {
> > > +		ksft_print_msg("munmap failed with error code %d\n", ret);
> > > +		ret = false;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +volatile bool break_loop;
> > > +
> > > +void sigusr1_handler(int signo)
> > > +{
> > > +	break_loop = true;
> > > +}
> > > +
> > > +bool sigusr1_signal_test(void)
> > > +{
> > > +	struct sigaction sa = {};
> > > +
> > > +	sa.sa_handler = sigusr1_handler;
> > > +	sa.sa_flags = 0;
> > > +	sigemptyset(&sa.sa_mask);
> > > +	if (sigaction(SIGUSR1, &sa, NULL)) {
> > > +		ksft_print_msg("Registering signal handler for SIGUSR1 failed\n");
> > > +		return false;
> > > +	}
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +/*
> > > + * shadow stack signal test. shadow stack must be enabled.
> > > + * register a signal, fork another thread which is waiting
> > > + * on signal. Send a signal from parent to child, verify
> > > + * that signal was received by child. If not test fails
> > > + */
> > > +bool shadow_stack_signal_test(unsigned long test_num, void *ctx)
> > > +{
> > > +	int pid = 0, child_status = 0, ret = 0;
> > > +	unsigned long ss_status = 0;
> > > +
> > > +	ksft_print_msg("Exercising shadow stack signal test\n");
> > > +
> > > +	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &ss_status, 0, 0, 0);
> > > +	if (ret) {
> > > +		ksft_print_msg("Shadow stack get status prctl failed with errorcode %d\n", ret);
> > > +		return false;
> > > +	}
> > > +
> > > +	if (!(ss_status & PR_SHADOW_STACK_ENABLE))
> > > +		ksft_print_msg("Shadow stack is not enabled, should be enabled via glibc\n");
> > > +
> > > +	/* this should be caught by signal handler and do an exit */
> > > +	if (!sigusr1_signal_test()) {
> > > +		ksft_print_msg("Registering sigusr1 handler failed\n");
> > > +		exit(-1);
> > > +	}
> > > +
> > > +	pid = fork();
> > > +
> > > +	if (pid == -1) {
> > > +		ksft_print_msg("Signal test: fork failed\n");
> > > +		goto out;
> > > +	}
> > > +
> > > +	if (pid == 0) {
> > > +		while (!break_loop)
> > > +			sleep(1);
> > > +
> > > +		exit(11);
> > > +		/* child shouldn't go beyond here */
> > > +	}
> > > +
> > > +	/* send SIGUSR1 to child */
> > > +	kill(pid, SIGUSR1);
> > > +	wait(&child_status);
> > > +
> > > +out:
> > > +
> > > +	return (WIFEXITED(child_status) &&
> > > +		WEXITSTATUS(child_status) == 11);
> > > +}
> > > +
> > > +int execute_shadow_stack_tests(void)
> > > +{
> > > +	int ret = 0;
> > > +	unsigned long test_count = 0;
> > > +	unsigned long shstk_status = 0;
> > > +	bool test_pass = false;
> > > +
> > > +	ksft_print_msg("Executing RISC-V shadow stack self tests\n");
> > > +	ksft_set_plan(RISCV_SHADOW_STACK_TESTS);
> > > +
> > > +	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &shstk_status, 0, 0, 0);
> > > +
> > > +	if (ret != 0)
> > > +		ksft_exit_fail_msg("Get shadow stack status failed with %d\n", ret);
> > > +
> > > +	/*
> > > +	 * If we are here that means get shadow stack status succeeded and
> > > +	 * thus shadow stack support is baked in the kernel.
> > > +	 */
> > > +	while (test_count < RISCV_SHADOW_STACK_TESTS) {
> > > +		test_pass = (*shstk_tests[test_count].t_func)(test_count, NULL);
> > > +		ksft_test_result(test_pass, shstk_tests[test_count].name);
> > > +		test_count++;
> > > +	}
> > > +
> > > +	ksft_finished();
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +#pragma GCC pop_options
> > > diff --git a/tools/testing/selftests/riscv/cfi/shadowstack.h b/tools/testing/selftests/riscv/cfi/shadowstack.h
> > > new file mode 100644
> > > index 000000000000..0be510167de3
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/riscv/cfi/shadowstack.h
> > > @@ -0,0 +1,27 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +
> > > +#ifndef SELFTEST_SHADOWSTACK_TEST_H
> > > +#define SELFTEST_SHADOWSTACK_TEST_H
> > > +#include <stddef.h>
> > > +#include <linux/prctl.h>
> > > +
> > > +/*
> > > + * a cfi test returns true for success or false for fail
> > > + * takes a number for test number to index into array and void pointer.
> > > + */
> > > +typedef bool (*shstk_test_func)(unsigned long test_num, void *);
> > > +
> > > +struct shadow_stack_tests {
> > > +	char *name;
> > > +	shstk_test_func t_func;
> > > +};
> > > +
> > > +bool shadow_stack_fork_test(unsigned long test_num, void *ctx);
> > > +bool shadow_stack_map_test(unsigned long test_num, void *ctx);
> > > +bool shadow_stack_protection_test(unsigned long test_num, void *ctx);
> > > +bool shadow_stack_gup_tests(unsigned long test_num, void *ctx);
> > > +bool shadow_stack_signal_test(unsigned long test_num, void *ctx);
> > > +
> > > +int execute_shadow_stack_tests(void);
> > > +
> > > +#endif
> > > 
> > > -- 
> > > 2.43.0
> > > 

