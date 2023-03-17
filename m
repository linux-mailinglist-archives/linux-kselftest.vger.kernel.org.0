Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEE46BF50C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 23:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjCQWYO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 18:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjCQWYM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 18:24:12 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599821CF5F;
        Fri, 17 Mar 2023 15:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=QCSM8IY96H9KmBoQKZ61d+fRHLqM0SsEL5+eFIjtxeQ=; b=MeKcr7FnKCJYYleDV3l22ndAzd
        tvoekBNGdhglX8Iub9s237y4DIMT8ahcixRh0eP/H5V6QRKkAzknjBeogm5w2JrncqO+0ke/Pr/vd
        bfQBtuoM9YQ9H8lzUtj2xh9NlaPJrpBVJaRUkzXDiOIlUbtfIST+9aY3xCPFlxh+jlN/5hEK051dd
        ENEnvtp3+Ic1G4F3ud2QfTLazfv7fyvCcky6qW02FBFIKn9xNHFWN0MG24GNirUGv1P/LVxzgIm69
        X248gXH35Tkx+MS8xZEXdjSNi/am1Doz+zZtnxItDGA9cg0kR9lUiuCQYC7h5lVNRD8NGF+hhTDcE
        WYxY4low==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pdIUX-0000Ic-Ku; Fri, 17 Mar 2023 23:24:05 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pdIUX-000VJt-3y; Fri, 17 Mar 2023 23:24:05 +0100
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix a umin > umax reg bound error
To:     Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
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
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1331dd9c-4fb0-5347-6519-2b8d2dfea93d@iogearbox.net>
Date:   Fri, 17 Mar 2023 23:24:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230314203424.4015351-2-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26846/Fri Mar 17 08:22:57 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/14/23 9:34 PM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> After commit 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking"),
> the following bpf prog is rejected:
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
> And the verifier log says:
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
> What can be seen here is that r1->umin grows blindly and becomes bigger
> than r1->umax. The reason is because the loop does not terminate, when
> r0 increases to r1->umax_value, the following code in reg_set_min_max()
> sets r1->umin_value to r1->umax_value + 1 blindly:
> 
> case BPF_JGT:
> {
>          if (is_jmp32) {
>                  [...]
>          } else {
>                  u64 false_umax = opcode == BPF_JGT ? val    : val - 1;
>                  u64 true_umin = opcode == BPF_JGT ? val + 1 : val;
> 
>                  false_reg->umax_value = min(false_reg->umax_value, false_umax);
>                  true_reg->umin_value = max(true_reg->umin_value, true_umin);
>          }
>          break;
> }
> 
> Why the loop does not terminate is because tnum_is_const(src_reg->var_off)
> always returns false, causing is_branch_taken() to be skipped:
> 
> if (src_reg->type == SCALAR_VALUE &&
> 	   !is_jmp32 && tnum_is_const(src_reg->var_off)) {
> 	pred = is_branch_taken(dst_reg,   // could not reach here
> 			       src_reg->var_off.value,
> 			       opcode,
> 			       is_jmp32);
> }
> 
> Why tnum_is_const(src_reg->var_off) always returns false is because
> r1->umin_value starts increasing from 0x7fffffffffffff10, always bigger
> than U32_MAX, causing the __reg_combine_64_into_32() to mark the lower
> 32 bits unbounded, i.e. not a constant.
> 
> To fix it:
> 1. avoid increasing reg lower bound to a value bigger than the upper bound,
>     or decreasing reg upper bound to a value smaller than the lower bound.
> 2. set 32-bit min/max values to the lower 32 bits of the 64-bit min/max values
>     when the 64-bit min/max values are equal.

Should both these be separate patches, meaning are both of them strictly
required as one logical entity or not? From your description it's not really
clear wrt reg_{inc,dec}_{u32,u64}_{min,max} and if this is mainly defensive
or required.

Also, while you describe to some degree how we get here, there is no analysis
on why your proposed changes are safe. If you want to make the verifier less
conservative to start accepting such progs, can you then elaborate on the latter?

> Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>   kernel/bpf/verifier.c | 143 +++++++++++++++++++++++++++---------------
>   1 file changed, 93 insertions(+), 50 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2bbd89279070..b775b50353d6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2223,14 +2223,21 @@ static bool __reg64_bound_u32(u64 a)
>   
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
> +	if ((__reg64_bound_s32(smin) && __reg64_bound_s32(smax)) ||
> +		smin == smax) {

Did you look into debugging reg_bounds_sync()? Assumption for constant
register is register_is_const() and it's explicitly looking at var_off.

> +		reg->s32_min_value = (s32)smin;
> +		reg->s32_max_value = (s32)smax;
>   	}
> -	if (__reg64_bound_u32(reg->umin_value) && __reg64_bound_u32(reg->umax_value)) {
> -		reg->u32_min_value = (u32)reg->umin_value;
> -		reg->u32_max_value = (u32)reg->umax_value;
> +	if ((__reg64_bound_u32(umin) && __reg64_bound_u32(umax)) ||
> +		umin == umax) {
> +		reg->u32_min_value = (u32)umin;
> +		reg->u32_max_value = (u32)umax;
>   	}
>   	reg_bounds_sync(reg);
>   }
> @@ -12828,6 +12835,62 @@ static int is_pkt_ptr_branch_taken(struct bpf_reg_state *dst_reg,
>   	return -1;
>   }
>   
> +static void reg_inc_u32_min(struct bpf_reg_state *reg, u32 val)
> +{
> +	reg->u32_min_value = max(reg->u32_min_value, val);
> +	if (reg->u32_min_value > reg->u32_max_value)
> +		reg->u32_min_value = reg->u32_max_value;
> +}
> +
> +static void reg_dec_u32_max(struct bpf_reg_state *reg, u32 val)
> +{
> +	reg->u32_max_value = min(reg->u32_max_value, val);
> +	if (reg->u32_max_value < reg->u32_min_value)
> +		reg->u32_max_value = reg->u32_min_value;
> +}
> +
> +static void reg_inc_s32_min(struct bpf_reg_state *reg, s32 val)
> +{
> +	reg->s32_min_value = max(reg->s32_min_value, val);
> +	if (reg->s32_min_value > reg->s32_max_value)
> +		reg->s32_min_value = reg->s32_max_value;
> +}
> +
> +static void reg_dec_s32_max(struct bpf_reg_state *reg, s32 val)
> +{
> +	reg->s32_max_value = min(reg->s32_max_value, val);
> +	if (reg->s32_max_value < reg->s32_min_value)
> +		reg->s32_max_value = reg->s32_min_value;
> +}
> +
> +static void reg_inc_u64_min(struct bpf_reg_state *reg, u64 val)
> +{
> +	reg->umin_value = max(reg->umin_value, val);
> +	if (reg->umin_value > reg->umax_value)
> +		reg->umin_value = reg->umax_value;
> +}
> +
> +static void reg_dec_u64_max(struct bpf_reg_state *reg, u64 val)
> +{
> +	reg->umax_value = min(reg->umax_value, val);
> +	if (reg->umax_value < reg->umin_value)
> +		reg->umax_value = reg->umin_value;
> +}
> +
> +static void reg_inc_s64_min(struct bpf_reg_state *reg, s64 val)
> +{
> +	reg->smin_value = max(reg->smin_value, val);
> +	if (reg->smin_value > reg->smax_value)
> +		reg->smin_value = reg->smax_value;
> +}
> +
> +static void reg_dec_s64_max(struct bpf_reg_state *reg, s64 val)
> +{
> +	reg->smax_value = min(reg->smax_value, val);
> +	if (reg->smax_value < reg->smin_value)
> +		reg->smax_value = reg->smin_value;
> +}

All this feels more like a workaround and papering over the issue.

>   /* Adjusts the register min/max values in the case that the dst_reg is the
>    * variable register that we are working on, and src_reg is a constant or we're
>    * simply doing a BPF_K check.
> @@ -12898,76 +12961,56 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
>   	case BPF_JGE:
>   	case BPF_JGT:
>   	{
> -		if (is_jmp32) {
> -			u32 false_umax = opcode == BPF_JGT ? val32  : val32 - 1;
> -			u32 true_umin = opcode == BPF_JGT ? val32 + 1 : val32;
> +		bool neq = (opcode == BPF_JGT);
>   
> -			false_reg->u32_max_value = min(false_reg->u32_max_value,
> -						       false_umax);
> -			true_reg->u32_min_value = max(true_reg->u32_min_value,
> -						      true_umin);
> +		if (is_jmp32) {
> +			reg_dec_u32_max(false_reg, neq ? val32 : val32 - 1);
> +			reg_inc_u32_min(true_reg, neq ? val32 + 1 : val32);
>   		} else {
> -			u64 false_umax = opcode == BPF_JGT ? val    : val - 1;
> -			u64 true_umin = opcode == BPF_JGT ? val + 1 : val;
> -
> -			false_reg->umax_value = min(false_reg->umax_value, false_umax);
> -			true_reg->umin_value = max(true_reg->umin_value, true_umin);
> +			reg_dec_u64_max(false_reg, neq ? val : val - 1);
> +			reg_inc_u64_min(true_reg, neq ? val + 1 : val);
