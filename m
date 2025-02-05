Return-Path: <linux-kselftest+bounces-25744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 418E9A2804E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 01:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C5D1888F1E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 00:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61724227BA5;
	Wed,  5 Feb 2025 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HoGpHEWI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3A95FDA7
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Feb 2025 00:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716444; cv=none; b=ZEpLqoFBWNI/Bf6jBT9QKQJU7MEBdREQi31ACAP2ZElpHs8UI74qpzJR1ovs2T+UkWeq8s/u+K796JWTRwDemKAKUoAAtU5F3s2a3b5Kl7M/rHjAAofJaH3uLdzjdhbxGMXfFyJyNGOEwKJALHyc6exu8x07xTZOowKnyDxapMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716444; c=relaxed/simple;
	bh=f9sPyJPHfx+mJ3CCUlm+4FqDQVDGiXmeXxAHWBCRcc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMSkgzA80jXqmrOyGV8a7sUaDXzvt1aW+ZbW9hJumxGVK5iMX6DPiP1IsKjfTsIEhnYmgTYvqoCxAj2uvdpd07oaiuX8A8bKrzWkrkm+d/dM6Wp5dhWanTWD5NqXju1rr8zizcgypgPpVYbr22EgSUYKf6z9e2GpHqg/vO+/Mlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HoGpHEWI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso88225e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2025 16:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738716440; x=1739321240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9sPyJPHfx+mJ3CCUlm+4FqDQVDGiXmeXxAHWBCRcc4=;
        b=HoGpHEWIK5wpMQKxAlwbLFFsRnG4SS+Z6WgGo+XCxHzSxIGJFqjQlW3ajLcVJUvdFi
         vLGzeQVPf8m2fN7gUZPeyChz8W1yfaBsAswklIxYU9G+989tZPu/xcvMCufKqujmxF7G
         qaV+tWJzuXcloGLGMKI1srL1Q+FQUDXmehJ2t8N9SnUwp5Tpgm/c7v2GtCzePrDrYOER
         RjGCq8ZD41UAHJFOou/T4SHjmLHMFWQQwNA6bWjli7kkqaUDxmxE+qC97P3qGaLVhvE0
         pRiOqUlcgJD5D6zpQY/BRunQ3ZEisi0kf3RBT4s036ullxJZVJwiHcxFsyNyGTXzfMI0
         ZmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738716440; x=1739321240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9sPyJPHfx+mJ3CCUlm+4FqDQVDGiXmeXxAHWBCRcc4=;
        b=wFElhglRcuLsWgloALtkZl1jG638b5VuW3cvFp4UEax5tqRv4L+paFKykW+c2rBqs3
         Wey4mDCw7UGqNwB11qlqHbs8K+qF+PDxe8glWFjDDrEcVD+bFkxjhZgdn7ztSRMb/lWY
         IZmbB1cH82SSND8QK8vfOTdZ0u4MoIOmsjjpHktuhYtvhQoH5J/bY0ZfudbL+KrP0xeL
         r9kUmzfqS1cqB4U+y++KmLnOz/5hxvB9JyWA96rokBlNeVMLGGgMVQ/NPpY5NCCyKgeI
         o8tDf5tUMKwbIk33YHwVLTC5u7ulad0r9SNEjMP27yfIcGAnavhmI0NwXq5uhuWKALWO
         X72g==
X-Forwarded-Encrypted: i=1; AJvYcCWrvkaI0qoqAKH3vwWxMR9XAVhIpYwY5ubpALfmNRBNgn8JK6ZRlfik0N0jCwwx9gweHelqGlBNRVzeCXkIPgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjhndPtmAl+aXrCr86BMi9Z+kzvH9w7E/xG/s78JXU32Poegw
	b0KwwKhbsVQe/igiDP3w/30+9VE1NHElYoeukrkoyKSJU5lGZ+D97AMtosoSkfCtzaO+5KCW0u0
	xFJXDvWJeL7sBoRIexwf1L2zr6bdPPIse93QI
X-Gm-Gg: ASbGncsAF3T4TR/Au++tCdAR/GB0CkRAesmHdYo9BQ76zoCZsyts5Of7WufwzDoZuws
	Ml4NHF5ezRzKXjpQ6Wf9//nPvaDs6BjkM3vJc80oLx3MrOcAPKbDraNTySh7lCET02bLzbgQ8OA
	4FCQuDROj1N0fxe9OjX8kh0cu7qzs=
X-Google-Smtp-Source: AGHT+IGUW31PJlD3bYGpDg+C9be07H94SMBHgAtFyLNBcYtrn/UCuPjfBnxH4b74FqIdyPfbzJGcpSZUbPkSK4KZGl0=
X-Received: by 2002:a05:600c:5112:b0:436:1811:a79c with SMTP id
 5b1f17b1804b1-439075839damr1798985e9.5.1738716440349; Tue, 04 Feb 2025
 16:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com>
 <a97c4278-ea08-4693-a394-8654f1168fea@redhat.com> <CAHS8izNZrKVXSXxL3JG3BuZdho2OQZp=nhLuVCrLZjJD1R0EPg@mail.gmail.com>
 <Z6JXFRUobi-w73D0@mini-arch> <CAHS8izNXo1cQmA5GijE-UW2X1OU6irMV9FRevL5tZW3B5NQ8rA@mail.gmail.com>
 <Z6Jt62bZEeHnN1JP@mini-arch>
In-Reply-To: <Z6Jt62bZEeHnN1JP@mini-arch>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 4 Feb 2025 16:47:09 -0800
X-Gm-Features: AWEUYZkIUQ2TlE5w2LjqCY40ZGBNlBpSfqK85PLzfyPMNWV7Cff5-KExyysuV40
Message-ID: <CAAywjhTZnyLkCSQTMO1SpJrL-epJMDrWRDAb_UEnR5WuAEvtpg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 11:43=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 02/04, Mina Almasry wrote:
> > On Tue, Feb 4, 2025 at 10:06=E2=80=AFAM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> > >
> > > On 02/04, Mina Almasry wrote:
> > > > On Tue, Feb 4, 2025 at 4:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.c=
om> wrote:
> > > > >
> > > > > On 2/3/25 11:39 PM, Mina Almasry wrote:
> > > > > > The TX path had been dropped from the Device Memory TCP patch s=
eries
> > > > > > post RFCv1 [1], to make that series slightly easier to review. =
This
> > > > > > series rebases the implementation of the TX path on top of the
> > > > > > net_iov/netmem framework agreed upon and merged. The motivation=
 for
> > > > > > the feature is thoroughly described in the docs & cover letter =
of the
> > > > > > original proposal, so I don't repeat the lengthy descriptions h=
ere, but
> > > > > > they are available in [1].
> > > > > >
> > > > > > Sending this series as RFC as the winder closure is immenient. =
I plan on
> > > > > > reposting as non-RFC once the tree re-opens, addressing any fee=
dback
> > > > > > I receive in the meantime.
> > > > >
> > > > > I guess you should drop this paragraph.
> > > > >
> > > > > > Full outline on usage of the TX path is detailed in the documen=
tation
> > > > > > added in the first patch.
> > > > > >
> > > > > > Test example is available via the kselftest included in the ser=
ies as well.
> > > > > >
> > > > > > The series is relatively small, as the TX path for this feature=
 largely
> > > > > > piggybacks on the existing MSG_ZEROCOPY implementation.
> > > > >
> > > > > It looks like no additional device level support is required. Tha=
t is
> > > > > IMHO so good up to suspicious level :)
> > > > >
> > > >
> > > > It is correct no additional device level support is required. I don=
't
> > > > have any local changes to my driver to make this work. I think Stan
> > > > on-list was able to run the TX path (he commented on fixes to the t=
est
> > > > but didn't say it doesn't work :D) and one other person was able to
> > > > run it offlist.
> > >
> > > For BRCM I had shared this: https://lore.kernel.org/netdev/ZxAfWHk3aR=
Wl-F31@mini-arch/
> > > I have similar internal patch for mlx5 (will share after RX part gets
> > > in). I agree that it seems like gve_unmap_packet needs some work to b=
e more
> > > careful to not unmap NIOVs (if you were testing against gve).
> >
> > Hmm. I think you're right. We ran into a similar issue with the RX
> > path. The RX path worked 'fine' on initial merge, but it was passing
> > dmabuf dma-addrs to the dma-mapping API which Jason later called out
> > to be unsafe. The dma-mapping API calls with dmabuf dma-addrs will
> > boil down into no-ops for a lot of setups I think which is why I'm not
> > running into any issues in testing, but upon closer look, I think yes,
> > we need to make sure the driver doesn't end up passing these niov
> > dma-addrs to functions like dma_unmap_*() and dma_sync_*().
> >
> > Stan, do you run into issues (crashes/warnings/bugs) in your setup
> > when the driver tries to unmap niovs? Or did you implement these
> > changes purely for safety?
>
> I don't run into any issues with those unmaps in place, but I'm running x=
86
> with iommu bypass (and as you mention in the other thread, those
> calls are no-ops in this case).
The dma_addr from dma-buf should never enter dma_* APIs. dma-bufs
exporters have their own implementation of these ops and they could be
no-op for identity mappings or when iommu is disabled (in a VM? with
no IOMMU enabled GPA=3DIOVA). so if we really want to map/unmap/sync
these addresses the dma-buf APIs should be used to do that. Maybe some
glue with a memory provider is required for these net_iovs? I think
the safest option with these is that mappings are never unmapped
manually by driver until the dma_buf_unmap_attachment is called during
unbinding? But maybe that complicates things for io_uring?

