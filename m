Return-Path: <linux-kselftest+bounces-12913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E0D91B749
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 08:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E112878D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 06:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1952613211E;
	Fri, 28 Jun 2024 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wXCQVvtF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AFF85938
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 06:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719557123; cv=none; b=pE8oEgN6xBuspFG43PKjfuLyh4xvXurEcyq6IwVfOtpTpuyuBq0JizJLw0JAht5940F0XXvFSBbW0V+NvUsZ4jelkyfg6a7Y/ZS5Zyp/3D8zYTcOJo4FcAjRWqpmh0xZTRR99Bw+UwagOp3Xk0yPuXhoWmNB8tdanGQRCOnn70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719557123; c=relaxed/simple;
	bh=1LIMHyLJHkU5Pdd3kNxkaT+1GkvFT9KTRc7qGcJF3Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwFL+XLS0M8Ddy/SKbmH+xuRGNL6oHgYQR3q2y+weCmagdi6U7lrfQMc5OmVYUb/TMAVzpWGajqOAgE6k9hCSmEuzELfUZNmik1kfEMfpzY+PLhjadqNe/JTrMBk4oCVt67foqWxEfM8l7ieCWI3j+URHwimuEM2H1ZRFAAsW6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wXCQVvtF; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e7d2278d8so126136e87.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jun 2024 23:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719557118; x=1720161918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LIMHyLJHkU5Pdd3kNxkaT+1GkvFT9KTRc7qGcJF3Ec=;
        b=wXCQVvtFPqUR7I1RyjWA2St1Wunfyj27FdS5BVtZFjlnAlE+KoAdctvKLiIdii5qvd
         3pPPH8pKbi5UeZACOrdFUPFGuKu94nfvmtAHbvUFDFKC7m6QhMHkeaqIM0MsampeIEjg
         DrIOSNB3IpUyKScyhyWhDVhN3BgCWNRDPUyI3ErfsvBnLmJLa/1jwPQp1O5/DDEJREu8
         I+eAWDaQsZfeYnd9KSxFhFrQH4ZFegrdKAWOj0kd5PM7wu1YdKhrmsFTDXBd9npvxFxW
         35KAIsB5OloY7G2vdTBKIYDfbEaLfRKtB8bPq54f5EEkgAFdPoqD7zCU0WvSrzxLC4xP
         A16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719557118; x=1720161918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LIMHyLJHkU5Pdd3kNxkaT+1GkvFT9KTRc7qGcJF3Ec=;
        b=jTi27qDD0CVRJJtdeom3HTN2lMck7Fm9ClDWgsB+WylOvj1i8YqMpmhSmW74DIeu3l
         P5o/iukX7ChWOMqR3N8qDoJ4Zf6/yRzIwKpvxhsE1MHNE5HDz7Pu4CauJGn8CXa5fyeZ
         JKaAp72X5cFhOI0p/hKFe90iQ6bgvbeLCRzRlx6WC0HiX5P4GfiJCYcj0PVSz9HzfpCJ
         fcKHSD3QjCUaFYHNHR/jO02KX8Kd2TPH0e77Jzur6lvwwmpu1GMDDQaeu34dJpO6vaKG
         ZpO7ghgQpw4fEzT9BfHmd70NEDWMvNvyos5GmuyXuiu4xVPlaJq+wLwI+ybcCgf+djpA
         pYQw==
X-Forwarded-Encrypted: i=1; AJvYcCVrtZx4+XYR+eE7LMvv0xDLrxH0b+61nibTdDyjeiQFVOsKSmtrEbqQ8zwGobTJVGVogaxv308StZGLvx2h4NByuK//UYrQzGab5LQeDUIu
X-Gm-Message-State: AOJu0YzHBzPYnKa1eo77iM1xbLW3HJTd2/l8XI731aB+WLqR7F9jvzcg
	1SkK+WcaNtw6EmonVG5PDw53siEr4VMHkDyxjrSIH7OK88QyDOjt1BQ1QCCQ+WBR1j++FDwZFhh
	F3B/kgEdNg5436DLLPr6Z5RpzrNgfrb+Ve+uJ
X-Google-Smtp-Source: AGHT+IFzoWsdn3M+XFfrkT8kZLzSfZp/lZeDCR97JMMrDEnf+uiFKANkVEhRvPu3Ts+wC5+Q+DppqxOk60nnma26g80=
X-Received: by 2002:a05:6512:110f:b0:52c:df8e:a367 with SMTP id
 2adb3069b0e04-52cf4dafc54mr7327684e87.53.1719557117907; Thu, 27 Jun 2024
 23:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com>
In-Reply-To: <20240628003253.1694510-1-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 27 Jun 2024 23:45:03 -0700
Message-ID: <CAHS8izNTLc1NP13Y5irKOS47ZLOOjwfAjmRFY5pFATfZGZ30yg@mail.gmail.com>
Subject: Re: [PATCH net-next v15 00/14] Device Memory TCP
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Pavel Begunkov <asml.silence@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, daniel@ffwll.ch
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
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 5:32=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> v15: https://patchwork.kernel.org/project/netdevbpf/list/?series=3D865481=
&state=3D*
> =3D=3D=3D=3D
>
> No material changes in this version, only a fix to linking against
> libynl.a from the last version. Per Jakub's instructions I've pulled one
> of his patches into this series, and now use the new libynl.a correctly,
> I hope.
>

Gah, I forgot to carry a couple of Reviewed-by's from v14.

Pavel Reviewed-by "net: add SO_DEVMEM_DONTNEED setsockopt to release RX fra=
gs":
https://lore.kernel.org/netdev/09bdd7e5-75ca-42d5-8e59-a8ec05da89c7@gmail.c=
om/

Pavel Reviewed-by "tcp: RX path for devmem TCP":
https://lore.kernel.org/netdev/6524676c-fbc0-4ea0-b320-f605d34da007@gmail.c=
om/

Nikolay Reviewed-by "net: add SO_DEVMEM_DONTNEED setsockopt to release
RX frags":
https://lore.kernel.org/netdev/1d0483b9-13bc-426e-a57a-69044d5098c1@blackwa=
ll.org/

Daniel Acked-by "netdev: support binding dma-buf to netdevice":
https://lore.kernel.org/netdev/ZnvM_gtscO7q9P2Y@phenom.ffwll.local/

None of these patches changed much since v14, I just forgot to add the
tags. Thank you very much for the reviews.

