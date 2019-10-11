Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A797D3CB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 11:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfJKJsB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 05:48:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39245 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfJKJsB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 05:48:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id e1so5486303pgj.6
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2019 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hFWWTgCwLZF7eZOvdKDIvbCxpSZTOcR0S73D1F8CmM=;
        b=S7Ymoa1PVnGwmbDGdsD3ELF+jheOHnoQ3o7rp8tIrMo9/229yIJGB1gtX0hGXXSmzv
         FQJLQs7o1OBt+HxVICbFH3/Mkr2lEKjwQgm7iFWAFEBsJHZJzvuf398RZXTTqe0JquBi
         oopaz9k1/piO92jyKSGYZnGXjtMkgrxE+BotEX7IzZRQT2FP50oI9ato3gIWzDOnFIrY
         LJUEXh4w0YT+u91aGoaATthu3hblIY2Rje2hQ9/ZfrFYRN4sdIdKZKedT/1InoFJ6kma
         4xkHASYuK3U5FAr+ZyuXdKFuDf+PRaPKJIXa2I6+I/NchH1Z0FvzRESqT5O70y4zWZ/p
         YLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hFWWTgCwLZF7eZOvdKDIvbCxpSZTOcR0S73D1F8CmM=;
        b=JePmRr6CmBT+oRGSxkz1gSIjANlJLPBk/hdOzHQYii1JK8FSrL1qzW5r71vN7wkYRM
         TPtt9k3DJvDSUWLpvczQylBf3Dvf7Q/5RA4x9pQtOx6Wa5zqgBEzPRzwMHVLipn68BGf
         Y8WpxK/Cogwkps3auGT7EzZWD7mJCcJsDNekyTZZp2rSDX5U2HUfrvhmTs0OLh2aOK0u
         NT0FxLaJYF/KGnpysX4iqv9mwlvtzFp/VAmAXtiuJ5y7teiapfpe5IfjE7YB0EXLRXif
         mBr5LFLmiEDSv/7S46osu+D6NlhCq5onRXpLH/E2UkYE3+hDKaM5osw+YApO3F/AOgPh
         fc1A==
X-Gm-Message-State: APjAAAW7ZQkhJtcg5QoAKc0SwCnMAEql76a3WRim17YJB+bj2xmwmV35
        4HPXjSxZc6FEfqqAV3MeuI5w3CGfPf+fPXsv0rdt2q7a
X-Google-Smtp-Source: APXvYqzTt4HxIOOG7kIK/D6X+t2zy+2SXJ+jDfNdcNp0zdfnvBTQj95+cOKO+6wfO8k6eU777KfeTb+fXCY2rqIVbFo=
X-Received: by 2002:a63:5516:: with SMTP id j22mr15723527pgb.201.1570787280364;
 Fri, 11 Oct 2019 02:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
 <1570546546-549-2-git-send-email-alan.maguire@oracle.com> <20191008213535.GB186342@google.com>
 <alpine.LRH.2.20.1910091726010.2517@dhcp-10-175-191-127.vpn.oracle.com>
In-Reply-To: <alpine.LRH.2.20.1910091726010.2517@dhcp-10-175-191-127.vpn.oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 11 Oct 2019 02:47:49 -0700
Message-ID: <CAFd5g46_6McK06XSrX=EZ9AaYYitQzd2CTvPMX+rPymisDq5uQ@mail.gmail.com>
Subject: Re: [PATCH v2 linux-kselftest-test 1/3] kunit: allow kunit tests to
 be loaded as a module
To:     Alan Maguire <alan.maguire@oracle.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        changbin.du@intel.com, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sorry for the delayed reply. I will be on vacation until Wednesday,
October 16th.

On Wed, Oct 9, 2019 at 9:36 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Tue, 8 Oct 2019, Brendan Higgins wrote:
>
> > On Tue, Oct 08, 2019 at 03:55:44PM +0100, Alan Maguire wrote:
[...]
> > > diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> > > index e6d17aa..e4f3a97 100644
> > > --- a/lib/kunit/string-stream.c
> > > +++ b/lib/kunit/string-stream.c
> > > @@ -100,6 +100,7 @@ int string_stream_vadd(struct string_stream *stream,
> > >
> > >     return 0;
> > >  }
> > > +EXPORT_SYMBOL_GPL(string_stream_vadd);
> >
> > Is this actually needed by anything other than lib/kunit/test.c right
> > now? Maybe we should move the include file into the kunit/ directory to
> > hide these so no one else can use them.
> >
>
> I tried this, and it's the right answer I think but it exposes
> a problem with symbol visibility when kunit is compiled as a module.
> More on this below...
>
> > >  int string_stream_add(struct string_stream *stream, const char *fmt, ...)
> > >  {
> > > @@ -112,6 +113,7 @@ int string_stream_add(struct string_stream *stream, const char *fmt, ...)
> > >
> > >     return result;
> > >  }
> > > +EXPORT_SYMBOL_GPL(string_stream_add);
> > [...]
> > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > index c83c0fa..e7896f1 100644
> > > --- a/lib/kunit/test.c
> > > +++ b/lib/kunit/test.c
> > [...]
> > > @@ -50,6 +51,7 @@ static unsigned long kunit_test_timeout(void)
> > >      * For more background on this topic, see:
> > >      * https://mike-bland.com/2011/11/01/small-medium-large.html
> > >      */
> > > +#ifndef MODULE
> >
> > Why is this block of code "ifndef MODULE"?
> >
>
> Symbol visibility is the problem again; sysctl_hung_task_timeout_secs
> isn't exported so when kunit is a module it can't find the symbol.
>
> I think I saw Kees mentioned something about symbol lookup too; in KTF
> Knut solved this by defining ktf_find_symbol(). I'd suggest we may need a
> kunit_find_symbol() with a function signature

I thought we were just talking about exposing symbols for linking
outside of a compilation unit (static vs. not static); nevertheless, I
think you are right that it is relevant here. Kees, thoughts?

> void *kunit_find_symbol(const char *modname, const char *symbol_name);
>
> ...which does a [module_]kallsyms_lookup_sym().
>
> If the above makes sense I can look at adding it as a patch (and adding
> a test of it of course!). What do you think?

So that won't work if you are trying to link against a symbol not in a
module, right? Also, it won't work against a static symbol, right?

Even so, I think it is pretty wonky to expect users to either a)
export any symbol name to be tested, or b) have to access them via
kunit_find_symbol. I think it is fine to have some tests that cannot
be compiled as modules, if there is no other user friendly way to make
this work in those cases.

Thoughts?
