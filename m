Return-Path: <linux-kselftest+bounces-11575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF159025D2
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 17:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2552A1F2206B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 15:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E0013E3F2;
	Mon, 10 Jun 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBC3BjeV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B613DDCD
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034104; cv=none; b=ZkH3Z+DgLj4C8mDw6XVtq4yaxPz2MFyALdJGndpgRGIWAz5915o5QSgdVSSgt/GopWKJpox5J3SNC6G+zn4o7vAaOit19lMptMag4PwU7RaOVxoqmL1pinlgfGQti9E6sBPtWqhJb7PqL1HIUtlX7PV5B1NCaZVqKMJms6A32MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034104; c=relaxed/simple;
	bh=NH9qOe8AuGn3R+TevtlS2pqQNAL05iIcoVXpQ7CPaGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nq7awHv3busKPTVGMStIGp5Ja9LbjSDPqE30a+r8/iGu6KJn0tzoB3kdH+vMrMUt9KF8c2Umem/v88xGoCkq4sws1mXPYnRPG0NEWEK6mUJCxmFRFNsKsR8z897OAwpzorcoCQgjJ3RHdUH6AvWZ/OYXPPAyeY8u9K1ibVUcjlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBC3BjeV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c714a1e24so2486740a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718034100; x=1718638900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NH9qOe8AuGn3R+TevtlS2pqQNAL05iIcoVXpQ7CPaGI=;
        b=NBC3BjeV43Tto6rj7jzWS0apRPZAnZhJNBOou0IKmm3h/8DlAdjhG4Y5gsqiMZ3pAd
         eHigC7Qcovtju7HZ8zQbCH+6Mddcwh9xzZyF87jwWeINqrgM1FR10aoNpM9dZICtDvyc
         xpf/0lnr4kBXB8f4u7FUjoUTnij835IuH9nXp7+XMaRWHJ0DuFWMNuTFhWOjApFRaXYT
         7RG3m7uf6qb1wB3E+GyK9gA7GBP6oTu3azHkQzuLULoMA/9i+b2aihNWU9FBTH7e5imH
         Ehtos6vd4QKW9+lJTwoCRJli+5DpQDQDQZAogzlY1LO+FpPUy3lqrKWKLqAw+vVHctXA
         UdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718034100; x=1718638900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NH9qOe8AuGn3R+TevtlS2pqQNAL05iIcoVXpQ7CPaGI=;
        b=s/XAqTwDJzjCxxIewscVGcsQJ6bfFD0zP9K04wV1nI6rLrs1abwywSPhA7dAhq9y2T
         rBl3pOY/Y8cTbRQq1O7X+jg0MAwJGMiW2GPAUNyVqHLOpB/IhD9BeqbwnUsKd6+0w/BY
         C7fc4hFoJeYs6MygKatBQKbuOxce1aORAe5+W7axlqg7HSN7ymKwlRUJxw8HLaqH0/YO
         8NzMSBwtuCzK+IhpT17GeLKOF+7RLx0edJuC8szhbYFVePKP2k7C+b5yV86fbX9lGoX+
         OEihE4nU5iHFdGR0eBRmdhYwHFr8GIKbdQARwnCs98jOHpaoE2MnN8o9vB27egn9ah3/
         nK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTBAh/enIqs/c1CXNPrxxXjldYeVsDXrSzkv3S2djaJTXYPwX91JKK/PqIes0xUzsmK1MH8Hw2lxkPrGQM2Otj2xDmd8gyZMR24Qhq1zp6
X-Gm-Message-State: AOJu0YwQ7+5Kaj7d0H3UdyhClEfLCGHtYv7pqaBh8LHw7ixXjj6kpkhy
	RBdr3RwqWzy4aMw9jEpngBWGzhbTeDCWv93fCOQRffRKq8RkklYqN8LIJKRvE9xrSEv1Cpog1Wk
	UCMGYoWTP+y2CS70Wz/wvW3d6LYnOnyvTV+NU
X-Google-Smtp-Source: AGHT+IGhBtLDJFK2P+RcfVlyA2ZAGso96YWHpocomofOltg8xljfiwSKPnAsDJBDqZd1U8grgl7y/Dr4+a+0D+ppdnU=
X-Received: by 2002:a17:906:8888:b0:a6f:279b:37ca with SMTP id
 a640c23a62f3a-a6f279b38b3mr91530566b.51.1718034099331; Mon, 10 Jun 2024
 08:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org> <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com> <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com> <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <20240607145247.GG791043@ziepe.ca> <45803740-442c-4298-b47e-2d87ae5a6012@davidwei.uk>
 <54975459-7a5a-46ff-a9ae-dc16ceffbab4@gmail.com> <20240610121625.GI791043@ziepe.ca>
 <cdbc0d5f-bfbc-4f58-a6dd-c13b0bb5ff1c@amd.com>
In-Reply-To: <cdbc0d5f-bfbc-4f58-a6dd-c13b0bb5ff1c@amd.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 10 Jun 2024 08:41:25 -0700
Message-ID: <CAHS8izNwmXQTLc9VADpushYKyeJ4ZY4G9aV47W2-1St65-tKUg@mail.gmail.com>
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	David Ahern <dsahern@kernel.org>, Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 5:38=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 10.06.24 um 14:16 schrieb Jason Gunthorpe:
> > On Mon, Jun 10, 2024 at 02:07:01AM +0100, Pavel Begunkov wrote:
> >> On 6/10/24 01:37, David Wei wrote:
> >>> On 2024-06-07 17:52, Jason Gunthorpe wrote:
> >>>> IMHO it seems to compose poorly if you can only use the io_uring
> >>>> lifecycle model with io_uring registered memory, and not with DMABUF
> >>>> memory registered through Mina's mechanism.
> >>> By this, do you mean io_uring must be exclusively used to use this
> >>> feature?
> >>>
> >>> And you'd rather see the two decoupled, so userspace can register w/ =
say
> >>> dmabuf then pass it to io_uring?
> >> Personally, I have no clue what Jason means. You can just as
> >> well say that it's poorly composable that write(2) to a disk
> >> cannot post a completion into a XDP ring, or a netlink socket,
> >> or io_uring's main completion queue, or name any other API.
> > There is no reason you shouldn't be able to use your fast io_uring
> > completion and lifecycle flow with DMABUF backed memory. Those are not
> > widly different things and there is good reason they should work
> > together.
>
> Well there is the fundamental problem that you can't use io_uring to
> implement the semantics necessary for a dma_fence.
>
> That's why we had to reject the io_uring work on DMA-buf sharing from
> Google a few years ago.
>

Any chance someone can link me to this? io_uring, as far as my
primitive understanding goes, is not yet very adopted at Google, and
I'm curious what this effort is.

--=20
Thanks,
Mina

