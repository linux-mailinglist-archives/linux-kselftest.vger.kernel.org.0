Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444F332BCF8
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Mar 2021 23:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244610AbhCCPKv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Mar 2021 10:10:51 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39385 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239577AbhCCMFO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Mar 2021 07:05:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UQFn22N_1614772990;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UQFn22N_1614772990)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Mar 2021 20:03:11 +0800
Subject: Re: [PATCH] selftests/sgx: fix EINIT failure dueto
 SGX_INVALID_SIGNATURE
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, X86 ML <x86@kernel.org>,
        linux-sgx@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jia Zhang <zhang.jia@linux.alibaba.com>
References: <20210301051836.30738-1-tianjia.zhang@linux.alibaba.com>
 <YDy51R2Wva7s+k/x@kernel.org>
 <3bcdcf04-4bed-ed95-84b6-790675f18240@linux.alibaba.com>
 <CALCETrVn_inXAULfsPrCXeHUTBet+KnL1XsxuiaR+jgG1uTJNg@mail.gmail.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <870e9a2e-65dd-131d-78c2-24de1ffffd31@linux.alibaba.com>
Date:   Wed, 3 Mar 2021 20:03:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CALCETrVn_inXAULfsPrCXeHUTBet+KnL1XsxuiaR+jgG1uTJNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/2/21 1:54 PM, Andy Lutomirski wrote:
> On Mon, Mar 1, 2021 at 9:06 PM Tianjia Zhang
> <tianjia.zhang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 3/1/21 5:54 PM, Jarkko Sakkinen wrote:
>>> On Mon, Mar 01, 2021 at 01:18:36PM +0800, Tianjia Zhang wrote:
>>>> q2 is not always 384-byte length. Sometimes it only has 383-byte.
>>>
>>> What does determine this?
>>>
>>>> In this case, the valid portion of q2 is reordered reversely for
>>>> little endian order, and the remaining portion is filled with zero.
>>>
>>> I'm presuming that you want to say "In this case, q2 needs to be reversed because...".
>>>
>>> I'm lacking these details:
>>>
>>> 1. Why the length of Q2 can vary?
>>> 2. Why reversing the bytes is the correct measure to counter-measure
>>>      this variation?
>>>
>>> /Jarkko
>>>
>>
>> When use openssl to generate a key instead of using the built-in
>> sign_key.pem, there is a probability that will encounter this problem.
>>
>> Here is a problematic key I encountered. The calculated q1 and q2 of
>> this key are both 383 bytes, If the length is not processed, the
>> hardware signature will fail.
> 
> Presumably the issue is that some keys have parameters that have
> enough leading 0 bits to be effectively shorter.  The openssl API
> (and, sadly, a bunch  of the ASN.1 stuff) treats these parameters as
> variable-size integers.
> 

I agree with your opinion.

Thanks,
Tianjia
