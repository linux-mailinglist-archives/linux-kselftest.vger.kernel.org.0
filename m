Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8FD4F9D6D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 21:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiDHTGY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 15:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiDHTGX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 15:06:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A8DF8EEC
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 12:04:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bq8so19081201ejb.10
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Apr 2022 12:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rHGD3PoFwL+nB4RQq7j9aGht0hUkl4t6Erm9eBYAxo=;
        b=YsHLti3LKEtuuI4cKwjbPzSTusGPZZx1XbNGIHygbTntEkwqUL6G+VU4mEaO323Gy2
         jMp5qBNSl8scs0iftHUH2fWSLiCkT30fxcbsdOnjPyQ2HnRE8DaLMWgZPkK/zPilHRnj
         W/FwFsNLtS4UKF3Eh9fZiYg4w0ApKjdKCrkiRF8cPHBqOTk/2s4JQ53X0hj68VKRnd3O
         UmVdSKO0abUUF6C6VR+2DFdkVW/wa5hbTIRs5IUyHciqzh9afQGf3L7Kjw4Ze5MECgY8
         CiXhioEJn6JSZ6Cbn3uAvBSCE/7fHfeSPAj7MsW4um6Rp4oHilW4FvTFJM+d8JUUkww6
         I/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rHGD3PoFwL+nB4RQq7j9aGht0hUkl4t6Erm9eBYAxo=;
        b=3J8HLfGkzCCaM+lzbV/HcKHvvcju4Iak93m55GP9JufNSEa3cfDH/C75MWXEfgDRgl
         YZzUxRHK8qenfYA6O5mvMnoK3fa3slH22BZi23gkE6zruV925iplZCN4stytWW4RaVV8
         EgE0FXBAdlPkhjHLqX95n3JRIUGvqiqEgOgxZLWuE3kHZTd4Iyw4+nXmg5BCBpE0Wr9a
         OUVGWEcem+DxRz2ftg6SDo0GkpqEs9gaeLnXM6CkYbPJYAgpEs4ZMewlzWtFJW+KbHn5
         5a5n1O1PSIekpepAkUY9q5p5Qxmm3/dXJLY2D4Qujfy95WnzNhi7HpYl2sKNLNsaua3V
         cdWQ==
X-Gm-Message-State: AOAM5329E6JAIl+O6YsaK5NLtsQUDrTpE3q8lArACWMflWnpHxOCUWY1
        dqUD4PovbRhVil2GXHo64UeroUOarQwTRcZJG1fPLVAQTVHBgg==
X-Google-Smtp-Source: ABdhPJzuTD8lGVC9WsX3DoSaWaE1gcO0BreSCSSb7v406i3EgLAy2ifm0g/gB9FjnVbYnbabeuKq/C7fMy8S3tEq+/8=
X-Received: by 2002:a17:906:a2c2:b0:6e7:efc2:17f2 with SMTP id
 by2-20020a170906a2c200b006e7efc217f2mr18810277ejb.542.1649444657126; Fri, 08
 Apr 2022 12:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220407223019.2066361-1-dlatypov@google.com> <20220408034848.2081355-1-davidgow@google.com>
 <CAGS_qxrNOPq+akyt2Ee4NXySP+Zxqis2H5CwKs_kNWNvJ+bo5A@mail.gmail.com> <CABVgOSkKuHCkfpQhzNmzufaVw_6qO-Ve_t5oTub1JeweTiC9RQ@mail.gmail.com>
In-Reply-To: <CABVgOSkKuHCkfpQhzNmzufaVw_6qO-Ve_t5oTub1JeweTiC9RQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 8 Apr 2022 14:04:06 -0500
Message-ID: <CAGS_qxqmbgy6KOp1bPF4Pk5SZT+r8L7ASqEyNWF9BtCS2JgXaw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Print a total count of tests.
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

)On Thu, Apr 7, 2022 at 11:18 PM David Gow <davidgow@google.com> wrote:
>
> On Fri, Apr 8, 2022 at 11:59 AM 'Daniel Latypov' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > On Thu, Apr 7, 2022 at 10:48 PM 'David Gow' via KUnit Development
> > <kunit-dev@googlegroups.com> wrote:
> > >
> > > Add a count of the total number of tests run (including skipped tests,
> > > which do run a little bit until they decide to skip themselves) to the
> > > summary line.
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>
> > > ---
> > >
> > > This patch depends on:
> > > https://lore.kernel.org/linux-kselftest/20220407223019.2066361-1-dlatypov@google.com/
> > >
> > >  tools/testing/kunit/kunit_parser.py | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> > > index 957907105429..da01998d29b1 100644
> > > --- a/tools/testing/kunit/kunit_parser.py
> > > +++ b/tools/testing/kunit/kunit_parser.py
> > > @@ -96,7 +96,7 @@ class TestCounts:
> > >                 """
> > >                 statuses = [('Passed', self.passed), ('Failed', self.failed),
> > >                         ('Crashed', self.crashed), ('Skipped', self.skipped),
> > > -                       ('Errors', self.errors)]
> > > +                       ('Errors', self.errors), ('Total', self.total())]
> >
> > Hmm, I've never really felt the need for a total to be printed out.
> > We've had few enough tests and different statuses that the mental
> > addition is easy enough.
>
> It's useful just often enough as a sanity check (were those failures /
> skipped tests fixed, or did we just stop running them): having one
> number to check for "did some more tests run at all" is quite
> convenient. Particularly when dealing with nasty dependency chains and
> "all tests" builds.
>
> This is also particularly useful when running on setups where
> scrollback is more of a pain, as the summary line is absolutely
> invaluable there.

Ack. My point was about the summary line.
We have so few tests that only a handful statuses, that adding up 2-3
small numbers always felt simple enough.
Esp. since the previous patch skips printing out the statues with 0s,
that becomes even easier.

But I'm not against having the total.
I just personally find the current output looks very awkward and would
prefer the status-quo over that specific output format.

>
> >
> > Bikeshedding:
> > This current output of
> >   Passed: 40, Skipped: 2, Total: 42
> > feels a bit awkward to me.
> > If we did print one out, I think it should probably go first, e.g.
> >   Ran 42 tests: 40 passed, 2 skipped.
> >
> > Wdyt?
>
> I personally don't find having "Total" at the end awkward -- putting
> the sum at the end has been done on ledgers for years -- but do admit
> it's even more convenient to have it first (so it's at the same place
> on the screen every run, regardless of the rest). So "Ran 42 tests: 40
> passed..." would emphasise the "total" over the "passed" count here.
> Personally, I think that's probably a good thing: I think what most
> people really want at a glance is effectively "Failed / Total" (or,

I think a reader can already easily note the difference between
  Ran 42 tests: 40 passed, 2 skipped.
and
  Ran 42 tests: 20 passed, 20 failed, 2 skipped.

I.e. the mere existence of a second or third number in the breakdown
after "XX passed" feels like enough of an affordance.
(This is perhaps naively assuming that tests are kept healthy)

> more realistically a sort-of "Problems / Total", where problems is
> Failed + Error). But the combination of the colour (did it pass
> overall) and the total are the things I'd usually want to look for
> first.
>
> So, tl;dr: I'd be all for the "Ran n tests: a passed, b failed, etc" wording.

Ack.
Let's see if Brendan or others on the list have a preference.

If we want to go down that route, it might be easier if I combine this
in the previous patch
(https://lore.kernel.org/linux-kselftest/20220407223019.2066361-1-dlatypov@google.com/

E.g. I get this output
Ran 173 tests: passed: 137, skipped: 36

with a new combined patch of

diff --git a/tools/testing/kunit/kunit_parser.py
b/tools/testing/kunit/kunit_parser.py
index 807ed2bd6832..de1c0b7e14ed 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -94,11 +94,11 @@ class TestCounts:
        def __str__(self) -> str:
                """Returns the string representation of a TestCounts object.
                """
-               return ('Passed: ' + str(self.passed) +
-                       ', Failed: ' + str(self.failed) +
-                       ', Crashed: ' + str(self.crashed) +
-                       ', Skipped: ' + str(self.skipped) +
-                       ', Errors: ' + str(self.errors))
+               statuses = [('passed', self.passed), ('failed', self.failed),
+                       ('crashed', self.crashed), ('skipped', self.skipped),
+                       ('errors', self.errors)]
+               return f'Ran {self.total()} tests: ' + \
+                       ', '.join(f'{s}: {n}' for s, n in statuses if n > 0)

        def total(self) -> int:
                """Returns the total number of test cases within a test

>
> Cheers,
> -- David
