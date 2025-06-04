Return-Path: <linux-kselftest+bounces-34268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD87ACD4C6
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 03:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBDE3A4580
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 01:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E55278F3A;
	Wed,  4 Jun 2025 01:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UinGPSTj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993731DDD1
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999927; cv=none; b=GHm9pwClYO1g5QMeePB5eo1CjtBFYAow5PuXJTcAwK4kd1aKNyqNS1AgxwbyquykXRybKPCw/skbr0YPCYjMeifs9iEVm5FqS2CXidEikocR2A4cQV69k8BqzgYwrCQldEqDWGEmDv9FyQmpr8zbeSUnDRo3lPPq5EG8J/p7Sj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999927; c=relaxed/simple;
	bh=TU5raU8CLI5e3LMHuVmzVjSuFh7aCubUMZ1v6HP3ni4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOhJC6C0PT0zFUL72HyBeeMcMQAL5bXVCOJFV3uvq5UiIkYbBkJ6C1kafFdxXw2pN7vlrbOkbT0yMYeM2QZ0Q7l8TV0cdksFjq4fAjkVy7R7gh/uhdo0rvxOe0+A557aakvB8knH6s0YK4c8X4wLK2p8Gw7VVQiYfckD/SbI8XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UinGPSTj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748999923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGSicdZ/oCg5lp+er2IEvl27RXvIulGaT4Ab9/IfYPs=;
	b=UinGPSTjeYwTNToKFpXOba9gtkV/Af3cAJ2Xc4fmR1zEJxkkk0wrlUNwQ9fjaqcjHmDZiy
	4HD/vBgPYku4OjR0hZ+Mi+GOzlgQaej2eruCI1SJBx0TzGZL6XeH3RWkwh8rEWOxZ1xcfd
	moWNf4Y1JWLIcQFSmGTcD9JYe1tIYMk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-rRQ44g8SN6uHjtG1OGvpXQ-1; Tue, 03 Jun 2025 21:18:42 -0400
X-MC-Unique: rRQ44g8SN6uHjtG1OGvpXQ-1
X-Mimecast-MFC-AGG-ID: rRQ44g8SN6uHjtG1OGvpXQ_1748999921
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7401179b06fso4795609b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 18:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748999921; x=1749604721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGSicdZ/oCg5lp+er2IEvl27RXvIulGaT4Ab9/IfYPs=;
        b=q5pNMOsW3Z3RQnjCP+yrQdWa3z0lzu3EjOoV4U36fGbbx/R097n8ur//5IMXycznyX
         rh4fZSqsTYLHeJJlphf1W7G/GYwRx/OKMzLfJ88mgm86ItDUexancfznXH6Bk/14gar0
         cO7HGk2M3YVnAHh1f3ohginB2MfaPtKZWprd/qhUC8hQuv93i1iKMvuv31XIj9SkJdvB
         2yIR+nI8ybB4JMMpdfJXZNf0pQMckhDGZH3XPjCmSSYFVLZS3Ci01g0lvhBVqJ2oGoJZ
         tBiif8n+yjASQR7GRJr31xejZ+uaJyZK30IV5WS/lZk3FqkWy9D47lXrnQu5J1j10DYn
         icOw==
X-Forwarded-Encrypted: i=1; AJvYcCVyMDntHlSXBQBp/b3ak+6FWgzpzWFwdDwG7QWqiy2Q5g6eJxA9WMQnoflcnZsL8uehoshLzpiqMrB5EdtKfDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyF7x1ODAq3yT1DqlUaGnTQukkmlN/baamRUMSQuoDKB+/U4Ym
	nj7k1kOzfqSCWIB2cQ6G/dB3/cJ9B/DAiewNrlhBsX77sYGDzPxECA03tJ+ZNZVbhFgVSy8WgTn
	bR392Ak/WazJFvZiWXeX/THC2D4EHup562pOhkBjCL4muYBleFQMN/kY1z90QNyRPISUxctzd4i
	LzK6Ct1I0wo+/IQtIP4Rw3wmuQ2uu3k9+25/eCUeliDRm2
X-Gm-Gg: ASbGncuDFaK/AZPgkVmBaivoiVsczleXL5v+r/HoJxq8tXOt2LlWRaZzJkDabV5Pe56
	PGBpTB1ka+tXw2vRkaBSAvbiY0TW0tk1wumajY2E2jP7tZDBZyxHowP5Ctj4iJqm/7OqIFlCJUu
	oc9nM1
X-Received: by 2002:a05:6a21:15c9:b0:203:addb:5a29 with SMTP id adf61e73a8af0-21d2478a934mr804226637.40.1748999921395;
        Tue, 03 Jun 2025 18:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9x2Jsz+oEkjdyApeUA+CuoK8myNpbDW4bJgTDO/ZV8ngn2BsxLUd0KXN3ouD9XKiPa4r78geNfVRdh7nw+0I=
X-Received: by 2002:a05:6a21:15c9:b0:203:addb:5a29 with SMTP id
 adf61e73a8af0-21d2478a934mr804171637.40.1748999920971; Tue, 03 Jun 2025
 18:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-1-95d8b348de91@daynix.com>
 <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com> <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com>
In-Reply-To: <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Jun 2025 09:18:29 +0800
X-Gm-Features: AX0GCFuo2dPa7ucM1Nh8rfxdTLetjqqveALggfJbyBjhCoXiIN_FHhv1NK0hF9M
Message-ID: <CACGkMEu6fZaErFEu7_UFsykXRL7Z+CwmkcxmvJHC+eN_j0pQvg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
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

On Tue, Jun 3, 2025 at 1:31=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2025/06/03 12:19, Jason Wang wrote:
> > On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
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
> >> index 02a9f4dc594d..426f33b4b824 100644
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
> >
> > So I still think we need a comment here to explain why this is not an
> > issue if the device can report HASH_XXX_EX. Or we need to add the
> > support, since this is the code from the driver side, I don't think we
> > need to worry about the device implementation issues.
>
> This is on the device side, and don't report HASH_TYPE_XXX_EX.
>
> >
> > For the issue of the number of options, does the spec forbid fallback
> > to VIRTIO_NET_HASH_REPORT_NONE? If not, we can do that.
>
> 5.1.6.4.3.4 "IPv6 packets with extension header" says:
>  > If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet has a TCPv6
>  > header, the hash is calculated over the following fields:
>  > - Home address from the home address option in the IPv6 destination
>  >   options header. If the extension header is not present, use the
>  >   Source IPv6 address.
>  > - IPv6 address that is contained in the Routing-Header-Type-2 from the
>  >   associated extension header. If the extension header is not present,
>  >   use the Destination IPv6 address.
>  > - Source TCP port
>  > - Destination TCP port
>
> Therefore, if VIRTIO_NET_HASH_TYPE_TCP_EX is set, the packet has a TCPv6
> and an home address option in the IPv6 destination options header is
> present, the hash is calculated over the home address. If the hash is
> not calculated over the home address in such a case, the device is
> contradicting with this section and violating the spec. The same goes
> for the other HASH_TYPE_XXX_EX types and Routing-Header-Type-2.

Just to make sure we are one the same page. I meant:

1) If the hash is not calculated over the home address (in the case of
IPv6 destination destination), it can still report
VIRTIO_NET_RSS_HASH_TYPE_IPv6. This is what you implemented in your
series. So the device can simply fallback to e.g TCPv6 if it can't
understand all or part of the IPv6 options.
2) the VIRTIO_NET_SUPPORTED_HASH_TYPES is not checked against the
tun_vnet_ioctl_sethash(), so userspace may set
VIRTIO_NET_HASH_TYPE_TCP_EX regardless of what has been returned by
tun_vnet_ioctl_gethashtypes(). In this case they won't get
VIRTIO_NET_HASH_TYPE_TCP_EX.
3) implementing part of the hash types might complicate the migration
or at least we need to describe the expectations of libvirt or other
management in this case. For example, do we plan to have a dedicated
Qemu command line like:

-device virtio-net-pci,hash_report=3Don,supported_hash_types=3DX,Y,Z?

Thanks

>
> Regards,
> Akihiko Odaki
>


