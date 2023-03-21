Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC3F6C2BE6
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 09:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCUIGV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 04:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCUIGU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 04:06:20 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C65E19B;
        Tue, 21 Mar 2023 01:06:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Pgkh443jvz4f3nqN;
        Tue, 21 Mar 2023 16:06:12 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
        by APP4 (Coremail) with SMTP id gCh0CgBnF6t1ZRlkXbEhFw--.4787S2;
        Tue, 21 Mar 2023 16:06:14 +0800 (CST)
Message-ID: <8aff940e-6618-f9b2-49e9-8d862705b098@huaweicloud.com>
Date:   Tue, 21 Mar 2023 16:06:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix a umin > umax reg bound error
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
References: <20230314203424.4015351-1-xukuohai@huaweicloud.com>
 <20230314203424.4015351-2-xukuohai@huaweicloud.com>
 <1331dd9c-4fb0-5347-6519-2b8d2dfea93d@iogearbox.net>
From:   Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <1331dd9c-4fb0-5347-6519-2b8d2dfea93d@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnF6t1ZRlkXbEhFw--.4787S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Zr1xXw4DJw4UtryftFyxZrb_yoW8XF47to
        WY9r45ArW5tw1xGr4UKw1kJr1akr1rGrnrtF1YganxGFyUAF1jy3yUA3y3G3y3AF1rGryU
        Cr1DJrWFyFykGw4Dn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYg7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWx
        JVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/18/2023 6:24 AM, Daniel Borkmann wrote:

> On 3/14/23 9:34 PM, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> After commit 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking"),
>> the following bpf prog is rejected:
>>
>> 0: (61) r2 = *(u32 *)(r1 +0)          ; R2_w=pkt(off=0,r=0,imm=0)
>> 1: (61) r3 = *(u32 *)(r1 +4)          ; R3_w=pkt_end(off=0,imm=0)
>> 2: (bf) r1 = r2
>> 3: (07) r1 += 1
>> 4: (2d) if r1 > r3 goto pc+8
>> 5: (71) r1 = *(u8 *)(r2 +0)           ; R1_w=scalar(umax=255,var_off=(0x0; 0xff))
>> 6: (18) r0 = 0x7fffffffffffff10
>> 8: (0f) r1 += r0                      ; R1_w=scalar(umin=0x7fffffffffffff10,umax=0x800000000000000f)
>> 9: (18) r0 = 0x8000000000000000
>> 11: (07) r0 += 1
>> 12: (ad) if r0 < r1 goto pc-2
>> 13: (b7) r0 = 0
>> 14: (95) exit
>>
>> And the verifier log says:
>>
>> [...]
>>
>> from 12 to 11: R0_w=-9223372036854775794 R1=scalar(umin=9223372036854775823,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
>> 11: (07) r0 += 1                      ; R0_w=-9223372036854775793
>> 12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775793 R1=scalar(umin=9223372036854775823,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
>> 13: safe
>>
>> from 12 to 11: R0_w=-9223372036854775793 R1=scalar(umin=9223372036854775824,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
>> 11: (07) r0 += 1                      ; R0_w=-9223372036854775792
>> 12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775792 R1=scalar(umin=9223372036854775824,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
>> 13: safe
>>
>> [...]
>>
>> What can be seen here is that r1->umin grows blindly and becomes bigger
>> than r1->umax. The reason is because the loop does not terminate, when
>> r0 increases to r1->umax_value, the following code in reg_set_min_max()
>> sets r1->umin_value to r1->umax_value + 1 blindly:
>>
>> case BPF_JGT:
>> {
>>          if (is_jmp32) {
>>                  [...]
>>          } else {
>>                  u64 false_umax = opcode == BPF_JGT ? val    : val - 1;
>>                  u64 true_umin = opcode == BPF_JGT ? val + 1 : val;
>>
>>                  false_reg->umax_value = min(false_reg->umax_value, false_umax);
>>                  true_reg->umin_value = max(true_reg->umin_value, true_umin);
>>          }
>>          break;
>> }
>>
>> Why the loop does not terminate is because tnum_is_const(src_reg->var_off)
>> always returns false, causing is_branch_taken() to be skipped:
>>
>> if (src_reg->type == SCALAR_VALUE &&
>>        !is_jmp32 && tnum_is_const(src_reg->var_off)) {
>>     pred = is_branch_taken(dst_reg,   // could not reach here
>>                    src_reg->var_off.value,
>>                    opcode,
>>                    is_jmp32);
>> }
>>
>> Why tnum_is_const(src_reg->var_off) always returns false is because
>> r1->umin_value starts increasing from 0x7fffffffffffff10, always bigger
>> than U32_MAX, causing the __reg_combine_64_into_32() to mark the lower
>> 32 bits unbounded, i.e. not a constant.
>>
>> To fix it:
>> 1. avoid increasing reg lower bound to a value bigger than the upper bound,
>>     or decreasing reg upper bound to a value smaller than the lower bound.
>> 2. set 32-bit min/max values to the lower 32 bits of the 64-bit min/max values
>>     when the 64-bit min/max values are equal.
> 
> Should both these be separate patches, meaning are both of them strictly
> required as one logical entity or not? From your description it's not really
> clear wrt reg_{inc,dec}_{u32,u64}_{min,max} and if this is mainly defensive
> or required.
>

It's defensive, not required. It was added to address "umin > umax" concerns
received in v1. Maybe I misunderstood something.

> Also, while you describe to some degree how we get here, there is no analysis
> on why your proposed changes are safe. If you want to make the verifier less
> conservative to start accepting such progs, can you then elaborate on the latter?
>

I have some discussion below and hope it makes some sense.

>> Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   kernel/bpf/verifier.c | 143 +++++++++++++++++++++++++++---------------
>>   1 file changed, 93 insertions(+), 50 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 2bbd89279070..b775b50353d6 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2223,14 +2223,21 @@ static bool __reg64_bound_u32(u64 a)
>>   static void __reg_combine_64_into_32(struct bpf_reg_state *reg)
>>   {
>> +    s64 smin = reg->smin_value;
>> +    s64 smax = reg->smax_value;
>> +    u64 umin = reg->umin_value;
>> +    u64 umax = reg->umax_value;
>> +
>>       __mark_reg32_unbounded(reg);
>> -    if (__reg64_bound_s32(reg->smin_value) && __reg64_bound_s32(reg->smax_value)) {
>> -        reg->s32_min_value = (s32)reg->smin_value;
>> -        reg->s32_max_value = (s32)reg->smax_value;
>> +    if ((__reg64_bound_s32(smin) && __reg64_bound_s32(smax)) ||
>> +        smin == smax) {
> 
> Did you look into debugging reg_bounds_sync()? Assumption for constant
> register is register_is_const() and it's explicitly looking at var_off.
>

I checked this function and saw that the low 32 bits and high 32 bits of
var_off are updated separately, and the new low/high 32 bits are the
intersection of the old low/high 32 bits and the new [u32_min, u32_max]
or [umin, umax] range. So as the range [u32_min, u32_max] or [umin, umax]
converges, the low/high 32 bits converge as well.

This converge process is reasonable. The lower 32 bits of var_off do not
converge to constant is because the range [u32_min, u32_max] does not
converge to constant.

IIUC, what _reg_combine_64_into_32 does before calling reg_bounds_sync is
find the value range of y when the 64-bit variable x changes from smin to
smax for function y = (s32)x, and the value range of y when x changes from
umin to umax for function y = (u32)x.

So when the value range of x is a constant, the value range of y is naturally
also a constant, that is, it's reasonable to infer u32_min == u32_max from
the 64-bit umin == umax.

In fact, the range of y could be found from function graph directly.

1. function graph for y = (u32)x:

                     ^ y = (u32)x
                     |
            U32_MAX  +                  _                   _
                     |                _/ |                _| |
                     |              _|   |              _|   |
                     |            _|     |            _|     |
                     |          _|       |          _|       |
                     |        _|         |        _|         |
                     |      _|           |      _|           |
                     |    _|             |    _|             |
                     |  _|               |  _|               |
                     | |                 | |                 |
                   0 +-------------------+-------------------+----> x/u64

                     |<---U32_MAX + 1--->|<---U32_MAX + 1--->|

1A) if umin == umax, then u32_min = (u32)umin, u32_max = (u32)umax:

                     ^ y = (u32)x
                     |
            U32_MAX  +                  _                   _
                     |                _/ |                _| |
                     |              _|   |              _|   |
                     |            _|     |            _|     |
  u32_min == u32_max | _ _ _ _  _|       |          _|       |
                     |        _|         |        _|         |
                     |      _| |         |      _|           |
                     |    _|   |         |    _|             |
                     |  _|     |         |  _|               |
                     | |       |         | |                 |
                   0 +---------+---------+-------------------+----> x/u64
                         umin == umax

                     |<---U32_MAX + 1--->|<---U32_MAX + 1--->|


1B) if umax - umin <= U32_MAX and (u32)umin < (u32)umax, then
     u32_min = (u32)umin, u32_max = (u32)umax:

                     ^ y = (u32)x
                     |
            U32_MAX  +                  _                   _
u32_max = (u32)umax | _ _ _ _ _ _ _  _/ |                _| |
                     |              _|   |              _|   |
                     |            _| |   |            _|     |
u32_min = (u32)umin | _ _ _ _  _|   |   |          _|       |
                     |        _|     |   |        _|         |
                     |      _| |     |   |      _|           |
                     |    _|   |     |   |    _|             |
                     |  _|     |     |   |  _|               |
                     | |       |     |   | |                 |
                   0 +---------+-----+---+-------------------+----> x/u64
                             umin   umax

                     |<---U32_MAX + 1--->|<---U32_MAX + 1--->|


1C) if umax - umin <= U32_MAX and (u32)umin > (u32)umax, then
     u32_min = U32_MIN, u32_max = U32_MAX:

                     ^ y = (u32)x
                     |
   u32_max = 32_MAX  +                  _                   _
                     |                _/ |                _| |
                     |              _|   |              _|   |
                     |            _|     |            _|     |
           (u32)umin | _ _ _ _  _|       |          _|       |
                     |        _|         |        _|         |
                     |      _| |         |      _|           |
           (u32)umax | _  _| _ |_ _ _ _ _|_ _ _|             |
                     |  _|     |         |  _| |             |
                     | |       |         | |   |             |
u32_min = U32_MIN 0 +---------+---------+-----+-------------+----> x/u64
                             umin             umax

                     |<---U32_MAX + 1--->|<---U32_MAX + 1--->|

1D) if umax - umin > U32_MAX, then u32_min = U32_MIN, u32_max = U32_MAX:

                     ^ y = (u32)x
                     |
   u32_max = 32_MAX  +                  _                   _
                     |                _/ |                _| |
           (u32)umax | _ _ _ _ _ _  _|_ _|_ _ _ _ _ _ _ _|   |
                     |            _|     |            _|     |
           (u32)umin | _ _ _ _  _|       |          _| |     |
                     |        _|         |        _|   |     |
                     |      _| |         |      _|     |     |
                     |    _|   |         |    _|       |     |
                     |  _|     |         |  _|         |     |
                     | |       |         | |           |     |
u32_min = U32_MIN 0 +---------+---------+-------------+-----+----> x/u64
                             umin                     umax

                     |<---U32_MAX + 1--->|<---U32_MAX + 1--->|


2. function graph for y = (s32)x:

                   ^ y = (s32)x
                   |
           S32_MAX | _ _ _ _ _                    _
                   |       _| |                 _| |
                   |     _|   |               _|   |
                   |   _|     |             _|     |
                   | _|       |           _|       |
       --+---------0----------+---------+----------+---> x/s64
         |        _|          |        _|
         |      _| |          |      _|
         |    _|   |          |    _|
         |  _|     |          |  _|
         |_| _ _ _ | S32_MIN  |_|
                   |
                   |
         |<--- U32_MAX + 1--->|<--- U32_MAX + 1--->|

2A) if smin == smax, then s32_min = (s32)smin, s32_max = (s32)smax:


                   ^ y = (s32)x
                   |
           S32_MAX | _ _ _ _ _                    _
                   |       _| |                 _| |
                   |     _|   |               _|   |
s32_min == s32_max|__ _|     |             _|     |
                   | _| |     |           _|       |
       --+---------0----+-----+---------+----------+---> x/s64
         |        _|   smin   |        _|
         |      _| |   smax   |      _|
         |    _|   |          |    _|
         |  _|     |          |  _|
         |_| _ _ _ | S32_MIN  |_|
                   |
                   |
         |<--- U32_MAX + 1--->|<--- U32_MAX + 1--->|



2B) if smax - smin <= U32_MAX and (s32)smin < (s32)smax, then
     s32_min = (u32)smin, s32_max = (s32)smax:


                   ^ y = (s32)x
                   |
           S32_MAX | _ _ _ _ _                    _
           s32_max | _ _ _ _| |                 _| |
                   |     _|   |               _|   |
                   |   _| |   |             _|     |
                   | _|   |   |           _|       |
       --+---+-----0------+---+---------+----------+---> x/s64
         |  smin  _|     smax |        _|
         |   |  _| |          |      _|
         |   |_|_ _| s32_min  |    _|
         |  _|     |          |  _|
         |_| _ _ _ | S32_MIN  |_|
                   |
                   |
         |<--- U32_MAX + 1--->|<--- U32_MAX + 1--->|

2C) if smax - smin <= U32_MAX and (s32)smin > (s32)smax, then
     s32_min = S32_MIN, s32_max = S32_MAX:

                   ^ y = (s32)x
                   |
s32_max = S32_MAX | _ _ _ _ _                    _
                   |       _| |                 _| |
         (s32)smin |_ _  _|   |               _|   |
                   |   _|     |             _|     |
                   | _| |     |   smax    _|       |
       --+---------0----+-----+-----+---+----------+---> x/s64
                   |   smin   |     |  _|
         (s32)smax | _ _ _ _ _|_ _ _|_|
                   |          |    _|
                   |          |  _|
s32_min = S32_MIN | _ _ _ _ _|_|
                   |
                   |
         |<--- U32_MAX + 1--->|<--- U32_MAX + 1--->|




2D) if smax - smin > U32_MAX, then s32_min = S32_MIN, s32_max = S32_MAX:

                   ^ y = (s32)x
                   |
s32_max = S32_MAX | _ _ _ _ _                    _
         (s32)smax | _ _ _ _|_|_ _ _ _ _ _ _ _  _| |
                   |     _|   |               _|   |
         (s32)smin | _ _|     |             _| |   |
                   | _|       |           _|   |   |
       --+---------0--+-------+---------+------+---+---> x/s64
                   | smin     |        _|     smax
                   |          |      _|
                   |          |    _|
                   |          |  _|
s32_min = S32_MIN | _ _ _ _ _|_|
                   |
                   |
         |<--- U32_MAX + 1--->|<--- U32_MAX + 1--->|

>> +        reg->s32_min_value = (s32)smin;
>> +        reg->s32_max_value = (s32)smax;
>>       }
>> -    if (__reg64_bound_u32(reg->umin_value) && __reg64_bound_u32(reg->umax_value)) {
>> -        reg->u32_min_value = (u32)reg->umin_value;
>> -        reg->u32_max_value = (u32)reg->umax_value;
>> +    if ((__reg64_bound_u32(umin) && __reg64_bound_u32(umax)) ||
>> +        umin == umax) {
>> +        reg->u32_min_value = (u32)umin;
>> +        reg->u32_max_value = (u32)umax;
>>       }
>>       reg_bounds_sync(reg);
>>   }
>> @@ -12828,6 +12835,62 @@ static int is_pkt_ptr_branch_taken(struct bpf_reg_state *dst_reg,
>>       return -1;
>>   }
>> +static void reg_inc_u32_min(struct bpf_reg_state *reg, u32 val)
>> +{
>> +    reg->u32_min_value = max(reg->u32_min_value, val);
>> +    if (reg->u32_min_value > reg->u32_max_value)
>> +        reg->u32_min_value = reg->u32_max_value;
>> +}
>> +
>> +static void reg_dec_u32_max(struct bpf_reg_state *reg, u32 val)
>> +{
>> +    reg->u32_max_value = min(reg->u32_max_value, val);
>> +    if (reg->u32_max_value < reg->u32_min_value)
>> +        reg->u32_max_value = reg->u32_min_value;
>> +}
>> +
>> +static void reg_inc_s32_min(struct bpf_reg_state *reg, s32 val)
>> +{
>> +    reg->s32_min_value = max(reg->s32_min_value, val);
>> +    if (reg->s32_min_value > reg->s32_max_value)
>> +        reg->s32_min_value = reg->s32_max_value;
>> +}
>> +
>> +static void reg_dec_s32_max(struct bpf_reg_state *reg, s32 val)
>> +{
>> +    reg->s32_max_value = min(reg->s32_max_value, val);
>> +    if (reg->s32_max_value < reg->s32_min_value)
>> +        reg->s32_max_value = reg->s32_min_value;
>> +}
>> +
>> +static void reg_inc_u64_min(struct bpf_reg_state *reg, u64 val)
>> +{
>> +    reg->umin_value = max(reg->umin_value, val);
>> +    if (reg->umin_value > reg->umax_value)
>> +        reg->umin_value = reg->umax_value;
>> +}
>> +
>> +static void reg_dec_u64_max(struct bpf_reg_state *reg, u64 val)
>> +{
>> +    reg->umax_value = min(reg->umax_value, val);
>> +    if (reg->umax_value < reg->umin_value)
>> +        reg->umax_value = reg->umin_value;
>> +}
>> +
>> +static void reg_inc_s64_min(struct bpf_reg_state *reg, s64 val)
>> +{
>> +    reg->smin_value = max(reg->smin_value, val);
>> +    if (reg->smin_value > reg->smax_value)
>> +        reg->smin_value = reg->smax_value;
>> +}
>> +
>> +static void reg_dec_s64_max(struct bpf_reg_state *reg, s64 val)
>> +{
>> +    reg->smax_value = min(reg->smax_value, val);
>> +    if (reg->smax_value < reg->smin_value)
>> +        reg->smax_value = reg->smin_value;
>> +}
> 
> All this feels more like a workaround and papering over the issue.
>

Agree, making umin > umax disappear from error log does not fix the
issue, and may make debugging more difficult.

>>   /* Adjusts the register min/max values in the case that the dst_reg is the
>>    * variable register that we are working on, and src_reg is a constant or we're
>>    * simply doing a BPF_K check.
>> @@ -12898,76 +12961,56 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
>>       case BPF_JGE:
>>       case BPF_JGT:
>>       {
>> -        if (is_jmp32) {
>> -            u32 false_umax = opcode == BPF_JGT ? val32  : val32 - 1;
>> -            u32 true_umin = opcode == BPF_JGT ? val32 + 1 : val32;
>> +        bool neq = (opcode == BPF_JGT);
>> -            false_reg->u32_max_value = min(false_reg->u32_max_value,
>> -                               false_umax);
>> -            true_reg->u32_min_value = max(true_reg->u32_min_value,
>> -                              true_umin);
>> +        if (is_jmp32) {
>> +            reg_dec_u32_max(false_reg, neq ? val32 : val32 - 1);
>> +            reg_inc_u32_min(true_reg, neq ? val32 + 1 : val32);
>>           } else {
>> -            u64 false_umax = opcode == BPF_JGT ? val    : val - 1;
>> -            u64 true_umin = opcode == BPF_JGT ? val + 1 : val;
>> -
>> -            false_reg->umax_value = min(false_reg->umax_value, false_umax);
>> -            true_reg->umin_value = max(true_reg->umin_value, true_umin);
>> +            reg_dec_u64_max(false_reg, neq ? val : val - 1);
>> +            reg_inc_u64_min(true_reg, neq ? val + 1 : val);
> .

