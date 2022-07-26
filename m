Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2247581AB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Jul 2022 22:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239736AbiGZUHq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Jul 2022 16:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239708AbiGZUHp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Jul 2022 16:07:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF0532469;
        Tue, 26 Jul 2022 13:07:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F55BB80919;
        Tue, 26 Jul 2022 20:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDA2C433C1;
        Tue, 26 Jul 2022 20:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658866061;
        bh=y5wfcocVA31wNAT1AzwXJsrzMI45+ZN+MdMwmwEEHlA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JgWGgmzyl3SKYdp9DW27KLVN9dJyVSdu1dgw4HHmpM11CzFXuYhtinp0oUVPAibdI
         B7OYo75rbIEpGXPOJ8q7sT0UMtr5jC2n9ctbz9a1RZ44zY7rQM0RaKpud2gpanljeX
         phB1II7HBWwZuGvYCsKNGLmtdaQQamYjTOEnRj07D0DLFt0KU3Drrl5/R+0cAA9aRG
         4BZkylF8KoxQiuv2qNRk1PWwzcYjAsY9cJLw7L1QbVjw86MTZSZ3GK6Pc8IE2FF1bs
         DsVHv92JI7yw9ezHPoeunxpXQHXQgAvC9WS4HVM8u66Tvz022POYCb0ATXLxynOpvc
         ufbIGURnMSCjg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOS=bm5TmEBd8jxuTPJy426OgC14ryqn4FLQR1pHNf5uhsw@mail.gmail.com>
References: <20220711162713.2467476-1-dlatypov@google.com> <20220711204859.3DDD5C34115@smtp.kernel.org> <CAGS_qxqxGfQ5tA063XoRbL1ktimyfmt+CuucJ_rsYVnoi4i7gw@mail.gmail.com> <CABVgOS=bm5TmEBd8jxuTPJy426OgC14ryqn4FLQR1pHNf5uhsw@mail.gmail.com>
Subject: Re: [PATCH] clk: explicitly disable CONFIG_UML_PCI_OVER_VIRTIO in .kunitconfig
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-clk@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
To:     Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>
Date:   Tue, 26 Jul 2022 13:07:39 -0700
User-Agent: alot/0.10
Message-Id: <20220726200741.2DDA2C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting David Gow (2022-07-11 23:44:08)
>=20
> So, as I understand it, casting a regular pointer to an __iomem
> pointer (as the clk test does) isn't technically correct, though it
> does work on almost every architecture out there. If we want some way
> of intercepting I/O access, then then that'll need to be handled by
> the various read()/write() functions.

Yep. It's test code though so it seemed ok at the time.

>=20
> UML doesn't support iomem at all out of the box, and logic_iomem is a
> way of implementing it which allow us to attach handler functions to
> blocks of memory, albeit with more constraints about what addresses
> get used. Brendan started implementing a "fake hardware" interface on
> top of this here, though it's still in-progress:
> https://kunit-review.googlesource.com/c/linux/+/5272/4

Cool.

>=20
> Ultimately, I think the 'correct' solution here will be
> logic_iomem-based, but doing that nicely will probably require one of
> two things:
> - logic_iomem to support non-UML architectures as well (becoming a
> generic "insert a 'fake' device here" system)
> - logic_iomem to have some way of "passing through" access to an io
> memory region through to the normal underlying memory.
>=20
> Ideally, we'll have both, and maybe even defaults which will allow
> hacks like this to continue working (perhaps with a warning?). That'll
> require some significant (and probably not uncontroversial) work on
> how iomem accesses work in general, though, possibly with performance
> impact.

Does it matter to pass through to real iomem? I'd think we wouldn't want
to actually affect real hardware in test code. Instead we'd like to fake
it and then look at the result, like how the clk test works.

>=20
> The other option of using function redirection on the io read()
> write() functions exists, and would be a bit simpler in the
> short-term, but would probably result in a lot of tests reimplementing
> this, and also would have some performance impacts, as the I/O
> accesses wouldn't be able to be inlined if KUNIT is enabled.
>=20

That sounds OK to me because nobody is enabling KUNIT in production,
right?
