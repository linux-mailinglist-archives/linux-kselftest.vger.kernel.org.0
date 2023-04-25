Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CE56EE4A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 17:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjDYPYB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 11:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjDYPYA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 11:24:00 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8483CA5F5;
        Tue, 25 Apr 2023 08:23:59 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id CF8232B061E1;
        Tue, 25 Apr 2023 11:23:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Apr 2023 11:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682436234; x=1682443434; bh=ie
        +kwy29np8Lu3Cx0FWF+CbrsbBORKaPAuFe21CfxZE=; b=EXp/Q8bHo7P+3qC8bM
        5VDVYZBe4ELBbbCfMb5+4wNueWe1iYMU6aaW3CIxrwpcXqUUhd7hghKxZ09CuhK/
        QMnIkfEtrwqN1586XPmr0SvjG7Rc2/DjKSXd8I8AHdLsJyjc/3mwLt4itQD8dpK8
        FH+iz9zymDZhVC+Fl6/0p4Y/31F5cV9czUxZdOtwLq7UOxC3ahhFtzOmY2uocxXO
        QiS6rGUHxlqcKUptdmmBfhPv+P5n4LF6SgiCQXKGq671tcTf7DEm+SyUMsiHBT2q
        fUJGosGOFwEGKavCaNG1s9NsS4/uyrcEJbo0k0gMr+6Xl7PcHD7aq4D/HZSB8c4P
        K6mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682436234; x=1682443434; bh=ie+kwy29np8Lu
        3Cx0FWF+CbrsbBORKaPAuFe21CfxZE=; b=CrSQOm6Jg028X3LsVqROL4eT6pydQ
        WT375bIrqh4Lng37wujwE0K6P9iL2P+OA5UDOFJnk0qfxJ6vHHkCTHUqK6vKwdGT
        HHaNR5mlsFC2qphfD5pMFWs7ChQaa0zARDN71PbKnkMjnz3hyrGqhFJBiq6SYFq7
        dQpiehkZl7CqfIZ+5Xp44BpEPYkFRXI+iqFebGM/TXBpvsX0mCvoYGLmRTMcONbQ
        9CILIrb56MwAZzf1zpJD5oYG33QsqNKF0+HDPQXQrQwY+9Cugzjgs11P2MBiAGGO
        G+YkIebivQBBd1iwBzbHznh+70D+0yAVVmmv9qGWZ1RwyUm4Kfs+9WOfA==
X-ME-Sender: <xms:ifBHZN4KyomX3KdRe7frJ1pmbUu88PShVhYkQbNVC5IdxeLs8IODmQ>
    <xme:ifBHZK4waAE5xl2kxfD0n39PnpavMjTtfniLrrJfIdT4gfBiHLCTO8xj-gZ6PveYh
    79IOWjrcEolkCAh-Io>
X-ME-Received: <xmr:ifBHZEdm4fDu1epxvsQarXIUiaDBgxQOeDAcZXlEfb-dN2f3bIpgLnn3EbtoP3ctxlzUvE7rlUI4eJrdyJJYeBwNQiAoMD0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduvddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ifBHZGLCMzJFOYk1g3C8R4P23FvOSfJ3T1t89z9g4zoLRuo5RNnM3Q>
    <xmx:ifBHZBKUSUsjd8xU16wbp2oK9d7KxwkWg0sW2iaqakAi0rONbHUqCg>
    <xmx:ifBHZPzT2sZbes9g5asxK_d89mjAjEJrPnwH1Xhzcy401dB6zDaVkA>
    <xmx:ivBHZP31z8LqNWugs2llvkHGH1D7Z1u6sEh0WmmsGx5B6-1JE1OvTLt1w0o>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Apr 2023 11:23:52 -0400 (EDT)
Date:   Tue, 25 Apr 2023 17:23:50 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Gow <davidgow@google.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v1 0/3] kunit: Deferred action helpers
Message-ID: <knlcj7ub477vbdhi4jkhxg6eltrluffli2gett4t4w4ed4cztr@qlxpd4rmgx3g>
References: <20230421084226.2278282-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rb5lfax26rs5huyx"
Content-Disposition: inline
In-Reply-To: <20230421084226.2278282-1-davidgow@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--rb5lfax26rs5huyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 21, 2023 at 04:42:23PM +0800, David Gow wrote:
> This is v1 of the KUnit deferred actions API, which implements an
> equivalent of devm_add_action[1] on top of KUnit managed resources. This
> provides a simple way of scheduling a function to run when the test
> terminates (whether successfully, or with an error). It's therefore very
> useful for freeing resources, or otherwise cleaning up.
>=20
> The notable changes since RFCv2[2] are:
> - Got rid of the 'cancellation token' concept. It was overcomplicated,
>   and we can add it back if we need to.
> - kunit_add_action() therefore now returns 0 on success, and an error
>   otherwise (like devm_add_action()). Though you may wish to use:
> - Added kunit_add_action_or_reset(), which will call the deferred
>   function if an error occurs. (See devm_add_action_or_reset()). This
>   also returns an error on failure, which can be asserted safely.
> - Got rid of the function pointer typedef. Personally, I liked it, but
>   it's more typedef-y than most kernel code.
> - Got rid of the 'internal_gfp' argument: all internal state is now
>   allocated with GFP_KERNEL. The main KUnit resource API can be used
>   instead if this doesn't work for your use-case.
>=20
> I'd love to hear any further thoughts!

I've converted the KMS kunit tests to use that API when relevant, and
it works like a charm and is super usable, thanks so much.

One improvement we could do as a second step is to provide a
kunit_action_t type or something to make casting kfree-like functions
easier, but it's already great overall.

Reviewed-by: Maxime Ripard <maxime@cerno.tech>
Tested-by: Maxime Ripard <maxime@cerno.tech>

Thanks again,
Maxime

--rb5lfax26rs5huyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZEfwhgAKCRDj7w1vZxhR
xcAtAP4prqqqC77VuBSmZ2OPTWVaV2lVYsHKC9qTunwwWG+JxgEA8xbRD6OKfxOH
ctUpY5UfYbzXWLDYjOBC+h0ylhFx1Ac=
=uD/b
-----END PGP SIGNATURE-----

--rb5lfax26rs5huyx--
