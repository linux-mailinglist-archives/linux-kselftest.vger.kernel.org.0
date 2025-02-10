Return-Path: <linux-kselftest+bounces-26269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08406A2FE90
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECD83A5D5B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 23:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45513260A2B;
	Mon, 10 Feb 2025 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnF5EYED"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38311DE3B8;
	Mon, 10 Feb 2025 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739230982; cv=none; b=qH7al10kpRaIzh8OUhWWhVsEBHOjn5US3jO1Z/f/UXjDbXpNRxdgdMnt/uw1HBmX0oUyyqdbLJCrtEV6OQ16OxuFXcBPYMlUnv6j2G5OEdPhQ9oq/u/uW5SsgDcsES6Z98+DYjW+dkwG7zv5+PBscVH/t6pC9KJlmIKAv5CpS5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739230982; c=relaxed/simple;
	bh=MUIDd2fI73QZi6v0y5Fvhz8OUmwuDCtfk7eH7bHgesY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5BEBNWaNMsy7hS9a4Mav/c1NyL6bOUJlCwRfbpjGhJNO2zO3Adcuysra7gry60yDD+TCXOA5h8PjRrbjb7PtnhC7UCATZYyPZ5L2PaCvAPcARknmhLMsQAP7hQ2pTu9wnfyeD7KJ4zu8ep2MjZDl1nr4TXYiHmryJ6w0v3h+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnF5EYED; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f5660c2fdso64765965ad.2;
        Mon, 10 Feb 2025 15:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739230980; x=1739835780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hvhku1/z5ISGPVdL1BlHcUNOUe+L4Ex94wS+iRNs3Co=;
        b=CnF5EYEDELE95V5U5WCgqmoBgp6Yiau9wanowXL4nAZc4pNFSNWU0fxbhXRaq1CTLk
         4vc2GR373bBHxhWW+VcKXdzghHPXG/Nj8aCc4TQQurj/iMoAg2pdCyuxSjmRzKoiMHSA
         xUuuDg1HtmPWJ+K8Cv2xNVq+rasYJAbcyEv2Cwbi6QY34d8aWNQAv5sffnLzCThikWmI
         Zy6DIQpeUSlvJyjxeWTiQ2wEJAaMMO2cMc8/nFgRZwenNZ7troINypz13Ufqyd/7Vdw0
         DM28zwzOvB+DEqMrWPIpG3kcZp1swL5bmG4A4W2zZR2rUKZ4J4rylcHLugbM3JgkctYQ
         GhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739230980; x=1739835780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hvhku1/z5ISGPVdL1BlHcUNOUe+L4Ex94wS+iRNs3Co=;
        b=fGQRC0yqz/O5pxEf28Px0OkH1/W/y/yhPOhDPoTtVNPd71kawLBWHZSMsgOkOB1GEh
         7Z9ivt0Q+nE1Wz3JEPiZ7X0dBoOxlc2nKbWvnImDtOWW5r64tsERcNHe/UByVjc46XH4
         zXVHfEwP2FAsR3yYIvVk4Xk7pueKPmcwMgV9O6adZTFpH6Jeh9Wgjk9+7PV+V4EJ6+/O
         mZBNfmS9kdrUGDOWcCqWi6niOk9M2cig/Oml+e33mfJhfVV5fHgsTCP5pKFIaN6WbUKQ
         ArLC57Po/Fg9htssy0OTBBKBmRZH2NziyjZQtBf0U9+iH587/sTsedw2t/gyX6/PH97h
         92GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWwmjpUuxPE3x1VvdQDsMYcIN++tAm5MTGLjNLVuhG827W64moJ9s6uivy4qS528q740iBTmwie1w=@vger.kernel.org, AJvYcCUrDIDALdL3KOBG/UxzJOF5IrTaC/pz7wP3UQ7Wkgm7Fgy8w1Qa78ZpKS5xeuI6xNJby3yc3KYJf4nQqOut@vger.kernel.org, AJvYcCVL+eC8LUtDfGvO5btUZK632in6zdwjg+4rYXkvQmqXkeOUtQYg/1VC57OSuofj8Ds7bYQh+B4IVMW32aJtxc2c@vger.kernel.org, AJvYcCX9rRvUw2rCaE9b7JAHunouS/SXYsmAvn4axWhSoXRrQlvQkxX2Nt71vsyUVQwHWlqXtLBqhzwd@vger.kernel.org
X-Gm-Message-State: AOJu0YyIksHFjN9unX5yAQqFkvDxbexR8ygoPkcih+ijSyb1N2sAE6+b
	YlpHr4d+NQS5o/usOg7MA4Snv56fyIvd104PZetz6ruvGE/KSA9D
X-Gm-Gg: ASbGncumo5F8DiZ2r7K3LeCSN74F3kPmigL4n6WzMjpWxBGD8MOwMHDXeCEE3tnu8P+
	PyTuO/hNCEZmM21+EikMzx/wohFW9QcJAwTtjO3rhjE9YC7vfATKSAufTQfQMvIVpfGzVQOpOsH
	8Nt/PixFx8QcTtSiAFfGbajv7dHcfcHW+PusBIUxNxABbdJ2hBghGCUCua1cScFL/uztcWxGg0y
	GFqIpBKsQ8cryzxjiA0z2XnOgxuSPHka2csqr2zK3uOdElQp3wR1fhwJl7Ldf9y2SOlO9BPut5+
	mBlAWK3Jb8bC5q4=
X-Google-Smtp-Source: AGHT+IH/fffzdjw2z+TAvMPwE3HgU+tyPfoL2nybzuCe5nAEYQkGbNqUIgJ55joJVM1uAlrE35NZOg==
X-Received: by 2002:a17:902:f790:b0:21f:614e:9e7c with SMTP id d9443c01a7336-21f614ea049mr227369245ad.25.1739230979741;
        Mon, 10 Feb 2025 15:42:59 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650e6aasm83909935ad.12.2025.02.10.15.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 15:42:57 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 98551423E4E4; Tue, 11 Feb 2025 06:42:51 +0700 (WIB)
Date: Tue, 11 Feb 2025 06:42:51 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, rdunlap@infradead.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next v5 8/8] netconsole: docs: Add documentation for
 CPU number auto-population
Message-ID: <Z6qO-_Ebnn5OTkgy@archie.me>
References: <20250206-netcon_cpu-v5-0-859b23cc3826@debian.org>
 <20250206-netcon_cpu-v5-8-859b23cc3826@debian.org>
 <Z6Vm3ny5VN6mcKJN@archie.me>
 <20250210-crafty-snobbish-pogona-83e904@leitao>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jrZ3IkBhdvf9Qfh8"
Content-Disposition: inline
In-Reply-To: <20250210-crafty-snobbish-pogona-83e904@leitao>


--jrZ3IkBhdvf9Qfh8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 03:07:24AM -0800, Breno Leitao wrote:
> Hello Bagas,
>=20
> On Fri, Feb 07, 2025 at 08:50:22AM +0700, Bagas Sanjaya wrote:
> > On Thu, Feb 06, 2025 at 03:05:59AM -0800, Breno Leitao wrote:
> > > +.. note::
> > > +
> > > +   If the user has set a conflicting `cpu` key in the userdata dicti=
onary,
> > > +   both keys will be reported, with the kernel-populated entry appea=
ring after
> > > +   the user one. For example::
> >=20
> > In that case, shouldn't the kernel autopopulates numbers of the rest of
> > CPUs?
>=20
> Do you mean listing all the CPUs that are *not* sending the current
> message?

Nope.

>=20
> Let me come up with an example to try to understand this better. Let's
> suppopse I have a machine with 64 cores, and cpu=3D42 is sending that
> current message, then I would see the following on the dictionary:
>=20
>  cpu=3D42
>=20
> You are suggesting we send all the other cpus, except 42 in a "key"?

Sort of.

I mean, on the dictionary, we would see user-defined cpu number on one cpu,
and kernel-generated numbers on the rest.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--jrZ3IkBhdvf9Qfh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ6qO9AAKCRD2uYlJVVFO
oyo6APsFj5scWxy8KkPllfChAVz5wqVh0oignotmAl3UJbIfqwD/RuuRG9shJ5JF
mRYIV7kgg8Aec4+MY+9ni4010HWTrAc=
=R/cL
-----END PGP SIGNATURE-----

--jrZ3IkBhdvf9Qfh8--

