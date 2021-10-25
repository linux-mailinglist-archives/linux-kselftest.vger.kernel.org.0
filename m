Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D93A43A519
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 22:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhJYU5N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 16:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbhJYU5D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 16:57:03 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E04CC061745
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 13:54:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m14so12078796pfc.9
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 13:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PDbthfUbW4kGALLE2nKlmxyvdKbARz7oLNl+X7TpQTg=;
        b=HSweu34SrhB4QVvc45t7Vwp+afnf9VBtVgRZcgVGaNz7qyDC3YtgQmYDqNXgeMEtNH
         MzWpXOVPPJSNKlpG/71XOYg16hFbFMgAFI9pR1yQZsI9MeeQQXstIpOAkr8pTxp0xiXS
         rt9syE3aRcvdKRVQz2sFVn2qDCf+TMyu7IADmB0oas6kLpoOXw4j7MwRDtqO89A4HTF2
         69cDqURGtnWs6sBTbcJAM0IfC4qtEOEKydXbAr44HuzHlMm0cMcBKoDQ/E9SUzj/w+5K
         XegQLOg7GQ1wHGl9+m/9cVfUGdc1/HK18Gn68IEf/0TLlWDB9aN6vvSE+2P5xaymksKK
         qiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PDbthfUbW4kGALLE2nKlmxyvdKbARz7oLNl+X7TpQTg=;
        b=mfKbWnMaf1LIHHagyoCC+30E2EfzdfZ6Fg61ZVcgP1QKD9h0GSHkJQyG/GzSzNg74+
         f22GmKn5NyKRNLFpffhYmsSpSEVUGo0M8mHfSEhniVyv5cE68A1ZkRlQGOpgaOX/vjhP
         GoORLe61za878Jdah66oby1Zo6AdOfR/sUdsoN1YQHB1LoIkNR+ObKqQjIw2e3qoX/cp
         AHnoq4WDgSNFJondIsIHE/+dBsWCD8BzrzbtnClqVDctjBjKKZtLdxqBl3BHaxgoojKP
         UhYDSEoekiGofzls+zC+Gryei4neaIEVtr68I6MAbl914mm2T16lAH8zMqyTcSxmEFtC
         oXdA==
X-Gm-Message-State: AOAM531RgS719bXODRCz64TkobUS3/q42VXoa8OoNSNm+sVss2UgY1pg
        uxQ+Kdx4Oi61UnKcx+Czo5Szxe7bhiBtGKReKdYsQ8QSP5Y=
X-Google-Smtp-Source: ABdhPJxFZFQD4o8sgpbeIgU+RS/8UzX7yPcp4ovt4WrDWWEiZ5w/LKQ6gbpHtflBbTrYQZ/jv0V5ErRqT6kb3/qk/sM=
X-Received: by 2002:aa7:8b49:0:b0:44d:65a9:fb9d with SMTP id
 i9-20020aa78b49000000b0044d65a9fb9dmr21330350pfd.24.1635195279698; Mon, 25
 Oct 2021 13:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211002022656.1681956-1-jk@codeconstruct.com.au>
 <CABVgOS=F9K_AzoWjKPRT9m014NAo37vKHYEp-jHWDt5M+pkzSw@mail.gmail.com>
 <101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au>
 <CAFd5g46HN9pBcQhgEBGW6b=DR7ds48+Pggf0Y_d7804YO1aiKg@mail.gmail.com>
 <af2793322ce99c2bfa9e7dc35884a103b67f48b5.camel@codeconstruct.com.au> <CABVgOSn8fJ1YkFSwfNDoh93ve0r2Xom-RjiWvdwttvxqx39UEQ@mail.gmail.com>
In-Reply-To: <CABVgOSn8fJ1YkFSwfNDoh93ve0r2Xom-RjiWvdwttvxqx39UEQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 25 Oct 2021 13:54:28 -0700
Message-ID: <CAFd5g46FWz4i3=XkAp6sZGN2ztVz-Y34xTooV1rowXpn4Gv77Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mctp: test: disallow MCTP_TEST when building
 as a module
To:     David Gow <davidgow@google.com>
Cc:     Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 21, 2021 at 12:06 AM David Gow <davidgow@google.com> wrote:
>
> On Thu, Oct 21, 2021 at 2:17 PM Jeremy Kerr <jk@codeconstruct.com.au> wrote:
> >
> > Hi Brendan,
> >
> > > I think this change here should mostly go into lib/kunit/executor.c:
> > >
> > > https://elixir.bootlin.com/linux/latest/source/lib/kunit/executor.c
> > >
> > > Not totally sure how this should interact with printing the TAP header
> > > and some other functionality, but we already have some module params
> > > in there that we may want to pick up when KUnit is loaded as a module.
> >
> > So I had a go at doing this as part of the executor, but that just
> > raised more questions about how we want this to work for the various
> > configurations of built-in/modules, where we have five options, assuming
> > two example kunit consumers:
> >
> >  - CONFIG_example1_TEST=y - our built-in suite: suites end up in the
> >    vmlinux kunit_test_suites section
> >
> >  - CONFIG_example2_TEST=m - our modular suite: suites end up in the
> >    modules' kunit_test_suites section, to be iterated on module load.
> >
> > Currently, it looks like we have:
> >
> > CONFIG_KUNIT=y
> >
> > 1) example1's tests are run through the built-in init path:
> >     kernel_init_freeable()
> >      -> kunit_run_all_tests, which iterates through the built-in
> >         kunit_test_suites section
> >
> > 2) example2's tests are run through:
> >
> >     the module's own module_init(),
> >      -> __kunit_test_suites_init()
> >            - passing the suite to be init-ed and immediately run.
> >
> > CONFIG_KUNIT=m - is where this gets tricky:
> >
> > 3) example1's tests are never run; we don't iterate the
> >    kunit_test_suites section when KUNIT=m (as kunit_run_all_tests() is
> >    empty)
> >
>
> Thus far, this hasn't been a much of a problem (at least for me), as
> the kunit test modules all depend on kunit.ko, so modprobing one of
> them will pull kunit.ko in as well. And I think Kconfig will
> discourage you from building kunit tests into a kernel if
> CONFIG_KUNIT=m.
>
> > 4) loading example2.ko after kunit.ko will get example2's test run
> >    through example2's module_init -> __kunit_test_suites_init()
> >
> > 5) loading example2.ko before kunit.ko would result in an unresolved
> >    symbol, as __kunit_test_suites_init() doesn't exist yet.
>
> Again, this shouldn't happen if people use modprobe, but manual
> insmodding could trigger it.
> >
> > Is that all correct?
> >
> > With the proposed change to use a section for module's test suites:
> >
> > (1) would stay as-is
> >
> > (2) is similar, but the suites are loaded from the module's
> > kuint_test_suites section rather than an explicit call from
> > module_init().
> >
> > (3) would stay as-is (but we could export the __kuint_test_suites
> > section details, allowing kunit.ko to iterate the built-in suites - is
> > this desirable?).
>
> I'd be okay with exporting __kunit_test_suites to support this. I do
> feel that this is the most niche case, though, so I'd equally be okay
> with not supporting it unless someone actually has a need for it.
> >
> > (4) is now the same as (2); once kunit.ko is present, it will be
> > notified on subsequent module loads, and will extract tests from the
> > module's own kuint_test_suites section
> >
> > (5) does not result in any dependencies between example2.ko and
> > kunit.ko. exmaple2.ko is able to be loaded before kunit.ko without
> > symbol dep issues, but (of course) its tests will not be run. We have an
> > option here to store the suites of loaded modules into a small built-in
> > list, for kunit.ko to consume when it starts, similar to the changes
> > possible in (3).
>
> One idea I've had in the past is to keep such a list around of "test
> suites to be run when KUnit is ready". This is partly because it's
> much nicer to have all the test suites run together as part of a
> single (K)TAP output, so this could be a way of implementing (at least
> part of) that.

+1

> In any case, this plan looks pretty good for me: I'm not sure if cases
> (3) and (5) show up often enough in the real world to be worth
> complicating things too much to get them working, but the other cases
> are important, and your plan handles those the way I'd expect.

+1

> Brendan: do you know of anyone who's actually building KUnit itself as
> a module? Given that there are some nasty side effects (bloating

No, some people asked for it early on, but I think we broke it once or
twice and no one noticed which suggests that no one uses it.

> 'current' with the test pointer, the KASLR address leak) which affects
> the whole build, I'm not sure it's actually ever useful to do so.

Oh yeah, I forgot that we put the test pointer in `current` when
CONFIG_KUNIT is built-in OR a module. Yeah, I agree, that makes
CONFIG_KUNIT=m kind of useless.

> Thoughts?
>
> -- David
