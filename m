Return-Path: <linux-kselftest+bounces-44-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA187E965A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 05:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7107D1C2030D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 04:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287423D86;
	Mon, 13 Nov 2023 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpHpwcNa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99CF8C17
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Nov 2023 04:54:31 +0000 (UTC)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BD71719
	for <linux-kselftest@vger.kernel.org>; Sun, 12 Nov 2023 20:54:30 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-45e777af839so1529598137.3
        for <linux-kselftest@vger.kernel.org>; Sun, 12 Nov 2023 20:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699851269; x=1700456069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulZUsxBjy/DYiq3mQzgGs9wuxEBLqLXZ1LrWDxA7qvo=;
        b=EpHpwcNa5850JC9ptPMc0rHEkmfFb//UmLZu6w4Zq62rCeX7YhQRh6151JLwbnNaqW
         FUBdTkFdrs8j+xIk1QpbfS95rXXzKa9Y8Su+L+EVSoep1a6MzC8GhTz1OJKX16uNIkoU
         oGxtrVmrXKfPnD/eXZmdQgK053n9cA07QVfIwiFQrqK0rr2N9sO1xKWjL09OxX74whju
         /y3ixDqG9xME0+Jh4drr1niRwhUJMsr3IZa4+IgCm36lSaMnsA5ZdU7wepg4/84iSmtq
         KWpRNM4BpAg6x+GqqgTmaxwvbUYTxUGr/Fqv9+HSFryVJX3oTVR8tvI8JNRLEmbo4JBh
         HUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699851269; x=1700456069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulZUsxBjy/DYiq3mQzgGs9wuxEBLqLXZ1LrWDxA7qvo=;
        b=tHb/H1fPbvfK8SV6w8hcsre+4bQWPsN7Vj6EJrxbkpV+TgzYTHGX2UoH39cDPz3qSq
         GHrUZcvaH4lG+pIm568my9PxwqdxgBTXUt2Z6WSOMIc9gRMaR6iMnG8tvWIyGsb/7LZd
         yIeUlBpSuQky5qq7jaoEnSnssefGAqyaQDiJAX4F4ZRSBO3kL0izOtMxUTJlol+PTPf3
         2mbsDMMIfMZ79CJ1TPUSGIz/HwVGXQx+6W8opuGf3NT6MG8pYHhlyshGCKaS+sn0gZi0
         qR3EthJ0PW/gJRvPnLNpEHnvv9qMokDLjhZW1IgIYKdwb2JAcoUGdaQeEK280R8CsY+1
         iovA==
X-Gm-Message-State: AOJu0Yz/J4hfeJQvn8j4EFifBsOZxmQ6sKMLRuR20Dv5FL1FBsDz++6J
	2TFnk2OcautVB3CxpG2wvA1yogJM/FNMDzBjA/6iXw==
X-Google-Smtp-Source: AGHT+IGBugYmcwQCmYo3XhrW53vx7SnsNtkGBEWopCzRD+dofX6GN+L1OxYsj2HtZsztRRSBDJnHEIwyfhi7gc94JeA=
X-Received: by 2002:a67:ab0d:0:b0:45f:4e67:4420 with SMTP id
 u13-20020a67ab0d000000b0045f4e674420mr2062262vse.2.1699851269262; Sun, 12 Nov
 2023 20:54:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-7-almasrymina@google.com> <20231110151622.2f45f618@kernel.org>
In-Reply-To: <20231110151622.2f45f618@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 12 Nov 2023 20:54:18 -0800
Message-ID: <CAHS8izMGNLM18TF1RCDBfdOXXpqseePA4_27qmQt-FsrFzGfdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/12] memory-provider: dmabuf devmem memory provider
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 3:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun,  5 Nov 2023 18:44:05 -0800 Mina Almasry wrote:
> > +static int mp_dmabuf_devmem_init(struct page_pool *pool)
> > +{
> > +     struct netdev_dmabuf_binding *binding =3D pool->mp_priv;
> > +
> > +     if (!binding)
> > +             return -EINVAL;
> > +
> > +     if (pool->p.flags & PP_FLAG_DMA_MAP ||
> > +         pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> > +             return -EOPNOTSUPP;
>
> This looks backwards, we should _force_ the driver to use the dma
> mapping built into the page pool APIs, to isolate the driver from
> how the DMA addr actually gets obtained. Right?
>
> Maybe seeing driver patches would illuminate.

The full tree with driver patches is here:

https://github.com/torvalds/linux/compare/master...mina:linux:tcpdevmem-v3

This is probably the most relevant patch, it implements POC page-pool
support into GVE + devmem support:

https://github.com/torvalds/linux/commit/3c27aa21eb3374f2f1677ece6258f046da=
234443

But, to answer your question, yes, this is a mistake. devmem doesn't
need to be mapped, which is why I disabled the flag. Actually what
should happen is like you said, we should enforce that PP_FLAG_DMA_MAP
is on, and have it be a no-op, so the driver doesn't try to map the
devmem on its own.

--=20
Thanks,
Mina

