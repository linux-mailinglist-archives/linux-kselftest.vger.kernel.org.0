Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0254F7A0BAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbjINRZ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 13:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240003AbjINRZp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 13:25:45 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24101359C;
        Thu, 14 Sep 2023 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=+rQkSX/sTt9mCfEyiFHgFHaHzrtXbCcdvkzQAAhcaCs=; b=jJYYKQiLbpdOVDjsdPtWUT6TFj
        gIUSL0E1I0K9FlPVK7YspQJTHRg8rpubRjsPu6LnmF2U95xpHfr3wlI3gvjQinqqbGOBohWR2umHr
        /oLG2eG2yInnO/eUSA7/xml20eBP76E7sgvVjIu+3H6NnDye2dsuxDMkYmsftqg9eYsFXFkl9TkUn
        +O/XGVj0+MTrUU5BhYwV6I24vjTVr7m32a9Dhz1fdd2S4nYmWEa+uCzGdeiikHwbziwI2M3GfUYa1
        gSq4dY0QkoWQC11WwBan3CsrqqUDr/s/o4pTND1h2ZEfxN9FqRqWTsOCuqSeiL5dMwQq3Wds8K39S
        eWDU0MpA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qgq4Z-000J4w-I0; Thu, 14 Sep 2023 19:24:11 +0200
Received: from [64.61.70.24] (helo=localhost.localdomain)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qgq4Y-0009Z8-JG; Thu, 14 Sep 2023 19:24:10 +0200
Subject: Re: [PATCH 2/3] Revert "bpf: Fix issue in verifying allow_ptr_leaks"
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Luis Gerhorst <gerhorst@cs.fau.de>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        gerhorst@amazon.de, Ilya Leoshkevich <iii@linux.ibm.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hagar Gamal Halim Hemdan <hagarhem@amazon.de>,
        Puranjay Mohan <puranjay12@gmail.com>
References: <CAADnVQLid7QvukhnqRoY2VVFi1tCfkPFsMGUUeHDtCgf0SAJCg@mail.gmail.com>
 <20230913122827.91591-1-gerhorst@amazon.de>
 <CAADnVQJsjVf3t0OJCZkc3rNpHMi_ZTtwLa3LBMi6ot3zufnb+A@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <723a49b4-c4ed-3b0b-2a9d-915b49725411@iogearbox.net>
Date:   Thu, 14 Sep 2023 19:24:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAADnVQJsjVf3t0OJCZkc3rNpHMi_ZTtwLa3LBMi6ot3zufnb+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27031/Thu Sep 14 09:39:27 2023)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/14/23 6:20 PM, Alexei Starovoitov wrote:
> On Wed, Sep 13, 2023 at 5:30 AM Luis Gerhorst <gerhorst@amazon.de> wrote:
>>
>> This reverts commit d75e30dddf73449bc2d10bb8e2f1a2c446bc67a2.
>>
>> To mitigate Spectre v1, the verifier relies on static analysis to deduct
>> constant pointer bounds, which can then be enforced by rewriting pointer
>> arithmetic [1] or index masking [2]. This relies on the fact that every
>> memory region to be accessed has a static upper bound and every date
>> below that bound is accessible. The verifier can only rewrite pointer
>> arithmetic or insert masking instructions to mitigate Spectre v1 if a
>> static upper bound, below of which every access is valid, can be given.
>>
>> When allowing packet pointer comparisons, this introduces a way for the
>> program to effectively construct an accessible pointer for which no
>> static upper bound is known. Intuitively, this is obvious as a packet
>> might be of any size and therefore 0 is the only statically known upper
>> bound below of which every date is always accessible (i.e., none).
>>
>> To clarify, the problem is not that comparing two pointers can be used
>> for pointer leaks in the same way in that comparing a pointer to a known
>> scalar can be used for pointer leaks. That is because the "secret"
>> components of the addresses cancel each other out if the pointers are
>> into the same region.
>>
>> With [3] applied, the following malicious BPF program can be loaded into
>> the kernel without CAP_PERFMON:
>>
>> r2 = *(u32 *)(r1 + 76) // data
>> r3 = *(u32 *)(r1 + 80) // data_end
>> r4 = r2
>> r4 += 1
>> if r4 > r3 goto exit
>> r5 = *(u8 *)(r2 + 0) // speculatively read secret
>> r5 &= 1 // choose bit to leak
>> // ... side channel to leak secret bit
>> exit:
>> // ...
>>
>> This is jited to the following amd64 code which still contains the
>> gadget:
>>
>>     0:   endbr64
>>     4:   nopl   0x0(%rax,%rax,1)
>>     9:   xchg   %ax,%ax
>>     b:   push   %rbp
>>     c:   mov    %rsp,%rbp
>>     f:   endbr64
>>    13:   push   %rbx
>>    14:   mov    0xc8(%rdi),%rsi // data
>>    1b:   mov    0x50(%rdi),%rdx // data_end
>>    1f:   mov    %rsi,%rcx
>>    22:   add    $0x1,%rcx
>>    26:   cmp    %rdx,%rcx
>>    29:   ja     0x000000000000003f // branch to mispredict
>>    2b:   movzbq 0x0(%rsi),%r8 // speculative load of secret
>>    30:   and    $0x1,%r8 // choose bit to leak
>>    34:   xor    %ebx,%ebx
>>    36:   cmp    %rbx,%r8
>>    39:   je     0x000000000000003f // branch based on secret
>>    3b:   imul   $0x61,%r8,%r8 // leak using port contention side channel
>>    3f:   xor    %eax,%eax
>>    41:   pop    %rbx
>>    42:   leaveq
>>    43:   retq
>>
>> Here I'm using a port contention side channel because storing the secret
>> to the stack causes the verifier to insert an lfence for unrelated
>> reasons (SSB mitigation) which would terminate the speculation.
>>
>> As Daniel already pointed out to me, data_end is even attacker
>> controlled as one could send many packets of sufficient length to train
>> the branch prediction into assuming data_end >= data will never be true.
>> When the attacker then sends a packet with insufficient data, the
>> Spectre v1 gadget leaks the chosen bit of some value that lies behind
>> data_end.
> 
> The above analysis is correct, but unlike traditional spec_v1
> the attacker doesn't control data/data_end.
> The attack can send many large packets to train that data + X < data_end
> and then send a small packet where CPU will mispredict that branch
> and data + X will speculatively read past data_end,
> so the attacker can extract a bit past data_end,
> but data/data_end themselves cannot be controlled.
> So whether this bit 0 or 1 has no bearing.
> The attack cannot be repeated for the same location.
> The attacker can read one bit 8 times in a row and all of them
> will be from different locations in the memory.
> Same as reading 8 random bits from 8 random locations.
> Hence I don't think this revert is necessary.
> I don't believe you can craft an actual exploit.
> 
> Your patch 3 says:
>         /* Speculative access to be prevented. */
> +       char secret = *((char *) iph);
> +
> +       /* Leak the first bit of the secret value that lies behind data_end to a
> +        * SMP silbling thread that also executes imul instructions. If the bit
> +        * is 1, the silbling will experience a slowdown. */
> +       long long x = secret;
> +       if (secret & 1) {
> +               x *= 97;
> +       }
> 
> the comment is correct, but speculative access alone is not enough
> to leak data.

What you write makes sense, it will probably be hard to craft an exploit.
Where it's a bit more of an unknown to me is whether struct skb_shared_info
could have e.g. destructor_arg rather static (at last the upper addr bits)
so that you would leak out kernel addresses.
