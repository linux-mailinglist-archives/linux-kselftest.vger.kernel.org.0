Return-Path: <linux-kselftest+bounces-13335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CAC92AA5B
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 22:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFCA28143C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 20:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE914BFA8;
	Mon,  8 Jul 2024 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nvt70lDq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BCF43AC0
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Jul 2024 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469300; cv=none; b=T9Po92QBh6kxOsB6Ly+MYmNgSHtRAkFmUlDZArCbpiCtVX6hx+AokbBRboTLgRpFeVxRd1FE6S5olPq3BrvBC+ae7+UJtY4SiNWqNZcfRV/ojiLc51hPhvylq2399wHeKf7w0w3Oeni/ORZpcD6zV3lQwpzyxvmswfDC+i/znzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469300; c=relaxed/simple;
	bh=ZRZU9TG8IKJPir335kv6uvmf5/6XvlnF0lVWn7S/s+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmXtTDAgfQCn3ZCZylUHpG4V1vMePhArfiTAZMvbKONzGPYgcnZifbRd3SmjU/g0Aqyy6J2NP1xtJu8sskc6D3XtURN3d0QfuEW7939lC9nAg3gbzTcKxl2hIpmFUx4PB04ppTH0+KpZGMKzKiQM7B5y5O0dNFItuH/nVXFVEYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nvt70lDq; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b61bb5f6c0so1424936d6.2
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Jul 2024 13:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720469297; x=1721074097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef8kYUavZDQKnlAolqYPRC/e9sM3ztTKFUbqIbLKTok=;
        b=Nvt70lDqisNpfwC9Q3U8CpMPR/mXlio5gK5xUUEULro9iTsTMaVhWouG0PNbjJ764Z
         XmuqOmW4OjLY/v8ncqtpAZLDqReczDacqRUd29wMBjK/Pl4UMDLOac/fYtgDxnPuoJuk
         IvS6KFzrbX1CnMTF0cH7coo7IaDMyw1XZt115Qc3Z1r/aqwK4LbCLyhPxSQ+MKzH0BRY
         su7qtvbvu/b/Gm6/C3zgPrrezPL6pUG/2KhsGXdSNhifEyjUHDw42lqBmvOsllSmGx37
         m7jNmIPpAZLTMJS3tYsSuWUEADMiOD8uidBdDgUGHbJGi7yFwJGzzteXip+0OASqNo2g
         7E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720469297; x=1721074097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ef8kYUavZDQKnlAolqYPRC/e9sM3ztTKFUbqIbLKTok=;
        b=EwZI48SaYsRZTqETfOzmzbP9Lwb2aUvmM+4mzv7jqd259v37O3L7Wy4CoIfD1kzJly
         ZNL5LX5TSKwO4NSM0ePXdU3VzH63EmKohMNojiAUPj+NR+zlODmx482ujUa2xb6iHYyF
         7olEUc8ORdEkN9BU4/PSEosrrHVNZP7JS/x6BhxETdE2UBBiKdPnFbXTseM7Ln57Trtf
         sNAGYAykqi5B7LKOIR/MFqRrAmsC8COciK++dMEI3dZrPVnAeXELPYZJP+JpIkilLsKc
         jKxc8dFAlkTumj5agR3ROEDGnZgLTTl3QuNGCwp/XHF59gJJsFw1+ex1s68nuamHKxSL
         Y5gA==
X-Forwarded-Encrypted: i=1; AJvYcCXhDB/bTjpFspib1AmR01U4giz5o0OK4ZG67kkJmJmjgIm+Aov3aKTyX3VNvYvh7s8RsMkOCt3OOSwbN6hMClfb85ocif8VE6HS25KsS8Kv
X-Gm-Message-State: AOJu0YydEnF611HgxeCdY+Y3xXFGq8so5XTQgt3ESjb+LY2S7vtbCvvQ
	LL/MBScF2PoeoLdwMiSnPKjNUi11G21V3It7nMBCuQMmKXTESQslcz0PPPjeeUSnKaV7ZhdJe0p
	YXlVzu16CTDdlQY7v2YftLixze0ZmGu2GnU7s
X-Google-Smtp-Source: AGHT+IHB+Sby5xb3KQY4fJme46cOICuiSOSK7oxUno8JfmvAwWNnn3nyYgyDJgtIcLGc/wIzDrQoP+07XuveT6i0qf0=
X-Received: by 2002:a05:6214:c44:b0:6b4:b179:8eeb with SMTP id
 6a1803df08f44-6b61c230e3fmr8398346d6.63.1720469296819; Mon, 08 Jul 2024
 13:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com>
 <20240628003253.1694510-4-almasrymina@google.com> <CAMArcTUqqxam+BPwGExOFOLVi3t=dwA-5sSagKC5dndv07GDLQ@mail.gmail.com>
In-Reply-To: <CAMArcTUqqxam+BPwGExOFOLVi3t=dwA-5sSagKC5dndv07GDLQ@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 8 Jul 2024 13:08:01 -0700
Message-ID: <CAHS8izNS5jZjPfc-sARbHV7mzqzH+UhHfAtCTKRRTfSAdhY4Cw@mail.gmail.com>
Subject: Re: [PATCH net-next v15 03/14] netdev: support binding dma-buf to netdevice
To: Taehee Yoo <ap420073@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 10:57=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> I found several locking warnings while testing.
>

Thanks for Testing Taehee! And sorry for the late reply. I was off for
a couple of days. With some minor tweaks to my test setup I was able
to reproduce and fix all 3 warnings.

> [ 1135.125874] WARNING: CPU: 1 PID: 1644 at
> drivers/dma-buf/dma-buf.c:1123 dma_buf_map_attachment+0x164/0x2f0
...
> [ 1136.178258] WARNING: CPU: 1 PID: 1644 at
> drivers/dma-buf/dma-buf.c:1226 dma_buf_unmap_attachment+0x267/0x320

Both of these are warnings that dma->resv is not locked when calling
dma_buf_[un]map_attachment(). As far as I can tell so far, this can be
resolved by using the unlocked versions:
dma_buf_[un]map_attachment_unlocked() which is correct here for this
static importer.

...

> [ 1135.709313] WARNING: CPU: 3 PID: 1644 at
> net/core/netdev_rx_queue.c:18 netdev_rx_queue_restart+0x3f4/0x5a0

This is due to rtnl_lock() actually not being acquired in the unbind
path, when the netlink socket is closed. Sorry about that. This is
fixed by obtaining rtnl_lock() in the unbind path.

With the fixes below all the warnings disappear. I'm planning to
squash them to the next version. Let me know if those don't work for
you. Thanks!

diff --git a/net/core/devmem.c b/net/core/devmem.c
index e52bca1a55c7c..a6ef1485b80f2 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -46,8 +46,8 @@ void __net_devmem_dmabuf_binding_free(struct
net_devmem_dmabuf_binding *binding)
                  size, avail))
                gen_pool_destroy(binding->chunk_pool);

-       dma_buf_unmap_attachment(binding->attachment, binding->sgt,
-                                DMA_FROM_DEVICE);
+       dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt=
,
+                                         DMA_FROM_DEVICE);
        dma_buf_detach(binding->dmabuf, binding->attachment);
        dma_buf_put(binding->dmabuf);
        xa_destroy(&binding->bound_rxqs);
@@ -157,8 +157,8 @@ struct net_devmem_dmabuf_binding
*net_devmem_bind_dmabuf(struct net_device *dev,
                goto err_free_id;
        }

-       binding->sgt =3D
-               dma_buf_map_attachment(binding->attachment, DMA_FROM_DEVICE=
);
+       binding->sgt =3D dma_buf_map_attachment_unlocked(binding->attachmen=
t,
+                                                      DMA_FROM_DEVICE);
        if (IS_ERR(binding->sgt)) {
                err =3D PTR_ERR(binding->sgt);
                goto err_detach;
@@ -225,8 +225,8 @@ struct net_devmem_dmabuf_binding
*net_devmem_bind_dmabuf(struct net_device *dev,
                                net_devmem_dmabuf_free_chunk_owner, NULL);
        gen_pool_destroy(binding->chunk_pool);
 err_unmap:
-       dma_buf_unmap_attachment(binding->attachment, binding->sgt,
-                                DMA_FROM_DEVICE);
+       dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt=
,
+                                         DMA_FROM_DEVICE);
 err_detach:
        dma_buf_detach(dmabuf, binding->attachment);
 err_free_id:
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 4b16b3ad2ec5b..33bb20c143997 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -861,6 +861,9 @@ void netdev_nl_sock_priv_destroy(struct list_head *priv=
)
        struct net_devmem_dmabuf_binding *binding;
        struct net_devmem_dmabuf_binding *temp;

-       list_for_each_entry_safe(binding, temp, priv, list)
+       list_for_each_entry_safe(binding, temp, priv, list) {
+               rtnl_lock();
                net_devmem_unbind_dmabuf(binding);
+               rtnl_unlock();
+       }
 }



--
Thanks,
Mina

