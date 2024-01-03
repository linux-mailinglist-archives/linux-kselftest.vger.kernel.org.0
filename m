Return-Path: <linux-kselftest+bounces-2612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3BB822E5D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 14:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E8D1C23718
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 13:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D725619BB6;
	Wed,  3 Jan 2024 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHxFdWop"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC82199DA
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Jan 2024 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so8988a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Jan 2024 05:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704288614; x=1704893414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EG1JPJoQXcnD8x9xPNrPoCvZ57tzKqywV3MMnL/ZCpM=;
        b=BHxFdWopckJEP9NAvDTlmOGjEg4Fn01X5MUaUJAi10nyecZh+csJO5sA6oubWNGx6z
         gMWWKTe6SqAaBxzHcoR8TgpNYXhfMknC/JSQ4XvBmKw7kz1WluQJEUVzy+Hfd6FjWM78
         9hQ7kzWSDG62+wINIolrA4gfo/XvUDCCT1cr06ixSSWtSaHor/uzOYYImM4siHljv1Dz
         eJgOGwqW3+dfMgJb384jM3BEQT8pmqYQcVcohRwP5Nk5IYDyE8+9z23qP/RXflEAgu9w
         YklkOIK+sxUsGY0Dr4xW5S9yUfJxGcCLl4e4V+XTb9+uLbvcdkEMqdKI7YrsDveXWS/F
         VWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704288614; x=1704893414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EG1JPJoQXcnD8x9xPNrPoCvZ57tzKqywV3MMnL/ZCpM=;
        b=jeDhyWL48oWqvfVzaLBWYW02g8wur0Ov/N5AaYmMYkzKphrUvaZIVXaRtbJewDOEZv
         mLAlOaeoPEG3hYAFAS7M5Djtq0bXtbaDwa37yQjX1IvJ0YTIquftfvYOQE32eVPA8Ipf
         lRdrQE//wxpIJVngPNWbxIKhxWD83NnW5xLKqc3sBeMB9ANLqWeusL629WJG4lgxXfR5
         Al6ueDKJq9O2zxawMUrLmjGO+A/Jj6LSI4OMNdcD8xzRal/n9ncFaGcHthtjMOsBAJiE
         xMSzU0YUFbiu8HWDswU2lzjScmD78cQFh6Obfx6w4c8iQpjOTxfR5IeuYAYSGAy33ubB
         ZCvg==
X-Gm-Message-State: AOJu0YwoVth1R9cdjUNfYVZa77D5+dqS52qvKaTqkbCB5aWwpHBWADhn
	M3FdXgmTyoBTa54RSheddsiYWM3KIIuTPhyFGzKwlmk5vD2u
X-Google-Smtp-Source: AGHT+IGcpdkuovt9cj7pidLmE+5ecVJgA0Cy2xBQq+vDKoXa5lhX7c0GLa621Y2qcJM05Kn+NLFA71EX7DXzL6DkU0E=
X-Received: by 2002:a50:9ece:0:b0:554:2501:cc8e with SMTP id
 a72-20020a509ece000000b005542501cc8emr157394edf.6.1704288614143; Wed, 03 Jan
 2024 05:30:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <127b8199-1cd4-42d7-9b2b-875abaad93fe@gmail.com>
 <90117449-1f4a-47d7-baf4-2ed6540bc436@gmail.com> <CANn89i+GJOgcDWK=C0+vmomt2ShotrOKyLiXzFkfT1W8vpJv1Q@mail.gmail.com>
 <9419df03-a203-4b73-91a6-f008076c29b4@gmail.com>
In-Reply-To: <9419df03-a203-4b73-91a6-f008076c29b4@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Jan 2024 14:30:00 +0100
Message-ID: <CANn89iJdPRspWo2XzqdGdGe9_am7zNwbq9vm0AFLF-KRODzE7A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: gro: parse ipv6 ext headers without
 frag0 invalidation
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 2:08=E2=80=AFPM Richard Gobert <richardbgobert@gmail=
.com> wrote:
>
>
>
> Eric Dumazet wrote:
> > On Tue, Jan 2, 2024 at 2:25=E2=80=AFPM Richard Gobert <richardbgobert@g=
mail.com> wrote:
> >>
> >> The existing code always pulls the IPv6 header and sets the transport
> >> offset initially. Then optionally again pulls any extension headers in
> >> ipv6_gso_pull_exthdrs and sets the transport offset again on return fr=
om
> >> that call. skb->data is set at the start of the first extension header
> >> before calling ipv6_gso_pull_exthdrs, and must disable the frag0
> >> optimization because that function uses pskb_may_pull/pskb_pull instea=
d of
> >> skb_gro_ helpers. It sets the GRO offset to the TCP header with
> >> skb_gro_pull and sets the transport header. Then returns skb->data to =
its
> >> position before this block.
> >>
> >> This commit introduces a new helper function - ipv6_gro_pull_exthdrs -
> >> which is used in ipv6_gro_receive to pull ipv6 ext headers instead of
> >> ipv6_gso_pull_exthdrs. Thus, there is no modification of skb->data, al=
l
> >> operations use skb_gro_* helpers, and the frag0 fast path can be taken=
 for
> >> IPv6 packets with ext headers.
> >>
> >> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> >> Reviewed-by: Willem de Bruijn <willemb@google.com>
> >> ---
> >>  include/net/ipv6.h     |  1 +
> >>  net/ipv6/ip6_offload.c | 51 +++++++++++++++++++++++++++++++++--------=
-
> >>  2 files changed, 42 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> >> index 78d38dd88aba..217240efa182 100644
> >> --- a/include/net/ipv6.h
> >> +++ b/include/net/ipv6.h
> >> @@ -26,6 +26,7 @@ struct ip_tunnel_info;
> >>  #define SIN6_LEN_RFC2133       24
> >>
> >>  #define IPV6_MAXPLEN           65535
> >> +#define IPV6_MIN_EXTHDR_LEN    8
> >
> > // Hmm see my following comment.
> >
> >>
> >>  /*
> >>   *     NextHeader field of IPv6 header
> >> diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
> >> index 0e0b5fed0995..c07111d8f56a 100644
> >> --- a/net/ipv6/ip6_offload.c
> >> +++ b/net/ipv6/ip6_offload.c
> >> @@ -37,6 +37,40 @@
> >>                 INDIRECT_CALL_L4(cb, f2, f1, head, skb);        \
> >>  })
> >>
> >> +static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int pr=
oto)
> >> +{
> >> +       const struct net_offload *ops =3D NULL;
> >> +       struct ipv6_opt_hdr *opth;
> >> +
> >> +       for (;;) {
> >> +               int len;
> >> +
> >> +               ops =3D rcu_dereference(inet6_offloads[proto]);
> >> +
> >> +               if (unlikely(!ops))
> >> +                       break;
> >> +
> >> +               if (!(ops->flags & INET6_PROTO_GSO_EXTHDR))
> >> +                       break;
> >> +
> >> +               opth =3D skb_gro_header(skb, off + IPV6_MIN_EXTHDR_LEN=
, off);
> >
> > I do not see a compelling reason for adding yet another constant here.
> >
> > I would stick to
> >
> >    opth =3D skb_gro_header(skb, off + sizeof(*opth), off);
> >
> > Consistency with similar helpers is desirable.
> >
>
> In terms of consistency - similar helper functions (ipv6_gso_pull_exthdrs=
,
> ipv6_parse_hopopts) also pull 8 bytes at the beginning of every IPv6
> extension header, because the minimum extension header length is 8 bytes.
>
> sizeof(*opth) =3D 2, so for an IPv6 packet with one extension header with=
 a
> common length of 8 bytes, pskb_may_pull will be called twice: first with
> length =3D 2 and again with length =3D 8, which might not be ideal when p=
arsing
> non-linear packets.
>
> Willem suggested adding a constant to make the code more self-documenting=
.


Hmm... I was looking at

skb_checksum_setup_ipv6() , it uses skb_maybe_pull_tail( ...
sizeof(struct ipv6_opt_hdr))
ipv6_skip_exthdr()  also uses sizeof(struct ipv6_opt_hdr)
ip6_tnl_parse_tlv_enc_lim also uses the same.
hbh_mt6(), ipv6header_mt6(),  .. same...
ip6_find_1stfragopt(), get_ipv6_ext_hdrs(), tcf_csum_ipv6(),
mip6_rthdr_offset() same

So it seems you found two helpers that went the other way.

If you think pulling 8 bytes first is a win, I would suggest a stand
alone patch, adding the magic constant
using it in all places, so that a casual reader can make sense of the
magical 8 value.

