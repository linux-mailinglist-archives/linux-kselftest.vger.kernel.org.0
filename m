Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0833677C62F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 05:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjHODBe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 23:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbjHODBT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 23:01:19 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79031173D;
        Mon, 14 Aug 2023 20:01:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68783004143so3217296b3a.2;
        Mon, 14 Aug 2023 20:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692068478; x=1692673278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5C/1PvUiL8DSfmWpsIxllcEjbtqgJK+mdWQGka7G2A=;
        b=Z7PpLQ6VpbDrzZJFUYNRb4Ug+0z55YYTyXVv3fZQgB+W6GrZmWItYTYsfnJEEVWY2a
         fDCaqAQ4oJrZjA+8xZxD9C0sa9L2JO+eK1rgJwHApSCpXqJw9j8Syt+fAanSkTpMtr42
         vAl8Ux9IFqgg8PoV37ArJmpHP+FoSMIg+pehOWqJ9smRwsi7NGc8GwDr4zf5BsXu6m3j
         ossC+fuVbDJbQ+NFIgiHhDLRcc5kut8hF5nrZfjaNgRUn3xsNgtHIcp+lFMcuxoowUaE
         Gu35UMZs7lcQisZdy5LAF2YlkiYc6HyYBOA0qjp0QaRcMtVWK1nEq2J4DeQPPBNsnBHi
         SeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692068478; x=1692673278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5C/1PvUiL8DSfmWpsIxllcEjbtqgJK+mdWQGka7G2A=;
        b=dz+uv1UXwciaDBe0e00XyNjNlNcrUbIbN5qF9bTyaGZsCJiqQ2pYNs7XuMWi9v+/Vx
         XLPoJvAAx9YodQk7yK74PAlCFtR4T5IzPcQS3DfucyTCNwUvrThuNdRY4moZ2AdNTD7P
         sqRoaT2Tit2b1F4RZypeVE8KOpMi7eJkYyjGY6tOXp++FVx/E2oZcc5NdRfV76ZZOMMR
         LZdehcovqkxNjIKJS8PEjJG+32JDQuJ2QJGBMBZ4tcYC4bP73Q4o1mOiZ8u/bNdLcHaL
         bS0y5HRKVkbu13H9IwyHtyQJsOHvuVdoMQJmGdLgA9/Ht61gZ7vpbgAZ2TWe8zMxzxHF
         P7Ug==
X-Gm-Message-State: AOJu0Yz7rVVc98mHFZbqCHrsdTGWsd/PBQho4oD3dld96h8d9cKD5ZHe
        iQj01n4UokRgcGrh6COf8bQ=
X-Google-Smtp-Source: AGHT+IHsxJ3ItPHxAF8wCs7z30D+sHHez/drJWRptmraQ/qUUQytMbj3/U0NlM5oAIjTETh6Zgc4+g==
X-Received: by 2002:a05:6a00:2e84:b0:687:1c2c:7cf7 with SMTP id fd4-20020a056a002e8400b006871c2c7cf7mr10793597pfb.19.1692068477711;
        Mon, 14 Aug 2023 20:01:17 -0700 (PDT)
Received: from [10.22.68.146] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id bu29-20020a63295d000000b005501b24b1c9sm688567pgb.62.2023.08.14.20.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 20:01:17 -0700 (PDT)
Message-ID: <43201fd2-dca7-9294-1dea-8460a9e99296@gmail.com>
Date:   Tue, 15 Aug 2023 11:01:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH bpf-next 1/2] bpf, x64: Fix tailcall infinite loop bug
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
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
References: <20230814134147.70289-1-hffilwlqm@gmail.com>
 <20230814134147.70289-2-hffilwlqm@gmail.com>
 <ad3db96c97aea916d555c76069490a176f634ccb.camel@gmail.com>
From:   Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <ad3db96c97aea916d555c76069490a176f634ccb.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 15/8/23 08:52, Eduard Zingerman wrote:
> On Mon, 2023-08-14 at 21:41 +0800, Leon Hwang wrote:
>> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
>> handling in JIT"), the tailcall on x64 works better than before.
>>
>> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
>> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
>>
>> From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF program
>> to other BPF programs"), BPF program is able to trace other BPF programs.
>>
>> How about combining them all together?
>>
>> 1. FENTRY/FEXIT on a BPF subprogram.
>> 2. A tailcall runs in the BPF subprogram.
>> 3. The tailcall calls itself.
>>
>> As a result, a tailcall infinite loop comes up. And the loop halts the
>> machine.
>>
>> As we know, in tail call context, the tail_call_cnt propagates by stack
>> and RAX register between BPF subprograms. So do it in FENTRY/FEXIT
>> trampolines.
> 
> Hi Leon,
> 
> I'm not familiar with this part of the jit compiler, so decided that
> taking a look at your series might be a good learning point.
> I think I got the gist of it, but I don't understand where
> the initial value of RAX (== 0) is coming from in
> arch_prepare_bpf_trampoline(), could you please help me out?
> 
> Also a nitpick:
> - in arch_prepare_bpf_trampoline() there is a comment detailing 
>   the stack layout, it probably should be updated to say that
>   tail call count is stored as well;
> - before arch_prepare_bpf_trampoline() there is a comment with
>   an example of generated assembly, should it be updated?
> 
> Thanks,
> Eduard
> 

a) Initial value of RAX is in emit_prologue().
	if (!ebpf_from_cbpf) {
		if (tail_call_reachable && !is_subprog)
			/* When it's the entry of the whole
			 * tailcall context, zeroing the RAX
			 * means init tail_call_cnt.
			 */
			EMIT2(0x31, 0xC0); /* xor eax, eax */
		else
			// Keep the same asm layout.
			EMIT2(0x66, 0x90); /* nop2 */
	}
   I'd like to add this comment to emit_prologue().

b) Good to update the stack layout. I'll do it.

c) Its comment will be updated also.

Thanks,
Leon

>>
>> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
>> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>> ---
>>  arch/x86/net/bpf_jit_comp.c | 23 +++++++++++++++++++----
>>  include/linux/bpf.h         |  6 ++++++
>>  kernel/bpf/trampoline.c     |  5 +++--
>>  kernel/bpf/verifier.c       |  9 +++++++--
>>  4 files changed, 35 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index a5930042139d3..ca5366d97ad04 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -1018,6 +1018,10 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
>>  
>>  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>>  
>> +/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
>> +#define RESTORE_TAIL_CALL_CNT(stack)				\
>> +	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
>> +
>>  static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
>>  		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
>>  {
>> @@ -1623,9 +1627,7 @@ st:			if (is_imm8(insn->off))
>>  
>>  			func = (u8 *) __bpf_call_base + imm32;
>>  			if (tail_call_reachable) {
>> -				/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
>> -				EMIT3_off32(0x48, 0x8B, 0x85,
>> -					    -round_up(bpf_prog->aux->stack_depth, 8) - 8);
>> +				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
>>  				if (!imm32)
>>  					return -EINVAL;
>>  				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
>> @@ -2464,6 +2466,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>  	else
>>  		/* sub rsp, stack_size */
>>  		EMIT4(0x48, 0x83, 0xEC, stack_size);
>> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
>> +		EMIT1(0x50);		/* push rax */
>>  	/* mov QWORD PTR [rbp - rbx_off], rbx */
>>  	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
>>  
>> @@ -2516,6 +2520,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>  		restore_regs(m, &prog, regs_off);
>>  		save_args(m, &prog, arg_stack_off, true);
>>  
>> +		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
>> +			/* Before calling the original function, restore the
>> +			 * tail_call_cnt from stack.
>> +			 */
>> +			RESTORE_TAIL_CALL_CNT(stack_size);
>> +
>>  		if (flags & BPF_TRAMP_F_ORIG_STACK) {
>>  			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
>>  			EMIT2(0xff, 0xd0); /* call *rax */
>> @@ -2569,7 +2579,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>>  			ret = -EINVAL;
>>  			goto cleanup;
>>  		}
>> -	}
>> +	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
>> +		/* Before running the original function, restore the
>> +		 * tail_call_cnt from stack.
>> +		 */
>> +		RESTORE_TAIL_CALL_CNT(stack_size);
>> +
>>  	/* restore return value of orig_call or fentry prog back into RAX */
>>  	if (save_ret)
>>  		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index cfabbcf47bdb8..55c72086034ef 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1028,6 +1028,11 @@ struct btf_func_model {
>>   */
>>  #define BPF_TRAMP_F_SHARE_IPMODIFY	BIT(6)
>>  
>> +/* Indicate that current trampoline is in a tail call context. Then, it has to
>> + * cache and restore tail_call_cnt to avoid infinite tail call loop.
>> + */
>> +#define BPF_TRAMP_F_TAIL_CALL_CTX	BIT(7)
>> +
>>  /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
>>   * bytes on x86.
>>   */
>> @@ -1147,6 +1152,7 @@ struct bpf_attach_target_info {
>>  	struct module *tgt_mod;
>>  	const char *tgt_name;
>>  	const struct btf_type *tgt_type;
>> +	bool tail_call_ctx;
>>  };
>>  
>>  #define BPF_DISPATCHER_MAX 48 /* Fits in 2048B */
>> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>> index 78acf28d48732..0fae334e3f7b8 100644
>> --- a/kernel/bpf/trampoline.c
>> +++ b/kernel/bpf/trampoline.c
>> @@ -415,8 +415,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>>  		goto out;
>>  	}
>>  
>> -	/* clear all bits except SHARE_IPMODIFY */
>> -	tr->flags &= BPF_TRAMP_F_SHARE_IPMODIFY;
>> +	/* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
>> +	tr->flags &= (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL_CTX);
>>  
>>  	if (tlinks[BPF_TRAMP_FEXIT].nr_links ||
>>  	    tlinks[BPF_TRAMP_MODIFY_RETURN].nr_links) {
>> @@ -783,6 +783,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
>>  
>>  	memcpy(&tr->func.model, &tgt_info->fmodel, sizeof(tgt_info->fmodel));
>>  	tr->func.addr = (void *)tgt_info->tgt_addr;
>> +	tr->flags = (tgt_info->tail_call_ctx ? BPF_TRAMP_F_TAIL_CALL_CTX : 0);
>>  out:
>>  	mutex_unlock(&tr->mutex);
>>  	return tr;
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 4ccca1f6c9981..a78e5a2ae5c72 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -19400,10 +19400,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>  			return -EINVAL;
>>  		fallthrough;
>>  	case BPF_MODIFY_RETURN:
>> -	case BPF_LSM_MAC:
>> -	case BPF_LSM_CGROUP:
>>  	case BPF_TRACE_FENTRY:
>>  	case BPF_TRACE_FEXIT:
>> +		if (tgt_prog && subprog > 0 &&
>> +		    tgt_prog->aux->func[subprog]->is_func &&
>> +		    tgt_prog->aux->tail_call_reachable)
>> +			tgt_info->tail_call_ctx = true;
>> +		fallthrough;
>> +	case BPF_LSM_MAC:
>> +	case BPF_LSM_CGROUP:
>>  		if (!btf_type_is_func(t)) {
>>  			bpf_log(log, "attach_btf_id %u is not a function\n",
>>  				btf_id);
> 
