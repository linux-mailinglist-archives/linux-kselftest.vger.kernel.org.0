Return-Path: <linux-kselftest+bounces-47021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB3FCA42BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 16:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C46BD315F728
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 15:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0122D0C95;
	Thu,  4 Dec 2025 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qks7DJ5n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466FE2D23B6
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860681; cv=none; b=id5jpOpTMBZMw0iVHKMYiLnxVd3CQF9mPSSkhJAMVG28pdD00ZuY10pgurTxwNczUGbuxFPd7KL9Tub51TYol2bD+qeHTZsbfHQ87xac0qFUHlYYDlgk4LDnXypjF2w9b0FBf7HOkVZELHQDRC1kcJ+fv0i4nCBgrKstYWMRc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860681; c=relaxed/simple;
	bh=xDom32upKqfl9Liuos8JFqUcWNVUk18yGRlg1WeU/6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzH0hHvZ6pyUKOiQSI8KSPkXpD9MUZFlOsehkhRJr3VijO35grHSYdfkqE/X83s/yX1ylxakrFMhKllYEEHBSZZcctWIocjUH2O8WyuDiZ0I4TBc1QiZj+9b1h5NyvESEoHgqpuQYmvJxvO+XYoL6UUuld1UExdkgtfilSjdDNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qks7DJ5n; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so12958865e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Dec 2025 07:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764860678; x=1765465478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x/oVG6yt0b9tG4brIyUSYxsLsof1IU6gNnAr1g9Uea0=;
        b=Qks7DJ5nvyoafavqsdMq6ZZf19qLmHGDOmQjK8kGtfvbEmCJmTKqoQXgxE6h27o1c6
         PLZKyBDggRn0eO6CQGlafP+PrG67cTyIGf5kaHgVKtesG+ZzksanUQ3XrCiyasjPZOUR
         CgQtVtFe/d3E+TcRNYrfyKgN54Jymx/btYq3MjCseCBN/U9x62Fcm4migZqTIyrzgE9a
         hVQ3QSI2kgFAmeRX06gTM5XFvROwIZq273h89HslFIANi5Uskarwj3X2m6EEzzBCtbOG
         2wbncEzYONK96n6uhU+V4DEde5nftTroET0S79+8Z+R+n+nciQmquVOZasssyTKDHW+/
         ftkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764860678; x=1765465478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/oVG6yt0b9tG4brIyUSYxsLsof1IU6gNnAr1g9Uea0=;
        b=fos2QL2PGtx3nDbiceEvxhlSSmJ1oswp4O8OlNtTl4IyTdTr9YnjAXoPxlxF5u0AQ8
         9UfiSmcR5h5pVtSYlH380PYf0t/E58NCIx792/YrnrQryL+rqja3fTvwmSidE43sR6Em
         v319Qx6Gs4Fx6Fu3WCmA/3/wMg0YQd07O0aSkhrR/xKhOW9CgmHfbxDkR4HL5IbAdTEW
         YCePfre/JGEDvhzKJXWCES6QXqSFmrGYrxW0UJIYdm7Rhpsd7xOS+oD85wX6xQz77kDs
         F4jT4ZDdeqgv6j6n+bl4iWYVs7jVPFae1BNPaykKOyjFIAVqisPImXgJDygvSzeH+jUm
         fd7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkzEtlxE66vGvO06wwxRxCRqkcdqcB6o6AIl7/nW6QQUxZp0afmUkwUFWYQJQO4th4xKL1qmX6DkidTG8v5O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ4a5JRw/i6Go9HKTOotO7NxVGbvkKD0FwroLTFxmo9P6jNSB2
	/oPhfR/sudtC8Q6Z+4Jp+vZqPSYDDa/2qxGZBFOZJiBp+1igm4z/74EY4e9j3GeEpSM=
X-Gm-Gg: ASbGncuxMwxgEmRNsPdnIuDEpLyGewjBeSI76n+iRM3sZrnpLwkU4iFmwczpCkeXgcH
	qysq7q11vUoYEFplCEs6olSOZk+Udn7NRJ7zSiKbqRzkNnBFm5xpIyvm6T2kT+5N2ld45GGnzc9
	vl3lqWNPEFi7iCueffOfBYQcuQH5xbVmoRlIBM7UzAyot4FrXtD+8OdViWIiGN6zMaQSf8J0Xq8
	gxxZdT9XgPZaqhmd7h0f0QwD+NMRyhtjfYo2JWvWowq0wMSuOyTobJmCVBQvwZqfXP9mga/2zDD
	EMi92tu9LVgKc7jWmua9QyDuKGeO0EQdmuhz3/A1bbfni/wOq2RhuPtkATb3UnW7iacG34OP2bZ
	sFA7JxMaB1rH5W063jFODRwJXG10zSlpcBrLDfJ5xpl7inpxqf+Y/HDFEnDI9cBcp0K5dCwymdf
	OQjAxK2zwkditykDXJ99N8Ze0rkGipPMI=
X-Google-Smtp-Source: AGHT+IHE5sb784sH97jiBE9GQFt2QDlFdyIO48ifG+5s0esu24gZG4M3Ltveqfpo7zH5EorQZDV74Q==
X-Received: by 2002:a5d:5f84:0:b0:3e7:45c7:828e with SMTP id ffacd0b85a97d-42f798482c0mr3517344f8f.33.1764860677527;
        Thu, 04 Dec 2025 07:04:37 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222478sm3638410f8f.20.2025.12.04.07.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 07:04:37 -0800 (PST)
Date: Thu, 4 Dec 2025 16:04:35 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, shuah@kernel.org, 
	roman.gushchin@linux.dev, lance.yang@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] selftests: cgroup: make test_memcg_sock robust
 against delayed sock stats
Message-ID: <dyie6co47aemejhok5xjjmsvfjpsg2djmkbucnonent3afqylm@ojui2r4gb3ro>
References: <20251203115631.947908-1-zhangguopeng@kylinos.cn>
 <20251203115631.947908-3-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yv3jk2strjnvzxuo"
Content-Disposition: inline
In-Reply-To: <20251203115631.947908-3-zhangguopeng@kylinos.cn>


--yv3jk2strjnvzxuo
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/3] selftests: cgroup: make test_memcg_sock robust
 against delayed sock stats
MIME-Version: 1.0

On Wed, Dec 03, 2025 at 07:56:30PM +0800, Guopeng Zhang <zhangguopeng@kylin=
os.cn> wrote:
> test_memcg_sock() currently requires that memory.stat's "sock " counter
> is exactly zero immediately after the TCP server exits. On a busy system
> this assumption is too strict:
>=20
>   - Socket memory may be freed with a small delay (e.g. RCU callbacks).
>   - memcg statistics are updated asynchronously via the rstat flushing
>     worker, so the "sock " value in memory.stat can stay non-zero for a
>     short period of time even after all socket memory has been uncharged.
>=20
> As a result, test_memcg_sock() can intermittently fail even though socket
> memory accounting is working correctly.
>=20
> Make the test more robust by polling memory.stat for the "sock "
> counter and allowing it some time to drop to zero instead of checking
> it only once. The timeout is set to 3 seconds to cover the periodic
> rstat flush interval (FLUSH_TIME =3D 2*HZ by default) plus some
> scheduling slack. If the counter does not become zero within the
> timeout, the test still fails as before.
>=20
> On my test system, running test_memcontrol 50 times produced:
>=20
>   - Before this patch:  6/50 runs passed.
>   - After this patch:  50/50 runs passed.
>=20
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> Suggested-by: Lance Yang <lance.yang@linux.dev>
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  .../selftests/cgroup/test_memcontrol.c        | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--yv3jk2strjnvzxuo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaTGjABsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiVEwD7BJrfWOByVOptuK3iVMCh
fif6gFVXfUY7OTYHzXj5Z7AA/0EyqsqZ6vK/4ej9qB2PndhgnCbsP9ZadktOrMdz
BbkA
=wjUR
-----END PGP SIGNATURE-----

--yv3jk2strjnvzxuo--

