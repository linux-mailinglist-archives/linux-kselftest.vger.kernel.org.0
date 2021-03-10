Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3070D333CD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Mar 2021 13:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhCJMpK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Mar 2021 07:45:10 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:37202 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229948AbhCJMos (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Mar 2021 07:44:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0URK2fWn_1615380284;
Received: from ali-6c96cfd98fb5.local(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0URK2fWn_1615380284)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 10 Mar 2021 20:44:45 +0800
Subject: Re: [PATCH] selftests/sgx: fix EINIT failure dueto
 SGX_INVALID_SIGNATURE
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
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
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <1f5c2375-39e2-65a8-3ad3-8dc43422f568@linux.alibaba.com>
Date:   Wed, 10 Mar 2021 20:44:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YD5B7P++T6jLoWBR@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2021/3/2 下午9:47, Jarkko Sakkinen wrote:
> On Mon, Mar 01, 2021 at 09:54:37PM -0800, Andy Lutomirski wrote:
>> On Mon, Mar 1, 2021 at 9:06 PM Tianjia Zhang
>> <tianjia.zhang@linux.alibaba.com> wrote:
>>>
>>>
>>>
>>> On 3/1/21 5:54 PM, Jarkko Sakkinen wrote:
>>>> On Mon, Mar 01, 2021 at 01:18:36PM +0800, Tianjia Zhang wrote:
>>>>> q2 is not always 384-byte length. Sometimes it only has 383-byte.
>>>>
>>>> What does determine this?
>>>>
>>>>> In this case, the valid portion of q2 is reordered reversely for
>>>>> little endian order, and the remaining portion is filled with zero.
>>>>
>>>> I'm presuming that you want to say "In this case, q2 needs to be reversed because...".
>>>>
>>>> I'm lacking these details:
>>>>
>>>> 1. Why the length of Q2 can vary?
>>>> 2. Why reversing the bytes is the correct measure to counter-measure
>>>>     this variation?
>>>>
>>>> /Jarkko
>>>>
>>>
>>> When use openssl to generate a key instead of using the built-in
>>> sign_key.pem, there is a probability that will encounter this problem.
>>>
>>> Here is a problematic key I encountered. The calculated q1 and q2 of
>>> this key are both 383 bytes, If the length is not processed, the
>>> hardware signature will fail.
>>
>> Presumably the issue is that some keys have parameters that have
>> enough leading 0 bits to be effectively shorter.  The openssl API
>> (and, sadly, a bunch  of the ASN.1 stuff) treats these parameters as
>> variable-size integers.
> 
> But the test uses a static key. It used to generate a key on fly but

IMO even though the test code, it comes from the linux kernel, meaning
that its quality has a certain guarantee and it is a good reference, so
the test code still needs to ensure its correctness.

Jia

> in some of the last versions I replaced key generation with a static
> key:
> 
> static RSA *gen_sign_key(void)
> {
> 	unsigned long sign_key_length;
> 	BIO *bio;
> 	RSA *key;
> 
> 	sign_key_length = (unsigned long)&sign_key_end -
> 			  (unsigned long)&sign_key;
> 
> 	bio = BIO_new_mem_buf(&sign_key, sign_key_length);
> 	if (!bio)
> 		return NULL;
> 
> 	key = PEM_read_bio_RSAPrivateKey(bio, NULL, NULL, NULL);
> 	BIO_free(bio);
> 
> 	return key;
> }
> 
> /Jarkko
> 
