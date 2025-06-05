Return-Path: <linux-kselftest+bounces-34354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F38F5ACE86C
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 04:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B8F16B912
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 02:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194501F0E26;
	Thu,  5 Jun 2025 02:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hl5oa5ft"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EADE1F941
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Jun 2025 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749091637; cv=none; b=pzMKmnQ2wS6RMgVFJgIiHhuNgKG6ipS7DcxnPTK7OET9wUEwy6CheqCkv5KAd/IzShh28P1chY0wXFljjS4vI+zKemaIhQZ2JaPFqK6ubtRJvFpv6K85J7HErZYtv6zDx2qqMZupqsXrRlwDi/t27OdZgtO3anzXjdRP5goHPuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749091637; c=relaxed/simple;
	bh=omIp1mzOfpWW5NtnN0bnzoknDyuqi/3OPgFAYaUwxUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSVlb7+SYMknenXKxRlKHouieoGGU+UXRdn7tyhHUxsUxcI2GqftUA9ByQ+cvX9QNxJIZ8be2UBLcNlmKt7SYMpMinJQfR4IXE4iT3sxn40bJ0TmbY3sGvJ6Ivxo9UIAf3/ExNHCm3urLYXMtSUzzxGzCwsY/gYkReHa7CYPsXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hl5oa5ft; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749091633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dEp8EEq9IZLjoD7IXIoV5lnHN1rozAVzaIx61db4w7A=;
	b=hl5oa5ftjhYbd/pnhkSJZzjVbvtLS/3/XN9L6Kilmzju2gExCxFDdiLFkqIMDacuPVa7dR
	AlPjeL3QJrUhGdbO8WgXxK/k66XDryFskKnB6APQCrmeKDxErVdkW5LGei4YG+MOnT4/bk
	KGVBiXFjkU7PmxzR4LO0SoT9o5CrdaI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-2ldKnySdPeq-Wph7-oQsFw-1; Wed, 04 Jun 2025 22:47:12 -0400
X-MC-Unique: 2ldKnySdPeq-Wph7-oQsFw-1
X-Mimecast-MFC-AGG-ID: 2ldKnySdPeq-Wph7-oQsFw_1749091631
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-745e89b0c32so701618b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 19:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749091631; x=1749696431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEp8EEq9IZLjoD7IXIoV5lnHN1rozAVzaIx61db4w7A=;
        b=WfWoPM8ST0fBLxr9kbCHXchO/c+OGLgW6SNe+9z8Vd+af7NnyG2+MA3xLynRAhP3pw
         M0jcGXfkLibGHW9ouBhX+I5z8Tonjd+Huv1ZjLky/WiLYoSl+/d5ecRbN8zkRAuLhkAv
         5OYzMGTFeVomvNd3xYfiYM8wFsVWQ0SbmMHZOF+WWjqYvMeNg3DQ5sdT/8oAyJiUr6j0
         Zje5LsH4dJs3JYCusnTSu3Wpv+t7SuC81lrIiBdTe1D2UnCHynDZ3TN2xtgcFhfEpzAr
         j6cZJtBsdqyshRM95p4P1/9N3lNgaTR14s1ZCkyuuo764U+cVXMdUH/Bwix2duK59GgM
         uOmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb8+wRpCnw7hxo9e5CAIrJ4FSHXMjVjQiIdtXViNSGisRTMJYjUkTHEkV0vVCzgeUQf8tqZ5vVafnTdgUWSfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC3a5F1qmCaf8CEay44m6Hr9dTFgFh7a4qwLlnLXJScDD7YDNT
	T8NCQjMiQJRS5HjDQlI7R2imHeae9tkwk93zuXPkY7sZch18B41o/dy5gX1Ao6HLxUaBD4vrvfs
	eR4GKlFCwERYwAqMEOBnwaGevhjsXouIgpTr5GtAXf9GNq7L17+6f353VVzolLReYsoNmj1eyk/
	rJDHL/k1X/xVG+uHLK4n4KURQsOu51Nd69h3vAd8KDS3qL
X-Gm-Gg: ASbGncvmVsbm5NW1z8EFhDASEOL4k4GYb9wYTui6Ci0JGDDkmPzdCtIXPrMlwuGN1ht
	a+nZht0g9WONpI9ta3Nztd1XU9whjMcG2s+ca6kX7bce4lioERTI+UR2U4MGb0ZgNzR45
X-Received: by 2002:a05:6a00:1a8b:b0:736:53f2:87bc with SMTP id d2e1a72fcca58-7480b41c057mr7026746b3a.13.1749091631049;
        Wed, 04 Jun 2025 19:47:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMX0tDxTPzBlM7jNwDe8J2mmVQ4fZbrpXfmUzEnYWQZ8EbI55qxfCnLs650/Af6UAWCtrMOWVqFtn2/dUJOwU=
X-Received: by 2002:a05:6a00:1a8b:b0:736:53f2:87bc with SMTP id
 d2e1a72fcca58-7480b41c057mr7026705b3a.13.1749091630477; Wed, 04 Jun 2025
 19:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-4-95d8b348de91@daynix.com>
 <CACGkMEupCBFH2eLv_93uy9K=+s_jQPM12mvyhU=zGbwSUnyVaA@mail.gmail.com> <a3e21479-2967-4604-a684-9b9b9e115f37@daynix.com>
In-Reply-To: <a3e21479-2967-4604-a684-9b9b9e115f37@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Jun 2025 10:46:59 +0800
X-Gm-Features: AX0GCFvNNqZbw1M6lohRaBSwqZGPEvNCPQEPehheBS7BVopMGkjYcNpaKD_-zV8
Message-ID: <CACGkMEuBb6eB9w=HgYq7wy2vW-4PMGGQKk5dd=kCm3ednJ2WxQ@mail.gmail.com>
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

On Wed, Jun 4, 2025 at 4:42=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2025/06/04 10:53, Jason Wang wrote:
> > On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>
> >> Add common code required for the features being added to TUN and TAP.
> >> They will be enabled for each of them in following patches.
> >>
> >> Added Features
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Hash reporting
> >> --------------
> >>
> >> Allow the guest to reuse the hash value to make receive steering
> >> consistent between the host and guest, and to save hash computation.
> >>
> >> Receive Side Scaling (RSS)
> >> --------------------------
> >>
> >> RSS is a receive steering algorithm that can be negotiated to use with
> >> virtio_net. Conventionally the hash calculation was done by the VMM.
> >> However, computing the hash after the queue was chosen defeats the
> >> purpose of RSS.
> >>
> >> Another approach is to use eBPF steering program. This approach has
> >> another downside: it cannot report the calculated hash due to the
> >> restrictive nature of eBPF steering program.
> >>
> >> Introduce the code to perform RSS to the kernel in order to overcome
> >> thse challenges. An alternative solution is to extend the eBPF steerin=
g
> >> program so that it will be able to report to the userspace, but I didn=
't
> >> opt for it because extending the current mechanism of eBPF steering
> >> program as is because it relies on legacy context rewriting, and
> >> introducing kfunc-based eBPF will result in non-UAPI dependency while
> >> the other relevant virtualization APIs such as KVM and vhost_net are
> >> UAPIs.
> >>
> >> Added ioctls
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> They are designed to make extensibility and VM migration compatible.
> >> This change only adds the implementation and does not expose them to
> >> the userspace.
> >>
> >> TUNGETVNETHASHTYPES
> >> -------------------
> >>
> >> This ioctl tells supported hash types. It is useful to check if a VM c=
an
> >> be migrated to the current host.
> >>
> >> TUNSETVNETREPORTINGAUTOMQ, TUNSETVNETREPORTINGRSS, and TUNSETVNETRSS
> >> --------------------------------------------------------------------
> >>
> >> These ioctls configures a steering algorithm and, if needed, hash
> >> reporting.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> Tested-by: Lei Yang <leiyang@redhat.com>
> >> ---
> >>   drivers/net/tap.c           |  10 ++-
> >>   drivers/net/tun.c           |  12 +++-
> >>   drivers/net/tun_vnet.h      | 165 ++++++++++++++++++++++++++++++++++=
+++++++---
> >>   include/uapi/linux/if_tun.h |  71 +++++++++++++++++++
> >>   4 files changed, 244 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >> index d4ece538f1b2..25c60ff2d3f2 100644
> >> --- a/drivers/net/tap.c
> >> +++ b/drivers/net/tap.c
> >> @@ -179,6 +179,11 @@ static void tap_put_queue(struct tap_queue *q)
> >>          sock_put(&q->sk);
> >>   }
> >>
> >> +static const struct virtio_net_hash *tap_find_hash(const struct sk_bu=
ff *skb)
> >> +{
> >> +       return NULL;
> >> +}
> >> +
> >>   /*
> >>    * Select a queue based on the rxq of the device on which this packe=
t
> >>    * arrived. If the incoming device is not mq, calculate a flow hash
> >> @@ -711,11 +716,12 @@ static ssize_t tap_put_user(struct tap_queue *q,
> >>          int total;
> >>
> >>          if (q->flags & IFF_VNET_HDR) {
> >> -               struct virtio_net_hdr vnet_hdr;
> >> +               struct virtio_net_hdr_v1_hash vnet_hdr;
> >>
> >>                  vnet_hdr_len =3D READ_ONCE(q->vnet_hdr_sz);
> >>
> >> -               ret =3D tun_vnet_hdr_from_skb(q->flags, NULL, skb, &vn=
et_hdr);
> >> +               ret =3D tun_vnet_hdr_from_skb(vnet_hdr_len, q->flags, =
NULL, skb,
> >> +                                           tap_find_hash, &vnet_hdr);
> >>                  if (ret)
> >>                          return ret;
> >>
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index 9133ab9ed3f5..03d47799e9bd 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -451,6 +451,11 @@ static inline void tun_flow_save_rps_rxhash(struc=
t tun_flow_entry *e, u32 hash)
> >>                  e->rps_rxhash =3D hash;
> >>   }
> >>
> >> +static const struct virtio_net_hash *tun_find_hash(const struct sk_bu=
ff *skb)
> >> +{
> >> +       return NULL;
> >> +}
> >> +
> >>   /* We try to identify a flow through its rxhash. The reason that
> >>    * we do not check rxq no. is because some cards(e.g 82599), chooses
> >>    * the rxq based on the txq where the last packet of the flow comes.=
 As
> >> @@ -1993,7 +1998,7 @@ static ssize_t tun_put_user_xdp(struct tun_struc=
t *tun,
> >>          ssize_t ret;
> >>
> >>          if (tun->flags & IFF_VNET_HDR) {
> >> -               struct virtio_net_hdr gso =3D { 0 };
> >> +               struct virtio_net_hdr_v1_hash gso =3D { 0 };
> >>
> >>                  vnet_hdr_sz =3D READ_ONCE(tun->vnet_hdr_sz);
> >>                  ret =3D tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
> >> @@ -2046,9 +2051,10 @@ static ssize_t tun_put_user(struct tun_struct *=
tun,
> >>          }
> >>
> >>          if (vnet_hdr_sz) {
> >> -               struct virtio_net_hdr gso;
> >> +               struct virtio_net_hdr_v1_hash gso;
> >>
> >> -               ret =3D tun_vnet_hdr_from_skb(tun->flags, tun->dev, sk=
b, &gso);
> >> +               ret =3D tun_vnet_hdr_from_skb(vnet_hdr_sz, tun->flags,=
 tun->dev,
> >> +                                           skb, tun_find_hash, &gso);
> >>                  if (ret)
> >>                          return ret;
> >>
> >> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> >> index 58b9ac7a5fc4..45d0533efc8d 100644
> >> --- a/drivers/net/tun_vnet.h
> >> +++ b/drivers/net/tun_vnet.h
> >> @@ -6,6 +6,17 @@
> >>   #define TUN_VNET_LE     0x80000000
> >>   #define TUN_VNET_BE     0x40000000
> >>
> >> +typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_buff *=
);
> >> +typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const str=
uct sk_buff *);
> >> +
> >> +struct tun_vnet_hash {
> >> +       bool report;
> >> +       bool rss;
> >> +       struct tun_vnet_rss common;
> >> +       u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >> +       u16 rss_indirection_table[];
> >> +};
> >> +
> >>   static inline bool tun_vnet_legacy_is_little_endian(unsigned int fla=
gs)
> >>   {
> >>          bool be =3D IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> >> @@ -107,6 +118,128 @@ static inline long tun_vnet_ioctl(int *vnet_hdr_=
sz, unsigned int *flags,
> >>          }
> >>   }
> >>
> >> +static inline long tun_vnet_ioctl_gethashtypes(u32 __user *argp)
> >> +{
> >> +       return put_user(VIRTIO_NET_SUPPORTED_HASH_TYPES, argp) ? -EFAU=
LT : 0;
> >> +}
> >> +
> >> +static inline long tun_vnet_ioctl_sethash(struct tun_vnet_hash __rcu =
**hashp,
> >> +                                         unsigned int cmd,
> >> +                                         void __user *argp)
> >> +{
> >> +       struct tun_vnet_rss common;
> >> +       struct tun_vnet_hash *hash;
> >> +       size_t indirection_table_size;
> >> +       size_t key_size;
> >> +       size_t size;
> >> +
> >> +       switch (cmd) {
> >> +       case TUNSETVNETREPORTINGAUTOMQ:
> >> +               if (get_user(common.hash_types, (u32 __user *)argp))
> >> +                       return -EFAULT;
> >> +
> >> +               if (common.hash_types) {
> >> +                       hash =3D kzalloc(sizeof(*hash), GFP_KERNEL);
> >> +                       if (!hash)
> >> +                               return -ENOMEM;
> >> +
> >> +                       hash->report =3D true;
> >> +                       hash->common.hash_types =3D common.hash_types;
> >> +               } else {
> >> +                       hash =3D NULL;
> >> +               }
> >> +               break;
> >> +
> >> +       case TUNSETVNETREPORTINGRSS:
> >> +       case TUNSETVNETRSS:
> >
> > So the above three shows unnecessary design redundancy as well as a
> > burden for the future extension.  Why not simply have
> >
> > 1) TUNSETVNET_RSS
> > 2) TUNSETVNET_HASH_REPORT
> > ?
> >
> > Which maps to
> >
> >   #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1 (for configurable
> > receive steering)
> >   #define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2 (for configurable
> > hash calculation)
> >
> > It would be always easier to start with what spec had or at least we
> > need to explain why we choose a different design here or in the
> > changelog to ease our life.
>
> TUNSETVNETREPORTINGAUTOMQ maps to VIRTIO_NET_CTRL_MQ_HASH_CONFIG.

It's not:

VIRTIO_NET_CTRL_MQ_HASH_CONFIG uses:

struct virtio_net_hash_config {
    le32 hash_types;
    le16 reserved[4];
    u8 hash_key_length;
    u8 hash_key_data[hash_key_length];
};

but TUNSETVNETREPORTINGAUTOMQ only accepts hash_types without others:

>
> TUNSETVNETREPORTINGRSS and TUNSETVNETRSS map to
> VIRTIO_NET_CTRL_MQ_RSS_CONFIG.

I think we've already had a discussion about this.

Reusing virtio-net uAPI is much better instead of having a tun
specific one considering tun may need to support more virtio commands
in the future. Or maybe it's the time to introduce a transport for the
virtio control virtqueue uAPI in tuntap to avoid inventing new uAPI
endlessly.

What's more I see:

struct tun_vnet_rss {
        __u32 hash_types;
        __u16 indirection_table_mask;
        __u16 unclassified_queue;
};

struct tun_vnet_hash {
        bool report;
        bool rss;
        struct tun_vnet_rss common;
        u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
        u16 rss_indirection_table[];
};

As I pointed out in the past, let's just decouple the rss from hash,
everything would be much simpler, or you need to explain why you
couple this somewhere.

For example:

1) why is the tun_vnet_hash not part of the uAPI but tun_vnet_rss, or
how could userspace know what kind of format it would use for
TUNSETVNETREPORTINGRSS?
2) what's the advantages of embedding rss specific stuff into hash
report structure
3) what's the advantages of not using virtio-net uAPI

More issues:

1) max_tx_vq is ignored, so do you expect the userspace to intercept
this and switch to using TUNSETQUEUE? This seems like a burden as TUN
can simply accept it and do the attaching/detaching by itself
2) the rx depends on the indirection table, so userspace need to
intercept the indirection and change the rx queue numbers accordingly
3) RSS allows a async TX/RX queue, this is not supported by TUN now,
no matter if we decide to let userspace to intercept max_tx_vq or not,
we need to implement it first

Things would be much more simpler, if kernel can do 1) and 2).

> We have two ioctls here because
> VIRTIO_NET_CTRL_MQ_RSS_CONFIG behaves differently depending on whether
> VIRTIO_NET_F_HASH_REPORT is negotiated or not;

It wouldn't be a problem if you do 1:1 mapping between virtio commands
and TUN uAPI, otherwise it should have a bug somewhere.

> it also enables hash
> reporting if the feature is negotiated.

Again, starting from virtio-net command is easier, a strong
justification is needed to explain why we choose another for tun/tap.

>
> >
> > One day we would have tun_select_queue_algorithm_x() we don't have to
> > duplicate the ioctls once again here like TUNSETVNETREPORTINGXYZ
>
> 5.1.6.5.6.4 Hash calculation says:
> >  If VIRTIO_NET_F_HASH_REPORT was negotiated and the device uses
> > automatic receive steering, the device MUST support a command to
> > configure hash calculation parameters.
> >
> > The driver provides parameters for hash calculation as follows:
> >
> > class VIRTIO_NET_CTRL_MQ, command VIRTIO_NET_CTRL_MQ_HASH_CONFIG.
>
> VIRTIO_NET_CTRL_MQ_HASH_CONFIG is for automatic receive steering and not
> for RSS (or other steering algorithms if the spec gets any in the future)=
.

I'm not sure but the spec needs some tweaking. For example, I don't
expect there would be a dedicated hash config command for flow filters
in the future. I think the reason why spec says like this is that
virtio-net only supports automatic receive steering.

Note that macvtap doesn't implement automatic receive steering.

>
> >
> >> +               if (copy_from_user(&common, argp, sizeof(common)))
> >> +                       return -EFAULT;
> >> +               argp =3D (struct tun_vnet_rss __user *)argp + 1;
> >> +
> >> +               indirection_table_size =3D ((size_t)common.indirection=
_table_mask + 1) * 2;
> >> +               key_size =3D virtio_net_hash_key_length(common.hash_ty=
pes);
> >> +               size =3D struct_size(hash, rss_indirection_table,
> >> +                                  (size_t)common.indirection_table_ma=
sk + 1);
> >> +
> >> +               hash =3D kmalloc(size, GFP_KERNEL);
> >> +               if (!hash)
> >> +                       return -ENOMEM;
> >> +
> >> +               if (copy_from_user(hash->rss_indirection_table,
> >> +                                  argp, indirection_table_size)) {
> >> +                       kfree(hash);
> >> +                       return -EFAULT;
> >> +               }
> >> +               argp =3D (u16 __user *)argp + common.indirection_table=
_mask + 1;
> >> +
> >> +               if (copy_from_user(hash->rss_key, argp, key_size)) {
> >> +                       kfree(hash);
> >> +                       return -EFAULT;
> >> +               }
> >> +
> >> +               virtio_net_toeplitz_convert_key(hash->rss_key, key_siz=
e);
> >> +               hash->report =3D cmd =3D=3D TUNSETVNETREPORTINGRSS;
> >
> > At least, if this is the only difference why not simply code this into
> > the ioctl itself other than having a very similar command?
>
> It is what the previous version did. Either is fine I guess; the only
> practical difference would be the size of the configuration struct is
> smaller with this approach.
>
> >
> >> +               hash->rss =3D true;
> >> +               hash->common =3D common;
> >> +               break;
> >> +
> >> +       default:
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(*hashp, hash));
> >> +       return 0;
> >> +}
> >> +
> >> +static inline void tun_vnet_hash_report(const struct tun_vnet_hash *h=
ash,
> >> +                                       struct sk_buff *skb,
> >> +                                       const struct flow_keys_basic *=
keys,
> >> +                                       u32 value,
> >> +                                       tun_vnet_hash_add vnet_hash_ad=
d)
> >> +{
> >> +       struct virtio_net_hash *report;
> >> +
> >> +       if (!hash || !hash->report)
> >> +               return;
> >> +
> >> +       report =3D vnet_hash_add(skb);
> >> +       if (!report)
> >> +               return;
> >> +
> >> +       *report =3D (struct virtio_net_hash) {
> >> +               .report =3D virtio_net_hash_report(hash->common.hash_t=
ypes, keys),
> >> +               .value =3D value
> >> +       };
> >> +}
> >> +
> >> +static inline u16 tun_vnet_rss_select_queue(u32 numqueues,
> >> +                                           const struct tun_vnet_hash=
 *hash,
> >> +                                           struct sk_buff *skb,
> >> +                                           tun_vnet_hash_add vnet_has=
h_add)
> >> +{
> >> +       struct virtio_net_hash *report;
> >> +       struct virtio_net_hash ret;
> >> +       u16 index;
> >> +
> >> +       if (!numqueues)
> >> +               return 0;
> >> +
> >> +       virtio_net_hash_rss(skb, hash->common.hash_types, hash->rss_ke=
y, &ret);
> >> +
> >> +       if (!ret.report)
> >> +               return hash->common.unclassified_queue % numqueues;
> >> +
> >> +       if (hash->report) {
> >> +               report =3D vnet_hash_add(skb);
> >> +               if (report)
> >> +                       *report =3D ret;
> >> +       }
> >> +
> >> +       index =3D ret.value & hash->common.indirection_table_mask;
> >> +
> >> +       return hash->rss_indirection_table[index] % numqueues;
> >> +}
> >> +
> >>   static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
> >>                                     struct iov_iter *from,
> >>                                     struct virtio_net_hdr *hdr)
> >> @@ -135,15 +268,17 @@ static inline int tun_vnet_hdr_get(int sz, unsig=
ned int flags,
> >>   }
> >>
> >>   static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> >> -                                  const struct virtio_net_hdr *hdr)
> >> +                                  const struct virtio_net_hdr_v1_hash=
 *hdr)
> >>   {
> >> +       int content_sz =3D MIN(sizeof(*hdr), sz);
> >> +
> >>          if (unlikely(iov_iter_count(iter) < sz))
> >>                  return -EINVAL;
> >>
> >> -       if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) !=3D sizeof=
(*hdr)))
> >> +       if (unlikely(copy_to_iter(hdr, content_sz, iter) !=3D content_=
sz))
> >>                  return -EFAULT;
> >>
> >> -       if (iov_iter_zero(sz - sizeof(*hdr), iter) !=3D sz - sizeof(*h=
dr))
> >> +       if (iov_iter_zero(sz - content_sz, iter) !=3D sz - content_sz)
> >>                  return -EFAULT;
> >>
> >>          return 0;
> >> @@ -155,26 +290,38 @@ static inline int tun_vnet_hdr_to_skb(unsigned i=
nt flags, struct sk_buff *skb,
> >>          return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_end=
ian(flags));
> >>   }
> >>
> >> -static inline int tun_vnet_hdr_from_skb(unsigned int flags,
> >> +static inline int tun_vnet_hdr_from_skb(int sz, unsigned int flags,
> >>                                          const struct net_device *dev,
> >>                                          const struct sk_buff *skb,
> >> -                                       struct virtio_net_hdr *hdr)
> >> +                                       tun_vnet_hash_find vnet_hash_f=
ind,
> >> +                                       struct virtio_net_hdr_v1_hash =
*hdr)
> >>   {
> >>          int vlan_hlen =3D skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
> >> +       const struct virtio_net_hash *report =3D sz < sizeof(struct vi=
rtio_net_hdr_v1_hash) ?
> >> +                                              NULL : vnet_hash_find(s=
kb);
> >> +
> >> +       *hdr =3D (struct virtio_net_hdr_v1_hash) {
> >> +               .hash_report =3D VIRTIO_NET_HASH_REPORT_NONE
> >> +       };
> >> +
> >> +       if (report) {
> >> +               hdr->hash_value =3D cpu_to_le32(report->value);
> >> +               hdr->hash_report =3D cpu_to_le16(report->report);
> >> +       }
> >>
> >> -       if (virtio_net_hdr_from_skb(skb, hdr,
> >> +       if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
> >>                                      tun_vnet_is_little_endian(flags),=
 true,
> >>                                      vlan_hlen)) {
> >>                  struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> >>
> >>                  if (net_ratelimit()) {
> >>                          netdev_err(dev, "unexpected GSO type: 0x%x, g=
so_size %d, hdr_len %d\n",
> >> -                                  sinfo->gso_type, tun_vnet16_to_cpu(=
flags, hdr->gso_size),
> >> -                                  tun_vnet16_to_cpu(flags, hdr->hdr_l=
en));
> >> +                                  sinfo->gso_type, tun_vnet16_to_cpu(=
flags, hdr->hdr.gso_size),
> >> +                                  tun_vnet16_to_cpu(flags, hdr->hdr.h=
dr_len));
> >>                          print_hex_dump(KERN_ERR, "tun: ",
> >>                                         DUMP_PREFIX_NONE,
> >>                                         16, 1, skb->head,
> >> -                                      min(tun_vnet16_to_cpu(flags, hd=
r->hdr_len), 64), true);
> >> +                                      min(tun_vnet16_to_cpu(flags, hd=
r->hdr.hdr_len), 64), true);
> >>                  }
> >>                  WARN_ON_ONCE(1);
> >>                  return -EINVAL;
> >> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> >> index 980de74724fc..fe4b984d3bbb 100644
> >> --- a/include/uapi/linux/if_tun.h
> >> +++ b/include/uapi/linux/if_tun.h
> >> @@ -62,6 +62,62 @@
> >>   #define TUNSETCARRIER _IOW('T', 226, int)
> >>   #define TUNGETDEVNETNS _IO('T', 227)
> >>
> >> +/**
> >> + * define TUNGETVNETHASHTYPES - ioctl to get supported virtio_net has=
hing types
> >> + *
> >> + * The argument is a pointer to __u32 which will store the supported =
virtio_net
> >> + * hashing types.
> >> + */
> >> +#define TUNGETVNETHASHTYPES _IOR('T', 228, __u32)
> >> +
> >> +/**
> >> + * define TUNSETVNETREPORTINGAUTOMQ - ioctl to enable automq with has=
h reporting
> >> + *
> >> + * Disable RSS and enable automatic receive steering with hash report=
ing.
> >> + *
> >> + * The argument is a pointer to __u32 that contains a bitmask of hash=
 types
> >> + * allowed to be reported.
> >> + *
> >> + * This ioctl results in %EBADFD if the underlying device is deleted.=
 It affects
> >> + * all queues attached to the same device.
> >> + *
> >> + * This ioctl currently has no effect on XDP packets and packets with
> >> + * queue_mapping set by TC.
> >> + */
> >> +#define TUNSETVNETREPORTINGAUTOMQ _IOR('T', 229, __u32)
> >> +
> >> +/**
> >> + * define TUNSETVNETREPORTINGRSS - ioctl to enable RSS with hash repo=
rting
> >> + *
> >> + * Disable automatic receive steering and enable RSS with hash report=
ing.
> >
> > This is unnecessary, e.g one day will have select_queue_xyz(), we
> > don't want to say "Disable automatic receive steering and xyz ..."
>
> It is still something better to be documented as its behavior is
> somewhat complicated.

This is a hint of uAPI design issue.

>
> Concretely, this ioctl disables automatic receive steering but doesn't
> disable steering by eBPF, which is implied by TUN_STEERINGEBPF_FALLBACK.

It would be simpler:

1) not having TUN_STEERINGEBPF_FALLBACK
2) the steering algorithm depends on the last uAPI call

>
> Perhaps it may be rephrased to tell it disables "the other receive
> steering mechanism except eBPF".
>
> Regards,
> Akihiko Odaki
>
> >

Thanks


