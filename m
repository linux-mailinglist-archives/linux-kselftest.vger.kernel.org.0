Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B77675A8DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 10:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGTIOL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 04:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjGTIOK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 04:14:10 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98308211F
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 01:14:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so712654e87.3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 01:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689840846; x=1690445646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pr6JMOyo8xBta00ZkqFzr6fzrP7XkXRaBSf7j7HlZ/U=;
        b=GDSizF/B+ucio52p533XeQ4Nc4PlxzdgqFTMRTEk7FJ0ZVPf5VJ5jnJBugweo0Mv/W
         HXgDYWFwoJidjd0gREojTYRKn/ZUr0iAqDyxnS0Yw3vqlD/r2/mq4rZM82aa/MMeluNU
         on+u40mgtrds4Wt+dFZML8vAW/qGSWvn0pPwCi9Bdo0MRwJ5/Ow5Z6BDRKbxdF2oot4B
         O2eB0dlggRtHAdTW2jtPFmKYwSfG+oixFJoHNeHmGHTZWFzJB0Ex5rN6xES0UiAaEu9/
         LRWT6ZRV9IYh9JlJE29jLMwIkkJ004O8i5TZZKVLDAspg0RPavmqbKPIw4RG8kdcXhHN
         JMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689840846; x=1690445646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pr6JMOyo8xBta00ZkqFzr6fzrP7XkXRaBSf7j7HlZ/U=;
        b=aQL5wtferJol785CovqjjcWqAoWLal5HddB1zjumwgZG6qQ+f9Cyqh1y4TG+Cyw3kg
         G6JUEwXU/jOGmQWel4uouX6i2kybA8I4Yjwb1QcfQsI3LdlWpIuLOceKNaS/IATBBGKm
         f7hRItq+hWvUtbE/Ctg982cKg1Aa6Cs+yBGTQY5/Rhx8g8SNlOfsQTfP9rnpMO8kFLXW
         aB5/PCyox5Z1NHCwJHFYE5M9SUd26JNZ8kuADJ63a/DZ9+faqf6CLxR6iti7gldAOLl8
         80Y2B0Dx68c9SCSTF66BmuvLyg6U5VOBws6I2b56b+5vE8qyroRTRMtOS54e9nsCk/gH
         +dXA==
X-Gm-Message-State: ABy/qLbmBZUSIgGgiSnlTVwy/ZeG7ITgEOoHIRoq73KwXtLMCr7VdObz
        tfK/c30Xxsu6HvKz0AG4ipRDYZ2cACS3wRwir4ScIw==
X-Google-Smtp-Source: APBJJlHIHnf/Ou2r9HFtGQF5G94v8undXdV+GSETq1dizsussY5NL7ytInJm0wx9i23bhmmhfP5zdP/NtqqeqgalD88=
X-Received: by 2002:ac2:5b05:0:b0:4fa:6d62:9219 with SMTP id
 v5-20020ac25b05000000b004fa6d629219mr1495448lfn.62.1689840845696; Thu, 20 Jul
 2023 01:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230714165508.94561-1-charlie@rivosinc.com> <20230714165508.94561-2-charlie@rivosinc.com>
In-Reply-To: <20230714165508.94561-2-charlie@rivosinc.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 20 Jul 2023 10:13:54 +0200
Message-ID: <CAHVXubhpQGYvNdRnU8Obi-6h6okdXYUuo7WGeCU_LbscUbmgjg@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] RISC-V: mm: Restrict address space for sv39,sv48,sv57
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        conor@kernel.org, paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 14, 2023 at 6:55=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Make sv48 the default address space for mmap as some applications
> currently depend on this assumption. A hint address passed to mmap will
> cause the largest address space that fits entirely into the hint to be
> used. If the hint is less than or equal to 1<<38, an sv39 address will
> be used. An exception is that if the hint address is 0, then a sv48
> address will be used. After an address space is completely full, the next
> smallest address space will be used.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/elf.h       |  2 +-
>  arch/riscv/include/asm/pgtable.h   | 12 +++++++-
>  arch/riscv/include/asm/processor.h | 46 +++++++++++++++++++++++++-----
>  3 files changed, 51 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> index c24280774caf..5d3368d5585c 100644
> --- a/arch/riscv/include/asm/elf.h
> +++ b/arch/riscv/include/asm/elf.h
> @@ -49,7 +49,7 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
>   * the loader.  We need to make sure that it is out of the way of the pr=
ogram
>   * that it will "exec", and that there is sufficient room for the brk.
>   */
> -#define ELF_ET_DYN_BASE                ((TASK_SIZE / 3) * 2)
> +#define ELF_ET_DYN_BASE                ((DEFAULT_MAP_WINDOW / 3) * 2)
>
>  #ifdef CONFIG_64BIT
>  #ifdef CONFIG_COMPAT
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 75970ee2bda2..e13f5872bfe9 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -63,12 +63,22 @@
>   * position vmemmap directly below the VMALLOC region.
>   */
>  #ifdef CONFIG_64BIT
> +#define VA_BITS_SV39 39
> +#define VA_BITS_SV48 48
> +#define VA_BITS_SV57 57
> +
> +#define VA_USER_SV39 (UL(1) << (VA_BITS_SV39 - 1))
> +#define VA_USER_SV48 (UL(1) << (VA_BITS_SV48 - 1))
> +#define VA_USER_SV57 (UL(1) << (VA_BITS_SV57 - 1))
> +
>  #define VA_BITS                (pgtable_l5_enabled ? \
> -                               57 : (pgtable_l4_enabled ? 48 : 39))
> +                               VA_BITS_SV57 : (pgtable_l4_enabled ? VA_B=
ITS_SV48 : VA_BITS_SV39))
>  #else
>  #define VA_BITS                32
>  #endif
>
> +#define MMAP_VA_BITS ((VA_BITS >=3D VA_BITS_SV48) ? VA_BITS_SV48 : VA_BI=
TS)
> +
>  #define VMEMMAP_SHIFT \
>         (VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
>  #define VMEMMAP_SIZE   BIT(VMEMMAP_SHIFT)
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index c950a8d9edef..14a5396eed3d 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -13,20 +13,52 @@
>
>  #include <asm/ptrace.h>
>
> -/*
> - * This decides where the kernel will search for a free chunk of vm
> - * space during mmap's.
> - */
> -#define TASK_UNMAPPED_BASE     PAGE_ALIGN(TASK_SIZE / 3)
> -
> -#define STACK_TOP              TASK_SIZE
>  #ifdef CONFIG_64BIT
> +#define DEFAULT_MAP_WINDOW     (UL(1) << (MMAP_VA_BITS - 1))
>  #define STACK_TOP_MAX          TASK_SIZE_64
> +
> +#define arch_get_mmap_end(addr, len, flags)    \
> +({     \
> +       unsigned long mmap_end; \
> +       if ((addr) >=3D VA_USER_SV57)     \
> +               mmap_end =3D STACK_TOP_MAX;       \
> +       else if ((((addr) >=3D VA_USER_SV48)) && (VA_BITS >=3D VA_BITS_SV=
48))       \
> +               mmap_end =3D VA_USER_SV48;        \
> +       else if ((addr) =3D=3D 0)   \
> +               mmap_end =3D DEFAULT_MAP_WINDOW;  \
> +       else    \
> +               mmap_end =3D VA_USER_SV39;        \
> +       mmap_end;       \
> +})

What about the following instead:

#define arch_get_mmap_end(addr, len, flags)    \
({     \
       unsigned long mmap_end; \
       if ((addr) >=3D VA_USER_SV57) \
          mmap_end =3D STACK_TOP_MAX; \ // Maybe a comment here that
says it returns the max user address of the current mode, not obvious
at first sight.
       else \
          mmap_end =3D DEFAULT_MAP_WINDOW; \
       mmap_end; \
})

The only corner case is when sv57 is active, then only a hint greater
than VA_USER_SV57 can return a sv57 user address. Otherwise, we just
need to return the default mmap end right?

> +
> +#define arch_get_mmap_base(addr, base) \
> +({     \
> +       unsigned long mmap_base;        \
> +       if (((addr) >=3D VA_USER_SV57) && (VA_BITS >=3D VA_BITS_SV57))   =
   \
> +               mmap_base =3D (base) + (VA_USER_SV57 - DEFAULT_MAP_WINDOW=
);       \
> +       else if ((((addr) >=3D VA_USER_SV48)) && (VA_BITS >=3D VA_BITS_SV=
48))       \
> +               mmap_base =3D (base) + (VA_USER_SV48 - DEFAULT_MAP_WINDOW=
);       \
> +       else if ((addr) =3D=3D 0)   \
> +               mmap_base =3D (base);     \
> +       else    \
> +               mmap_base =3D (base) + (VA_USER_SV39 - DEFAULT_MAP_WINDOW=
);       \
> +       mmap_base;      \
> +})
> +

From arch_pick_mmap_layout()
(https://elixir.bootlin.com/linux/latest/source/mm/util.c#L433), the
"base" argument is:

- either STACK_TOP in top-down (more or less some random offset)
- or TASK_UNMAPPED_BASE in bottom-up (more or less some random offset)

When bottom-up is the current mode, we should not change the base, so
adding (VA_USER_SV57 - DEFAULT_MAP_WINDOW) in the first case is not
right for me. When sv48 or sv57 are the active mode,
DEFAULT_MAP_WINDOW is equal to VA_USER_SV48 right? So (VA_USER_SV48 -
DEFAULT_MAP_WINDOW) is 0, so not useful. And for the last case, when
the user asks for a sv39 address whereas the active mode is sv48 or
sv57, then  (VA_USER_SV39 - DEFAULT_MAP_WINDOW) is negative and the
base is smaller which is not correct.

In the bottom-up case, we should preserve the base and I think that
again, only sv57 is the corner case to deal with.


>  #else
> +#define DEFAULT_MAP_WINDOW     TASK_SIZE
>  #define STACK_TOP_MAX          TASK_SIZE
>  #endif
>  #define STACK_ALIGN            16
>
> +#define STACK_TOP              DEFAULT_MAP_WINDOW
> +
> +/*
> + * This decides where the kernel will search for a free chunk of vm
> + * space during mmap's.
> + */
> +#define TASK_UNMAPPED_BASE     PAGE_ALIGN(DEFAULT_MAP_WINDOW / 3)
> +
>  #ifndef __ASSEMBLY__
>
>  struct task_struct;
> --
> 2.41.0
>
