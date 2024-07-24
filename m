Return-Path: <linux-kselftest+bounces-14133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C15B593ABA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 05:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CB52B227E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 03:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0093420322;
	Wed, 24 Jul 2024 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhrLQxbm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8091C6A1;
	Wed, 24 Jul 2024 03:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721792944; cv=none; b=fok6lP7kRf5WEhvHPT99u7KUuSBs18+RJzJ0qQ3Xn+n/xpcNGVTslq4L4Y7zpdcydB+ZpPa8Ag8oSmFPmPOM8VkNlP3P0iMYFLz+TJ4ekvJCISAlq0XfwsgFXc1r9D/l2ppEeLzMyc/QsrpVIK9csnvqH5Pqbg3oEWzcCr3rH3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721792944; c=relaxed/simple;
	bh=NKrj4Xe15h7P+/8akw56axN+QjFD9WXReSS4RVzKxwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3rnYzlCy7oA5eGTGsdO4qhS3yKxlk/fX1R9K8GN5QDLsS8ors21RKu+kA1us9Cz0TTWSUQriIlrgfsg7juLnTbBg/hExMa7HfUL22WrdzeWLFAI6jnNDOVm2GueQPrcwZC7BSGnNJ+/ywsEPb91LzuJFcDv5q1+vfy/RLPveFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhrLQxbm; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8205ceff95cso1935220241.1;
        Tue, 23 Jul 2024 20:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721792942; x=1722397742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIIzMgLof7Cy8pOJkAUdfmjOzPX18xl1X4zt9wdck1I=;
        b=IhrLQxbmIVQzPVfwxoStvcX6ZdR1XNXYlnmjixBvVR9aVm6qKqkL4UFN3pHWh7WKRm
         SUn994Ry4JRPoiGsSbnvHRkyiC8f2l68n+BgL6SGhMO2g/qeLqypXAkZoziTapyfifYd
         IrE5P+PmA6OM9tX6yKK6t0ynTPcjVooFtZg2WKquSITJvkFz2X1VCeoMKU1FbhEa7x4R
         uRWH3Gm0V5O6RcvIcdbj3L0W98ty1ojB9gMd92UyZQk7XqBrDB9BuWrUxREVnUF5aYgf
         RDjzkcYGXHbPE6nwkacrEkkegYanyH/5cIwEFQAHXVbT44btGo8RFs5JHXD75ZONQZ4O
         Z8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721792942; x=1722397742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIIzMgLof7Cy8pOJkAUdfmjOzPX18xl1X4zt9wdck1I=;
        b=EKOJcnOJT3fnKRY7cNHo1C9bCcQsnYC+Njt8n4MPAfAvgHAYv7S/kcKUhm29dBSJtZ
         wbM5pNC4WNEfxusZdiQqCYIFEYFXGYYKIa5YQ2Fd9p4jxK/TZ1sN0usbUAhtJNtTK61r
         mJPtOX7SZqqJOAYO9AedF/VwVjICC/hAAYsb5atjnsyNLuwn8Lv5kFkC/U+ndlEz/qEq
         I7nzJuZMACe2e4FIBZTViecTU1HPoGxKr99yE3rKMO9NUWPS7nvop+umI5pzjbY3ukAk
         cGEkI+bqZfPLvekBxT3phdPAqCwNgcts3ZKVvMNq2bSZSvdJi0CyDpXCJ9l7ALiaYbep
         qbtA==
X-Forwarded-Encrypted: i=1; AJvYcCURPmq+Btqmr2RhKE/tPxIpd8VGTPOulOWL3PuXWp//IufMqogLUqvERi0vwp3kIwa4792+7xjBvhoWkn7UT6XkaixdXoIRmM041zfAPLgqPABpp5cjoLinJ+FI/vjMv0IDHoYhbE8h
X-Gm-Message-State: AOJu0YwiK0JmcrB3OUdq71nn2HWLxqmvtWFfvBNuK71yGzM63Ihge4Sj
	4sfroxhbwnwkwIJcAz0pad5o1WxyaoZu2TitYyHrPHu0Idw5hwpHMZ8zg0opsfBVNn3Ieaodr2M
	JlJiAL+isgmSFK/8Ey48NBsXZDNo=
X-Google-Smtp-Source: AGHT+IFDvtbe82NNASQ0oM9M0v5+nZcAsCCLz1k3PmRjYQzgoGqz5vUMO4HDkw4dQsjBUNVozxiQ1PzitWivbSxe5zU=
X-Received: by 2002:a05:6102:158b:b0:493:c631:5eda with SMTP id
 ada2fe7eead31-493c63160d9mr769729137.9.1721792941922; Tue, 23 Jul 2024
 20:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723223109.2196886-1-kuba@kernel.org>
In-Reply-To: <20240723223109.2196886-1-kuba@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 23 Jul 2024 23:48:24 -0400
Message-ID: <CAF=yD-LJ+-S4gC9EVo6ijJTGjR6KfPMNPrpxoffgoQBFpo8GNQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio: fix GSO with frames unaligned to size
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, shuah@kernel.org, 
	arefev@swemel.ru, virtualization@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 3:31=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> The commit under fixes added a questionable check to
> virtio_net_hdr_to_skb(). I'm guessing the check was supposed
> to protect from csum offset being outside of a segment
> (especially if len is not multiple of segment size).
>
> The condition can't be right, tho, as it breaks previously
> working sending of GSO frames with only one segment
> (i.e. when gso_size <=3D len we silently ignore the GSO
> request and send a single non-GSO frame).
>
> Fix the logic and move it to the GSO part.

I missed the previous patch. Should we revert that and create a new
fix against the original issue?

Normally the checksum start + offset should always be in the header,
so not even part of gso_size. So needed need not be related to
gso_size.

The exception to this is UDP fragmentation offload, I suppose. As
there the network and transport headers are part of the UFO payload.

But even for the normal TSO and USO cases we cannot verify in
virtio_net_hdr_to_skb that the csum_start + csum_off passed from
userspace are really pointing into the transport header.

For SKB_GSO_UDP_L4 I added a minimal check that csum_off must be
offsetof(struct udphdr, check). We can arguably tighten these csum_off
for all requests, as only UDP and TCP offsets are valid. But no such
simple check exists for csum_start. This requires full packet parsing,
which we don't do until skb_gso_segment.

One option may be to test csum_start in tcp_gso_segment and
udp_gso_fragment and fail segmentation when it points not where
expected.

Btw, do we have a better idea what exact packet triggered this
WARN_ON_ONCE in skb_checksum_help? Usually, more interesting than the
skb_dump of the segment that reached the WARN is the skb_dump at the
time of virtio_net_hdr_to_skb, along with the vnet_hdr.

> This has been caught by net/tap and net/psock_send.sh tests.

That's very nice!

> Fixes: e269d79c7d35 ("net: missing check virtio")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

> +               if (csum_needed) {
> +                       unsigned int p_rem, p_size;
> +
> +                       p_size =3D gso_size;
> +                       p_rem =3D (skb->len - nh_off) % gso_size;
> +                       if (p_rem)
> +                               p_size =3D p_rem;
> +
> +                       /* Make sure csum still within packet after GSO *=
/
> +                       if (p_size + nh_off < csum_needed)
> +                               return -EINVAL;
> +               }
> +

A check could even go in the below branch.

The warning apparently was not that csum_needed is outside the segment
entirely, but that the segment is non-linear and csum_start points in
the non-linear part (offset >=3D skb_headlen(skb)).

I don't think we should be playing SKBFL_SHARED_FRAG tricks to trigger
linearization, to be clear.

We also cannot just silence the WARN and trust that the stack detects
these bad packets and drops them (as ip_do_fragment does), as they
might end up not in ip_do_fragment, but in a device ndo_start_xmit.

>                 /* Too small packets are not really GSO ones. */
>                 if (skb->len - nh_off > gso_size) {
>                         shinfo->gso_size =3D gso_size;
> diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/=
net/tap.c
> index 247c3b3ac1c9..8527d51449cf 100644
> --- a/tools/testing/selftests/net/tap.c
> +++ b/tools/testing/selftests/net/tap.c
> @@ -418,6 +418,36 @@ TEST_F(tap, test_packet_valid_udp_csum)
>         ASSERT_EQ(ret, off);
>  }
>
> +TEST_F(tap, test_packet_invalid_udp_gso_csum)
> +{
> +       uint8_t pkt[TEST_PACKET_SZ];
> +       uint16_t payload;
> +       size_t off;
> +       int ret;
> +       int i;
> +
> +       payload =3D ETH_DATA_LEN - sizeof(struct iphdr) - sizeof(struct u=
dphdr);
> +
> +       memset(pkt, 0, sizeof(pkt));
> +       off =3D build_test_packet_valid_udp_gso(pkt, payload);
> +
> +       for (i =3D -16; i < 16; i++) {
> +               ret =3D write(self->fd, pkt, off + i);
> +
> +               if (i <=3D 0 ||
> +                   i > __builtin_offsetof(struct udphdr, check) + 1) {
> +                       EXPECT_EQ(ret, off + i)
> +                               TH_LOG("mismatch with offset: %d (%zd)",
> +                                      i, off + i);
> +               } else {
> +                       EXPECT_EQ(ret, -1)
> +                               TH_LOG("mismatch with offset: %d (%zd)",
> +                                      i, off + i);
> +                       EXPECT_EQ(errno, 22);
> +               }
> +       }
> +}
> +
>  TEST_F(tap, test_packet_crash_tap_invalid_eth_proto)
>  {
>         uint8_t pkt[TEST_PACKET_SZ];
> --
> 2.45.2
>

