Return-Path: <linux-kselftest+bounces-33311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B00ABB555
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 08:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7273AEEC2
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 06:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC6E257AC8;
	Mon, 19 May 2025 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9oUP07t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6673C2561A8;
	Mon, 19 May 2025 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747637132; cv=none; b=UPPfAOGSWUS6ctx2bgw1wxxUpbswCce3dZwFNjoka4iYXFT7AGdGW6ApWGhPuoh/OAIgG6qk2NPs1C7SAwfh1hav10V5K5vbiJmiM+rfN3yiwscA1WsrRYWxICoQ2gAc4Ki2I1KKogzU6sviYiQWDz4MaQwCoXOLvKoQFa3IQ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747637132; c=relaxed/simple;
	bh=Q/EuBFxYLHacrAtoDgyo+Cp+NqiGu+iQD1Hv+BWylno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+d7IEdqbzSNlTQf5o6desFU+dAwBhlY/RoTJSgBoVTEnRVdVebUOoaA6NSEVQOCIVKg9qy035ROz88NFpra3yo0mentyUdbEe3F/uaHLxoTE37w6KwQxRavwG9L+LiBZrDntHWZJnB6sqQ8zXmrjQWn4MYOcJqcQCCSNAN5uHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9oUP07t; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-601a9e65228so2183460a12.2;
        Sun, 18 May 2025 23:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747637129; x=1748241929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dywUjDT8o21WvwXU4M6vIQErqeNKabKpWm7swQyA/U=;
        b=R9oUP07tvzvWilMahP2g4NXeVHsPQArwdVJ5fCFJWYmNwKstjVjBwpHvCFyFHkiQY4
         Uux2mAgf+4akYzQyTwVGkNv7UgYNRu+Wsh3q6erfMN4RsKInH89kEqfJp+LLaKZLKTSI
         sA2xpWCf289oQKQikaq9TBSillqWQbPqKFpHb2AwxgBkNLLjP729ZngVoWJuRcdJUEUU
         PCV3Hb9ObWBjpw/Q5Sv2xMVxc8GWMN6bSYHQl1zBkOqcylTmwpnQpBnQExoa8yi4AB67
         rBg38/jP+XrT2dn6xGRmEE/6H51GTvXiyxzcJahW46XRPcjpdIwOmOfrIVdBMOlqbCi8
         5NTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747637129; x=1748241929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dywUjDT8o21WvwXU4M6vIQErqeNKabKpWm7swQyA/U=;
        b=n9rHc23+QDkzQfaCtdOmJ2wAkxqMpz8vq/vc5CvF0NyBqzXLSQlUR78cBcq3/vq/Uw
         Lc5UXzDD0O/TiSIV4bC8ZgD2Ag0I4iePyObG+zQsxDtfsq/WIOwr2czNLxjkQCVUUA8i
         Cr3/vsMHfa0damiolw1gLgHnjaF1/QgtQHDAkSPXeoCvRSb6HXrzh2Oo7aCXkWjCBDjU
         mQ7WWRbshgV7rTBSRUWX6OblPyZ+MOU6eEX2cU9hU7++sug+iHsWlrl3bmoRqd8igHP3
         V/3V1CztnGTS6q6PDv+FYtATyfL2ZjRJITkclv+PcqvtLO2vZeAtpYK9xYq5atHxfMeM
         CBoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAofZyWo00DnSVweJZdDgifcFTzZeHpm52BhKPJkl2nZdUfISVQ2V6cKgpNCWo3eNdLnlvBff2bF8MeUfMkDh6@vger.kernel.org, AJvYcCXOQ++6x7SXyzByUqNJ5Y54j9OxUR7UzzzqXyL4iF8qEjADNrUP8314tbKxVmS6Uq4PKjfSe+pj8T+XSYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQmEKbc3ujAa7Qk6aKB6avYzIlqqOyHlGlwRoucIgyJY6EZgEb
	cwgdYMdBXfuQJEl3iXoh6e8wwIXUVPCzXk2+HpapOm+1XRDdMV1mGq1Msd8+FAzL2ssJMMU9gZK
	az8scclSVBDnCj1fRB1ty330hvkXbBGE=
X-Gm-Gg: ASbGnctLFeA4zNLivlyOEdBa6+diiNzcemkWxLejDYYgfwVyXd+5ToKP7kxCIxTDQNs
	+vmTAKLqbNWtFMoEdrtfzprjpUAdTvp1+iQHCjQmdzCyuUAcLmm9d0xNrtzU/4uw7E2EPOeZgnO
	UXtIDF0NhwALpyla9GO3K07jVczaDdJ5/EBHA=
X-Google-Smtp-Source: AGHT+IF3L8AEKICmzGQm5Dojg79LCCoJK0F7RtvPfyM64CES29vCUgrPrAWhmo0Ub4qh5k07rF4LLYu7OYPAWeeMwNM=
X-Received: by 2002:a05:6402:3547:b0:601:e99c:9b19 with SMTP id
 4fb4d7f45d1cf-601e99c9c00mr1880146a12.1.1747637128468; Sun, 18 May 2025
 23:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519023517.4062941-1-almasrymina@google.com> <20250519023517.4062941-2-almasrymina@google.com>
In-Reply-To: <20250519023517.4062941-2-almasrymina@google.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Mon, 19 May 2025 15:45:17 +0900
X-Gm-Features: AX0GCFua0Whe2SPSz3kVScCNpt1xz5InpnKb57gfS0HzR5yNtmzH2eWzkLVWbEk
Message-ID: <CAMArcTWQY5FW5x3x-OM6tHh6nX4Fu91e7GNSQ97x6Qy80gCH6g@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/9] net: devmem: move list_add to net_devmem_bind_dmabuf.
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 11:35=E2=80=AFAM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> It's annoying for the list_add to be outside net_devmem_bind_dmabuf, but
> the list_del is in net_devmem_unbind_dmabuf. Make it consistent by
> having both the list_add/del be inside the net_devmem_[un]bind_dmabuf.
>
> Cc: ap420073@gmail.com
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Hi Mina,
Thanks a lot for this work!

I tested it and it works well.

Tested-by: Taehee Yoo <ap420073@gmail.com>

Thanks!
Taehee Yoo

>
> ---
>  net/core/devmem.c      | 5 ++++-
>  net/core/devmem.h      | 5 ++++-
>  net/core/netdev-genl.c | 8 ++------
>  3 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 0dba26baae18..b3a62ca0df65 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -178,7 +178,8 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device=
 *dev, u32 rxq_idx,
>  struct net_devmem_dmabuf_binding *
>  net_devmem_bind_dmabuf(struct net_device *dev,
>                        enum dma_data_direction direction,
> -                      unsigned int dmabuf_fd, struct netlink_ext_ack *ex=
tack)
> +                      unsigned int dmabuf_fd, struct netdev_nl_sock *pri=
v,
> +                      struct netlink_ext_ack *extack)
>  {
>         struct net_devmem_dmabuf_binding *binding;
>         static u32 id_alloc_next;
> @@ -299,6 +300,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>         if (err < 0)
>                 goto err_free_chunks;
>
> +       list_add(&binding->list, &priv->bindings);
> +
>         return binding;
>
>  err_free_chunks:
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 58d8d3c1b945..e7ba77050b8f 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -11,6 +11,7 @@
>  #define _NET_DEVMEM_H
>
>  #include <net/netmem.h>
> +#include <net/netdev_netlink.h>
>
>  struct netlink_ext_ack;
>
> @@ -82,7 +83,8 @@ void __net_devmem_dmabuf_binding_free(struct work_struc=
t *wq);
>  struct net_devmem_dmabuf_binding *
>  net_devmem_bind_dmabuf(struct net_device *dev,
>                        enum dma_data_direction direction,
> -                      unsigned int dmabuf_fd, struct netlink_ext_ack *ex=
tack);
> +                      unsigned int dmabuf_fd, struct netdev_nl_sock *pri=
v,
> +                      struct netlink_ext_ack *extack);
>  struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
>  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)=
;
>  int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> @@ -170,6 +172,7 @@ static inline void __net_devmem_dmabuf_binding_free(s=
truct work_struct *wq)
>  static inline struct net_devmem_dmabuf_binding *
>  net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
>                        enum dma_data_direction direction,
> +                      struct netdev_nl_sock *priv,
>                        struct netlink_ext_ack *extack)
>  {
>         return ERR_PTR(-EOPNOTSUPP);
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 762570dcda61..2afa7b2141aa 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -908,7 +908,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struc=
t genl_info *info)
>         }
>
>         binding =3D net_devmem_bind_dmabuf(netdev, DMA_FROM_DEVICE, dmabu=
f_fd,
> -                                        info->extack);
> +                                        priv, info->extack);
>         if (IS_ERR(binding)) {
>                 err =3D PTR_ERR(binding);
>                 goto err_unlock;
> @@ -943,8 +943,6 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struc=
t genl_info *info)
>                         goto err_unbind;
>         }
>
> -       list_add(&binding->list, &priv->bindings);
> -
>         nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
>         genlmsg_end(rsp, hdr);
>
> @@ -1020,15 +1018,13 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, s=
truct genl_info *info)
>                 goto err_unlock_netdev;
>         }
>
> -       binding =3D net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_=
fd,
> +       binding =3D net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_=
fd, priv,
>                                          info->extack);
>         if (IS_ERR(binding)) {
>                 err =3D PTR_ERR(binding);
>                 goto err_unlock_netdev;
>         }
>
> -       list_add(&binding->list, &priv->bindings);
> -
>         nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
>         genlmsg_end(rsp, hdr);
>
> --
> 2.49.0.1101.gccaa498523-goog
>

