Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD986B590C
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Mar 2023 07:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCKGml (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Mar 2023 01:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCKGmk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Mar 2023 01:42:40 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA2C11CD5D
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 22:42:38 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k37so4769874wms.0
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Mar 2023 22:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678516956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rLCDgBE2CpEpsYEH2GzNb2mRA3Ov/LpZ5EV9ph3pyrE=;
        b=GJw9guvyr0s5eebXuJrA9NOkpl95WPNpiig/eTGB5Oom88V/Zp6f+dhqK5P/TXiP9I
         +lME1MquTJSG6dt2pPa57FLIAwj/biU0Qf962U4moIZrFm+oWItD8o5l+Y34iS4LOMOj
         Dljq872LDn+dRGWMQtNJuQE+g+5Is0J8POfj2Gl0v+5e1j5IJ4rbjOzgMWHRGEgZhsNE
         3RL/kxG3uz2rxtrTqxJwBzbtg4LSrZ/ZL9Mg/las7shVi1Poyt9Yz6xxm/+04xdFR1jG
         IrkPMxmJ5nttDheyrDkTehYfgNS+FJF4Ruv0PMXdmNsYgh1gpy9TOUQ9fl6wHqu01k3y
         HK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678516956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLCDgBE2CpEpsYEH2GzNb2mRA3Ov/LpZ5EV9ph3pyrE=;
        b=LYjhLbB/YG7LMXHkX3I/PNP/UNTh1b0+P2w763xOmHMTJipJ3DZTXL4pwWYDXloRRf
         37N4u77C+RCiX2C45u9deoYxdB5C52RCGk61fMDUMIhj2ba3TgQm6pF0c9H7cGv/Bfah
         geUEY+NuUQj5VjSBfjAGvSMBiVWhhCOPtFBIecFJVxPQvy62hO5xHkeucudKnMqC/8me
         hBgE17VuhOyWnyMvHZrEotPSfTlsuSjhTWvlZ11xs10Megd2DttxwFN5G+iHXzC6ajcW
         7HQAPUcALR9wV7iVWKpvm8EO+FfrJ+OdH3NeLXnhG9GzBsgvqtYe4iR55xOetOshTott
         aoFw==
X-Gm-Message-State: AO0yUKVLvXl5vAV8SitVdqMLB7eIFM2g7MSMdr7EID39BkHz8w6Ejvtg
        wkCe5WguK/gf+eOA9oRrYYV/G+B4xTA8sFcrL+rmkA==
X-Google-Smtp-Source: AK7set9wYQn7im6e0NM13fx/mhFULhLhun1pudfxqWhKunmEGg+fxkJOhN9RKEAuwsiPqa/qDohJi4l7xBDedI9OZmU=
X-Received: by 2002:a05:600c:a382:b0:3eb:2e68:5c76 with SMTP id
 hn2-20020a05600ca38200b003eb2e685c76mr1461577wmb.3.1678516956022; Fri, 10 Mar
 2023 22:42:36 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230302013822.1808711-3-sboyd@kernel.org>
 <CABVgOSkomwwgKZ9N0_0YMDL--QaZiTV7ONgSRABU2Ph1Z0CG-g@mail.gmail.com>
 <a97c9bb3a5addfb34af8ccabaa513026.sboyd@kernel.org> <CABVgOSkJ4mw_DtFzn5EwcsuYixWY_j13YotxEYqWhO+ZCL1KPg@mail.gmail.com>
 <d64a086ddcb7c5ca5abecab0ca654259.sboyd@kernel.org>
In-Reply-To: <d64a086ddcb7c5ca5abecab0ca654259.sboyd@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 11 Mar 2023 14:42:24 +0800
Message-ID: <CABVgOSk9gqRe_5yQZweBA2Qg2aGx8rUJtOHywGeT4x7TEyBH0A@mail.gmail.com>
Subject: Re: [PATCH 2/8] of: Enable DTB loading on UML for KUnit tests
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 11 Mar 2023 at 07:34, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting David Gow (2023-03-10 00:09:48)
> > On Fri, 10 Mar 2023 at 07:19, Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > >
> > > Hmm. I think you're suggesting that the unit test data be loaded
> > > whenever CONFIG_OF=y and CONFIG_KUNIT=y. Then tests can check for
> > > CONFIG_OF and skip if it isn't enabled?
> > >
> >
> > More of the opposite: that we should have some way of supporting tests
> > which might want to use a DTB other than the built-in one. Mostly for
> > non-UML situations where an actual devicetree is needed to even boot
> > far enough to get test output (so we wouldn't be able to override it
> > with a compiled-in test one).
>
> Ok, got it.
>
> >
> > I think moving to overlays probably will render this idea obsolete:
> > but the thought was to give test code a way to check for the required
> > devicetree nodes at runtime, and skip the test if they weren't found.
> > That way, the failure mode for trying to boot this on something which
> > required another device tree for, e.g., serial, would be "these tests
> > are skipped because the wrong device tree is loaded", not "I get no
> > output because serial isn't working".
> >
> > Again, though, it's only really needed for non-UML, and just loading
> > overlays as needed should be much more sensible anyway.
>
> I still have one niggle here. Loading overlays requires
> CONFIG_OF_OVERLAY, and the overlay loading API returns -ENOTSUPP when
> CONFIG_OF_OVERLAY=n. For now I'm checking for the config being enabled
> in each test, but I'm thinking it may be better to simply call
> kunit_skip() from the overlay loading function if the config is
> disabled. This way tests can simply call the overlay loading function
> and we'll halt the test immediately if the config isn't enabled.
>

That sounds sensible, though there is a potential pitfall. If
kunit_skip() is called directly from overlay code, might introduce a
dependency on kunit.ko from the DT overlay, which we might not want.
The solution there is either to have a kunit wrapper function (so the
call is already in kunit.ko), or to have a hook to skip the current
test (which probably makes sense to do anyway, but I think the wrapper
is the better option).


> >
> > > >
> > > > That being said, I do think that there's probably some sense in
> > > > supporting the compiled-in DTB as well (it's definitely simpler than
> > > > patching kunit.py to always pass the extra command-line option in, for
> > > > example).
> > > > But maybe it'd be nice to have the command-line option override the
> > > > built-in one if present.
> > >
> > > Got it. I need to test loading another DTB on the commandline still, but
> > > I think this won't be a problem. We'll load the unittest-data DTB even
> > > with KUnit on UML, so assuming that works on UML right now it should be
> > > unchanged by this series once I resend.
> >
> > Again, moving to overlays should render this mostly obsolete, no? Or
> > am I misunderstanding how the overlay stuff will work?
>
> Right, overlays make it largely a moot issue. The way the OF unit tests
> work today is by grafting a DTB onto the live tree. I'm reusing that
> logic to graft a container node target for kunit tests to add their
> overlays too. It will be clearer once I post v2.
>
> >
> > One possible future advantage of being able to test with custom DTs at
> > boot time would be for fuzzing (provide random DT properties, see what
> > happens in the test). We've got some vague plans to support a way of
> > passing custom data to tests to support this kind of case (though, if
> > we're using overlays, maybe the test could just patch those if we
> > wanted to do that).
>
> Ah ok. I can see someone making a fuzzer that modifies devicetree
> properties randomly, e.g. using different strings for clock-names.
>
> This reminds me of another issue I ran into. I wanted to test adding the
> same platform device to the platform bus twice to confirm that the
> second device can't be added. That prints a warning, which makes
> kunit.py think that the test has failed because it printed a warning. Is
> there some way to avoid that? I want something like
>
>         KUNIT_EXPECT_WARNING(test, <call some function>)
>
> so I can test error cases.

Hmm... I'd've thought that shouldn't be a problem: kunit.py should
ignore most messages during a test, unless it can't find a valid
result line. What does the raw KTAP output look like? (You can get it
from kunit.py by passing the --raw_output option).

That being said, a KUNIT_EXPECT_LOG_MESSAGE() or similar is something
we've wanted for a while. I think that the KASAN folks have been
working on something similar using console tracepoints:
https://lore.kernel.org/all/ebf96ea600050f00ed567e80505ae8f242633640.1666113393.git.andreyknvl@google.com/

Cheers,
-- David
