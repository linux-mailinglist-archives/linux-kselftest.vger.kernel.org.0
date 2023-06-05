Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75047228E9
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 16:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjFEOgJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 10:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjFEOgI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 10:36:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346EBED;
        Mon,  5 Jun 2023 07:36:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50d897af77bso684379a12.1;
        Mon, 05 Jun 2023 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685975764; x=1688567764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nEIx2pKx8MANmuUD53PuQCkyn4NP8umHBPTpshdhtE=;
        b=X4pOGtiEGzl58GIFHbyV096t93IrJzELqcypLc4QMyHeBwAan/aALSMopAZ+lqPIs/
         PZNtR1f+KboWQSY8gUKV8bP6VLPOPyLj9X+PcDBik6Rb1GkoW1dQzGRxs/VB+cefUAHk
         oqOoq9ZzN1ix9J54M/O922WWDlAgpQE5AKeuQY1UWV5aftGRdFXROUT/wO25J2bq7tvJ
         ntDFTIewi2nWrpz4P99jP9etHFIKzZEQQ2s93Ttnro2HDYWUBGQU+f9mpHNbRQ5IlJbB
         1OEzF7yvggyK3Clsj7G1B3wcFoRHXo6xJ+JId++mQ9eGPjlFHkVYB7SLL19lfxy+iJ6r
         HQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685975764; x=1688567764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nEIx2pKx8MANmuUD53PuQCkyn4NP8umHBPTpshdhtE=;
        b=SdyEPM1jdpO9UOjc0wb88OGty/2k7gzfz84pMrlR/hf04x2sNQsdH1kLGenOSnkhxC
         Xed8E54J/t3ug3QhcTKKK9S6FyI+GU2Nfdy8cGyACpdQSsAJJ5OFZ1LEYjBQIb0EkKQI
         tJJXJxCHPvOLDAw4vDc4XhESB+5cK7+73Rb3lgOuasUOzGUJK37tQ2cXI1+WCiuxAInz
         o181SDEEJ3+Vhd+oKmOzYltAwTl6rm6kl+wGo0zJEQpEs6aEkoZ59zeV0cjGMG3vAhlx
         alKcLY3f9/woPFYXzZHbAJgs4sRWY+Oz0rP4+K7vORK2mCY8PoBfWMRqewxfYcGb40WL
         mClg==
X-Gm-Message-State: AC+VfDwVqPXhfqSKpU9vMuVKLCbgVychtSfjpQQQ9MfKX1HXgt/fCgeD
        EPuFSTDv/gyQV+PxqlAhg+c=
X-Google-Smtp-Source: ACHHUZ64cK7Y08p9XC1fThPd/qyz85iOAi9xrRj76BmDStiQbKH5iM+XYS3Sd25RTQiQg9fupo3QbA==
X-Received: by 2002:a17:906:7a17:b0:974:56cb:9dfc with SMTP id d23-20020a1709067a1700b0097456cb9dfcmr9788715ejo.1.1685975764343;
        Mon, 05 Jun 2023 07:36:04 -0700 (PDT)
Received: from localhost ([134.191.220.83])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906851500b00965e9a23f2bsm4364473ejx.134.2023.06.05.07.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 07:36:04 -0700 (PDT)
Date:   Mon, 5 Jun 2023 22:35:20 +0800
From:   Zhi Wang <zhi.wang.linux@gmail.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
        aleksandar.qemu.devel@gmail.com, tsbogend@alpha.franken.de,
        anup@brainfault.org, atishp@atishpatra.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, seanjc@google.com, pbonzini@redhat.com,
        dmatlack@google.com, ricarkol@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/16] KVM: arm64: Document the page table walker
 actions based on the callback's return value
Message-ID: <20230605223520.00007fbd.zhi.wang.linux@gmail.com>
In-Reply-To: <20230602160914.4011728-10-vipinsh@google.com>
References: <20230602160914.4011728-1-vipinsh@google.com>
        <20230602160914.4011728-10-vipinsh@google.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri,  2 Jun 2023 09:09:07 -0700
Vipin Sharma <vipinsh@google.com> wrote:

> Document what the page table walker do when walker callback function returns
> a value.
> 
> Current documentation is not correct as negative error of -EAGAIN on a
> non-shared page table walker doesn't terminate the walker and continues
> to the next step.
> 
> There might be a better place to keep this information, for now this
> documentation will work as a reference guide until a better way is
> found.
>

After reading the whole patch series, I was thinking it might be a good
time to improve the way how the visitor function and page table walker
talk to each other. The error code is good enough before, but its meaning
seems limited and vague when the visitor function wants to express more about
what exactly happens inside. I am not sure if it is a good idea to continue
that way: 1. found a new situation. 2. choosing a error code for visitor
function. 3. walker translates the error code into the situation to
handle. 4. document the error code and its actual meaning.

Eventually I am afraid that we are going to abuse the error code.

What about introducing a set of flags for the visitor function to express
what happened and simplify the existing error code?

> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index 8ef7e8f3f054..957bc20dab00 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -711,8 +711,19 @@ int kvm_pgtable_stage2_split(struct kvm_pgtable *pgt, u64 addr, u64 size,
>   * after invoking the walker callback, allowing the walker to descend into
>   * a newly installed table.
>   *
> - * Returning a negative error code from the walker callback function will
> - * terminate the walk immediately with the same error code.
> + * Depending on the return value from the walker callback function, the page
> + * table walk will continue or exit the walk. This is also dependent on the
> + * type of the walker, i.e. shared walker (vCPU fault handlers) or non-shared
> + * walker.
> + *
> + * Walker Type  | Callback         | Walker action
> + * -------------|------------------|--------------
> + * Non-Shared   | 0                | Continue
> + * Non-Shared   | -EAGAIN          | Continue
> + * Non-Shared   | Any other        | Exit
> + * -------------|------------------|--------------
> + * Shared       | 0                | Continue
> + * Shared       | Any other        | Exit
>   *
>   * Return: 0 on success, negative error code on failure.
>   */

