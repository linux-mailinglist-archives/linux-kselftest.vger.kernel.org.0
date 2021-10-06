Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A32F423951
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 10:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbhJFIEC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 04:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbhJFID6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 04:03:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F15CC061765
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Oct 2021 01:01:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t8so6150163wri.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Oct 2021 01:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oXCXGqRpjoj7k6pAhRs79haVLMELl6RnsJCAi2j42CY=;
        b=LIQDxPwZgraHyky+z4ClvEtXZNQ4lC1pN3t3srJmDw1B+9KvBP9RxHotTNzeHjTy9F
         pIKXV4Mw9WD+Ts7tmrMr2mrFiGmZ5Pf9HWjvo8UYtWeXQ4WLcEZXpkEfQ80qM4VxSAaH
         5M/1pQ6cmNR7dbgJBmuBzHXFQz+rODRKs2m9P12lYKMSEjlTw0Z5HxOQnTBKW6RNeWRc
         RzQ6ZsEi2ixPC+aaoVU5TeAzgZPSPvKzpHu0arGqsgRH/5Kf4+2BsT2cfJc+Nr09L++D
         mHCDm0yyFbtnPxcW9JcdiwYXDya9c7BQuDyDVOe9O2jXYrJkTsCWmDnyGMRIFIp67I+a
         6D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oXCXGqRpjoj7k6pAhRs79haVLMELl6RnsJCAi2j42CY=;
        b=U6fzVOuwsJvCzhowLgX/pMHokT+i37RIqBoCb6xjMkImQfmJqk15HbG2gAJrqmrUFJ
         n8Pjma652WEANEHPE5x+EdtC7vXSIz0Cm3VA1ywFRdOlkM2wiHnqB2u9wMZstmgSmsRL
         6e4AfjOlvOSayN827kf5aVpKAUypLO4IjE6n2l7QMVf7SvNe3nXmtBETrdMqesL/y2IC
         54CQRnwzN/CTi3E9wRptFGT2KGUpSgTLUV1YDkxjB/CxtkE+qLiUiafnp2Wg2xtNl5gZ
         eENnJ4n7Mbxkqj7gYnXjGymphD4v4uA25RSdEWKeFE7EYm/5QIm9iA9+0+THOneK0d4d
         diQQ==
X-Gm-Message-State: AOAM530BlJ0q3SQAbOrVFHgjJEajvHLwj5IchpnvYWxtvtwQ3NxBz4vL
        M9IousPWFl24ElNvQfac+RUCPzLnBjEg5rtzDlmTPQ==
X-Google-Smtp-Source: ABdhPJzCCAu8Cjmo6dt3gAhb13SUhuQrWKA5WDTRQaKBu6caYMWk1MOvCsQDElOfjDTaERuhfVj7hKKXrm98XgMiXnQ=
X-Received: by 2002:a7b:c453:: with SMTP id l19mr8092261wmi.7.1633507317525;
 Wed, 06 Oct 2021 01:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211002022656.1681956-1-jk@codeconstruct.com.au>
 <CABVgOS=F9K_AzoWjKPRT9m014NAo37vKHYEp-jHWDt5M+pkzSw@mail.gmail.com> <101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au>
In-Reply-To: <101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au>
From:   David Gow <davidgow@google.com>
Date:   Wed, 6 Oct 2021 16:01:46 +0800
Message-ID: <CABVgOSmOFtYMiHWKTbbXST00pbYE88eu3DagD8pHt5=QdmCqyg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mctp: test: disallow MCTP_TEST when building
 as a module
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     Matt Johnston <matt@codeconstruct.com.au>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 4, 2021 at 10:21 AM Jeremy Kerr <jk@codeconstruct.com.au> wrote:
>
> Hi David,
>
> [removing netdev, this is more kunit-related]
>
> > This looks good to me. I don't think you'll be the only person to hit
> > this issue, so -- while it's probably overall nicer if tests can sit
> > in their own module -- we'll look into finding a way of supporting
> > this with KUnit at some point.
>
> Just digging in to this a little: what's the intended structure here? Is
> it intended to have the tests as their own loadable modules?
>
> For MCTP, I'd like to enable tests when we're built as a module; in that
> case, are you expecting we'd now have two modules: the core, and the
> kunit tests?
>

That's what we've mostly done so far, just because it can be useful to
load the core without the tests. There are also a number of test
modules for things which themselves are built-in (e.g. KASAN), so
having separate test modules was necessary for those.

We're still feeling out what the best way to do this is, though, and
there's nothing wrong with including the KUnit tests in the MCTP
module. It's just not as well explored, so does tend to hit a few
issues. Better supporting tests embedded in a larger model (as well as
making it easier to export symbols "for testing") are on our roadmap.

> As you've seen, my test implementation here is to directly include the
> <tests>.c file; this means I don't need to EXPORT_SYMBOL all of the
> MCTP-internal functions that I want to test; they can remain private to
> the individual compilation unit. However, the current kunit_test_suites
> implementation prevents this.

We actually already have a test suite which already includes the
"tests.c" file: the AppArmor suite. However AppArmor can't be built as
a module, so we never hit any of the module issues with it.

We're still working out how best to test internal, static functions:
the options basically are to include the "test.c" as you've found, or
to find some way of exporting symbols "for testing", either with some
macro magic (the functions are 'static' if CONFIG_KUNIT is undefined,
or similar), or by trying to use module symbol namespaces. I expect
we'll have a few tests doing each for a while, and then start to
settle on whatever ends up being most convenient in most cases.

> I've been hacking around with the (very experimental) patch below, to
> allow tests in modules (without open-coding kunit_test_suites, which the
> aspeed mmc sdhci driver has done), but I don't have much background on
> kunit, so I'm not sure whether this is a useful direction to take.

This looks really neat, and much better than the existing module
support. There are a few other tests which open-code kunit_test_suites
or something similar which have hit problems due to running too early
if built-in, which this could help resolve as well. Getting rid of (or
at least standardising) those custom KUnit suite initialisers is
something I've wanted to do for a while.

I haven't had a chance to look through the patch in a lot of detail
yet (and there are a few tweaks which would be needed, as it breaks
the UML build at the moment), but this definitely looks a much better
approach than what we've been doing. Module support has always been a
little bit less stable than running built in tests, and this should at
least go some way towards reconciling those two paths.

In any case, thanks a lot -- this is awesome.

Cheers,
-- David
