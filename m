Return-Path: <linux-kselftest+bounces-49097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 975A8D2D798
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18BC130028AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 07:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF7FB67E;
	Fri, 16 Jan 2026 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue/kZJSQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4EF2D322E;
	Fri, 16 Jan 2026 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549813; cv=none; b=HqMbGlg0YrDhmo71WHt36rPy8G2Sg1VwgFkM6eu8SaIaC+X9X4YkrvvSTMPZu/gm7WYy+okKvQIGWspOzvgyVeYLS2wQvGLTJaV1AkKRlALoJduvKmaLgcis4MzPbBGD06Z+UdYAY1yBcXbTEcsLXMIwYmqyjv5w/09tDlEYqaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549813; c=relaxed/simple;
	bh=YXmaVdah014ZVqknQvzp8N6sFEg6IjrWIef9VuBaPsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWeZCLiVJh7tyUc07YReR4nibIUQhdx/MOVTbhi5tfQ7JwtCGWsT0Oi2WvfAEFVJjCGZbF4mAtLGGr7zbju+0ytbhx0hlTXp6M3uppNYUQkHAzp/N4gxHkQWA86tNoKHkCQ16DvejP9a9jm846EivwzVg1CEfXLc48StjZt9wv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue/kZJSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E4BC116C6;
	Fri, 16 Jan 2026 07:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768549812;
	bh=YXmaVdah014ZVqknQvzp8N6sFEg6IjrWIef9VuBaPsY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ue/kZJSQwc1sUQCqQZSnb/Hq+x94wOb6OUAkY6QP7gzrjbPoOZN7uphi4XAxQx4ta
	 oR9ryg8KYiRfXifpxczxGxaPy9SDJlcSOBCblAD2XdFvODkNBWs70QyUqpXAsYRW4p
	 RTFnd5z9+ARqEcg3Sd/e//3u6nQaCkX9Aj9JjdkDJFt+NjgthKUwlinsIaOtxfFNyj
	 D13fvM31991JYi/iH4W2Nv/hzn3gHcKYNE391SDg6c2ln5ljEGZP46GzMGYVxIGaF0
	 LB8Iln8smTR1/ESEJCiNQa83UyHf5uz3Tg9pWHMdqQ4tA8LND2b6ZG3J88hYIUiiWE
	 pWgMD8B280jkw==
Message-ID: <ea66ddc5-984f-4873-993d-9de1140d7e6e@kernel.org>
Date: Fri, 16 Jan 2026 08:49:56 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] powerpc64/bpf: Support tailcalls with subprogs
To: Hari Bathini <hbathini@linux.ibm.com>, adubey <adubey@imap.linux.ibm.com>
Cc: adubey@linux.ibm.com, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 sachinpb@linux.ibm.com, venkat88@linux.ibm.com, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, naveen@kernel.org, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com, iii@linux.ibm.com,
 shuah@kernel.org
References: <20260114114450.30405-1-adubey@linux.ibm.com>
 <20260114114450.30405-3-adubey@linux.ibm.com>
 <42d41a0d-9d26-4eeb-af46-200083261c09@kernel.org>
 <2d242f4476b61373da236d24272b0ec3@imap.linux.ibm.com>
 <78536979-e924-4be3-b847-332802ad82e2@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <78536979-e924-4be3-b847-332802ad82e2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/01/2026 à 05:50, Hari Bathini a écrit :

Not received this mail that Hari is reponding to.

> 
> 
> On 14/01/26 6:33 pm, adubey wrote:
>> On 2026-01-14 17:57, Christophe Leroy (CS GROUP) wrote:
>>> Le 14/01/2026 à 12:44, adubey@linux.ibm.com a écrit :
>>>> From: Abhishek Dubey <adubey@linux.ibm.com>
>>>>
>>>> Enabling tailcalls with subprog combinations by referencing
>>>> method. The actual tailcall count is always maintained in the
>>>> tail_call_info variable present in the frame of main function
>>>> (also called entry function). The tail_call_info variables in
>>>> the frames of all other subprog contains reference to the
>>>> tail_call_info present in frame of main function.
>>>>
>>>> Dynamic resolution interprets the tail_call_info either as
>>>> value or reference depending on the context of active frame
>>>> while tailcall is invoked.
>>>>
>>>> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
>>>> ---
>>>>   arch/powerpc/net/bpf_jit.h        | 12 +++++-
>>>>   arch/powerpc/net/bpf_jit_comp.c   | 10 ++++-
>>>>   arch/powerpc/net/bpf_jit_comp64.c | 68 ++++++++++++++++++++++ 
>>>> +--------
>>>>   3 files changed, 70 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
>>>> index 45d419c0ee73..5d735bc5e6bd 100644
>>>> --- a/arch/powerpc/net/bpf_jit.h
>>>> +++ b/arch/powerpc/net/bpf_jit.h
>>>> @@ -51,6 +51,12 @@
>>>>           EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | 
>>>> (offset & 0xfffc));                    \
>>>>       } while (0)
>>>>   +/* Same as PPC_BCC_SHORT, except valid dest is known prior to 
>>>> call. */
>>>> +#define PPC_COND_BRANCH(cond, dest)         \
>>>> +    do {                                      \
>>>> +        long offset = (long)(dest) - CTX_NIA(ctx);              \
>>>> +        EMIT(PPC_INST_BRANCH_COND | (((cond) & 0x3ff) << 16) | 
>>>> (offset & 0xfffc));    \
>>>> +    } while (0)
>>>
>>> I don't like the idea of duplicating PPC_BCC_SHORT() to just kick the
>>> verification out. Now we will have two macros doing the exact same
>>> thing with one handling failure case and one ignoring failure case.
>>> There is a big risk that one day or another someone will use the wrong
>>> macro.
>>>
>>> Could you change bpf_jit_build_prologue() to return an int add use
>>> PPC_BCC_SHORT() instead of that new PPC_COND_BRANCH() ?
>> I implemented exactly same change in bpf_jit_build_prologue(). But, 
>> during internal review, @HariBathini suggested
>> to have separate macro with a caution note.
>>
>> @Hari please suggest here!
> 
> Not just about the change of return type but the check seems like an
> overkill for cases where the offset is known and within branch range.
> How about using BUILD_BUG_ON() to avoid unecessary checks and
> return type change for places where the branch offset is known
> and is a constant?

When offset is a constant known at build time, checks are eliminated by 
gcc at build, see exemple below from disasembly of bpf_jit_comp32.o, 
there are no checks.

                                 PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 4);
     36d8:       3c 80 41 81     lis     r4,16769
                                 EMIT(PPC_RAW_CMPLW(src_reg, _R0));
     36dc:       81 3f 00 04     lwz     r9,4(r31)
                                 PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 4);
     36e0:       60 84 00 10     ori     r4,r4,16
                                 EMIT(PPC_RAW_CMPLW(src_reg, _R0));
     36e4:       39 29 00 01     addi    r9,r9,1
                                 PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 4);
     36e8:       55 23 10 3a     slwi    r3,r9,2
                                 EMIT(PPC_RAW_CMPLW(src_reg, _R0));
     36ec:       91 3f 00 04     stw     r9,4(r31)
                                 PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 4);
     36f0:       7c 97 19 2e     stwx    r4,r23,r3
                                 EMIT(PPC_RAW_LI(dst_reg, 0));
     36f4:       55 49 a9 94     rlwinm  r9,r10,21,6,10
                                 PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 4);
     36f8:       80 9f 00 04     lwz     r4,4(r31)
                                 EMIT(PPC_RAW_LI(dst_reg, 0));
     36fc:       65 29 38 00     oris    r9,r9,14336
                                 PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 4);
     3700:       38 84 00 01     addi    r4,r4,1
                                 EMIT(PPC_RAW_LI(dst_reg, 0));
     3704:       54 83 10 3a     slwi    r3,r4,2
                                 PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 4);
     3708:       90 9f 00 04     stw     r4,4(r31)
                                 EMIT(PPC_RAW_LI(dst_reg, 0));
     370c:       7d 37 19 2e     stwx    r9,r23,r3


> 
>>>
>>>>   /*
>>>>    * Sign-extended 32-bit immediate load
>>>>    *
>>>> @@ -75,6 +81,8 @@
>>>>     /* for tailcall counter */
>>>>   #define BPF_PPC_TAILCALL        8
>>>> +/* for gpr non volatile registers BPG_REG_6 to 10 */
>>>> +#define BPF_PPC_STACK_SAVE      (6*8)
>>>
>>> Add spaces before and after the *
>>>
>>>>     /* If dummy pass (!image), account for maximum possible 
>>>> instructions */
>>>>   #define PPC_LI64(d, i)        do {                          \
>>>> @@ -170,6 +178,7 @@ struct codegen_context {
>>>>       unsigned int alt_exit_addr;
>>>>       u64 arena_vm_start;
>>>>       u64 user_vm_start;
>>>> +    bool is_subprog;
>>>>   };
>>>>     #define bpf_to_ppc(r)    (ctx->b2p[r])
>>>> @@ -204,11 +213,10 @@ void bpf_jit_build_epilogue(u32 *image, struct 
>>>> codegen_context *ctx);
>>>>   void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context 
>>>> *ctx);
>>>>   void bpf_jit_realloc_regs(struct codegen_context *ctx);
>>>>   int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context 
>>>> *ctx, int tmp_reg, long exit_addr);
>>>> -
>>>>   int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 
>>>> *fimage, int pass,
>>>>                 struct codegen_context *ctx, int insn_idx,
>>>>                 int jmp_off, int dst_reg, u32 code);
>>>> -
>>>
>>> Not sure why this patch needs to remove those blank lines here and 
>>> above.
>>>
>>>> +int bpf_jit_stack_tailcallinfo_offset(struct codegen_context *ctx);
>>>>   #endif
>>>>     #endif
>>>> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/ 
>>>> bpf_jit_comp.c
>>>> index 5e976730b2f5..069a8822c30d 100644
>>>> --- a/arch/powerpc/net/bpf_jit_comp.c
>>>> +++ b/arch/powerpc/net/bpf_jit_comp.c
>>>> @@ -206,6 +206,7 @@ struct bpf_prog *bpf_int_jit_compile(struct 
>>>> bpf_prog *fp)
>>>>       cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
>>>>       cgctx.arena_vm_start = bpf_arena_get_kern_vm_start(fp->aux- 
>>>> >arena);
>>>>       cgctx.user_vm_start = bpf_arena_get_user_vm_start(fp->aux- 
>>>> >arena);
>>>> +    cgctx.is_subprog = bpf_is_subprog(fp);
>>>>         /* Scouting faux-generate pass 0 */
>>>>       if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, 
>>>> false)) {
>>>> @@ -435,6 +436,11 @@ void bpf_jit_free(struct bpf_prog *fp)
>>>>       bpf_prog_unlock_free(fp);
>>>>   }
>>>>   +bool bpf_jit_supports_subprog_tailcalls(void)
>>>> +{
>>>> +    return IS_ENABLED(CONFIG_PPC64);
>>>> +}
>>>> +
>>>>   bool bpf_jit_supports_kfunc_call(void)
>>>>   {
>>>>       return true;
>>>> @@ -604,7 +610,7 @@ static void 
>>>> bpf_trampoline_setup_tail_call_cnt(u32 *image, struct codegen_contex
>>>>                              int func_frame_offset, int r4_off)
>>>>   {
>>>>       if (IS_ENABLED(CONFIG_PPC64)) {
>>>> -        /* See bpf_jit_stack_tailcallcnt() */
>>>> +        /* See bpf_jit_stack_tailcallinfo_offset() */
>>>>           int tailcallcnt_offset = 7 * 8;
>>>>             EMIT(PPC_RAW_LL(_R3, _R1, func_frame_offset - 
>>>> tailcallcnt_offset));
>>>> @@ -619,7 +625,7 @@ static void 
>>>> bpf_trampoline_restore_tail_call_cnt(u32 *image, struct codegen_cont
>>>>                            int func_frame_offset, int r4_off)
>>>>   {
>>>>       if (IS_ENABLED(CONFIG_PPC64)) {
>>>> -        /* See bpf_jit_stack_tailcallcnt() */
>>>> +        /* See bpf_jit_stack_tailcallinfo_offset() */
>>>>           int tailcallcnt_offset = 7 * 8;
>>>>             EMIT(PPC_RAW_LL(_R3, _R1, -tailcallcnt_offset));
>>>> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/ 
>>>> bpf_jit_comp64.c
>>>> index 39061cd742c1..cebf81fbd59f 100644
>>>> --- a/arch/powerpc/net/bpf_jit_comp64.c
>>>> +++ b/arch/powerpc/net/bpf_jit_comp64.c
>>>> @@ -26,8 +26,12 @@
>>>>    * Ensure the top half (upto local_tmp_var) stays consistent
>>>>    * with our redzone usage.
>>>>    *
>>>> + * tail_call_info - stores tailcall count value in main program's
>>>> + *                  frame, stores reference to tail_call_info of
>>>> + *                  main's frame in sub-prog's frame.
>>>> + *
>>>>    *        [    prev sp        ] <-------------
>>>> - *        [    tail_call_cnt    ] 8        |
>>>> + *        [    tail_call_info    ] 8        |
>>>>    *        [   nv gpr save area    ] 6*8        |
>>>>    *        [    local_tmp_var    ] 24        |
>>>>    * fp (r31) -->    [   ebpf stack space    ] upto 512    |
>>>> @@ -35,8 +39,6 @@
>>>>    * sp (r1) --->    [    stack pointer    ] --------------
>>>>    */
>>>>   -/* for gpr non volatile registers BPG_REG_6 to 10 */
>>>> -#define BPF_PPC_STACK_SAVE    (6*8)
>>>>   /* for bpf JIT code internal usage */
>>>>   #define BPF_PPC_STACK_LOCALS    24
>>>>   /* stack frame excluding BPF stack, ensure this is quadword 
>>>> aligned */
>>>> @@ -98,7 +100,7 @@ static inline bool bpf_has_stack_frame(struct 
>>>> codegen_context *ctx)
>>>>    *        [    prev sp        ] <-------------
>>>>    *        [      ...           ]         |
>>>>    * sp (r1) --->    [    stack pointer    ] --------------
>>>> - *        [    tail_call_cnt    ] 8
>>>> + *        [    tail_call_info    ] 8
>>>>    *        [   nv gpr save area    ] 6*8
>>>>    *        [    local_tmp_var    ] 24
>>>>    *        [   unused red zone    ] 224
>>>> @@ -114,7 +116,7 @@ static int bpf_jit_stack_local(struct 
>>>> codegen_context *ctx)
>>>>       }
>>>>   }
>>>>   -static int bpf_jit_stack_tailcallcnt(struct codegen_context *ctx)
>>>> +int bpf_jit_stack_tailcallinfo_offset(struct codegen_context *ctx)
>>>>   {
>>>>       return bpf_jit_stack_local(ctx) + BPF_PPC_STACK_LOCALS + 
>>>> BPF_PPC_STACK_SAVE;
>>>>   }
>>>> @@ -147,17 +149,32 @@ void bpf_jit_build_prologue(u32 *image, struct 
>>>> codegen_context *ctx)
>>>>   #endif
>>>>         /*
>>>> -     * Initialize tail_call_cnt if we do tail calls.
>>>> -     * Otherwise, put in NOPs so that it can be skipped when we are
>>>> -     * invoked through a tail call.
>>>> +     * Tail call count(tcc) is saved & updated only in main
>>>> +     * program's frame and the address of tcc in main program's
>>>> +     * frame (tcc_ptr) is saved in subprogs frame.
>>>> +     *
>>>> +     * Offset of tail_call_info on any frame will be interpreted
>>>> +     * as either tcc_ptr or tcc value depending on whether it is
>>>> +     * greater than MAX_TAIL_CALL_CNT or not.
>>>>        */
>>>> -    if (ctx->seen & SEEN_TAILCALL) {
>>>> +    if (!ctx->is_subprog) {
>>>>           EMIT(PPC_RAW_LI(bpf_to_ppc(TMP_REG_1), 0));
>>>>           /* this goes in the redzone */
>>>>           EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, - 
>>>> (BPF_PPC_TAILCALL)));
>>>>       } else {
>>>> -        EMIT(PPC_RAW_NOP());
>>>> -        EMIT(PPC_RAW_NOP());
>>>> +        /*
>>>> +         * if tail_call_info < MAX_TAIL_CALL_CNT
>>>> +         *     main prog calling first subprog -> copy reference
>>>> +         * else
>>>> +         *     subsequent subprog calling another subprog -> 
>>>> directly copy content
>>>> +         */
>>>> +        EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, 0));
>>>> +        EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), 
>>>> bpf_to_ppc(TMP_REG_2), -(BPF_PPC_TAILCALL)));
>>>> +        EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), 
>>>> MAX_TAIL_CALL_CNT));
>>>> +        PPC_COND_BRANCH(COND_GT, CTX_NIA(ctx) + 8);
>>>> +        EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), 
>>>> bpf_to_ppc(TMP_REG_2),
>>>> +                            -(BPF_PPC_TAILCALL)));
>>>> +        EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, - 
>>>> (BPF_PPC_TAILCALL)));
>>>>       }
>>>>         if (bpf_has_stack_frame(ctx)) {
>>>> @@ -352,19 +369,38 @@ static int bpf_jit_emit_tail_call(u32 *image, 
>>>> struct codegen_context *ctx, u32 o
>>>>       EMIT(PPC_RAW_CMPLW(b2p_index, bpf_to_ppc(TMP_REG_1)));
>>>>       PPC_BCC_SHORT(COND_GE, out);
>>>>   +    EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R1, 
>>>> bpf_jit_stack_tailcallinfo_offset(ctx)));
>>>> +    EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
>>>> +    PPC_COND_BRANCH(COND_LE, CTX_NIA(ctx) + 8);
>>>> +
>>>> +    /* dereference TMP_REG_1 */
>>>> +    EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), 0));
>>>> +
>>>>       /*
>>>> -     * if (tail_call_cnt >= MAX_TAIL_CALL_CNT)
>>>> +     * if (tail_call_info == MAX_TAIL_CALL_CNT)
>>>>        *   goto out;
>>>>        */
>>>> -    EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R1, 
>>>> bpf_jit_stack_tailcallcnt(ctx)));
>>>>       EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
>>>> -    PPC_BCC_SHORT(COND_GE, out);
>>>> +    PPC_COND_BRANCH(COND_EQ, out);
>>>>         /*
>>>> -     * tail_call_cnt++;
>>>> +     * tail_call_info++; <- Actual value of tcc here
>>>>        */
>>>>       EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), 
>>>> bpf_to_ppc(TMP_REG_1), 1));
>>>> -    EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), _R1, 
>>>> bpf_jit_stack_tailcallcnt(ctx)));
>>>> +
>>>> +    /*
>>>> +     * Before writing updated tail_call_info, distinguish if 
>>>> current frame
>>>> +     * is storing a reference to tail_call_info or actual tcc value in
>>>> +     * tail_call_info.
>>>> +     */
>>>> +    EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, 
>>>> bpf_jit_stack_tailcallinfo_offset(ctx)));
>>>> +    EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
>>>> +    PPC_COND_BRANCH(COND_GT, CTX_NIA(ctx) + 8);
>>>> +
>>>> +    /* First get address of tail_call_info */
>>>> +    EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_2), _R1, 
>>>> bpf_jit_stack_tailcallinfo_offset(ctx)));
>>>> +    /* Writeback updated value to tail_call_info */
>>>> +    EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2), 
>>>> 0));
>>>>         /* prog = array->ptrs[index]; */
>>>>       EMIT(PPC_RAW_MULI(bpf_to_ppc(TMP_REG_1), b2p_index, 8));
>> -Abhishek
> 


