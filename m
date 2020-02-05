Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EABE15371B
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2020 18:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgBER6j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Feb 2020 12:58:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38525 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgBER6j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Feb 2020 12:58:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so3871325wrh.5
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Feb 2020 09:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJvZ+LESdZtd5WGeTnbWB5+DEtp+eP7zYdHNLW4NGgw=;
        b=hF6ZtELcfVJ5Was2i3jUYVdbVhGlpsIdk7OQDTWzsSp+OxfC+NMNb4lFErpdSM589m
         AambAQRybraD8+auTE49pcp7s9Kndskbd4cZO/8bhBAgeofqGbVPf3U5YmcIL46d3xf3
         7rZF/Wp1aoZ3bmzK4+YqSuqVQj+myTGar5Old7WPMLZJGifN6D/mgyHGE0ZMaiEV4XMk
         Ukc5TmMAD/wOD+3MKf5KLCkQvDXilM8YxFNqKEtEHJ+yQlevFWo2wcfwsbAACAxdjhJB
         CbS451mst3RHRuyAPxvNGExC7mEX2QBDbZmqejgCgk73JbRdGWy31j0ptdR1hOCEUJm8
         HU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJvZ+LESdZtd5WGeTnbWB5+DEtp+eP7zYdHNLW4NGgw=;
        b=qMasSXdYRju1c0vYjZvusjl/FEEo8G9ZXHMRiAudmH1hunLgzACeBpfc6fU76VucRO
         VdyNSHYqCoCzuMpUOIwKB1z4/S017actmwapKNbrNMvDd5dZWQLsc6uII52PrKrQgy/B
         fo4gLsaioA4btld3Lu0cwkEee6ULkUoAtVHae+NSDVGAFqRz9pPqnIC8t0NyzThlkj4w
         kRxXA3ZM0fpLl0/ynCYeeBfhi+Hj8raHeBEE6QGfrJWd4ffyuEs0BazZU1MeEfrwTzGD
         CkcmOKHFDx1ogVxvDYxlPWnZCgOmho91dALQrLxfWgGA8D+558PyaNSlahP8I895j3eA
         tXWg==
X-Gm-Message-State: APjAAAWrfgQL2E8dS03VR8I1pZfzbyDqryjgIxD399J2ZcujKuF486U0
        yFfToDfJ2eCMZik+43KqBp1Nl/m3mQRUXmG6htj+9A==
X-Google-Smtp-Source: APXvYqzTbfg/iLsk5cSfhBL9S5d5L+m+pFAAStIYggeDc/+2mzG1fiSGEKqoe3tVBitZlGnY8XgopbQRSol6RJzUXiQ=
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr30274271wrp.203.1580925516197;
 Wed, 05 Feb 2020 09:58:36 -0800 (PST)
MIME-Version: 1.0
References: <CAFd5g448555=dKFQMbjJ6G=tvtfF5oJgTtTgGx+38Ls3VqHo5g@mail.gmail.com>
 <20200205021428.8007-1-sj38.park@gmail.com>
In-Reply-To: <20200205021428.8007-1-sj38.park@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 5 Feb 2020 09:58:23 -0800
Message-ID: <CABVgOSmFAZN3KRYkHVg5bb-m-UorB7+9=f9vAqW2ECABzpa9zQ@mail.gmail.com>
Subject: Re: Re: Re: [PATCH] kunit/kunit_kernel: Rebuild .config if
 .kunitconfig is modified
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

One thing we'd like to do with kunit_tool is to make its functionality
a bit more independent: in particular, allowing the configuration,
running the kernel, and parsing the results to be done independently.

If that's the case, it may make sense for "kunit.py run" or similar to
not do anything with the .config, and to relegate that to a separate
"configuration" step, which would allow someone to modify the
configuration themselves (e.g., using make menuconfig) and re-run the
tests, but also allow the config to be explicitly regenerated when
helpful.

Exactly what that'd end up looking like (and to what extent we'd still
want to support a single command that'd do both) are still up in the
air: but I think a general "separation of concerns" like this is
probably the right path forward for kunit_tool.

Cheers,
-- David


On Tue, Feb 4, 2020 at 6:14 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> On Tue, 4 Feb 2020 16:46:06 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:
>
> > Sorry for the delay.
> >
> > On Mon, Jan 27, 2020 at 10:03 PM SeongJae Park <sj38.park@gmail.com> wrote:
> > >
> > > On Mon, 27 Jan 2020 16:02:48 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:
> > >
> > > > On Sat, Jan 25, 2020 at 5:59 PM <sj38.park@gmail.com> wrote:
> > > > >
> > > > > From: SeongJae Park <sjpark@amazon.de>
> > > > >
> > > > > Deletions of configs in the '.kunitconfig' is not applied because kunit
> > > > > rebuilds '.config' only if the '.config' is not a subset of the
> > > > > '.kunitconfig'.  To allow the deletions to applied, this commit modifies
> > > > > the '.config' rebuild condition to addtionally check the modified times
> > > > > of those files.
> > > >
> > > > The reason it only checks that .kunitconfig is a subset of .config is
> > > > because we don't want the .kunitconfig to remove options just because
> > > > it doesn't recognize them.
> > > >
> > > > It runs `make ARCH=um olddefconfig` on the .config that it generates
> > > > from the .kunitconfig, and most of the time that means you will get a
> > > > .config with lots of things in it that aren't in the .kunitconfig.
> > > > Consequently, nothing should ever be deleted from the .config just
> > > > because it was deleted in the .kunitconfig (unless, of course, you
> > > > change a =y to a =n or # ... is not set), so I don't see what this
> > > > change would do.
> > > >
> > > > Can you maybe provide an example?
> > >
> > > Sorry for my insufficient explanation.  I added a kunit test
> > > (SYSCTL_KUNIT_TEST) to '.kunitconfig', ran the added test, and then removed it
> > > from the file.  However, '.config' is not generated again due to the condition
> > > and therefore the test still runs.
> > >
> > > For more detail:
> > >
> > >     $ ./tools/testing/kunit/kunit.py run --defconfig --build_dir ../kunit.out/
> > >     $ echo "CONFIG_SYSCTL_KUNIT_TEST=y" >> ../kunit.out/.kunitconfig
> > >     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> > >     $ sed -i '4d' ../kunit.out/.kunitconfig
> > >     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> > >
> > > The 2nd line command adds sysctl kunit test and the 3rd line shows it runs the
> > > added test as expected.  Because the default kunit config contains only 3
> > > lines, The 4th line command removes the sysctl kunit test from the
> > > .kunitconfig.  However, the 5th line still run the test.
> > >
> > > This patch is for such cases.  Of course, this might make more false positives
> > > but I believe it would not be a big problem because .config generation takes no
> > > long time.  If I missed something, please let me know.
> >
> > I think I understand.
> >
> > It is intentional - currently - that KUnit doesn't generate a new
> > .config with every invocation. The reason is basically to support
> > interaction with other methods of generating .configs. Consider that
> > you might want to use make menuconfig to turn something on. It is a
> > pretty handy interface if you work on vastly different parts of the
> > kernel. Or maybe you have a defconfig that you always use for some
> > platform, I think it is easier to run
> >
> > make foo_config; tools/testing/kunit/kunit.py run
> >
> > Then having to maintain both your defconfig and a .kunitconfig which
> > is a superset of the defconfig.
> >
> > Your change would make it so that you have to have a .kunitconfig for
> > every test environment that you care about, and you could not as
> > easily take advantage of menuconfig.
>
> Thank you for this kind answer.  Now I understood the intention and agree with
> that. :)
>
> >
> > I think what we do now is a bit janky, and the use cases I mentioned
> > are not super well supported. So I am sympathetic to what you are
> > trying to do, maybe we could have a config option for it?
> >
> > I think Ted and Bjorn might have opinions on this; they had some
> > related opinions in the past.
>
> I'm ok with current state, but if related discussions continue and my opinion
> is required, I will join in.
>
>
> Thanks,
> SeongJae Park
>
> >
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20200205021428.8007-1-sj38.park%40gmail.com.
