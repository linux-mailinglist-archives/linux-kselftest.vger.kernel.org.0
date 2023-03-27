Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE1D6C9B51
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 08:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjC0GUr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 02:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjC0GUr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 02:20:47 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A72FD;
        Sun, 26 Mar 2023 23:20:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PlN3Y08tXz4f3tpm;
        Mon, 27 Mar 2023 14:20:41 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
        by APP4 (Coremail) with SMTP id gCh0CgDHea23NSFkHPWcGA--.44812S2;
        Mon, 27 Mar 2023 14:20:40 +0800 (CST)
Message-ID: <a4e44814-3c92-ccab-2a14-7824dfd44488@huaweicloud.com>
Date:   Mon, 27 Mar 2023 14:20:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove two infinite loop bound
 check cases
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20230327153538.850440-1-xukuohai@huaweicloud.com>
 <CAEf4BzZuf=G0sEk5XqB0nAbvr81uRChLa96WDz0jCSG82=kofQ@mail.gmail.com>
From:   Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAEf4BzZuf=G0sEk5XqB0nAbvr81uRChLa96WDz0jCSG82=kofQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHea23NSFkHPWcGA--.44812S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWryUJw1fZFyrtF1rJF1rtFb_yoWrJF1fpa
        4rXFnrJr48Ja1jv3ykKFW2qry2qrW8J3y7Aas2kryxAry7tanxKa4Utw45C3ZIyrn3Gr4S
        vr15uwn7Ka4UWaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/27/2023 11:20 AM, Andrii Nakryiko wrote:
> On Sun, Mar 26, 2023 at 7:45 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> The two infinite loop bound check cases added by commit
>> 1a3148fc171f ("selftests/bpf: Check when bounds are not in the 32-bit range")
>> take a long time to execute but don't add much value.
>>
>> Remove them to reduce run time of test_verifier.
> 
> Summary: 2042 PASSED, 0 SKIPPED, 1 FAILED
> 
> real    0m4.780s
> user    0m0.458s
> sys     0m3.871s
> 
> 
> 5 seconds isn't such a long time, especially when we compare it to
> test_progs (even with parallelization).
> 

Well, I actually don't know if it is "long time".

This patch was sent to address Alexei's concern about the run time
of test_verifier in mail [1].

[1] https://lore.kernel.org/bpf/20230322213056.2470-1-daniel@iogearbox.net/T/#mb3d6363a693ccd63d416d9d787db17f8fdcb8442

>>
>> Fixes: 1a3148fc171f ("selftests/bpf: Check when bounds are not in the 32-bit range")
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   tools/testing/selftests/bpf/verifier/bounds.c | 50 -------------------
>>   1 file changed, 50 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/verifier/bounds.c b/tools/testing/selftests/bpf/verifier/bounds.c
>> index 74b1917d4208..515a8222f08f 100644
>> --- a/tools/testing/selftests/bpf/verifier/bounds.c
>> +++ b/tools/testing/selftests/bpf/verifier/bounds.c
>> @@ -777,31 +777,6 @@
>>          .result = ACCEPT,
>>          .prog_type = BPF_PROG_TYPE_XDP,
>>   },
>> -{
>> -       "bound check with JMP_JSLT for crossing 64-bit signed boundary",
>> -       .insns = {
>> -       BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
>> -       BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
>> -       BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
>> -       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
>> -       BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 8),
>> -
>> -       BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
>> -       BPF_LD_IMM64(BPF_REG_0, 0x7fffffffffffff10),
>> -       BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
>> -
>> -       BPF_LD_IMM64(BPF_REG_0, 0x8000000000000000),
>> -       BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
>> -       /* r1 signed range is [S64_MIN, S64_MAX] */
>> -       BPF_JMP_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
>> -
>> -       BPF_MOV64_IMM(BPF_REG_0, 0),
>> -       BPF_EXIT_INSN(),
>> -       },
>> -       .errstr = "BPF program is too large",
>> -       .result = REJECT,
>> -       .prog_type = BPF_PROG_TYPE_XDP,
>> -},
>>   {
>>          "bound check for loop upper bound greater than U32_MAX",
>>          .insns = {
>> @@ -849,28 +824,3 @@
>>          .result = ACCEPT,
>>          .prog_type = BPF_PROG_TYPE_XDP,
>>   },
>> -{
>> -       "bound check with JMP32_JSLT for crossing 32-bit signed boundary",
>> -       .insns = {
>> -       BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, offsetof(struct xdp_md, data)),
>> -       BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, offsetof(struct xdp_md, data_end)),
>> -       BPF_MOV64_REG(BPF_REG_1, BPF_REG_2),
>> -       BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 1),
>> -       BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_3, 6),
>> -
>> -       BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_2, 0),
>> -       BPF_MOV32_IMM(BPF_REG_0, 0x7fffff10),
>> -       BPF_ALU32_REG(BPF_ADD, BPF_REG_1, BPF_REG_0),
>> -
>> -       BPF_MOV32_IMM(BPF_REG_0, 0x80000000),
>> -       BPF_ALU32_IMM(BPF_ADD, BPF_REG_0, 1),
>> -       /* r1 signed range is [S32_MIN, S32_MAX] */
>> -       BPF_JMP32_REG(BPF_JSLT, BPF_REG_0, BPF_REG_1, -2),
>> -
>> -       BPF_MOV64_IMM(BPF_REG_0, 0),
>> -       BPF_EXIT_INSN(),
>> -       },
>> -       .errstr = "BPF program is too large",
>> -       .result = REJECT,
>> -       .prog_type = BPF_PROG_TYPE_XDP,
>> -},
>> --
>> 2.30.2
>>
> .

