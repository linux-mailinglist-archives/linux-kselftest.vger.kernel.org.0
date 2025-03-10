Return-Path: <linux-kselftest+bounces-28579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DB7A58B02
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 05:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032733AA920
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 04:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA33F1BD9C7;
	Mon, 10 Mar 2025 04:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqFPCmp6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8277E1401B
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 04:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741579277; cv=none; b=tSMo57Vi0kJrS0Dkxtim1jrN7NStVByYPafgP3bvL89d/Dyj+GNGW4Rv2yuUqaGluXUDqsp4bhczHAzs7Agq54D2YRhgB/2Ws32jcNvN543HpsAePx4Oa5d+8rR8cBeJuU5aL0zVr7jiOghpSuhiOiYIA8hQ3WfCDOhN/OxH3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741579277; c=relaxed/simple;
	bh=y2jgmxgCkCS0866p0uhw4Z/wKL7ZAlvCJDAr0KB4Wp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXOHDthuChqT2L9tbVLgC6/3KcLEkReqa4v59UquG6EiEnYbkNS6jZfLPxMkWdwbbRYGRvPAw+Yw6GhH4j02HwdMF0VtQitlNV7eWOFQ1KPK4DqrOpyRbBJ9UAIx0cgB6xWywpCaY9ErknOrx/WOt/cWQSldQ8Gii+hZR6CoRf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqFPCmp6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741579274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baDSD60KKAXA2YV4cwTHazyMng6zqZ9j6/BH6ENwQIo=;
	b=TqFPCmp6FldnTqNHM9ffUXFPQbuMHMY+8uF5yS4iUpfs1qGhIFxWR2DWxPevrGMRgjWfuy
	fW9doVJlPPFzhPvMq/3s14KwPYPw4x//GlcMa6sIPw8rQvlT0B8r2I5IdMQZ5i+i5yN4uO
	gDt5RGpKIqfwCQId4tnYJfed5FyuRrc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-ZMyEcni8N1Sb3xoyWtfbGA-1; Mon, 10 Mar 2025 00:01:13 -0400
X-MC-Unique: ZMyEcni8N1Sb3xoyWtfbGA-1
X-Mimecast-MFC-AGG-ID: ZMyEcni8N1Sb3xoyWtfbGA_1741579272
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so11421252a91.3
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Mar 2025 21:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741579271; x=1742184071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baDSD60KKAXA2YV4cwTHazyMng6zqZ9j6/BH6ENwQIo=;
        b=fHuTggEsJCylrqeRG7xBGWu/Tk0EW3i4KIc4r33HB3vb/BWKfTgOD+8stRUCCAOMPm
         EEPXE83s4AqffGt/6cqlfo20//RNAv972X4n1YwSYsE8GmmfYZlmA/vEss7AElyalPHQ
         +HMzd0/ZyQN5UZzwx57THof1UWRNAUrVacSN/r2bnwamk/5crdQjuV9YqkVXW73cXlot
         ooHE78hfKe41BDZByO1SmDo8qE8AkMjz079ztfX6wwTe9gJ6vwCrK147KIE4EgtdtXJZ
         yrTBU2y62DEXLlmAVkDoslG9pMuZAh8ARD6Nfo/LE+mZ/w2fImcxtPvcDfumY0LqUUZW
         dxzg==
X-Forwarded-Encrypted: i=1; AJvYcCWkGj87X54IMLHsKbjv+FVCun88GlLBqOsIWS3i0gXBZMi7CJalJuh1IVgD+bdikDzpyUvP2ozmKCYvDRyHP68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0xdxoOFVkS+ToL30vH1KV6g/Dzz/PseYa3Bj3NtsXlkxlvGQ
	TlE9sneBOWZNS+MN4/2Q2A85W1E83yEkKwGOeh6dqM/VgeEMoUNsbm2QqJZJumQ239gw3lyjr6W
	ZRInqIX2xhI0aYCGK94bjsCTZ20uR13x8ITM3N1XmlArYzBNscPdgMwPCJ+atsv3ENB1kysIz7f
	3O625I4IVaR+dwBGLbDvSja5q5f4YSWvxFKHOMrkl+
X-Gm-Gg: ASbGnctNIx1hQqhLZe6utHkSmN+IC52Jsa08INv1xuWDlGdbd/HDFbfXZ4OOB+hfOPh
	fBtHXKdThyfD61S/RhfQ/lyDZjAfvG4EToG4EO//KcD245naqwY4XzhZerO6qcwZCZNqwe8lsOQ
	==
X-Received: by 2002:a17:90b:1b0b:b0:2fc:c262:ef4b with SMTP id 98e67ed59e1d1-2ff7cea9a99mr22401412a91.18.1741579271530;
        Sun, 09 Mar 2025 21:01:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9DOsUxA9Z0UU+zFKp4XwB12kvLD6PT8eYjbCh1DLy1GK1oX1uE/LbhxDyNJ0rRDiXuxTT1vCPASJg6+fMr/4=
X-Received: by 2002:a17:90b:1b0b:b0:2fc:c262:ef4b with SMTP id
 98e67ed59e1d1-2ff7cea9a99mr22401364a91.18.1741579271097; Sun, 09 Mar 2025
 21:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-3-df76624025eb@daynix.com>
 <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com>
In-Reply-To: <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Mar 2025 12:01:00 +0800
X-Gm-Features: AQ5f1JpaV-Y2lOTdTlLng-Bakedv0t_hz074LEAN3YdWqqKw7pRKMp2RrCa8b3E
Message-ID: <CACGkMEtCEwSB7XvCg7_8ebkcM8o2s8JB2Err2f153L-_i2KtxA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/6] tun: Introduce virtio-net hash feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:55=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Fri, Mar 7, 2025 at 7:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
> >
> > Hash reporting
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Allow the guest to reuse the hash value to make receive steering
> > consistent between the host and guest, and to save hash computation.
> >
> > RSS
> > =3D=3D=3D
> >
> > RSS is a receive steering algorithm that can be negotiated to use with
> > virtio_net. Conventionally the hash calculation was done by the VMM.
> > However, computing the hash after the queue was chosen defeats the
> > purpose of RSS.
> >
> > Another approach is to use eBPF steering program. This approach has
> > another downside: it cannot report the calculated hash due to the
> > restrictive nature of eBPF steering program.
> >
> > Introduce the code to perform RSS to the kernel in order to overcome
> > thse challenges. An alternative solution is to extend the eBPF steering
> > program so that it will be able to report to the userspace, but I didn'=
t
> > opt for it because extending the current mechanism of eBPF steering
> > program as is because it relies on legacy context rewriting, and
> > introducing kfunc-based eBPF will result in non-UAPI dependency while
> > the other relevant virtualization APIs such as KVM and vhost_net are
> > UAPIs.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Tested-by: Lei Yang <leiyang@redhat.com>
> > ---
> >  Documentation/networking/tuntap.rst |   7 ++
> >  drivers/net/Kconfig                 |   1 +
> >  drivers/net/tap.c                   |  68 ++++++++++++++-
> >  drivers/net/tun.c                   |  98 +++++++++++++++++-----
> >  drivers/net/tun_vnet.h              | 159 ++++++++++++++++++++++++++++=
++++++--
> >  include/linux/if_tap.h              |   2 +
> >  include/linux/skbuff.h              |   3 +
> >  include/uapi/linux/if_tun.h         |  75 +++++++++++++++++
> >  net/core/skbuff.c                   |   4 +
> >  9 files changed, 386 insertions(+), 31 deletions(-)

[...]

> > + *
> > + * The %TUN_VNET_HASH_REPORT flag set with this ioctl will be effectiv=
e only
> > + * after calling the %TUNSETVNETHDRSZ ioctl with a number greater than=
 or equal
> > + * to the size of &struct virtio_net_hdr_v1_hash.
>
> So you had a dependency check already for vnet hdr len. I'd still
> suggest to split this into rss and hash as they are separated
> features. Then we can use separate data structure for them instead of
> a container struct.
>

Besides this, I think we still need to add new bits to TUNGETIFF to
let userspace know about the new ability.

Thanks


