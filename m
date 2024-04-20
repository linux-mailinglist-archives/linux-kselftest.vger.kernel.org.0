Return-Path: <linux-kselftest+bounces-8532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 825208ABA4A
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 10:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1896F1F22441
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 08:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5EBD524;
	Sat, 20 Apr 2024 08:33:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182E38C;
	Sat, 20 Apr 2024 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713602010; cv=none; b=NxCF4DbMMsCojzU3BN+qVaisw/ojAiqoYumg8foA6v9GZOS0ZTXc3kJlN6ERcxfbEdN0bL4UJKuIM7QdEwiD04DTBHtZfETYJnfxlnWi3DOotM/T4LHxwfqI/hXQFbnLzmD4pzl3COf1shgLgszPMxcT5g+TV7TiX00iSv26Zvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713602010; c=relaxed/simple;
	bh=ozJf00ALOxbfst1CfKs7QsoFD3TOa+lAa1uCModcRhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZCVV10cjz8ogQ2qWNpNiqO0FrBuCVl00HI9+/HwXwjbPdqrobgQYHMHLz+cH9oISCpMO7YVb1wdPxjEEFHJ+FW+TD5y2+de5KpKBvr/xIfq8+Y396rXfJZTb6TOYCRw9uu0AjZbn4qILyWvSncfjkOpeyyrFJAD6M/nImDXL2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VM4XQ1jXvz4f3khR;
	Sat, 20 Apr 2024 16:33:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8DDFB1A0903;
	Sat, 20 Apr 2024 16:33:17 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgCHnQbLfSNmO6PhKQ--.65426S2;
	Sat, 20 Apr 2024 16:33:17 +0800 (CST)
Message-ID: <f80991aa-3a49-451a-9a82-ac57982dcb28@huaweicloud.com>
Date: Sat, 20 Apr 2024 16:33:15 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 07/11] bpf: Fix a false rejection caused by
 AND operation
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Brendan Jackman <jackmanb@chromium.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 Khadija Kamran <kamrankhadijadj@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>,
 John Johansen <john.johansen@canonical.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
 <20240411122752.2873562-8-xukuohai@huaweicloud.com>
 <e62e2971301ca7f2e9eb74fc500c520285cad8f5.camel@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <e62e2971301ca7f2e9eb74fc500c520285cad8f5.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCHnQbLfSNmO6PhKQ--.65426S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4DuFyUAry8KFyrXF13Jwb_yoWxGr4kpF
	WfG3ZFka1kXrW8Cw1Iqan8JFyakF4fAa17JFyUJryFyas8uF4FqFs0grWjyr98Ar4ruw42
	vFnFqay8GryUCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/20/2024 7:00 AM, Eduard Zingerman wrote:
> On Thu, 2024-04-11 at 20:27 +0800, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> With lsm return value check, the no-alu32 version test_libbpf_get_fd_by_id_opts
>> is rejected by the verifier, and the log says:
>>
>>    0: R1=ctx() R10=fp0
>>    ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
>>    0: (b7) r0 = 0                        ; R0_w=0
>>    1: (79) r2 = *(u64 *)(r1 +0)
>>    func 'bpf_lsm_bpf_map' arg0 has btf_id 916 type STRUCT 'bpf_map'
>>    2: R1=ctx() R2_w=trusted_ptr_bpf_map()
>>    ; if (map != (struct bpf_map *)&data_input) @ test_libbpf_get_fd_by_id_opts.c:29
>>    2: (18) r3 = 0xffff9742c0951a00       ; R3_w=map_ptr(map=data_input,ks=4,vs=4)
>>    4: (5d) if r2 != r3 goto pc+4         ; R2_w=trusted_ptr_bpf_map() R3_w=map_ptr(map=data_input,ks=4,vs=4)
>>    ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
>>    5: (79) r0 = *(u64 *)(r1 +8)          ; R0_w=scalar() R1=ctx()
>>    ; if (fmode & FMODE_WRITE) @ test_libbpf_get_fd_by_id_opts.c:32
>>    6: (67) r0 <<= 62                     ; R0_w=scalar(smax=0x4000000000000000,umax=0xc000000000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xc000000000000000))
>>    7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
>>    ;  @ test_libbpf_get_fd_by_id_opts.c:0
>>    8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))
>>    ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
>>    9: (95) exit
>>
>> And here is the C code of the prog.
>>
>> SEC("lsm/bpf_map")
>> int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
>> {
>> 	if (map != (struct bpf_map *)&data_input)
>> 		return 0;
>>
>> 	if (fmode & FMODE_WRITE)
>> 		return -EACCES;
>>
>> 	return 0;
>> }
>>
>> It is clear that the prog can only return either 0 or -EACCESS, and both
>> values are legal.
>>
>> So why is it rejected by the verifier?
>>
>> The verifier log shows that the second if and return value setting
>> statements in the prog is optimized to bitwise operations "r0 s>>= 63"
>> and "r0 &= -13". The verifier correctly deduces that the the value of
>> r0 is in the range [-1, 0] after verifing instruction "r0 s>>= 63".
>> But when the verifier proceeds to verify instruction "r0 &= -13", it
>> fails to deduce the correct value range of r0.
>>
>> 7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
>> 8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))
>>
>> So why the verifier fails to deduce the result of 'r0 &= -13'?
>>
>> The verifier uses tnum to track values, and the two ranges "[-1, 0]" and
>> "[0, -1ULL]" are encoded to the same tnum. When verifing instruction
>> "r0 &= -13", the verifier erroneously deduces the result from
>> "[0, -1ULL] AND -13", which is out of the expected return range
>> [-4095, 0].
>>
>> To fix it, this patch simply adds a special SCALAR32 case for the
>> verifier. That is, when the source operand of the AND instruction is
>> a constant and the destination operand changes from negative to
>> non-negative and falls in range [-256, 256], deduce the result range
>> by enumerating all possible AND results.
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
> 
> Hello,
> 
> Sorry for the delay, I had to think about this issue a bit.
> I found the clang transformation that generates the pattern this patch
> tries to handle.
> It is located in DAGCombiner::SimplifySelectCC() method (see [1]).
> The transformation happens as a part of DAG to DAG rewrites
> (LLVM uses several internal representations:
>   - generic optimizer uses LLVM IR, most of the work is done
>     using this representation;
>   - before instruction selection IR is converted to Selection DAG,
>     some optimizations are applied at this stage,
>     all such optimizations are a set of pattern replacements;
>   - Selection DAG is converted to machine code, some optimizations
>     are applied at the machine code level).
> 
> Full pattern is described as follows:
> 
>    // fold (select_cc seteq (and x, y), 0, 0, A) -> (and (sra (shl x)) A)
>    // where y is has a single bit set.
>    // A plaintext description would be, we can turn the SELECT_CC into an AND
>    // when the condition can be materialized as an all-ones register.  Any
>    // single bit-test can be materialized as an all-ones register with
>    // shift-left and shift-right-arith.
> 
> For this particular test case the DAG is converted as follows:
> 
>                      .---------------- lhs         The meaning of this select_cc is:
>                      |        .------- rhs         `lhs == rhs ? true value : false value`
>                      |        | .----- true value
>                      |        | |  .-- false value
>                      v        v v  v
>    (select_cc seteq (and X 2) 0 0 -13)
>                            ^
> ->                        '---------------.
>    (and (sra (sll X 62) 63)                |
>         -13)                               |
>                                            |
> Before pattern is applied, it checks that second 'and' operand has
> only one bit set, (which is true for '2').
> 
> The pattern itself generates logical shift left / arithmetic shift
> right pair, that ensures that result is either all ones (-1) or all
> zeros (0). Hence, applying 'and' to shifts result and false value
> generates a correct result.
>

Thanks for your detailed and invaluable explanation!

> In my opinion the approach taken by this patch is sub-optimal:
> - 512 iterations is too much;
> - this does not cover all code that could be generated by the above
>    mentioned LLVM transformation
>    (e.g. second 'and' operand could be 1 << 16).
> 
> Instead, I suggest to make a special case for source or dst register
> of '&=' operation being in range [-1,0].
> Meaning that one of the '&=' operands is either:
> - all ones, in which case the counterpart is the result of the operation;
> - all zeros, in which case zero is the result of the operation;
> - derive MIN and MAX values based on above two observations.
>

Totally agree, I'll cook a new patch as you suggested.

> [1] https://github.com/llvm/llvm-project/blob/4523a267829c807f3fc8fab8e5e9613985a51565/llvm/lib/CodeGen/SelectionDAG/DAGCombiner.cpp#L5391
> 
> Best regards,
> Eduard


