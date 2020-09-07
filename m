Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155BB25F5C4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Sep 2020 10:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgIGI5M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Sep 2020 04:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgIGI5L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Sep 2020 04:57:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02953C061573
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Sep 2020 01:57:11 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q9so13595531wmj.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Sep 2020 01:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Yl9hPW8Oci7ALl4vX8u8AUkDDmAA1DXOMq94Yc3e+E=;
        b=sLjNZsZ9pVZFtfzH9TOmoRPxwqyh0H8Lftc9PoCx20A+dD+EhuV+c81AEkVHI2WeTg
         NbWu6HW5nwkllDPvUn5cgX/dIjBUyFAKwhwWxEtoAAa2JH+O8DBAtFhxdXiILhWbkbvf
         M5HqJmebzEehUkk2g8V2tuZ8AoNSgsqeECzXyuFb2+fbSe8ezt9wyO8dpr0RMmOO6mHQ
         sIAHFBz7k2xvBjqH91w2r16uxZCKQk2wqsowKrIeOUFzzxCr+YHzyj5fJJgvuqXNGOFi
         BrBEYVbNQ/9G8EvxfO07HFOpSwAfQP2JbsIRRBw59a3abecJmTmbLdsomy8NAHFYN3FW
         kEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Yl9hPW8Oci7ALl4vX8u8AUkDDmAA1DXOMq94Yc3e+E=;
        b=ll3KlNODyUQ9XqaqqXkwq1dgr9yuKXvgGAyjDAfIEcRv71hYwop7BRaMIMUCylMXaG
         SmzOp11iV5BUdv3cy4tqEILkKv/xbz0upbB8pX0aY3QsUBRfa4Ce7XsQJpmRY9DYpwXd
         FYdPHJm8sOKxF4ATI1dNETLm71NevIz9fnCdAwGX/xKySGRHebOwprHOIOkRMuPJBWK1
         mIp5U8I6O+tFHkc3aZwy6b5tECPkvO91Dxjcwb2GNxiDg7g5/DfjNTC4vysCdBMVzKeP
         eQ52yjvcs2jHdmitMQX/lcMemRByIzsgPyrEAjSJpqDY448U/y7T7j+8sJcQrWbQpt/E
         pJng==
X-Gm-Message-State: AOAM533mUNdpKevdIMk8MUDImaqxPlbtMOsaePn6WXAHjmaVsaMAgxUe
        ddsl6TIIanmZRlMy4SSrkMIFUg==
X-Google-Smtp-Source: ABdhPJzIue43NhDfaHuhI9lR8skmhnAYsAZcWz4xpXJkoa8MKLYng2NLBIPgkdkdWvvHbj6LAfOb0Q==
X-Received: by 2002:a1c:2781:: with SMTP id n123mr19471333wmn.27.1599469029372;
        Mon, 07 Sep 2020 01:57:09 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id q20sm24926205wmj.5.2020.09.07.01.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 01:57:08 -0700 (PDT)
Date:   Mon, 7 Sep 2020 10:57:03 +0200
From:   Marco Elver <elver@google.com>
To:     David Gow <davidgow@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Tim Bird <Tim.Bird@sony.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: kunit: Add naming guidelines
Message-ID: <20200907085703.GA1653285@elver.google.com>
References: <20200702071416.1780522-1-davidgow@google.com>
 <20200827131438.GA3597431@elver.google.com>
 <CABVgOSmoiFh5i8Ue14MtCLwq-LbGgQ1hf4MyRYLFWFQrkushjQ@mail.gmail.com>
 <202008311641.D10607D43@keescook>
 <CABVgOSmF93YVD=scGL5p0tjnm0XUwC2n8LPT9xFqGje9zXQ96Q@mail.gmail.com>
 <CANpmjNP9OD0ZULQbZKv2HtVyO4Nho46uu4h9gNO8i-XhOMzHVw@mail.gmail.com>
 <CABVgOSmvcToydrGzPGdTkRkKq62Gh4vtc+ZazGMfnsXw0FdRWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSmvcToydrGzPGdTkRkKq62Gh4vtc+ZazGMfnsXw0FdRWQ@mail.gmail.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 04, 2020 at 12:22PM +0800, David Gow wrote:
[...]
> 
> This is a good point -- renaming files is definitely a pain. It's
> obviously my hope that KUnit sticks around long enough that it's not
> being added/removed as a dependency too often, particularly for the
> unit tests, so "_kunit" as a name doesn't worry me that much
> otherwise.

Make sense. And I do also hope that once a test is a KUnit test, there
is no need to change it. :-)

[...]
> I'm not personally convinced that "kunit" isn't something people could
> associate with tests, particularly as it becomes more popular, but if
> people really dislike it, we could have"_unittest.c" or similar.
> There's a balancing act between being generic (and not distinguishing
> between unit/integration/etc tests) and being consistent or avoiding
> renames. Take the case where there's a set of unit tests in a
> "-test.c" file, and an integration test is written as well: it
> probably should go in a speparate file, so now you'd either have a
> "-test.c" and a separate "-integration-test.c" (or the other way
> around if the integration test was written first), or the "-test.c"
> file would be renamed.

Makes sense, too. Yeah, if we have both we'd need to distinguish one way
or another. What might be particularly annoying is the case if an
integration test exists first, and it had been named "_kunit.c",
followed by addition of a unit test. I think the only sane thing at that
point would be to do a rename of the integration test; whereas if it had
been named "_test.c", I could live with there simply being a
"_unit_test.c" (or similar) file for the new unit test.

[...]
> > 1. Clear, intuitive, descriptive filenames ("[...] something that says
> > more strongly that this is a test [...]").
> >
> > 2. Avoid renames if any of the following changes: test framework, test
> > type or scope. I worry the most about this point, because it affects
> > our workflows. We need to avoid unnecessary patch conflicts, keep
> > cherry-picks simple, etc.
> >
> > 3. Strive for consistently named tests, regardless of type (because
> > it's hard to get right).
> >
> > 4. Want to distinguish KUnit tests from non-KUnit tests. (Also
> > consider that tooling can assist with this.)
> >
> 
> I think that these are somewhat in conflict with each other, which is
> what makes this complicated. Particularly, it's going to be difficult
> to both avoid renames if the test framework changes and to distinguish
> between KUnit and non-KUnit tests by filename.
> 
> I personally think that of these requirements, 2 is probably the one
> that would cause people the most real-world pain. I'm not sure how
> often test type or scope changes enough to be worth the rename, and I
> hope KUnit survives long enough and is useful enough that test
> framework changes are kept to a minimum, but this has already
> irritated enough people porting tests to KUnit to be a noticeable
> issue. One possibility is to focus on module names, which are probably
> more important and can be renamed without changing the filename,
> though that's pretty ugly.
> 
> I actually think "_kunit.c" probably is descriptive/intuitive enough
> to meet (1) -- or at least will be once KUnit is more widely used --
> but it does conflict a bit with 2.
> 
> It'd be nice to have consistently named tests, but we're not there at
> the moment, so fixing it will require a lot of renaming things. It's
> looking increasingly unlikely that we'll be able to do that for
> everything, so making this a recommendation for new test suites is
> probably the best we're likely to get.
> 
> > These are the 2 options under closer consideration:
> >
> > A. Original choice of "*-test.c": Satisfies 1,2,3. It seems to fail 4,
> > per Kees's original concern.
> >
> 
> Kees also brings up that using hyphens instead of underscores causes
> some inconsistency with module names, which is a bit of a pain.
> 
> > B. "*_kunit.c": Satisfies 4, maybe 3.
> >   - Fails 1, because !strstr("_kunit.c", "test") and the resulting
> > indirection. It hints at "unit test", but this may be a problem for
> > (2).
> >   - Fails 2, because if the test for some reason decides to stop using
> > KUnit (or a unit test morphs into an integration test), the file needs
> > to be renamed.
> >
> > And based on all this, why not:
> >
> > C. "*-ktest.c" (or "*_ktest.c"):
> >   - Satisfies 1, because it's descriptive and clearly says it's a
> > test; the 'k' can suggest it's an "[in-]kernel test" vs. some other
> > hybrid test that requires a userspace component.
> >   - Satisfies 2, because neither test framework or test type need to
> > be encoded in the filename.
> >   - Satisfies 3, because every test (that wants to use KUnit) can just
> > use this without thinking too much about it.
> >   - Satisfies 4, because "git grep -- '[-_]ktest\.[co]'" returns nothing.
> >
> 
> My concern with this is that we're introducing new jargon either way:
> does having "test" in the name outweigh the potential confusion from
> having "ktest" be in the filename only for "KUnit tests". So my
> feeling is that this would've been really useful if we'd named KUnit
> KTest (which, ironically, I think Brendan had considered) instead, but
> as-is is probably more confusing.

Make sense, too.

> At the risk of just chickening out at calling this "too hard", I'm
> leaning towards a variant of (A) here, and going for _test, but making
> it a weaker recommendation:
> - Specifying that the module name should end in _test, rather than the
> source filename. Module names are easier to change without causing
> merge conflicts (though they're a pain to change for the user).
> - Only applies to new test suites, and another suffix may be used if
> it conflicts with an existing non-kunit test (if it conflicts with a
> kunit test, they should be disambiguated in the suite name).
> - Test types (unit, integration, some subsystem-specific thing, etc)
> may be disambiguated in the suite name, at the discretion of the test
> author. (e.g., "driver_integration" as a suite name, with
> "driver_integration_test" as the module name, and either
> "driver_integration_test.c" or "integration_test.c" as recommended
> test filenames, depending on if "driver" is in its own directory.)
> 
> This should satisfy 1 & 2, and go some way towards satisfying 3. We
> can try to come up with some other technical solution to 4 if we need
> to.
> 
> Unless the objections are particularly earth-shattering, I'll do a new
> version of the patch that matches this next week. The other option is
> to drop the filename stuff from the document altogether, and sort it
> out in another patch, so we at least get some of the consistency in
> suite and Kconfig names.

Thanks for the detailed answer. Your plan sounds good to me. I'm fine
either way, as long as requirement (2) is somehow addressed, and we do
not end up with unnecessary renames.

Thanks,
-- Marco
