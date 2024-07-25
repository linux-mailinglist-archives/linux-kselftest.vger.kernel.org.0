Return-Path: <linux-kselftest+bounces-14252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADE593CA0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 23:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9158A282C8D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 21:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE7513A240;
	Thu, 25 Jul 2024 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNqBPCpZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6FD299;
	Thu, 25 Jul 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721941377; cv=none; b=XWfNvbcgVdElb8mM6xa5e3PvOhsbR+RSC7QMpqKKpL9t+m5d0uGU2ZSuClsxnDy9y61EPALOQ02DDcT21kV6sfu0S5BBmoYpAAdp13Szhynw51C5wekZEp1Wv/671Z1Yxsq0YtFtwfcDnfju9ulOvg3AHB27gPlTCKUSj1c4DiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721941377; c=relaxed/simple;
	bh=EEs0PsVZtmXovIP4elBP1rkP5kAYWDF0gM35V4qrISY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGKi3S3FHgii2s6QVF0DvOxdj94ARQR3a67zisoMd62xvOEhq4CkyOpBR2R42xdo7Y7PWQ4TIj7BoGTxGKTE7Zq8JfYkamQC/5RXSi7Uqf0E7Nt6qiuFMuK4qy6/kr16bcKQeDtxZr9xVrQLG1Pgy9IEBIILeCaFhAqfEuS1IbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNqBPCpZ; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d5aeaa9751so209478eaf.1;
        Thu, 25 Jul 2024 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721941373; x=1722546173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0R3aNtSay58/lkjvIqsiNk76d3Gj29c33jDe7aDrYg=;
        b=UNqBPCpZ3DUDd3G+qmclclDYz+capChaSglXChRR1bjHLj43LRXZeVb1PRxrddS0zy
         wAxsTck9fbyA3et40kwow2j35vDb8kYb0EsJdq31XAuFdITckyC72nOBJYDipAy175HV
         g63GmYW1qHWxU+NPUms0ZlCZxdSg5g/1p0lH7w0V7X+3MYy/x3xIm1hC9yCsK1A8Srwi
         CbhA3SZYs9sEPxdf/pglVSLi6yxsX3qghlPHvyPh5ZdL3iydqeKPDpP+0Jb2MzjR/HQv
         BpCtMoVNMClKhPM5V3ZDWSF+3QEE05L4hyxiQ2aXd+5VDpIbXJRNH0cu+9Plr+wxnqVJ
         yQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721941373; x=1722546173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0R3aNtSay58/lkjvIqsiNk76d3Gj29c33jDe7aDrYg=;
        b=EuxKajNpe7ocu6wPPR5HQ1z2U2NNIlQ6M2ATh+eBBSBcWN3jfRC8pyw0sN83HalOAc
         KBGP5FQOqCjqJMRFIQFVtm0qKf2ZIoKhq6j/g92FrYczO9pb7p4wIiWWFn6VJcSYxV+o
         gNwoVBxyWXGCLxwUG+IOHVcfPWd0I2HivlE6P9W/REammhpG0DLNTNCwkgGlLgfsO0sj
         F4eL2wmGxyVgK/Kg3wsbjYpdNzPyWKhCwfn4AzLI9WswRXwTK9NANEJFCK5rmxn/vycc
         JfPg0K6lbNZyHF5CN3JJAQ6SFBcW0LPqT1RAHeaGMETJb87VlT7U2KUYGqpIFTbk/f7T
         JDYg==
X-Forwarded-Encrypted: i=1; AJvYcCUk2W1yGBf8dY2GmJbvpUfMrqM0bsF3nwYpNCwHa2/dpHXHKab6bSo/XAsQdtuKiV76nIo2MeP6oImVlS02rxkqEn5P8qYsc43C5piR6D0wZDNEmPqVja50tsxdJEhSKQxDNLI4nvpS
X-Gm-Message-State: AOJu0Yy7+YiNXYTuAeals1h4cRFN/p97fUxDo+Ahp4FRfvLIEWhp337m
	wSL9G2cWa9VpGyMpdjbywaaoTfVBCQz1Qfo6nKMAqYz89tYI8r8irN4nP6QeMEJtXF0C5wWD9NZ
	FeiyROzSeyCy4Yf8mY16cKJMzl0o=
X-Google-Smtp-Source: AGHT+IHpabHVk/SwCJqR5J+AVsCV6XSW/pF6eWZyyTvY8O3GCcoIlZgV1sQr+Tvs0AhJPuNVGamq2GTyOXZXWbEDO18=
X-Received: by 2002:a05:6358:7202:b0:1a6:799b:b06c with SMTP id
 e5c5f4694b2df-1acf8908280mr570291155d.23.1721941372869; Thu, 25 Jul 2024
 14:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723223109.2196886-1-kuba@kernel.org> <20240725092203.26366-1-arefev@swemel.ru>
 <CAF=yD-Kz3PRncy4N0LkTSDGm95Zg7yfKDm+BOHBs4NfkEDSJUw@mail.gmail.com>
In-Reply-To: <CAF=yD-Kz3PRncy4N0LkTSDGm95Zg7yfKDm+BOHBs4NfkEDSJUw@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 25 Jul 2024 17:02:15 -0400
Message-ID: <CAF=yD-J7P=5V+Ksx9KRT2nm+UzK42HoBVCDed-EYH4KzMPWtkw@mail.gmail.com>
Subject: Re: [PATCH net] virtio: fix GSO with frames unaligned to size
To: Denis Arefev <arefev@swemel.ru>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	eperezma@redhat.com, jasowang@redhat.com, linux-kselftest@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 10:27=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Jul 25, 2024 at 5:22=E2=80=AFAM Denis Arefev <arefev@swemel.ru> w=
rote:
> >
> > I checked the patch on three reproducers and all three DEFINITELY broke=
 the core.
> >
> > There are two malfunctions.
> >
> > 1. No flag skb_shinfo(skb)->tx_flags |=3D SKBFL_SHARED_FRAG;
> >  If it is not set then __skb_linearize will not be executed in skb_chec=
ksum_help.
> >  sk_buff remains fragmented (non-linear) and this is the first warning.
> >  OR add skb_shinfo(skb)->tx_flags |=3D SKBFL_SHARED_FRAG.
> >  OR ask Eric Dumazet (cef401de7be8c). Is checking if (skb_has_shared_fr=
ag(skb)) so important?
> >  in the skb_checksum_help function, is it enough if (skb_is_nonlinear(s=
kb)) ?
>
> Thanks for sharing the reproducers. Having a look.

Reproduced https://syzkaller.appspot.com/bug?extid=3De1db31216c789f552871

That is against a v6.1 kernel, and the syzkaller page reports that it
did not fail against a recent upstream commit. Will take a closer look
at that.

But on v6.1, at least, the following did catch it:

@@ -72,6 +72,18 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
        if (thlen < sizeof(*th))
                goto out;

+       if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
+           skb->csum_start !=3D skb->transport_header) {
+               skb_dump(KERN_INFO, skb, false);
+               goto out;
+        }
+

And the geometry of the bad packet at that point:

[   52.003050][ T8403] skb len=3D12202 headroom=3D244 headlen=3D12093 tailr=
oom=3D0
[   52.003050][ T8403] mac=3D(168,24) mac_len=3D24 net=3D(192,52) trans=3D2=
44
[   52.003050][ T8403] shinfo(txflags=3D0 nr_frags=3D1 gso(size=3D1552 type=
=3D3 segs=3D0))
[   52.003050][ T8403] csum(0x60000c7 start=3D199 offset=3D1536
ip_summed=3D3 complete_sw=3D0 valid=3D0 level=3D0)

Sharing sketch patch for any feedback. A few downsides:

The patch adds a branch in the semi hot path of TCP software
segmentation for every packet. Including for the more common kernel
stack generated packets. And it needs the same test in two locations
in net/ipv4/udp_offload.c, for USO and UFO.

It is tempting to move it to the if (skb_gso_ok(skb, features |
NETIF_F_GSO_ROBUST)) branch below, as then it is limited to
SKB_GSO_DODGY. But that does not catch dodgy packets that need
software segmentation. Conversely, we could check in skb_segment
before calling skb_checksum_help.

I'll be out for four days over the weekend. May have to delay until next we=
ek.

> > Should we revert that and create a new fix against the original issue?
>
> We can, no strong preference.

On second thought, since this has to go to all the stable trees, let's
keep it a single patch. Rather than a revert + new fix.

