Return-Path: <linux-kselftest+bounces-8749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9220C8AFE55
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 04:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FCA1C2225B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 02:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F17134A5;
	Wed, 24 Apr 2024 02:26:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5670D18EA5;
	Wed, 24 Apr 2024 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925561; cv=none; b=qkpkVqyP5cpBVfqynHNpQAxYbtkTITd6KArAEmihPihEwy106w8WhKib666rNGhyUDPDKxMq/iJdOg9em8NbMucejWat6tZSyg3Jb3Wy1+0SstLML/T8KqWjVyjH+K3IBR7QrokOB3nWFigKR37exWIHp0R4zbf9RuBkskswsqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925561; c=relaxed/simple;
	bh=12cvGeFyW2C9I9L9KGqgi5E9+U9Fuod25024OOQY9N8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oe8iF2CaO3qCuJPzvktnu9XP7trCdDUprguZvW+h2Ya8acMwBKC8wacdBVLFbMtfL6I9ovns5TIRVgX5GtILo7S2r0vz1AVXKUzerwv7sqihGzyyeU2iDx/DEBVWKiJQ0uUBeTiUb6fGDTBAYs46JzcNXxR693uKMH/EPsXMQgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPNBj3qcVz4f3l88;
	Wed, 24 Apr 2024 10:25:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5D9CC1A11D9;
	Wed, 24 Apr 2024 10:25:54 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgC3to6vbShmyUSNKg--.2911S2;
	Wed, 24 Apr 2024 10:25:52 +0800 (CST)
Message-ID: <576c7c44-d1b4-42c8-8b6e-2e6b93d7547a@huaweicloud.com>
Date: Wed, 24 Apr 2024 10:25:51 +0800
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
To: Yonghong Song <yonghong.song@linux.dev>,
 Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
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
 <f80991aa-3a49-451a-9a82-ac57982dcb28@huaweicloud.com>
 <bdc84c6c-7415-4b84-a883-1988cb5f77d1@linux.dev>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <bdc84c6c-7415-4b84-a883-1988cb5f77d1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgC3to6vbShmyUSNKg--.2911S2
X-Coremail-Antispam: 1UD129KBjvAXoW3uFyfXr48WF1fAr4xuryrCrg_yoW8Wr4DCo
	WFgr47Aw4FqF18GF1qy34qqr1Yg3W7Grn7JryUJFnxGF1jvw4UX348JrW5JayaqF18Wr1D
	C347tr95AFyUJFn3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYz7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoj
	jgUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/24/2024 5:55 AM, Yonghong Song wrote:
> 
> On 4/20/24 1:33 AM, Xu Kuohai wrote:
>> On 4/20/2024 7:00 AM, Eduard Zingerman wrote:
>>> On Thu, 2024-04-11 at 20:27 +0800, Xu Kuohai wrote:
>>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>>
>>>> With lsm return value check, the no-alu32 version test_libbpf_get_fd_by_id_opts
>>>> is rejected by the verifier, and the log says:
>>>>
>>>>    0: R1=ctx() R10=fp0
>>>>    ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
>>>>    0: (b7) r0 = 0                        ; R0_w=0
>>>>    1: (79) r2 = *(u64 *)(r1 +0)
>>>>    func 'bpf_lsm_bpf_map' arg0 has btf_id 916 type STRUCT 'bpf_map'
>>>>    2: R1=ctx() R2_w=trusted_ptr_bpf_map()
>>>>    ; if (map != (struct bpf_map *)&data_input) @ test_libbpf_get_fd_by_id_opts.c:29
>>>>    2: (18) r3 = 0xffff9742c0951a00       ; R3_w=map_ptr(map=data_input,ks=4,vs=4)
>>>>    4: (5d) if r2 != r3 goto pc+4         ; R2_w=trusted_ptr_bpf_map() R3_w=map_ptr(map=data_input,ks=4,vs=4)
>>>>    ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
>>>>    5: (79) r0 = *(u64 *)(r1 +8)          ; R0_w=scalar() R1=ctx()
>>>>    ; if (fmode & FMODE_WRITE) @ test_libbpf_get_fd_by_id_opts.c:32
>>>>    6: (67) r0 <<= 62                     ; R0_w=scalar(smax=0x4000000000000000,umax=0xc000000000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xc000000000000000))
>>>>    7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
>>>>    ;  @ test_libbpf_get_fd_by_id_opts.c:0
>>>>    8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))
>>>>    ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
>>>>    9: (95) exit
>>>>
>>>> And here is the C code of the prog.
>>>>
>>>> SEC("lsm/bpf_map")
>>>> int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
>>>> {
>>>>     if (map != (struct bpf_map *)&data_input)
>>>>         return 0;
>>>>
>>>>     if (fmode & FMODE_WRITE)
>>>>         return -EACCES;
>>>>
>>>>     return 0;
>>>> }
>>>>
>>>> It is clear that the prog can only return either 0 or -EACCESS, and both
>>>> values are legal.
>>>>
>>>> So why is it rejected by the verifier?
>>>>
>>>> The verifier log shows that the second if and return value setting
>>>> statements in the prog is optimized to bitwise operations "r0 s>>= 63"
>>>> and "r0 &= -13". The verifier correctly deduces that the the value of
>>>> r0 is in the range [-1, 0] after verifing instruction "r0 s>>= 63".
>>>> But when the verifier proceeds to verify instruction "r0 &= -13", it
>>>> fails to deduce the correct value range of r0.
>>>>
>>>> 7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
>>>> 8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))
>>>>
>>>> So why the verifier fails to deduce the result of 'r0 &= -13'?
>>>>
>>>> The verifier uses tnum to track values, and the two ranges "[-1, 0]" and
>>>> "[0, -1ULL]" are encoded to the same tnum. When verifing instruction
>>>> "r0 &= -13", the verifier erroneously deduces the result from
>>>> "[0, -1ULL] AND -13", which is out of the expected return range
>>>> [-4095, 0].
>>>>
>>>> To fix it, this patch simply adds a special SCALAR32 case for the
>>>> verifier. That is, when the source operand of the AND instruction is
>>>> a constant and the destination operand changes from negative to
>>>> non-negative and falls in range [-256, 256], deduce the result range
>>>> by enumerating all possible AND results.
>>>>
>>>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>>>> ---
>>>
>>> Hello,
>>>
>>> Sorry for the delay, I had to think about this issue a bit.
>>> I found the clang transformation that generates the pattern this patch
>>> tries to handle.
>>> It is located in DAGCombiner::SimplifySelectCC() method (see [1]).
>>> The transformation happens as a part of DAG to DAG rewrites
>>> (LLVM uses several internal representations:
>>>   - generic optimizer uses LLVM IR, most of the work is done
>>>     using this representation;
>>>   - before instruction selection IR is converted to Selection DAG,
>>>     some optimizations are applied at this stage,
>>>     all such optimizations are a set of pattern replacements;
>>>   - Selection DAG is converted to machine code, some optimizations
>>>     are applied at the machine code level).
>>>
>>> Full pattern is described as follows:
>>>
>>>    // fold (select_cc seteq (and x, y), 0, 0, A) -> (and (sra (shl x)) A)
>>>    // where y is has a single bit set.
>>>    // A plaintext description would be, we can turn the SELECT_CC into an AND
>>>    // when the condition can be materialized as an all-ones register.  Any
>>>    // single bit-test can be materialized as an all-ones register with
>>>    // shift-left and shift-right-arith.
>>>
>>> For this particular test case the DAG is converted as follows:
>>>
>>>                      .---------------- lhs         The meaning of this select_cc is:
>>>                      |        .------- rhs         `lhs == rhs ? true value : false value`
>>>                      |        | .----- true value
>>>                      |        | |  .-- false value
>>>                      v        v v  v
>>>    (select_cc seteq (and X 2) 0 0 -13)
>>>                            ^
>>> ->                        '---------------.
>>>    (and (sra (sll X 62) 63)                |
>>>         -13)                               |
>>>                                            |
>>> Before pattern is applied, it checks that second 'and' operand has
>>> only one bit set, (which is true for '2').
>>>
>>> The pattern itself generates logical shift left / arithmetic shift
>>> right pair, that ensures that result is either all ones (-1) or all
>>> zeros (0). Hence, applying 'and' to shifts result and false value
>>> generates a correct result.
>>>
>>
>> Thanks for your detailed and invaluable explanation!
> 
> Thanks Eduard for detailed explanation. It looks like we could
> resolve this issue without adding too much complexity to verifier.
> Also, this code pattern above seems generic enough to be worthwhile
> with verifier change.
> 
> Kuohai, please added detailed explanation (as described by Eduard)
> in the commit message.
>

Sure, already added, the commit message and the change now is like this:

---

     bpf: Fix a false rejection caused by AND operation

     With lsm return value check, the no-alu32 version test_libbpf_get_fd_by_id_opts
     is rejected by the verifier, and the log says:

     0: R1=ctx() R10=fp0
     ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
     0: (b7) r0 = 0                        ; R0_w=0
     1: (79) r2 = *(u64 *)(r1 +0)
     func 'bpf_lsm_bpf_map' arg0 has btf_id 916 type STRUCT 'bpf_map'
     2: R1=ctx() R2_w=trusted_ptr_bpf_map()
     ; if (map != (struct bpf_map *)&data_input) @ test_libbpf_get_fd_by_id_opts.c:29
     2: (18) r3 = 0xffff9742c0951a00       ; R3_w=map_ptr(map=data_input,ks=4,vs=4)
     4: (5d) if r2 != r3 goto pc+4         ; R2_w=trusted_ptr_bpf_map() R3_w=map_ptr(map=data_input,ks=4,vs=4)
     ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
     5: (79) r0 = *(u64 *)(r1 +8)          ; R0_w=scalar() R1=ctx()
     ; if (fmode & FMODE_WRITE) @ test_libbpf_get_fd_by_id_opts.c:32
     6: (67) r0 <<= 62                     ; R0_w=scalar(smax=0x4000000000000000,umax=0xc000000000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xc000000000000000))
     7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
     ;  @ test_libbpf_get_fd_by_id_opts.c:0
     8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))
     ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
     9: (95) exit

     And here is the C code of the prog.

     SEC("lsm/bpf_map")
     int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
     {
         if (map != (struct bpf_map *)&data_input)
                 return 0;

         if (fmode & FMODE_WRITE)
                 return -EACCES;

         return 0;
     }

     It is clear that the prog can only return either 0 or -EACCESS, and both
     values are legal.

     So why is it rejected by the verifier?

     The verifier log shows that the second if and return value setting
     statements in the prog is optimized to bitwise operations "r0 s>>= 63"
     and "r0 &= -13". The verifier correctly deduces that the the value of
     r0 is in the range [-1, 0] after verifing instruction "r0 s>>= 63".
     But when the verifier proceeds to verify instruction "r0 &= -13", it
     fails to deduce the correct value range of r0.

     7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
     8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))

     So why the verifier fails to deduce the result of 'r0 &= -13'?

     The verifier uses tnum to track values, and the two ranges "[-1, 0]" and
     "[0, -1ULL]" are encoded to the same tnum. When verifing instruction
     "r0 &= -13", the verifier erroneously deduces the result from
     "[0, -1ULL] AND -13", which is out of the expected return range
     [-4095, 0].

     As explained by Eduard in [0], the clang transformation that generates this
     pattern is located in DAGCombiner::SimplifySelectCC() method (see [1]).

     The transformation happens as a part of DAG to DAG rewrites
     (LLVM uses several internal representations:
      - generic optimizer uses LLVM IR, most of the work is done
        using this representation;
      - before instruction selection IR is converted to Selection DAG,
        some optimizations are applied at this stage,
        all such optimizations are a set of pattern replacements;
      - Selection DAG is converted to machine code, some optimizations
        are applied at the machine code level).

     Full pattern is described as follows:

       // fold (select_cc seteq (and x, y), 0, 0, A) -> (and (sra (shl x)) A)
       // where y is has a single bit set.
       // A plaintext description would be, we can turn the SELECT_CC into an AND
       // when the condition can be materialized as an all-ones register.  Any
       // single bit-test can be materialized as an all-ones register with
       // shift-left and shift-right-arith.

     For this particular test case the DAG is converted as follows:

                         .---------------- lhs         The meaning of this select_cc is:
                         |        .------- rhs         `lhs == rhs ? true value : false value`
                         |        | .----- true value
                         |        | |  .-- false value
                         v        v v  v
       (select_cc seteq (and X 2) 0 0 -13)
                               ^
     ->                        '---------------.
       (and (sra (sll X 62) 63)                |
            -13)                               |
                                               |
     Before pattern is applied, it checks that second 'and' operand has
     only one bit set, (which is true for '2').

     The pattern itself generates logical shift left / arithmetic shift
     right pair, that ensures that result is either all ones (-1) or all
     zeros (0). Hence, applying 'and' to shifts result and false value
     generates a correct result.

     As suggested by Eduard, this patch makes a special case for source
     or destination register of '&=' operation being in range [-1, 0].

     Meaning that one of the '&=' operands is either:
     - all ones, in which case the counterpart is the result of the operation;
     - all zeros, in which case zero is the result of the operation.

     And MIN and MAX values could be derived based on above two observations.

     [0] https://lore.kernel.org/bpf/e62e2971301ca7f2e9eb74fc500c520285cad8f5.camel@gmail.com/
     [1] https://github.com/llvm/llvm-project/blob/4523a267829c807f3fc8fab8e5e9613985a51565/llvm/lib/CodeGen/SelectionDAG/DAGCombiner.cpp

     Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
     Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 640747b53745..30c551d39329 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13374,6 +13374,24 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
         dst_reg->u32_min_value = var32_off.value;
         dst_reg->u32_max_value = min(dst_reg->u32_max_value, umax_val);

+       /* Special case: src_reg is known and dst_reg is in range [-1, 0] */
+       if (src_known &&
+               dst_reg->s32_min_value == -1 && dst_reg->s32_max_value == 0 &&
+               dst_reg->smin_value == -1 && dst_reg->smax_value == 0) {
+               dst_reg->s32_min_value = min_t(s32, src_reg->s32_min_value, 0);
+               dst_reg->s32_max_value = max_t(s32, src_reg->s32_min_value, 0);
+               return;
+       }
+
+       /* Special case: dst_reg is known and src_reg is in range [-1, 0] */
+       if (dst_known &&
+               src_reg->s32_min_value == -1 && src_reg->s32_max_value == 0 &&
+               src_reg->smin_value == -1 && src_reg->smax_value == 0) {
+               dst_reg->s32_min_value = min_t(s32, dst_reg->s32_min_value, 0);
+               dst_reg->s32_max_value = max_t(s32, dst_reg->s32_min_value, 0);
+               return;
+       }
+
         /* Safe to set s32 bounds by casting u32 result into s32 when u32
          * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
          */
@@ -13404,6 +13422,24 @@ static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
         dst_reg->umin_value = dst_reg->var_off.value;
         dst_reg->umax_value = min(dst_reg->umax_value, umax_val);

+       /* Special case: src_reg is known and dst_reg is in range [-1, 0] */
+       if (src_known &&
+               dst_reg->smin_value == -1 && dst_reg->smax_value == 0 &&
+               dst_reg->s32_min_value == -1 && dst_reg->s32_max_value == 0) {
+               dst_reg->smin_value = min_t(s64, src_reg->smin_value, 0);
+               dst_reg->smax_value = max_t(s64, src_reg->smin_value, 0);
+               return;
+       }
+
+       /* Special case: dst_reg is known and src_reg is in range [-1, 0] */
+       if (dst_known &&
+               src_reg->smin_value == -1 && src_reg->smax_value == 0 &&
+               src_reg->s32_min_value == -1 && src_reg->s32_max_value == 0) {
+               dst_reg->smin_value = min_t(s64, dst_reg->smin_value, 0);
+               dst_reg->smax_value = max_t(s64, dst_reg->smin_value, 0);
+               return;
+       }
+
         /* Safe to set s64 bounds by casting u64 result into s64 when u64
          * doesn't cross sign boundary. Otherwise set s64 bounds to unbounded.
          */

>>
>>> In my opinion the approach taken by this patch is sub-optimal:
>>> - 512 iterations is too much;
>>> - this does not cover all code that could be generated by the above
>>>    mentioned LLVM transformation
>>>    (e.g. second 'and' operand could be 1 << 16).
>>>
>>> Instead, I suggest to make a special case for source or dst register
>>> of '&=' operation being in range [-1,0].
>>> Meaning that one of the '&=' operands is either:
>>> - all ones, in which case the counterpart is the result of the operation;
>>> - all zeros, in which case zero is the result of the operation;
>>> - derive MIN and MAX values based on above two observations.
>>>
>>
>> Totally agree, I'll cook a new patch as you suggested.
>>
>>> [1] https://github.com/llvm/llvm-project/blob/4523a267829c807f3fc8fab8e5e9613985a51565/llvm/lib/CodeGen/SelectionDAG/DAGCombiner.cpp#L5391
>>>
>>> Best regards,
>>> Eduard
>>
>>
> 


