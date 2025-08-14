Return-Path: <linux-kselftest+bounces-38935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AFFB25BF7
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 08:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4531E721A00
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 06:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D373252917;
	Thu, 14 Aug 2025 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jr/kJEsD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9EB24FC09;
	Thu, 14 Aug 2025 06:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153584; cv=none; b=jaxDQt1lr1rXig0sWI9/4ah7mMKBeN/08MuL33BHbMxpDsXcdaSX+aPdfqaE+ClujswgSh5sEpETvrT/UjsSdImDczujhjjgZamwIxD75Bj47RSBizgVyElkxj3Id0l3GIEVWs9VlV/QeR8tmCdssk5P3ix9NsoII2YTZwCRCTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153584; c=relaxed/simple;
	bh=R1C/8DCIBJz96E2r7yTyeQKXLBEZvbbz3YPZilRHxA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCRvjW41h+P/OktOMoODO/atJpVVJM8sxfth2jcdx0kbagtm9rhPPK03q1yBZ8qeMWJ03Tvmc6x4zwysMIyIL/bZYYbrzA6lZAbv3U96i6wuy6sRY903f9TPbKFZknlTvLm5Cz112z74QIOQeM9EUIw9FlS7G6ivR/+b/C6NJLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jr/kJEsD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2445806df50so4184335ad.1;
        Wed, 13 Aug 2025 23:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755153582; x=1755758382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1C/8DCIBJz96E2r7yTyeQKXLBEZvbbz3YPZilRHxA8=;
        b=jr/kJEsDnjD/nmJQ3oijUrAZXAf8LhjzJwNhxGxq1aPEwJdCWvhVb+DXYr9v+olo9y
         zn+n9IvAztJeIUArutGDSoBMSKmLovA5Z0NkqAsYI72SuWavElB3iXVsK5KnSOoteuZa
         yzvxl80Ir1wtGSVXsnAX2YYwB6yPG5OZDqGrIlUH70wJZj7dZslKOhwWyuci/URYipHy
         v3GuvTnkz6FSje5n6XezNSJoHoXfJxMUlTXlck+ZhqCxAbetHoDM6LafzuWoPHkmOsoY
         U9y2T9Y9elp4kRON3eRFf7umnUNyS7wGhqxgfPaBVfiBk8RuG0GEVC8KqrGZCTMQRviB
         tjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755153582; x=1755758382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1C/8DCIBJz96E2r7yTyeQKXLBEZvbbz3YPZilRHxA8=;
        b=hXdNkpauHn/+rL0INDWcHPd/Pl4cgpm9IzOFJyTX1877LA6K9fxiun+mRU4Di6EaKS
         O5pTkEWGyP2yM29y7iAVnrAMYF5JnGF7erKILoxWWzXjTunnd3nGfGAzvGA8XkiSyBmL
         y5X2J/Rk4JUNqInX0zCafcU8r51Vi0oof/RN3jT9w2nzvexKeR8TUVc8EpmiLCo27H6R
         I2UQWxsoXp3TLI8McljgFjeYPyT2Lln1d32OrEWdbB2z+UX5Xe4qNcjSv9QnZaxEfyRr
         KQQe1sJIDVf4MblxWwLALM1hi3/IESaDjdA/ixbOPJNtjei2yHi18gqOl92j+qz2dtzX
         /pbg==
X-Forwarded-Encrypted: i=1; AJvYcCUCYnqQLr+GUCDc/wIYggZRL4gha+PX8M3dirZH522MTGVUaGXgOU5cEDEJm42ACAl/grdfD3MdNswPIinh@vger.kernel.org, AJvYcCUjaHAhKgBzhVINEjve5q1ul5OsHsmKb+dKT67Ju36YorIqhMcpgscwYJPpUPObeMYtsWxgvL4qSMAP@vger.kernel.org, AJvYcCVAdiBLuS+F62ly4JS/XB0y2Ly14UtnnVG4E7wpNuyaqSYTwZqQTXuVRScCiPasWB0ieuN+hWZMd4g=@vger.kernel.org, AJvYcCVNTes2H2etAEXGiPte1wQjhqQFD0YU1wRG4XXn//prxBMcIiQwVOTNQYlUKEteFZBrwJBT0un2qJBdrWyPt8Nd@vger.kernel.org
X-Gm-Message-State: AOJu0YwwyMMv8yHtRnyOyaHEILxPtYR7sD5dV0AoUhPjnrzPoCJIn0AX
	bxRDZdCoVrU1dXFDV6zLe2S5Qjt8PG+/nUn9LbRrZISTmX0862eFntsA
X-Gm-Gg: ASbGnctgDS+J3Zui/4etNHcbmr+qmpJjCICOdrGmDf4aSPp4VGv08h3XcNm6Aav5bQi
	YhGpQqUTc3kXZZ94tTeoGXGoM1mbjyhtPHXsZOruygLkisOZZZf++rLFBAMPH+2aRhOaFwnw3B9
	y5P9UbZwlMfFrL6tjHX8W8kLC4/O4MpbKpoBweQeXNEjdqw6310+UM3BrRJwSYntluesocSCbS/
	pIT/9FnPDlSZwSuiBU3Zguie7TZ+JVGzXjaM0F7cF718a16+hBkBR+/ly6+CL9S4jK62Tnq5oFz
	v18APxGchKOzYlyCjo0SaqbUArmd6E/hSrcypL2RDHjje4txikHmj4Dq9AeVlY45YziRGE61TdD
	U7vFMH2TnTXi9bpL4KSlAnw==
X-Google-Smtp-Source: AGHT+IEUsKVk7G4ljZuETiaQhj9SpFjdw3c+YmZ4fIKMSMdn/3GF4m36bVdbkDaj2lnQ9wltfClBWA==
X-Received: by 2002:a17:903:1af0:b0:240:2145:e51d with SMTP id d9443c01a7336-2445868b3ebmr30999825ad.31.1755153582122;
        Wed, 13 Aug 2025 23:39:42 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-244590608dbsm10300325ad.66.2025.08.13.23.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:39:38 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 783CB40164BE; Thu, 14 Aug 2025 13:39:34 +0700 (WIB)
Date: Thu, 14 Aug 2025 13:39:34 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Linux Kernel Selftests <linux-kselftest@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Tim Bird <Tim.Bird@sony.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH 0/2] Documentation: ktap: formatting cleanup
Message-ID: <aJ2Epp0b3HgeaMxk@archie.me>
References: <20250814012046.21235-1-bagasdotme@gmail.com>
 <98ed6868-8030-4d10-b66d-c7e3d42886f8@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ie7JBSI6Q0nMquM1"
Content-Disposition: inline
In-Reply-To: <98ed6868-8030-4d10-b66d-c7e3d42886f8@infradead.org>


--ie7JBSI6Q0nMquM1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 06:58:12PM -0700, Randy Dunlap wrote:
> Why send this patch series to the workflows mailing list?

Workflows ML is listed in get_maintainer.pl output.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ie7JBSI6Q0nMquM1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaJ2EoAAKCRD2uYlJVVFO
o1TpAP9lIizu4pMJAsA+vYyUic3/QOcQJD/j49wQx+7Ze/5cOwD+NP451W3K4yU0
7K0SzH1b+L+VQr9cnTE9JqR0GqZ1BAk=
=TK+6
-----END PGP SIGNATURE-----

--ie7JBSI6Q0nMquM1--

