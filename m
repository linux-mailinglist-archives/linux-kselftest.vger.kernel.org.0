Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AF1570782
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jul 2022 17:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiGKPuO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jul 2022 11:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiGKPuM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jul 2022 11:50:12 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2D332BB6;
        Mon, 11 Jul 2022 08:50:10 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 35C9F5C011B;
        Mon, 11 Jul 2022 11:50:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 11 Jul 2022 11:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1657554608; x=1657641008; bh=8qccav2SJP
        J53nvjnDtjMg/z8lYQcZlSa58F5Rij4wY=; b=DPW/YjOh9WS6Xkge6pkbJ7vrAN
        yRbixqkN5ntj6KzG+cDT4ETHa0xYwxIyCJYep+bFegiZ+RoawYK53g7hiD21Hjlu
        HfngdnmNS4F6ChzjTj6U7qfjLMqjoaRljk1VEpogPffOftzpdwZfq1OfD2woOHa8
        WTfZfW5SSViq6RxB44AYCeql4mmbdKvYFOAq1iPIBM2O3GV5cDimLA5l1h9BSTP4
        BAPocdY8RFb77/jcqqhoB7DL5v4P4U8DmbrcwTIOda/L243GjYGRsnM3VYowFYuq
        PxvaeWcp1iKAeWziDXHdfz9Blwl1bukN2kHbgX1lN8MGrZPcEl+eDJUAvwew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657554608; x=1657641008; bh=8qccav2SJPJ53nvjnDtjMg/z8lYQ
        cZlSa58F5Rij4wY=; b=PaO244N0Uy4kq0H6LdBZcsUQ1dlFgT89UfUvZoGCW9qH
        pDg7iLNTNITYHES8w8UCMbNbdgsTyFuRPv9a2duzbX6ri3sHMCb/3XpzH3n9Ovoc
        eMOY2W3bjnDGDWKi83G8DxQW7to61OwiA+ru+kkAQEbkCtwnGvjfXnuB++G3cxTE
        U+3WCxYQoQZvLaGx/YjbxqM5ksrjzHKlIsy0PWa3Y6pk+mrCA9CxPyiVUa5wVbE/
        cbqtvyumBD6Ft6xw4Kv0i+mL309EQmJoVzvEkP9Fi28yQrT8P/3k4rRUTFuDC3Aa
        LR+bZlpNYDw9mwgD7ZiEPCaa2VuROR3Va5zoMQ/0Bg==
X-ME-Sender: <xms:r0bMYqv58IRpfIHXFYaIQcZpSX6rXeh-DJ0M2z_lYEZ3YM6mWJfEWA>
    <xme:r0bMYvcLhNZRQQk_HJ7unownj0i_5BoEyLQ32Wu7f0yLw0jTMpTH5YkDcrjUe4dDQ
    IKIxgadYDSnEzOyrKc>
X-ME-Received: <xmr:r0bMYlxaDSqXNpAJrHoG-J-3G0LrUH-SxxcVaIL-JmgpjoFKWvIct0TBdkF10t6QXF4gX-pcggIhFdWu_HgdDHNFvs66IXqM6G4K7WY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejfedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetfefffefgkedtfefgledugfdtjeefjedvtddtkeetieffjedvgfehheff
    hfevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:sEbMYlONkUDFMJYzTwtrCDFUM9-I2NjpXFcxfbePABt3tRPU-gaKMw>
    <xmx:sEbMYq-CucExmeSe35iE_d5I1531BwVIumHeKqrQJ0QYJY_gi9gEXQ>
    <xmx:sEbMYtV6oOOhuBzbqknHdkO7tzjzLzZeca3ipUTmY4ZEW93NR1QJFw>
    <xmx:sEbMYtaowM6bSEqbCDL0fWrS1hzkX6Rbhnx798m13-mIrTdfgtG5Cg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Jul 2022 11:50:07 -0400 (EDT)
Date:   Mon, 11 Jul 2022 17:50:05 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3] kunit: tool: Enable virtio/PCI by default on UML
Message-ID: <20220711155005.lnebdh534ntmf4sv@houat>
References: <20220708162711.1309633-1-dlatypov@google.com>
 <20220711144651.yekrivauz3phkuvm@houat>
 <CAGS_qxp=UAJ19zQOZKP8ywPiNAj4wT80ubH2YW060mmADoqBcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="62a7ggmdoypgfr4x"
Content-Disposition: inline
In-Reply-To: <CAGS_qxp=UAJ19zQOZKP8ywPiNAj4wT80ubH2YW060mmADoqBcw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--62a7ggmdoypgfr4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 11, 2022 at 08:10:36AM -0700, Daniel Latypov wrote:
> On Mon, Jul 11, 2022 at 7:46 AM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Unfortunately, this breaks the clock tests in next-20220711:
> > $ ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/clk/.kunit=
config  --raw_output
>=20
> Thanks, this is indeed an issue.
>=20
> I remember noticing this in early April.
> I incorrectly remembered that a fix had been sent.
>=20
> A more minimal reproducer:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/clk
> 'clk-gate-test.clk_gate_test_enable'
>=20
> The part of the test that becomes problematic with this patch (i.e.
> enabling logic iomem) is the cast on line 143.
>=20
>    130  struct clk_gate_test_context {
>    131          void __iomem *fake_mem;
>    132          struct clk_hw *hw;
>    133          struct clk_hw *parent;
>    134          u32 fake_reg; /* Keep at end, KASAN can detect out of bou=
nds */
>    135  };
>    136
>    137  static struct clk_gate_test_context
> *clk_gate_test_alloc_ctx(struct kunit *test)
>    138  {
>    139          struct clk_gate_test_context *ctx;
>    140
>    141          test->priv =3D ctx =3D kunit_kzalloc(test, sizeof(*ctx),
> GFP_KERNEL);
>    142          KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
>    143          ctx->fake_mem =3D (void __force __iomem *)&ctx->fake_reg;
>    144
>    145          return ctx;
>    146  }
>=20
> A simple fix we could carry in the KUnit branch is this:
>=20
> diff --git a/drivers/clk/.kunitconfig b/drivers/clk/.kunitconfig
> index cdbc7d7deba9..2fbeb71316f8 100644
> --- a/drivers/clk/.kunitconfig
> +++ b/drivers/clk/.kunitconfig
> @@ -2,3 +2,4 @@ CONFIG_KUNIT=3Dy
>  CONFIG_COMMON_CLK=3Dy
>  CONFIG_CLK_KUNIT_TEST=3Dy
>  CONFIG_CLK_GATE_KUNIT_TEST=3Dy
> +CONFIG_UML_PCI_OVER_VIRTIO=3Dn

It works for me now thanks

Feel free to add my Tested-by

Maxime

--62a7ggmdoypgfr4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYsxGrQAKCRDj7w1vZxhR
xZyqAQC4NkZsJpoYeowyQIVO4BfNLIn0HRfUGFWT5pUN6QP/MAD+NTf3aEmdrypM
+IdKY8hTsxBVo3BWv7sMzCpsAtqprgI=
=CyaJ
-----END PGP SIGNATURE-----

--62a7ggmdoypgfr4x--
