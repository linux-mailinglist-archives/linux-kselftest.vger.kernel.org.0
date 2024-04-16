Return-Path: <linux-kselftest+bounces-8091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DE08A6294
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 06:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911A1285108
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 04:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32294374F5;
	Tue, 16 Apr 2024 04:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGsBsyY/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AB339FD0;
	Tue, 16 Apr 2024 04:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713242954; cv=none; b=HO18yl/qZKcDaTf4lXerc7gcuqFtRcnKVfekkWy0UuF3X6i4BLaGO5iDtOAm/JVR3/6MXSoKyZ7pjqMuQkFLTC8Mwf130dHnVXIwLw+htUja2kFW1XhnyjjYnqVr7oJZ+k92ytbqUBYlX0m9dVrorXlNmFsGcf7HoG8eIJVDU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713242954; c=relaxed/simple;
	bh=X0e/b4815dUU3yNfWs7rK8Qfqjm9Hb0r1rcD66zpWFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PED2eJ2i5X5B2mDhjhs285LAi9+DOiSFsEg+uCxPIeEdFbyRO5CaQX2ZPD45MkHSUNY+uGgY6ROGJWew609rcpmgyzExRtss246hafk1vCmNC81nKbEa3ynP9Cv0Tz50cf5eIrX9TCxpfFqnpquKt0UQe6xStt4BVz6ViAZlsXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGsBsyY/; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so2424288b6e.2;
        Mon, 15 Apr 2024 21:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713242952; x=1713847752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X0e/b4815dUU3yNfWs7rK8Qfqjm9Hb0r1rcD66zpWFc=;
        b=kGsBsyY/eG0fcYO2vm6JuStXj8mDolBmFcWNI+KC8PbHw4hn32dtUIAndWNHGpH4b6
         eiszdp68Ca84nnCykEDe0kesDR0J94deRb5XuTDyNoiCK+7oLf3IRGJ1MngdBYyu+3Pe
         bL1U3lEw0cZzfZ7AzLOY7DdXdgvvoQQWVGdVjrQqZB0Blb3q6NvG0NRwYZAWpnLL0kcu
         2OT4gR7OjDxRRHUyJc5mYoe8C6aUVZ7u3aBtiOgT4ajmEHrWg1dZ2iicwGlQi3INTRgv
         lpbjcZCLBxbSYdkJDHENqFIrTWoeBIKymxxcw9SCXU1qaCR8+oqYowLoRQg3Z2KMnwti
         LkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713242952; x=1713847752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0e/b4815dUU3yNfWs7rK8Qfqjm9Hb0r1rcD66zpWFc=;
        b=duGh2vWX9dR+wCbavV3t1oZbCjlcqPxO0fFCLrfUKHnwLBvcb32rW3A553uIZy/H2e
         WpLBdEgV7XYnXP8P4Z82k6IBafF1ACiWu97b+rRdYYu7bxEAUOBH3vM28Ko78z/gdfb+
         NFw7O0A7NPpnp1DaU6eXgAoW6W/oZt+OjwiEiqPR4B19nUSWun3UUu1T2TTPhd15uVco
         HyrDyOcwv102F7/RDhYgETn1PfpxQtvunMGfhDPwxznyf4Eg8RfBKQOVFvDeZUf0ztp2
         dq3DRPzW4zCMh5eXWv2h+j0hBJVOMdxZ379OUvugl0JwQ1j+4iQLSnm+2NqA7z2wF9jb
         N1vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbH5ABX1QI2kXX+QNlsI6pIiF7A8KOZvAyYu0O5ML3d3ROSTggc3lXXXiG6o+ZWBFkeq6r7bTwKrSG72TotxdO4BjgMRVgYrTAIUiB5O12LCnjbWgmbv3PLPotGc7GRfhu7Gnprc1aZuD6OqD0hdjcpNOhqbHUWmT168uvWZC/CyXkHcy90CF1YM/s4ramT3heqNoFLvmKxs1HaFhTHjD4AtgvocDwfg+I4EmkXcRXLrsoI+K99NuizwgIR3s4
X-Gm-Message-State: AOJu0Ywe6n1JSue5DES8FTpQQn5Ffyn0pftSc347kk+jb/RGJEc4fIyV
	CrfnLmEmcB6NrzqomAaDSI0K6KBn+YNg8ph9Y0OIyrtFSi7qK0Tj
X-Google-Smtp-Source: AGHT+IGoloH1Cz2CDfxkFKegELxS+FD2Cf5LJ6XwCl9i4FMzbWDZYaoJWDAQEPh28jpTvMESJD+fqQ==
X-Received: by 2002:a05:6808:3c6:b0:3c5:fd59:cfd2 with SMTP id o6-20020a05680803c600b003c5fd59cfd2mr13127438oie.37.1713242951652;
        Mon, 15 Apr 2024 21:49:11 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id gh12-20020a056a00638c00b006ecc858b67fsm8312130pfb.175.2024.04.15.21.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 21:49:11 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id BA5A818462BA0; Tue, 16 Apr 2024 11:49:07 +0700 (WIB)
Date: Tue, 16 Apr 2024 11:49:07 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	akpm@linux-foundation.org, shuah@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	mic@digikod.net
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
	linux-integrity@vger.kernel.org, wufan@linux.microsoft.com,
	pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de,
	mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
	dhowells@redhat.com, jikos@kernel.org, mkoutny@suse.com,
	ppavlu@suse.com, petr.vorel@gmail.com, mzerqung@0pointer.de,
	kgold@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
Message-ID: <Zh4DQ7RGxtWCam8K@archie.me>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BkMvQL07QYXGkkI3"
Content-Disposition: inline
In-Reply-To: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>


--BkMvQL07QYXGkkI3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 04:24:22PM +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Integrity detection and protection has long been a desirable feature, to
> reach a large user base and mitigate the risk of flaws in the software
> and attacks.
>=20
> However, while solutions exist, they struggle to reach the large user
> base, due to requiring higher than desired constraints on performance,
> flexibility and configurability, that only security conscious people are
> willing to accept.
>=20
> This is where the new digest_cache LSM comes into play, it offers
> additional support for new and existing integrity solutions, to make
> them faster and easier to deploy.
>=20
> The full documentation with the motivation and the solution details can be
> found in patch 14.
>=20
> The IMA integration patch set will be introduced separately. Also a PoC
> based on the current version of IPE can be provided.
>=20

I can't cleanly apply this series (conflict on patch [13/14]). Can you
point out the base commit of this series?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--BkMvQL07QYXGkkI3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZh4DPQAKCRD2uYlJVVFO
oxOIAP4gVyV6DAnmVLqQb6OkqAAY7l0rywBHayaYMF+T7O8BUwD9EU018eGv0r1C
TUjWVbhQh6gRlmM3rI+Alg84QyqPvwg=
=IWc9
-----END PGP SIGNATURE-----

--BkMvQL07QYXGkkI3--

