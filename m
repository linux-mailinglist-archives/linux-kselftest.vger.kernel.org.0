Return-Path: <linux-kselftest+bounces-13064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 269F7924058
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 16:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9D71C22ED2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 14:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB451BA077;
	Tue,  2 Jul 2024 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZf3GYlv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ADD19DFAB
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jul 2024 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929872; cv=none; b=J1/k59h+TOscH1mqOQidGNzrC8BgWG9jjaNnCftHpgWxXo1sBYYcfMpw061Q49djrS5K2ulQVYkBtMYTTxDx13L1jnzIkh6HSX/pII1MaCK4FcKgsiYfv9yRWHP6qah777FIi29A+gDh+148+uwTumbr1aTFhqp2vMEDuDOUCj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929872; c=relaxed/simple;
	bh=Z3bX1ChqHo56rpTGVon7MaAxxB9empFscQlQSgayDl8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gOCu7n2PSM/eu3VvRNWfbQRWYiaJoGMOqLeruyMu+pkfAHCMzQMEVSrEnv9StL7bWvJotnmEdEhKyiWIhYBZLJz558ytX/yb1XnIDphsXQ/SfxlUiY4e0DN/wdjYKwROPF3MPxn7r6nXkZQ++2nqvxWGtiVJGoKfRBapmN2U8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bZf3GYlv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719929870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ued8NE/q8zXpL0TRng1QPMxjOe9iz1whmao3wS1ySBg=;
	b=bZf3GYlvh0yumxcvTlQmKP0YaIAXVA58eDNtroHTRlar+Qosp52x9m9EAeso5Dc1nuRQ4/
	PLxj+KlhHlRE0dgUnjXW1lm7MHNsA+a/uj3qMGeRBJv1sQJMecGQb9A8u6roAe0PCabYzD
	V12I61b9WF5m6YurM4xie55EBVjZMdo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-AQxkdRLwPX2W5AKEfrMi8w-1; Tue, 02 Jul 2024 10:17:49 -0400
X-MC-Unique: AQxkdRLwPX2W5AKEfrMi8w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4255f5fbfc6so2155355e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jul 2024 07:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719929868; x=1720534668;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ued8NE/q8zXpL0TRng1QPMxjOe9iz1whmao3wS1ySBg=;
        b=IwPxkoMIpdYy7+8daR6Dg7G6pLKiICJ677WNU7WTah8huc4DeWjqvaaUEVrLvKJUc4
         hpSMUvzrqDBFMdlXrujLAAw+RoS5M4OVyRrcHRD5q2N6OoNBBzpbcAkLQrO/FJm2LjzR
         ARgvUtPYudbssrNVNRPUdVGY1FslgvCaHkhoyjOiIi+QKByT5J/apk1tcafRM9BS3kfJ
         CqmLkk/faZuhE/uRtciTdgsnNbfHhW2JU82vyUATRYBd6hGDlA/p+fQXAKMhPrIP9PxN
         y7M9xlEzFSBOT+C4UhXIimIDXZGLaFZELJoyRL3mzKTcnlf6jigNflBHtjwjL+V8P5rm
         rjaA==
X-Forwarded-Encrypted: i=1; AJvYcCW0Uw7AyaPHd3WEGO+xPT1bf2FXt3rSF/wRzqwdUOq0c7cvdrTDDbvLfsRtJi3BImYHAQOlYiwdbovzTwOMWJWC2MaoCB0sbsCsMRbatYUp
X-Gm-Message-State: AOJu0Yx1CXzdZ2L7an994Ef8dH2ZP48otIaVNKW8RBgTEDUJKbsvPGg0
	EarNm+oOlKHSLSoVRPt1jLsRh7ovFgAGcf23MXS9sF2s3GBiOvVidFhNTWQkMkTGbtfMfXRS6X3
	rtrfmCIHLLutDDK/MxEaY3vrPpFFsEia8xGdGOr+uEP8mlPQzsejzLCS+jyk0iuLwBw==
X-Received: by 2002:a05:600c:4fd3:b0:422:78c:82f6 with SMTP id 5b1f17b1804b1-4257a0df29dmr65490455e9.3.1719929867943;
        Tue, 02 Jul 2024 07:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbWk8I4Yl1h9HU7fJ8yjrwVSLYofO39SP2rdrxUuS5Wy6cRR2zvMHL+Gj2TSgNve9bWyjhzw==
X-Received: by 2002:a05:600c:4fd3:b0:422:78c:82f6 with SMTP id 5b1f17b1804b1-4257a0df29dmr65489935e9.3.1719929867495;
        Tue, 02 Jul 2024 07:17:47 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0a6:6710::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42581bd5e4bsm94460405e9.10.2024.07.02.07.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:17:46 -0700 (PDT)
Message-ID: <dea693fdd35692e3542466868fb3b979c1b23593.camel@redhat.com>
Subject: Re: [PATCH net-next v15 03/14] netdev: support binding dma-buf to
 netdevice
From: Paolo Abeni <pabeni@redhat.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Richard
 Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,  Shuah Khan
 <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>,  Shakeel Butt
 <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn
 <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Date: Tue, 02 Jul 2024 16:17:43 +0200
In-Reply-To: <29c65e23b88002eef6b2a8c272357fa2b2a661b6.camel@redhat.com>
References: <20240628003253.1694510-1-almasrymina@google.com>
	 <20240628003253.1694510-4-almasrymina@google.com>
	 <29c65e23b88002eef6b2a8c272357fa2b2a661b6.camel@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 13:08 +0200, Paolo Abeni wrote:
> On Fri, 2024-06-28 at 00:32 +0000, Mina Almasry wrote:
> > +int net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf=
_fd,
> > +			   struct net_devmem_dmabuf_binding **out)
> > +{
> > +	struct net_devmem_dmabuf_binding *binding;
> > +	static u32 id_alloc_next;
> > +	struct scatterlist *sg;
> > +	struct dma_buf *dmabuf;
> > +	unsigned int sg_idx, i;
> > +	unsigned long virtual;
> > +	int err;
> > +
> > +	dmabuf =3D dma_buf_get(dmabuf_fd);
> > +	if (IS_ERR(dmabuf))
> > +		return -EBADFD;
> > +
> > +	binding =3D kzalloc_node(sizeof(*binding), GFP_KERNEL,
> > +			       dev_to_node(&dev->dev));
> > +	if (!binding) {
> > +		err =3D -ENOMEM;
> > +		goto err_put_dmabuf;
> > +	}
> > +
> > +	binding->dev =3D dev;
> > +
> > +	err =3D xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
> > +			      binding, xa_limit_32b, &id_alloc_next,
> > +			      GFP_KERNEL);
> > +	if (err < 0)
> > +		goto err_free_binding;
> > +
> > +	xa_init_flags(&binding->bound_rxq_list, XA_FLAGS_ALLOC);
> > +
> > +	refcount_set(&binding->ref, 1);
> > +
> > +	binding->dmabuf =3D dmabuf;
> > +
> > +	binding->attachment =3D dma_buf_attach(binding->dmabuf, dev->dev.pare=
nt);
> > +	if (IS_ERR(binding->attachment)) {
> > +		err =3D PTR_ERR(binding->attachment);
> > +		goto err_free_id;
> > +	}
> > +
> > +	binding->sgt =3D
> > +		dma_buf_map_attachment(binding->attachment, DMA_FROM_DEVICE);
> > +	if (IS_ERR(binding->sgt)) {
> > +		err =3D PTR_ERR(binding->sgt);
> > +		goto err_detach;
> > +	}
> > +
> > +	/* For simplicity we expect to make PAGE_SIZE allocations, but the
> > +	 * binding can be much more flexible than that. We may be able to
> > +	 * allocate MTU sized chunks here. Leave that for future work...
> > +	 */
> > +	binding->chunk_pool =3D
> > +		gen_pool_create(PAGE_SHIFT, dev_to_node(&dev->dev));
> > +	if (!binding->chunk_pool) {
> > +		err =3D -ENOMEM;
> > +		goto err_unmap;
> > +	}
> > +
> > +	virtual =3D 0;
> > +	for_each_sgtable_dma_sg(binding->sgt, sg, sg_idx) {
> > +		dma_addr_t dma_addr =3D sg_dma_address(sg);
> > +		struct dmabuf_genpool_chunk_owner *owner;
> > +		size_t len =3D sg_dma_len(sg);
> > +		struct net_iov *niov;
> > +
> > +		owner =3D kzalloc_node(sizeof(*owner), GFP_KERNEL,
> > +				     dev_to_node(&dev->dev));
>=20
> I'm sorry for not catching this earlier, but it looks like the above
> allocation lacks a NULL check.

FTR, given the size of the series, the number of iterations already
done and the issue not preventing the functionality, I agree to merge
the series as-is, and handle this with a follow-up.

Thanks,

Paolo


