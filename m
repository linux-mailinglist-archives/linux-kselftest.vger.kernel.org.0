Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 099EB9F5BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 00:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfH0WA6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 18:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfH0WA5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 18:00:57 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 077D32070B;
        Tue, 27 Aug 2019 22:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566943256;
        bh=PS/QwP4Xax9g527ItgaFxeFjQ7qAcrtvuXy5R4KNyhw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bi2IrWWe/7PtGt1+NJhcsHsNOSc4/7KQ4HaHP2+ovZn1/EcUZdvDbZ8fWztRml/Nn
         NPf/qENpTXyyPtKXsdeWUiF/Sfl85SerhYGHl9scCqEuHi/XPaYN3pdpV+Vj9W+p5D
         PGAEAV/1D3H6aiDR35ymNCUmRRt+aNhY2L3F1/e0=
Subject: Re: [PATCH v1] kunit: fix failure to build without printk
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        shuah <shuah@kernel.org>
References: <20190827174932.44177-1-brendanhiggins@google.com>
 <ae9b9102-187c-eefe-d377-6efa63de2d28@kernel.org>
 <CAFd5g473nZAfM4D=Vkr54O_+nn=MSt3dzuDcXzNMZGRDWg1nxA@mail.gmail.com>
 <CAFd5g47rSBJS8QVH6d5HqoJW5PJXdNnkoP6WcvQCFUqHUEmDzw@mail.gmail.com>
 <CAFd5g44A5vtgxBYErP4mCGwDgOHEMYUXCDSF=d9bYB3ktpW5jA@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <10b44374-829d-0daa-8fb0-4450582cb40c@kernel.org>
Date:   Tue, 27 Aug 2019 16:00:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g44A5vtgxBYErP4mCGwDgOHEMYUXCDSF=d9bYB3ktpW5jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/27/19 3:36 PM, Brendan Higgins wrote:
> On Tue, Aug 27, 2019 at 2:09 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
>>
>> On Tue, Aug 27, 2019 at 2:03 PM Brendan Higgins
>> <brendanhiggins@google.com> wrote:
>>>
>>> On Tue, Aug 27, 2019 at 1:21 PM shuah <shuah@kernel.org> wrote:
>>>>
>>>> On 8/27/19 11:49 AM, Brendan Higgins wrote:
>>>>> Previously KUnit assumed that printk would always be present, which is
>>>>> not a valid assumption to make. Fix that by ifdefing out functions which
>>>>> directly depend on printk core functions similar to what dev_printk
>>>>> does.
>>>>>
>>>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>>>>> Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
>>>>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>>>> ---
>>>>>    include/kunit/test.h |  7 +++++++
>>>>>    kunit/test.c         | 41 ++++++++++++++++++++++++-----------------
>>>>>    2 files changed, 31 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>>>>> index 8b7eb03d4971..339af5f95c4a 100644
>>>>> --- a/include/kunit/test.h
>>>>> +++ b/include/kunit/test.h
>>>>> @@ -339,9 +339,16 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
>>> [...]
>>>> Okay after reviewing this, I am not sure why you need to do all
>>>> this.
>>>>
>>>> Why can't you just change the root function that throws the warn:
>>>>
>>>>    static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
>>>> {
>>>>           return vprintk_emit(0, level, NULL, 0, fmt, args);
>>>> }
>>>>
>>>> You aren'r really doing anything extra here, other than calling
>>>> vprintk_emit()
>>>
>>> Yeah, I did that a while ago. I think it was a combination of trying
>>> to avoid an extra layer of adding and then removing the log level, and
>>> that's what dev_printk and friends did.
>>>
>>> But I think you are probably right. It's a lot of maintenance overhead
>>> to get rid of that. Probably best to just use what the printk people
>>> have.
>>>
>>>> Unless I am missing something, can't you solve this problem by including
>>>> printk.h and let it handle the !CONFIG_PRINTK case?
>>>
>>> Randy, I hope you don't mind, but I am going to ask you to re-ack my
>>> next revision since it basically addresses the problem in a totally
>>> different way.
>>
>> Actually, scratch that. Checkpatch doesn't like me calling printk
>> without using a KERN_<LEVEL>.
>>
>> Now that I am thinking back to when I wrote this. I think it also
>> might not like using a dynamic KERN_<LEVEL> either (printk("%s my
>> message", KERN_INFO)).
>>
>> I am going to have to do some more investigation.
> 
> Alright, I am pretty sure it is safe to do printk("%smessage", KERN_<LEVEL>);
> 
> Looking at the printk implementation, it appears to do the format
> before it checks the log level:
> 
> https://elixir.bootlin.com/linux/v5.2.10/source/kernel/printk/printk.c#L1907
> 
> So I am pretty sure we can do it either with the vprintk_emit or with printk.

Let me see if we are on the same page first. I am asking if you can
just include printk.h for vprintk_emit() define for both CONFIG_PRINTK
and !CONFIG_PRINTK cases.

I am not asking you to use printk() in place of vprintk_emit().
It is perfectly fine to use vprintk_emit()

> 
> So it appears that we have to weigh the following trade-offs:
> 
> Using vprintk_emit:
> 
> Pros:
>   - That's what dev_printk uses.

Not sure what you mean by this. I am suggesting if you can just
call vprintk_emit() and include printk.h and not have to ifdef
around all the other callers of kunit_vprintk_emit()

Yes. There is the other issue of why do you need the complexity
of having kunit_vprintk_emit() at all.

thanks,
-- Shuah

