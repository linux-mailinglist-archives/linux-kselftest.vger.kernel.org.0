Return-Path: <linux-kselftest+bounces-31217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D7BA94712
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Apr 2025 09:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73B11892A52
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Apr 2025 07:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9835202C5D;
	Sun, 20 Apr 2025 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISKBPsno"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9932918A6A5;
	Sun, 20 Apr 2025 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745134696; cv=none; b=uJqli98yEhtUHJ5r/b3Ue3tMqA8Khgwx6sJkWvU4Ey2ptgPcDoYq6bzECSuW12opj7gaj4EYAUGrCJ5hzG83waFZjSQ+30I5ZV02EiJ6gZKLH/RbYA5rbdAakesFIVQ1riJumXuZJ4ImEqdLDOOR7UEYVx3Q9k7tNoQ99DbRk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745134696; c=relaxed/simple;
	bh=8H2wR04H8flbz5OMYgtYm6o3qdMPcv3utA0LEY5U3SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAU893IKfyoi+Mb7XAdwnDIEwdTFW0sOQYG+n4f6c1unDzMnExt51XIfpaKnQTf/KafMSaNu0T3znrpimECKP5YR5Rbl8pWychCXntsfJfynqlZLGbmed1b76nFtg924m0Zr7r9Nq4lAdenLuyL+CC9cHbc+eFPj6/kAyIi1OnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISKBPsno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165CAC4CEED;
	Sun, 20 Apr 2025 07:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745134696;
	bh=8H2wR04H8flbz5OMYgtYm6o3qdMPcv3utA0LEY5U3SI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ISKBPsnoeIKDORV/IhljEqs53hZXUeJJkqc7dulc385QQvxZ6VtKvFyFltimGlTBT
	 A1fSEAjicVQhrBNR4YG/ZkWhkxc+WVjZ92J1qWyFdCi0Hq4MGrHa166myzRwTgZheg
	 owRnDqWGM7g7XUbK3/C/UwnqvnJlQ6ukzO3Z38RZtmRvECZ1L6xR77m6tS3lOZEvLu
	 xQ01Z/hKoykU9oX2gHYGnSdLOT6mZfHmhrMHaW1I7CyA40nM9idoRqNXxvIwfCUBXh
	 1pllZYc5e3yuSD6wRUhNoIJJgoEbaU6/ciJcjHVZaRpX2qey1mptq993MIq5+PEWh4
	 l+jAMherFfd7A==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f62d3ed994so3160622a12.2;
        Sun, 20 Apr 2025 00:38:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVv0Cleg0P2xsKC5766jH3nq++/CDJOZ6K5kfUbfBOfs+MZqRTug8/ht8anWfs7GvYcf3pV9Y4LSo87Cppt0CPD@vger.kernel.org, AJvYcCWBIprZK9WkAwD3//0zToO5zJKvUQCoWq8wibOMJjm24P9MesIIGUpuDNU8YXp6veb6k4Q=@vger.kernel.org, AJvYcCXzGMLsagtA1be5ohoLTv7apvn/wWpGt7nd6igK+HJ5HC+NcUQrbmyhVlESnPs4lMyEW7XjdeLNuBsp6j4a@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8v4TIDtLyVIwIvnXNEOqijc86CPoulSbohp+UsjbKAgnhORHL
	wQxN4dYhG+epmMrxO7AByySrGsMR6JbDRw2R2qHYM4Z3bYWFdlsf8U3Ck7SWxYYsf/h0nMTY5/b
	tLeuFI9llBRPKzmCTx+pJske+lrc=
X-Google-Smtp-Source: AGHT+IEPY3aHqS34i2DS8PF0w5KZNLHi15ueZKKiTRh1EovxvH8x79W7hl/sn7a21s2Xb6lUG42bSOFjpYisBeBdTko=
X-Received: by 2002:a17:907:728a:b0:ac7:c66a:4702 with SMTP id
 a640c23a62f3a-acb74df38d6mr696349966b.57.1745134694668; Sun, 20 Apr 2025
 00:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416035455.25996-1-maobibo@loongson.cn> <20250416035455.25996-3-maobibo@loongson.cn>
In-Reply-To: <20250416035455.25996-3-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 20 Apr 2025 15:38:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7p7KM=Qwf8w5qd2JrS0dn+iqZzzWm9xBpFvXA+uG_ALA@mail.gmail.com>
X-Gm-Features: ATxdqUH_c_klc_h2EcIWJzKU3k_bZ7XCmp5pIX-o9iaC44k5jeeJwU6Cc61KGSo
Message-ID: <CAAhV-H7p7KM=Qwf8w5qd2JrS0dn+iqZzzWm9xBpFvXA+uG_ALA@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] KVM: selftests: Add KVM selftests header files for LoongArch
To: Bibo Mao <maobibo@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Wed, Apr 16, 2025 at 11:55=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
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
> index f8faed8c8024..93013564428b 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -233,6 +233,11 @@ extern enum vm_guest_mode vm_mode_default;
>  #define MIN_PAGE_SHIFT                 12U
>  #define ptes_per_page(page_size)       ((page_size) / 8)
>
> +#elif defined(__loongarch__)
> +#define VM_MODE_DEFAULT                        VM_MODE_P47V47_16K
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
As I said in V8, the page size supported by kernel is 4K, 16K and 64K,
so you can remove 8K and add 64K.

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

