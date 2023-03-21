Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CA06C2C56
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 09:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjCUI3M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 04:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjCUI2g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 04:28:36 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A80DBC5;
        Tue, 21 Mar 2023 01:28:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pgl9l0FLkz4f3v4b;
        Tue, 21 Mar 2023 16:28:27 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
        by APP4 (Coremail) with SMTP id gCh0CgAn2q2rahlkjrEiFw--.11771S2;
        Tue, 21 Mar 2023 16:28:28 +0800 (CST)
Message-ID: <9aa7b0ed-dfe0-325a-ad22-94a30d167cda@huaweicloud.com>
Date:   Tue, 21 Mar 2023 16:28:27 +0800
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
 <9c4c6052-974d-dbea-42dd-42a02c23ba01@iogearbox.net>
From:   Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <9c4c6052-974d-dbea-42dd-42a02c23ba01@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAn2q2rahlkjrEiFw--.11771S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JryUXw1DXFWrCw1xJw1DJrb_yoW7trWfpr
        y8JF1UGrWkJr18Jw1Utw1UJry8tr18J3WUXr1UJFyUAr1UWr1jqr1UWr1jgF1DJr48Jr17
        tr1DXrW2vr1Utw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUAxhLUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/21/2023 12:42 AM, Daniel Borkmann wrote:
> On 3/17/23 11:24 PM, Daniel Borkmann wrote:
>> On 3/14/23 9:34 PM, Xu Kuohai wrote:
>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>
>>> After commit 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking"),
>>> the following bpf prog is rejected:
>>>
>>> 0: (61) r2 = *(u32 *)(r1 +0)          ; R2_w=pkt(off=0,r=0,imm=0)
>>> 1: (61) r3 = *(u32 *)(r1 +4)          ; R3_w=pkt_end(off=0,imm=0)
>>> 2: (bf) r1 = r2
>>> 3: (07) r1 += 1
>>> 4: (2d) if r1 > r3 goto pc+8
>>> 5: (71) r1 = *(u8 *)(r2 +0)           ; R1_w=scalar(umax=255,var_off=(0x0; 0xff))
>>> 6: (18) r0 = 0x7fffffffffffff10
>>> 8: (0f) r1 += r0                      ; R1_w=scalar(umin=0x7fffffffffffff10,umax=0x800000000000000f)
>>> 9: (18) r0 = 0x8000000000000000
>>> 11: (07) r0 += 1
>>> 12: (ad) if r0 < r1 goto pc-2
>>> 13: (b7) r0 = 0
>>> 14: (95) exit
>>>
>>> And the verifier log says:
>>>
>>> [...]
>>>
>>> from 12 to 11: R0_w=-9223372036854775794 R1=scalar(umin=9223372036854775823,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
>>> 11: (07) r0 += 1                      ; R0_w=-9223372036854775793
>>> 12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775793 R1=scalar(umin=9223372036854775823,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
>>> 13: safe
>>>
>>> from 12 to 11: R0_w=-9223372036854775793 R1=scalar(umin=9223372036854775824,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
>>> 11: (07) r0 += 1                      ; R0_w=-9223372036854775792
>>> 12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775792 R1=scalar(umin=9223372036854775824,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
>>> 13: safe
>>>
>>> [...]
>>>
>>> What can be seen here is that r1->umin grows blindly and becomes bigger
>>> than r1->umax. The reason is because the loop does not terminate, when
>>> r0 increases to r1->umax_value, the following code in reg_set_min_max()
>>> sets r1->umin_value to r1->umax_value + 1 blindly:
>>>
>>> case BPF_JGT:
>>> {
>>>          if (is_jmp32) {
>>>                  [...]
>>>          } else {
>>>                  u64 false_umax = opcode == BPF_JGT ? val    : val - 1;
>>>                  u64 true_umin = opcode == BPF_JGT ? val + 1 : val;
>>>
>>>                  false_reg->umax_value = min(false_reg->umax_value, false_umax);
>>>                  true_reg->umin_value = max(true_reg->umin_value, true_umin);
>>>          }
>>>          break;
>>> }
>>>
>>> Why the loop does not terminate is because tnum_is_const(src_reg->var_off)
>>> always returns false, causing is_branch_taken() to be skipped:
>>>
>>> if (src_reg->type == SCALAR_VALUE &&
>>>        !is_jmp32 && tnum_is_const(src_reg->var_off)) {
>>>     pred = is_branch_taken(dst_reg,   // could not reach here
>>>                    src_reg->var_off.value,
>>>                    opcode,
>>>                    is_jmp32);
>>> }
>>>
>>> Why tnum_is_const(src_reg->var_off) always returns false is because
>>> r1->umin_value starts increasing from 0x7fffffffffffff10, always bigger
>>> than U32_MAX, causing the __reg_combine_64_into_32() to mark the lower
>>> 32 bits unbounded, i.e. not a constant.
>>>
>>> To fix it:
>>> 1. avoid increasing reg lower bound to a value bigger than the upper bound,
>>>     or decreasing reg upper bound to a value smaller than the lower bound.
>>> 2. set 32-bit min/max values to the lower 32 bits of the 64-bit min/max values
>>>     when the 64-bit min/max values are equal.
>>
>> Should both these be separate patches, meaning are both of them strictly
>> required as one logical entity or not? From your description it's not really
>> clear wrt reg_{inc,dec}_{u32,u64}_{min,max} and if this is mainly defensive
>> or required.
> 
> Fyi, I'm working on the below draft patch which passes all of test_verifier and
> your test cases as well from patch 2. Will cook a proper patch once I'm through
> with further analysis:
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d517d13878cf..8bef2ed89e87 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1823,7 +1823,7 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
>          struct tnum var64_off = tnum_intersect(reg->var_off,
>                                                 tnum_range(reg->umin_value,
>                                                            reg->umax_value));
> -       struct tnum var32_off = tnum_intersect(tnum_subreg(reg->var_off),
> +       struct tnum var32_off = tnum_intersect(tnum_subreg(var64_off),
>                                                  tnum_range(reg->u32_min_value,
>                                                             reg->u32_max_value));
> .

[forget to reply to the list, resend]

Thanks for the patch, it works for me. But as replied in the other mail,
it seems more reasonable to converge var32_off to constant by converging
[u32_min_value, u32_max_value] to constant.

