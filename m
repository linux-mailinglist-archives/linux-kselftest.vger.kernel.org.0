Return-Path: <linux-kselftest+bounces-34411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FF6ACFA8D
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 03:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE237189C59C
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 01:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA5D7FD;
	Fri,  6 Jun 2025 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9h/A6s/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B626720ED
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Jun 2025 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749171716; cv=none; b=MXTiWZ7woQXrXxaca6nYX+dD8l/hE7pxTnpk/5KlMTQk5cgVBRelSAibHSkpz0iOVNNm0Zk7bHPCaeJAs2Y5OATU+379J+Crn5n8czr2Jk+m/qZ66UmZJ6uEM8qaQsQNBEgGiURGH8yAyPBfbtlasQD/teRtiBDLgxXPpx7C5Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749171716; c=relaxed/simple;
	bh=6Xqf9lprQVqkSWRREDnbUeYvjtd+s92AifV9VOuE0yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYQd1lFP0Y/42YApPBy/XdxewvrjFrZAtc3FATgVlU63MliluUTkpdMRDKJWj4yOpsHx3j+BDROcyIGlR6ebfqE/Il53+tEJcaL45ay2dzNXybcQrvFqgh1wA2BmTuCBAGVKt4MNBPY6ba/BrrE3Bx8VHZV/T/4Ld0sQv6YGrOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9h/A6s/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749171712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oIMKo20rMDNqV6BtvgPuWkO7ebZm3QeRHz07x9w/4U=;
	b=S9h/A6s/7zleQhvjqyThPUEVrkvwBe3iWwmXHa+PAkkqwpmQzokkEfKoBasRjigirq5+Wa
	xCdd5yEHpqXpqB4xFQ3j5o+hMMInbHUn+GbOj7hMI6+fglEBKT9rU8EYnpEmkP6saCeJQ7
	Yysz92ZJ/ZPgYzzSYRovZapgh1mkKus=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-n7Q7sLQEOnyU1njoR9PU_w-1; Thu, 05 Jun 2025 21:01:50 -0400
X-MC-Unique: n7Q7sLQEOnyU1njoR9PU_w-1
X-Mimecast-MFC-AGG-ID: n7Q7sLQEOnyU1njoR9PU_w_1749171710
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311ef4fb5eeso1428755a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Jun 2025 18:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749171709; x=1749776509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oIMKo20rMDNqV6BtvgPuWkO7ebZm3QeRHz07x9w/4U=;
        b=IZrABJTSa1fE3JzbQ9ZuCf+TaT5j/olZlkjm22su/2LKpXIHQNWIBFkP574aDwBOGD
         1hpJELifikDykY242NJTFe7dm2sswMQToPRu118dD99pZsu4Qfl4nEA6uHQY9v0oBi19
         1fDHtk7R0ZsmK1JZEPv59CB42kki6U50mxeVxERupxeR3I+4qp7512sFajFbogeYUFiv
         aF4ePfXgijbZVqsRscVQnuNQz947Grnb0+LJMT+OBSWMyHUeFny3Ax5/zMzUcp2Jh7Xi
         /z9ozykrOcaWu5fB9BkqqQkRxxxCMXeZB8Oxzkl53awEnhIWoLyPI9J6eToWrNbjEyoC
         Tg+A==
X-Forwarded-Encrypted: i=1; AJvYcCVJvJdAggc5tdJSZ6w0nJJ+66xWbpfDvLCU91XvJhGNU8hUO50JbjgNDIasRLv+5tCRMjkgciJs8vvDSRubx4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaJvuGX9HN4DNZp6jIRbFwB7OTzYfaqUHb5u73zq5Ze2RAz3u/
	kra6LTgHvTQpB6Ss/z4XXzDIfKMrbKuZlYlPux0wxFD8kuXv3Zfeo3rejk0Jm6wAyY7kH0BkNVW
	4UKhc3yRkDM4aDDHxr9QO7y9H4eWGxydkLVL7zD3Om/BYMZbBqgSzlRvCNeFn1zVGxIUQljFKwt
	AS+qdWpvUTezJ1Iu9ulX20HfPjx1jC5gUvK4H99uvY3ErI
X-Gm-Gg: ASbGncuZysYSXszDBhqjnoNHsjx73u3ymphamqAfJmAm0VGyavQg8hc4Ha59UgpDLlP
	7oZV+MnxjIF84Z14uKfZ+/2iZMjBnSTX15x4DXRqXm4zb8Uel5+aEmGCGak2Z8YscQEULIihoLr
	uDtX55
X-Received: by 2002:a17:90b:48d0:b0:312:e751:8213 with SMTP id 98e67ed59e1d1-31349fb548cmr1604592a91.13.1749171709117;
        Thu, 05 Jun 2025 18:01:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElSk+Lw13rzo/Rlh93dzINmhWKscdyWYLtvAHEpcN6hNxiUrL2tix/ZD/N9G+7sXjSZKFlG45V+HomMonEFTY=
X-Received: by 2002:a17:90b:48d0:b0:312:e751:8213 with SMTP id
 98e67ed59e1d1-31349fb548cmr1604517a91.13.1749171708286; Thu, 05 Jun 2025
 18:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-4-95d8b348de91@daynix.com>
 <CACGkMEupCBFH2eLv_93uy9K=+s_jQPM12mvyhU=zGbwSUnyVaA@mail.gmail.com>
 <a3e21479-2967-4604-a684-9b9b9e115f37@daynix.com> <CACGkMEuBb6eB9w=HgYq7wy2vW-4PMGGQKk5dd=kCm3ednJ2WxQ@mail.gmail.com>
 <56647ddd-c6ac-43cf-bcb2-626a162858a4@daynix.com>
In-Reply-To: <56647ddd-c6ac-43cf-bcb2-626a162858a4@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 6 Jun 2025 09:01:36 +0800
X-Gm-Features: AX0GCFsHVcFi1ALb09VOzUp2KBcWHu5AaEEwHpjJVp3_PfuL1P7UF6y9zEfe6YE
Message-ID: <CACGkMEs+3Pu9-E7RcmEzp6wZxZYwDS1G+1P3ti=Vzceq=C31YQ@mail.gmail.com>
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

On Thu, Jun 5, 2025 at 4:18=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2025/06/05 11:46, Jason Wang wrote:
> > On Wed, Jun 4, 2025 at 4:42=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> On 2025/06/04 10:53, Jason Wang wrote:
> >>> On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>
> >>>> Add common code required for the features being added to TUN and TAP=
.
> >>>> They will be enabled for each of them in following patches.
> >>>>
> >>>> Added Features
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> Hash reporting
> >>>> --------------
> >>>>
> >>>> Allow the guest to reuse the hash value to make receive steering
> >>>> consistent between the host and guest, and to save hash computation.
> >>>>
> >>>> Receive Side Scaling (RSS)
> >>>> --------------------------
> >>>>
> >>>> RSS is a receive steering algorithm that can be negotiated to use wi=
th
> >>>> virtio_net. Conventionally the hash calculation was done by the VMM.
> >>>> However, computing the hash after the queue was chosen defeats the
> >>>> purpose of RSS.
> >>>>
> >>>> Another approach is to use eBPF steering program. This approach has
> >>>> another downside: it cannot report the calculated hash due to the
> >>>> restrictive nature of eBPF steering program.
> >>>>
> >>>> Introduce the code to perform RSS to the kernel in order to overcome
> >>>> thse challenges. An alternative solution is to extend the eBPF steer=
ing
> >>>> program so that it will be able to report to the userspace, but I di=
dn't
> >>>> opt for it because extending the current mechanism of eBPF steering
> >>>> program as is because it relies on legacy context rewriting, and
> >>>> introducing kfunc-based eBPF will result in non-UAPI dependency whil=
e
> >>>> the other relevant virtualization APIs such as KVM and vhost_net are
> >>>> UAPIs.
> >>>>
> >>>> Added ioctls
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> They are designed to make extensibility and VM migration compatible.
> >>>> This change only adds the implementation and does not expose them to
> >>>> the userspace.
> >>>>
> >>>> TUNGETVNETHASHTYPES
> >>>> -------------------
> >>>>
> >>>> This ioctl tells supported hash types. It is useful to check if a VM=
 can
> >>>> be migrated to the current host.
> >>>>
> >>>> TUNSETVNETREPORTINGAUTOMQ, TUNSETVNETREPORTINGRSS, and TUNSETVNETRSS
> >>>> --------------------------------------------------------------------
> >>>>
> >>>> These ioctls configures a steering algorithm and, if needed, hash
> >>>> reporting.
> >>>>
> >>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>> ---
> >>>>    drivers/net/tap.c           |  10 ++-
> >>>>    drivers/net/tun.c           |  12 +++-
> >>>>    drivers/net/tun_vnet.h      | 165 +++++++++++++++++++++++++++++++=
++++++++++---
> >>>>    include/uapi/linux/if_tun.h |  71 +++++++++++++++++++
> >>>>    4 files changed, 244 insertions(+), 14 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>> index d4ece538f1b2..25c60ff2d3f2 100644
> >>>> --- a/drivers/net/tap.c
> >>>> +++ b/drivers/net/tap.c
> >>>> @@ -179,6 +179,11 @@ static void tap_put_queue(struct tap_queue *q)
> >>>>           sock_put(&q->sk);
> >>>>    }
> >>>>
> >>>> +static const struct virtio_net_hash *tap_find_hash(const struct sk_=
buff *skb)
> >>>> +{
> >>>> +       return NULL;
> >>>> +}
> >>>> +
> >>>>    /*
> >>>>     * Select a queue based on the rxq of the device on which this pa=
cket
> >>>>     * arrived. If the incoming device is not mq, calculate a flow ha=
sh
> >>>> @@ -711,11 +716,12 @@ static ssize_t tap_put_user(struct tap_queue *=
q,
> >>>>           int total;
> >>>>
> >>>>           if (q->flags & IFF_VNET_HDR) {
> >>>> -               struct virtio_net_hdr vnet_hdr;
> >>>> +               struct virtio_net_hdr_v1_hash vnet_hdr;
> >>>>
> >>>>                   vnet_hdr_len =3D READ_ONCE(q->vnet_hdr_sz);
> >>>>
> >>>> -               ret =3D tun_vnet_hdr_from_skb(q->flags, NULL, skb, &=
vnet_hdr);
> >>>> +               ret =3D tun_vnet_hdr_from_skb(vnet_hdr_len, q->flags=
, NULL, skb,
> >>>> +                                           tap_find_hash, &vnet_hdr=
);
> >>>>                   if (ret)
> >>>>                           return ret;
> >>>>
> >>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>> index 9133ab9ed3f5..03d47799e9bd 100644
> >>>> --- a/drivers/net/tun.c
> >>>> +++ b/drivers/net/tun.c
> >>>> @@ -451,6 +451,11 @@ static inline void tun_flow_save_rps_rxhash(str=
uct tun_flow_entry *e, u32 hash)
> >>>>                   e->rps_rxhash =3D hash;
> >>>>    }
> >>>>
> >>>> +static const struct virtio_net_hash *tun_find_hash(const struct sk_=
buff *skb)
> >>>> +{
> >>>> +       return NULL;
> >>>> +}
> >>>> +
> >>>>    /* We try to identify a flow through its rxhash. The reason that
> >>>>     * we do not check rxq no. is because some cards(e.g 82599), choo=
ses
> >>>>     * the rxq based on the txq where the last packet of the flow com=
es. As
> >>>> @@ -1993,7 +1998,7 @@ static ssize_t tun_put_user_xdp(struct tun_str=
uct *tun,
> >>>>           ssize_t ret;
> >>>>
> >>>>           if (tun->flags & IFF_VNET_HDR) {
> >>>> -               struct virtio_net_hdr gso =3D { 0 };
> >>>> +               struct virtio_net_hdr_v1_hash gso =3D { 0 };
> >>>>
> >>>>                   vnet_hdr_sz =3D READ_ONCE(tun->vnet_hdr_sz);
> >>>>                   ret =3D tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
> >>>> @@ -2046,9 +2051,10 @@ static ssize_t tun_put_user(struct tun_struct=
 *tun,
> >>>>           }
> >>>>
> >>>>           if (vnet_hdr_sz) {
> >>>> -               struct virtio_net_hdr gso;
> >>>> +               struct virtio_net_hdr_v1_hash gso;
> >>>>
> >>>> -               ret =3D tun_vnet_hdr_from_skb(tun->flags, tun->dev, =
skb, &gso);
> >>>> +               ret =3D tun_vnet_hdr_from_skb(vnet_hdr_sz, tun->flag=
s, tun->dev,
> >>>> +                                           skb, tun_find_hash, &gso=
);
> >>>>                   if (ret)
> >>>>                           return ret;
> >>>>
> >>>> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> >>>> index 58b9ac7a5fc4..45d0533efc8d 100644
> >>>> --- a/drivers/net/tun_vnet.h
> >>>> +++ b/drivers/net/tun_vnet.h
> >>>> @@ -6,6 +6,17 @@
> >>>>    #define TUN_VNET_LE     0x80000000
> >>>>    #define TUN_VNET_BE     0x40000000
> >>>>
> >>>> +typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_buff=
 *);
> >>>> +typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const s=
truct sk_buff *);
> >>>> +
> >>>> +struct tun_vnet_hash {
> >>>> +       bool report;
> >>>> +       bool rss;
> >>>> +       struct tun_vnet_rss common;
> >>>> +       u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >>>> +       u16 rss_indirection_table[];
> >>>> +};
> >>>> +
> >>>>    static inline bool tun_vnet_legacy_is_little_endian(unsigned int =
flags)
> >>>>    {
> >>>>           bool be =3D IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> >>>> @@ -107,6 +118,128 @@ static inline long tun_vnet_ioctl(int *vnet_hd=
r_sz, unsigned int *flags,
> >>>>           }
> >>>>    }
> >>>>
> >>>> +static inline long tun_vnet_ioctl_gethashtypes(u32 __user *argp)
> >>>> +{
> >>>> +       return put_user(VIRTIO_NET_SUPPORTED_HASH_TYPES, argp) ? -EF=
AULT : 0;
> >>>> +}
> >>>> +
> >>>> +static inline long tun_vnet_ioctl_sethash(struct tun_vnet_hash __rc=
u **hashp,
> >>>> +                                         unsigned int cmd,
> >>>> +                                         void __user *argp)
> >>>> +{
> >>>> +       struct tun_vnet_rss common;
> >>>> +       struct tun_vnet_hash *hash;
> >>>> +       size_t indirection_table_size;
> >>>> +       size_t key_size;
> >>>> +       size_t size;
> >>>> +
> >>>> +       switch (cmd) {
> >>>> +       case TUNSETVNETREPORTINGAUTOMQ:
> >>>> +               if (get_user(common.hash_types, (u32 __user *)argp))
> >>>> +                       return -EFAULT;
> >>>> +
> >>>> +               if (common.hash_types) {
> >>>> +                       hash =3D kzalloc(sizeof(*hash), GFP_KERNEL);
> >>>> +                       if (!hash)
> >>>> +                               return -ENOMEM;
> >>>> +
> >>>> +                       hash->report =3D true;
> >>>> +                       hash->common.hash_types =3D common.hash_type=
s;
> >>>> +               } else {
> >>>> +                       hash =3D NULL;
> >>>> +               }
> >>>> +               break;
> >>>> +
> >>>> +       case TUNSETVNETREPORTINGRSS:
> >>>> +       case TUNSETVNETRSS:
> >>>
> >>> So the above three shows unnecessary design redundancy as well as a
> >>> burden for the future extension.  Why not simply have
> >>>
> >>> 1) TUNSETVNET_RSS
> >>> 2) TUNSETVNET_HASH_REPORT
> >>> ?
> >>>
> >>> Which maps to
> >>>
> >>>    #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1 (for configurable
> >>> receive steering)
> >>>    #define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2 (for configurable
> >>> hash calculation)
> >>>
> >>> It would be always easier to start with what spec had or at least we
> >>> need to explain why we choose a different design here or in the
> >>> changelog to ease our life.
> >>
> >> TUNSETVNETREPORTINGAUTOMQ maps to VIRTIO_NET_CTRL_MQ_HASH_CONFIG.
> >
> > It's not:
> >
> > VIRTIO_NET_CTRL_MQ_HASH_CONFIG uses:
> >
> > struct virtio_net_hash_config {
> >      le32 hash_types;
> >      le16 reserved[4];
> >      u8 hash_key_length;
> >      u8 hash_key_data[hash_key_length];
> > };
> >
> > but TUNSETVNETREPORTINGAUTOMQ only accepts hash_types without others:
>
> The others are not present because the spec doesn't specify what to do
> with them and the kernel doesn't use them either.

Did you mean the hash_key_length and hash_key_data? Note that we have
drivers other than the Linux ones as well.

>
> >
> >>
> >> TUNSETVNETREPORTINGRSS and TUNSETVNETRSS map to
> >> VIRTIO_NET_CTRL_MQ_RSS_CONFIG.
> >
> > I think we've already had a discussion about this.
> >
> > Reusing virtio-net uAPI is much better instead of having a tun
> > specific one considering tun may need to support more virtio commands
> > in the future. Or maybe it's the time to introduce a transport for the
> > virtio control virtqueue uAPI in tuntap to avoid inventing new uAPI
> > endlessly.
> >
> > What's more I see:
> >
> > struct tun_vnet_rss {
> >          __u32 hash_types;
> >          __u16 indirection_table_mask;
> >          __u16 unclassified_queue;
> > };
> >
> > struct tun_vnet_hash {
> >          bool report;
> >          bool rss;
> >          struct tun_vnet_rss common;
> >          u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >          u16 rss_indirection_table[];
> > };
> >
> > As I pointed out in the past, let's just decouple the rss from hash,
> > everything would be much simpler, or you need to explain why you
> > couple this somewhere.
> >
> > For example:
> >
> > 1) why is the tun_vnet_hash not part of the uAPI but tun_vnet_rss, or
> > how could userspace know what kind of format it would use for
> > TUNSETVNETREPORTINGRSS?
>
> That was the previous version.
>
> > 2) what's the advantages of embedding rss specific stuff into hash
> > report structure
>
> Because the hash types field in struct tun_vnet_rss is used by hash
> reporting too.
>
> > 3) what's the advantages of not using virtio-net uAPI
>
> 1. The use cases that don't involve VM will be simplified; programs for
> such a use case will not need to convert endian or to fill fileds the
> kernel doesn't care.

Well, virtio_net_hdr is used by packet socket as well. Considering the
complexity of designing a new uAPI, it's still better.

Or maybe you can clarify which field that kernel doesn't care about?
In this case TUN/TAP is basically the device datapath, if some of the
fields don't make sense, it's a bug of the spec.

> 2. It aligns with existing UAPIs that operate in native endian and don't
> use virtio-net data structures like TUNSETOFFLOAD and TUNSETVNETHDRSZ.

For those two examples, it would be used by guests directly. This is
different from RSS stuff.

With native endian, you need an endian conversation that converts le to nat=
ive.

>
> >
> > More issues:
> >
> > 1) max_tx_vq is ignored, so do you expect the userspace to intercept
> > this and switch to using TUNSETQUEUE? This seems like a burden as TUN
> > can simply accept it and do the attaching/detaching by itself
> > 2) the rx depends on the indirection table, so userspace need to
> > intercept the indirection and change the rx queue numbers accordingly
> > 3) RSS allows a async TX/RX queue, this is not supported by TUN now,
> > no matter if we decide to let userspace to intercept max_tx_vq or not,
> > we need to implement it first
>  > > Things would be much more simpler, if kernel can do 1) and 2).
>
> Attaching and detaching queues is not possible for the kernel because it
> doesn't know what file descriptors that map to queues will be used by
> the userspace.

The kernel knows, tfile has a queue_index part.

>
> The following patch does 2) for QEMU:
> https://lore.kernel.org/qemu-devel/20250322-vq-v2-1-cee0aafe6404@daynix.c=
om/

See below point, form the view of the kernel, it's still a queue pair
not async TX/RX queue.

>
> For 3), the patch for QEMU takes the maximum of TX and RX queue numbers
> to derive the number of queue pairs.
>
> >
> >> We have two ioctls here because
> >> VIRTIO_NET_CTRL_MQ_RSS_CONFIG behaves differently depending on whether
> >> VIRTIO_NET_F_HASH_REPORT is negotiated or not;
> >
> > It wouldn't be a problem if you do 1:1 mapping between virtio commands
> > and TUN uAPI, otherwise it should have a bug somewhere.
>
> Speaking of 1:1 mapping, it is possible to map VIRTIO_NET_F_HASH_REPORT
> into another ioctl. It may help add another receive steering algorithm
> in the future by not requiring two ioctls (TUNSETVNETREPORTING_X and
> TUNSETVNET_X).

Yes and as I pointed out, virtio_net_hash_config should not be
specific to automq, it can work for other steering algorithm as well.

>
> >
> >> it also enables hash
> >> reporting if the feature is negotiated.
> >
> > Again, starting from virtio-net command is easier, a strong
> > justification is needed to explain why we choose another for tun/tap.
> >
> >>
> >>>
> >>> One day we would have tun_select_queue_algorithm_x() we don't have to
> >>> duplicate the ioctls once again here like TUNSETVNETREPORTINGXYZ
> >>
> >> 5.1.6.5.6.4 Hash calculation says:
> >>>   If VIRTIO_NET_F_HASH_REPORT was negotiated and the device uses
> >>> automatic receive steering, the device MUST support a command to
> >>> configure hash calculation parameters.
> >>>
> >>> The driver provides parameters for hash calculation as follows:
> >>>
> >>> class VIRTIO_NET_CTRL_MQ, command VIRTIO_NET_CTRL_MQ_HASH_CONFIG.
> >>
> >> VIRTIO_NET_CTRL_MQ_HASH_CONFIG is for automatic receive steering and n=
ot
> >> for RSS (or other steering algorithms if the spec gets any in the futu=
re).
> >
> > I'm not sure but the spec needs some tweaking. For example, I don't
> > expect there would be a dedicated hash config command for flow filters
> > in the future. I think the reason why spec says like this is that
> > virtio-net only supports automatic receive steering.
> >
> > Note that macvtap doesn't implement automatic receive steering.
>
> QEMU advertises VIRTIO_NET_F_CTRL_VQ for macvtap too, so it should have
> implemented it. I think QEMU with macvtap still compliant to the spec.

Compliant, but automatic traffic steering is the best effort as well.

Nope, TUN/TAP implements a flow cache that can steer tx based on rx.
Macvtap simply uses hash here.

>
> "5.1.6.5.6 Automatic receive steering in multiqueue mode" says:
>
>  > After the driver transmitted a packet of a flow on transmitqX, the
>  > device SHOULD cause incoming packets for that flow to be steered to
>  > receiveqX.
>
> It is "SHOULD", so it is still compliant if the device doesn't properly
> respect the flow.

Yes, a quality of implementation, or it's impractical to support a
correct steering for this device as limited resources and mailious
users can do syn flood etc.

>
> >
> >>
> >>>
> >>>> +               if (copy_from_user(&common, argp, sizeof(common)))
> >>>> +                       return -EFAULT;
> >>>> +               argp =3D (struct tun_vnet_rss __user *)argp + 1;
> >>>> +
> >>>> +               indirection_table_size =3D ((size_t)common.indirecti=
on_table_mask + 1) * 2;
> >>>> +               key_size =3D virtio_net_hash_key_length(common.hash_=
types);
> >>>> +               size =3D struct_size(hash, rss_indirection_table,
> >>>> +                                  (size_t)common.indirection_table_=
mask + 1);
> >>>> +
> >>>> +               hash =3D kmalloc(size, GFP_KERNEL);
> >>>> +               if (!hash)
> >>>> +                       return -ENOMEM;
> >>>> +
> >>>> +               if (copy_from_user(hash->rss_indirection_table,
> >>>> +                                  argp, indirection_table_size)) {
> >>>> +                       kfree(hash);
> >>>> +                       return -EFAULT;
> >>>> +               }
> >>>> +               argp =3D (u16 __user *)argp + common.indirection_tab=
le_mask + 1;
> >>>> +
> >>>> +               if (copy_from_user(hash->rss_key, argp, key_size)) {
> >>>> +                       kfree(hash);
> >>>> +                       return -EFAULT;
> >>>> +               }
> >>>> +
> >>>> +               virtio_net_toeplitz_convert_key(hash->rss_key, key_s=
ize);
> >>>> +               hash->report =3D cmd =3D=3D TUNSETVNETREPORTINGRSS;
> >>>
> >>> At least, if this is the only difference why not simply code this int=
o
> >>> the ioctl itself other than having a very similar command?
> >>
> >> It is what the previous version did. Either is fine I guess; the only
> >> practical difference would be the size of the configuration struct is
> >> smaller with this approach.
> >>
> >>>
> >>>> +               hash->rss =3D true;
> >>>> +               hash->common =3D common;
> >>>> +               break;
> >>>> +
> >>>> +       default:
> >>>> +               return -EINVAL;
> >>>> +       }
> >>>> +
> >>>> +       kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(*hashp, hash))=
;
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>> +static inline void tun_vnet_hash_report(const struct tun_vnet_hash =
*hash,
> >>>> +                                       struct sk_buff *skb,
> >>>> +                                       const struct flow_keys_basic=
 *keys,
> >>>> +                                       u32 value,
> >>>> +                                       tun_vnet_hash_add vnet_hash_=
add)
> >>>> +{
> >>>> +       struct virtio_net_hash *report;
> >>>> +
> >>>> +       if (!hash || !hash->report)
> >>>> +               return;
> >>>> +
> >>>> +       report =3D vnet_hash_add(skb);
> >>>> +       if (!report)
> >>>> +               return;
> >>>> +
> >>>> +       *report =3D (struct virtio_net_hash) {
> >>>> +               .report =3D virtio_net_hash_report(hash->common.hash=
_types, keys),
> >>>> +               .value =3D value
> >>>> +       };
> >>>> +}
> >>>> +
> >>>> +static inline u16 tun_vnet_rss_select_queue(u32 numqueues,
> >>>> +                                           const struct tun_vnet_ha=
sh *hash,
> >>>> +                                           struct sk_buff *skb,
> >>>> +                                           tun_vnet_hash_add vnet_h=
ash_add)
> >>>> +{
> >>>> +       struct virtio_net_hash *report;
> >>>> +       struct virtio_net_hash ret;
> >>>> +       u16 index;
> >>>> +
> >>>> +       if (!numqueues)
> >>>> +               return 0;
> >>>> +
> >>>> +       virtio_net_hash_rss(skb, hash->common.hash_types, hash->rss_=
key, &ret);
> >>>> +
> >>>> +       if (!ret.report)
> >>>> +               return hash->common.unclassified_queue % numqueues;
> >>>> +
> >>>> +       if (hash->report) {
> >>>> +               report =3D vnet_hash_add(skb);
> >>>> +               if (report)
> >>>> +                       *report =3D ret;
> >>>> +       }
> >>>> +
> >>>> +       index =3D ret.value & hash->common.indirection_table_mask;
> >>>> +
> >>>> +       return hash->rss_indirection_table[index] % numqueues;
> >>>> +}
> >>>> +
> >>>>    static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
> >>>>                                      struct iov_iter *from,
> >>>>                                      struct virtio_net_hdr *hdr)
> >>>> @@ -135,15 +268,17 @@ static inline int tun_vnet_hdr_get(int sz, uns=
igned int flags,
> >>>>    }
> >>>>
> >>>>    static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> >>>> -                                  const struct virtio_net_hdr *hdr)
> >>>> +                                  const struct virtio_net_hdr_v1_ha=
sh *hdr)
> >>>>    {
> >>>> +       int content_sz =3D MIN(sizeof(*hdr), sz);
> >>>> +
> >>>>           if (unlikely(iov_iter_count(iter) < sz))
> >>>>                   return -EINVAL;
> >>>>
> >>>> -       if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) !=3D size=
of(*hdr)))
> >>>> +       if (unlikely(copy_to_iter(hdr, content_sz, iter) !=3D conten=
t_sz))
> >>>>                   return -EFAULT;
> >>>>
> >>>> -       if (iov_iter_zero(sz - sizeof(*hdr), iter) !=3D sz - sizeof(=
*hdr))
> >>>> +       if (iov_iter_zero(sz - content_sz, iter) !=3D sz - content_s=
z)
> >>>>                   return -EFAULT;
> >>>>
> >>>>           return 0;
> >>>> @@ -155,26 +290,38 @@ static inline int tun_vnet_hdr_to_skb(unsigned=
 int flags, struct sk_buff *skb,
> >>>>           return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_=
endian(flags));
> >>>>    }
> >>>>
> >>>> -static inline int tun_vnet_hdr_from_skb(unsigned int flags,
> >>>> +static inline int tun_vnet_hdr_from_skb(int sz, unsigned int flags,
> >>>>                                           const struct net_device *d=
ev,
> >>>>                                           const struct sk_buff *skb,
> >>>> -                                       struct virtio_net_hdr *hdr)
> >>>> +                                       tun_vnet_hash_find vnet_hash=
_find,
> >>>> +                                       struct virtio_net_hdr_v1_has=
h *hdr)
> >>>>    {
> >>>>           int vlan_hlen =3D skb_vlan_tag_present(skb) ? VLAN_HLEN : =
0;
> >>>> +       const struct virtio_net_hash *report =3D sz < sizeof(struct =
virtio_net_hdr_v1_hash) ?
> >>>> +                                              NULL : vnet_hash_find=
(skb);
> >>>> +
> >>>> +       *hdr =3D (struct virtio_net_hdr_v1_hash) {
> >>>> +               .hash_report =3D VIRTIO_NET_HASH_REPORT_NONE
> >>>> +       };
> >>>> +
> >>>> +       if (report) {
> >>>> +               hdr->hash_value =3D cpu_to_le32(report->value);
> >>>> +               hdr->hash_report =3D cpu_to_le16(report->report);
> >>>> +       }
> >>>>
> >>>> -       if (virtio_net_hdr_from_skb(skb, hdr,
> >>>> +       if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hd=
r,
> >>>>                                       tun_vnet_is_little_endian(flag=
s), true,
> >>>>                                       vlan_hlen)) {
> >>>>                   struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> >>>>
> >>>>                   if (net_ratelimit()) {
> >>>>                           netdev_err(dev, "unexpected GSO type: 0x%x=
, gso_size %d, hdr_len %d\n",
> >>>> -                                  sinfo->gso_type, tun_vnet16_to_cp=
u(flags, hdr->gso_size),
> >>>> -                                  tun_vnet16_to_cpu(flags, hdr->hdr=
_len));
> >>>> +                                  sinfo->gso_type, tun_vnet16_to_cp=
u(flags, hdr->hdr.gso_size),
> >>>> +                                  tun_vnet16_to_cpu(flags, hdr->hdr=
.hdr_len));
> >>>>                           print_hex_dump(KERN_ERR, "tun: ",
> >>>>                                          DUMP_PREFIX_NONE,
> >>>>                                          16, 1, skb->head,
> >>>> -                                      min(tun_vnet16_to_cpu(flags, =
hdr->hdr_len), 64), true);
> >>>> +                                      min(tun_vnet16_to_cpu(flags, =
hdr->hdr.hdr_len), 64), true);
> >>>>                   }
> >>>>                   WARN_ON_ONCE(1);
> >>>>                   return -EINVAL;
> >>>> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun=
.h
> >>>> index 980de74724fc..fe4b984d3bbb 100644
> >>>> --- a/include/uapi/linux/if_tun.h
> >>>> +++ b/include/uapi/linux/if_tun.h
> >>>> @@ -62,6 +62,62 @@
> >>>>    #define TUNSETCARRIER _IOW('T', 226, int)
> >>>>    #define TUNGETDEVNETNS _IO('T', 227)
> >>>>
> >>>> +/**
> >>>> + * define TUNGETVNETHASHTYPES - ioctl to get supported virtio_net h=
ashing types
> >>>> + *
> >>>> + * The argument is a pointer to __u32 which will store the supporte=
d virtio_net
> >>>> + * hashing types.
> >>>> + */
> >>>> +#define TUNGETVNETHASHTYPES _IOR('T', 228, __u32)
> >>>> +
> >>>> +/**
> >>>> + * define TUNSETVNETREPORTINGAUTOMQ - ioctl to enable automq with h=
ash reporting
> >>>> + *
> >>>> + * Disable RSS and enable automatic receive steering with hash repo=
rting.
> >>>> + *
> >>>> + * The argument is a pointer to __u32 that contains a bitmask of ha=
sh types
> >>>> + * allowed to be reported.
> >>>> + *
> >>>> + * This ioctl results in %EBADFD if the underlying device is delete=
d. It affects
> >>>> + * all queues attached to the same device.
> >>>> + *
> >>>> + * This ioctl currently has no effect on XDP packets and packets wi=
th
> >>>> + * queue_mapping set by TC.
> >>>> + */
> >>>> +#define TUNSETVNETREPORTINGAUTOMQ _IOR('T', 229, __u32)
> >>>> +
> >>>> +/**
> >>>> + * define TUNSETVNETREPORTINGRSS - ioctl to enable RSS with hash re=
porting
> >>>> + *
> >>>> + * Disable automatic receive steering and enable RSS with hash repo=
rting.
> >>>
> >>> This is unnecessary, e.g one day will have select_queue_xyz(), we
> >>> don't want to say "Disable automatic receive steering and xyz ..."
> >>
> >> It is still something better to be documented as its behavior is
> >> somewhat complicated.
> >
> > This is a hint of uAPI design issue.
> >
> >>
> >> Concretely, this ioctl disables automatic receive steering but doesn't
> >> disable steering by eBPF, which is implied by TUN_STEERINGEBPF_FALLBAC=
K.
> >
> > It would be simpler:
> >
> > 1) not having TUN_STEERINGEBPF_FALLBACK
> > 2) the steering algorithm depends on the last uAPI call
>
> What will TUNSETSTEERINGEBPF with NULL mean in that case? It currently
> switches the steering algorithm to automq.

A stackwise semantic then?

Thanks

>
> Regards,
> Akihiko Odaki
>


