Return-Path: <linux-kselftest+bounces-39830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEF3B3405B
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 15:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA034856E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 13:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0658202996;
	Mon, 25 Aug 2025 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuhREm7r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17A1F418F;
	Mon, 25 Aug 2025 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127196; cv=none; b=ioR551v3IY6ZWPwas6/xaaW0+WcsEPKvrb9gK5OjgRT8F1R5xl19+MSiKC//wW6UkWFsgqD+tupVhj2XjI6pVZJIkMX0Y7xTR7TLhvM2nMOfanpDMIwsbCrpeRmgvgVsDVQDp/dYNQztidB5BtAGSEg6HBBkq111ffnaeLvNRfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127196; c=relaxed/simple;
	bh=FeHS+tJrW9ZraKAp3dY5aFZJX+0uhfMK5f0hPXIAq/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kqf6EfhUQfMP3z5mDPO3FQyKUNTfEntF77pvaqET0xvTfEt5quRcRLugnd1BqnhzBJewJyjhK1CFnX94oASE5PG+PcT+5CRptXWoBE91JM0eFryl+jdd6jjM+4WP4fK0Q7XctoT5TGVLbBkjvHd7za+MfimsBspF/gO25Bs0Lac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuhREm7r; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-244580523a0so41472245ad.1;
        Mon, 25 Aug 2025 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756127195; x=1756731995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FeHS+tJrW9ZraKAp3dY5aFZJX+0uhfMK5f0hPXIAq/A=;
        b=VuhREm7rxehDbEHTuSEJSYHrMfqUYaxUaWMm9mJ/gGPMQdyqeYTlaHS0+HOM3Rp28Z
         1nysmdolVryt38b8/6sW6tYF4WKLtkrn1nbA16Mt8J6BjLvnu22and0GABC66wxG9pMZ
         QxqIRTyPeBnrYD0zFf/sxFwQGcIN7cSfvWEbR3M7WeUd8liK2MCeAMPfVFUAQ/+7xhIx
         G+kq9/d3SuNe/1SfJGMAwPmbzMgLL3k5/O+h9de6XDmepVlwbKZJx8mbrzMRS5x5w457
         YJ60b0ENpVw0ONVl5328XJvf3afCumDbY4Dl0nF5mh8OYe/tLlSzmwquh93j3nAIRC04
         xW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756127195; x=1756731995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeHS+tJrW9ZraKAp3dY5aFZJX+0uhfMK5f0hPXIAq/A=;
        b=ly41wp1OVmJyZa3f7/kZnZrNkL1D54dahOBWG6R0UHxGUMQIFNEx+AP+xT/SyNUpK1
         dfogNAdb4myT8V4LatWaw8Bid8hk7OI49c6SSu+9QPojhHPXcWcmCM61sfXLU4zpyS4E
         G7SzcSAJ6cR09ZBMwMm+5oce2ysjCGbrPrRpZ9aUj8yvYJ+wW73DMzvQuGqHYi/+/Q6R
         CaQg58SNhR0DiPGehJYQH3ayqBr1TildGFjFKPd+lWLSatJFQIZ4AMt0rovY8ljKfq17
         DNfCk2GMX62F4EZuKvj7v0Q67ch/DrNcOZrVAbHtYcSQ3++HklQhDFXkhE1SS2wqju1E
         0/uw==
X-Forwarded-Encrypted: i=1; AJvYcCW8Ik9tPR0YlKfpF91c8apiknwlwDC+NZu9AZNl9TYj/KDRu3ucBJ7Hb5ZyLcjy8y70JJ8hZAXJH4HS0dARZpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+U7fVzaYfHbtXuR3PWfdzrcMB9TU1W+RobLRbfBT3fvmUQ+C4
	dgVn97OGzvL9E9ASbdOiba7FLXsWmrx2+qEDIZI4/bhXXy2JQEk11cDO
X-Gm-Gg: ASbGncuCl+bNeL4GwSuAnkHpEKRQaBgDtY0gh6C9YpRP22F8sgPqHsnWK0i4gFv2tr+
	Q1XoPKWWvc3aRqe63VpH7rHI2KGfl+uRj91+eK+EmSpGMAMc/Hw+RALhftscymHtRtmeAzIq3O6
	45tjPDXB2fk3pbSyF5aXmzgjyaaioOQXUUu7z1TXMoKtcxlRaW3c1E7AfFN2tWwWlaJf1/nXFUQ
	zxMtaStz5FIbKRWMzsa62po+rTf+GYPz2eCVgKUFoyxKUPobRrL29ekRUAWVjUV/aD9FFejz9ay
	oNc+vXRW3gai8nQt12SOuPWLY6JTlwvihD9P2hVHxZIRJehGcTFI3QJB5GX59MPWabfi0pfBTLi
	DOSOqVV8po/4+laohj8nMrTLWpF/+nElcpDgJWuLkrXU=
X-Google-Smtp-Source: AGHT+IFsrdGj5ONohaBrEbHATvRUaAGYnpkIopiRoXVCgitKhuXtw0IQV0Dnk+CfztUMDHaeXeFWDA==
X-Received: by 2002:a17:902:cec2:b0:236:9726:7264 with SMTP id d9443c01a7336-2462edc37a2mr180907925ad.5.1756127194436;
        Mon, 25 Aug 2025 06:06:34 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466886122dsm68847975ad.101.2025.08.25.06.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:06:32 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 599494020B61; Mon, 25 Aug 2025 20:06:30 +0700 (WIB)
Date: Mon, 25 Aug 2025 20:06:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Eric Biggers <ebiggers@google.com>, Mark Brown <broonie@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Shuah Khan <shuah@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] selftests/arm64: Fix typos in malloc return value check
Message-ID: <aKxf1X1u8QHAdvqW@archie.me>
References: <20250824131647.490439-1-zlatistiv@gmail.com>
 <ed07c6f9-e389-4387-8585-6f1206da1a07@web.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fIO8M9lhbFK9DNqg"
Content-Disposition: inline
In-Reply-To: <ed07c6f9-e389-4387-8585-6f1206da1a07@web.de>


--fIO8M9lhbFK9DNqg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 03:40:44PM +0200, Markus Elfring wrote:
> > Fix double "-ed" in malloc return value check
>=20
> Refine wordings in error message string literals?
>=20

I think what the patch author (Nikola) intends is "The error messages' word=
ing
use parallel structure device, where the second verb should've been in
infinitives form. Correct it."

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--fIO8M9lhbFK9DNqg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaKxfzwAKCRD2uYlJVVFO
o0qZAQDaefbC0aa64Pk+TLexCY84I8KwjJWmZwptmBm5h9RRqQD/U/dm64bgsWdS
gKnKPBGmuJkji24s6mH1W1FT1SvNzQQ=
=EI4L
-----END PGP SIGNATURE-----

--fIO8M9lhbFK9DNqg--

