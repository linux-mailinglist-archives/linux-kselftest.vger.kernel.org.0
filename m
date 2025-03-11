Return-Path: <linux-kselftest+bounces-28684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4273AA5B446
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 01:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614CC1732A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 00:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E670200B0;
	Tue, 11 Mar 2025 00:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VT7eYmOe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B5E1E511
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 00:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741653514; cv=none; b=nd1epfZNpxJeT5lGicOa/D+okWI7ybas61WoFUztgRoKCmq1rQ1NkU5U9fQXVteOW6bzKGjV5pdFEsPnrEzDIJLrmTN3bDgE+koRFj3wcZupQsYm7oGHUDD1ghwb1MzgKleeIbE8xONPpxTCwstPV0oUda1edWFyj5x9amb/4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741653514; c=relaxed/simple;
	bh=pC2bMFh4gx9snvWFLhOECwUWQ2bNg+6zDKVtwNKTwWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtQU+BFMPc/1INxcet9/5vy3CYVDx9lPs8Voq0ahrNM8+uaUuGrFaZ7He6BHv339OcH6CASimyPkc5KtEXEvEclUadpDQsWRXPnyPKhT+vF+yOj/+BOhtFUeZi+w11A5duzCN+JFmcK/7K3xvtVZ4pgHTo/rV5b7sybjPo25CeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VT7eYmOe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741653510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AEt0fLq1vKeg+k+XGJ/WBpcq9tNbR0V+LjVs0GLe5Wc=;
	b=VT7eYmOeK2Ipx7fOBZEbypTmFml299HIvnh97uQM9c1xUU4ZTBRBzBUPDKr09d5Ru/gN1n
	GQYZbzjKKxuVEl9SH+XuUApIFPy6k8izzb32XynTZZLwvR2qnl+ETghOZ5sSY1gJ9RKGlo
	4maCuEAEz7kcjeS21d2JsqdW4yQSYBE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-CfvHuNKFMribLLvSJ-ixCA-1; Mon, 10 Mar 2025 20:38:29 -0400
X-MC-Unique: CfvHuNKFMribLLvSJ-ixCA-1
X-Mimecast-MFC-AGG-ID: CfvHuNKFMribLLvSJ-ixCA_1741653508
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff8340d547so5534571a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 17:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741653508; x=1742258308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEt0fLq1vKeg+k+XGJ/WBpcq9tNbR0V+LjVs0GLe5Wc=;
        b=VLj/H0evDm4z6wRwg0q2JlfKwG2R4WwbNHC3bPi8W+H8AqhYZ3gNiWaUr0hHri0+9M
         6BFoySFXehxNXGdBNnfK8YFv7zsod6McsjT4VPEVkUkHz3lgPn+GcVbUb6JGrcw2Zqt2
         0jsnzZVaI9vkig+g3FHeDEWLLDN0c7gDysenVT+x+u2wJqVFp7YnsnW479o02LMhuKnK
         WQ8eneCyeab0Az1Q/+4Uvl9PiekzWWeVN+V/OIn9RkWe0/SDwgHlXBWKhi7JB4iygXi4
         QOYP9TNWFrKDuM3N3bLjw8NE4Gf0Qb5iC4FqvMjoYajCrVMwYDgpMhOeQwXIlU4BB0F7
         resw==
X-Forwarded-Encrypted: i=1; AJvYcCV7bdfUwJDLNAK9HE0lC76ynpuRMTXGFrE4nBcLuGmHVx9aejLKNdyF97FkcD6Rz3RMwh+CRylRvw9DMyX1jvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyDA3BQOLxOgCU1z+ORtU6KSDWo9Rqwo6QLGXgjJI4yR5Kat8O
	5oVbQouCIuapgTwGTznCKUNo8FpFJTjtQkOpd2qP0Fda8wmGSih72QozpGRytswL8Cgaqel1q8f
	VTLlFZDQiWQqTOETuTbAJOSKxofBVtFN9o4KGU4ajfSKnYhIFVx9rwJx7yLR7dUrMCoPxlIDCQr
	P8NlriABGsr1rwVSlJn4K7RF4Xa+NmejRWDcEXZzVt91YUyFA/Govq7g==
X-Gm-Gg: ASbGnctk7hjuF0r6ItYeaGV0bW2S+EZf0Pz/z+hGxeFkQJ1477HvHp1BfGQLhl0Puq0
	/UqzRhAc4XfuWfw6acPzOPr8Yu6xEmYwBhG4IWr6HFTSYM7Ri/A/3jkXtY3qKF+Wiy6yb+Q==
X-Received: by 2002:a17:90b:2fc7:b0:2fe:ac91:4667 with SMTP id 98e67ed59e1d1-2ff7cf1d266mr23651419a91.29.1741653507785;
        Mon, 10 Mar 2025 17:38:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9F4OqgitK+qU5EnHMvpWS1qd/xaj2rIemWc+9lOAgsHJ3Hx7t19xln7eW4g2JnumpAvBDvF8Bl/NqAyTXRgA=
X-Received: by 2002:a17:90b:2fc7:b0:2fe:ac91:4667 with SMTP id
 98e67ed59e1d1-2ff7cf1d266mr23651361a91.29.1741653507048; Mon, 10 Mar 2025
 17:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-3-df76624025eb@daynix.com>
 <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com> <7978dfd5-8499-44f3-9c30-e53a01449281@daynix.com>
In-Reply-To: <7978dfd5-8499-44f3-9c30-e53a01449281@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Mar 2025 08:38:13 +0800
X-Gm-Features: AQ5f1JoRqFs52HwPMJTABayzAYov9fpdm_fTMLYhj2tfJI0EBKbATdtsJ0Qtqa4
Message-ID: <CACGkMEsR4_RreDbYQSEk5Cr29_26WNUYheWCQBjyMNUn=1eS2Q@mail.gmail.com>
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

On Mon, Mar 10, 2025 at 3:45=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/10 12:55, Jason Wang wrote:
> > On Fri, Mar 7, 2025 at 7:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> Hash reporting
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Allow the guest to reuse the hash value to make receive steering
> >> consistent between the host and guest, and to save hash computation.
> >>
> >> RSS
> >> =3D=3D=3D
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
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> Tested-by: Lei Yang <leiyang@redhat.com>
> >> ---
> >>   Documentation/networking/tuntap.rst |   7 ++
> >>   drivers/net/Kconfig                 |   1 +
> >>   drivers/net/tap.c                   |  68 ++++++++++++++-
> >>   drivers/net/tun.c                   |  98 +++++++++++++++++-----
> >>   drivers/net/tun_vnet.h              | 159 ++++++++++++++++++++++++++=
++++++++--
> >>   include/linux/if_tap.h              |   2 +
> >>   include/linux/skbuff.h              |   3 +
> >>   include/uapi/linux/if_tun.h         |  75 +++++++++++++++++
> >>   net/core/skbuff.c                   |   4 +
> >>   9 files changed, 386 insertions(+), 31 deletions(-)
> >>
> >> diff --git a/Documentation/networking/tuntap.rst b/Documentation/netwo=
rking/tuntap.rst
> >> index 4d7087f727be5e37dfbf5066a9e9c872cc98898d..86b4ae8caa8ad062c1e558=
920be42ce0d4217465 100644
> >> --- a/Documentation/networking/tuntap.rst
> >> +++ b/Documentation/networking/tuntap.rst
> >> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable=
 it::
> >>         return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
> >>     }
> >>
> >> +3.4 Reference
> >> +-------------
> >> +
> >> +``linux/if_tun.h`` defines the interface described below:
> >> +
> >> +.. kernel-doc:: include/uapi/linux/if_tun.h
> >> +
> >>   Universal TUN/TAP device driver Frequently Asked Question
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> >> index 1fd5acdc73c6af0e1a861867039c3624fc618e25..aecfd244dd83585fea2c5b=
815dcd787c58166c28 100644
> >> --- a/drivers/net/Kconfig
> >> +++ b/drivers/net/Kconfig
> >> @@ -395,6 +395,7 @@ config TUN
> >>          tristate "Universal TUN/TAP device driver support"
> >>          depends on INET
> >>          select CRC32
> >> +       select SKB_EXTENSIONS
> >>          help
> >>            TUN/TAP provides packet reception and transmission for user=
 space
> >>            programs.  It can be viewed as a simple Point-to-Point or E=
thernet
> >> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >> index d4ece538f1b23789ca60caa6232690e4d0a4d14a..9428b63ec27e7f92e78a78=
afcb5e24383862c00d 100644
> >> --- a/drivers/net/tap.c
> >> +++ b/drivers/net/tap.c
> >> @@ -49,6 +49,10 @@ struct major_info {
> >>          struct list_head next;
> >>   };
> >>
> >> +struct tap_skb_cb {
> >> +       struct virtio_net_hash hash;
> >> +};
> >> +
> >>   #define GOODCOPY_LEN 128
> >>
> >>   static const struct proto_ops tap_socket_ops;
> >> @@ -179,6 +183,22 @@ static void tap_put_queue(struct tap_queue *q)
> >>          sock_put(&q->sk);
> >>   }
> >>
> >> +static struct tap_skb_cb *tap_skb_cb(const struct sk_buff *skb)
> >> +{
> >> +       BUILD_BUG_ON(sizeof(skb->cb) < sizeof(struct tap_skb_cb));
> >> +       return (struct tap_skb_cb *)skb->cb;
> >> +}
> >> +
> >> +static struct virtio_net_hash *tap_add_hash(struct sk_buff *skb)
> >> +{
> >> +       return &tap_skb_cb(skb)->hash;
> >> +}
> >> +
> >> +static const struct virtio_net_hash *tap_find_hash(const struct sk_bu=
ff *skb)
> >> +{
> >> +       return &tap_skb_cb(skb)->hash;
> >> +}
> >> +
> >>   /*
> >>    * Select a queue based on the rxq of the device on which this packe=
t
> >>    * arrived. If the incoming device is not mq, calculate a flow hash
> >> @@ -189,6 +209,7 @@ static void tap_put_queue(struct tap_queue *q)
> >>   static struct tap_queue *tap_get_queue(struct tap_dev *tap,
> >>                                         struct sk_buff *skb)
> >>   {
> >> +       struct flow_keys_basic keys_basic;
> >>          struct tap_queue *queue =3D NULL;
> >>          /* Access to taps array is protected by rcu, but access to nu=
mvtaps
> >>           * isn't. Below we use it to lookup a queue, but treat it as =
a hint
> >> @@ -196,17 +217,47 @@ static struct tap_queue *tap_get_queue(struct ta=
p_dev *tap,
> >>           * racing against queue removal.
> >>           */
> >>          int numvtaps =3D READ_ONCE(tap->numvtaps);
> >> +       struct tun_vnet_hash_container *vnet_hash =3D rcu_dereference(=
tap->vnet_hash);
> >>          __u32 rxq;
> >>
> >> +       *tap_skb_cb(skb) =3D (struct tap_skb_cb) {
> >> +               .hash =3D { .report =3D VIRTIO_NET_HASH_REPORT_NONE }
> >> +       };
> >> +
> >>          if (!numvtaps)
> >>                  goto out;
> >>
> >>          if (numvtaps =3D=3D 1)
> >>                  goto single;
> >>
> >> +       if (vnet_hash) {
> >> +               if ((vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
> >> +                       rxq =3D tun_vnet_rss_select_queue(numvtaps, vn=
et_hash, skb, tap_add_hash);
> >> +                       queue =3D rcu_dereference(tap->taps[rxq]);
> >> +                       goto out;
> >> +               }
> >> +
> >> +               if (!skb->l4_hash && !skb->sw_hash) {
> >> +                       struct flow_keys keys;
> >> +
> >> +                       skb_flow_dissect_flow_keys(skb, &keys, FLOW_DI=
SSECTOR_F_STOP_AT_FLOW_LABEL);
> >> +                       rxq =3D flow_hash_from_keys(&keys);
> >> +                       keys_basic =3D (struct flow_keys_basic) {
> >> +                               .control =3D keys.control,
> >> +                               .basic =3D keys.basic
> >> +                       };
> >> +               } else {
> >> +                       skb_flow_dissect_flow_keys_basic(NULL, skb, &k=
eys_basic, NULL, 0, 0, 0,
> >> +                                                        FLOW_DISSECTO=
R_F_STOP_AT_FLOW_LABEL);
> >> +                       rxq =3D skb->hash;
> >> +               }
> >> +       } else {
> >> +               rxq =3D skb_get_hash(skb);
> >> +       }
> >> +
> >>          /* Check if we can use flow to select a queue */
> >> -       rxq =3D skb_get_hash(skb);
> >>          if (rxq) {
> >> +               tun_vnet_hash_report(vnet_hash, skb, &keys_basic, rxq,=
 tap_add_hash);
> >>                  queue =3D rcu_dereference(tap->taps[rxq % numvtaps]);
> >>                  goto out;
> >>          }
> >> @@ -711,11 +762,12 @@ static ssize_t tap_put_user(struct tap_queue *q,
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
> >> @@ -992,6 +1044,16 @@ static long tap_ioctl(struct file *file, unsigne=
d int cmd,
> >>                  rtnl_unlock();
> >>                  return ret;
> >>
> >> +       case TUNGETVNETHASHCAP:
> >> +               return tun_vnet_ioctl_gethashcap(argp);
> >> +
> >> +       case TUNSETVNETHASH:
> >> +               rtnl_lock();
> >> +               tap =3D rtnl_dereference(q->tap);
> >> +               ret =3D tap ? tun_vnet_ioctl_sethash(&tap->vnet_hash, =
true, argp) : -EBADFD;
> >> +               rtnl_unlock();
> >> +               return ret;
> >> +
> >>          case SIOCGIFHWADDR:
> >>                  rtnl_lock();
> >>                  tap =3D tap_get_tap_dev(q);
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index d8f4d3e996a7a81d1f8b04635054081671a14f07..520013df416e93d3a50b46=
be9b53ae9ab410eab4 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -209,6 +209,7 @@ struct tun_struct {
> >>          struct bpf_prog __rcu *xdp_prog;
> >>          struct tun_prog __rcu *steering_prog;
> >>          struct tun_prog __rcu *filter_prog;
> >> +       struct tun_vnet_hash_container __rcu *vnet_hash;
> >>          struct ethtool_link_ksettings link_ksettings;
> >>          /* init args */
> >>          struct file *file;
> >> @@ -451,20 +452,37 @@ static inline void tun_flow_save_rps_rxhash(stru=
ct tun_flow_entry *e, u32 hash)
> >>                  e->rps_rxhash =3D hash;
> >>   }
> >>
> >> +static struct virtio_net_hash *tun_add_hash(struct sk_buff *skb)
> >> +{
> >> +       return skb_ext_add(skb, SKB_EXT_TUN_VNET_HASH);
> >> +}
> >> +
> >> +static const struct virtio_net_hash *tun_find_hash(const struct sk_bu=
ff *skb)
> >> +{
> >> +       return skb_ext_find(skb, SKB_EXT_TUN_VNET_HASH);
> >> +}
> >> +
> >>   /* We try to identify a flow through its rxhash. The reason that
> >>    * we do not check rxq no. is because some cards(e.g 82599), chooses
> >>    * the rxq based on the txq where the last packet of the flow comes.=
 As
> >>    * the userspace application move between processors, we may get a
> >>    * different rxq no. here.
> >>    */
> >> -static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_=
buff *skb)
> >> +static u16 tun_automq_select_queue(struct tun_struct *tun,
> >> +                                  const struct tun_vnet_hash_containe=
r *vnet_hash,
> >> +                                  struct sk_buff *skb)
> >>   {
> >> +       struct flow_keys keys;
> >> +       struct flow_keys_basic keys_basic;
> >>          struct tun_flow_entry *e;
> >>          u32 txq, numqueues;
> >>
> >>          numqueues =3D READ_ONCE(tun->numqueues);
> >>
> >> -       txq =3D __skb_get_hash_symmetric(skb);
> >> +       memset(&keys, 0, sizeof(keys));
> >> +       skb_flow_dissect(skb, &flow_keys_dissector_symmetric, &keys, 0=
);
> >> +
> >> +       txq =3D flow_hash_from_keys(&keys);
> >>          e =3D tun_flow_find(&tun->flows[tun_hashfn(txq)], txq);
> >>          if (e) {
> >>                  tun_flow_save_rps_rxhash(e, txq);
> >> @@ -473,6 +491,13 @@ static u16 tun_automq_select_queue(struct tun_str=
uct *tun, struct sk_buff *skb)
> >>                  txq =3D reciprocal_scale(txq, numqueues);
> >>          }
> >>
> >> +       keys_basic =3D (struct flow_keys_basic) {
> >> +               .control =3D keys.control,
> >> +               .basic =3D keys.basic
> >> +       };
> >> +       tun_vnet_hash_report(vnet_hash, skb, &keys_basic, skb->l4_hash=
 ? skb->hash : txq,
> >> +                            tun_add_hash);
> >> +
> >>          return txq;
> >>   }
> >>
> >> @@ -500,10 +525,17 @@ static u16 tun_select_queue(struct net_device *d=
ev, struct sk_buff *skb,
> >>          u16 ret;
> >>
> >>          rcu_read_lock();
> >> -       if (rcu_dereference(tun->steering_prog))
> >> +       if (rcu_dereference(tun->steering_prog)) {
> >>                  ret =3D tun_ebpf_select_queue(tun, skb);
> >> -       else
> >> -               ret =3D tun_automq_select_queue(tun, skb);
> >> +       } else {
> >> +               struct tun_vnet_hash_container *vnet_hash =3D rcu_dere=
ference(tun->vnet_hash);
> >> +
> >> +               if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_H=
ASH_RSS))
> >> +                       ret =3D tun_vnet_rss_select_queue(READ_ONCE(tu=
n->numqueues), vnet_hash,
> >> +                                                       skb, tun_add_h=
ash);
> >> +               else
> >> +                       ret =3D tun_automq_select_queue(tun, vnet_hash=
, skb);
> >> +       }
> >>          rcu_read_unlock();
> >>
> >>          return ret;
> >> @@ -1987,7 +2019,7 @@ static ssize_t tun_put_user_xdp(struct tun_struc=
t *tun,
> >>          ssize_t ret;
> >>
> >>          if (tun->flags & IFF_VNET_HDR) {
> >> -               struct virtio_net_hdr gso =3D { 0 };
> >> +               struct virtio_net_hdr_v1_hash gso =3D { 0 };
> >>
> >>                  vnet_hdr_sz =3D READ_ONCE(tun->vnet_hdr_sz);
> >>                  ret =3D tun_vnet_hdr_put(vnet_hdr_sz, iter, &gso);
> >> @@ -2040,9 +2072,10 @@ static ssize_t tun_put_user(struct tun_struct *=
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
> >> @@ -2223,6 +2256,7 @@ static void tun_free_netdev(struct net_device *d=
ev)
> >>          security_tun_dev_free_security(tun->security);
> >>          __tun_set_ebpf(tun, &tun->steering_prog, NULL);
> >>          __tun_set_ebpf(tun, &tun->filter_prog, NULL);
> >> +       kfree_rcu_mightsleep(rcu_access_pointer(tun->vnet_hash));
> >>   }
> >>
> >>   static void tun_setup(struct net_device *dev)
> >> @@ -2921,13 +2955,9 @@ static int tun_set_queue(struct file *file, str=
uct ifreq *ifr)
> >>   }
> >>
> >>   static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rc=
u **prog_p,
> >> -                       void __user *data)
> >> +                       int fd)
> >>   {
> >>          struct bpf_prog *prog;
> >> -       int fd;
> >> -
> >> -       if (copy_from_user(&fd, data, sizeof(fd)))
> >> -               return -EFAULT;
> >>
> >>          if (fd =3D=3D -1) {
> >>                  prog =3D NULL;
> >> @@ -2993,7 +3023,9 @@ static long __tun_chr_ioctl(struct file *file, u=
nsigned int cmd,
> >>          int ifindex;
> >>          int sndbuf;
> >>          int ret;
> >> +       int fd;
> >>          bool do_notify =3D false;
> >> +       struct tun_vnet_hash_container *vnet_hash;
> >>
> >>          if (cmd =3D=3D TUNSETIFF || cmd =3D=3D TUNSETQUEUE ||
> >>              (_IOC_TYPE(cmd) =3D=3D SOCK_IOC_TYPE && cmd !=3D SIOCGSKN=
S)) {
> >> @@ -3020,7 +3052,8 @@ static long __tun_chr_ioctl(struct file *file, u=
nsigned int cmd,
> >>          rtnl_lock();
> >>
> >>          tun =3D tun_get(tfile);
> >> -       if (cmd =3D=3D TUNSETIFF) {
> >> +       switch (cmd) {
> >> +       case TUNSETIFF:
> >>                  ret =3D -EEXIST;
> >>                  if (tun)
> >>                          goto unlock;
> >> @@ -3035,8 +3068,8 @@ static long __tun_chr_ioctl(struct file *file, u=
nsigned int cmd,
> >>                  if (copy_to_user(argp, &ifr, ifreq_len))
> >>                          ret =3D -EFAULT;
> >>                  goto unlock;
> >> -       }
> >> -       if (cmd =3D=3D TUNSETIFINDEX) {
> >> +
> >> +       case TUNSETIFINDEX:
> >>                  ret =3D -EPERM;
> >>                  if (tun)
> >>                          goto unlock;
> >> @@ -3050,6 +3083,10 @@ static long __tun_chr_ioctl(struct file *file, =
unsigned int cmd,
> >>                  ret =3D 0;
> >>                  tfile->ifindex =3D ifindex;
> >>                  goto unlock;
> >> +
> >> +       case TUNGETVNETHASHCAP:
> >> +               ret =3D tun_vnet_ioctl_gethashcap(argp);
> >> +               goto unlock;
> >>          }
> >>
> >>          ret =3D -EBADFD;
> >> @@ -3230,11 +3267,27 @@ static long __tun_chr_ioctl(struct file *file,=
 unsigned int cmd,
> >>                  break;
> >>
> >>          case TUNSETSTEERINGEBPF:
> >> -               ret =3D tun_set_ebpf(tun, &tun->steering_prog, argp);
> >> +               if (get_user(fd, (int __user *)argp)) {
> >> +                       ret =3D -EFAULT;
> >> +                       break;
> >> +               }
> >> +
> >> +               vnet_hash =3D rtnl_dereference(tun->vnet_hash);
> >> +               if (fd !=3D -1 && vnet_hash && (vnet_hash->common.flag=
s & TUN_VNET_HASH_RSS)) {
> >> +                       ret =3D -EBUSY;
> >> +                       break;
> >> +               }
> >> +
> >> +               ret =3D tun_set_ebpf(tun, &tun->steering_prog, fd);
> >>                  break;
> >>
> >>          case TUNSETFILTEREBPF:
> >> -               ret =3D tun_set_ebpf(tun, &tun->filter_prog, argp);
> >> +               if (get_user(fd, (int __user *)argp)) {
> >> +                       ret =3D -EFAULT;
> >> +                       break;
> >> +               }
> >> +
> >> +               ret =3D tun_set_ebpf(tun, &tun->filter_prog, fd);
> >>                  break;
> >>
> >>          case TUNSETCARRIER:
> >> @@ -3252,8 +3305,15 @@ static long __tun_chr_ioctl(struct file *file, =
unsigned int cmd,
> >>                  ret =3D open_related_ns(&net->ns, get_net_ns);
> >>                  break;
> >>
> >> +       case TUNSETVNETHASH:
> >> +               ret =3D tun_vnet_ioctl_sethash(&tun->vnet_hash,
> >> +                                            !rtnl_dereference(tun->st=
eering_prog),
> >> +                                            argp);
> >> +               break;
> >> +
> >>          default:
> >> -               ret =3D tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags,=
 cmd, argp);
> >> +               ret =3D tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags,
> >> +                                    cmd, argp);
> >>                  break;
> >>          }
> >>
> >> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> >> index 58b9ac7a5fc4084c789fe94fe36b5f8631bf1fa4..8e7d51fb0b4742cef56e7c=
5ad778b156cc654bed 100644
> >> --- a/drivers/net/tun_vnet.h
> >> +++ b/drivers/net/tun_vnet.h
> >> @@ -6,6 +6,16 @@
> >>   #define TUN_VNET_LE     0x80000000
> >>   #define TUN_VNET_BE     0x40000000
> >>
> >> +typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_buff *=
);
> >> +typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const str=
uct sk_buff *);
> >> +
> >> +struct tun_vnet_hash_container {
> >> +       struct tun_vnet_hash common;
> >
> > I'd rename this as hash.
> >
> >> +       struct tun_vnet_hash_rss rss;
> >> +       u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >> +       u16 rss_indirection_table[];
> >> +};
> >
> > Besides the separated ioctl, I'd split this structure into rss and
> > hash part as well.
> >
> >> +
> >>   static inline bool tun_vnet_legacy_is_little_endian(unsigned int fla=
gs)
> >>   {
> >>          bool be =3D IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> >> @@ -107,6 +117,123 @@ static inline long tun_vnet_ioctl(int *vnet_hdr_=
sz, unsigned int *flags,
> >>          }
> >>   }
> >>
> >> +static inline long tun_vnet_ioctl_gethashcap(void __user *argp)
> >> +{
> >> +       static const struct tun_vnet_hash cap =3D {
> >> +               .flags =3D TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
> >> +               .types =3D VIRTIO_NET_SUPPORTED_HASH_TYPES
> >> +       };
> >> +
> >> +       return copy_to_user(argp, &cap, sizeof(cap)) ? -EFAULT : 0;
> >
> > Let's has a consistent name for this and the uapi to be consistent
> > with TUNSETIFF/TUNGETIFF. Probably TUNSETVNETHASH and
> > tun_vnet_ioctl_gethash().
>
> They have different semantics so they should have different names.
> TUNGETIFF reports the value currently set while TUNGETVNETHASHCAP
> reports the value that can be set later.

I'm not sure I will get here. I meant a symmetric name

TUNSETVNETHASH and TUNVETVNETHASH.

>
> >
> >> +}
> >> +
> >> +static inline long tun_vnet_ioctl_sethash(struct tun_vnet_hash_contai=
ner __rcu **hashp,
> >> +                                         bool can_rss, void __user *a=
rgp)
> >
> > So again, can_rss seems to be tricky. Looking at its caller, it tires
> > to make eBPF and RSS mutually exclusive. I still don't understand why
> > we need this. Allow eBPF program to override some of the path seems to
> > be common practice.
> >
> > What's more, we didn't try (or even can't) to make automq and eBPF to
> > be mutually exclusive. So I still didn't see what we gain from this
> > and it complicates the codes and may lead to ambiguous uAPI/behaviour.
>
> automq and eBPF are mutually exclusive; automq is disabled when an eBPF
> steering program is set so I followed the example here.

I meant from the view of uAPI, the kernel doesn't or can't reject eBPF
while using automq.

>
> We don't even have an interface for eBPF to let it fall back to another
> alogirhtm.

It doesn't even need this, e.g XDP overrides the default receiving path.

> I could make it fall back to RSS if the eBPF steeering
> program is designed to fall back to automq when it returns e.g., -1. But
> such an interface is currently not defined and defining one is out of
> scope of this patch series.

Just to make sure we are on the same page, I meant we just need to
make the behaviour consistent: allow eBPF to override the behaviour of
both automq and rss.

>
> >
> >> +{
> >> +       struct tun_vnet_hash hash_buf;
> >> +       struct tun_vnet_hash_container *hash;
> >> +
> >> +       if (copy_from_user(&hash_buf, argp, sizeof(hash_buf)))
> >> +               return -EFAULT;
> >> +       argp =3D (struct tun_vnet_hash __user *)argp + 1;
> >> +
> >> +       if (hash_buf.flags & TUN_VNET_HASH_RSS) {
> >> +               struct tun_vnet_hash_rss rss;
> >> +               size_t indirection_table_size;
> >> +               size_t key_size;
> >> +               size_t size;
> >> +
> >> +               if (!can_rss)
> >> +                       return -EBUSY;
> >> +
> >> +               if (copy_from_user(&rss, argp, sizeof(rss)))
> >> +                       return -EFAULT;
> >> +               argp =3D (struct tun_vnet_hash_rss __user *)argp + 1;
> >> +
> >> +               indirection_table_size =3D ((size_t)rss.indirection_ta=
ble_mask + 1) * 2;
> >> +               key_size =3D virtio_net_hash_key_length(hash_buf.types=
);
> >> +               size =3D struct_size(hash, rss_indirection_table,
> >> +                                  (size_t)rss.indirection_table_mask =
+ 1);
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
> >> +               argp =3D (u16 __user *)argp + rss.indirection_table_ma=
sk + 1;
> >> +
> >> +               if (copy_from_user(hash->rss_key, argp, key_size)) {
> >> +                       kfree(hash);
> >> +                       return -EFAULT;
> >> +               }
> >> +
> >> +               virtio_net_toeplitz_convert_key(hash->rss_key, key_siz=
e);
> >> +               hash->rss =3D rss;
> >> +       } else {
> >> +               hash =3D kmalloc(sizeof(hash->common), GFP_KERNEL);
> >> +               if (!hash)
> >> +                       return -ENOMEM;
> >
> > Do we need to validate the hash here (at least against the types we sup=
ported?)
> >
> >> +       }
> >> +
> >> +       hash->common =3D hash_buf;
> >> +       kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(*hashp, hash));
> >
> > I still didn't understand the trick here. E.g we use very simple
> > primitives in synchronizing ebpf program through RCU in
> > __tun_set_ebpf().
>
> It is even simpler than __tun_set_ebpf(). The differences from
> __tun_set_ebpf() are:
> 1. This uses the rtnl lock instead of TUN-specific one. It makes the
> code simpler as the rtnl lock is already taken in __tun_chr_ioctl().

It can be tweaked to use rtnl as well.

> 2. This does not add rcu_head and uses blocking APIs for simplicity.

Right.

>
> >
> >> +       return 0;
> >> +}
> >> +
> >> +static void tun_vnet_hash_report(const struct tun_vnet_hash_container=
 *hash,
> >> +                                struct sk_buff *skb,
> >> +                                const struct flow_keys_basic *keys,
> >> +                                u32 value,
> >> +                                tun_vnet_hash_add vnet_hash_add)
> >> +{
> >> +       struct virtio_net_hash *report;
> >> +
> >> +       if (!hash || !(hash->common.flags & TUN_VNET_HASH_REPORT))
> >> +               return;
> >> +
> >> +       report =3D vnet_hash_add(skb);
> >> +       if (!report)
> >> +               return;
> >> +
> >> +       *report =3D (struct virtio_net_hash) {
> >> +               .report =3D virtio_net_hash_report(hash->common.types,=
 keys),
> >> +               .value =3D value
> >> +       };
> >
> > What's the advantage of using Designated Initializers here? Simple
> > assignment can save two lines of code.
>
> It automatically fills other fileds with zero. Simple assignments will
> need more tokens for zeroing.

Ok.

>
> >
> >> +}
> >> +
> >> +static u16 tun_vnet_rss_select_queue(u32 numqueues,
> >> +                                    const struct tun_vnet_hash_contai=
ner *hash,
> >> +                                    struct sk_buff *skb,
> >> +                                    tun_vnet_hash_add vnet_hash_add)
> >> +{
> >> +       struct virtio_net_hash *report;
> >> +       struct virtio_net_hash ret;
> >> +       u16 txq, index;
> >> +
> >> +       if (!numqueues)
> >> +               return 0;
> >> +
> >> +       virtio_net_hash_rss(skb, hash->common.types, hash->rss_key, &r=
et);
> >> +
> >> +       if (!ret.report)
> >> +               return hash->rss.unclassified_queue % numqueues;
> >> +
> >> +       if (hash->common.flags & TUN_VNET_HASH_REPORT) {
> >> +               report =3D vnet_hash_add(skb);
> >> +               if (report)
> >> +                       *report =3D ret;
> >> +       }
> >
> > Is there a chance that we can reach here without TUN_VNET_HASH_REPORT?
> > If yes, it should be a bug.
>
> It is possible to use RSS without TUN_VNET_HASH_REPORT.

Another call to separate the ioctls then.

> It is more of a
> feature instead of a bug; it behaves like QEMU's eBPF program but
> requires no privilege and is more optimized with native code and ffs().
>
> >
> >> +
> >> +       index =3D ret.value & hash->rss.indirection_table_mask;
> >> +       txq =3D READ_ONCE(hash->rss_indirection_table[index]);
> >
> > So vnet_hash is accessed via rcu_dereference(), I don't get any reason
> > we need READ_ONCE here, is this paired with something? If yes, let's
> > add a comment here. If rss_indirection_table need why
> > indirection_table_mask doesn't need this?
>
> I'll drop it. I think it's just a left-over of previous versions without
> RCU.
>
> >
> >> +
> >> +       return txq % numqueues;
> >> +}
> >> +
> >>   static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
> >>                                     struct iov_iter *from,
> >>                                     struct virtio_net_hdr *hdr)
> >> @@ -135,15 +262,17 @@ static inline int tun_vnet_hdr_get(int sz, unsig=
ned int flags,
> >>   }
> >>
> >>   static inline int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
> >> -                                  const struct virtio_net_hdr *hdr)
> >> +                                  const struct virtio_net_hdr_v1_hash=
 *hdr)
> >>   {
> >
> > To be more robust, we can tweak the function to accept a vnet_hdr_len
> > parameter then we can avoid touching this every time when we need to
> > extend vnet hdr in the future?
>
> I think you meant vnet_hdr_sz instead of vnet_hdr_len. It is already
> passed just as "sz" here as the function name already says it's about
> the header.
>
> It is possible to add another parameter for sizeof(*hdr) and convert the
> hdr parameter to void * to avoid future changes. But I rather keep it as
> is because the current form ensures the hdr is large enough and
> statically avoids buffer overrun.

Right.

>
> >
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
> >> @@ -155,26 +284,38 @@ static inline int tun_vnet_hdr_to_skb(unsigned i=
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
> >> diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
> >> index 553552fa635c3e1e53d1a63c203d32e4c4fd5a4f..7334c46a3f101675a0d4e5=
a036987cfe18842f9f 100644
> >> --- a/include/linux/if_tap.h
> >> +++ b/include/linux/if_tap.h
> >> @@ -31,6 +31,7 @@ static inline struct ptr_ring *tap_get_ptr_ring(stru=
ct file *f)
> >>   #define MAX_TAP_QUEUES 256
> >>
> >>   struct tap_queue;
> >> +struct tun_vnet_hash_container;
> >>
> >>   struct tap_dev {
> >>          struct net_device       *dev;
> >> @@ -43,6 +44,7 @@ struct tap_dev {
> >>          int                     numqueues;
> >>          netdev_features_t       tap_features;
> >>          int                     minor;
> >> +       struct tun_vnet_hash_container __rcu *vnet_hash;
> >>
> >>          void (*update_features)(struct tap_dev *tap, netdev_features_=
t features);
> >>          void (*count_tx_dropped)(struct tap_dev *tap);
> >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> >> index bb2b751d274acff931281a72e8b4b0c699b4e8af..cdd793f1c360ad5f63fcc4=
cbf67d845f5e2ccf6f 100644
> >> --- a/include/linux/skbuff.h
> >> +++ b/include/linux/skbuff.h
> >> @@ -4842,6 +4842,9 @@ enum skb_ext_id {
> >>   #endif
> >>   #if IS_ENABLED(CONFIG_MCTP_FLOWS)
> >>          SKB_EXT_MCTP,
> >> +#endif
> >> +#if IS_ENABLED(CONFIG_TUN)
> >> +       SKB_EXT_TUN_VNET_HASH,
> >>   #endif
> >>          SKB_EXT_NUM, /* must be last */
> >>   };
> >> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> >> index 287cdc81c9390c289a30545aa7ed23d81c3329d3..4887f97500a870c7ef3c96=
a5837b2d0a5a225040 100644
> >> --- a/include/uapi/linux/if_tun.h
> >> +++ b/include/uapi/linux/if_tun.h
> >> @@ -62,6 +62,42 @@
> >>   #define TUNSETCARRIER _IOW('T', 226, int)
> >>   #define TUNGETDEVNETNS _IO('T', 227)
> >>
> >> +/**
> >> + * define TUNGETVNETHASHCAP - ioctl to get virtio_net hashing capabil=
ity.
> >> + *
> >> + * The argument is a pointer to &struct tun_vnet_hash which will stor=
e the
> >> + * maximal virtio_net hashing configuration.
> >> + */
> >> +#define TUNGETVNETHASHCAP _IOR('T', 228, struct tun_vnet_hash)
> >> +
> >> +/**
> >> + * define TUNSETVNETHASH - ioctl to configure virtio_net hashing
> >> + *
> >> + * The argument is a pointer to &struct tun_vnet_hash.
> >> + *
> >> + * The argument is a pointer to the compound of the following in orde=
r if
> >> + * %TUN_VNET_HASH_RSS is set:
> >> + *
> >> + * 1. &struct tun_vnet_hash
> >> + * 2. &struct tun_vnet_hash_rss
> >> + * 3. Indirection table
> >> + * 4. Key
> >> + *
> >> + * The %TUN_VNET_HASH_REPORT flag set with this ioctl will be effecti=
ve only
> >> + * after calling the %TUNSETVNETHDRSZ ioctl with a number greater tha=
n or equal
> >> + * to the size of &struct virtio_net_hdr_v1_hash.
> >
> > So you had a dependency check already for vnet hdr len. I'd still
> > suggest to split this into rss and hash as they are separated
> > features. Then we can use separate data structure for them instead of
> > a container struct.
>
> I added a dependency check and found it is complicating the code and
> requires additional tests. I need a reason to justify the complexity if
> we are going to split it.

As we discussed above: They don't dedpend on each other.

>
> Regards,
> Akihiko Odaki
>
> >
> >> + *
> >> + * The members added to the legacy header by %TUN_VNET_HASH_REPORT fl=
ag will
> >> + * always be little-endian.
> >> + *
> >> + * This ioctl results in %EBADFD if the underlying device is deleted.=
 It affects
> >> + * all queues attached to the same device.
> >> + *
> >> + * This ioctl currently has no effect on XDP packets and packets with
> >> + * queue_mapping set by TC.
> >> + */
> >> +#define TUNSETVNETHASH _IOW('T', 229, struct tun_vnet_hash)
> >> +
> >>   /* TUNSETIFF ifr flags */
> >>   #define IFF_TUN                0x0001
> >>   #define IFF_TAP                0x0002
> >> @@ -115,4 +151,43 @@ struct tun_filter {
> >>          __u8   addr[][ETH_ALEN];
> >>   };
> >>
> >> +/**
> >> + * define TUN_VNET_HASH_REPORT - Request virtio_net hash reporting fo=
r vhost
> >> + */
> >> +#define TUN_VNET_HASH_REPORT   0x0001
> >> +
> >> +/**
> >> + * define TUN_VNET_HASH_RSS - Request virtio_net RSS
> >> + *
> >> + * This is mutually exclusive with eBPF steering program.
> >> + */
> >> +#define TUN_VNET_HASH_RSS      0x0002
> >> +
> >> +/**
> >> + * struct tun_vnet_hash - virtio_net hashing configuration
> >> + * @flags:
> >> + *             Bitmask consists of %TUN_VNET_HASH_REPORT and %TUN_VNE=
T_HASH_RSS
> >> + * @pad:
> >> + *             Should be filled with zero before passing to %TUNSETVN=
ETHASH
> >> + * @types:
> >> + *             Bitmask of allowed hash types
> >> + */
> >> +struct tun_vnet_hash {
> >> +       __u16 flags;
> >> +       __u8 pad[2];
> >> +       __u32 types;
> >> +};
> >
> > Padding in the middle of the structure is not elegant. Any reason for t=
his?
> >
> > And hash->types seems never used.
> >
> >> +
> >> +/**
> >> + * struct tun_vnet_hash_rss - virtio_net RSS configuration
> >> + * @indirection_table_mask:
> >> + *             Bitmask to be applied to the indirection table index
> >> + * @unclassified_queue:
> >> + *             The index of the queue to place unclassified packets i=
n
> >> + */
> >> +struct tun_vnet_hash_rss {
> >> +       __u16 indirection_table_mask;
> >> +       __u16 unclassified_queue;
> >> +};
> >> +
> >>   #endif /* _UAPI__IF_TUN_H */
> >> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >> index 7b03b64fdcb276f68ce881d1d8da8e4c6b897efc..aa2a091b649f0c9d6e0196=
f34f345ba78b5498fb 100644
> >> --- a/net/core/skbuff.c
> >> +++ b/net/core/skbuff.c
> >> @@ -64,6 +64,7 @@
> >>   #include <linux/mpls.h>
> >>   #include <linux/kcov.h>
> >>   #include <linux/iov_iter.h>
> >> +#include <linux/virtio_net.h>
> >>
> >>   #include <net/protocol.h>
> >>   #include <net/dst.h>
> >> @@ -4969,6 +4970,9 @@ static const u8 skb_ext_type_len[] =3D {
> >>   #if IS_ENABLED(CONFIG_MCTP_FLOWS)
> >>          [SKB_EXT_MCTP] =3D SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
> >>   #endif
> >> +#if IS_ENABLED(CONFIG_TUN)
> >> +       [SKB_EXT_TUN_VNET_HASH] =3D SKB_EXT_CHUNKSIZEOF(struct virtio_=
net_hash),
> >> +#endif
> >>   };
> >>
> >>   static __always_inline unsigned int skb_ext_total_length(void)
> >>
> >> --
> >> 2.48.1
> >>
> >
> > Thanks
> >
>


