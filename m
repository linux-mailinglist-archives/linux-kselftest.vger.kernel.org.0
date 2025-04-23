Return-Path: <linux-kselftest+bounces-31447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F26A99946
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 22:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAB307B0814
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 20:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A70F25B663;
	Wed, 23 Apr 2025 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iw4ul+Me"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6F7191F6D;
	Wed, 23 Apr 2025 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745439340; cv=none; b=IGkJ2H71ln7p6V3OaUsJgnVrgh0pCq/ms2RuAX2q7MI3tXQhalYpMdPNPoF7MFE7Dh48z/A1aDjn+arnCmjodfKPrPupZTC+KPXsBRfG66wSvcF92/9USkPnmzmzmAUPQi86puPAKpt3uwXUem/HS/kidOIU6Ef5hE4Bdj95CaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745439340; c=relaxed/simple;
	bh=O3kOtANHK+iQ+nKHvWF6BZLth8XdLSSUINgkM6b7LzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6GmyMCDytqulhExXbs/fJgiUhKRNzTFg6Bd0UPW6WpmNHd7g6QPDM8eQV8Qm+13tnzef8MNRncWYXMBanEu0y4YfZRsPeqlARZPweyDdrsFaDgLF/7/x4e1G0JBBBVgdCK9GjK+HvFGdUZcHs06HGkfHjUPexBQmiCIZrvdhtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iw4ul+Me; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c33ac23edso2600535ad.0;
        Wed, 23 Apr 2025 13:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745439338; x=1746044138; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4pTi8BCmrYIvthcU9R/d2tjeubTglUkyusFrrbw0qHU=;
        b=iw4ul+Mefzhil3ZebXWH6+W302U6lLWhNuEI1lvae8xu4zi7gfiyrf5J2pxnSztDFP
         bUjVDAvimBLecWX47nVMwxJ9NhZRVVsRuTxHLPO93g5pAegnoN6EzRjqKw2v3KEaPpl4
         SclsXib5INkiXhFa2SNhNkUGmCJWn02ye9avFgY2Uzxo1taRdFGJ3kKFwCWCBJGhV7Jr
         TV49rC1P6MtCsQYgG1PBqiKa8NlERyryRjQVi4Zg2MJi+4s9+BfBVeaPaQVbOCQN9Dww
         oTS23aY60Kq/83XgMi5Sk4iDTapbfDsJkoggGDz2PM//EP+45TAabE1dn26UvCwo70Bu
         TEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745439338; x=1746044138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4pTi8BCmrYIvthcU9R/d2tjeubTglUkyusFrrbw0qHU=;
        b=s+5RGqYDTvaRaeDq5t99nCdsaR3g0KsBvG3LxSXX4ewvySMjI6dD2yCWmxWNSdNkc+
         Uyazi9wiky3Y+SYCelhNzCUbOepBiqlug/6sU+RlYu8eqMMnqCtkLPJRlT0p77TBZW0d
         Sl10v+JIOKVmx6czflH5AZnBxwarCu3DT4H0qERu78sEnmnubUGL5vdzhEWwmYwiIcXR
         H7CzSOwXmiLhrcnHmEPQFVQLCdCw1/5AqaWdmPUxy7I2+Sw6HvQ8Q9ueTkodI9tYkCbB
         lbq9y9A/83qM1OAvgEsQXO2IHz1DRHvRnsoPAS0VGWxuNhKLyh24Txx6IXKveStznLfs
         OIUA==
X-Forwarded-Encrypted: i=1; AJvYcCXpouXO0T13B28xlb5yYaZZqtpNDXNmjhMftyepxBg0P/GQz8twfNjWQ+BcxlYKfdXvBFqSzocRmb5VOmEi1UM=@vger.kernel.org, AJvYcCXy0PhDbFXlsHQiQEmHiHVQtEYQVPY6j4UMwvEYzoHuczmvaIEhwxUrq/gA7W7MoA1rCcN7IusC@vger.kernel.org
X-Gm-Message-State: AOJu0YyMlRWjcU60yv/s8ku+mpQgGUhLSjSqqp0HnFe6JvF6JNPaseF/
	2lfAkQHwl1kzswMJHAbMBjOdsQKjnbvl9Ar0MJ+XnvKjb8upYes=
X-Gm-Gg: ASbGncvKphM244HG9wCLNGPaWR4HZlF6L1rkWthpYCNvhjYtSNeAYVnZEqJPwk/uFya
	tUmk7ltHIOi71fB01vVblIUFCZkx9YbIHk+qNamvcXNrBoARU4ATWY1eWTDR4tcShH5AezdcGv7
	2ilMWFgyBgWh3UwFpPQ/tvfHwN8fQGkYJrsep5ypZf3HP3l93vBdWqeo1N4TSthpLctlouOKjRf
	gAgI0FV/YL0DFEAr1zpx/wNBCLCZTzfQi4AsrWrhoD8FNKGsFOPB0kLSz0a6SHQct4nWsLuFACq
	GOHOzjWov4QkRjGD6XXJ+T4TlCxxjvGHx/hmPaJn
X-Google-Smtp-Source: AGHT+IH7cgGcCGTRD3dWAKtuh47uuQ3gs/slgvMSP/4ucP4YR395JjMZ2VtlG8BY/ymMwO7Ojv48ZQ==
X-Received: by 2002:a17:902:f611:b0:21f:85af:4bbf with SMTP id d9443c01a7336-22c5359e628mr244289285ad.20.1745439337773;
        Wed, 23 Apr 2025 13:15:37 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50eb4a46sm109153435ad.147.2025.04.23.13.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 13:15:37 -0700 (PDT)
Date: Wed, 23 Apr 2025 13:15:36 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 1/2] net/devmem: Reject insufficiently large dmabuf
 pools
Message-ID: <aAlKaELj0xIbJ45c@mini-arch>
References: <20250423153504.1085434-1-cratiu@nvidia.com>
 <CAHS8izPxT_SB6+fc7dPcojv3mui3BjDZB5xmz3u6oYuA2805FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPxT_SB6+fc7dPcojv3mui3BjDZB5xmz3u6oYuA2805FA@mail.gmail.com>

On 04/23, Mina Almasry wrote:
> On Wed, Apr 23, 2025 at 9:03 AM Cosmin Ratiu <cratiu@nvidia.com> wrote:
> >
> > Drivers that are told to allocate RX buffers from pools of DMA memory
> > should have enough memory in the pool to satisfy projected allocation
> > requests (a function of ring size, MTU & other parameters). If there's
> > not enough memory, RX ring refill might fail later at inconvenient times
> > (e.g. during NAPI poll).
> >
> 
> My understanding is that if the RX ring refill fails, the driver will
> post the buffers it was able to allocate data for, and will not post
> other buffers. So it will run with a degraded performance but nothing
> overly bad should happen. This should be the same behavior if the
> machine is under memory pressure.
> 
> In general I don't know about this change. If the user wants to use
> very small dmabufs, they should be able to, without going through
> hoops reducing the number of rx ring slots the driver has (if it
> supports configuring that).
> 
> I think maybe printing an error or warning that the dmabuf is too
> small for the pool_size may be fine. But outright failing this
> configuration? I don't think so.
> 
> > This commit adds a check at dmabuf pool init time that compares the
> > amount of memory in the underlying chunk pool (configured by the user
> > space application providing dmabuf memory) with the desired pool size
> > (previously set by the driver) and fails with an error message if chunk
> > memory isn't enough.
> >
> > Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider")
> > Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> > ---
> >  net/core/devmem.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 6e27a47d0493..651cd55ebb28 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -299,6 +299,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> >  int mp_dmabuf_devmem_init(struct page_pool *pool)
> >  {
> >         struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
> > +       size_t size;
> >
> >         if (!binding)
> >                 return -EINVAL;
> > @@ -312,6 +313,16 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
> >         if (pool->p.order != 0)
> >                 return -E2BIG;
> >
> > +       /* Validate that the underlying dmabuf has enough memory to satisfy
> > +        * requested pool size.
> > +        */
> > +       size = gen_pool_size(binding->chunk_pool) >> PAGE_SHIFT;
> > +       if (size < pool->p.pool_size) {
> 
> pool_size seems to be the number of ptr_ring slots in the page_pool,
> not some upper or lower bound on the amount of memory the page_pool
> can provide. So this check seems useless? The page_pool can still not
> provide this amount of memory with dmabuf (if the netmems aren't being
> recycled fast enough) or with normal memory (under memory pressure).

I read this check more as "is there enough chunks in the binding to
fully fill in the page pool". User controls the size of rx ring which
controls the size of the page pool which somewhat dictates the minimal
size of the binding (maybe). So it's more of a sanity check.

Maybe having better defaults in ncdevmem would've been a better option? It
allocates (16000*4096) bytes (slightly less than 64MB, why? to fit into
default /sys/module/udmabuf/parameters/size_limit_mb?) and on my setup
PP wants to get 64MB at least..

