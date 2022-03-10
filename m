Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9FB4D4CDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 16:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbiCJPi0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 10:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbiCJPiY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 10:38:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A93D16E7CE
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 07:37:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33F99B826BA
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 15:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED81C340F4;
        Thu, 10 Mar 2022 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646926640;
        bh=bWFHYHHjDffgD+b1rMnHpRbMaj/SZXCAgi+Wzsp21ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFHzvbfo6+v1Ik3rG8ww3DyuURE03Zik1uv2NtsPivOu3mEow6ueoEEVnapDlmJC/
         dgMSB0KDoHzMpTGzU4iU+fkzm+NYwFS0hfRRcpIE5bByEMcEm4tumA/ap14aHq0cgb
         B82rwQe31hPERmUM1GOiKlveMtW4YD3Cg1G47IFO+thagk3IPZokeLxvGNKyb7m3Ir
         a+7GBrx2lO6nJbut6dTdYxWsBusEhpkpTHHsFpbOsOR4ja+caN2Q9RjvToQQ/BZsrM
         T78UTs1MCWelBy0ciGr8rJbLEdJj/6Fwx4RRJAQb6Bg+sAtch43cLTbs22WCT8BCiH
         fVeZ5Gd5vwxEw==
Date:   Thu, 10 Mar 2022 15:37:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v1 4/4] kselftest/arm64: Add simple test for MTE prctl
Message-ID: <YiobK0180DsCfza6@sirena.org.uk>
References: <20220310144335.2097457-1-broonie@kernel.org>
 <20220310144335.2097457-5-broonie@kernel.org>
 <20220310153306.GA53610@e124191.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/malM9kj/RE72vif"
Content-Disposition: inline
In-Reply-To: <20220310153306.GA53610@e124191.cambridge.arm.com>
X-Cookie: Package sold by weight, not volume.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--/malM9kj/RE72vif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 10, 2022 at 03:33:06PM +0000, Joey Gouly wrote:
> On Thu, Mar 10, 2022 at 02:43:35PM +0000, Mark Brown wrote:

> > +static bool system_has_mte;

> This looks unused (apart from being set in main()).

It is, it was used in the asymmetric bits of the test.

--/malM9kj/RE72vif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIqGysACgkQJNaLcl1U
h9C23wf+N4wjkQhiKiTIGIQotn2xVrGr+UW8Ya9GO5DzKYU7nT/S4J5GwZUWyLtf
+7colIUNSNIIccbE91Yh1sd2Nb1wg/1D/gp5az3mXnZbGeHbdScchwAACEHtdB0J
nhLa7ifVt2BwoJHVxw74jwjflWogxAWA+c8ToavmRUX+GgH+VECliHMFxLb+mgeh
iKTYHEWJCewpLH05znfwQPmtQnwVHOHAbU8FcB3cUkQ3a+z1Oc6ltKg+whSVAGZ5
LlNRADSOZN3ePG83BCwDOf0bnUedkXOinKt0JeTVrEk94tzN8RfB7kpQHho/2tvi
J10SBWmqcRdYj2YSWutxK4csykOaVQ==
=x6Fq
-----END PGP SIGNATURE-----

--/malM9kj/RE72vif--
