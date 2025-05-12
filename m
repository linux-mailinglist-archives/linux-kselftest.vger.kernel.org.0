Return-Path: <linux-kselftest+bounces-32834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6755AB301C
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 08:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71E6B7A3D06
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 06:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0D025525C;
	Mon, 12 May 2025 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4iqbgLs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1333254B11;
	Mon, 12 May 2025 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747032872; cv=none; b=Grp5YCZqLlb0liJ2oCJ84+8WxHaUNPHpgJOpOHYcKU6UjM/a2JZ6/KdM2LLK+B66x6k+QCVX9Xu7FjoPgXban+A7sDBv9loW5rwNjrc4CckQo61SHY3lmo6S9uLYTvXwoaxNyTna3l1NKeggPgp1JRvwDQUoWyyO4UHjTxcY4m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747032872; c=relaxed/simple;
	bh=UzyEJvf8UIvCMjIRcLORGRYJMFtP5tILmnPRiEBiat0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXGbuAXBBS8D/PLkPV6e0yvzlbK0nUgK4+X2dkgRtqT2CxeU3UUux34hzElYbnUg+cQZwuslml6KtKz0ASnveqwcVJFpCAPKnvIY4vJUCcpZtCngxWfYAYcIioQujlj9HJwbBot4unJgWYzgnCOD3la5DnnWpG4VyQzF3VO+sgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4iqbgLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F65C4CEF0;
	Mon, 12 May 2025 06:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747032872;
	bh=UzyEJvf8UIvCMjIRcLORGRYJMFtP5tILmnPRiEBiat0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V4iqbgLsOub54hoUrXAi6Npd3rIZcXZpXN6k1b2hLv3wR/tCAmdwOohvATOxxfdCy
	 OFEkTFftL4i70t7QFmxJu79Wnt17MP+BH2LWci1BvLdV7Kc8PttI8tCMpv3ajG/slL
	 EwpoUKDh5ZtP9PfTtzv5n4e5dxyUm2k6jiB+lqmHF430Y3aD2JZLvSikAZPoQmPoAS
	 iYSfQMuuM8Q2GsFTGBMHj4IHVTZ3R8O+l74e6XHbKJExc6f7F+bUf0XZ/HQJ2DMJvX
	 Uw4TylArMUx2CgUbo0MGZ2L2RzBdJClf1zGdcATiJnZdPgFVNoXwqiWQ8qQ3PG0Gvl
	 gl2iWs4EO5zjA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad238c68b35so337380266b.1;
        Sun, 11 May 2025 23:54:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrTc5uuwhh32TxWPHpfEHkkdNQgpOnFgra0/zC728JsfiJXJUZYg8cpI/MUP2mMSvjzPM=@vger.kernel.org, AJvYcCWZYveOofdsP3Z/vO+aO4GTjYkmBor6YC09hF/PBlP502XzZDLes162ULRYS6JNp9xYUql4pDvOzhMgQEJl@vger.kernel.org, AJvYcCXRTrVHSuhlwix8V8xYegHL56Ke7HVUIbXufS/5FtUfLzrjz/e8WSuY1HnWauw9X3UyUzjXoZ642zZ1dkH386aB@vger.kernel.org
X-Gm-Message-State: AOJu0YxTm/kstjLUtzTTZ4iOP5VdrNjxA7pqv2pBR+MJBk7BEDIgGobp
	JypYDstmZUow+PP5XTcH7RjKFAUA1Mo4114DZ9xUzgJ0pZ3jE1TJMQt3wvdRgTdTJqpiwIhgptR
	tM8haDGPp8NBqPFvD9wJugyorxHU=
X-Google-Smtp-Source: AGHT+IFxFWMNvgOxu8zRhvVKyXxVHRL6cDDVhBy0i7qh8Xalv67bNmfVN2BYwKEk4C5/eCMRlmSaBUD1DiQOzCvq3DM=
X-Received: by 2002:a17:907:7e8b:b0:ad2:4f80:a79a with SMTP id
 a640c23a62f3a-ad24f80a96fmr370746466b.46.1747032870867; Sun, 11 May 2025
 23:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427064535.242404-1-maobibo@loongson.cn> <20250427064535.242404-6-maobibo@loongson.cn>
In-Reply-To: <20250427064535.242404-6-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 12 May 2025 14:54:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Es=TwK+2uPWwBdJ4uEiro5H4mg-fRYdqneebWWf0H4Q@mail.gmail.com>
X-Gm-Features: AX0GCFu9KNAdZfVJev6aerIkTBkCRrioJYlTWqzxkU51wZJTdyNJRkoGE0rbyII
Message-ID: <CAAhV-H5Es=TwK+2uPWwBdJ4uEiro5H4mg-fRYdqneebWWf0H4Q@mail.gmail.com>
Subject: Re: [PATCH v11 5/5] KVM: selftests: Add test cases for LoongArch
To: Bibo Mao <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Sun, Apr 27, 2025 at 2:45=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> Some common KVM test cases are supported on LoongArch now as following:
>   coalesced_io_test
>   demand_paging_test
>   dirty_log_perf_test
>   dirty_log_test
>   guest_print_test
>   hardware_disable_test
>   kvm_binary_stats_test
>   kvm_create_max_vcpus
>   kvm_page_table_test
>   memslot_modification_stress_test
>   memslot_perf_test
>   set_memory_region_test
> And other test cases are not supported by LoongArch such as rseq_test,
> since it is not supported on LoongArch physical machine either.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  MAINTAINERS                                    |  2 ++
>  tools/testing/selftests/kvm/Makefile           |  2 +-
>  tools/testing/selftests/kvm/Makefile.kvm       | 18 ++++++++++++++++++
>  .../selftests/kvm/set_memory_region_test.c     |  2 +-
>  4 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3cbf9ac0d83f..20cb455e0821 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13043,6 +13043,8 @@ F:      Documentation/virt/kvm/loongarch/
>  F:     arch/loongarch/include/asm/kvm*
>  F:     arch/loongarch/include/uapi/asm/kvm*
>  F:     arch/loongarch/kvm/
> +F:     tools/testing/selftests/kvm/*/loongarch/
> +F:     tools/testing/selftests/kvm/lib/loongarch/
>
>  KERNEL VIRTUAL MACHINE FOR MIPS (KVM/mips)
>  M:     Huacai Chen <chenhuacai@kernel.org>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftes=
ts/kvm/Makefile
> index 20af35a91d6f..d9fffe06d3ea 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -3,7 +3,7 @@ top_srcdir =3D ../../../..
>  include $(top_srcdir)/scripts/subarch.include
>  ARCH            ?=3D $(SUBARCH)
>
> -ifeq ($(ARCH),$(filter $(ARCH),arm64 s390 riscv x86 x86_64))
> +ifeq ($(ARCH),$(filter $(ARCH),arm64 s390 riscv x86 x86_64 loongarch))
>  # Top-level selftests allows ARCH=3Dx86_64 :-(
>  ifeq ($(ARCH),x86_64)
>         ARCH :=3D x86
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/sel=
ftests/kvm/Makefile.kvm
> index f62b0a5aba35..7985bb42d2c1 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -47,6 +47,10 @@ LIBKVM_riscv +=3D lib/riscv/handlers.S
>  LIBKVM_riscv +=3D lib/riscv/processor.c
>  LIBKVM_riscv +=3D lib/riscv/ucall.c
>
> +LIBKVM_loongarch +=3D lib/loongarch/processor.c
> +LIBKVM_loongarch +=3D lib/loongarch/ucall.c
> +LIBKVM_loongarch +=3D lib/loongarch/exception.S
> +
>  # Non-compiled test targets
>  TEST_PROGS_x86 +=3D x86/nx_huge_pages_test.sh
>
> @@ -190,6 +194,20 @@ TEST_GEN_PROGS_riscv +=3D coalesced_io_test
>  TEST_GEN_PROGS_riscv +=3D get-reg-list
>  TEST_GEN_PROGS_riscv +=3D steal_time
>
> +TEST_GEN_PROGS_loongarch +=3D coalesced_io_test
> +TEST_GEN_PROGS_loongarch +=3D demand_paging_test
> +TEST_GEN_PROGS_loongarch +=3D dirty_log_perf_test
> +TEST_GEN_PROGS_loongarch +=3D dirty_log_test
> +TEST_GEN_PROGS_loongarch +=3D demand_paging_test
This line is duplicated.


Huacai

> +TEST_GEN_PROGS_loongarch +=3D guest_print_test
> +TEST_GEN_PROGS_loongarch +=3D hardware_disable_test
> +TEST_GEN_PROGS_loongarch +=3D kvm_binary_stats_test
> +TEST_GEN_PROGS_loongarch +=3D kvm_create_max_vcpus
> +TEST_GEN_PROGS_loongarch +=3D kvm_page_table_test
> +TEST_GEN_PROGS_loongarch +=3D memslot_modification_stress_test
> +TEST_GEN_PROGS_loongarch +=3D memslot_perf_test
> +TEST_GEN_PROGS_loongarch +=3D set_memory_region_test
> +
>  SPLIT_TESTS +=3D arch_timer
>  SPLIT_TESTS +=3D get-reg-list
>
> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools=
/testing/selftests/kvm/set_memory_region_test.c
> index bc440d5aba57..ce3ac0fd6dfb 100644
> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
> @@ -350,7 +350,7 @@ static void test_invalid_memory_region_flags(void)
>         struct kvm_vm *vm;
>         int r, i;
>
> -#if defined __aarch64__ || defined __riscv || defined __x86_64__
> +#if defined __aarch64__ || defined __riscv || defined __x86_64__ || defi=
ned __loongarch__
>         supported_flags |=3D KVM_MEM_READONLY;
>  #endif
>
> --
> 2.39.3
>

