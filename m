Return-Path: <linux-kselftest+bounces-8998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E84FB8B4C57
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Apr 2024 17:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D23D1C20918
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Apr 2024 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED2D6D1C7;
	Sun, 28 Apr 2024 15:15:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D4D1BC40;
	Sun, 28 Apr 2024 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714317351; cv=none; b=kZU5hNlnzF3/rzsEFWfLFmqIzy/7XPTjzOU1c2CV0V/eo3KwUGM/0nnB/azYMYHuO+VPkquXkBD/B64yRmI7xj2V+xnGgYZmjVHDl1n1rbyoICVFmm0mQ6mygnxtoV0wgdGiUxMx1VLMrHMODpu+hkqB88cCob9m/yPQ+fdqKWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714317351; c=relaxed/simple;
	bh=ufQehwoOP8I5WnKH2epn1XxVgLfPaCl2twGWpKmEu7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpSZUZxvYnNfdEYEpSL81xAWFi7UWE9uPnBQ72WSiLoUqJX3O1U505Yatc3gBTFbUQj3RmHEny+8PFL8yQixWRqq033577lVbp2eWr8yE0uJAerCDG6vlbhGzewKQmzaSiPcq1LWuM6MmT6HIfEPfQWy8/zMBTJhjG3Pjb+42I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VS956682Bz4f3jkC;
	Sun, 28 Apr 2024 23:15:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CEC8E1A0179;
	Sun, 28 Apr 2024 23:15:43 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgDXTnEcaC5mZeugLQ--.61138S2;
	Sun, 28 Apr 2024 23:15:41 +0800 (CST)
Message-ID: <4fbce978-9687-48a9-be2a-1c4d76790f7d@huaweicloud.com>
Date: Sun, 28 Apr 2024 23:15:40 +0800
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
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
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
 <576c7c44-d1b4-42c8-8b6e-2e6b93d7547a@huaweicloud.com>
 <CAEf4BzZTzftrOCFsfBd81sHDBpmNK+4Jefqa3SSS6NiuncO0tQ@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAEf4BzZTzftrOCFsfBd81sHDBpmNK+4Jefqa3SSS6NiuncO0tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXTnEcaC5mZeugLQ--.61138S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr4Uuw43XF4fuw13WrWfXwb_yoWfCFy5pF
	Z8JFnFvr4kZ3yUZw1qqw4DArZYqF18JF18u34kA34IyrnFqFy5tr13KFyjkF9xArs7Cr4f
	XF13WrW7tw4qqrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFYFCUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/27/2024 4:36 AM, Andrii Nakryiko wrote:
> On Tue, Apr 23, 2024 at 7:26 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> On 4/24/2024 5:55 AM, Yonghong Song wrote:
>>>
>>> On 4/20/24 1:33 AM, Xu Kuohai wrote:
>>>> On 4/20/2024 7:00 AM, Eduard Zingerman wrote:
>>>>> On Thu, 2024-04-11 at 20:27 +0800, Xu Kuohai wrote:
>>>>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>>>>
>>>>>> With lsm return value check, the no-alu32 version test_libbpf_get_fd_by_id_opts
>>>>>> is rejected by the verifier, and the log says:
>>>>>>
>>>>>>     0: R1=ctx() R10=fp0
>>>>>>     ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
>>>>>>     0: (b7) r0 = 0                        ; R0_w=0
>>>>>>     1: (79) r2 = *(u64 *)(r1 +0)
>>>>>>     func 'bpf_lsm_bpf_map' arg0 has btf_id 916 type STRUCT 'bpf_map'
>>>>>>     2: R1=ctx() R2_w=trusted_ptr_bpf_map()
>>>>>>     ; if (map != (struct bpf_map *)&data_input) @ test_libbpf_get_fd_by_id_opts.c:29
>>>>>>     2: (18) r3 = 0xffff9742c0951a00       ; R3_w=map_ptr(map=data_input,ks=4,vs=4)
>>>>>>     4: (5d) if r2 != r3 goto pc+4         ; R2_w=trusted_ptr_bpf_map() R3_w=map_ptr(map=data_input,ks=4,vs=4)
>>>>>>     ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
>>>>>>     5: (79) r0 = *(u64 *)(r1 +8)          ; R0_w=scalar() R1=ctx()
>>>>>>     ; if (fmode & FMODE_WRITE) @ test_libbpf_get_fd_by_id_opts.c:32
>>>>>>     6: (67) r0 <<= 62                     ; R0_w=scalar(smax=0x4000000000000000,umax=0xc000000000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xc000000000000000))
>>>>>>     7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
>>>>>>     ;  @ test_libbpf_get_fd_by_id_opts.c:0
>>>>>>     8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))
>>>>>>     ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
>>>>>>     9: (95) exit
> 
> [...]
> 
>>
>>       As suggested by Eduard, this patch makes a special case for source
>>       or destination register of '&=' operation being in range [-1, 0].
>>
>>       Meaning that one of the '&=' operands is either:
>>       - all ones, in which case the counterpart is the result of the operation;
>>       - all zeros, in which case zero is the result of the operation.
>>
>>       And MIN and MAX values could be derived based on above two observations.
>>
>>       [0] https://lore.kernel.org/bpf/e62e2971301ca7f2e9eb74fc500c520285cad8f5.camel@gmail.com/
>>       [1] https://github.com/llvm/llvm-project/blob/4523a267829c807f3fc8fab8e5e9613985a51565/llvm/lib/CodeGen/SelectionDAG/DAGCombiner.cpp
>>
>>       Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
>>       Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 640747b53745..30c551d39329 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -13374,6 +13374,24 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
>>           dst_reg->u32_min_value = var32_off.value;
>>           dst_reg->u32_max_value = min(dst_reg->u32_max_value, umax_val);
>>
>> +       /* Special case: src_reg is known and dst_reg is in range [-1, 0] */
>> +       if (src_known &&
>> +               dst_reg->s32_min_value == -1 && dst_reg->s32_max_value == 0 &&
>> +               dst_reg->smin_value == -1 && dst_reg->smax_value == 0) {
> 
> please keep if () condition aligned across multiple lines, it's super
> confusing this way
>

OK, will update the align style

>> +               dst_reg->s32_min_value = min_t(s32, src_reg->s32_min_value, 0);
>> +               dst_reg->s32_max_value = max_t(s32, src_reg->s32_min_value, 0);
> 
> do we need to update tnum parts as well (or reset and re-derive, probably)?
> 
> btw, can't we support src being a range here? the idea is that dst_reg
> either all ones or all zeros. For and it means that it either stays
> all zero, or will be *exactly equal* to src, right? So I think the
> logic would be:
> 
> a) if [s32_min, s32_max] is on the same side of zero, then resulting
> range would be [min(s32_min, 0), max(s32_max, 0)], just like you have
> here
> 
> b) if [s32_min, s32_max] contains zero, then resulting range will be
> exactly [s32_min, s32_max]
> 
> Or did I make a mistake above?
>

Totally agree, the AND of any set with the range [-1,0] is equivalent
to adding number 0 to the set!

Based on this observation, I've rewritten the patch as follows.

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index 3c13240077b8..5e795d728b9f 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -52,6 +52,9 @@ struct tnum tnum_mul(struct tnum a, struct tnum b);
  /* Return a tnum representing numbers satisfying both @a and @b */
  struct tnum tnum_intersect(struct tnum a, struct tnum b);

+/* Return a tnum representing numbers satisfying either @a or @b */
+struct tnum tnum_union(struct tnum a, struct tnum b);
+
  /* Return @a with all but the lowest @size bytes cleared */
  struct tnum tnum_cast(struct tnum a, u8 size);

diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index 9dbc31b25e3d..9d4480a683ca 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -150,6 +150,29 @@ struct tnum tnum_intersect(struct tnum a, struct tnum b)
         return TNUM(v & ~mu, mu);
  }

+/*
+ * Each bit has 3 states: unkown, known 0, known 1. If using x to represent
+ * unknown state, the result of the union of two bits is as follows:
+ *
+ *         | x    0    1
+ *    -----+------------
+ *     x   | x    x    x
+ *     0   | x    0    x
+ *     1   | x    x    1
+ *
+ * For tnum a and b, only the bits that are both known 0 or known 1 in a
+ * and b are known in the result of union a and b.
+ */
+struct tnum tnum_union(struct tnum a, struct tnum b)
+{
+       u64 v0, v1, mu;
+
+       mu = a.mask | b.mask; // unkown bits either in a or b
+       v1 = (a.value & b.value) & ~mu; // "known 1" bits in both a and b
+       v0 = (~a.value & ~b.value) & ~mu; // "known 0" bits in both a and b
+       return TNUM(v1, mu | ~(v0 | v1));
+}
+
  struct tnum tnum_cast(struct tnum a, u8 size)
  {
         a.value &= (1ULL << (size * 8)) - 1;
  {
         a.value &= (1ULL << (size * 8)) - 1;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8f0f2e21699e..b69c89bc5cfc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13478,6 +13478,28 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
                 return;
         }

+       /* Special case: dst_reg is in range [-1, 0] */
+       if (dst_reg->s32_min_value == -1 && dst_reg->s32_max_value == 0) {
+               var32_off = tnum_union(src_reg->var_off, tnum_const(0));
+               dst_reg->var_off = tnum_with_subreg(dst_reg->var_off, var32_off);
+               dst_reg->u32_min_value = var32_off.value;
+               dst_reg->u32_max_value = min(dst_reg->u32_max_value, umax_val);
+               dst_reg->s32_min_value = min_t(s32, src_reg->s32_min_value, 0);
+               dst_reg->s32_max_value = max_t(s32, src_reg->s32_max_value, 0);
+               return;
+       }
+
+       /* Special case: src_reg is in range [-1, 0] */
+       if (src_reg->s32_min_value == -1 && src_reg->s32_max_value == 0) {
+               var32_off = tnum_union(dst_reg->var_off, tnum_const(0));
+               dst_reg->var_off = tnum_with_subreg(dst_reg->var_off, var32_off);
+               dst_reg->u32_min_value = var32_off.value;
+               dst_reg->u32_max_value = min(dst_reg->u32_max_value, umax_val);
+               dst_reg->s32_min_value = min_t(s32, dst_reg->s32_min_value, 0);
+               dst_reg->s32_max_value = max_t(s32, dst_reg->s32_max_value, 0);
+               return;
+       }
+
         /* We get our minimum from the var_off, since that's inherently
          * bitwise.  Our maximum is the minimum of the operands' maxima.
          */
@@ -13508,6 +13530,26 @@ static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
                 return;
         }

+       /* Special case: dst_reg is in range [-1, 0] */
+       if (dst_reg->smin_value == -1 && dst_reg->smax_value == 0) {
+               dst_reg->var_off = tnum_union(src_reg->var_off, tnum_const(0));
+               dst_reg->umin_value = dst_reg->var_off.value;
+               dst_reg->umax_value = min(dst_reg->umax_value, umax_val);
+               dst_reg->smin_value = min_t(s64, src_reg->smin_value, 0);
+               dst_reg->smax_value = max_t(s64, src_reg->smax_value, 0);
+               return;
+       }
+
+       /* Special case: src_reg is in range [-1, 0] */
+       if (src_reg->smin_value == -1 && src_reg->smax_value == 0) {
+               dst_reg->var_off = tnum_union(dst_reg->var_off, tnum_const(0));
+               dst_reg->umin_value = dst_reg->var_off.value;
+               dst_reg->umax_value = min(dst_reg->umax_value, umax_val);
+               dst_reg->smin_value = min_t(s64, dst_reg->smin_value, 0);
+               dst_reg->smax_value = max_t(s64, dst_reg->smax_value, 0);
+               return;
+       }
+

>> +               return;
>> +       }
>> +
>> +       /* Special case: dst_reg is known and src_reg is in range [-1, 0] */
>> +       if (dst_known &&
>> +               src_reg->s32_min_value == -1 && src_reg->s32_max_value == 0 &&
>> +               src_reg->smin_value == -1 && src_reg->smax_value == 0) {
>> +               dst_reg->s32_min_value = min_t(s32, dst_reg->s32_min_value, 0);
>> +               dst_reg->s32_max_value = max_t(s32, dst_reg->s32_min_value, 0);
>> +               return;
>> +       }
>> +
>>           /* Safe to set s32 bounds by casting u32 result into s32 when u32
>>            * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
>>            */
> 
> [...]
> 


