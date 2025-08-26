Return-Path: <linux-kselftest+bounces-40018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E63B375B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 01:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF90E1B66A09
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 23:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB283054E8;
	Tue, 26 Aug 2025 23:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG4+dyz8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3F928FD;
	Tue, 26 Aug 2025 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756252306; cv=none; b=sTEXGxbWE1YhbQi5EdYRMNZCbWL84TzkRGD2KIsVrBrK5eRNwhRac2f4FUbn+61pIyLjgMAJRvFsbSHnUH/yKkM+YKyF3Gify4Rbvui32dsLdmQNy74St6osmyle7JGZerliE2sHrHoz9k8UlveXO8YOBLexvc24juZYZ4cw1O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756252306; c=relaxed/simple;
	bh=SpXyvaX1NMJmqbPDl1jzs13gIOFuk+UAO1oy0+GjGMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nh8++1KLmiO7CY84wPH0f5t3xvJu2c1vJzX390N1U/rx1mk/k0J/CqEQcRgofUpkhtR13xVXSJTG90YlNxB3ZUOdBBGb0MkHMMldL8gENDB9SzY+1O6FoHNIE/cwhPPItDhhvPf1ICW94VX29hIv9k/UjQogMzScn9f1XJr0pLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG4+dyz8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2445806df50so48750635ad.1;
        Tue, 26 Aug 2025 16:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756252304; x=1756857104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePblVNg9HZRAOQWqKcYLTh/hWYQSO5Q87vhxYG33kNc=;
        b=bG4+dyz8SHUuPLRofdqK9PCVW+LoX2z7lPp7S5vJV/yVunhxfDThASkAcAoAuN4wZ+
         vysthJfSr592EtVsFkFMuXVUhPZ1copVPqXJ7mr96BZLyddv+siXDfxhBxzQept5asof
         w2BVup91xdQL86R5hGADDp5BnMHQk58V41LsTXHBQ1WW0xcd6UAg348zC4gJSaSLz9qs
         o+M1Iy1l7uYPAAbveT/a8yjJMfoo5i9WLrdN8gBFcxCpW7mARMjJnM+iT1sda/wPBL0V
         13iAkYqzIoOQRPBq3Y50xKbNsYNGHm9i7uLX8VZC4U+UZjgiSEW+c1jnkXvbcsqpCrMN
         l9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756252304; x=1756857104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePblVNg9HZRAOQWqKcYLTh/hWYQSO5Q87vhxYG33kNc=;
        b=EQWDFwZNxZ4+HdLoIOu9ateNNSps8q8BkDP0cSPqwuQMjhykmDTdyP1pHTL4tiANMo
         qcfvD/lun6XforirrtZds/y17P5/AHYXfB2nLJwrJUtrqyhpX3cWYroCqieviEF8SYGh
         ifO7oNNQ6kA4HEgeuy4/YfamTvrdCPQULUE6oRniiFLgdw/pTJrc107v+TKa625F93Tv
         2I4OwuYNe5Hj6JJ7s8rWrMMESMmEIvvOCGZA383XUmE6q59Y1hwQ02ZM+T2oMHpbpjQC
         C9iUWt2GwobbTVfe4qDKkxrftiLhEDJd7k6eyS63UixqZn8Pgg73K22erCYF3VXZAsP6
         STHg==
X-Forwarded-Encrypted: i=1; AJvYcCUctoRaCnr0QOukEPzxhx94Xf8cTpU1/1paljQGplL0+4C9r183uBfMOZPcXrkC9JVBX8/B7AhxQM0+hxA=@vger.kernel.org, AJvYcCUpEY/QwziEWf6Rr5i1OGO/pkKS7SdpefjIugvqzDc5g0qN2fLi0ZOuxjyMpe+RsaCy/WeqPV4m6ZVn4T65VxEi@vger.kernel.org
X-Gm-Message-State: AOJu0YzMjD4K3DAa5Mrp9DOkxPU4vVVGvKeakhs5keX4rV8s+4LtWB1o
	U9H14uJa/jVGEsITlPf70O/W1h5Kg7f9Br0J8e5Nl38RCJm4gjcYEKnN
X-Gm-Gg: ASbGncvn7zhsnp09IIJVRd2A4eaRW2Imdpu1P3akqAv7umAatHM45NqYbY1SOixfOvX
	uRzrUOrugrg+HPRJ0xKfOtwGXCYdBJ5EbEdXMb/3HWNaXilxtr5xZP6Irp6Nf34ECC+NJ+ZrqXX
	uB+gLvTsKc2n9SUt8LHkpWlWR9DG5fv1iSAc6dh5EDRaL4t+Jgp+WVh5m4rfZxqfbDPgDn4womr
	1oTlwp9jIcBStLAMtoRzecj4eLHNyToTT3iiMQAl1sx+5AQj9+ujKhHnP8ULRXxatc35+/YP1dW
	mWOvBUGnt0NFkh9F9afdjAyXngm2IZBhLQqrMlWa+JqaeQVrePf24MgbHYmInEUqyge6MW4Bxtb
	GET7VqchvEj8W9qvl/EMigg==
X-Google-Smtp-Source: AGHT+IFb8KVQRSdRU+uLjRMz6f0hTjcJUJXW9JG6G/8TmE/+OZYW9hjVMMGvhDWh2D9wG3itreKMjw==
X-Received: by 2002:a17:903:11c5:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-2462ef44573mr206281725ad.38.1756252304007;
        Tue, 26 Aug 2025 16:51:44 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687a5fc5sm106139645ad.52.2025.08.26.16.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 16:51:43 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1228941E4F06; Wed, 27 Aug 2025 06:51:40 +0700 (WIB)
Date: Wed, 27 Aug 2025 06:51:40 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: bhanuseshukumar <bhanuseshukumar@gmail.com>, tglx@linutronix.de,
	mingo@redhat.com, shuah@kernel.org
Cc: peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
	andrealmeid@igalia.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	bigeasy@linutronix.de, colin.i.king@gmail.com
Subject: Re: [PATCH] selftests: futex; Fix spelling in test messages
Message-ID: <aK5IjAkVEyDdGpPu@archie.me>
References: <20250821154103.115110-1-bhanuseshukumar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KcJKMH3iRoHD8Lg5"
Content-Disposition: inline
In-Reply-To: <20250821154103.115110-1-bhanuseshukumar@gmail.com>


--KcJKMH3iRoHD8Lg5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 09:11:03PM +0530, bhanuseshukumar wrote:
> -	printf("  -g    Test global hash instead intead local immutable \n");
> +	printf("  -g    Test global hash instead local immutable\n");
                                         instead of local immutable
> -	ksft_test_result(ret =3D=3D 2, "No more auto-resize after manaul settin=
g, got %d\n",
> +	ksft_test_result(ret =3D=3D 2, "No more auto-resize after manual settin=
g, got %d\n",

This one looks OK.

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--KcJKMH3iRoHD8Lg5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaK5IhwAKCRD2uYlJVVFO
o2/dAP9CPlLCjbClhfPsWjJPq0xEgCHDChtGzkwpBrIRrCf79AEAuCCLeTfsIRN8
m6FPTCQPwmt2ChZvakiMMycRqp6Mtwg=
=KwY0
-----END PGP SIGNATURE-----

--KcJKMH3iRoHD8Lg5--

