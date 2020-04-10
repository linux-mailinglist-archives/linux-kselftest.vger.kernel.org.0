Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE461A4AB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Apr 2020 21:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgDJTlT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Apr 2020 15:41:19 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53923 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJTlT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Apr 2020 15:41:19 -0400
Received: by mail-pj1-f68.google.com with SMTP id l36so1138589pjb.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Apr 2020 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5OvqZpMSxpDga8tOOgnXo4SkZH42ToDKFuwSO8UOXzk=;
        b=Q6y07q886RK5lH9vSzLnampP7GAEl//DAgL/A/Y39qj2SNSE2Z4hGkLqU1o9Wb4l8s
         M8pt0DTF+cmGDsKpVAJskD7BGUq2y0wc1M2V42uKkifyfIf5htwXJErvIhNahgbjGjbe
         HrtWF5RmcxdQ0W9YxXJBS05SYFGjg+Nm1fY/sc6fttQmYCEoQPEwwVIYJUEsF527F5Bs
         Li6Yi0oXbmyRxuyCfmSMydnwr+TpUY/utpbvfoo+Bn6PqAR1ouW/Ra9vtiS0qJ2m8RZe
         PYs4GFUhsMf+o0upksaNGLln3nwMqedZl+RriM9ndjQsMmC6We3FIKOM64oW9P+cUUFQ
         lqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OvqZpMSxpDga8tOOgnXo4SkZH42ToDKFuwSO8UOXzk=;
        b=aPqWyKuW894Bw45D/TuYdsW1MsDnliACH+jmhd0Bq3AzhJNsPYcj0XIeG/bBsZQQwQ
         5lrTY9aNhMQWnNR0QKAVBu0f54b57hYOPfvzN5XLPk1PaQkiY/uDVckidLmvvD8yBABP
         s95ZgH5bgIQD68F+4f1RnM9oQ6EcEg5nJmcEd5DB2b7sU1zt7ipL2sLot+A0VDRVlVRQ
         Q8rmFDu6v1lGcWxTzgTOTzVn42dk/9BMu89VzWq0UZyqo/JplxmoZDs3YQfQPkQIkEqZ
         NPDZpL9DXZhbB1WHpYIc/MhG3HMZNbqtor93dasvk1ERzCfcK5WRiO4KGjy8Y0RG9JQX
         R33g==
X-Gm-Message-State: AGi0PuasvF6M+vz0yaf6aA1JzS+gSzueRt5oH2n+quxygMXB0H9p4kNJ
        BKtiLF1CxkmEQK/H+KY+ISRL7YIqo1cvomensHs=
X-Google-Smtp-Source: APiQypKIJob2axNHWnUh+pQfoVUlyN394QVStQK2YbpymlVcYBNGz9NZaQKb9qBGidgT5nI4vdo+nG65FXR9V1ddAFU=
X-Received: by 2002:a17:902:8546:: with SMTP id d6mr6118772plo.280.1586547678699;
 Fri, 10 Apr 2020 12:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200408205024.22119-1-l.rubusch@gmail.com> <CAFd5g47O07Gk6BixQV6iQpcERU_xVbBtRaUyXGaOO7Axcma+iQ@mail.gmail.com>
 <CAFXKEHY0pBmUhEMAVgOJ+zzaxWxEFcGQqa7ry+qF30wWs5=B4w@mail.gmail.com>
 <CAFd5g47037poE7w6GUasV90-BNBMcg0+uCQjikqpCuYwDJ4euw@mail.gmail.com>
 <CAFXKEHYU-t2Xt_Q9-CN=G_v17_jj1mO1bBcA7mtYFq0zxyus2Q@mail.gmail.com> <CAFd5g445TiNfTD3bMnqgtts0iGsb9tFnzK6CyMjcW_9hcsG+dQ@mail.gmail.com>
In-Reply-To: <CAFd5g445TiNfTD3bMnqgtts0iGsb9tFnzK6CyMjcW_9hcsG+dQ@mail.gmail.com>
From:   Lothar Rubusch <l.rubusch@gmail.com>
Date:   Fri, 10 Apr 2020 21:40:42 +0200
Message-ID: <CAFXKEHYnaKutRTkb07TY5imWROsXzPwRQt=mdZupXw1VvXQa3g@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: test.h - fix warnings
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 9, 2020 at 11:16 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Thu, Apr 9, 2020 at 1:51 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
> >
> > On Thu, Apr 9, 2020 at 10:00 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Wed, Apr 8, 2020 at 2:17 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > >
> > > > On Wed, Apr 8, 2020 at 10:56 PM Brendan Higgins
> > > > <brendanhiggins@google.com> wrote:
> > > > >
> > > > > On Wed, Apr 8, 2020 at 1:50 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> [...]
>
> > > > > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > > > > index 9b0c46a6ca1f..16d548b795b5 100644
> > > > > > --- a/include/kunit/test.h
> > > > > > +++ b/include/kunit/test.h
> > > > > > @@ -175,7 +175,7 @@ struct kunit_suite {
> > > > > >         void (*exit)(struct kunit *test);
> > > > > >         struct kunit_case *test_cases;
> > > > > >
> > > > > > -       /* private - internal use only */
> > > > > > +       /* private: internal use only */
> > > > > >         struct dentry *debugfs;
> > > > > >         char *log;
> > > > > >  };
> > > > > > @@ -232,7 +232,8 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
> > > > > >   * kunit_test_suites() - used to register one or more &struct kunit_suite
> > > > > >   *                      with KUnit.
> > > > > >   *
> > > > > > - * @suites: a statically allocated list of &struct kunit_suite.
> > > > > > + * @...: a statically allocated list of &struct kunit_suite, assigned
> > > > > > + *           to the pointer @suites.
> > > > > >   *
> > > > > >   * Registers @suites with the test framework. See &struct kunit_suite for
> > > > >
> > > > > Can you change the @suites param here to match @...?
> > > >
> > > > You mean, in "Registers @suites with the test framework" to something
> > > > rather like "Registers @... with"?
> > > > Hum, franckly I think, in the documentation it reads better having the
> > > > name "suites", that's why I tried to
> > > > append a hint, that a passed list of struct kunit_suite initializes
> > > > the pointer "suites". Then further in the doc
> > > > refered as suites, I think it becomes clear. But let me know. Shall I
> > > > use @... instead?
> > >
> > > I agree that it doesn't read as well, but I like having the proper
> > > syntax highlighting and consistent naming over a mix and match.
> >
> > I'll have another look on the syntax highlighting, leave out the api page
> > removal and then resubmit. No problem. Thank you for all your patience!!
> > I really appreciate if I can contribute to something!
> >
> >
> > > Another alternative would be to replace `...` with `suites...` and
> > > then @suites should work.
> > >
> > > Either way is fine with me; it's a nasty macro anyway.
> >
> > Yeah, that's what I read in the kernel-doc perl, too. Changing '...'
> > to 'suites...'
> > is a code change, though. Possible, but IMHO would be a different patch.
>
> Good thought; that would usually be true most likely; however, in this
> case the documentation issue is in a comment in a code file, so no
> matter how you look at it, it is a code change. Also, it's such a
> minor change and since most of the KUnit code and documentation
> changes both go through the KUnit branch of the Kselftest tree anyway,
> so I think it's fine to just keep it all in one patch.

Absolutely Agree, this is cosmetics. Anyway, personally I'm also learning how
to write to the community, i.e. I try to be careful. Thanks for the support!

> > Actually, should we fix up the code for having a nicer documentation?!!
>
> Yes! Or at least I think so. Good documentation can be just as
> important, even more important than good code. I know there are plenty
> of developers that disagree with me on this point, but given what we
> are trying to do with KUnit, I say we are actually one of the places
> where our documentation is of utmost importance.

Ah, this is actually not what I meant. I fully agree with you, good generated
documentation is essential. I wanted to say, In a way I would prefer changing
the scripts, rather than the sources to obtain better documentation.
Practically it's easier to adjust the source directly.

> Still, great question to ask. Different kernel developers feel very
> differently about this point, and with good reason: some parts of the
> kernel will only really be used by people who can be expected to read
> all the relevant code, whereas other parts of the kernel may be used
> directly by a huge number of people most of which can't be expected to
> read all the code. It would make sense that these two groups of people
> would find different value in documentation.
>
> > Somehow this feels like the next patches should go rather to sphinx/kernel-doc.
>
> Not sure what you mean by this.

Generally I see the limitation in the kernel-doc scripts not allowing
for an anotation
for a better naming an unnamed variadics. I mean changing the source
according to
the limitations of the scripts, is still kind of reasonable, low prio,
low effort, easy...
Alternatively, extending the scripts may add more flexibility.
I saw worse things at the sphinx documentation e.g. duplicate label
warnings when
using same headers inside the same document and sphinx.ext.autosection label
active - which makes me feel like this should be rather patched, than
rewritten in
the docs to fit that quirk of sphinx. Getting offtopic..

> > Anyway, this patch is all about documentation.
> > A code change must be tested and verified and IMHO might be a different story.
>
> True, all code changes should be tested (I think all docs changes
> should be tested too :-) ), but testing this code here is really easy.
> You can test it with the following command:
>
> ./tools/testing/kunit/kunit.py run --timeout=60 --jobs=8 --defconfig

This is just awesome. Yesterday I was too lazy to still try anything.
Thank you, I appreciate. I'll play around with that the next days.

> >
> > Happy Easter!
>
> Happy Easter! (again)
L
