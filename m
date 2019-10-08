Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A455D03AB
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 01:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfJHXAF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 19:00:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44988 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHXAF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 19:00:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id q15so59005pll.11
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2019 16:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eyo69Bj9AG/hnXPevoWygqlppJemIYNJ7F2RPuWU8dY=;
        b=POFNouzMoxXQIv9JnlsSQgK3y3HMhAy3mp2TYc598ljUPvN8FBTKuIE9wAwzZqL+/F
         HZw+PT1DTt3Gjbf8QtFh34JvPf9Q/hPy5X6qhumTnnasWaD4yUX6AsWhNjT6JN/5nVXH
         xbvpKtpOu/SW3ycJtZj6EuK/TO0A1HFU+6f7NzoBSJ8XBcbOHDvTcrDPYHlwxTs8D+5p
         ISSGweWiERgDfqtXvDbluCimeJ0wkkroHkxoHoSBf1dB8MubcphrrZRCiSGJICH24gnf
         Cr4bbNPSwSzAxYzhSWZtGL3A34XK5x+qKE/8jQZ7m8Lg91jmnIXNiqLRJERrR3qQkGbv
         IgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eyo69Bj9AG/hnXPevoWygqlppJemIYNJ7F2RPuWU8dY=;
        b=B1TnouKs5JBm3+Nj7m4LVOjoVZjyOf2hV9HDEY/6BP7LGTV0PMx1PYW9E5AE6HbZyD
         KKoRSp8N7eN/m1i+nDW9omECp3LUEFvpe+TR0sHias8eDfHjC8Yg7FVp0Hjmav0VhEoE
         wG+Nb0kiQjEMwfwkIovYH5hdHSyDYQysPtk1DHKUlLtFHuXH6hObvorylIW+dMqsb1tG
         rpvGD8PIKttE7uAgbedCKY8y2znAfxHsyw4WkARgCB7oO31aI+TwabRswNge3rnf/36G
         f7lpr2sYfvoaIsvAcJVRn4SlD36be3Pn9YdgLyDXemflPVN2GAoQvF/q+4kISYzL6HnV
         YenQ==
X-Gm-Message-State: APjAAAVEvF7C6nl73Gjffd4cMNzSKfyujkNvhzIpYmOe9phmW0qaxG9b
        EDiLT8g7GJQVVrjIe6VTAi8wziSW7U7J/gsI4r6cjzr+LFaJHg==
X-Google-Smtp-Source: APXvYqwt6lKV097yKIvMMLvJn2axxESyqhaimfQfK2VgBnSpIw3QAm7iMeYTx54wc+6BItZKAD+0+Qi1GLCAejI/EIc=
X-Received: by 2002:a17:902:8216:: with SMTP id x22mr20714pln.232.1570575604135;
 Tue, 08 Oct 2019 16:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191007213633.92565-1-davidgow@google.com> <20191008174837.GA155928@google.com>
 <201910081110.C2C582408F@keescook>
In-Reply-To: <201910081110.C2C582408F@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 8 Oct 2019 15:59:43 -0700
Message-ID: <CAFd5g46V6m8OyQmi9H7qdwtXcaFJrz3e6c4+SQ8yaauR7SFayg@mail.gmail.com>
Subject: Re: [PATCH] lib/list-test: add a test for the 'list' doubly linked list
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>, shuah <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 8, 2019 at 11:15 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Oct 08, 2019 at 10:48:37AM -0700, Brendan Higgins wrote:
> > On Mon, Oct 07, 2019 at 02:36:33PM -0700, David Gow wrote:
> > > This change adds a KUnit test for the kernel doubly linked list
> > > implementation in include/linux/list.h
> > >
> > > Note that, at present, it only tests the list_ types (not the
> > > singly-linked hlist_), and does not yet test all of the
> > > list_for_each_entry* macros (and some related things like
> > > list_prepare_entry).
> > >
> > > This change depends on KUnit, so should be merged via the 'test' branch:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=test
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>
> > > ---
> > >  lib/Kconfig.debug |  12 +
> > >  lib/Makefile      |   3 +
> > >  lib/list-test.c   | 711 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 726 insertions(+)
> > >  create mode 100644 lib/list-test.c
> >
> > Also, I think it might be good to make a MAINTAINERs entry for this
> > test.
>
> Another thought, though maybe this is already covered and I missed the
> "best practices" notes on naming conventions.
>
> As the "one-off" tests are already named "foo_test.c" it seems like
> KUnit tests should be named distinctly. Should this be lib/kunit-list.c,
> lib/list-kunit.c, or something else?

So we already had a discussion on this here:
https://patchwork.kernel.org/patch/10925861/

(Sounds like I should have probably documented that :-))

However, I am sympathetic to your argument. I was thinking that it
might be good to make get_maintainer suggest CC'ing kunit-dev@ and
linux-kselftest@ for all new tests and this would be hard with the
*-test.c naming scheme.

If we are going to change it, now is probably the time to do it :-)

> For internal naming of structs and tests, should things be
> named "kunit_foo"? Examples here would be kunit_list_struct and
> kunit_list_test_...

I had generally been following the pattern:

foo.c
struct foo_bar {};
int foo_baz() {}
foo-test.c
struct foo_test_buzz {};
void foo_test_does_foo_baz_buzz(struct kunit *test) {}

However, now that you point that out I am realizing there is a bunch
of stuff here that is not consistent with that (whoops, sorry for not
catching that earlier, David).

Nevertheless, I think the list_test_struct is fine and conforms to the pattern.

> When testing other stuff, should only exposed interfaces be tested?
> Many things have their API exposed via registration of a static structure
> of function pointers to static functions. What's the proposed best way
> to get at that? Should the KUnit tests is IN the .c file that declares
> all the static functions?

Yeah, that is a good point, but I don't think entirely relevant to
this code review.

Fundamentally it boils down to figuring out what your API is, and
coming up with a way to expose it. For drivers, that means finding a
way to give KUnit access to the generated driver objects, in some
cases it means using more dependency injection, in other cases it may
mean making something that is static, not static.

I know those answers sound pretty unsatisfying, and I have some
features planned which alleviate some of those issues, but I think the
most important thing is making examples of how to deal with some of
the broad cases, getting agreement on them, documenting them, finding
exceptions and iterating.

Nevertheless, if you want to start enumerating cases and proposed
solutions, I would be more than happy to have that conversation now,
but we might want to fork the discussion.

Cheers!
