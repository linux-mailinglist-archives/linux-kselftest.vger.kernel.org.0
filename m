Return-Path: <linux-kselftest+bounces-15779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5723D958BDD
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 18:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD951C22283
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 16:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9663B1917CC;
	Tue, 20 Aug 2024 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUVVTAWx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A67C18E345;
	Tue, 20 Aug 2024 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169819; cv=none; b=qIC0WMYAwQ/l9xIpITp+kjeDo9QVf+B8+Q3f9X9acrMJsPGvjHGwb+8nHfuhgpDwCB3z42L9mnxNADZeN3DXFGV/v6YNsnXmoEkWaLrciA2KRuQ5RjK8KLqqPHfjfXLRYI0iBLhnNNHGvH+4Byy+7/kEvwWnDsgExqdHmbuCtRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169819; c=relaxed/simple;
	bh=/yVBXopS+OUoveXJwCqPSrKAl3/0x4KkcAgmVdW7mKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1boH60aqKtrYk54zJKtKaPQXYDtgf5Z0YZ/QmTFrJ4vQYsuO9Goz9caYXnKM+AbtL11vPczBF3EHzjGNUl9P6yrEqu8Yr2x3T8Oxc1zIAgatkzspL6Sk90DePJ6RWUPpT1N0BByF+Qxr4awBF5JJa/ovkxjsa1z7lcE2tk/dz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUVVTAWx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso45097165e9.0;
        Tue, 20 Aug 2024 09:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724169815; x=1724774615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACxpErlOvFQuBRokph/wthh0GeLIFddWl+sG+UC+KHk=;
        b=bUVVTAWx40Mv6IaxidDVXvH7zPZ7BoYKNK28kFEutRWcx2CcbdQFTPY6r4yEaEjls8
         8oyY7P9A52pVxMPODFFI7xE8ZqaS5v1k44jRf8IhLGo4Ey/oN1IgUUwEe3IrF+vHq1eG
         Tsix5kwh4mG/39ts/jGhS0CoOaYqUFrWuHUWxS3QoHQU4ltd1qX2vzINnZABXu2Q1cXV
         0wQYFd6lUEC/WO5vZQYOjaIf9Yl0HjnqBd2gtngEpNi826V+Be3WLL1QyDPJOIRoCcOn
         XT1FcQqhvEKgexzXoIPJ1FJzBDbKtC3XEzx12T3+DsYscBo+AWgoPMgKN2PCxJakddar
         Ihmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724169815; x=1724774615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACxpErlOvFQuBRokph/wthh0GeLIFddWl+sG+UC+KHk=;
        b=pr+9qjcl+aiZ/jlV5eiqSLyXw36vDDE6Iw41tCf8SDAIY5jb/uf8P1vwlACZjbwjYU
         M1UeyM0r9ncdWMVZiAHx7okBIt2ZxGPrWJHiqAy9JBPhrEkWKU8EnTnlSaR/aFMxoo76
         Q7rf95wdkEjAzHoQh9zlFiJp6ks27R4JaHhlZgN4ErHRmdLxBDqQDXk4R6XSdMSYI+E0
         HxjaiUSYmD0klKBFNRZwAZvqidE8ReWWImOXwuH3cPehGkdFz3IQ/3Bq9oT9b2/jVZKd
         tzHuyZLPX/78vEV3ngefRfe0RrmGXakMjqSm8RRZ1hvqbY/bvJb3AfuU3wbi1avY6gey
         I/cA==
X-Forwarded-Encrypted: i=1; AJvYcCU+w3n5zX/f6R5XV2CLmI0TFBadErFpoG+T+H3GpbpgAtNJVGbuGAAtfFZ9E5VHEa/MvF6M@vger.kernel.org, AJvYcCUCHTmhGlZh6mB3x6b/kea7tU7I/001wLTnWCTFMwrlt1xNHL18HZriK7kx00ICKMRnS2BrCptK6NdH@vger.kernel.org, AJvYcCUq+NOA2n5ddhIdZVpKUNnrmZD4dUGDew5Z4rHLWfuvEyBnwfadGOPukSDGBRvvGeff6doZIaqUhAm2oCB1@vger.kernel.org, AJvYcCVx7nLvqwgM3Ana8UVH3/dSTDIZt5S0pNHX2zLqy3T74zXOnJPubd8kK/essb7VoAVfyg2cgczfFxFEihHrv0pR@vger.kernel.org, AJvYcCXfspOtmYCmK4IoXLjKCByhpGj6BAq237FeeeNYiNqpBY/nHmRo6sRpo83zehYcxq/VUf0=@vger.kernel.org, AJvYcCXqe6LgucCycm0cver+6RD0oaF/zrQzwuY0tTKs7y+IQ6Ky27QrU4Tsfp+b09CFNRr1qV/Eb8Fd@vger.kernel.org
X-Gm-Message-State: AOJu0YymyFkgnA0iu1XWZzAiJ/cK+ud2qmKQnX05QJvWGJERZ4U5fb5z
	jP+jj0fh2WkiGuFGIPb6mHDtmMaqxE8ZA8FqVg8bD+req+HOp1Xp4npyPkgNXAdDrex0eRz+2cz
	QpmptqtGSvHuHIyGdlBR1vQ/RqeM=
X-Google-Smtp-Source: AGHT+IF4DoS60WZqDqVaq8Y/5SjjI7zscaIxzpj60ezQwLm3viTYLpGZpmD+jTekneRZUAoDJMoW7JwgYwWaXYZHKdQ=
X-Received: by 2002:adf:f285:0:b0:371:888d:7aaa with SMTP id
 ffacd0b85a97d-371946b1ae9mr9087932f8f.49.1724169814881; Tue, 20 Aug 2024
 09:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-5-linyunsheng@huawei.com> <d1a23116d054e2ebb00067227f0cffecefe33e11.camel@gmail.com>
 <676a2a15-d390-48a7-a8d7-6e491c89e200@huawei.com> <CAKgT0Uct5ptfs9ZEoe-9u-fOVz4HLf+5MS-YidKV+xELCBHKNw@mail.gmail.com>
 <3e069c81-a728-4d72-a5bb-3be00d182107@huawei.com> <CAKgT0UcDDFeMqD_eRe1-2Og0GEEFyNP90E9SDxDjskdgtMe0Uw@mail.gmail.com>
 <98ceade3-8d60-45bf-a419-ff3982a96101@huawei.com>
In-Reply-To: <98ceade3-8d60-45bf-a419-ff3982a96101@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 20 Aug 2024 09:02:57 -0700
Message-ID: <CAKgT0Uc+e3MUb4CK1i7H7F=y-fHTxiGF8zddBFiqFRdbd6ofLg@mail.gmail.com>
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

On Tue, Aug 20, 2024 at 6:07=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/8/19 23:54, Alexander Duyck wrote:
>
> ...
>
> >>>>
> >>>> "There are three types of API as proposed in this patchset instead o=
f
> >>>> two types of API:
> >>>> 1. page_frag_alloc_va() returns [va].
> >>>> 2. page_frag_alloc_pg() returns [page, offset].
> >>>> 3. page_frag_alloc() returns [va] & [page, offset].
> >>>>
> >>>> You seemed to miss that we need a third naming for the type 3 API.
> >>>> Do you see type 3 API as a valid API? if yes, what naming are you
> >>>> suggesting for it? if no, why it is not a valid API?"
> >>>
> >>> I didn't. I just don't see the point in pushing out the existing API
> >>> to support that. In reality 2 and 3 are redundant. You probably only
> >>> need 3. Like I mentioned earlier you can essentially just pass a
> >>
> >> If the caller just expect [page, offset], do you expect the caller als=
o
> >> type 3 API, which return both [va] and [page, offset]?
> >>
> >> I am not sure if I understand why you think 2 and 3 are redundant here=
?
> >> If you think 2 and 3 are redundant here, aren't 1 and 3 also redundant
> >> as the similar agrument?
> >
> > The big difference is the need to return page and offset. Basically to
> > support returning page and offset you need to pass at least one value
> > as a pointer so you can store the return there.
> >
> > The reason why 3 is just a redundant form of 2 is that you will
> > normally just be converting from a va to a page and offset so the va
> > should already be easily accessible.
>
> I am assuming that by 'easily accessible', you meant the 'va' can be
> calculated as below, right?
>
> va =3D encoded_page_address(encoded_va) +
>                 (page_frag_cache_page_size(encoded_va) - remaining);
>
> I guess it is easily accessible, but it is not without some overhead
> to calculate the 'va' here.

It is just the encoded_page_address + offset that you have to
calculate anyway. So the only bit you actually have to do is 2
instructions, one to mask the encoded_va and then the addition of the
offset that you provided to the page. As it stands those instruction
can easily be slipped in while you are working on converting the va to
a page.


> >
> >>> page_frag via pointer to the function. With that you could also look
> >>> at just returning a virtual address as well if you insist on having
> >>> something that returns all of the above. No point in having 2 and 3 b=
e
> >>> seperate functions.
> >>
> >> Let's be more specific about what are your suggestion here: which way
> >> is the prefer way to return the virtual address. It seems there are tw=
o
> >> options:
> >>
> >> 1. Return the virtual address by function returning as below:
> >> void *page_frag_alloc_bio(struct page_frag_cache *nc, struct bio_vec *=
bio);
> >>
> >> 2. Return the virtual address by double pointer as below:
> >> int page_frag_alloc_bio(struct page_frag_cache *nc, struct bio_vec *bi=
o,
> >>                         void **va);
> >
> > I was thinking more of option 1. Basically this is a superset of
> > page_frag_alloc_va that is also returning the page and offset via a
> > page frag. However instead of bio_vec I would be good with "struct
> > page_frag *" being the value passed to the function to play the role
> > of container. Basically the big difference between 1 and 2/3 if I am
> > not mistaken is the fact that for 1 you pass the size, whereas with
> > 2/3 you are peeling off the page frag from the larger page frag cache
>
> Let's be clear here: The callers just expecting [page, offset] also need
> to call type 3 API, which return both [va] and [page, offset]? and it
> is ok to ignore the overhead of calculating the 'va' for those kinds
> of callers just because we don't want to do the renaming for a existing
> API and can't come up with good naming for that?
>
> > after the fact via a commit type action.
>
> Just be clear here, there is no commit type action for some subtype of
> type 2/3 API.
>
> For example, for type 2 API in this patchset, it has below subtypes:
>
> subtype 1: it does not need a commit type action, it just return
>            [page, offset] instead of page_frag_alloc_va() returning [va],
>            and it does not return the allocated fragsz back to the caller
>            as page_frag_alloc_va() does not too:
> struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
>                                 unsigned int *offset, unsigned int fragsz=
,
>                                 gfp_t gfp)
>
> subtype 2: it does need a commit type action, and @fragsz is returned to
>            the caller and caller used that to commit how much fragsz to
>            commit.
> struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
>                                         unsigned int *offset,
>                                         unsigned int *fragsz, gfp_t gfp)
>
> Do you see subtype 1 as valid API? If no, why?

Not really, it is just a wrapper for page_frag_alloc that is
converting the virtual address to a page and offset. They are the same
data and don't justify the need for two functions. It kind of explains
one of the complaints I had about this code. Supposedly it was
refactoring and combining several different callers into one, but what
it is actually doing is fracturing the code path into 3 different
variants based on little if any actual difference as it is doing
unnecessary optimization.

> If yes, do you also expect the caller to use "struct page_frag *" as the
> container? If yes, what is the caller expected to do with the size field =
in
> "struct page_frag *" from API perspective? Just ignore it?

It should be populated. You passed a fragsz, so you should populate
the output fragsz so you can get the truesize in the case of network
packets. The removal of the page_frag from the other callers is making
it much harder to review your code anyway. If we keep the page_frag
there it should reduce the amount of change needed when you replace
page_frag with the page_frag_cache.

Honestly this is eating up too much of my time. As I said before this
patch set is too big and it is trying to squeeze in more than it
really should for a single patch set to be reviewable. Going forward
please split up the patch set as I had suggested before and address my
comments. Ideally you would have your first patch just be some
refactor and cleanup to get the "offset" pointer moving in the
direction you want. With that we can at least get half of this set
digested before we start chewing into all this refactor for the
replacement of page_frag with the page_frag_cache.

