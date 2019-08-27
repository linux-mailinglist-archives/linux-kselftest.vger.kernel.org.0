Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8F9F678
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 00:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfH0WzY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 18:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfH0WzX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 18:55:23 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 401C2217F5;
        Tue, 27 Aug 2019 22:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566946522;
        bh=KNwArzVbNm8E/1uMq4N2WCFYXTVjp5rzpzUHm185bIg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=0Ri5y9DtZ6EwxRD84fFUzn9ouh1+D+xrBUkHCnkf+RGms/JIW1n3lbZpNjyz/dXDX
         lpGAIUgaQAyC7NrhyM56tpF5k6D4WguZrLIwerhB3tviHK60OgG9k1cPbVepSbzYjG
         q55XH/5YxHoZeZm2/jwVL8E/knU6InIoz8d74SAs=
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
 <10b44374-829d-0daa-8fb0-4450582cb40c@kernel.org>
 <CAFd5g474EYEj1BmqCv=xe6M9JW4L389xL2SU1Ak-evjmpGOvJg@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <559233b8-cd29-189a-e63b-0f46ea9b6f83@kernel.org>
Date:   Tue, 27 Aug 2019 16:55:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFd5g474EYEj1BmqCv=xe6M9JW4L389xL2SU1Ak-evjmpGOvJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/27/19 4:16 PM, Brendan Higgins wrote:
> On Tue, Aug 27, 2019 at 3:00 PM shuah <shuah@kernel.org> wrote:
>>
>> On 8/27/19 3:36 PM, Brendan Higgins wrote:
>>> On Tue, Aug 27, 2019 at 2:09 PM Brendan Higgins
>>> <brendanhiggins@google.com> wrote:
>>>>
>>>> On Tue, Aug 27, 2019 at 2:03 PM Brendan Higgins
>>>> <brendanhiggins@google.com> wrote:
>>>>>
>>>>> On Tue, Aug 27, 2019 at 1:21 PM shuah <shuah@kernel.org> wrote:
>>>>>>
>>>>>> On 8/27/19 11:49 AM, Brendan Higgins wrote:
>>>>>>> Previously KUnit assumed that printk would always be present, which is
>>>>>>> not a valid assumption to make. Fix that by ifdefing out functions which
>>>>>>> directly depend on printk core functions similar to what dev_printk
>>>>>>> does.
>>>>>>>
>>>>>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>>>>>>> Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
>>>>>>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>>>>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>>>>>> ---
>>>>>>>     include/kunit/test.h |  7 +++++++
>>>>>>>     kunit/test.c         | 41 ++++++++++++++++++++++++-----------------
>>>>>>>     2 files changed, 31 insertions(+), 17 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>>>>>>> index 8b7eb03d4971..339af5f95c4a 100644
>>>>>>> --- a/include/kunit/test.h
>>>>>>> +++ b/include/kunit/test.h
>>>>>>> @@ -339,9 +339,16 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
>>>>> [...]
>>>>>> Okay after reviewing this, I am not sure why you need to do all
>>>>>> this.
>>>>>>
>>>>>> Why can't you just change the root function that throws the warn:
>>>>>>
>>>>>>     static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
>>>>>> {
>>>>>>            return vprintk_emit(0, level, NULL, 0, fmt, args);
>>>>>> }
>>>>>>
>>>>>> You aren'r really doing anything extra here, other than calling
>>>>>> vprintk_emit()
>>>>>
>>>>> Yeah, I did that a while ago. I think it was a combination of trying
>>>>> to avoid an extra layer of adding and then removing the log level, and
>>>>> that's what dev_printk and friends did.
>>>>>
>>>>> But I think you are probably right. It's a lot of maintenance overhead
>>>>> to get rid of that. Probably best to just use what the printk people
>>>>> have.
>>>>>
>>>>>> Unless I am missing something, can't you solve this problem by including
>>>>>> printk.h and let it handle the !CONFIG_PRINTK case?
>>>>>
>>>>> Randy, I hope you don't mind, but I am going to ask you to re-ack my
>>>>> next revision since it basically addresses the problem in a totally
>>>>> different way.
>>>>
>>>> Actually, scratch that. Checkpatch doesn't like me calling printk
>>>> without using a KERN_<LEVEL>.
>>>>
>>>> Now that I am thinking back to when I wrote this. I think it also
>>>> might not like using a dynamic KERN_<LEVEL> either (printk("%s my
>>>> message", KERN_INFO)).
>>>>
>>>> I am going to have to do some more investigation.
>>>
>>> Alright, I am pretty sure it is safe to do printk("%smessage", KERN_<LEVEL>);
>>>
>>> Looking at the printk implementation, it appears to do the format
>>> before it checks the log level:
>>>
>>> https://elixir.bootlin.com/linux/v5.2.10/source/kernel/printk/printk.c#L1907
>>>
>>> So I am pretty sure we can do it either with the vprintk_emit or with printk.
>>
>> Let me see if we are on the same page first. I am asking if you can
>> just include printk.h for vprintk_emit() define for both CONFIG_PRINTK
>> and !CONFIG_PRINTK cases.
> 
> Ah sorry, I misunderstood you.
> 
> No, that doesn't work. I tried including linux/printk.h, and I get the
> same error.
> 
> The reason for this is that vprintk_emit() is only defined when CONFIG_PRINTK=y:
> 

This is the real problem here. printk.h defines several for
!CONFIG_PRINTK case.

> https://elixir.bootlin.com/linux/latest/ident/vprintk_emit
> 
>> I am not asking you to use printk() in place of vprintk_emit().
>> It is perfectly fine to use vprintk_emit()
> 
> Okay, cool.
> 
>>>
>>> So it appears that we have to weigh the following trade-offs:
>>>
>>> Using vprintk_emit:
>>>
>>> Pros:
>>>    - That's what dev_printk uses.
>>
>> Not sure what you mean by this. I am suggesting if you can just
>> call vprintk_emit() and include printk.h and not have to ifdef
>> around all the other callers of kunit_vprintk_emit()
> 
> Oh, I was just saying that I heavily based my implementation of
> kunit_printk on dev_printk. So I have a high degree of confidence that
> it is okay to use it the way that I am using it.
> 
>> Yes. There is the other issue of why do you need the complexity
>> of having kunit_vprintk_emit() at all.
> 
> Right, and the problem with the alternative, is there is no good
> kernel API for logging with the log level set dynamically. printk
> prefers to have it as a string prefix on the format string, but I
> cannot do that because I need to add my own prefix to the format
> string.
> 
> So, I guess I should just go ahead and address the earlier comments on
> this patch?
> 

So what does your code do in the case of !CONFIG_PRINTK. From my read of
it, it returns 0 from kunit_printk_emit(0 from my read of it. What I am
saying is this is a lot of indirection instead of fixing the leaf
function which is kunit_vprintk_emit().

+#else /* CONFIG_PRINTK */
+static inline int kunit_printk_emit(int level, const char *fmt, ...)
+{
+	return 0;
+}
+#endif /* CONFIG_PRINTK */

Does the following work?

#if defined CONFIG_PRINTK
static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
{
         return vprintk_emit(0, level, NULL, 0, fmt, args);
}
#else
static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
{
        return 0;
}
#endif

I think the real problem is in the printk.h with its missing define for
vprintk_emit() for !CONFIG_PRINTK case. There seem to only one call for
this in drivers/base/core.c in CONFIG_PRINTK path. Unless I am totally
missing some context for why there is no stub for vprintk_emit() for
!CONFIG_PRINTK case

thanks,
-- Shuah
