Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9587A5A14
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 08:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjISGn3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 02:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISGn2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 02:43:28 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BB6102;
        Mon, 18 Sep 2023 23:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=34Uh17I9wHX4KI71I6rE04RGqv/kStTi6V+yD7DZOxU=; b=EXUFGhmPJF7GLD0Bdm6rLk2Qwh
        blxEDHnHGVGggnX+GQNOPf4h0TYB9SmDoVS4R2K1cR6fjzdSkRzb542RigqHQP8iCo1K8XX9P1nlQ
        FumVWR+xvKbMMkYrmyERmAC37qPesVgpGj7kakr8qpbK7/uPcqrbcD0ryqxkSDelC8bgclHCioZ2T
        4uC4Y+wgL3ei+0dErp185GgNTwXk8Pby2kNS0W3w1tdJS5GWtCnA+D1BxG3V2KvfAxb52TuYvdNro
        iV5Zp8Tx86MrCPRG6jwl3rdGGXIVeO031SHjs1jgZtzOH3syrT6nKqVlIcdBLA09YgYyFy5GMJgvP
        QbWHz38A==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qiUS0-000CCG-TY; Tue, 19 Sep 2023 08:43:12 +0200
Received: from [85.1.206.226] (helo=linux-3.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qiUS0-000F32-2t; Tue, 19 Sep 2023 08:43:12 +0200
Subject: Re: [PATCH 2/3] Revert "bpf: Fix issue in verifying allow_ptr_leaks"
To:     Yafang Shao <laoar.shao@gmail.com>,
        Luis Gerhorst <gerhorst@cs.fau.de>
Cc:     alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, martin.lau@linux.dev,
        sdf@google.com, song@kernel.org, yonghong.song@linux.dev,
        mykolal@fb.com, shuah@kernel.org, gerhorst@amazon.de,
        iii@linux.ibm.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hagar Gamal Halim Hemdan <hagarhem@amazon.de>,
        Puranjay Mohan <puranjay12@gmail.com>
References: <CAADnVQLid7QvukhnqRoY2VVFi1tCfkPFsMGUUeHDtCgf0SAJCg@mail.gmail.com>
 <20230913122827.91591-1-gerhorst@amazon.de>
 <CALOAHbAswO78gQ+D6yOupi5Hx_i3xqHQFrjGdWR=EhdVvV3ZkA@mail.gmail.com>
 <e15dea4b-f6a5-a37d-1660-406bca5a0026@cs.fau.de>
 <CALOAHbA3acaZGoxsiahmzh23rzsqGWbATkdF4bK-OUeCWzUYgw@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b4fc15f7-b204-767e-ebb9-fdb4233961fb@iogearbox.net>
Date:   Tue, 19 Sep 2023 08:43:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CALOAHbA3acaZGoxsiahmzh23rzsqGWbATkdF4bK-OUeCWzUYgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27035/Mon Sep 18 09:40:43 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/19/23 5:43 AM, Yafang Shao wrote:
> On Mon, Sep 18, 2023 at 7:52 PM Luis Gerhorst <gerhorst@cs.fau.de> wrote:
>> On 15/09/2023 04:26, Yafang Shao wrote:
>>> On Wed, Sep 13, 2023 at 8:30 PM Luis Gerhorst <gerhorst@amazon.de> wrote:
>>>>
>>>> This reverts commit d75e30dddf73449bc2d10bb8e2f1a2c446bc67a2.
>>>>
>>>> To mitigate Spectre v1, the verifier relies on static analysis to deduct
>>>> constant pointer bounds, which can then be enforced by rewriting pointer
>>>> arithmetic [1] or index masking [2]. This relies on the fact that every
>>>> memory region to be accessed has a static upper bound and every date
>>>> below that bound is accessible. The verifier can only rewrite pointer
>>>> arithmetic or insert masking instructions to mitigate Spectre v1 if a
>>>> static upper bound, below of which every access is valid, can be given.
>>>>
>>>> When allowing packet pointer comparisons, this introduces a way for the
>>>> program to effectively construct an accessible pointer for which no
>>>> static upper bound is known. Intuitively, this is obvious as a packet
>>>> might be of any size and therefore 0 is the only statically known upper
>>>> bound below of which every date is always accessible (i.e., none).
>>>>
>>>> To clarify, the problem is not that comparing two pointers can be used
>>>> for pointer leaks in the same way in that comparing a pointer to a known
>>>> scalar can be used for pointer leaks. That is because the "secret"
>>>> components of the addresses cancel each other out if the pointers are
>>>> into the same region.
>>>>
>>>> With [3] applied, the following malicious BPF program can be loaded into
>>>> the kernel without CAP_PERFMON:
>>>>
>>>> r2 = *(u32 *)(r1 + 76) // data
>>>> r3 = *(u32 *)(r1 + 80) // data_end
>>>> r4 = r2
>>>> r4 += 1
>>>> if r4 > r3 goto exit
>>>> r5 = *(u8 *)(r2 + 0) // speculatively read secret
>>>> r5 &= 1 // choose bit to leak
>>>> // ... side channel to leak secret bit
>>>> exit:
>>>> // ...
>>>>
>>>> This is jited to the following amd64 code which still contains the
>>>> gadget:
>>>>
>>>>      0:   endbr64
>>>>      4:   nopl   0x0(%rax,%rax,1)
>>>>      9:   xchg   %ax,%ax
>>>>      b:   push   %rbp
>>>>      c:   mov    %rsp,%rbp
>>>>      f:   endbr64
>>>>     13:   push   %rbx
>>>>     14:   mov    0xc8(%rdi),%rsi // data
>>>>     1b:   mov    0x50(%rdi),%rdx // data_end
>>>>     1f:   mov    %rsi,%rcx
>>>>     22:   add    $0x1,%rcx
>>>>     26:   cmp    %rdx,%rcx
>>>>     29:   ja     0x000000000000003f // branch to mispredict
>>>>     2b:   movzbq 0x0(%rsi),%r8 // speculative load of secret
>>>>     30:   and    $0x1,%r8 // choose bit to leak
>>>>     34:   xor    %ebx,%ebx
>>>>     36:   cmp    %rbx,%r8
>>>>     39:   je     0x000000000000003f // branch based on secret
>>>>     3b:   imul   $0x61,%r8,%r8 // leak using port contention side channel
>>>>     3f:   xor    %eax,%eax
>>>>     41:   pop    %rbx
>>>>     42:   leaveq
>>>>     43:   retq
>>>>
>>>> Here I'm using a port contention side channel because storing the secret
>>>> to the stack causes the verifier to insert an lfence for unrelated
>>>> reasons (SSB mitigation) which would terminate the speculation.
>>>>
>>>> As Daniel already pointed out to me, data_end is even attacker
>>>> controlled as one could send many packets of sufficient length to train
>>>> the branch prediction into assuming data_end >= data will never be true.
>>>> When the attacker then sends a packet with insufficient data, the
>>>> Spectre v1 gadget leaks the chosen bit of some value that lies behind
>>>> data_end.
>>>>
>>>> To make it clear that the problem is not the pointer comparison but the
>>>> missing masking instruction, it can be useful to transform the code
>>>> above into the following equivalent pseudocode:
>>>>
>>>> r2 = data
>>>> r3 = data_end
>>>> r6 = ... // index to access, constant does not help
>>>> r7 = data_end - data // only known at runtime, could be [0,PKT_MAX)
>>>> if !(r6 < r7) goto exit
>>>> // no masking of index in r6 happens
>>>> r2 += r6 // addr. to access
>>>> r5 = *(u8 *)(r2 + 0) // speculatively read secret
>>>> // ... leak secret as above
>>>>
>>>> One idea to resolve this while still allowing for unprivileged packet
>>>> access would be to always allocate a power of 2 for the packet data and
>>>> then also pass the respective index mask in the skb structure. The
>>>> verifier would then have to check that this index mask is always applied
>>>> to the offset before a packet pointer is dereferenced. This patch does
>>>> not implement this extension, but only reverts [3].
>>>
>>> Hi Luis,
>>>
>>> The skb pointer comparison is a reasonable operation in a networking bpf prog.
>>> If we just prohibit a reasonable operation to prevent a possible
>>> spectre v1 attack, it looks a little weird, right ?
>>> Should we figure out a real fix to prevent it ?
>>>
>>
>> I see your point, but this has been the case since Spectre v1 was
>> mitigated for BPF. I actually did a few statistics on that in [1] and
>>   >50 out of ~350 programs are rejected because of the Spectre v1
>> mitigations. However, to repeat: The operation is not completely
>> prohibited, only prohibited without CAP_PERFMON.
>>
>> Maybe it would be possible to expose the allow_ptr_leaks/bpf_spec_vX
>> flags in sysfs? It would be helpful for debugging, and you could set it
>> to 1 permanently for your purposes. However, I'm not sure if the others
>> would like that...
> 
> I really appreciate that idea. I actually shared a similar concept earlier.[1].
> Nonetheless, I believe it would be prudent to align with the system
> settings regarding CPU security mitigations within the BPF subsystem
> as well. In our production environment, we consistently configure it
> with "mitigations=off"[2] to enhance performance, essentially
> deactivating all optional CPU mitigations. Consequently, if we
> implement a system-wide "mitigations=off" setting, it should also
> inherently bypass Spectre v1 and Spectre v4 in the BPF subsystem.
> 
> Alexei, Daniel, any comments ?

Yes, I think that would be acceptable as a global override. At least I
don't see it would make anything worse if the rest of the system has
mitigations disabled anyway.

> [1]. https://lore.kernel.org/bpf/CALOAHbDDT=paFEdTb1Jsqu7eGkFXAh6A+f21VTrMdAeq5F60kg@mail.gmail.com/
> [2]. https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
> 
>> Another solution I have been working on in [2] is to change the
>> mitigations to insert an lfence instead of rejecting the program
>> entirely. That would have bad performance, but would still be better
>> than completely rejecting the program. However, these patches are far
>> from going upstream currently.
>>
>> A detail: The patches in [2] currently do not support the case we are
>> discussing here, they only insert fences when the speculative paths fail
>> to verify.
>>
>> [1]
>> https://sys.cs.fau.de/extern/person/gerhorst/23-03_fgbs-spring-2023-presentation.pdf
>> - Slide 9
>> [2]
>> https://gitlab.cs.fau.de/un65esoq/linux/-/commits/v6.5-rc6-bpf-spectre-nospec/
>>
>> --
>> Luis
> 
> 
> 
> --
> Regards
> Yafang
> 

