Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964875A2FBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 21:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbiHZTLX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 15:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiHZTLW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 15:11:22 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5B46CD03;
        Fri, 26 Aug 2022 12:11:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MDq6s1nGVz9v7N9;
        Sat, 27 Aug 2022 03:05:57 +0800 (CST)
Received: from [10.81.204.244] (unknown [10.81.204.244])
        by APP2 (Coremail) with SMTP id GxC2BwA38hmqGgljYsJSAA--.58619S2;
        Fri, 26 Aug 2022 20:10:50 +0100 (CET)
Message-ID: <9e11d51c-891f-739f-30a9-bb5361ceccb2@huaweicloud.com>
Date:   Fri, 26 Aug 2022 21:10:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v12 02/10] btf: Handle dynamic pointer parameter in kfuncs
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Joanne Koong <joannelkoong@gmail.com>
References: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
 <20220818152929.402605-3-roberto.sassu@huaweicloud.com>
 <YwhSCE0H+JfUe4Ew@kernel.org>
 <CAADnVQJbTzfe28ife1+vg+ByLfyLBTCoEZW_eg8TEw838JGaog@mail.gmail.com>
 <YwheJqUDLOxL3iTi@kernel.org> <YwjcItv0q8GdzPbb@kernel.org>
 <bb4bdd90017d5772bdc31dfac93f2e86c6c61b82.camel@huaweicloud.com>
 <Ywj1s6d7XowV82PZ@kernel.org> <Ywj3pOahYdxA8Dza@kernel.org>
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <Ywj3pOahYdxA8Dza@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwA38hmqGgljYsJSAA--.58619S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1ruw1UAF47KFW3KFyxGrg_yoW5Wr4Dpa
        48Aayqkr4UJr45Cwnrtr1xtF10yrWjqr48Xry5J34FyF1qvF1SgF4xJr1Yka45Gr18AF18
        Za1UX347XF15A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUFYFCUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj35XHQABsS
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/26/2022 6:41 PM, Jarkko Sakkinen wrote:
> On Fri, Aug 26, 2022 at 07:32:54PM +0300, Jarkko Sakkinen wrote:
>> On Fri, Aug 26, 2022 at 05:34:57PM +0200, Roberto Sassu wrote:
>>> On Fri, 2022-08-26 at 17:43 +0300, Jarkko Sakkinen wrote:
>>>> On Fri, Aug 26, 2022 at 08:46:14AM +0300, Jarkko Sakkinen wrote:
>>>>> On Thu, Aug 25, 2022 at 10:16:14PM -0700, Alexei Starovoitov wrote:
>>>>>> On Thu, Aug 25, 2022 at 9:54 PM Jarkko Sakkinen <
>>>>>> jarkko@kernel.org> wrote:
>>>>>>>> -static bool is_dynptr_reg_valid_init(struct bpf_verifier_env
>>>>>>>> *env, struct bpf_reg_state *reg,
>>>>>>>> -                                  enum bpf_arg_type
>>>>>>>> arg_type)
>>>>>>>> +bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
>>>>>>>> struct bpf_reg_state *reg,
>>>>>>>> +                           enum bpf_arg_type arg_type)
>>>>>>>>   {
>>>>>>>>        struct bpf_func_state *state = func(env, reg);
>>>>>>>>        int spi = get_spi(reg->off);
>>>>>>>> --
>>>>>>>> 2.25.1
>>>>>>>>
>>>>>>>
>>>>>>> Might be niticking but generally I'd consider splitting
>>>>>>> exports as commits of their own.
>>>>>>
>>>>>> -static bool
>>>>>> +bool
>>>>>>
>>>>>> into a separate commit?
>>>>>>
>>>>>> I guess it makes sense for people whose salary depends on
>>>>>> number of commits.
>>>>>> We don't play these games.
>>>>>
>>>>> What kind of argument is that anyway.
>>>>
>>>> "Separate each *logical change* into a separate patch." [*]
>>>
>>> The logical change, as per the patch subject, is allowing the
>>> possibility of including eBPF dynamic pointers in a kfunc definition.
>>> It requires to call an existing function that was already defined
>>> elsewhere.
>>>
>>> Maybe I'm wrong, but I don't see only exporting a function definition
>>> to an include file as a logical change. To me, the changes in this
>>> patch are clearly connected. Or even better, they tell why the function
>>> definition has been exported, that would not appear if moving the
>>> function definition is a standalone patch.
>>>
>>>>
>>>> To add, generally any user space visible space should be an
>>>> isolated patch.
>>>
>>> As far as I understood, definitions visible to user space should be in
>>> include/uapi.
>>
>> It does change e.g. the output of kallsyms.
>>
>> It's not ABI but it's still user space visble.
>>
>>>
>>>>
>>>> Please, stop posting nonsense.
>>>
>>> If I may, saying this does not encourage people to try to submit their
>>> code. I feel it is a bit strong, and I kindly ask you to express your
>>> opinion in a more gentle way.
>>
>> I agree. That's why I was wondering what is this nonsense
>> about salary and games.
> 
> Please denote that I started my review with "Might be nitpicking...".
> 
> It's neither particularly disencouraging nor enforcing for anyone.

Thanks for clarifying. Yes, it is not. Sorry, I misunderstood.

Roberto

