Return-Path: <linux-kselftest+bounces-28578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A3BA58AF5
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 04:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDA3169454
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 03:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AEE1C4A24;
	Mon, 10 Mar 2025 03:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWLIm0SG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EE01C1AB4
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 03:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741578959; cv=none; b=l2V4SRW6Kg7wIDURVKH0hAjoNmc438Tz2/zxQbFMT9h2dDgrsbIFchyzzUfFmWRdmRmW/xDATMb0+HjImBXNtL7l0up98tdSbtX6Yd/8XbX5QOvjjR/fpX56yzUFtqm5PKb6yW+436cdYeG/lepe7mBcCup9dQbITMtThGkdDtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741578959; c=relaxed/simple;
	bh=cAsEA5rVLtlF4YFTrYNPFuKy+KtQ1kpU4FosslrO3sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+DdMUr7RGAeeAGja12bzSVGddTWiD8YjoERfQMAr3YpOqheHturOB7Oo7SrXyhZNVydEK1n/CMA0x/zJamyBim1cwic/1hc/qQaLWx6Ld3qhfSUMW7RYlF1KPfsQTo6SyRgKyjBuUve3DvfL0du6qZpHMc1Vqdz0/1e2MnFVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWLIm0SG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741578955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KLfDOaZ+6H2fVtzm/R21I7CXsAT52XVMOY62cWTJKC4=;
	b=DWLIm0SGWKeAyk2XN2D4wtmhcs72FooXf8sLHJ2ntGMft+9PthlwlE6d7kglX2GKyC91y3
	VoMRDD7n+pPGy1iXJfn+9Ky29DXq0sbD0WJ8mW4LJNsjdpdaqofgwCdKcXES8TS1xXtayt
	9/F7StnZvLBpNXEkyvvtyl/iZv4vdCY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-DpDsvmg4MnifKsLVpkp9fg-1; Sun, 09 Mar 2025 23:55:54 -0400
X-MC-Unique: DpDsvmg4MnifKsLVpkp9fg-1
X-Mimecast-MFC-AGG-ID: DpDsvmg4MnifKsLVpkp9fg_1741578953
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff6943febeso6054544a91.0
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Mar 2025 20:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741578953; x=1742183753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLfDOaZ+6H2fVtzm/R21I7CXsAT52XVMOY62cWTJKC4=;
        b=ViYLTDOno3zzze4Ve9sU6JdAbeOqUHC6HS9fcRwTJOt/ZIQdafPyVrALnQ+ygEsISe
         miEdaWA228lxEsFKXDnHalYBatUug+YsEyEPRYM4XduLee+BCSdZn8nB8WroW/ezBiYs
         vfWbO75+G0QLhLAr6ExVhR4DW3N9QI2Zw4SvO+IrUZm2nzxQRXueqbpTTGQBBsGjJxfv
         VUdzWus1JvblBdmSGP9GAhZIbVCF2jbb7XME29dic+5lhLbTondG8CcZA6kLZjinFC3k
         JSzvJsussyrSaTtqEtts8NZkEUCrKvU+gusKHEaSgaC2sayOfZn/NkA399AMGbzDJVA+
         EKdg==
X-Forwarded-Encrypted: i=1; AJvYcCWq77A7NDqgk4CN61J1GDDkEpMvRig+t3DbJU5gKmWrhB2e3lU08AJ3gRuAhfXvhnSAyau7Vbr5OzDt9GxMdZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7noVbHjKTVv0BZuKR/hK3roKKIrRcBv1C9H0he4KLhCaTrn4z
	voSfKLehGKDZEhKRA/XR6cvTEqV7Y0rXy5dJKtX1RWuZSlIwgVZSNk2vATlSysSIFvDe7PD7U5T
	HgItpstzGVZcVCUsIEuiez4AQPUtBw18ZWTXH1/Al5p/YmnOP+0Eb4z7ZtHBcA/J4HlhSUtQUh1
	F64YXD18xMkxmXQZHro11cy5zI4BORIot/yYJBs3TD
X-Gm-Gg: ASbGncutn1JdHgXiBe3hxym3HnDpkWqzw4obXQejk4xDd7ADG9+eHk41yf4B3OMLg+I
	givUmhfYsVZePTw5P9qjlIVprcv3UatOlUrApvKwB8s2sfzZr6VMolgDx64CiVHXzv9aFicEw6A
	==
X-Received: by 2002:a17:90b:3b4a:b0:2fa:603e:905c with SMTP id 98e67ed59e1d1-2ffbc147913mr13099018a91.2.1741578952979;
        Sun, 09 Mar 2025 20:55:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/k2MZl+1eTauKKRQaBczo7+lYkLKBKYojv/oPSwVVjxmhcvsBCepaGgDHH6nnmcXNP7M3odraNkugC8ff+SY=
X-Received: by 2002:a17:90b:3b4a:b0:2fa:603e:905c with SMTP id
 98e67ed59e1d1-2ffbc147913mr13098993a91.2.1741578952536; Sun, 09 Mar 2025
 20:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-1-df76624025eb@daynix.com>
In-Reply-To: <20250307-rss-v9-1-df76624025eb@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Mar 2025 11:55:41 +0800
X-Gm-Features: AQ5f1Jo7izCEaK4h7KNaa2PmkyiGKSX1VLT--PvuZ9E5ca0j_EFeVEqGooF6Dh4
Message-ID: <CACGkMEvxkwe9OJRZPb7zz-sRfVpeuoYSz4c2kh9_jjtGbkb_qA@mail.gmail.com>
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

On Fri, Mar 7, 2025 at 7:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> They are useful to implement VIRTIO_NET_F_RSS and
> VIRTIO_NET_F_HASH_REPORT.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Lei Yang <leiyang@redhat.com>
> ---
>  include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 188 insertions(+)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 02a9f4dc594d02372a6c1850cd600eff9d000d8d..426f33b4b82440d61b2af9fdc=
4c0b0d4c571b2c5 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -9,6 +9,194 @@
>  #include <uapi/linux/tcp.h>
>  #include <uapi/linux/virtio_net.h>
>
> +struct virtio_net_hash {
> +       u32 value;
> +       u16 report;
> +};
> +
> +struct virtio_net_toeplitz_state {
> +       u32 hash;
> +       const u32 *key;
> +};
> +
> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 |=
 \
> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv4 |=
 \
> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv4 |=
 \
> +                                        VIRTIO_NET_RSS_HASH_TYPE_IPv6 | =
\
> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv6 |=
 \
> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv6)

Let's explain why

#define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
#define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
#define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9

are missed here.

And explain how we could maintain migration compatibility

1) Does those three work for userspace datapath in Qemu? If yes,
migration will be broken.
2) once we support those three in the future. For example, is the qemu
expected to probe this via TUNGETVNETHASHCAP in the destination and
fail the migration?

Thanks



> +
> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
> +
> +static inline void virtio_net_toeplitz_convert_key(u32 *input, size_t le=
n)
> +{
> +       while (len >=3D sizeof(*input)) {
> +               *input =3D be32_to_cpu((__force __be32)*input);
> +               input++;
> +               len -=3D sizeof(*input);
> +       }
> +}
> +
> +static inline void virtio_net_toeplitz_calc(struct virtio_net_toeplitz_s=
tate *state,
> +                                           const __be32 *input, size_t l=
en)
> +{
> +       while (len >=3D sizeof(*input)) {
> +               for (u32 map =3D be32_to_cpu(*input); map; map &=3D (map =
- 1)) {
> +                       u32 i =3D ffs(map);
> +
> +                       state->hash ^=3D state->key[0] << (32 - i) |
> +                                      (u32)((u64)state->key[1] >> i);
> +               }
> +
> +               state->key++;
> +               input++;
> +               len -=3D sizeof(*input);
> +       }
> +}
> +
> +static inline u8 virtio_net_hash_key_length(u32 types)
> +{
> +       size_t len =3D 0;
> +
> +       if (types & VIRTIO_NET_HASH_REPORT_IPv4)
> +               len =3D max(len,
> +                         sizeof(struct flow_dissector_key_ipv4_addrs));
> +
> +       if (types &
> +           (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4)=
)
> +               len =3D max(len,
> +                         sizeof(struct flow_dissector_key_ipv4_addrs) +
> +                         sizeof(struct flow_dissector_key_ports));
> +
> +       if (types & VIRTIO_NET_HASH_REPORT_IPv6)
> +               len =3D max(len,
> +                         sizeof(struct flow_dissector_key_ipv6_addrs));
> +
> +       if (types &
> +           (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6)=
)
> +               len =3D max(len,
> +                         sizeof(struct flow_dissector_key_ipv6_addrs) +
> +                         sizeof(struct flow_dissector_key_ports));
> +
> +       return len + sizeof(u32);
> +}
> +
> +static inline u32 virtio_net_hash_report(u32 types,
> +                                        const struct flow_keys_basic *ke=
ys)
> +{
> +       switch (keys->basic.n_proto) {
> +       case cpu_to_be16(ETH_P_IP):
> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_TCP &&
> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
> +                               return VIRTIO_NET_HASH_REPORT_TCPv4;
> +
> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_UDP &&
> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
> +                               return VIRTIO_NET_HASH_REPORT_UDPv4;
> +               }
> +
> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
> +                       return VIRTIO_NET_HASH_REPORT_IPv4;
> +
> +               return VIRTIO_NET_HASH_REPORT_NONE;
> +
> +       case cpu_to_be16(ETH_P_IPV6):
> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_TCP &&
> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
> +                               return VIRTIO_NET_HASH_REPORT_TCPv6;
> +
> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_UDP &&
> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
> +                               return VIRTIO_NET_HASH_REPORT_UDPv6;
> +               }
> +
> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
> +                       return VIRTIO_NET_HASH_REPORT_IPv6;
> +
> +               return VIRTIO_NET_HASH_REPORT_NONE;
> +
> +       default:
> +               return VIRTIO_NET_HASH_REPORT_NONE;
> +       }
> +}
> +
> +static inline void virtio_net_hash_rss(const struct sk_buff *skb,
> +                                      u32 types, const u32 *key,
> +                                      struct virtio_net_hash *hash)
> +{
> +       struct virtio_net_toeplitz_state toeplitz_state =3D { .key =3D ke=
y };
> +       struct flow_keys flow;
> +       struct flow_keys_basic flow_basic;
> +       u16 report;
> +
> +       if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
> +               hash->report =3D VIRTIO_NET_HASH_REPORT_NONE;
> +               return;
> +       }
> +
> +       flow_basic =3D (struct flow_keys_basic) {
> +               .control =3D flow.control,
> +               .basic =3D flow.basic
> +       };
> +
> +       report =3D virtio_net_hash_report(types, &flow_basic);
> +
> +       switch (report) {
> +       case VIRTIO_NET_HASH_REPORT_IPv4:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v4addrs,
> +                                        sizeof(flow.addrs.v4addrs));
> +               break;
> +
> +       case VIRTIO_NET_HASH_REPORT_TCPv4:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v4addrs,
> +                                        sizeof(flow.addrs.v4addrs));
> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.por=
ts,
> +                                        sizeof(flow.ports.ports));
> +               break;
> +
> +       case VIRTIO_NET_HASH_REPORT_UDPv4:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v4addrs,
> +                                        sizeof(flow.addrs.v4addrs));
> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.por=
ts,
> +                                        sizeof(flow.ports.ports));
> +               break;
> +
> +       case VIRTIO_NET_HASH_REPORT_IPv6:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v6addrs,
> +                                        sizeof(flow.addrs.v6addrs));
> +               break;
> +
> +       case VIRTIO_NET_HASH_REPORT_TCPv6:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v6addrs,
> +                                        sizeof(flow.addrs.v6addrs));
> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.por=
ts,
> +                                        sizeof(flow.ports.ports));
> +               break;
> +
> +       case VIRTIO_NET_HASH_REPORT_UDPv6:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v6addrs,
> +                                        sizeof(flow.addrs.v6addrs));
> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.por=
ts,
> +                                        sizeof(flow.ports.ports));
> +               break;
> +
> +       default:
> +               hash->report =3D VIRTIO_NET_HASH_REPORT_NONE;
> +               return;
> +       }
> +
> +       hash->value =3D toeplitz_state.hash;
> +       hash->report =3D report;
> +}
> +
>  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_=
type)
>  {
>         switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
>
> --
> 2.48.1
>


