Return-Path: <linux-kselftest+bounces-31618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B04A9BB73
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 01:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7228E4A7DA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 23:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD1B28F93A;
	Thu, 24 Apr 2025 23:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F4rG9mX8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005528DF1C
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745538160; cv=none; b=AZZyld33nuODyugugePaOUkzcncbxZ9MDUkVAUzkk3JpCT92TiVnAM2xgFCSJwu0MhVwdpiZq07n1nD6ByAG1mESMrpxGGxv3tB+HKp0JNFUD9ICFXugDfgi99PIhirYm+UzJXE2kKhS6zuPNK4HNTRv/F2vzARgE5siw63lA6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745538160; c=relaxed/simple;
	bh=JnLUjZ/8pVQovIMrcbYwyzwtGXm36AK3037pKgerl/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q220fz0x4a6oUoPusteuVUidkynWFTuP6InGvClxl+bGTdmV4Hc0SBxSRhdx7FZpXk3BJErz7BGt2pjQpqtIlnL+wBhPfREx11zi9qJYgzT41b7TP/8wWv6Rnysmvgotead2OpIRugJWB+ileOqXQxRLYo/hLKEqhrPdCA2SDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F4rG9mX8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240aad70f2so75165ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 16:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745538157; x=1746142957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/B3OOwUKyXTs3YYPKcRuzRbYS7jgZym6Wq/lSgCbVc=;
        b=F4rG9mX8eTLyCjbHLULvDd3exXGaVDkkUciXnWPHIe7fpuSAdNQuv4Q9FcgzILG74l
         Ss4O9gVZv6FUHbmOnVlYxn1XwD7/x8GG0JEHiZQ1P5/Iok2J7Nk2Hj5WnVVlgcQij7vR
         lGdZrOSv7WkoQOGJ5KjrPXjaoksRw6rqKoAvVa9Fg+VMtVs4vfeLslXKmr+VFyOJI5HI
         iEBKjhBSQ+l7r71Z+9t5uQz9o3nzy0Z/Lod1+3j/m25S31jzUE55FaMr0KcX1EkJrxQs
         ttCnLAXUKpMS08pgkbAawbsRFNbo5iRC1Y+oaKCaPzA0a1psa1ESFdi2JrpDdpoByWNc
         OTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745538157; x=1746142957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/B3OOwUKyXTs3YYPKcRuzRbYS7jgZym6Wq/lSgCbVc=;
        b=LiqU5FTHFEcDTKgdrXVjKQAE4DWGtZqIbnrbRw1rIIyLANtEbli2jF28bCEqHxwEKv
         qrDo1iWYOTIzxVYb4BJiO0hZA12WXV/nr/x3YB3/ksd045FtW2cpYk+6RxZKay0F0sbR
         YJ2IH/SSdXt5gyBpJXv6NQrGcfGKhziQOpNzwN5ULu8dtq27Y15EGVrj7bSQWc4Wsinz
         n0r5Q5CcG2Ej7MwBtX3oxtFQaJ24et6N2M/sGmuVOL7kpI/Rfdd1IyXvmGgvEYFGq7Xe
         Y2GZdAgO0ahCG3pN3jKOnfWgW1k3jWPNKtzIix6g3cch1Sl2aIzX37VCRn0/Jv3vMlxO
         +ekA==
X-Forwarded-Encrypted: i=1; AJvYcCVkMGeZ2wpf7czJz47S+RgW6soUEBVyBsbP0DRPXCCLdoR7zmutTBwakGHdRYIZc2sCQ4mJMiCUPmWeHwBe/p0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVlv6d6OiZ2VSVlZmaw0rOvWn2+iQxL3M/56hq778k08f/e7WT
	BmEDDRJxQ1eNNUxp2ArXb9LygbBsxCWzqyWwen5pHec7q9oYNEWl6IYIfXsf30hbf5HZOFjTewb
	QOmoBjQO6anQZFAKyCBnQ3M84+k6BPIlMx/UH
X-Gm-Gg: ASbGnctgJ/ihSe6ypSilAO4NCtRZI8dPCdgqmGCZainQ6/0BhAUrZQZ8dL471nuTOo9
	gOgeswffT//4qFH6UuktWdlIXRKO3fNzE/vERvI41H2c6qhl735rm2EOyoX9SN5mqqSa27Wmlk5
	t7NPJJfLbWlX4DBSbl1fbzE3FN1yczFeF3hEBntq65ZogJMMT4TnjZ
X-Google-Smtp-Source: AGHT+IHiblyNoUcKiFVLYSWQ3t7d4ZdCJVqJZcgtW1EVQ8AgwoLNUamjuGFAQ/M0gzlmnMvKRJFosAFsbxOf3VVBa88=
X-Received: by 2002:a17:902:ec8e:b0:216:27f5:9dd7 with SMTP id
 d9443c01a7336-22dbe47ad31mr546605ad.11.1745538156942; Thu, 24 Apr 2025
 16:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423153504.1085434-1-cratiu@nvidia.com> <CAHS8izPxT_SB6+fc7dPcojv3mui3BjDZB5xmz3u6oYuA2805FA@mail.gmail.com>
 <aAlKaELj0xIbJ45c@mini-arch> <CAHS8izOm4QbHECZDB+imV2eVXs=KXRKzJsDw2gKGp_gx0ja7Ng@mail.gmail.com>
 <aAq2y_awPoGqhjdp@mini-arch> <CAHS8izNAtzyjY94qPq1-2sPUUDaN14SCXrgM5XkwCNDz4SgbvQ@mail.gmail.com>
 <aAq94Zw69XRs45T4@mini-arch>
In-Reply-To: <aAq94Zw69XRs45T4@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 24 Apr 2025 16:42:23 -0700
X-Gm-Features: ATxdqUHQ6sVTAYTEZ_YE_uYCsC_aHI6SjSAvK6P9SZkmDx7cDZoRJ5znQR08K6I
Message-ID: <CAHS8izPm_yWCRTD3ngUgDqapqiGmtpw5hhG1DFAwqwtXC-CHLA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/devmem: Reject insufficiently large dmabuf pools
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 3:40=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 04/24, Mina Almasry wrote:
> > On Thu, Apr 24, 2025 at 3:10=E2=80=AFPM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> > >
> > > On 04/24, Mina Almasry wrote:
> > > > On Wed, Apr 23, 2025 at 1:15=E2=80=AFPM Stanislav Fomichev <stfomic=
hev@gmail.com> wrote:
> > > > >
> > > > > On 04/23, Mina Almasry wrote:
> > > > > > On Wed, Apr 23, 2025 at 9:03=E2=80=AFAM Cosmin Ratiu <cratiu@nv=
idia.com> wrote:
> > > > > > >
> > > > > > > Drivers that are told to allocate RX buffers from pools of DM=
A memory
> > > > > > > should have enough memory in the pool to satisfy projected al=
location
> > > > > > > requests (a function of ring size, MTU & other parameters). I=
f there's
> > > > > > > not enough memory, RX ring refill might fail later at inconve=
nient times
> > > > > > > (e.g. during NAPI poll).
> > > > > > >
> > > > > >
> > > > > > My understanding is that if the RX ring refill fails, the drive=
r will
> > > > > > post the buffers it was able to allocate data for, and will not=
 post
> > > > > > other buffers. So it will run with a degraded performance but n=
othing
> > > > > > overly bad should happen. This should be the same behavior if t=
he
> > > > > > machine is under memory pressure.
> > > > > >
> > > > > > In general I don't know about this change. If the user wants to=
 use
> > > > > > very small dmabufs, they should be able to, without going throu=
gh
> > > > > > hoops reducing the number of rx ring slots the driver has (if i=
t
> > > > > > supports configuring that).
> > > > > >
> > > > > > I think maybe printing an error or warning that the dmabuf is t=
oo
> > > > > > small for the pool_size may be fine. But outright failing this
> > > > > > configuration? I don't think so.
> > > > > >
> > > > > > > This commit adds a check at dmabuf pool init time that compar=
es the
> > > > > > > amount of memory in the underlying chunk pool (configured by =
the user
> > > > > > > space application providing dmabuf memory) with the desired p=
ool size
> > > > > > > (previously set by the driver) and fails with an error messag=
e if chunk
> > > > > > > memory isn't enough.
> > > > > > >
> > > > > > > Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory p=
rovider")
> > > > > > > Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> > > > > > > ---
> > > > > > >  net/core/devmem.c | 11 +++++++++++
> > > > > > >  1 file changed, 11 insertions(+)
> > > > > > >
> > > > > > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > > > > > index 6e27a47d0493..651cd55ebb28 100644
> > > > > > > --- a/net/core/devmem.c
> > > > > > > +++ b/net/core/devmem.c
> > > > > > > @@ -299,6 +299,7 @@ net_devmem_bind_dmabuf(struct net_device =
*dev, unsigned int dmabuf_fd,
> > > > > > >  int mp_dmabuf_devmem_init(struct page_pool *pool)
> > > > > > >  {
> > > > > > >         struct net_devmem_dmabuf_binding *binding =3D pool->m=
p_priv;
> > > > > > > +       size_t size;
> > > > > > >
> > > > > > >         if (!binding)
> > > > > > >                 return -EINVAL;
> > > > > > > @@ -312,6 +313,16 @@ int mp_dmabuf_devmem_init(struct page_po=
ol *pool)
> > > > > > >         if (pool->p.order !=3D 0)
> > > > > > >                 return -E2BIG;
> > > > > > >
> > > > > > > +       /* Validate that the underlying dmabuf has enough mem=
ory to satisfy
> > > > > > > +        * requested pool size.
> > > > > > > +        */
> > > > > > > +       size =3D gen_pool_size(binding->chunk_pool) >> PAGE_S=
HIFT;
> > > > > > > +       if (size < pool->p.pool_size) {
> > > > > >
> > > > > > pool_size seems to be the number of ptr_ring slots in the page_=
pool,
> > > > > > not some upper or lower bound on the amount of memory the page_=
pool
> > > > > > can provide. So this check seems useless? The page_pool can sti=
ll not
> > > > > > provide this amount of memory with dmabuf (if the netmems aren'=
t being
> > > > > > recycled fast enough) or with normal memory (under memory press=
ure).
> > > > >
> > > > > I read this check more as "is there enough chunks in the binding =
to
> > > > > fully fill in the page pool". User controls the size of rx ring
> > > >
> > > > Only on drivers that support ethtool -G, and where it will let you
> > > > configure -G to what you want.
> > >
> > > gve is the minority here, any major nic (brcm/mlx/intel) supports res=
izing
> > > the rings.
> > >
> >
> > GVE supports resizing rings. Other drivers may not. Even on drivers
> > that support resizing rings. Some users may have a use case for a
> > dmabuf smaller than the minimum ring size their driver accepts.
> >
> > > > > which
> > > > > controls the size of the page pool which somewhat dictates the mi=
nimal
> > > > > size of the binding (maybe).
> > > >
> > > > See the test I ran in the other thread. Seems at least GVE is fine
> > > > with dmabuf size < ring size. I don't know what other drivers do, b=
ut
> > > > generally speaking I think specific driver limitations should not
> > > > limit what others can do with their drivers. Sure for the GPU mem
> > > > applications you're probably looking at the dmabufs are huge and
> > > > supporting small dmabufs is not a concern, but someone somewhere ma=
y
> > > > want to run with 1 MB dmabuf for some use case and if their driver =
is
> > > > fine with it, core should not prevent it, I think.
> > > >
> > > > > So it's more of a sanity check.
> > > > >
> > > > > Maybe having better defaults in ncdevmem would've been a better o=
ption? It
> > > > > allocates (16000*4096) bytes (slightly less than 64MB, why? to fi=
t into
> > > > > default /sys/module/udmabuf/parameters/size_limit_mb?) and on my =
setup
> > > > > PP wants to get 64MB at least..
> > > >
> > > > Yeah, udmabuf has a limitation that it only supports 64MB max size
> > > > last I looked.
> > >
> > > We can use /sys/module/udmabuf/parameters/size_limit_mb to allocate
> > > more than 64MB, ncdevmem can change it.
> >
> > The udmabuf limit is hardcoded, in udmabuf.c or configured on module
> > load, and ncdevmem doesn't load udmabuf. I guess it could be changed
> > to that, but currently ncdevmem works with CONFIG_UDMABUF=3Dy
>
> You don't need to load/reload the module to change module params:
>
> # id
> uid=3D0(root) gid=3D0(root) groups=3D0(root),1(bin),2(daemon),3(sys)
> # cat /sys/module/udmabuf/parameters/size_limit_mb
> 64
> # echo 128 > /sys/module/udmabuf/parameters/size_limit_mb
> # cat /sys/module/udmabuf/parameters/size_limit_mb
> 128
>

Today I learned! Thanks!

I will put it on my todo list to make ncdevmem force a larger limit to
udmabuf and allocate a larger dmabuf by default. Technically any
dmabuf should be supported, but by default I think probably ncdevmem
should use a .5 GB -> 1GB dmabuf that is more common for these GPU
applications or something. There could be an option as well for folks
to test their driver against smaller dmabufs.

--=20
Thanks,
Mina

