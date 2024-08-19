Return-Path: <linux-kselftest+bounces-15657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C5D956F52
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 17:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C09281CDA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 15:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08688135A53;
	Mon, 19 Aug 2024 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEGegQAg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142484964D;
	Mon, 19 Aug 2024 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082912; cv=none; b=nrHb105v5HG7Kugz4zoh4mXI0rIARR079rgQApmQTxJL1WCz5WtxyTGoOof91IgHjeoFz8eANNM7tJVMkDhW1qFICAnqLaZwHJQ/u+Yc4WAOBihLhSov1zXXzH77ItgMv/ZqMPAG0jHgS5e3O7x1BCwYrrLqV3hx1VCesACMtfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082912; c=relaxed/simple;
	bh=nDiEC+oucoZKIe0++x2SH+xHDpiER8lsQQj93ua/syg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLkdOW3EvwK+HPmX65F1gJ2POxOhkIR88Lo9i9g7iMHH1sTQWRJhKg4uWouCx2/X7Fapml4rBAVfIXjZHGzATN83PfcN9I5Q2UQIj1WuML+1Yb6lHfQlD2yA1ff+PX0IhWvUlIZJfQYrVT9aHm+B0/c7c0AZWk9EARIIAcLA+5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEGegQAg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36d2a601c31so2625315f8f.0;
        Mon, 19 Aug 2024 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724082909; x=1724687709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIOAt7qcIh7yk+Ak6kXM6rwImTNnnUyR1orHAIYs4r4=;
        b=LEGegQAgR/u/Pdp8PHauHk2xrJgMCZAbSXg17MdTqhvhkGgiQdwVs+BDXZfl/oDM5M
         7zLRwRBxSRU+perNXuitonz8pw70SpMKJRela/GbT657vXPopPBF6TaDRE3l71jImLWw
         8ptBH+DdAjJhAt51xQFHL+6lfAGg6Nn07Nc6N6edT3195VpQHQVxerLHp1NSmZJIYk/E
         4UED7clX/gQXBJXE/Mhn+FHzXOEuFDseYH0Osvta3jQKkXD8OGwyn0GFTEX6Twt2Ndr4
         4NUukM3NHw2g494hm8Q+5JIbs7DzznV55WawzgRdHs7Uptw7rgWGVyqdSUWCJUvwjqtI
         9ziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724082909; x=1724687709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIOAt7qcIh7yk+Ak6kXM6rwImTNnnUyR1orHAIYs4r4=;
        b=jJbF0X1dNiYKEr0DOtmmG/c/Bb/mSFTsxpubTiPs9/tStOFpSoxMggxn0Y65ZWE363
         I0h6TsMImik1slPgI5ilvJmByTFCyzaZVQtcgMcTGBpYzwfB5dYBa1tZj62kADnP+b7n
         QoiuEV2DuCdw6/pVSXiqDvQbvjNdeCiNKug8pLqgK+ozfTQjyVPcA96IqaW1ZRuCPP/M
         mdplU9G9cd9rRxg4ISOxznjenM1YoYEz522IEFatY5qDOvMjuat4gUG1Z4mH3CpqN0Ke
         YpdNII8ForTiC2N7p58fhrfKN95QHo/MwxTynE9bljvjdP7pmXBAZLsZY3/CWaq0x9nU
         gKeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4l25kHT4WUCl1V+AytZ8wIUMhh5x1+x3sfav6L1rY62eT5RBgVQV4DmGr44Y+PfRraLvYcB09za4JFvNiiMmpjonyHb6Ne+k6/zRT5Q41q/MJR4FaXqDde8ZI9kU2ljbXACIt1HiLCFg/JNoO84ZMVS4x4PJGnrQTGyM3EWRRC4xY9OGl5YfauVn9wG4ihvulFVhtGG755rt4rS49LjAA1JiqYHkgX0aPR95FUbDNiihKDrg+cc20oGzRDQIp8Z7VrNeUQgzivr6F
X-Gm-Message-State: AOJu0YyGvTGb7qmSz1y0QmIWJEO2ASdPnMsyEEx0ynD4iX/20ceqcObh
	VxvVJ+QlzXKJD/5bxsc2t6OfHtkXMFZrpWtH0IlsJD43woSKXk2soXxxU7iIm2h9+zIYg2pI6Y+
	xLINBffQmn8Gt+Y/KB7QM0U8aVag=
X-Google-Smtp-Source: AGHT+IH+5SdMMmvczHHbCQS3d2lV+42NHIBp97s6EuIfp9v1lsrp5Tb1uRlaaTz2L+/Rjsor4cGm4qQ4+md5bQzOvmo=
X-Received: by 2002:a05:6000:1006:b0:371:8eaf:3c49 with SMTP id
 ffacd0b85a97d-371946a32a9mr7016301f8f.40.1724082909035; Mon, 19 Aug 2024
 08:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-5-linyunsheng@huawei.com> <d1a23116d054e2ebb00067227f0cffecefe33e11.camel@gmail.com>
 <676a2a15-d390-48a7-a8d7-6e491c89e200@huawei.com> <CAKgT0Uct5ptfs9ZEoe-9u-fOVz4HLf+5MS-YidKV+xELCBHKNw@mail.gmail.com>
 <3e069c81-a728-4d72-a5bb-3be00d182107@huawei.com>
In-Reply-To: <3e069c81-a728-4d72-a5bb-3be00d182107@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 19 Aug 2024 08:54:32 -0700
Message-ID: <CAKgT0UcDDFeMqD_eRe1-2Og0GEEFyNP90E9SDxDjskdgtMe0Uw@mail.gmail.com>
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

On Fri, Aug 16, 2024 at 4:55=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/8/15 23:00, Alexander Duyck wrote:
> > On Wed, Aug 14, 2024 at 8:00=E2=80=AFPM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2024/8/14 23:49, Alexander H Duyck wrote:
> >>> On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
> >>>> Currently the page_frag API is returning 'virtual address'
> >>>> or 'va' when allocing and expecting 'virtual address' or
> >>>> 'va' as input when freeing.
> >>>>
> >>>> As we are about to support new use cases that the caller
> >>>> need to deal with 'struct page' or need to deal with both
> >>>> 'va' and 'struct page'. In order to differentiate the API
> >>>> handling between 'va' and 'struct page', add '_va' suffix
> >>>> to the corresponding API mirroring the page_pool_alloc_va()
> >>>> API of the page_pool. So that callers expecting to deal with
> >>>> va, page or both va and page may call page_frag_alloc_va*,
> >>>> page_frag_alloc_pg*, or page_frag_alloc* API accordingly.
> >>>>
> >>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >>>> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
> >>>> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> >>>> Acked-by: Sagi Grimberg <sagi@grimberg.me>
> >>>> ---
> >>>>  drivers/net/ethernet/google/gve/gve_rx.c      |  4 ++--
> >>>>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  2 +-
> >>>>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
> >>>>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  2 +-
> >>>>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  4 ++--
> >>>>  .../marvell/octeontx2/nic/otx2_common.c       |  2 +-
> >>>>  drivers/net/ethernet/mediatek/mtk_wed_wo.c    |  4 ++--
> >>>>  drivers/nvme/host/tcp.c                       |  8 +++----
> >>>>  drivers/nvme/target/tcp.c                     | 22 +++++++++-------=
---
> >>>>  drivers/vhost/net.c                           |  6 ++---
> >>>>  include/linux/page_frag_cache.h               | 21 +++++++++-------=
--
> >>>>  include/linux/skbuff.h                        |  2 +-
> >>>>  kernel/bpf/cpumap.c                           |  2 +-
> >>>>  mm/page_frag_cache.c                          | 12 +++++-----
> >>>>  net/core/skbuff.c                             | 16 +++++++-------
> >>>>  net/core/xdp.c                                |  2 +-
> >>>>  net/rxrpc/txbuf.c                             | 15 +++++++------
> >>>>  net/sunrpc/svcsock.c                          |  6 ++---
> >>>>  .../selftests/mm/page_frag/page_frag_test.c   | 13 ++++++-----
> >>>>  19 files changed, 75 insertions(+), 70 deletions(-)
> >>>>
> >>>
> >>> I still say no to this patch. It is an unnecessary name change and ad=
ds
> >>> no value. If you insist on this patch I will reject the set every tim=
e.
> >>>
> >>> The fact is it is polluting the git history and just makes things
> >>> harder to maintain without adding any value as you aren't changing wh=
at
> >>> the function does and there is no need for this. In addition it just
> >>
> >> I guess I have to disagree with the above 'no need for this' part for
> >> now, as mentioned in [1]:
> >>
> >> "There are three types of API as proposed in this patchset instead of
> >> two types of API:
> >> 1. page_frag_alloc_va() returns [va].
> >> 2. page_frag_alloc_pg() returns [page, offset].
> >> 3. page_frag_alloc() returns [va] & [page, offset].
> >>
> >> You seemed to miss that we need a third naming for the type 3 API.
> >> Do you see type 3 API as a valid API? if yes, what naming are you
> >> suggesting for it? if no, why it is not a valid API?"
> >
> > I didn't. I just don't see the point in pushing out the existing API
> > to support that. In reality 2 and 3 are redundant. You probably only
> > need 3. Like I mentioned earlier you can essentially just pass a
>
> If the caller just expect [page, offset], do you expect the caller also
> type 3 API, which return both [va] and [page, offset]?
>
> I am not sure if I understand why you think 2 and 3 are redundant here?
> If you think 2 and 3 are redundant here, aren't 1 and 3 also redundant
> as the similar agrument?

The big difference is the need to return page and offset. Basically to
support returning page and offset you need to pass at least one value
as a pointer so you can store the return there.

The reason why 3 is just a redundant form of 2 is that you will
normally just be converting from a va to a page and offset so the va
should already be easily accessible.

> > page_frag via pointer to the function. With that you could also look
> > at just returning a virtual address as well if you insist on having
> > something that returns all of the above. No point in having 2 and 3 be
> > seperate functions.
>
> Let's be more specific about what are your suggestion here: which way
> is the prefer way to return the virtual address. It seems there are two
> options:
>
> 1. Return the virtual address by function returning as below:
> void *page_frag_alloc_bio(struct page_frag_cache *nc, struct bio_vec *bio=
);
>
> 2. Return the virtual address by double pointer as below:
> int page_frag_alloc_bio(struct page_frag_cache *nc, struct bio_vec *bio,
>                         void **va);

I was thinking more of option 1. Basically this is a superset of
page_frag_alloc_va that is also returning the page and offset via a
page frag. However instead of bio_vec I would be good with "struct
page_frag *" being the value passed to the function to play the role
of container. Basically the big difference between 1 and 2/3 if I am
not mistaken is the fact that for 1 you pass the size, whereas with
2/3 you are peeling off the page frag from the larger page frag cache
after the fact via a commit type action.

