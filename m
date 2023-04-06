Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81846D9A81
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 16:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbjDFOgi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 10:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239228AbjDFOgV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 10:36:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2992ECC3F;
        Thu,  6 Apr 2023 07:34:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A71B64888;
        Thu,  6 Apr 2023 14:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132A5C4339B;
        Thu,  6 Apr 2023 14:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680791545;
        bh=6BIfB4wvUgxIKkIw8tnOtXgIf705ROTUHHNPNs8dsBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HnyHBjB9ixqoCm2AAGGQAs5SQAV+xhCcNC69AqlnekuQZfxKN0kITpAErvMRHDZh6
         VcqXJirOq/uTqY8BTI3G+H3RLiGOCPSF+xWPa0nMFs9fCRhRpfI9m816+7yZLeLMsD
         WeX72Uh/lOexY6KXBJA5MXuIb606v667hYXN9WGxUO+qrjD9SfYdVmBPaWLbbOROAN
         LBfAaJF4RVgkMHvIKSS9rpCmplEJPd44+Y8V3pHFI97iYtPOqlM3xpUDb4kunIyfvg
         evY2bO5TsWZTdrQJLR2omBZbXU+QNSUmxgi2Grp3uSna0s36CCiTMorD+ztGy+mrcv
         MtmuhJ2xgmX3Q==
Date:   Thu, 6 Apr 2023 15:32:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kselftest: Support nolibc
Message-ID: <bdac4e4a-383d-4d60-8ce4-f26c1e265335@sirena.org.uk>
References: <20230405-kselftest-nolibc-v1-0-63fbcd70b202@kernel.org>
 <ZC7VLXGpB8PRdj12@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MTmPwNu10y8JhqJR"
Content-Disposition: inline
In-Reply-To: <ZC7VLXGpB8PRdj12@1wt.eu>
X-Cookie: Man and wife make one fool.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--MTmPwNu10y8JhqJR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 06, 2023 at 04:20:29PM +0200, Willy Tarreau wrote:
> On Thu, Apr 06, 2023 at 02:56:28PM +0100, Mark Brown wrote:

> > At present the kselftest header can't be used with nolibc since it makes
> > use of vprintf() which is not available in nolibc and seems like it would
> > be inappropriate to implement given the minimal system requirements and
> > environment intended for nolibc.

> In fact we already have vfprintf(), and printf() is based on it, so
> wouldn't it just be a matter of adding vprintf() that calls vfprintf()
> for your case ? Maybe just something like this :

>   static int vprintf(const char *fmt, va_list args)
>   {
> 	return vfprintf(stdout, fmt, args);
>   }

> It's possible I'm missing something, but it's also possible you didn't
> find vfprintf() which is why I prefer to raise my hand ;-)

Oh, yes - I just didn't find that.  Can't remember what I searched for
but it didn't match.

> > This has resulted in some open coded
> > kselftests which use nolibc to test features that are supposed to be
> > controlled via libc and therefore better exercised in an environment with
> > no libc.

> Yeah that's ugly. In nolibc-test we now have two build targets so that
> we can more easily verify the compatibility between the default libc and
> nolibc, so my recommendation would be to stick to a common subset of both
> libcs, but not to rely on nolibc-specific stuff that could make tests
> harder to debug.

For these features we simply never want to run with a proper libc since
if we use a libc which has support for the features then we can't
meaningfully interact with them.  We're trying to test interfaces that
libc is supposed to use.

--MTmPwNu10y8JhqJR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQu1/MACgkQJNaLcl1U
h9AKrQf9FJ4PEMz9Ni8fLSHTryCUuwHgsy8fRLZ3E6W81upwXdouPyElgX3Rz/Xy
yY1pRVTt8kH4WH36JsswWeXSO1UzyRLFi9JOpeQtWOXRIiB+8fwNEGqqIW3nw2p+
LNE4ew8WlOwKMbOxBxR6bGP8rfILBLogGQrT9eoxoP13e6+6lxg9EB9ydjcGWwlG
CLw+zUg73api6eKp5KY2cczbt5uXjTynFSygQo5YXaQ9a4vMzqwb9y9myIq4bs57
6A1yyfbP9+2nBQ7WSijAU+/jPAbE37mZvV74s9AxXu5dUgTaGEn8RsfVX44DYamw
Biml/SBG2ZWtwJbZt8/ttN08eP7n4A==
=WIUj
-----END PGP SIGNATURE-----

--MTmPwNu10y8JhqJR--
