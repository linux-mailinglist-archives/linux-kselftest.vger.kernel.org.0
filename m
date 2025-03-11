Return-Path: <linux-kselftest+bounces-28687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D6DA5B54A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 01:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD143AFB43
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 00:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BEA1E25EB;
	Tue, 11 Mar 2025 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nat/Girb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D271DED46
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 00:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741654088; cv=none; b=hcWQ39HDxwXwinpMdPk5laEmboxCfJDU1WnDILamXkNS4ppGsLhbtQEX7dNu2o8gxa01WPDlsbvHbhvs8pPYX8vxb8f48UKG4Wt7fgtQcyl0z4znePQhiEf81S/NBmNlL9ZPJvOyj2ymGEQrql+udygVbiWVFCoaBOWhFtkxwKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741654088; c=relaxed/simple;
	bh=iUmKMFMfNVHV3p9gOEOJzilXkAvvuzEkpKVDUSknwuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNYKzXfzEA40LnKzxqYrakPA/wlVTJWJmcOcja3Qs/WgEt5mYKxSVD1fkHol52KPZO3uvOmBXhA2de1QT14domp+0GKulFs3KZUb2lmdaQvC65qRIS+t3XXnMvHfa2iTF+3KexFA2KjGgDg0rPvUogjS3YmHnvddXZlDnlNoW5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nat/Girb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741654085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4RPpAsJjFLb1bmj7ZTjB+BgN1HMNXzkPXhmqdvbnZE=;
	b=Nat/GirbaZY+WSjYvEhe+oIAjtk3CYbc1cid5lNinOafKf3SaaLtkq6YMZYxffbdNkSHnC
	ytVotXQn0uGQ5UgzYgqh5NIBVNYQAjb90+KyV/zG6aDu2yxDx2o8GaIRRim3pkrER7v8lI
	eDsiL2/cCq+aZm85/SPzsfg2luy8MAc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-91eeEWtJPs673lrSn4LqfA-1; Mon, 10 Mar 2025 20:48:03 -0400
X-MC-Unique: 91eeEWtJPs673lrSn4LqfA-1
X-Mimecast-MFC-AGG-ID: 91eeEWtJPs673lrSn4LqfA_1741654083
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff8119b436so5974487a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 17:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741654082; x=1742258882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4RPpAsJjFLb1bmj7ZTjB+BgN1HMNXzkPXhmqdvbnZE=;
        b=rePngNt3Rlimevze+hTz8Jd7b1z9Iz8pBoWG+jWTyuyowirJ+Ez8lvpP6O8IIwumKl
         DBLZxLaoTxYd1SBrZ4ztayAGlKJ1EHK6/nsZFiL6E7Y1AloPWUAA4LJPS6q8cvB7ywJf
         ebUMFyrilR95iwDNVFHWRKb2ExIiX1AnVdHYMnFTamu/axdbiFV7fUZ7lrkYXmO8t1M+
         I+PDre7luleRVPvDkoxcLr7angwoMpj1m3Tu4B8wlcoh2uVPk2f7VPKs6PakPBTjtSC9
         Xg35dmDu59ZRjEE+bElj+GkIkjfh61KsW4TaAFuW9SGq1lUwfN+0MGG4D8MQDCBGGmCI
         S6EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvNnmLrSmB6/VMQtqrfCFEVOA5tRMZ2vEduB0kMQGY0wZvK+G/CKOFrssrTX9mhTe9/Dx/EzPtvyP6pcuAKwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze0RDSepJtAdFbnymfWv/WcmMYN3bfFngpt7/SMLvkcIhvvrSM
	hf7f3Uu4hW9+2LKS02P6xZivTQsgziWscmnNaIVSnZEIfFD79FtJfwKSUT0S2Qv5Wiyfy9XD3cN
	r8CHRNikZSmrPLdGpjaEM0BXjkImbObc5Cu7nZ6iaayxDZBODb75DJqBcfu4935PVNh/e0rcURG
	JTZWcqk9uQJCJ4sTPthDkc0hH+t+zXsJ3tUT1XSLlqQSP01ry7Nuh6cw==
X-Gm-Gg: ASbGncsLY9FCS318uYpt7uYwHHjzwqBOc5TDc+6zVw2aJZFCzFsqABUhNLizevrdTkL
	FYAk3abd/njIR/4b199T7D80U2iEkXWRCxaH/g5YFveT5koqPOtVU8o1m6tUZtSseLLgdzg==
X-Received: by 2002:a17:90b:384a:b0:2ff:5ec1:6c6a with SMTP id 98e67ed59e1d1-2ff7cea69acmr27154078a91.18.1741654081868;
        Mon, 10 Mar 2025 17:48:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCzN5ET9BNqAf3acX2G6l8I6qUEcjNy9Eoao8D4JeeEu9MREQ+pXl9fLN3HTDfMoQUsh8bxkQUlZOvr8h4Tbw=
X-Received: by 2002:a17:90b:384a:b0:2ff:5ec1:6c6a with SMTP id
 98e67ed59e1d1-2ff7cea69acmr27154033a91.18.1741654081471; Mon, 10 Mar 2025
 17:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-1-df76624025eb@daynix.com>
 <CACGkMEvxkwe9OJRZPb7zz-sRfVpeuoYSz4c2kh9_jjtGbkb_qA@mail.gmail.com> <2e27f18b-1fc9-433d-92e9-8b2e3b1b65dc@daynix.com>
In-Reply-To: <2e27f18b-1fc9-433d-92e9-8b2e3b1b65dc@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Mar 2025 08:47:48 +0800
X-Gm-Features: AQ5f1Jp0pVNg8U2GWf0EyGN2bx4F1EnKJYGYXftamL6P0gaUKg2z9-u2GBEOkyc
Message-ID: <CACGkMEssbh0-BKJq7M=T1z9seMu==4OJzmDPU+HEx4OA95E3ng@mail.gmail.com>
Subject: Re: [PATCH net-next v9 1/6] virtio_net: Add functions for hashing
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

On Mon, Mar 10, 2025 at 2:53=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/10 12:55, Jason Wang wrote:
> > On Fri, Mar 7, 2025 at 7:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> They are useful to implement VIRTIO_NET_F_RSS and
> >> VIRTIO_NET_F_HASH_REPORT.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> Tested-by: Lei Yang <leiyang@redhat.com>
> >> ---
> >>   include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++=
++++++++++
> >>   1 file changed, 188 insertions(+)
> >>
> >> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> >> index 02a9f4dc594d02372a6c1850cd600eff9d000d8d..426f33b4b82440d61b2af9=
fdc4c0b0d4c571b2c5 100644
> >> --- a/include/linux/virtio_net.h
> >> +++ b/include/linux/virtio_net.h
> >> @@ -9,6 +9,194 @@
> >>   #include <uapi/linux/tcp.h>
> >>   #include <uapi/linux/virtio_net.h>
> >>
> >> +struct virtio_net_hash {
> >> +       u32 value;
> >> +       u16 report;
> >> +};
> >> +
> >> +struct virtio_net_toeplitz_state {
> >> +       u32 hash;
> >> +       const u32 *key;
> >> +};
> >> +
> >> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv=
4 | \
> >> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv=
4 | \
> >> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv=
4 | \
> >> +                                        VIRTIO_NET_RSS_HASH_TYPE_IPv6=
 | \
> >> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv=
6 | \
> >> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv=
6)
> >
> > Let's explain why
> >
> > #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
> > #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
> > #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> >
> > are missed here.
>
> Because they require parsing IPv6 options and I'm not sure how many we
> need to parse. QEMU's eBPF program has a hard-coded limit of 30 options;
> it has some explanation for this limit, but it does not seem definitive
> either:
> https://gitlab.com/qemu-project/qemu/-/commit/f3fa412de28ae3cb31d38811d30=
a77e4e20456cc#6ec48fc8af2f802e92f5127425e845c4c213ff60_0_165
>

How about the usersapce datapath RSS in Qemu? (We probably don't need
to align with eBPF RSS as it's just a reference implementation)

> In this patch series, I add an ioctl to query capability instead; it
> allows me leaving those hash types unimplemented and is crucial to
> assure extensibility for future additions of hash types anyway. Anyone
> who find these hash types useful can implement in the future.

Yes, but we need to make sure no userspace visible behaviour changes
after migration.

>
> >
> > And explain how we could maintain migration compatibility
> >
> > 1) Does those three work for userspace datapath in Qemu? If yes,
> > migration will be broken.
>
> They work for userspace datapath so my RFC patch series for QEMU uses
> TUNGETVNETHASHCAP to prevent breaking migration:
> https://patchew.org/QEMU/20240915-hash-v3-0-79cb08d28647@daynix.com/
>

Ok, let's mention this in the cover letter. Another interesting thing
is the migration from 10.0 to 9.0.

> This patch series first adds configuration options for users to choose
> hash types. QEMU then automatically picks one implementation from the
> following (the earlier one is the more preferred):
> 1) The hash capability of vhost hardware
> 2) The hash capability I'm proposing here
> 3) The eBPF program
> 4) The pure userspace implementation
>
> This decision depends on the following:
> - The required hash types; supported ones are queried for 1) and 2)
> - Whether vhost is enabled or not and what vhost backend is used
> - Whether hash reporting is enabled; 3) is incompatible with this
>
> The network device will not be realized if no implementation satisfies
> the requirements.

This makes sense, let's add this in the cover letter.

>
> > 2) once we support those three in the future. For example, is the qemu
> > expected to probe this via TUNGETVNETHASHCAP in the destination and
> > fail the migration?
>
> QEMU is expected to use TUNGETVNETHASHCAP, but it can selectively enable
> hash types with TUNSETVNETHASH to keep migration working.
>
> In summary, this patch series provides a sufficient facility for the
> userspace to make extensibility and migration compatible;
> TUNGETVNETHASHCAP exposes all of the kernel capabilities and
> TUNSETVNETHASH allows the userspace to limit them.
>
> Regards,
> Akihiko Odaki

Fine.

Thanks

>
> >
> > Thanks
> >
> >
> >
> >> +
> >> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
> >> +
> >> +static inline void virtio_net_toeplitz_convert_key(u32 *input, size_t=
 len)
> >> +{
> >> +       while (len >=3D sizeof(*input)) {
> >> +               *input =3D be32_to_cpu((__force __be32)*input);
> >> +               input++;
> >> +               len -=3D sizeof(*input);
> >> +       }
> >> +}
> >> +
> >> +static inline void virtio_net_toeplitz_calc(struct virtio_net_toeplit=
z_state *state,
> >> +                                           const __be32 *input, size_=
t len)
> >> +{
> >> +       while (len >=3D sizeof(*input)) {
> >> +               for (u32 map =3D be32_to_cpu(*input); map; map &=3D (m=
ap - 1)) {
> >> +                       u32 i =3D ffs(map);
> >> +
> >> +                       state->hash ^=3D state->key[0] << (32 - i) |
> >> +                                      (u32)((u64)state->key[1] >> i);
> >> +               }
> >> +
> >> +               state->key++;
> >> +               input++;
> >> +               len -=3D sizeof(*input);
> >> +       }
> >> +}
> >> +
> >> +static inline u8 virtio_net_hash_key_length(u32 types)
> >> +{
> >> +       size_t len =3D 0;
> >> +
> >> +       if (types & VIRTIO_NET_HASH_REPORT_IPv4)
> >> +               len =3D max(len,
> >> +                         sizeof(struct flow_dissector_key_ipv4_addrs)=
);
> >> +
> >> +       if (types &
> >> +           (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDP=
v4))
> >> +               len =3D max(len,
> >> +                         sizeof(struct flow_dissector_key_ipv4_addrs)=
 +
> >> +                         sizeof(struct flow_dissector_key_ports));
> >> +
> >> +       if (types & VIRTIO_NET_HASH_REPORT_IPv6)
> >> +               len =3D max(len,
> >> +                         sizeof(struct flow_dissector_key_ipv6_addrs)=
);
> >> +
> >> +       if (types &
> >> +           (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDP=
v6))
> >> +               len =3D max(len,
> >> +                         sizeof(struct flow_dissector_key_ipv6_addrs)=
 +
> >> +                         sizeof(struct flow_dissector_key_ports));
> >> +
> >> +       return len + sizeof(u32);
> >> +}
> >> +
> >> +static inline u32 virtio_net_hash_report(u32 types,
> >> +                                        const struct flow_keys_basic =
*keys)
> >> +{
> >> +       switch (keys->basic.n_proto) {
> >> +       case cpu_to_be16(ETH_P_IP):
> >> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
> >> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_TCP &&
> >> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
> >> +                               return VIRTIO_NET_HASH_REPORT_TCPv4;
> >> +
> >> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_UDP &&
> >> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
> >> +                               return VIRTIO_NET_HASH_REPORT_UDPv4;
> >> +               }
> >> +
> >> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
> >> +                       return VIRTIO_NET_HASH_REPORT_IPv4;
> >> +
> >> +               return VIRTIO_NET_HASH_REPORT_NONE;
> >> +
> >> +       case cpu_to_be16(ETH_P_IPV6):
> >> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
> >> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_TCP &&
> >> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
> >> +                               return VIRTIO_NET_HASH_REPORT_TCPv6;
> >> +
> >> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_UDP &&
> >> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
> >> +                               return VIRTIO_NET_HASH_REPORT_UDPv6;
> >> +               }
> >> +
> >> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
> >> +                       return VIRTIO_NET_HASH_REPORT_IPv6;
> >> +
> >> +               return VIRTIO_NET_HASH_REPORT_NONE;
> >> +
> >> +       default:
> >> +               return VIRTIO_NET_HASH_REPORT_NONE;
> >> +       }
> >> +}
> >> +
> >> +static inline void virtio_net_hash_rss(const struct sk_buff *skb,
> >> +                                      u32 types, const u32 *key,
> >> +                                      struct virtio_net_hash *hash)
> >> +{
> >> +       struct virtio_net_toeplitz_state toeplitz_state =3D { .key =3D=
 key };
> >> +       struct flow_keys flow;
> >> +       struct flow_keys_basic flow_basic;
> >> +       u16 report;
> >> +
> >> +       if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
> >> +               hash->report =3D VIRTIO_NET_HASH_REPORT_NONE;
> >> +               return;
> >> +       }
> >> +
> >> +       flow_basic =3D (struct flow_keys_basic) {
> >> +               .control =3D flow.control,
> >> +               .basic =3D flow.basic
> >> +       };
> >> +
> >> +       report =3D virtio_net_hash_report(types, &flow_basic);
> >> +
> >> +       switch (report) {
> >> +       case VIRTIO_NET_HASH_REPORT_IPv4:
> >> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >> +                                        (__be32 *)&flow.addrs.v4addrs=
,
> >> +                                        sizeof(flow.addrs.v4addrs));
> >> +               break;
> >> +
> >> +       case VIRTIO_NET_HASH_REPORT_TCPv4:
> >> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >> +                                        (__be32 *)&flow.addrs.v4addrs=
,
> >> +                                        sizeof(flow.addrs.v4addrs));
> >> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.=
ports,
> >> +                                        sizeof(flow.ports.ports));
> >> +               break;
> >> +
> >> +       case VIRTIO_NET_HASH_REPORT_UDPv4:
> >> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >> +                                        (__be32 *)&flow.addrs.v4addrs=
,
> >> +                                        sizeof(flow.addrs.v4addrs));
> >> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.=
ports,
> >> +                                        sizeof(flow.ports.ports));
> >> +               break;
> >> +
> >> +       case VIRTIO_NET_HASH_REPORT_IPv6:
> >> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >> +                                        (__be32 *)&flow.addrs.v6addrs=
,
> >> +                                        sizeof(flow.addrs.v6addrs));
> >> +               break;
> >> +
> >> +       case VIRTIO_NET_HASH_REPORT_TCPv6:
> >> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >> +                                        (__be32 *)&flow.addrs.v6addrs=
,
> >> +                                        sizeof(flow.addrs.v6addrs));
> >> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.=
ports,
> >> +                                        sizeof(flow.ports.ports));
> >> +               break;
> >> +
> >> +       case VIRTIO_NET_HASH_REPORT_UDPv6:
> >> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >> +                                        (__be32 *)&flow.addrs.v6addrs=
,
> >> +                                        sizeof(flow.addrs.v6addrs));
> >> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.=
ports,
> >> +                                        sizeof(flow.ports.ports));
> >> +               break;
> >> +
> >> +       default:
> >> +               hash->report =3D VIRTIO_NET_HASH_REPORT_NONE;
> >> +               return;
> >> +       }
> >> +
> >> +       hash->value =3D toeplitz_state.hash;
> >> +       hash->report =3D report;
> >> +}
> >> +
> >>   static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 =
gso_type)
> >>   {
> >>          switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> >>
> >> --
> >> 2.48.1
> >>
> >
>


