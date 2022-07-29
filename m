Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF03C5853AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jul 2022 18:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbiG2Qm1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Jul 2022 12:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbiG2QmO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Jul 2022 12:42:14 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F6189ABC
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Jul 2022 09:41:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y141so5079463pfb.7
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Jul 2022 09:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=NMO1jQ66pV4SyLO5boYVc0i/NxNBqasynsQS7DccqC0=;
        b=KQgUachRwUkIv7hgz2rl5L7Qo5kIaR3Ait+15YWM4aNAbxbitpAy+QkfVdXrPZEosx
         /rTxnmdmshDe3SnGX+y9S8w7jyL4rDAv2G2qaG4J2V9w5/DsoHUQq6BW3JFuGCcjgwmb
         6m68gtBvKabThaKC2YcyPot+BRBCZy9vj8flkP/s6aM9QWRPuZcJ72J9OGh6wvwpeLeX
         X5pqw8rO3P/ESZ7CWIoZJK7wo/IuMxmdZA8YHM6KSA4xXupmlCcKzIsJC3xUPz/jbUwK
         nmpTPAo634sHOh0AtC9e3h1ejNJkBAlCIsvdT1ZpVCwE63uIm/YZSoe31WRWSNHEYjmQ
         hi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=NMO1jQ66pV4SyLO5boYVc0i/NxNBqasynsQS7DccqC0=;
        b=eG5z0f/wPF09ZwcQxY+oeR59dgtmPj+B3bE0gNjG3ZbWDlwgeQMCSdkuu7cDGF2gLR
         HzQACfFAiyDUJr5B3Sz/stfycwHD/2xGCRYvW7sC5uSDduZ2AsdDXCQg4sACfDEUzWZA
         iSB8OPOLik+fS4wMaHqa7TocZXXjD87Rw0EUM6jWiRweEXTt11DPv/m2RtgvFWpZYOiC
         AyJrrfbw4dy9+uUTYvirCDbBf1cjiypgtk3c2xdZvrDyWtQGCEyDJWkp5k+z8fzmtt9Z
         NL5hDxpeXPVzaash9V/fb2DjLWpNv02mJm2DuLEnjwYl9mV23z+lCmT84OdsFvv932FU
         ztkQ==
X-Gm-Message-State: AJIora8kspdX4mQz16r0hB83QYJQrzzpc4hKf1O+xFWKWvprucZu46Pb
        Ua4T0tE2rIhvOQfXuGBV/oeJdg==
X-Google-Smtp-Source: AGRyM1vxD4hWgholSGw8b/eiQmq8OQbeLIC6DbpYb5joh47IFXKCNZESMdfhbbenyH/gFuPogFVvYw==
X-Received: by 2002:a63:155f:0:b0:41b:6acb:68b6 with SMTP id 31-20020a63155f000000b0041b6acb68b6mr3576780pgv.225.1659112913281;
        Fri, 29 Jul 2022 09:41:53 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b0016d3a354cffsm3813041plm.89.2022.07.29.09.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 09:41:52 -0700 (PDT)
Date:   Fri, 29 Jul 2022 16:41:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Michal Luczaj <mhal@rbox.co>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pbonzini@redhat.com, shuah@kernel.org
Subject: Re: [PATCH 1/2] KVM: x86: emulator: Fix illegal LEA handling
Message-ID: <YuQNzIOGtOep/qGG@google.com>
References: <20220729134801.1120-1-mhal@rbox.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729134801.1120-1-mhal@rbox.co>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 29, 2022, Michal Luczaj wrote:
> The emulator mishandles LEA with register source operand. Even though such
> LEA is illegal, it can be encoded and fed to CPU. In which case real
> hardware throws #UD. The emulator, instead, returns address of
> x86_emulate_ctxt._regs. This info leak hurts host's kASLR.
> 
> Tell the decoder that illegal LEA is not to be emulated.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> What the emulator does for LEA is simply:
> 	
> 	case 0x8d: /* lea r16/r32, m */
> 		ctxt->dst.val = ctxt->src.addr.mem.ea;
> 		break;
> 
> And it makes sense if you assume that LEA's source operand is always
> memory. But because there is a race window between VM-exit and the decoder
> instruction fetch, emulator can be force fed an arbitrary opcode of choice.
> Including some that are simply illegal and would cause #UD in normal
> circumstances. Such as a LEA with a register-direct source operand -- for
> which the emulator sets `op->addr.reg`, but reads `op->addr.mem.ea`.
> 
> 		union {
> 			unsigned long *reg;
> 			struct segmented_address {
> 				ulong ea;
> 				unsigned seg;
> 			} mem;
> 			...
> 		} addr;
> 
> Because `reg` and `mem` are in union, emulator reveals address in host's
> memory.
> 
> I hope this patch is not considered an `instr_dual` abuse?

Nope, definitely not abuse.  This is very similar to how both SVM and VMX usurped
"reserved" Mod=3 (register) encodings from SGDT, SIDT, LGDT, LIDT, and INVLPG
to implement virtualization instructions.  I.e. if the Mod=3 encoding is ever
repurposed, then using instr_dual will become necessary.  I'm actually somewhat
surprised that Mod=3 hasn't already been repurposed.

>  arch/x86/kvm/emulate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index f8382abe22ff..7c14706372d0 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -4566,6 +4566,10 @@ static const struct mode_dual mode_dual_63 = {
>  	N, I(DstReg | SrcMem32 | ModRM | Mov, em_movsxd)
>  };
>  
> +static const struct instr_dual instr_dual_8d = {
> +	D(DstReg | SrcMem | ModRM | NoAccess), N
> +};
> +
>  static const struct opcode opcode_table[256] = {
>  	/* 0x00 - 0x07 */
>  	F6ALU(Lock, em_add),
> @@ -4622,7 +4626,7 @@ static const struct opcode opcode_table[256] = {
>  	I2bv(DstMem | SrcReg | ModRM | Mov | PageTable, em_mov),
>  	I2bv(DstReg | SrcMem | ModRM | Mov, em_mov),
>  	I(DstMem | SrcNone | ModRM | Mov | PageTable, em_mov_rm_sreg),
> -	D(ModRM | SrcMem | NoAccess | DstReg),
> +	ID(0, &instr_dual_8d),

Somewhat tentatively because I'm terrible at reading the emulator's decoder, but
this looks correct...

Reviewed-by: Sean Christopherson <seanjc@google.com>

>  	I(ImplicitOps | SrcMem16 | ModRM, em_mov_sreg_rm),
>  	G(0, group1A),
>  	/* 0x90 - 0x97 */
> -- 
> 2.32.0
> 
