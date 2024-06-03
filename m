Return-Path: <linux-kselftest+bounces-11112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B15BB8D84C0
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 16:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7482865D5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 14:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C9B12FB0B;
	Mon,  3 Jun 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aB7uHwwR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F2B12F37F
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Jun 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424245; cv=none; b=Sh58ddEkSnmG7AaiKazD/z7BIbr5hJVHc9t6hWq2D0MUXAjYng69JkXGBKM/3V1aJSduvaaENSWJVEZNZ6W5elROJYKWpboDanHgO84Hbw5RniJEeDTlzid/wz0GhuUs9sIllw1qoNB+U5BVU8fcflf6HGhfoekh7nFkgg9LH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424245; c=relaxed/simple;
	bh=HKIk/fziZZuLGu58aSs/+3iSct4B2ZtBElSDQxdl5rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sn59ClksE7Y/E/n9SK/UK1dHj9P9dBPkxjL1FCIy60JT7FQsQw/yT4CjTaBu14CQsyU09ASki+JC4xThukPCmjb13oAT5tj8cEW4FERyimp2PmymxGRc5MEaj1dwrnvyL2jwTsPa8QZ2Id5aNHc4R/kaxBmgriBpFri2j4N7SjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aB7uHwwR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a68c5524086so212619166b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2024 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717424242; x=1718029042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hX960fiFK86sEZShyroAmINX+eMw+I3MOlcUpYKxHw8=;
        b=aB7uHwwRC7K0jUH0NEm5WyzGaXSGKbzBBXAQ/6KPLq5hvpt5gIsvpFgfO+Ff0rEtAi
         jFQAdvKA+d/RJ2UFZ8PV41xtUcqWdMTeSLaliBueAXelYp9ptkog+SW+FezzEmmo9o9d
         BwrDZZ+ccw3hWVXFmvqFB2pRbtAZzZP0f/yDYFTuMXWx0g9CeAg6iSPPB5H1TcvUZGho
         uWsd8K4622fPZ85APw7Ml60GB0r4/d7flyjjdgDutm+xZWqjhAu0MvYpF0qu9XjpyYC4
         3JsnzPJ1DDmPHBUsMLmTQbjkIB/LXXKRTnAd//N+7CaOMjZU6LKDJea6nZRDzlyQFFWR
         7HNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717424242; x=1718029042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hX960fiFK86sEZShyroAmINX+eMw+I3MOlcUpYKxHw8=;
        b=SMd/5HrVhWOjnjJzFjnplF7etZegKuoakQh2l4XMv1/n3IKTLbriFQUQUcF4vosezM
         aYZ8fEygwuJXPYgs5kUasRKpUP4sSSlV9Z9/UryzDsR+4ddlEYACJcEKB/ILFk1pmKGt
         tdogNBDenl9tYE15V2a2n+6R0EhBUCZ0rWCu8+iSnj83QaJA3FnmwfRJfCIBkUPSG+0Z
         BFN9uHrpK017YDIOh6S3zj2TmikZN8eI0S0DnGoi0BraTll5nJKLiB6cmi7Jdoj1gjh7
         d5mmS2FudAdn+OsoehDzQ5ctAkJeIYandnf6pDlwZrl7niYl/NIYl82Yi6UbkMAQRz+Z
         lOAw==
X-Forwarded-Encrypted: i=1; AJvYcCUBkQH7xCTt4hihLUEMgtvmUIud+QGOzSjPlZNrIiVuACR68lJTxpmBzFxfOgQe6P5vnWIwZpDo4DLef+V4pMv7j1pPPKkSene5O6EqgJE4
X-Gm-Message-State: AOJu0Ywh32kqsWsgbnuQmGugE6E3dEFC73J1LSDZSLuynRbwBtypmy0H
	TtzJmIt0e+36csV0YJ19rpiNOJ6UNe3LeKgvop18VBYZZb+493A0ypf32T54IfPW8GKmCrkHrzN
	yW8bYPOsqF+22HBorGKZ3kNtUAZ6rF4f9NAVh
X-Google-Smtp-Source: AGHT+IF2dM971g+G40jgbxNlCnWLD2vDmcmV06zLLO0GJhjluR0VCD0WMHMSdMpVvOnlSN5qx4LmzaU7Z6g2TUlHcjM=
X-Received: by 2002:a17:907:914e:b0:a68:9621:a93c with SMTP id
 a640c23a62f3a-a689621ab6fmr371329366b.8.1717424241215; Mon, 03 Jun 2024
 07:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com> <ZlqzER_ufrhlB28v@infradead.org>
In-Reply-To: <ZlqzER_ufrhlB28v@infradead.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 3 Jun 2024 07:17:05 -0700
Message-ID: <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: Christoph Hellwig <hch@infradead.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 10:35=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Thu, May 30, 2024 at 08:16:01PM +0000, Mina Almasry wrote:
> > I'm unsure if the discussion has been resolved yet. Sending the series
> > anyway to get reviews/feedback on the (unrelated) rest of the series.
>
> As far as I'm concerned it is not.  I've not seen any convincing
> argument for more than page/folio allocator including larger order /
> huge page and dmabuf.
>

Thanks Christoph, this particular patch series adds dmabuf, so I
assume no objection there. I assume the objection is that you want the
generic, extensible hooks removed.

To be honest, I don't think the hooks are an integral part of the
design, and at this point I think we've argued for them enough. I
think we can easily achieve the same thing with just raw if statements
in a couple of places. We can always add the hooks if and only if we
actually justify many memory providers.

Any objections to me removing the hooks and directing to memory
allocations via simple if statements? Something like (very rough
draft, doesn't compile):

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 92be1aaf18ccc..2cc986455bce6 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -557,8 +557,8 @@ netmem_ref page_pool_alloc_netmem(struct page_pool
*pool, gfp_t gfp)
                return netmem;

        /* Slow-path: cache empty, do real allocation */
-       if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_op=
s)
-               netmem =3D pool->mp_ops->alloc_pages(pool, gfp);
+       if (unlikely(page_pool_is_dmabuf(pool)))
+               netmem =3D mp_dmabuf_devmem_alloc_pages():
        else
                netmem =3D __page_pool_alloc_pages_slow(pool, gfp);
        return netmem;


--=20
Thanks,
Mina

