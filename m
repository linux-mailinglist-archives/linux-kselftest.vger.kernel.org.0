Return-Path: <linux-kselftest+bounces-15046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0091C94C5D0
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 22:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4C42826EC
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 20:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E0015A876;
	Thu,  8 Aug 2024 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x6SGk8qM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C868158875
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Aug 2024 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723149400; cv=none; b=RdSrEHeg1zqfsm7F7mH294tMBosSyVXtT9CvrkXdob3QBxxcH6/toLKj8URcO2+/SSRsGXO1/11J2KI4544MQXGyrdskZuRtdW2q6wy+d5qR4+VE8e/X6QCAeJtFFnqc8K6RWDLuul4brsre0iE6XcJaa8hBuEvKVfGv7ZwYVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723149400; c=relaxed/simple;
	bh=AQWn/xnnEHnNvSM4lorxKMv1lH4nZlJoO1CrXZ0ujvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0PAx6hVMAn1nSiwFOGs69OARrGuScKzM+L7ltAtNAoMj/xwS9Fnyafq1JW7sfb9qMUkvrUao8379nWU+DTzisJW9Sk+fQm0fD2Cm+m1ZLYSTQclvOnqRHfjTJQYjUIZExt0sazqxXDx6ORLZ2MgZ+SukJLUcKynDRIp1aEbTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x6SGk8qM; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1da036d35so87432385a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Aug 2024 13:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723149396; x=1723754196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOI5LTLx9cXrWhuBdvZp6mpixN3oVmTyWbuUGECDTYI=;
        b=x6SGk8qM4ol3KzlyM19lvutubfSozSymkojAosXvy2p7iEi/57f0fmxcY/V2rjJojd
         8sjm146NzZgAZnrP3T4MViYjDkLXS6of4u+0sC9HI3Jb0KTyr2D0/pHWeIQjn7A8OUPY
         8I5QJrvrQmL91A0MDm+K5tx/sep46NirIcHlLpp3rvmiDkBxsnj29LJkDErtCXuiEBs2
         zVTDcCYAW/P68np5jn3+cU6G8YAWpIDWElfiZJKjj1iYwq+tCGJ/uDPFCZqLWXupMUxY
         Hg/rYQ7JP6RwqNow96vW51hAXYdUjYzVRQdDgMGKiSDXlCllFOtshZNnQxD4y4rb+pvp
         9UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723149396; x=1723754196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOI5LTLx9cXrWhuBdvZp6mpixN3oVmTyWbuUGECDTYI=;
        b=bzIgXqdX2gxgaVjv1EC91wCs4+MVRijkkQF9iztk9YjTrfzxL3LPldUfrinzhpFGSD
         WTRpMyWVtzfsCF5CSJ+yQCxersTGiUINXtQFwLmxiGfLY3hOW/KLHpPekKRbQIKPM8Kw
         XT43UaOlXq4NocWewx7CpokBaBT4fcDrftY9Ykjn5IJB/uGrRfsXFjJJ3TgYcWhS/PqY
         F28GzrETKyuT0IeQ8oDw71uM8OjLOn26JKaY5kZj066etfse5dyhR11iLwch5+C+GVyR
         Rz6RfdoUK6rAmlFDxfmwAGUXmlgpvdLxK0oZfVak648QXqWUXBADHUlSkuIOlimGHlj7
         1+Yg==
X-Forwarded-Encrypted: i=1; AJvYcCV4b9QtWZRV4rJ9yNZrMbL8mlfGy8hVD/Q/tZ6HVMc1mwhHKriBGLgewdJhjrJUokg0JwX5VisBxbwm5LsQLuOkYO+AiEjIFF0X2dlwn42w
X-Gm-Message-State: AOJu0YyH6FVhxOMVeWlBSqYljLQITtzcEPXz5C3GP3kv+qthUdn3PbBz
	tmH6I7uKVKuNBpQxmZyjc0GN+8ejHL2Fbfmmw7d6do5dXMi+j78f4S9FSBUxhAlvllTBYYn2i1n
	8JfoEMNefsvr5/0ezL5I0Xi4gHZoVUjeZSEYs
X-Google-Smtp-Source: AGHT+IGEd8MEPPIzKesyVrhvbUxEPsn7+b9jVtjwHdEDzmwadpVOXKjz66694N5xOc7FFo6QD61TV8emUgJPi2VIqag=
X-Received: by 2002:a05:6214:498e:b0:6b7:b4b1:85ae with SMTP id
 6a1803df08f44-6bd6bd7f455mr38124966d6.54.1723149396123; Thu, 08 Aug 2024
 13:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805212536.2172174-1-almasrymina@google.com>
 <20240805212536.2172174-8-almasrymina@google.com> <20240806135924.5bb65ec7@kernel.org>
In-Reply-To: <20240806135924.5bb65ec7@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 8 Aug 2024 16:36:24 -0400
Message-ID: <CAHS8izOA80dxpB9rzOwv7Oe_1w4A7vo5S3c3=uCES8TSnjyzpg@mail.gmail.com>
Subject: Re: [PATCH net-next v18 07/14] memory-provider: dmabuf devmem memory provider
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 4:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
...
> On Mon,  5 Aug 2024 21:25:20 +0000 Mina Almasry wrote:
> > +     if (pool->p.queue) {
> > +             /* We rely on rtnl_lock()ing to make sure netdev_rx_queue
> > +              * configuration doesn't change while we're initializing =
the
> > +              * page_pool.
> > +              */
> > +             ASSERT_RTNL();
> > +             pool->mp_priv =3D pool->p.queue->mp_params.mp_priv;
>

Hi Jakub,

Sorry for the late reply, it took a bit of code reading to understand
what you mean with the deactivation request on the other patch, but I
think I got it down and have a patch on the way.

> How do you know that the driver:
>  - supports net_iov at all (let's not make implicit assumptions based
>    on presence of queue API);
>  - supports net_iov in current configuration (eg header-data split is
>    enabled)
>  - supports net_iov for _this_ pool (all drivers must have separate
>    buffer pools for headers and data for this to work, some will use
>    page pool for both)
>
> What comes to mind is adding an "I can gobble up net_iovs from this
> pool" flag in page pool params (the struct that comes from the driver),

This already sorta exists in the current iteration, although maybe in
an implicit way. As written, drivers need to set params.queue,
otherwise core will not attempt to grab the mp information from
params.queue. A driver can set params.queue for its data pages pool
and not set it for the headers pool. AFAICT that deals with all 3
issues you present above.

The awkward part is if params.queue starts getting used for other
reasons rather than passing mp configuration, but as of today that's
not the case so I didn't add the secondary flag. If you want a second
flag to be added preemptively, I can do that, no problem. Can you
confirm params.queue is not good enough?

> and then on the installation path we can check if after queue reset
> the refcount of the binding has increased. If it did - driver has
> created a pool as we expected, otherwise - fail, something must be off.
> Maybe that's a bit hacky?

What's missing is for core to check at binding time that the driver
supports net_iov. I had relied on the implicit presence of the
queue-API.

What you're proposing works, but AFAICT it's quite hacky, yes. I
basically need to ASSERT_RTNL in net_devmem_binding_get() to ensure
nothing can increment the refcount while the binding is happening so
that the refcount check is valid.

I think a less hacky approach is to add a function to the queue-API
like ndo_queue_supported_features(), which lets the driver declare
that it supports net_iov at a given rx queue. However I'm open to both
approaches. What do you prefer?

--=20
Thanks,
Mina

