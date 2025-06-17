Return-Path: <linux-kselftest+bounces-35162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAEFADBFF0
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 05:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36F117170D
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 03:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504DA1F3BA9;
	Tue, 17 Jun 2025 03:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epXBYWGd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EECD28399
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750131573; cv=none; b=dLQx3sXfWnxKm6qLvhA1RX4FWEKqMKdwxpPz3cESmG5QA6PFs6lKlo0NFoDjR8smtk9O0mk8wXIng5gRaF70Upv7Bu0xg6Or3aEN1tqGqDcmlld5o05zv0eGfxrJmJ1c4j7V115vJFMbkzxy/xHZ1Ks+UjsSvAhoBaqgSCmFl4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750131573; c=relaxed/simple;
	bh=HlxFQf/9ma4wvcN8/n5wocEkw3VvVzRk1jpgKD/QT3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pwh3tr2sJc1IIdsS/YbLG7imRKyZaK1VsXNGox28pk+S3ZjvvsCTdhCcO9lXjWwKw+jJGv2RQ1cfUEVFp+OuF4BHDBUGMRJVpibgaEDCcC1/AG8ch3sZm5bCDUOpAw8DvauBEkTZdYKMo+FQ42BOYNBvu/fh+T5QaNk9bJp345c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epXBYWGd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750131569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwuYDGTNCkR7tt8IP0zKlMBhxBNdnD8KQUc8BhMqxX0=;
	b=epXBYWGdw3HnyZ1r9+NFsnv6VOx9A6iGuR5I46B8BRYl1y66YW0q1MePqxULA/OpcvIHtm
	/2dQzfT+RhbwUHA7EW0vt9dXFlykF/5/nzWGWhrr99mFdstZ1r5IWG1ItfG/xtbgXyhDXp
	EanqKV3Q5uHmoXt0S/mtDg2qmu+SjJo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-jnBMacaZNcir2XjkHgiSog-1; Mon, 16 Jun 2025 23:39:27 -0400
X-MC-Unique: jnBMacaZNcir2XjkHgiSog-1
X-Mimecast-MFC-AGG-ID: jnBMacaZNcir2XjkHgiSog_1750131567
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3132e7266d3so5408180a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 20:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750131567; x=1750736367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwuYDGTNCkR7tt8IP0zKlMBhxBNdnD8KQUc8BhMqxX0=;
        b=uEW1yy7Qz+89mlT7Wc58FBAHWWMCBciq6lrzemsWlQ03Tf6wIU5PGrZ8Jp60/ljysG
         bXif+D95WYGc8fAPvDNb+mS3KbOPo13UGdTLS8JGnS4OAajVppWf9iEB1nczfou8Xm8B
         L41wylh2p8ZXzE1/69biV5TuWErkntrtoZtH12Sg23d2P9eXEk6HUAWANOx2JES9qkSp
         dj8R6IA3Kz6XJixq4S7VxSjolSmNylZMaB+VXRhBpCvTze8yWwqyHIH7pej27ibNeSBh
         y+q0kyWMaXWPv1NedCGKbZQaxABHvxa1JJLW3K5WTPn5vfFBfw5ghJyu8hQ10CBJolOl
         klCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWdC0Hz/D8MgcyWGBCtiLplZJE852sx0pP3UuoqLUs0Jc6EFF0JBwOdTge5yMuzt7izZtf4lz8EWhwo+vZvsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXB/ZTjjHH/3w54WdxNSHJs5RMPUJtjq2rH6Ny8NCU9NS5us1L
	AkSeAbuQpN9CAmny0nRr0dFfuM7SjaxlHwythY5OJc2Qalps/0wLIeo0QC0dBDDlq107+taF6ao
	pwAhHp0HBSUaUKveGW1JdVb8yhedGbZUgRYkhZLlGcjXz5HDA7Zt/KMzOhMu2i+BlJPS7UzUrtD
	4XJDrLExNHcj2zZjIUCivy5b82x7QGmC8Hz/tAtxKye24/
X-Gm-Gg: ASbGncuchyuZqKwTaxz2Z8pz2TFiK4yFIDhQHYoV4oAWwDqKPeW3BTGVF0q+9Lzl1yb
	A1gYosoAjvC2kOF3JrQchixaXAnHh1l9770Hau/ga5Wzm/3pYepF9jCn1bKkcAd2Zgw2Ufv60AO
	l3uulo
X-Received: by 2002:a17:90b:3d88:b0:311:ea13:2e63 with SMTP id 98e67ed59e1d1-313f1ca12e2mr18547407a91.13.1750131566165;
        Mon, 16 Jun 2025 20:39:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr7GqK1l4yhcPacWxjan2QXVIiJBa05XuYBC1Ekj2xybrwG/9WSWJl6e8Ue2EckmwFS61aRMlVPdO4e+Z1se0=
X-Received: by 2002:a17:90b:3d88:b0:311:ea13:2e63 with SMTP id
 98e67ed59e1d1-313f1ca12e2mr18547349a91.13.1750131565432; Mon, 16 Jun 2025
 20:39:25 -0700 (PDT)
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
 <48ae8ca2-d5e9-446c-b845-0df31f385ff6@daynix.com>
In-Reply-To: <48ae8ca2-d5e9-446c-b845-0df31f385ff6@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Jun 2025 11:39:14 +0800
X-Gm-Features: AX0GCFsNzUOkH1HcEWrRRmY-Z-iGrLxlmwaQ7SxHClbQf3779r0CPTLVf-zSq14
Message-ID: <CACGkMEtXYCfPO9Zgyooz=wLBv4C_JBVWcoy0JcJpXR7pk8-=bw@mail.gmail.com>
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

On Fri, Jun 6, 2025 at 5:27=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2025/06/06 10:01, Jason Wang wrote:
> > On Thu, Jun 5, 2025 at 4:18=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> On 2025/06/05 11:46, Jason Wang wrote:
> >>> On Wed, Jun 4, 2025 at 4:42=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> On 2025/06/04 10:53, Jason Wang wrote:
> >>>>> On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.oda=
ki@daynix.com> wrote:
> >>>>>>
> >>>>>> Add common code required for the features being added to TUN and T=
AP.
> >>>>>> They will be enabled for each of them in following patches.
> >>>>>>
> >>>>>> Added Features
> >>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>
> >>>>>> Hash reporting
> >>>>>> --------------
> >>>>>>
> >>>>>> Allow the guest to reuse the hash value to make receive steering
> >>>>>> consistent between the host and guest, and to save hash computatio=
n.
> >>>>>>
> >>>>>> Receive Side Scaling (RSS)
> >>>>>> --------------------------
> >>>>>>
> >>>>>> RSS is a receive steering algorithm that can be negotiated to use =
with
> >>>>>> virtio_net. Conventionally the hash calculation was done by the VM=
M.
> >>>>>> However, computing the hash after the queue was chosen defeats the
> >>>>>> purpose of RSS.
> >>>>>>
> >>>>>> Another approach is to use eBPF steering program. This approach ha=
s
> >>>>>> another downside: it cannot report the calculated hash due to the
> >>>>>> restrictive nature of eBPF steering program.
> >>>>>>
> >>>>>> Introduce the code to perform RSS to the kernel in order to overco=
me
> >>>>>> thse challenges. An alternative solution is to extend the eBPF ste=
ering
> >>>>>> program so that it will be able to report to the userspace, but I =
didn't
> >>>>>> opt for it because extending the current mechanism of eBPF steerin=
g
> >>>>>> program as is because it relies on legacy context rewriting, and
> >>>>>> introducing kfunc-based eBPF will result in non-UAPI dependency wh=
ile
> >>>>>> the other relevant virtualization APIs such as KVM and vhost_net a=
re
> >>>>>> UAPIs.
> >>>>>>
> >>>>>> Added ioctls
> >>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>
> >>>>>> They are designed to make extensibility and VM migration compatibl=
e.
> >>>>>> This change only adds the implementation and does not expose them =
to
> >>>>>> the userspace.
> >>>>>>
> >>>>>> TUNGETVNETHASHTYPES
> >>>>>> -------------------
> >>>>>>
> >>>>>> This ioctl tells supported hash types. It is useful to check if a =
VM can
> >>>>>> be migrated to the current host.
> >>>>>>
> >>>>>> TUNSETVNETREPORTINGAUTOMQ, TUNSETVNETREPORTINGRSS, and TUNSETVNETR=
SS
> >>>>>> ------------------------------------------------------------------=
--
> >>>>>>
> >>>>>> These ioctls configures a steering algorithm and, if needed, hash
> >>>>>> reporting.
> >>>>>>
> >>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>>>> ---
> >>>>>>     drivers/net/tap.c           |  10 ++-
> >>>>>>     drivers/net/tun.c           |  12 +++-
> >>>>>>     drivers/net/tun_vnet.h      | 165 ++++++++++++++++++++++++++++=
+++++++++++++---
> >>>>>>     include/uapi/linux/if_tun.h |  71 +++++++++++++++++++
> >>>>>>     4 files changed, 244 insertions(+), 14 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>>>> index d4ece538f1b2..25c60ff2d3f2 100644
> >>>>>> --- a/drivers/net/tap.c
> >>>>>> +++ b/drivers/net/tap.c
> >>>>>> @@ -179,6 +179,11 @@ static void tap_put_queue(struct tap_queue *q=
)
> >>>>>>            sock_put(&q->sk);
> >>>>>>     }
> >>>>>>
> >>>>>> +static const struct virtio_net_hash *tap_find_hash(const struct s=
k_buff *skb)
> >>>>>> +{
> >>>>>> +       return NULL;
> >>>>>> +}
> >>>>>> +
> >>>>>>     /*
> >>>>>>      * Select a queue based on the rxq of the device on which this=
 packet
> >>>>>>      * arrived. If the incoming device is not mq, calculate a flow=
 hash
> >>>>>> @@ -711,11 +716,12 @@ static ssize_t tap_put_user(struct tap_queue=
 *q,
> >>>>>>            int total;
> >>>>>>
> >>>>>>            if (q->flags & IFF_VNET_HDR) {
> >>>>>> -               struct virtio_net_hdr vnet_hdr;
> >>>>>> +               struct virtio_net_hdr_v1_hash vnet_hdr;
> >>>>>>
> >>>>>>                    vnet_hdr_len =3D READ_ONCE(q->vnet_hdr_sz);
> >>>>>>
> >>>>>> -               ret =3D tun_vnet_hdr_from_skb(q->flags, NULL, skb,=
 &vnet_hdr);
> >>>>>> +               ret =3D tun_vnet_hdr_from_skb(vnet_hdr_len, q->fla=
gs, NULL, skb,
> >>>>>> +                                           tap_find_hash, &vnet_h=
dr);
> >>>>>>                    if (ret)
> >>>>>>                            return ret;
> >>>>>>
> >>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>>> index 9133ab9ed3f5..03d47799e9bd 100644
> >>>>>> --- a/drivers/net/tun.c
> >>>>>> +++ b/drivers/net/tun.c
> >>>>>> @@ -451,6 +451,11 @@ static inline void tun_flow_save_rps_rxhash(s=
truct tun_flow_entry *e, u32 hash)
> >>>>>>                    e->rps_rxhash =3D hash;
> >>>>>>     }
> >>>>>>
> >>>>>> +static const struct virtio_net_hash *tun_find_hash(const struct s=
k_buff *skb)
> >>>>>> +{
> >>>>>> +       return NULL;
> >>>>>> +}
> >>>>>> +
> >>>>>>     /* We try to identify a flow through its rxhash. The reason th=
at
> >>>>>>      * we do not check rxq no. is because some cards(e.g 82599), c=
hooses
> >>>>>>      * the rxq based on the txq where the last packet of the flow =
comes. As
> >>>>>> @@ -1993,7 +1998,7 @@ static ssize_t tun_put_user_xdp(struct tun_s=
truct *tun,
> >>>>>>            ssize_t ret;
> >>>>>>
> >>>>>>            if (tun->flags & IFF_VNET_HDR) {
> >>>>>> -               struct virtio_net_hdr gso =3D { 0 };
> >>>>>> +               struct virtio_net_hdr_v1_hash gso =3D { 0 };
> >>>>>>
> >>>>>>                    vnet_hdr_sz =3D READ_ONCE(tun->vnet_hdr_sz);
> >>>>>>                    ret =3D tun_vnet_hdr_put(vnet_hdr_sz, iter, &gs=
o);
> >>>>>> @@ -2046,9 +2051,10 @@ static ssize_t tun_put_user(struct tun_stru=
ct *tun,
> >>>>>>            }
> >>>>>>
> >>>>>>            if (vnet_hdr_sz) {
> >>>>>> -               struct virtio_net_hdr gso;
> >>>>>> +               struct virtio_net_hdr_v1_hash gso;
> >>>>>>
> >>>>>> -               ret =3D tun_vnet_hdr_from_skb(tun->flags, tun->dev=
, skb, &gso);
> >>>>>> +               ret =3D tun_vnet_hdr_from_skb(vnet_hdr_sz, tun->fl=
ags, tun->dev,
> >>>>>> +                                           skb, tun_find_hash, &g=
so);
> >>>>>>                    if (ret)
> >>>>>>                            return ret;
> >>>>>>
> >>>>>> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> >>>>>> index 58b9ac7a5fc4..45d0533efc8d 100644
> >>>>>> --- a/drivers/net/tun_vnet.h
> >>>>>> +++ b/drivers/net/tun_vnet.h
> >>>>>> @@ -6,6 +6,17 @@
> >>>>>>     #define TUN_VNET_LE     0x80000000
> >>>>>>     #define TUN_VNET_BE     0x40000000
> >>>>>>
> >>>>>> +typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_bu=
ff *);
> >>>>>> +typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const=
 struct sk_buff *);
> >>>>>> +
> >>>>>> +struct tun_vnet_hash {
> >>>>>> +       bool report;
> >>>>>> +       bool rss;
> >>>>>> +       struct tun_vnet_rss common;
> >>>>>> +       u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >>>>>> +       u16 rss_indirection_table[];
> >>>>>> +};
> >>>>>> +
> >>>>>>     static inline bool tun_vnet_legacy_is_little_endian(unsigned i=
nt flags)
> >>>>>>     {
> >>>>>>            bool be =3D IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> >>>>>> @@ -107,6 +118,128 @@ static inline long tun_vnet_ioctl(int *vnet_=
hdr_sz, unsigned int *flags,
> >>>>>>            }
> >>>>>>     }
> >>>>>>
> >>>>>> +static inline long tun_vnet_ioctl_gethashtypes(u32 __user *argp)
> >>>>>> +{
> >>>>>> +       return put_user(VIRTIO_NET_SUPPORTED_HASH_TYPES, argp) ? -=
EFAULT : 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static inline long tun_vnet_ioctl_sethash(struct tun_vnet_hash __=
rcu **hashp,
> >>>>>> +                                         unsigned int cmd,
> >>>>>> +                                         void __user *argp)
> >>>>>> +{
> >>>>>> +       struct tun_vnet_rss common;
> >>>>>> +       struct tun_vnet_hash *hash;
> >>>>>> +       size_t indirection_table_size;
> >>>>>> +       size_t key_size;
> >>>>>> +       size_t size;
> >>>>>> +
> >>>>>> +       switch (cmd) {
> >>>>>> +       case TUNSETVNETREPORTINGAUTOMQ:
> >>>>>> +               if (get_user(common.hash_types, (u32 __user *)argp=
))
> >>>>>> +                       return -EFAULT;
> >>>>>> +
> >>>>>> +               if (common.hash_types) {
> >>>>>> +                       hash =3D kzalloc(sizeof(*hash), GFP_KERNEL=
);
> >>>>>> +                       if (!hash)
> >>>>>> +                               return -ENOMEM;
> >>>>>> +
> >>>>>> +                       hash->report =3D true;
> >>>>>> +                       hash->common.hash_types =3D common.hash_ty=
pes;
> >>>>>> +               } else {
> >>>>>> +                       hash =3D NULL;
> >>>>>> +               }
> >>>>>> +               break;
> >>>>>> +
> >>>>>> +       case TUNSETVNETREPORTINGRSS:
> >>>>>> +       case TUNSETVNETRSS:
> >>>>>
> >>>>> So the above three shows unnecessary design redundancy as well as a
> >>>>> burden for the future extension.  Why not simply have
> >>>>>
> >>>>> 1) TUNSETVNET_RSS
> >>>>> 2) TUNSETVNET_HASH_REPORT
> >>>>> ?
> >>>>>
> >>>>> Which maps to
> >>>>>
> >>>>>     #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1 (for configura=
ble
> >>>>> receive steering)
> >>>>>     #define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2 (for configura=
ble
> >>>>> hash calculation)
> >>>>>
> >>>>> It would be always easier to start with what spec had or at least w=
e
> >>>>> need to explain why we choose a different design here or in the
> >>>>> changelog to ease our life.
> >>>>
> >>>> TUNSETVNETREPORTINGAUTOMQ maps to VIRTIO_NET_CTRL_MQ_HASH_CONFIG.
> >>>
> >>> It's not:
> >>>
> >>> VIRTIO_NET_CTRL_MQ_HASH_CONFIG uses:
> >>>
> >>> struct virtio_net_hash_config {
> >>>       le32 hash_types;
> >>>       le16 reserved[4];
> >>>       u8 hash_key_length;
> >>>       u8 hash_key_data[hash_key_length];
> >>> };
> >>>
> >>> but TUNSETVNETREPORTINGAUTOMQ only accepts hash_types without others:
> >>
> >> The others are not present because the spec doesn't specify what to do
> >> with them and the kernel doesn't use them either.
> >
> > Did you mean the hash_key_length and hash_key_data? Note that we have
> > drivers other than the Linux ones as well.
>
> And reserved. Drivers can set whatever to these fields. It is not
> specified how these fields should be used.
>
> >
> >>
> >>>
> >>>>
> >>>> TUNSETVNETREPORTINGRSS and TUNSETVNETRSS map to
> >>>> VIRTIO_NET_CTRL_MQ_RSS_CONFIG.
> >>>
> >>> I think we've already had a discussion about this.
> >>>
> >>> Reusing virtio-net uAPI is much better instead of having a tun
> >>> specific one considering tun may need to support more virtio commands
> >>> in the future. Or maybe it's the time to introduce a transport for th=
e
> >>> virtio control virtqueue uAPI in tuntap to avoid inventing new uAPI
> >>> endlessly.
> >>>
> >>> What's more I see:
> >>>
> >>> struct tun_vnet_rss {
> >>>           __u32 hash_types;
> >>>           __u16 indirection_table_mask;
> >>>           __u16 unclassified_queue;
> >>> };
> >>>
> >>> struct tun_vnet_hash {
> >>>           bool report;
> >>>           bool rss;
> >>>           struct tun_vnet_rss common;
> >>>           u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >>>           u16 rss_indirection_table[];
> >>> };
> >>>
> >>> As I pointed out in the past, let's just decouple the rss from hash,
> >>> everything would be much simpler, or you need to explain why you
> >>> couple this somewhere.
> >>>
> >>> For example:
> >>>
> >>> 1) why is the tun_vnet_hash not part of the uAPI but tun_vnet_rss, or
> >>> how could userspace know what kind of format it would use for
> >>> TUNSETVNETREPORTINGRSS?
> >>
> >> That was the previous version.
> >>
> >>> 2) what's the advantages of embedding rss specific stuff into hash
> >>> report structure
> >>
> >> Because the hash types field in struct tun_vnet_rss is used by hash
> >> reporting too.
> >>
> >>> 3) what's the advantages of not using virtio-net uAPI
> >>
> >> 1. The use cases that don't involve VM will be simplified; programs fo=
r
> >> such a use case will not need to convert endian or to fill fileds the
> >> kernel doesn't care.
> >
> > Well, virtio_net_hdr is used by packet socket as well. Considering the
> > complexity of designing a new uAPI, it's still better.
>
> This patch series also reuses the datapath, following the prior examples.
>
> >
> > Or maybe you can clarify which field that kernel doesn't care about?
> > In this case TUN/TAP is basically the device datapath, if some of the
> > fields don't make sense, it's a bug of the spec.
>
> reserved, hash_key_length, and hash_key_data.

I may miss something when RSS is not negotiated, hash_key_length, and
hash_key_data is necessary, otherwise how could we calculate the hash?

>
> >
> >> 2. It aligns with existing UAPIs that operate in native endian and don=
't
> >> use virtio-net data structures like TUNSETOFFLOAD and TUNSETVNETHDRSZ.
> >
> > For those two examples, it would be used by guests directly. This is
> > different from RSS stuff.
>
> They are mediated by the VMM, which is no different from RSS.

Not necessarily, e,g Qemu support vDPA control virtqueue passthrough.

>
> >
> > With native endian, you need an endian conversation that converts le to=
 native.
>
> That's true, but QEMU does so anyway to validate the configuration, to
> attach/detach queues, and to share the data structures with userspace
> RSS implementations. I expect other VMMs will do so too.

See above.

>
> >
> >>
> >>>
> >>> More issues:
> >>>
> >>> 1) max_tx_vq is ignored, so do you expect the userspace to intercept
> >>> this and switch to using TUNSETQUEUE? This seems like a burden as TUN
> >>> can simply accept it and do the attaching/detaching by itself
> >>> 2) the rx depends on the indirection table, so userspace need to
> >>> intercept the indirection and change the rx queue numbers accordingly
> >>> 3) RSS allows a async TX/RX queue, this is not supported by TUN now,
> >>> no matter if we decide to let userspace to intercept max_tx_vq or not=
,
> >>> we need to implement it first
> >>   > > Things would be much more simpler, if kernel can do 1) and 2).
> >>
> >> Attaching and detaching queues is not possible for the kernel because =
it
> >> doesn't know what file descriptors that map to queues will be used by
> >> the userspace.
> >
> > The kernel knows, tfile has a queue_index part.
>
> queue_index is set with TUNSETQUEUE so we need the ioctl.

queue_index would be reshuffle during attaching/detaching since the
netdev core forbids sparse active queue indices.

But I don't see it's an issue since we are talking about introducing
new uAPI here.

If it doesn't work, it doesn't change the point, a new uAPI is needed
since RSS requires async tx/rx queue numbers, current TUN only allows
combined queue pairs.

>
> >
> >>
> >> The following patch does 2) for QEMU:
> >> https://lore.kernel.org/qemu-devel/20250322-vq-v2-1-cee0aafe6404@dayni=
x.com/
> >
> > See below point, form the view of the kernel, it's still a queue pair
> > not async TX/RX queue.
> >
> >>
> >> For 3), the patch for QEMU takes the maximum of TX and RX queue number=
s
> >> to derive the number of queue pairs.
> >>
> >>>
> >>>> We have two ioctls here because
> >>>> VIRTIO_NET_CTRL_MQ_RSS_CONFIG behaves differently depending on wheth=
er
> >>>> VIRTIO_NET_F_HASH_REPORT is negotiated or not;
> >>>
> >>> It wouldn't be a problem if you do 1:1 mapping between virtio command=
s
> >>> and TUN uAPI, otherwise it should have a bug somewhere.
> >>
> >> Speaking of 1:1 mapping, it is possible to map VIRTIO_NET_F_HASH_REPOR=
T
> >> into another ioctl. It may help add another receive steering algorithm
> >> in the future by not requiring two ioctls (TUNSETVNETREPORTING_X and
> >> TUNSETVNET_X).
> >
> > Yes and as I pointed out, virtio_net_hash_config should not be
> > specific to automq, it can work for other steering algorithm as well.
>
> That's not what the virtio spec says, so it will not be 1:1 mapping
> between virtio commands and TUN uAPI.

That's only because the spec only supports RSS and AUTOMQ so far. Or
do we expect a new virtio_net_XXX_hash_config for the new steering
algorithm?

>
> >
> >>
> >>>
> >>>> it also enables hash
> >>>> reporting if the feature is negotiated.
> >>>
> >>> Again, starting from virtio-net command is easier, a strong
> >>> justification is needed to explain why we choose another for tun/tap.
> >>>
> >>>>
> >>>>>
> >>>>> One day we would have tun_select_queue_algorithm_x() we don't have =
to
> >>>>> duplicate the ioctls once again here like TUNSETVNETREPORTINGXYZ
> >>>>
> >>>> 5.1.6.5.6.4 Hash calculation says:
> >>>>>    If VIRTIO_NET_F_HASH_REPORT was negotiated and the device uses
> >>>>> automatic receive steering, the device MUST support a command to
> >>>>> configure hash calculation parameters.
> >>>>>
> >>>>> The driver provides parameters for hash calculation as follows:
> >>>>>
> >>>>> class VIRTIO_NET_CTRL_MQ, command VIRTIO_NET_CTRL_MQ_HASH_CONFIG.
> >>>>
> >>>> VIRTIO_NET_CTRL_MQ_HASH_CONFIG is for automatic receive steering and=
 not
> >>>> for RSS (or other steering algorithms if the spec gets any in the fu=
ture).
> >>>
> >>> I'm not sure but the spec needs some tweaking. For example, I don't
> >>> expect there would be a dedicated hash config command for flow filter=
s
> >>> in the future. I think the reason why spec says like this is that
> >>> virtio-net only supports automatic receive steering.
> >>>
> >>> Note that macvtap doesn't implement automatic receive steering.
> >>
> >> QEMU advertises VIRTIO_NET_F_CTRL_VQ for macvtap too, so it should hav=
e
> >> implemented it. I think QEMU with macvtap still compliant to the spec.
> >
> > Compliant, but automatic traffic steering is the best effort as well.
> >
> > Nope, TUN/TAP implements a flow cache that can steer tx based on rx.
> > Macvtap simply uses hash here.
> >
> >>
> >> "5.1.6.5.6 Automatic receive steering in multiqueue mode" says:
> >>
> >>   > After the driver transmitted a packet of a flow on transmitqX, the
> >>   > device SHOULD cause incoming packets for that flow to be steered t=
o
> >>   > receiveqX.
> >>
> >> It is "SHOULD", so it is still compliant if the device doesn't properl=
y
> >> respect the flow.
> >
> > Yes, a quality of implementation, or it's impractical to support a
> > correct steering for this device as limited resources and mailious
> > users can do syn flood etc.
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>>> +               if (copy_from_user(&common, argp, sizeof(common)))
> >>>>>> +                       return -EFAULT;
> >>>>>> +               argp =3D (struct tun_vnet_rss __user *)argp + 1;
> >>>>>> +
> >>>>>> +               indirection_table_size =3D ((size_t)common.indirec=
tion_table_mask + 1) * 2;
> >>>>>> +               key_size =3D virtio_net_hash_key_length(common.has=
h_types);
> >>>>>> +               size =3D struct_size(hash, rss_indirection_table,
> >>>>>> +                                  (size_t)common.indirection_tabl=
e_mask + 1);
> >>>>>> +
> >>>>>> +               hash =3D kmalloc(size, GFP_KERNEL);
> >>>>>> +               if (!hash)
> >>>>>> +                       return -ENOMEM;
> >>>>>> +
> >>>>>> +               if (copy_from_user(hash->rss_indirection_table,
> >>>>>> +                                  argp, indirection_table_size)) =
{
> >>>>>> +                       kfree(hash);
> >>>>>> +                       return -EFAULT;
> >>>>>> +               }
> >>>>>> +               argp =3D (u16 __user *)argp + common.indirection_t=
able_mask + 1;
> >>>>>> +
> >>>>>> +               if (copy_from_user(hash->rss_key, argp, key_size))=
 {
> >>>>>> +                       kfree(hash);
> >>>>>> +                       return -EFAULT;
> >>>>>> +               }
> >>>>>> +
> >>>>>> +               virtio_net_toeplitz_convert_key(hash->rss_key, key=
_size);
> >>>>>> +               hash->report =3D cmd =3D=3D TUNSETVNETREPORTINGRSS=
;
> >>>>>
> >>>>> At least, if this is the only difference why not simply code this i=
nto
> >>>>> the ioctl itself other than having a very similar command?
> >>>>
> >>>> It is what the previous version did. Either is fine I guess; the onl=
y
> >>>> practical difference would be the size of the configuration struct i=
s
> >>>> smaller with this approach.
> >>>>
> >>>>>
> >>>>>> +               hash->rss =3D true;
> >>>>>> +               hash->common =3D common;
> >>>>>> +               break;
> >>>>>> +
> >>>>>> +       default:
> >>>>>> +               return -EINVAL;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       kfree_rcu_mightsleep(rcu_replace_pointer_rtnl(*hashp, hash=
));
> >>>>>> +       return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static inline void tun_vnet_hash_report(const struct tun_vnet_has=
h *hash,
> >>>>>> +                                       struct sk_buff *skb,
> >>>>>> +                                       const struct flow_keys_bas=
ic *keys,
> >>>>>> +                                       u32 value,
> >>>>>> +                                       tun_vnet_hash_add vnet_has=
h_add)
> >>>>>> +{
> >>>>>> +       struct virtio_net_hash *report;
> >>>>>> +
> >>>>>> +       if (!hash || !hash->report)
> >>>>>> +               return;
> >>>>>> +
> >>>>>> +       report =3D vnet_hash_add(skb);
> >>>>>> +       if (!report)
> >>>>>> +               return;
> >>>>>> +
> >>>>>> +       *report =3D (struct virtio_net_hash) {
> >>>>>> +               .report =3D virtio_net_hash_report(hash->common.ha=
sh_types, keys),
> >>>>>> +               .value =3D value
> >>>>>> +       };
> >>>>>> +}
> >>>>>> +
> >>>>>> +static inline u16 tun_vnet_rss_select_queue(u32 numqueues,
> >>>>>> +                                           const struct tun_vnet_=
hash *hash,
> >>>>>> +                                           struct sk_buff *skb,
> >>>>>> +                                           tun_vnet_hash_add vnet=
_hash_add)
> >>>>>> +{
> >>>>>> +       struct virtio_net_hash *report;
> >>>>>> +       struct virtio_net_hash ret;
> >>>>>> +       u16 index;
> >>>>>> +
> >>>>>> +       if (!numqueues)
> >>>>>> +               return 0;
> >>>>>> +
> >>>>>> +       virtio_net_hash_rss(skb, hash->common.hash_types, hash->rs=
s_key, &ret);
> >>>>>> +
> >>>>>> +       if (!ret.report)
> >>>>>> +               return hash->common.unclassified_queue % numqueues=
;
> >>>>>> +
> >>>>>> +       if (hash->report) {
> >>>>>> +               report =3D vnet_hash_add(skb);
> >>>>>> +               if (report)
> >>>>>> +                       *report =3D ret;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       index =3D ret.value & hash->common.indirection_table_mask;
> >>>>>> +
> >>>>>> +       return hash->rss_indirection_table[index] % numqueues;
> >>>>>> +}
> >>>>>> +
> >>>>>>     static inline int tun_vnet_hdr_get(int sz, unsigned int flags,
> >>>>>>                                       struct iov_iter *from,
> >>>>>>                                       struct virtio_net_hdr *hdr)
> >>>>>> @@ -135,15 +268,17 @@ static inline int tun_vnet_hdr_get(int sz, u=
nsigned int flags,
> >>>>>>     }
> >>>>>>
> >>>>>>     static inline int tun_vnet_hdr_put(int sz, struct iov_iter *it=
er,
> >>>>>> -                                  const struct virtio_net_hdr *hd=
r)
> >>>>>> +                                  const struct virtio_net_hdr_v1_=
hash *hdr)
> >>>>>>     {
> >>>>>> +       int content_sz =3D MIN(sizeof(*hdr), sz);
> >>>>>> +
> >>>>>>            if (unlikely(iov_iter_count(iter) < sz))
> >>>>>>                    return -EINVAL;
> >>>>>>
> >>>>>> -       if (unlikely(copy_to_iter(hdr, sizeof(*hdr), iter) !=3D si=
zeof(*hdr)))
> >>>>>> +       if (unlikely(copy_to_iter(hdr, content_sz, iter) !=3D cont=
ent_sz))
> >>>>>>                    return -EFAULT;
> >>>>>>
> >>>>>> -       if (iov_iter_zero(sz - sizeof(*hdr), iter) !=3D sz - sizeo=
f(*hdr))
> >>>>>> +       if (iov_iter_zero(sz - content_sz, iter) !=3D sz - content=
_sz)
> >>>>>>                    return -EFAULT;
> >>>>>>
> >>>>>>            return 0;
> >>>>>> @@ -155,26 +290,38 @@ static inline int tun_vnet_hdr_to_skb(unsign=
ed int flags, struct sk_buff *skb,
> >>>>>>            return virtio_net_hdr_to_skb(skb, hdr, tun_vnet_is_litt=
le_endian(flags));
> >>>>>>     }
> >>>>>>
> >>>>>> -static inline int tun_vnet_hdr_from_skb(unsigned int flags,
> >>>>>> +static inline int tun_vnet_hdr_from_skb(int sz, unsigned int flag=
s,
> >>>>>>                                            const struct net_device=
 *dev,
> >>>>>>                                            const struct sk_buff *s=
kb,
> >>>>>> -                                       struct virtio_net_hdr *hdr=
)
> >>>>>> +                                       tun_vnet_hash_find vnet_ha=
sh_find,
> >>>>>> +                                       struct virtio_net_hdr_v1_h=
ash *hdr)
> >>>>>>     {
> >>>>>>            int vlan_hlen =3D skb_vlan_tag_present(skb) ? VLAN_HLEN=
 : 0;
> >>>>>> +       const struct virtio_net_hash *report =3D sz < sizeof(struc=
t virtio_net_hdr_v1_hash) ?
> >>>>>> +                                              NULL : vnet_hash_fi=
nd(skb);
> >>>>>> +
> >>>>>> +       *hdr =3D (struct virtio_net_hdr_v1_hash) {
> >>>>>> +               .hash_report =3D VIRTIO_NET_HASH_REPORT_NONE
> >>>>>> +       };
> >>>>>> +
> >>>>>> +       if (report) {
> >>>>>> +               hdr->hash_value =3D cpu_to_le32(report->value);
> >>>>>> +               hdr->hash_report =3D cpu_to_le16(report->report);
> >>>>>> +       }
> >>>>>>
> >>>>>> -       if (virtio_net_hdr_from_skb(skb, hdr,
> >>>>>> +       if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)=
hdr,
> >>>>>>                                        tun_vnet_is_little_endian(f=
lags), true,
> >>>>>>                                        vlan_hlen)) {
> >>>>>>                    struct skb_shared_info *sinfo =3D skb_shinfo(sk=
b);
> >>>>>>
> >>>>>>                    if (net_ratelimit()) {
> >>>>>>                            netdev_err(dev, "unexpected GSO type: 0=
x%x, gso_size %d, hdr_len %d\n",
> >>>>>> -                                  sinfo->gso_type, tun_vnet16_to_=
cpu(flags, hdr->gso_size),
> >>>>>> -                                  tun_vnet16_to_cpu(flags, hdr->h=
dr_len));
> >>>>>> +                                  sinfo->gso_type, tun_vnet16_to_=
cpu(flags, hdr->hdr.gso_size),
> >>>>>> +                                  tun_vnet16_to_cpu(flags, hdr->h=
dr.hdr_len));
> >>>>>>                            print_hex_dump(KERN_ERR, "tun: ",
> >>>>>>                                           DUMP_PREFIX_NONE,
> >>>>>>                                           16, 1, skb->head,
> >>>>>> -                                      min(tun_vnet16_to_cpu(flags=
, hdr->hdr_len), 64), true);
> >>>>>> +                                      min(tun_vnet16_to_cpu(flags=
, hdr->hdr.hdr_len), 64), true);
> >>>>>>                    }
> >>>>>>                    WARN_ON_ONCE(1);
> >>>>>>                    return -EINVAL;
> >>>>>> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_t=
un.h
> >>>>>> index 980de74724fc..fe4b984d3bbb 100644
> >>>>>> --- a/include/uapi/linux/if_tun.h
> >>>>>> +++ b/include/uapi/linux/if_tun.h
> >>>>>> @@ -62,6 +62,62 @@
> >>>>>>     #define TUNSETCARRIER _IOW('T', 226, int)
> >>>>>>     #define TUNGETDEVNETNS _IO('T', 227)
> >>>>>>
> >>>>>> +/**
> >>>>>> + * define TUNGETVNETHASHTYPES - ioctl to get supported virtio_net=
 hashing types
> >>>>>> + *
> >>>>>> + * The argument is a pointer to __u32 which will store the suppor=
ted virtio_net
> >>>>>> + * hashing types.
> >>>>>> + */
> >>>>>> +#define TUNGETVNETHASHTYPES _IOR('T', 228, __u32)
> >>>>>> +
> >>>>>> +/**
> >>>>>> + * define TUNSETVNETREPORTINGAUTOMQ - ioctl to enable automq with=
 hash reporting
> >>>>>> + *
> >>>>>> + * Disable RSS and enable automatic receive steering with hash re=
porting.
> >>>>>> + *
> >>>>>> + * The argument is a pointer to __u32 that contains a bitmask of =
hash types
> >>>>>> + * allowed to be reported.
> >>>>>> + *
> >>>>>> + * This ioctl results in %EBADFD if the underlying device is dele=
ted. It affects
> >>>>>> + * all queues attached to the same device.
> >>>>>> + *
> >>>>>> + * This ioctl currently has no effect on XDP packets and packets =
with
> >>>>>> + * queue_mapping set by TC.
> >>>>>> + */
> >>>>>> +#define TUNSETVNETREPORTINGAUTOMQ _IOR('T', 229, __u32)
> >>>>>> +
> >>>>>> +/**
> >>>>>> + * define TUNSETVNETREPORTINGRSS - ioctl to enable RSS with hash =
reporting
> >>>>>> + *
> >>>>>> + * Disable automatic receive steering and enable RSS with hash re=
porting.
> >>>>>
> >>>>> This is unnecessary, e.g one day will have select_queue_xyz(), we
> >>>>> don't want to say "Disable automatic receive steering and xyz ..."
> >>>>
> >>>> It is still something better to be documented as its behavior is
> >>>> somewhat complicated.
> >>>
> >>> This is a hint of uAPI design issue.
> >>>
> >>>>
> >>>> Concretely, this ioctl disables automatic receive steering but doesn=
't
> >>>> disable steering by eBPF, which is implied by TUN_STEERINGEBPF_FALLB=
ACK.
> >>>
> >>> It would be simpler:
> >>>
> >>> 1) not having TUN_STEERINGEBPF_FALLBACK
> >>> 2) the steering algorithm depends on the last uAPI call
> >>
> >> What will TUNSETSTEERINGEBPF with NULL mean in that case? It currently
> >> switches the steering algorithm to automq.
> >
> > A stackwise semantic then?
>
> Can you clarify the semantics with an example of a set of ioctls?
> Perhaps it is an easy way to demonstrate an alternative design idea.

Consider user do:

1) TUNSETQUEUE /* enable automq, push */
2) TUNSETSTEERINGEBPF /* enable steering ebp, push */
3) TUNSETETTERINGEBPF to NULL /* disable steering ebpf, pop */

Automq is in the stack top, so TUN will use that.

Thanks

>
> Regards,
> Akihiko Odaki
>


