Return-Path: <linux-kselftest+bounces-34410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BD0ACFA72
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 02:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91E518917A9
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 00:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3261E884;
	Fri,  6 Jun 2025 00:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2TiX3hJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB31BF58
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Jun 2025 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749170946; cv=none; b=HA4jDF2Mpk37dL8BjUWCrgqbnN8IUz00o7BSZgBBTWz+O8UNXbZeYoXVFUrgkXc707ZV5sp4Irzi8+4YoUDC39lCab7J22vIEvBN4SKR7a3JTCKpZaENBpajEwjjnY1gc1BvVi7eHZ4uwoEXOEczcNOSShwlWFSinyBCqRnYYZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749170946; c=relaxed/simple;
	bh=tY+k3QGwsZ7nAcD2q9trIH+sq8HEFtWho6gpPouXGKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cATGsvFY63MDQi9pe+mlxATUG1adoo94B5Nsy6GV+XijiWuwjk22TxVtRxC/h6G64DwgEIfLESJvxlth0yzkjb7p4Eyz6DqaIe00IKvnFIeNdXamaOWklm/Zzd8viahWpjuP/yD+NFLd4Y4NMVKQOcOsLR/u4NrBon6vKTCu+hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2TiX3hJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749170943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ix90UYUbM9rkF+vvvxIw9m2PWD1r5sZBXm0z/BO9x9w=;
	b=A2TiX3hJqTNYPfFXP+gVw8qLux4FwbsdMP7919Va00u7vXGM/XSaTdGMntp6k6g6DyWMZr
	vSc3wedggRiZSCVi67Zq/jm41aoBgB7SeEx8h3w+kNUv2uj+KwM7sMb6JQ3p/r46Zkn47S
	HifxTaz4LnvgG1z45vtUk31CvVIFAPM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-_JtfYpTiOEOnaiLiVDAT5g-1; Thu, 05 Jun 2025 20:49:01 -0400
X-MC-Unique: _JtfYpTiOEOnaiLiVDAT5g-1
X-Mimecast-MFC-AGG-ID: _JtfYpTiOEOnaiLiVDAT5g_1749170940
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31327b2f8e4so1470953a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Jun 2025 17:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749170940; x=1749775740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ix90UYUbM9rkF+vvvxIw9m2PWD1r5sZBXm0z/BO9x9w=;
        b=H4f/TELmhzrM6Avr3WL2R4dBc3G5Q6wGKi7uSvUsEJ1RXyrrmwreCat4+pprH5NzUp
         MB9mm9RzxDscfgdKFiYFNA/6BJAx1SzWaYUZqUsUM5Hk0nlxdHObFBYl8u39adX61oPA
         w0eNrbqaSWCtsjISRXJrc84/0QUo88g8jdrWmMV3ZPaQTTXER+8iXv7/qP2jUHx/3zFb
         cdTWnt0ICZwl4STyTXHtULVWj5iQc/YvKsJqUPpwU7suQ6dyflPQh2XQw+yW7mvrvbJs
         JsSiyDhP2Yo4NqFb998Yd5QFtyqvcXZ22y95N06iqGKi9mu2EegfmgvrPs2Ua2IxtIB9
         ggCw==
X-Forwarded-Encrypted: i=1; AJvYcCXNZNV5pNfWMSkxELL4MGOXrNwWuL6Yc+uc1yfF5yhqILHLXD9c5nPmCEsb69HfVe1HkYupsVsvo+Wue4HBGAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5OzBKGp0jNw6Hh+4VheMufs4/3abNb3/AeOOu5kT5gJcOzSi
	4+OJRK62fskfVxw1IElAadVbPccKVG2xASdwO/kCHnFZpfHhczCyQlTRpzMZtjZETEbgcdCG7GO
	duNqoP0LHIeLEKB1zx3qgVDHPAMW51/p1f88cFf7sF7RUbjw2erqxHFtC7A5xsWLK0zbXyCJgsj
	FOVuq+2Aq54mIjSFW/EQEHJcpmc0euKLtNkydkBHoxITe6
X-Gm-Gg: ASbGncvaW6rOzuOF99gR2TKXK8TQ6Gcutrsb/MT8wab7P0WV3DqqKMh1Jdcb2D7Fi2z
	I/l+x8tXaffvf8tEVgUWGcHb9I19CnkgWVcx/2s9xidJroQrs4ZI/jrbTEV5hKGMlTUNtrQoFot
	PT1Qjt
X-Received: by 2002:a17:90b:2748:b0:311:9c9a:58d7 with SMTP id 98e67ed59e1d1-31346b4d641mr2035821a91.19.1749170940192;
        Thu, 05 Jun 2025 17:49:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWzeQYYlHyrRnH0s8g3D2h7+H4wjFzq19umt7qxJB6T3fclwGB4lj/P/ELm4NXZdTbix/ibSCmW9j5MWfqMZ8=
X-Received: by 2002:a17:90b:2748:b0:311:9c9a:58d7 with SMTP id
 98e67ed59e1d1-31346b4d641mr2035796a91.19.1749170939711; Thu, 05 Jun 2025
 17:48:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-1-95d8b348de91@daynix.com>
 <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
 <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com> <CACGkMEu6fZaErFEu7_UFsykXRL7Z+CwmkcxmvJHC+eN_j0pQvg@mail.gmail.com>
 <4eaa7aaa-f677-4a31-bcc2-badcb5e2b9f6@daynix.com> <CACGkMEu3QH+VdHqQEePYz_z+_bNYswpA-KNxzz0edEOSSkJtWw@mail.gmail.com>
 <75ef190e-49fc-48aa-abf2-579ea31e4d15@daynix.com>
In-Reply-To: <75ef190e-49fc-48aa-abf2-579ea31e4d15@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 6 Jun 2025 08:48:48 +0800
X-Gm-Features: AX0GCFt0LCt6YkIaNNqaDSQP6RZfBK6gZ-qHk5EyLlhxJLUXtnUYLlys2ZX1-3E
Message-ID: <CACGkMEu2n-O0UtVEmcPkELcg9gpML=m5W=qYPjeEjp3ba73Eiw@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Akihiko Odaki <akihiko.odaki@daynix.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 3:58=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2025/06/05 10:53, Jason Wang wrote:
> > On Wed, Jun 4, 2025 at 3:20=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> On 2025/06/04 10:18, Jason Wang wrote:
> >>> On Tue, Jun 3, 2025 at 1:31=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> On 2025/06/03 12:19, Jason Wang wrote:
> >>>>> On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.oda=
ki@daynix.com> wrote:
> >>>>>>
> >>>>>> They are useful to implement VIRTIO_NET_F_RSS and
> >>>>>> VIRTIO_NET_F_HASH_REPORT.
> >>>>>>
> >>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>>>> ---
> >>>>>>     include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++=
++++++++++++++++
> >>>>>>     1 file changed, 188 insertions(+)
> >>>>>>
> >>>>>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net=
.h
> >>>>>> index 02a9f4dc594d..426f33b4b824 100644
> >>>>>> --- a/include/linux/virtio_net.h
> >>>>>> +++ b/include/linux/virtio_net.h
> >>>>>> @@ -9,6 +9,194 @@
> >>>>>>     #include <uapi/linux/tcp.h>
> >>>>>>     #include <uapi/linux/virtio_net.h>
> >>>>>>
> >>>>>> +struct virtio_net_hash {
> >>>>>> +       u32 value;
> >>>>>> +       u16 report;
> >>>>>> +};
> >>>>>> +
> >>>>>> +struct virtio_net_toeplitz_state {
> >>>>>> +       u32 hash;
> >>>>>> +       const u32 *key;
> >>>>>> +};
> >>>>>> +
> >>>>>> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE=
_IPv4 | \
> >>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_=
TCPv4 | \
> >>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_=
UDPv4 | \
> >>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_=
IPv6 | \
> >>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_=
TCPv6 | \
> >>>>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_=
UDPv6)
> >>>>>> +
> >>>>>> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
> >>>>>> +
> >>>>>> +static inline void virtio_net_toeplitz_convert_key(u32 *input, si=
ze_t len)
> >>>>>> +{
> >>>>>> +       while (len >=3D sizeof(*input)) {
> >>>>>> +               *input =3D be32_to_cpu((__force __be32)*input);
> >>>>>> +               input++;
> >>>>>> +               len -=3D sizeof(*input);
> >>>>>> +       }
> >>>>>> +}
> >>>>>> +
> >>>>>> +static inline void virtio_net_toeplitz_calc(struct virtio_net_toe=
plitz_state *state,
> >>>>>> +                                           const __be32 *input, s=
ize_t len)
> >>>>>> +{
> >>>>>> +       while (len >=3D sizeof(*input)) {
> >>>>>> +               for (u32 map =3D be32_to_cpu(*input); map; map &=
=3D (map - 1)) {
> >>>>>> +                       u32 i =3D ffs(map);
> >>>>>> +
> >>>>>> +                       state->hash ^=3D state->key[0] << (32 - i)=
 |
> >>>>>> +                                      (u32)((u64)state->key[1] >>=
 i);
> >>>>>> +               }
> >>>>>> +
> >>>>>> +               state->key++;
> >>>>>> +               input++;
> >>>>>> +               len -=3D sizeof(*input);
> >>>>>> +       }
> >>>>>> +}
> >>>>>> +
> >>>>>> +static inline u8 virtio_net_hash_key_length(u32 types)
> >>>>>> +{
> >>>>>> +       size_t len =3D 0;
> >>>>>> +
> >>>>>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv4)
> >>>>>> +               len =3D max(len,
> >>>>>> +                         sizeof(struct flow_dissector_key_ipv4_ad=
drs));
> >>>>>> +
> >>>>>> +       if (types &
> >>>>>> +           (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT=
_UDPv4))
> >>>>>> +               len =3D max(len,
> >>>>>> +                         sizeof(struct flow_dissector_key_ipv4_ad=
drs) +
> >>>>>> +                         sizeof(struct flow_dissector_key_ports))=
;
> >>>>>> +
> >>>>>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv6)
> >>>>>> +               len =3D max(len,
> >>>>>> +                         sizeof(struct flow_dissector_key_ipv6_ad=
drs));
> >>>>>> +
> >>>>>> +       if (types &
> >>>>>> +           (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT=
_UDPv6))
> >>>>>> +               len =3D max(len,
> >>>>>> +                         sizeof(struct flow_dissector_key_ipv6_ad=
drs) +
> >>>>>> +                         sizeof(struct flow_dissector_key_ports))=
;
> >>>>>> +
> >>>>>> +       return len + sizeof(u32);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static inline u32 virtio_net_hash_report(u32 types,
> >>>>>> +                                        const struct flow_keys_ba=
sic *keys)
> >>>>>> +{
> >>>>>> +       switch (keys->basic.n_proto) {
> >>>>>> +       case cpu_to_be16(ETH_P_IP):
> >>>>>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT))=
 {
> >>>>>> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_TC=
P &&
> >>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv=
4))
> >>>>>> +                               return VIRTIO_NET_HASH_REPORT_TCPv=
4;
> >>>>>> +
> >>>>>> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_UD=
P &&
> >>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv=
4))
> >>>>>> +                               return VIRTIO_NET_HASH_REPORT_UDPv=
4;
> >>>>>> +               }
> >>>>>> +
> >>>>>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
> >>>>>> +                       return VIRTIO_NET_HASH_REPORT_IPv4;
> >>>>>> +
> >>>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
> >>>>>> +
> >>>>>> +       case cpu_to_be16(ETH_P_IPV6):
> >>>>>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT))=
 {
> >>>>>> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_TC=
P &&
> >>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv=
6))
> >>>>>> +                               return VIRTIO_NET_HASH_REPORT_TCPv=
6;
> >>>>>> +
> >>>>>> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_UD=
P &&
> >>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv=
6))
> >>>>>> +                               return VIRTIO_NET_HASH_REPORT_UDPv=
6;
> >>>>>> +               }
> >>>>>> +
> >>>>>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
> >>>>>> +                       return VIRTIO_NET_HASH_REPORT_IPv6;
> >>>>>> +
> >>>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
> >>>>>> +
> >>>>>> +       default:
> >>>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
> >>>>>> +       }
> >>>>>> +}
> >>>>>> +
> >>>>>> +static inline void virtio_net_hash_rss(const struct sk_buff *skb,
> >>>>>> +                                      u32 types, const u32 *key,
> >>>>>> +                                      struct virtio_net_hash *has=
h)
> >>>>>> +{
> >>>>>> +       struct virtio_net_toeplitz_state toeplitz_state =3D { .key=
 =3D key };
> >>>>>> +       struct flow_keys flow;
> >>>>>> +       struct flow_keys_basic flow_basic;
> >>>>>> +       u16 report;
> >>>>>> +
> >>>>>> +       if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
> >>>>>> +               hash->report =3D VIRTIO_NET_HASH_REPORT_NONE;
> >>>>>> +               return;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       flow_basic =3D (struct flow_keys_basic) {
> >>>>>> +               .control =3D flow.control,
> >>>>>> +               .basic =3D flow.basic
> >>>>>> +       };
> >>>>>> +
> >>>>>> +       report =3D virtio_net_hash_report(types, &flow_basic);
> >>>>>> +
> >>>>>> +       switch (report) {
> >>>>>> +       case VIRTIO_NET_HASH_REPORT_IPv4:
> >>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>>>> +                                        (__be32 *)&flow.addrs.v4a=
ddrs,
> >>>>>> +                                        sizeof(flow.addrs.v4addrs=
));
> >>>>>> +               break;
> >>>>>> +
> >>>>>> +       case VIRTIO_NET_HASH_REPORT_TCPv4:
> >>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>>>> +                                        (__be32 *)&flow.addrs.v4a=
ddrs,
> >>>>>> +                                        sizeof(flow.addrs.v4addrs=
));
> >>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.po=
rts.ports,
> >>>>>> +                                        sizeof(flow.ports.ports))=
;
> >>>>>> +               break;
> >>>>>> +
> >>>>>> +       case VIRTIO_NET_HASH_REPORT_UDPv4:
> >>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>>>> +                                        (__be32 *)&flow.addrs.v4a=
ddrs,
> >>>>>> +                                        sizeof(flow.addrs.v4addrs=
));
> >>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.po=
rts.ports,
> >>>>>> +                                        sizeof(flow.ports.ports))=
;
> >>>>>> +               break;
> >>>>>> +
> >>>>>> +       case VIRTIO_NET_HASH_REPORT_IPv6:
> >>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>>>> +                                        (__be32 *)&flow.addrs.v6a=
ddrs,
> >>>>>> +                                        sizeof(flow.addrs.v6addrs=
));
> >>>>>> +               break;
> >>>>>> +
> >>>>>> +       case VIRTIO_NET_HASH_REPORT_TCPv6:
> >>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>>>> +                                        (__be32 *)&flow.addrs.v6a=
ddrs,
> >>>>>> +                                        sizeof(flow.addrs.v6addrs=
));
> >>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.po=
rts.ports,
> >>>>>> +                                        sizeof(flow.ports.ports))=
;
> >>>>>> +               break;
> >>>>>> +
> >>>>>> +       case VIRTIO_NET_HASH_REPORT_UDPv6:
> >>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>>>> +                                        (__be32 *)&flow.addrs.v6a=
ddrs,
> >>>>>> +                                        sizeof(flow.addrs.v6addrs=
));
> >>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.po=
rts.ports,
> >>>>>> +                                        sizeof(flow.ports.ports))=
;
> >>>>>> +               break;
> >>>>>> +
> >>>>>> +       default:
> >>>>>> +               hash->report =3D VIRTIO_NET_HASH_REPORT_NONE;
> >>>>>> +               return;
> >>>>>
> >>>>> So I still think we need a comment here to explain why this is not =
an
> >>>>> issue if the device can report HASH_XXX_EX. Or we need to add the
> >>>>> support, since this is the code from the driver side, I don't think=
 we
> >>>>> need to worry about the device implementation issues.
> >>>>
> >>>> This is on the device side, and don't report HASH_TYPE_XXX_EX.
> >>>>
> >>>>>
> >>>>> For the issue of the number of options, does the spec forbid fallba=
ck
> >>>>> to VIRTIO_NET_HASH_REPORT_NONE? If not, we can do that.
> >>>>
> >>>> 5.1.6.4.3.4 "IPv6 packets with extension header" says:
> >>>>    > If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet has a TCPv=
6
> >>>>    > header, the hash is calculated over the following fields:
> >>>>    > - Home address from the home address option in the IPv6 destina=
tion
> >>>>    >   options header. If the extension header is not present, use t=
he
> >>>>    >   Source IPv6 address.
> >>>>    > - IPv6 address that is contained in the Routing-Header-Type-2 f=
rom the
> >>>>    >   associated extension header. If the extension header is not p=
resent,
> >>>>    >   use the Destination IPv6 address.
> >>>>    > - Source TCP port
> >>>>    > - Destination TCP port
> >>>>
> >>>> Therefore, if VIRTIO_NET_HASH_TYPE_TCP_EX is set, the packet has a T=
CPv6
> >>>> and an home address option in the IPv6 destination options header is
> >>>> present, the hash is calculated over the home address. If the hash i=
s
> >>>> not calculated over the home address in such a case, the device is
> >>>> contradicting with this section and violating the spec. The same goe=
s
> >>>> for the other HASH_TYPE_XXX_EX types and Routing-Header-Type-2.
> >>>
> >>> Just to make sure we are one the same page. I meant:
> >>>
> >>> 1) If the hash is not calculated over the home address (in the case o=
f
> >>> IPv6 destination destination), it can still report
> >>> VIRTIO_NET_RSS_HASH_TYPE_IPv6. This is what you implemented in your
> >>> series. So the device can simply fallback to e.g TCPv6 if it can't
> >>> understand all or part of the IPv6 options.
> >>
> >> The spec says it can fallback if "the extension header is not present"=
,
> >> not if the device can't understand the extension header.
> >
> > I don't think so,
> >
> > 1) spec had a condition beforehand:
> >
> > """
> > If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet has a TCPv6
> > header, the hash is calculated over the following fields:
> > ...
> > If the extension header is not present ...
> > """
> >
> > So the device can choose not to set VIRTIO_NET_HASH_TYPE_TCP_EX as
> > spec doesn't say device MUST set VIRTIO_NET_HASH_TYPE_TCP_EX if ...
> >
> > 2) implementation wise, since device has limited resources, we can't
> > expect the device can parse arbitrary number of ipv6 options
> >
> > 3) if 1) and 2) not the case, we need fix the spec otherwise implement
> > a spec compliant device is impractical
>
> The statement is preceded by the following:
>  >  The device calculates the hash on IPv4 packets according to
>  > =E2=80=99Enabled hash types=E2=80=99 bitmask as follows:
>
> The 'Enabled hash types' bitmask is specified by the device.
>
> I think the spec needs amendment.

Michael, can you help to clarify here?

>
> I wonder if there are any people interested in the feature though.
> Looking at virtnet_set_hashflow() in drivers/net/virtio_net.c, the
> driver of Linux does not let users configure HASH_TYPE_XXX_EX. I suppose
> Windows supports HASH_TYPE_XXX_EX, but those who care network
> performance most would use Linux so HASH_TYPE_XXX_EX support without
> Linux driver's support may not be useful.

It might be still interesting for example for the hardware virtio
vendors to support windows etc.

>
> >
> >>
> >>> 2) the VIRTIO_NET_SUPPORTED_HASH_TYPES is not checked against the
> >>> tun_vnet_ioctl_sethash(), so userspace may set
> >>> VIRTIO_NET_HASH_TYPE_TCP_EX regardless of what has been returned by
> >>> tun_vnet_ioctl_gethashtypes(). In this case they won't get
> >>> VIRTIO_NET_HASH_TYPE_TCP_EX.
> >>
> >> That's right. It's the responsibility of the userspace to set only the
> >> supported hash types.
> >
> > Well, the kernel should filter out the unsupported one to have a
> > robust uAPI. Otherwise, we give green light to the buggy userspace
> > which will have unexpected results.
>
> My reasoning was that it may be fine for some use cases other than VM
> (e.g., DPDK); in such a use case, it is fine as long as the UAPI works
> in the best-effort basis.

Best-effort might increase the chance for user visisable changes after
migration.

>
> For example, suppose a userspace program that processes TCP packets; the
> program can enable: HASH_TYPE_IPv4, HASH_TYPE_TCPv4, HASH_TYPE_IPv6, and
> HASH_TYPE_TCPv6. Ideally, the kernel should support all the hash types,
> but, even if e.g., HASH_TYPE_TCPv6 is not available,

For "available" did you mean it is not supported by the device?

> it will fall back
> to HASH_TYPE_IPv6, which still does something good and may be acceptable.

This fallback is exactly the same as I said above, let
VIRTIO_NET_HASH_TYPE_TCP_EX to fallback.

My point is that, the implementation should either:

1) allow fallback so it can claim to support all hash types

or

2) don't allow fallback so it can only support a part of the hash types

If we're doing something in the middle, for example, allow part of the
type to fallback.

>
> That said, for a use case that involves VM and implements virtio-net
> (e.g., QEMU), setting an unsupported hash type here is definitely a bug.
> Catching the bug may outweigh the extra trouble for other use cases.
>
> >
> >>
> >>> 3) implementing part of the hash types might complicate the migration
> >>> or at least we need to describe the expectations of libvirt or other
> >>> management in this case. For example, do we plan to have a dedicated
> >>> Qemu command line like:
> >>>
> >>> -device virtio-net-pci,hash_report=3Don,supported_hash_types=3DX,Y,Z?
> >>
> >> I posted a patch series to implement such a command line for vDPA[1].
> >> The patch series that wires this tuntap feature up[2] reuses the
> >> infrastructure so it doesn't bring additional complexity.
> >>
> >> [1]
> >> https://lore.kernel.org/qemu-devel/20250530-vdpa-v1-0-5af4109b1c19@day=
nix.com/
> >> [2]
> >> https://lore.kernel.org/qemu-devel/20250530-hash-v5-0-343d7d7a8200@day=
nix.com/
> >
> > I meant, if we implement a full hash report feature, it means a single
> > hash cmdline option is more than sufficient and so compatibility code
> > can just turn it off when dealing with machine types. This is much
> > more simpler than
> >
> > 1) having both hash as well as supported_hash_features
> > 2) dealing both hash as well as supported_hash_features in compatibilit=
y codes
> > 3) libvirt will be happy
> >
> > For [1], it seems it introduces a per has type option, this seems to
> > be a burden to the management layer as it need to learn new option
> > everytime a new hash type is supported
>
> Even with the command line you proposed (supported_hash_types=3DX,Y,Z), i=
t
> is still necessary to know the values the supported_hash_types property
> accepts (X.Y,Z), so I don't think it makes difference.

It could be a uint32_t.

>
> The burden to the management layer is already present for features, so
> it is an existing problem (or its mere extension).

Yes, but since this feature is new it's better to try our best to avoid tha=
t.

>
> This problem was discussed in the following thread in the past, but no
> solution is implemented yet, and probably solving it will be difficult.
> https://lore.kernel.org/qemu-devel/20230731223148.1002258-5-yuri.benditov=
ich@daynix.com/

It's a similar issue but not the same, it looks more like a discussion
on whether the fallback from vhost-net to qemu works for missing
features etc.

Thanks

>
> Regards,
> Akihiko Odaki
>


