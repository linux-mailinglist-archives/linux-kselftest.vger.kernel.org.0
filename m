Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771BE2068B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 01:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387703AbgFWXz2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Jun 2020 19:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387518AbgFWXz1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Jun 2020 19:55:27 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0075C061573;
        Tue, 23 Jun 2020 16:55:25 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z1so329613qtn.2;
        Tue, 23 Jun 2020 16:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E9zV8lOV197lqceFWJXuqVlYBc5GlEgmlIsGMyfRQvM=;
        b=WYvzcMSox5xQbtQukC0PoQlXSIEqN5udEQG2u7CVeZlnfYIxfyr6Yo21pqoq/0Q5kc
         rli4kyx5YXdLp3zVxAC2BDUKyVEqp9Shdjdi3hwXK0O1VhrUJ9OynW3wNWR44KWEWH19
         BhoTsB9KV+pVBEz0AlSDBODDpqAOKBDLZfBTpDSSNlMR5cqevkEuHfrpG0yWYEnxgSXc
         1V5YWDVSsfH+O3+9fzI1p1KWojJ4EQlHVYmmQodV47TzkqHe7s4jPXp85YJymjso3mej
         3a5X+5Xwozw1OJ40fOZERce4L6OrJD7AwBItmSFVUuF8+XfQo9HWKUy9ocFaYx/s/SMm
         itfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E9zV8lOV197lqceFWJXuqVlYBc5GlEgmlIsGMyfRQvM=;
        b=Xfx8hQigP62EjKoNrl3UCDhVjvo0r9wV+BvKDKi0AdF4yoY6UZNojFsaBEOFj2iuic
         /TOzXq6aEbySjwEj5xmZDw8OCWxZCa8PUgUbpwEXpVR13Sla5/nR2kSGNcd0N+98KEuF
         ANdQutqidZFNWEjyagGvYvTeCL8yfpzl5YbP4AQaw+/jgOBWCMHDs/828xnYOoc3oIoj
         uhswZ2UHDCMfAE3IWzHzHZdFXgHgmrwcNbSldbyrA513fSJ5v2HQPmMjW4C1PhaJWfVs
         ZIh8AwakJcOYrhp/PT5iYnIO74AER3Z6s4eX3YfRImvWjs0KBFqTWVIivqlmnEs/7+jF
         WKig==
X-Gm-Message-State: AOAM532Wn6CPUIyNmsR5L3FEvDyRfRXPq6K+vsjk4qJ5yesmIyjyTtSR
        6z7QGH7dWmGdFv2mIS3ZqCM=
X-Google-Smtp-Source: ABdhPJzgU9KRQ1xL1j2O+Qa3Yhe+6mrXawsqogJEqnGkIeZJhJGcxxWV2CQaqt3joydCz/MnpCL+jw==
X-Received: by 2002:aed:2b04:: with SMTP id p4mr11794303qtd.158.1592956524868;
        Tue, 23 Jun 2020 16:55:24 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id p29sm2094597qtu.15.2020.06.23.16.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 16:55:21 -0700 (PDT)
Subject: Re: RFC: KTAP documentation - expected messages
To:     David Gow <davidgow@google.com>, Dmitry Vyukov <dvyukov@google.com>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <d38bf9f9-8a39-87a6-8ce7-d37e4a641675@gmail.com>
 <CABVgOSkwZUAEjxrqO46kqj=uY5HDzr-E_LR9i04yXEKqjp91Og@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <6d70b168-d05b-5330-89c8-148b334f9fce@gmail.com>
Date:   Tue, 23 Jun 2020 18:55:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CABVgOSkwZUAEjxrqO46kqj=uY5HDzr-E_LR9i04yXEKqjp91Og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Dmitry, since Brendan added him to another reply at this thread level

On 2020-06-22 21:46, David Gow wrote:
> On Mon, Jun 22, 2020 at 6:45 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> Tim Bird started a thread [1] proposing that he document the selftest result
>> format used by Linux kernel tests.
>>
>> [1] https://lore.kernel.org/r/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com
>>
>> The issue of messages generated by the kernel being tested (that are not
>> messages directly created by the tests, but are instead triggered as a
>> side effect of the test) came up.  In this thread, I will call these
>> messages "expected messages".  Instead of sidetracking that thread with
>> a proposal to handle expected messages, I am starting this new thread.
> 
> Thanks for doing this: I think there are quite a few tests which could
> benefit from something like this.
> 
> I think there were actually two separate questions: what do we do with
> unexpected messages (most of which I expect are useless, but some of
> which may end up being related to an unexpected test failure), and how
> to have tests "expect" a particular message to appear. I'll stick to

Yes.  But there is also a third aspect that made this feature important
for the Devicetree unittest.  There was a question on the devicetree
mail list, asking whether some devicetree related kernel warning and/or
error messages were devicetree problems.  The messages appeared while
the unittest was executing, but at the same time a lot of system
initialization is in progress, resulting in lots of console messages
that are unrelated to unittest.  I could not in good conscious reply
that the messages were truly of no consequence without actually
chasing each of them down and verifying that they were triggered by
unittest, and were showing what the devicetree infrastructure should
be reporting in response to the test stimulus, vs an underlying bug
in the devicetree infrastructure.

I found the expected messages API to be a useful tool to document
the validity of the messages, both for myself, and for the random
developer who might be reading the boot messages.

> talking about the latter for this thread, but even there there's two
> possible interpretations of "expected messages" we probably want to
> explicitly distinguish between: a message which must be present for
> the test to pass (which I think best fits the "expected message"
> name), and a message which the test is likely to produce, but which
> shouldn't alter the result (an "ignored message").

This type of case was the impetus for me to create the API.  There
was a unittest that resulted in the probe of a device, where the
probe executed devicetree subsystem code that invoked a
blocking_notifier_call_chain(), that resulted in another subsystem
taking some action, and that action just happened to do a printk()
reporting a specific action that the unittest was trying to
verify.

I was able to verify much of the asynchronous activity by creating
a fake driver and corresponding devices to be probed and could
instrument the fake driver.  The printk() information provided
the last little bit of checking for correct behavior.

> I don't see much
> use for the latter at present, but if we wanted to do more things with
> messages and had some otherwise very verbose tests, it could
> potentially be useful.

The use for the "ignored message" is my third aspect above.  This points
out that yet another possible consumer of the console boot log is the
QA or test engineer.  They can have the same concerns as any "random
developer".

> 
> The other thing I'd note here is that this proposal seems to be doing
> all of the actual message filtering in userspace, which makes a lot of
> sense for kselftest tests, but does mean that the kernel can't know if
> the test has passed or failed.

Yes.  I had absolutely no interest in my test code examining the history
of console messages, which could be generated on any other processor.

The printk related code has always been complex, nuanced, and seems to
attract the attention of people who want to change it instead of
leaving it stable.  I would really like to stay away from any dependency
on it.

> There's definitely a tradeoff between
> trying to put too much needless string parsing in the kernel and
> having to have a userland tool determine the test results. The
> proposed KCSAN test suite[1] is using tracepoints to do this in the
> kernel. It's not the cleanest thing, but there's no reason KUnit or
> similar couldn't implement a nicer API around it.

My interest is in printk() based messages that are present in areas
outside of my test code and independent of my test code.  I specifically
did not want to modify that existing code with any test code.

I was willing to accept the extra layer of running a user space program
to process the console output to verify one small portion of the
test passing or failing (or alternately, just examining the console
output manually).

-Frank

> 
> [1]: https://lkml.org/lkml/2020/6/22/1506
> 
>> I implemented an API for expected messages that are triggered by tests
>> in the Devicetree unittest code, with the expectation that the specific
>> details may change when the Devicetree unittest code adapts the KUnit
>> API.  It seems appropriate to incorporate the concept of expected
>> messages in Tim's documentation instead of waiting to address the
>> subject when the Devicetree unittest code adapts the KUnit API, since
>> Tim's document may become the kernel selftest standard.
> 
> Is having a nice way to handle expected messages the only thing
> holding up porting this to KUnit?
> 
>> Instead of creating a very long email containing multiple objects,
>> I will reply to this email with a separate reply for each of:
>>
>>   The "expected messages" API implemention and use can be from
>>   drivers/of/unittest.c in the mainline kernel.
>>
>>   of_unittest_expect - A proof of concept perl program to filter console
>>                        output containing expected messages output
>>
>>                        of_unittest_expect is also available by cloning
>>                        https://github.com/frowand/dt_tools.git
>>
>>   An example raw console output with timestamps and expect messages.
>>
>>   An example of console output processed by filter program
>>   of_unittest_expect to be more human readable.  The expected
>>   messages are not removed, but are flagged.
>>
>>   An example of console output processed by filter program
>>   of_unittest_expect to be more human readable.  The expected
>>   messages are removed instead of being flagged.
> 
> Cheers,
> -- David
> 

