Return-Path: <linux-kselftest+bounces-31606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D79A9BA71
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 00:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45F91B830DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 22:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36A52820D3;
	Thu, 24 Apr 2025 22:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToRDBRxw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FA81FDD;
	Thu, 24 Apr 2025 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745532623; cv=none; b=fe+dEnBeXjd9BG3Tzpaj2bvo9qRDjbEoOTQrUqUQY+88NDh6bVhYxZYIRvfqV5Dcekk8L1+OvaWyKPeXgpklHjcFuoKFtNRJfs9dLD9ePKwCLrs6GoQgARi50DHYQX0Fvrpb9liwF2yISpYS18ULBd+QFU3M549EF2clh2I4sK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745532623; c=relaxed/simple;
	bh=GU35jMbe3Q0PGnlh5nME4WsSYB6AlM40N3mZKqoAujM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRJPPbrgQKqXxARb4ahJEodEwVjS7tW9cKEYVLGtJa+3IFFsZlPj99wgNOnNpbw4OBn7Xc46uCKi7mshOzMO+yeMQbI/Bxe0Hdu2W/jAKu9psIRJJyMlRbgKu3BCeRqTvU8tWKBhno3TvfnLCBmX/vtI4KXYiEFlfInDRCp5t+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToRDBRxw; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736aaeed234so1424345b3a.0;
        Thu, 24 Apr 2025 15:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745532621; x=1746137421; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bcW0CFKowaKKiu9VZdlc/toRBZBFi5QtfelaWprAF2M=;
        b=ToRDBRxwRA+tIYvgfLvr76+9mMNAoq+qMccK0cMcdrw1+dMeNZMpF51mzD6F4/o2Qa
         2crM66pJwtWiVNwveTyAM0ZZY2gM2eoGIhM3tt2StSwsR7vKzBDFAX48CPpnb8IfZzZ2
         P8xpmzu5fe8Gx1gSkghiu9VB9SDaieArOQaERgEqEULGyxKry2XjGUEaWhDpzCV/8o2I
         cYSD9kfYae20olFxkyNo0ENUBLsgaj2jb09oLSWF8QjNuT2E+AWPOwf3jfOUh0nA4KSb
         Q5VVL9Z781FMdxz9quSMcHkQsJZgVBIHZrv5d0BzyHHNC5TxZzOEoxyhx75lX1/eptX6
         r7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745532621; x=1746137421;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bcW0CFKowaKKiu9VZdlc/toRBZBFi5QtfelaWprAF2M=;
        b=UHA0Rc/GHxDOiSDxObwjSsreKx/aDbq9kvWZ7uzTjTrR1Z2qOCqcOkFu/NAxYr9Cx/
         szgTj/OTXkW0uxRRbyXHobk6D3ZEuuuXbFgstkcCfJ14SOmI1OLhTueA2NKtunmdrvOt
         tp8Pke9YnPUYdKkvCLCQudscwCxReg5OuEFMJvl50gfdyy/4tcrJlj5ion137Ii7EVrz
         lkbaYNdkix6rA16Ay8bOe388QKOdhKS/+doljQvsMzxi70bVq2F/jd4Wun0OGozwWvZS
         ska6isnAA3t5GV9Ej0GWv0PB6/0MBA/HDcZjXeWZCcmFe+52zLcZqPepdhdnEwTkoFNd
         2xFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdtmGOwzK0TVNiXFltJqFKvle1oGT3pXckFLkmcfE1ERXniL3vuktmscszJnn1doVRlkYNUSl+@vger.kernel.org, AJvYcCUir8P/IQIjrob2KEZk/MbNti1G3IKOruAjH09vWfZycKIEeBeBd2JKD1P17aSDcubcNgSD2iTm6PV727PMaRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4aqWH6xwva9hP33jK3X5UHaJJZh+lglqbbNMQWzrfT2t7ozs
	GpjqpAc8kqMt72gO9ZQUEUOS0pTQbpl4VJ+GJdhJc8VRjv8LzWM=
X-Gm-Gg: ASbGncuYnzsySQ1N/V5Hgc2Cu4Zc4reKVE4mSaOL2o/60iT3fenDDEf3LpZLzrcS6Tp
	njjOr2awfeoFyFFDW5NPsZ5nDlbiv6hcUyVQPYu8FsaPdc8fW886irnzQU1hyp53sEyP6uahTYl
	lMwZiXZEF1C7g2GejoGFi1B0DQNhAkeArFy11CPkx5A1IkrhZkKdrSeO0TwAAyC7nNiBbTWB5bc
	+IX+lyCbKfT17EzSWjAHPVPwBkPiA6kbDcC69rO/ZarHnXNMkZoIfjK5dWUAvZEc9V47Y83Nrjw
	7brB4Q1uM1NsiEvWxv5ZfLVRn4mwAOeJ9gGVRVED
X-Google-Smtp-Source: AGHT+IFe7d7IzLdLzIAAS2A8/HSIvSvbrOySdhqheyqascya7dy/hFgdfHLkY6I1QZouxpk2Ow5cBg==
X-Received: by 2002:a05:6a21:4006:b0:1f5:8e04:f186 with SMTP id adf61e73a8af0-204567bf81cmr1398525637.35.1745532621040;
        Thu, 24 Apr 2025 15:10:21 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b15f7ec22cfsm1737967a12.23.2025.04.24.15.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:10:20 -0700 (PDT)
Date: Thu, 24 Apr 2025 15:10:19 -0700
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
Message-ID: <aAq2y_awPoGqhjdp@mini-arch>
References: <20250423153504.1085434-1-cratiu@nvidia.com>
 <CAHS8izPxT_SB6+fc7dPcojv3mui3BjDZB5xmz3u6oYuA2805FA@mail.gmail.com>
 <aAlKaELj0xIbJ45c@mini-arch>
 <CAHS8izOm4QbHECZDB+imV2eVXs=KXRKzJsDw2gKGp_gx0ja7Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOm4QbHECZDB+imV2eVXs=KXRKzJsDw2gKGp_gx0ja7Ng@mail.gmail.com>

On 04/24, Mina Almasry wrote:
> On Wed, Apr 23, 2025 at 1:15 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 04/23, Mina Almasry wrote:
> > > On Wed, Apr 23, 2025 at 9:03 AM Cosmin Ratiu <cratiu@nvidia.com> wrote:
> > > >
> > > > Drivers that are told to allocate RX buffers from pools of DMA memory
> > > > should have enough memory in the pool to satisfy projected allocation
> > > > requests (a function of ring size, MTU & other parameters). If there's
> > > > not enough memory, RX ring refill might fail later at inconvenient times
> > > > (e.g. during NAPI poll).
> > > >
> > >
> > > My understanding is that if the RX ring refill fails, the driver will
> > > post the buffers it was able to allocate data for, and will not post
> > > other buffers. So it will run with a degraded performance but nothing
> > > overly bad should happen. This should be the same behavior if the
> > > machine is under memory pressure.
> > >
> > > In general I don't know about this change. If the user wants to use
> > > very small dmabufs, they should be able to, without going through
> > > hoops reducing the number of rx ring slots the driver has (if it
> > > supports configuring that).
> > >
> > > I think maybe printing an error or warning that the dmabuf is too
> > > small for the pool_size may be fine. But outright failing this
> > > configuration? I don't think so.
> > >
> > > > This commit adds a check at dmabuf pool init time that compares the
> > > > amount of memory in the underlying chunk pool (configured by the user
> > > > space application providing dmabuf memory) with the desired pool size
> > > > (previously set by the driver) and fails with an error message if chunk
> > > > memory isn't enough.
> > > >
> > > > Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider")
> > > > Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> > > > ---
> > > >  net/core/devmem.c | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > > index 6e27a47d0493..651cd55ebb28 100644
> > > > --- a/net/core/devmem.c
> > > > +++ b/net/core/devmem.c
> > > > @@ -299,6 +299,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> > > >  int mp_dmabuf_devmem_init(struct page_pool *pool)
> > > >  {
> > > >         struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
> > > > +       size_t size;
> > > >
> > > >         if (!binding)
> > > >                 return -EINVAL;
> > > > @@ -312,6 +313,16 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
> > > >         if (pool->p.order != 0)
> > > >                 return -E2BIG;
> > > >
> > > > +       /* Validate that the underlying dmabuf has enough memory to satisfy
> > > > +        * requested pool size.
> > > > +        */
> > > > +       size = gen_pool_size(binding->chunk_pool) >> PAGE_SHIFT;
> > > > +       if (size < pool->p.pool_size) {
> > >
> > > pool_size seems to be the number of ptr_ring slots in the page_pool,
> > > not some upper or lower bound on the amount of memory the page_pool
> > > can provide. So this check seems useless? The page_pool can still not
> > > provide this amount of memory with dmabuf (if the netmems aren't being
> > > recycled fast enough) or with normal memory (under memory pressure).
> >
> > I read this check more as "is there enough chunks in the binding to
> > fully fill in the page pool". User controls the size of rx ring
> 
> Only on drivers that support ethtool -G, and where it will let you
> configure -G to what you want.

gve is the minority here, any major nic (brcm/mlx/intel) supports resizing
the rings.

> > which
> > controls the size of the page pool which somewhat dictates the minimal
> > size of the binding (maybe).
> 
> See the test I ran in the other thread. Seems at least GVE is fine
> with dmabuf size < ring size. I don't know what other drivers do, but
> generally speaking I think specific driver limitations should not
> limit what others can do with their drivers. Sure for the GPU mem
> applications you're probably looking at the dmabufs are huge and
> supporting small dmabufs is not a concern, but someone somewhere may
> want to run with 1 MB dmabuf for some use case and if their driver is
> fine with it, core should not prevent it, I think.
> 
> > So it's more of a sanity check.
> >
> > Maybe having better defaults in ncdevmem would've been a better option? It
> > allocates (16000*4096) bytes (slightly less than 64MB, why? to fit into
> > default /sys/module/udmabuf/parameters/size_limit_mb?) and on my setup
> > PP wants to get 64MB at least..
> 
> Yeah, udmabuf has a limitation that it only supports 64MB max size
> last I looked.

We can use /sys/module/udmabuf/parameters/size_limit_mb to allocate
more than 64MB, ncdevmem can change it. Or warn the user similar
to what kperf does: https://github.com/facebookexperimental/kperf/blob/main/devmem.c#L308

So either having a kernel warn or tuning 63MB up to something sensible
(1G?) should prevent people from going through the pain..

> I added devmem TCP support with udmabuf selftests to demonstrate that
> the feature is non-proprietary, not to advertise that devmem tcp +
> udmabuf is a great combination. udmabuf is actually terrible for
> devmem TCP. The 64MB limit is way too small for anyone to do anything
> performant on it and by dmaing into host memory you lose many of the
> benefits of devmem TCP (lower mem bw + pcie bw utilization).

It would still be nice to have a udmabuf as a properly supported option.
This can drive the UAPI performance conversions: for example, comparing
existing tcp rx zerocopy vs MSG_SOCK_DEVMEM.. So let's not completely
dismiss it. We've played internally with doing 2MB udmabuf huge-pages,
might post it at some point..

> If you're running real experiments with devmem TCP I suggest moving to
> real dmabufs as soon as possible, or at least hack udmabuf to give you
> large sizes. We've open sourced our production devmem TCP userspace:
> 
> https://github.com/google/tcpgpudmarxd
> https://github.com/google/nccl-plugin-gpudirecttcpx
> 
> Porting it to upstream APIs + your dmabuf provider will have you run
> much more interesting tests than anything you do with udmabuf I think,
> unless you hack the udmabuf size.

I found these a bit too late, so I reimplemented the plugin over
upstream APIs :-[ Plus, you yourself have acked [0], guess why
I sent this patch :-D Once the tx part is accepted, we'll upstream
kperf cuda support as well..

0: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=8b9049af8066b4705d83bb7847ee3c960fc58d09

