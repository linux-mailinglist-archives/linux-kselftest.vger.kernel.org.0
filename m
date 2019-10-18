Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 948B2DD14C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 23:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506204AbfJRVly (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 17:41:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43247 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbfJRVlx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 17:41:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so4634249pfo.10
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2019 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hB675E64nw6z0mCcKC5XdWKWFq2jH+IHeB9Onr50eJk=;
        b=Dv4zsmRJo2A3OUBuY3Se6GL3N3SOEpmUZ9N5EEC2m1ZUOL2Wy9W45/J/RaJ0t9C/ql
         edyVPXSWSlYxIzlvngP0j3G6pVOFnbQau6NDqujV1HzqnEF5CJjRChCSB145wMp7y6RR
         8OHvE8LaxyDLyjUqLcdNDf243o/lSFax4zrSQ0+c4rOO4tcEHM9933OIZqoHufz3Ldq7
         SgkUu+ur1967uOV3zKASFWF4Ptb3EBcruZWfxuK/fwTpuoH4KuvW1R0OJOEShhb+oawu
         T8f6Qemur5xLLarXVuOsR+J39wgmHEx107Z9O3sQd8qYw5RC8DqjoV54RebL6Qn4Lf8l
         zL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hB675E64nw6z0mCcKC5XdWKWFq2jH+IHeB9Onr50eJk=;
        b=dXOrULU3zzWrbt8Nk0cVRum4Otvk/9XAQlqRSkyVfn9757HcWbOsps85RhmQ6mNWzr
         57vI61jn3vlMNmWr6y0XBPdRVnUmbUe7RrnSD98Y+ri8GDADNv7vBdvMv+t58cyYATmm
         TqAc7sr9IzNVDDLHjJEdCPQbf1WA0tvhVN2KDloySw8UVefE0Hmtqfrt8pg7FGYjf0Rq
         gQ1tCW2+qk0mg+trsDZ3uPGy0Ct0JJBq3o2q863jOhqZLzTs69XfjeDdpvUNAYjZOq8o
         I2eG/Uf2hCYW6DnGM7TechueopKl4d5CuweOh6KXkiMnPXswIiEmrkbKXo2yZkwDCQKp
         6YPA==
X-Gm-Message-State: APjAAAW+AXGzsstU9179G77MgHWJcZxy7VI8QW4LvD+N2UZQz1oJgjnm
        5Da1Tw552rYEhSwwE7Z+B88pWKXmg+iN8sM6ktlm1w==
X-Google-Smtp-Source: APXvYqz0loB5waUCNTaItdo70SDJfGU6MsU/KHLszClQR43GlHkfVYKtZOJZwmWEv2CChhS5uqZRHje3MCRoUE9Cshk=
X-Received: by 2002:a17:90a:f495:: with SMTP id bx21mr13128557pjb.84.1571434912732;
 Fri, 18 Oct 2019 14:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018004307.GA95597@google.com> <20191018162519.GH21137@mit.edu>
In-Reply-To: <20191018162519.GH21137@mit.edu>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 18 Oct 2019 14:41:38 -0700
Message-ID: <CAFd5g45LmnbD7L4LqdbfBV5YR377e81m61+z==RKCGjWBFqDGQ@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Kees Cook <keescook@chromium.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 18, 2019 at 9:25 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Oct 17, 2019 at 05:43:07PM -0700, Brendan Higgins wrote:
> > > +config SECURITY_APPARMOR_TEST
> > > +   bool "Build KUnit tests for policy_unpack.c"
> > > +   default n
> > > +   depends on KUNIT && SECURITY_APPARMOR
> >
> > Ted, here is an example where doing select on direct dependencies is
> > tricky because SECURITY_APPARMOR has a number of indirect dependencies.
>
> Well, that could be solved by adding a select on all of the indirect
> dependencies.  I did get your point about the fact that we could have

In this particular case that would work.

> cases where the indirect dependencies might conflict with one another.
> That's going to be a tough situation regardless of whether we have a
> sat-solver or a human who has to struggle with that situation.

But yeah, that's the real problem.

> It's also going to be a bit sad because it means that we won't be able
> to create a single config that could be used to run all the kunit
> tests when a user pushes a change to a Gerrit server for review.  :-/

Yeah...well, we can do the next best thing and generate a set of
kunitconfigs that in sum will run all the tests. Not nearly as nice,
but it's the next best thing, right? If you think about it, it's
really not all that different from the eventual goal of having many
independent test binaries.

> I suppose that if we use a strict definition of "unit tests", and we
> assume that all of the tests impacted by a change in foo/bar/baz.c
> will be found in foo/bar/baz-test.c, or maybe foo/bar/*-test.c, we can
> automate the generation of the kunitconfig file, perhaps?

Possibly. I have some friends on the TAP team (automated testing team
within Google), and it sounds like that is actually a pretty hard
problem, but something that is at least possible. Still, it would be
nice to have a way to periodically run all the tests.

> The other sad bit about having mutually exclusive config options is
> that we can't easily "run all KUinit tests" for some kind of test
> spinner or zero-day bot.
>
> I'm not sure there's a good solution to that issue, though.

I think, as I mentioned above, the best we can do is probably have a
thing which generates a set of kunitconfigs that in sum will run all
the tests.

Thoughts?
