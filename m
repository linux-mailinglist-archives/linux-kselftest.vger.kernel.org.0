Return-Path: <linux-kselftest+bounces-9681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8038BF6DE
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 09:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559EE28528C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 07:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480D2282D6;
	Wed,  8 May 2024 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DBmGgaXq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A182E400
	for <linux-kselftest@vger.kernel.org>; Wed,  8 May 2024 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152618; cv=none; b=OnAubCUKR4G3yl7Z6Ls3zaUDgOZDXN8e+7j34K7HLU7Kbq5KOP1x5HUNd46Rc1QlYVgIW14DoFcm066hz4ZlXzYeuAlGXfLhHlpE1iWmRxqADmGl8/byE3MTR7zCQvwSAtw+5OZzcN1rs550795rCxu1RTD4gzmNWt+2joNging=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152618; c=relaxed/simple;
	bh=f0m34QhDPAosJyYZmjdMVXrVYo1qtPAsG7RWUe2/wXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl5h1hAj+Yx6LmNDMJVmPbLkffvqTdTopuzBPgvQHbkcL/k6+JSOPvTIsgwGnMFb3b4u4kY7r0cKA6GuDxetmoAlJ8mH8brFbzejxwwM5EZ5v+cDOTScI+5eyyu02mTlcNGQ3KVZa5Q87sKQOthUfcaxtI94/9D9Cv6aLwXlzBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=DBmGgaXq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a599fc7943aso105264166b.1
        for <linux-kselftest@vger.kernel.org>; Wed, 08 May 2024 00:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1715152615; x=1715757415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeBqT9Zed0z1jUGrfvGp1XN4J6QgdBnyIkuy1n0h3cY=;
        b=DBmGgaXqwtbAn9I0Nvc5+wBv9yBnLxto05HFT/bGqugsjDLKACg94cKX5tt1RCysE6
         TDfgQ0wB9+shI1+rW5UNmWS8o0c5BUQ8RM+ajUHJ2NLXtn2f8TxkgdG+whdV74kg2BgB
         /MJfVZ1z/riYiVPNDi9T9jLUBrRmihFot5wIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715152615; x=1715757415;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CeBqT9Zed0z1jUGrfvGp1XN4J6QgdBnyIkuy1n0h3cY=;
        b=p8Ze/1hsqhAN8L7F7dpprGGD5UQdR72Ktns6cthCx6xucp1QdxWPTwCdOpdvPK3pVh
         lL6TmF4OYYTSwPpUuXlrAE6mRRImj4bvCb9lw8CqbFf5H5VhMwguvhPc2KzEuQSdDxPw
         8NqUmZzDNWN75ndROQQGYmgNNfY6YG25ef/chfbnCvBrnwAPxJ0ID3k9lsnpnpqI1HeW
         xnK7D0/jbU6FY350DViSrVKjvW+cQhvOuX2xlv09KTQMqQALomhXLwklfY6ocaxo7DDL
         PQDwmZ2QMNKC6OavZ2seZc2zWEv0vWMbVzdvM0193Ta43fiRLUpV9lJgSnIryxggkYb/
         7qdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkpmKlijDRFHfQw37t2oNAonpq4teJJK/7evT3+bg5z2IeFAP4cai+9tewrcJUP2c4dYl3rW133qFvYV4808RopGmY1gWWT19uPeC06cIH
X-Gm-Message-State: AOJu0YyHwfV8hNRBbXAIn+p11xGGjqZV3gHmbtaSksHxDdI6XzncfRBY
	sCdupsPIK6eqD1nhqJNVnWcB39nO+66CiRHcvyLV/cF1rc8Zg953MxI/BiYcNH4=
X-Google-Smtp-Source: AGHT+IHGhXCUeVIYLmH7Uo4M9BmI6iPWf/Ls31PQQRWTBdNBS6P3e6HNMCsyKMnZNizlrV6npyfCDA==
X-Received: by 2002:a05:6402:378a:b0:572:d841:1189 with SMTP id 4fb4d7f45d1cf-5731da624efmr899529a12.3.1715152610093;
        Wed, 08 May 2024 00:16:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n18-20020a05640205d200b00572f0438b02sm4124571edx.6.2024.05.08.00.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:16:49 -0700 (PDT)
Date: Wed, 8 May 2024 09:16:46 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Aleksander Lobakin <aleksander.lobakin@intel.com>,
	Michael Lass <bevan@bi-co.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>, David Wei <dw@davidwei.uk>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [RFC PATCH net-next v8 02/14] net: page_pool: create hooks for
 custom page providers
Message-ID: <Zjsm3vO6rIY_sw5A@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Aleksander Lobakin <aleksander.lobakin@intel.com>,
	Michael Lass <bevan@bi-co.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>, David Wei <dw@davidwei.uk>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
References: <ZjjHUh1eINPg1wkn@infradead.org>
 <20b1c2d9-0b37-414c-b348-89684c0c0998@gmail.com>
 <20240507161857.GA4718@ziepe.ca>
 <ZjpVfPqGNfE5N4bl@infradead.org>
 <CAHS8izPH+sRLSiZ7vbrNtRdHrFEf8XQ61XAyHuxRSL9Jjy8YbQ@mail.gmail.com>
 <20240507164838.GG4718@ziepe.ca>
 <0d5da361-cc7b-46e9-a635-9a7a4c208444@gmail.com>
 <20240507175644.GJ4718@ziepe.ca>
 <6a50d01a-b5b9-4699-9d58-94e5f8f81c13@gmail.com>
 <20240507233247.GK4718@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507233247.GK4718@ziepe.ca>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Tue, May 07, 2024 at 08:32:47PM -0300, Jason Gunthorpe wrote:
> On Tue, May 07, 2024 at 08:35:37PM +0100, Pavel Begunkov wrote:
> > On 5/7/24 18:56, Jason Gunthorpe wrote:
> > > On Tue, May 07, 2024 at 06:25:52PM +0100, Pavel Begunkov wrote:
> > > > On 5/7/24 17:48, Jason Gunthorpe wrote:
> > > > > On Tue, May 07, 2024 at 09:42:05AM -0700, Mina Almasry wrote:
> > > > > 
> > > > > > 1. Align with devmem TCP to use udmabuf for your io_uring memory. I
> > > > > > think in the past you said it's a uapi you don't link but in the face
> > > > > > of this pushback you may want to reconsider.
> > > > > 
> > > > > dmabuf does not force a uapi, you can acquire your pages however you
> > > > > want and wrap them up in a dmabuf. No uapi at all.
> > > > > 
> > > > > The point is that dmabuf already provides ops that do basically what
> > > > > is needed here. We don't need ops calling ops just because dmabuf's
> > > > > ops are not understsood or not perfect. Fixup dmabuf.
> > > > 
> > > > Those ops, for example, are used to efficiently return used buffers
> > > > back to the kernel, which is uapi, I don't see how dmabuf can be
> > > > fixed up to cover it.
> > > 
> > > Sure, but that doesn't mean you can't use dma buf for the other parts
> > > of the flow. The per-page lifetime is a different topic than the
> > > refcounting and access of the entire bulk of memory.
> > 
> > Ok, so if we're leaving uapi (and ops) and keep per page/sub-buffer as
> > is, the rest is resolving uptr -> pages, and passing it to page pool in
> > a convenient to page pool format (net_iov).
> 
> I'm not going to pretend to know about page pool details, but dmabuf
> is the way to get the bulk of pages into a pool within the net stack's
> allocator and keep that bulk properly refcounted while.
> 
> An object like dmabuf is needed for the general case because there are
> not going to be per-page references or otherwise available.
> 
> What you seem to want is to alter how the actual allocation flow works
> from that bulk of memory and delay the free. It seems like a different
> topic to me, and honestly hacking into the allocator free function
> seems a bit weird..

Also I don't see how it's an argument against dma-buf as the interface for
all these, because e.g. ttm internally does have a page pool because
depending upon allocator, that's indeed beneficial. Other drm drivers have
more buffer-based concepts for opportunistically memory around, usually
by marking buffers that are just kept as cache as purgeable (which is a
concept that goes all the way to opengl/vulkan).

But these are all internals of the dma-buf exporter, the dma-buf api users
don't ever need to care.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

