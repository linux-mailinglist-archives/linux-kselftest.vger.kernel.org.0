Return-Path: <linux-kselftest+bounces-5971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5652B872D0A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 03:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF3E1C21482
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 02:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958ED6FBD;
	Wed,  6 Mar 2024 02:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FfspCDPZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5553212E71
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Mar 2024 02:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709693684; cv=none; b=sC9wwzobmTYmZBkHnzSEVTxu1MgNSWgchL/Vc+3CSH2+medSWMrIlpRUdNLR2qPlzgSjaR13WDI0iuII5XxkWvKDOFSR22TChyzS2UO+7K49Wpt32uvwaFcTEMG3rI26fUkvIyppXYmegD78u1g+ByyL534AQTnWlNmwTc5tBnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709693684; c=relaxed/simple;
	bh=rCsQQP7xgQocqgJZyTCewEFa4pqWP3bm2r+qfnB/Kdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUdWlEFvgC5PBRO5jVcewTpnxXg4zYw/pHPy4UrrfCF8ez4ID89kjHY92kQ6BgqxBUSL58wI6Lcc+ITbqRSWTIEL3B0+8vj7T4bkQJRok3ILwKMOnlPHr1YR5PDKxQx3qsHB5uTJ//Crr2L7eG8q5db6gcbLtCA7V6kyh+aib28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FfspCDPZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so195772166b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Mar 2024 18:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709693681; x=1710298481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eS/C6JRe/LZxR5BB0/jvRViDTj3F8vBSe/WWRgNeFIA=;
        b=FfspCDPZNW8S7Qf7wpydUp7nMkxbIvbEb4ID33aWUPwHOYvxyiL5+xjC/RGuYky5nJ
         UXbu0gXQCFwnw50zF+4eh5urGT9USQAfcXkEasQoB328Tb8CE77MTWKT72cElYJh0wiU
         E8M6JwS0IqClv/VPW882Nqjm33OxkixBNmv2B1WPXiL5arG8e00lOAa7AfTo3NB4z5xf
         jcpIGJ9Llm7DNOCjp3Jw3H51L90Ew0/AcaBWuTDJDOQG4bdnCW1kNOzZmO/JeKseNhq8
         VZCcpvUcpy7bLKHJluNjLXFu8vbMbxapQ9qoBZgzezbUe/OupdB7FZDjPG1+nCvQ0lcD
         tgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709693681; x=1710298481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eS/C6JRe/LZxR5BB0/jvRViDTj3F8vBSe/WWRgNeFIA=;
        b=s7W2pIHtWsk0W6SWUSoxoETY/Fr4yMqkyWeVMMFa46aJMYolIfjyQHdI0GcM51vRJp
         TmvQOriIPLq5OGzy/Ih6gb5fgSpWot1+MJLRoiZ/FrIhcltY3nm6w5F56CUGPEv2cBsQ
         EerbCFqdSD/xSkJvc5UQJw3m/TJhxXCK8iamix9iCY7bN/pSnx+TBnaaWwAOkHOmfgc8
         JRanwJaMRLI7dOXmjJ08r+H3+sGLJQtZnU4QmX71mlFkCU+e+n2KN/7YcZ/8A0QXLVu2
         Ao6MT16jJ5o6mL3VqTDCPIR9yhDdwkcgHh5lv/WvS0XvtBmuxnI+7OgjyoDQ1PrxXLJg
         cyXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGZc84axV7oBDN5Zd1fLG1QzSWIybpe6kUjcLn6VSZJ8HcNtjbWY3EOM816AXvhdXeGQj8vTH80Enfe1PUtxqslmK+LVw5C5LnUEp8zOmL
X-Gm-Message-State: AOJu0YxRXRQq8mRRM069aQRpGbVkVkZIg59sxFqd81cpuLtfyUfeGYg9
	AjoW+qX9ZLs8V2J4MNoLSsMt61TyykE6/OdxIAJd4OVuCukMW6XeKHEpauSxoL32taSh3PXPzIB
	51a6F/+aS2qx46rmLVtb2bab/GuIPKsbq2jhT
X-Google-Smtp-Source: AGHT+IEBCHh5at8F+COR4cGDllSpD2J7JpR+ODcNFG7XI5qKLEW8CmG66IZiYQuqBlnDkixdz9i/+yCx3p+Y4GqdUM0=
X-Received: by 2002:a17:906:4551:b0:a45:270e:3617 with SMTP id
 s17-20020a170906455100b00a45270e3617mr5771839ejq.27.1709693680497; Tue, 05
 Mar 2024 18:54:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-10-almasrymina@google.com> <383c4870-167f-4123-bbf3-928db1463e01@davidwei.uk>
 <CAHS8izP_PzDJVxycwZe_d_x10-SX4=Q-CWpKTjoOQ5dc2NSn3w@mail.gmail.com> <6562b8b0-6cc0-4652-b746-75549801c002@davidwei.uk>
In-Reply-To: <6562b8b0-6cc0-4652-b746-75549801c002@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 5 Mar 2024 18:54:28 -0800
Message-ID: <CAHS8izOExbcxNSW8b5UUO=Y2se8ypZfaoyoviQvqR-WVZ=7s-g@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 09/15] memory-provider: dmabuf devmem
 memory provider
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 6:47=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-03-05 18:42, Mina Almasry wrote:
> > On Tue, Mar 5, 2024 at 6:28=E2=80=AFPM David Wei <dw@davidwei.uk> wrote=
:
> >>
> >> On 2024-03-04 18:01, Mina Almasry wrote:
> >>> +     if (pool->p.queue)
> >>> +             binding =3D READ_ONCE(pool->p.queue->binding);
> >>> +
> >>> +     if (binding) {
> >>> +             pool->mp_ops =3D &dmabuf_devmem_ops;
> >>> +             pool->mp_priv =3D binding;
> >>> +     }
> >>
> >> This is specific to TCP devmem. For ZC Rx we will need something more
> >> generic to let us pass our own memory provider backend down to the pag=
e
> >> pool.
> >>
> >> What about storing ops and priv void ptr in struct netdev_rx_queue
> >> instead? Then we can both use it.
> >
> > Yes, this is dmabuf specific, I was thinking you'd define your own
> > member of netdev_rx_queue, and then add something like this to
> > page_pool_init:
> >
> > +       if (pool->p.queue)
> > +               io_uring_metadata =3D READ_ONCE(pool->p.queue->io_uring=
_metadata);
> > +
> > +       /* We don't support rx-queues that are configured for both
> > io_uring & dmabuf binding */
> > +       BUG_ON(io_uring_metadata && binding);
> > +
> > +       if (io_uring_metadata) {
> > +               pool->mp_ops =3D &io_uring_ops;
> > +               pool->mp_priv =3D io_uring_metadata;
> > +       }
> >
> > I.e., we share the pool->mp_ops and the pool->mp_priv but we don't
> > really need to share the same netdev_rx_queue member. For me it's a
> > dma-buf specific data structure (netdev_dmabuf_binding) and for you
> > it's something else.
>
> This adds size to struct netdev_rx_queue and requires checks on whether
> both are set. There can be thousands of these structs at any one time so
> if we don't need to add size unnecessarily then that would be best.
>
> We can disambiguate by comparing &mp_ops and then cast the void ptr to
> our impl specific objects.
>
> What do you not like about this approach?
>

I was thinking it leaks page_pool specifics into a generic struct
unrelated to the page pool like netdev_rx_queue. My mental model is
that the rx-queue just says that it's bound to a dma-buf/io_uring
unaware of page_pool internals, and the page pool internals figure out
what to do from there.

Currently netdev_rx_queue.h doesn't include net/page_pool/types.h for
example because there is no dependency between netdev_rx_queue &
page_pool, I think this change would add a dependency.

But I concede it does not matter much AFAICT, I can certainly change
the netdev_rx_queue to hold the mp_priv & mp_ops directly and include
net/page_pool/types.h if you prefer that. I'll look into applying this
change in the next iteration if there are no objections.

> >
> > page_pool_init() probably needs to validate that the queue is
> > configured for dma-buf or io_uring but not both. If it's configured
> > for both then the user is doing something funky we shouldn't support.
> >
> > Perhaps I can make the intention clearer by renaming 'binding' to
> > something more specific to dma-buf like queue->dmabuf_binding, to make
> > it clear that this is the dma-buf binding and not some other binding
> > like io_uring?
> >



--=20
Thanks,
Mina

