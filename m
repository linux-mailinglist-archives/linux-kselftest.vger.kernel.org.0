Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02696AAEC3
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Mar 2023 10:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCEJ07 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Mar 2023 04:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCEJ07 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Mar 2023 04:26:59 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE35113DDC;
        Sun,  5 Mar 2023 01:26:56 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id s12so7529654qtq.11;
        Sun, 05 Mar 2023 01:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678008415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqH/fUNw1v+IeKE/kiXgUEg5Js8jhAM4t/LI9qQb7pQ=;
        b=3Y4emuKqfRXeH7fuWtyAYbjB2SfdQkxzc8Pswk6X/OgAHgVsehMY8Kinc0nfJJdU/c
         AWfeXElwaYj254FaEJU4alCPK5v8st/0OkRJzaQYm4M1rMSMtKfhD3MdNuGIYDPdf752
         uBiQIFfJe+mmsOSzCNXrWBRf0S/RL2SlZjnvl9/2iqTjmLnLvpnGxA3nYn+UGMNQMUSh
         J9vLtTE+NJRELfgPsEG7/8UMP16nrWM1jFb5XSnG+KSRe3+FAD/Gn/NO1AF4dN9jEPLV
         lzkfl/YJy8W8hUkYRrsbLvgtIeNu6l2d9yV+tsuhAIDC2QZ9dzKJPMIZdswuUuj8gbrZ
         UZ2Q==
X-Gm-Message-State: AO0yUKVCAroO5Hoc7r//Fdss9r8GFWI2R02TJ/I77LLKTlMYGEx9dVkh
        CCbqt+aaBTFX0P3J82msIVIoecxMrToh0g==
X-Google-Smtp-Source: AK7set/ePzqKDAnQzuzP4vPRHgyCXZnI6zTHj40AgUo9CerF8kxJWf9UucB1j0WMnznem3ZRuSLjZw==
X-Received: by 2002:ac8:5dd1:0:b0:3bf:db29:b79e with SMTP id e17-20020ac85dd1000000b003bfdb29b79emr12765131qtx.5.1678008415672;
        Sun, 05 Mar 2023 01:26:55 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id t190-20020a3746c7000000b0074235745fdasm5216626qka.58.2023.03.05.01.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 01:26:54 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 82so5444138ybn.6;
        Sun, 05 Mar 2023 01:26:53 -0800 (PST)
X-Received: by 2002:a5b:c42:0:b0:a43:52fe:c36f with SMTP id
 d2-20020a5b0c42000000b00a4352fec36fmr3381016ybr.7.1678008413630; Sun, 05 Mar
 2023 01:26:53 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <CABVgOSnpMNCtEEsJV28OzUoxdDuiT4a2T0avP0AYf9xFW1jxrw@mail.gmail.com>
 <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com>
 <3759b28cca7ab751296d4dd83f2dcc51.sboyd@kernel.org> <CAMuHMdXDx6ChRj4xvWbQgcdJd0CGFi-RXySXr=M8QhBkA7YiGw@mail.gmail.com>
 <a2fdbd70-ca44-0d13-5b6f-4177761ecc18@gmail.com>
In-Reply-To: <a2fdbd70-ca44-0d13-5b6f-4177761ecc18@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 5 Mar 2023 10:26:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUMrG9yuXDhDRd+mAUGo5_A6ONjAXXZkJTPXQsO_0C41A@mail.gmail.com>
Message-ID: <CAMuHMdUMrG9yuXDhDRd+mAUGo5_A6ONjAXXZkJTPXQsO_0C41A@mail.gmail.com>
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, David Gow <davidgow@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Frank,

On Sun, Mar 5, 2023 at 4:33 AM Frank Rowand <frowand.list@gmail.com> wrote:
> On 3/2/23 13:47, Geert Uytterhoeven wrote:
> > On Thu, Mar 2, 2023 at 8:28 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >> Quoting Rob Herring (2023-03-02 09:32:09)
> >>> On Thu, Mar 2, 2023 at 2:14 AM David Gow <davidgow@google.com> wrote:
> >>>> On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
> >>>>> This patch series adds unit tests for the clk fixed rate basic type and
> >>>>> the clk registration functions that use struct clk_parent_data. To get
> >>>>> there, we add support for loading a DTB into the UML kernel that's
> >>>>> running the unit tests along with probing platform drivers to bind to
> >>>>> device nodes specified in DT.
> >>>>>
> >>>>> With this series, we're able to exercise some of the code in the common
> >>>>> clk framework that uses devicetree lookups to find parents and the fixed
> >>>>> rate clk code that scans devicetree directly and creates clks. Please
> >>>>> review.
> >>>>>
> >>>>
> >>>> Thanks Stephen -- this is really neat!
> >>>>
> >>>> This works well here, and I love all of the tests for the
> >>>> KUnit/device-tree integration as well.
> >>>>
> >>>> I'm still looking through the details of it (alas, I've mostly lived
> >>>> in x86-land, so my device-tree knowledge is, uh, spotty to say the
> >>>> least), but apart from possibly renaming some things or similarly
> >>>> minor tweaks, I've not got any real suggestions thus far.
> >>>>
> >>>> I do wonder whether we'll want, on the KUnit side, to have some way of
> >>>> supporting KUnit device trees on non-UML architecctures (e.g., if we
> >>>> need to test something architecture-specific, or on a big-endian
> >>>> platform, etc), but I think that's a question for the future, rather
> >>>> than something that affects this series.
> >>>
> >>> I'll say that's a requirement. We should be able to structure the
> >>> tests to not interfere with the running system's DT. The DT unittest
> >>> does that.
> >>
> >> That could be another choice in the unit test choice menu.
> >> CONFIG_OF_KUNIT_NOT_UML that injects some built-in DTB overlay on an
> >> architecture that wants to run tests.
> >
> > As long as you use compatible values that don't exist elsewhere,
> > and don't overwrite anything, you can load your kunit test overlays
> > on any running system that has DT support.
> >
> >>> As a side topic, Is anyone looking at getting UML to work on arm64?
> >>> It's surprising how much x86 stuff there is which is I guess one
> >>> reason it hasn't happened.
> >>
> >> I've no idea but it would be nice indeed.
> >
> > I believe that's non-trivial. At least for arm32 (I didn't have any arm64
> > systems last time I asked the experts).
> >
> >>>> Similarly, I wonder if there's something we could do with device tree
> >>>> overlays, in order to make it possible for tests to swap nodes in and
> >>>> out for testing.
> >>>
> >>> Yes, that's how the DT unittest works. But it is pretty much one big
> >>> overlay (ignoring the overlay tests). It could probably be more
> >>> modular where it is apply overlay, test, remove overlay, repeat.
> >>
> >> I didn't want to rely on the overlay code to inject DT nodes. Having
> >> tests written for the fake KUnit machine is simple. It closely matches
> >> how clk code probes the DTB and how nodes are created and populated on
> >> the platform bus as devices. CLK_OF_DECLARE() would need the overlay to
> >> be applied early too, which doesn't happen otherwise as far as I know.
> >
> > Don't all generic clock drivers also create a platform driver?
> > At least drivers/clk/clk-fixed-factor.c does.
> >
> >> But perhaps this design is too much of an end-to-end test and not a unit
> >> test? In the spirit of unit testing we shouldn't care about how the node
> >> is added to the live devicetree, just that there is a devicetree at all.
> >>
> >> Supporting overlays to more easily test combinations sounds like a good
> >> idea. Probably some kunit_*() prefixed functions could be used to
> >> apply a test managed overlay and automatically remove it when the test
> >> is over would work. The clk registration tests could use this API to
> >> inject an overlay and then manually call the of_platform_populate()
> >> function to create the platform device(s). The overlay could be built in
> >> drivers/clk/ too and then probably some macroish function can find the
> >> blob and apply it.
> >
> > No need to manually call of_platform_populate() to create the
> > platform devices. That is taken care of automatically when applying
> > an overlay.
> >
> >> Is there some way to delete the platform devices that we populate from
> >> the overlay? I'd like the tests to be hermetic.
>
> > Removing the overlay will delete the platform devices.
>
> I _think_ that is incorrect.  Do you have a pointer to the overlay code that
> deletes the device?  (If I remember correctly, the overlay remove code does not
> even check whether the device exists and whether a driver is bound to it -- but
> this is on my todo list to look into.)

https://elixir.bootlin.com/linux/latest/source/drivers/of/platform.c#L769

> > All of that works if you have your own code to apply a DT overlay.
> > The recent fw_devlinks patches did cause some regressions, cfr.
> > https://lore.kernel.org/all/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
