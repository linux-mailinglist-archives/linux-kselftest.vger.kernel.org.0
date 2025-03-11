Return-Path: <linux-kselftest+bounces-28686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2267EA5B4C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 01:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5A97A5BDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 00:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EDB146593;
	Tue, 11 Mar 2025 00:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1A5/0K7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C381C3F34
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741653762; cv=none; b=o44PYK/uEcLzuR8OW3NtRmE/rbQooeTsXacp8ZIzKjFPkb+1OnN/nn58XnO34vL0K4YI+M8AcV3dXUvc4bpNnORwLMMn1oHRRY5pr1qyckktSGHL1L6Yrlxv4SMoc2l2eFnKyFg5jQtQQotcMkPdJlYEnrUMzaY3VFFn/R2EBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741653762; c=relaxed/simple;
	bh=mDO9x/sNKaSh6VKq6BR9qetuUOFySZaiPD1KWPXFKso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKdr84HvHA/64+J03TeUW/H7+n17CP5cY/pf3AOBm//+ccw3VCu1tTzWyz7MQzB6JYQG/CwbhVVm4n0Hno80o2JJ3vB1YMTfQrI5adLFzvluTxcTtZlYNXZNdZOU+pO4QIc+6dnwgEQIuJefpemQduX9+WoXW0vDCIUhYge11Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1A5/0K7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741653755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=847bTrI9x3dTQBNL5SAKMbZJ6bNHhxo9NrLY7aN1zMI=;
	b=M1A5/0K73zSnO0RIzITwHsMkDYfyyTWSId6CESU+T/KMiyCYRuLwBVG18n3jhA1aOY0keG
	ETEzvVvuhdewRNi/1VU+c138goYXrGeVD/tOKCKTWJw08VgJ7wCVYRv/ACHmtk9mzu6Aj/
	TYEksgDzCH15hpOnF3xI6I+OCS+ghh0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-54EkFevdN42n0z_IjMa02Q-1; Mon, 10 Mar 2025 20:42:33 -0400
X-MC-Unique: 54EkFevdN42n0z_IjMa02Q-1
X-Mimecast-MFC-AGG-ID: 54EkFevdN42n0z_IjMa02Q_1741653747
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff798e8c93so7202294a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 17:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741653746; x=1742258546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=847bTrI9x3dTQBNL5SAKMbZJ6bNHhxo9NrLY7aN1zMI=;
        b=qqoZacr5O4Wz7L6J7LMQYNTMfyooMAt5pwih2j6uWkSt0AFMQ3+XZr4fj8X0K5ypHQ
         CPvm7EoajGuI8LcgvID2R5eKGRs+GHWC9bJf5cINGDiJQw66l0AmBIsYWcsEhUY50vB8
         dG3mlj5T2odK6wE7sxNZyhQMNs6XzYLwKeRH265fqXOr6fHTpzAuXtlhcdszcpAHW+Ge
         IbPYDTIqMIaNBjQ+cPRmLFkPFJMwHdPMG8uU/HTYDLeRR1HIZrEaFB493KEvdQB52Qn/
         4hH+s65M+V8Ux1bRSR9nrhDM8CWprNg4ImNFTaGM5Ki+BRpuJbMmdWva7t141kEf4FUR
         vH+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6T424D8Sx0sW9bhIgDz143xny/6yEP6VdCUFA3H5Jm+2etpbD0dKT2zMrFg2RJmZUEuC3U25lR9C3lA04Zrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9W8lQgLokZKGJ0tcsiZ0/nidhaeABb3NNd5srWIZ5mfNkQpFe
	l9hXOrW/2/ZoFqeAtIkOG8VFvwGbqNTbF7iVXLdMvg5MIJ6+fIGabq3qybTKh6PYXAO+H9TUa2l
	1VNmq4tL6OpPzYpdxt28q/rUOi3g9E7eWYtq6KLpIxioC8tw0GpZ6zAHwj/K83ZE8Z3Nc1ouAw9
	0q8dDqwDpRT04SD+96zjjaBkCT0iu88iQoj2KMNrqj
X-Gm-Gg: ASbGncuaM7k5g/zZh0LC+qgXSADkwC3J/ds1eGQFg7ySB/jVRtRiYRrmDlifeYHrQDi
	rZsIB+WWydSuma/BV86hE4fXQKpQMyZAW5ZcEr+xhcyFp1rMox5FZzg4hglihcmYOxkQ6qg==
X-Received: by 2002:a17:90b:1f8c:b0:2ff:698d:ef7c with SMTP id 98e67ed59e1d1-300ff3701e6mr2209798a91.29.1741653746486;
        Mon, 10 Mar 2025 17:42:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbDtyJiENvXOe613oqH0vAWN8hUrOgIBvwTgQjpWafbqSKNzh+whVUzZLm1l+kq/H8WuSWlOotAIb4Chd6SFM=
X-Received: by 2002:a17:90b:1f8c:b0:2ff:698d:ef7c with SMTP id
 98e67ed59e1d1-300ff3701e6mr2209768a91.29.1741653746073; Mon, 10 Mar 2025
 17:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-6-df76624025eb@daynix.com>
 <CACGkMEuccQ6ah-aZ3tcW1VRuetEoPA_NaLxLT+9fb0uAab8Agg@mail.gmail.com> <2e550452-a716-4c3f-9d5a-3882d2c9912a@daynix.com>
In-Reply-To: <2e550452-a716-4c3f-9d5a-3882d2c9912a@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Mar 2025 08:42:13 +0800
X-Gm-Features: AQ5f1Jr7Qnv1FpSExilgR3dbxXrVBsVK1HLZstm0K3Mj08GcyKcVawpejY0cXIk
Message-ID: <CACGkMEu9tynRgTh__3p_vSqOekSirbVgS90rd5dUiJru9oV1eg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 6/6] vhost/net: Support VIRTIO_NET_F_HASH_REPORT
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

On Mon, Mar 10, 2025 at 3:04=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/10 13:43, Jason Wang wrote:
> > On Fri, Mar 7, 2025 at 7:02=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on th=
e
> >> host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
> >> hash values (i.e., the hash_report member is always set to
> >> VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
> >> underlying socket will be reported.
> >>
> >> VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> Tested-by: Lei Yang <leiyang@redhat.com>
> >> ---
> >>   drivers/vhost/net.c | 49 +++++++++++++++++++++++++++++--------------=
------
> >>   1 file changed, 29 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >> index b9b9e9d40951856d881d77ac74331d914473cd56..16b241b44f89820a42c302=
f3586ea6bb5e0d4289 100644
> >> --- a/drivers/vhost/net.c
> >> +++ b/drivers/vhost/net.c
> >> @@ -73,6 +73,7 @@ enum {
> >>          VHOST_NET_FEATURES =3D VHOST_FEATURES |
> >>                           (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
> >>                           (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
> >> +                        (1ULL << VIRTIO_NET_F_HASH_REPORT) |
> >>                           (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> >>                           (1ULL << VIRTIO_F_RING_RESET)
> >>   };
> >> @@ -1097,9 +1098,11 @@ static void handle_rx(struct vhost_net *net)
> >>                  .msg_controllen =3D 0,
> >>                  .msg_flags =3D MSG_DONTWAIT,
> >>          };
> >> -       struct virtio_net_hdr hdr =3D {
> >> -               .flags =3D 0,
> >> -               .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> >> +       struct virtio_net_hdr_v1_hash hdr =3D {
> >> +               .hdr =3D {
> >> +                       .flags =3D 0,
> >> +                       .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> >> +               }
> >>          };
> >>          size_t total_len =3D 0;
> >>          int err, mergeable;
> >> @@ -1110,7 +1113,6 @@ static void handle_rx(struct vhost_net *net)
> >>          bool set_num_buffers;
> >>          struct socket *sock;
> >>          struct iov_iter fixup;
> >> -       __virtio16 num_buffers;
> >>          int recv_pkts =3D 0;
> >>
> >>          mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
> >> @@ -1191,30 +1193,30 @@ static void handle_rx(struct vhost_net *net)
> >>                          vhost_discard_vq_desc(vq, headcount);
> >>                          continue;
> >>                  }
> >> +               hdr.hdr.num_buffers =3D cpu_to_vhost16(vq, headcount);
> >>                  /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HD=
R */
> >>                  if (unlikely(vhost_hlen)) {
> >> -                       if (copy_to_iter(&hdr, sizeof(hdr),
> >> -                                        &fixup) !=3D sizeof(hdr)) {
> >> +                       if (copy_to_iter(&hdr, vhost_hlen,
> >> +                                        &fixup) !=3D vhost_hlen) {
> >>                                  vq_err(vq, "Unable to write vnet_hdr =
"
> >>                                         "at addr %p\n", vq->iov->iov_b=
ase);
> >>                                  goto out;
> >
> > Is this an "issue" specific to RSS/HASH? If it's not, we need a separat=
e patch.
> >
> > Honestly, I'm not sure if it's too late to fix this.
>
> There is nothing wrong with the current implementation.

Note that I meant the vhost_hlen part, and the current code is tricky.

The comment said:

"""
/* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
"""

So it tries to only offer virtio_net_hdr even if vhost_hlen is the set
to mrg_rxbuf len.

And this patch changes this behaviour.

Thanks

> The current
> implementation fills the header with zero except num_buffers, which it
> fills some real value. This functionality is working fine with
> VIRTIO_NET_F_MRG_RXBUF and VIRTIO_F_VERSION_1, which change the header si=
ze.
>
> Now I'm adding VIRTIO_NET_F_HASH_REPORT and it adds the hash_report
> field, which also needs to be initialized with zero, so I'm making sure
> vhost_net will also initialize it.
>
> Regards,
> Akihiko Odaki
>
> >
> > Others look fine.
> >
> > Thanks
> >
>


