Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84DD01190F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2019 20:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLJTsI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Dec 2019 14:48:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40282 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfLJTsH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Dec 2019 14:48:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so9375396pgt.7
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2019 11:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hs4+jt4b4qkjnd//rQ0dpgbF0ORXyEi5ROObXi8EfqY=;
        b=mYnRzTb5+sTStYc7Niv1gGvH8acexDCSmAR+l0KIkpgvJvO+UcpjC7yGbeRlAanOLS
         9X2B13LZgLNohEiDdd7+igZqn9TNKmhRIY1C0B7AS+VxR1Vxl4UJ6mdA3VB6atZDX4Jn
         NTcWbvkzGlJ0wiIQr/Bqwlnvpx8AJV8BuVDKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hs4+jt4b4qkjnd//rQ0dpgbF0ORXyEi5ROObXi8EfqY=;
        b=uRdTs5WI/XfTD3zzWrGqeofo8F/v4MvQT+FUVZdI4htSDAytbMkQcB+2+id/2YCxPG
         bcpC8jFvDkyWXTtfL0oT3taf+9lIn+Ihvx/grnkAwHhtiscseOk2yLtdFF2hpH7E92Ec
         7lC1XhYdOSd/Iy81Muy4jBlDsSKVnQloq32Pp/l/sewO0XEo0C4ymRCrkPprql+PNYlK
         Hs0ZdGTi/m1/RBMTJwH8ZhV7lAWsrx+0Ka2a5fVKJgQuVfRrJmaVHKrODTs5STl00OP4
         1LA3VP4YWUlj8xwUAN+QHYnj5gYbJvK7jnWohNyyN2MH+GWmTguuSi5kIxA+emzgOFaV
         RUqg==
X-Gm-Message-State: APjAAAWwEadq9hDwPigL6G3mMQWCugirDuGP5xcM1VRSqYgtPlzj1f60
        GGbwVb3FrUi4YDU0I8VMjkTrMA==
X-Google-Smtp-Source: APXvYqz78cU7WRPjnasXetiMClBhXKzMKxaJBk2LajotEHBGPikWJe9GXvoW0ru9xwaigCtaqSZ13Q==
X-Received: by 2002:a63:4e47:: with SMTP id o7mr26628998pgl.332.1576007286738;
        Tue, 10 Dec 2019 11:48:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l186sm4243001pge.31.2019.12.10.11.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 11:48:05 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:48:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Subject: Re: [PATCH linux-kselftest/test v2] apparmor: add AppArmor KUnit
 tests for policy unpack
Message-ID: <201912101147.7BCF728@keescook>
References: <20191106004329.16991-1-brendanhiggins@google.com>
 <201911060916.AC9E14B@keescook>
 <20191107233337.GA191231@google.com>
 <CAFd5g462jFnbPxA2Nvc_3W064kZ8t5oHNE4M_3yt84+NuoiHGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g462jFnbPxA2Nvc_3W064kZ8t5oHNE4M_3yt84+NuoiHGQ@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 18, 2019 at 04:34:53PM -0800, Brendan Higgins wrote:
> On Thu, Nov 7, 2019 at 3:33 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Wed, Nov 06, 2019 at 09:18:27AM -0800, Kees Cook wrote:
> > > On Tue, Nov 05, 2019 at 04:43:29PM -0800, Brendan Higgins wrote:
> > > > From: Mike Salvatore <mike.salvatore@canonical.com>
> > > >
> > > > Add KUnit tests to test AppArmor unpacking of userspace policies.
> > > > AppArmor uses a serialized binary format for loading policies. To find
> > > > policy format documentation see
> > > > Documentation/admin-guide/LSM/apparmor.rst.
> > > >
> > > > In order to write the tests against the policy unpacking code, some
> > > > static functions needed to be exposed for testing purposes. One of the
> > > > goals of this patch is to establish a pattern for which testing these
> > > > kinds of functions should be done in the future.
> > > >
> > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > > Signed-off-by: Mike Salvatore <mike.salvatore@canonical.com>
> > > > ---
> > > >  security/apparmor/Kconfig              |  16 +
> > > >  security/apparmor/policy_unpack.c      |   4 +
> > > >  security/apparmor/policy_unpack_test.c | 607 +++++++++++++++++++++++++
> > > >  3 files changed, 627 insertions(+)
> > > >  create mode 100644 security/apparmor/policy_unpack_test.c
> > > >
> > > > diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
> > > > index d8b1a360a6368..78a33ccac2574 100644
> > > > --- a/security/apparmor/Kconfig
> > > > +++ b/security/apparmor/Kconfig
> > > > @@ -66,3 +66,19 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
> > > >       Set the default value of the apparmor.debug kernel parameter.
> > > >       When enabled, various debug messages will be logged to
> > > >       the kernel message buffer.
> > > > +
> > > > +config SECURITY_APPARMOR_KUNIT_TEST
> > > > +   bool "Build KUnit tests for policy_unpack.c"
> > > > +   depends on KUNIT && SECURITY_APPARMOR
> > > > +   help
> > > > +     This builds the AppArmor KUnit tests.
> > > > +
> > > > +     KUnit tests run during boot and output the results to the debug log
> > > > +     in TAP format (http://testanything.org/). Only useful for kernel devs
> > > > +     running KUnit test harness and are not for inclusion into a
> > > > +     production build.
> > > > +
> > > > +     For more information on KUnit and unit tests in general please refer
> > > > +     to the KUnit documentation in Documentation/dev-tools/kunit/.
> > > > +
> > > > +     If unsure, say N.
> > > > diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> > > > index 8cfc9493eefc7..37c1dd3178fc0 100644
> > > > --- a/security/apparmor/policy_unpack.c
> > > > +++ b/security/apparmor/policy_unpack.c
> > > > @@ -1120,3 +1120,7 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
> > > >
> > > >     return error;
> > > >  }
> > > > +
> > > > +#ifdef CONFIG_SECURITY_APPARMOR_KUNIT_TEST
> > > > +#include "policy_unpack_test.c"
> > > > +#endif /* CONFIG_SECURITY_APPARMOR_KUNIT_TEST */
> > >
> > > To make this even LESS intrusive, the ifdefs could live in ..._test.c.
> >
> > Less intrusive, yes, but I think I actually like the ifdef here; it
> > makes it clear from the source that the test is only a part of the build
> > when configured to do so. Nevertheless, I will change it if anyone feels
> > strongly about it.
> >
> > > Also, while I *think* the kernel build system will correctly track this
> > > dependency, can you double-check that changes to ..._test.c correctly
> > > trigger a recompile of policy_unpack.c?
> >
> > Yep, just verified, first I ran the tests and everything passed. Then I
> > applied the following diff:
> >
> > diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
> > index 533137f45361c..e1b0670dbdc27 100644
> > --- a/security/apparmor/policy_unpack_test.c
> > +++ b/security/apparmor/policy_unpack_test.c
> > @@ -161,7 +161,7 @@ static void policy_unpack_test_unpack_array_with_name(struct kunit *test)
> >
> >         array_size = unpack_array(puf->e, name);
> >
> > -       KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
> > +       KUNIT_EXPECT_EQ(test, array_size + 1, (u16)TEST_ARRAY_SIZE);
> >         KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
> >                 puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1);
> >  }
> >
> > and reran the tests (to trigger an incremental build) and the test
> > failed as expected indicating that the dependency is properly tracked.
> 
> Hey Kees,
> 
> Since it looks like you already took a pretty close look at this,
> would you mind giving me a review?

Yes! Thanks for checking on those items. :)

Reviewed-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
