Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67206587441
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 01:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiHAXG2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Aug 2022 19:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbiHAXGY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Aug 2022 19:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767A229C92
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Aug 2022 16:06:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 089F560EE6
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Aug 2022 23:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C411C433D6;
        Mon,  1 Aug 2022 23:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659395182;
        bh=qu9hBV2ZzvuYuyQ/qBi7HBz/IqtLJs1F6Y8cisuFyeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J3UGFk7lgMODzufHiU87C5JMb8rsx0yKdeqMOrHgJqvMWa8ZtEMB+bP7PXlYGRpGI
         WvlzVD1SgaxGTe6quRc0KGJeEb6GsGd6BD5c1kffZtETr/cDm2+PfRsf9J8W+befKi
         ihRF8kIVtHVQK+3ez0ucRAfVmIjOtTNiSKviCji8Qe8/ixtqTmpoHkJ5jSpB4Sb0XV
         CMWmLTxTP26W1PtTCCq7pbBnU2u4967GXWgGMrU2N24YnizAZ92GnRX+XH7T1XTRwX
         rCTs+bvt2rf0Y1TLr2cHyYLmocxsuid20ZZ6WuawjDf35bZcRF8GaHzxPdNnczXX0R
         w0Xlb6+RmGBJg==
Date:   Tue, 2 Aug 2022 00:06:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Fix validation of EXTRA_CONTEXT signal
 contexts
Message-ID: <Yuhcac/iM+WebgW+@sirena.org.uk>
References: <20220801225926.3694639-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xAwKLmjB12kD0Oi+"
Content-Disposition: inline
In-Reply-To: <20220801225926.3694639-1-broonie@kernel.org>
X-Cookie: Dieters live life in the fasting lane.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--xAwKLmjB12kD0Oi+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 01, 2022 at 11:59:26PM +0100, Mark Brown wrote:

> Currently in validate_extra_context() we assert both that the extra data
> pointed to by the EXTRA_CONTEXT is 16 byte aligned and that it immediately
> follows the struct _aarch64_ctx providing the terminator for the linked

I just realised that this is a very similar subject to another fix I
sent for this stuff a few hours ago.  Both fixes are needed, the code
really is quite buggy.  I've tweaked the subjects locally in case I need
to resend - this one is:

kselftest/arm64: Fix validation of EXTRA_CONTEXT signal contexts

and the other is:

kselftest/arm64: Fix validatation termination record after EXTRA_CONTEXT

The good news is that with the patches I've now posted we no longer get
any spurious failures, though further patches (which should emerge after
the merge window) will be required to actually validate the data inside
an EXTRA_CONTEXT.

--xAwKLmjB12kD0Oi+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLoXGgACgkQJNaLcl1U
h9BWkwf/QjiAjRUdK2gqdwZ95dOZ212EwvaqCpxAC5YHuCvBMj78P/PtelwYl/5O
bEtu1H5umN5kU2nXrN5ElUO7nlKFvLPygvp93LiEG2bsV4grvgnp5ilIZ+0Q/niO
rlYYbB5qpSRzHf1Me5S/eBdV1pwxmYv1vMLeUmC3vTCkWtjIAFt2Kw5ghY5u3bTk
AnssMLyKQtouP5JOANDQdw2XtYlZGZas0vLQNa14nRdj692zOSWNenCrJoydl0ok
+yz3roG2SgsZ05/ZR0/Z+5SNccqL1uu5PvNXwi9c+2AiapJtP4aeCmHOP0uxzsI2
luWELvUtgjXI2sQuP3eWmjKmQ0o0ag==
=k7if
-----END PGP SIGNATURE-----

--xAwKLmjB12kD0Oi+--
