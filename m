Return-Path: <linux-kselftest+bounces-34352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A74EACE80B
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 03:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA7B1727BB
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 01:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19E71D63F2;
	Thu,  5 Jun 2025 01:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9P73MDo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFD71B85CC
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Jun 2025 01:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749088453; cv=none; b=lfnMV8EMJNQwWkCzGbjW+W3lPrMMWSwltJTM5pSOBpRQ3kLsOfldBXBZczS/rgCBQRol8DOV3bs50wyw1qoBQzyWjc3Kjm41EUMPyMkyCa+X9O/ONvdKExbYtzO8PT3+kojgbNJ/aKZTcK/3gCboafKFiW8b18Y+KDbU0KVjda8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749088453; c=relaxed/simple;
	bh=vQTwx8rjcXn0A4riGtEhQ1K3L41kSXoaebSKay+4t4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zzu1/bDobM5oZW6AnE6bxHhnI8I90dY72Mmh4Z9xpSVqYUfcBNkWJPRtLiAR5DLOWjB2JJjPgc+XNv4++IwOXfHR35NxN45I/yRP2PijtuDMN3PQtUcwUue0j0KCJD8Ep7kbRXE9eCxtxjvoXmBSSLjOjoLAUV0Ob9dFK0zeMkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9P73MDo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749088447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BC2mBK4yBi4qafCyDggN6PiVKb9O1UTdapJO1DummFw=;
	b=c9P73MDoeaAqySPmAFnCl1zgz4N8hQDi87h3FeEtF6zVKt7U1+Z0uP8tZWkuYRxdOCM0R3
	q7wxWaHZHZ/tx53gvRZgnEM3fOi9cTStNZsYJWN84B89g0JTE3L39PC/tckji8AnWy11NE
	37jNhW/iIDxyGD+IZNUhX1OxzWkYTVQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-gx0tGdBVOtid08E6GGSJ0A-1; Wed, 04 Jun 2025 21:54:04 -0400
X-MC-Unique: gx0tGdBVOtid08E6GGSJ0A-1
X-Mimecast-MFC-AGG-ID: gx0tGdBVOtid08E6GGSJ0A_1749088443
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3122368d82bso689270a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 18:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749088443; x=1749693243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BC2mBK4yBi4qafCyDggN6PiVKb9O1UTdapJO1DummFw=;
        b=LOCtMFqm2gcNqENy65wTjoBUljXEPUS75qxPPQ40a99G29k+zAEFgk0mCVLdk22y5R
         fx6QOSUf698toh9b+hYGNH9QP8R4BeYOhfT7Hp3vZ7Pu7p7FUBDMrd0gkld9EyYyjFlr
         yfRRqWwNniY0PqnjoyksY/oEZ9DL1Huqb8xvzbHroznE9dPZyMYTjwwNqJjCfoSNOAaI
         Cjhua37z+RzoJTcVhAnw4b6J8jaL/DAP5HRlPYE+u9FACUw6PrlsOxxYs1+j+hyIZhV5
         i9BzKHIyefahvvJCUYmep/gcJeDV7uM5Fz14xkxI6scjYFdpZtgKe+QyeIHfa8qEBLlu
         gIfA==
X-Forwarded-Encrypted: i=1; AJvYcCVHu7zUxzU1uoBsIWnG2mBEPN9dUiDph867OfM8CGTpMBIvJorTCwutyHtvjUQOcgL81TGaOp5BAZUdanIv0sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyygKA1KhnXMr0tY+ErmnxwdroHG5gq5iPL8yV8lXjU665eIcFT
	ynkFIVkwWU/q2tgzdrXChhnbxt+LxRVn/qTAZarO2/jml2y7Uea52nwYK8CKSL8iObEyY6EoZS2
	vv9xxTRWLFZ8UiplhRoa6IFtTAtD7YVzUqNtPvizuI04zRu9xgLKnfRgyQMDL+kR2jPl8iNGwsE
	p5NzQNrI5TYWbqWy5N5/tQMMA2Vtqg1vlcKu8SjggfXZgV
X-Gm-Gg: ASbGncspiTg12TyGwrF4BO3wY8WBAghxPDfXL+/x8U64Gts96m6hE5PuBvSEDeWwBVI
	lF7IUykOOnq6CdPXOf58A0aEmJWXE4GqR3Oq8wojE1drsSV+1s8zf4iZzh1IDw/KwWIuB
X-Received: by 2002:a17:90a:2d7:b0:313:1e60:584e with SMTP id 98e67ed59e1d1-3131e60681bmr3809490a91.9.1749088443123;
        Wed, 04 Jun 2025 18:54:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG0yzA99Erlj2MhkgitZrXe/a2toXhaJ/g+nzdB5AodaS9MJdc58V+7sd9YNfwB2uorJqDK32mTTajXn9WVFY=
X-Received: by 2002:a17:90a:2d7:b0:313:1e60:584e with SMTP id
 98e67ed59e1d1-3131e60681bmr3809457a91.9.1749088442626; Wed, 04 Jun 2025
 18:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-1-95d8b348de91@daynix.com>
 <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
 <95cb2640-570d-4f51-8775-af5248c6bc5a@daynix.com> <CACGkMEu6fZaErFEu7_UFsykXRL7Z+CwmkcxmvJHC+eN_j0pQvg@mail.gmail.com>
 <4eaa7aaa-f677-4a31-bcc2-badcb5e2b9f6@daynix.com>
In-Reply-To: <4eaa7aaa-f677-4a31-bcc2-badcb5e2b9f6@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Jun 2025 09:53:51 +0800
X-Gm-Features: AX0GCFs6gwWaUHSoehy3V82tjRpIbnMIfL8B0gU0JQ9aatmr2UJ2cS77eqKWV84
Message-ID: <CACGkMEu3QH+VdHqQEePYz_z+_bNYswpA-KNxzz0edEOSSkJtWw@mail.gmail.com>
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

On Wed, Jun 4, 2025 at 3:20=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2025/06/04 10:18, Jason Wang wrote:
> > On Tue, Jun 3, 2025 at 1:31=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> On 2025/06/03 12:19, Jason Wang wrote:
> >>> On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>
> >>>> They are useful to implement VIRTIO_NET_F_RSS and
> >>>> VIRTIO_NET_F_HASH_REPORT.
> >>>>
> >>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>> ---
> >>>>    include/linux/virtio_net.h | 188 ++++++++++++++++++++++++++++++++=
+++++++++++++
> >>>>    1 file changed, 188 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> >>>> index 02a9f4dc594d..426f33b4b824 100644
> >>>> --- a/include/linux/virtio_net.h
> >>>> +++ b/include/linux/virtio_net.h
> >>>> @@ -9,6 +9,194 @@
> >>>>    #include <uapi/linux/tcp.h>
> >>>>    #include <uapi/linux/virtio_net.h>
> >>>>
> >>>> +struct virtio_net_hash {
> >>>> +       u32 value;
> >>>> +       u16 report;
> >>>> +};
> >>>> +
> >>>> +struct virtio_net_toeplitz_state {
> >>>> +       u32 hash;
> >>>> +       const u32 *key;
> >>>> +};
> >>>> +
> >>>> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_I=
Pv4 | \
> >>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TC=
Pv4 | \
> >>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UD=
Pv4 | \
> >>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_IP=
v6 | \
> >>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TC=
Pv6 | \
> >>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UD=
Pv6)
> >>>> +
> >>>> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
> >>>> +
> >>>> +static inline void virtio_net_toeplitz_convert_key(u32 *input, size=
_t len)
> >>>> +{
> >>>> +       while (len >=3D sizeof(*input)) {
> >>>> +               *input =3D be32_to_cpu((__force __be32)*input);
> >>>> +               input++;
> >>>> +               len -=3D sizeof(*input);
> >>>> +       }
> >>>> +}
> >>>> +
> >>>> +static inline void virtio_net_toeplitz_calc(struct virtio_net_toepl=
itz_state *state,
> >>>> +                                           const __be32 *input, siz=
e_t len)
> >>>> +{
> >>>> +       while (len >=3D sizeof(*input)) {
> >>>> +               for (u32 map =3D be32_to_cpu(*input); map; map &=3D =
(map - 1)) {
> >>>> +                       u32 i =3D ffs(map);
> >>>> +
> >>>> +                       state->hash ^=3D state->key[0] << (32 - i) |
> >>>> +                                      (u32)((u64)state->key[1] >> i=
);
> >>>> +               }
> >>>> +
> >>>> +               state->key++;
> >>>> +               input++;
> >>>> +               len -=3D sizeof(*input);
> >>>> +       }
> >>>> +}
> >>>> +
> >>>> +static inline u8 virtio_net_hash_key_length(u32 types)
> >>>> +{
> >>>> +       size_t len =3D 0;
> >>>> +
> >>>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv4)
> >>>> +               len =3D max(len,
> >>>> +                         sizeof(struct flow_dissector_key_ipv4_addr=
s));
> >>>> +
> >>>> +       if (types &
> >>>> +           (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_U=
DPv4))
> >>>> +               len =3D max(len,
> >>>> +                         sizeof(struct flow_dissector_key_ipv4_addr=
s) +
> >>>> +                         sizeof(struct flow_dissector_key_ports));
> >>>> +
> >>>> +       if (types & VIRTIO_NET_HASH_REPORT_IPv6)
> >>>> +               len =3D max(len,
> >>>> +                         sizeof(struct flow_dissector_key_ipv6_addr=
s));
> >>>> +
> >>>> +       if (types &
> >>>> +           (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_U=
DPv6))
> >>>> +               len =3D max(len,
> >>>> +                         sizeof(struct flow_dissector_key_ipv6_addr=
s) +
> >>>> +                         sizeof(struct flow_dissector_key_ports));
> >>>> +
> >>>> +       return len + sizeof(u32);
> >>>> +}
> >>>> +
> >>>> +static inline u32 virtio_net_hash_report(u32 types,
> >>>> +                                        const struct flow_keys_basi=
c *keys)
> >>>> +{
> >>>> +       switch (keys->basic.n_proto) {
> >>>> +       case cpu_to_be16(ETH_P_IP):
> >>>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
> >>>> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_TCP =
&&
> >>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4)=
)
> >>>> +                               return VIRTIO_NET_HASH_REPORT_TCPv4;
> >>>> +
> >>>> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_UDP =
&&
> >>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4)=
)
> >>>> +                               return VIRTIO_NET_HASH_REPORT_UDPv4;
> >>>> +               }
> >>>> +
> >>>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
> >>>> +                       return VIRTIO_NET_HASH_REPORT_IPv4;
> >>>> +
> >>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
> >>>> +
> >>>> +       case cpu_to_be16(ETH_P_IPV6):
> >>>> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
> >>>> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_TCP =
&&
> >>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6)=
)
> >>>> +                               return VIRTIO_NET_HASH_REPORT_TCPv6;
> >>>> +
> >>>> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_UDP =
&&
> >>>> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6)=
)
> >>>> +                               return VIRTIO_NET_HASH_REPORT_UDPv6;
> >>>> +               }
> >>>> +
> >>>> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
> >>>> +                       return VIRTIO_NET_HASH_REPORT_IPv6;
> >>>> +
> >>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
> >>>> +
> >>>> +       default:
> >>>> +               return VIRTIO_NET_HASH_REPORT_NONE;
> >>>> +       }
> >>>> +}
> >>>> +
> >>>> +static inline void virtio_net_hash_rss(const struct sk_buff *skb,
> >>>> +                                      u32 types, const u32 *key,
> >>>> +                                      struct virtio_net_hash *hash)
> >>>> +{
> >>>> +       struct virtio_net_toeplitz_state toeplitz_state =3D { .key =
=3D key };
> >>>> +       struct flow_keys flow;
> >>>> +       struct flow_keys_basic flow_basic;
> >>>> +       u16 report;
> >>>> +
> >>>> +       if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
> >>>> +               hash->report =3D VIRTIO_NET_HASH_REPORT_NONE;
> >>>> +               return;
> >>>> +       }
> >>>> +
> >>>> +       flow_basic =3D (struct flow_keys_basic) {
> >>>> +               .control =3D flow.control,
> >>>> +               .basic =3D flow.basic
> >>>> +       };
> >>>> +
> >>>> +       report =3D virtio_net_hash_report(types, &flow_basic);
> >>>> +
> >>>> +       switch (report) {
> >>>> +       case VIRTIO_NET_HASH_REPORT_IPv4:
> >>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>> +                                        (__be32 *)&flow.addrs.v4add=
rs,
> >>>> +                                        sizeof(flow.addrs.v4addrs))=
;
> >>>> +               break;
> >>>> +
> >>>> +       case VIRTIO_NET_HASH_REPORT_TCPv4:
> >>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>> +                                        (__be32 *)&flow.addrs.v4add=
rs,
> >>>> +                                        sizeof(flow.addrs.v4addrs))=
;
> >>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.port=
s.ports,
> >>>> +                                        sizeof(flow.ports.ports));
> >>>> +               break;
> >>>> +
> >>>> +       case VIRTIO_NET_HASH_REPORT_UDPv4:
> >>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>> +                                        (__be32 *)&flow.addrs.v4add=
rs,
> >>>> +                                        sizeof(flow.addrs.v4addrs))=
;
> >>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.port=
s.ports,
> >>>> +                                        sizeof(flow.ports.ports));
> >>>> +               break;
> >>>> +
> >>>> +       case VIRTIO_NET_HASH_REPORT_IPv6:
> >>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>> +                                        (__be32 *)&flow.addrs.v6add=
rs,
> >>>> +                                        sizeof(flow.addrs.v6addrs))=
;
> >>>> +               break;
> >>>> +
> >>>> +       case VIRTIO_NET_HASH_REPORT_TCPv6:
> >>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>> +                                        (__be32 *)&flow.addrs.v6add=
rs,
> >>>> +                                        sizeof(flow.addrs.v6addrs))=
;
> >>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.port=
s.ports,
> >>>> +                                        sizeof(flow.ports.ports));
> >>>> +               break;
> >>>> +
> >>>> +       case VIRTIO_NET_HASH_REPORT_UDPv6:
> >>>> +               virtio_net_toeplitz_calc(&toeplitz_state,
> >>>> +                                        (__be32 *)&flow.addrs.v6add=
rs,
> >>>> +                                        sizeof(flow.addrs.v6addrs))=
;
> >>>> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.port=
s.ports,
> >>>> +                                        sizeof(flow.ports.ports));
> >>>> +               break;
> >>>> +
> >>>> +       default:
> >>>> +               hash->report =3D VIRTIO_NET_HASH_REPORT_NONE;
> >>>> +               return;
> >>>
> >>> So I still think we need a comment here to explain why this is not an
> >>> issue if the device can report HASH_XXX_EX. Or we need to add the
> >>> support, since this is the code from the driver side, I don't think w=
e
> >>> need to worry about the device implementation issues.
> >>
> >> This is on the device side, and don't report HASH_TYPE_XXX_EX.
> >>
> >>>
> >>> For the issue of the number of options, does the spec forbid fallback
> >>> to VIRTIO_NET_HASH_REPORT_NONE? If not, we can do that.
> >>
> >> 5.1.6.4.3.4 "IPv6 packets with extension header" says:
> >>   > If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet has a TCPv6
> >>   > header, the hash is calculated over the following fields:
> >>   > - Home address from the home address option in the IPv6 destinatio=
n
> >>   >   options header. If the extension header is not present, use the
> >>   >   Source IPv6 address.
> >>   > - IPv6 address that is contained in the Routing-Header-Type-2 from=
 the
> >>   >   associated extension header. If the extension header is not pres=
ent,
> >>   >   use the Destination IPv6 address.
> >>   > - Source TCP port
> >>   > - Destination TCP port
> >>
> >> Therefore, if VIRTIO_NET_HASH_TYPE_TCP_EX is set, the packet has a TCP=
v6
> >> and an home address option in the IPv6 destination options header is
> >> present, the hash is calculated over the home address. If the hash is
> >> not calculated over the home address in such a case, the device is
> >> contradicting with this section and violating the spec. The same goes
> >> for the other HASH_TYPE_XXX_EX types and Routing-Header-Type-2.
> >
> > Just to make sure we are one the same page. I meant:
> >
> > 1) If the hash is not calculated over the home address (in the case of
> > IPv6 destination destination), it can still report
> > VIRTIO_NET_RSS_HASH_TYPE_IPv6. This is what you implemented in your
> > series. So the device can simply fallback to e.g TCPv6 if it can't
> > understand all or part of the IPv6 options.
>
> The spec says it can fallback if "the extension header is not present",
> not if the device can't understand the extension header.

I don't think so,

1) spec had a condition beforehand:

"""
If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet has a TCPv6
header, the hash is calculated over the following fields:
...
If the extension header is not present ...
"""

So the device can choose not to set VIRTIO_NET_HASH_TYPE_TCP_EX as
spec doesn't say device MUST set VIRTIO_NET_HASH_TYPE_TCP_EX if ...

2) implementation wise, since device has limited resources, we can't
expect the device can parse arbitrary number of ipv6 options

3) if 1) and 2) not the case, we need fix the spec otherwise implement
a spec compliant device is impractical

>
> > 2) the VIRTIO_NET_SUPPORTED_HASH_TYPES is not checked against the
> > tun_vnet_ioctl_sethash(), so userspace may set
> > VIRTIO_NET_HASH_TYPE_TCP_EX regardless of what has been returned by
> > tun_vnet_ioctl_gethashtypes(). In this case they won't get
> > VIRTIO_NET_HASH_TYPE_TCP_EX.
>
> That's right. It's the responsibility of the userspace to set only the
> supported hash types.

Well, the kernel should filter out the unsupported one to have a
robust uAPI. Otherwise, we give green light to the buggy userspace
which will have unexpected results.

>
> > 3) implementing part of the hash types might complicate the migration
> > or at least we need to describe the expectations of libvirt or other
> > management in this case. For example, do we plan to have a dedicated
> > Qemu command line like:
> >
> > -device virtio-net-pci,hash_report=3Don,supported_hash_types=3DX,Y,Z?
>
> I posted a patch series to implement such a command line for vDPA[1].
> The patch series that wires this tuntap feature up[2] reuses the
> infrastructure so it doesn't bring additional complexity.
>
> [1]
> https://lore.kernel.org/qemu-devel/20250530-vdpa-v1-0-5af4109b1c19@daynix=
.com/
> [2]
> https://lore.kernel.org/qemu-devel/20250530-hash-v5-0-343d7d7a8200@daynix=
.com/

I meant, if we implement a full hash report feature, it means a single
hash cmdline option is more than sufficient and so compatibility code
can just turn it off when dealing with machine types. This is much
more simpler than

1) having both hash as well as supported_hash_features
2) dealing both hash as well as supported_hash_features in compatibility co=
des
3) libvirt will be happy

For [1], it seems it introduces a per has type option, this seems to
be a burden to the management layer as it need to learn new option
everytime a new hash type is supported

Thanks

>
> Regards,
> Akihiko Odaki
>


