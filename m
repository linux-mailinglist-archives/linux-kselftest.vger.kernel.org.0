Return-Path: <linux-kselftest+bounces-31621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4B4A9BBE5
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 02:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F384D1731B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 00:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC1910E9;
	Fri, 25 Apr 2025 00:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrVq7I2M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E6A50;
	Fri, 25 Apr 2025 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745541476; cv=none; b=AsLnzIF+snHHSEOQSNdFg2woY4kU3sOXg6c7BIow2kLjUbB6bcXLfb041PNxF25p2fnegZe1Y+aVj7fsjU2iycP4Npw7byAIo3XCl4Emrzk1HcMerxaupTQTooC+LzU/5h0PGewYtWRBmXlzjnbYvN3jaPXEnlGUhtVeBDEL5fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745541476; c=relaxed/simple;
	bh=mC2Lw7YlZ3qpk1ny/9fSQGYP8DUVFiVjQQ4y6NO6WOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUuq+0Uiqkv6qsGVeCdTXUF+1cqytA/Lff7gXync4dZIUnFAnN8K/elovsKWQVx5wrYsTcEWOI0xTo6PYNM/0B+vyfzDaMtNBdfB+A6uIxyVgKGyR7IUuNMmbe/Kq3kGy+y4W+BQrueBfyFCTVflFZaQb6nruj6uqDjrvLz62js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrVq7I2M; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7376dd56eccso1717303b3a.0;
        Thu, 24 Apr 2025 17:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745541474; x=1746146274; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hCpmv9EFqFhUqRp+aW6xC7QdFtPfa/NWuPhogAa6p/I=;
        b=KrVq7I2MgKjdPKYDx+VHszLrWBpXlEx3YkVi2aBN1rs68qmrTfO1odbAFRjtukic5d
         kRGTAtIqvQqhotvvIR8PNgZdktHsMNukSlA2fFcZli83ph4WPzkH0aefaWur0WxTuZgG
         INGDILNowMqJDNEs0P2Bx7sJrdf+YRNJaHwVZ/IGNkRT4Z8IM+vQhqRaeLCtI3wzFmlj
         /ShnDT4VHqnY3pws4jB4S4DPoM/jHoR/0rzf0Je46AmCmFDAqnFlMyTAtWOGwCuGLujP
         QqmspO/dlcAfq1IiAX/o7JNqyO3KbskRApLoq06xUAj5XDrXPYqGj4dWZsmN0seoZo4P
         crkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745541474; x=1746146274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCpmv9EFqFhUqRp+aW6xC7QdFtPfa/NWuPhogAa6p/I=;
        b=AGixrL+ooiJ1Bl/vuIxcuFDT1n01bEG8DWyR3QXZ5UwjGDpB0XaOlwuxT9pIoXoTMX
         kIeJtJVlhZ1Hn3ferKsRRMV3t6pqh+Jc8R0Zz0k7yrVmYS2bQM7iCHUaIacFEh/Jaoo9
         bTlQsl13H8lEGcZeSqBWcuf4Ihw5Yl2bivtAqbFqpwgTm8vwhtDjYidYRSy06lIIMA5T
         zgrLbDOtPbxSDXykRtuXpd1mCSJbS+g1YtMTHb4+MHx5IXaYau/VuoUVuD35Yvg7XD3R
         nE/MYxsQEvQ3wossEqkb6xqS3Aq22zE3CuaLDDn0a8v/k24+HzJO2ofK22odrgb4LQqC
         WkDw==
X-Forwarded-Encrypted: i=1; AJvYcCUsBbzAAK/MoaBVn3LUBYF1hrRWbL8VjcA4H+wBJ7mnlL4kVa6IKVTgqCEamiyPDujUPj75XO7MG/7n/oe61kA=@vger.kernel.org, AJvYcCXYBl2Pdat/zU/b4FuzVsa1pqzJxSnpJjK6fIsytuzGzbBOo8bpUB5qXbBU2kLXyiUzCK55yh2v@vger.kernel.org
X-Gm-Message-State: AOJu0YwIrYSVdjbO7NAc+6Q/SxNzPHVvl65qeO/ym8hlJ9ZxvLxjO4Uf
	FpwEKugWSXYpKYG8wSR1nNS1GGHm74GKkOBaj89wb+0Rc2wIZ2Y=
X-Gm-Gg: ASbGnctIINxp0p1r9+7cK0I9NItygUVf5iKramjU96O+0CvUUTRVJXjERPZ9KpziYxD
	b6iqUVSaoJrsnktMAoI111WVvvdOG+LcoIzc9RPbNmsELGabgR39XPUzCfhuNv/S32/JEHGKp/Z
	EYfTLjCbvoB+/3iR8nQaj3TLQT7Y/CUPANocX3yuVFyyZiaHaJOqbf+P6YMiv0y7Wwnn0kTo1+u
	m8SbrGrzzdqRRBE8pPFOvFB8URXRwQMzLHf5fnF9Cg8fyGs3YoIWsvLhs0/sMA+m/HkX149pJsa
	dzibohbEpGxUIlzp0gCiop6EU7VVaCEHWdcnybJ2
X-Google-Smtp-Source: AGHT+IEnUYnCMRKQP95wp7nsr8j0MwrHkurHodW9RPQX0leUgq5M79vCjzQItamC0Q0IYaKDzwEflQ==
X-Received: by 2002:a05:6a00:4fd6:b0:73e:598:b2a1 with SMTP id d2e1a72fcca58-73fd6901bb8mr347242b3a.1.1745541473991;
        Thu, 24 Apr 2025 17:37:53 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73e25912c7bsm2120311b3a.15.2025.04.24.17.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 17:37:53 -0700 (PDT)
Date: Thu, 24 Apr 2025 17:37:52 -0700
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
Message-ID: <aArZYDpFyThATgYN@mini-arch>
References: <20250423153504.1085434-1-cratiu@nvidia.com>
 <CAHS8izPxT_SB6+fc7dPcojv3mui3BjDZB5xmz3u6oYuA2805FA@mail.gmail.com>
 <aAlKaELj0xIbJ45c@mini-arch>
 <CAHS8izOm4QbHECZDB+imV2eVXs=KXRKzJsDw2gKGp_gx0ja7Ng@mail.gmail.com>
 <aAq2y_awPoGqhjdp@mini-arch>
 <CAHS8izNAtzyjY94qPq1-2sPUUDaN14SCXrgM5XkwCNDz4SgbvQ@mail.gmail.com>
 <aAq94Zw69XRs45T4@mini-arch>
 <CAHS8izPm_yWCRTD3ngUgDqapqiGmtpw5hhG1DFAwqwtXC-CHLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPm_yWCRTD3ngUgDqapqiGmtpw5hhG1DFAwqwtXC-CHLA@mail.gmail.com>

On 04/24, Mina Almasry wrote:
> On Thu, Apr 24, 2025 at 3:40 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 04/24, Mina Almasry wrote:
> > > On Thu, Apr 24, 2025 at 3:10 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > > >
> > > > On 04/24, Mina Almasry wrote:
> > > > > On Wed, Apr 23, 2025 at 1:15 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > > > > >
> > > > > > On 04/23, Mina Almasry wrote:
> > > > > > > On Wed, Apr 23, 2025 at 9:03 AM Cosmin Ratiu <cratiu@nvidia.com> wrote:
> > > > > > > >
> > > > > > > > Drivers that are told to allocate RX buffers from pools of DMA memory
> > > > > > > > should have enough memory in the pool to satisfy projected allocation
> > > > > > > > requests (a function of ring size, MTU & other parameters). If there's
> > > > > > > > not enough memory, RX ring refill might fail later at inconvenient times
> > > > > > > > (e.g. during NAPI poll).
> > > > > > > >
> > > > > > >
> > > > > > > My understanding is that if the RX ring refill fails, the driver will
> > > > > > > post the buffers it was able to allocate data for, and will not post
> > > > > > > other buffers. So it will run with a degraded performance but nothing
> > > > > > > overly bad should happen. This should be the same behavior if the
> > > > > > > machine is under memory pressure.
> > > > > > >
> > > > > > > In general I don't know about this change. If the user wants to use
> > > > > > > very small dmabufs, they should be able to, without going through
> > > > > > > hoops reducing the number of rx ring slots the driver has (if it
> > > > > > > supports configuring that).
> > > > > > >
> > > > > > > I think maybe printing an error or warning that the dmabuf is too
> > > > > > > small for the pool_size may be fine. But outright failing this
> > > > > > > configuration? I don't think so.
> > > > > > >
> > > > > > > > This commit adds a check at dmabuf pool init time that compares the
> > > > > > > > amount of memory in the underlying chunk pool (configured by the user
> > > > > > > > space application providing dmabuf memory) with the desired pool size
> > > > > > > > (previously set by the driver) and fails with an error message if chunk
> > > > > > > > memory isn't enough.
> > > > > > > >
> > > > > > > > Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider")
> > > > > > > > Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> > > > > > > > ---
> > > > > > > >  net/core/devmem.c | 11 +++++++++++
> > > > > > > >  1 file changed, 11 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > > > > > > index 6e27a47d0493..651cd55ebb28 100644
> > > > > > > > --- a/net/core/devmem.c
> > > > > > > > +++ b/net/core/devmem.c
> > > > > > > > @@ -299,6 +299,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> > > > > > > >  int mp_dmabuf_devmem_init(struct page_pool *pool)
> > > > > > > >  {
> > > > > > > >         struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
> > > > > > > > +       size_t size;
> > > > > > > >
> > > > > > > >         if (!binding)
> > > > > > > >                 return -EINVAL;
> > > > > > > > @@ -312,6 +313,16 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
> > > > > > > >         if (pool->p.order != 0)
> > > > > > > >                 return -E2BIG;
> > > > > > > >
> > > > > > > > +       /* Validate that the underlying dmabuf has enough memory to satisfy
> > > > > > > > +        * requested pool size.
> > > > > > > > +        */
> > > > > > > > +       size = gen_pool_size(binding->chunk_pool) >> PAGE_SHIFT;
> > > > > > > > +       if (size < pool->p.pool_size) {
> > > > > > >
> > > > > > > pool_size seems to be the number of ptr_ring slots in the page_pool,
> > > > > > > not some upper or lower bound on the amount of memory the page_pool
> > > > > > > can provide. So this check seems useless? The page_pool can still not
> > > > > > > provide this amount of memory with dmabuf (if the netmems aren't being
> > > > > > > recycled fast enough) or with normal memory (under memory pressure).
> > > > > >
> > > > > > I read this check more as "is there enough chunks in the binding to
> > > > > > fully fill in the page pool". User controls the size of rx ring
> > > > >
> > > > > Only on drivers that support ethtool -G, and where it will let you
> > > > > configure -G to what you want.
> > > >
> > > > gve is the minority here, any major nic (brcm/mlx/intel) supports resizing
> > > > the rings.
> > > >
> > >
> > > GVE supports resizing rings. Other drivers may not. Even on drivers
> > > that support resizing rings. Some users may have a use case for a
> > > dmabuf smaller than the minimum ring size their driver accepts.
> > >
> > > > > > which
> > > > > > controls the size of the page pool which somewhat dictates the minimal
> > > > > > size of the binding (maybe).
> > > > >
> > > > > See the test I ran in the other thread. Seems at least GVE is fine
> > > > > with dmabuf size < ring size. I don't know what other drivers do, but
> > > > > generally speaking I think specific driver limitations should not
> > > > > limit what others can do with their drivers. Sure for the GPU mem
> > > > > applications you're probably looking at the dmabufs are huge and
> > > > > supporting small dmabufs is not a concern, but someone somewhere may
> > > > > want to run with 1 MB dmabuf for some use case and if their driver is
> > > > > fine with it, core should not prevent it, I think.
> > > > >
> > > > > > So it's more of a sanity check.
> > > > > >
> > > > > > Maybe having better defaults in ncdevmem would've been a better option? It
> > > > > > allocates (16000*4096) bytes (slightly less than 64MB, why? to fit into
> > > > > > default /sys/module/udmabuf/parameters/size_limit_mb?) and on my setup
> > > > > > PP wants to get 64MB at least..
> > > > >
> > > > > Yeah, udmabuf has a limitation that it only supports 64MB max size
> > > > > last I looked.
> > > >
> > > > We can use /sys/module/udmabuf/parameters/size_limit_mb to allocate
> > > > more than 64MB, ncdevmem can change it.
> > >
> > > The udmabuf limit is hardcoded, in udmabuf.c or configured on module
> > > load, and ncdevmem doesn't load udmabuf. I guess it could be changed
> > > to that, but currently ncdevmem works with CONFIG_UDMABUF=y
> >
> > You don't need to load/reload the module to change module params:
> >
> > # id
> > uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys)
> > # cat /sys/module/udmabuf/parameters/size_limit_mb
> > 64
> > # echo 128 > /sys/module/udmabuf/parameters/size_limit_mb
> > # cat /sys/module/udmabuf/parameters/size_limit_mb
> > 128
> >
> 
> Today I learned! Thanks!
> 
> I will put it on my todo list to make ncdevmem force a larger limit to

Or we can ask Cosmin to send something out? Since he's already looking
into the buffer sizes..

