Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BAC6A8794
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 18:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCBRO0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 12:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjCBROZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 12:14:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5596426878;
        Thu,  2 Mar 2023 09:14:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9D40ECE1F60;
        Thu,  2 Mar 2023 17:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B13C4339C;
        Thu,  2 Mar 2023 17:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677777252;
        bh=sxh36iZQRth6PcbEK8rBaNdhPJuIjt084P0tIKyNndg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TAJj++imQypJWlswGfOoct5GpNWCJQsD7oCXqgQ+ZDG8uNTAaoEaYgHDCMmVXcK2X
         jB2C7tAJYpWiuL6YafBBMtsMVUYOCQrRTkfpoH2WH0W3qjbUP53Vj0Fw8x928o5+H0
         B3X0tkSkIQsoJKkhoOAQNwr3MaqnneespIRdTZKbtUtbpCq3wtLWfzBYaQCGuJznp5
         +2+jmuUHw6CUofbdurXFfoqeC+3fpZ523uvG5P3p8jI8KoD8MZuo1DwBAtxlhXwW0M
         i1AGLygTd9avSKC1IuYZNT7A91xL/Q075a1GwO/YFePebxenzP5rnDD7KFjGYoXuyQ
         w+gk9vEAOiauQ==
Received: by mail-ua1-f52.google.com with SMTP id n4so6667442ual.13;
        Thu, 02 Mar 2023 09:14:12 -0800 (PST)
X-Gm-Message-State: AO0yUKW35DVvKJjBldBaNEYrFwt4o8X496Y5l3to8M1KsFKZluJNM52c
        gU4Z3mAPMRbjIjlwCFJIxbcUWGin6IltBU61Bw==
X-Google-Smtp-Source: AK7set/cWK8giFKY8fRLWeGOHTziXVw5azzC2FP84wrmvxubHnP5GVl40pOdsWrs8+z15dRYvJSehk78bGu43zZqZQU=
X-Received: by 2002:a05:6122:b55:b0:40f:2033:6994 with SMTP id
 21-20020a0561220b5500b0040f20336994mr6152564vko.2.1677777250943; Thu, 02 Mar
 2023 09:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org>
In-Reply-To: <20230302013822.1808711-1-sboyd@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 2 Mar 2023 11:13:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLVQVZhYTSZgrvA-V-xOUbiBdyDxqPOZk=89YS33EahBQ@mail.gmail.com>
Message-ID: <CAL_JsqLVQVZhYTSZgrvA-V-xOUbiBdyDxqPOZk=89YS33EahBQ@mail.gmail.com>
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

On Wed, Mar 1, 2023 at 7:38=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wrot=
e:
>
> This patch series adds unit tests for the clk fixed rate basic type and
> the clk registration functions that use struct clk_parent_data. To get
> there, we add support for loading a DTB into the UML kernel that's
> running the unit tests along with probing platform drivers to bind to
> device nodes specified in DT.
>
> With this series, we're able to exercise some of the code in the common
> clk framework that uses devicetree lookups to find parents and the fixed
> rate clk code that scans devicetree directly and creates clks. Please
> review.
>
> I Cced everyone to all the patches so they get the full context. I'm
> hoping I can take the whole pile through the clk tree as they almost all
> depend on each other. In the future I imagine it will be easy to add
> more test nodes to the clk.dtsi file and not need to go across various
> maintainer trees like this series does.
>
> Stephen Boyd (8):
>   dt-bindings: Add linux,kunit binding
>   of: Enable DTB loading on UML for KUnit tests
>   kunit: Add test managed platform_device/driver APIs
>   clk: Add test managed clk provider/consumer APIs
>   dt-bindings: kunit: Add fixed rate clk consumer test
>   clk: Add KUnit tests for clk fixed rate basic type
>   dt-bindings: clk: Add KUnit clk_parent_data test
>   clk: Add KUnit tests for clks registered with struct clk_parent_data

Good to see bindings for this. I've been meaning to do something about
the DT unittest ones being undocumented, but I hadn't really decided
whether it was worth writing schemas for them. The compatibles at
least show up with 'make dt_compatible_check'. Perhaps we want to just
define some vendor (not 'linux') that's an exception rather than
requiring schemas (actually, that already works for 'foo'). It's
likely that we want test DTs that fail normal checks and schemas get
in the way of that as we don't have a way to turn off checks.

We already have GPIO tests in the DT unittests, so why is clocks
different? Or should the GPIO tests be moved out (yes, please!)?

What happens when/if the DT unittest is converted to kunit? I think
that would look confusing from the naming. My initial thought is
'kunit' should be dropped from the naming of a lot of this. Note that
the original kunit submission converted the DT unittests. I would
still like to see that happen. Frank disagreed over what's a unit test
or not, then agreed, then didn't... I don't really care. If there's a
framework to use, then we should use it IMO.

>
>  .../clock/linux,clk-kunit-parent-data.yaml    |  47 ++
>  .../kunit/linux,clk-kunit-fixed-rate.yaml     |  35 ++
>  .../bindings/kunit/linux,kunit.yaml           |  24 +
>  arch/um/kernel/dtb.c                          |  29 +-
>  drivers/clk/.kunitconfig                      |   3 +
>  drivers/clk/Kconfig                           |   7 +
>  drivers/clk/Makefile                          |   6 +
>  drivers/clk/clk-fixed-rate_test.c             | 296 ++++++++++++
>  drivers/clk/clk-kunit.c                       | 204 ++++++++
>  drivers/clk/clk-kunit.h                       |  28 ++
>  drivers/clk/clk_test.c                        | 456 +++++++++++++++++-
>  drivers/of/Kconfig                            |  26 +
>  drivers/of/Makefile                           |   1 +
>  drivers/of/kunit/.kunitconfig                 |   4 +
>  drivers/of/kunit/Makefile                     |   4 +
>  drivers/of/kunit/clk.dtsi                     |  30 ++
>  drivers/of/kunit/kunit.dtsi                   |   9 +
>  drivers/of/kunit/kunit.dtso                   |   4 +
>  drivers/of/kunit/uml_dtb_test.c               |  55 +++
>  include/kunit/platform_driver.h               |  15 +
>  lib/kunit/Makefile                            |   6 +
>  lib/kunit/platform_driver-test.c              | 107 ++++
>  lib/kunit/platform_driver.c                   | 207 ++++++++

Humm, we have DT platform driver unittests too. What's the difference?

Anyways, that's all just my initial reaction from only halfway looking
at this. :)

Rob
