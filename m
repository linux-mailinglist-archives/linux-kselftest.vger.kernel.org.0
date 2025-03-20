Return-Path: <linux-kselftest+bounces-29491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE476A6A4D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 12:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45269822FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 11:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E80621CC68;
	Thu, 20 Mar 2025 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="I9x3sfZW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56721CA0A
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469612; cv=none; b=e9vFJHsxOKc0GmxH37n9jV3q8GmIc1cABaExAPDGj/HyDA+aoamGZ96wa/1kTgA6lGA22PdUXTPXz5jbkoML630N7/mpe8VwSrltoOOXOlEoMAajyzRdg2YRMbqla553agC98zwtpq0z3TEmM/B75V8FkA/Y1DJBksIJ8KapWlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469612; c=relaxed/simple;
	bh=c9in5ky7MSyDydh7HyOrlQT/pLw+J4dJ+b2Cx0Z3sSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfkFkDH1kjq8RvKt20UCSEXGUvGvY+/hDDPAcKiLXi1HNERrCufrpfqOrg1IaQkDS5UoXcMztU4C/Z6oW0/ozoke6QPZy+KVtZi6aA+JQuo6++rxU4NsR9XBL6ki/C1ltXsjHBeZ4ZpTdxwYrVJu6mbcVPFL7KaRD34keZcp0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=I9x3sfZW; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=iDIJ
	IKhTKAN042Zme/lW/P7yyI4g/zIGmLhB5BgbU7A=; b=I9x3sfZWVcfaDg60Qu5u
	K+4akm8iHKILDKI2rgKsIOMBITY2DkF6zJiJUV3X1A8K5RFP2I9lzuPBRhNpXVav
	WlAnkQ1iBe8WNDiC5vYkgFlkHQTB4Ysg43HL/wNxmqDHU+SrPQYAs9v2HIpwjU0X
	0Vgsq+5JzIaXSCU6kfNjuUTE534EmeGW0CZrjRFGXtDTNjvTDlo3gp9r2Q2A2hhY
	38lTyAthYNwM753sjm0vtTePmDt7nGqaALRU5hLfQbKUxwD9tKruNPg7n6hxLKAv
	ZDgqUm+qqNy8/f9DmWLwZSWXlu82ugnsSUyOVbBI5EEwOxQ6ZfNbjRPnqWlUY6Hq
	Kw==
Received: (qmail 629424 invoked from network); 20 Mar 2025 12:20:08 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Mar 2025 12:20:08 +0100
X-UD-Smtp-Session: l3s3148p1@748AUsQwhM0gAwDPXyTHAJp038nK7dx+
Date: Thu, 20 Mar 2025 12:20:07 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shuah Khan <shuah@kernel.org>, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH] rtc: remove 'setdate' test program
Message-ID: <Z9v550Kbt8tjYst3@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Shuah Khan <shuah@kernel.org>, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
References: <20250320103433.11673-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdVwVyyZWfgFi12ujvSj8bVtDZyZvj+QMZ_iQbPbRDNHQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VLk94VSnE6k0T/In"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVwVyyZWfgFi12ujvSj8bVtDZyZvj+QMZ_iQbPbRDNHQQ@mail.gmail.com>


--VLk94VSnE6k0T/In
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Geert,

> Where can I find these "rtc-tools"? They don't seem to be carried

On your favourite git server :)

https://web.git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/

> by e.g. Ubuntu or Debian.

Well, buildroot has it.

> Iff this can be cross-compiled easily, it might be a better option
> than the rtc-tools I couldn't find...

Did you find the 'setdate' utility? It is in 'testing/selftests/' not in
'tools/'.

But yeah, rtc-tools could get a wider audience. Packaging for Debian?
Moving them into the kernel tree? Alexandre's call, I guess.

Happy hacking,

   Wolfram


--VLk94VSnE6k0T/In
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmfb+ecACgkQFA3kzBSg
Kbblfw/+NoIkmZgfRxhNzjeUAkHBcfE3lj+X2bqKCLQf22WYnWpImTJsZrtYf7qb
PY2jjqcVXKjJimf/kvoDfJz5eD35lmeKb1YfMgsk+DGwCRcPGUFuyKYSXfnHb+G6
b7zUIvg6EFp4ea/RHSUPOjP3ESqGhHA1P2coCeVQWNN/PFvJGuW9sUC8V2YoCNrm
KbDYiHqsxoacnX5mZry188/VkdL9i5uxLdXFOFKtBYPGf9n9f2Z/SR8uuoehadJM
6VfFt4GXEvCIzpV5LYuH4OOhsJpwFiW6YA6RdgMzp9GvF2EXth4V7RZ8/LTkahu3
MqfjNkqC4Jz9yqgoj8WVSasRZ8xR4G5miEYfNGqNdM4C6kzZ8nr7DlA9MNaDRzlz
CSbzEz6tl8DKl/fXvbisTdxcgShZuB2dLc6XvhFyoKP2pvVXWqvWhvpnc+ak4xrZ
pay8y0aoOf7Gc1E3X1Dtpt+WZJXUvjh50rAQNWQ3DAWi07llbqsl29g+6cVYERm7
9aEGKFahA70SvxJEu5YyclwYxUHXlAotahPi9xV+1EMai80varxxdEwl/DTPzlkp
eN513/VYguJrztr2Rf9ydHuGaViYH2Kp9I0bZ0e/NiMhuD+H6oiqn0GUaK9uMlKR
XSfMGqAREVCCekpfffh/KYc/58FC35Ap+SUdNBlL4xdM4REau6I=
=1dX0
-----END PGP SIGNATURE-----

--VLk94VSnE6k0T/In--

