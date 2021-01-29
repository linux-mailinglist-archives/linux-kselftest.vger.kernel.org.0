Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FA1308C4F
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jan 2021 19:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhA2SVN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Jan 2021 13:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhA2SUt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Jan 2021 13:20:49 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A013C06174A
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Jan 2021 10:20:09 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id y17so9370163ili.12
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Jan 2021 10:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dkfy9D4szoTbkUSTq/ZhsTMr1TyIJnO6J28s6U7fg4I=;
        b=CVpTeuwdpsNzmOl9z2MSMm9h9Byz+lm1DBfCOMcC70X9z9O7pYUamk4dAzrWkVF3u1
         UKBsp03itKVjhp0MZ9Z6Ajw3phF/lARtw9HTrEPY/IdfH70rWuoSQaC0otCKrrQg66Op
         IPjtxOWLju1Gp5FQ2FSWnXwllgb5zgz/lQTWzhEa9EeNC8zDKRBG3uWf+P7v1vWRqL6A
         MIbnGzHvRRlZ85WhkSebx31G8CMyB4jjJ4oRNTCNxZ5rJoUpAHWKLKQJeHThHfuymjYX
         FG97aGnqcKYnpp8UI0ahjSEIU3b0wINhzo9Duv6QjFnJki1Kd2pIRw0LYflTi0qLzjxU
         VKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dkfy9D4szoTbkUSTq/ZhsTMr1TyIJnO6J28s6U7fg4I=;
        b=Qpzgwpc7Tedy+SlrLgd8etwe0LAbRT+5rqfogd71saYjUgBLYF2EbkBWdRkKqlzNvz
         q5tDO8/tfgQA97DNU6jquufci6VA03FzVN5ZNR3Jwamb5dUB9MUv+xZQG4MrgIay8n/c
         WpR37oQQPb5Axo/WtlORZDtTP4+4HMxuN2B1FvtKRZJpAVFLtuHZmC5xhGwNEB5K0rCK
         vlNyO59t34ljK2uS4egp+0LQTRcdwlTRkNJS9E7O6A2OFrSVzaqMHai8XBVYj13P4zpP
         cdY2WalsWTr1bbt2Ta4+m71+zRuk7zs92CIX+vYD7qa2J+nZ2gxmZQSNg1E2h6dHNbj+
         wFOA==
X-Gm-Message-State: AOAM532mHg7VW/jb8vQe8LMTZTfLY0lw0r9j1sxyzmhJAh+mvxMO6HVi
        4+5dsbOv8GhpdOZlf2W/k7yu/85UyO+aeSPFSxhuOg==
X-Google-Smtp-Source: ABdhPJzDAy5vsizjrTresNuNFBOFAvh9JU6zDvqgn75g4prU7+/UnoxvTVd3uMdvZ58odVn+Cpk1qkc1w9pZ8B7U8tg=
X-Received: by 2002:a92:510:: with SMTP id q16mr4072338ile.136.1611944408326;
 Fri, 29 Jan 2021 10:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20210129022555.2411999-1-dlatypov@google.com> <CABVgOSmaSz5jNkVTihCg3LbWg+6HGDPoQqjqNZ9_boOfUj_LkA@mail.gmail.com>
In-Reply-To: <CABVgOSmaSz5jNkVTihCg3LbWg+6HGDPoQqjqNZ9_boOfUj_LkA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 29 Jan 2021 10:19:56 -0800
Message-ID: <CAGS_qxorPoK=dyZs_SyNOv1_Z0RjJrn97A03sbyF0UmsopcdLQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: don't show `1 == 1` in failed assertion messages
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

On Thu, Jan 28, 2021 at 8:51 PM David Gow <davidgow@google.com> wrote:
>
> On Fri, Jan 29, 2021 at 10:26 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Currently, given something (fairly dystopian) like
> > > KUNIT_EXPECT_EQ(test, 2 + 2, 5)
> >
> > KUnit will prints a failure message like this.
> > >  Expected 2 + 2 == 5, but
> > >      2 + 2 == 4
> > >      5 == 5
> >
> > With this patch, the output just becomes
> > >  Expected 2 + 2 == 5, but
> > >      2 + 2 == 4
> >
> > This patch is slightly hacky, but it's quite common* to compare an
> > expression to a literal integer value, so this can make KUnit less
> > chatty in many cases. (This patch also fixes variants like
> > KUNIT_EXPECT_GT, LE, et al.).
> >
> > It also allocates an additional string briefly, but given this only
> > happens on test failures, it doesn't seem too bad a tradeoff.
> > Also, in most cases it'll realize the lengths are unequal and bail out
> > before the allocation.
> >
> > We could save the result of the formatted string to avoid wasting this
> > extra work, but it felt cleaner to leave it as-is.
> >
> > Edge case: for something silly and unrealistic like
> > > KUNIT_EXPECT_EQ(test, 4, 5);
> >
> > It'll generate this message with a trailing "but"
> > >  Expected 2 + 2 == 5, but
> > >  <next line of normal output>
>
> I assume this is supposed to say "Expected 4 == 5" here.
> (I tested it to make sure, and that's what it did here.)

Ah yes, too much copy-paste.

>
> Personally, I'd ideally like to get rid of the ", but", or even add a
> "but 4 != 5" style second line. Particularly in case the next line in
> the output might be confused for the rest of a sentence.

Given the apparent interest in other types (STR_EQ) of literal
ellision, maybe this should be done.
But I'd be tempted to have that change come later once at least the
str_eq version is in place.

>
> That being said, this is a pretty silly edge case: I'd be worried if
> we ever saw that case in an actual submitted test. People might see it
> a bit while debugging, though: particularly if they're using
> KUNIT_EXPECT_EQ(test, 1, 2) as a way of forcing a test to fail. (I've
> done this while testing tooling, for instance.)

Same/Agreed on all points.

>
> >
> > It didn't feel worth adding a check up-front to see if both sides are
> > literals to handle this better.
> >
> > *A quick grep suggests 100+ comparisons to an integer literal as the
> > right hand side.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> I tested this, and it works well: the results are definitely more
> human readable. I could see it making things slightly more complicated
> for people who wanted to automatically parse assertion errors, but
> no-one is doing that, and the extra complexity is pretty minimal
> anyway.

Hmm, machine parsing of the contents of failures is interesting.
But in general, that feels that requires a more structured format.

I hate to invoke it, but the tooling I've seen that's parsed the
"expected" and "actual" values has represented them as XML elements.

>
> One thing which might be worth doing is expanding this to
> KUNIT_EXPECT_STREQ() and/or KUNIT_EXPECT_PTR_EQ(). These have slightly
> more complicated formatting (quotes, leading 0s, etc), though.
> Comparing pointer literals is pretty unlikely to show up, though, so I
> don't think it's as important. (I thought that maybe the KASAN shadow
> memory tests might use them, but a quick look didn't reveal any.)
>

Ack. Actually, the string literal check was smaller, see below.
I debated sending a patch out for that, but this case mattered more
and I wasn't sure if it would be acceptable or not.
It felt it would be incongruous to only handle strings and not the
much more common integer case.

So if the hackier, more costly integer comparison seems fine, I might
actually go and send out the str patch that I already have sitting
around anyways.

+/* Checks if KUNIT_EXPECT_STREQ() args were string literals.
+ * Note: `text` will have ""s where as `value` will not.
+ */
+static bool is_str_literal(const char *text, const char *value)
+{
+       int len;
+
+       len = strlen(text);
+       if (len < 2) return false;
+       if (text[0] != '\"' || text[len-1] != '\"') return false;
+
+       return strncmp(text+1, value, len-2) == 0;
+}
+

This produces
[10:05:59]     Expected str == "world", but
[10:05:59]         str == hello

One misgiving I had was whether we should "fix" the string printing to
quote the values or not before adding `is_str_literal()` in.
Having just "str == hello" where neither is quoted is a bit unclear
and the extra "world == world" line sorta helped make that more clear,
ha.

David, I can send a version of this patch w/ a fixed commit message
and then tack on the str changes as children.
Would you prefer that?

> For the record, this is what STREQ()/PTR_EQ()/ failures with literals look like:
> # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:31
> Expected "abc" == "abd", but
>     "abc" == abc
>     "abd" == abd
> # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:33
> Expected 0x124 == 0x1234, but
>     0x124 == 0000000000000124
>     0x1234 == 0000000000001234

Yeah, I had considered PTR_EQ(), but it seemed more complex and also
less likely to show up.
And outside of very niche use cases (which probably don't work too on
UML, tbh...), it felt like an anti-pattern to have hard-coded pointers
in unit tests.

>
> Either way, though, this is:
>
> Tested-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
