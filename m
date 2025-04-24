Return-Path: <linux-kselftest+bounces-31465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BB6A99C3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 01:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0147D7A886D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 23:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E147E242D88;
	Wed, 23 Apr 2025 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m22b7eh7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604F21FF50
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 23:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745452186; cv=none; b=cRXcCuoD3zDgYKtenDzoxpeHuGTMT87K5s5lNLo0GLtUAPuieoTlXN250ay+8VKMQ5W9Bt9JKENWnSuj51AsKyre+ja5Biwy1afuOd+T4AmyvbWvOiu47KaIORZYhUFXFJ6DM0TiC2nnjdnQu+NDPMcxR4bBhTAv7POSY4zQi10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745452186; c=relaxed/simple;
	bh=2VepqBRKfk+JUtYK6Opi6yC4PoH9lRaO6DVRy49F788=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3Y6Rl4fFK4/YGdyfcrA8JqGnRuakbzKPKOMgnKNlgBKkJBFPXb9Rp8IX0l5KvNThPFRTxceJ69+DjFsv9vy5IDG+f2In+MVQVqff3Zdxczl7iMjsc0zoZgTHpTCEwfrBxcFk3KSWLjIgaQVYPMu1HwxIXgg+ePDcg9kDvh23JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m22b7eh7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2242ac37caeso40965ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 16:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745452184; x=1746056984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgkZ0Ext9iMP/JpiGlrjV0G3sg7KUzWq6I5onInGXLo=;
        b=m22b7eh7ZBAWuwp7bnnFNPDsGXVQsJgKx+hykA/dVSbsJgYAf5w2hfu5xArKlpaCHf
         jt+IWwYEfNrRJzlhCsLsw6WR+n+EGP7r+VoSB54JXwSHboVNzntSz3/Z6Hodfr7a/15u
         8+k3QfiC/wMJz6eYAM+iuFiBEtLs6dzI2Rw3y1IaqESHzvdXk4jyVgAwLdrssEtEL6D6
         3HPrHD5dd6IpQaMzXB76bNq9QUljv+CaRttURfXotriwapSQ+0U0HB0sFCfZpQEANqfA
         +TqfHvmWI3VIMd8qdr3Qf1kohOYK4cwoxuwjmUzJA6/Pf+DokhIf64GtClz7SkLog/1d
         VyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745452184; x=1746056984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgkZ0Ext9iMP/JpiGlrjV0G3sg7KUzWq6I5onInGXLo=;
        b=sVwvo9NHKnoJGr7vmPRrPU5tS0mqWVTmFMb2dQADyogKm/qr4t2xahsh1onAOxEO1B
         +yWCkkLc/hEMHSEkVpfFaiKnRuCt8FJ65LuVk3siBHo7rJQtKz264DUP/OczMlgjPvqD
         jCBYKr8FThikoqPe4Z/Ev1/uhPDEpmTX26Om5lJ2dJP3Yt63WhI5ZNJ4vhfshb8hRjsf
         pRD0GmwjF7rArei2auulqNI3qJ9BUdnwhc/j8BGSYui8ak/ilC7nJrDSZy0/JLTWe8mY
         PjTS6bHULrDloUuvted+FKVnWuldDZhqlCXZ3KUNUZVADAgUb7G4iaD42Zq3NTKr6YRX
         3JOA==
X-Forwarded-Encrypted: i=1; AJvYcCW+jMxtsXsFM1Xi+hpAaZ7clI+nTnkWh38x1ChVgBAzHFKKK6x+YtXUX8HWEo8mfl3itTv87+cOtr5+8GAEl30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZCJqWRa/bYNUCG/WgumitANRhH0kOD+dX+Sq8eWlW6YDm3Ox0
	5v2DtuBGQynU8iVcL/l4HZc1jXnpyCj0sNowLVGhWD47mrq2s6+dY99pvq/2R0uFnwALspjUb2N
	8AKQqmnycANgeAGBwt1uafK1uG0z2uEgUoOw+
X-Gm-Gg: ASbGncvVU3+GG6gBE3+PjzYXXyB2PzvEee2RuqGAHaFQq/rQM9TM9coooylEqZW8DKV
	WphjN1hxFbtb9puXgSga5dsI2FKrquOTK3u7/HlJLYXS1Hkq8zi/Nn7D/PyZEPI0ovaXy+nqFqs
	angcIan1yJQFkZpU/xaVGXshuf29/CNIEKgZkySRqAEGg9yCs7V564
X-Google-Smtp-Source: AGHT+IGX7LK2aizJTPRrsUG1SCwbT2wY7Q85CyE+4DCuBGCQwpCEAfBGkW2ltJ7AcRFVxOQFDMwRmDSguzDhCxxr7Yc=
X-Received: by 2002:a17:903:46c6:b0:21f:3c4a:136f with SMTP id
 d9443c01a7336-22db2214bfcmr1400785ad.28.1745452183416; Wed, 23 Apr 2025
 16:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423031117.907681-1-almasrymina@google.com>
 <20250423031117.907681-5-almasrymina@google.com> <20250423140931-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250423140931-mutt-send-email-mst@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 23 Apr 2025 16:49:30 -0700
X-Gm-Features: ATxdqUHdLn2wP88hj2tffPEL1QlUjkAMN1_0DSb5R09qEYsDQJ9iaUC4P8x0YMU
Message-ID: <CAHS8izNRk1MOs-R1RmWMQ5zMBOo70YpTzOdt8=OrrjrD7JQTfA@mail.gmail.com>
Subject: Re: [PATCH net-next v10 4/9] net: devmem: Implement TX path
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 11:24=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> some nits
>
> On Wed, Apr 23, 2025 at 03:11:11AM +0000, Mina Almasry wrote:
> > @@ -189,43 +200,44 @@ net_devmem_bind_dmabuf(struct net_device *dev, un=
signed int dmabuf_fd,
> >       }
> >
> >       binding->dev =3D dev;
> > -
> > -     err =3D xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id=
,
> > -                           binding, xa_limit_32b, &id_alloc_next,
> > -                           GFP_KERNEL);
> > -     if (err < 0)
> > -             goto err_free_binding;
> > -
> >       xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
> > -
> >       refcount_set(&binding->ref, 1);
> > -
> >       binding->dmabuf =3D dmabuf;
> >
>
> given you keep iterating, don't tweak whitespace in the same patch-
> will make the review a tiny bit easier.
>

Sure.

>
> >       binding->attachment =3D dma_buf_attach(binding->dmabuf, dev->dev.=
parent);
> >       if (IS_ERR(binding->attachment)) {
> >               err =3D PTR_ERR(binding->attachment);
> >               NL_SET_ERR_MSG(extack, "Failed to bind dmabuf to device")=
;
> > -             goto err_free_id;
> > +             goto err_free_binding;
> >       }
> >
> >       binding->sgt =3D dma_buf_map_attachment_unlocked(binding->attachm=
ent,
> > -                                                    DMA_FROM_DEVICE);
> > +                                                    direction);
> >       if (IS_ERR(binding->sgt)) {
> >               err =3D PTR_ERR(binding->sgt);
> >               NL_SET_ERR_MSG(extack, "Failed to map dmabuf attachment")=
;
> >               goto err_detach;
> >       }
> >
> > +     if (direction =3D=3D DMA_TO_DEVICE) {
> > +             binding->tx_vec =3D kvmalloc_array(dmabuf->size / PAGE_SI=
ZE,
> > +                                              sizeof(struct net_iov *)=
,
> > +                                              GFP_KERNEL);
> > +             if (!binding->tx_vec) {
> > +                     err =3D -ENOMEM;
> > +                     goto err_unmap;
> > +             }
> > +     }
> > +
> >       /* For simplicity we expect to make PAGE_SIZE allocations, but th=
e
> >        * binding can be much more flexible than that. We may be able to
> >        * allocate MTU sized chunks here. Leave that for future work...
> >        */
> > -     binding->chunk_pool =3D
> > -             gen_pool_create(PAGE_SHIFT, dev_to_node(&dev->dev));
> > +     binding->chunk_pool =3D gen_pool_create(PAGE_SHIFT,
> > +                                           dev_to_node(&dev->dev));
> >       if (!binding->chunk_pool) {
> >               err =3D -ENOMEM;
> > -             goto err_unmap;
> > +             goto err_tx_vec;
> >       }
> >
> >       virtual =3D 0;
> > @@ -270,24 +282,34 @@ net_devmem_bind_dmabuf(struct net_device *dev, un=
signed int dmabuf_fd,
> >                       niov->owner =3D &owner->area;
> >                       page_pool_set_dma_addr_netmem(net_iov_to_netmem(n=
iov),
> >                                                     net_devmem_get_dma_=
addr(niov));
> > +                     if (direction =3D=3D DMA_TO_DEVICE)
> > +                             binding->tx_vec[owner->area.base_virtual =
/ PAGE_SIZE + i] =3D niov;
> >               }
> >
> >               virtual +=3D len;
> >       }
> >
> > +     err =3D xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id=
,
> > +                           binding, xa_limit_32b, &id_alloc_next,
> > +                           GFP_KERNEL);
> > +     if (err < 0)
> > +             goto err_free_id;
> > +
> >       return binding;
> >
> > +err_free_id:
> > +     xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> >  err_free_chunks:
> >       gen_pool_for_each_chunk(binding->chunk_pool,
> >                               net_devmem_dmabuf_free_chunk_owner, NULL)=
;
> >       gen_pool_destroy(binding->chunk_pool);
> > +err_tx_vec:
> > +     kvfree(binding->tx_vec);
> >  err_unmap:
> >       dma_buf_unmap_attachment_unlocked(binding->attachment, binding->s=
gt,
> >                                         DMA_FROM_DEVICE);
> >  err_detach:
> >       dma_buf_detach(dmabuf, binding->attachment);
> > -err_free_id:
> > -     xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> >  err_free_binding:
> >       kfree(binding);
> >  err_put_dmabuf:
> > @@ -295,6 +317,21 @@ net_devmem_bind_dmabuf(struct net_device *dev, uns=
igned int dmabuf_fd,
> >       return ERR_PTR(err);
> >  }
> >
> > +struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id)
> > +{
> > +     struct net_devmem_dmabuf_binding *binding;
> > +
> > +     rcu_read_lock();
> > +     binding =3D xa_load(&net_devmem_dmabuf_bindings, id);
> > +     if (binding) {
> > +             if (!net_devmem_dmabuf_binding_get(binding))
> > +                     binding =3D NULL;
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     return binding;
> > +}
> > +
> >  void net_devmem_get_net_iov(struct net_iov *niov)
> >  {
> >       net_devmem_dmabuf_binding_get(net_devmem_iov_binding(niov));
> > @@ -305,6 +342,53 @@ void net_devmem_put_net_iov(struct net_iov *niov)
> >       net_devmem_dmabuf_binding_put(net_devmem_iov_binding(niov));
> >  }
> >
> > +struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *=
sk,
> > +                                                      unsigned int dma=
buf_id)
> > +{
> > +     struct net_devmem_dmabuf_binding *binding;
> > +     struct dst_entry *dst =3D __sk_dst_get(sk);
> > +     int err =3D 0;
> > +
> > +     binding =3D net_devmem_lookup_dmabuf(dmabuf_id);
>
> why not initialize binding together with the declaration?
>

I find it stylistically much better to error check this right after
it's assigned.

> > +     if (!binding || !binding->tx_vec) {
> > +             err =3D -EINVAL;
> > +             goto out_err;
> > +     }
> > +
> > +     /* The dma-addrs in this binding are only reachable to the corres=
ponding
> > +      * net_device.
> > +      */
> > +     if (!dst || !dst->dev || dst->dev->ifindex !=3D binding->dev->ifi=
ndex) {
> > +             err =3D -ENODEV;
> > +             goto out_err;
> > +     }
> > +
> > +     return binding;
> > +
> > +out_err:
> > +     if (binding)
> > +             net_devmem_dmabuf_binding_put(binding);
> > +
> > +     return ERR_PTR(err);
> > +}
> > +
> > +struct net_iov *
> > +net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding,
> > +                    size_t virt_addr, size_t *off, size_t *size)
> > +{
> > +     size_t idx;
> > +
> > +     if (virt_addr >=3D binding->dmabuf->size)
> > +             return NULL;
> > +
> > +     idx =3D virt_addr / PAGE_SIZE;
>
> init this at where it's declared?
> or where it's used.
>

I think probably a local variable isn't warranted. Will remove.

--=20
Thanks,
Mina

