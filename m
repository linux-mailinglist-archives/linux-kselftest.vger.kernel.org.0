Return-Path: <linux-kselftest+bounces-28791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF76A5D4C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 04:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569707AA03F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 03:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3B1198E8C;
	Wed, 12 Mar 2025 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/xddV6t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3FE1487ED
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741750590; cv=none; b=Y+FSmnCDUkyJcJrqL9giqjQUbjXZevruBpvEgPcGkL3mc3q65bKsaWwRqToR6nUVHeebpCM+rDVlzvOOfQD/4nUbr83nPc0UXxGbLPBMvoeHfbALSva2j46iSbI8H9V/5UVPjNNJCs/x1xWVrn+ILAMfacOkPiWed948qDLSius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741750590; c=relaxed/simple;
	bh=Dyw0HFF2I3UqKNeJMJWrFl+V1/u9vlMYXlU1qdh2Fs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObS+9yHq6SnaMNr/24D1dbwD9Y8367hp0GnfkJrix73/zZzpFRH2Rq67isrDYNE3/sb7Ndf+Rp9RwCk3WZqv6UBmU+GtqBCP89sDmOy4Z+aBZVMU0KQzKAL0Xl5eVLgZHbphVPNHnzYd7FyUPQT29Em5hYnh0qCxWW6UxUokx54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/xddV6t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741750587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZpwUgpQlsRSqyhUJVMbAHrvSDusnw6V0w+ye5eNYLw=;
	b=O/xddV6tAvttgmf0NkPoR3aYCt99nHAK+qRJv0OTAuO3EWmYT487HWCM8V0RzVU/VtRp3y
	bmVcEck8VNLtGROvu/lpEkT+bIeBaPIuVKWTBBPjUMX4mIN0nr1YnYo1RQ27lr6KFMUVW/
	oGMqbD1WdE4zt8Wj53ZELtjIjxPuZ7Q=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-ITRdtOOSPSGt1SkqvCYIqg-1; Tue, 11 Mar 2025 23:36:26 -0400
X-MC-Unique: ITRdtOOSPSGt1SkqvCYIqg-1
X-Mimecast-MFC-AGG-ID: ITRdtOOSPSGt1SkqvCYIqg_1741750585
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-224192ff68bso95616705ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 20:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741750585; x=1742355385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZpwUgpQlsRSqyhUJVMbAHrvSDusnw6V0w+ye5eNYLw=;
        b=NKmj8jCl2DC7bJGcz5gIEcHviYrnR76dVIZo6KRcrOiqqJhw8ngmwuATFy+PQRJVui
         +WdrfTHwIhKcR0mLfDH0xBWqZcHh8jL8PvvJjNaq+n2RgBMEgY4n0CyIVym0OjSHp06i
         pcG1Py0xr0aAS/q+oWX5506IIy21DNQUjCP8h1rbD1LWZ7gxKmI5RgMLaNkkBIDBJ/4J
         xFigs9LJVQcbxZe+FY2SBUah5QClMc49Bkki8YtPXiEX4sXW/OpRcWXGA2gJgQWjeHQC
         7zxlq66NTAuktNn32l1xE/alSUUrNUn1by+nLjY7ToSis1NvFu4Bsg6EHxribshncoBM
         uQaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqDoV/LssRoNZbt/NZdWiUhfGSDhlApZpf1hXdFB+XFPdXuflEn6sGzlN+dGP7u+6OAlUNhWaLf3e2a1SqIwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5QJaituqhZcerFmJzL24/ZpzA9ULQmvN7Cwj2v4BlH7jt8Ber
	iYmvQDKw1Vik8b3OR+m4nhTPsWjyARpPX3aqrhc0oKOF4loqHsAk66WkD1MKxyb3eRTJJsZjAxf
	HRCmFTHzHdkmLd+3vUa33iM7XrMALz0fbgK2TVE/gphITiQxkMCL81FGRJF3y3O1Xt7ZIY/tghe
	lrJLQhdBaf53mPN1Fu1Zkj7ObyRwp913QDzUER1Mh9qV9785QifOmx7oas
X-Gm-Gg: ASbGncusXoic9CMiTePGpffHfcQtwqktk10mKIg/sRhoZutbB63CcmeJxhVwC4SU687
	RmyNjsNoxAN98Ob/q2PUBYFAc5Sneo0NtcaN6fZ13P/K+dTbChbSMofo3CkZmBd0zXS2mbA==
X-Received: by 2002:a05:6a00:238d:b0:736:d6da:8f9e with SMTP id d2e1a72fcca58-736eb667a71mr7986964b3a.0.1741750584738;
        Tue, 11 Mar 2025 20:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMmxpIAevVVywh2O0MaRFt52q3IQdqP0x11H7Tx5Em3ifIbgwiYbMghj8Z7Q/WU0TpCaMabTo/4ereJNFvbKw=
X-Received: by 2002:a05:6a00:238d:b0:736:d6da:8f9e with SMTP id
 d2e1a72fcca58-736eb667a71mr7986941b3a.0.1741750584315; Tue, 11 Mar 2025
 20:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-6-df76624025eb@daynix.com>
 <CACGkMEuccQ6ah-aZ3tcW1VRuetEoPA_NaLxLT+9fb0uAab8Agg@mail.gmail.com>
 <2e550452-a716-4c3f-9d5a-3882d2c9912a@daynix.com> <CACGkMEu9tynRgTh__3p_vSqOekSirbVgS90rd5dUiJru9oV1eg@mail.gmail.com>
 <1dd2417a-3246-44b0-b4ba-feadfd6f794e@daynix.com>
In-Reply-To: <1dd2417a-3246-44b0-b4ba-feadfd6f794e@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Mar 2025 11:36:11 +0800
X-Gm-Features: AQ5f1JrxpKp6znsUaqgeF38Q8NdhxxsJo9tfhGhP07-EGgT1K5NsmabBVB2dyas
Message-ID: <CACGkMEthfj0KJvOHhnc_ww7iqtmhHUy9f9EGOoR-n0OwHOBrvQ@mail.gmail.com>
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

On Tue, Mar 11, 2025 at 2:24=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/11 9:42, Jason Wang wrote:
> > On Mon, Mar 10, 2025 at 3:04=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2025/03/10 13:43, Jason Wang wrote:
> >>> On Fri, Mar 7, 2025 at 7:02=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> VIRTIO_NET_F_HASH_REPORT allows to report hash values calculated on =
the
> >>>> host. When VHOST_NET_F_VIRTIO_NET_HDR is employed, it will report no
> >>>> hash values (i.e., the hash_report member is always set to
> >>>> VIRTIO_NET_HASH_REPORT_NONE). Otherwise, the values reported by the
> >>>> underlying socket will be reported.
> >>>>
> >>>> VIRTIO_NET_F_HASH_REPORT requires VIRTIO_F_VERSION_1.
> >>>>
> >>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>> ---
> >>>>    drivers/vhost/net.c | 49 +++++++++++++++++++++++++++++-----------=
---------
> >>>>    1 file changed, 29 insertions(+), 20 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >>>> index b9b9e9d40951856d881d77ac74331d914473cd56..16b241b44f89820a42c3=
02f3586ea6bb5e0d4289 100644
> >>>> --- a/drivers/vhost/net.c
> >>>> +++ b/drivers/vhost/net.c
> >>>> @@ -73,6 +73,7 @@ enum {
> >>>>           VHOST_NET_FEATURES =3D VHOST_FEATURES |
> >>>>                            (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
> >>>>                            (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
> >>>> +                        (1ULL << VIRTIO_NET_F_HASH_REPORT) |
> >>>>                            (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> >>>>                            (1ULL << VIRTIO_F_RING_RESET)
> >>>>    };
> >>>> @@ -1097,9 +1098,11 @@ static void handle_rx(struct vhost_net *net)
> >>>>                   .msg_controllen =3D 0,
> >>>>                   .msg_flags =3D MSG_DONTWAIT,
> >>>>           };
> >>>> -       struct virtio_net_hdr hdr =3D {
> >>>> -               .flags =3D 0,
> >>>> -               .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> >>>> +       struct virtio_net_hdr_v1_hash hdr =3D {
> >>>> +               .hdr =3D {
> >>>> +                       .flags =3D 0,
> >>>> +                       .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
> >>>> +               }
> >>>>           };
> >>>>           size_t total_len =3D 0;
> >>>>           int err, mergeable;
> >>>> @@ -1110,7 +1113,6 @@ static void handle_rx(struct vhost_net *net)
> >>>>           bool set_num_buffers;
> >>>>           struct socket *sock;
> >>>>           struct iov_iter fixup;
> >>>> -       __virtio16 num_buffers;
> >>>>           int recv_pkts =3D 0;
> >>>>
> >>>>           mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
> >>>> @@ -1191,30 +1193,30 @@ static void handle_rx(struct vhost_net *net)
> >>>>                           vhost_discard_vq_desc(vq, headcount);
> >>>>                           continue;
> >>>>                   }
> >>>> +               hdr.hdr.num_buffers =3D cpu_to_vhost16(vq, headcount=
);
> >>>>                   /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET=
_HDR */
> >>>>                   if (unlikely(vhost_hlen)) {
> >>>> -                       if (copy_to_iter(&hdr, sizeof(hdr),
> >>>> -                                        &fixup) !=3D sizeof(hdr)) {
> >>>> +                       if (copy_to_iter(&hdr, vhost_hlen,
> >>>> +                                        &fixup) !=3D vhost_hlen) {
> >>>>                                   vq_err(vq, "Unable to write vnet_h=
dr "
> >>>>                                          "at addr %p\n", vq->iov->io=
v_base);
> >>>>                                   goto out;
> >>>
> >>> Is this an "issue" specific to RSS/HASH? If it's not, we need a separ=
ate patch.
> >>>
> >>> Honestly, I'm not sure if it's too late to fix this.
> >>
> >> There is nothing wrong with the current implementation.
> >
> > Note that I meant the vhost_hlen part, and the current code is tricky.
> >
> > The comment said:
> >
> > """
> > /* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
> > """
> >
> > So it tries to only offer virtio_net_hdr even if vhost_hlen is the set
> > to mrg_rxbuf len.
> >
> > And this patch changes this behaviour.
>
> mrg_rxbuf only adds the num_buffers field, which is always set for
> mrg_rxbuf.
>
> The num_buffers was not set for VIRTIO_F_VERSION_1 in the past, but this
> was also fixed with commit a3b9c053d82a ("vhost/net: Set num_buffers for
> virtio 1.0")
>
> So there is no behavioral change for existing features with this patch.

I meant this part.

>>>> +                       if (copy_to_iter(&hdr, vhost_hlen,
>>>> +                                        &fixup) !=3D vhost_hlen) {

We should copy only sizeof(hdr) instead of vhost_hlen.

Anything I miss?

Thanks

>
> Regards,
> Akihiko Odaki
>
> >
> > Thanks
> >
> >> The current
> >> implementation fills the header with zero except num_buffers, which it
> >> fills some real value. This functionality is working fine with
> >> VIRTIO_NET_F_MRG_RXBUF and VIRTIO_F_VERSION_1, which change the header=
 size.
> >>
> >> Now I'm adding VIRTIO_NET_F_HASH_REPORT and it adds the hash_report
> >> field, which also needs to be initialized with zero, so I'm making sur=
e
> >> vhost_net will also initialize it.
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>>
> >>> Others look fine.
> >>>
> >>> Thanks
> >>>
> >>
> >
>


