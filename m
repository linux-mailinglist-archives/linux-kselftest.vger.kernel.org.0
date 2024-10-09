Return-Path: <linux-kselftest+bounces-19326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D8F99622B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 10:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24291F21589
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 08:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00C8188719;
	Wed,  9 Oct 2024 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEaqnX0V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDF616EB4C
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Oct 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461701; cv=none; b=aDtjN1ZgYpMcQwXMsBR8v6vBSv9YrOCXemky1I9EbKZ7QyX9MRds+NoZgZ4Z/zgn/nZnUVFV4Epj3Ilr2y7suosNtbHbSZxdxaMFcXZ4Irg+48F0A0D8XpOIsWAmi6X4UjojBATz/HjN5Hzcw0rAFbjFcniWoYCfD1BnvhTbqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461701; c=relaxed/simple;
	bh=dHmAdtyowOOqOuCiAn5XLz30uoc7uI7uEMltn6ut7+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUiV7ut294+g+dNbUZsb6cUgN6ChdSKu5y6I/UGYhXuHWDGsuWbeYrYWSUjusLVnuGhz0lVDBd9VPDtBzmSK55LITEcirIA/smoT+v3BFKHCSIxgLiIhsmSUcYi8qvw3WjLGThk3sUpA5jbIDDzdoqdNlnfhVbHk4I/hSLIWu/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aEaqnX0V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728461698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHbsa77UElIEBSMfz/c53qskt8LH36YYM6tWPiPc/MA=;
	b=aEaqnX0VOf4rjHYGsqjmedMV+D9ELUklES1+UsCiBJHwvKRnKMflSCHrbJC1WyJm5zoCtt
	yp/0bJ1x7/SeO9Y/YQ6rfs1Jm4rCCPue6SW9S92pNvEu8UkJpHh9Kp6vPW7dN7YwKqnX3X
	SaVo8XeB/k5zGyYOGujTZtDpRP/8JL0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-DRElMW0nP_mC2LV-svc_4g-1; Wed, 09 Oct 2024 04:14:55 -0400
X-MC-Unique: DRElMW0nP_mC2LV-svc_4g-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-207510f3242so84775915ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Oct 2024 01:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728461694; x=1729066494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHbsa77UElIEBSMfz/c53qskt8LH36YYM6tWPiPc/MA=;
        b=fSiN7ry73amYIslIVS3sghSTvmoolR3wD9OCkzPbqQSxlonVrAd5Ae9+/rrr6AijVU
         tQvmQ2qxs1y+Wucne2n8mf10viozMq/41fWRuqYoDmKHbzYLss3tliadH1frL6zUs943
         ziaNftzwaS2DqhdsVFzPnJsHvJLnhn+S3KPw8tVdbYMVOLRBFPQ068rH17Fvk063cdRy
         bZNQVbEyUi8Fq6pr2sMjb7rRbzEU7L7mhsE8rEqhSdrGtZAPGnnw2wipUvZmcEfo9sB7
         Q85IarQ+QKN/0N5hW3okV0kiBQ4T2ZQap8Or3v8oJWHzzjRpZqizIPgMFhUOTXPaHfMd
         VZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWOT1WdcWYGtTgztNQK1vHbJGW+C1pC0lhEUy+zHBv/BFvr22yeJOZXy/DXIqCvrxTQLxPS9BvK6SWEUB6xDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8k4asGrgRolEHqK2ztJhL/aZ3kWrXP+Vt4o2Rd8zOMVFXNvg0
	IGXk/sdqnAEfDl9Ux3FaZGH6PEBckh+yxKFeVXSjYg+lXCAAWRP8cNSWGUynEhTYqg4CabTHELG
	trJ3rR91RFhCdmstkOgdMLGqjqpLRm9cIfU8FgStGVkjrhx4y8q0rWRPxS75ucHLjxVLZjN1tJ3
	L+SLuVvVFY7XPxrCcEl6BHKLytvG3w4EFVpPuJpNlB
X-Received: by 2002:a17:902:cec7:b0:20b:4f95:9335 with SMTP id d9443c01a7336-20c637f77c8mr35370555ad.43.1728461694249;
        Wed, 09 Oct 2024 01:14:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4dyOPW8dtp5miOwuRsmOi+ob0tZdSiMbuYW2/dryq3WCfd9tVeV+A6uHmbXGgJTqFtXZewdRUsNINGh/+tEA=
X-Received: by 2002:a17:902:cec7:b0:20b:4f95:9335 with SMTP id
 d9443c01a7336-20c637f77c8mr35370135ad.43.1728461693618; Wed, 09 Oct 2024
 01:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com> <20241008-rss-v5-7-f3cf68df005d@daynix.com>
In-Reply-To: <20241008-rss-v5-7-f3cf68df005d@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 16:14:41 +0800
Message-ID: <CACGkMEsPNTr3zcstsQGoOiQdCFQ+6EG6cSGiZzNxONsH9Xm=Aw@mail.gmail.com>
Subject: Re: [PATCH RFC v5 07/10] tun: Introduce virtio-net RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:55=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
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
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/tap.c           | 11 +++++-
>  drivers/net/tun.c           | 57 ++++++++++++++++++++-------
>  drivers/net/tun_vnet.h      | 96 +++++++++++++++++++++++++++++++++++++++=
++----
>  include/linux/if_tap.h      |  4 +-
>  include/uapi/linux/if_tun.h | 27 +++++++++++++
>  5 files changed, 169 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 5e2fbe63ca47..a58b83285af4 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -207,6 +207,7 @@ static struct tap_queue *tap_get_queue(struct tap_dev=
 *tap,
>          * racing against queue removal.
>          */
>         int numvtaps =3D READ_ONCE(tap->numvtaps);
> +       struct tun_vnet_hash_container *vnet_hash =3D rcu_dereference(tap=
->vnet_hash);
>         __u32 rxq;
>
>         *tap_add_hash(skb) =3D (struct virtio_net_hash) { .report =3D VIR=
TIO_NET_HASH_REPORT_NONE };
> @@ -217,6 +218,12 @@ static struct tap_queue *tap_get_queue(struct tap_de=
v *tap,
>         if (numvtaps =3D=3D 1)
>                 goto single;
>
> +       if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH_RSS)) {
> +               rxq =3D tun_vnet_rss_select_queue(numvtaps, vnet_hash, sk=
b, tap_add_hash);
> +               queue =3D rcu_dereference(tap->taps[rxq]);
> +               goto out;
> +       }
> +
>         if (!skb->l4_hash && !skb->sw_hash) {
>                 struct flow_keys keys;
>
> @@ -234,7 +241,7 @@ static struct tap_queue *tap_get_queue(struct tap_dev=
 *tap,
>
>         /* Check if we can use flow to select a queue */
>         if (rxq) {
> -               tun_vnet_hash_report(&tap->vnet_hash, skb, &keys_basic, r=
xq, tap_add_hash);
> +               tun_vnet_hash_report(vnet_hash, skb, &keys_basic, rxq, ta=
p_add_hash);
>                 queue =3D rcu_dereference(tap->taps[rxq % numvtaps]);
>                 goto out;
>         }
> @@ -1058,7 +1065,7 @@ static long tap_ioctl(struct file *file, unsigned i=
nt cmd,
>                 tap =3D rtnl_dereference(q->tap);
>                 ret =3D tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags,
>                                      tap ? &tap->vnet_hash : NULL, -EINVA=
L,
> -                                    cmd, sp);
> +                                    true, cmd, sp);
>                 rtnl_unlock();
>                 return ret;
>         }
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 27308417b834..18528568aed7 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -209,7 +209,7 @@ struct tun_struct {
>         struct bpf_prog __rcu *xdp_prog;
>         struct tun_prog __rcu *steering_prog;
>         struct tun_prog __rcu *filter_prog;
> -       struct tun_vnet_hash vnet_hash;
> +       struct tun_vnet_hash_container __rcu *vnet_hash;
>         struct ethtool_link_ksettings link_ksettings;
>         /* init args */
>         struct file *file;
> @@ -468,7 +468,9 @@ static const struct virtio_net_hash *tun_find_hash(co=
nst struct sk_buff *skb)
>   * the userspace application move between processors, we may get a
>   * different rxq no. here.
>   */
> -static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buf=
f *skb)
> +static u16 tun_automq_select_queue(struct tun_struct *tun,
> +                                  const struct tun_vnet_hash_container *=
vnet_hash,
> +                                  struct sk_buff *skb)
>  {
>         struct flow_keys keys;
>         struct flow_keys_basic keys_basic;
> @@ -493,7 +495,7 @@ static u16 tun_automq_select_queue(struct tun_struct =
*tun, struct sk_buff *skb)
>                 .control =3D keys.control,
>                 .basic =3D keys.basic
>         };
> -       tun_vnet_hash_report(&tun->vnet_hash, skb, &keys_basic, skb->l4_h=
ash ? skb->hash : txq,
> +       tun_vnet_hash_report(vnet_hash, skb, &keys_basic, skb->l4_hash ? =
skb->hash : txq,
>                              tun_add_hash);
>
>         return txq;
> @@ -523,10 +525,17 @@ static u16 tun_select_queue(struct net_device *dev,=
 struct sk_buff *skb,
>         u16 ret;
>
>         rcu_read_lock();
> -       if (rcu_dereference(tun->steering_prog))
> +       if (rcu_dereference(tun->steering_prog)) {
>                 ret =3D tun_ebpf_select_queue(tun, skb);
> -       else
> -               ret =3D tun_automq_select_queue(tun, skb);
> +       } else {
> +               struct tun_vnet_hash_container *vnet_hash =3D rcu_derefer=
ence(tun->vnet_hash);
> +
> +               if (vnet_hash && (vnet_hash->common.flags & TUN_VNET_HASH=
_RSS))
> +                       ret =3D tun_vnet_rss_select_queue(READ_ONCE(tun->=
numqueues), vnet_hash,
> +                                                       skb, tun_add_hash=
);
> +               else
> +                       ret =3D tun_automq_select_queue(tun, vnet_hash, s=
kb);
> +       }
>         rcu_read_unlock();
>
>         return ret;
> @@ -2248,6 +2257,9 @@ static void tun_free_netdev(struct net_device *dev)
>         security_tun_dev_free_security(tun->security);
>         __tun_set_ebpf(tun, &tun->steering_prog, NULL);
>         __tun_set_ebpf(tun, &tun->filter_prog, NULL);
> +       rtnl_lock();
> +       kfree_rcu_mightsleep(rtnl_dereference(tun->vnet_hash));
> +       rtnl_unlock();
>  }
>
>  static void tun_setup(struct net_device *dev)
> @@ -2946,13 +2958,9 @@ static int tun_set_queue(struct file *file, struct=
 ifreq *ifr)
>  }
>
>  static int tun_set_ebpf(struct tun_struct *tun, struct tun_prog __rcu **=
prog_p,
> -                       void __user *data)
> +                       int fd)
>  {
>         struct bpf_prog *prog;
> -       int fd;
> -
> -       if (copy_from_user(&fd, data, sizeof(fd)))
> -               return -EFAULT;
>
>         if (fd =3D=3D -1) {
>                 prog =3D NULL;
> @@ -3019,6 +3027,7 @@ static long __tun_chr_ioctl(struct file *file, unsi=
gned int cmd,
>         int sndbuf;
>         int ret;
>         bool do_notify =3D false;
> +       struct tun_vnet_hash_container *vnet_hash;
>
>         if (cmd =3D=3D TUNSETIFF || cmd =3D=3D TUNSETQUEUE ||
>             (_IOC_TYPE(cmd) =3D=3D SOCK_IOC_TYPE && cmd !=3D SIOCGSKNS)) =
{
> @@ -3078,7 +3087,7 @@ static long __tun_chr_ioctl(struct file *file, unsi=
gned int cmd,
>         }
>
>         if (!tun) {
> -               ret =3D tun_vnet_ioctl(NULL, NULL, NULL, -EBADFD, cmd, ar=
gp);
> +               ret =3D tun_vnet_ioctl(NULL, NULL, NULL, -EBADFD, true, c=
md, argp);
>                 goto unlock;
>         }
>
> @@ -3256,11 +3265,27 @@ static long __tun_chr_ioctl(struct file *file, un=
signed int cmd,
>                 break;
>
>         case TUNSETSTEERINGEBPF:
> -               ret =3D tun_set_ebpf(tun, &tun->steering_prog, argp);
> +               if (get_user(ret, (int __user *)argp)) {
> +                       ret =3D -EFAULT;
> +                       break;
> +               }
> +
> +               vnet_hash =3D rtnl_dereference(tun->vnet_hash);
> +               if (ret !=3D -1 && vnet_hash && (vnet_hash->common.flags =
& TUN_VNET_HASH_RSS)) {
> +                       ret =3D -EBUSY;
> +                       break;
> +               }
> +
> +               ret =3D tun_set_ebpf(tun, &tun->steering_prog, ret);
>                 break;
>
>         case TUNSETFILTEREBPF:
> -               ret =3D tun_set_ebpf(tun, &tun->filter_prog, argp);
> +               if (get_user(ret, (int __user *)argp)) {
> +                       ret =3D -EFAULT;
> +                       break;
> +               }
> +
> +               ret =3D tun_set_ebpf(tun, &tun->filter_prog, ret);
>                 break;
>
>         case TUNSETCARRIER:
> @@ -3280,7 +3305,9 @@ static long __tun_chr_ioctl(struct file *file, unsi=
gned int cmd,
>
>         default:
>                 ret =3D tun_vnet_ioctl(&tun->vnet_hdr_sz, &tun->flags,
> -                                    &tun->vnet_hash, -EINVAL, cmd, argp)=
;
> +                                    &tun->vnet_hash, -EINVAL,
> +                                    !rtnl_dereference(tun->steering_prog=
),
> +                                    cmd, argp);
>         }
>
>         if (do_notify)
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 589a97dd7d02..f5de4fe9d14e 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -9,6 +9,13 @@
>  typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_buff *);
>  typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const struct=
 sk_buff *);
>
> +struct tun_vnet_hash_container {
> +       struct tun_vnet_hash common;
> +       struct tun_vnet_hash_rss rss;
> +       u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +       u16 rss_indirection_table[];
> +};
> +
>  static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
>  {
>         return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) && (flags & TUN_VNE=
T_BE)) &&
> @@ -62,14 +69,16 @@ static inline __virtio16 cpu_to_tun_vnet16(unsigned i=
nt flags, u16 val)
>  }
>
>  static inline long tun_vnet_ioctl(int *sz, unsigned int *flags,
> -                                 struct tun_vnet_hash *hash, long fallba=
ck,
> +                                 struct tun_vnet_hash_container __rcu **=
hashp,
> +                                 long fallback, bool can_rss,
>                                   unsigned int cmd, void __user *argp)
>  {
>         static const struct tun_vnet_hash cap =3D {
> -               .flags =3D TUN_VNET_HASH_REPORT,
> +               .flags =3D TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
>                 .types =3D VIRTIO_NET_SUPPORTED_HASH_TYPES
>         };
>         struct tun_vnet_hash hash_buf;
> +       struct tun_vnet_hash_container *hash;
>         int __user *sp =3D argp;
>         int s;
>
> @@ -132,13 +141,57 @@ static inline long tun_vnet_ioctl(int *sz, unsigned=
 int *flags,
>                 return copy_to_user(argp, &cap, sizeof(cap)) ? -EFAULT : =
0;
>
>         case TUNSETVNETHASH:
> -               if (!hash)
> +               if (!hashp)
>                         return -EBADFD;
>
>                 if (copy_from_user(&hash_buf, argp, sizeof(hash_buf)))
>                         return -EFAULT;
> +               argp =3D (struct tun_vnet_hash __user *)argp + 1;
> +
> +               if (hash_buf.flags & TUN_VNET_HASH_RSS) {
> +                       struct tun_vnet_hash_rss rss;
> +                       size_t indirection_table_size;
> +                       size_t key_size;
> +                       size_t size;
> +
> +                       if (!can_rss)
> +                               return -EBUSY;
> +
> +                       if (copy_from_user(&rss, argp, sizeof(rss)))

This seems to be a change of the uAPI of TUNSETVNETHASH.

> +                               return -EFAULT;
> +                       argp =3D (struct tun_vnet_hash_rss __user *)argp =
+ 1;
> +
> +                       indirection_table_size =3D ((size_t)rss.indirecti=
on_table_mask + 1) * 2;
> +                       key_size =3D virtio_net_hash_key_length(hash_buf.=
types);
> +                       size =3D struct_size(hash, rss_indirection_table,
> +                                          (size_t)rss.indirection_table_=
mask + 1);
> +
> +                       hash =3D kmalloc(size, GFP_KERNEL);
> +                       if (!hash)
> +                               return -ENOMEM;
> +
> +                       if (copy_from_user(hash->rss_indirection_table,
> +                                          argp, indirection_table_size))=
 {
> +                               kfree(hash);
> +                               return -EFAULT;
> +                       }
> +                       argp =3D (u16 __user *)argp + rss.indirection_tab=
le_mask + 1;
> +
> +                       if (copy_from_user(hash->rss_key, argp, key_size)=
) {
> +                               kfree(hash);
> +                               return -EFAULT;
> +                       }
> +
> +                       virtio_net_toeplitz_convert_key(hash->rss_key, ke=
y_size);
> +                       hash->rss =3D rss;
> +               } else {
> +                       hash =3D kmalloc(sizeof(hash->common), GFP_KERNEL=
);
> +                       if (!hash)
> +                               return -ENOMEM;
> +               }
>
> -               *hash =3D hash_buf;
> +               hash->common =3D hash_buf;
> +               kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(*hashp, has=
h));
>                 return 0;
>
>         default:
> @@ -146,7 +199,7 @@ static inline long tun_vnet_ioctl(int *sz, unsigned i=
nt *flags,
>         }
>  }
>
> -static inline void tun_vnet_hash_report(const struct tun_vnet_hash *hash=
,
> +static inline void tun_vnet_hash_report(const struct tun_vnet_hash_conta=
iner *hash,
>                                         struct sk_buff *skb,
>                                         const struct flow_keys_basic *key=
s,
>                                         u32 value,
> @@ -154,7 +207,7 @@ static inline void tun_vnet_hash_report(const struct =
tun_vnet_hash *hash,
>  {
>         struct virtio_net_hash *report;
>
> -       if (!(hash->flags & TUN_VNET_HASH_REPORT))
> +       if (!hash || !(hash->common.flags & TUN_VNET_HASH_REPORT))
>                 return;
>
>         report =3D vnet_hash_add(skb);
> @@ -162,11 +215,40 @@ static inline void tun_vnet_hash_report(const struc=
t tun_vnet_hash *hash,
>                 return;
>
>         *report =3D (struct virtio_net_hash) {
> -               .report =3D virtio_net_hash_report(hash->types, keys),
> +               .report =3D virtio_net_hash_report(hash->common.types, ke=
ys),
>                 .value =3D value
>         };
>  }
>
> +static inline u16 tun_vnet_rss_select_queue(u32 numqueues,
> +                                           const struct tun_vnet_hash_co=
ntainer *hash,
> +                                           struct sk_buff *skb,
> +                                           tun_vnet_hash_add vnet_hash_a=
dd)
> +{
> +       struct virtio_net_hash *report;
> +       struct virtio_net_hash ret;
> +       u16 txq, index;
> +
> +       if (!numqueues)
> +               return 0;
> +
> +       virtio_net_hash_rss(skb, hash->common.types, hash->rss_key, &ret)=
;
> +
> +       if (!ret.report)
> +               return hash->rss.unclassified_queue % numqueues;
> +
> +       if (hash->common.flags & TUN_VNET_HASH_REPORT) {
> +               report =3D vnet_hash_add(skb);
> +               if (report)
> +                       *report =3D ret;
> +       }
> +
> +       index =3D ret.value & hash->rss.indirection_table_mask;
> +       txq =3D READ_ONCE(hash->rss_indirection_table[index]);
> +
> +       return txq % numqueues;
> +}
> +
>  static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
>                                    struct iov_iter *from,
>                                    struct virtio_net_hdr *hdr)
> diff --git a/include/linux/if_tap.h b/include/linux/if_tap.h
> index 5bbb343a6dba..7334c46a3f10 100644
> --- a/include/linux/if_tap.h
> +++ b/include/linux/if_tap.h
> @@ -4,7 +4,6 @@
>
>  #include <net/sock.h>
>  #include <linux/skb_array.h>
> -#include <uapi/linux/if_tun.h>
>
>  struct file;
>  struct socket;
> @@ -32,6 +31,7 @@ static inline struct ptr_ring *tap_get_ptr_ring(struct =
file *f)
>  #define MAX_TAP_QUEUES 256
>
>  struct tap_queue;
> +struct tun_vnet_hash_container;
>
>  struct tap_dev {
>         struct net_device       *dev;
> @@ -44,7 +44,7 @@ struct tap_dev {
>         int                     numqueues;
>         netdev_features_t       tap_features;
>         int                     minor;
> -       struct tun_vnet_hash    vnet_hash;
> +       struct tun_vnet_hash_container __rcu *vnet_hash;
>
>         void (*update_features)(struct tap_dev *tap, netdev_features_t fe=
atures);
>         void (*count_tx_dropped)(struct tap_dev *tap);
> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> index d11e79b4e0dc..4887f97500a8 100644
> --- a/include/uapi/linux/if_tun.h
> +++ b/include/uapi/linux/if_tun.h
> @@ -75,6 +75,14 @@
>   *
>   * The argument is a pointer to &struct tun_vnet_hash.
>   *
> + * The argument is a pointer to the compound of the following in order i=
f
> + * %TUN_VNET_HASH_RSS is set:
> + *
> + * 1. &struct tun_vnet_hash
> + * 2. &struct tun_vnet_hash_rss
> + * 3. Indirection table
> + * 4. Key
> + *

Let's try not modify uAPI. We can introduce new ioctl if necessary.

>   * The %TUN_VNET_HASH_REPORT flag set with this ioctl will be effective =
only
>   * after calling the %TUNSETVNETHDRSZ ioctl with a number greater than o=
r equal
>   * to the size of &struct virtio_net_hdr_v1_hash.
> @@ -148,6 +156,13 @@ struct tun_filter {
>   */
>  #define TUN_VNET_HASH_REPORT   0x0001
>
> +/**
> + * define TUN_VNET_HASH_RSS - Request virtio_net RSS
> + *
> + * This is mutually exclusive with eBPF steering program.
> + */
> +#define TUN_VNET_HASH_RSS      0x0002
> +
>  /**
>   * struct tun_vnet_hash - virtio_net hashing configuration
>   * @flags:
> @@ -163,4 +178,16 @@ struct tun_vnet_hash {
>         __u32 types;
>  };
>
> +/**
> + * struct tun_vnet_hash_rss - virtio_net RSS configuration
> + * @indirection_table_mask:
> + *             Bitmask to be applied to the indirection table index
> + * @unclassified_queue:
> + *             The index of the queue to place unclassified packets in
> + */
> +struct tun_vnet_hash_rss {
> +       __u16 indirection_table_mask;
> +       __u16 unclassified_queue;
> +};
> +
>  #endif /* _UAPI__IF_TUN_H */
>
> --
> 2.46.2
>

Thanks


