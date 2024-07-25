Return-Path: <linux-kselftest+bounces-14194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 401FC93BAFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 04:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB5B1F22222
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 02:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3304610A2A;
	Thu, 25 Jul 2024 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdVH8AWN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955DC101D4;
	Thu, 25 Jul 2024 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721875958; cv=none; b=ohux/3g+xmyI92xg2lzqjPmgQvDkSPm5iPcFbEMKVJKtW5ESif6Br67RV7vkW/khQO2ve6lO8HQic2p6kWYfbE4/ArLNWrgvivg6pFW120LfjgyMTTXLHdE+2gae0bJyrHFzfoNbPc/M97V9Tv7h+TSwHdrAMq3fifhlgT20ETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721875958; c=relaxed/simple;
	bh=gwcQ2eDQDyEe+mNpwBlNsxSv1lMLn+Pspw/FQPhKKCk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=k5Jzqx0ZE9BV6hTu3+UCPT6tkk9nH7aCpvKycHRtDGIlDJagN8v3HDhcBUOUDcmctBRr0xpeRDJhspFozr4V/FRJO1yF5UJ/fB0/xFbM7XcxYbGjgFsBly2zfp2B75d7HxDKUCUfh+hrCjeoAYd4IRNXEz6LMJl05PS1jk0aDy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdVH8AWN; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d42da3e9so24459485a.1;
        Wed, 24 Jul 2024 19:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721875955; x=1722480755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBUiRZivIy2H5zWQlKFTeSB2D5HGesM5Zhywj8P0csU=;
        b=IdVH8AWNKHx/X72DoDYBhbpPVVZIP6lzauxf9mVhCw2CHsS8PBa68/mS+IuOqd59OJ
         mW8M0BfqoNk9wH00MzbWNqbGfz+JlxGwLxmz3LwgZd1Ga1fqR4wk2UC6qljtI/0V9pTl
         CIRydwd6JxoGh6cVzDWgUmmV3+e4kyyoykuEJPjAnW8Wn8h0+4SOeFGSDm0Td54v+NM4
         wYGpJpnDuJ2S3GFCPJLLwhrpH3USO9H3Q5khB4WeS/FzUfXEk5S1XiAvc7bdzDc5nhgb
         b9AaL6wsuKfTa+0HTtzI8leGdSWs7RDsOMq1TcLlOHEm4GWUhIHQQ+pbUOWA16ayB6xx
         6qlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721875955; x=1722480755;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qBUiRZivIy2H5zWQlKFTeSB2D5HGesM5Zhywj8P0csU=;
        b=kVDBYmQVp/Axm/+TeNNcZsgAu4ZTM5LjYMvTWPRuAypzRD/QmuOwaGhdv2kOvxiER5
         YPGmt2NW87hJUevwLvrAJFMwGoZq8ud7N8erTXSVY8qDUynbrhJiAx2MNzx7hvKDj24M
         ePTKyJZiyKt9fOSygFPpqyz/nGvKZYtg/s45oA47It5wsGeOVCU98tQHhnMECwNRw1mM
         Bd9OZN8UVfME3RXYR8rLNwS2B046lP+MOumA4L0ZJGPy1SRldFhSSwBJD7hynfnC1+po
         1A5RSWKoC+OyxHuvmUoRs15t/qPM6Uonq1eVRnjLW6cufyTCEoYO2tF+DXF6b/uPRhPu
         4qOg==
X-Forwarded-Encrypted: i=1; AJvYcCW0Ll9+6+F/y2wbtH1xd1jNLe6qebcX8Enz9Mkz3QjMLURLsc2+i9BQq7T2pS+0oV5TBARtA7fUfLl+2Hzv0wnpUlAIcxda20NMJ7Iw++MUt9pmNujy+sBHf3FhcXqLeGoYYG/UBSEV
X-Gm-Message-State: AOJu0Yz8A6+5DZ/lG0pe4rU2gghsTFpBdlUMzkqB+DUzphGFLNSc0AT2
	anXwz3q03ylJ3BOlvNT6DCeKKC+449LYuySt0t/59d2ofqFzaCOr
X-Google-Smtp-Source: AGHT+IGuImde7YJHP17/nZcN1EhWUNyyzyCAZDedr1Njwnn/3CgIugsY94osKjrca7Lik8w+UBazcg==
X-Received: by 2002:a05:620a:178f:b0:7a1:d948:b939 with SMTP id af79cd13be357-7a1d948b981mr22344585a.14.1721875955305;
        Wed, 24 Jul 2024 19:52:35 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8172229sm2099071cf.47.2024.07.24.19.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 19:52:34 -0700 (PDT)
Date: Wed, 24 Jul 2024 22:52:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 mst@redhat.com, 
 jasowang@redhat.com, 
 xuanzhuo@linux.alibaba.com, 
 eperezma@redhat.com, 
 shuah@kernel.org, 
 arefev@swemel.ru, 
 virtualization@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, 
 Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <66a1bdf2955b5_85410294a0@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240724074123.614feaa4@kernel.org>
References: <20240723223109.2196886-1-kuba@kernel.org>
 <CAF=yD-LJ+-S4gC9EVo6ijJTGjR6KfPMNPrpxoffgoQBFpo8GNQ@mail.gmail.com>
 <20240724074123.614feaa4@kernel.org>
Subject: Re: [PATCH net] virtio: fix GSO with frames unaligned to size
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski wrote:
> On Tue, 23 Jul 2024 23:48:24 -0400 Willem de Bruijn wrote:
> > On Tue, Jul 23, 2024 at 3:31=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > The commit under fixes added a questionable check to
> > > virtio_net_hdr_to_skb(). I'm guessing the check was supposed
> > > to protect from csum offset being outside of a segment
> > > (especially if len is not multiple of segment size).
> > >
> > > The condition can't be right, tho, as it breaks previously
> > > working sending of GSO frames with only one segment
> > > (i.e. when gso_size <=3D len we silently ignore the GSO
> > > request and send a single non-GSO frame).
> > >
> > > Fix the logic and move it to the GSO part.  =

> > =

> > I missed the previous patch. Should we revert that and create a new
> > fix against the original issue?
> =

> We can, no strong preference.
> =

> > Normally the checksum start + offset should always be in the header,
> > so not even part of gso_size. So needed need not be related to
> > gso_size.
> > =

> > The exception to this is UDP fragmentation offload, I suppose. As
> > there the network and transport headers are part of the UFO payload.
> > =

> > But even for the normal TSO and USO cases we cannot verify in
> > virtio_net_hdr_to_skb that the csum_start + csum_off passed from
> > userspace are really pointing into the transport header.
> > =

> > For SKB_GSO_UDP_L4 I added a minimal check that csum_off must be
> > offsetof(struct udphdr, check). We can arguably tighten these csum_of=
f
> > for all requests, as only UDP and TCP offsets are valid. But no such
> > simple check exists for csum_start. This requires full packet parsing=
,
> > which we don't do until skb_gso_segment.
> > =

> > One option may be to test csum_start in tcp_gso_segment and
> > udp_gso_fragment and fail segmentation when it points not where
> > expected.
> =

> That should work, I think.
> Should we still check the segment boundaries, tho?
> A bit worrying to have packets floating around the stack with clearly
> broken csum offset. At the same time maybe the modulo isn't free..

If we catch all cases during segmentation, then it's safe too.

Since these packets get SKB_GSO_DODGY, no risk of passing bad
packets anywhere else.

We also defer other correctness checks to segmentation already,
because else we end up building a second parsing stage here.

But overall I also prefer checking at the gate. So either way.
 =

> > Btw, do we have a better idea what exact packet triggered this
> > WARN_ON_ONCE in skb_checksum_help? Usually, more interesting than the=

> > skb_dump of the segment that reached the WARN is the skb_dump at the
> > time of virtio_net_hdr_to_skb, along with the vnet_hdr.
> =

> I don't have any extra info, beyond what's in the commit message :(
> Note that the syzbot report says 6.7, too.
> Denis, can you comment? Do you have a repro?

Yes, please share if there is a repro. The original report did credit
syzkaller.

Else I might have to look into building one..



