Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EAD6ABFEE
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 13:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCFMxt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 07:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjCFMxs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 07:53:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77DA2279E;
        Mon,  6 Mar 2023 04:53:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5147D60EA7;
        Mon,  6 Mar 2023 12:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF7DC433A1;
        Mon,  6 Mar 2023 12:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678107224;
        bh=s7qvSmp961m8H2NWW5siPpAj/uuKqLUer2sGjcELtQo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sTmgHXrU8E/q7P+a54rXZ1Y5QGQX6Kp65qPs86UZB3UCQCjAXUFI66s+Jau1CW3on
         D20xBf0auHjA4vbCFfFA5xPiKk6iPAGwiDDn0hcw7xiAdYQ+gbv0B3SzCW1YlwmHmY
         nPp8TNTYjisUrQfPs4/CMz4LvPFNwrKZCuidj+EIPlZDlpfmBMKfWtTNT+q6mDzJyH
         K5OZmht0np93uQgb885/oJndBh6hQ5BQLlVk3HdOOP/DD4UYQ9WbDXSiUY4jpNmC2L
         r+pUP81yugH5zhej4yfVzmGLJcFH8v++E5oKzCHUWe5ogUMJn2mTeVdzV1X2/NBljv
         KDOHJeyt8HXJw==
Received: by mail-ua1-f51.google.com with SMTP id d12so6328851uak.10;
        Mon, 06 Mar 2023 04:53:44 -0800 (PST)
X-Gm-Message-State: AO0yUKXYS+NnV5A0XCgo7/1VOocLxWDVJI1hrtHEAUDYnIBJxZNMQ0fa
        L8fZ3ALSM2rAAC4ZrilKnMU2ugH0ZC1JysWdQQ==
X-Google-Smtp-Source: AK7set+fK06DShzsMycPKDmy9z6Wx0VC2Yhz2oQGSFH6EkFbq9PjDV5LaGfL/loi8rm7p84xqsd/FYfwofwON21sSwE=
X-Received: by 2002:ab0:544e:0:b0:68a:5c52:7f2b with SMTP id
 o14-20020ab0544e000000b0068a5c527f2bmr6711783uaa.1.1678107223577; Mon, 06 Mar
 2023 04:53:43 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <CAL_JsqLVQVZhYTSZgrvA-V-xOUbiBdyDxqPOZk=89YS33EahBQ@mail.gmail.com>
 <093867df6137ad9e964b7dd90fb58f1a.sboyd@kernel.org> <CAL_JsqLdPWRLu8TNqCG+dw9Pz2cS798QwGX=C5X18KKqAXwjSQ@mail.gmail.com>
 <ecb5ede44d5bcc0430dad99e53d4477d.sboyd@kernel.org> <c81211fa-2836-fe21-637f-a5cca7237d43@gmail.com>
In-Reply-To: <c81211fa-2836-fe21-637f-a5cca7237d43@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 Mar 2023 06:53:32 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+yhdSqiAVfUKh1DGaKTEGHOMPKAYpQPPB=ywA76C6EvA@mail.gmail.com>
Message-ID: <CAL_Jsq+yhdSqiAVfUKh1DGaKTEGHOMPKAYpQPPB=ywA76C6EvA@mail.gmail.com>
Subject: Re: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
To:     Frank Rowand <frowand.list@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J.Wysocki" <rafael@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
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

On Sat, Mar 4, 2023 at 9:39=E2=80=AFAM Frank Rowand <frowand.list@gmail.com=
> wrote:
>
> On 3/2/23 17:57, Stephen Boyd wrote:
> > Quoting Rob Herring (2023-03-02 12:18:34)
> >> On Thu, Mar 2, 2023 at 1:44=E2=80=AFPM Stephen Boyd <sboyd@kernel.org>=
 wrote:
> >>>
> >>> Quoting Rob Herring (2023-03-02 09:13:59)
> >>>>
> >>>> Good to see bindings for this. I've been meaning to do something abo=
ut
> >>>> the DT unittest ones being undocumented, but I hadn't really decided
> >>>> whether it was worth writing schemas for them. The compatibles at
> >>>> least show up with 'make dt_compatible_check'. Perhaps we want to ju=
st
> >>>> define some vendor (not 'linux') that's an exception rather than
> >>>> requiring schemas (actually, that already works for 'foo').
> >>>
> >>> Sure. Maybe "kunit" should be the vendor prefix? Or "dtbunit"?
> >>
> >> We'd want to use the same thing on the DT unittests or anything else
> >> potentially. How about just 'test'?
> >
> > Sounds good.
> >
> >>
> >>>> It's
> >>>> likely that we want test DTs that fail normal checks and schemas get
> >>>> in the way of that as we don't have a way to turn off checks.
> >>>
> >>> Having the schemas is nice to make sure tests that are expecting some
> >>> binding are actually getting that. But supporting broken bindings is
> >>> also important to test any error paths in functions that parse
> >>> properties. Maybe we keep the schema and have it enforce that incorre=
ct
> >>> properties are being set?
> >>
> >> I wasn't suggesting throwing them out. More why I hadn't written any I=
 guess.
> >>
> >>> Do we really need to test incorrect bindings? Doesn't the
> >>> dt_bindings_check catch these problems so we don't have to write DTB
> >>> verifiers in the kernel?
> >>
> >> Fair enough. Using my frequently stated position against me. :)
> >>
> >> I do have a secret plan to implement (debug) type checks into the
> >> of_property_* APIs by extracting the type information from schemas
> >> into C.
> >>
> >
> > Ok. I suspect we may want to test error paths though so I don't know
>
> Yes, exactly.
>
> > what to do here. For now I'll just leave the bindings in place and
> > change the prefix to "test".
> >
> >>
> >>>> We already have GPIO tests in the DT unittests, so why is clocks
> >>>> different? Or should the GPIO tests be moved out (yes, please!)?
> >>>
> >>> Ah I didn't notice the GPIO tests in there. There are i2c tests too,
> >>> right? All I can say is clks are using kunit, that's the difference ;=
-)
> >>
> >> Yeah, they should perhaps all move to the subsystems.
> >
> > Got it.
> >
> >>
> >>>> What happens when/if the DT unittest is converted to kunit? I think
> >>>> that would look confusing from the naming. My initial thought is
> >>>> 'kunit' should be dropped from the naming of a lot of this. Note tha=
t
> >>>> the original kunit submission converted the DT unittests. I would
> >>>> still like to see that happen. Frank disagreed over what's a unit te=
st
> >>>> or not, then agreed, then didn't... I don't really care. If there's =
a
> >>>> framework to use, then we should use it IMO.
> >>>
> >>> Honestly I don't want to get involved in migrating the existing DT
> >>> unittest code to kunit. I'm aware that it was attempted years ago whe=
n
> >>> kunit was introduced. Maybe if the overlay route works well enough I =
can
> >>> completely sidestep introducing any code in drivers/of/ besides some
> >>> kunit wrappers for this. I'll cross my fingers!
> >>
> >> Yeah, I wasn't expecting you to. I just want to make sure this meshes
> >> with any future conversion to kunit.
> >
> > Phew!
> >
> >>
> >> There's also some plans to always populate the DT root node if not
> >> present. That may help here. Or not. There's been a few versions
> >> posted with Frank's in the last week or 2.
> >>
> >
> > Ok. I think I have some time to try this overlay approach so let me see
> > what is needed.
>
> Please avoid overlays.  See my other replies in this thread for why.

If overlays work for the constrained environment of unit tests, then
use them. If overlays are not to be used, then remove the support from
the kernel. Putting issues in a todo list is not going to get them
done. Having users will.

Rob
