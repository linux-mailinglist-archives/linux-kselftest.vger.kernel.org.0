Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF52F1A3BC7
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Apr 2020 23:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgDIVQs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Apr 2020 17:16:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33249 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgDIVQr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Apr 2020 17:16:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay1so4312330plb.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Apr 2020 14:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eg9/ypr2QMi2cg+O5eic347O/arPnZLJt3LRgonxSZo=;
        b=mwuDe7kp2pcmJRWBNYoiisfC7kXQ9bXDuWhVoVPCkECTCbFgNoJ+TPP8URgOJfFXiB
         EG5QleVQTQ6x89Exe/UZC0tNPQm0HT4HR9EkoDe96SqHH8e1L4E4M9+sANWAWJBRLIfg
         Keo1oGO3cp5bAwkguPfZvC632jw3sjUVo8nByQKjsDwDS0sfQLq8TV+l90eBTGf3VBuC
         3nrgmHuD4x0toF48p6a9N2hxZZw4Z6QiA8SEe+zsOLm9oFJUvsA4T+SspPV2qS9nZwq/
         vkklVO4rz7/Cd0JkVAfei2lu4BirT6Zd54vldtXKd+a/oPCY102JFQOT48C5JrMNypby
         e6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eg9/ypr2QMi2cg+O5eic347O/arPnZLJt3LRgonxSZo=;
        b=d98Qizc1gBLRVwkBghCju6suIRokG4ZAcJyZUcbW+wTlca7NFxWdn4FeTUo+u1S0q5
         DaM6rIEDvCc9ulcDhBLh+BXbSdPEm+FzAgWh0wyXKZE//qXm+8gbRZNCV+HaRoGFiBvM
         mEvQ+wzyBTQ7g44LDAriEp0KC5bdLeOYJoTY2r/i2gLT16JCf59Vno2a0EnXbjNpoNGN
         8aucZ0VqVKq0oMGVw9Wt359hcZYVMwVCuvFPZaZzirt510zt5r5zfzkliVhacCAGJw5J
         P1peBC1Y59JoqCvBclLrdWI5UKLw0E7Jlg+j7gzyuRBvGF5Y3YeK8ZOqnAXZgYhwmmEl
         rUKw==
X-Gm-Message-State: AGi0PubIIBYkz5RrhWZPO1CccC736FhT191fq6otETaXmFMMFCKUSLta
        aK+OEB0yy/rTpKNhx6WcqkHC4ZJJi4tnjwf34ETPDw==
X-Google-Smtp-Source: APiQypLzxBThAvbjBG4L6Cm3iSVLL2rrA5MTmxJNo193/7FlGLhUGQ6bHd6XcntGhMaIqE80CJjh4MfFI/OBmb/9ZyI=
X-Received: by 2002:a17:902:8ec1:: with SMTP id x1mr1503078plo.325.1586467004720;
 Thu, 09 Apr 2020 14:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200408205024.22119-1-l.rubusch@gmail.com> <CAFd5g47O07Gk6BixQV6iQpcERU_xVbBtRaUyXGaOO7Axcma+iQ@mail.gmail.com>
 <CAFXKEHY0pBmUhEMAVgOJ+zzaxWxEFcGQqa7ry+qF30wWs5=B4w@mail.gmail.com>
 <CAFd5g47037poE7w6GUasV90-BNBMcg0+uCQjikqpCuYwDJ4euw@mail.gmail.com> <CAFXKEHYU-t2Xt_Q9-CN=G_v17_jj1mO1bBcA7mtYFq0zxyus2Q@mail.gmail.com>
In-Reply-To: <CAFXKEHYU-t2Xt_Q9-CN=G_v17_jj1mO1bBcA7mtYFq0zxyus2Q@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 9 Apr 2020 14:16:33 -0700
Message-ID: <CAFd5g445TiNfTD3bMnqgtts0iGsb9tFnzK6CyMjcW_9hcsG+dQ@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: test.h - fix warnings
To:     Lothar Rubusch <l.rubusch@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 9, 2020 at 1:51 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> On Thu, Apr 9, 2020 at 10:00 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Wed, Apr 8, 2020 at 2:17 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > >
> > > On Wed, Apr 8, 2020 at 10:56 PM Brendan Higgins
> > > <brendanhiggins@google.com> wrote:
> > > >
> > > > On Wed, Apr 8, 2020 at 1:50 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:

[...]

> > > > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > > > index 9b0c46a6ca1f..16d548b795b5 100644
> > > > > --- a/include/kunit/test.h
> > > > > +++ b/include/kunit/test.h
> > > > > @@ -175,7 +175,7 @@ struct kunit_suite {
> > > > >         void (*exit)(struct kunit *test);
> > > > >         struct kunit_case *test_cases;
> > > > >
> > > > > -       /* private - internal use only */
> > > > > +       /* private: internal use only */
> > > > >         struct dentry *debugfs;
> > > > >         char *log;
> > > > >  };
> > > > > @@ -232,7 +232,8 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
> > > > >   * kunit_test_suites() - used to register one or more &struct kunit_suite
> > > > >   *                      with KUnit.
> > > > >   *
> > > > > - * @suites: a statically allocated list of &struct kunit_suite.
> > > > > + * @...: a statically allocated list of &struct kunit_suite, assigned
> > > > > + *           to the pointer @suites.
> > > > >   *
> > > > >   * Registers @suites with the test framework. See &struct kunit_suite for
> > > >
> > > > Can you change the @suites param here to match @...?
> > >
> > > You mean, in "Registers @suites with the test framework" to something
> > > rather like "Registers @... with"?
> > > Hum, franckly I think, in the documentation it reads better having the
> > > name "suites", that's why I tried to
> > > append a hint, that a passed list of struct kunit_suite initializes
> > > the pointer "suites". Then further in the doc
> > > refered as suites, I think it becomes clear. But let me know. Shall I
> > > use @... instead?
> >
> > I agree that it doesn't read as well, but I like having the proper
> > syntax highlighting and consistent naming over a mix and match.
>
> I'll have another look on the syntax highlighting, leave out the api page
> removal and then resubmit. No problem. Thank you for all your patience!!
> I really appreciate if I can contribute to something!
>
>
> > Another alternative would be to replace `...` with `suites...` and
> > then @suites should work.
> >
> > Either way is fine with me; it's a nasty macro anyway.
>
> Yeah, that's what I read in the kernel-doc perl, too. Changing '...'
> to 'suites...'
> is a code change, though. Possible, but IMHO would be a different patch.

Good thought; that would usually be true most likely; however, in this
case the documentation issue is in a comment in a code file, so no
matter how you look at it, it is a code change. Also, it's such a
minor change and since most of the KUnit code and documentation
changes both go through the KUnit branch of the Kselftest tree anyway,
so I think it's fine to just keep it all in one patch.

> Actually, should we fix up the code for having a nicer documentation?!!

Yes! Or at least I think so. Good documentation can be just as
important, even more important than good code. I know there are plenty
of developers that disagree with me on this point, but given what we
are trying to do with KUnit, I say we are actually one of the places
where our documentation is of utmost importance.

Still, great question to ask. Different kernel developers feel very
differently about this point, and with good reason: some parts of the
kernel will only really be used by people who can be expected to read
all the relevant code, whereas other parts of the kernel may be used
directly by a huge number of people most of which can't be expected to
read all the code. It would make sense that these two groups of people
would find different value in documentation.

> Somehow this feels like the next patches should go rather to sphinx/kernel-doc.

Not sure what you mean by this.

> Anyway, this patch is all about documentation.
> A code change must be tested and verified and IMHO might be a different story.

True, all code changes should be tested (I think all docs changes
should be tested too :-) ), but testing this code here is really easy.
You can test it with the following command:

./tools/testing/kunit/kunit.py run --timeout=60 --jobs=8 --defconfig

>
> Happy Easter!

Happy Easter!
