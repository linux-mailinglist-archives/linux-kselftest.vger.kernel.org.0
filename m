Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA857255EE
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 09:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbjFGHiF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 03:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237642AbjFGHhY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 03:37:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D569268F;
        Wed,  7 Jun 2023 00:36:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f6170b1486so374250e87.0;
        Wed, 07 Jun 2023 00:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686123378; x=1688715378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2V3s3icJTC6LaLSn3oBF3M+3j5PZ/qbP3uDWciuJbcU=;
        b=fn2KcYq5uY2mH+HBy/a6NAnSP+8+9rQr82d+AuBIReLJOJ3cCVmW+3wr4VfxsM87BJ
         OMfKWaQ/mVrNrACzq5kUcPkCS/Q0xWVDHqyPJRRSmsPCAdMiPfl/Qv8hYQ84AJrRKaOe
         YDReSxP1+MEXJ4bCT9Dqm4Yzhd1c7MX/QuXdC3HohpTyuNP68nbtUvNEUydzmAhxxULl
         Q75bWHaJLVigND99EyKafEWnXnd5UMVjWsz+pIX2pC+S8Wqv6qCjWPcn6a/0zm0lZ3qa
         DVNboeHMPeGP5b7KJQ4Q1c2X3HDFPEKCFiRlXmG9h8Vix1Rv+/NskHW66qCSUGIOQYnr
         ZbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123378; x=1688715378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2V3s3icJTC6LaLSn3oBF3M+3j5PZ/qbP3uDWciuJbcU=;
        b=FJMpdptjmH3sP2FZJpj1yo6bboxJt9wdqlTk2HCW49jkB2s9I3Hsi/ugIo+x9EgWMI
         oBAlWZuZLTSeA0RShAYe8gcZ8zJbKgt/EZ9QNbWYKqab5ebrAmUR526x/geBb7UgQ1gP
         fEQl5SoTjHT5gH3di4lmPoEjyE+we+bhxXHhiy7TCux5NYl5Zj4mC+B7tj13KIrQUZCj
         RBl9yd+jT0ZrkUBII6S/S7l/KyezzvcaeFXAAnRiQL1SnCU+ekn9cWCCIhcDBh6IO9Bh
         DbYG3OHAUsmd+mpSMdWHJLYgs/iNE2eZsDmgA+yzLeQxk+2IKbzznj2HIX1gLQqHg7Yh
         jzIw==
X-Gm-Message-State: AC+VfDz98j5J1Fj1sp/C7NBW/eefcxlcTazVUuagsM3XmsCKCm8qk0Ak
        nc00+zaQ35iGeJl+RSUqQBClposvnNfCZZaFb6E=
X-Google-Smtp-Source: ACHHUZ74hYkDawUW0WJQlvYeMDw0pQKYrsLM1xjWznMqVZsLTownFItoGHR+rqczsq4O7/6SX3mgbQ==
X-Received: by 2002:a05:6512:3f0f:b0:4f3:b324:ea8 with SMTP id y15-20020a0565123f0f00b004f3b3240ea8mr4594590lfa.19.1686123378290;
        Wed, 07 Jun 2023 00:36:18 -0700 (PDT)
Received: from localhost ([171.25.193.78])
        by smtp.gmail.com with ESMTPSA id w18-20020a19c512000000b004f252f48e5fsm1731415lfe.40.2023.06.07.00.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:36:17 -0700 (PDT)
Date:   Wed, 7 Jun 2023 10:36:03 +0300
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Maxim Mikityanskiy <maxim@isovalent.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH bpf v3 1/2] bpf: Fix verifier tracking scalars on spill
Message-ID: <ZIAzY8C0-X6UXjY-@mail.gmail.com>
References: <20230606214246.403579-1-maxtram95@gmail.com>
 <20230606214246.403579-2-maxtram95@gmail.com>
 <11eb089f-9e71-856f-7f01-375176bd5edf@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11eb089f-9e71-856f-7f01-375176bd5edf@meta.com>
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 06 Jun 2023 at 18:32:37 -0700, Yonghong Song wrote:
> 
> 
> On 6/6/23 2:42 PM, Maxim Mikityanskiy wrote:
> > From: Maxim Mikityanskiy <maxim@isovalent.com>
> > 
> > The following scenario describes a verifier bypass in privileged mode
> > (CAP_BPF or CAP_SYS_ADMIN):
> > 
> > 1. Prepare a 32-bit rogue number.
> > 2. Put the rogue number into the upper half of a 64-bit register, and
> >     roll a random (unknown to the verifier) bit in the lower half. The
> >     rest of the bits should be zero (although variations are possible).
> > 3. Assign an ID to the register by MOVing it to another arbitrary
> >     register.
> > 4. Perform a 32-bit spill of the register, then perform a 32-bit fill to
> >     another register. Due to a bug in the verifier, the ID will be
> >     preserved, although the new register will contain only the lower 32
> >     bits, i.e. all zeros except one random bit.
> > 
> > At this point there are two registers with different values but the same
> > ID, which means the integrity of the verifier state has been corrupted.
> > Next steps show the actual bypass:
> > 
> > 5. Compare the new 32-bit register with 0. In the branch where it's
> >     equal to 0, the verifier will believe that the original 64-bit
> >     register is also 0, because it has the same ID, but its actual value
> >     still contains the rogue number in the upper half.
> >     Some optimizations of the verifier prevent the actual bypass, so
> >     extra care is needed: the comparison must be between two registers,
> >     and both branches must be reachable (this is why one random bit is
> >     needed). Both branches are still suitable for the bypass.
> > 6. Right shift the original register by 32 bits to pop the rogue number.
> > 7. Use the rogue number as an offset with any pointer. The verifier will
> >     believe that the offset is 0, while in reality it's the given number.
> > 
> > The fix is similar to the 32-bit BPF_MOV handling in check_alu_op for
> > SCALAR_VALUE. If the spill is narrowing the actual register value, don't
> > keep the ID, make sure it's reset to 0.
> > 
> > Fixes: 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")
> > Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> 
> LGTM with a small nit below.
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> 
> > ---
> >   kernel/bpf/verifier.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5871aa78d01a..7be23eced561 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3856,6 +3856,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
> >   	mark_stack_slot_scratched(env, spi);
> >   	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
> >   	    !register_is_null(reg) && env->bpf_capable) {
> > +		bool reg_value_fits;
> > +
> >   		if (dst_reg != BPF_REG_FP) {
> >   			/* The backtracking logic can only recognize explicit
> >   			 * stack slot address like [fp - 8]. Other spill of
> > @@ -3867,7 +3869,12 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
> >   			if (err)
> >   				return err;
> >   		}
> > +
> > +		reg_value_fits = fls64(reg->umax_value) <= BITS_PER_BYTE * size;
> >   		save_register_state(state, spi, reg, size);
> > +		/* Break the relation on a narrowing spill. */
> > +		if (!reg_value_fits)
> > +			state->stack[spi].spilled_ptr.id = 0;
> 
> I think the code can be simplied like below:
> 
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4230,6 +4230,8 @@ static int check_stack_write_fixed_off(struct
> bpf_verifier_env *env,
>                                 return err;
>                 }
>                 save_register_state(state, spi, reg, size);
> +               if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
> +                       state->stack[spi].spilled_ptr.id = 0;
>         } else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
>                    insn->imm != 0 && env->bpf_capable) {
>                 struct bpf_reg_state fake_reg = {};
> 

That's true, I kept the variable to avoid churn when I send a follow-up
improvement:

+               /* Make sure that reg had an ID to build a relation on spill. */
+               if (reg_value_fits && !reg->id)
+                       reg->id = ++env->id_gen;
                save_register_state(state, spi, reg, size);

But yeah, I agree, let's simplify it for now, there is no guarantee that
the follow-up patch will be accepted as is. Thanks for the review!

> >   	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
> >   		   insn->imm != 0 && env->bpf_capable) {
> >   		struct bpf_reg_state fake_reg = {};
