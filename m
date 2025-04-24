Return-Path: <linux-kselftest+bounces-31603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E65A6A9B973
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 22:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04537B203E
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 20:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08522580E7;
	Thu, 24 Apr 2025 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vu36O2/T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5E71F583A
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745528257; cv=none; b=ZMr0tbxWmGbZylw7rztKz+X1kQWF5JkZdmlA4fROi9zhO4Zj2MJYs2bA0ZJ2/MQuWAfH+5iFHdU0CLjsFWH43KkEo97IZ8fQxdQ4EBt+LzxqlM5fBfQt/frHW6DjMcJRg+DaGdI0uD2sUHzPHwgwrdSQTb4rCA0jSul1b2bqBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745528257; c=relaxed/simple;
	bh=69Zl1Q9Y/ulDN1OiSHLjO7STbweGZk6xpTGDwtmmH6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMViNhLBaOqjRreIpyOKlsMUlTOAc+FaycsZPEBvxzPZD9WJgjek7Nl/edoeiuqgQDBqWLrDoakoUNs7qI5gST/h0k9H/l5BVMVnQKW4yNw8niobgeg70hVhSRU7q0rDRtLhN+HRa6zwLEMOKp/LlO8ND0HEOY7+1GLChA4Kt24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vu36O2/T; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2264c9d0295so46905ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 13:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745528255; x=1746133055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVnR30CoW6pRa2/4n0Y/Q1aA7ucltJSZ6Z66DHuDv5I=;
        b=vu36O2/Tm6cQndQdHG8/fra8V61KLyqXQThvdJqdqrJpZGqdRiFDbAA2BPeg2ETc4/
         +8QURryzQtO+l7fcar4YzeivkEdrT9A87GXw1+p564IMlxCO+sd8/SgrSK1WYBnuY/5m
         b9pnkASZNIEz3cIKdWfIw+gIrLKyn0PaZnWUhHpQNkGAB0Vy+E3S3cmDPHSUwc1+dK2q
         XHndbmFxQ4bOabDCWIovYknoPAzm1qy9HzyX82nNF4SSVYNT5ArDCi95EJkUkqGzh9TQ
         qRfYqtYK9UwwQxfj58yMgjggWonva5n3tLtPk3tmAnUlyiJjgqCAy367bEDyjS8mBDBU
         E6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745528255; x=1746133055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVnR30CoW6pRa2/4n0Y/Q1aA7ucltJSZ6Z66DHuDv5I=;
        b=J9DLNvzhp0N3C3gaiwGGpEhZxZoAW9+Ogmx0+IKvTMhpPI51yNqQLxW1L3/zW+Qx4g
         vShWcNZ9SCDIL95mGzvoFAJIQQRa0HTp3ncoDSYzVPMxTklb+UlbdFnXLpZwwtzj2C1H
         9Prp9Nxftm/M/BrFJeb54C85gCUEVFcTns8cgiYV4C8x44GuXpjRJZgD893lH4kOl9IQ
         bCVK/OucTW0fg3bqbH/QrbwzXLpN7Rk+PgPBY4I2Y3r0UsRzeKsi3wrhr6FcshmLuqPF
         GLg+pIEAyqA125Vx9ePSjMaHgmz7KQvNfBm3ejaTpDpb/ovN44LE2I0UejVdA22Cr7E0
         lMWA==
X-Forwarded-Encrypted: i=1; AJvYcCVnMWADMVKL6/zgzO+dXfETNE8VVsf6jzMmZVtwHY7erQGGinE3WvELtjV5YkywDBveL6KiaxRRb5KlxSMpTIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0wuRILLv352Gu3Ds2SeACnlLfMOX7NRDy4QMzDYUsSlCEOcPp
	+D5I8vsC+B1wcdzpB2Z6kLRBtffZllYjRCgeyjns/2NYc6m8CCyTNkRmAX1CkxSIOdA86LV8rZz
	ymvv9LsMftNlw80yTEEkpkA1TkxGgoDwxH9aN
X-Gm-Gg: ASbGncvXT+qtCPyA0KHDFNg+W/bFvQ6w2V2q3tCmUpQKVmrAqXFPQ6qXF1iov+b3Mx3
	z5ULnjSNF7BA+WI3sdZEXXG5Fn44qu0H/D9nTKYK5g6M5FCXYpo2E9z6QWF5PHjKA+Dfog/OLs0
	lzHeInSKKefyLM2VJt3jGgdUCBWciMxlp+SdpHmc71oKW52fYK1CP4
X-Google-Smtp-Source: AGHT+IHvwGTnXWEouc+aQrROZ+mNQ/bMS9Tbe3AjHlQ32xBvI3gUczDHvV09gYKEVvcLaka+I4ldvUmYIY4Aeaq6HYY=
X-Received: by 2002:a17:903:3c47:b0:21f:3e29:9cd4 with SMTP id
 d9443c01a7336-22dbda861cdmr686195ad.20.1745528255070; Thu, 24 Apr 2025
 13:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423153504.1085434-1-cratiu@nvidia.com> <CAHS8izPxT_SB6+fc7dPcojv3mui3BjDZB5xmz3u6oYuA2805FA@mail.gmail.com>
 <aAlKaELj0xIbJ45c@mini-arch>
In-Reply-To: <aAlKaELj0xIbJ45c@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 24 Apr 2025 13:57:22 -0700
X-Gm-Features: ATxdqUFpuA1oI86A_55BG3HYyIRY20mi4m88DNRxjvSDThCfzcctNktY6unjCfg
Message-ID: <CAHS8izOm4QbHECZDB+imV2eVXs=KXRKzJsDw2gKGp_gx0ja7Ng@mail.gmail.com>
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

On Wed, Apr 23, 2025 at 1:15=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 04/23, Mina Almasry wrote:
> > On Wed, Apr 23, 2025 at 9:03=E2=80=AFAM Cosmin Ratiu <cratiu@nvidia.com=
> wrote:
> > >
> > > Drivers that are told to allocate RX buffers from pools of DMA memory
> > > should have enough memory in the pool to satisfy projected allocation
> > > requests (a function of ring size, MTU & other parameters). If there'=
s
> > > not enough memory, RX ring refill might fail later at inconvenient ti=
mes
> > > (e.g. during NAPI poll).
> > >
> >
> > My understanding is that if the RX ring refill fails, the driver will
> > post the buffers it was able to allocate data for, and will not post
> > other buffers. So it will run with a degraded performance but nothing
> > overly bad should happen. This should be the same behavior if the
> > machine is under memory pressure.
> >
> > In general I don't know about this change. If the user wants to use
> > very small dmabufs, they should be able to, without going through
> > hoops reducing the number of rx ring slots the driver has (if it
> > supports configuring that).
> >
> > I think maybe printing an error or warning that the dmabuf is too
> > small for the pool_size may be fine. But outright failing this
> > configuration? I don't think so.
> >
> > > This commit adds a check at dmabuf pool init time that compares the
> > > amount of memory in the underlying chunk pool (configured by the user
> > > space application providing dmabuf memory) with the desired pool size
> > > (previously set by the driver) and fails with an error message if chu=
nk
> > > memory isn't enough.
> > >
> > > Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider"=
)
> > > Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> > > ---
> > >  net/core/devmem.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > index 6e27a47d0493..651cd55ebb28 100644
> > > --- a/net/core/devmem.c
> > > +++ b/net/core/devmem.c
> > > @@ -299,6 +299,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, un=
signed int dmabuf_fd,
> > >  int mp_dmabuf_devmem_init(struct page_pool *pool)
> > >  {
> > >         struct net_devmem_dmabuf_binding *binding =3D pool->mp_priv;
> > > +       size_t size;
> > >
> > >         if (!binding)
> > >                 return -EINVAL;
> > > @@ -312,6 +313,16 @@ int mp_dmabuf_devmem_init(struct page_pool *pool=
)
> > >         if (pool->p.order !=3D 0)
> > >                 return -E2BIG;
> > >
> > > +       /* Validate that the underlying dmabuf has enough memory to s=
atisfy
> > > +        * requested pool size.
> > > +        */
> > > +       size =3D gen_pool_size(binding->chunk_pool) >> PAGE_SHIFT;
> > > +       if (size < pool->p.pool_size) {
> >
> > pool_size seems to be the number of ptr_ring slots in the page_pool,
> > not some upper or lower bound on the amount of memory the page_pool
> > can provide. So this check seems useless? The page_pool can still not
> > provide this amount of memory with dmabuf (if the netmems aren't being
> > recycled fast enough) or with normal memory (under memory pressure).
>
> I read this check more as "is there enough chunks in the binding to
> fully fill in the page pool". User controls the size of rx ring

Only on drivers that support ethtool -G, and where it will let you
configure -G to what you want.

> which
> controls the size of the page pool which somewhat dictates the minimal
> size of the binding (maybe).

See the test I ran in the other thread. Seems at least GVE is fine
with dmabuf size < ring size. I don't know what other drivers do, but
generally speaking I think specific driver limitations should not
limit what others can do with their drivers. Sure for the GPU mem
applications you're probably looking at the dmabufs are huge and
supporting small dmabufs is not a concern, but someone somewhere may
want to run with 1 MB dmabuf for some use case and if their driver is
fine with it, core should not prevent it, I think.

> So it's more of a sanity check.
>
> Maybe having better defaults in ncdevmem would've been a better option? I=
t
> allocates (16000*4096) bytes (slightly less than 64MB, why? to fit into
> default /sys/module/udmabuf/parameters/size_limit_mb?) and on my setup
> PP wants to get 64MB at least..

Yeah, udmabuf has a limitation that it only supports 64MB max size
last I looked.

I added devmem TCP support with udmabuf selftests to demonstrate that
the feature is non-proprietary, not to advertise that devmem tcp +
udmabuf is a great combination. udmabuf is actually terrible for
devmem TCP. The 64MB limit is way too small for anyone to do anything
performant on it and by dmaing into host memory you lose many of the
benefits of devmem TCP (lower mem bw + pcie bw utilization).

If you're running real experiments with devmem TCP I suggest moving to
real dmabufs as soon as possible, or at least hack udmabuf to give you
large sizes. We've open sourced our production devmem TCP userspace:

https://github.com/google/tcpgpudmarxd
https://github.com/google/nccl-plugin-gpudirecttcpx

Porting it to upstream APIs + your dmabuf provider will have you run
much more interesting tests than anything you do with udmabuf I think,
unless you hack the udmabuf size.

--=20
Thanks,
Mina

