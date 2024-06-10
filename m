Return-Path: <linux-kselftest+bounces-11578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1087D902699
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 18:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E891F26809
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C10314532C;
	Mon, 10 Jun 2024 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CbMdslNe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD46143734
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036537; cv=none; b=SSd5TOEhSElsHNte0sws0AJafXfo9hol3MXS5DXe5vX9wsHH1F12lFcL4YrBYOKSAn4ccoyUd1AOGPahCKRC86WQbePA7Re/HdGE32rDkbYWbBJwmp4lnZy0oyGPA8Rywvu2Q1v8gFPyOD+SrHWgEP1cOa4h0yOmn0C0K7sD56M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036537; c=relaxed/simple;
	bh=bxsg4DNdFkYFmIgYwjazkLg1QZ0/79fRk9dWu4LWVVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InKbQdKbMJ+p/qAMojP+BihNqx1amLPDOPO28qr5UfzG+cAO5lJxYBU1JLrj7o929Km+VeaoEv/yJEN8UHnddvooS1AXVtq0Ct3DQvJmw5//yI4779Mcold7i9zv2hFLI++uUHNAeXkatBj2oAhVb2JjadZEL6Beu/3mAEgsV/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=CbMdslNe; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52be2abf5dbso272322e87.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 09:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1718036533; x=1718641333; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4FQOUy6eQVbn2rNLxqez3pRfyzUAVY5hKRfgcqQacv4=;
        b=CbMdslNexg/lqMGvcz9EOs7GczC7ZsErEpZuX5EE7mc/TvOCgrdEdtuN+shIIBkZfg
         jE/k9pUF/wE0lzxXJAGbZUFWbgHUZW1CRXIIFvOGWRpYe+4BTrz41dIfimSzQLOkEH6O
         w42rU8pwt83wT+fwFpjh/p3NbvNiS4JONxgxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718036533; x=1718641333;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FQOUy6eQVbn2rNLxqez3pRfyzUAVY5hKRfgcqQacv4=;
        b=n8bNTvrvz53gIaMadySJ3GQjy+DaQPPwXfzjNmj+9I8/ss/eCNn6nSfiw1nldbXxbn
         BZt4teF0NLAAFkVzni6UvAbgfMsP8pibB9DXUTVtQVoYfgre7nlFIHIlS/5iN7jaCkkr
         Nj3zk1rFuuWWUjbf9DwjOD9MuigmxbhCV+ILB3B3zPHr03PoiOeAZtiIM0ZmLY0Q2cLm
         JZ3dapesUnVhFVq2btN8Z/vnyX7C15LMuDi7WNY+sL8RjMQqx9xA8lokUub4Y4qSDlyf
         g9h4UvO5ttpeTjT2Cxc88JnhlOwaJtdbsu38vVPhqpKHuekRUvyDDUfTt/Nkz0tGwCzg
         9CSw==
X-Forwarded-Encrypted: i=1; AJvYcCXC+fdmqZtX4LagJj6TFcmLmJ8AHADP7ByoT4+hWnKQ4mp+KdXzfmO7VALuz7zG+6PqKvHwcE8qVzXUky+NTWSRVEUIG+YyBZtp6FIPczt7
X-Gm-Message-State: AOJu0Yzwn5tW6+qn+sYgjtSIhUZ9m6iIrhEegCoqnXW2aOw1oZPUMHS+
	entFkvKg4hwIItlLClXtz0/fl79hLD63aQ2lfiW1B8Kal3P+5mC8wX1FbP8eOJE=
X-Google-Smtp-Source: AGHT+IGSIZFW5ug9A4F5elNqmArwptwwiWCm04nlIpH7pIYvmM7NziR+tlCEqa6BBIkNpwvoHu1pmQ==
X-Received: by 2002:a05:6512:310c:b0:52c:8e13:a830 with SMTP id 2adb3069b0e04-52c8e13a898mr1364204e87.0.1718036532505;
        Mon, 10 Jun 2024 09:22:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4220ce52c32sm21707585e9.48.2024.06.10.09.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 09:22:11 -0700 (PDT)
Date: Mon, 10 Jun 2024 18:22:08 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>, David Ahern <dsahern@kernel.org>,
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
	Donald Hunter <donald.hunter@gmail.com>,
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
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
Message-ID: <ZmcoMADenEFtuL6c@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	David Ahern <dsahern@kernel.org>,
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
	Donald Hunter <donald.hunter@gmail.com>,
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
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
References: <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
 <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <20240607145247.GG791043@ziepe.ca>
 <45803740-442c-4298-b47e-2d87ae5a6012@davidwei.uk>
 <54975459-7a5a-46ff-a9ae-dc16ceffbab4@gmail.com>
 <20240610121625.GI791043@ziepe.ca>
 <cdbc0d5f-bfbc-4f58-a6dd-c13b0bb5ff1c@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdbc0d5f-bfbc-4f58-a6dd-c13b0bb5ff1c@amd.com>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Mon, Jun 10, 2024 at 02:38:18PM +0200, Christian K�nig wrote:
> Am 10.06.24 um 14:16 schrieb Jason Gunthorpe:
> > On Mon, Jun 10, 2024 at 02:07:01AM +0100, Pavel Begunkov wrote:
> > > On 6/10/24 01:37, David Wei wrote:
> > > > On 2024-06-07 17:52, Jason Gunthorpe wrote:
> > > > > IMHO it seems to compose poorly if you can only use the io_uring
> > > > > lifecycle model with io_uring registered memory, and not with DMABUF
> > > > > memory registered through Mina's mechanism.
> > > > By this, do you mean io_uring must be exclusively used to use this
> > > > feature?
> > > > 
> > > > And you'd rather see the two decoupled, so userspace can register w/ say
> > > > dmabuf then pass it to io_uring?
> > > Personally, I have no clue what Jason means. You can just as
> > > well say that it's poorly composable that write(2) to a disk
> > > cannot post a completion into a XDP ring, or a netlink socket,
> > > or io_uring's main completion queue, or name any other API.
> > There is no reason you shouldn't be able to use your fast io_uring
> > completion and lifecycle flow with DMABUF backed memory. Those are not
> > widly different things and there is good reason they should work
> > together.
> 
> Well there is the fundamental problem that you can't use io_uring to
> implement the semantics necessary for a dma_fence.
> 
> That's why we had to reject the io_uring work on DMA-buf sharing from Google
> a few years ago.
> 
> But this only affects the dma_fence synchronization part of DMA-buf, but
> *not* the general buffer sharing.

More precisely, it only impacts the userspace/data access implicit
synchronization part of dma-buf. For tracking buffer movements like on
invalidations/refault with a dynamic dma-buf importer/exporter I think the
dma-fence rules are acceptable. At least they've been for rdma drivers.

But the escape hatch is to (temporarily) pin the dma-buf, which is exactly
what direct I/O also does when accessing pages. So aside from the still
unsolved question on how we should account/track pinned dma-buf, there
shouldn't be an issue. Or at least I'm failing to see one.

And for synchronization to data access the dma-fence stuff on dma-buf is
anyway rather deprecated on the gpu side too, exactly because of all these
limitations. On the gpu side we've been moving to free-standing
drm_syncobj instead, but those are fairly gpu specific and any other
subsystem should be able to just reuse what they have already to signal
transaction completions.

Cheers, Sima

> 
> Regards,
> Christian.
> 
> > 
> > Pretending they are totally different just because two different
> > people wrote them is a very siloed view.
> > 
> > > The devmem TCP callback can implement it in a way feasible to
> > > the project, but it cannot directly post events to an unrelated
> > > API like io_uring. And devmem attaches buffers to a socket,
> > > for which a ring for returning buffers might even be a nuisance.
> > If you can't compose your io_uring completion mechanism with a DMABUF
> > provided backing store then I think it needs more work.
> > 
> > Jason
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

