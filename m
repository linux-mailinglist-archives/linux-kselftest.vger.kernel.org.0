Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D5E5287DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 17:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiEPPCj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 11:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244843AbiEPPCj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 11:02:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738D53B3FD;
        Mon, 16 May 2022 08:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95159B811CF;
        Mon, 16 May 2022 15:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06E2C385AA;
        Mon, 16 May 2022 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652713355;
        bh=BrYg+P0E76QFC+K+QlgC5bvnhhpGso5mTlZran5yFn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVy9NZlxVi2S7kRNO3iFcEM/OKeHQmnKzyHXYl1CpDZh5ap4dSxopYPEQuxJRCL8p
         Lc74BM+vfewteyA1lUiFR3IR6+BwiyYjIXGtvzr2PDUY3QNWB95aWxAf3/eWS6eoVo
         +9+RnxHJ/logeTxspYuP8Py6CL2MxNLo+8NGQsHroOd2Hs6eDmcTvgQuHPYl4QrSpg
         UJX68Z8B73ov64eyl6wXZFIPjaMCoh2JZS3RWVfHZh3gy2oJjIRpT+kwG4aW91zveg
         x30jmjRu2uIdX4D9zhGOEdXjDKxdRcRLF1Om+4zT41XCvA83Jj4iwYPebx60ewnCSw
         qTSNrzanBQmjQ==
Date:   Mon, 16 May 2022 16:02:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Siddh Raman Pant <siddhpant.gh@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: alsa: Better error messages
Message-ID: <YoJnhulbKk49rZsw@sirena.org.uk>
References: <8598037d-0e24-9bc1-3f2c-a2751ec8e871@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cH4kqHwkCNRl3JMX"
Content-Disposition: inline
In-Reply-To: <8598037d-0e24-9bc1-3f2c-a2751ec8e871@gmail.com>
X-Cookie: May be too intense for some viewers.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--cH4kqHwkCNRl3JMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 13, 2022 at 07:10:57PM +0530, Siddh Raman Pant wrote:

> This allows for potentially better machine-parsing due to an
> expected / fixed format. Also because of eyecandy reasons.

As I said in reply to Takashi's mail I'm not convinced about all the
changes in here, a lot of it's really bikesheddy at the best of times
and to be honest there's more here that I don't like than do.  The
changes aren't entirely consistent in the final style either so
presumably not great if there is any machine parsing going on.  It'd be
much better to split this up into separate commits for separate changes,
that'd be a lot easier to review if nothing else.

>  	if (err < 0) {
> -		ksft_print_msg("Unable to parse custom alsa-lib configuration: %s\n",
> +		ksft_print_msg("Unable to parse custom alsa-lib configuration (%s)\n",
>  			       snd_strerror(err));

I'm really unconvinced that replacing : with () is helping either people
or machines - the form we have at the minute is probably more common for
command line tools?

> -				ksft_print_msg("%s getting info for %d\n",
> -					       snd_strerror(err),
> -					       ctl_data->name);
> +				ksft_print_msg("%s : %s while getting info\n",
> +					       ctl_data->name, snd_strerror(err));

Why add the space before the : here?  That really is not idiomatic for
Unix stuff, or just natural language.

> @@ -542,11 +541,12 @@ static bool show_mismatch(struct ctl_data *ctl, int=
 index,
>  		/*
>  		 * NOTE: The volatile attribute means that the hardware
>  		 * can voluntarily change the state of control element
> -		 * independent of any operation by software. =20
> +		 * independent of any operation by software.
>  		 */

This should definitely be a separate commit.

>  		bool is_volatile =3D snd_ctl_elem_info_is_volatile(ctl->info);
> -		ksft_print_msg("%s.%d expected %lld but read %lld, is_volatile %d\n",
> -			       ctl->name, index, expected_int, read_int, is_volatile);
> +		ksft_print_msg("%s.%d : Expected %lld, but read %lld (%s)\n",
> +			       ctl->name, index, expected_int, read_int,
> +			       (is_volatile ? "Volatile" : "Non-volatile"));

I don't understand the comma here?

--cH4kqHwkCNRl3JMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKCZ4UACgkQJNaLcl1U
h9CEbgf9Eps4RQf5GwgggebMWvlsEDS4AHT1wMUSZOns3d44DpU8Em6Fg9BHGF19
Y8qy5envpJ30adNWBZNS+hH/Cr1mzHsP4CXYxADNBTMLDvwHAT7v0xDThc5lGNhi
TjMNxnYssD4uk5vwqEDjfukpqQ8ee2U5Mteysg3nNfvUK0Y4Ty7rLU11wHPdpsib
iuwVlm56PbJwhJz/++DDj5JfAQKz+7K5ZMWmTYNyf4flwB2UyWdueeKknrNh7HrK
etvB6eYnOddvoP1fLzsZxFWE6Kamk2Fb7UPfdmc9HX26XhvrSpQlre5e+Otbs9Ft
cLadxKCsaQ6kn9eKdRiwUQwfDNvXEg==
=9XeY
-----END PGP SIGNATURE-----

--cH4kqHwkCNRl3JMX--
