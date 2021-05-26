Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13E1391F3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 20:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhEZSh3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 14:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhEZSh3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 14:37:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6B5C061756
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 11:35:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so1068531wmh.4
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 11:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vuU9uxld5nybVEuq54B8tCkV+pAQVJ8LqfwpbN9ssnI=;
        b=heAyaGdCvp3mMqZB2Kc8WJb2O2x5cbxLKQHEn+vo/nEIIgV2DsObPDSo7ammdypyhI
         zXRogNNmo/YXBrctMUND1xiaaTrZKTamN+xrenzv30uNYWFsdWK2p0ARL64k4JDYY0YV
         fJg+Z1IyF7RmqvvgCperjmWFzxc66+HJ5fBaAwV1CQVfm+0bX9WmgKD+mGSbfdmT0E/v
         WV2w4eHShBFneFwCwjxaFL+ELVrytLh0S9QCDnTNoeH9cJ0nhiNh7QCU4e91Iq2UCmZg
         YQDYH+ImchezeFeBknlmzbzVgbqfMNugLvp2RwQ2TQQRKwidQTzX6ylyVmIpgWkv3VtH
         3ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vuU9uxld5nybVEuq54B8tCkV+pAQVJ8LqfwpbN9ssnI=;
        b=jZbZ7SiaMDw1bmcLmzc5qJjyKe21qJCkoO291QYekq+NR2kbt6ffXABNCU5V2PKcPH
         zC5+TYqFcNoWjEDQYu0QH+yNHIKMW5mPGd+M3tabhlY/N7K77HsFAQBS8xCOm2u41x/K
         7RkFeJKORW1+Eyyc8vt4bIFU0+fGJUV1mTU6cki70u7FGY+NRDBZxRNOcO4TM3oFGhEh
         PhuxS8MECz/QulcYHZXtUkmBNi3LOAbVXIkuNm3CDDmwCY/BwmdGQIdJsCiQF5MK0v6I
         +7wFGpYdf+6aQTHi8gYx70H/lAH9vrW1KlYsTw3HmaojK1EQiihvYSgQaLt4SOICxv15
         BEJw==
X-Gm-Message-State: AOAM530nSjBl9j4hvggustoAhtivY9N9Ecz95gXETC3f0D7ZDgT1oCCU
        wluBbV//Bm1dTbRW4GctrnBuTA==
X-Google-Smtp-Source: ABdhPJyQY225rKyYNsyDEonRZZWTlFhAm5I+xmisJQw10qIevpIIa4O4M+3Dkkhl5nMycL7W8AgpJw==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr30129864wml.179.1622054154106;
        Wed, 26 May 2021 11:35:54 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:74ba:ff42:8494:7f35])
        by smtp.gmail.com with ESMTPSA id t14sm4914507wra.60.2021.05.26.11.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 11:35:53 -0700 (PDT)
Date:   Wed, 26 May 2021 20:35:47 +0200
From:   Marco Elver <elver@google.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] kunit: test: Add example_skip test suite which is
 always skipped
Message-ID: <YK6VA8mHSg4aU1Ts@elver.google.com>
References: <20210526081112.3652290-1-davidgow@google.com>
 <20210526081112.3652290-3-davidgow@google.com>
 <YK4NRlyrYJ8ktsWQ@elver.google.com>
 <CAGS_qxp=EV1iy5tCs+YpxH-Pug=MDTBXo3jSc13-h7HJnzBnDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxp=EV1iy5tCs+YpxH-Pug=MDTBXo3jSc13-h7HJnzBnDA@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 26, 2021 at 11:29AM -0700, Daniel Latypov wrote:
> On Wed, May 26, 2021 at 1:56 AM 'Marco Elver' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > On Wed, May 26, 2021 at 01:11AM -0700, David Gow wrote:
> > > Add a new KUnit test suite which contains tests which are always
> > > skipped. This is used as an example for how to write tests which are
> > > skipped, and to demonstrate the difference between kunit_skip() and
> > > kunit_mark_skipped().
> > >
> > > Because these tests do not pass (they're skipped), they are not enabled
> > > by default, or by the KUNIT_ALL_TESTS config option: they must be
> > > enabled explicitly by setting CONFIG_KUNIT_EXAMPLE_SKIP_TEST=y in either
> > > a .config or .kunitconfig file.
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>
> > > ---
> > >  lib/kunit/Kconfig                   | 15 +++++++++
> > >  lib/kunit/Makefile                  |  2 ++
> > >  lib/kunit/kunit-example-skip-test.c | 52 +++++++++++++++++++++++++++++
> > >  3 files changed, 69 insertions(+)
> > >  create mode 100644 lib/kunit/kunit-example-skip-test.c
> >
> > I don't know if this test is useful for a user of KUnit. Given it's not
> > testing KUnit functionality (I see you added tests that the feature
> > works in patch 1/3), but rather a demonstration and therefore dead code.
> > I don't think the feature is difficult to understand from the API doc
> > text.
> >
> > Instead, would it be more helpful to add something to
> > Documentation/dev-tools/kunit? Or perhaps just add something to
> > lib/kunit/kunit-example-test.c? It'd avoid introducing more Kconfig
> 
> I'm in favor of putting it in kunit-example-test.c as well.
> 
> But I hear there was pushback to have a non-passing test in the example?
> I guess the fear is that someone will see something that doesn't say
> "passed" in the example output and think something has gone wrong?
> 
> Hence this more conservative change.
> But I hope that in the absence of any replies in opposition, we can
> just keep one example-test.c

Maybe I misunderstood, but kunit_skip*() isn't supposed to change the
test ok/fail state, right?

That's the behaviour I'd expect at least.

So if the test case deliberately doesn't change the state, but just
skips, it should be fine in example-test.c.

Thanks,
-- Marco
