Return-Path: <linux-kselftest+bounces-13024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2059D91E819
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 21:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A9D1F23660
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 19:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5F816F291;
	Mon,  1 Jul 2024 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUj8CS78"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2890616E876
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Jul 2024 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860462; cv=none; b=WpLK3J5H+x9fAwjq8USZznqL1eyVIgOgVs2jC8vie+xWkgYCv//RRkfpa94emQyXDd9iqehsalzUX/juk8llAG8vC4aJoxKQiH9/1YQXm9O6MW1GwbZdx95d7vNMPwk4RumjAr/rwqIyJUFG+miqWkZRmIPq0unkiAjav9yfeNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860462; c=relaxed/simple;
	bh=nBEjUU1jP0cTXpDAibWGkU5XKOL/L/nsa6YcOdFrVXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmggdHue7V4wJg9vbvaEg5iCusBq7v/IRy9ctcqrotXuGcNOqVlNOLNcxTzMoQMekQ0ep7+yuOD4CfSu9p3nvWgfJQwzHf6rGBubfi4fe8GrqtUpdqWgjXWwzUWuVoN7oBDKj+E1I9iD20pmw1soi01ytPHKH7j5/T5xEh1VYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUj8CS78; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79c084476bdso310456385a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Jul 2024 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719860459; x=1720465259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4LpFR6VRPZBJqkm7iRXIp87VCy5+OyuBQMHBVpgrKc=;
        b=VUj8CS785cnwFWXu49a2yynTw9v5uBv7xV7sGzsKtbIvoTNL6XebeeShoCz1c7N9c6
         QOGHor2VqLzp0K1m3SZv/SBZFaz2CHuoZ8oXsw9KXCDQBvxqwRikiIBLCAwCxlrGz2/X
         hc5nYlLBRPdmRh7yHptNjyDMOkgHY7SjCvJS28YqP94iKO8zw4Mki7+1k4fCVqn2nprb
         AiEC6vWgc/hFEkSr2d8vF6MUm+f6Rooj1daMQNmskdu5fEMYG+P6YjIjLh3es+Yqqrz7
         2lha05Ab6XzuOpNcXnRqBElcdyOWL4r79CX5gf3ok4YE8CL5mfO8kfLJtqzYR8j0qAh1
         t3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719860459; x=1720465259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4LpFR6VRPZBJqkm7iRXIp87VCy5+OyuBQMHBVpgrKc=;
        b=nlTkxtLxc90oRFUYiXqF9Lgv/3zFZohcNJYE/Q45/RlevE6QB9ioqoISVarkMWoxBv
         PRCxlb6uZVHrYvNVuPPgdpMndp1KWIMxIEHOu6EGpDP+Em33JABedaUseGIwN6fhtudK
         VFPaHMOPFo7P+m4D3EDtGwA7XLH67zQN0FMjGR+vLF/GppdauISR9m9qT45YrPsvwBsM
         VWhnZeZvHDayYe+roO2BKkRps+bh/+mb1HLVte/ec30cf91SfXt/dhFfhk5v6e2WYxA8
         o+oQ0usbg7QUkfglLoevW7qsEtEf1ZsUM1b6rpDbn3Ld4xBol0srulrhzDcNnpEfxaXK
         GWcg==
X-Forwarded-Encrypted: i=1; AJvYcCVXM0pmF5jRVvmlgT0N6VD+wCvIJwPRfjYBEbwMT9KYLowffOPQBorZ5LhduwU88+x1ALbG8DVisU9+ogxFT6N+wEuaCCTSWs8e/AvwF7VI
X-Gm-Message-State: AOJu0YxKSzi1WuldYsVYghXXH2hlXXMuzP7JLkdrt8cNgYnRw+ZdctSO
	lRnXOCJz4isLloTLZlzmgvjFQVw3XzbCJwBBnwAkITMPErkKQnvPP21Gk0LNIxfxlgcXVQnjyiu
	d4zklk1BDf4vk48/RqnZvvn1CBegiC/Zvr72S
X-Google-Smtp-Source: AGHT+IHqGzU9tZFX9QqaBsD++nA7soWtr02PwwhDHubls3yJUOnaqW81EaDVu4zWNv2Iw9IsPTEVGjOAs2RkVILAwGg=
X-Received: by 2002:ad4:5c68:0:b0:6b5:4249:7c4 with SMTP id
 6a1803df08f44-6b5b7057b8emr78735846d6.2.1719860458778; Mon, 01 Jul 2024
 12:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com>
 <20240628003253.1694510-13-almasrymina@google.com> <m234oxcraf.fsf@gmail.com>
In-Reply-To: <m234oxcraf.fsf@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 1 Jul 2024 12:00:44 -0700
Message-ID: <CAHS8izOUJMnCxK0ZfOOOZH0auNF_Kk+WVA=oTEzJe8mYHdonfA@mail.gmail.com>
Subject: Re: [PATCH net-next v15 12/14] net: add devmem TCP documentation
To: Donald Hunter <donald.hunter@gmail.com>
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
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 3:10=E2=80=AFAM Donald Hunter <donald.hunter@gmail.=
com> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
> > +
> > +The user must bind a dmabuf to any number of RX queues on a given NIC =
using
> > +the netlink API::
> > +
> > +     /* Bind dmabuf to NIC RX queue 15 */
> > +     struct netdev_queue *queues;
> > +     queues =3D malloc(sizeof(*queues) * 1);
> > +
> > +     queues[0]._present.type =3D 1;
> > +     queues[0]._present.idx =3D 1;
> > +     queues[0].type =3D NETDEV_RX_QUEUE_TYPE_RX;
> > +     queues[0].idx =3D 15;
> > +
> > +     *ys =3D ynl_sock_create(&ynl_netdev_family, &yerr);
> > +
> > +     req =3D netdev_bind_rx_req_alloc();
> > +     netdev_bind_rx_req_set_ifindex(req, 1 /* ifindex */);
> > +     netdev_bind_rx_req_set_dmabuf_fd(req, dmabuf_fd);
> > +     __netdev_bind_rx_req_set_queues(req, queues, n_queue_index);
> > +
> > +     rsp =3D netdev_bind_rx(*ys, req);
> > +
> > +     dmabuf_id =3D rsp->dmabuf_id;
> > +
> > +
> > +The netlink API returns a dmabuf_id: a unique ID that refers to this d=
mabuf
> > +that has been bound.
>
> The docs don't mention the unbinding behaviour. Can you add the text
> from the commit message for patch 3 ?

Thanks, will do, if I end up sending another version of this with more
feedback. If this gets merged I'll follow up with a patch updating the
docs (there seems to be no other feedback at the moment).

--=20
Thanks,
Mina

