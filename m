Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF23336A3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Mar 2021 03:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCKCsd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Mar 2021 21:48:33 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:34259 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbhCKCry (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Mar 2021 21:47:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0URMi9aJ_1615430870;
Received: from ali-6c96cfd98fb5.local(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0URMi9aJ_1615430870)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Mar 2021 10:47:50 +0800
Subject: Re: [PATCH] selftests/sgx: fix EINIT failure dueto
 SGX_INVALID_SIGNATURE
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, X86 ML <x86@kernel.org>,
        linux-sgx@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210301051836.30738-1-tianjia.zhang@linux.alibaba.com>
 <YDy51R2Wva7s+k/x@kernel.org>
 <3bcdcf04-4bed-ed95-84b6-790675f18240@linux.alibaba.com>
 <CALCETrVn_inXAULfsPrCXeHUTBet+KnL1XsxuiaR+jgG1uTJNg@mail.gmail.com>
 <YD5B7P++T6jLoWBR@kernel.org>
 <1f5c2375-39e2-65a8-3ad3-8dc43422f568@linux.alibaba.com>
 <YEk8f/29icpsUhas@kernel.org>
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <20ef1254-007d-04ce-8df5-5122ffd4d8d3@linux.alibaba.com>
Date:   Thu, 11 Mar 2021 10:47:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEk8f/29icpsUhas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2021/3/11 上午5:39, Jarkko Sakkinen wrote:
> On Wed, Mar 10, 2021 at 08:44:44PM +0800, Jia Zhang wrote:
>>
>>
>> On 2021/3/2 下午9:47, Jarkko Sakkinen wrote:
>>> On Mon, Mar 01, 2021 at 09:54:37PM -0800, Andy Lutomirski wrote:
>>>> On Mon, Mar 1, 2021 at 9:06 PM Tianjia Zhang
>>>> <tianjia.zhang@linux.alibaba.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 3/1/21 5:54 PM, Jarkko Sakkinen wrote:
>>>>>> On Mon, Mar 01, 2021 at 01:18:36PM +0800, Tianjia Zhang wrote:
>>>>>>> q2 is not always 384-byte length. Sometimes it only has 383-byte.
>>>>>>
>>>>>> What does determine this?
>>>>>>
>>>>>>> In this case, the valid portion of q2 is reordered reversely for
>>>>>>> little endian order, and the remaining portion is filled with zero.
>>>>>>
>>>>>> I'm presuming that you want to say "In this case, q2 needs to be reversed because...".
>>>>>>
>>>>>> I'm lacking these details:
>>>>>>
>>>>>> 1. Why the length of Q2 can vary?
>>>>>> 2. Why reversing the bytes is the correct measure to counter-measure
>>>>>>     this variation?
>>>>>>
>>>>>> /Jarkko
>>>>>>
>>>>>
>>>>> When use openssl to generate a key instead of using the built-in
>>>>> sign_key.pem, there is a probability that will encounter this problem.
>>>>>
>>>>> Here is a problematic key I encountered. The calculated q1 and q2 of
>>>>> this key are both 383 bytes, If the length is not processed, the
>>>>> hardware signature will fail.
>>>>
>>>> Presumably the issue is that some keys have parameters that have
>>>> enough leading 0 bits to be effectively shorter.  The openssl API
>>>> (and, sadly, a bunch  of the ASN.1 stuff) treats these parameters as
>>>> variable-size integers.
>>>
>>> But the test uses a static key. It used to generate a key on fly but
>>
>> IMO even though the test code, it comes from the linux kernel, meaning
>> that its quality has a certain guarantee and it is a good reference, so
>> the test code still needs to ensure its correctness.
> 
> Hmm... what is working incorrectly then?

In current implementation, it is working well, after all the static key
can derive the full 384-byte length of q1 and q2. As mentioned above, if
someone refers to the design of signing tool from selftest code, it is
quite possible that the actual implementation will use dynamical or
external signing key deriving shorter q1 and/or q2 in length.

Going back the technical background, I'm not a crypto expert, so I
choose to check the code, doc and make experiment.

Accorindg to intel sdm vol3 37.14:

```
SIGSTRUCT includes four 3072-bit integers (MODULUS, SIGNATURE, Q1, Q2).
Each such integer is represented as a byte strings of length 384, with
the most significant byte at the position “offset + 383”, and the least
significant byte at position “offset”.

...

The 3072-bit integers Q1 and Q2 are defined by:
q1 = floor(Signature^2 / Modulus);
q2 = floor((Signature^3 - q1 * Signature * Modulus) / Modulus);
```

and the implementation of singing tool from Intel SGX SDK
(https://github.com/intel/linux-sgx/blob/master/sdk/sign_tool/SignTool/sign_tool.cpp#L381
), the most significant byte shuld be at the position “offset +
q1/q2_actuall_len”, and the padding portion should be filled with zero,
and don't involve the order reverse, but the selftest code always does.
This is the root cause of SGX_INVALID_SIGNATURE.

Just simplily enforce size_q1 and size_q2 to SE_KEY_SIZE, and generate
randome siging key with `openssl genrsa -3 -out signing_key.pem 3072`,
the SGX_INVALID_SIGNATURE error will appear up quickly.

Jia

> 
> /Jarkko
> 
