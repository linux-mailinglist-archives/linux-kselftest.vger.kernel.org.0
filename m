Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A17336B44
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Mar 2021 05:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhCKEyX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Mar 2021 23:54:23 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:47832 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230231AbhCKExy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Mar 2021 23:53:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0URNwJ8P_1615438430;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0URNwJ8P_1615438430)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Mar 2021 12:53:50 +0800
Subject: Re: [PATCH] selftests/sgx: fix EINIT failure dueto
 SGX_INVALID_SIGNATURE
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
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
 <20ef1254-007d-04ce-8df5-5122ffd4d8d3@linux.alibaba.com>
 <YEmRlQ8vL2inziEK@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <710b65d6-e492-ae24-f2af-6973e1df1b85@linux.alibaba.com>
Date:   Thu, 11 Mar 2021 12:53:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YEmRlQ8vL2inziEK@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/11/21 11:42 AM, Jarkko Sakkinen wrote:
> On Thu, Mar 11, 2021 at 10:47:50AM +0800, Jia Zhang wrote:
>>
>>
>> On 2021/3/11 上午5:39, Jarkko Sakkinen wrote:
>>> On Wed, Mar 10, 2021 at 08:44:44PM +0800, Jia Zhang wrote:
>>>>
>>>>
>>>> On 2021/3/2 下午9:47, Jarkko Sakkinen wrote:
>>>>> On Mon, Mar 01, 2021 at 09:54:37PM -0800, Andy Lutomirski wrote:
>>>>>> On Mon, Mar 1, 2021 at 9:06 PM Tianjia Zhang
>>>>>> <tianjia.zhang@linux.alibaba.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 3/1/21 5:54 PM, Jarkko Sakkinen wrote:
>>>>>>>> On Mon, Mar 01, 2021 at 01:18:36PM +0800, Tianjia Zhang wrote:
>>>>>>>>> q2 is not always 384-byte length. Sometimes it only has 383-byte.
>>>>>>>>
>>>>>>>> What does determine this?
>>>>>>>>
>>>>>>>>> In this case, the valid portion of q2 is reordered reversely for
>>>>>>>>> little endian order, and the remaining portion is filled with zero.
>>>>>>>>
>>>>>>>> I'm presuming that you want to say "In this case, q2 needs to be reversed because...".
>>>>>>>>
>>>>>>>> I'm lacking these details:
>>>>>>>>
>>>>>>>> 1. Why the length of Q2 can vary?
>>>>>>>> 2. Why reversing the bytes is the correct measure to counter-measure
>>>>>>>>      this variation?
>>>>>>>>
>>>>>>>> /Jarkko
>>>>>>>>
>>>>>>>
>>>>>>> When use openssl to generate a key instead of using the built-in
>>>>>>> sign_key.pem, there is a probability that will encounter this problem.
>>>>>>>
>>>>>>> Here is a problematic key I encountered. The calculated q1 and q2 of
>>>>>>> this key are both 383 bytes, If the length is not processed, the
>>>>>>> hardware signature will fail.
>>>>>>
>>>>>> Presumably the issue is that some keys have parameters that have
>>>>>> enough leading 0 bits to be effectively shorter.  The openssl API
>>>>>> (and, sadly, a bunch  of the ASN.1 stuff) treats these parameters as
>>>>>> variable-size integers.
>>>>>
>>>>> But the test uses a static key. It used to generate a key on fly but
>>>>
>>>> IMO even though the test code, it comes from the linux kernel, meaning
>>>> that its quality has a certain guarantee and it is a good reference, so
>>>> the test code still needs to ensure its correctness.
>>>
>>> Hmm... what is working incorrectly then?
>>
>> In current implementation, it is working well, after all the static key
>> can derive the full 384-byte length of q1 and q2. As mentioned above, if
>> someone refers to the design of signing tool from selftest code, it is
>> quite possible that the actual implementation will use dynamical or
>> external signing key deriving shorter q1 and/or q2 in length.
> 
> A self-test needs is not meant to be generic to be directly used in 3rd
> party code. With the current key there is not issue => there is no issue.
> 

For keys generated on fly, self-test does not work properly, this 
experience is really worse.

Best regards,
Tianjia
