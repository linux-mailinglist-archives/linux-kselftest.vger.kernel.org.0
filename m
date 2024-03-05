Return-Path: <linux-kselftest+bounces-5902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 717688718F5
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 10:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB9ECB2409A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 09:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6639535B6;
	Tue,  5 Mar 2024 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SUA7qEcP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dK6WqAJW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1635025C;
	Tue,  5 Mar 2024 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629509; cv=none; b=jLMkebHKu19+W/+rqGCDC47y3G9KZCUIQ8gd8Jbhh0yDiU9HW8go6sd9Q1rIgGwdCKre6zP/gQPoIvtNI3d6Nz6HusXlSTwOnPO5K6hM3oIUPjNHOLxdu+eKDB5QCDK8qgu8WxWrsTaM97SWtcCGMI4frwc6/QwjhdhtphAG1uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629509; c=relaxed/simple;
	bh=4vEnG02ligmP4LrcfFUAEQhjxpcNYEU0JASPzUPZp/M=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=OI7HcGOtHaAphoatAjA+1DDgwQxAeldkrMRefKnzo3G112Jk/ivKcweRdPFIPwP/pqmDUXByzyRIWtP/ojjH/QisoFH5fsfZp3Kpm0+iUaDsYNJV+GO0iLWn033aEfSsRzjibHYGxSqqvsc7G3HvhIqr0kveYWJZJEnQdtd5KQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SUA7qEcP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dK6WqAJW; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 22F5F1C000A7;
	Tue,  5 Mar 2024 04:05:06 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Mar 2024 04:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709629505; x=1709715905; bh=ekmA5RBZ+C
	vAhdFbvGw1i/0H90ih8Imy4vkxYH5RFbI=; b=SUA7qEcPhA1VtahsdC2df931yx
	WPbB2j3ZYmy701buT133pPpg1BhTzr7LF+TWNzdIkaWuMpprUFOS48zOhjCA8X4L
	QrZ0PgfUBHST7vlB23iK8TH+TnQdfOWnY8aOrjupIq/qqANsZJWFyvJpyjWg49XQ
	kjRXOzZoQ77VNo+thJ82UMaXMQWyNFyk79VVagp2IFPTRJrbjNr8CBts1AxVPG8M
	bjO7GLbM23jEwBjN3BWsei4NC56uzvQrCWHyScODnQymG6o+zFz4Vj3N2qCbSW81
	wItzocagCMHv3/TV7LNM6a5j/ru4N0O9LvD+qMa63R76kXfYgkWIAudRwfUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709629505; x=1709715905; bh=ekmA5RBZ+CvAhdFbvGw1i/0H90ih
	8Imy4vkxYH5RFbI=; b=dK6WqAJWMa4c4fjlHpghFjdIt3LMY3xxMkWUuukHuwfJ
	Fn5R3/jVLrvPK8HPH0xCLR/+EQRpUAFUnWeAiAO+ZCuiq7mxhTwCGwC3vudSRYpt
	MeEvo6I1Ro59HzaAWLL9L8NGtrxfmpvxyurfxdpMhbcqggJi2damWFe0e3ex8i8z
	Eqv+wuJnxl0fXLh/9OXryAC1UYrzcyYWGCIn8Zkc5jwx6wVXoHqm9AT52SlDjrOs
	0f100LdiAiVQXqNw0pVjgHTryUqiRWP7/Beoq04XH3IJ2YH6FjRUMC91NnB331QM
	8LzFD0JzIrOBD8QThpScqDeqGHRDE8eYEs7KAfNUMg==
X-ME-Sender: <xms:QeDmZYcmTl0_cUKPjzetyUgwCOJP16-giZuGRCd23Fcaod5mvwuasg>
    <xme:QeDmZaPNTc_AthIszgRYHzvvnFvvonjkI_CtQvZRuxXxbMGIW4iUjEpDMn314RxJy
    bedEwcNX31bqifDbbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheekgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:QeDmZZhYhQ4N-Vq4pFq8_Jb84muPkreZpR2XpPiBbPCfq5bfWtDhBA>
    <xmx:QeDmZd-0Yr0yXb4o9AIDX5bt4MvLmUCpkIyuHvt2PZ4e6x8RKq95Ew>
    <xmx:QeDmZUshX60bTjTnFeVR9hjLDGUNMOB81JWBVd_07wIqc9qNaUxp0g>
    <xmx:QeDmZSCXGxdi68ql_0o-PZ2wrqACrIJGaPXzq2fBVieFxYOJvISpL5s74vQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6329AB6008F; Tue,  5 Mar 2024 04:05:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5e2f9342-4ee9-4b30-9dcf-393e57e0f7c6@app.fastmail.com>
In-Reply-To: <20240305020153.2787423-6-almasrymina@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-6-almasrymina@google.com>
Date: Tue, 05 Mar 2024 10:04:45 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mina Almasry" <almasrymina@google.com>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Helge Deller" <deller@gmx.de>, "Andreas Larsson" <andreas@gaisler.com>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@google.com>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "David Ahern" <dsahern@kernel.org>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 shuah <shuah@kernel.org>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pavel Begunkov" <asml.silence@gmail.com>, "David Wei" <dw@davidwei.uk>,
 "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Yunsheng Lin" <linyunsheng@huawei.com>,
 "Shailend Chand" <shailend@google.com>,
 "Harshitha Ramamurthy" <hramamurthy@google.com>,
 "Shakeel Butt" <shakeelb@google.com>,
 "Jeroen de Borst" <jeroendb@google.com>,
 "Praveen Kaligineedi" <pkaligineedi@google.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "Kaiyuan Zhang" <kaiyuanz@google.com>
Subject: Re: [RFC PATCH net-next v6 05/15] netdev: support binding dma-buf to netdevice
Content-Type: text/plain

On Tue, Mar 5, 2024, at 03:01, Mina Almasry wrote:

> +int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> +		       struct netdev_dmabuf_binding **out)
> +{
> +	struct netdev_dmabuf_binding *binding;
> +	static u32 id_alloc_next;
> +	struct scatterlist *sg;
> +	struct dma_buf *dmabuf;
> +	unsigned int sg_idx, i;
> +	unsigned long virtual;
> +	int err;
> +
> +	if (!capable(CAP_NET_ADMIN))
> +		return -EPERM;
> +
> +	dmabuf = dma_buf_get(dmabuf_fd);
> +	if (IS_ERR_OR_NULL(dmabuf))
> +		return -EBADFD;

You should never need to use IS_ERR_OR_NULL() for a properly
defined kernel interface. This one should always return an
error or a valid pointer, so don't check for NULL.

> +	binding->attachment = dma_buf_attach(binding->dmabuf, dev->dev.parent);
> +	if (IS_ERR(binding->attachment)) {
> +		err = PTR_ERR(binding->attachment);
> +		goto err_free_id;
> +	}
> +
> +	binding->sgt =
> +		dma_buf_map_attachment(binding->attachment, DMA_BIDIRECTIONAL);
> +	if (IS_ERR(binding->sgt)) {
> +		err = PTR_ERR(binding->sgt);
> +		goto err_detach;
> +	}

Should there be a check to verify that this buffer
is suitable for network data?

In general, dmabuf allows buffers that are uncached or reside
in MMIO space of another device, but I think this would break
when you get an skb with those buffers and try to parse the
data inside of the kernel on architectures where MMIO space
is not a normal pointer or unaligned access is disallowed on
uncached data.

        Arnd

