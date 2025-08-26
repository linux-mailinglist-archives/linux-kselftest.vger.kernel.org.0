Return-Path: <linux-kselftest+bounces-39895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C939B34FDB
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 02:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF32240062
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 00:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC123AD;
	Tue, 26 Aug 2025 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbRk6If+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B9D3F9FB;
	Tue, 26 Aug 2025 00:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756166465; cv=none; b=fjAE2hJx+di+cbSbpS+SZhYVxh3nbRXYcta82s6awhHiopCWHgc0+mhzUxYNUtSCSQ7vqqKFAG25z4o/s+4MwjagHHPMQXya/00W88XWg/UO3A34U0nppP74mrhfuWgXdFWR3UjwVxPQ53rtybL2fljE4WnxReNLy8/qZzLZvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756166465; c=relaxed/simple;
	bh=mHFuIXiNmbEkoVbj8VOYF+pRey/xF5VfytxKQHW/a30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgblfomdPc9qjeef2teKAeF5mTHEAExFPKgZBZSs0rzu279BBG6h3YZh/3/zVqe4fKF/iv2R+ayZBTw36amI7uYbvLigBWLUU/igGwydv12YLKIR6fP6i9Tt9WHlDFiPPKWlEGvw8IzFSq/2TXB0nWeL6D+lOtpCuEhpnf1xF7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbRk6If+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24646202152so36013825ad.0;
        Mon, 25 Aug 2025 17:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756166463; x=1756771263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHFuIXiNmbEkoVbj8VOYF+pRey/xF5VfytxKQHW/a30=;
        b=TbRk6If+Uz9uVUP68MXYpZLI0LZvytbZjcdd3UtEuY/kqKI8K8XKBQh4iI4fzeYzTk
         kh6TnJPPDtehpzrhY6c+4Ju9b5Pjr/1wDTLmfJzH2LTIaDLgl3OapiIC26t7/j/kyITR
         PlZ6wDJr1i4VVNlnZMuhYqrfK0+BHEWTDi8YbFK01nS6rye515fz5N81c3KoXZBZ69Uh
         yfeJWr1HkiIMftWr6GpeQZgx7gMs6CFy9tL9bk4JuLxiGlcyPhL4ANTrc1QcdfXP/65O
         QR7WwNkzo5k53j/9Yz3r3S7Z18WOdJ+JyHNYojBv++tSoBi0ysU1V533ouT5MPpd57uC
         f6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756166463; x=1756771263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHFuIXiNmbEkoVbj8VOYF+pRey/xF5VfytxKQHW/a30=;
        b=e3J+0GVPrLgTRbE08QQpR8vByfcwjlxvOWAdc1DmCDrvZK0YtDELtpvhBmuRcDXSRH
         KTlzKb1NJaFTlClhBwwvF4nS0Up9PhKr/ssjV3Qvm6avgqImfArIn98yZXIZHrQtZrDN
         91+S4keOF57Cj3JuCGqmq4BqUayI9/oRt8R1ktGBXjPPrR/CL0kcF9hJnsbM3YkNVOp8
         lkeNz/OWTVx3DTCUThVUJq40muWbzo17Q/IS+pxxO4C2fb+1HgUgs/5XU4AtLdysy85y
         n6eBFM18s35WvInERFSP6LSOi58yET8+k1M02o+0iE9u55t7C6aOtU76YK+rV3Jc0Ese
         1Wyg==
X-Forwarded-Encrypted: i=1; AJvYcCWETXcpUErv0SmXGwowP9uhJjjBHCuKznVTSlMvpm+AME9sCOKcvv+Wh/WeIuH2CATTvZPWVjNAxqhVOqo=@vger.kernel.org, AJvYcCWSr8TSqMNO1GnEef51ENAcdBmsJfD6upKm6rwUS/MFwAdEAJMvAV+VFkSAE2qwGwb7brviJcQJnrmbuJA1ypwx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa2hPQpu9RUEDWhJpP6gBk3pWaPySHpd1mibbdBI+Q1buzUpiK
	zF+o1ZtthafCDPL5CYDoEc+giYrjq3yL05kMH++aWhWOle0v4opEE+Cx
X-Gm-Gg: ASbGncs2Y/kF2gb+iU2dDvsUS20WQEWMk9vF2rKkgCp92+6T3tKG3uTEcrWAJvd6Icl
	0zc5aihDcBr0NhOopqMA7ojhnvytI5gpPGvBiOy8r/uplCw36IGzBpIs+mfX8KS1mGoBLGG+vmo
	fGwvXZnKBD1GLuDAQQfM6+vLIzXxXTDcma1y95+DZHLbQOoa5spVto7AfRF0zohbYD4kHncdTUo
	xsEBD9VMTuuDIQ4tscF4gZe94JKYiX1ImU+jgg/fiMdNUjd/Ibwz0xN1+ZiJvmII6XYs1oNR9Bj
	Z+5115tBja6Oo3WgUHvC19Gdtx3b9ZGrBMYdxo2kaM0PugPT+LwCHm2fGIZ54NdFSz8iMPv3629
	0rn6Jtm1j6qyGtAHusGUqhw==
X-Google-Smtp-Source: AGHT+IFKcbvwi0kAjgdjFjeLliZLzfUxsoGc6FLH2aqpXBw/4v6OLvxDvjNLeydrT6uV6iibMapBlg==
X-Received: by 2002:a17:902:c40f:b0:244:99aa:54a1 with SMTP id d9443c01a7336-2462ee0b77emr192667065ad.7.1756166463145;
        Mon, 25 Aug 2025 17:01:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2467e3238fasm70835275ad.104.2025.08.25.17.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 17:01:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 940E6424E25B; Tue, 26 Aug 2025 07:01:00 +0700 (WIB)
Date: Tue, 26 Aug 2025 07:01:00 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Eric Biggers <ebiggers@google.com>, Mark Brown <broonie@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Shuah Khan <shuah@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] selftests/arm64: Fix typos in malloc return value check
Message-ID: <aKz5PJev5HwYcs09@archie.me>
References: <20250824131647.490439-1-zlatistiv@gmail.com>
 <ed07c6f9-e389-4387-8585-6f1206da1a07@web.de>
 <aKxf1X1u8QHAdvqW@archie.me>
 <u4bv3ypqrdaz5klrvs57ptp7tu25etf7xzvoytrgnz2xohiysj@vua5mcbpznio>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1viLhCQliFWdXD/L"
Content-Disposition: inline
In-Reply-To: <u4bv3ypqrdaz5klrvs57ptp7tu25etf7xzvoytrgnz2xohiysj@vua5mcbpznio>


--1viLhCQliFWdXD/L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 06:44:23PM +0300, Nikola Z. Ivanov wrote:
> On Mon, Aug 25, 2025 at 08:06:29PM +0700, Bagas Sanjaya wrote:
> > On Sun, Aug 24, 2025 at 03:40:44PM +0200, Markus Elfring wrote:
> > > > Fix double "-ed" in malloc return value check
> > >=20
> > > Refine wordings in error message string literals?
> > >=20
> >=20
> > I think what the patch author (Nikola) intends is "The error messages' =
wording
> > use parallel structure device, where the second verb should've been in
> > infinitives form. Correct it."
> >=20
> > Thanks.
> >=20
> > --=20
> > An old man doll... just what I always wanted! - Clara
>=20
> Thanks, I did not expect to get schooled like this (in a good way of
> course). Should I send v2?

Sure.

--=20
An old man doll... just what I always wanted! - Clara

--1viLhCQliFWdXD/L
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaKz5PAAKCRD2uYlJVVFO
ozARAP920T/0c5L0WMnc2FkxNDSA5EjC8NhZPcRc40EQJvrbNwD/ayi0OlIl/02c
o5bAFcYS6XvDl8io8108nSUee23LSws=
=iJfj
-----END PGP SIGNATURE-----

--1viLhCQliFWdXD/L--

