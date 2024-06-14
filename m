Return-Path: <linux-kselftest+bounces-11947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8528908D5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 16:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874781F25276
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 14:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA0EC157;
	Fri, 14 Jun 2024 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X72srpFj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBCBA38;
	Fri, 14 Jun 2024 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375359; cv=none; b=K6T2gjHxA5clUZd2yMBTmtdSdC37yPrJJvHCkkRt4+VwefkNQLl/weeRfFx1lhaCZLgvtcbQX9yS16C78s3nbiL0gg8YWOSRqT+A+gEuTtTyqeZ4GMPEp/cRugQ6d6nOH+6Lu29/lmUKJX4G8Py0tk88D5Ip1F+enW5/n4THjms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375359; c=relaxed/simple;
	bh=+mjXf4NNEH9LWUSCaszngxmhhuTzLjOHRvtV0P5cAaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRg+5rykWeujuPVbnUYmTUcAXDMLFEIo18eimJvTHTxzKGKGppqD94jbsqczxk+58i9b4RovxmSYPrSUL7veSpPKq5p/5lZLphqmPa/a8Wq0TK9Rc9Xx3cjdnMrIZ21/5ct5mr/18MwzdcDaioQEdxac6eYq0HD+B1unbYONjR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X72srpFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE18C2BD10;
	Fri, 14 Jun 2024 14:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718375359;
	bh=+mjXf4NNEH9LWUSCaszngxmhhuTzLjOHRvtV0P5cAaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X72srpFjFYsFwXWfkbQKmQVc5XaI22BwO/FH6zL3KtKPEloStShGn01DGe/oO3dyY
	 WMcHAXOoyiFGkolqX/J8SWwmY+TPbP9q85EnzyoVGaMqf3OXt/Qcy9pbEb+OhAwUj4
	 k7aESW5/1IEx9vAuCoXqb2tgFZc3p2GYVrBbg5P7t0OhLDhKH/y2JfI0no6P/TZoe+
	 4vj873znBBKMdichgJwhxiAgXhd7mcGgKQqPrfeksSgZZAM38encNHl7cIkcmli3Ig
	 MFR7fSJzpoPYHyxAKjMcqLqqISB7fjRA2xr5yuV/fbaws40CqyixOHb6PC5N+DnH9P
	 pGm9U5aMHwKdw==
Date: Fri, 14 Jun 2024 15:29:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
	Jaroslav Kysela <perex@perex.cz>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/5] kselftest/alsa: mixer-test: Skip write tests for
 volatile controls
Message-ID: <ZmxTrzZK2lwSLRpl@finisterre.sirena.org.uk>
References: <20240614124728.27901-1-tiwai@suse.de>
 <20240614124728.27901-5-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zZux0OioYOB/fvj7"
Content-Disposition: inline
In-Reply-To: <20240614124728.27901-5-tiwai@suse.de>
X-Cookie: Your love life will be... interesting.


--zZux0OioYOB/fvj7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2024 at 02:47:26PM +0200, Takashi Iwai wrote:

> The control elements with volatile flag don't guarantee that the
> written values are actually saved for the next reads, hence they
> aren't suitable for the standard mixer tests.  Skip the write tests
> for those volatile controls for avoiding confusion.

We should still verify that you can actually write I think...

> +	if (!snd_ctl_elem_info_is_volatile(ctl->info)) {
> +		ksft_print_msg("%s is volatile\n", ctl->name);
> +		ksft_test_result_skip("write_invalid.%d.%d\n",
> +				      ctl->card->card, ctl->elem);
> +		return;
> +	}

...and that you don't read back invalid values after a write like this
for example.  I think any change for this should be in the validation of
the read but we should still try the writes we think we can do.

--zZux0OioYOB/fvj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZsU64ACgkQJNaLcl1U
h9B3GQf/c29lrYLtNlYt1kWbBHXZknNiawUSF0xtHJk5SR3S+eI/MKMNLEdjVmjE
iwJP0YMBnhPgxk+Z9ea1wYE1n5Vy3lzXplM7RyiSgeBLX3nRXTFuGUi8QR1Mgb8T
JvlZWpgK1/nK9jYSSBaHY9fLyY2LXcPg4wrywc61slBU0Jsav06T8dhB2zHXdiBn
XSF/GUko5sOy9OxsCYRgd2znKH/qPN7IEj4+Jw0ysfxkyqseS6TM66kBvKwuIgsb
bFNkvAqZXGqrwI5VGp8xs0g5QfkT3U1FTfKIAEN6iDyiGrsBfvCJJrfzn3P8VavM
6YCRTRY+d8l34xA+1rcdQpYdhmA13A==
=YpUD
-----END PGP SIGNATURE-----

--zZux0OioYOB/fvj7--

