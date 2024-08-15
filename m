Return-Path: <linux-kselftest+bounces-15410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C91953676
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 17:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672531C252FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C0819DF9C;
	Thu, 15 Aug 2024 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy8gyr0J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CF41AC8BD;
	Thu, 15 Aug 2024 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734089; cv=none; b=GQ/bPFkD59tDgIFK64ZwdFkdCDXgIQkykWMHXzxqt4tPWXeybwG5IYoyaHi64FvGnPwcE9v8/3fBptm41bU0CVBb4WDi1QIk4AI74ysYLl5QVlW5D7Kxw465dk2OaCkDZxj/BU6a6IMBNy7I/lkokAhXLnoovkD1/O3OQNSYSM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734089; c=relaxed/simple;
	bh=AZof4Bx69ydPqYVIrzeRixgG1XQf1cxPLetvRiCSI14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qj1kuWMuEj4ErKIwRqNW9DvmQ9FU2zQtoGh/5oO/p/7QVCZJ5kQCvWRVxKGPp2azoc0Y9v0yrjRGhrgluCxHICbKe8vCTscnayT9cRmvYhsRnVkZm8zr5SYwDbc4N8y7YNEnLWjHj9znoSLR/22wkfk1N+vRXC6J7fABv9mpn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy8gyr0J; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso9485065e9.3;
        Thu, 15 Aug 2024 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723734086; x=1724338886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5A/Pf35dj4E2EpVtARhuhl6tAP8WNgJnMyspcYzO+k=;
        b=dy8gyr0JZC/GvY1aYc/YPk/Si3wqqX1WVmY+sz6zEV+tvYhfV5pa7OcsvIRnsHYHdy
         14JIXDiXrXRWZpUUp0AitQN6rTVZW59i4gxQdhQa7flGxfIX9AB41KlVWd0ctX1ghqIS
         eU2BsGHZJnRJcipvmmnnUJvP6gSpNXLal968OxI87/dhqUgkGvn408xDDMrxlL5C6wSz
         j4o3La6ObiqOUewr8MBq3ja5b9X1wrZw10yu7RYc7ogaLC3fBUupO9J/agBwBedMYH3Z
         v1WXvH0t/zGTGiV3AzE7uaBRIdp/9uxUZaA3bkeZspa/KUh+5jFOZvTVtBFc5zmK9kkb
         VS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723734086; x=1724338886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5A/Pf35dj4E2EpVtARhuhl6tAP8WNgJnMyspcYzO+k=;
        b=VFFnBDVS/NMC+b3DyNFvVBc1uy01ELlBbq0O6PB9naBINyUwAtwJCNx1kPnlJqEWm8
         zXoStR9Fbi+NDi+tkQpnRsj1xy0103wJVx1cUSIyLjrvNd+jD3gzljZTfARUUIbz7H7m
         uHDzfJmUG7LGtcI3eejToEbUB1EalRqsiIdCTW1wZcAAezroM4Hn9aHAO3TrxeaQSsXh
         KKVP9gCBEq/i7QNziozCC4Om8F6PhQSQZFGPgTC8av0sM16felOLoomTqjNINLYyhlaK
         wz2aXQ3kdv7Cpy15jzpYwBl+CrQbL9HJSGtUNLu24glPHjHrqHO9Nx77VijMNeCbAB03
         ajMw==
X-Forwarded-Encrypted: i=1; AJvYcCXFIvoK/Ye7cwG7Xj7MtxetJBlPt9+PpOEobadnF64amBRKmc9pzWdPLC6ZhPHCz2m0S9kUSrRcEMFAiOVPmhD8zj+1B6iI3KZxXy5aou4ltMKLFtIN90CoXlzGUyq8/cHgigzP06wWSFrEvdAHFuneYrsib3WqIh5O3ujJSNcM5/cw/SQXZV8/PcPwISAF8EKVDENEX2CJGVmcMW93iGhtH76wBsStyCvY9o82mMiiMqj0UHWAJ3LO2Azzq85+cN2+8V2iDMJWsKZo
X-Gm-Message-State: AOJu0YxHH2dZOcaDHHdY7RP+O6m5UP7ReZOpX2m6iDIVe7RpDdH1J6Yd
	9wg89DwiL7Te/5CIavSeQOoBFYNeyokzW79xcQ+InGHTfD+AqAhg+7DsnhonU7ublJ62XvGY1DQ
	75TbPM/i5yzO77NZuJlU/qKOC+H0=
X-Google-Smtp-Source: AGHT+IFDnpMtbZ2O72JrYtKTcNGdeMRDRFuISj162VcIBgDVR4ZNDcEgvb9oYMQdJ7UgCrLds6/xYlzhvGcrtQXyvpA=
X-Received: by 2002:a05:600c:511e:b0:426:59d3:8cae with SMTP id
 5b1f17b1804b1-429dd236521mr62262805e9.13.1723734085882; Thu, 15 Aug 2024
 08:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-5-linyunsheng@huawei.com> <d1a23116d054e2ebb00067227f0cffecefe33e11.camel@gmail.com>
 <676a2a15-d390-48a7-a8d7-6e491c89e200@huawei.com>
In-Reply-To: <676a2a15-d390-48a7-a8d7-6e491c89e200@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 15 Aug 2024 08:00:49 -0700
Message-ID: <CAKgT0Uct5ptfs9ZEoe-9u-fOVz4HLf+5MS-YidKV+xELCBHKNw@mail.gmail.com>
Subject: Re: [PATCH net-next v13 04/14] mm: page_frag: add '_va' suffix to
 page_frag API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, 
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	bpf@vger.kernel.org, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 8:00=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/8/14 23:49, Alexander H Duyck wrote:
> > On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
> >> Currently the page_frag API is returning 'virtual address'
> >> or 'va' when allocing and expecting 'virtual address' or
> >> 'va' as input when freeing.
> >>
> >> As we are about to support new use cases that the caller
> >> need to deal with 'struct page' or need to deal with both
> >> 'va' and 'struct page'. In order to differentiate the API
> >> handling between 'va' and 'struct page', add '_va' suffix
> >> to the corresponding API mirroring the page_pool_alloc_va()
> >> API of the page_pool. So that callers expecting to deal with
> >> va, page or both va and page may call page_frag_alloc_va*,
> >> page_frag_alloc_pg*, or page_frag_alloc* API accordingly.
> >>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
> >> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> >> Acked-by: Sagi Grimberg <sagi@grimberg.me>
> >> ---
> >>  drivers/net/ethernet/google/gve/gve_rx.c      |  4 ++--
> >>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  2 +-
> >>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
> >>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  2 +-
> >>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  4 ++--
> >>  .../marvell/octeontx2/nic/otx2_common.c       |  2 +-
> >>  drivers/net/ethernet/mediatek/mtk_wed_wo.c    |  4 ++--
> >>  drivers/nvme/host/tcp.c                       |  8 +++----
> >>  drivers/nvme/target/tcp.c                     | 22 +++++++++---------=
-
> >>  drivers/vhost/net.c                           |  6 ++---
> >>  include/linux/page_frag_cache.h               | 21 +++++++++---------
> >>  include/linux/skbuff.h                        |  2 +-
> >>  kernel/bpf/cpumap.c                           |  2 +-
> >>  mm/page_frag_cache.c                          | 12 +++++-----
> >>  net/core/skbuff.c                             | 16 +++++++-------
> >>  net/core/xdp.c                                |  2 +-
> >>  net/rxrpc/txbuf.c                             | 15 +++++++------
> >>  net/sunrpc/svcsock.c                          |  6 ++---
> >>  .../selftests/mm/page_frag/page_frag_test.c   | 13 ++++++-----
> >>  19 files changed, 75 insertions(+), 70 deletions(-)
> >>
> >
> > I still say no to this patch. It is an unnecessary name change and adds
> > no value. If you insist on this patch I will reject the set every time.
> >
> > The fact is it is polluting the git history and just makes things
> > harder to maintain without adding any value as you aren't changing what
> > the function does and there is no need for this. In addition it just
>
> I guess I have to disagree with the above 'no need for this' part for
> now, as mentioned in [1]:
>
> "There are three types of API as proposed in this patchset instead of
> two types of API:
> 1. page_frag_alloc_va() returns [va].
> 2. page_frag_alloc_pg() returns [page, offset].
> 3. page_frag_alloc() returns [va] & [page, offset].
>
> You seemed to miss that we need a third naming for the type 3 API.
> Do you see type 3 API as a valid API? if yes, what naming are you
> suggesting for it? if no, why it is not a valid API?"

I didn't. I just don't see the point in pushing out the existing API
to support that. In reality 2 and 3 are redundant. You probably only
need 3. Like I mentioned earlier you can essentially just pass a
page_frag via pointer to the function. With that you could also look
at just returning a virtual address as well if you insist on having
something that returns all of the above. No point in having 2 and 3 be
seperate functions.

I am going to nack this patch set if you insist on this pointless
renaming. The fact is it is just adding noise that adds no value.

