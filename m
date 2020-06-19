Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46137200201
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 08:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgFSGjT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 02:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgFSGjS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 02:39:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8823C06174E
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jun 2020 23:39:17 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j198so8128295wmj.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jun 2020 23:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s9LRkL9lOFQgOMceMt//SUxeCbRl56x0zEYITGtl7A4=;
        b=tZpGiUzUR073XZND+f9+kJnrTehpx8NYOOCOj5GneN3exQFcaG5JtQCwJ6IS3BHwr3
         0ru97rsPnbbcbtpRqZsCoyz0fxH4wLwbmhe2F07OyBQiLtnkkviTl0+znGQB7tSR+dbw
         oQ2n3uh1FgBaxAmS7V36Dm/wDPY48GY3pJWqeREGJqmHPz9H1HgFwx1akjwEGprQpY1Q
         qgA+Qii9MzUXGdN/u7Hf7QyXte2k3weu/ktJbLRJyiu+RZHq2MStri0R+DIoLddTVsD5
         rlT3yNDyCZHCKkl9d8idATp24VA5VhWpoTbA9DYPT3UWvFTazWjRL8F4eV1ZffdQB2WS
         xgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9LRkL9lOFQgOMceMt//SUxeCbRl56x0zEYITGtl7A4=;
        b=Z8QQzOZqfP/nz91nL7b12JwBOS02DteH4gOUkjO8JyAihN8owkkV5galpIEkaR04o1
         MtV9rXRyi1doFuThsBuPCObGAZGDE2ehFVj4XLSJqfT+fdyfeizCfyqjyDgrTYqB0CeL
         U0Q6UQO4eWuEMpRO7n7Xw1CDj3AebrzU1U6AL9gYuwaddIWqmzMYkdwyy3AQgDF86DNy
         N1Aawv+R+1aoCRaDQWsXI6T79DkZfUKwT5Wk6vrVNdEIZDwjUYFGtTfBrI4rrZenyqfx
         B14gB2Dw3cRkiuI2pD7LJ5AWfeEBAXI2Tr+vwnfhZLtgzb7CsbBJZZDTVCGijkFRupoo
         FsbQ==
X-Gm-Message-State: AOAM530CRUyoXw5cuopcOl7JAJwbrOIhkWmPcoBU9PS55wrIyu9w9RUO
        o63B2woY/AXA7gtAR+f0Rv0OutgHfYgPbCuL+f9UPA==
X-Google-Smtp-Source: ABdhPJx8mIk/t2hF7jthy0vl760vKbU48V+JeaesFdisiTX9CcWK7Y1oViQsJcnvzpE+gUVffxTBS+Oe3/kAZGG2/x0=
X-Received: by 2002:a1c:750e:: with SMTP id o14mr1912845wmc.86.1592548756057;
 Thu, 18 Jun 2020 23:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200611215501.213058-1-vitor@massaru.org> <202006121403.CF8D57C@keescook>
 <CABVgOSnofuJQ_fiCL-8KdKezg3Hnqk3A+X509c4YP_toKeBVBg@mail.gmail.com>
 <202006141005.BA19A9D3@keescook> <CABVgOSkPYBL8Qy9Fsr0owNhh2=tXZmdwCsWhnq+PshJLr06YKA@mail.gmail.com>
 <alpine.LRH.2.21.2006160956170.16027@localhost> <CABVgOS=-AHNABkAVV7p=pq67hwoVcXXJSEPvxNbp90Eh_RaxBg@mail.gmail.com>
 <CAFd5g44kZe7h+qKHmx029Qj15FdqxsFRFD3TEx_iEhPEt0jJmA@mail.gmail.com>
In-Reply-To: <CAFd5g44kZe7h+qKHmx029Qj15FdqxsFRFD3TEx_iEhPEt0jJmA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 19 Jun 2020 14:39:04 +0800
Message-ID: <CABVgOSnjrzfFOMF0VE1-5Ks-e40fc0XZsNZ92jE60ZOhYmZWog@mail.gmail.com>
Subject: Re: common KUnit Kconfig and file naming (was: Re: [PATCH] lib:
 kunit_test_overflow: add KUnit test of check_*_overflow functions)
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I'm in the process of writing up some documentation for this now.

I hope to post a draft soon, but here's the overview of what's going in it:
- Test filenames should be <suite>_kunit.c
  - (If the suite name is too long/namespaced, the source filename may
have prefixes removed, so long as the module name doesn't)
- Config names should end in _KUNIT_TEST, and follow the other
existing conventions (re: help text, default values, etc)
- Suite names should be fully-qualified/unambiguous across the whole
kernel (i.e., include driver/subsystem names)
  - Possibly look at the path to the code being tested as inspiration
for the suite name.
- Use underscores as separators, and don't decorate test/suite names
with "test" or "kunit".

Still thinking about:
- Whether to formalise a "subsystem", or just have it implicitly part
of the suite name.
- Whether to talk about having multiple suites in one file and/or Kconfig entry.


On Fri, Jun 19, 2020 at 4:28 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Jun 16, 2020 at 9:21 PM David Gow <davidgow@google.com> wrote:
> >
> > On Tue, Jun 16, 2020 at 5:40 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> > >
> > > On Tue, 16 Jun 2020, David Gow wrote:
> > >
> > > > CONFIG_PM_QOS_KUNIT_TESTOn Mon, Jun 15, 2020 at 1:48 AM Kees Cook
> > > > <keescook@chromium.org> wrote:
> > > > >
> > > > > On Sat, Jun 13, 2020 at 02:51:17PM +0800, David Gow wrote:
> > > > > > Yeah, _KUNIT_TEST was what we've sort-of implicitly decided on for
> > > > > > config names, but the documentation does need to happen.
> > > > >
> > > > > That works for me. It still feels redundant, but all I really want is a
> > > > > standard name. :)
> > > > >
> > > > > > We haven't put as much thought into standardising the filenames much, though.
> > > > >
> > > > > I actually find this to be much more important because it is more
> > > > > end-user-facing (i.e. in module naming, in build logs, in scripts, on
> > > > > filesystem, etc -- CONFIG is basically only present during kernel build).
> > > > > Trying to do any sorting or greping really needs a way to find all the
> > > > > kunit pieces.
> > > > >
> > > >
> > > > Certainly this is more of an issue now we support building KUnit tests
> > > > as modules, rather than having them always be built-in.
> > > >
> > > > Having some halfway consistent config-name <-> filename <-> test suite
> > > > name could be useful down the line, too. Unfortunately, not
> > > > necessarily a 1:1 mapping, e.g.:
> > > > - CONFIG_KUNIT_TEST compiles both kunit-test.c and string-stream-test.c
> > > > - kunit-test.c has several test suites within it:
> > > > kunit-try-catch-test, kunit-resource-test & kunit-log-test.
> > > > - CONFIG_EXT4_KUNIT_TESTS currently only builds ext4-inode-test.c, but
> > > > as the plural name suggests, might build others later.
> > > > - CONFIG_SECURITY_APPARMOR_KUNIT_TEST doesn't actually have its own
> > > > source file: the test is built into policy_unpack.c
> > > > - &cetera
> > > >
> > > > Indeed, this made me quickly look up the names of suites, and there
> > > > are a few inconsistencies there:
> > > > - most have "-test" as a suffix
> > > > - some have "_test" as a suffix
> > > > - some have no suffix
> > > >
> > > > (I'm inclined to say that these don't need a suffix at all.)
> > > >
> > >
> > > A good convention for module names - which I _think_ is along the lines
> > > of what Kees is suggesting - might be something like
> > >
> > > <subsystem>[_<optional_test-area>]_kunit.ko
> > >
> > > So for example
> > >
> > > kunit_test -> test_kunit.ko
> > > string_stream_test.ko -> test_string_stream_kunit.ko
> > > kunit_example_test -> example_kunit.ko
> > > ext4_inode_test.ko -> ext4_inode_kunit.ko
> > >
> > > For the kunit selftests, "selftest_" might be a better name
> > > than "test_", as the latter might encourage people to reintroduce
> > > a redundant "test" into their module name.
> > >
> >
> > I quite like the idea of having the deeper "subsystem:suite:test"
> > hierarchy here. "selftest" possibly would be a bit confusing against
> > kselftest for the KUnit tests -- personally I'd probably go with
> > "kunit", even if that introduces a redundant-looking kunit into the
> > module name.
>
> Ditto. My first reaction was that it would create too much nesting and
> subsystems are a poorly defined notion in the Linux kernel; however,
> after thinking about it some, I think we are already doing what you
> are proposing with namespacing in identifier names. It makes sense to
> reflect that in test organization and reporting.
>

The real trick for documenting this is, as you say, defining
subsystem. I suspect we'll be okay leaving this up to common sense,
and perhaps suggesting the MAINTAINERS entry or file path as places to
pull subsystem names from. Having the subsystem be the name of the
module being tested for drivers, for example, makes some sense, too.

> > So, this could look something like:
> > - Kconfig name: CONFIG_<subsystem>_<suite>_KUNIT_TEST, or very
> > possibly CONFIG_<subsystem>_KUNIT_TEST(S?) -- we already have
> > something like that for the ext4 tests.
>
> I think the biggest question there is whether we go with the every
> suite gets its own config approach or all suites in a subsystem are
> turned on by a single config. I don't think there are enough examples
> to determine what the community would prefer, and I can see advantages
> and disadvantages to both.

Yeah: it's really difficult to tell what makes more sense when most
subsystems will start off with just one suite. I had been favouring
the config-per-suite approach, but I can definitely see that getting
really cluttered. Maybe the right thing is to permit both?

> > - Source filename: <suite>_kunit.c within a subsystem directory. (We
> > probably don't need to enforce suites being in separate files, but
> > whatever file does contain the tests should at least end "kunit.c")
>
> I am cool with changing *-test.c to *-kunit.c. The *-test.c was a hold
> over from when everything was prefixed TEST_* instead of KUNIT_* (back
> in the early days of the RFC). I never liked naming everything KUNIT_*
> or -kunit- whatever; it felt kind of egotistical to me (there was also
> always a part of me that hoped I would come up with a better name than
> KUnit, but that ship sailed a long time ago). However, purely
> logically speaking, I think naming all KUnit tests *-kunit.c makes
> more sense than anything else.

Let's go with _kunit.c as a suffix, then.

> One question: the AppArmor KUnit tests are #included into another .c
> file when the tests are selected. Should tests #included in this
> manner be -kunit.h or should all tests be -kunit.c?

I don't think this matters as much -- such tests can't be built as
modules. I'd lean slightly towards it being _kunit.c, if only because
it's a simpler rule, and the current AppArmor tests are in a .c file
anyway. I think we do want to explicitly call out that this is
something to be avoided if possible, anyway.

> > - Module filename: <subsystem>_<suite>_kunit.ko, or
> > <subsystem>_kunit.ko if all suites are built into the same module (or
> > there's just one suite for the whole subsystem)
> > - Suite name: Either <subsystem>_<suite> or have a separate subsystem
> > field in kunit_suite. If there's only one suite for the subsystem, set
> > suite==subsystem
>
> No strong feelings here.
>
> > - Test names: Personally, I'd kind-of like to not prefix these at all,
> > as they're already part of the suite. If we do want to, though, prefix
> > them with <subsystem> and <suite>.
>
> Eh, I did that to remain consistent with the kernel naming
> conventions, but I think those have diverged too. If maintainers are
> cool with it, I agree that the prefixes are redundant on tests and
> generally way too long.
>

Do you have a link to the conventions you're talking about?

> > > > Within test suites, we're also largely prefixing all of the tests with
> > > > a suite name (even if it's not actually the specified suite name). For
> > > > example, CONFIG_PM_QOS_KUNIT_TEST builds
> > > > drivers/base/power/qos-test.c which contains a suite called
> > > > "qos-kunit-test", with tests prefixed "freq_qos_test_". Some of this
> > > > clearly comes down to wanting to namespace things a bit more
> > > > ("qos-test" as a name could refer to a few things, I imagine), but
> > > > specifying how to do so consistently could help.
> > > >
> > >
> > > Could we add some definitions to help standardize this?
> > > For example, adding a "subsystem" field to "struct kunit_suite"?
> > >
> > > So for the ext4 tests the "subsystem" would be "ext4" and the
> > > name "inode" would specify the test area within that subsystem.
> > > For the KUnit selftests, the subsystem would be "test"/"selftest".
> > > Logging could utilize the subsystem definition to allow test
> > > writers to use less redundant test names too.  For example
> > > the suite name logged could be constructed from the
> > > subsystem + area values associated with the kunit_suite,
> > > and individual test names could be shown as the
> > > suite area + test_name.
> >
> > As above, I quite like this. If we were really brave, we could
> > actually nest the results into subsystem:area/suite:test using the TAP
> > subtests stuff. Generating the longer suite name may be easier on
> > people manually reading large test logs, though, as they wouldn't have
> > to scroll quite as far to determine what subsystem they're in. (Again,
> > something that could be solved with tooling, and probably less of a
> > problem for people accessing results through debugfs.)
>
> SGTM

Cheers,
-- David
