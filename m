Return-Path: <linux-kselftest+bounces-12649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF42916A02
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 16:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943BB283254
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EEE16B3B9;
	Tue, 25 Jun 2024 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XrmAm4Zn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2CD16C445
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324979; cv=none; b=mTM7iL1SbE3kCHym3FWyuvLXm3QaGXQar6ushehQF2j15F0ayNhx3hshgSEzNUkKyUAzPn10yThD46DmTx1v35IF7hW+x4q6Hktd/Vt6NYhQDoHexflN8mQQiXK4A+Fqw2kNJ6pXHGqRIItXsvbNX5WJ8WtnK/greEOl/l+Q4HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324979; c=relaxed/simple;
	bh=v5/BN7Hm8eXOX6GvRiGj1yPcrrgAcTj4SdgdQ8HMC7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJoA+J2y6Mn/yZ9LDZelwWlQrabVzFWDK1j6a9KbU9a//hH3iuuBwLvG0gyHUWuOhHQ0ZADZdymRbHRN5+yNtYva+TVvTOKMMe5Pm0ATV2IOuYagD1wycNl2Y7XV3xvKaygWztNS7+YBVtYO/MCf1EYmqUiT+tLb05DmlwamoUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XrmAm4Zn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d07464aa9so5516052a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719324975; x=1719929775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txMg1yBI3C5zZj9b3iG0sb1mrfRfqVzlgNpFi+lwATA=;
        b=XrmAm4ZnuPZsds8goEsBqhaSPIYUvOrk8KVPEdyLOM8DaJvKaMPf02E2qZvz+UhwAt
         +LNFYndIu2JZLK1y+1xMlO/MXDsPWd29gc8q2gq2dikadLZKz3PaDGs5ChJci8uMRsww
         N2Q6ZQKplfjNusvGP7O00VW7OWbxsoEJunwmsjeol2i9p7bWkvizmqoXxPvXLsU3CEy8
         gu8cFUkKOI4ytWpF854FQjENXdJtpLKXMFy4zNzj86ifZ9Yd15dad061OSRorXmlEzbw
         tmp4H9VwUrQaFs4yLu5aO0AtPmv4ty2XnIoZH9c0rWIvPN0AYt5tT/HNTJGblNQ809aU
         nJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719324975; x=1719929775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txMg1yBI3C5zZj9b3iG0sb1mrfRfqVzlgNpFi+lwATA=;
        b=FFaKdJcKluyl8pdHcBYgN++uhCHYxkYshA6B+sP8DWYE09M0mzYHrTXkFJho2M8rrP
         Vatx6gK45Lh1fM/2HZeT8sQBWf91ISHSU45beNeQjEiAaS9vSL3m8Hmg/vUZkjHZ+Cqo
         dkSUeXHUUf1zwWFsrHAjRAQ/0/wkx8eSaaX4Xj+d7tjnhO+0G9vGF8P2G9h0N1Fv0be3
         28gRTn/qEhoe0V3YL/bbt6J3YLggEYcgcjP3bnoG+1R8eO4ujI/fVtP7WYjdcUjN2yM0
         Ov+BRCooS0N5Y8BEZe826fJz6UCH91FipIj71n+feFp0T9oASLEJmJH0r9YEE/CWjszA
         oOMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuGGzurGSIJbc6xhKl+8UvZeTyU1Vq9ibOLOjmIT9mOJqNqMGQtb14sZWFOxXE2BdL0BEiNZ1zbAPtyG7KrLBVaMZw3gfN+aQNQdE9D6Xd
X-Gm-Message-State: AOJu0Yym8gH9XUDELr85nsJ2Q4TKB8EmnL2CjiKZuz7G0jJ1JO3hdqTm
	hiscFAPcUcISDeTsyDvKZqXGQbtk23wzRJNzlanUZbYOOWawn3iFyrfbhswZQpIi7ZNGCFEWmU7
	KiwNL52xw9H1qEk/1zkmMTD7n6ebKsApbBHAl
X-Google-Smtp-Source: AGHT+IFscpUDigK3sjiafRtyPgDq4I1SxTB/v4k5zCynhP82Entzul2Gkuvq6bg+VXWqgIpi6/XH2Nq4EJopbPxoaxU=
X-Received: by 2002:a17:907:c301:b0:a6f:5f5d:e924 with SMTP id
 a640c23a62f3a-a7245b4c9bcmr662856066b.6.1719324975303; Tue, 25 Jun 2024
 07:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625024721.2140656-1-almasrymina@google.com>
In-Reply-To: <20240625024721.2140656-1-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 25 Jun 2024 07:16:00 -0700
Message-ID: <CAHS8izO1g5vZodyvKBNyE-Fx7A4EoD70RuDLwXtzE3yvfRw_2g@mail.gmail.com>
Subject: Re: [PATCH net-next v13 00/13] Device Memory TCP
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
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

On Mon, Jun 24, 2024 at 7:47=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> v13: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D861406=
&archive=3Dboth&state=3D*
> =3D=3D=3D=3D
>
> Major changes:
> --------------
>
> This iteration addresses Pavel's review comments, applies his
> reviewed-by's, and seeks to fix the patchwork build error (sorry!).
>

This series is showing a inapplicable to net-next error on patchwork:

https://patchwork.kernel.org/project/netdevbpf/list/?series=3D865135

What happened here is that I sync'd to net-next, ran all the tests
including the allmodconfig build which took a few hours, then posted
the series. In the meantime 34 patches got merged to net-next, and one
of those patches seems to generate a git am failure when I try to use
b4 to apply:

b4 am 20240625024721.2140656-2-almasrymina@google.com
...
git am ./v13_20240625_almasrymina_device_memory_tcp.mbx
...
Applying: tcp: RX path for devmem TCP
Using index info to reconstruct a base tree...
M       include/net/sock.h
M       net/ipv4/tcp_ipv4.c
Falling back to patching base and 3-way merge...
Auto-merging net/ipv4/tcp_ipv4.c
Auto-merging include/net/sock.h

Not sure if I'm getting very unlucky or if this was something I can do
to avoid this. I think I didn't tax NIPA too much since it's an apply
error. I'll repost after the 24hr cooldown, sorry again.

