Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5AC75A718
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 09:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjGTHBC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 03:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjGTHBB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 03:01:01 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0C312F
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 00:00:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31590e4e27aso311415f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 00:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689836458; x=1690441258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZEjFz7LOZdmaaeUrHv50TFnsXpX5R1v3ht7TZZ808M=;
        b=1MfTo46HP0GNpJ9cJoyU1w/4UKVOAFz6QpJ4q70QXZNvjfL/YVfMgjHYqRYUSAxHDc
         jTtWwxIaJkGms8cWTugFcMm3Mz/kMh171waQTUmVGUrnhWRdSZZAnopxNT52sGyk4Vhr
         JccuRh1ReQQymlnZdjxbyC4YAll5dWm92TQo+/lCGQexj5cQvGKHZ8hgObMHOvGcBNKc
         O5YUKLp3tsmyVHte9MmjUkozGnbFeFs6ggXSUOdv86CnBPa+ITw35RBr4dJ9ncycHteI
         yoBB4mBa6g7bQWRNx+/Wq4Kah+D6A8vPku4/YRJO5RvDvi7ldgcJ20Ijhjk2fCg6Vb/c
         pjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689836458; x=1690441258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZEjFz7LOZdmaaeUrHv50TFnsXpX5R1v3ht7TZZ808M=;
        b=ZIJvafN/6P+5zRXjecGoZb3PfDcdc/lJ30FuCfGMsjMyL3AHrlQIdbt7ModK+lIC50
         KgNeE6Mk9mJqG5PVDfcyYR5yprBwEvgn+NsRNwUznAR51ZhiJ+5EGE9v2mj2HHdP2zVw
         d1d0MrWNdSsYg5WdOlgNMpgQpIzGPYxttkfTk1pMVbCw2znuu5HYju+w0+7L+G0R+b62
         NJodXaE9gVoDBLqtTNyc8Vsif+7+UkoTKWn2sh6uTWrLuJFnw+GEpQFT6SQP+Po0cAQU
         M61xLhBadOTO7iXAB9++r7xZuqPdode5WhLobO8CghdOB1XGXTgS6LtyASiecSMeBT1v
         AeBw==
X-Gm-Message-State: ABy/qLYwlm6l/mXGoNkpq1GI32ej/zYUYYdvav8fbclh4FGz2I+D+SOl
        iuTIHalunzA8CdndaRg04rZtaR/r3eJJJb1WvY9HoA==
X-Google-Smtp-Source: APBJJlFTDTlY08cieS+z3W0RyAq1pip8zIDcg55w3AOM8lXoEXjLTyl+gVgmTMjFP8mz/ktC3zk5jdu+9sPkK0WnKYA=
X-Received: by 2002:adf:e903:0:b0:30e:3da5:46e5 with SMTP id
 f3-20020adfe903000000b0030e3da546e5mr1830181wrm.59.1689836457755; Thu, 20 Jul
 2023 00:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230714165508.94561-1-charlie@rivosinc.com> <20230714165508.94561-4-charlie@rivosinc.com>
In-Reply-To: <20230714165508.94561-4-charlie@rivosinc.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 20 Jul 2023 09:00:46 +0200
Message-ID: <CAHVXubhUdtiP_G4PwsmQTkKbsQ0PuL-Xjtyowz9iXDeDPeiHFA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] RISC-V: mm: Update pgtable comment documentation
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

On Fri, Jul 14, 2023 at 6:56=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> sv57 is supported in the kernel so pgtable.h should reflect that.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index e13f5872bfe9..28660bab754c 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -840,14 +840,16 @@ static inline pte_t pte_swp_clear_exclusive(pte_t p=
te)
>   * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
>   * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
>   * Task size is:
> - * -     0x9fc00000 (~2.5GB) for RV32.
> - * -   0x4000000000 ( 256GB) for RV64 using SV39 mmu
> - * - 0x800000000000 ( 128TB) for RV64 using SV48 mmu
> + * -        0x9fc00000 (~2.5GB) for RV32.
> + * -      0x4000000000 ( 256GB) for RV64 using SV39 mmu
> + * -    0x800000000000 ( 128TB) for RV64 using SV48 mmu
> + * - 0x100000000000000 (  64PB) for RV64 using SV57 mmu
>   *
>   * Note that PGDIR_SIZE must evenly divide TASK_SIZE since "RISC-V
>   * Instruction Set Manual Volume II: Privileged Architecture" states tha=
t
>   * "load and store effective addresses, which are 64bits, must have bits
>   * 63=E2=80=9348 all equal to bit 47, or else a page-fault exception wil=
l occur."
> + * Similarly for SV57, bits 63=E2=80=9357 must be equal to bit 56.
>   */
>  #ifdef CONFIG_64BIT
>  #define TASK_SIZE_64   (PGDIR_SIZE * PTRS_PER_PGD / 2)
> --
> 2.41.0
>

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex
