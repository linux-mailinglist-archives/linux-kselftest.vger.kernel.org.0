Return-Path: <linux-kselftest+bounces-49077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB94D29525
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 00:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F22A303768B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 23:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CCF2E8B8F;
	Thu, 15 Jan 2026 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNC6WO9/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2DC1D432D
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768520727; cv=none; b=kXyJy2AGeJf0j0RLXg5B4MPywKPeQKHKlARCf0qphI1PbXo901ipVQMUUWPGxo/+ReBme5RAt5ZUurquqWj306dwkKP4xiD9co3Soa6vWPoaAwYIy2thHtSPGoLkBRWh/wDiMcnaScJwr2/Kyy8zNaV2rW0NAHrRH2Yuz06rtvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768520727; c=relaxed/simple;
	bh=anu0cb12MUsXZDetyUJXmHWS6gx5i4J6kT+HeZDwZ7E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVUswLicE0CNVXaQ6zkLM09kFIG+/dFPjQVySILiMCKkMUVg7AC2lVUFkqndIQ4T2dU2YuuQWbhvO0IOtqum8zR4sXeKY88ycg+HAD47mc4WfzQF+Z8gGS86B1SECSY0l6s6w/fP+AlQYDM0Fj1kHP4gfv70V0JsdN2w+vnMCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNC6WO9/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a09d981507so10196435ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 15:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768520726; x=1769125526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pxBy609TOOX7PEiqMrbm1/JiMEAuCKLzkMf3kkYPtDA=;
        b=PNC6WO9/n9mgliX46Y6vyS1hq8+8wb1ElL1BH9V9Hu6clMYs83H5X4/z+v6uovev3N
         wbF1ABmd/zuGaeTyENQp1nQcGs9BR/Pu3V7SUbU4kRzSczegI44XUBO17AyNZWmghrxn
         ATIUz9M9JkaDES5vJp5WQxPpKps7VA2lcCLuSSj/RuoMZZkFCAhPWaLeZkIS5gESfif5
         KDDXI3cMO6KkP5KUH2wwQnOQjIjoY4fOYBtlppnTRPsZShAxRij4HFzXHvkGMcIzQBU6
         xhRAAOOsPXXsejfFkQEwrSRnIAfKeWcXVvlhU47BMLSxdydTkFxQe/Khw6+fg1GCWJNh
         3IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768520726; x=1769125526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pxBy609TOOX7PEiqMrbm1/JiMEAuCKLzkMf3kkYPtDA=;
        b=KjV9jRu5hvQ6a6Ljkt5/XzsKQnLnJHV67553Q+oQboZrlal8tf5L+sibBJ57ixKWsf
         a9ztRWjpKs57w16Tcu1KlUqkGTNnleLakXj9AiehlBFWAxa7w6Mh2zqJOp33tiz4r6jb
         43umZxOAeHX9mlLU0MamuL0yT4WpTyHcQsXxjmnTkRw+UZEjOZR7mlGeSz2q5rO1BBnZ
         HQtcxZeJ7vMNi6DFaO+DX1h5sZynDjL4HeFDOSpGdpoHSFNaXVY29yYpdTYCdNYH8dXf
         PpvR6T4Q1M/+7MUq7MvsxbcqxboWVUyIG1AL7t8Yt5CNcenbCrQvLS/Syu+VMBqvY+uI
         7bBw==
X-Forwarded-Encrypted: i=1; AJvYcCXAxVvieHxSnppDcDC4dPAFl5N+E9Dc6lesPV/FZbDo8/MA4FmjqtIGXFytAwrPIIhwPVXeZIwdHOAaKNbdAeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY6w6CbHCtYB1wCTgNu3Ldsv5TFi6LIHyZht72m1ZTRqFW1nr2
	CjYAnaENAsPxh31Nv3mowfGdyiDr/VZ1nqUsfz72XIWh05/zYN8WsWYe
X-Gm-Gg: AY/fxX6I0XiMCDgVK6GIZOZSLvTjEiU74cUxvjE0RPCmuIuM44AmncK/k/Fuaz6WEBU
	WBcWjgTWQYF5Sp7PCREo2JoUYxQjpuhKn0am34+P9KBh4y978G4jcdUQseR3ExbD3s8B4bAtn9B
	P6+rGzvS2Kf0wAeQTcsjUFT458pKAaHDwzzoH+5u3oC+dm9vx/K+K6XHxFsvbyA0YcbPMZScP76
	A9p8ZS3CvQGfZ+HyYczmTT1CnP2PlAZq2pTFPGcWHZZYAtC6V9rq2dwouoVVk4o1HcL7jkvCo0y
	qYZ4BoA7xDWH3nOBtdvZhVDK+V9eVU3I8BV2MNOfTkevj9BDuWFka0Z/vOoUbPezfZyE+urM2pn
	po5Th4G4pzAkCmZJZ2sDwWsRMfC6UrgYogPC4HrfW7Av4mQL19NJqQtwlwbu2jWHt/asbAP7Iyb
	zpUQRt8wxAi88pRhq9yg==
X-Received: by 2002:a17:902:e745:b0:2a3:ccf5:6691 with SMTP id d9443c01a7336-2a71782783emr12224645ad.30.1768520725819;
        Thu, 15 Jan 2026 15:45:25 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190eee4fsm3623595ad.42.2026.01.15.15.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 15:45:24 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 814914207D2D; Fri, 16 Jan 2026 06:45:21 +0700 (WIB)
Date: Fri, 16 Jan 2026 06:45:21 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Brett A C Sheffield <bacs@librecast.net>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] docs: kselftest: remove link to obsolete wiki
Message-ID: <aWl8EXT-Fp59WDMS@archie.me>
References: <20260115172817.7120-1-bacs@librecast.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a/+0KyrOdn65OOla"
Content-Disposition: inline
In-Reply-To: <20260115172817.7120-1-bacs@librecast.net>


--a/+0KyrOdn65OOla
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 05:24:44PM +0000, Brett A C Sheffield wrote:
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-to=
ols/kselftest.rst
> index 18c2da67fae4..e13aff7a80b5 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -15,11 +15,6 @@ able to run that test on an older kernel. Hence, it is=
 important to keep
>  code that can still test an older kernel and make sure it skips the test
>  gracefully on newer releases.
> =20
> -You can find additional information on Kselftest framework, how to
> -write new tests using the framework on Kselftest wiki:
> -
> -https://kselftest.wiki.kernel.org/
> -
>  On some systems, hot-plug tests could hang forever waiting for cpu and
>  memory to be ready to be offlined. A special hot-plug target is created
>  to run the full range of hot-plug tests. In default mode, hot-plug tests=
 run

Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--a/+0KyrOdn65OOla
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaWl8DQAKCRD2uYlJVVFO
o7FCAP4u3YWvqpb7XuvP/CShB6gKhNtUSEORxT+JfChh/8g9KwD7BwQstmQJZk8i
g7dOs1hlHWOFkH38sNz4SQJkGR3F+AY=
=39Y4
-----END PGP SIGNATURE-----

--a/+0KyrOdn65OOla--

