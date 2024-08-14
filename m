Return-Path: <linux-kselftest+bounces-15329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A05951F0D
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 17:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171711C21772
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A8E1B5808;
	Wed, 14 Aug 2024 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLOWP2sR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136A628DC3;
	Wed, 14 Aug 2024 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650602; cv=none; b=VfqJZmtmpCafY8LVqTl6ejKEFDwJbQPhoLqT/sc+fF7vOU/h702FKiBPYTK1X4u/5cCS+wAHR4NOaYMUVHMAkgNNDv8d8AxIh/hAmXybEacA87WEy1GP90DfGhJY8aJBV9+3XwPDTT4gmdEkXGkqx5FAHp35lMO4OIc05qfhb30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650602; c=relaxed/simple;
	bh=6vcFZWl/iSCK/BZGfGXgt8ur06Ij2rRs68cC5ThdJyg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YrFzmcvlRvWA4Kr3gzyAOzaCDsRsLDN269BpFCF9F99aUqJKMCrOksIzB/ZgjTp7SNfJqBMlRQtAA6l3koTLwrXltrWVvYBu7C9QyROdbCshTuB67uwyIU8t1TzSvqVL63fSOICfxy10C1EBvu5zcWiiDPRDphqgSPMyYZ5HEZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLOWP2sR; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7093472356dso3808967a34.0;
        Wed, 14 Aug 2024 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723650600; x=1724255400; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fDv9V0v7KkpdJrpMs0piYzLNRxXj+irK5gUuUzZpGhs=;
        b=eLOWP2sR+BDKCHyg1t27NoPaSeje4K4pIGR9xPHFZdEA7vIadrUaxzXJY9HKNHZDgh
         Ko7dYBloGZWSNBULmrWdpL9j6RsTMpfUfePQ81CoCjQX2UVJPxH6NwW5dG3fvttfnsqp
         f/bxETrCpDybYP4O/Z2k/PPPr7dbEi41mLrY/6a7oMfPvufWbhn2AA60HSnF7TOhMZ7q
         Yt/EiZZFellVwdiCI4uCPibIuzSvuFZ/rWXY0KZxJMA82OtmsVc0onHKeMsiJLqaHuGk
         FxodljGBwBqOgnmvAGwiQqxs2Gf5flh3mrVBxQd9dE+kME5yJG9xN5x9KW/Wh3wG/rGA
         YU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723650600; x=1724255400;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDv9V0v7KkpdJrpMs0piYzLNRxXj+irK5gUuUzZpGhs=;
        b=i/wVqWdoHd2tFl8xcEaUOj/G0qStpT4zH/eUP4CDLSE/ChptxXWnczqa9Ym+1fqLIL
         Oy/WqyYxfl15hqM3t7kefnFkaDUjjZooxW4HQXfBxJylwbZ/cQQmYzcUbpP6aXjV5ykx
         srKfqJ/Z0YKHE2oSrtljGxYPnUcGNUKPSKh3YBH/vSC4jKokk8uWwj5MsyMI9Gods+Dm
         Sst9VsmrPk2cEkylXk2Ko7YnVgPp9VxnxfvTi5vcbrI0J6FW8OeHkI1bA8v6by8zmmjL
         opASoHX7TPLm1L+j4/w9kl7r72WXHyRdtFM+cZ3LiwoNOaa1oieOjwUg3ZiX35v/hR1/
         hEyw==
X-Forwarded-Encrypted: i=1; AJvYcCXJCiznzieD6tQyaYwwroalQbZA2dmX1LIayV6sPfsO8edRT26kxQ/sbOzpziFDxJOjmhYlhi6HCB5uWS1/JUQc0HyqEShtJ9yUE0xmuTqtTX8yJxmZRijNOTq9V6eODMgAJhsRnnRvuIqx9H7ABI2YngI8NLWzd5lLb78hkNtwxuSOorZT07wCS8ExpD3x3YTbGPBsevcDibeoCk/oROzm4HlS345x3rU0WU5YGJsViYc5
X-Gm-Message-State: AOJu0Yy+1LZLxzdrEfzX5+W4NDgHcaggD6grGK0IPom8RBeR0/WOl32c
	HkavQDuSm0ENvoM/PPPRDitZ9QJnq30/EfrlxIK4oUhIeK1azUun
X-Google-Smtp-Source: AGHT+IF+xU5hTvBzD845HScA3WjHDYwvu17hmSc7al7mxeLt+8xp5o7SMvsr67KFPwp2VJkvDAOPFA==
X-Received: by 2002:a05:6830:638b:b0:709:3f84:c1e0 with SMTP id 46e09a7af769-70c9d9c25a1mr3660423a34.26.1723650600144;
        Wed, 14 Aug 2024 08:50:00 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70c7b880badsm2269478a34.54.2024.08.14.08.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:49:59 -0700 (PDT)
Message-ID: <d1a23116d054e2ebb00067227f0cffecefe33e11.camel@gmail.com>
Subject: Re: [PATCH net-next v13 04/14] mm: page_frag: add '_va' suffix to
 page_frag API
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Subbaraya Sundeep
 <sbhatta@marvell.com>, Chuck Lever <chuck.lever@oracle.com>, Sagi Grimberg
 <sagi@grimberg.me>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Shailend Chand
 <shailend@google.com>, Eric Dumazet <edumazet@google.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>,
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark Lee
 <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>,
  Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Chaitanya
 Kulkarni <kch@nvidia.com>,  "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  David Howells
 <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Jeff Layton
 <jlayton@kernel.org>,  Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
 <anna@kernel.org>,  Shuah Khan <shuah@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org, 
 kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org, 
 bpf@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-nfs@vger.kernel.org,  linux-kselftest@vger.kernel.org
Date: Wed, 14 Aug 2024 08:49:53 -0700
In-Reply-To: <20240808123714.462740-5-linyunsheng@huawei.com>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
	 <20240808123714.462740-5-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
> Currently the page_frag API is returning 'virtual address'
> or 'va' when allocing and expecting 'virtual address' or
> 'va' as input when freeing.
>=20
> As we are about to support new use cases that the caller
> need to deal with 'struct page' or need to deal with both
> 'va' and 'struct page'. In order to differentiate the API
> handling between 'va' and 'struct page', add '_va' suffix
> to the corresponding API mirroring the page_pool_alloc_va()
> API of the page_pool. So that callers expecting to deal with
> va, page or both va and page may call page_frag_alloc_va*,
> page_frag_alloc_pg*, or page_frag_alloc* API accordingly.
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Acked-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/net/ethernet/google/gve/gve_rx.c      |  4 ++--
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  2 +-
>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  4 ++--
>  .../marvell/octeontx2/nic/otx2_common.c       |  2 +-
>  drivers/net/ethernet/mediatek/mtk_wed_wo.c    |  4 ++--
>  drivers/nvme/host/tcp.c                       |  8 +++----
>  drivers/nvme/target/tcp.c                     | 22 +++++++++----------
>  drivers/vhost/net.c                           |  6 ++---
>  include/linux/page_frag_cache.h               | 21 +++++++++---------
>  include/linux/skbuff.h                        |  2 +-
>  kernel/bpf/cpumap.c                           |  2 +-
>  mm/page_frag_cache.c                          | 12 +++++-----
>  net/core/skbuff.c                             | 16 +++++++-------
>  net/core/xdp.c                                |  2 +-
>  net/rxrpc/txbuf.c                             | 15 +++++++------
>  net/sunrpc/svcsock.c                          |  6 ++---
>  .../selftests/mm/page_frag/page_frag_test.c   | 13 ++++++-----
>  19 files changed, 75 insertions(+), 70 deletions(-)
>=20

I still say no to this patch. It is an unnecessary name change and adds
no value. If you insist on this patch I will reject the set every time.

The fact is it is polluting the git history and just makes things
harder to maintain without adding any value as you aren't changing what
the function does and there is no need for this. In addition it just
makes it that much harder to backport fixes in the future as people
will have to work around the rename.


