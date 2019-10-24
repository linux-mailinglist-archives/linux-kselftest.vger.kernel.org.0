Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69166E2E91
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2019 12:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392605AbfJXKPe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Oct 2019 06:15:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33947 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391807AbfJXKPd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Oct 2019 06:15:33 -0400
Received: by mail-qt1-f196.google.com with SMTP id e14so17265623qto.1;
        Thu, 24 Oct 2019 03:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Jg0HC2V0TUACAR0qAG1JtmCPUTiqlxxEMeEIEXx1r8=;
        b=ewwQeIZJ7evve1w34HVzCkmXfpYvvm8figi2RlLP9K1LypO3IE+6UbWvbmBjLcrFiL
         6kuZ6tjw5v6zBA7i+ANnqEgWaBvafufHq4h103rpDGnxcGOs47cfCkShBQRdBd3srqLv
         UilmcNwTsYrJ2veKGosp0LrFh1pVOj4CUcMbIsgfuaZxElIyM3d0kXNVo+Tdmj24vCuf
         hBAXzti4fAdNBbc6pXO9PrHHnnvUotPtAFebRMb60FsreyI+5id3yX1XuQcy/SC+8mbZ
         3VwWLaaW9b/D9dL7H0aoKNSzJRzQsstllmFdBSqaJYe8wbJ2u5kPHIgAjTr8WkNAHPu4
         Ghjw==
X-Gm-Message-State: APjAAAWhX8eVKjiqy3KV91YLKguL9OlD9L04DX3dzDTqYGxGEZZeg9Os
        mQhtEsy6JqUrKI6JmGdG1U4=
X-Google-Smtp-Source: APXvYqwl1B9XBw0idLxLI//GAYXh+9vvmuxm/t9cdkKcX3KSrJE8Z2wYTpUkvL+buzZUu9VpYYjuAg==
X-Received: by 2002:ac8:4750:: with SMTP id k16mr3189652qtp.288.1571912132146;
        Thu, 24 Oct 2019 03:15:32 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v4sm12508055qkj.28.2019.10.24.03.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 03:15:31 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C6A2A40244; Thu, 24 Oct 2019 10:15:29 +0000 (UTC)
Date:   Thu, 24 Oct 2019 10:15:29 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Matthias Maennich <maennich@google.com>,
        shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
Message-ID: <20191024101529.GK11244@42.do-not-panic.com>
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018122949.GD11244@42.do-not-panic.com>
 <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com>
 <CAFd5g46aO4jwyo32DSz4L8GdhP6t38+Qb9NB+3fev3u4G6sg4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g46aO4jwyo32DSz4L8GdhP6t38+Qb9NB+3fev3u4G6sg4w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 23, 2019 at 05:42:18PM -0700, Brendan Higgins wrote:
> On Sat, Oct 19, 2019 at 5:56 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On Fri, 18 Oct 2019, Luis Chamberlain wrote:
> >
> > > On Thu, Oct 17, 2019 at 05:18:16PM -0700, Brendan Higgins wrote:
> > > > From: Mike Salvatore <mike.salvatore@canonical.com>
> > > >
> > > > In order to write the tests against the policy unpacking code, some
> > > > static functions needed to be exposed for testing purposes. One of the
> > > > goals of this patch is to establish a pattern for which testing these
> > > > kinds of functions should be done in the future.
> > >
> > > And you'd run into the same situation expressed elsewhere with kunit of
> > > an issue of the kunit test as built-in working but if built as a module
> > > then it would not work, given the lack of exports. Symbols namespaces
> > > should resolve this [0], and we'd be careful where a driver imports this
> > > namespace.
> > >
> > > [0] https://lwn.net/Articles/798254/
> 
> Maybe I am not understanding how the symbol namespaces work, but it
> seems that it doesn't actually solve our problem, at least not all of
> it.
> 
> First off this doesn't solve the problem for when a piece of code is
> included as a module; it also does not address the problem for symbols
> that would not normally be exported.

The suggestion is that since exporting certain symbols may not be wise,
exporting them for say a test namespace may make more sense. Then
the hacks don't need to be used for the lookup, therefore decreasing
test / complexity time. This would only make sense if there really is
no performance penalty known for having the symbol be exported.

> > WRT adding tests, I think what we're aiming at is a set of best practices
> > to advise test developers using KUnit, while attempting to minimize
> > side-effects of any changes we need to make to support testability.
> >
> > One aspect of this we probably have to consider is inlining of code. For
> > cases like this where the functions are small and are called in a small
> > number of cases, any testability changes we make may push a
> > previously-inlined function to not be inlined, with potential performance
> > side-effects for the subsystem.  In such cases, I wonder if the right
> > answer would be to suggest actually defining the functions as
> > inline in the header file? That way the compiler still gets to decide (as
> > opposed to __always_inline), and we don't perturb performance too much.
> 
> That's a really good point. Okay, so it seems that making the symbols
> public when not testing is probably not okay on its own. If we are
> going to do that, we probably need to do something like what you are
> suggesting.

If namespaces were to be used, and a consideration is that certain
symbols should not be public as otherwise there would be a real
perfomance hit, having a macro which only exports the namespace
if a build option is enabled would suffice as well. That is, a
no-op if the test feature is disabled, exported into a namespace
otherwise. But if a new build option were to be considered to help build
a different test kernel it begs the question if we just want or not a
full sweaping -fno-inline could be considered on the top level
Makefile when testing. The cost is a bloat the kernel, and it may
also produce slightly different runtimes. With a test specific
symbol namespace thing, we'd only export to a namespace those
symbols being tested.

FWIW we currently only enable -fno-inline-functions-called-once when we
have CONFIG_DEBUG_SECTION_MISMATCH enabled.

Your suggestion below with __visible_for_testing aligns with the gcc
flags I mentioned.

> With that, I think the best solution in this case will be the
> "__visible_for_testing" route. It has no overhead when testing is
> turned off (in fact it is no different in anyway when testing is
> turned off). The downsides I see are:
> 
> 1) You may not be able to test non-module code not compiled for
> testing later with the test modules that Alan is working on (But the
> only way I think that will work is by preventing the symbol from being
> inlined, right?).
> 
> 2) I think "__visible_for_testing" will be prone to abuse. Here, I
> think there are reasons why we might want to expose these symbols for
> testing, but not otherwise. Nevertheless, I think most symbols that
> should be tested should probably be made visible by default. Since you
> usually only want to test your public interfaces. I could very well
> see this getting used as a kludge that gets used far too frequently.

There are two parts to your statement on 2):

  a) possible abuse of say __visible_for_testing
  b) you typically only want to test your public interfaces

For a) I think a proper module testing namespace thing would less
likely be prone to abuse over somethingmore generic. It has the
penalty of always being enabled (unless you kconfig it to allow
you to disable it).

While I don't fully agree with b) I think for the most part it remains
true. But I'd agree more with this:

  Most functions you want to test likely don't have a performance
  criteria to be kept inline

And for those situations I think a wrapper kconfig to convert a
subsystem specific namespace call to be a nop would make sense.

  Luis

> Nevertheless, based on Alan's point, I suspect it, for this case at
> least, will likely be the least painful.
> 
> How do people feel about that?
