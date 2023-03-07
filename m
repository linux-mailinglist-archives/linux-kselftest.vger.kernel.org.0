Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5966ADA28
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 10:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCGJVo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 04:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCGJVk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 04:21:40 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CD753704;
        Tue,  7 Mar 2023 01:21:15 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PW9123tKNz4f3m6v;
        Tue,  7 Mar 2023 17:21:10 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
        by APP4 (Coremail) with SMTP id gCh0CgD3qa0HAgdkG0+gEw--.54420S2;
        Tue, 07 Mar 2023 17:21:12 +0800 (CST)
Message-ID: <1d1cb28f-c587-2359-b298-23766de66138@huaweicloud.com>
Date:   Tue, 7 Mar 2023 17:21:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 1/2] bpf: update 32-bit bounds when the lower
 32-bit value is not wrapping
Content-Language: en-US
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
In-Reply-To: <20230307220449.2933650-2-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgD3qa0HAgdkG0+gEw--.54420S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW3Kr4DXw4fWw47Wr13CFg_yoWrAry3pr
        W5GF1DGF4kX348C3yxtws8t34vyF18Aa1xWFWUury8ArnIg34qvr17Kry5KasayFyxZa1I
        q3ZrX3yUK3yUt3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/8/2023 6:04 AM, Xu Kuohai wrote:
> The following XDP prog is accepted by verifier.
> 
> 0: (61) r2 = *(u32 *)(r1 +0)          ; R2_w=pkt(off=0,r=0,imm=0)
> 1: (61) r3 = *(u32 *)(r1 +4)          ; R3_w=pkt_end(off=0,imm=0)
> 2: (bf) r1 = r2
> 3: (07) r1 += 1
> 4: (2d) if r1 > r3 goto pc+6
> 5: (71) r1 = *(u8 *)(r2 +0)           ; R1_w=scalar(umax=255,var_off=(0x0; 0xff))
> 6: (b4) w0 = 0x7fffff10
> 7: (0c) w1 += w0                      ; R1_w=scalar(umin=0x7fffff10,umax=0x8000000f,var_off=(0x0; 0xffffffff))
> 8: (b4) w0 = 0x80000000
> 9: (04) w0 += 1
> 10: (ae) if w0 < w1 goto pc-2
> 11: (b7) r0 = 0
> 12: (95) exit
> 
> while the following 64-bit version is rejected.
> 
> 0: (61) r2 = *(u32 *)(r1 +0)          ; R2_w=pkt(off=0,r=0,imm=0)
> 1: (61) r3 = *(u32 *)(r1 +4)          ; R3_w=pkt_end(off=0,imm=0)
> 2: (bf) r1 = r2
> 3: (07) r1 += 1
> 4: (2d) if r1 > r3 goto pc+8
> 5: (71) r1 = *(u8 *)(r2 +0)           ; R1_w=scalar(umax=255,var_off=(0x0; 0xff))
> 6: (18) r0 = 0x7fffffffffffff10
> 8: (0f) r1 += r0                      ; R1_w=scalar(umin=0x7fffffffffffff10,umax=0x800000000000000f)
> 9: (18) r0 = 0x8000000000000000
> 11: (07) r0 += 1
> 12: (ad) if r0 < r1 goto pc-2
> 13: (b7) r0 = 0
> 14: (95) exit
> 
> The verifier log says:
> 
> [...]
> 
> from 12 to 11: R0_w=-9223372036854775794 R1=scalar(umin=9223372036854775823,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
> 11: (07) r0 += 1                      ; R0_w=-9223372036854775793
> 12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775793 R1=scalar(umin=9223372036854775823,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
> 13: safe
> 
> from 12 to 11: R0_w=-9223372036854775793 R1=scalar(umin=9223372036854775824,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
> 11: (07) r0 += 1                      ; R0_w=-9223372036854775792
> 12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775792 R1=scalar(umin=9223372036854775824,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
> 13: safe
> 
> [...]
> 
> The loop crosses termination condition r0 == r1.umax, and does not stop.
> 
> The reason is that when the verifier enumerates to r1.umin == r1.umax, the value
> 0x800000000000000f of r1.umin is greater than U32_MAX, so __reg_combine_64_into_32
> sets the u32 range of r1 to [0, U32_MAX] instead of marking r1 as a constant,
> making is_branch_taken() in check_cond_jmp_op() be skipped.
> 
> To fix it, update 32-bit bounds when the lower 32-bit value is not wrapping,
> even if the 64-bit value is beyond the range of [0, U32_MAX] or [S32_MIN, S32_MAX].
> 
> Signed-off-by: Xu Kuohai <xukuohai@huaweicloud.com>

Oops, missing fixes tag, will resend

> ---
>   kernel/bpf/verifier.c | 27 +++++++++++----------------
>   1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b2116ca78d9a..64c9ee3857ec 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2013,26 +2013,21 @@ static void __reg_combine_32_into_64(struct bpf_reg_state *reg)
>   	reg_bounds_sync(reg);
>   }
>   
> -static bool __reg64_bound_s32(s64 a)
> -{
> -	return a >= S32_MIN && a <= S32_MAX;
> -}
> -
> -static bool __reg64_bound_u32(u64 a)
> -{
> -	return a >= U32_MIN && a <= U32_MAX;
> -}
> -
>   static void __reg_combine_64_into_32(struct bpf_reg_state *reg)
>   {
> +	s64 smin = reg->smin_value;
> +	s64 smax = reg->smax_value;
> +	u64 umin = reg->umin_value;
> +	u64 umax = reg->umax_value;
> +
>   	__mark_reg32_unbounded(reg);
> -	if (__reg64_bound_s32(reg->smin_value) && __reg64_bound_s32(reg->smax_value)) {
> -		reg->s32_min_value = (s32)reg->smin_value;
> -		reg->s32_max_value = (s32)reg->smax_value;
> +	if ((u64)(smax - smin) <= (u64)U32_MAX && (s32)smin <= (s32)smax) {
> +		reg->s32_min_value = (s32)smin;
> +		reg->s32_max_value = (s32)smax;
>   	}
> -	if (__reg64_bound_u32(reg->umin_value) && __reg64_bound_u32(reg->umax_value)) {
> -		reg->u32_min_value = (u32)reg->umin_value;
> -		reg->u32_max_value = (u32)reg->umax_value;
> +	if (umax - umin <= U32_MAX && (u32)umin <= (u32)umax) {
> +		reg->u32_min_value = (u32)umin;
> +		reg->u32_max_value = (u32)umax;
>   	}
>   	reg_bounds_sync(reg);
>   }

