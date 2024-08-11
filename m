Return-Path: <linux-kselftest+bounces-15119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C65894DF8F
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 04:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF07281A0D
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 02:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207DBDF5B;
	Sun, 11 Aug 2024 02:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXSU5CVS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF68F48
	for <linux-kselftest@vger.kernel.org>; Sun, 11 Aug 2024 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723342915; cv=none; b=aCGTYIBp7T17o6kX+P+gOt2dL/WyXmfSlDUnOHXaJl8m4KPd8fz5Wh1dSg0YdxhP4wJJprfRvnvO5xvoq7OOO9mrhdD6Jz/4tk9KiQhfuHF7D0T0f1lXGEcckDjrX/PCRVUL4kB/xAzBJDQJc8655DgbykKtYCVPcjM3XzAwjbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723342915; c=relaxed/simple;
	bh=RG9LHAeha0E5bVe70AIhZ3CulzWRiRRdzwCyU2ikkxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F410GahnUNIxMyEtu8GHBKHBgU2s2xCQTVKmk+MB7LQe/COxFusotrVf44zTr2rZIiSgSO3kwxbeNbROh+gQoOkISvWdqWYFoP5xGY5xtoG7EKaNSHlX++F8VzdPHC4mKVLRmH2NLVZRq82Z11Sia27dYS0qnAPB0X8gWuxjYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fXSU5CVS; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6bb687c3cceso19113536d6.0
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Aug 2024 19:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723342912; x=1723947712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RG9LHAeha0E5bVe70AIhZ3CulzWRiRRdzwCyU2ikkxg=;
        b=fXSU5CVSFFbF8Gxlcs6TWffKLPy5YSk54DIXLniQNmCL98F9FZLrOuOprTRSIAdWfV
         OuRxbRTXDbz0IaFjnxatxZa6jDXM3t0uCeJyAre0esHGCbqrFy0OIx72dNtkzCF0r/L6
         +fCsVj4DCPF5KHZv/sK2tO+JfhpZw44QwxkVdTSOWTPPW5tWtjCLfhBLKIRnnxftWvRf
         RyiZVW83mLx3R8xY/mXeh4hI/2z4v9blHJF+ieZTq9kHSWHzAlkXQDlPt+pQ7/bZm8Ic
         fisryOR9JByR69bcOEgnkmTWKQ6wFjsFlrhX1j6u42en22dm3OSrYiUv5vc70OTzpaTx
         XpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723342912; x=1723947712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RG9LHAeha0E5bVe70AIhZ3CulzWRiRRdzwCyU2ikkxg=;
        b=bJc4IHgqciw7vI6ddX1GuIBCnd6CsEv35avTsik/vpfOCuellN90YE7JnefdJKkcKk
         /E3sFHVQoAaA2K6p+3IAhQWzEG6dWYIN5fh7DCM32qosmwX9+hXxmu4WuTBusgZ6PpIY
         LR3aYL56S7d6lwgaeVCNctnxyDcsb1nearW3PueiBmqUmE5fss+QZB7ShJ932rew3h+v
         Z4kuE+DhsR81zOFLPJN+TOwVk1svelb+7NPyqbA74l+T4LJZQfU0RdJKi33c8Qb0Q+2a
         Ju6ua9dN8mpVFtagXPdNwG9SgLOmJYPkBNkbgf3pQP7jmxCJcalIxGJxLW1S0NvkrA6Q
         jLWA==
X-Forwarded-Encrypted: i=1; AJvYcCXRaEENZFrTgcPNg9J/VHSmOGtAKUISxT51kkCwBU7ZpGXLPPxk4Cn5ioE4nDJqEvJXgAfTi6DnFTmBvIn7zGP75hvvLxuvXRlv2VVpKpTf
X-Gm-Message-State: AOJu0YxUsTLAoWUplZjP0q/4+4/ZJ5mh8TiUIFhGo9/79YXATcvCEJ1j
	tgYb0+CID7xzZi1bYRdc8J7UXjunkyGHMm4OyT5B7uPIUjo2ufe2NW3XVfuiQeSn7il5bF36YyU
	U5RpRFvUXJdvpnpomUCk0OWkjKxyETyxdSocR
X-Google-Smtp-Source: AGHT+IEZ2o2IjbltxUtgiFqMaggi2EMslyYy4EjJKqHkpI3i2lfifDNDb+nrXQWahxplCc4kLWOurPaC9Ylw74lSj5w=
X-Received: by 2002:a05:6214:43c8:b0:6b5:dcda:bada with SMTP id
 6a1803df08f44-6bd78e8296cmr66071346d6.55.1723342911553; Sat, 10 Aug 2024
 19:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805212536.2172174-1-almasrymina@google.com>
 <20240805212536.2172174-8-almasrymina@google.com> <20240806135924.5bb65ec7@kernel.org>
 <CAHS8izOA80dxpB9rzOwv7Oe_1w4A7vo5S3c3=uCES8TSnjyzpg@mail.gmail.com>
 <20240808192410.37a49724@kernel.org> <CAHS8izMH4UhD+UDYqMjt9d=gu-wpGPQBLyewzVrCWRyoVtQcgA@mail.gmail.com>
 <fc6a8f0a-cdb4-4705-a08f-7033ef15213e@gmail.com> <20240809205236.77c959b0@kernel.org>
In-Reply-To: <20240809205236.77c959b0@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sat, 10 Aug 2024 22:21:39 -0400
Message-ID: <CAHS8izOXwZS-8sfvn3DuT1XWhjc--7-ZLjr8rMn1XHr5F+ckbA@mail.gmail.com>
Subject: Re: [PATCH net-next v18 07/14] memory-provider: dmabuf devmem memory provider
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 11:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 9 Aug 2024 16:45:50 +0100 Pavel Begunkov wrote:
> > > I think this is good, and it doesn't seem hacky to me, because we can
> > > check the page_pools of the netdev while we hold rtnl, so we can be
> > > sure nothing is messing with the pp configuration in the meantime.
> > > Like you say below it does validate the driver rather than rely on th=
e
> > > driver saying it's doing the right thing. I'll look into putting this
> > > in the next version.
> >
> > Why not have a flag set by the driver and advertising whether it
> > supports providers or not, which should be checked for instance in
> > netdev_rx_queue_restart()? If set, the driver should do the right
> > thing. That's in addition to a new pp_params flag explicitly telling
> > if pp should use providers. It's more explicit and feels a little
> > less hacky.
>
> You mean like I suggested in the previous two emails? :)
>
> Given how easy the check is to implement, I think it's worth
> adding as a sanity check. But the flag should be the main API,
> if the sanity check starts to be annoying we'll ditch it.

I think we're talking about 2 slightly different flags, AFAIU.

Pavel and I are suggesting the driver reports "I support memory
providers" directly to core (via the queue-api or what not), and we
check that flag directly in netdev_rx_queue_restart(), and fail
immediately if the support is not there.

Jakub is suggesting a page_pool_params flag which lets the driver
report "I support memory providers". If the driver doesn't support it
but core is trying to configure that, then the page_pool_create will
fail, which will cause the queue API operation
(ndo_queue_alloc_mem_alloc) to fail, which causes
netdev_rx_queue_restart() to fail.

Both are fine, I don't see any extremely strong reason to pick one of
the other. I prefer Jakub's suggestion, just because it's closer to
the page_pool and may be more reusable in the future. I'll err on the
side of that unless I hear strong preference to the contrary.

I also think the additional check that Jakub is requesting is easy to
implement and unobjectionable. It would let core validate that the
driver did actually create the page_pool with the memory provider. I
think one of the goals of the queue API was to allow core to do more
validation on driver configuration anyway.

--=20
Thanks,
Mina

