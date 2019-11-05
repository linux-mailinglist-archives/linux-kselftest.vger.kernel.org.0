Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 519A7F0A59
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2019 00:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfKEXon (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Nov 2019 18:44:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38364 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfKEXok (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Nov 2019 18:44:40 -0500
Received: by mail-pl1-f195.google.com with SMTP id w8so10488496plq.5
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Nov 2019 15:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Um9/qfCrgZQ1WrP8N3q635iXaQT9L9NZqcD9xzyqjhM=;
        b=m00rGWWyIBgUYfI0QN893mlVLSmeXOwzg7GcqkNFGQQZos7nfhjD+GJyP5XiGGvtfe
         jndgqjdkc8Qnbcp0cwruho0cEPYZ/2v+G5j7kC9ctfuh0rvGyynZVF49Fs42BvbGVuq3
         8tv+uhlF+yYWzMdnXTQIRmcwfTqXEoKJJPIu0hbQwOuj7VCLslthywlJT56/VzfsAaEr
         Sp5b2usbNudPlZ9FwnogiNaWQx21Ao+nNY6rA7jlrfkAcE/vORzVG9BbBMjZtPmNVAfg
         cvawCcLWuH99pXRuuD7Wlf+LvpZDOjabTvsjfcjYOwfM226DYIVsvTPTabKQCy7ZheDd
         JfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Um9/qfCrgZQ1WrP8N3q635iXaQT9L9NZqcD9xzyqjhM=;
        b=XDJDdArw/LE9R8D53l6/gI0riu/5KUBjV1mBNAd+8uT/3qJlwRzH8yBOzcGRdYVG52
         gvOVdi4tKAcOqFHJPJULHEvfd4Aqum5f1MRgS6Bqe4oPmU9+HfYt3JDaSHw0QdW1YIST
         7A07NL9FRoLoZtCqRMQ6GO7Rj8uHvKCX0vuxuSO/kSRbmWlWKmIOgNFrVUWhdWhQZ/Ii
         wiAi3EztBlYBQ+vBkhiVZtRrF2WQ6KR8DE4pZhdpcEQkq0yqC8AKuGb3a28obxc0vwjh
         vZ1kuDkJuQepE0Zt1VSFm6oaJGAXr4pbu0bRL5C+9NZa3pWVy8I1KOYjkSVBUptuAJhw
         3K5g==
X-Gm-Message-State: APjAAAUsDJVb06ZAfPg9q685+zEk88k8qci5I0k00ZH9wMolS2v1DZI/
        Qn0o0qEKa6V7PtTvz1p+2IzeaibdcV3PJXZVpZmqHA==
X-Google-Smtp-Source: APXvYqzCFV7KRMTLsbE7bEb+T05qapNLIwRw+TgsIRHszTdTe9Vcmq+K/1l3DcTczC5gtBYOrrlyzWqtn8ldUatIhnY=
X-Received: by 2002:a17:902:b685:: with SMTP id c5mr34580955pls.297.1572997478784;
 Tue, 05 Nov 2019 15:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018122949.GD11244@42.do-not-panic.com> <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com>
 <CAFd5g46aO4jwyo32DSz4L8GdhP6t38+Qb9NB+3fev3u4G6sg4w@mail.gmail.com>
 <20191024101529.GK11244@42.do-not-panic.com> <201910301205.74EC2A226D@keescook>
 <CAFd5g45V-iYaAhHwoaUPoPYUBud-5vxbBkApp-h5O6J8trnPRA@mail.gmail.com> <alpine.LRH.2.20.1911011142160.15982@dhcp-10-175-177-231.vpn.oracle.com>
In-Reply-To: <alpine.LRH.2.20.1911011142160.15982@dhcp-10-175-177-231.vpn.oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 5 Nov 2019 15:44:27 -0800
Message-ID: <CAFd5g44C4y=M3goRgaXeOzh=T=+y03Natfyut+ojrKOf+4HSWw@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
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

On Fri, Nov 1, 2019 at 5:30 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Thu, 31 Oct 2019, Brendan Higgins wrote:
>
> > On Wed, Oct 30, 2019 at 12:09 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Thu, Oct 24, 2019 at 10:15:29AM +0000, Luis Chamberlain wrote:
> > > > On Wed, Oct 23, 2019 at 05:42:18PM -0700, Brendan Higgins wrote:
> > > > > With that, I think the best solution in this case will be the
> > > > > "__visible_for_testing" route. It has no overhead when testing is
> > > > > turned off (in fact it is no different in anyway when testing is
> > > > > turned off). The downsides I see are:
> > > > >
> > > > > 1) You may not be able to test non-module code not compiled for
> > > > > testing later with the test modules that Alan is working on (But the
> > > > > only way I think that will work is by preventing the symbol from being
> > > > > inlined, right?).
> > > > >
> > > > > 2) I think "__visible_for_testing" will be prone to abuse. Here, I
> > > > > think there are reasons why we might want to expose these symbols for
> > > > > testing, but not otherwise. Nevertheless, I think most symbols that
> > > > > should be tested should probably be made visible by default. Since you
> > > > > usually only want to test your public interfaces. I could very well
> > > > > see this getting used as a kludge that gets used far too frequently.
> > > >
> > > > There are two parts to your statement on 2):
> > > >
> > > >   a) possible abuse of say __visible_for_testing
> > >
> > > I really don't like the idea of littering the kernel with these. It'll
> >
> > Yeah, I kind of hope that it would make people think more
> > intentionally about what is a public interface so that they wouldn't
> > litter the kernel with those. But I agree that in the world where
> > people *didn't* do that. Lots of these sprinkled around would be
> > annoying.
> >
> > > also require chunks in header files wrapped in #ifdefs. This is really
> >
> > Why would it require header files wrapped in #ifdefs?
> >
> > We could put all the ifdeffery logic in the __visible_for_testing
> > macro so that nothing in the original code has to change except for
> > adding an #include and replacing a couple of `static`s with
> > `__visible_for_testing`.
> >
>
> FWIW I think this approach, if used sparingly, is fine.  However I'd
> propose a hierarchy of options when looking to expose interfaces for
> testing.
>
> 1. For small, largely self-contained functions, move their definitions
> from .c files to a .h file where those functions are defined as "static
> inline".  That way the original code and tests can included them and we
> have solved function availability for both the cases where the tests are
> built-in and compiled as a module.  The apparmor interfaces here seem to
> be candidates for that approach.
>
> 2. For more complex cases, __visible_for_testing (for built-in visbility)
> and some sort of equivalent EXPORT_FOR_TESTING (for module
> visibility) would work, or the kunit_find_symbol() based lookup approach I
> suggested in the module patches.  Either of these allows for building
> tests as modules or builtin.
>
> 3. For some cases, module support will probably be impossible or difficult
> to maintain.  In such cases, builtin tests make most sense so any
> questions about symbol visibility would largely concern changing static
> definitions to be __visibile_for_testing, with no need for any symbol
> export for module visibility.

Very well said, I think this sums up a lot of good points. Basically,
I think you illustrate that it's not just one of the ways that were
proposed is the most appropriate for all cases, but really several are
valid strategies in different instances.

> > > ugly.
> > >
> > > >   b) you typically only want to test your public interfaces
> > >
> > > True, but being able to test the little helper functions is a nice
> > > starting point and a good building block.
> >
> > Yeah, I think I have come to accept that. We can argue about how this
> > should change and how people need to learn to be more intentional
> > about which interfaces are public and many other high minded ideas,
> > but when it comes down to it, we need to provide a starting point that
> > is easy.
> >
> > If our nice starting point becomes a problem, we can always improve it later.
> >
> > > Why can't unit tests live with the code they're testing? They're already
> > > logically tied together; what's the harm there? This needn't be the case
> > > for ALL tests, etc. The test driver could still live externally. The
> > > test in the other .c would just have exported functions... ?
> >
> > Well, for one, it totally tanks certain cases for building KUnit tests
> > as modules. I don't care about this point *too* much personally, but I
> > accept that there are others that want this, and I don't want to make
> > these people's lives too difficult.
> >
>
> Appreciated.  I think at this point it might be useful to lay out my
> thinking on why being able to build tests as modules may be helpful moving
> forward.
>
> - First and foremost, if the functionality itself is predominantly
> delivered in module form, or indeed is simply tristate, having a way to
> test kernel code when built as a module seems to me to be necessary. To
> test module code with built-in test code seems broken, and even if it
> could be made to work we'd end up having to invent a bunch of the mechanisms
> we'd need for building tests as modules anyway.

I think that is a fair point. I think I was thinking of it as an all
or nothing type thing. I know that we had moved past it in words, but
I think I was still hung up on the idea that we were going to try to
aggressively make tests buildable as modules. Here, and combined with
what Mike said (in a later email), I think I realized that a better
metric is what the code under test does.

It's probably not a big deal to make *everything* available as a
module. The right thing is probably that, if the code is available as
a module, the test should probably be available as a module. If the
code is not available as a module, it is not necessary to provide the
test as a module.

But that and what Mike said, I think, gets at something deeper. Each
subsystem has its own way of doing things, and that is a reality we
have to deal with. As long as there is some way to "run all the tests"
what conventions we enforce at the outset may not really be all that
important. Sure, some amount of consistency is important, but what is
more important is that we make something that is easy to use. We can
always go back and clean things up later.

After writing this, it sounds kind of obvious and like things that
people have said already; nevertheless, I think it is still worthwhile
to say, if nothing else to show that I think we are all on the same
page.

So yeah, I think that optionally including tests in the code under
test is fine (if that is what works best for the developer), I think
that __visible_for_testing is fine if that's what works best, and
testing through public interfaces is also fine. We might want to
gently push people in one direction or another over time, but all seem
like things that are reasonable to support now. In this case, since
people seem to be more in favor of including tests in source, that's
probably the right thing to do here.

I will make the __visible_for_testing thing available in a separate
patch at some point. Someone can pick it up if they want to use it.

> - Running tests on demand.  From previous discussions, I think this is
> wanted for kselftest, and if we have a set of modules with a conventional
> prefix (e.g. kunit-*), running tests becomes simply a "find + modprobe" in
> the kernel module tree.  Results could be harvested from debugfs (I have a
> WIP patch to store logging data in the per-test data structures such that
> "cat /sys/kernel/debug/kunit-results/kunit-foo" will display results for
> that test suite).  There are other ways to achieve this goal, and it's
> a crude method without any test selection beyond which modules are
> loaded, but this path is noticeably shorter to having a simple way to
> execute tests in a kselftest-friendly way I think.

Yep, I think we are all in agreement here. Shuah, Knut, and myself all
agreed at LPC that running tests on demand via kselftest was a
worthwhile goal. I am not strongly opposed to the common prefix idea.
I think that is something we might want to run past Linus though, as
he has not been a fan of certain file prefixes that he considers to
convey redundant information.

> - Developing tests. I've also found this model to be neat for test
> development; add a test, build, load the module to test the test, add
> another test, build, unload/load etc.

Not really sure what you mean here. I suspect that I probably won't
agree, as I have found that rebuilding the kernel for every test is
not overly burdensome. Nevertheless, I also don't see any reason to
oppose you here. If some developer likes that model (even if I don't),
it is best to support it if possible, as we should ideally make things
easier for every development flow.

> - The late_initcall() initialization of tests may not always be appropriate
> for subsystems under test, and as the number of tests grow (a good
> problem to have!), it will likely become infeasible.

Agreed. I just went with it for now because it was easy and
uncontroversial. I already have some WIP patches to get rid of it (I
am not sure how that will affect what you are doing, but I suspect
your module patches will be done first - since they already look close
- so I will probably try to figure that out after your module patches
get merged).

> Anyway I'm not sure if any of the above resonates with others as being
> useful, but hopefully it clarifies why module support might matter moving
> forward.

I definitely agree with the point about supporting building tests as
modules if the code under test builds as modules, especially if the
developers want it. So yes, it does resonate with me! :-)

> If it makes sense, I can look at tweaking the module patchset to remove
> the kunit_find_symbol() stuff so that we can punt on specific mechanisms
> for now; my main aim at this point is to ensure we're thinking about
> providing mechanisms for testing modules.

Yeah, I started looking at the latest version of your patches (sorry
for the late follow up), and yeah, I think it probably makes sense to
split that out into a separate patch/patchset.

Thanks for the comments! They really helped clear some things up for me!
