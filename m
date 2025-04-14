Return-Path: <linux-kselftest+bounces-30729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A601A88555
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 16:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8375602F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ADE2C030A;
	Mon, 14 Apr 2025 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0cTqYE0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4850B289377;
	Mon, 14 Apr 2025 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744639203; cv=none; b=JLiktMU8SAnVrz2mC6MSROyZxdb8I2dTF2s8/2Hzw/FuC9L4z+kOGjTGEu9IwRTVYT7R6bEE8gq03BBjDMYQH89t50pm6wMlPvQ6EM1Z1CpFdmlA4nSwn4zMYp4M0v2NrlRAtr92FrD/9rpXsw5T7uw6pNMcMS3iVOgBF46V1Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744639203; c=relaxed/simple;
	bh=nY2jtEZRHlv9V/RIKzrxyGRKCAifwpg4RNap/n4sscE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tmtq6bxXJrGodkpAQaBzE1ooACuRzimD8/vcUqCc4sQp9Ess66qyl873hAmK8tzzKnxCmDyws+EPf+cWGNgtnrO0pxxn8x99N0P8tnHpR02oUdQlbr4ouVhz6KgTYASFvTKuchVHFHnLJP7JgFKAk2sRNhhwvAY7kB4OWGJvPoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0cTqYE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF91DC4CEED;
	Mon, 14 Apr 2025 14:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744639202;
	bh=nY2jtEZRHlv9V/RIKzrxyGRKCAifwpg4RNap/n4sscE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P0cTqYE0WtuJeWZA6MbCkmNThUzBl8wjlhvoRicd3ljOFI0BUChk48ntXs7gVUzvN
	 Nd0fX0EOgLnFBb5Lmco9IShXsL3N06viCcyom8hamxY0ICXtdpCHfEfzSFm0bHZIjb
	 hZm8wVE5DtWTnue/gyLpwCXhphLSs+onecgQHWyrpQUonqxl+UzPZi5HTONg1da8jc
	 42LvNXvzOyV+qRtJtIIDw7uZ8Zs3DdmXIzegZjNRmWByKOxYRG7BIg2Yiprc9OSLmJ
	 4UhSAswXDevFNcnb4RykD6yKcK+GNgM5Sa8jh+UuGDZkFybCBjJ8bZkG89IelDZAtZ
	 C5z5B4t25/4hw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso7216714a12.0;
        Mon, 14 Apr 2025 07:00:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtNNR8ZCwIA7DrGUkSRUvASvTmJvNNgbNj8RBtvES4+nyzM9+mTWnqr0q7JzHejVewNtDNZ9IDawEz1rvo@vger.kernel.org, AJvYcCVe9xCAHqhYq8mvCGSUOmiRDwwPhsZMbetLvm85InJOmiFjuu5NedCraIz1qOt1oCwMFIUlLJ9ozFkGsQPKxFgR@vger.kernel.org, AJvYcCXcw+YIbjQ5kA/ZULbpri6AB60TTKmPUFbjAhO7+hIyiCK/rC6SaWLPcag6Dw/HXJBfw3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxSy2wKCNjm75a7q/2f6JL2PNMUaDtvecZKdY/0C+5/ZbSPkhP
	yflJVrk+7Ne+z61JKDEU1EUKy7VJ0hSINAGmS0uzVvS2LP/uXP4FOEN5Z/9reTu3btKPyiyHNqG
	FE41SUMOcdYwOAbXZAtgkXtc6/Mk=
X-Google-Smtp-Source: AGHT+IHTrFhMlY0mu/G+RXpZnyeIw7i/v2ZmgjUtm3x60VmXOAXRT4o1706xtyGtGLxxknXCe3hb49bt+W6ImpCZYYk=
X-Received: by 2002:a17:907:608c:b0:ac4:3cd:2cb2 with SMTP id
 a640c23a62f3a-acad3446924mr983552166b.1.1744639201346; Mon, 14 Apr 2025
 07:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410035647.3501139-1-maobibo@loongson.cn> <20250410035647.3501139-2-maobibo@loongson.cn>
In-Reply-To: <20250410035647.3501139-2-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 14 Apr 2025 21:59:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5-RXzHP8L2Hv6Drvaakwv4v=NYcDQhQUkzOEcgPTMm1Q@mail.gmail.com>
X-Gm-Features: ATxdqUFqgrZzEtN3FqqqG0wrYHfkvjREitGDfkEtzooKC0jRIO4R0yaVZNfMm3U
Message-ID: <CAAhV-H5-RXzHP8L2Hv6Drvaakwv4v=NYcDQhQUkzOEcgPTMm1Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] KVM: selftests: Add KVM selftests header files for LoongArch
To: Bibo Mao <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Thu, Apr 10, 2025 at 11:57=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> Add KVM selftests header files for LoongArch, including processor.h
> and kvm_util_base.h. It mainly contains LoongArch CSR register
> definition and page table entry definition.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  |   5 +
>  .../kvm/include/loongarch/kvm_util_arch.h     |   7 +
>  .../kvm/include/loongarch/processor.h         | 138 ++++++++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/include/loongarch/kvm_uti=
l_arch.h
>  create mode 100644 tools/testing/selftests/kvm/include/loongarch/process=
or.h
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testi=
ng/selftests/kvm/include/kvm_util.h
> index 373912464fb4..d9cb62207c57 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -232,6 +232,11 @@ extern enum vm_guest_mode vm_mode_default;
>  #define MIN_PAGE_SHIFT                 12U
>  #define ptes_per_page(page_size)       ((page_size) / 8)
>
> +#elif defined(__loongarch__)
> +#define VM_MODE_DEFAULT                        VM_MODE_P36V47_16K
Maybe we can add VM_MODE_P40V47_16K and VM_MODE_P48V47_16K? That is
more suitable for LoongArch in my opinion.

> +#define MIN_PAGE_SHIFT                 12U
> +#define ptes_per_page(page_size)       ((page_size) / 8)
> +
>  #endif
>
>  #define VM_SHAPE_DEFAULT       VM_SHAPE(VM_MODE_DEFAULT)
> diff --git a/tools/testing/selftests/kvm/include/loongarch/kvm_util_arch.=
h b/tools/testing/selftests/kvm/include/loongarch/kvm_util_arch.h
> new file mode 100644
> index 000000000000..e43a57d99b56
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/loongarch/kvm_util_arch.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTEST_KVM_UTIL_ARCH_H
> +#define SELFTEST_KVM_UTIL_ARCH_H
> +
> +struct kvm_vm_arch {};
> +
> +#endif  // SELFTEST_KVM_UTIL_ARCH_H
> diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/=
tools/testing/selftests/kvm/include/loongarch/processor.h
> new file mode 100644
> index 000000000000..e95dd2059605
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
> @@ -0,0 +1,138 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef SELFTEST_KVM_PROCESSOR_H
> +#define SELFTEST_KVM_PROCESSOR_H
> +
> +#ifndef __ASSEMBLER__
> +#include "ucall_common.h"
> +
> +#else
> +/* general registers */
> +#define zero                           $r0
> +#define ra                             $r1
> +#define tp                             $r2
> +#define sp                             $r3
> +#define a0                             $r4
> +#define a1                             $r5
> +#define a2                             $r6
> +#define a3                             $r7
> +#define a4                             $r8
> +#define a5                             $r9
> +#define a6                             $r10
> +#define a7                             $r11
> +#define t0                             $r12
> +#define t1                             $r13
> +#define t2                             $r14
> +#define t3                             $r15
> +#define t4                             $r16
> +#define t5                             $r17
> +#define t6                             $r18
> +#define t7                             $r19
> +#define t8                             $r20
> +#define u0                             $r21
> +#define fp                             $r22
> +#define s0                             $r23
> +#define s1                             $r24
> +#define s2                             $r25
> +#define s3                             $r26
> +#define s4                             $r27
> +#define s5                             $r28
> +#define s6                             $r29
> +#define s7                             $r30
> +#define s8                             $r31
> +#endif
> +
> +/* LoongArch page table entry definition */
> +#define _PAGE_VALID_SHIFT              0
> +#define _PAGE_DIRTY_SHIFT              1
> +#define _PAGE_PLV_SHIFT                        2  /* 2~3, two bits */
> +#define  PLV_KERN                      0
> +#define  PLV_USER                      3
> +#define  PLV_MASK                      0x3
> +#define _CACHE_SHIFT                   4  /* 4~5, two bits */
> +#define _PAGE_PRESENT_SHIFT            7
> +#define _PAGE_WRITE_SHIFT              8
> +
> +#define _PAGE_VALID                    BIT_ULL(_PAGE_VALID_SHIFT)
> +#define _PAGE_PRESENT                  BIT_ULL(_PAGE_PRESENT_SHIFT)
> +#define _PAGE_WRITE                    BIT_ULL(_PAGE_WRITE_SHIFT)
> +#define _PAGE_DIRTY                    BIT_ULL(_PAGE_DIRTY_SHIFT)
> +#define _PAGE_USER                     (PLV_USER << _PAGE_PLV_SHIFT)
> +#define   __READABLE                   (_PAGE_VALID)
> +#define   __WRITEABLE                  (_PAGE_DIRTY | _PAGE_WRITE)
> +/* Coherent Cached */
> +#define _CACHE_CC                      BIT_ULL(_CACHE_SHIFT)
> +#define PS_4K                          0x0000000c
> +#define PS_8K                          0x0000000d
> +#define PS_16K                         0x0000000e
The page size supported by kernel is 4K, 16K and 64K, so remove 8K and add =
64K?

Huacai

> +#define PS_DEFAULT_SIZE                        PS_16K
> +
> +/* LoongArch Basic CSR registers */
> +#define LOONGARCH_CSR_CRMD             0x0 /* Current mode info */
> +#define  CSR_CRMD_PG_SHIFT             4
> +#define  CSR_CRMD_PG                   BIT_ULL(CSR_CRMD_PG_SHIFT)
> +#define  CSR_CRMD_IE_SHIFT             2
> +#define  CSR_CRMD_IE                   BIT_ULL(CSR_CRMD_IE_SHIFT)
> +#define  CSR_CRMD_PLV_SHIFT            0
> +#define  CSR_CRMD_PLV_WIDTH            2
> +#define  CSR_CRMD_PLV                  (0x3UL << CSR_CRMD_PLV_SHIFT)
> +#define  PLV_MASK                      0x3
> +#define LOONGARCH_CSR_PRMD             0x1
> +#define LOONGARCH_CSR_EUEN             0x2
> +#define LOONGARCH_CSR_ECFG             0x4
> +#define LOONGARCH_CSR_ESTAT            0x5  /* Exception status */
> +#define LOONGARCH_CSR_ERA              0x6  /* ERA */
> +#define LOONGARCH_CSR_BADV             0x7  /* Bad virtual address */
> +#define LOONGARCH_CSR_EENTRY           0xc
> +#define LOONGARCH_CSR_TLBIDX           0x10 /* TLB Index, EHINV, PageSiz=
e */
> +#define  CSR_TLBIDX_PS_SHIFT           24
> +#define  CSR_TLBIDX_PS_WIDTH           6
> +#define  CSR_TLBIDX_PS                 (0x3fUL << CSR_TLBIDX_PS_SHIFT)
> +#define  CSR_TLBIDX_SIZEM              0x3f000000
> +#define  CSR_TLBIDX_SIZE               CSR_TLBIDX_PS_SHIFT
> +#define LOONGARCH_CSR_ASID             0x18 /* ASID */
> +#define LOONGARCH_CSR_PGDL             0x19
> +#define LOONGARCH_CSR_PGDH             0x1a
> +/* Page table base */
> +#define LOONGARCH_CSR_PGD              0x1b
> +#define LOONGARCH_CSR_PWCTL0           0x1c
> +#define LOONGARCH_CSR_PWCTL1           0x1d
> +#define LOONGARCH_CSR_STLBPGSIZE       0x1e
> +#define LOONGARCH_CSR_CPUID            0x20
> +#define LOONGARCH_CSR_KS0              0x30
> +#define LOONGARCH_CSR_KS1              0x31
> +#define LOONGARCH_CSR_TMID             0x40
> +#define LOONGARCH_CSR_TCFG             0x41
> +/* TLB refill exception entry */
> +#define LOONGARCH_CSR_TLBRENTRY                0x88
> +#define LOONGARCH_CSR_TLBRSAVE         0x8b
> +#define LOONGARCH_CSR_TLBREHI          0x8e
> +#define  CSR_TLBREHI_PS_SHIFT          0
> +#define  CSR_TLBREHI_PS                        (0x3fUL << CSR_TLBREHI_PS=
_SHIFT)
> +
> +#define EXREGS_GPRS                    (32)
> +
> +#ifndef __ASSEMBLER__
> +void handle_tlb_refill(void);
> +void handle_exception(void);
> +
> +struct ex_regs {
> +       unsigned long regs[EXREGS_GPRS];
> +       unsigned long pc;
> +       unsigned long estat;
> +       unsigned long badv;
> +};
> +
> +#define PC_OFFSET_EXREGS               offsetof(struct ex_regs, pc)
> +#define ESTAT_OFFSET_EXREGS            offsetof(struct ex_regs, estat)
> +#define BADV_OFFSET_EXREGS             offsetof(struct ex_regs, badv)
> +#define EXREGS_SIZE                    sizeof(struct ex_regs)
> +
> +#else
> +#define PC_OFFSET_EXREGS               ((EXREGS_GPRS + 0) * 8)
> +#define ESTAT_OFFSET_EXREGS            ((EXREGS_GPRS + 1) * 8)
> +#define BADV_OFFSET_EXREGS             ((EXREGS_GPRS + 2) * 8)
> +#define EXREGS_SIZE                    ((EXREGS_GPRS + 3) * 8)
> +#endif
> +
> +#endif /* SELFTEST_KVM_PROCESSOR_H */
> --
> 2.39.3
>

