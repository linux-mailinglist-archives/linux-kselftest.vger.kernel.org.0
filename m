Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5F8A5984
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2019 16:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbfIBOkC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Sep 2019 10:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730830AbfIBOkB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Sep 2019 10:40:01 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25C242087E;
        Mon,  2 Sep 2019 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567435200;
        bh=wuLNHdq4qiPYY4vaRkJdguYMmspwYOeW5TeDdxn/Q+U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pZ2zCSjOWm+c2x4dtk1SR9LV+mxeygSDuf+eHNF0glhZuCOV9/svIM/l/AT6XMGWy
         5fCIaWYeESRwOPwsDCM/jF5rqRg06xsn3uzrwrOh8IaB8bKYk1e4daM/2g0X60GKfA
         8CoggJg+tNDu+bIX7X28PqRkGMyX7Umz50wZykWw=
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
To:     Petr Mladek <pmladek@suse.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Tim.Bird@sony.com, sfr@canb.auug.org.au, frowand.list@gmail.com,
        sergey.senozhatsky@gmail.com, sergey.senozhatsky.work@gmail.com,
        rostedt@goodmis.org, kunit-dev@googlegroups.com,
        rdunlap@infradead.org, sboyd@kernel.org, joe@perches.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190828094929.GA14038@jagdpanzerIV>
 <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
 <f2d5b474411b2940d62198490f06e77890fbdb32.camel@perches.com>
 <20190830183821.GA30306@google.com>
 <bc688b00b2995e4b11229c3d4d90f532e00792c7.camel@perches.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977A8392@USCULXMSG01.am.sony.com>
 <ca01d8c4823c63db52fc0f18d62334aeb5634a50.camel@perches.com>
 <CAFd5g45X8bOiTWn5TMe3iEFwASafr6dWo6c4bG32uRKbQ+r5oA@mail.gmail.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977A8416@USCULXMSG01.am.sony.com>
 <20190830233710.GA101591@google.com>
 <20190902125249.qs7ql54vnsgf2665@pathway.suse.cz>
From:   shuah <shuah@kernel.org>
Message-ID: <91f7f74f-a815-0fda-5a01-0dbfa4ebe24d@kernel.org>
Date:   Mon, 2 Sep 2019 08:39:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902125249.qs7ql54vnsgf2665@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/2/19 6:52 AM, Petr Mladek wrote:
> On Fri 2019-08-30 16:37:10, Brendan Higgins wrote:
>> On Fri, Aug 30, 2019 at 11:22:43PM +0000, Tim.Bird@sony.com wrote:
>>>> -----Original Message-----
>>>> From: Brendan Higgins
>>>>
>>>> On Fri, Aug 30, 2019 at 3:46 PM Joe Perches <joe@perches.com> wrote:
>>>>>
>>>>> On Fri, 2019-08-30 at 21:58 +0000, Tim.Bird@sony.com wrote:
>>>>>>> From: Joe Perches
>>>>> []
>>>>>> IMHO %pV should be avoided if possible.  Just because people are
>>>>>> doing it doesn't mean it should be used when it is not necessary.
>>>>>
>>>>> Well, as the guy that created %pV, I of course
>>>>> have a different opinion.
>>>>>
>>>>>>>   then wouldn't it be easier to pass in the
>>>>>>>> kernel level as a separate parameter and then strip off all printk
>>>>>>>> headers like this:
>>>>>>>
>>>>>>> Depends on whether or not you care for overall
>>>>>>> object size.  Consolidated formats with the
>>>>>>> embedded KERN_<LEVEL> like suggested are smaller
>>>>>>> overall object size.
>>>>>>
>>>>>> This is an argument I can agree with.  I'm generally in favor of
>>>>>> things that lessen kernel size creep. :-)
>>>>>
>>>>> As am I.
>>>>
>>>> Sorry, to be clear, we are talking about the object size penalty due
>>>> to adding a single parameter to a function. Is that right?
>>>
>>> Not exactly.  The argument is that pre-pending the different KERN_LEVEL
>>> strings onto format strings can result in several versions of nearly identical strings
>>> being compiled into the object file.  By parameterizing this (that is, adding
>>> '%s' into the format string, and putting the level into the string as an argument),
>>> it prevents this duplication of format strings.
>>>
>>> I haven't seen the data on duplication of format strings, and how much this
>>> affects it, but little things can add up.  Whether it matters in this case depends
>>> on whether the format strings that kunit uses are also used elsewhere in the kernel,
>>> and whether these same format strings are used with multiple kernel message levels.
>>>   -- Tim
>>
>> I thought this portion of the discussion was about whether Joe's version
>> of kunit_printk was better or my critique of his version of kunit_printk:
>>
>> Joe's:
>>>>>> -void kunit_printk(const char *level,
>>>>>> -		  const struct kunit *test,
>>>>>> -		  const char *fmt, ...)
>>>>>> +void kunit_printk(const struct kunit *test, const char *fmt, ...)
>>>>>>   {
>>>>>> +	char lvl[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = "\0";
>>>>>>   	struct va_format vaf;
>>>>>>   	va_list args;
>>>>>> +	int kern_level;
>>>>>>
>>>>>>   	va_start(args, fmt);
>>>>>>
>>>>>> +	while ((kern_level = printk_get_level(fmt)) != 0) {
>>>>>> +		size_t size = printk_skip_level(fmt) - fmt;
>>>>>> +
>>>>>> +		if (kern_level >= '0' && kern_level <= '7') {
>>>>>> +			memcpy(lvl, fmt,  size);
>>>>>> +			lvl[size] = '\0';
>>>>>> +		}
>>>>>> +		fmt += size;
>>>>>> +	}
>>>>>> +
>>>>>>   	vaf.fmt = fmt;
>>>>>>   	vaf.va = &args;
>>>>>>
>>>>>> -	kunit_vprintk(test, level, &vaf);
>>>>>> +	printk("%s\t# %s %pV\n", lvl, test->name, &vaf);
>>>>>>
>>>>>>   	va_end(args);
>>>>>>   }
>>
>> Mine:
>>>   void kunit_printk(const char *level,
>>>   		  const struct kunit *test,
>>>   		  const char *fmt, ...)
>>>   {
>>>   	struct va_format vaf;
>>>   	va_list args;
>>>
>>>   	va_start(args, fmt);
>>>
>>> +	fmt = printk_skip_headers(fmt);
>>> +
>>>   	vaf.fmt = fmt;
>>>   	vaf.va = &args;
>>>
>>> -	kunit_vprintk(test, level, &vaf);
>>> +	printk("%s\t# %s %pV\n", level, test->name, &vaf);
>>>
>>>   	va_end(args);
>>>   }
>>
>> I thought you and Joe were arguing that "Joe's" resulted in a smaller
>> object size than "Mine" (not to be confused with the actual patch I
>> presented here, which is what Sergey suggested I do on a different
>> thread).
>>
>> I really don't feel strongly about what Sergey suggested I do (which is
>> what this patch originally introduced), versus, what Joe suggested,
>> versus what I suggested in response to Joe (or any of the things
>> suggested on other threads). I just want to pick one, fix the breakage
>> in linux-next, and move on with my life.
> 
> I am a bit lost in all the versions ;-) Though, I like most this
> patch. I think that it is based on Sergey's suggestion.
> 

I am too.

> I think that object size is not a huge concern for unit testing.
> Also if I get it correctly, the object is bigger only when
> the same string is used with different log levels. I am not
> sure how often this happen.
> 
> Feel free to use for this patch:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 

Brendan,

Send me the version Sergey suggested with a short summary of the
discussion in the commit log. Tag it v3 so I don't pull the wrong
patch in.

I am going to just ignore the checkpatch warn on this and get it in.
Thanks for the discussion. It helped me clarify my understanding of
the printk.

thanks,
-- Shuah

