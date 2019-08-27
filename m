Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01BAD9F6A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 01:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfH0XLR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 19:11:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37241 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfH0XLR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 19:11:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id y9so369105pfl.4
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2019 16:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNiWRAtjZyKRIcfrXYaye+GShOA8MBJmVs8c4Xp0tNo=;
        b=kqmStsQ7U+KRzw5DRox6/uGePUjBsKfBeZOUcY0B5RUhlO/10ScTQPkIzl2aO21qtc
         X8u/tDaafZ1+Q6s4WfLzrcSfNUdgnp7RCnH5BJORRpDcnzxmVrkLaMDuG56JaYDLqmVA
         ORoRnwTAgRy6wlZ8xGLPgSWwfoyl2mA9W4g7DpoLZT/x/aaySFMzkb29oSplEaF2hdX4
         6px4EVmIBsYc/K0gypTjXGHS9Te5oqlz1bgnY/N6ISuRv3NAAQd5ivSsd6DxqNZZJ+QP
         ZY/DaB1FfqMGzjrhNncI8HOO1UsfS7aarMwa11gRmrOhZwO3vD47s709vPAMS4t5Wezd
         oYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNiWRAtjZyKRIcfrXYaye+GShOA8MBJmVs8c4Xp0tNo=;
        b=Ew0lOiUV4c91afJBN43202Yk6HyNVQDNL5PJJXb2A8QAijEeJ1A36AibNevXsqfVtl
         gptCL/qZHZh2FnDltErAxq2IJ4A//asLhZbCAcYOGnJX9MXtM1sqT2lZuQ4ecnHe8On3
         yTXi9Mme8J50hOeYNJtj21XIh0e+b+0sWEuYqwFkn78In7Kxg8aeVGKbwRaggGlpHiUN
         Y4VLksWw7rMGQwbgzThELTAu3wZqFecJfjKpX9QhojwDDFjOhejDU+JCPW8FuyW6sABQ
         hpjTQCMILMJn6B1miIuN0okiURH5H7XyEQzVs5cluxLHw95l1tMRQs/TBzdpgB82d/9S
         E6zw==
X-Gm-Message-State: APjAAAUc46T/rpqawrtS/IsxzVFN6QIxZPUBny4PlqUzpu+pPXA4NSDx
        YK1A2rgZ81e5duuOa+HVh6bdXl44RJIJrKA+wA6F5g==
X-Google-Smtp-Source: APXvYqx76fx4BkXNFm6LcgY4T7W5ukMQu9hfdzsizWEDlrpec6JYXQtQd5yiGBiYdv8gyMeIiUN7c1WphTCd2T13RNk=
X-Received: by 2002:a17:90a:7f01:: with SMTP id k1mr1157286pjl.84.1566947476324;
 Tue, 27 Aug 2019 16:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190827174932.44177-1-brendanhiggins@google.com>
 <ae9b9102-187c-eefe-d377-6efa63de2d28@kernel.org> <CAFd5g473nZAfM4D=Vkr54O_+nn=MSt3dzuDcXzNMZGRDWg1nxA@mail.gmail.com>
 <CAFd5g47rSBJS8QVH6d5HqoJW5PJXdNnkoP6WcvQCFUqHUEmDzw@mail.gmail.com>
 <CAFd5g44A5vtgxBYErP4mCGwDgOHEMYUXCDSF=d9bYB3ktpW5jA@mail.gmail.com>
 <10b44374-829d-0daa-8fb0-4450582cb40c@kernel.org> <CAFd5g474EYEj1BmqCv=xe6M9JW4L389xL2SU1Ak-evjmpGOvJg@mail.gmail.com>
 <559233b8-cd29-189a-e63b-0f46ea9b6f83@kernel.org>
In-Reply-To: <559233b8-cd29-189a-e63b-0f46ea9b6f83@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 27 Aug 2019 16:11:05 -0700
Message-ID: <CAFd5g44F1HShBbyxDnGPUoh6WWuEQzvDh2uGUYHe_xHRSWJrBQ@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: fix failure to build without printk
To:     shuah <shuah@kernel.org>
Cc:     kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 27, 2019 at 3:55 PM shuah <shuah@kernel.org> wrote:
>
> On 8/27/19 4:16 PM, Brendan Higgins wrote:
> > On Tue, Aug 27, 2019 at 3:00 PM shuah <shuah@kernel.org> wrote:
> >>
> >> On 8/27/19 3:36 PM, Brendan Higgins wrote:
> >>> On Tue, Aug 27, 2019 at 2:09 PM Brendan Higgins
> >>> <brendanhiggins@google.com> wrote:
> >>>>
> >>>> On Tue, Aug 27, 2019 at 2:03 PM Brendan Higgins
> >>>> <brendanhiggins@google.com> wrote:
> >>>>>
> >>>>> On Tue, Aug 27, 2019 at 1:21 PM shuah <shuah@kernel.org> wrote:
> >>>>>>
> >>>>>> On 8/27/19 11:49 AM, Brendan Higgins wrote:
> >>>>>>> Previously KUnit assumed that printk would always be present, which is
> >>>>>>> not a valid assumption to make. Fix that by ifdefing out functions which
> >>>>>>> directly depend on printk core functions similar to what dev_printk
> >>>>>>> does.
> >>>>>>>
> >>>>>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> >>>>>>> Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
> >>>>>>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> >>>>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> >>>>>>> ---
> >>>>>>>     include/kunit/test.h |  7 +++++++
> >>>>>>>     kunit/test.c         | 41 ++++++++++++++++++++++++-----------------
> >>>>>>>     2 files changed, 31 insertions(+), 17 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/include/kunit/test.h b/include/kunit/test.h
> >>>>>>> index 8b7eb03d4971..339af5f95c4a 100644
> >>>>>>> --- a/include/kunit/test.h
> >>>>>>> +++ b/include/kunit/test.h
> >>>>>>> @@ -339,9 +339,16 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
> >>>>> [...]
> >>>>>> Okay after reviewing this, I am not sure why you need to do all
> >>>>>> this.
> >>>>>>
> >>>>>> Why can't you just change the root function that throws the warn:
> >>>>>>
> >>>>>>     static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
> >>>>>> {
> >>>>>>            return vprintk_emit(0, level, NULL, 0, fmt, args);
> >>>>>> }
> >>>>>>
> >>>>>> You aren'r really doing anything extra here, other than calling
> >>>>>> vprintk_emit()
> >>>>>
> >>>>> Yeah, I did that a while ago. I think it was a combination of trying
> >>>>> to avoid an extra layer of adding and then removing the log level, and
> >>>>> that's what dev_printk and friends did.
> >>>>>
> >>>>> But I think you are probably right. It's a lot of maintenance overhead
> >>>>> to get rid of that. Probably best to just use what the printk people
> >>>>> have.
> >>>>>
> >>>>>> Unless I am missing something, can't you solve this problem by including
> >>>>>> printk.h and let it handle the !CONFIG_PRINTK case?
> >>>>>
> >>>>> Randy, I hope you don't mind, but I am going to ask you to re-ack my
> >>>>> next revision since it basically addresses the problem in a totally
> >>>>> different way.
> >>>>
> >>>> Actually, scratch that. Checkpatch doesn't like me calling printk
> >>>> without using a KERN_<LEVEL>.
> >>>>
> >>>> Now that I am thinking back to when I wrote this. I think it also
> >>>> might not like using a dynamic KERN_<LEVEL> either (printk("%s my
> >>>> message", KERN_INFO)).
> >>>>
> >>>> I am going to have to do some more investigation.
> >>>
> >>> Alright, I am pretty sure it is safe to do printk("%smessage", KERN_<LEVEL>);
> >>>
> >>> Looking at the printk implementation, it appears to do the format
> >>> before it checks the log level:
> >>>
> >>> https://elixir.bootlin.com/linux/v5.2.10/source/kernel/printk/printk.c#L1907
> >>>
> >>> So I am pretty sure we can do it either with the vprintk_emit or with printk.
> >>
> >> Let me see if we are on the same page first. I am asking if you can
> >> just include printk.h for vprintk_emit() define for both CONFIG_PRINTK
> >> and !CONFIG_PRINTK cases.
> >
> > Ah sorry, I misunderstood you.
> >
> > No, that doesn't work. I tried including linux/printk.h, and I get the
> > same error.
> >
> > The reason for this is that vprintk_emit() is only defined when CONFIG_PRINTK=y:
> >
>
> This is the real problem here. printk.h defines several for
> !CONFIG_PRINTK case.

Yeah, Tim pointed that out.

I think both of you are right, I should be filing my fix against them.

> > https://elixir.bootlin.com/linux/latest/ident/vprintk_emit
> >
> >> I am not asking you to use printk() in place of vprintk_emit().
> >> It is perfectly fine to use vprintk_emit()
> >
> > Okay, cool.
> >
> >>>
> >>> So it appears that we have to weigh the following trade-offs:
> >>>
> >>> Using vprintk_emit:
> >>>
> >>> Pros:
> >>>    - That's what dev_printk uses.
> >>
> >> Not sure what you mean by this. I am suggesting if you can just
> >> call vprintk_emit() and include printk.h and not have to ifdef
> >> around all the other callers of kunit_vprintk_emit()
> >
> > Oh, I was just saying that I heavily based my implementation of
> > kunit_printk on dev_printk. So I have a high degree of confidence that
> > it is okay to use it the way that I am using it.
> >
> >> Yes. There is the other issue of why do you need the complexity
> >> of having kunit_vprintk_emit() at all.
> >
> > Right, and the problem with the alternative, is there is no good
> > kernel API for logging with the log level set dynamically. printk
> > prefers to have it as a string prefix on the format string, but I
> > cannot do that because I need to add my own prefix to the format
> > string.
> >
> > So, I guess I should just go ahead and address the earlier comments on
> > this patch?
> >
>
> So what does your code do in the case of !CONFIG_PRINTK. From my read of
> it, it returns 0 from kunit_printk_emit(0 from my read of it. What I am
> saying is this is a lot of indirection instead of fixing the leaf
> function which is kunit_vprintk_emit().

Agreed. My apologies, as I mentioned in response to Tim, I just
assumed I was using it wrong.

> +#else /* CONFIG_PRINTK */
> +static inline int kunit_printk_emit(int level, const char *fmt, ...)
> +{
> +       return 0;
> +}
> +#endif /* CONFIG_PRINTK */
>
> Does the following work?
>
> #if defined CONFIG_PRINTK
> static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
> {
>          return vprintk_emit(0, level, NULL, 0, fmt, args);
> }
> #else
> static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
> {
>         return 0;
> }
> #endif
>
> I think the real problem is in the printk.h with its missing define for
> vprintk_emit() for !CONFIG_PRINTK case. There seem to only one call for
> this in drivers/base/core.c in CONFIG_PRINTK path. Unless I am totally
> missing some context for why there is no stub for vprintk_emit() for
> !CONFIG_PRINTK case

Agreed.

Sorry again for the confusion.

Thanks!
