Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6F31FC504
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 06:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgFQEVC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jun 2020 00:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgFQEVC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jun 2020 00:21:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D312AC061573
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 21:21:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l10so754701wrr.10
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 21:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTfy5ZLyuJT0yC8McsN2BR/ssAXBpdtQpUx9FOK3zbk=;
        b=trYmk0NGqDbCC4+0yisOAMU2pUJhbmgPqz+08MzhL27FdwrZo5x8CC4LEpCfuYb/Zr
         s1QKUQ36/lFT54YeSj4wMO2z03xG7ZHUyULrLv/itHLmSJrxFSEhFzNxmLIDV3tA1gnK
         YAPUnmYpzNlEn1MNyIFPBRyY/DJQ8pPbeVuwcVP/tmWe4gav31Bs+27G+UlUAw8/YJ/5
         yTKh7XhbkytVPeIHwAX3HLHug9KZVFvVYeTpepaKrD1CyXC5RiXl6v+c5PUH6BO9zDaP
         GYJcs6px4Qrqv0P91Xbb+OkXoYyebl7f4EBsdAVNN8Tn4TXMxoaN1C0iiWjPseR0JNzw
         /irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTfy5ZLyuJT0yC8McsN2BR/ssAXBpdtQpUx9FOK3zbk=;
        b=aClbbRIoAcprnidBlY/RN0s/tGMA0u0/PrlEzfHoO0CM9kqGSsxWXunLW8qLT1WCgk
         gTX1OGJms0wBv0dqAAchn91QHp/iXCqpBGowPoLdq3tu//9oadB47IgzkzhX0fjUuImL
         VemxNXMQ4vV+BsXRr/xa/zf9FBq5OLOgvDaMTS8iBGftLAbVurSyAPR0R9lGMg1jhwT0
         WmMrBG0odXJJvr5ZXrAhM0EZ3NUjYbU9uenGUqA9AtQ72NsXI6LzF2ZOTxBaoPD6RDMW
         fgm9gVFQLF5GT722lJqxfoLak4SyjZpLEQOF3rqDWy1fdIjmLsaRkhWtMtdjvrXPV2h4
         rCZw==
X-Gm-Message-State: AOAM5336D0cQXUz4/X65y0eBe6y/4Errp0oGUEn1eZCOY+i80XL9CvjY
        OHNkaHX1QD9UEPdg1PHYzvPf4KqzAbgx8/keQ/kcjg==
X-Google-Smtp-Source: ABdhPJxJ1NKDw0A/Mr5gdEzqzF5vb61QgpH/v8tCiZA1rOlUaXZVgnusiMMA71lTFJNM8LFxei18qdWr+22zs53LCG8=
X-Received: by 2002:a5d:69ca:: with SMTP id s10mr6465150wrw.203.1592367660051;
 Tue, 16 Jun 2020 21:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200611215501.213058-1-vitor@massaru.org> <202006121403.CF8D57C@keescook>
 <CABVgOSnofuJQ_fiCL-8KdKezg3Hnqk3A+X509c4YP_toKeBVBg@mail.gmail.com>
 <202006141005.BA19A9D3@keescook> <CABVgOSkPYBL8Qy9Fsr0owNhh2=tXZmdwCsWhnq+PshJLr06YKA@mail.gmail.com>
 <alpine.LRH.2.21.2006160956170.16027@localhost>
In-Reply-To: <alpine.LRH.2.21.2006160956170.16027@localhost>
From:   David Gow <davidgow@google.com>
Date:   Wed, 17 Jun 2020 12:20:48 +0800
Message-ID: <CABVgOS=-AHNABkAVV7p=pq67hwoVcXXJSEPvxNbp90Eh_RaxBg@mail.gmail.com>
Subject: Re: common KUnit Kconfig and file naming (was: Re: [PATCH] lib:
 kunit_test_overflow: add KUnit test of check_*_overflow functions)
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 16, 2020 at 5:40 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Tue, 16 Jun 2020, David Gow wrote:
>
> > CONFIG_PM_QOS_KUNIT_TESTOn Mon, Jun 15, 2020 at 1:48 AM Kees Cook
> > <keescook@chromium.org> wrote:
> > >
> > > On Sat, Jun 13, 2020 at 02:51:17PM +0800, David Gow wrote:
> > > > Yeah, _KUNIT_TEST was what we've sort-of implicitly decided on for
> > > > config names, but the documentation does need to happen.
> > >
> > > That works for me. It still feels redundant, but all I really want is a
> > > standard name. :)
> > >
> > > > We haven't put as much thought into standardising the filenames much, though.
> > >
> > > I actually find this to be much more important because it is more
> > > end-user-facing (i.e. in module naming, in build logs, in scripts, on
> > > filesystem, etc -- CONFIG is basically only present during kernel build).
> > > Trying to do any sorting or greping really needs a way to find all the
> > > kunit pieces.
> > >
> >
> > Certainly this is more of an issue now we support building KUnit tests
> > as modules, rather than having them always be built-in.
> >
> > Having some halfway consistent config-name <-> filename <-> test suite
> > name could be useful down the line, too. Unfortunately, not
> > necessarily a 1:1 mapping, e.g.:
> > - CONFIG_KUNIT_TEST compiles both kunit-test.c and string-stream-test.c
> > - kunit-test.c has several test suites within it:
> > kunit-try-catch-test, kunit-resource-test & kunit-log-test.
> > - CONFIG_EXT4_KUNIT_TESTS currently only builds ext4-inode-test.c, but
> > as the plural name suggests, might build others later.
> > - CONFIG_SECURITY_APPARMOR_KUNIT_TEST doesn't actually have its own
> > source file: the test is built into policy_unpack.c
> > - &cetera
> >
> > Indeed, this made me quickly look up the names of suites, and there
> > are a few inconsistencies there:
> > - most have "-test" as a suffix
> > - some have "_test" as a suffix
> > - some have no suffix
> >
> > (I'm inclined to say that these don't need a suffix at all.)
> >
>
> A good convention for module names - which I _think_ is along the lines
> of what Kees is suggesting - might be something like
>
> <subsystem>[_<optional_test-area>]_kunit.ko
>
> So for example
>
> kunit_test -> test_kunit.ko
> string_stream_test.ko -> test_string_stream_kunit.ko
> kunit_example_test -> example_kunit.ko
> ext4_inode_test.ko -> ext4_inode_kunit.ko
>
> For the kunit selftests, "selftest_" might be a better name
> than "test_", as the latter might encourage people to reintroduce
> a redundant "test" into their module name.
>

I quite like the idea of having the deeper "subsystem:suite:test"
hierarchy here. "selftest" possibly would be a bit confusing against
kselftest for the KUnit tests -- personally I'd probably go with
"kunit", even if that introduces a redundant-looking kunit into the
module name.

So, this could look something like:
- Kconfig name: CONFIG_<subsystem>_<suite>_KUNIT_TEST, or very
possibly CONFIG_<subsystem>_KUNIT_TEST(S?) -- we already have
something like that for the ext4 tests.
- Source filename: <suite>_kunit.c within a subsystem directory. (We
probably don't need to enforce suites being in separate files, but
whatever file does contain the tests should at least end "kunit.c")
- Module filename: <subsystem>_<suite>_kunit.ko, or
<subsystem>_kunit.ko if all suites are built into the same module (or
there's just one suite for the whole subsystem)
- Suite name: Either <subsystem>_<suite> or have a separate subsystem
field in kunit_suite. If there's only one suite for the subsystem, set
suite==subsystem
- Test names: Personally, I'd kind-of like to not prefix these at all,
as they're already part of the suite. If we do want to, though, prefix
them with <subsystem> and <suite>.

> > Within test suites, we're also largely prefixing all of the tests with
> > a suite name (even if it's not actually the specified suite name). For
> > example, CONFIG_PM_QOS_KUNIT_TEST builds
> > drivers/base/power/qos-test.c which contains a suite called
> > "qos-kunit-test", with tests prefixed "freq_qos_test_". Some of this
> > clearly comes down to wanting to namespace things a bit more
> > ("qos-test" as a name could refer to a few things, I imagine), but
> > specifying how to do so consistently could help.
> >
>
> Could we add some definitions to help standardize this?
> For example, adding a "subsystem" field to "struct kunit_suite"?
>
> So for the ext4 tests the "subsystem" would be "ext4" and the
> name "inode" would specify the test area within that subsystem.
> For the KUnit selftests, the subsystem would be "test"/"selftest".
> Logging could utilize the subsystem definition to allow test
> writers to use less redundant test names too.  For example
> the suite name logged could be constructed from the
> subsystem + area values associated with the kunit_suite,
> and individual test names could be shown as the
> suite area + test_name.

As above, I quite like this. If we were really brave, we could
actually nest the results into subsystem:area/suite:test using the TAP
subtests stuff. Generating the longer suite name may be easier on
people manually reading large test logs, though, as they wouldn't have
to scroll quite as far to determine what subsystem they're in. (Again,
something that could be solved with tooling, and probably less of a
problem for people accessing results through debugfs.)

Cheers,
-- David
