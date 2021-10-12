Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7CF42AD5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Oct 2021 21:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhJLTlA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Oct 2021 15:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJLTk7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Oct 2021 15:40:59 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B55C061570
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Oct 2021 12:38:57 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id h125so482178pfe.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Oct 2021 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/k3ydoQrpjLKgcomai612qLQf1/7H5c4Qkjd6qSAjQ=;
        b=JmuaNNbkNUahBZtf10mNJ99s895eHqtuotc0RyE/8BdbEUyVXaFZ+T/58pUV0rFEdr
         GuFpOWuQLbgjTRIxuOcyhAOa771yNTu+LkFMu1npWojLHY29k9svsMKyBigxt+Bxm8Bc
         4WmhUhcFduvZt2F8qQzkocomdSmY+lIBHlbyOqnZOawz7/lYcx1lqfZX1fnTmohzxueb
         OlRM3vclehep5mehth73OAUng1q5Wi5llqufNn5irVxmhKTz7sWDCwjC706Lsp+diX6t
         M4s8rhjFK26YSxJ43T+qFrdEoJoQtzaZxiy2zhQIdbbakfv0yB+AYY0Q/VLsdS6jdde6
         yKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/k3ydoQrpjLKgcomai612qLQf1/7H5c4Qkjd6qSAjQ=;
        b=uBYF9hsTdCsXNDWiCkw74+G3yQUnKbNYCNfI60ASBAaFbIBLJWaPIpQkQJoi3yqpC3
         HhhMunEDFzqekevFXd2sHdWU6+P2IAH3a1Q63ySdwIJGv+G03sbB0lijf+kZioH+ulhz
         3vPRQ/Ro6eFMsEHle1JcBlJ6F2tYZhGwjCSBJ0rAqzPN78biIUJCCiOzvIqEhB1otQ0F
         E1R3p6hHX3Kl4Czn156gTmqcqZ3Bo6YIDezla3w6eRZGVOcHLByN6M3fNN5LC1qG/0sA
         erD9ryDYL8J3k0/SSV5AaBm5Rqy0RRghPsd4zdyvstGBP/PWDw5SuEf8oTih9Kd8cPg8
         NPyA==
X-Gm-Message-State: AOAM531vex3KtzItn+gxlD27IxUAXrD9wR90qPyveMHTkSvWbgyBnods
        8so6gfxxtBYNk6IL/NGB2HjnPyk9scq1wZtic0KAQshrTXQ=
X-Google-Smtp-Source: ABdhPJxggHiBoBe+TjOHmwPGRllHR0Vol5VJN+/GYoKvTKfo5HpQ05ZD8ctG3uK6y7+P4DXZlfDZrGhZZpMJgP1qzSQ=
X-Received: by 2002:a65:6658:: with SMTP id z24mr24705096pgv.266.1634067536982;
 Tue, 12 Oct 2021 12:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211002022656.1681956-1-jk@codeconstruct.com.au>
 <CABVgOS=F9K_AzoWjKPRT9m014NAo37vKHYEp-jHWDt5M+pkzSw@mail.gmail.com>
 <101d12fc9250b7a445ff50a9e7a25cd74d0e16eb.camel@codeconstruct.com.au>
 <CABVgOSmOFtYMiHWKTbbXST00pbYE88eu3DagD8pHt5=QdmCqyg@mail.gmail.com>
 <de7b75062fbc19824111685a9b8119545ee83e35.camel@codeconstruct.com.au> <CABVgOS=evHzhP5k9EshZM4MG+Zt9qDwn11tf2Q7EaYgVwdWGOQ@mail.gmail.com>
In-Reply-To: <CABVgOS=evHzhP5k9EshZM4MG+Zt9qDwn11tf2Q7EaYgVwdWGOQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 12 Oct 2021 12:38:45 -0700
Message-ID: <CAFd5g46Yzum-ZxRMvaK5Tgc3WUd05SiB1Pemf84u5ysybsZEdw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mctp: test: disallow MCTP_TEST when building
 as a module
To:     David Gow <davidgow@google.com>
Cc:     Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 11, 2021 at 9:38 PM David Gow <davidgow@google.com> wrote:
>
> On Mon, Oct 11, 2021 at 10:10 AM Jeremy Kerr <jk@codeconstruct.com.au> wrote:

Hey Jeremy, small world! :-)

> > Hi David,
> >
> > > In any case, thanks a lot -- this is awesome.
> >
> > Oh neat, glad it's useful!
> >
> > I'm happy to keep hacking on this if it's in a direction that makes
> > sense for kunit in general. As an approximate plan, I can fix the UML
> > breakages, then work on some resulting simplifications for tree-wide
> > initialisers (we'd no longer need the null-terminated arrays of suites
> > everywhere, for example).
> >
> +dlatypov, +kunit-dev
>
> Yeah, we think this would be a much better direction for KUnit to go
> for modules. If you're happy to work on it, that'd be great! Brendan,
> Daniel (CCed), and I would be more than willing to help out with
> questions, reviews, etc, as well.

+1 to David. My immediate reaction to looking at your diff is that it
is the way that module support *should have* always worked, (No
offense to those who worked on KUnit module support in the past: any
module support was a big improvement over none.) your implementation
is so much simpler and less obtrusive.

> On the other hand, if you're really busy and you'd rather we pick this
> up, improved module support has been on the to-do list for ages, so we
> could bump it up the list a bit and finish it off.
>
> The UML breakages were mostly pretty simple: our default config
> doesn't require module support at all, so the various functions should
> just need to go behind the appropriate #ifdefs. A quick way to test it
> is just to run './tools/testing/kunit/kunit.py run' from the kernel
> source directory, which will configure, build, and run everything in
> the .kunit builddir.

Cheers
