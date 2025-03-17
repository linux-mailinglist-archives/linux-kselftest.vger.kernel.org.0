Return-Path: <linux-kselftest+bounces-29167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A17DA639CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 02:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECD03A5B33
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 01:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DFA5674E;
	Mon, 17 Mar 2025 01:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2+SrshA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8301EDDC1
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 01:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742173998; cv=none; b=HM/ma3uWrz/RftbgVHFPv0OKCpF0auK26uT8MJe1m+UvvVDvZvPvbyujVK3Hhs/3SLiW1sg16O4+FySYGOQ+QBylCFGRhQVI+eUAPhg7P5pusd2nMepr6YyZa7HmtAmqc7tup6lnXs3YRZm6Pwc6TJGnyb1k2Z0K+Zbj78uTR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742173998; c=relaxed/simple;
	bh=MegtryvFqQIppHgHOLxnS74N/rMKL/rK/AZO/E8X+fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlUldixj/xzyE5UbO+N9dgGBuRK3MP3M/Vy+EYfpeHAewjTIjserSQCzyWqX5ZJvY2Nj1t8I+DdDYIxeA0oFlwCDLZE03xYbajyuiqTj2ilp+9R7YGCVhViIbbibgz7tPdyPP8CHeFyKQpa5cs3i9CBx7qFEnxf3Qpyi/euMHxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2+SrshA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742173994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2pU2CrvJxs42XXvKO0iiqoJ6d0A377CzdEe/BLeOmM=;
	b=e2+SrshAHehNMFqdaGfVzTqPhM/ygIgWB44p7UX9Vjm/ZV1J1i180t6ePR1puPDld6r3Kg
	EdsV4aQ/QEWqckkbvWyCytZg1UPLJ5h+UMRFQm2XVU29A2SVHsvxuHyskv3gG0dftMWPZ8
	s7ZkxsbjpyrdEKU1nClNYWJRorMSVWk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-wKPgpBX9Pi2qc9odssyGJw-1; Sun, 16 Mar 2025 21:13:13 -0400
X-MC-Unique: wKPgpBX9Pi2qc9odssyGJw-1
X-Mimecast-MFC-AGG-ID: wKPgpBX9Pi2qc9odssyGJw_1742173992
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so4449805a91.3
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Mar 2025 18:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742173992; x=1742778792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2pU2CrvJxs42XXvKO0iiqoJ6d0A377CzdEe/BLeOmM=;
        b=seCTGOnKGhx5hUVyrNoxigUj3hVD4N/eWllKa6MNdm5oBHpZhTWB+ozn327W3fndjt
         r0SJoGMNqfuPwPoRzbM0c3N9rfqi/5mrT8c7CjEYFCy+fZTS83CYG5Vgs19MBcfuOnw9
         YssP0WYiHomoWAXoWy6VVdKDDTTHS4zYUBlvP3PzH44EBsFG/8G/ndwDGQbboSlQlVCg
         FPvMtY2PDRffYSN1kTGB7jm87jawcxRjmHnHY/dER61sqWGTqq8TJ58SMnua2XNVeCLZ
         nwyH4mz5owvAGi3E9fqK46baUzH+uxn3XXg7kWkKMNw5arWlJDz42RiIvNzveWwKVbY+
         YkaA==
X-Forwarded-Encrypted: i=1; AJvYcCXAHtQW/SMIVVFTSuQz6Zkk24qYXesEiH8bD/deHWzx+UloJDu81T7Y3P23Bkl4EeKsc4ni9wSDVhIef8i22FU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx06AAU2iUwOrLfoYWkgXQV3YG9QOU8WDIKASoWDjRfJx9LjZsR
	Kp4VXorOJkWHiDa6NwysiAKgdqbfBSvWlYeuK5LcWLsqDUHg34Dpz4jsgAS7EDtwkJIk7VHoDIG
	NHTlutCSik8GVw4RayJsvSrDwtGgts27xYAaR9R88xrd/QZXrSfEAKu9zYyi8UmI4dAdfSPmWUG
	El1aC0ryq7iJOmWj8Z/8gAGxYWQwHkJQegi5Li1hng
X-Gm-Gg: ASbGncuH86wc8T1URM/2H14vFNQYOdpVKIpj+Ad8u9r/9SmkgJhXGJNZFk1TPPHMu+e
	fxkMGAHLGDVrv1fyo6srO5AJfyr8ytvDBTEGpoLY2KZw85ULoZeGqCGUL/wwKMjuHobpsbuWyZA
	==
X-Received: by 2002:a17:90b:5102:b0:2fe:b774:3ec8 with SMTP id 98e67ed59e1d1-30151d579ecmr10889003a91.23.1742173991638;
        Sun, 16 Mar 2025 18:13:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuBDM83agWgP1LGBHRibz0QSEGG1pr8LmZzWFhUfvQBdUmUysCUWVrJ07Kz47gQgoB9eSK9yIwcoU5NY2+Bds=
X-Received: by 2002:a17:90b:5102:b0:2fe:b774:3ec8 with SMTP id
 98e67ed59e1d1-30151d579ecmr10888965a91.23.1742173991176; Sun, 16 Mar 2025
 18:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-3-df76624025eb@daynix.com>
 <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com>
 <7978dfd5-8499-44f3-9c30-e53a01449281@daynix.com> <CACGkMEsR4_RreDbYQSEk5Cr29_26WNUYheWCQBjyMNUn=1eS2Q@mail.gmail.com>
 <edf41317-2191-458f-a315-87d5af42a264@daynix.com> <CACGkMEta3k_JOhKv44XiBXZb=WuS=KbSeJNpYxCdeiAgRY2azg@mail.gmail.com>
 <ff7916cf-8a9c-4c27-baaf-ca408817c063@daynix.com>
In-Reply-To: <ff7916cf-8a9c-4c27-baaf-ca408817c063@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Mar 2025 09:12:58 +0800
X-Gm-Features: AQ5f1JpbovIUWP4Gme3peFz6NLeQE0mM1LrLEOCV_o8YXlq3HxnPfJrMBa6T7m4
Message-ID: <CACGkMEsVgbJPhz2d2ATm5fr3M2uSEoSXWW7tXZ_FrkQtmmu1wA@mail.gmail.com>
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

On Wed, Mar 12, 2025 at 1:03=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/12 11:35, Jason Wang wrote:
> > On Tue, Mar 11, 2025 at 2:11=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2025/03/11 9:38, Jason Wang wrote:
> >>> On Mon, Mar 10, 2025 at 3:45=E2=80=AFPM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> On 2025/03/10 12:55, Jason Wang wrote:
> >>>>> On Fri, Mar 7, 2025 at 7:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>>>
> >>>>>> Hash reporting
> >>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>
> >>>>>> Allow the guest to reuse the hash value to make receive steering
> >>>>>> consistent between the host and guest, and to save hash computatio=
n.
> >>>>>>
> >>>>>> RSS
> >>>>>> =3D=3D=3D
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
> >>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>>>> ---
> >>>>>>     Documentation/networking/tuntap.rst |   7 ++
> >>>>>>     drivers/net/Kconfig                 |   1 +
> >>>>>>     drivers/net/tap.c                   |  68 ++++++++++++++-
> >>>>>>     drivers/net/tun.c                   |  98 +++++++++++++++++---=
--
> >>>>>>     drivers/net/tun_vnet.h              | 159 ++++++++++++++++++++=
++++++++++++++--
> >>>>>>     include/linux/if_tap.h              |   2 +
> >>>>>>     include/linux/skbuff.h              |   3 +
> >>>>>>     include/uapi/linux/if_tun.h         |  75 +++++++++++++++++
> >>>>>>     net/core/skbuff.c                   |   4 +
> >>>>>>     9 files changed, 386 insertions(+), 31 deletions(-)
> >>>>>>
> >>>>>> diff --git a/Documentation/networking/tuntap.rst b/Documentation/n=
etworking/tuntap.rst
> >>>>>> index 4d7087f727be5e37dfbf5066a9e9c872cc98898d..86b4ae8caa8ad062c1=
e558920be42ce0d4217465 100644
> >>>>>> --- a/Documentation/networking/tuntap.rst
> >>>>>> +++ b/Documentation/networking/tuntap.rst
> >>>>>> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we dis=
able it::
> >>>>>>           return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
> >>>>>>       }
> >>>>>>
> >
> > [...]
> >
> >>>>>> +static inline long tun_vnet_ioctl_sethash(struct tun_vnet_hash_co=
ntainer __rcu **hashp,
> >>>>>> +                                         bool can_rss, void __use=
r *argp)
> >>>>>
> >>>>> So again, can_rss seems to be tricky. Looking at its caller, it tir=
es
> >>>>> to make eBPF and RSS mutually exclusive. I still don't understand w=
hy
> >>>>> we need this. Allow eBPF program to override some of the path seems=
 to
> >>>>> be common practice.
> >>>>>
> >>>>> What's more, we didn't try (or even can't) to make automq and eBPF =
to
> >>>>> be mutually exclusive. So I still didn't see what we gain from this
> >>>>> and it complicates the codes and may lead to ambiguous uAPI/behavio=
ur.
> >>>>
> >>>> automq and eBPF are mutually exclusive; automq is disabled when an e=
BPF
> >>>> steering program is set so I followed the example here.
> >>>
> >>> I meant from the view of uAPI, the kernel doesn't or can't reject eBP=
F
> >>> while using automq.
> >>   > >>
> >>>> We don't even have an interface for eBPF to let it fall back to anot=
her
> >>>> alogirhtm.
> >>>
> >>> It doesn't even need this, e.g XDP overrides the default receiving pa=
th.
> >>>
> >>>> I could make it fall back to RSS if the eBPF steeering
> >>>> program is designed to fall back to automq when it returns e.g., -1.=
 But
> >>>> such an interface is currently not defined and defining one is out o=
f
> >>>> scope of this patch series.
> >>>
> >>> Just to make sure we are on the same page, I meant we just need to
> >>> make the behaviour consistent: allow eBPF to override the behaviour o=
f
> >>> both automq and rss.
> >>
> >> That assumes eBPF takes precedence over RSS, which is not obvious to m=
e.
> >
> > Well, it's kind of obvious. Not speaking the eBPF selector, we have
> > other eBPF stuffs like skbedit etc.
> >
> >>
> >> Let's add an interface for the eBPF steering program to fall back to
> >> another steering algorithm. I said it is out of scope before, but it
> >> makes clear that the eBPF steering program takes precedence over other
> >> algorithms and allows us to delete the code for the configuration
> >> validation in this patch.
> >
> > Fallback is out of scope but it's not what I meant.
> >
> > I meant in the current uAPI take eBPF precedence over automq. It's
> > much more simpler to stick this precedence unless we see obvious
> > advanatge.
>
> We still have three different design options that preserve the current
> precedence:
>
> 1) Precedence order: eBPF -> RSS -> automq
> 2) Precedence order: RSS -> eBPF -> automq
> 3) Precedence order: eBPF OR RSS -> automq where eBPF and RSS are
> mutually exclusive
>
> I think this is a unique situation for this steering program and I could
> not find another example in other eBPF stuffs.

As described above, queue mapping could be overridden by tc-ebpf. So
there's no way to guarantee the RSS will work:

https://github.com/DPDK/dpdk/blob/main/drivers/net/tap/bpf/tap_rss.c#L262

Making eBPF first leaves a chance for the management layer to override
the choice of Qemu.

>
> The current version implements 3) because it is not obvious whether we
> should choose either 1) or 2).

But you didn't explain why you choose 3), and it leads to tricky code
(e.g the can_rss stuff etc).

> But 1) will be the most capable option if
> eBPF has a fall-back feature.
>
> >
> >>
> >>>
> >>>>
> >>>>>
> >
> > [...]
> >
> >>>>> Is there a chance that we can reach here without TUN_VNET_HASH_REPO=
RT?
> >>>>> If yes, it should be a bug.
> >>>>
> >>>> It is possible to use RSS without TUN_VNET_HASH_REPORT.
> >>>
> >>> Another call to separate the ioctls then.
> >>
> >> RSS and hash reporting are not completely independent though.
> >
> > Spec said:
> >
> > """
> > VIRTIO_NET_F_RSSRequires VIRTIO_NET_F_CTRL_VQ.
> > """
>
> I meant the features can be enabled independently, but they will share
> the hash type set when they are enabled at the same time.

Looking at the spec:

Hash repot uses:

"""
struct virtio_net_hash_config {
    le32 hash_types;
    le16 reserved[4];
    u8 hash_key_length;
    u8 hash_key_data[hash_key_length];
};
"""

RSS uses

"""
struct rss_rq_id {
   le16 vq_index_1_16: 15; /* Bits 1 to 16 of the virtqueue index */
   le16 reserved: 1; /* Set to zero */
};

struct virtio_net_rss_config {
    le32 hash_types;
    le16 indirection_table_mask;
    struct rss_rq_id unclassified_queue;
    struct rss_rq_id indirection_table[indirection_table_length];
    le16 max_tx_vq;
    u8 hash_key_length;
    u8 hash_key_data[hash_key_length];
};
"""

Instead of trying to figure out whether we can share some data
structures, why not simply start from what has been done in the spec?
This would ease the usersapce as well where it can simply do 1:1
mapping between ctrl vq command and tun uAPI.

>
> >
> >>
> >> A plot twist is the "types" parameter; it is a parameter that is
> >> "common" for RSS and hash reporting.
> >
> > So we can share part of the structure through the uAPI.
>
> Isn't that what this patch does?

I didn't see, basically I see only one TUNSETVNETHASH that is used to
set both hash report and rss:

"""
+/**
+ * define TUNSETVNETHASH - ioctl to configure virtio_net hashing
+ *
+ * The argument is a pointer to &struct tun_vnet_hash.
+ *
+ * The argument is a pointer to the compound of the following in order if
+ * %TUN_VNET_HASH_RSS is set:
+ *
+ * 1. &struct tun_vnet_hash
+ * 2. &struct tun_vnet_hash_rss
+ * 3. Indirection table
+ * 4. Key
+ *
"""

And it seems to lack parameters like max_tx_vq.

What's more, we've already had virito-net uAPI. Why not simply reusing them=
?

>
> >
> >> RSS and hash reporting must share
> >> this parameter when both are enabled at the same time; otherwise RSS m=
ay
> >> compute hash values that are not suited for hash reporting.
> >
> > Is this mandated by the spec? If yes, we can add a check. If not,
> > userspace risk themselves as a mis-configuration which we don't need
> > to bother.
>
> Yes, it is mandated. 5.1.6.4.3 Hash calculation for incoming packets says=
:
>  > A device attempts to calculate a per-packet hash in the following
>  > cases:
>  >
>  >   - The feature VIRTIO_NET_F_RSS was negotiated. The device uses the
>  >     hash to determine the receive virtqueue to place incoming packets.
>  >   - The feature VIRTIO_NET_F_HASH_REPORT was negotiated. The device
>  >     reports the hash value and the hash type with the packet.
>  >
>  > If the feature VIRTIO_NET_F_RSS was negotiated:
>  >
>  >   - The device uses hash_types of the virtio_net_rss_config structure
>  >     as =E2=80=99Enabled hash types=E2=80=99 bitmask.
>  >   - The device uses a key as defined in hash_key_data and
>        hash_key_length of the virtio_net_rss_config structure (see
>  >      5.1.6.5.7.1).
>  >
>  > If the feature VIRTIO_NET_F_RSS was not negotiated:
>  >
>  >   - The device uses hash_types of the virtio_net_hash_config structure
>  >     as =E2=80=99Enabled hash types=E2=80=99 bitmask.
>  >   - The device uses a key as defined in hash_key_data and
>  >     hash_key_length of the virtio_net_hash_config structure (see
>  >      .1.6.5.6.4).
>
> So when both VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT are
> negotiated, virtio_net_rss_config not only controls RSS but also the
> reported hash values and types. They cannot be divergent.
>
> >
> > Note that spec use different commands for hash_report and rss.
>
> TUNSETVNETHASH is different from these commands in terms that it also
> negotiates VIRTIO_NET_F_HASH_REPORT and VIRTIO_NET_F_RSS.
>

There Are different "issues" here:

1) Whether or not we need to use a unified API for negotiating RSS and
HASH_REPORT features
2) Whether or not we need to sue a unified API for setting RSS and
HASH_REPORT configuration

What I want to say is point 2. But what you raise is point 1.

For simplicity, it looks to me like it's a call for having separated
ioctls for feature negotiation (for example via TUNSETIFF). You may
argue that either RSS or HASH_REPORT requires configurations, we can
just follow what spec defines or not (e.g what happens if
RSS/HASH_REPORT were negotiated but no configurations were set).

> In the virtio-net specification, it is not defined what would happen if
> these features are negotiated but the VIRTIO_NET_CTRL_MQ_RSS_CONFIG or
> VIRTIO_NET_CTRL_MQ_HASH_CONFIG commands are not sent. There is no such
> ambiguity with TUNSETVNETHASH.

So I don't see advantages of unifying hash reports and rss into a
single ioctl. Let's just follow what has been done in the spec that
uses separated commands. Tuntap is not a good place to debate whether
those commands could be unified or not. We need to move it to the spec
but assuming spec has been done, it might be too late or too few
advantages for having another design.

Thanks

>
> Regards,
> Akihiko Odaki
>
> >
> >>
> >> The paramter will be duplicated if we have separate ioctls for RSS and
> >> hash reporting, and the kernel will have a chiken-egg problem when
> >> ensuring they are synchronized; when the ioctl for RSS is issued, shou=
ld
> >> the kernel ensure the "types" parameter is identical with one specifie=
d
> >> for hash reporting? It will not work if the userspace may decide to
> >> configure hash reporting after RSS.
> >>
> >
> > See my reply above.
> >
> > Thanks
> >
>


