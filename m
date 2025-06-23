Return-Path: <linux-kselftest+bounces-35604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2963DAE37A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 09:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2D1171AAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623041FE471;
	Mon, 23 Jun 2025 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ps5aIygr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE861F5834
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750665575; cv=none; b=L2RMK1fDR+rI4LhGNBMqiib+k6euCOqiZnNve3fCukYqDV7lCmbqAYAmLuTskhwLKBnrAPnjakKnQFBXEpLRjy40+JeH35a9QoNzPeAUhoEgqZqot/Rdn1DZil57TRmppKVE50S37ZbTl8JOqq4GKVoRa3zmOB+gAK3fh5qF46I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750665575; c=relaxed/simple;
	bh=HHJmqV+jwfbse4E8Oi+59YcCNYp92cl96nk1CYpxiuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BuG+fbmlq1ROEQivtm26J1iUWd3Jq1Jc5iegWB5n+3Q5tClKA5bYlOnp2cgaJBJsNi4qvKF0o4aFeSDKLBiKVgdu9d42EOg60qffpwU1yOxYGwNqAsNnpxzlPTAoOFa8EPMlfhqY485M3I21/2AIAs5NTYTot11HjAXa1FodL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ps5aIygr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750665571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=emrJOBRsp5arFozw0X66D0rFFPQQ8AoVHWnmbQLCei8=;
	b=Ps5aIygrSgkcC89V006LY9jV2ezAggjBWiN5NOqh808LgddmSPa4xgewRCb3nXR9QP0DhO
	FXrfNVeSvx8tSFhhwye+/hAA22tEG3yxoMpyikpeRHZo73HIkWAiaFFbRSPiN1QtnKkAFt
	NBIUVsMfyS9CZvfrdDsgZgcnqm8WpXk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-vJga9A_cMCm03WfcM-qDCg-1; Mon, 23 Jun 2025 03:59:29 -0400
X-MC-Unique: vJga9A_cMCm03WfcM-qDCg-1
X-Mimecast-MFC-AGG-ID: vJga9A_cMCm03WfcM-qDCg_1750665569
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748e6457567so2643894b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 00:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750665568; x=1751270368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emrJOBRsp5arFozw0X66D0rFFPQQ8AoVHWnmbQLCei8=;
        b=YOeGhFUb8n8QY9vMgSrsFiS0ASpyOck+dxUZhiGgAcoiS9HTo9QMYc1jWk8k6lHSHz
         g4u4W+WvKTKXAfxAEoakzmEVdvbIAmPTquRUqclbgDvAHz89O1zi+pCAdSHmmza00LyK
         s+Qxc7cfGzVePm+FX0FDArtvP3+CrejzhYbwAjDRqcH8aBjwaO8EQ89mHHCkIJXPDa1V
         By1iRfQfIAPjY3y14TrU32FMr4sHjKBU6NDUuzzB17VudFNexOvAHpetnDX1hvKDTe31
         1doQ8nCwYha7Fyvmx58OQ5nPAw0WYaZT+SABa5AxTWmRT4i7rVX4xpHBwYE+38+Cc64E
         zdpw==
X-Forwarded-Encrypted: i=1; AJvYcCVkA8b6OZO3UhqX6JmsOQ51vV3Srn5TKbXx3HBrARIAv9bhJ5eZBvZFbiiSa6Y3OF/cEsvdENIOIiP9idkjjA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygSxVwHfIGu2GH1Q8Y7VlXQXiciuPCBi5WuMfBM9/uB+K3uwo6
	JBHeC0x24z+hk492T4JV9FAQdzvZGe/2SuaMCl/ihZmXk7n5Y3VYw51wfm5wtfvs4Kh0/4PwCAV
	TYZl9Ky1OvzinVYLaa2dz6ZVACDxjDEL69+9datGQTNnxC+fk8D4a/+UG5tZdrx9rGWtfQfeO6R
	cCog6E0hwk/Ynee9liPb2HL8cV3QD5L3cuqObz6pvQlbqT
X-Gm-Gg: ASbGncuPcXm67ghq7axI9gZaDX44nrgrTHZRoyA9iE4Q7hZzQOrbyBTYI8f2mdayY21
	CglHgreb85bYkwhgVOoCI52g6k7Iib+g0kz3WiZMneqA7R6XHP3Fk+rjw166V1NC5VHNmuDI7P3
	vB8Gmt
X-Received: by 2002:a05:6a20:4321:b0:215:dacf:5746 with SMTP id adf61e73a8af0-220293b751amr18504367637.19.1750665568197;
        Mon, 23 Jun 2025 00:59:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqhEU48IsrQreUHVHTSRYLv8hE0X1YfsGlZa8E34wznwwaM6wv2gzW5f2OTDus7sy6qVCKc9dmxmpWcm4l544=
X-Received: by 2002:a05:6a20:4321:b0:215:dacf:5746 with SMTP id
 adf61e73a8af0-220293b751amr18504313637.19.1750665567436; Mon, 23 Jun 2025
 00:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-4-95d8b348de91@daynix.com>
 <CACGkMEupCBFH2eLv_93uy9K=+s_jQPM12mvyhU=zGbwSUnyVaA@mail.gmail.com>
 <a3e21479-2967-4604-a684-9b9b9e115f37@daynix.com> <CACGkMEuBb6eB9w=HgYq7wy2vW-4PMGGQKk5dd=kCm3ednJ2WxQ@mail.gmail.com>
 <56647ddd-c6ac-43cf-bcb2-626a162858a4@daynix.com> <CACGkMEs+3Pu9-E7RcmEzp6wZxZYwDS1G+1P3ti=Vzceq=C31YQ@mail.gmail.com>
 <48ae8ca2-d5e9-446c-b845-0df31f385ff6@daynix.com> <CACGkMEtXYCfPO9Zgyooz=wLBv4C_JBVWcoy0JcJpXR7pk8-=bw@mail.gmail.com>
 <655ea82a-f584-4c45-bd1f-2b5db44c6c25@daynix.com>
In-Reply-To: <655ea82a-f584-4c45-bd1f-2b5db44c6c25@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 23 Jun 2025 15:59:15 +0800
X-Gm-Features: AX0GCFv7mWXrEA1exn6vnG3gSVYN1n-0s4aT6wkQEgPEUEbyFK8N64hYWmWpL-g
Message-ID: <CACGkMEsOW=Ytj0usq8zf03tU0ODTPQQpE4mC=EqVKFbT388M-A@mail.gmail.com>
Subject: Re: [PATCH net-next v12 04/10] tun: Add common virtio-net hash
 feature code
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

On Fri, Jun 20, 2025 at 1:01=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/06/17 12:39, Jason Wang wrote:
> > On Fri, Jun 6, 2025 at 5:27=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> On 2025/06/06 10:01, Jason Wang wrote:
> >>> On Thu, Jun 5, 2025 at 4:18=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> On 2025/06/05 11:46, Jason Wang wrote:
> >>>>> On Wed, Jun 4, 2025 at 4:42=E2=80=AFPM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>>>
> >>>>>> On 2025/06/04 10:53, Jason Wang wrote:
> >>>>>>> On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.o=
daki@daynix.com> wrote:
> >>>>>>>>
> >>>>>>>> Add common code required for the features being added to TUN and=
 TAP.
> >>>>>>>> They will be enabled for each of them in following patches.
> >>>>>>>>
> >>>>>>>> Added Features
> >>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>>>
> >>>>>>>> Hash reporting
> >>>>>>>> --------------
> >>>>>>>>
> >>>>>>>> Allow the guest to reuse the hash value to make receive steering
> >>>>>>>> consistent between the host and guest, and to save hash computat=
ion.
> >>>>>>>>
> >>>>>>>> Receive Side Scaling (RSS)
> >>>>>>>> --------------------------
> >>>>>>>>
> >>>>>>>> RSS is a receive steering algorithm that can be negotiated to us=
e with
> >>>>>>>> virtio_net. Conventionally the hash calculation was done by the =
VMM.
> >>>>>>>> However, computing the hash after the queue was chosen defeats t=
he
> >>>>>>>> purpose of RSS.
> >>>>>>>>
> >>>>>>>> Another approach is to use eBPF steering program. This approach =
has
> >>>>>>>> another downside: it cannot report the calculated hash due to th=
e
> >>>>>>>> restrictive nature of eBPF steering program.
> >>>>>>>>
> >>>>>>>> Introduce the code to perform RSS to the kernel in order to over=
come
> >>>>>>>> thse challenges. An alternative solution is to extend the eBPF s=
teering
> >>>>>>>> program so that it will be able to report to the userspace, but =
I didn't
> >>>>>>>> opt for it because extending the current mechanism of eBPF steer=
ing
> >>>>>>>> program as is because it relies on legacy context rewriting, and
> >>>>>>>> introducing kfunc-based eBPF will result in non-UAPI dependency =
while
> >>>>>>>> the other relevant virtualization APIs such as KVM and vhost_net=
 are
> >>>>>>>> UAPIs.
> >>>>>>>>
> >>>>>>>> Added ioctls
> >>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>>>
> >>>>>>>> They are designed to make extensibility and VM migration compati=
ble.
> >>>>>>>> This change only adds the implementation and does not expose the=
m to
> >>>>>>>> the userspace.
> >>>>>>>>
> >>>>>>>> TUNGETVNETHASHTYPES
> >>>>>>>> -------------------
> >>>>>>>>
> >>>>>>>> This ioctl tells supported hash types. It is useful to check if =
a VM can
> >>>>>>>> be migrated to the current host.
> >>>>>>>>
> >>>>>>>> TUNSETVNETREPORTINGAUTOMQ, TUNSETVNETREPORTINGRSS, and TUNSETVNE=
TRSS
> >>>>>>>> ----------------------------------------------------------------=
----
> >>>>>>>>
> >>>>>>>> These ioctls configures a steering algorithm and, if needed, has=
h
> >>>>>>>> reporting.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>>>>>> ---
> >>>>>>>>      drivers/net/tap.c           |  10 ++-
> >>>>>>>>      drivers/net/tun.c           |  12 +++-
> >>>>>>>>      drivers/net/tun_vnet.h      | 165 +++++++++++++++++++++++++=
++++++++++++++++---
> >>>>>>>>      include/uapi/linux/if_tun.h |  71 +++++++++++++++++++
> >>>>>>>>      4 files changed, 244 insertions(+), 14 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>>>>>> index d4ece538f1b2..25c60ff2d3f2 100644
> >>>>>>>> --- a/drivers/net/tap.c
> >>>>>>>> +++ b/drivers/net/tap.c
> >>>>>>>> @@ -179,6 +179,11 @@ static void tap_put_queue(struct tap_queue =
*q)
> >>>>>>>>             sock_put(&q->sk);
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>> +static const struct virtio_net_hash *tap_find_hash(const struct=
 sk_buff *skb)
> >>>>>>>> +{
> >>>>>>>> +       return NULL;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>      /*
> >>>>>>>>       * Select a queue based on the rxq of the device on which t=
his packet
> >>>>>>>>       * arrived. If the incoming device is not mq, calculate a f=
low hash
> >>>>>>>> @@ -711,11 +716,12 @@ static ssize_t tap_put_user(struct tap_que=
ue *q,
> >>>>>>>>             int total;
> >>>>>>>>
> >>>>>>>>             if (q->flags & IFF_VNET_HDR) {
> >>>>>>>> -               struct virtio_net_hdr vnet_hdr;
> >>>>>>>> +               struct virtio_net_hdr_v1_hash vnet_hdr;
> >>>>>>>>
> >>>>>>>>                     vnet_hdr_len =3D READ_ONCE(q->vnet_hdr_sz);
> >>>>>>>>
> >>>>>>>> -               ret =3D tun_vnet_hdr_from_skb(q->flags, NULL, sk=
b, &vnet_hdr);
> >>>>>>>> +               ret =3D tun_vnet_hdr_from_skb(vnet_hdr_len, q->f=
lags, NULL, skb,
> >>>>>>>> +                                           tap_find_hash, &vnet=
_hdr);
> >>>>>>>>                     if (ret)
> >>>>>>>>                             return ret;
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>>>>> index 9133ab9ed3f5..03d47799e9bd 100644
> >>>>>>>> --- a/drivers/net/tun.c
> >>>>>>>> +++ b/drivers/net/tun.c
> >>>>>>>> @@ -451,6 +451,11 @@ static inline void tun_flow_save_rps_rxhash=
(struct tun_flow_entry *e, u32 hash)
> >>>>>>>>                     e->rps_rxhash =3D hash;
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>> +static const struct virtio_net_hash *tun_find_hash(const struct=
 sk_buff *skb)
> >>>>>>>> +{
> >>>>>>>> +       return NULL;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>      /* We try to identify a flow through its rxhash. The reason=
 that
> >>>>>>>>       * we do not check rxq no. is because some cards(e.g 82599)=
, chooses
> >>>>>>>>       * the rxq based on the txq where the last packet of the fl=
ow comes. As
> >>>>>>>> @@ -1993,7 +1998,7 @@ static ssize_t tun_put_user_xdp(struct tun=
_struct *tun,
> >>>>>>>>             ssize_t ret;
> >>>>>>>>
> >>>>>>>>             if (tun->flags & IFF_VNET_HDR) {
> >>>>>>>> -               struct virtio_net_hdr gso =3D { 0 };
> >>>>>>>> +               struct virtio_net_hdr_v1_hash gso =3D { 0 };
> >>>>>>>>
> >>>>>>>>                     vnet_hdr_sz =3D READ_ONCE(tun->vnet_hdr_sz);
> >>>>>>>>                     ret =3D tun_vnet_hdr_put(vnet_hdr_sz, iter, =
&gso);
> >>>>>>>> @@ -2046,9 +2051,10 @@ static ssize_t tun_put_user(struct tun_st=
ruct *tun,
> >>>>>>>>             }
> >>>>>>>>
> >>>>>>>>             if (vnet_hdr_sz) {
> >>>>>>>> -               struct virtio_net_hdr gso;
> >>>>>>>> +               struct virtio_net_hdr_v1_hash gso;
> >>>>>>>>
> >>>>>>>> -               ret =3D tun_vnet_hdr_from_skb(tun->flags, tun->d=
ev, skb, &gso);
> >>>>>>>> +               ret =3D tun_vnet_hdr_from_skb(vnet_hdr_sz, tun->=
flags, tun->dev,
> >>>>>>>> +                                           skb, tun_find_hash, =
&gso);
> >>>>>>>>                     if (ret)
> >>>>>>>>                             return ret;
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> >>>>>>>> index 58b9ac7a5fc4..45d0533efc8d 100644
> >>>>>>>> --- a/drivers/net/tun_vnet.h
> >>>>>>>> +++ b/drivers/net/tun_vnet.h
> >>>>>>>> @@ -6,6 +6,17 @@
> >>>>>>>>      #define TUN_VNET_LE     0x80000000
> >>>>>>>>      #define TUN_VNET_BE     0x40000000
> >>>>>>>>
> >>>>>>>> +typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_=
buff *);
> >>>>>>>> +typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(con=
st struct sk_buff *);
> >>>>>>>> +
> >>>>>>>> +struct tun_vnet_hash {
> >>>>>>>> +       bool report;
> >>>>>>>> +       bool rss;
> >>>>>>>> +       struct tun_vnet_rss common;
> >>>>>>>> +       u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >>>>>>>> +       u16 rss_indirection_table[];
> >>>>>>>> +};
> >>>>>>>> +
> >>>>>>>>      static inline bool tun_vnet_legacy_is_little_endian(unsigne=
d int flags)
> >>>>>>>>      {
> >>>>>>>>             bool be =3D IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> >>>>>>>> @@ -107,6 +118,128 @@ static inline long tun_vnet_ioctl(int *vne=
t_hdr_sz, unsigned int *flags,
> >>>>>>>>             }
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>> +static inline long tun_vnet_ioctl_gethashtypes(u32 __user *argp=
)
> >>>>>>>> +{
> >>>>>>>> +       return put_user(VIRTIO_NET_SUPPORTED_HASH_TYPES, argp) ?=
 -EFAULT : 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static inline long tun_vnet_ioctl_sethash(struct tun_vnet_hash =
__rcu **hashp,
> >>>>>>>> +                                         unsigned int cmd,
> >>>>>>>> +                                         void __user *argp)
> >>>>>>>> +{
> >>>>>>>> +       struct tun_vnet_rss common;
> >>>>>>>> +       struct tun_vnet_hash *hash;
> >>>>>>>> +       size_t indirection_table_size;
> >>>>>>>> +       size_t key_size;
> >>>>>>>> +       size_t size;
> >>>>>>>> +
> >>>>>>>> +       switch (cmd) {
> >>>>>>>> +       case TUNSETVNETREPORTINGAUTOMQ:
> >>>>>>>> +               if (get_user(common.hash_types, (u32 __user *)ar=
gp))
> >>>>>>>> +                       return -EFAULT;
> >>>>>>>> +
> >>>>>>>> +               if (common.hash_types) {
> >>>>>>>> +                       hash =3D kzalloc(sizeof(*hash), GFP_KERN=
EL);
> >>>>>>>> +                       if (!hash)
> >>>>>>>> +                               return -ENOMEM;
> >>>>>>>> +
> >>>>>>>> +                       hash->report =3D true;
> >>>>>>>> +                       hash->common.hash_types =3D common.hash_=
types;
> >>>>>>>> +               } else {
> >>>>>>>> +                       hash =3D NULL;
> >>>>>>>> +               }
> >>>>>>>> +               break;
> >>>>>>>> +
> >>>>>>>> +       case TUNSETVNETREPORTINGRSS:
> >>>>>>>> +       case TUNSETVNETRSS:
> >>>>>>>
> >>>>>>> So the above three shows unnecessary design redundancy as well as=
 a
> >>>>>>> burden for the future extension.  Why not simply have
> >>>>>>>
> >>>>>>> 1) TUNSETVNET_RSS
> >>>>>>> 2) TUNSETVNET_HASH_REPORT
> >>>>>>> ?
> >>>>>>>
> >>>>>>> Which maps to
> >>>>>>>
> >>>>>>>      #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1 (for config=
urable
> >>>>>>> receive steering)
> >>>>>>>      #define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2 (for config=
urable
> >>>>>>> hash calculation)
> >>>>>>>
> >>>>>>> It would be always easier to start with what spec had or at least=
 we
> >>>>>>> need to explain why we choose a different design here or in the
> >>>>>>> changelog to ease our life.
> >>>>>>
> >>>>>> TUNSETVNETREPORTINGAUTOMQ maps to VIRTIO_NET_CTRL_MQ_HASH_CONFIG.
> >>>>>
> >>>>> It's not:
> >>>>>
> >>>>> VIRTIO_NET_CTRL_MQ_HASH_CONFIG uses:
> >>>>>
> >>>>> struct virtio_net_hash_config {
> >>>>>        le32 hash_types;
> >>>>>        le16 reserved[4];
> >>>>>        u8 hash_key_length;
> >>>>>        u8 hash_key_data[hash_key_length];
> >>>>> };
> >>>>>
> >>>>> but TUNSETVNETREPORTINGAUTOMQ only accepts hash_types without other=
s:
> >>>>
> >>>> The others are not present because the spec doesn't specify what to =
do
> >>>> with them and the kernel doesn't use them either.
> >>>
> >>> Did you mean the hash_key_length and hash_key_data? Note that we have
> >>> drivers other than the Linux ones as well.
> >>
> >> And reserved. Drivers can set whatever to these fields. It is not
> >> specified how these fields should be used.
> >>
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>> TUNSETVNETREPORTINGRSS and TUNSETVNETRSS map to
> >>>>>> VIRTIO_NET_CTRL_MQ_RSS_CONFIG.
> >>>>>
> >>>>> I think we've already had a discussion about this.
> >>>>>
> >>>>> Reusing virtio-net uAPI is much better instead of having a tun
> >>>>> specific one considering tun may need to support more virtio comman=
ds
> >>>>> in the future. Or maybe it's the time to introduce a transport for =
the
> >>>>> virtio control virtqueue uAPI in tuntap to avoid inventing new uAPI
> >>>>> endlessly.
> >>>>>
> >>>>> What's more I see:
> >>>>>
> >>>>> struct tun_vnet_rss {
> >>>>>            __u32 hash_types;
> >>>>>            __u16 indirection_table_mask;
> >>>>>            __u16 unclassified_queue;
> >>>>> };
> >>>>>
> >>>>> struct tun_vnet_hash {
> >>>>>            bool report;
> >>>>>            bool rss;
> >>>>>            struct tun_vnet_rss common;
> >>>>>            u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >>>>>            u16 rss_indirection_table[];
> >>>>> };
> >>>>>
> >>>>> As I pointed out in the past, let's just decouple the rss from hash=
,
> >>>>> everything would be much simpler, or you need to explain why you
> >>>>> couple this somewhere.
> >>>>>
> >>>>> For example:
> >>>>>
> >>>>> 1) why is the tun_vnet_hash not part of the uAPI but tun_vnet_rss, =
or
> >>>>> how could userspace know what kind of format it would use for
> >>>>> TUNSETVNETREPORTINGRSS?
> >>>>
> >>>> That was the previous version.
> >>>>
> >>>>> 2) what's the advantages of embedding rss specific stuff into hash
> >>>>> report structure
> >>>>
> >>>> Because the hash types field in struct tun_vnet_rss is used by hash
> >>>> reporting too.
> >>>>
> >>>>> 3) what's the advantages of not using virtio-net uAPI
> >>>>
> >>>> 1. The use cases that don't involve VM will be simplified; programs =
for
> >>>> such a use case will not need to convert endian or to fill fileds th=
e
> >>>> kernel doesn't care.
> >>>
> >>> Well, virtio_net_hdr is used by packet socket as well. Considering th=
e
> >>> complexity of designing a new uAPI, it's still better.
> >>
> >> This patch series also reuses the datapath, following the prior exampl=
es.
> >>
> >>>
> >>> Or maybe you can clarify which field that kernel doesn't care about?
> >>> In this case TUN/TAP is basically the device datapath, if some of the
> >>> fields don't make sense, it's a bug of the spec.
> >>
> >> reserved, hash_key_length, and hash_key_data.
> >
> > I may miss something when RSS is not negotiated, hash_key_length, and
> > hash_key_data is necessary, otherwise how could we calculate the hash?
>
> I was not clear that I was referring to the fields of struct
> virtio_net_hash_config. struct virtio_net_rss_config provides
> hash_key_length and hash_key_data for RSS.
>
> >
> >>
> >>>
> >>>> 2. It aligns with existing UAPIs that operate in native endian and d=
on't
> >>>> use virtio-net data structures like TUNSETOFFLOAD and TUNSETVNETHDRS=
Z.
> >>>
> >>> For those two examples, it would be used by guests directly. This is
> >>> different from RSS stuff.
> >>
> >> They are mediated by the VMM, which is no different from RSS.
> >
> > Not necessarily, e,g Qemu support vDPA control virtqueue passthrough.
>
> TUNSETOFFLOAD and TUNSETVNETHDRSZ are not used with vDPA, are they?

They aren't but I mean hash/rss config.

>
> >
> >>
> >>>
> >>> With native endian, you need an endian conversation that converts le =
to native.
> >>
> >> That's true, but QEMU does so anyway to validate the configuration, to
> >> attach/detach queues, and to share the data structures with userspace
> >> RSS implementations. I expect other VMMs will do so too.
> >
> > See above.
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>> More issues:
> >>>>>
> >>>>> 1) max_tx_vq is ignored, so do you expect the userspace to intercep=
t
> >>>>> this and switch to using TUNSETQUEUE? This seems like a burden as T=
UN
> >>>>> can simply accept it and do the attaching/detaching by itself
> >>>>> 2) the rx depends on the indirection table, so userspace need to
> >>>>> intercept the indirection and change the rx queue numbers according=
ly
> >>>>> 3) RSS allows a async TX/RX queue, this is not supported by TUN now=
,
> >>>>> no matter if we decide to let userspace to intercept max_tx_vq or n=
ot,
> >>>>> we need to implement it first
> >>>>    > > Things would be much more simpler, if kernel can do 1) and 2)=
.
> >>>>
> >>>> Attaching and detaching queues is not possible for the kernel becaus=
e it
> >>>> doesn't know what file descriptors that map to queues will be used b=
y
> >>>> the userspace.
> >>>
> >>> The kernel knows, tfile has a queue_index part.
> >>
> >> queue_index is set with TUNSETQUEUE so we need the ioctl.
> >
> > queue_index would be reshuffle during attaching/detaching since the
> > netdev core forbids sparse active queue indices.
> >
> > But I don't see it's an issue since we are talking about introducing
> > new uAPI here.
>
> If queue_index is not usable, how can we pick queues for the new UAPI?

But queue_index is contiguous, so we can use the first several ones.

>
> >
> > If it doesn't work, it doesn't change the point, a new uAPI is needed
> > since RSS requires async tx/rx queue numbers, current TUN only allows
> > combined queue pairs.
>
> TUN can have more tx/rx queues than the guest requests, so a VMM can
> take the maximum of TX and RX queue numbers to derive the number of
> queue pairs when the guest reqeusts async tx/rx queue numbers.

I think we are talking about the same issue, I mean anyhow you need a
new uAPI to tell the kernel it needs to start async tx/rx. This is not
supported in the current kernel.

>
> >
> >>
> >>>
> >>>>
> >>>> The following patch does 2) for QEMU:
> >>>> https://lore.kernel.org/qemu-devel/20250322-vq-v2-1-cee0aafe6404@day=
nix.com/
> >>>
> >>> See below point, form the view of the kernel, it's still a queue pair
> >>> not async TX/RX queue.
> >>>
> >>>>
> >>>> For 3), the patch for QEMU takes the maximum of TX and RX queue numb=
ers
> >>>> to derive the number of queue pairs.
> >>>>
> >>>>>
> >>>>>> We have two ioctls here because
> >>>>>> VIRTIO_NET_CTRL_MQ_RSS_CONFIG behaves differently depending on whe=
ther
> >>>>>> VIRTIO_NET_F_HASH_REPORT is negotiated or not;
> >>>>>
> >>>>> It wouldn't be a problem if you do 1:1 mapping between virtio comma=
nds
> >>>>> and TUN uAPI, otherwise it should have a bug somewhere.
> >>>>
> >>>> Speaking of 1:1 mapping, it is possible to map VIRTIO_NET_F_HASH_REP=
ORT
> >>>> into another ioctl. It may help add another receive steering algorit=
hm
> >>>> in the future by not requiring two ioctls (TUNSETVNETREPORTING_X and
> >>>> TUNSETVNET_X).
> >>>
> >>> Yes and as I pointed out, virtio_net_hash_config should not be
> >>> specific to automq, it can work for other steering algorithm as well.
> >>
> >> That's not what the virtio spec says, so it will not be 1:1 mapping
> >> between virtio commands and TUN uAPI.
> >
> > That's only because the spec only supports RSS and AUTOMQ so far. Or
> > do we expect a new virtio_net_XXX_hash_config for the new steering
> > algorithm?
>
> No. RSS only needs struct virtio_net_rss_config for hash configuration,
> and a new steering algorithm will only need one struct. For example, if
> the spec is to gain siphash, we will need to add struct
> virtio_net_siphash_config.

I think there're several things. We should decouple hash from the steering.

New steering algorithm doesn't necessarily hash or new hash algorithm.

>
> struct virtio_net_hash_config is only for automq.
>
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>>> it also enables hash
> >>>>>> reporting if the feature is negotiated.
> >>>>>
> >>>>> Again, starting from virtio-net command is easier, a strong
> >>>>> justification is needed to explain why we choose another for tun/ta=
p.
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> One day we would have tun_select_queue_algorithm_x() we don't hav=
e to
> >>>>>>> duplicate the ioctls once again here like TUNSETVNETREPORTINGXYZ
> >>>>>>
> >>>>>> 5.1.6.5.6.4 Hash calculation says:
> >>>>>>>     If VIRTIO_NET_F_HASH_REPORT was negotiated and the device use=
s
> >>>>>>> automatic receive steering, the device MUST support a command to
> >>>>>>> configure hash calculation parameters.
> >>>>>>>
> >>>>>>> The driver provides parameters for hash calculation as follows:
> >>>>>>>
> >>>>>>> class VIRTIO_NET_CTRL_MQ, command VIRTIO_NET_CTRL_MQ_HASH_CONFIG.
> >>>>>>
> >>>>>> VIRTIO_NET_CTRL_MQ_HASH_CONFIG is for automatic receive steering a=
nd not
> >>>>>> for RSS (or other steering algorithms if the spec gets any in the =
future).
> >>>>>
> >>>>> I'm not sure but the spec needs some tweaking. For example, I don't
> >>>>> expect there would be a dedicated hash config command for flow filt=
ers
> >>>>> in the future. I think the reason why spec says like this is that
> >>>>> virtio-net only supports automatic receive steering.
> >>>>>
> >>>>> Note that macvtap doesn't implement automatic receive steering.
> >>>>
> >>>> QEMU advertises VIRTIO_NET_F_CTRL_VQ for macvtap too, so it should h=
ave
> >>>> implemented it. I think QEMU with macvtap still compliant to the spe=
c.
> >>>
> >>> Compliant, but automatic traffic steering is the best effort as well.
> >>>
> >>> Nope, TUN/TAP implements a flow cache that can steer tx based on rx.
> >>> Macvtap simply uses hash here.
> >>>
> >>>>
> >>>> "5.1.6.5.6 Automatic receive steering in multiqueue mode" says:
> >>>>
> >>>>    > After the driver transmitted a packet of a flow on transmitqX, =
the
> >>>>    > device SHOULD cause incoming packets for that flow to be steere=
d to
> >>>>    > receiveqX.
> >>>>
> >>>> It is "SHOULD", so it is still compliant if the device doesn't prope=
rly
> >>>> respect the flow.
> >>>
> >>> Yes, a quality of implementation, or it's impractical to support a
> >>> correct steering for this device as limited resources and mailious
> >>> users can do syn flood etc.
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>> +               if (copy_from_user(&common, argp, sizeof(common)=
))
> >>>>>>>> +                       return -EFAULT;
> >>>>>>>> +               argp =3D (struct tun_vnet_rss __user *)argp + 1;
> >>>>>>>> +
> >>>>>>>> +               indirection_table_size =3D ((size_t)common.indir=
ection_table_mask + 1) * 2;
> >>>>>>>> +               key_size =3D virtio_net_hash_key_length(common.h=
ash_types);
> >>>>>>>> +               size =3D struct_size(hash, rss_indirection_table=
,
> >>>>>>>> +                                  (size_t)common.indirection_ta=
ble_mask + 1);
> >>>>>>>> +
> >>>>>>>> +               hash =3D kmalloc(size, GFP_KERNEL);
> >>>>>>>> +               if (!hash)
> >>>>>>>> +                       return -ENOMEM;
> >>>>>>>> +
> >>>>>>>> +               if (copy_from_user(hash->rss_indirection_table,
> >>>>>>>> +                                  argp, indirection_table_size)=
) {
> >>>>>>>> +                       kfree(hash);
> >>>>>>>> +                       return -EFAULT;
> >>>>>>>> +               }
> >>>>>>>> +               argp =3D (u16 __user *)argp + common.indirection=
_table_mask + 1;
> >>>>>>>> +
> >>>>>>>> +               if (copy_from_user(hash->rss_key, argp, key_size=
)) {
> >>>>>>>> +                       kfree(hash);
> >>>>>>>> +                       return -EFAULT;
> >>>>>>>> +               }
> >>>>>>>> +
> >>>>>>>> +               virtio_net_toeplitz_convert_key(hash->rss_key, k=
ey_size);
> >>>>>>>> +               hash->report =3D cmd =3D=3D TUNSETVNETREPORTINGR=
SS;
> >>>>>>>
> >>>>>>> At least, if this is the only difference why not simply code this=
 into
> >>>>>>> the ioctl itself other than having a very similar command?
> >>>>>>
> >>>>>> It is what the previous version did. Either is fine I guess; the o=
nly
> >>>>>> practical difference would be the size of the configuration struct=
 is
> >>>>>> smaller with this approach.
> >>>>>>
> >>>>>>>
> >>>>>>>> +               hash->rss =3D true;
> >>>>>>>> +               hash->common =3D common;
> >>>>>>>> +               break;
> >>>>>>>> +
> >>>>>>>> +       default:
> >>>>>>>> +               return -EINVAL;
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(*hashp, ha=
sh));
> >>>>>>>> +       return 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static inline void tun_vnet_hash_report(const struct tun_vnet_h=
ash *hash,
> >>>>>>>> +                                       struct sk_buff *skb,
> >>>>>>>> +                                       const struct flow_keys_b=
asic *keys,
> >>>>>>>> +                                       u32 value,
> >>>>>>>> +                                       tun_vnet_hash_add vnet_h=
ash_add)
> >>>>>>>> +{
> >>>>>>>> +       struct virtio_net_hash *report;
> >>>>>>>> +
> >>>>>>>> +       if (!hash || !hash->report)
> >>>>>>>> +               return;
> >>>>>>>> +
> >>>>>>>> +       report =3D vnet_hash_add(skb);
> >>>>>>>> +       if (!report)
> >>>>>>>> +               return;
> >>>>>>>> +
> >>>>>>>> +       *report =3D (struct virtio_net_hash) {
> >>>>>>>> +               .report =3D virtio_net_hash_report(hash->common.=
hash_types, keys),
> >>>>>>>> +               .value =3D value
> >>>>>>>> +       };
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static inline u16 tun_vnet_rss_select_queue(u32 numqueues,
> >>>>>>>> +                                           const struct tun_vne=
t_hash *hash,
> >>>>>>>> +                                           struct sk_buff *skb,
> >>>>>>>> +                                           tun_vnet_hash_add vn=
et_hash_add)
> >>>>>>>> +{
> >>>>>>>> +       struct virtio_net_hash *report;
> >>>>>>>> +       struct virtio_net_hash ret;
> >>>>>>>> +       u16 index;
> >>>>>>>> +
> >>>>>>>> +       if (!numqueues)
> >>>>>>>> +               return 0;
> >>>>>>>> +
> >>>>>>>> +       virtio_net_hash_rss(skb, hash->common.hash_types, hash->=
rss_key, &ret);
> >>>>>>>> +
> >>>>>>>> +       if (!ret.report)
> >>>>>>>> +               return hash->common.unclassified_queue % numqueu=
es;
> >>>>>>>> +
> >>>>>>>> +       if (hash->report) {
> >>>>>>>> +               report =3D vnet_hash_add(skb);
> >>>>>>>> +               if (report)
> >>>>>>>> +                       *report =3D ret;
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       index =3D ret.value & hash->common.indirection_table_mas=
k;
> >>>>>>>> +
> >>>>>>>> +       return hash->rss_indirection_table[index] % numqueues;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>>      static inline int tun_vnet_hdr_get(int sz, unsigned int fla=
gs,
> >>>>>>>>                                        struct iov_iter *from,
> >>>>>>>>                                        struct virtio_net_hdr *hd=
r)
> >>>>>>>> @@ -135,15 +268,17 @@ static inline int tun_vnet_hdr_get(int sz,=
 unsigned int flags,
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>>      static inline int tun_vnet_hdr_put(int sz, struct iov_iter =
*iter,
> >>>>>>>> -                                  const struct virtio_net_hdr *=
hdr)
> >>>>>>>> +                                  const struct virtio_net_hdr_v=
1_hash *hdr)
> >>>>>>>>      {
> >>>>>>>> +       int content_sz =3D MIN(sizeof(*hdr), sz);
> >>>>>>>> +
> >>>>>>>>             if (unlikely(iov_iter_count(iter) < sz))
> >>>>>>>>                     return -EINVAL;
> >>>>>>>>
> >>>>>>>> -       if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) !=3D =
sizeof(*hdr)))
> >>>>>>>> +       if (unlikely(copy_to_iter(hdr, content_sz, iter) !=3D co=
ntent_sz))
> >>>>>>>>                     return -EFAULT;
> >>>>>>>>
> >>>>>>>> -       if (iov_iter_zero(sz - sizeof(*hdr), iter) !=3D sz - siz=
eof(*hdr))
> >>>>>>>> +       if (iov_iter_zero(sz - content_sz, iter) !=3D sz - conte=
nt_sz)
> >>>>>>>>                     return -EFAULT;
> >>>>>>>>
> >>>>>>>>             return 0;
> >>>>>>>> @@ -155,26 +290,38 @@ static inline int tun_vnet_hdr_to_skb(unsi=
gned int flags, struct sk_buff *skb,
> >>>>>>>>             return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_l=
ittle_endian(flags));
> >>>>>>>>      }
> >>>>>>>>
> >>>>>>>> -static inline int tun_vnet_hdr_from_skb(unsigned int flags,
> >>>>>>>> +static inline int tun_vnet_hdr_from_skb(int sz, unsigned int fl=
ags,
> >>>>>>>>                                             const struct net_dev=
ice *dev,
> >>>>>>>>                                             const struct sk_buff=
 *skb,
> >>>>>>>> -                                       struct virtio_net_hdr *h=
dr)
> >>>>>>>> +                                       tun_vnet_hash_find vnet_=
hash_find,
> >>>>>>>> +                                       struct virtio_net_hdr_v1=
_hash *hdr)
> >>>>>>>>      {
> >>>>>>>>             int vlan_hlen =3D skb_vlan_tag_present(skb) ? VLAN_H=
LEN : 0;
> >>>>>>>> +       const struct virtio_net_hash *report =3D sz < sizeof(str=
uct virtio_net_hdr_v1_hash) ?
> >>>>>>>> +                                              NULL : vnet_hash_=
find(skb);
> >>>>>>>> +
> >>>>>>>> +       *hdr =3D (struct virtio_net_hdr_v1_hash) {
> >>>>>>>> +               .hash_report =3D VIRTIO_NET_HASH_REPORT_NONE
> >>>>>>>> +       };
> >>>>>>>> +
> >>>>>>>> +       if (report) {
> >>>>>>>> +               hdr->hash_value =3D cpu_to_le32(report->value);
> >>>>>>>> +               hdr->hash_report =3D cpu_to_le16(report->report)=
;
> >>>>>>>> +       }
> >>>>>>>>
> >>>>>>>> -       if (virtio_net_hdr_from_skb(skb, hdr,
> >>>>>>>> +       if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr =
*)hdr,
> >>>>>>>>                                         tun_vnet_is_little_endia=
n(flags), true,
> >>>>>>>>                                         vlan_hlen)) {
> >>>>>>>>                     struct skb_shared_info *sinfo =3D skb_shinfo=
(skb);
> >>>>>>>>
> >>>>>>>>                     if (net_ratelimit()) {
> >>>>>>>>                             netdev_err(dev, "unexpected GSO type=
: 0x%x, gso_size %d, hdr_len %d\n",
> >>>>>>>> -                                  sinfo->gso_type, tun_vnet16_t=
o_cpu(flags, hdr->gso_size),
> >>>>>>>> -                                  tun_vnet16_to_cpu(flags, hdr-=
>hdr_len));
> >>>>>>>> +                                  sinfo->gso_type, tun_vnet16_t=
o_cpu(flags, hdr->hdr.gso_size),
> >>>>>>>> +                                  tun_vnet16_to_cpu(flags, hdr-=
>hdr.hdr_len));
> >>>>>>>>                             print_hex_dump(KERN_ERR, "tun: ",
> >>>>>>>>                                            DUMP_PREFIX_NONE,
> >>>>>>>>                                            16, 1, skb->head,
> >>>>>>>> -                                      min(tun_vnet16_to_cpu(fla=
gs, hdr->hdr_len), 64), true);
> >>>>>>>> +                                      min(tun_vnet16_to_cpu(fla=
gs, hdr->hdr.hdr_len), 64), true);
> >>>>>>>>                     }
> >>>>>>>>                     WARN_ON_ONCE(1);
> >>>>>>>>                     return -EINVAL;
> >>>>>>>> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if=
_tun.h
> >>>>>>>> index 980de74724fc..fe4b984d3bbb 100644
> >>>>>>>> --- a/include/uapi/linux/if_tun.h
> >>>>>>>> +++ b/include/uapi/linux/if_tun.h
> >>>>>>>> @@ -62,6 +62,62 @@
> >>>>>>>>      #define TUNSETCARRIER _IOW('T', 226, int)
> >>>>>>>>      #define TUNGETDEVNETNS _IO('T', 227)
> >>>>>>>>
> >>>>>>>> +/**
> >>>>>>>> + * define TUNGETVNETHASHTYPES - ioctl to get supported virtio_n=
et hashing types
> >>>>>>>> + *
> >>>>>>>> + * The argument is a pointer to __u32 which will store the supp=
orted virtio_net
> >>>>>>>> + * hashing types.
> >>>>>>>> + */
> >>>>>>>> +#define TUNGETVNETHASHTYPES _IOR('T', 228, __u32)
> >>>>>>>> +
> >>>>>>>> +/**
> >>>>>>>> + * define TUNSETVNETREPORTINGAUTOMQ - ioctl to enable automq wi=
th hash reporting
> >>>>>>>> + *
> >>>>>>>> + * Disable RSS and enable automatic receive steering with hash =
reporting.
> >>>>>>>> + *
> >>>>>>>> + * The argument is a pointer to __u32 that contains a bitmask o=
f hash types
> >>>>>>>> + * allowed to be reported.
> >>>>>>>> + *
> >>>>>>>> + * This ioctl results in %EBADFD if the underlying device is de=
leted. It affects
> >>>>>>>> + * all queues attached to the same device.
> >>>>>>>> + *
> >>>>>>>> + * This ioctl currently has no effect on XDP packets and packet=
s with
> >>>>>>>> + * queue_mapping set by TC.
> >>>>>>>> + */
> >>>>>>>> +#define TUNSETVNETREPORTINGAUTOMQ _IOR('T', 229, __u32)
> >>>>>>>> +
> >>>>>>>> +/**
> >>>>>>>> + * define TUNSETVNETREPORTINGRSS - ioctl to enable RSS with has=
h reporting
> >>>>>>>> + *
> >>>>>>>> + * Disable automatic receive steering and enable RSS with hash =
reporting.
> >>>>>>>
> >>>>>>> This is unnecessary, e.g one day will have select_queue_xyz(), we
> >>>>>>> don't want to say "Disable automatic receive steering and xyz ...=
"
> >>>>>>
> >>>>>> It is still something better to be documented as its behavior is
> >>>>>> somewhat complicated.
> >>>>>
> >>>>> This is a hint of uAPI design issue.
> >>>>>
> >>>>>>
> >>>>>> Concretely, this ioctl disables automatic receive steering but doe=
sn't
> >>>>>> disable steering by eBPF, which is implied by TUN_STEERINGEBPF_FAL=
LBACK.
> >>>>>
> >>>>> It would be simpler:
> >>>>>
> >>>>> 1) not having TUN_STEERINGEBPF_FALLBACK
> >>>>> 2) the steering algorithm depends on the last uAPI call
> >>>>
> >>>> What will TUNSETSTEERINGEBPF with NULL mean in that case? It current=
ly
> >>>> switches the steering algorithm to automq.
> >>>
> >>> A stackwise semantic then?
> >>
> >> Can you clarify the semantics with an example of a set of ioctls?
> >> Perhaps it is an easy way to demonstrate an alternative design idea.
> >
> > Consider user do:
> >
> > 1) TUNSETQUEUE /* enable automq, push */
> > 2) TUNSETSTEERINGEBPF /* enable steering ebp, push */
> > 3) TUNSETETTERINGEBPF to NULL /* disable steering ebpf, pop */
> >
> > Automq is in the stack top, so TUN will use that.
>
> In that case, what will happen if the user does:
>
> 1) TUNSETQUEUE
> 2) TUNSETVNETRSS
> 3) TUNSETETTERINGEBPF to NULL

RSS I guess since 3) will cause an error?

Or we can introduce new uAPI for setting a exclusively steering algorithm.

Thanks

>
> Regards,
> Akihiko Odaki
>


