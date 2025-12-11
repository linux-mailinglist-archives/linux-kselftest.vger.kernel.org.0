Return-Path: <linux-kselftest+bounces-47377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF953CB4A70
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 04:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 325383014622
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 03:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09972D94AC;
	Thu, 11 Dec 2025 03:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZJ+z8Zsn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE272C0294
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 03:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765424857; cv=none; b=XZGyvR/E+YPcLT7DSzMBkzd9FBzcgTRNKAQF2tWVmbFvb7/KzuuOY1zd9xwX8o1KFy+sWVxh2VOlm2KwZzx5KMd67oSYMH1TBuzRYH/5DF9MJDd1mn+/hyQml/4LV41qowoJpp1cWrytod5gETfmF+1M5wZm4YT8i54Ojtog6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765424857; c=relaxed/simple;
	bh=/a7+eP5QJ7LUqX+guLEai83prspNSYNSevmmGsCHHsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlh90gPaK1PWBNCmxi0b+pX5jlCF+Ke8ykmU1mr2fbEfzWeT2xFe3O1o6OiMLXzPup6cMthct66Micv9mfX8TCET/yVXUVd9wb4Hu+Irg00fJ7zHXGcGNjZVo/LFys0AUlSs74jxz4Aw9pjAQFMFERZvtYkfkt2DBXfvIG/61K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZJ+z8Zsn; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=/a7+
	eP5QJ7LUqX+guLEai83prspNSYNSevmmGsCHHsw=; b=ZJ+z8ZsnvDQ3aiFLCj+r
	hkxLAo1kTBq/jD5S0CqhU4XE5l/7uZrgCEdpHwBjmOOPnSgmvzzzkRzEyKqfiEq+
	rAJNnApDSa0MUPn6Iod4M32B7z7FQsx2BvMLvUj1fcfzDtRg/og2N/x99riH/sis
	e0J8TMpgKziYVHI7dz60I5Exqm3Jxf6Fh7hD0MDGPFL8nI5ezsRT4RdPmrvNcjGn
	Lxn+u56vTMhPZknC/HxE35Jer0Oe2qEwcNYn8qGLeHGj4IJ3U9jyFySsZ8GYQLer
	QljLgSh+K54DFZsKh/32QRWRJFCq16Uwx2TfE5115bXctS+TbqdTygxSBMN8DlzJ
	gA==
Received: (qmail 3606451 invoked from network); 11 Dec 2025 04:47:21 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Dec 2025 04:47:21 +0100
X-UD-Smtp-Session: l3s3148p1@rt5iAKVFQPOZ9ob4
Date: Thu, 11 Dec 2025 12:47:16 +0900
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
Message-ID: <aTo-xErTTiJcribR@shikoro>
References: <aPJp3hP44n96Rug9@tzungbi-laptop>
 <20251017162116.GA316284@nvidia.com>
 <aPT-7TTgW_Xop99j@tzungbi-laptop>
 <20251020115734.GH316284@nvidia.com>
 <aPcQ99MZse5zmv3o@google.com>
 <20251021121536.GG316284@nvidia.com>
 <aPo6CZyT_IGWmu-O@tzungbi-laptop>
 <20251023145131.GI262900@nvidia.com>
 <2025102321-struggle-fraying-52ff@gregkh>
 <20251211032306.GO28860@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qu/5HOC0rx38U1af"
Content-Disposition: inline
In-Reply-To: <20251211032306.GO28860@pendragon.ideasonboard.com>


--qu/5HOC0rx38U1af
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Replying late to this thread, I don't think this is right for V4L2. When
> it comes to solving the .remove() vs. userspace race, I think the right
> solution is at the cdev level.

Isn't there even prototype code from Dan Williams?

"[PATCH 1/3] cdev: Finish the cdev api with queued mode support"

https://lkml.org/lkml/2021/1/20/997


--qu/5HOC0rx38U1af
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmk6PsEACgkQFA3kzBSg
KbYRgg/+Kg4KkHrfEBuIlPY4Tmc9Wy75VBemIFjPdsEl7CVRMYqL7b4pU4bTlrin
Vip0ZRX+4/lzhCDOld2mMgSe8GjEWS1Cfqvzl+WPWgShiH8ta+ySMLmqt+il6N6x
y/vyAocRnW8z1DvxKyFiQO4gM+D+UP2EKpRTXnw63D+CyMcARZKJaX+Kw5RH8NBr
qs+H/GhcYev9uSmTRFS2ARuO7g2vNdm+eqRyTmvzVSIdNUYlHeMKmfpV3DylGecH
cZwEN+uhVQ6MEK3a7O+Rw1wx/uFFz56iZwVaNNisjrlJkfrQWZhClJVthRmRVHVx
VIgPmQ8sABpSXl7bpeGmwxzJ++Nb6jP9iZm2ISvw6EtMfo3khGaMZheEpKxmR52D
88o/1N2Ok5+e0CLo6wGCMTy1EJsJL55evezUkin+ECGBBwwdXnyUrVophjgg9Ta6
dKkdUKokkT29u8lAe+Y2is9MVDRmqEDcoDzkymDJdNtREMLj2HzPZbqeWMiivPnc
yo6ZK7QeU/YFYK4hwqnmfPx0YHWj8UqviTlc3vUFTfKjmgaeBA8Q2/eY+1TVzTrZ
lHOTUJasafEh+dcx65+CEd/s1Xrx+gQYf1EQ4VDOGu8bXfwYBzlD4roPQ3ZT6K6Y
nwG7vvT6NUABpHLRC3eL979YBwfQWK2Bcf45VNNwLZ3o1rF2NUk=
=webN
-----END PGP SIGNATURE-----

--qu/5HOC0rx38U1af--

