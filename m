Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF71740678
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 00:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjF0Wcw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 18:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0Wcv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 18:32:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066A4211E
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 15:32:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbaed1ac99so2367055e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 15:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1687905168; x=1690497168;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96mjTfQ9kY+9YoQpS1KAZ12o+s7Q28O5zoNqhn0CFLw=;
        b=KHKX3x3/xnUbcE9dNXX+UPf5rVUm/vAXIfnMCaYvfN1O7zLXkWxkqIr4fXCFAysZK0
         U17/JvZ8Aicy8einjjOf+lGga/SqFh+KbN5MByku+rszdWVtxLflpzmRQPPsw+sQdtca
         ARq389WyD4Dd2msj2BusZkJoBeyqFHo8GM/qFd/HolyIyIdStUG+TLyE1q/Pe9S74tHD
         i2LWaAyS7k/QA4X9zG/yL8pQ0Dep8F8f2f5SyG667W2UhSMVDaeVPEuCBuc1zL4NtjBb
         Ax1d+hTE8ixM8M1YIpxBGdwKN6hj7wI/ofutyUJS2eAFrUTKVMmuzlo8sTKekWhf+XcJ
         Qe3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687905168; x=1690497168;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96mjTfQ9kY+9YoQpS1KAZ12o+s7Q28O5zoNqhn0CFLw=;
        b=dGpT6mc6PEDUlgqHM6mLO9AO8Unm6b1jc+S41O4/BS+7fGlR5xgg0WMC/kxmyzEH6g
         17wzDZ/59VG5q+GT+Se4mwHm4N2TBRlLIxpICypsnh4wX2vO512YbgNl4NX0jc/mYqRV
         Cbi1XeqBFO4pPz1Uc3PMQDxt+lQkloxZt2nBr4eXPVJ33Mg3zsYSDIbPTRn9kkwvTC5d
         rHpRfUeviCxkGnlnCP2XhHKVE7zft0CmZle1AFf+KK6eiFHDWOW1a6BCk19DUFd6gZRV
         ramMGNmDlJEtyrU3R2j4/qmDOJoFv2wBkp8C44sefrzLfnSsV8K1sQPBjkx95ON7bBKa
         c9Aw==
X-Gm-Message-State: AC+VfDxiXoWJVDqFuBLD44VjAQx5aueh5RZGeReGHBe838txUPo/TB/h
        p4o0dZ2CoTVHbelak9afuBiIYg==
X-Google-Smtp-Source: ACHHUZ56C4bQwPWT98hnSB+uKRS/WOCZaRkYvpaAwhlzkOui1rGSOpdwJa8Wm1Cus+cWjuCmOvVmQA==
X-Received: by 2002:a7b:cd89:0:b0:3fa:7991:52b3 with SMTP id y9-20020a7bcd89000000b003fa799152b3mr9680786wmj.5.1687905168246;
        Tue, 27 Jun 2023 15:32:48 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id m5-20020a7bce05000000b003fbaade0735sm1622625wmc.19.2023.06.27.15.32.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2023 15:32:47 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH 1/2] RISC-V: mm: Restrict address space for sv39,sv48,sv57
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230627222152.177716-2-charlie@rivosinc.com>
Date:   Tue, 27 Jun 2023 23:32:36 +0100
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>, bjorn@rivosinc.com,
        Anup Patel <anup@brainfault.org>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <473F7474-D7AA-4C9F-95A3-320F1741EC50@jrtc27.com>
References: <20230627222152.177716-1-charlie@rivosinc.com>
 <20230627222152.177716-2-charlie@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 27 Jun 2023, at 23:21, Charlie Jenkins <charlie@rivosinc.com> wrote:
>=20
> Make sv39 the default address space for mmap as some applications
> currently depend on this assumption.

They are just plain wrong too. Sv48 was in even Priv v1.10 (the first
spec where satp was named as such and contained the mode, rather than
requiring M-mode=E2=80=99s help in configuring virtual memory), =
predating the
ratified v1.11 spec. A 39-bit address space is pathetic and has
implications for ASLR.

I strongly suggest applications be forced to support at least Sv48,
which is totally reasonable given the address space sizes used by other
architectures. Sv57 is more disruptive to some runtimes, though ideally
even that would be free for the kernel to use rather than committing to
not using it for the default uABI.

Jess

> The RISC-V specification enforces
> that bits outside of the virtual address range are not used, so
> restricting the size of the default address space as such should be
> temporary. A hint address passed to mmap will cause the largest =
address
> space that fits entirely into the hint to be used. If the hint is less
> than or equal to 1<<38, a 39-bit address will be used. After an =
address
> space is completely full, the next smallest address space will be =
used.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> arch/riscv/include/asm/elf.h       |  2 +-
> arch/riscv/include/asm/pgtable.h   | 13 +++++++++-
> arch/riscv/include/asm/processor.h | 41 +++++++++++++++++++++++++-----
> 3 files changed, 47 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/elf.h =
b/arch/riscv/include/asm/elf.h
> index 30e7d2455960..1b57f13a1afd 100644
> --- a/arch/riscv/include/asm/elf.h
> +++ b/arch/riscv/include/asm/elf.h
> @@ -49,7 +49,7 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
>  * the loader.  We need to make sure that it is out of the way of the =
program
>  * that it will "exec", and that there is sufficient room for the brk.
>  */
> -#define ELF_ET_DYN_BASE ((TASK_SIZE / 3) * 2)
> +#define ELF_ET_DYN_BASE ((DEFAULT_MAP_WINDOW / 3) * 2)
>=20
> #ifdef CONFIG_64BIT
> #ifdef CONFIG_COMPAT
> diff --git a/arch/riscv/include/asm/pgtable.h =
b/arch/riscv/include/asm/pgtable.h
> index 75970ee2bda2..e83912e97870 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -57,18 +57,29 @@
> #define MODULES_END (PFN_ALIGN((unsigned long)&_start))
> #endif
>=20
> +
> /*
>  * Roughly size the vmemmap space to be large enough to fit enough
>  * struct pages to map half the virtual address space. Then
>  * position vmemmap directly below the VMALLOC region.
>  */
> #ifdef CONFIG_64BIT
> +#define VA_BITS_SV39 39
> +#define VA_BITS_SV48 48
> +#define VA_BITS_SV57 57
> +
> +#define VA_USER_SV39 (UL(1) << (VA_BITS_SV39 - 1))
> +#define VA_USER_SV48 (UL(1) << (VA_BITS_SV48 - 1))
> +#define VA_USER_SV57 (UL(1) << (VA_BITS_SV57 - 1))
> +
> #define VA_BITS (pgtable_l5_enabled ? \
> - 57 : (pgtable_l4_enabled ? 48 : 39))
> + VA_BITS_SV57 : (pgtable_l4_enabled ? VA_BITS_SV48 : VA_BITS_SV39))
> #else
> #define VA_BITS 32
> #endif
>=20
> +#define DEFAULT_VA_BITS ((VA_BITS >=3D VA_BITS_SV39) ? VA_BITS_SV39 : =
VA_BITS)
> +
> #define VMEMMAP_SHIFT \
> (VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
> #define VMEMMAP_SIZE BIT(VMEMMAP_SHIFT)
> diff --git a/arch/riscv/include/asm/processor.h =
b/arch/riscv/include/asm/processor.h
> index 6fb8bbec8459..019dcd4ecae4 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -12,20 +12,47 @@
>=20
> #include <asm/ptrace.h>
>=20
> -/*
> - * This decides where the kernel will search for a free chunk of vm
> - * space during mmap's.
> - */
> -#define TASK_UNMAPPED_BASE PAGE_ALIGN(TASK_SIZE / 3)
> -
> -#define STACK_TOP TASK_SIZE
> #ifdef CONFIG_64BIT
> +#define DEFAULT_MAP_WINDOW (UL(1) << (DEFAULT_VA_BITS - 1))
> #define STACK_TOP_MAX TASK_SIZE_64
> +
> +#define arch_get_mmap_end(addr, len, flags) \
> + ((addr) =3D=3D 0 || (addr) >=3D VA_USER_SV57 ? STACK_TOP_MAX :   \
> + (((addr) >=3D VA_USER_SV48) && (VA_BITS >=3D VA_BITS_SV48)) ? \
> + VA_USER_SV48 : \
> + VA_USER_SV39)
> +
> +#define arch_get_mmap_base(addr, base) \
> + (((addr >=3D VA_USER_SV57) && (VA_BITS >=3D VA_BITS_SV57)) ?   \
> + base + STACK_TOP_MAX - DEFAULT_MAP_WINDOW : \
> + (((addr) >=3D VA_USER_SV48) && (VA_BITS >=3D VA_BITS_SV48)) ? \
> + base + VA_USER_SV48 - DEFAULT_MAP_WINDOW : \
> + base)
> +
> #else
> +#define DEFAULT_MAP_WINDOW TASK_SIZE
> #define STACK_TOP_MAX TASK_SIZE
> +
> +#define arch_get_mmap_end(addr, len, flags) \
> + ((addr) > DEFAULT_MAP_WINDOW ? STACK_TOP_MAX : DEFAULT_MAP_WINDOW)
> +
> +#define arch_get_mmap_base(addr, base) \
> + ((addr > DEFAULT_MAP_WINDOW) ? \
> + base + STACK_TOP_MAX - DEFAULT_MAP_WINDOW : \
> + base)
> +
> #endif
> #define STACK_ALIGN 16
>=20
> +
> +#define STACK_TOP DEFAULT_MAP_WINDOW
> +
> +/*
> + * This decides where the kernel will search for a free chunk of vm
> + * space during mmap's.
> + */
> +#define TASK_UNMAPPED_BASE PAGE_ALIGN(DEFAULT_MAP_WINDOW / 3)
> +
> #ifndef __ASSEMBLY__
>=20
> struct task_struct;
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

