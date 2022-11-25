Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B8B638C42
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 15:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiKYOds (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 09:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKYOdq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 09:33:46 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208142ED7B;
        Fri, 25 Nov 2022 06:33:45 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id DB89C5803E5;
        Fri, 25 Nov 2022 09:33:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 25 Nov 2022 09:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1669386821; x=1669394021; bh=M6MnU6LmiA
        YmvlmzIoIefG1FuwFoAznyitukgUEcknw=; b=P6EcLVbnBM2XgS0pzWCe/1rIDW
        LJpD0QMQb7FEm85MnUCRx0OIT/NTT0Iat6SeNrZQ33egH5CGd3JqkVO8TYdYlwJQ
        vrAZjZTditwnXo9fRTQXz2sZJjZIuKiBmW3+jT06X9mylNcQCwaFiizcn8pK927+
        PowVQgWtPcog16wDBa1OOVLvLoiTkSaujr/rs1lPblFCvGihAIYdCmtb7fXtD0P2
        md8BrtBzQsGth02UVxQVwjifyrfoMwhQ9gHoqyPmbKx4ITw69RjgPiUz6/SeWqg7
        MDTATCC27wthxBtYdMPsSjzxlEqeCUCq5KXEgiQBJA4DeHMWGiQEaeFpLgzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669386821; x=1669394021; bh=M6MnU6LmiAYmvlmzIoIefG1FuwFo
        AznyitukgUEcknw=; b=j9jhcO81ZwRz1HzwCBRYdFInEE4Gu0n/iVzAkl1gjRN+
        VGRNi0+3J29Zh/qZpFG0ZehU//Zf4eNGkPVyK7LvyTaAeql+jtWGuTm0U5zSF2TJ
        I65Ug05FVmOx5AlurbYPPQOKTwdeTr+ZHTfMhIGV1y7VLu7Ihqu0BCUJnUlPbg8j
        D/KC6mWK1oSrLQOzn/SIPpgfHvIWpMohK0dcPjC8x8UCP7T9nBmF3yUQc/DvUFTc
        IW9etyFO5LVMrPdBpIjlfbK+kkny5z1BZkuqY1aO7eePY4sUV10ZVoM/LXWihz1E
        4tu0RokOn3atFsFWacXh+3KO8yLTeoM0cMPbbDCe1g==
X-ME-Sender: <xms:RNKAY91dPIvOopiSBkTlZTlsBtawKib3krM6hYQ2iK4L1lPTo4bPeQ>
    <xme:RNKAY0Ghuvp2N3Ox1NHKS_kkb5iP2fd-5EB0veQZR2dWgDOzLvHtnkp5wY50-6lTx
    cKgosbve5HIzDWdblY>
X-ME-Received: <xmr:RNKAY95mo2uSj7_xUAsiyOQQj3g5DtI5TMSGg_THRkHo-yUYGuzRKxShcXnMxm73TUjElj81GR6SIYFJf9XEEKdmovwouFEz8PfeQsIKJpALtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieehgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeevfeehfeekieffgeevleevtefgffefkedtfeeuhfettdegjeehgfegudff
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:RNKAY62siUBO6VQir3UrNe22QwYWPBDHPrGpfl_P707sZD7N330bJg>
    <xmx:RNKAYwG4gZ0CkAhklQIb1FQHTdJwtcroegQS-7D3xsd2MhrWUEgb-A>
    <xmx:RNKAY7_aXptjD05fY78X0D8c9xuodR2S7HsyxLzHSB3A8wwTGHyjCA>
    <xmx:RdKAY2R83jecd_63_yfenloFGvhBQCg2ePMGaB9yA5U_fVvwXbOMyg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Nov 2022 09:33:39 -0500 (EST)
Date:   Fri, 25 Nov 2022 15:33:37 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org
Subject: Re: [PATCH 01/24] drm/tests: helpers: Rename the device init helper
Message-ID: <20221125143337.edzn53n6ackomhv5@houat>
References: <20221123-rpi-kunit-tests-v1-0-051a0bb60a16@cerno.tech>
 <20221123-rpi-kunit-tests-v1-1-051a0bb60a16@cerno.tech>
 <6a817cad-df46-42ac-3c14-dbdce681cde6@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="acmx5lmtcx2n462u"
Content-Disposition: inline
In-Reply-To: <6a817cad-df46-42ac-3c14-dbdce681cde6@riseup.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--acmx5lmtcx2n462u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 25, 2022 at 11:10:02AM -0300, Ma=EDra Canal wrote:
> On 11/23/22 12:25, Maxime Ripard wrote:
> > The name doesn't really fit the conventions for the other helpers in
> > DRM/KMS, so let's rename it to make it obvious that we allocate a new
> > DRM device.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>=20
> Although I believe using "drm_device" on the function name is a bit
> redundant (maybe drm_kunit_helper_alloc_dev or drm_kunit_helper_alloc_dev=
ice
> would be cleaner),

Yeah, I don't quite like the name either, but we'll need to also
allocate a struct device in the next few patches so we need to make the
distinction between a struct drm_device and a struct device.

Maxime

--acmx5lmtcx2n462u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY4DSQQAKCRDj7w1vZxhR
xeGkAPkBFLa3lV36E2W1jTknr7iiJBV/Zjt6EB2CqXA8txhT8AD/TvavUqFz4lG/
jgViwFq+5i24QHZJ/YlXq5ZvEZ09pAI=
=52Ai
-----END PGP SIGNATURE-----

--acmx5lmtcx2n462u--
