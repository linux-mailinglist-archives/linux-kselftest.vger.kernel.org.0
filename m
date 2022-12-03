Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DDD6413D9
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Dec 2022 03:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiLCC6v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 21:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbiLCC6u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 21:58:50 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570AEEE94D;
        Fri,  2 Dec 2022 18:58:48 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NPDyK1nTszFprd;
        Sat,  3 Dec 2022 10:58:01 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Dec 2022 10:58:44 +0800
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Adapt 32-bit return value kfunc for
 32-bit ARM when zext extension
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        <colin.i.king@gmail.com>, Artem Savkov <asavkov@redhat.com>,
        Delyan Kratunov <delyank@fb.com>, bpf <bpf@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20221126094530.226629-1-yangjihong1@huawei.com>
 <20221126094530.226629-2-yangjihong1@huawei.com>
 <20221128015758.aekybr3qlahfopwq@MacBook-Pro-5.local>
 <dc9d1823-80f2-e2d9-39a8-c39b6f52dec5@huawei.com>
 <CAADnVQJPRCnESmJ92W39bo-btqNbYaNsGQO0is6FD3JLU_mSjQ@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <8cb54255-4dce-6d50-d6f0-ac9af0e56f37@huawei.com>
Date:   Sat, 3 Dec 2022 10:58:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAADnVQJPRCnESmJ92W39bo-btqNbYaNsGQO0is6FD3JLU_mSjQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2022/11/29 0:41, Alexei Starovoitov wrote:
> On Mon, Nov 28, 2022 at 4:40 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>>
>>
>> On 2022/11/28 9:57, Alexei Starovoitov wrote:
>>> On Sat, Nov 26, 2022 at 05:45:27PM +0800, Yang Jihong wrote:
>>>> For ARM32 architecture, if data width of kfunc return value is 32 bits,
>>>> need to do explicit zero extension for high 32-bit, insn_def_regno should
>>>> return dst_reg for BPF_JMP type of BPF_PSEUDO_KFUNC_CALL. Otherwise,
>>>> opt_subreg_zext_lo32_rnd_hi32 returns -EFAULT, resulting in BPF failure.
>>>>
>>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>>> ---
>>>>    kernel/bpf/verifier.c | 44 ++++++++++++++++++++++++++++++++++++++++---
>>>>    1 file changed, 41 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 264b3dc714cc..193ea927aa69 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -1927,6 +1927,21 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
>>>>                      sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
>>>>    }
>>>>
>>>> +static int kfunc_desc_cmp_by_imm(const void *a, const void *b);
>>>> +
>>>> +static const struct bpf_kfunc_desc *
>>>> +find_kfunc_desc_by_imm(const struct bpf_prog *prog, s32 imm)
>>>> +{
>>>> +    struct bpf_kfunc_desc desc = {
>>>> +            .imm = imm,
>>>> +    };
>>>> +    struct bpf_kfunc_desc_tab *tab;
>>>> +
>>>> +    tab = prog->aux->kfunc_tab;
>>>> +    return bsearch(&desc, tab->descs, tab->nr_descs,
>>>> +                   sizeof(tab->descs[0]), kfunc_desc_cmp_by_imm);
>>>> +}
>>>> +
>>>>    static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
>>>>                                        s16 offset)
>>>>    {
>>>> @@ -2342,6 +2357,13 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>>>                        */
>>>>                       if (insn->src_reg == BPF_PSEUDO_CALL)
>>>>                               return false;
>>>> +
>>>> +                    /* Kfunc call will reach here because of insn_has_def32,
>>>> +                     * conservatively return TRUE.
>>>> +                     */
>>>> +                    if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL)
>>>> +                            return true;
>>>> +
>>>>                       /* Helper call will reach here because of arg type
>>>>                        * check, conservatively return TRUE.
>>>>                        */
>>>> @@ -2405,10 +2427,26 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>>>    }
>>>>
>>>>    /* Return the regno defined by the insn, or -1. */
>>>> -static int insn_def_regno(const struct bpf_insn *insn)
>>>> +static int insn_def_regno(struct bpf_verifier_env *env, const struct bpf_insn *insn)
>>>>    {
>>>>       switch (BPF_CLASS(insn->code)) {
>>>>       case BPF_JMP:
>>>> +            if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
>>>> +                    const struct bpf_kfunc_desc *desc;
>>>> +
>>>> +                    /* The value of desc cannot be NULL */
>>>> +                    desc = find_kfunc_desc_by_imm(env->prog, insn->imm);
>>>> +
>>>> +                    /* A kfunc can return void.
>>>> +                     * The btf type of the kfunc's return value needs
>>>> +                     * to be checked against "void" first
>>>> +                     */
>>>> +                    if (desc->func_model.ret_size == 0)
>>>> +                            return -1;
>>>> +                    else
>>>> +                            return insn->dst_reg;
>>>> +            }
>>>> +            fallthrough;
>>>
>>> I cannot make any sense of this patch.
>>> insn->dst_reg above is 0.
>>> The kfunc call doesn't define a register from insn_def_regno() pov.
>>>
>>> Are you hacking insn_def_regno() to return 0 so that
>>> if (WARN_ON(load_reg == -1)) {
>>>     verbose(env, "verifier bug. zext_dst is set, but no reg is defined\n");
>>>     return -EFAULT;
>>> }
>>> in opt_subreg_zext_lo32_rnd_hi32() doesn't trigger ?
>>>
>>> But this verifier message should have been a hint that you need
>>> to analyze why zext_dst is set on this kfunc call.
>>> Maybe it shouldn't ?
>>> Did you analyze the logic of mark_btf_func_reg_size() ?
>> make r0 zext is not caused by mark_btf_func_reg_size.
>>
>> This problem occurs when running the kfunc_call_test_ref_btf_id test
>> case in the 32-bit ARM environment.
> 
> Why is it not failing on x86-32 ?
Use the latest mainline kernel code to test on the x86_32 machine. The 
test also fails:

   # ./test_progs -t kfunc_call/kfunc_call_test_ref_btf_id
   Failed to load bpf_testmod.ko into the kernel: -8
   WARNING! Selftests relying on bpf_testmod.ko will be skipped.
   libbpf: prog 'kfunc_call_test_ref_btf_id': BPF program load failed: 
Bad address
   libbpf: prog 'kfunc_call_test_ref_btf_id': -- BEGIN PROG LOAD LOG --
   processed 25 insns (limit 1000000) max_states_per_insn 0 total_states 
2 peak_states 2 mark_read 1
   -- END PROG LOAD LOG --
   libbpf: prog 'kfunc_call_test_ref_btf_id': failed to load: -14
   libbpf: failed to load object 'kfunc_call_test'
   libbpf: failed to load BPF skeleton 'kfunc_call_test': -14
   verify_success:FAIL:skel unexpected error: -14

Therefore, this problem also exists on x86_32:
"verifier bug. zext_dst is set, but no reg is defined"

> 
>> The bpf prog is as follows:
>> int kfunc_call_test_ref_btf_id(struct __sk_buff *skb)
>> {
>> struct prog_test_ref_kfunc *pt;
>> unsigned long s = 0;
>> int ret = 0;
>>
>> pt = bpf_kfunc_call_test_acquire(&s);
>> if (pt) {
>>        // here, do_check clears the upper 32bits of r0 through:
>>        // check_alu_op
>>        //   ->check_reg_arg
>>        //    ->mark_insn_zext
>> if (pt->a != 42 || pt->b != 108)
>> ret = -1;
>> bpf_kfunc_call_test_release(pt);
>> }
>> return ret;
>> }
>>
>>>
>>> Before producing any patches please understand the logic fully.
>>> Your commit log
>>> "insn_def_regno should
>>>    return dst_reg for BPF_JMP type of BPF_PSEUDO_KFUNC_CALL."
>>>
>>> Makes no sense to me, since dst_reg is unused in JMP insn.
>>> There is no concept of a src or dst register in a JMP insn.
>>>
>>> 32-bit x86 supports calling kfuncs. See emit_kfunc_call().
>>> And we don't have this "verifier bug. zext_dst is set" issue there, right?
>>> But what you're saying in the commit log:
>>> "if data width of kfunc return value is 32 bits"
>>> should have been applicable to x86-32 as well.
>>> So please start with a test that demonstrates the issue on x86-32 and
>>> then we can discuss the way to fix it.
>>>
>>> The patch 2 sort-of makes sense.
>>>
>>> For patch 3 pls add new test funcs to bpf_testmod.
>>> We will move all of them from net/bpf/test_run.c to bpf_testmod eventually.
>>> .
>>>
> .
> 
