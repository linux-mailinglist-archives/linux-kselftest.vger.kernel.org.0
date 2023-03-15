Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E216A6BAB08
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 09:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCOIqL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 04:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCOIqK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 04:46:10 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Mar 2023 01:46:07 PDT
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A0F72019;
        Wed, 15 Mar 2023 01:46:06 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 9E7482B05BCC;
        Wed, 15 Mar 2023 04:28:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 15 Mar 2023 04:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1678868881; x=1678876081; bh=sm
        BXPA4tzaw5CWmCbZopn1Nv/tcbeL+d7+B00EOaE7Q=; b=n2jAfdmkzr4/x+CsBm
        W3h1fdrXzPUm2M6yIwhfuUk5NhMWT/Re0vBrmd65xKAFLeiEY/BPKjvG849fGvop
        r6lZ+pB/zktfi8PfRRRsZZxxY+cJG9Y8XIUnSYR9FzjNY1hbRY7wB2Ioqdk4Xy3J
        +zrsJ8pM3pJUgMLZjLnB8owsf1EKqCBVtyimEGpJnrWHHZ3GZnmthFkeDTmiy15O
        wCZ248asyrS8sfn/G2SctX82+c9wYjoqkwx6H14GvynjhkvaV69ZxuBKI07kZWqS
        2BAIxwRWGRkc/xYuv+WUF6S3KnnkiwzWwTt5cjAY1pXxu+1AGKpNS0+LHt0g4mQo
        YeYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678868881; x=1678876081; bh=smBXPA4tzaw5C
        WmCbZopn1Nv/tcbeL+d7+B00EOaE7Q=; b=F9iSSzvNOuBHmzJ/Fjk/0R6964S6p
        odwOiiFpi55tKtu3VaUMm/rZY8Hu73NPU/2nn66mTZdMKLH8z/G73bZUoVgOWQFM
        lEWHDM0Q2GsVNtwgXiIvtw2V6JnAQICZbxMDCGFQDJZ/8O21qcOEE8PnqOSr5G9A
        3wQswbd0yMxi8kTTJn0befLjm5ZI/PjqJc8f8Uxh70MlAUPiQgVdyUXZGbE9DRPc
        Bn+XLdW5kusQNFnzzSJbTu7HS1CQJggtArNUcghVl+C6huIpTLQmhFd8CeMpgu4n
        2H/PoTPP4AVPhupCfieoBLln5iLfbSLiVx/apAN0+A5evGjnGtX8rK5yg==
X-ME-Sender: <xms:j4ERZN7n63PUVZA5NQrmfriOeymxN4S23oD5CkVe-P3ocMm_vkMwlQ>
    <xme:j4ERZK5JYdqTXwxHgRekqf6m27BGyMd_lx9Ec8m9TYMiyd5PZcUPhlqfa71AtXer5
    wk4VwFJLw8gv0WXAO0>
X-ME-Received: <xmr:j4ERZEcLZytM7Ewc974LmNDKPijeBjzfR8JPNjQs-XBCokHRLLKVOWLF7SN8FXMBglnYsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvjedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnheptdelkeejiedufedvhfeiffetlefhiedvleeigfeiuefghfdvleeiffej
    ieegteejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:kIERZGIDWUucWnPXTT6Llkt_3om4aQKgR9mx6sRYPcZI6RP9JmCYlw>
    <xmx:kIERZBJBjGTvnhJuADp3ZCN0-GwhVdn4XlaIdYwb_uE-SevZEmx0jA>
    <xmx:kIERZPx8rOuY_jmxv_1O3qoQ0Sr341i5gKbvpdvQiYLdBZegosqI7Q>
    <xmx:kYERZJcsvqLRjqXppPj219cma-IgLDluKHxkQFfUdPILE_e9JwFd8mgOnf8>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 04:27:59 -0400 (EDT)
Date:   Wed, 15 Mar 2023 09:27:56 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     David Gow <davidgow@google.com>,
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
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 3/8] kunit: Add test managed platform_device/driver APIs
Message-ID: <20230315082756.ynq3dpbv7udrcbds@houat>
References: <20230302013822.1808711-1-sboyd@kernel.org>
 <20230302013822.1808711-4-sboyd@kernel.org>
 <CABVgOSmR0_u8Tw0E8C1mRFxSiGKwdKG5ka_+X_36Hj4VNLdg2g@mail.gmail.com>
 <20230303143528.2dovipmqlms74vp2@houat>
 <dea61f59ea83c772b693b18db43c3eb7.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mrd2rsrmiq2ziig6"
Content-Disposition: inline
In-Reply-To: <dea61f59ea83c772b693b18db43c3eb7.sboyd@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--mrd2rsrmiq2ziig6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Thu, Mar 09, 2023 at 03:31:15PM -0800, Stephen Boyd wrote:
> Quoting Maxime Ripard (2023-03-03 06:35:28)
> > On Fri, Mar 03, 2023 at 03:15:31PM +0800, David Gow wrote:
> > >=20
> > > DRM has a similar thing already (albeit with a root_device, which is
> > > more common with KUnit tests generally):
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/include/drm/drm_kunit_helpers.h
> > >=20
> > > But that's reasonably drm-specific, so it makes sense that it lives
> > > with DRM stuff. platform_device is a bit more generic.
> >=20
> > I'd be very happy to get something from the core to address the same
> > thing.
> >=20
> > I think the main thing we needed that isn't covered by this patch is we
> > wanted the device to be bound to its driver, so with probe being called
> > before calling the test (see 57a84a97bbda).
>
> Can you clarify? This patch makes a poor attempt at waiting for the
> platform driver to bind, but in reality it may not be bound by the time
> the driver register function returns.

The issue was that devm will only clean up the resources if the device
was bound to a driver so we were exhausting resources when running
dozens of test in a sequence.

The way I solved it for vc4 was to create a dumb platform driver with a
waitqueue, and wait for probe to be called.

I think we could make it more generic by allowing a pointer to a probe
function and calling it into our own probe implementation. What do you
think?

Maxime

--mrd2rsrmiq2ziig6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZBGBhwAKCRDj7w1vZxhR
xQfJAP9d8Mk6W6LsnZWjdC2ZVCNtlVeMbIMPi7JwuKzAFKJrnwD+P0T5lH1uMYyg
Q4LeS+MNoLW1jvZenhi+zkdv6wRJswU=
=1NPj
-----END PGP SIGNATURE-----

--mrd2rsrmiq2ziig6--
