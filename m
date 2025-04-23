Return-Path: <linux-kselftest+bounces-31436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA971A996B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 19:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B051B864CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC3728A1D6;
	Wed, 23 Apr 2025 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B98DxptG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A1528BABA
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429423; cv=none; b=JdIzaO4cr7dOYw4aJqFwwcskYnc33n5UYW5TvOJJDbc1jFhAnJS7FGSFsH4/q0v7v1ZHWSsSzbK3YaqzC7JSYWyq8GkGClf2UKd4xuxiu6Wi0sqx36WV1I5E7z+hcEhHY7WHVi1NGfsXphWVChpwHKn04uJLNFeD8nCT9i5EOkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429423; c=relaxed/simple;
	bh=tw0FwtBtwDLDTLVtobFzgF1QiT11ZisnHD362VqJl58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUG8VhvaNqu4x3ZN95rHF5uO/i2OGrEcDA1eUkeAE7ZxGUK05EIRBz/suO01Wy+ThZTM2skGvC5QcGe/TmrQXu/4iTsqtxd9CSsVF9BzWNzmH9fJ4FlT/jNgrvLURNe+/MNW/F4YNP8CobRbJc2lBafIHT/im70OT3q2G2GmSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B98DxptG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2264c9d0295so20565ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745429421; x=1746034221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsUrdVLaEzlgval7+rWkZtPbYqCP3FVlYtcxMOMczKY=;
        b=B98DxptGwSExk+cKgVZ+QN4jlNtAcfFLNTu5XOBrpeRUx+66EwLhfuj3CI5X5WiaI0
         FRv2gyCLb4g32jYV1mvL9YBLrPNmhiptZyZ4dRqOPtT9xqz0x6fnIZ/l5MFFnJgTbdOD
         gld19tINlb8UnhX48KUXuQlygTi3rrpLZWLrhh4/JGyLr5NHAYqgzm6bGlniGxXurUJu
         XAG+JvAKoA+Ttmwc0+vE88aFB7JJwsTraCt9/oSnbHoWXYXSwMUV54VfjwO59R4kHa4j
         Ianuv7sQ2kxG28TzMYl2VmXE7Z0MTCE5mi/S0+oaCGMOX9NemwJ1LiGhJbxvhgrtNUZz
         Sb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429421; x=1746034221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsUrdVLaEzlgval7+rWkZtPbYqCP3FVlYtcxMOMczKY=;
        b=JhPhavvcSehtiZWNorPuR8lS/5gqxDEjJdYEbWyWxgh8f2+mcsXvssvNHzWISxcsoO
         POtmYsak2eAnKMxxqWReSPZFUHf+7SGg5v8LD+rZ9w6HBx9Wg/q7aSU1Athx2EYkMkGL
         +aqj0XFQQksC0qC1zYIQlUjds6Bp5/6KaA0CDUcHWgWUN5G6a2IE9Rs0Ufgge5x34X+5
         9FwtWQVvLjwNeETJZBJihs7EtaQrxrDsEqWctPHMlav2NKtdJviIwbAN2/4ie4jmfndy
         DGNner2jzcglBPoATRNxfw4KB+zc6I5uJBQChdY/xST3IoPng2RKKHTEFTKDw4NUJ2Si
         s9vg==
X-Forwarded-Encrypted: i=1; AJvYcCV+tGrijOo9lHde3P6Ipad3cKjaHwpvrZhDJxQ8EtS/h1ru80ljlVWrDJ1kPCoPeVWCrg9bQUaErT/SZAGQXpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQGg05GivIuGk3ak2UjxqsAAJH25VQpx30HhQ8+ALYKlPO/o86
	HxSdYk4ZS7FRiPdMfuavj1zOCxgC41yF0dwPkll4VNBk/Ds9vU19wfAiRXKjml+XL+jT0Mz5wR8
	8z6uaTQjWf0nAYDTtresAMeQQDNb8kVfcq5Bd
X-Gm-Gg: ASbGnctVBugcIZP0qHItSaueUKjldCfcl9n86Eb5YnXOPtQFCJRPZkO/1atYxduV2zT
	ralYpexIA75k0MFuIv9nSCI2jhpFREw/CGGF3tR8ZbkZBLgeLGvq7+NzlCXEJK35KgpiQ5Koo9/
	UZ24zWjemHtDgNBo0E4ZU4CKQG22ac4+NZvXggFqTABKQYvR0x7cDx
X-Google-Smtp-Source: AGHT+IHIWCKy3ltia4+nTDexTeHi1vB/Lhhg4KHYCEuJSgDxLbOKRZrSLdDGonlYcGDGV+ZmhG5w4gZg0RKo0PCRroU=
X-Received: by 2002:a17:903:1a05:b0:220:c905:689f with SMTP id
 d9443c01a7336-22da4f0c1cdmr3074675ad.25.1745429421021; Wed, 23 Apr 2025
 10:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423153504.1085434-1-cratiu@nvidia.com>
In-Reply-To: <20250423153504.1085434-1-cratiu@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 23 Apr 2025 10:30:07 -0700
X-Gm-Features: ATxdqUG4VyZdKZ70xcAHfngdsmTBCA-K_0DrPBYVneS0iCs3DoR6SyqAwKNzsCM
Message-ID: <CAHS8izPxT_SB6+fc7dPcojv3mui3BjDZB5xmz3u6oYuA2805FA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/devmem: Reject insufficiently large dmabuf pools
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 9:03=E2=80=AFAM Cosmin Ratiu <cratiu@nvidia.com> wr=
ote:
>
> Drivers that are told to allocate RX buffers from pools of DMA memory
> should have enough memory in the pool to satisfy projected allocation
> requests (a function of ring size, MTU & other parameters). If there's
> not enough memory, RX ring refill might fail later at inconvenient times
> (e.g. during NAPI poll).
>

My understanding is that if the RX ring refill fails, the driver will
post the buffers it was able to allocate data for, and will not post
other buffers. So it will run with a degraded performance but nothing
overly bad should happen. This should be the same behavior if the
machine is under memory pressure.

In general I don't know about this change. If the user wants to use
very small dmabufs, they should be able to, without going through
hoops reducing the number of rx ring slots the driver has (if it
supports configuring that).

I think maybe printing an error or warning that the dmabuf is too
small for the pool_size may be fine. But outright failing this
configuration? I don't think so.

> This commit adds a check at dmabuf pool init time that compares the
> amount of memory in the underlying chunk pool (configured by the user
> space application providing dmabuf memory) with the desired pool size
> (previously set by the driver) and fails with an error message if chunk
> memory isn't enough.
>
> Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  net/core/devmem.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 6e27a47d0493..651cd55ebb28 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -299,6 +299,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsign=
ed int dmabuf_fd,
>  int mp_dmabuf_devmem_init(struct page_pool *pool)
>  {
>         struct net_devmem_dmabuf_binding *binding =3D pool->mp_priv;
> +       size_t size;
>
>         if (!binding)
>                 return -EINVAL;
> @@ -312,6 +313,16 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
>         if (pool->p.order !=3D 0)
>                 return -E2BIG;
>
> +       /* Validate that the underlying dmabuf has enough memory to satis=
fy
> +        * requested pool size.
> +        */
> +       size =3D gen_pool_size(binding->chunk_pool) >> PAGE_SHIFT;
> +       if (size < pool->p.pool_size) {

pool_size seems to be the number of ptr_ring slots in the page_pool,
not some upper or lower bound on the amount of memory the page_pool
can provide. So this check seems useless? The page_pool can still not
provide this amount of memory with dmabuf (if the netmems aren't being
recycled fast enough) or with normal memory (under memory pressure).


> +               pr_warn("%s: Insufficient dmabuf memory (%zu pages) to sa=
tisfy pool_size (%u pages)\n",
> +                       __func__, size, pool->p.pool_size);
> +               return -ENOMEM;

In general I think maybe printing an error/warn to dmesg to warn the
user that this is a weird configuration may be fine, but return
-ENOMEM? I don't think this should be an unsupported configuration and
I don't think checking against p.pool_size guarantees anything.

> +       }
> +
>         net_devmem_dmabuf_binding_get(binding);
>         return 0;
>  }
> --
> 2.45.0
>
>


--=20
Thanks,
Mina

