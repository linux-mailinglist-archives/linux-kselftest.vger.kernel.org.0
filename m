Return-Path: <linux-kselftest+bounces-34273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CB3ACD525
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 03:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63723A2F62
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 01:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A77478F37;
	Wed,  4 Jun 2025 01:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbFBOX5+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762557C9F
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 01:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749002057; cv=none; b=MRanj0aEi7YUFVbF2WIBZ+s5bDhtf8G2MN97Z6Wd+tnETt6G0GhK1MpFaPR1TqO+hrnbP4g9HmihLiErYedm5CIj+S/QjIbdUgGTs/WGItpZICsMz3vDRr+quv53zBfE08jpJvSpvpmSZFSZaBSMYsgu3I27LiNWKxWKH/oVH+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749002057; c=relaxed/simple;
	bh=PyIz3SCR+camueB4pc22WFv+Om6DUckRqywBuWiFBME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdcKQCHxrD8i7CeUAcbH2PtyJi3E7Jaljq3zm1dB14kNQQfXRm3aj7GaL5rPyvjrkIcwfQb/dqMnYucd6xoef8eaFVO6QAOEcTuZgR5RrifWvL5xgDNvThlQLCK/vaRO59fYh9KlnFjPW30qoR8/SP3BfFkiiTH/cam/StOorE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KbFBOX5+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749002053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QsSbRJ1za8pHH/vyhuAC7Q239kUDTVlrxiDTBXQAi98=;
	b=KbFBOX5+VrT8fovPEmxDGpiHPDl0+KAOc+KBS7of8kgdFmHrqqe1/aoQb3d1XWWzrkZIy9
	mGNOmxAzVzGT+Eh8ou9cvdDnLqYmv1ZHcc98RSpIpNfDFHoz2CKGNdHtYud1dVE/FNd3uT
	H/SVhxi2nuB02OdRcGtVAPGIyf1pZFA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609--oQR6rXeMImd6kHaftIHWw-1; Tue, 03 Jun 2025 21:54:12 -0400
X-MC-Unique: -oQR6rXeMImd6kHaftIHWw-1
X-Mimecast-MFC-AGG-ID: -oQR6rXeMImd6kHaftIHWw_1749002051
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311b6d25278so6654597a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 18:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749002051; x=1749606851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsSbRJ1za8pHH/vyhuAC7Q239kUDTVlrxiDTBXQAi98=;
        b=bS+fbYPHV6XGNklEYzcXZNpnW3urDJ4kizDlRCeNiTNY+2tsRiNHRQIrRXYm2KEfvJ
         /S78bGUW+FttoHcUHsivoHawNIdl3SS0cFaDknZE4+XrEXHLiMBZ0/GzNuOuGmrhNkhu
         ZsemtNeg59ByfqMnwp5kCS/fti6HDQJU75LtbmrW8TMT2unoAebxfNJPp41BRYwiF1Ii
         BLQRYvOYP6AVeNIZKzbouiMCUZ4Mzi4Ayq4dD1GDFc56Ufl6xQnDySnBoTGtJ1WTwmS4
         GX7HBu1+9BooMW6xSzmhmpG+d/iO80w1vLu4zuLhAt5zx9dO3w6CHNrqY4GQ/UF+xbdR
         F+IA==
X-Forwarded-Encrypted: i=1; AJvYcCXUglGi7tKaWkWvUl4YU/DyIYSkWuKZPZ+VDOwERPn9GS/erzx/prNJEqoimx0mAIvp0NDhrV9F2ZI/qtegYAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw03Gm+tODpBl1uxYpRpMWDNAyCegZwHwT5BK7EBKdnD5e3A1EC
	R9JTvVWAWYPAKLpy6OQ0XynlvdvoTW+CqhlEdCnwHJ+FaKPabdAnvq1pP+ZPiG9oCi4EQoqKEtk
	rRm45P7cFMMmwAjnGit2KII/L7RaY6OkWdvTV791rvBYt3eph9ICfYP43lSAEI5EdjXzGhmM4O/
	pyqDsO7gKBYhIv0WjwyEbSGe4WTUVh9hkKTpHejvU+tIg1
X-Gm-Gg: ASbGncvlydrndGsd/jdFhIfEGIgPSjH9g65zD68fwK0sHaxCl6htcmn1ABgYYk9ljFh
	NI8c1m5gApy1U8+uZ+ph9P54d532NNOsu2Nqy4TY8uNh6HxnML5SjkT1mEpXf/2mFrjLJPQ==
X-Received: by 2002:a17:90b:1b42:b0:312:e91c:e340 with SMTP id 98e67ed59e1d1-3130ce79550mr1576878a91.35.1749002051009;
        Tue, 03 Jun 2025 18:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsQwqwhD0o9BRhk6G0ILR8Vi9Nf6ZU4HJshOO3koVcuj78mtCkmlXV3cj94uQV/Fyehpz4b0p7NXm3make1eg=
X-Received: by 2002:a17:90b:1b42:b0:312:e91c:e340 with SMTP id
 98e67ed59e1d1-3130ce79550mr1576829a91.35.1749002050397; Tue, 03 Jun 2025
 18:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-4-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-4-95d8b348de91@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Jun 2025 09:53:58 +0800
X-Gm-Features: AX0GCFse6lZTFS3iYG0JrGqphRlnASdB2inXbNx_Cl97YAH1p2CxrbdwXEZD38I
Message-ID: <CACGkMEupCBFH2eLv_93uy9K=+s_jQPM12mvyhU=zGbwSUnyVaA@mail.gmail.com>
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

On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> Add common code required for the features being added to TUN and TAP.
> They will be enabled for each of them in following patches.
>
> Added Features
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Hash reporting
> --------------
>
> Allow the guest to reuse the hash value to make receive steering
> consistent between the host and guest, and to save hash computation.
>
> Receive Side Scaling (RSS)
> --------------------------
>
> RSS is a receive steering algorithm that can be negotiated to use with
> virtio_net. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
>
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF steering program.
>
> Introduce the code to perform RSS to the kernel in order to overcome
> thse challenges. An alternative solution is to extend the eBPF steering
> program so that it will be able to report to the userspace, but I didn't
> opt for it because extending the current mechanism of eBPF steering
> program as is because it relies on legacy context rewriting, and
> introducing kfunc-based eBPF will result in non-UAPI dependency while
> the other relevant virtualization APIs such as KVM and vhost_net are
> UAPIs.
>
> Added ioctls
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> They are designed to make extensibility and VM migration compatible.
> This change only adds the implementation and does not expose them to
> the userspace.
>
> TUNGETVNETHASHTYPES
> -------------------
>
> This ioctl tells supported hash types. It is useful to check if a VM can
> be migrated to the current host.
>
> TUNSETVNETREPORTINGAUTOMQ, TUNSETVNETREPORTINGRSS, and TUNSETVNETRSS
> --------------------------------------------------------------------
>
> These ioctls configures a steering algorithm and, if needed, hash
> reporting.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Lei Yang <leiyang@redhat.com>
> ---
>  drivers/net/tap.c           |  10 ++-
>  drivers/net/tun.c           |  12 +++-
>  drivers/net/tun_vnet.h      | 165 ++++++++++++++++++++++++++++++++++++++=
+++---
>  include/uapi/linux/if_tun.h |  71 +++++++++++++++++++
>  4 files changed, 244 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index d4ece538f1b2..25c60ff2d3f2 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -179,6 +179,11 @@ static void tap_put_queue(struct tap_queue *q)
>         sock_put(&q->sk);
>  }
>
> +static const struct virtio_net_hash *tap_find_hash(const struct sk_buff =
*skb)
> +{
> +       return NULL;
> +}
> +
>  /*
>   * Select a queue based on the rxq of the device on which this packet
>   * arrived. If the incoming device is not mq, calculate a flow hash
> @@ -711,11 +716,12 @@ static ssize_t tap_put_user(struct tap_queue *q,
>         int total;
>
>         if (q->flags & IFF_VNET_HDR) {
> -               struct virtio_net_hdr vnet_hdr;
> +               struct virtio_net_hdr_v1_hash vnet_hdr;
>
>                 vnet_hdr_len =3D READ_ONCE(q->vnet_hdr_sz);
>
> -               ret =3D tun_vnet_hdr_from_skb(q->flags, NULL, skb, &vnet_=
hdr);
> +               ret =3D tun_vnet_hdr_from_skb(vnet_hdr_len, q->flags, NUL=
L, skb,
> +                                           tap_find_hash, &vnet_hdr);
>                 if (ret)
>                         return ret;
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 9133ab9ed3f5..03d47799e9bd 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -451,6 +451,11 @@ static inline void tun_flow_save_rps_rxhash(struct t=
un_flow_entry *e, u32 hash)
>                 e->rps_rxhash =3D hash;
>  }
>
> +static const struct virtio_net_hash *tun_find_hash(const struct sk_buff =
*skb)
> +{
> +       return NULL;
> +}
> +
>  /* We try to identify a flow through its rxhash. The reason that
>   * we do not check rxq no. is because some cards(e.g 82599), chooses
>   * the rxq based on the txq where the last packet of the flow comes. As
> @@ -1993,7 +1998,7 @@ static ssize_t tun_put_user_xdp(struct tun_struct *=
tun,
>         ssize_t ret;
>
>         if (tun->flags & IFF_VNET_HDR) {
> -               struct virtio_net_hdr gso =3D { 0 };
> +               struct virtio_net_hdr_v1_hash gso =3D { 0 };
>
>                 vnet_hdr_sz =3D READ_ONCE(tun->vnet_hdr_sz);
>                 ret =3D tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
> @@ -2046,9 +2051,10 @@ static ssize_t tun_put_user(struct tun_struct *tun=
,
>         }
>
>         if (vnet_hdr_sz) {
> -               struct virtio_net_hdr gso;
> +               struct virtio_net_hdr_v1_hash gso;
>
> -               ret =3D tun_vnet_hdr_from_skb(tun->flags, tun->dev, skb, =
&gso);
> +               ret =3D tun_vnet_hdr_from_skb(vnet_hdr_sz, tun->flags, tu=
n->dev,
> +                                           skb, tun_find_hash, &gso);
>                 if (ret)
>                         return ret;
>
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 58b9ac7a5fc4..45d0533efc8d 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -6,6 +6,17 @@
>  #define TUN_VNET_LE     0x80000000
>  #define TUN_VNET_BE     0x40000000
>
> +typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_buff *);
> +typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const struct=
 sk_buff *);
> +
> +struct tun_vnet_hash {
> +       bool report;
> +       bool rss;
> +       struct tun_vnet_rss common;
> +       u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +       u16 rss_indirection_table[];
> +};
> +
>  static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
>  {
>         bool be =3D IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> @@ -107,6 +118,128 @@ static inline long tun_vnet_ioctl(int *vnet_hdr_sz,=
 unsigned int *flags,
>         }
>  }
>
> +static inline long tun_vnet_ioctl_gethashtypes(u32 __user *argp)
> +{
> +       return put_user(VIRTIO_NET_SUPPORTED_HASH_TYPES, argp) ? -EFAULT =
: 0;
> +}
> +
> +static inline long tun_vnet_ioctl_sethash(struct tun_vnet_hash __rcu **h=
ashp,
> +                                         unsigned int cmd,
> +                                         void __user *argp)
> +{
> +       struct tun_vnet_rss common;
> +       struct tun_vnet_hash *hash;
> +       size_t indirection_table_size;
> +       size_t key_size;
> +       size_t size;
> +
> +       switch (cmd) {
> +       case TUNSETVNETREPORTINGAUTOMQ:
> +               if (get_user(common.hash_types, (u32 __user *)argp))
> +                       return -EFAULT;
> +
> +               if (common.hash_types) {
> +                       hash =3D kzalloc(sizeof(*hash), GFP_KERNEL);
> +                       if (!hash)
> +                               return -ENOMEM;
> +
> +                       hash->report =3D true;
> +                       hash->common.hash_types =3D common.hash_types;
> +               } else {
> +                       hash =3D NULL;
> +               }
> +               break;
> +
> +       case TUNSETVNETREPORTINGRSS:
> +       case TUNSETVNETRSS:

So the above three shows unnecessary design redundancy as well as a
burden for the future extension.  Why not simply have

1) TUNSETVNET_RSS
2) TUNSETVNET_HASH_REPORT
?

Which maps to

 #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1 (for configurable
receive steering)
 #define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2 (for configurable
hash calculation)

It would be always easier to start with what spec had or at least we
need to explain why we choose a different design here or in the
changelog to ease our life.

One day we would have tun_select_queue_algorithm_x() we don't have to
duplicate the ioctls once again here like TUNSETVNETREPORTINGXYZ

> +               if (copy_from_user(&common, argp, sizeof(common)))
> +                       return -EFAULT;
> +               argp =3D (struct tun_vnet_rss __user *)argp + 1;
> +
> +               indirection_table_size =3D ((size_t)common.indirection_ta=
ble_mask + 1) * 2;
> +               key_size =3D virtio_net_hash_key_length(common.hash_types=
);
> +               size =3D struct_size(hash, rss_indirection_table,
> +                                  (size_t)common.indirection_table_mask =
+ 1);
> +
> +               hash =3D kmalloc(size, GFP_KERNEL);
> +               if (!hash)
> +                       return -ENOMEM;
> +
> +               if (copy_from_user(hash->rss_indirection_table,
> +                                  argp, indirection_table_size)) {
> +                       kfree(hash);
> +                       return -EFAULT;
> +               }
> +               argp =3D (u16 __user *)argp + common.indirection_table_ma=
sk + 1;
> +
> +               if (copy_from_user(hash->rss_key, argp, key_size)) {
> +                       kfree(hash);
> +                       return -EFAULT;
> +               }
> +
> +               virtio_net_toeplitz_convert_key(hash->rss_key, key_size);
> +               hash->report =3D cmd =3D=3D TUNSETVNETREPORTINGRSS;

At least, if this is the only difference why not simply code this into
the ioctl itself other than having a very similar command?

> +               hash->rss =3D true;
> +               hash->common =3D common;
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(*hashp, hash));
> +       return 0;
> +}
> +
> +static inline void tun_vnet_hash_report(const struct tun_vnet_hash *hash=
,
> +                                       struct sk_buff *skb,
> +                                       const struct flow_keys_basic *key=
s,
> +                                       u32 value,
> +                                       tun_vnet_hash_add vnet_hash_add)
> +{
> +       struct virtio_net_hash *report;
> +
> +       if (!hash || !hash->report)
> +               return;
> +
> +       report =3D vnet_hash_add(skb);
> +       if (!report)
> +               return;
> +
> +       *report =3D (struct virtio_net_hash) {
> +               .report =3D virtio_net_hash_report(hash->common.hash_type=
s, keys),
> +               .value =3D value
> +       };
> +}
> +
> +static inline u16 tun_vnet_rss_select_queue(u32 numqueues,
> +                                           const struct tun_vnet_hash *h=
ash,
> +                                           struct sk_buff *skb,
> +                                           tun_vnet_hash_add vnet_hash_a=
dd)
> +{
> +       struct virtio_net_hash *report;
> +       struct virtio_net_hash ret;
> +       u16 index;
> +
> +       if (!numqueues)
> +               return 0;
> +
> +       virtio_net_hash_rss(skb, hash->common.hash_types, hash->rss_key, =
&ret);
> +
> +       if (!ret.report)
> +               return hash->common.unclassified_queue % numqueues;
> +
> +       if (hash->report) {
> +               report =3D vnet_hash_add(skb);
> +               if (report)
> +                       *report =3D ret;
> +       }
> +
> +       index =3D ret.value & hash->common.indirection_table_mask;
> +
> +       return hash->rss_indirection_table[index] % numqueues;
> +}
> +
>  static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
>                                    struct iov_iter *from,
>                                    struct virtio_net_hdr *hdr)
> @@ -135,15 +268,17 @@ static inline int tun_vnet_hdr_get(int sz, unsigned=
 int flags,
>  }
>
>  static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> -                                  const struct virtio_net_hdr *hdr)
> +                                  const struct virtio_net_hdr_v1_hash *h=
dr)
>  {
> +       int content_sz =3D MIN(sizeof(*hdr), sz);
> +
>         if (unlikely(iov_iter_count(iter) < sz))
>                 return -EINVAL;
>
> -       if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) !=3D sizeof(*h=
dr)))
> +       if (unlikely(copy_to_iter(hdr, content_sz, iter) !=3D content_sz)=
)
>                 return -EFAULT;
>
> -       if (iov_iter_zero(sz - sizeof(*hdr), iter) !=3D sz - sizeof(*hdr)=
)
> +       if (iov_iter_zero(sz - content_sz, iter) !=3D sz - content_sz)
>                 return -EFAULT;
>
>         return 0;
> @@ -155,26 +290,38 @@ static inline int tun_vnet_hdr_to_skb(unsigned int =
flags, struct sk_buff *skb,
>         return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_little_endian(=
flags));
>  }
>
> -static inline int tun_vnet_hdr_from_skb(unsigned int flags,
> +static inline int tun_vnet_hdr_from_skb(int sz, unsigned int flags,
>                                         const struct net_device *dev,
>                                         const struct sk_buff *skb,
> -                                       struct virtio_net_hdr *hdr)
> +                                       tun_vnet_hash_find vnet_hash_find=
,
> +                                       struct virtio_net_hdr_v1_hash *hd=
r)
>  {
>         int vlan_hlen =3D skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
> +       const struct virtio_net_hash *report =3D sz < sizeof(struct virti=
o_net_hdr_v1_hash) ?
> +                                              NULL : vnet_hash_find(skb)=
;
> +
> +       *hdr =3D (struct virtio_net_hdr_v1_hash) {
> +               .hash_report =3D VIRTIO_NET_HASH_REPORT_NONE
> +       };
> +
> +       if (report) {
> +               hdr->hash_value =3D cpu_to_le32(report->value);
> +               hdr->hash_report =3D cpu_to_le16(report->report);
> +       }
>
> -       if (virtio_net_hdr_from_skb(skb, hdr,
> +       if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
>                                     tun_vnet_is_little_endian(flags), tru=
e,
>                                     vlan_hlen)) {
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
>
>                 if (net_ratelimit()) {
>                         netdev_err(dev, "unexpected GSO type: 0x%x, gso_s=
ize %d, hdr_len %d\n",
> -                                  sinfo->gso_type, tun_vnet16_to_cpu(fla=
gs, hdr->gso_size),
> -                                  tun_vnet16_to_cpu(flags, hdr->hdr_len)=
);
> +                                  sinfo->gso_type, tun_vnet16_to_cpu(fla=
gs, hdr->hdr.gso_size),
> +                                  tun_vnet16_to_cpu(flags, hdr->hdr.hdr_=
len));
>                         print_hex_dump(KERN_ERR, "tun: ",
>                                        DUMP_PREFIX_NONE,
>                                        16, 1, skb->head,
> -                                      min(tun_vnet16_to_cpu(flags, hdr->=
hdr_len), 64), true);
> +                                      min(tun_vnet16_to_cpu(flags, hdr->=
hdr.hdr_len), 64), true);
>                 }
>                 WARN_ON_ONCE(1);
>                 return -EINVAL;
> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> index 980de74724fc..fe4b984d3bbb 100644
> --- a/include/uapi/linux/if_tun.h
> +++ b/include/uapi/linux/if_tun.h
> @@ -62,6 +62,62 @@
>  #define TUNSETCARRIER _IOW('T', 226, int)
>  #define TUNGETDEVNETNS _IO('T', 227)
>
> +/**
> + * define TUNGETVNETHASHTYPES - ioctl to get supported virtio_net hashin=
g types
> + *
> + * The argument is a pointer to __u32 which will store the supported vir=
tio_net
> + * hashing types.
> + */
> +#define TUNGETVNETHASHTYPES _IOR('T', 228, __u32)
> +
> +/**
> + * define TUNSETVNETREPORTINGAUTOMQ - ioctl to enable automq with hash r=
eporting
> + *
> + * Disable RSS and enable automatic receive steering with hash reporting=
.
> + *
> + * The argument is a pointer to __u32 that contains a bitmask of hash ty=
pes
> + * allowed to be reported.
> + *
> + * This ioctl results in %EBADFD if the underlying device is deleted. It=
 affects
> + * all queues attached to the same device.
> + *
> + * This ioctl currently has no effect on XDP packets and packets with
> + * queue_mapping set by TC.
> + */
> +#define TUNSETVNETREPORTINGAUTOMQ _IOR('T', 229, __u32)
> +
> +/**
> + * define TUNSETVNETREPORTINGRSS - ioctl to enable RSS with hash reporti=
ng
> + *
> + * Disable automatic receive steering and enable RSS with hash reporting=
.

This is unnecessary, e.g one day will have select_queue_xyz(), we
don't want to say "Disable automatic receive steering and xyz ..."

> + *
> + * This ioctl results in %EBADFD if the underlying device is deleted. It=
 affects
> + * all queues attached to the same device.
> + *
> + * This ioctl currently has no effect on XDP packets and packets with
> + * queue_mapping set by TC.
> + */
> +#define TUNSETVNETREPORTINGRSS _IOR('T', 230, struct tun_vnet_rss)
> +
> +/**
> + * define TUNSETVNETRSS - ioctl to enable RSS without hash reporting
> + *
> + * Disable automatic receive steering and enable RSS without hash report=
ing.

Same here.

> + *
> + * The argument is a pointer to the compound of the following in order:
> + *
> + * 1. &struct tun_vnet_rss
> + * 3. Indirection table
> + * 4. Key
> + *
> + * This ioctl results in %EBADFD if the underlying device is deleted. It=
 affects
> + * all queues attached to the same device.
> + *
> + * This ioctl currently has no effect on XDP packets and packets with
> + * queue_mapping set by TC.
> + */
> +#define TUNSETVNETRSS _IOR('T', 231, struct tun_vnet_rss)
> +
>  /* TUNSETIFF ifr flags */
>  #define IFF_TUN                0x0001
>  #define IFF_TAP                0x0002
> @@ -124,4 +180,19 @@ struct tun_filter {
>   */
>  #define TUN_STEERINGEBPF_FALLBACK -1
>
> +/**
> + * struct tun_vnet_rss - virtio_net RSS configuration
> + * @hash_types:
> + *             Bitmask of allowed hash types
> + * @indirection_table_mask:
> + *             Bitmask to be applied to the indirection table index
> + * @unclassified_queue:
> + *             The index of the queue to place unclassified packets in
> + */
> +struct tun_vnet_rss {
> +       __u32 hash_types;
> +       __u16 indirection_table_mask;
> +       __u16 unclassified_queue;
> +};
> +
>  #endif /* _UAPI__IF_TUN_H */
>
> --
> 2.49.0
>

Thanks


