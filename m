Return-Path: <linux-kselftest+bounces-35161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5AFADBFDD
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 05:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB3916489B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 03:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498E1217F55;
	Tue, 17 Jun 2025 03:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEY/SLbi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2B194A65
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 03:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750130925; cv=none; b=VA/i1fgf+C/atJejqQQG43N+lKyPyNg4sklgFSf0QppOtsSVIE3+4/SiAvpzc1Mp929CWC83lB+D+oYtaLKTRo3cKvfH6mJ/9SH9p47ugb9SUWKsFBt8zneb+kTIPni3lk6ppP2+LykrCiX7FdWS1Pr9JIJzPqCH93bWGrmEfo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750130925; c=relaxed/simple;
	bh=D3IkZ7iI4qZeGc4JUt8yZukT8YMHbcG+JkA3RwAVHdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRtuW1kRioau1aqBJyngHN0vnNpvHxLqKsVReBFGpOXWVjuFA82/tVOz0rZmiCH1rrD3AeYA9mb5Bx9qcpv4uwHt+iX1PAZxm5dKCrh5d1fjAib4en9nFFclEjUUPMHvXKoteYfMw27q6TDQhZTcWqrOp5QpDkJ9LfuO8de3KMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LEY/SLbi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750130921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZnjLocapY1GDtsVX0XE+EGlfXbZ9yLF/3jYtxyATXo=;
	b=LEY/SLbi9d9E0EKN5lPaAa+ryyYD8cVjvXbTkMmotV9G3b+xuXD/G2dQbXDe2XYpW+Uywg
	l5VCVysIVsZQLmsLW24sdRrkQ/U23ZKfaqLjwUdhK6io8MFR21TYd94LoJMiltokjcXJnM
	RhRdIXgV3wsSTh0ijrBKYsvLBMK4GuA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-K2l_c0aCPTWfcNtxmQ9msA-1; Mon, 16 Jun 2025 23:28:40 -0400
X-MC-Unique: K2l_c0aCPTWfcNtxmQ9msA-1
X-Mimecast-MFC-AGG-ID: K2l_c0aCPTWfcNtxmQ9msA_1750130919
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b26e73d375aso5545835a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 20:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750130919; x=1750735719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZnjLocapY1GDtsVX0XE+EGlfXbZ9yLF/3jYtxyATXo=;
        b=GXEkFYGeiHhs75oBqKPTvOFUejLBqOv/Mi37HuuiQKKBmI6SLk21uPbVKkKCxl0usU
         6t1eAdJUMDNQtehGLgo+ukgoSB7I4R0Uz4rB772cWEK+oHafN1IRDhnXZE0OiiSni75W
         S4/zrHkR6RxXwumuJLcV317Zh/U2+wbrWliYuNYXOuwJQkp2sJ0UoaTckDNmg3Vj7oQe
         uAsm6mhpQBfOxqHlM2xWtyzBbvYWpXqSyYoZjenHIGh6dskSEIXPGHbO00TGd61YlTK2
         ELvStvzp8/W73kzejSAC/4h2f705UpHAfEe3DQ04DlI9bcmhsZL2GPm3+EZgD0LAl3zf
         eE8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVQRff5UjwI+H91sWjWa+D6xqHok4O1ecvyaOucjOhmRkdtz6G+vHmPfOThlQ+8hFrNxc3nJU17z2IYQEl2wE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsRXSXanJftBtoNsRlEIQHjqXo+y88asbFNH1F3x9/f+VSjLmJ
	BKMl2Ti3/cDfShphHzZCNJraJasqN8e0gbpRGAzhxFS/XWX+iG1vA3fCgbhMM6rgeU2jDmvbfC8
	W04JfZMpd/GI/8cNxt7HjGHgMCgdxBdGgwtnhObrDkD9VWOBFDjtzcQboKIG8VfwoO7HR7i/AmX
	H25j0+O0MFbqc7cTBkrXhWN2otpsVBcuOLpVxOqQoD0u/W
X-Gm-Gg: ASbGncvarlpV2Wa2jhthgYFhroR7N2wZNDPkrLzDlLDL5Pgoc7BTl2H8NgyVWzywwAQ
	P+WF+dxaI6znkxhN11hI/LDrqP6hX2JY47XU3bI1Wmnnb8GpaUr/P/ibVlFucRPTIqtYTW1Adp7
	o1DCmt
X-Received: by 2002:a05:6a20:9f48:b0:215:de13:e212 with SMTP id adf61e73a8af0-21fbd4bbebemr18475188637.15.1750130918911;
        Mon, 16 Jun 2025 20:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGojw2ZaoSQc7LcnecH8We8ufRtfHIeDRaftsdYUa9/oGmMTDfgHybQ3gnppKJHWwNG36xG8kElsRKXtsoFLHM=
X-Received: by 2002:a05:6a20:9f48:b0:215:de13:e212 with SMTP id
 adf61e73a8af0-21fbd4bbebemr18475139637.15.1750130918331; Mon, 16 Jun 2025
 20:28:38 -0700 (PDT)
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
 <75ef190e-49fc-48aa-abf2-579ea31e4d15@daynix.com> <CACGkMEu2n-O0UtVEmcPkELcg9gpML=m5W=qYPjeEjp3ba73Eiw@mail.gmail.com>
 <760e9154-3440-464f-9b82-5a0c66f482ee@daynix.com>
In-Reply-To: <760e9154-3440-464f-9b82-5a0c66f482ee@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Jun 2025 11:28:26 +0800
X-Gm-Features: AX0GCFu7C79F_NF_tsdftJB3uWwwAlsfeJAmSIVcZ0cQgWARIymF17AjoTvBB_A
Message-ID: <CACGkMEtCr65RFB0jeprX3iQ3ke997AWF0FGH6JW_zuJOLqS5uw@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Andrew Melnychenko <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 5:10=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2025/06/06 9:48, Jason Wang wrote:
> > On Thu, Jun 5, 2025 at 3:58=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> On 2025/06/05 10:53, Jason Wang wrote:
> >>> On Wed, Jun 4, 2025 at 3:20=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> On 2025/06/04 10:18, Jason Wang wrote:
> >>>>> On Tue, Jun 3, 2025 at 1:31=E2=80=AFPM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>>>
> >>>>>> On 2025/06/03 12:19, Jason Wang wrote:
> >>>>>>> On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.o=
daki@daynix.com> wrote:
> >>>>>>>>
> >>>>>>>> They are useful to implement VIRTIO_NET_F_RSS and
> >>>>>>>> VIRTIO_NET_F_HASH_REPORT.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>>>>>> ---
> >>>>>>>>      include/linux/virtio_net.h | 188 ++++++++++++++++++++++++++=
+++++++++++++++++++
> >>>>>>>>      1 file changed, 188 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_n=
et.h
> >>>>>>>> index 02a9f4dc594d..426f33b4b824 100644
> >>>>>>>> --- a/include/linux/virtio_net.h
> >>>>>>>> +++ b/include/linux/virtio_net.h
> >>>>>>>> @@ -9,6 +9,194 @@
> >>>>>>>>      #include <uapi/linux/tcp.h>
> >>>>>>>>      #include <uapi/linux/virtio_net.h>
> >>>>>>>>
> >>>>>>>> +struct virtio_net_hash {
> >>>>>>>> +       u32 value;
> >>>>>>>> +       u16 report;
> >>>>>>>> +};
> >>>>>>>> +
> >>>>>>>> +struct virtio_net_toeplitz_state {
> >>>>>>>> +       u32 hash;
> >>>>>>>> +       const u32 *key;
> >>>>>>>> +};
> >>>>>>>> +
> >>>>>>>> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TY=
PE_IPv4 | \
> >>>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYP=
E_TCPv4 | \
> >>>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYP=
E_UDPv4 | \
> >>>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYP=
E_IPv6 | \
> >>>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYP=
E_TCPv6 | \
> >>>>>>>> +                                        VIRTIO_NET_RSS_HASH_TYP=
E_UDPv6)
> >>>>>>>> +
> >>>>>>>> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
> >>>>>>>> +
> >>>>>>>> +static inline void virtio_net_toeplitz_convert_key(u32 *input, =
size_t len)
> >>>>>>>> +{
> >>>>>>>> +       while (len >=3D sizeof(*input)) {
> >>>>>>>> +               *input =3D be32_to_cpu((__force __be32)*input);
> >>>>>>>> +               input++;
> >>>>>>>> +               len -=3D sizeof(*input);
> >>>>>>>> +       }
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static inline void virtio_net_toeplitz_calc(struct virtio_net_t=
oeplitz_state *state,
> >>>>>>>> +                                           const __be32 *input,=
 size_t len)
> >>>>>>>> +{
> >>>>>>>> +       while (len >=3D sizeof(*input)) {
> >>>>>>>> +               for (u32 map =3D be32_to_cpu(*input); map; map &=
=3D (map - 1)) {
> >>>>>>>> +                       u32 i =3D ffs(map);
> >>>>>>>> +
> >>>>>>>> +                       state->hash ^=3D state->key[0] << (32 - =
i) |
> >>>>>>>> +                                      (u32)((u64)state->key[1] =
>> i);
> >>>>>>>> +               }
> >>>>>>>> +
> >>>>>>>> +               state->key++;
> >>>>>>>> +               input++;
> >>>>>>>> +               len -=3D sizeof(*input);
> >>>>>>>> +       }
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static inline u8 virtio_net_hash_key_length(u32 types)
> >>>>>>>> +{
> >>>>>>>> +       size_t len =3D 0;
> >>>>>>>> +
> >>>>>>>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv4)
> >>>>>>>> +               len =3D max(len,
> >>>>>>>> +                         sizeof(struct flow_dissector_key_ipv4_=
addrs));
> >>>>>>>> +
> >>>>>>>> +       if (types &
> >>>>>>>> +           (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPO=
RT_UDPv4))
> >>>>>>>> +               len =3D max(len,
> >>>>>>>> +                         sizeof(struct flow_dissector_key_ipv4_=
addrs) +
> >>>>>>>> +                         sizeof(struct flow_dissector_key_ports=
));
> >>>>>>>> +
> >>>>>>>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv6)
> >>>>>>>> +               len =3D max(len,
> >>>>>>>> +                         sizeof(struct flow_dissector_key_ipv6_=
addrs));
> >>>>>>>> +
> >>>>>>>> +       if (types &
> >>>>>>>> +           (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPO=
RT_UDPv6))
> >>>>>>>> +               len =3D max(len,
> >>>>>>>> +                         sizeof(struct flow_dissector_key_ipv6_=
addrs) +
> >>>>>>>> +                         sizeof(struct flow_dissector_key_ports=
));
> >>>>>>>> +
> >>>>>>>> +       return len + sizeof(u32);
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static inline u32 virtio_net_hash_report(u32 types,
> >>>>>>>> +                                        const struct flow_keys_=
basic *keys)
> >>>>>>>> +{
> >>>>>>>> +       switch (keys->basic.n_proto) {
> >>>>>>>> +       case cpu_to_be16(ETH_P_IP):
> >>>>>>>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT=
)) {
> >>>>>>>> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_=
TCP &&
> >>>>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TC=
Pv4))
> >>>>>>>> +                               return VIRTIO_NET_HASH_REPORT_TC=
Pv4;
> >>>>>>>> +
> >>>>>>>> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_=
UDP &&
> >>>>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UD=
Pv4))
> >>>>>>>> +                               return VIRTIO_NET_HASH_REPORT_UD=
Pv4;
> >>>>>>>> +               }
> >>>>>>>> +
> >>>>>>>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
> >>>>>>>> +                       return VIRTIO_NET_HASH_REPORT_IPv4;
> >>>>>>>> +
> >>>>>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
> >>>>>>>> +
> >>>>>>>> +       case cpu_to_be16(ETH_P_IPV6):
> >>>>>>>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT=
)) {
> >>>>>>>> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_=
TCP &&
> >>>>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TC=
Pv6))
> >>>>>>>> +                               return VIRTIO_NET_HASH_REPORT_TC=
Pv6;
> >>>>>>>> +
> >>>>>>>> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_=
UDP &&
> >>>>>>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UD=
Pv6))
> >>>>>>>> +                               return VIRTIO_NET_HASH_REPORT_UD=
Pv6;
> >>>>>>>> +               }
> >>>>>>>> +
> >>>>>>>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
> >>>>>>>> +                       return VIRTIO_NET_HASH_REPORT_IPv6;
> >>>>>>>> +
> >>>>>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
> >>>>>>>> +
> >>>>>>>> +       default:
> >>>>>>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
> >>>>>>>> +       }
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static inline void virtio_net_hash_rss(const struct sk_buff *sk=
b,
> >>>>>>>> +                                      u32 types, const u32 *key=
,
> >>>>>>>> +                                      struct virtio_net_hash *h=
ash)
> >>>>>>>> +{
> >>>>>>>> +       struct virtio_net_toeplitz_state toeplitz_state =3D { .k=
ey =3D key };
> >>>>>>>> +       struct flow_keys flow;
> >>>>>>>> +       struct flow_keys_basic flow_basic;
> >>>>>>>> +       u16 report;
> >>>>>>>> +
> >>>>>>>> +       if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
> >>>>>>>> +               hash->report =3D VIRTIO_NET_HASH_REPORT_NONE;
> >>>>>>>> +               return;
> >>>>>>>> +       }
> >>>>>>>> +
> >>>>>>>> +       flow_basic =3D (struct flow_keys_basic) {
> >>>>>>>> +               .control =3D flow.control,
> >>>>>>>> +               .basic =3D flow.basic
> >>>>>>>> +       };
> >>>>>>>> +
> >>>>>>>> +       report =3D virtio_net_hash_report(types, &flow_basic);
> >>>>>>>> +
> >>>>>>>> +       switch (report) {
> >>>>>>>> +       case VIRTIO_NET_HASH_REPORT_IPv4:
> >>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>>>>>> +                                        (__be32 *)&flow.addrs.v=
4addrs,
> >>>>>>>> +                                        sizeof(flow.addrs.v4add=
rs));
> >>>>>>>> +               break;
> >>>>>>>> +
> >>>>>>>> +       case VIRTIO_NET_HASH_REPORT_TCPv4:
> >>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>>>>>> +                                        (__be32 *)&flow.addrs.v=
4addrs,
> >>>>>>>> +                                        sizeof(flow.addrs.v4add=
rs));
> >>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.=
ports.ports,
> >>>>>>>> +                                        sizeof(flow.ports.ports=
));
> >>>>>>>> +               break;
> >>>>>>>> +
> >>>>>>>> +       case VIRTIO_NET_HASH_REPORT_UDPv4:
> >>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>>>>>> +                                        (__be32 *)&flow.addrs.v=
4addrs,
> >>>>>>>> +                                        sizeof(flow.addrs.v4add=
rs));
> >>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.=
ports.ports,
> >>>>>>>> +                                        sizeof(flow.ports.ports=
));
> >>>>>>>> +               break;
> >>>>>>>> +
> >>>>>>>> +       case VIRTIO_NET_HASH_REPORT_IPv6:
> >>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>>>>>> +                                        (__be32 *)&flow.addrs.v=
6addrs,
> >>>>>>>> +                                        sizeof(flow.addrs.v6add=
rs));
> >>>>>>>> +               break;
> >>>>>>>> +
> >>>>>>>> +       case VIRTIO_NET_HASH_REPORT_TCPv6:
> >>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>>>>>> +                                        (__be32 *)&flow.addrs.v=
6addrs,
> >>>>>>>> +                                        sizeof(flow.addrs.v6add=
rs));
> >>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.=
ports.ports,
> >>>>>>>> +                                        sizeof(flow.ports.ports=
));
> >>>>>>>> +               break;
> >>>>>>>> +
> >>>>>>>> +       case VIRTIO_NET_HASH_REPORT_UDPv6:
> >>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>>>>>> +                                        (__be32 *)&flow.addrs.v=
6addrs,
> >>>>>>>> +                                        sizeof(flow.addrs.v6add=
rs));
> >>>>>>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.=
ports.ports,
> >>>>>>>> +                                        sizeof(flow.ports.ports=
));
> >>>>>>>> +               break;
> >>>>>>>> +
> >>>>>>>> +       default:
> >>>>>>>> +               hash->report =3D VIRTIO_NET_HASH_REPORT_NONE;
> >>>>>>>> +               return;
> >>>>>>>
> >>>>>>> So I still think we need a comment here to explain why this is no=
t an
> >>>>>>> issue if the device can report HASH_XXX_EX. Or we need to add the
> >>>>>>> support, since this is the code from the driver side, I don't thi=
nk we
> >>>>>>> need to worry about the device implementation issues.
> >>>>>>
> >>>>>> This is on the device side, and don't report HASH_TYPE_XXX_EX.
> >>>>>>
> >>>>>>>
> >>>>>>> For the issue of the number of options, does the spec forbid fall=
back
> >>>>>>> to VIRTIO_NET_HASH_REPORT_NONE? If not, we can do that.
> >>>>>>
> >>>>>> 5.1.6.4.3.4 "IPv6 packets with extension header" says:
> >>>>>>     > If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet has a T=
CPv6
> >>>>>>     > header, the hash is calculated over the following fields:
> >>>>>>     > - Home address from the home address option in the IPv6 dest=
ination
> >>>>>>     >   options header. If the extension header is not present, us=
e the
> >>>>>>     >   Source IPv6 address.
> >>>>>>     > - IPv6 address that is contained in the Routing-Header-Type-=
2 from the
> >>>>>>     >   associated extension header. If the extension header is no=
t present,
> >>>>>>     >   use the Destination IPv6 address.
> >>>>>>     > - Source TCP port
> >>>>>>     > - Destination TCP port
> >>>>>>
> >>>>>> Therefore, if VIRTIO_NET_HASH_TYPE_TCP_EX is set, the packet has a=
 TCPv6
> >>>>>> and an home address option in the IPv6 destination options header =
is
> >>>>>> present, the hash is calculated over the home address. If the hash=
 is
> >>>>>> not calculated over the home address in such a case, the device is
> >>>>>> contradicting with this section and violating the spec. The same g=
oes
> >>>>>> for the other HASH_TYPE_XXX_EX types and Routing-Header-Type-2.
> >>>>>
> >>>>> Just to make sure we are one the same page. I meant:
> >>>>>
> >>>>> 1) If the hash is not calculated over the home address (in the case=
 of
> >>>>> IPv6 destination destination), it can still report
> >>>>> VIRTIO_NET_RSS_HASH_TYPE_IPv6. This is what you implemented in your
> >>>>> series. So the device can simply fallback to e.g TCPv6 if it can't
> >>>>> understand all or part of the IPv6 options.
> >>>>
> >>>> The spec says it can fallback if "the extension header is not presen=
t",
> >>>> not if the device can't understand the extension header.
> >>>
> >>> I don't think so,
> >>>
> >>> 1) spec had a condition beforehand:
> >>>
> >>> """
> >>> If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet has a TCPv6
> >>> header, the hash is calculated over the following fields:
> >>> ...
> >>> If the extension header is not present ...
> >>> """
> >>>
> >>> So the device can choose not to set VIRTIO_NET_HASH_TYPE_TCP_EX as
> >>> spec doesn't say device MUST set VIRTIO_NET_HASH_TYPE_TCP_EX if ...
> >>>
> >>> 2) implementation wise, since device has limited resources, we can't
> >>> expect the device can parse arbitrary number of ipv6 options
> >>>
> >>> 3) if 1) and 2) not the case, we need fix the spec otherwise implemen=
t
> >>> a spec compliant device is impractical
> >>
> >> The statement is preceded by the following:
> >>   >  The device calculates the hash on IPv4 packets according to
> >>   > =E2=80=99Enabled hash types=E2=80=99 bitmask as follows:
> >>
> >> The 'Enabled hash types' bitmask is specified by the device.
> >>
> >> I think the spec needs amendment.
> >
> > Michael, can you help to clarify here?
> >
> >>
> >> I wonder if there are any people interested in the feature though.
> >> Looking at virtnet_set_hashflow() in drivers/net/virtio_net.c, the
> >> driver of Linux does not let users configure HASH_TYPE_XXX_EX. I suppo=
se
> >> Windows supports HASH_TYPE_XXX_EX, but those who care network
> >> performance most would use Linux so HASH_TYPE_XXX_EX support without
> >> Linux driver's support may not be useful.
> >
> > It might be still interesting for example for the hardware virtio
> > vendors to support windows etc.
>
> I don't know if Windows needs them for e.g., device/driver certification
> so surveying Windows makes sense.

Yuri, can you help to clarify this?

>
> >
> >>
> >>>
> >>>>
> >>>>> 2) the VIRTIO_NET_SUPPORTED_HASH_TYPES is not checked against the
> >>>>> tun_vnet_ioctl_sethash(), so userspace may set
> >>>>> VIRTIO_NET_HASH_TYPE_TCP_EX regardless of what has been returned by
> >>>>> tun_vnet_ioctl_gethashtypes(). In this case they won't get
> >>>>> VIRTIO_NET_HASH_TYPE_TCP_EX.
> >>>>
> >>>> That's right. It's the responsibility of the userspace to set only t=
he
> >>>> supported hash types.
> >>>
> >>> Well, the kernel should filter out the unsupported one to have a
> >>> robust uAPI. Otherwise, we give green light to the buggy userspace
> >>> which will have unexpected results.
> >>
> >> My reasoning was that it may be fine for some use cases other than VM
> >> (e.g., DPDK); in such a use case, it is fine as long as the UAPI works
> >> in the best-effort basis.
> >
> > Best-effort might increase the chance for user visisable changes after
> > migration.
>
> It is a trade-off between catching a migration bug for VMM and making
> life a bit easier for userspace programs other than VMM.

My understanding is to avoid breaking the migration compatibility as
much as possible as fixing that would be complicated or even
impossible.

>
> >
> >>
> >> For example, suppose a userspace program that processes TCP packets; t=
he
> >> program can enable: HASH_TYPE_IPv4, HASH_TYPE_TCPv4, HASH_TYPE_IPv6, a=
nd
> >> HASH_TYPE_TCPv6. Ideally, the kernel should support all the hash types=
,
> >> but, even if e.g., HASH_TYPE_TCPv6 is not available,
> >
> > For "available" did you mean it is not supported by the device?
> >
> >> it will fall back
> >> to HASH_TYPE_IPv6, which still does something good and may be acceptab=
le.
> >
> > This fallback is exactly the same as I said above, let
> > VIRTIO_NET_HASH_TYPE_TCP_EX to fallback.
> >
> > My point is that, the implementation should either:
> >
> > 1) allow fallback so it can claim to support all hash types
> >
> > or
> >
> > 2) don't allow fallback so it can only support a part of the hash types
> >
> > If we're doing something in the middle, for example, allow part of the
> > type to fallback.
>
> 1) or the middle will make it unsuitable for VM because it violates the
> virtio spec. 2) makes sense though the trade-off I mentioned should be
> taken into consideration.
>
> >
> >>
> >> That said, for a use case that involves VM and implements virtio-net
> >> (e.g., QEMU), setting an unsupported hash type here is definitely a bu=
g.
> >> Catching the bug may outweigh the extra trouble for other use cases.
> >>
> >>>
> >>>>
> >>>>> 3) implementing part of the hash types might complicate the migrati=
on
> >>>>> or at least we need to describe the expectations of libvirt or othe=
r
> >>>>> management in this case. For example, do we plan to have a dedicate=
d
> >>>>> Qemu command line like:
> >>>>>
> >>>>> -device virtio-net-pci,hash_report=3Don,supported_hash_types=3DX,Y,=
Z?
> >>>>
> >>>> I posted a patch series to implement such a command line for vDPA[1]=
.
> >>>> The patch series that wires this tuntap feature up[2] reuses the
> >>>> infrastructure so it doesn't bring additional complexity.
> >>>>
> >>>> [1]
> >>>> https://lore.kernel.org/qemu-devel/20250530-vdpa-v1-0-5af4109b1c19@d=
aynix.com/
> >>>> [2]
> >>>> https://lore.kernel.org/qemu-devel/20250530-hash-v5-0-343d7d7a8200@d=
aynix.com/
> >>>
> >>> I meant, if we implement a full hash report feature, it means a singl=
e
> >>> hash cmdline option is more than sufficient and so compatibility code
> >>> can just turn it off when dealing with machine types. This is much
> >>> more simpler than
> >>>
> >>> 1) having both hash as well as supported_hash_features
> >>> 2) dealing both hash as well as supported_hash_features in compatibil=
ity codes
> >>> 3) libvirt will be happy
> >>>
> >>> For [1], it seems it introduces a per has type option, this seems to
> >>> be a burden to the management layer as it need to learn new option
> >>> everytime a new hash type is supported
> >>
> >> Even with the command line you proposed (supported_hash_types=3DX,Y,Z)=
, it
> >> is still necessary to know the values the supported_hash_types propert=
y
> >> accepts (X.Y,Z), so I don't think it makes difference.
> >
> > It could be a uint32_t.
>
> The management layer will need to know what bits are accepted even with
> uint32_t.

Ease the management, basically it would be used by debugging or
machine type only.

>
> >
> >>
> >> The burden to the management layer is already present for features, so
> >> it is an existing problem (or its mere extension).
> >
> > Yes, but since this feature is new it's better to try our best to avoid=
 that.
> >
> >>
> >> This problem was discussed in the following thread in the past, but no
> >> solution is implemented yet, and probably solving it will be difficult=
.
> >> https://lore.kernel.org/qemu-devel/20230731223148.1002258-5-yuri.bendi=
tovich@daynix.com/
> >
> > It's a similar issue but not the same, it looks more like a discussion
> > on whether the fallback from vhost-net to qemu works for missing
> > features etc.
>
> Perhaps we may be able to do better since this feature is new as you say
> and we don't have to worry much about breaking change. I don't have an
> idea for that yet.

Right.

>
> Regards,
> Akihiko Odaki
>

Thanks


