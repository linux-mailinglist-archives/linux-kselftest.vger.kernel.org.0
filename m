Return-Path: <linux-kselftest+bounces-32854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A51F2AB35AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 13:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F791891924
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7030F2882CA;
	Mon, 12 May 2025 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mf7H3Ufq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774026D4C6
	for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747048344; cv=none; b=o4DJbnPZAfI0WqnRI/cNxB1QhwlVzC/40kq32YSpgo/iQtdwJiS2B/716mBYDNjoC4krPuyoV0NYH3DeeHGHBn7165+wcdC05OwUqsGEus7yW5oJNPEs2e0IqcZPfeZnuJYQzKCPWVWKUgtkZZZr71maqD1KaCvNBmGCKdZCEaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747048344; c=relaxed/simple;
	bh=ko7Q9qbhYNYPvYA7LVk3TXue899YIv1qyRy0EJufnh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUv29C1Ub0Q1OlfKkzoNVRb1EJFUGmQ3Fb26ZZoefaNgZxPSFQtl98R43tQlfBbKZnfIawUCxJ2NN0ZzYMFFwvsMzoyjA9jDyJ92m1vdgO7JZhJRWfpK7gfR6wwfgFMrTXIyQbuzIuLV5ShjMQQOrvlLKyhVifHUn5qWFeepMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mf7H3Ufq; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <16eafae1-5014-42a9-b6c4-8be40b26cf31@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747048339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=77hYgmLIC7yLFMAWuJ8WWRqfKmeQfFFtha5TvnJkXHE=;
	b=Mf7H3UfqXNL+8ByS9N/IjYMBcjOfeZyyG2JVX60LIiCuwnp0SKaZwgs0WFbVaiSvprVNXS
	EnotFEhb+U5mp/CjW+iGtzDGzsZE3NtKj6IxG8BgSRxTgwbJAsGusplrUbY1cWf6FAVpcf
	QmoKyw604efUa0L7qFeuHzNoDZjV/IQ=
Date: Mon, 12 May 2025 19:12:07 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/4] bpf: Allow get_func_[arg|arg_cnt] helpers in
 raw tracepoint programs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kafai Wan <mannkafai@gmail.com>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20250426160027.177173-1-mannkafai@gmail.com>
 <20250426160027.177173-2-mannkafai@gmail.com>
 <CAADnVQ+DF18nKEf9i1RKEQN+ybH+duu7U-91YZDaa_PiqUx17g@mail.gmail.com>
 <CALqUS-6XtJ0Bb9jiykdC3jAY_OHjGuirj06Kzssjvo7eW_so2A@mail.gmail.com>
 <f951b81f-1b46-4219-82fd-0839e27ab3f3@linux.dev>
 <CAADnVQ+FANha0fO_BF+iHJ4iZSCPtDfoUkzR8mMFwOakw8+eCg@mail.gmail.com>
 <f1f23c1a-f4a8-4807-8028-87e247775ec8@linux.dev>
 <CAEf4BzZcuCrK4UVv2qpp7LAL=uXg+YqFopNW3EzCCpUBNPq-ag@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzZcuCrK4UVv2qpp7LAL=uXg+YqFopNW3EzCCpUBNPq-ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/5/7 05:01, Andrii Nakryiko wrote:
> On Fri, May 2, 2025 at 7:26 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 2025/5/1 00:53, Alexei Starovoitov wrote:
>>> On Wed, Apr 30, 2025 at 8:55 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>
>>>>
>>>>
>>>> On 2025/4/30 20:43, Kafai Wan wrote:
>>>>> On Wed, Apr 30, 2025 at 10:46 AM Alexei Starovoitov
>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>
>>>>>> On Sat, Apr 26, 2025 at 9:00 AM KaFai Wan <mannkafai@gmail.com> wrote:
>>>>>>>
>>>>
>>
>> [...]
>>
>>>>
>>>>
>>>> bpf_get_func_arg() will be very helpful for bpfsnoop[1] when tracing tp_btf.
>>>>
>>>> In bpfsnoop, it can generate a small snippet of bpf instructions to use
>>>> bpf_get_func_arg() for retrieving and filtering arguments. For example,
>>>> with the netif_receive_skb tracepoint, bpfsnoop can use
>>>> bpf_get_func_arg() to filter the skb argument using pcap-filter(7)[2] or
>>>> a custom attribute-based filter. This will allow bpfsnoop to trace
>>>> multiple tracepoints using a single bpf program code.
>>>
>>> I doubt you thought it through end to end.
>>> When tracepoint prog attaches we have this check:
>>>         /*
>>>          * check that program doesn't access arguments beyond what's
>>>          * available in this tracepoint
>>>          */
>>>         if (prog->aux->max_ctx_offset > btp->num_args * sizeof(u64))
>>>                 return -EINVAL;
>>>
>>> So you cannot have a single bpf prog attached to many tracepoints
>>> to read many arguments as-is.
>>> You can hack around that limit with probe_read,
>>> but the values won't be trusted and you won't be able to pass
>>> such untrusted pointers into skb and other helpers/kfuncs.
>>
>> I understand that a single bpf program cannot be attached to multiple
>> tracepoints using tp_btf. However, the same bpf code can be reused to
>> create multiple bpf programs, each attached to a different tracepoint.
>>
>> For example:
>>
>> SEC("fentry")
>> int BPF_PROG(fentry_fn)
>> {
>>         /* ... */
>>         return BPF_OK;
>> }
>>
>> The above fentry code can be compiled into multiple bpf programs to
>> trace different kernel functions. Each program can then use the
>> bpf_get_func_arg() helper to access the arguments of the traced function.
>>
>> With this patch, tp_btf will gain similar flexibility. For example:
>>
>> SEC("tp_btf")
>> int BPF_PROG(tp_btf_fn)
>> {
>>         /* ... */
>>         return BPF_OK;
>> }
>>
>> Here, bpf_get_func_arg() can be used to access tracepoint arguments.
>>
>> Currently, due to the lack of bpf_get_func_arg() support in tp_btf,
>> bpfsnoop[1] uses bpf_probe_read_kernel() to read tracepoint arguments.
>> This is also used when filtering specific argument attributes.
>>
>> For instance, to filter the skb argument of the netif_receive_skb
>> tracepoint by 'skb->dev->ifindex == 2', the translated bpf instructions
>> with bpf_probe_read_kernel() would look like this:
>>
>> bool filter_arg(__u64 * args):
>> ; filter_arg(__u64 *args)
>>  209: (79) r1 = *(u64 *)(r1 +0) /* all tracepoint's argument has been
>> read into args using bpf_probe_read_kernel() */
>>  210: (bf) r3 = r1
>>  211: (07) r3 += 16
>>  212: (b7) r2 = 8
>>  213: (bf) r1 = r10
>>  214: (07) r1 += -8
>>  215: (85) call bpf_probe_read_kernel#-125280
>>  216: (79) r3 = *(u64 *)(r10 -8)
>>  217: (15) if r3 == 0x0 goto pc+10
>>  218: (07) r3 += 224
>>  219: (b7) r2 = 8
>>  220: (bf) r1 = r10
>>  221: (07) r1 += -8
>>  222: (85) call bpf_probe_read_kernel#-125280
>>  223: (79) r3 = *(u64 *)(r10 -8)
>>  224: (67) r3 <<= 32
>>  225: (77) r3 >>= 32
>>  226: (b7) r0 = 1
>>  227: (15) if r3 == 0x2 goto pc+1
>>  228: (af) r0 ^= r0
>>  229: (95) exit
>>
>> If bpf_get_func_arg() is supported in tp_btf, the bpf program will
>> instead look like:
>>
>> static __noinline bool
>> filter_skb(void *ctx)
>> {
>>     struct sk_buff *skb;
>>
>>     (void) bpf_get_func_arg(ctx, 0, (__u64 *) &skb);
>>     return skb->dev->ifindex == 2;
>> }
>>
>> This will simplify the generated code and eliminate the need for
>> bpf_probe_read_kernel() calls. However, in my tests (on kernel
>> 6.8.0-35-generic, Ubuntu 24.04 LTS), the pointer returned by
>> bpf_get_func_arg() is marked as a scalar rather than a trusted pointer:
>>
>>         0: R1=ctx() R10=fp0
>>         ; if (!filter_skb(ctx))
>>         0: (85) call pc+3
>>         caller:
>>          R10=fp0
>>         callee:
>>          frame1: R1=ctx() R10=fp0
>>         4: frame1: R1=ctx() R10=fp0
>>         ; filter_skb(void *ctx)
>>         4: (bf) r3 = r10                      ; frame1: R3_w=fp0 R10=fp0
>>         ;
>>         5: (07) r3 += -8                      ; frame1: R3_w=fp-8
>>         ; (void) bpf_get_func_arg(ctx, 0, (__u64 *) &skb);
>>         6: (b7) r2 = 0                        ; frame1: R2_w=0
>>         7: (85) call bpf_get_func_arg#183     ; frame1: R0_w=scalar()
>>         ; return skb->dev->ifindex == 2;
>>         8: (79) r1 = *(u64 *)(r10 -8)         ; frame1: R1_w=scalar() R10=fp0
>> fp-8=mmmmmmmm
>>         ; return skb->dev->ifindex == 2;
>>         9: (79) r1 = *(u64 *)(r1 +16)
>>         R1 invalid mem access 'scalar'
>>         processed 7 insns (limit 1000000) max_states_per_insn 0 total_states 0
>> peak_states 0 mark_read 0
>>
>> If the returned skb is a trusted pointer, the verifier will accept
>> something like:
>>
>> static __noinline bool
>> filter_skb(struct sk_buff *skb)
>> {
>>     return skb->dev->ifindex == 2;
>> }
>>
>> Which will compile into much simpler and more efficient instructions:
>>
>> bool filter_skb(struct sk_buff * skb):
>> ; return skb->dev->ifindex == 2;
>>   92: (79) r1 = *(u64 *)(r1 +16)
>> ; return skb->dev->ifindex == 2;
>>   93: (61) r1 = *(u32 *)(r1 +224)
>>   94: (b7) r0 = 1
>> ; return skb->dev->ifindex == 2;
>>   95: (15) if r1 == 0x2 goto pc+1
>>   96: (b7) r0 = 0
>> ; return skb->dev->ifindex == 2;
>>   97: (95) exit
>>
>> In conclusion:
>>
>> 1. It will be better if the pointer returned by bpf_get_func_arg() is
>> trusted, only when the argument index is a known constant.
> 
> bpf_get_func_arg() was never meant to return trusted arguments, so
> this, IMO, is pushing it too far.
> 
>> 2. Adding bpf_get_func_arg() support to tp_btf will significantly
>> simplify and improve tools like bpfsnoop.
> 
> "Significantly simplify and improve" is a bit of an exaggeration,
> given BPF cookies can be used for getting number of arguments of
> tp_btf, as for the getting rid of bpf_probe_read_kernel(), tbh, more
> generally useful addition would be an untyped counterpart to
> bpf_core_cast(), which wouldn't need BTF type information, but will
> treat all accessed memory as raw bytes (but will still install
> exception handler just like with bpf_core_cast()).
> 

Cool! The bpf_rdonly_cast() kfunc used by the bpf_core_cast() macro
works well in bpfsnoop.

The expression 'skb->dev->ifindex == 2' is translated into:

bool filter_arg(__u64 * args):
; filter_arg(__u64 *args)
 209: (bf) r9 = r1
 210: (79) r8 = *(u64 *)(r9 +0)
 211: (bf) r1 = r8
 212: (b7) r2 = 6973
 213: (bf) r0 = r1
 214: (79) r1 = *(u64 *)(r0 +16)
 215: (15) if r1 == 0x0 goto pc+12
 216: (07) r1 += 224
 217: (bf) r3 = r1
 218: (b7) r2 = 8
 219: (bf) r1 = r10
 220: (07) r1 += -8
 221: (85) call bpf_probe_read_kernel#-125280
 222: (79) r8 = *(u64 *)(r10 -8)
 223: (67) r8 <<= 32
 224: (77) r8 >>= 32
 225: (55) if r8 != 0x2 goto pc+2
 226: (b7) r8 = 1
 227: (05) goto pc+1
 228: (af) r8 ^= r8
 229: (bf) r0 = r8
 230: (95) exit

However, since bpf_rdonly_cast() is a kfunc, it causes registers r1–r5
to be considered volatile.

If the verifier could trust the pointer fetched by bpf_get_func_arg(),
this extra cost from bpf_rdonly_cast() could be avoided.

Thanks,
Leon



