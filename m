Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B5B77C4C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 02:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjHOAxp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 20:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjHOAxM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 20:53:12 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2540419A6;
        Mon, 14 Aug 2023 17:52:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5257669d4fbso51659a12.0;
        Mon, 14 Aug 2023 17:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692060761; x=1692665561;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VBXj6Q1qP6PeN9D3vFvsZujG8b242HgWd1gGmdiSLeg=;
        b=LWPPKd4whKGFKKdhsfmKztofDKvQXGYkq2R0Dth2wnpFb0we8TEEqeEM30dfTbcfGc
         OhSoguZwC9yQqe0NhYu29WsYc0bXye+3yr7KXJx28baG1hK0PQMmU4TmPZXBy+Pwd7+t
         ImlEOeoGzvEi/KQMKvLnLTr3OyJ//FcJTROwblpPYr2lI1teTPuuJ4i/+woGH5pIy+av
         5N9dOTgngWazsKB0v5RFDOKG0FGmx6iSg0DUqGzLtw/2C65tmD5ipPyldy1gTZqST44r
         RBUt+COR/JIX4AoaA90E1VfIV2mt5fbJq0Z2WigAjW8o769nju/eqKRN95KvUVQ2dvPy
         ku/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692060761; x=1692665561;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VBXj6Q1qP6PeN9D3vFvsZujG8b242HgWd1gGmdiSLeg=;
        b=HWTLBcuy4lllwiF629hH+Jlm2vG8RNR4QPFuPc+zzi7SG39Yxz+neYhxN2OIeDmg7S
         qk9+cVxbT3os/RQjJznIeNYVR6Na4GTPYBstQhtW44NN599mLPrAt+iX9NgHTKQcLToY
         QY4fkNJbIWkUe91CxrChOlgaI9zzTybZttGCqP1dyTKz0+BKtLWQvNA4xVBdgJswrtg9
         4FkYq5JXP1yJBpw7o4Pma0i3M35izGUSf0KhaZNgXAXbUkBDPL/IKXSpmeEB0vZpXVRw
         LlpHxVAjN1nGtgx6eiABC5IhZz8cs2kdoy+hLwb+xEsf/TBGJNUSNN0jVwlZ0vYp05+1
         /NfQ==
X-Gm-Message-State: AOJu0Yyd+6QgjXDj5YFYqwbc8MbtGOcsYX6gz81OL0hZi/MBcl9WhjGu
        hrwIX/KSBlb1lOxnlWw6JPQ=
X-Google-Smtp-Source: AGHT+IFxIWCawPFp6LUY+j33M3J8fAuovTqg1U9YMafVTNMHsbMLqOASSn7V+Qg1wgOUlruNEUzudA==
X-Received: by 2002:aa7:c607:0:b0:525:5ea1:419c with SMTP id h7-20020aa7c607000000b005255ea1419cmr3492818edq.9.1692060761262;
        Mon, 14 Aug 2023 17:52:41 -0700 (PDT)
Received: from [192.168.1.95] (grateful-telephoner.volia.net. [93.74.79.183])
        by smtp.gmail.com with ESMTPSA id l10-20020aa7c3ca000000b005255ddb67c7sm2428856edr.40.2023.08.14.17.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 17:52:40 -0700 (PDT)
Message-ID: <ad3db96c97aea916d555c76069490a176f634ccb.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf, x64: Fix tailcall infinite loop
 bug
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, x86@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mykolal@fb.com,
        shuah@kernel.org, davem@davemloft.net, dsahern@kernel.org,
        tangyeechou@gmail.com, kernel-patches-bot@fb.com,
        maciej.fijalkowski@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date:   Tue, 15 Aug 2023 03:52:38 +0300
In-Reply-To: <20230814134147.70289-2-hffilwlqm@gmail.com>
References: <20230814134147.70289-1-hffilwlqm@gmail.com>
         <20230814134147.70289-2-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 2023-08-14 at 21:41 +0800, Leon Hwang wrote:
> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
> handling in JIT"), the tailcall on x64 works better than before.
>=20
> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprogram=
s
> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
>=20
> From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF program
> to other BPF programs"), BPF program is able to trace other BPF programs.
>=20
> How about combining them all together?
>=20
> 1. FENTRY/FEXIT on a BPF subprogram.
> 2. A tailcall runs in the BPF subprogram.
> 3. The tailcall calls itself.
>=20
> As a result, a tailcall infinite loop comes up. And the loop halts the
> machine.
>=20
> As we know, in tail call context, the tail_call_cnt propagates by stack
> and RAX register between BPF subprograms. So do it in FENTRY/FEXIT
> trampolines.

Hi Leon,

I'm not familiar with this part of the jit compiler, so decided that
taking a look at your series might be a good learning point.
I think I got the gist of it, but I don't understand where
the initial value of RAX (=3D=3D 0) is coming from in
arch_prepare_bpf_trampoline(), could you please help me out?

Also a nitpick:
- in arch_prepare_bpf_trampoline() there is a comment detailing=20
  the stack layout, it probably should be updated to say that
  tail call count is stored as well;
- before arch_prepare_bpf_trampoline() there is a comment with
  an example of generated assembly, should it be updated?

Thanks,
Eduard

>=20
> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling=
 in JIT")
> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64=
 JIT")
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 23 +++++++++++++++++++----
>  include/linux/bpf.h         |  6 ++++++
>  kernel/bpf/trampoline.c     |  5 +++--
>  kernel/bpf/verifier.c       |  9 +++++++--
>  4 files changed, 35 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index a5930042139d3..ca5366d97ad04 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1018,6 +1018,10 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u=
8 src_reg, bool is64, u8 op)
> =20
>  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
> =20
> +/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
> +#define RESTORE_TAIL_CALL_CNT(stack)				\
> +	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
> +
>  static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *=
rw_image,
>  		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
>  {
> @@ -1623,9 +1627,7 @@ st:			if (is_imm8(insn->off))
> =20
>  			func =3D (u8 *) __bpf_call_base + imm32;
>  			if (tail_call_reachable) {
> -				/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
> -				EMIT3_off32(0x48, 0x8B, 0x85,
> -					    -round_up(bpf_prog->aux->stack_depth, 8) - 8);
> +				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
>  				if (!imm32)
>  					return -EINVAL;
>  				offs =3D 7 + x86_call_depth_emit_accounting(&prog, func);
> @@ -2464,6 +2466,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
>  	else
>  		/* sub rsp, stack_size */
>  		EMIT4(0x48, 0x83, 0xEC, stack_size);
> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +		EMIT1(0x50);		/* push rax */
>  	/* mov QWORD PTR [rbp - rbx_off], rbx */
>  	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
> =20
> @@ -2516,6 +2520,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
>  		restore_regs(m, &prog, regs_off);
>  		save_args(m, &prog, arg_stack_off, true);
> =20
> +		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +			/* Before calling the original function, restore the
> +			 * tail_call_cnt from stack.
> +			 */
> +			RESTORE_TAIL_CALL_CNT(stack_size);
> +
>  		if (flags & BPF_TRAMP_F_ORIG_STACK) {
>  			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
>  			EMIT2(0xff, 0xd0); /* call *rax */
> @@ -2569,7 +2579,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
>  			ret =3D -EINVAL;
>  			goto cleanup;
>  		}
> -	}
> +	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +		/* Before running the original function, restore the
> +		 * tail_call_cnt from stack.
> +		 */
> +		RESTORE_TAIL_CALL_CNT(stack_size);
> +
>  	/* restore return value of orig_call or fentry prog back into RAX */
>  	if (save_ret)
>  		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cfabbcf47bdb8..55c72086034ef 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1028,6 +1028,11 @@ struct btf_func_model {
>   */
>  #define BPF_TRAMP_F_SHARE_IPMODIFY	BIT(6)
> =20
> +/* Indicate that current trampoline is in a tail call context. Then, it =
has to
> + * cache and restore tail_call_cnt to avoid infinite tail call loop.
> + */
> +#define BPF_TRAMP_F_TAIL_CALL_CTX	BIT(7)
> +
>  /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is =
~50
>   * bytes on x86.
>   */
> @@ -1147,6 +1152,7 @@ struct bpf_attach_target_info {
>  	struct module *tgt_mod;
>  	const char *tgt_name;
>  	const struct btf_type *tgt_type;
> +	bool tail_call_ctx;
>  };
> =20
>  #define BPF_DISPATCHER_MAX 48 /* Fits in 2048B */
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 78acf28d48732..0fae334e3f7b8 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -415,8 +415,8 @@ static int bpf_trampoline_update(struct bpf_trampolin=
e *tr, bool lock_direct_mut
>  		goto out;
>  	}
> =20
> -	/* clear all bits except SHARE_IPMODIFY */
> -	tr->flags &=3D BPF_TRAMP_F_SHARE_IPMODIFY;
> +	/* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
> +	tr->flags &=3D (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL_CTX)=
;
> =20
>  	if (tlinks[BPF_TRAMP_FEXIT].nr_links ||
>  	    tlinks[BPF_TRAMP_MODIFY_RETURN].nr_links) {
> @@ -783,6 +783,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
> =20
>  	memcpy(&tr->func.model, &tgt_info->fmodel, sizeof(tgt_info->fmodel));
>  	tr->func.addr =3D (void *)tgt_info->tgt_addr;
> +	tr->flags =3D (tgt_info->tail_call_ctx ? BPF_TRAMP_F_TAIL_CALL_CTX : 0)=
;
>  out:
>  	mutex_unlock(&tr->mutex);
>  	return tr;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4ccca1f6c9981..a78e5a2ae5c72 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19400,10 +19400,15 @@ int bpf_check_attach_target(struct bpf_verifier=
_log *log,
>  			return -EINVAL;
>  		fallthrough;
>  	case BPF_MODIFY_RETURN:
> -	case BPF_LSM_MAC:
> -	case BPF_LSM_CGROUP:
>  	case BPF_TRACE_FENTRY:
>  	case BPF_TRACE_FEXIT:
> +		if (tgt_prog && subprog > 0 &&
> +		    tgt_prog->aux->func[subprog]->is_func &&
> +		    tgt_prog->aux->tail_call_reachable)
> +			tgt_info->tail_call_ctx =3D true;
> +		fallthrough;
> +	case BPF_LSM_MAC:
> +	case BPF_LSM_CGROUP:
>  		if (!btf_type_is_func(t)) {
>  			bpf_log(log, "attach_btf_id %u is not a function\n",
>  				btf_id);

