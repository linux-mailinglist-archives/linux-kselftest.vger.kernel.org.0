Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DF76EE4F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 17:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjDYPrT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 11:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjDYPrS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 11:47:18 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C971BD6;
        Tue, 25 Apr 2023 08:47:16 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 9ADD62B067C0;
        Tue, 25 Apr 2023 11:47:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 25 Apr 2023 11:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682437634; x=1682444834; bh=+/
        XKcjKrBYNMWbprccyz7nA7lIfjchnB0B9EnEgI4Ak=; b=D8yd29ybuQFZIaBp65
        nnQQBAQPAy0o2t/dQP0i+h4ktrybLSxygK1NhFRY/KIFdNwezspf5m5cp/kAhVRL
        oAlnOD1waJ4UZy40wvfhByRmZ4hblbuu7aDYQGnC370Ntq+tz/HViGEUMVteMMmj
        M91RirqtYE0xRhPLkF0GberrHPFS+YgA53vHrvOXQJbe+CkZsSR6e3+TiFjR45fr
        I3yfumMJ62cwfys0RILOW5OhNmgKPjT/oa4GlkYzlFMOfUsPsjxMWxL3zUNEChd5
        h3EkTiYXg3scTgCKbtaGTLw4722h4yck71n1W2P88ZbzJXmzjC5NU+fhVlBmzeZ1
        FmTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682437634; x=1682444834; bh=+/XKcjKrBYNMW
        bprccyz7nA7lIfjchnB0B9EnEgI4Ak=; b=HIGtPOWRm3DbLvvy30nvn2nBHnvxZ
        G2nlTgmf82KI3Vt78B0hz/UAiYmF+JlNWTEnru8pEK02E7QsSHYgCVmFdDs62UIT
        3p+sJK5yUDqls75GwI2IUJtS8WQ4vI8tHcpm0MtAsGtrxsCnrQRQ9/J+MhgNPmTn
        YOIS/F8ghzk52/9oxZeRc2eIf1PfIUbIpTvy4S+GGlBk6dVRDP9p4hdawO5AQzTn
        y4tEju9iuDFOtj87EAu6OgnQnapzwsT5tMDSmORtrnOZpBMUItkIAykzAPfP7lZf
        HB2G0fRM4c/OpaFQOfo5TmAzYgduJxcplFeCPEwt86vJdLgDBNmi40XSA==
X-ME-Sender: <xms:AfZHZKwMtvGTqa_A0i09gEnHLcdTkqi1Knn52Jvr9ZIlWSdoZaILDw>
    <xme:AfZHZGQJbJjoiiN41ZPGV2Sf_3MBhHDeuUaNb1lpw2BEjrZk4OvMgi4HfeZ6ecnEi
    h_UNDHSq_BBzsGgoJg>
X-ME-Received: <xmr:AfZHZMUvAE5LtUmQ1MMvOVayVSx5jZgQUavz_TpAMDyzRDWzgDVwuo-CHVgseEOXmk75ZGB_a2wNuA8U7wuL524ZetbhDJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduvddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:AvZHZAjBfoVYg79wVyqiLub51ycMXPtjFV0-Zs6NAHFzL_M4ki1VqA>
    <xmx:AvZHZMAkCdiMpx9RrlCAdDIwNAQkWQC_BkhmEfHbDlYmHWcXGmmjCQ>
    <xmx:AvZHZBLCzxR__3BMP5JUxq1EWB2Nwnf8LWtD4iUmNQzoJ1BPEN1ghg>
    <xmx:AvZHZDDCphmBb3jkBkFzbCVrsjTiFCEg6pkyldzmgN6gEz_EbrEBNYYTBzI>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Apr 2023 11:47:13 -0400 (EDT)
Date:   Tue, 25 Apr 2023 17:47:11 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Gow <davidgow@google.com>
Cc:     Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Stephen Boyd <sboyd@kernel.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sadiya Kazi <sadiyakazi@google.com>
Subject: Re: [PATCH v3 1/4] kunit: Always run cleanup from a test kthread
Message-ID: <ugim4ef5kbcamojrhq4ryun5wjktcd2rgnfxt7k64hg2y7bkle@ej4mcwflmqbv>
References: <20230421040218.2156548-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t7kvs675m2vml6sl"
Content-Disposition: inline
In-Reply-To: <20230421040218.2156548-1-davidgow@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--t7kvs675m2vml6sl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 21, 2023 at 12:02:15PM +0800, David Gow wrote:
> KUnit tests run in a kthread, with the current->kunit_test pointer set
> to the test's context. This allows the kunit_get_current_test() and
> kunit_fail_current_test() macros to work. Normally, this pointer is
> still valid during test shutdown (i.e., the suite->exit function, and
> any resource cleanup). However, if the test has exited early (e.g., due
> to a failed assertion), the cleanup is done in the parent KUnit thread,
> which does not have an active context.
>=20
> Instead, in the event test terminates early, run the test exit and
> cleanup from a new 'cleanup' kthread, which sets current->kunit_test,
> and better isolates the rest of KUnit from issues which arise in test
> cleanup.
>=20
> If a test cleanup function itself aborts (e.g., due to an assertion
> failing), there will be no further attempts to clean up: an error will
> be logged and the test failed. For example:
> 	 # example_simple_test: test aborted during cleanup. continuing without =
cleaning up
>=20
> This should also make it easier to get access to the KUnit context,
> particularly from within resource cleanup functions, which may, for
> example, need access to data in test->priv.
>=20
> Signed-off-by: David Gow <davidgow@google.com>

Thanks for doing this. I've tested it with an action that needs the test
priv pointer, and it works as expected

Reviewed-by: Maxime Ripard <maxime@cerno.tech>
Tested-by: Maxime Ripard <maxime@cerno.tech>

Thanks!
Maxime

--t7kvs675m2vml6sl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZEf1/wAKCRDj7w1vZxhR
xXLCAP4+nmIiGMTkvl6NDkhzxZl5fYLgenEzcCQXyW3kF3QnsAEAuERclbus30rc
1i5UTw/t/svBmP/hBwxq2PVNT96RwQU=
=VQOD
-----END PGP SIGNATURE-----

--t7kvs675m2vml6sl--
