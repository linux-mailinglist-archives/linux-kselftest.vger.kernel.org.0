Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A0B6F0676
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 15:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbjD0NOy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Apr 2023 09:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243673AbjD0NOx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Apr 2023 09:14:53 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7331930C5;
        Thu, 27 Apr 2023 06:14:50 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 466552B06760;
        Thu, 27 Apr 2023 09:14:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 27 Apr 2023 09:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682601283; x=1682608483; bh=kD
        00qCtOfk3PbNYqRHdOJ0AiVNKigJdl3uCFID5G/aY=; b=Mz6hYz2W5BfmPu0zkL
        xk9jUjefighREaUKRO/5rGPPwflA6bc14vnmu2w5I+rcNZAHGWEVDqykFsIqHQbd
        Y6dlHxwr5DBu4JGctPJJ3yVqCT+ESy1W3y5UNrRgw56OA3mCA1JYkEks4PTIbY8T
        U/YJ64/CgophUX+xL2RAldvo8HChwgod0K9ZgX1L6IAD+jJBe7IYH33+tDDiHViw
        nupD7tTSSI6q1AvEEOlW28S9DttGzwNkgI9G2YWcBeTS/mnhO/2TnPVeaWIkE2IG
        HubawSdaIVjw66Yf0sWKOu4TJy9ss11qLB+hNwV/kaT1jRxYaLm9bcXi32seMZz0
        sofQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682601283; x=1682608483; bh=kD00qCtOfk3Pb
        NYqRHdOJ0AiVNKigJdl3uCFID5G/aY=; b=ErA++GpS9heKXOKVvv80Y78uKPjIu
        NH8qTo+6WynzCiUwajbKBO6uT9626bnmomP4hokwjvVAIPCGQrX2Czs6acG64HTi
        dSFyWbYP+flNExxc/EwlVWXm6wzJPIH0V1YsRlpl6N2eb0haCUEBne6GgzhSms/U
        2ZhPb3PwsLBEDVQ4L71bfXC8G659q4BGZqTYaaBDQjW1ObZbyPsco28ct/jTMfa8
        FHB5fGn8Zy6ie2FHtT5ycwxh2HofnKxJmjevjbmxK50bsyCV9WzW3P3fXtAn1IgO
        KnWiHfZjCyqSrnICDEgLjtDdV1mvQ9Ru8l8+6+vW0rAQMSrtGlZ5AlFtQ==
X-ME-Sender: <xms:QnVKZPRTUYR5oREMtp70kgsdiaEtNPPsOAV4jQZCG4kIqpzZbOHIWQ>
    <xme:QnVKZAwT9Kyx2lnkwQb9CE7N7BOyEd_Vuab0vNo4htGIlcY5Z4bFLm4JCYUIAicMT
    _UecEMvZlYk6IQBP2Y>
X-ME-Received: <xmr:QnVKZE08eduDDjWUM9Oa3GTzJAMniO2pWdV1_2v1fGdHVqmT9aQs7haDxHP9tKFhYxCIeSPhUUm9moRtahOTHUE9VdmiGAE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeefjeeiueeiheevtddvgfeluedufeeigeeijefhveelfeevueefieehuefg
    ffetteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:QnVKZPBGqwCP_WxVI0MNV83HmtaP_NNGU8_9uVPpwZPwg9dij6042Q>
    <xmx:QnVKZIiYLOyR-4LYOFleFzDhhlXAdB-VLvIpjfjyu_czKy8z1Vr0NA>
    <xmx:QnVKZDq-Ta5jO5KoJ7HpadSql_PkQkxZmFVYKsjGuka0YvKtbH0h0Q>
    <xmx:Q3VKZOFA-jEAioLVslxmyb3U8gD3MJN4gp93ofmTK_aB93x1diXpkQB-wEI>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 09:14:41 -0400 (EDT)
Date:   Thu, 27 Apr 2023 15:14:39 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arthur Grillo <arthur.grillo@usp.br>
Subject: Re: [PATCH v5 9/9] drm: selftest: convert drm_mm selftest to KUnit
Message-ID: <7yc3fkagtlr4i7qnkulwvfzqjs7v64ddugcc3cxt6g5oawvqoa@ax67ukkrr7jt>
References: <20220708203052.236290-1-maira.canal@usp.br>
 <20220708203052.236290-10-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uwsquh22deiiaohx"
Content-Disposition: inline
In-Reply-To: <20220708203052.236290-10-maira.canal@usp.br>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--uwsquh22deiiaohx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 08, 2022 at 05:30:52PM -0300, Ma=EDra Canal wrote:
> From: Arthur Grillo <arthur.grillo@usp.br>
>=20
> Considering the current adoption of the KUnit framework, convert the
> DRM mm selftest to the KUnit API.
>=20
> Signed-off-by: Arthur Grillo <arthur.grillo@usp.br>
> Tested-by: David Gow <davidgow@google.com>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Ma=EDra Canal <maira.canal@usp.br>

I'm very late to the party, but I'd like to discuss that patch some more.

Two tests (drm_test_mm_reserve, drm_test_mm_insert) in it take a super
long time to run (about 30s each on my machine).

If we run all the DRM tests and VC4 tests, each of those two are longer
to run than all the ~300 tests combined. About 100 times longer.

I don't think that running for so long is reasonable, and for multiple
reasons:

  - While I don't know drm_mm well, it doesn't look like any of those
    tests do something that really should take this long. I'm especially
    skeptical about the fact that we test each operation 8192 times by
    default.

  - It makes using kunit more tedious than it should be. Like I said, on
    a very capable machine, running the all the DRM and VC4 tests takes
    about 50s with those two tests, ~0.4s without.

  - The corollary is that it will get in the way of people that really
    want to use kunit will just remove those tests before doing so,
    defeating the original intent.


I understand that it came from selftests initially, but I think we
should rewrite the tests entirely to have smaller, faster tests. It's
not clear to me why those tests are as complicated as they are though.

Also, going forward we should probably put disencourage tests running
that long. Could Kunit timeout/warn after a while if a test is taking
more than X seconds to run?

Maxime

--uwsquh22deiiaohx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZEp1PwAKCRDj7w1vZxhR
xZb5AQCaxNd1KOuvPksm5yR9miZ4Ahbm8VgMYLVdiUFWcuI6qQEAi3Bnj0sJPHcE
KsVuqZ8Ykbx805ymp4NScJYexkW79gU=
=CnRS
-----END PGP SIGNATURE-----

--uwsquh22deiiaohx--
