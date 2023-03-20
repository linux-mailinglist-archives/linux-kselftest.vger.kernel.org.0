Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230766C1CD3
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 17:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjCTQwd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 12:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjCTQwP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 12:52:15 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015A73A8A;
        Mon, 20 Mar 2023 09:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=WyT5pk+JdnVwgOoOQiKG7pJHdKl0DzzKPRLhy5H2GH0=; b=R9vXyQqav0Qp5+OFU6PGanrsAw
        XtTDDqXQ0q2NlSoz85EE+nc/RSVBwvlSaVG3bMe30ilZptvlzwodBALhuoXxTJtmMLO+tETZ3Mo85
        jQOddePwuWVpYCEiNSbxo7LMsj8f7/jTQpEM+rZo4Bqr3V6b9lGcPiisqLKKhSnLL0BCIxxwcMfGJ
        BmuJpieSb0f63HnwgfkeJomgW2GXu/98Ji/mkShDs41lkKdSZs6wFA3fKqXaZS8XWquR0PwEFqckO
        BoZaz5KmMSzGelq4mrbZKr6lZuNpj2tYp0UYhKdivG/BPKIRTS77cZ1HRRLVdUSBmE8pwmRDZ+yIB
        BfrG4oEQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1peIaX-000A2h-7W; Mon, 20 Mar 2023 17:42:25 +0100
Received: from [81.6.34.132] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1peIaW-0009Og-M2; Mon, 20 Mar 2023 17:42:24 +0100
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Fix a umin > umax reg bound error
From:   Daniel Borkmann <daniel@iogearbox.net>
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
 <1331dd9c-4fb0-5347-6519-2b8d2dfea93d@iogearbox.net>
Message-ID: <9c4c6052-974d-dbea-42dd-42a02c23ba01@iogearbox.net>
Date:   Mon, 20 Mar 2023 17:42:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1331dd9c-4fb0-5347-6519-2b8d2dfea93d@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26849/Mon Mar 20 08:24:18 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/17/23 11:24 PM, Daniel Borkmann wrote:
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

Fyi, I'm working on the below draft patch which passes all of test_verifier and
your test cases as well from patch 2. Will cook a proper patch once I'm through
with further analysis:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d517d13878cf..8bef2ed89e87 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1823,7 +1823,7 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
         struct tnum var64_off = tnum_intersect(reg->var_off,
                                                tnum_range(reg->umin_value,
                                                           reg->umax_value));
-       struct tnum var32_off = tnum_intersect(tnum_subreg(reg->var_off),
+       struct tnum var32_off = tnum_intersect(tnum_subreg(var64_off),
                                                 tnum_range(reg->u32_min_value,
                                                            reg->u32_max_value));
