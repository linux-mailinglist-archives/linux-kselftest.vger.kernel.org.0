Return-Path: <linux-kselftest+bounces-6115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CF9876B6A
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 20:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674D128267E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 19:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6EA5A7BB;
	Fri,  8 Mar 2024 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FQIcIjit"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1DB5B5B3
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Mar 2024 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709927618; cv=none; b=Wzk7YmvudXBHqgUwEv1xSkza6Kl3lE6isUdxcG9LybzUujxfM14oh3R3RDI0jTx/YFNfKXKkg7+8QrLzaTfSfHqqlAS2Ug0BZfjSProbSI9THFbByO7T4uGFpVf7pJtNx6y242Y78jCTk0BuTQU1FkqgrNtMLca1u8NlWJPgbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709927618; c=relaxed/simple;
	bh=+JPchmRbdEWp2hPvsQ8mwR8SsWihb9svN/keL3PqCmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNELoVriSqaXuxv7hJMESi54NuTYqmennM0Vn6KPWj8iI2xt/GZwzh+JExcZzQflZ1gU1AGiMa+vYfYc/7ck5LFn/S8a5/SfQTaf/FfZBVvmPtMKarWE2L+2sIlW39JteRJpjhuwyAYe4WZSFPyCI5Y9W5hYrCEa7ETSkaSe3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FQIcIjit; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a450bedffdfso335985066b.3
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Mar 2024 11:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709927613; x=1710532413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd2ZoV00c/hvjjV6TuUocydSDT4SN2a80zpBvuI43a4=;
        b=FQIcIjitCXslDz2GbbUrP/Dl2A1fHjodIwfcVwX7edPGJjzUe6ft0Dzx4S5sFwe1Vh
         g88zviT2eLf5PmHmjVJB2aNpgv9n3ocJvS72MSrLxPfMODNwXkIqGml7VkVhyDJXPZ65
         MjMUs4Lqmk59C5q9pviF7lrr5HVfpNnp9VtqWc7ZvnuMI0EGx3Q5NM/4uZGay3xcEJFy
         qYcxb+eRfAcYnwP/UVfmW9ErY4qC/DPOwckI+rRsS39kszwhkv8lEpCyJ9PUorpE+Wmk
         8YbTN6+zdx0SrM+L7muhYuk5uJr4h+Hit4pCKYkJfFmlBE74LLcVw8ZHHf4d82NY4qR1
         jV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709927613; x=1710532413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pd2ZoV00c/hvjjV6TuUocydSDT4SN2a80zpBvuI43a4=;
        b=oNwCHnD41GnnEx/g9ptBETfX4kej1pZOm1VTCfmeVjmGhnbAJuOydzK81vbHsoOF8M
         qQUV923swOTbbKxZxgN3aE2YBIym5CcuSwqmpKe5Y5TKAMxd/6mnb/4J8vhQa4RWPZcC
         llTIgSVbo4csEls9owq8w5EEPIXjjdmc70CSBJhpssUmxXv+fRK45FAitCUHRDLK/jEQ
         So+oT3fzzfaYfTV+pQOzgUQ09eQN8D7hua0l2ODLRw5eWKIctIU30al1QRtkBuwMiXCE
         BVepmeheHOZbE9PGo9xh7LSKG5b4t+LaK/12SWG5o8/fd2t4Vngouv9GELURYqg8ODkf
         CUpg==
X-Forwarded-Encrypted: i=1; AJvYcCUuH4+ze/N0hECXCCnpyBgqB5+7pKavUuleMvZdFzuTFkPbRb5AkfyJT8Eq95dNgkurNIyhiJE7PfzyALEFDUO65t+tzFCyHUcAVhgw6WrL
X-Gm-Message-State: AOJu0YziBVR9tqk167qHaBRjXaSB/T8IhAg3RJ3v2HugRmEs9KWlvEAc
	jGzVtZszx06cNfZO1S7fkIuvVQelulwfUONQ8wdZt7vyAZrM7S6ZU3k2LwnTF5wLyD1IFIBZKtn
	E9nk1ENdgj1/uGqLWX8BqRt3t8o9CWlnKUt2V
X-Google-Smtp-Source: AGHT+IGdfTizwHQnCpRk5GeSjOHjssHLcb+cVFlrr45NHBDRApEdAye6AN9i0+rO/lWinEjVvgcrkAuNBm/bbSNX5ic=
X-Received: by 2002:a17:907:76d7:b0:a3e:9aa3:7024 with SMTP id
 kf23-20020a17090776d700b00a3e9aa37024mr57660ejc.34.1709927612751; Fri, 08 Mar
 2024 11:53:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-3-almasrymina@google.com> <15625bac-dfec-4c4e-a828-d11424f7aced@davidwei.uk>
In-Reply-To: <15625bac-dfec-4c4e-a828-d11424f7aced@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 8 Mar 2024 11:53:18 -0800
Message-ID: <CAHS8izMC=q_DuR94i-NCKFVsW0JadX7NEbDfyT8PfG3tBwPv-Q@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 02/15] net: page_pool: create hooks for
 custom page providers
To: David Wei <dw@davidwei.uk>
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
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 8:57=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-03-04 18:01, Mina Almasry wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> >
> > The page providers which try to reuse the same pages will
> > need to hold onto the ref, even if page gets released from
> > the pool - as in releasing the page from the pp just transfers
> > the "ownership" reference from pp to the provider, and provider
> > will wait for other references to be gone before feeding this
> > page back into the pool.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > This is implemented by Jakub in his RFC:
> > https://lore.kernel.org/netdev/f8270765-a27b-6ccf-33ea-cda097168d79@red=
hat.com/T/
> >
> > I take no credit for the idea or implementation; I only added minor
> > edits to make this workable with device memory TCP, and removed some
> > hacky test code. This is a critical dependency of device memory TCP
> > and thus I'm pulling it into this series to make it revewable and
> > mergeable.
> >
> > RFC v3 -> v1
> > - Removed unusued mem_provider. (Yunsheng).
> > - Replaced memory_provider & mp_priv with netdev_rx_queue (Jakub).
> >
> > ---
> >  include/net/page_pool/types.h | 12 ++++++++++
> >  net/core/page_pool.c          | 43 +++++++++++++++++++++++++++++++----
> >  2 files changed, 50 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/net/page_pool/types.h b/include/net/page_pool/type=
s.h
> > index 5e43a08d3231..ffe5f31fb0da 100644
> > --- a/include/net/page_pool/types.h
> > +++ b/include/net/page_pool/types.h
> > @@ -52,6 +52,7 @@ struct pp_alloc_cache {
> >   * @dev:     device, for DMA pre-mapping purposes
> >   * @netdev:  netdev this pool will serve (leave as NULL if none or mul=
tiple)
> >   * @napi:    NAPI which is the sole consumer of pages, otherwise NULL
> > + * @queue:   struct netdev_rx_queue this page_pool is being created fo=
r.
> >   * @dma_dir: DMA mapping direction
> >   * @max_len: max DMA sync memory size for PP_FLAG_DMA_SYNC_DEV
> >   * @offset:  DMA sync address offset for PP_FLAG_DMA_SYNC_DEV
> > @@ -64,6 +65,7 @@ struct page_pool_params {
> >               int             nid;
> >               struct device   *dev;
> >               struct napi_struct *napi;
> > +             struct netdev_rx_queue *queue;
> >               enum dma_data_direction dma_dir;
> >               unsigned int    max_len;
> >               unsigned int    offset;
> > @@ -126,6 +128,13 @@ struct page_pool_stats {
> >  };
> >  #endif
> >
> > +struct memory_provider_ops {
> > +     int (*init)(struct page_pool *pool);
> > +     void (*destroy)(struct page_pool *pool);
> > +     struct page *(*alloc_pages)(struct page_pool *pool, gfp_t gfp);
> > +     bool (*release_page)(struct page_pool *pool, struct page *page);
> > +};
>
> Separate question as I try to adapt bnxt to this and your queue
> configuration API.
>
> How does GVE handle the need to allocate kernel pages for headers and
> dmabuf for payloads?
>
> Reading the code, struct gve_rx_ring is the main per-ring object with a
> page pool. gve_queue_page_lists are filled with page pool netmem
> allocations from the page pool in gve_alloc_queue_page_list(). Are these
> strictly used for payloads only?
>

You're almost correct. We actually don't use the gve queue page lists
for devmem TCP, that's an unrelated GVE feature/code path for low
memory VMs. The code in effect is the !qpl code. In that code, for
incoming RX packets we allocate a new or recycled netmem from the page
pool in gve_alloc_page_dqo(). These buffers are used for payload only
in the case where header split is enabled. In the case header split is
disabled, these buffers are used for the entire incoming packet.

> I found a struct gve_header_buf in both gve_rx_ring and struct
> gve_per_rx_queue_mem_dpo. This is allocated in gve_rx_queue_mem_alloc()
> using dma_alloc_coherent(). Is this where GVE stores headers?
>

Yes, this is where GVE stores headers.

> IOW, GVE only uses page pool to allocate memory for QPLs, and QPLs are
> used by the device for split payloads. Is my understanding correct?
>

--=20
Thanks,
Mina

