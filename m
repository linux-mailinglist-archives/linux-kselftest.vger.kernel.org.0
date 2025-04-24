Return-Path: <linux-kselftest+bounces-31610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA4AA9BAEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 00:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD10B9A4258
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 22:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35A428BA98;
	Thu, 24 Apr 2025 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrKLYqIn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8CA289343;
	Thu, 24 Apr 2025 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745534437; cv=none; b=N2UK1uN5Hq+1UOQg+/9KxU0Tn87/o7nJe75C4ZI6cMqwjPu8b22z305dZgZNSZd9VixeYAJr1G8IyJHn9mZ5LtCv/ebXfTSRlxsILyll/umyozprjoQIFKGTjFeBIwWcoflIJdN3us8a2N38OksIudkVCuv9h3pzsQiyfQ0UFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745534437; c=relaxed/simple;
	bh=CPymJrNzkTCC7cf533OUxyRlDjzuFR7/rUWYwDh18BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcQPsa9OSuPTSkhIXrtOUn7yYnqnbghSFzqx2rFR/KtT7a3K2XGVUF8WTsX6U247+mj+PZcftLxThO9zxd5+JajDGIfvnK/rvK3vD3fHaMLDvJaf8C2XgBt5ZPYVlBsR6RLeAWwNHf0GmePI2F6Tj+ODCQZ5Xqbv25MpOVJx6zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrKLYqIn; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-306bf444ba2so1645944a91.1;
        Thu, 24 Apr 2025 15:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745534435; x=1746139235; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mR9rrdZ6+HdtoBxUXeVVRL1oiuhTPin2/mAhsiUs3eM=;
        b=TrKLYqInpW6AXOuPsuyLVsMbQV1Ph9IBp5iGp3eVLx98kLqAwSqoELZxpyAgVptw7s
         A17IYgwDrcVM2GKA55dajr0/pf9wM7eWnkvatb+P4o9MMnMiIYTEvE7eQN/XgDZ4koBQ
         vLQw4AGhWDzHBFHUfUCCWIIgy6dS4LW1qCRoJqNpSUHGoZIMxv6yXxjkii7R42rPOxm5
         3AHbVljccHStoVAkTLsK8aJ0tSnhnGYsIGCfsZr5W12zodaRDI6vdlYDhji0PkUmA9Ga
         ZS+6uEzrgbDEd+FY2kuX2XSHqXdB8cqVxre+AiNVSpA/HeYZOIA3tdnPGfc2bVMqq7N6
         +45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745534435; x=1746139235;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mR9rrdZ6+HdtoBxUXeVVRL1oiuhTPin2/mAhsiUs3eM=;
        b=l+y2vYK5UImemOakHDJr3LjF2LU5LqBJNYPw5zGWOsR8QlVRaLIxbQBXeikVqvZdYT
         0ie6ifD3Br7WZy+YUpxIIbFdwpra3fisR1omPHzw0d6lmGHoOH70t7uoFvLeOvB/vLB7
         qORGRInQaNeActk4QwK3Dop4zQDRsPa4S/Ou8B3ntayPacGR/5dYOV/R0k97QOiYiuGU
         jFYVKNGBxeMpUN2ycS1nMwkiRAPioUQSblCQqRn/vHAJzS0m7BnVjLBg3SyBSI0PGSbA
         80Htsa0ERhaFHqz3RKaXttL+b/RzSHs8yf+vdvgOfFaLAsd1474PiuCNPm6MSaehjnrI
         /ffg==
X-Forwarded-Encrypted: i=1; AJvYcCXAOKDq8ie62CSu8a6hKkMRZukboFHg15EFvW+Y6CPPy0t/Nc9p/xGZhYiJf+pRATctsz6IqdD8@vger.kernel.org, AJvYcCXtl5K74kbgVnHjgg7M7oEPNOlRVab74K515TD7owZnNXeWNfS0uJdZAJ4piIIuDvosVsvzSfH1WODNZgH/VNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuTqDY1x4tSdUFULuzq0OjvTYgla+pXItBt/yVQJE+rvQU/2x0
	H3Kqd4yxcHhUuEiNFzcZnYlpEYCqQIkSch7Gr6AteY3KPOxnnwM=
X-Gm-Gg: ASbGncvbE+LhaU1o3U4PiiinIQP64nG2QucfD9cJb/6wu2MrBDwOfL4IC46z7sSYbdB
	2bL3HbGZhkFNSn8NCzDhoo7DRh8I7zkvKJlzy5TQrhnsIWe9naZ3kO//EJYWTCTIt/mbmo43fpD
	OFmdumA0zhgaykq4BlntAtvy310nEWnpH0khGINmMmDjQXi/L7YXaXd2JFJWRnGPrTnHHJFhbLT
	T3woL80bv3KG3f59vvYV+m4MfPaQgqOa108ci8oqCjiBoYLmIzv45hD8HqgJo6lDHcPotmLIfOX
	NY1Up9YnZWOcUg06UoKUXlPQQi5efmlL2U91ij1p
X-Google-Smtp-Source: AGHT+IEHEuGcQPgNznq6Fhs46m6GHMwSktjbc2tqGpyZY3XEWKDFTSevCbocLlWKq3rXQBpL1JyDuQ==
X-Received: by 2002:a17:90a:d647:b0:2ee:863e:9ffc with SMTP id 98e67ed59e1d1-309f7dfd11cmr353229a91.21.1745534435164;
        Thu, 24 Apr 2025 15:40:35 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-309f774e4d1sm163302a91.16.2025.04.24.15.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:40:34 -0700 (PDT)
Date: Thu, 24 Apr 2025 15:40:33 -0700
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
Message-ID: <aAq94Zw69XRs45T4@mini-arch>
References: <20250423153504.1085434-1-cratiu@nvidia.com>
 <CAHS8izPxT_SB6+fc7dPcojv3mui3BjDZB5xmz3u6oYuA2805FA@mail.gmail.com>
 <aAlKaELj0xIbJ45c@mini-arch>
 <CAHS8izOm4QbHECZDB+imV2eVXs=KXRKzJsDw2gKGp_gx0ja7Ng@mail.gmail.com>
 <aAq2y_awPoGqhjdp@mini-arch>
 <CAHS8izNAtzyjY94qPq1-2sPUUDaN14SCXrgM5XkwCNDz4SgbvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNAtzyjY94qPq1-2sPUUDaN14SCXrgM5XkwCNDz4SgbvQ@mail.gmail.com>

On 04/24, Mina Almasry wrote:
> On Thu, Apr 24, 2025 at 3:10 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 04/24, Mina Almasry wrote:
> > > On Wed, Apr 23, 2025 at 1:15 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > > >
> > > > On 04/23, Mina Almasry wrote:
> > > > > On Wed, Apr 23, 2025 at 9:03 AM Cosmin Ratiu <cratiu@nvidia.com> wrote:
> > > > > >
> > > > > > Drivers that are told to allocate RX buffers from pools of DMA memory
> > > > > > should have enough memory in the pool to satisfy projected allocation
> > > > > > requests (a function of ring size, MTU & other parameters). If there's
> > > > > > not enough memory, RX ring refill might fail later at inconvenient times
> > > > > > (e.g. during NAPI poll).
> > > > > >
> > > > >
> > > > > My understanding is that if the RX ring refill fails, the driver will
> > > > > post the buffers it was able to allocate data for, and will not post
> > > > > other buffers. So it will run with a degraded performance but nothing
> > > > > overly bad should happen. This should be the same behavior if the
> > > > > machine is under memory pressure.
> > > > >
> > > > > In general I don't know about this change. If the user wants to use
> > > > > very small dmabufs, they should be able to, without going through
> > > > > hoops reducing the number of rx ring slots the driver has (if it
> > > > > supports configuring that).
> > > > >
> > > > > I think maybe printing an error or warning that the dmabuf is too
> > > > > small for the pool_size may be fine. But outright failing this
> > > > > configuration? I don't think so.
> > > > >
> > > > > > This commit adds a check at dmabuf pool init time that compares the
> > > > > > amount of memory in the underlying chunk pool (configured by the user
> > > > > > space application providing dmabuf memory) with the desired pool size
> > > > > > (previously set by the driver) and fails with an error message if chunk
> > > > > > memory isn't enough.
> > > > > >
> > > > > > Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider")
> > > > > > Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> > > > > > ---
> > > > > >  net/core/devmem.c | 11 +++++++++++
> > > > > >  1 file changed, 11 insertions(+)
> > > > > >
> > > > > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > > > > index 6e27a47d0493..651cd55ebb28 100644
> > > > > > --- a/net/core/devmem.c
> > > > > > +++ b/net/core/devmem.c
> > > > > > @@ -299,6 +299,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> > > > > >  int mp_dmabuf_devmem_init(struct page_pool *pool)
> > > > > >  {
> > > > > >         struct net_devmem_dmabuf_binding *binding = pool->mp_priv;
> > > > > > +       size_t size;
> > > > > >
> > > > > >         if (!binding)
> > > > > >                 return -EINVAL;
> > > > > > @@ -312,6 +313,16 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
> > > > > >         if (pool->p.order != 0)
> > > > > >                 return -E2BIG;
> > > > > >
> > > > > > +       /* Validate that the underlying dmabuf has enough memory to satisfy
> > > > > > +        * requested pool size.
> > > > > > +        */
> > > > > > +       size = gen_pool_size(binding->chunk_pool) >> PAGE_SHIFT;
> > > > > > +       if (size < pool->p.pool_size) {
> > > > >
> > > > > pool_size seems to be the number of ptr_ring slots in the page_pool,
> > > > > not some upper or lower bound on the amount of memory the page_pool
> > > > > can provide. So this check seems useless? The page_pool can still not
> > > > > provide this amount of memory with dmabuf (if the netmems aren't being
> > > > > recycled fast enough) or with normal memory (under memory pressure).
> > > >
> > > > I read this check more as "is there enough chunks in the binding to
> > > > fully fill in the page pool". User controls the size of rx ring
> > >
> > > Only on drivers that support ethtool -G, and where it will let you
> > > configure -G to what you want.
> >
> > gve is the minority here, any major nic (brcm/mlx/intel) supports resizing
> > the rings.
> >
> 
> GVE supports resizing rings. Other drivers may not. Even on drivers
> that support resizing rings. Some users may have a use case for a
> dmabuf smaller than the minimum ring size their driver accepts.
> 
> > > > which
> > > > controls the size of the page pool which somewhat dictates the minimal
> > > > size of the binding (maybe).
> > >
> > > See the test I ran in the other thread. Seems at least GVE is fine
> > > with dmabuf size < ring size. I don't know what other drivers do, but
> > > generally speaking I think specific driver limitations should not
> > > limit what others can do with their drivers. Sure for the GPU mem
> > > applications you're probably looking at the dmabufs are huge and
> > > supporting small dmabufs is not a concern, but someone somewhere may
> > > want to run with 1 MB dmabuf for some use case and if their driver is
> > > fine with it, core should not prevent it, I think.
> > >
> > > > So it's more of a sanity check.
> > > >
> > > > Maybe having better defaults in ncdevmem would've been a better option? It
> > > > allocates (16000*4096) bytes (slightly less than 64MB, why? to fit into
> > > > default /sys/module/udmabuf/parameters/size_limit_mb?) and on my setup
> > > > PP wants to get 64MB at least..
> > >
> > > Yeah, udmabuf has a limitation that it only supports 64MB max size
> > > last I looked.
> >
> > We can use /sys/module/udmabuf/parameters/size_limit_mb to allocate
> > more than 64MB, ncdevmem can change it.
> 
> The udmabuf limit is hardcoded, in udmabuf.c or configured on module
> load, and ncdevmem doesn't load udmabuf. I guess it could be changed
> to that, but currently ncdevmem works with CONFIG_UDMABUF=y

You don't need to load/reload the module to change module params:

# id
uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys)
# cat /sys/module/udmabuf/parameters/size_limit_mb
64
# echo 128 > /sys/module/udmabuf/parameters/size_limit_mb
# cat /sys/module/udmabuf/parameters/size_limit_mb
128

> > Or warn the user similar
> > to what kperf does: https://github.com/facebookexperimental/kperf/blob/main/devmem.c#L308
> >
> > So either having a kernel warn or tuning 63MB up to something sensible
> > (1G?) should prevent people from going through the pain..
> >
> 
> Agreed with both. Another option is updating the devmem.rst docs:
> 
> "Some drivers may struggle to run devmem TCP when the dmabuf size is
> too small, especially when it's smaller than the number of rx ring
> slots. Look for this warning in dmesg." etc.
> 
> But I don't see the need to outright disable this "dmabuf size < ring
> size" use case for everyone to solve this.

Agreed. The fact that mlx5 has issues with small pp should be fixed,
I'm not arguing with that. I'm trying to understand whether giving
a hint to the user about dmabuf < pp size is helpful or not (because
it will most likely will lead to poor perf, which is the main point
of devmem).

> > > I added devmem TCP support with udmabuf selftests to demonstrate that
> > > the feature is non-proprietary, not to advertise that devmem tcp +
> > > udmabuf is a great combination. udmabuf is actually terrible for
> > > devmem TCP. The 64MB limit is way too small for anyone to do anything
> > > performant on it and by dmaing into host memory you lose many of the
> > > benefits of devmem TCP (lower mem bw + pcie bw utilization).
> >
> > It would still be nice to have a udmabuf as a properly supported option.
> > This can drive the UAPI performance conversions: for example, comparing
> > existing tcp rx zerocopy vs MSG_SOCK_DEVMEM.. So let's not completely
> > dismiss it. We've played internally with doing 2MB udmabuf huge-pages,
> > might post it at some point..
> >
> > > If you're running real experiments with devmem TCP I suggest moving to
> > > real dmabufs as soon as possible, or at least hack udmabuf to give you
> > > large sizes. We've open sourced our production devmem TCP userspace:
> > >
> > > https://github.com/google/tcpgpudmarxd
> > > https://github.com/google/nccl-plugin-gpudirecttcpx
> > >
> > > Porting it to upstream APIs + your dmabuf provider will have you run
> > > much more interesting tests than anything you do with udmabuf I think,
> > > unless you hack the udmabuf size.
> >
> > I found these a bit too late, so I reimplemented the plugin over
> > upstream APIs :-[
> 
> Oh, where? Is it open source?

No, but depending on where we end up I think it should be possible
to make it open source. The is no secret sauce in there..

