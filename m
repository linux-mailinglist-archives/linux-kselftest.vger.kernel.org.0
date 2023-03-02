Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3394A6A89D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 20:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjCBTzM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 14:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjCBTzK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 14:55:10 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE384617C;
        Thu,  2 Mar 2023 11:54:57 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id e26-20020a9d6e1a000000b00694274b5d3aso255324otr.5;
        Thu, 02 Mar 2023 11:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f95O1774ZoBykD/usZaosY+efoKseNjJy4cpA8XSzCQ=;
        b=FgbexaQzVJUNTFzbAskaj+T3Zi60/Bd3rajZq0JcdC4I0C93qyD9DzTw2Wg2pz7Nd2
         vR4RyxU4wcjqcFyBWQ+3ZEIt0yiNxfZ2LVy7BVpPVQYh7lekdZU7g/C1fWOxPKNr13CY
         a98lTorpBB4H4Ejgcu1vlhYThmC2vQIYcnvud2ct3C170zSfdlI9QIX95RxBZj+s6vK5
         XkxQPdJmQ8X8FnIgEUOTjVaZreGmBfVOaPxiOpJvMi3yS+4T4Roi5OKDCvSH5J4EQC9z
         qDvwUVCmblp1wQTmBiQI6WG7qjeFygH7zjVFqp/qClN8JY0DA1Rfum6IdNG/Yuf9o3IB
         u0Aw==
X-Gm-Message-State: AO0yUKXhZdsK2JH5VH5zITv7UixBP9kaPxqvSXxJ2SQiLC7wq9eKwoS7
        x6ihHBiatxPW2lwjNRjoo2TtpOHIBbD08g==
X-Google-Smtp-Source: AK7set9BMks7DIP0m0ljiUJhiADS25rAAGbyfRTHayVnxIqrV5/fqmCl2rCltECfaeWxKfN3RxfPPA==
X-Received: by 2002:a9d:7187:0:b0:694:39d1:a225 with SMTP id o7-20020a9d7187000000b0069439d1a225mr1869810otj.17.1677786896289;
        Thu, 02 Mar 2023 11:54:56 -0800 (PST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id r21-20020a9d7cd5000000b006865223e532sm244573otn.51.2023.03.02.11.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 11:54:56 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id bj30so98978oib.6;
        Thu, 02 Mar 2023 11:54:56 -0800 (PST)
X-Received: by 2002:a81:ad1b:0:b0:52f:1c23:ef1 with SMTP id
 l27-20020a81ad1b000000b0052f1c230ef1mr7066170ywh.5.1677786463634; Thu, 02 Mar
 2023 11:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <CABVgOSnpMNCtEEsJV28OzUoxdDuiT4a2T0avP0AYf9xFW1jxrw@mail.gmail.com>
 <CAL_JsqJMd3Fi0ZBObdyE1VDKTH1_+smuGDymHnKOkVH2HB3jJQ@mail.gmail.com> <3759b28cca7ab751296d4dd83f2dcc51.sboyd@kernel.org>
In-Reply-To: <3759b28cca7ab751296d4dd83f2dcc51.sboyd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Mar 2023 20:47:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXDx6ChRj4xvWbQgcdJd0CGFi-RXySXr=M8QhBkA7YiGw@mail.gmail.com>
Message-ID: <CAMuHMdXDx6ChRj4xvWbQgcdJd0CGFi-RXySXr=M8QhBkA7YiGw@mail.gmail.com>
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     David Gow <davidgow@google.com>, Rob Herring <robh+dt@kernel.org>,
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
        Frank Rowand <frowand.list@gmail.com>,
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

Hi Stephen,

On Thu, Mar 2, 2023 at 8:28 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Rob Herring (2023-03-02 09:32:09)
> > On Thu, Mar 2, 2023 at 2:14 AM David Gow <davidgow@google.com> wrote:
> > > On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
> > > > This patch series adds unit tests for the clk fixed rate basic type and
> > > > the clk registration functions that use struct clk_parent_data. To get
> > > > there, we add support for loading a DTB into the UML kernel that's
> > > > running the unit tests along with probing platform drivers to bind to
> > > > device nodes specified in DT.
> > > >
> > > > With this series, we're able to exercise some of the code in the common
> > > > clk framework that uses devicetree lookups to find parents and the fixed
> > > > rate clk code that scans devicetree directly and creates clks. Please
> > > > review.
> > > >
> > >
> > > Thanks Stephen -- this is really neat!
> > >
> > > This works well here, and I love all of the tests for the
> > > KUnit/device-tree integration as well.
> > >
> > > I'm still looking through the details of it (alas, I've mostly lived
> > > in x86-land, so my device-tree knowledge is, uh, spotty to say the
> > > least), but apart from possibly renaming some things or similarly
> > > minor tweaks, I've not got any real suggestions thus far.
> > >
> > > I do wonder whether we'll want, on the KUnit side, to have some way of
> > > supporting KUnit device trees on non-UML architecctures (e.g., if we
> > > need to test something architecture-specific, or on a big-endian
> > > platform, etc), but I think that's a question for the future, rather
> > > than something that affects this series.
> >
> > I'll say that's a requirement. We should be able to structure the
> > tests to not interfere with the running system's DT. The DT unittest
> > does that.
>
> That could be another choice in the unit test choice menu.
> CONFIG_OF_KUNIT_NOT_UML that injects some built-in DTB overlay on an
> architecture that wants to run tests.

As long as you use compatible values that don't exist elsewhere,
and don't overwrite anything, you can load your kunit test overlays
on any running system that has DT support.

> > As a side topic, Is anyone looking at getting UML to work on arm64?
> > It's surprising how much x86 stuff there is which is I guess one
> > reason it hasn't happened.
>
> I've no idea but it would be nice indeed.

I believe that's non-trivial. At least for arm32 (I didn't have any arm64
systems last time I asked the experts).

> > > Similarly, I wonder if there's something we could do with device tree
> > > overlays, in order to make it possible for tests to swap nodes in and
> > > out for testing.
> >
> > Yes, that's how the DT unittest works. But it is pretty much one big
> > overlay (ignoring the overlay tests). It could probably be more
> > modular where it is apply overlay, test, remove overlay, repeat.
>
> I didn't want to rely on the overlay code to inject DT nodes. Having
> tests written for the fake KUnit machine is simple. It closely matches
> how clk code probes the DTB and how nodes are created and populated on
> the platform bus as devices. CLK_OF_DECLARE() would need the overlay to
> be applied early too, which doesn't happen otherwise as far as I know.

Don't all generic clock drivers also create a platform driver?
At least drivers/clk/clk-fixed-factor.c does.

> But perhaps this design is too much of an end-to-end test and not a unit
> test? In the spirit of unit testing we shouldn't care about how the node
> is added to the live devicetree, just that there is a devicetree at all.
>
> Supporting overlays to more easily test combinations sounds like a good
> idea. Probably some kunit_*() prefixed functions could be used to
> apply a test managed overlay and automatically remove it when the test
> is over would work. The clk registration tests could use this API to
> inject an overlay and then manually call the of_platform_populate()
> function to create the platform device(s). The overlay could be built in
> drivers/clk/ too and then probably some macroish function can find the
> blob and apply it.

No need to manually call of_platform_populate() to create the
platform devices. That is taken care of automatically when applying
an overlay.

> Is there some way to delete the platform devices that we populate from
> the overlay? I'd like the tests to be hermetic.

Removing the overlay will delete the platform devices.

All of that works if you have your own code to apply a DT overlay.
The recent fw_devlinks patches did cause some regressions, cfr.
https://lore.kernel.org/all/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com

P.S. Shameless plug: for loading overlays from userspace, there are
     my overlay branches, cfr. https://elinux.org/R-Car/DT-Overlays

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
