Return-Path: <linux-kselftest+bounces-31602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8E8A9B96B
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 22:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFFB3A5D6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9633321D3D4;
	Thu, 24 Apr 2025 20:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PKxRPcgm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00F217733
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745527851; cv=none; b=JS2shYfMihouGzamSXusKcDGK4fyv5jdmR3Xl+Hb71Z0CzaeBtflJ66Dn0RNEAW2llWvX8zLNqmHKOZQlvbcJcVLm8qCm2Pf8Nv7w/oPNAGdQzpOBSrw2gzRGZNmuhBxLBTz5Xen660v0x4fVm4QbmOeQBG9Y334HvMuRB5auZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745527851; c=relaxed/simple;
	bh=LB7qNGAAaMWemnkoRO++0VBgqYQ61MEhQaUz3r90ctU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfI2nGapEQ24v5mqOhCJaAx9QdimeM7njAn3yGA6kTrgj8wmip/tzC/MyqxRhDyhu2AwbBAfetFyDU70eQPV4DMa9BJInpxUALvsCZYYvJQW4K9zvBLo0wa+1fIb0Zm0TwTxT2DUP89WzG4mPIYnKBqjE1YCBz3AIqYeB1IXv40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PKxRPcgm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2242ac37caeso7715ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 13:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745527849; x=1746132649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/802qi6eb0E7qPDB0B7VDX02ruc5oRmaUhnY+sV4z8=;
        b=PKxRPcgmvvmGgUsuCZuNazBXlXS5LRq7rTe6ykFo6xTG0CvN8tSHriN1aAtkCDO8Pa
         fU3iAruwQCNJUBjmaispXbk1hR00EiD/c+rjnfe7nLvvbtho+RrMCAeyvXkZWkWWd6I3
         VOrndO/k+iEzhZ0hN91jvGvKt+rUIYxg3RGTUmmbOuy8ho1goFOGflGVlc2HOFrq39Pu
         wICsaTBSn7j8Iat3d8HaowVc6H5MAfS3Mu4WyP6KBhtjRe9HUs3qG/j0bfATmN49tnzk
         TrbukAC4w+ys6v/V8nRKuIvD8Hxsl/4NjdUSeNNkWDugi7Z95KKJ2cLsiObtsB6fseiq
         vy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745527849; x=1746132649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/802qi6eb0E7qPDB0B7VDX02ruc5oRmaUhnY+sV4z8=;
        b=NS7AGNnWCibqfyVerLp6qXbEtKCQX3JI8dKxGGxRH9cTValrjXS+UmUrbtcPklSpRY
         pV3QQAF49nKSC1EQo/baeHIf44qq9HNwgyKfmDDfHS6CVhKjp5FPipi3K1cWeVfCe8kT
         4a44oqHAAlTK1xPtqyJ4r7dJqBjM4BjP9KiwL71bpkVb9COT3fKD5wI06k6sVx0i+/Ct
         hyhqAuetA3hq3mtRyXqXjQTpUKrbjm5PpP9cD+Fydw+LXG/XDFxv+29p0UdUwYjx3R3Y
         oe1X6x8pxsXPK9x1pf8+1ZDxrQq29026FHR5uBqzIrETJwlQswmUgB34QC6KnQraXFbd
         3t9A==
X-Forwarded-Encrypted: i=1; AJvYcCUmRF3xiJa3MkeoSvNxZD1CbGXnn7mJWCzfdTawYiJ1vMGyFVFhGbCvBIprXyG2/JmQs3KP+S83xgmF1GTb7Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzExuqTAlZTk/igCaGmsOczWp0pp/qc+am3WLnBcoscRyq2Ivrw
	Dnm6rh0AMIXhjaU5cWmH5x8LqJmGr6HAD7rQLUc/bFzuVMD6mA4d+ci5QarQu1c05KSUW4m/P8Y
	+3OrwrPrXWD7g/E9akvCYHE4qus1SN+NwVfTq
X-Gm-Gg: ASbGncu0IZEHbPcjHTkTu4t0h2qmf8L1Z6KIsCcZiD2mKwDASYevjFDy0we+8EyGwu3
	ZrY7KAamwljroz+HK4tbVjpzayjWjeN8bbrUamJLVQbyBpz8t2K+CvTDXZrCLGODheiqSAfWuNe
	7biVxKgDGk2vM2Q0udSsxk8gtmpMFh1Rm5nrWuncu6tYGE+kJjsRmb
X-Google-Smtp-Source: AGHT+IFNkXE9PRC3ayxXx+fRCxr+F26rln5fZ6roq2TrIdXM/8T4kEtsQjIS9/nx2ZAmTrEyasN1ZxNuuHVbrrmck8g=
X-Received: by 2002:a17:902:d508:b0:223:3b76:4e25 with SMTP id
 d9443c01a7336-22dbe47ad14mr87555ad.17.1745527848933; Thu, 24 Apr 2025
 13:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423153504.1085434-1-cratiu@nvidia.com> <CAHS8izPxT_SB6+fc7dPcojv3mui3BjDZB5xmz3u6oYuA2805FA@mail.gmail.com>
 <9322c3c4826ed1072ddc9a2103cc641060665864.camel@nvidia.com>
In-Reply-To: <9322c3c4826ed1072ddc9a2103cc641060665864.camel@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 24 Apr 2025 13:50:35 -0700
X-Gm-Features: ATxdqUEuhLKTWnDuUFNISQQgLta9fpzCmB9Lk5mhqVRYucx9SnaE5w5d2Jx1MXc
Message-ID: <CAHS8izMnpEoXzuu2Eg-3ewSj7Chq2mC5k0tFosOLT6SU3+ennQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/devmem: Reject insufficiently large dmabuf pools
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	Leon Romanovsky <leonro@nvidia.com>, "edumazet@google.com" <edumazet@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 1:47=E2=80=AFAM Cosmin Ratiu <cratiu@nvidia.com> wr=
ote:
>
> On Wed, 2025-04-23 at 10:30 -0700, Mina Almasry wrote:
> > On Wed, Apr 23, 2025 at 9:03=E2=80=AFAM Cosmin Ratiu <cratiu@nvidia.com=
>
> > wrote:
> > >
> > > Drivers that are told to allocate RX buffers from pools of DMA
> > > memory
> > > should have enough memory in the pool to satisfy projected
> > > allocation
> > > requests (a function of ring size, MTU & other parameters). If
> > > there's
> > > not enough memory, RX ring refill might fail later at inconvenient
> > > times
> > > (e.g. during NAPI poll).
> > >
> >
> > My understanding is that if the RX ring refill fails, the driver will
> > post the buffers it was able to allocate data for, and will not post
> > other buffers. So it will run with a degraded performance but nothing
> > overly bad should happen. This should be the same behavior if the
> > machine is under memory pressure.
>
> What motivated this change was a failure in how mlx5 refills rings
> today. For efficiency, ring refill triggered by NAPI polling only
> releases old buffers just before allocating new ones so effectively has
> a built-in assumption that the ring can be filled. Commit 4c2a13236807
> ("net/mlx5e: RX, Defer page release in striding rq for better
> recycling") is an interesting read here.
>
> For more details, see the do{ }while loop in mlx5e_post_rx_mpwqes,
> where mlx5e_free_rx_mpwqe then mlx5e_alloc_rx_mpwqe are called to free
> the old buffer and reallocate a new one at the same position. This has
> excellent cache-locality and the pages returned to the pool will be
> reused by the new descriptor.
>

Thanks for the detailed explanation. These seem like a clever optimization.

> The bug in mlx5 is that with a large MTU & ring size, the ring cannot
> be fully populated with rx descriptors because the pool doesn't have
> enough memory, but there's no memory released back to the pool for new
> ones. Eventually, rx descriptors are exhausted and traffic stops.
>
> > In general I don't know about this change. If the user wants to use
> > very small dmabufs, they should be able to, without going through
> > hoops reducing the number of rx ring slots the driver has (if it
> > supports configuring that).
> >
> > I think maybe printing an error or warning that the dmabuf is too
> > small for the pool_size may be fine. But outright failing this
> > configuration? I don't think so.
>
> For regular memory-backed page pools, there's no hard limit of how big
> they can become (except available physical memory), so this issue was
> not seen before.
>
> I didn't look at other drivers yet, but is it expected that drivers
> operate with incompletely filled rings? I assumed that since the user
> configured a specified ring size, it expects drivers to be able to use
> that size and not silently operate in degraded mode, with a smaller
> ring size.
>
> If you think drivers should work in degraded mode, we can look at
> improving the ring population code to work better in this scenario.
>

You're probably a bigger expert to me on what drivers should do in
general, but yes, this seems like an mlx5 limitation, not a general
limitation to all drivers. GVE for example, I think, has a host of
optimization for memory pressure scenarios that makes it resilient to
this. I ran this test:

mina-3 /home/almasrymina_google_com # ethtool -g eth0
Ring parameters for eth0:
...
Current hardware settings:
...
RX:             1024

Then hacked ncdevmem to only provide a 64 page udmabuf:

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index 1f9fb0b1cb811..6de64f7680241 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -76,7 +76,7 @@

 #define PAGE_SHIFT 12
 #define TEST_PREFIX "ncdevmem"
-#define NUM_PAGES 16000
+#define NUM_PAGES 64

 #ifndef MSG_SOCK_DEVMEM
 #define MSG_SOCK_DEVMEM 0x2000000

To my surprise, the test passed just fine. Seems the limitation at
least doesn't apply to GVE. I don't know what the rest of the drivers
do, but so far this seems like driver specific behavior. I think
putting limitations in the core stack for mlx5 issues doesn't seem
great.

> > pool_size seems to be the number of ptr_ring slots in the page_pool,
> > not some upper or lower bound on the amount of memory the page_pool
> > can provide. So this check seems useless? The page_pool can still not
> > provide this amount of memory with dmabuf (if the netmems aren't
> > being
> > recycled fast enough) or with normal memory (under memory pressure).
>
> I think pool_size is usually set by drivers based on their params, and
> it's the max size of pool->ring. The opportunistic check I added
> compares this demand with the supply (available chunk memory) and fails
> this config based on the assumption that there should be enough memory
> in the pool to satisfy driver needs.
>
> Please let me know your thoughts and how to proceed.

I think there are better options here:

1. In the page_pool, warn if the dmabuf is too small for the ring
size, but don't outright prevent the configuration. If the user is
running on a driver that doesn't have a dmabuf size limitation, let
them ignore the warning and run it.

2. In mlx5 code, somehow find out how big the dmabuf size is (it may
need a new pp api), and then in mlx5 code prevent this configuration
to workaround your (I think) driver-specific limitation.

3. Maybe address the general limitation in mlx5, and make it work even
if it can't refill its rings? It would help this case and other memory
pressure scenarios as well.





--=20
Thanks,
Mina

