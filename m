Return-Path: <linux-kselftest+bounces-25310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAC0A20C48
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 15:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4190B1889CB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 14:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9381AAA0F;
	Tue, 28 Jan 2025 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv/2KVbG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C7F9F8;
	Tue, 28 Jan 2025 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738075804; cv=none; b=aw9NuPdEeY//r4s0DwUBUcIFUXOHR18kLerRWd2qQPWHMLKcKF3nvT6J0yUbv9XaTGEw77S6E5pSMWUnlqtaKsMPvhqVZF8Rn2kgEjm//m/d4muvK8fY69XKBd9waajQfxgmuarggvCNeUDViVG8Jtdo+ILWpyH7EYT7ZpI7Auk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738075804; c=relaxed/simple;
	bh=8IpvaS1zfcVdWjXbEe4QmGoiJaTdnB3V6B3WOb2GQHs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tbEay3yn5nINFhWij7BeSiygJvpSs8wvbss4bL0D2ttfnsZhFroxbUU5X/KWNFVtS94slaRX2CW6rrqTCYQNjc1r36F5q0lJP862ghMtVCWpoIhBQuyLiF2tPyZglsMLbJw4DyqeVTEI/DFEPpGS1+5QPv4Glu1gn89RtbCi0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lv/2KVbG; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-51619b06a1cso3402336e0c.3;
        Tue, 28 Jan 2025 06:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738075801; x=1738680601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zb99191K64oonEm8sGz6Xg9hMLlXiUhPwruyb9S25aU=;
        b=lv/2KVbGrwuZHgAiPcRE8H+1CjngLvPNTTskJwK23Jh2AAWAJOcu54HJe+k7c+DofU
         CwY1UjDG0PVOr+d6isYLPAZDknLFklvXzOPXbB+WUBbpV801PD3AbyYkl3A1m1el+mik
         A0jPzdNiscP8UZGafkJUPttF0vR6DxDjyLmO54kuzzQI8/7OUf1DGpQlOZwQabFLNne5
         CT/4gFj9Dd3vb/eiGgcPUyuXuasXT7gxpoobrEO7+rtiIXEUpC1R5s3c4v+6MHvAM5tw
         EH8l3WLa6+mK1sm6+nhZtcYYCyDquX/AUQ9J3oyO0WEMmvm6+hFxdaW/Aq3d/xZjnoKF
         GzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738075801; x=1738680601;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zb99191K64oonEm8sGz6Xg9hMLlXiUhPwruyb9S25aU=;
        b=vay6R+zqy8nfeXPjd1I0yLmegcI9QfqskOWqIPlQGC1CVe3yu7nTuoyN/3+o7NaSUt
         cixvJgtmMyDjtIAiR0SArpsNJNF30e8EsHiQ0nUNdhfL03Zd8D4HnRG1E8kwNVBiHBba
         QquZ0hwDjKNbWVOlvogxtu9krlZsbugurNyLOhwbXWDbYKlV8+ksXOt0y8tYLWU2DRuC
         RI8OKml+E4EP4x+AKhhcyOZJMRvVOPfN65+sAaEQndHoMpUGFgd8CESGX80l2leruThu
         CnuXZT8H3PJ2iziRTHzES1oSJ6bkuMNRFQBKz/tMMSrLd8uytR7KS7DCWjofXxa0pp80
         liUg==
X-Forwarded-Encrypted: i=1; AJvYcCW+4uGqwT1rruM2Shzmyb/uyXLAFrLe+vnVFfPC9DOTR+gwgxcP0azQ1nRYm9CrWiX7qLQRX+sHERBF@vger.kernel.org, AJvYcCXI5jecCS0BIABjbwXK2KmKZc8osH3SKQNZrsiofzt3jo6xbI8sur7L7722hgVbPcRfXA4=@vger.kernel.org, AJvYcCXUTdrddnV8iZZWZVFaUyFEfu6nxJcnoVUj48f/a8dlHJE/R8kg7HjlhOlrCHA/WKTR03PhfLmRW/CKn2KZ@vger.kernel.org, AJvYcCXcaFoRNmupxJARXXkBOFOo+jbyYriQt3loH/2IG3neIq+h9Zdnj/KNKDNNMYD0UrBTds583bLrdtKDr+iR/ZrL@vger.kernel.org
X-Gm-Message-State: AOJu0YwQhJLxubRbrE9ACE+j45n31jfsi4jruU7/WRYkz7CTP1AE2bzb
	Ro7oCNXqUbOIp3ftl8ruutc3PimDC3GQLt8344xYGL4V1q/JUf/bXDK/dw==
X-Gm-Gg: ASbGnct6eI86QQzpFMLFp4MNVcFY9J0unsnH8j4M9sWFos2P+FVVcn/Y9nN3FCZCWrK
	BadKJK0ykTcjeKny11smcJCz4UlLwEQjhyaM5mIG4xE/QvQFfpecGv6KpE+u35/dE8s/mDXayOA
	wcB6pG2xMrtTSrBq6X/VDPEs/1AzSCa+LgTJ6DR3XkAMJl+WendzaHw8ESliGYYZiskDBQBLVDE
	AZYE/ypxRBbX/glthnk7WcRV/snOX1t8UJcJ5T+Aew5c3GNLanM0ZeG7k6mP/zuyWECX7DrzEwP
	U7DoV1fvE2msffkkNsYvVj652VrSTvra0ibSa8BdvWc51908nkzUq236zmeOKtk=
X-Google-Smtp-Source: AGHT+IHW31CLAfaZZ/6noX+17+d4mKCF+2r2fMRxUk8GJnrrJeBabGTvUIlBo05ZEujchzkiLC6htg==
X-Received: by 2002:a05:6122:1698:b0:518:91b3:5e37 with SMTP id 71dfb90a1353d-51d5b26bbafmr36947933e0c.5.1738075801328;
        Tue, 28 Jan 2025 06:50:01 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51e4ea71de3sm1791758e0c.12.2025.01.28.06.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 06:50:00 -0800 (PST)
Date: Tue, 28 Jan 2025 09:49:59 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 David Ahern <dsahern@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Joe Damato <jdamato@fastly.com>, 
 dw@davidwei.uk
Message-ID: <6798ee97c73e1_987d9294d6@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAHS8izNzbEi_Dn+hDohF9Go=et7kts-BnmEpq=Znpot7o7B5wA@mail.gmail.com>
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-6-almasrymina@google.com>
 <676dd022d1388_1d346b2947@willemb.c.googlers.com.notmuch>
 <CAHS8izNzbEi_Dn+hDohF9Go=et7kts-BnmEpq=Znpot7o7B5wA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v1 5/5] net: devmem: Implement TX path
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > > +struct net_devmem_dmabuf_binding *
> > > +net_devmem_get_sockc_binding(struct sock *sk, struct sockcm_cookie *sockc)
> > > +{
> > > +     struct net_devmem_dmabuf_binding *binding;
> > > +     int err = 0;
> > > +
> > > +     binding = net_devmem_lookup_dmabuf(sockc->dmabuf_id);
> >
> > This lookup is from global xarray net_devmem_dmabuf_bindings.
> >
> > Is there a check that the socket is sending out through the device
> > to which this dmabuf was bound with netlink? Should there be?
> > (e.g., SO_BINDTODEVICE).
> >
> 
> Yes, I think it may be an issue if the user triggers a send from a
> different netdevice, because indeed when we bind a dmabuf we bind it
> to a specific netdevice.
> 
> One option is as you say to require TX sockets to be bound and to
> check that we're bound to the correct netdev. I also wonder if I can
> make this work without SO_BINDTODEVICE, by querying the netdev the
> sock is currently trying to send out on and doing a check in the
> tcp_sendmsg. I'm not sure if this is possible but I'll give it a look.

I was a bit quick on mentioning SO_BINDTODEVICE. Agreed that it is
vastly preferable to not require that, but infer the device from
the connected TCP sock.


