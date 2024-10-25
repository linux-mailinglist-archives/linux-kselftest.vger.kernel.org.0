Return-Path: <linux-kselftest+bounces-20660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050DB9AFF82
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 12:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37FFDB25A2A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 10:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7569F1D63EA;
	Fri, 25 Oct 2024 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbeKOElD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF3C1C0DF0;
	Fri, 25 Oct 2024 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850755; cv=none; b=QF5dQKOfczkVzwLU9/LZfMmXQ6vmZ32EbiMadKs062oByhYYeep/8Jczk5cLdzwZWynXEdswLCAUS7vxACdBM+dz0qqObnEESeJi+KVBIouSOqiUDkSUVJVld4jSKjz77AgVe0bIWf4yynt1IO9Hl6eY+FQZSCFlxTLTbivYKBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850755; c=relaxed/simple;
	bh=d80JKrTzHZwxS7GVDWBKiR0+iPVCU3MTwX4pzo7j3Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhdzvPaTrGGobHJx9V3hoxE+KbGi07tHcS+dJHSuz7pawzFjpEKHMYbGbkvyeKUEB9170nOn/x4hf+JSGVRMjawBbozGtyvxLYfi60BTgHR4+CtjeC/6qCGOd4XvQ2TqY1J+s/TdZzvQe0kO54WP6I3GmVwL1tVRS+pXihxi1XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbeKOElD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF13C4CEC3;
	Fri, 25 Oct 2024 10:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729850754;
	bh=d80JKrTzHZwxS7GVDWBKiR0+iPVCU3MTwX4pzo7j3Q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YbeKOElDGrzQwUM9UVmzs4FTlB9A0/BYnlt1Kg2q3SwmDNNKLtLP2xWkROR5qMeWB
	 mxSqBKRtSWalfWKej0GSOdeoxwMD+nmr/L3OKNoP+ICLc2KEcf3kKXFhs/2Q1uDJAj
	 /W2bCFozALgudtfsbx/7fOxX3AE+SDLwt3s89zL8XtGigGq0xgmoLUD04hfqVVwNNt
	 4yoBYQk6T56I085+aEglB8syzhbUGl1tqaOQK49u/xjp1E8PW2xQq/UPKxLOVRDOn7
	 euLfbxTPTf4umhWhUh2KykEc2bqaBYqHlGxnp1vkgeOMco/WgpBPkMbW3OZyyEFLTu
	 Rc/QNVU2Ysr7A==
Date: Fri, 25 Oct 2024 11:05:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org
Subject: Re: [PATCH for-next 1/7] selftests/alsa: Add a few missing gitignore
 files
Message-ID: <831f5cfd-2a4a-4b48-9ce0-55215cf2c600@sirena.org.uk>
References: <20241025014010.6533-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZPDZZejE6/rt7ECm"
Content-Disposition: inline
In-Reply-To: <20241025014010.6533-1-lizhijian@fujitsu.com>
X-Cookie: Often things ARE as bad as they seem!


--ZPDZZejE6/rt7ECm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 09:40:04AM +0800, Li Zhijian wrote:

> index 12dc3fcd3456..1407fd24a97b 100644
> --- a/tools/testing/selftests/alsa/.gitignore
> +++ b/tools/testing/selftests/alsa/.gitignore
> @@ -1,3 +1,5 @@
>  mixer-test
>  pcm-test
>  test-pcmtest-driver
> +global-timer
> +utimer-test
> --=20

Please keep the file sorted, this avoids spurious conflicts in future.

--ZPDZZejE6/rt7ECm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcbbW0ACgkQJNaLcl1U
h9DLngf9HZN3G/r08l2XIWByPI07w1WsERP+h6ZC6ozmgsOl+NOMfYEArrLAKTTw
Q1Y3hA2E/Iga3ATg1w6z/2ycTGSS0YYnO4A2pl2Z6IMopFzho/bQoZQ5OTZ2/ITH
n9/ENmyjP8xF2Xz2iYsWVWCDEZijX1ZW541cSHD6QF7XJVAZjAGt3gNPPi7e7AJx
79bZJihkwKdWIlpZuJT7aNzWOydA6cIoj1X1AoM3tWo+Qvt4LRciJ/Cx78oZg+XA
KRfjUYceQbe5e04ZvLNHu+zbv72i2ogzVZJOOnn/001NF8aFNP4mYHHwWVgqYyOV
VbDxvShANHI/UsPo7QJl4KRZ9o9NBA==
=gRPk
-----END PGP SIGNATURE-----

--ZPDZZejE6/rt7ECm--

