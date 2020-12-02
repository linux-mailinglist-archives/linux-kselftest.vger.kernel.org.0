Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1482CC652
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 20:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389672AbgLBTMi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 14:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387672AbgLBTMi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 14:12:38 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92D4C0613D4
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Dec 2020 11:11:57 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id b8so2538893ila.13
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Dec 2020 11:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWwMP9Qu59E97WnFSo7tWaVZ8Q8jnvlr9E6yczqoWS4=;
        b=CRHBGwB9OYdmxCSy62fpr/oNz2KCocWFi0UY60gE6eh0hhx3IZtqjAc/ORzPKzx+Xd
         ZKHBCVGTvTSWdns/xOPCTMhmNowm7e4w7l5IPCpnMDc3f3k7bTguG0BegRersVqnxIHs
         DkvnsWkMrced75uqvWrstgsgYmM99kYyOY/zlFMbyDW726cSdiixFbe/x4efDUaYlCW3
         LXhwaOPqcfltQDEEoDx7U6PXpkUCY/Qc292hNmGy7XPu7BRqcUygd7RRzwPzMh8y1fVL
         GQ342FwvYbipSLN5e7syUjT+L39G+oD/LD4Zya0T7a7iW341uhqi4qKM8fUlSNO9I2i8
         9IdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWwMP9Qu59E97WnFSo7tWaVZ8Q8jnvlr9E6yczqoWS4=;
        b=WPA+jxyJmvkrqKEAo609BFYJTihK0Y4OjJmxNQiWCPp7DNcBaTP5W9WZvT4xcj/gqT
         59e3sBopLz0uc8F3tAxuX1D01MzAQJ4y6grd9cToi3XxjgQjnPHI5gNWYv8O88XTRA9N
         UJg/C86dVB883Tt//NnaliOMER+4N4640kfR45buYKTPW+PbwxQpIYNuFNkiEL97m/Wq
         UOKDjtzzoOg9Qq2VwwucItlUeUA0bCAkXLKAf9Ijy8G5hJoNqQdELv9+X/TXnagoJMcY
         SgTchAIWBQtA4qBHgYU332RYkSkEfPHhGyxpWzEVMSVWAMNjDT8rfBJDacy9a0bzLsW9
         uqpw==
X-Gm-Message-State: AOAM533I2pTSVWrpNCJpjE8ZryihFTGb18KZ0ZsgcQMqT1q5JOI3Q+T3
        AXUAG9gPF3LTipkk+LXodtep5AWgNpa4VYb65WuJyA==
X-Google-Smtp-Source: ABdhPJwkSHS24J9Fb8k3A3FTIW/JlQja+VFvbGxlYzEynz0UwTD4IDoOW+2vKVQVDx26isb8rcbEnmPyXCwhh3YKiVI=
X-Received: by 2002:a92:bf09:: with SMTP id z9mr3612407ilh.194.1606936317006;
 Wed, 02 Dec 2020 11:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20201130233242.78413-1-dlatypov@google.com> <20201130233242.78413-2-dlatypov@google.com>
 <CABVgOSmX3foOr6XJhQ_goYabFEg8qNYoQ+5O7JPRW=gLmh=OQA@mail.gmail.com>
 <CAGS_qxpW=Q=x8WAR3WWhtYnJc+K43kpDw680x+6go1cAjW6oUQ@mail.gmail.com> <CABVgOSnH0gz7z5JhRCGyG1wg0zDDBTLoSUCoB-gWMeXLgVTo2w@mail.gmail.com>
In-Reply-To: <CABVgOSnH0gz7z5JhRCGyG1wg0zDDBTLoSUCoB-gWMeXLgVTo2w@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 2 Dec 2020 11:11:45 -0800
Message-ID: <CAGS_qxr8GD-VO5eYHV5BpgQrat4bdZwAO_xDRnkZrEizxgZ1oA@mail.gmail.com>
Subject: Re: [PATCH 2/5] kunit: tool: fix unit test so it can run from
 non-root dir
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 1, 2020 at 8:41 PM David Gow <davidgow@google.com> wrote:
>
> On Wed, Dec 2, 2020 at 3:00 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Mon, Nov 30, 2020 at 11:33 PM David Gow <davidgow@google.com> wrote:
> > >
> > > On Tue, Dec 1, 2020 at 7:33 AM Daniel Latypov <dlatypov@google.com> wrote:
> > > >
> > > > get_absolute_path() makes an attempt to allow for this.
> > > > But that doesn't work as soon as os.chdir() gets called.
> > >
> > > Can we explain why this doesn't work? It's because the test_data/
> > > files are accessed with relative paths, so chdir breaks access to
> > > them, right?
> >
> > Correct.
> > Because it actually returns a relative path.
> >
> > (I forgot that I called out that get_absolute_path() gives relative
> > paths in the last patch, and not this one. I can update the commit
> > desc if we want a v2 of this)
> >
> > >
> > > >
> > > > So make it so that os.chdir() does nothing to avoid this.
> > > >
> > > > Note: mock.patch.object() doesn't seem to work in setUpModule(), hence
> > > > the introduction of a new base class instead.
> > > >
> > > > Fixes: 5578d008d9e0 ("kunit: tool: fix running kunit_tool from outside kernel tree")
> > > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > > ---
> > >
> > > I don't like this: disabling a real system call seems like overkill to
> > > work around a path issue like this.
> > >
> > > Wouldn't it be better to either:
> > > (a) stop kunit_tool from needing to chdir entirely; or
> >
> > a) is doable, but would require plumbing cwd=get_kernel_root_path() to
> > all the subprocess calls to make, etc.
> > I'm not sure fixing a internal test-only issue necessarily justifies
> > taking that path instead of the easier "just add a chdir" we opted for
> > in 5578d008d9e0 ("kunit: tool: fix running kunit_tool from outside
> > kernel tree").
> >
> > > (b) have get_absolute_path() / test_data_path() produce an absolute path.
> > >
> > > The latter really seems like the most sensible approach: have the
> > > script read its own path and read files relative to that.
> >
> > b) is not that simple, sadly.
> >
> > Say I invoke
> > $ python3 kunit_tool_test.py
> > then __file__ = kunit_tool_test.py.
> >
> > So __file__ is a relative path, but the code assumed it was an
> > absolute one and any change of directory breaks things.
> > Working around that would require something like caching the result of
> > os.path.abspath(__file__) somewhere.
>
> So, to clarify, __file__ is a relative path based on the cwd when the
> script is initially run, right?

Yes, on my box at least.
https://docs.python.org/3/reference/import.html#__file__ doesn't not
seem to stipulate an absolute path, either.

>
> In any case, caching the result of os.path.abspath(__file__) seems
> like the most sensible solution to me. There's global state anyway
> (the current directory), we might as well have it in an explicit
> variable, IMHO.

Ok, sent out a v2 and squash this change with the test_data_path() patch.

Not really a fan of the adding the global state, but I see your point
about there maybe being need for more chdir calls and I don't see a
better way of keeping track of the absolute path.

> >
> > I can see the point about not mocking out something like os.chdir().
> > But on the other hand, do we have any other legitimate reason to call
> > it besides that one place in kunit.py?
> > If we do have something that relies on doing an os.chdir(), it should
> > ideally notice that it didn't work and manifest in a unit test failure
> > somehow.
>
> Certainly there doesn't seem to be any other need to chdir() in
> kunit_tool at the moment, but I could see us doing so when adding
> other features. More to the point, if both kunit.py and
> kunit_tool_test.py rely on or manipulate the current directory as part
> of their state, that seems like it's asking for some trouble down the
> line.
>
> If we use an absolute path for the test data, that's something that
> seems unlikely to ever need further changes or cause issues.
> >
> > Alternatively, we could make get_kernel_root_path() return ""/None to
> > avoid the chdir call.
> > kunit.py:       if get_kernel_root_path():
> > kunit.py:               os.chdir(get_kernel_root_path())
> >
> > There'd be no adverse affects atm for stubbing that out, and I don't forsee any.
> > But if we want to be even safer, then perhaps we have
> >
> > def chdir_to_kernel_root():
> >    ...
> >
> > and mock out just that func in the unit test?
>
> I'd be okay with this, even if I'd prefer us to use an absolute path
> for the test_data as well. Having something like this might even give
> us the opportunity to verify that we're actually trying to change to
> the kernel directory in cases where we need to, but that seems like
> it's out-of-scope for a simple fix.
>
> -- David
