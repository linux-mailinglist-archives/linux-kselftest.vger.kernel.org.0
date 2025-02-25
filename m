Return-Path: <linux-kselftest+bounces-27524-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FAEA44AEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 19:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC52177AB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524491A9B46;
	Tue, 25 Feb 2025 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0v4riTqf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B200B1A0BF1
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509695; cv=none; b=r2p6iliCgoWWT2nGLdw1Fwh9ockdLlTEsIbfj0QIDRmwnoC3u2g9Y1DDLod5NI1hqz4RYzl8u+AE7JEzVzyle2svmUuMukOEpx1VLkSdbPVAfYDNbuWAID27Mh4Eug3rNl3RsO604knfZ+snNOVZGc03weEtNy5BX84p6blhHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509695; c=relaxed/simple;
	bh=5o8pizoxvzVoSdZd/O+cZXmZb2Ptzgx/7TJMpQErk40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEES79zgAcqLQvFA4ZftnC5QOeDINV6hY18atfAaWYnG0zesWiB0tE2TfcZA1qW0qVOed8RmkxU2bmqE3iAFiNUlFcHA6Zu3pyAKMK/w03449R7G+MjAh+LIClsAnQzMAC4rzEpTnWL2D5uNd5I6AGqg4o/J105vihvYoa8w1W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0v4riTqf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22117c396baso16075ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 10:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740509692; x=1741114492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMCXizc35EGrmaC85T0NiBuwZkt8Yhq5EnmRBkHr9ig=;
        b=0v4riTqfdOu+E/qSOFlzOFSI+fZoE+Xr20a/9HR6AlLOgJrqI9/Yj28Xmqh7U+femg
         29yrlKtZ4y0rWIMnB6Abm36KOyag4BWd0cM2d22YObAB7BpQZI1wFWV4UYJYAsCzW1qd
         FciBaASfMNqrYqtwLYpxGCf6h1H7pLim6ogclP5gfWp3Z9dX02lyYdO3VrBS5dQxyCmf
         5NBOZCnMWsCRe9U8P1//nz2p8lSAdf2lRxZ5OBdkXLA8zs1E21hyJ3cYi5fZzSHKBS7W
         FivyAfSRlS4iQS9fG+gUrHJjrLSwVkYA/LjgK8bh+pykNnyxMuHMNAyBMLNizTxJf1Ps
         Jabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740509692; x=1741114492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMCXizc35EGrmaC85T0NiBuwZkt8Yhq5EnmRBkHr9ig=;
        b=UcecIh2toCQuEKzmuxibDPZZwbrZ5WPwdudRQMl9goT+Md+RakiXXVF2TMdT7pU4b4
         eSwtvCF1KpJo83N4tFluuKt/qvzUXSN/3ASd3JT9iWOs3mtowtoPhee6pO7tSpWCM8Wa
         UlqTkqMnP1Yl8RH8cbEnQhhmR6oUORsB9b+DQe7FtrpGbUNss1Fafn+LicfyQ/u4iNxo
         4x4/5R2KzKKeiDzBVUCi7BIXfPMzCXkdnB4N+WVC38omPp0iKkbh2wzq2RmNIygwKhrx
         PlurkKPrNZiEVUuTPbf4rvwLbmbfjNfy8L2XojgLBzKM6vXJMD9JISPlBiLsXA0FkWwd
         TKRw==
X-Forwarded-Encrypted: i=1; AJvYcCWfWr2JXU7A/VjA4pe5xRQupfhNjZRSVecoMwhA4OE5qaKYCtwm/k6MPIZEyaF56xDfZLfP5bCs4tAeMjXu18A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOlFAipg21apoi18ZQtvAX0CBO9MxOI7Hs3Le0QXRMjdZYF4//
	ngt97UgQDaUNj26DpkdwPZf+xNuj3Btw3kdROUiq5qyAvOFZ3S+gcrYxx3XI76tDv1VQT78BdDY
	zvjhToLnVQBK40w7qmtxUA+2TBfxWG23d7PSk
X-Gm-Gg: ASbGncuackQ1ai0uRJz9CRyoE+ovfYjcMRAxt9JVMOOylsmE5XptVDZfurpQorbCpfQ
	Fyb8s7xTZFDOewhmc1Y8IL/VPb74Xet5lI3NAcsZYhQT9q7o6ipMxXfCA9igucU16x6CEJnAUmK
	Vw8dh+fdxxkD0LziW0XQe5EdDJg/p9A/0rj3dt
X-Google-Smtp-Source: AGHT+IHKtkzfqoDq/aFKOFQr1ERgcAbcEK4IFsBn5K00z2a2QK3glh0MNqMaWd3X+U0cJKGz5XG2Nx9VjUfKKSOn5L8=
X-Received: by 2002:a17:903:32c8:b0:21f:3f5c:d24c with SMTP id
 d9443c01a7336-22307990990mr4177415ad.0.1740509691634; Tue, 25 Feb 2025
 10:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222191517.743530-1-almasrymina@google.com>
 <20250222191517.743530-4-almasrymina@google.com> <a814c41a-40f9-4632-a5bb-ad3da5911fb6@redhat.com>
 <CAHS8izNfNJLrMtdR0je3DsXDAvP2Hs8HfKf5Jq7_kQJsVUbrzg@mail.gmail.com> <a003b144-0abf-4274-abff-a6e391a3e20b@kernel.org>
In-Reply-To: <a003b144-0abf-4274-abff-a6e391a3e20b@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 25 Feb 2025 10:54:39 -0800
X-Gm-Features: AWEUYZm9ddJufTmC5t011zUcER-Yc8Z8hhKJRb2CSFMpmWrFXAHePyW-LPIzaHw
Message-ID: <CAHS8izMc0NCMPvCGg-uAOeWaf+K-_EfHnK7+4i205dPUy9JBFA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/9] net: devmem: Implement TX path
To: David Ahern <dsahern@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:03=E2=80=AFAM David Ahern <dsahern@kernel.org> w=
rote:
>
> On 2/25/25 10:41 AM, Mina Almasry wrote:
> > On Tue, Feb 25, 2025 at 5:04=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >>
> >> On 2/22/25 8:15 PM, Mina Almasry wrote:
> >> [...]
> >>> @@ -119,6 +122,13 @@ void net_devmem_unbind_dmabuf(struct net_devmem_=
dmabuf_binding *binding)
> >>>       unsigned long xa_idx;
> >>>       unsigned int rxq_idx;
> >>>
> >>> +     xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> >>> +
> >>> +     /* Ensure no tx net_devmem_lookup_dmabuf() are in flight after =
the
> >>> +      * erase.
> >>> +      */
> >>> +     synchronize_net();
> >>
> >> Is the above statement always true? can the dmabuf being stuck in some
> >> qdisc? or even some local socket due to redirect?
> >>
> >
> > Yes, we could have have netmems in the TX path in the qdisc or waiting
> > for retransmits that still have references to the dmabuf, and that's
> > fine here I think.
>
> skbs with references to netmem from a dmabuf can get stuck in retransmit
> queues for a long time. The comment should at least acknowledge that.
>

Will do, although I think maybe I'll add that comment above the
refcount_t definition in net_devmem_dmabuf_binding, if that's OK with
you. That was meant to explain how the refcounting on the binding
works.

Maybe worthy of note, this is not that new, in fact something similar
is happening in the RX path. In the RX path each skb waiting in the
receive queue to be recvmsg()'d will hold a reference on the
underlying page_pool, which in-turn holds a reference on the
underlying dmabuf. It's just that a similar thing is happening in the
TX path.

--=20
Thanks,
Mina

