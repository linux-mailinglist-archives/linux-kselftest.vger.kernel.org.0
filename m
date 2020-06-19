Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B699201B8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 21:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389863AbgFSTpH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 15:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390066AbgFSTpG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 15:45:06 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2318BC0613EE
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 12:45:05 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n2so4295258pld.13
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 12:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SyUec5c/aPhd3mmtCmh5hrx61kd4SJGtSz9m/M2vfvI=;
        b=Pxk8qBM3nqlmYBsvNWyuxnrkwidpDk51MG0QHv1fDMadcchDdktxN2ajrtxP2kRY+s
         vdv1crfC4/aQvV6BqHquqhEXMbcX+OqxAQwVtPneHkb88iyndTvF/oOV2NsGDkKcHKJH
         Okesr4PPTvLm+SNbEn8hPUEkYPkeJFqkvX56tTR9ucbHTSMme5UfkkTRL8k4bgnZtY+g
         W7GmF4yvBj/CCWWmLaksBe34TH32e69AyjqQ/FFPZSYOSWW+rZ+qPYhmdgFPU660MiXL
         +5LbrCslKYMiwoopNhmPMPu53hrE68R4nubtTfhdpHjXsvM4NhqU+eGfs+FlpCF55Xua
         +UBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SyUec5c/aPhd3mmtCmh5hrx61kd4SJGtSz9m/M2vfvI=;
        b=LSj7hbA3rcfNW1s3mhL53X94HdzQNwLIQuledgf6AUKIz9wcZ+DIYTRUJEMlNB7LdO
         jf9vlmO/CzzJbu13Y+7qHFsnPK+hqyPZ7e8MZkewQyrvuoEf+2rAGCoE1u8Q5jNX/iPG
         pSb9DQNPi5RiUP4H1htIwn+/GRwM7NXJIwBz/TvJbgU6LNbEpdqplXHmWofEeHjDgQw4
         1AdseZTrVaHNQ9kPIklXTlNUFGP5AthC18vckBBm8xV7uXhDpT2LU+bphigv404yk3eK
         C56ZV9SJdULQT6/ZzqFV4Fdw2ZqOr9F0VCzOy/R2ppMDe1RwZLkxwim0LpIl3QSrc2J/
         7l5g==
X-Gm-Message-State: AOAM533jinM8kwoeA7tmRM1+uQp6ngaV1tquDxcOhpeoFVvi2eqsr3vt
        m3mPMvsjrFcaTcAfWqu5MTlj6acFP0reOfKHqxIWYw==
X-Google-Smtp-Source: ABdhPJzhbsfHrGCSGojM0v1tn0+N4CJkIltgdEdcqzVmVU0MNVY+4qCAxZ+oryv1VrB7drj0mvJbr8s/SBRWlzq2rs0=
X-Received: by 2002:a17:90a:3321:: with SMTP id m30mr5095177pjb.20.1592595904407;
 Fri, 19 Jun 2020 12:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200616204817.GA212825@google.com> <CY4PR13MB1175A71AE3937C0786721ABFFD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006161703.B2E51605@keescook> <CY4PR13MB1175DCC4066FC0839A6B2E84FD9A0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006162032.9BF6F8F4E@keescook> <CABVgOSn48gw3pMSCccmF8FK=3UPF+Spe47AiDQcMiXkk3k4yqQ@mail.gmail.com>
In-Reply-To: <CABVgOSn48gw3pMSCccmF8FK=3UPF+Spe47AiDQcMiXkk3k4yqQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 19 Jun 2020 12:44:53 -0700
Message-ID: <CAFd5g4610GBAcyY9DDoQjoCVC0AG-=5FYJAZnS_5+L-aU7e4XA@mail.gmail.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     David Gow <davidgow@google.com>
Cc:     Kees Cook <keescook@chromium.org>, "Bird, Tim" <Tim.Bird@sony.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 16, 2020 at 9:06 PM David Gow <davidgow@google.com> wrote:
>
> On Wed, Jun 17, 2020 at 11:36 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Jun 17, 2020 at 02:30:45AM +0000, Bird, Tim wrote:
> > > Agreed.  You only need machine-parsable data if you expect the CI
> > > system to do something more with the data than just present it.
> > > What that would be, that would be common for all tests (or at least
> > > many test), is unclear.  Maybe there are patterns in the diagnostic
> > > data that could lead to higher-level analysis, or even automated
> > > fixes, that don't become apparent if the data is unstructured.  But
> > > it's hard to know until you have lots of data.  I think just getting
> > > the other things consistent is a good priority right now.
> >
> > Yeah. I think the main place for this is performance analysis, but I
> > think that's a separate system entirely. TAP is really strictly yes/no,
> > where as performance analysis a whole other thing. The only other thing
> > I can think of is some kind of feature analysis, but that would be built
> > out of the standard yes/no output. i.e. if I create a test that checks
> > for specific security mitigation features (*cough*LKDTM*cough*), having
> > a dashboard that shows features down one axis and architectures and/or
> > kernel versions on other axes, then I get a pretty picture. But it's
> > still being built out of the yes/no info.
> >
> > *shrug*
> >
> > I think diagnostic should be expressly non-machine-oriented.
>
> So from the KUnit side, we sort-of have three kinds of diagnostic lines:
> - Lines printed directly from tests (typically using kunit_info() or
> similar functions): as I understand it, these are basically the
> equivalent of what kselftest typically uses diagnostics for --
> test-specific, human-readable messages. I don't think we need/want to
> parse these much.
> - Kernel messages during test execution. If we get the results from
> scraping the kernel log (which is still the default for KUnit, though
> there is also a debugfs info), other kernel logs can be interleaved
> with the results. Sometimes these are irrelevant things happening on
> another thread, sometimes they're something directly related to the
> test which we'd like to capture (KASAN errors, for instance). I don't
> think we want these to be machine oriented, but we may want to be able
> to filter them out.
> - Expectation failures: as Brendan mentioned, KUnit will print some
> diagnostic messages for individual assertion/expectation failures,
> including the expected and actual values. We'd ideally like to be able
> to identify and parse these, but keeping them human-readable is
> definitely also a goal.

Seems like a fair characterization to me.

> Now, to be honest, I doubt that the distinction here would be of much
> use to kselftest, but it could be nice to not go out of our way to
> make parsing some diagnostic lines possible. That being said,
> personally I'm all for avoiding the yaml for diagnostic messages stuff
> and sticking to something simple and line-based, possibly
> standardising a the format of a few common diagnostic measurements
> (e.g., assertions/expected values/etc) in a way that's both
> human-readable and parsable if possible.

Agreed.

> I agree that there's a lot of analysis that is possible with just the
> yes/no data. There's probably some fancy correlation one could do even
> with unstructured diagnostic logs, so I don't think overstructuring
> things is a necessity by any means. Where we have different tests
> doing similar sorts of things, though, consistency in message
> formatting could help even if things are not explicitly parsed.
> Ensuring that helper functions that log and the like are spitting
> things out in the same format is probably a good starting step down
> that path.

Super agreed. I am sure that there are people who can do some very
clever things with what is being described here, but I would prefer
not to overcomplicate the spec right out of the gate. It feels like we
only have two TAP versions to reconcile here, and we are mostly in
agreement on how to do that.
