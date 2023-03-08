Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ADE6B03B4
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 11:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjCHKG0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 05:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjCHKGU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 05:06:20 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57710900B2;
        Wed,  8 Mar 2023 02:05:54 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PWnvc0Ff9zKqCv;
        Wed,  8 Mar 2023 18:03:40 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 18:05:39 +0800
Message-ID: <3600f642-a15e-b817-bca0-612233d18416@huawei.com>
Date:   Wed, 8 Mar 2023 18:05:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 1/2] bpf: update 32-bit bounds when the lower
 32-bit value is not wrapping
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Xu Kuohai <xukuohai@huaweicloud.com>
CC:     bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
References: <20230307220449.2933650-1-xukuohai@huaweicloud.com>
 <20230307220449.2933650-2-xukuohai@huaweicloud.com>
 <CAADnVQLDmP0A7Pr7628nH8YSo3-xTjzAr5-x-0YCZvuS8xu09A@mail.gmail.com>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <CAADnVQLDmP0A7Pr7628nH8YSo3-xTjzAr5-x-0YCZvuS8xu09A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/8/2023 1:22 AM, Alexei Starovoitov wrote:
> On Tue, Mar 7, 2023 at 1:05 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> The following XDP prog is accepted by verifier.
>>
>> 0: (61) r2 = *(u32 *)(r1 +0)          ; R2_w=pkt(off=0,r=0,imm=0)
>> 1: (61) r3 = *(u32 *)(r1 +4)          ; R3_w=pkt_end(off=0,imm=0)
>> 2: (bf) r1 = r2
>> 3: (07) r1 += 1
>> 4: (2d) if r1 > r3 goto pc+6
>> 5: (71) r1 = *(u8 *)(r2 +0)           ; R1_w=scalar(umax=255,var_off=(0x0; 0xff))
>> 6: (b4) w0 = 0x7fffff10
>> 7: (0c) w1 += w0                      ; R1_w=scalar(umin=0x7fffff10,umax=0x8000000f,var_off=(0x0; 0xffffffff))
>> 8: (b4) w0 = 0x80000000
>> 9: (04) w0 += 1
>> 10: (ae) if w0 < w1 goto pc-2
>> 11: (b7) r0 = 0
>> 12: (95) exit
>>
>> while the following 64-bit version is rejected.
>>
>> 0: (61) r2 = *(u32 *)(r1 +0)          ; R2_w=pkt(off=0,r=0,imm=0)
>> 1: (61) r3 = *(u32 *)(r1 +4)          ; R3_w=pkt_end(off=0,imm=0)
>> 2: (bf) r1 = r2
>> 3: (07) r1 += 1
>> 4: (2d) if r1 > r3 goto pc+8
>> 5: (71) r1 = *(u8 *)(r2 +0)           ; R1_w=scalar(umax=255,var_off=(0x0; 0xff))
>> 6: (18) r0 = 0x7fffffffffffff10
>> 8: (0f) r1 += r0                      ; R1_w=scalar(umin=0x7fffffffffffff10,umax=0x800000000000000f)
>> 9: (18) r0 = 0x8000000000000000
>> 11: (07) r0 += 1
>> 12: (ad) if r0 < r1 goto pc-2
>> 13: (b7) r0 = 0
>> 14: (95) exit
> 
> These two programs are not equivalent.
> Not clear how apples to oranges comparison explains anything.
> 

Yes, they are not equivalent. I assumed the 32-bit prog being accepted
implies it is unreasonable for the 64-bit prog to be rejected. Regardless
of this assumption and the 32-bit prog, the above 64-bit prog is expected
to be accepted, right?

>> The verifier log says:
>>
>> [...]
>>
>> from 12 to 11: R0_w=-9223372036854775794 R1=scalar(umin=9223372036854775823,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
>> 11: (07) r0 += 1                      ; R0_w=-9223372036854775793
>> 12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775793 R1=scalar(umin=9223372036854775823,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
>> 13: safe
>>
>> from 12 to 11: R0_w=-9223372036854775793 R1=scalar(umin=9223372036854775824,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
> 
> First thing to debug is why umin is higher than umax.
> 

Well, it's because the loop does not stop, when r0 increases to -9223372036854775793,
the following code in reg_set_min_max() sets umin_value to 9223372036854775824:

case BPF_JGT:
{
         if (is_jmp32) {
                 [...]
         } else {
                 u64 false_umax = opcode == BPF_JGT ? val    : val - 1;
                 u64 true_umin = opcode == BPF_JGT ? val + 1 : val;

                 false_reg->umax_value = min(false_reg->umax_value, false_umax);
                 true_reg->umin_value = max(true_reg->umin_value, true_umin);
         }
         break;
}

To avoid umin > umax, it could be changed it to:

case BPF_JGT:
{
         if (is_jmp32) {
                 [...]
         } else {
                 u64 false_umax = opcode == BPF_JGT ? val    : val - 1;
                 u64 true_umin = opcode == BPF_JGT ? val + 1 : val;

                 false_reg->umax_value = min(false_reg->umax_value, false_umax);
                 false_reg->umax_value = max(false_reg->umax_value, false_reg->umin_value);

                 true_reg->umin_value = max(true_reg->umin_value, true_umin);
                 true_reg->umin_value = min(true_reg->umax_value, true_reg->umin_value);
         }
         break;
}

The problem is that the loop still does not stop because tnum_is_const(src_reg->var_off)
always returns false and is_branch_taken() is skipped:

         if (BPF_SRC(insn->code) == BPF_K) {
                 [...]
         } else if (src_reg->type == SCALAR_VALUE &&
                    is_jmp32 && tnum_is_const(tnum_subreg(src_reg->var_off))) {
                 [...]
         } else if (src_reg->type == SCALAR_VALUE &&
                    !is_jmp32 && tnum_is_const(src_reg->var_off)) {
                 pred = is_branch_taken(dst_reg,   // could not reach here
                                        src_reg->var_off.value,
                                        opcode,
                                        is_jmp32);
         } else if (reg_is_pkt_pointer_any(dst_reg) &&
                    reg_is_pkt_pointer_any(src_reg) &&
                    !is_jmp32) {
                 [...]
         }

Why tnum_is_const(src_reg->var_off) returns false is because the lower 32-bit
is not constant since the lower 32-bit range is [U32_MIN, U32_MAX].

>> 11: (07) r0 += 1                      ; R0_w=-9223372036854775792
>> 12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775792 R1=scalar(umin=9223372036854775824,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
>> 13: safe
>>
>> [...]
>>
>> The loop crosses termination condition r0 == r1.umax, and does not stop.
>>
>> The reason is that when the verifier enumerates to r1.umin == r1.umax, the value
>> 0x800000000000000f of r1.umin is greater than U32_MAX, so __reg_combine_64_into_32
>> sets the u32 range of r1 to [0, U32_MAX] instead of marking r1 as a constant,
>> making is_branch_taken() in check_cond_jmp_op() be skipped.
> 
> And it's fine. The verifier is conservative.
> 
>>
>> To fix it, update 32-bit bounds when the lower 32-bit value is not wrapping,
>> even if the 64-bit value is beyond the range of [0, U32_MAX] or [S32_MIN, S32_MAX].
> 
> That's not safe in general.
>
>>
>> Signed-off-by: Xu Kuohai <xukuohai@huaweicloud.com>
>> ---
>>   kernel/bpf/verifier.c | 27 +++++++++++----------------
>>   1 file changed, 11 insertions(+), 16 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index b2116ca78d9a..64c9ee3857ec 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2013,26 +2013,21 @@ static void __reg_combine_32_into_64(struct bpf_reg_state *reg)
>>          reg_bounds_sync(reg);
>>   }
>>
>> -static bool __reg64_bound_s32(s64 a)
>> -{
>> -       return a >= S32_MIN && a <= S32_MAX;
>> -}
>> -
>> -static bool __reg64_bound_u32(u64 a)
>> -{
>> -       return a >= U32_MIN && a <= U32_MAX;
>> -}
>> -
>>   static void __reg_combine_64_into_32(struct bpf_reg_state *reg)
>>   {
>> +       s64 smin = reg->smin_value;
>> +       s64 smax = reg->smax_value;
>> +       u64 umin = reg->umin_value;
>> +       u64 umax = reg->umax_value;
>> +
>>          __mark_reg32_unbounded(reg);
>> -       if (__reg64_bound_s32(reg->smin_value) && __reg64_bound_s32(reg->smax_value)) {
>> -               reg->s32_min_value = (s32)reg->smin_value;
>> -               reg->s32_max_value = (s32)reg->smax_value;
>> +       if ((u64)(smax - smin) <= (u64)U32_MAX && (s32)smin <= (s32)smax) {
>> +               reg->s32_min_value = (s32)smin;
>> +               reg->s32_max_value = (s32)smax;
>>          }
>> -       if (__reg64_bound_u32(reg->umin_value) && __reg64_bound_u32(reg->umax_value)) {
>> -               reg->u32_min_value = (u32)reg->umin_value;
>> -               reg->u32_max_value = (u32)reg->umax_value;
>> +       if (umax - umin <= U32_MAX && (u32)umin <= (u32)umax) {
>> +               reg->u32_min_value = (u32)umin;
>> +               reg->u32_max_value = (u32)umax;
> 
> This looks like a workaround for umin > umax issue.
> Please debug that instead.
>

"__reg64_bound_u32(umin) && __reg64_bound_u32(max)" is a special case of
"umax - umin <= U32_MAX && (u32)umin <= (u32)umax " when umax <= U32_MAX.

If it's only safe to set lower 32-bit range to [U32_MIN, U32_MAX] when
umax > U32_MAX, could we infer the 64-bit value is a constant from umin == umax?

>>          }
>>          reg_bounds_sync(reg);
>>   }
>> --
>> 2.30.2
>>
> .

