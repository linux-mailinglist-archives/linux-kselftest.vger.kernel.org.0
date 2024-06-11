Return-Path: <linux-kselftest+bounces-11695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F06590432F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 20:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E21B232CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 18:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F427581B;
	Tue, 11 Jun 2024 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORBH1T28"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5D75915A
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718129377; cv=none; b=pf/3VwL+AM3T291sYYA3bRcX95YyFh1WxfDxhYoAK+zZDT0KXEBWL8BS30RV7bZbeluv9JGhndE8GsLCHwb1ouED9tWa8HiNgUVWqVb39jejcKkaH15S2lseHdhfp4lmWMYMuxOu0u1pUG0IOXYuzBgKBk283JGla4NYSuPcsmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718129377; c=relaxed/simple;
	bh=+lxPetrPpHvENSTokBRC6xognbIAj4RmicEAyuXDxTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7Gng67tq2jp7nPXOSP+xyi7e17kwXqMMlvjvTLRhDmSmVliSYHS0W81iO9DIZsrNaIqLcmfhTTME80B+wl1KFMihyFQXU++quK7dhn4rlsydNBZ7drb3GbLSHV2UXSj9dnAZm72VYkwoD0oBH649Q7mF33gvejVGbNtee6A2fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ORBH1T28; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso604874466b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718129370; x=1718734170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lxPetrPpHvENSTokBRC6xognbIAj4RmicEAyuXDxTU=;
        b=ORBH1T28Kv+Gm9vfDRFh0o9KoHNuPBRhIxafHB3qgyANZSEAx+9LLa6Wv5Iv2FulVM
         1C4r4QsMP/tolax4DaWy4QrJlMTPTRDUpbMg8JdQqiADkwRyXa1Iy11Ylt5B7YbjRIRq
         OctBI7JiWrNqmKnqBVdhpMRueuExFqKOmwSK+7OfBSrsjK4SgORfTkvjgaMoS3DMo0Q7
         FkTsN8QksrcUNYzFDEG1UmAfTCd8yxst6SYakYd6YSlIZ9FEq+7SBeD6XMUjZNk9BCcy
         Wrv4JJvkiSqmCMz3b9EpLjg4cplFB6acY4gYixvwk4VoXVVCe+PzWeGjji2mognTN5AY
         C0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718129370; x=1718734170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lxPetrPpHvENSTokBRC6xognbIAj4RmicEAyuXDxTU=;
        b=MUVGRVecOx6d0R3zYo8SoEM4Bob6be2VyjliXCOE1odQ5Mtrh7ZfTgc4w5HgGZJeFp
         zSvb4cQF3OuMvuDPT+ioCPc1Xe0kML/nl+CV9VgQ4TZyjUqj9/fKaxsXeNh0m20W8Yoq
         2dB9+t7GB6nYSBvZJh3tQ7b75ZRk6iTaBY+cfg9P0JRSZX/ak9lYmx8DLrZ7yTc85Cy3
         qkjZq6CzIkDDwAJigrYyu0Gj9V+xkfoWcec9eu+MqXjuJ63EyvbOHHk5ksJ3lwfpIPPI
         NniBh30OG83Q+TPwRd3+EMqrp0UkwB4zS64hKAiP2M9p7fDqr0r+485QYe22ig34F0Kh
         pFTw==
X-Forwarded-Encrypted: i=1; AJvYcCW1vWIMoPAiKrR1MaJeBeHuzQY5rAiYsJdRoJBhN+C1wocK3jeybs6VZ/6kvxbduSWKOZ9wnTg7Q6hffvS8H+s6mWEk246eEOdVcMiuSO6h
X-Gm-Message-State: AOJu0YxkmBGW+kb9z1EcJK9YINlxgh81ymQX0mQDiT9jp35VGVSchNGW
	MBNgPvEv+yBhyYqZ5/ufVY514BQAQnHkzsLFuxn7+hU9WfXqCLtVbJXXnCcoS7kLriDifJXGZ2E
	nb8Vw+sllQxOhd1k/nJxgXqyxN6QwTFTWcNT9
X-Google-Smtp-Source: AGHT+IHSnbMlQQE9x/zPWpkI90JIlOTBHgyEzLn5RoXQZyiGaSSB2YwhfXwjdqq72pgI+LQF0hGDSafJjuWqavJQlB4=
X-Received: by 2002:a17:906:4742:b0:a6f:393a:9dea with SMTP id
 a640c23a62f3a-a6f393aa161mr132795366b.77.1718129370030; Tue, 11 Jun 2024
 11:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com> <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <20240607145247.GG791043@ziepe.ca> <45803740-442c-4298-b47e-2d87ae5a6012@davidwei.uk>
 <54975459-7a5a-46ff-a9ae-dc16ceffbab4@gmail.com> <20240610121625.GI791043@ziepe.ca>
 <59443d14-1f1d-42bb-8be3-73e6e4a0b683@kernel.org> <00c67cf0-2bf3-4eaf-b200-ffe00d91593b@gmail.com>
 <20240610221500.GN791043@ziepe.ca>
In-Reply-To: <20240610221500.GN791043@ziepe.ca>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 11 Jun 2024 11:09:15 -0700
Message-ID: <CAHS8izNRd=f=jHgrYKKfzgcU3JzkZA1NkZnbQM+hfYd8-0NyBQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	David Wei <dw@davidwei.uk>, Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org, 
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
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 3:15=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Jun 10, 2024 at 08:20:08PM +0100, Pavel Begunkov wrote:
> > On 6/10/24 16:16, David Ahern wrote:
>
> > > > There is no reason you shouldn't be able to use your fast io_uring
> > > > completion and lifecycle flow with DMABUF backed memory. Those are =
not
> > > > widly different things and there is good reason they should work
> > > > together.
> >
> > Let's not mix up devmem TCP and dmabuf specifically, as I see it
> > your question was concerning the latter: "... DMABUF memory registered
> > through Mina's mechanism". io_uring's zcrx can trivially get dmabuf
> > support in future, as mentioned it's mostly the setup side. ABI,
> > buffer workflow and some details is a separate issue, and I don't
> > see how further integration aside from what we're already sharing
> > is beneficial, on opposite it'll complicate things.
>
> Again, I am talking about composability here, duplicating the DMABUF
> stuff into io_uring is not composable, it is just duplicating things.
>
> It does not match the view that there should be two distinct layers
> here, one that provides the pages and one that manages the
> lifecycle. As HCH pushes for pages either come from the allocator and
> get to use the struct folio or the come from a dmabuf and they
> don't. That is it, the only two choices.
>
> The iouring stuff is trying to confuse the source of the pages with
> the lifecycle - which is surely convenient, but is why Christoph is
> opposing it.
>

Just curious: in Pavel's effort, io_uring - which is not a device - is
trying to share memory with the page_pool, which is also not a device.
And Pavel is being asked to wrap the memory in a dmabuf. Is dmabuf
going to be the kernel's standard for any memory sharing between any 2
components in the future, even when they're not devices? As in you
expect dmabuf exporters which are not devices to be added to the
kernel? Currently the only dmabuf exporter which is not a device
(AFAIK) is udmabuf, which is used for testing and emulation, not
really a production thing, I think.

--=20
Thanks,
Mina

