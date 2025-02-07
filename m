Return-Path: <linux-kselftest+bounces-25949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6C4A2B86B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 02:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCE93A0863
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 01:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C274313D8A0;
	Fri,  7 Feb 2025 01:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0TU8Mjn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486744C6E;
	Fri,  7 Feb 2025 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738893028; cv=none; b=iynh2TPpUM0M12mrPYAK8oNVcUZpMFwZUSHeJvUaXL66N4KoUaMUR7oc7cVLe6/3iIVEfyKFsNhRHskGH3891Wss7MIhUJBIQJ3evwE4XGJ9mOfgjSqq51zFpFi+9AhG44nM8WOxM9OQFSNzB0m+46Gl4EYovVtiX3PxSVhU024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738893028; c=relaxed/simple;
	bh=Rud4kJG4jLV8/BLphCONNw9DdTI3UIf93xW0ZFGDjNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fy2f979qjGxatLGf7JIaMg2IVj7Ln0v5J4pys7h60tF5VhEl6/WszGaCa0uEyU63DLaVzqgfmZnFELWIXKpD375o8txjLChV2XGJ4GMXjv1X4MOmJyoxW9Co2uJ4oT0NTXis/2d7z8ih3uhD89OcZmWbFSJ8iOO/7ICWEzynKBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0TU8Mjn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2163dc5155fso31770335ad.0;
        Thu, 06 Feb 2025 17:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738893026; x=1739497826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4YfON87g7ZENJvxYhKgpcX2R2CBtwnkVHbGO7qiUEc8=;
        b=k0TU8MjnF8D9VYorzYWyLsnJBqVVg8yhx+wi8R/GYqfxE0eW60wTV24swJFHqjVrq+
         ZNsze6HuVWD3ASV9g8F7p4rt7i2Bjwhcw1Zr1CAQ+YIVd/MvLKGEf0D07WvNfrZRhq8s
         8oPxWAPBMwIKfujRAwjENcth273irlndHbWXvfLWrAKSY+k9vNoC8ABEMN/zjpoifpL4
         rv41D6S3WdTSerPQCqwOtFzmFa3gLT+JwC+/A5AgTKijzAMTjFq81yqSPFwYlcIZ7x0I
         LpOeNUBWAKZdTPTt+r2c8kXfdh7ROH49a+mpmsFpdZtdEx63rcKBiq8yBJsEjELko4OZ
         bH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738893026; x=1739497826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YfON87g7ZENJvxYhKgpcX2R2CBtwnkVHbGO7qiUEc8=;
        b=oxjF3nNIRVNoE28mFe39is+vGVNnEexN3CZg/cRFAGDK9DPKkafTpDwYvojI/aj2dF
         qaacEJLizmvwXf7rEAM71QdFKFmAh76e78+zrOnQiP3eFRNMVFSbRhAZx/5/deWU3m75
         rOye0R+76ONOlY+ELJO2OXkMAMj8ookklJcFJwOflWbs2AsY0B4vzPgKcN+OND2q0gTY
         XeAPi7/RbuzSj7kXrczldHkrxFU9xX/aM3OKdmTuD5oKcyN/DtlAEVjKRBOiWFo/Q6wV
         83S1Rk1G66wu7x4fNPRSZwVW5U6C2PvAjwW5elPG9xvozWTZ3JrW6DvSwCRIxZokC65l
         FdJw==
X-Forwarded-Encrypted: i=1; AJvYcCUqHcmxiRjNevBGYtPZDJJeTA/3/Oi32yo9ym+0CdBKYbZJvbU2Q84TOu911/fh1a+59vGpNrblAmycndevUQvG@vger.kernel.org, AJvYcCXgMRWn7zP02AG5L+FS1TZb6bhdRAk3VPAI+00tnmNwmLw255B0yrWCm5vDA3okiUexypnjhAldEvI=@vger.kernel.org, AJvYcCXnUrOE4b6B0f6X6jaLbmlVAj+Hb14IVOIQ9n3t9gG3cFH3q7AtvPkcWWsxP4HPSPPPf391DzI2+B0NJPRU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/x7QCkKVMMgbPnQKqKuE6Zn7jHKYF+giWNBiurs2GGMGYlzpL
	yUyPY3skZWXyQ6Z9JcLFw+7VNTYUguctw6EeIbjODuHZaboGlp5y
X-Gm-Gg: ASbGncu8A1jf2k1R5OGk4ByiQH+9iyJdOLFo/Q1+lBQZkrX8w5jx7BzSZ7DJIzbO7L2
	5fkfcCROhy/8yZCLujhdpByKR75pFoN9NsNbXrkVVCwjvYp+iXXTJQ6f3k9CTvvQp9TKa+UL8He
	mqPpaOUmDKIgMblnCbDB43yPqez5H9DeXQ2AAg1YzX2LeIlMiXZUrXYdkdIS/Qh4QPGv4n2026w
	aH078ipcrLBO4Cw2Ks9omhpKHkOYgbbq3Z69Zbe6Pjj6bRgdWfD66pB+3OGH0mRIFRwjtxY2AFd
	l8k7SUdkTQg+k8s=
X-Google-Smtp-Source: AGHT+IEKPltVte/Yg9TtzUIHo+iiX2qVLRUgE9ZWa/b3KIV9wnOfO9sorF4AZAlMYmQdYvEQfurITQ==
X-Received: by 2002:a05:6a21:9982:b0:1e1:b12e:edb8 with SMTP id adf61e73a8af0-1ee03b0c1a3mr3117686637.30.1738893026363;
        Thu, 06 Feb 2025 17:50:26 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ad2809sm1939143b3a.58.2025.02.06.17.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 17:50:25 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 469244208FB2; Fri, 07 Feb 2025 08:50:22 +0700 (WIB)
Date: Fri, 7 Feb 2025 08:50:22 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	rdunlap@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v5 8/8] netconsole: docs: Add documentation for
 CPU number auto-population
Message-ID: <Z6Vm3ny5VN6mcKJN@archie.me>
References: <20250206-netcon_cpu-v5-0-859b23cc3826@debian.org>
 <20250206-netcon_cpu-v5-8-859b23cc3826@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lodIkLAKjr6DSprG"
Content-Disposition: inline
In-Reply-To: <20250206-netcon_cpu-v5-8-859b23cc3826@debian.org>


--lodIkLAKjr6DSprG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 03:05:59AM -0800, Breno Leitao wrote:
> +.. note::
> +
> +   If the user has set a conflicting `cpu` key in the userdata dictionar=
y,
> +   both keys will be reported, with the kernel-populated entry appearing=
 after
> +   the user one. For example::

In that case, shouldn't the kernel autopopulates numbers of the rest of
CPUs?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--lodIkLAKjr6DSprG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ6Vm3gAKCRD2uYlJVVFO
o2bTAP4uJmPtE0EY4degcM3pfk3wqYf0sMZJz2mr4YVi/uHxmgD8Cbi3tjnZVF5s
ZA5M+4zojHr6lDlCXHmZ0SJWVwLyBAQ=
=bMtW
-----END PGP SIGNATURE-----

--lodIkLAKjr6DSprG--

