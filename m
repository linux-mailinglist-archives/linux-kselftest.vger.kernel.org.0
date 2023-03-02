Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0BC6A8A17
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 21:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCBUSy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 15:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBUSw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 15:18:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7CF1B33B;
        Thu,  2 Mar 2023 12:18:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FE1AB815BB;
        Thu,  2 Mar 2023 20:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E00C433D2;
        Thu,  2 Mar 2023 20:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677788327;
        bh=/Yn3UcMdQ1GXWH06I63xFkYGrZyXxsIhd8sDdU/N+rU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S3pI84K0PNBtKG1nQ9HGZ6kbE153E/SPIRWB3OJArdOlrjEGtVCXZ3xXkoOEj86On
         TxM99XZA4Mj88eHESIOKaet/GYTAVuYwP6NLi6JEayM2rWcTJsp3Kefqm9UGQDg681
         4p2iTjbJ1sc+bKGIknarjbzBDsubDF67/wgUez3qtElsuJFSxHyiQ1MdJ4vmsIbgXT
         ufMQpB3K2m2YZLE1n4IodBAM0uYyxQcKgdpWKKuy7uo1/n7xiYxc4HaKYo7tyN+YJP
         7WcTrrCyQYFTNy/Fie+Yl2vjzW1mtAnwhoJV+mmymjLkmlK+akoh1+AnsRKclhdZcS
         6UnxrOQTGDjGQ==
Received: by mail-vs1-f54.google.com with SMTP id m10so453290vso.4;
        Thu, 02 Mar 2023 12:18:47 -0800 (PST)
X-Gm-Message-State: AO0yUKWFf1vjlYP8r4XNtk2fF9gXU7q/KSH1OIL+AH/5yjB/uR6xdTwQ
        iqnjeLWKmbe3WPN0LIZcB9/0obhCcLyAPUWzkw==
X-Google-Smtp-Source: AK7set8CdZkV4nzAcxJAbmUjGudJ4PuiuPCHsE83ibLSseGKCb8fkRaEA/lrtnQAVCyfd8eCj0HxtuGm3QHjodqLBCw=
X-Received: by 2002:a05:6102:184:b0:414:4ef2:b607 with SMTP id
 r4-20020a056102018400b004144ef2b607mr7202543vsq.6.1677788326407; Thu, 02 Mar
 2023 12:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <CAL_JsqLVQVZhYTSZgrvA-V-xOUbiBdyDxqPOZk=89YS33EahBQ@mail.gmail.com>
 <093867df6137ad9e964b7dd90fb58f1a.sboyd@kernel.org>
In-Reply-To: <093867df6137ad9e964b7dd90fb58f1a.sboyd@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 2 Mar 2023 14:18:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLdPWRLu8TNqCG+dw9Pz2cS798QwGX=C5X18KKqAXwjSQ@mail.gmail.com>
Message-ID: <CAL_JsqLdPWRLu8TNqCG+dw9Pz2cS798QwGX=C5X18KKqAXwjSQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 2, 2023 at 1:44=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wrot=
e:
>
> Quoting Rob Herring (2023-03-02 09:13:59)
> > On Wed, Mar 1, 2023 at 7:38=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> =
wrote:
> > >
> > > This patch series adds unit tests for the clk fixed rate basic type a=
nd
> > > the clk registration functions that use struct clk_parent_data. To ge=
t
> > > there, we add support for loading a DTB into the UML kernel that's
> > > running the unit tests along with probing platform drivers to bind to
> > > device nodes specified in DT.
> > >
> > > With this series, we're able to exercise some of the code in the comm=
on
> > > clk framework that uses devicetree lookups to find parents and the fi=
xed
> > > rate clk code that scans devicetree directly and creates clks. Please
> > > review.
> > >
> > > I Cced everyone to all the patches so they get the full context. I'm
> > > hoping I can take the whole pile through the clk tree as they almost =
all
> > > depend on each other. In the future I imagine it will be easy to add
> > > more test nodes to the clk.dtsi file and not need to go across variou=
s
> > > maintainer trees like this series does.
> > >
> > > Stephen Boyd (8):
> > >   dt-bindings: Add linux,kunit binding
> > >   of: Enable DTB loading on UML for KUnit tests
> > >   kunit: Add test managed platform_device/driver APIs
> > >   clk: Add test managed clk provider/consumer APIs
> > >   dt-bindings: kunit: Add fixed rate clk consumer test
> > >   clk: Add KUnit tests for clk fixed rate basic type
> > >   dt-bindings: clk: Add KUnit clk_parent_data test
> > >   clk: Add KUnit tests for clks registered with struct clk_parent_dat=
a
> >
> > Good to see bindings for this. I've been meaning to do something about
> > the DT unittest ones being undocumented, but I hadn't really decided
> > whether it was worth writing schemas for them. The compatibles at
> > least show up with 'make dt_compatible_check'. Perhaps we want to just
> > define some vendor (not 'linux') that's an exception rather than
> > requiring schemas (actually, that already works for 'foo').
>
> Sure. Maybe "kunit" should be the vendor prefix? Or "dtbunit"?

We'd want to use the same thing on the DT unittests or anything else
potentially. How about just 'test'?

> > It's
> > likely that we want test DTs that fail normal checks and schemas get
> > in the way of that as we don't have a way to turn off checks.
>
> Having the schemas is nice to make sure tests that are expecting some
> binding are actually getting that. But supporting broken bindings is
> also important to test any error paths in functions that parse
> properties. Maybe we keep the schema and have it enforce that incorrect
> properties are being set?

I wasn't suggesting throwing them out. More why I hadn't written any I gues=
s.

> Do we really need to test incorrect bindings? Doesn't the
> dt_bindings_check catch these problems so we don't have to write DTB
> verifiers in the kernel?

Fair enough. Using my frequently stated position against me. :)

I do have a secret plan to implement (debug) type checks into the
of_property_* APIs by extracting the type information from schemas
into C.


> > We already have GPIO tests in the DT unittests, so why is clocks
> > different? Or should the GPIO tests be moved out (yes, please!)?
>
> Ah I didn't notice the GPIO tests in there. There are i2c tests too,
> right? All I can say is clks are using kunit, that's the difference ;-)

Yeah, they should perhaps all move to the subsystems.

> > What happens when/if the DT unittest is converted to kunit? I think
> > that would look confusing from the naming. My initial thought is
> > 'kunit' should be dropped from the naming of a lot of this. Note that
> > the original kunit submission converted the DT unittests. I would
> > still like to see that happen. Frank disagreed over what's a unit test
> > or not, then agreed, then didn't... I don't really care. If there's a
> > framework to use, then we should use it IMO.
>
> Honestly I don't want to get involved in migrating the existing DT
> unittest code to kunit. I'm aware that it was attempted years ago when
> kunit was introduced. Maybe if the overlay route works well enough I can
> completely sidestep introducing any code in drivers/of/ besides some
> kunit wrappers for this. I'll cross my fingers!

Yeah, I wasn't expecting you to. I just want to make sure this meshes
with any future conversion to kunit.

There's also some plans to always populate the DT root node if not
present. That may help here. Or not. There's been a few versions
posted with Frank's in the last week or 2.

Rob
