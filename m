Return-Path: <linux-kselftest+bounces-34523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DA3AD291F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 00:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F3816E19D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 22:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7107221FC0;
	Mon,  9 Jun 2025 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRxdBwXm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A714F881E;
	Mon,  9 Jun 2025 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749506439; cv=none; b=tiIvuXwRmihktM5+7YlWX+/7Zda6A3QL11ewnKMPO3oW4x48hqvBq8yyg23JgzaQL5OqPM5ZTNP9IOb8aJzhPTcRoY+juYCNDPxRoI3DP6DBafWAzGKCFmYcedGLuYFL3kzA0GHORsGPv5LdS25Uxhx31PSwomJ/S8wtf7Fje+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749506439; c=relaxed/simple;
	bh=CCQ6UXOHB+c5ctwB/EL8rAqFO9dWevbk6fecl/G/TU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjnRaWnsxCeK0U/XipXgd2Infz21ztXaNDclIvab2QrwMiD1e57iueQpD5XKUbPvU5wuAS50Im4FeFuYtTQQ37MCvfCcZDZMe5jYL4pz9AgZkvfJYZlF9FQ8bNcnEAw8dA2/QqWC2hgfu+M6kSxRkrcrJlA7/xsq2sno44TZc/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRxdBwXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721DEC4CEED;
	Mon,  9 Jun 2025 22:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749506439;
	bh=CCQ6UXOHB+c5ctwB/EL8rAqFO9dWevbk6fecl/G/TU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KRxdBwXmgkJHIjzWGouOsiCArYVNMnZ9UxHLldGOTOd9qTDBrq3TZyInh/BUs8E+G
	 3q17tDoLng4+0JeOVEjmhQw/OZu91G7crTiXSY+EgxAMmgGq2LFtFT7oAqF4qnHO9p
	 l+REv/sthDjGTuu9KHdZo9SXat1I4QN/f4vw7je/BwYiII9o4A5bni2mmITS86TYlz
	 VJk47urtR2hS0IJkK1bIYXcpwzm90nTylbox2CiCAHClliabgIOC0qYNYqQ84Oqbdv
	 Y6crZzG/L9gHz41qp87IppkfAfIfO+6OILQi44Wi2+9A5YfYE13LbYiz6uBqCvj2Pv
	 P2Px+hsYGyW2Q==
Date: Mon, 9 Jun 2025 15:00:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, Daniel Borkmann
 <daniel@iogearbox.net>, martin.lau@linux.dev, john.fastabend@gmail.com,
 eddyz87@gmail.com, sdf@fomichev.me, haoluo@google.com, willemb@google.com,
 william.xuanziyang@huawei.com, alan.maguire@oracle.com,
 bpf@vger.kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 yonghong.song@linux.dev
Subject: Re: [PATCH net v2] net: clear the dst when changing skb protocol
Message-ID: <20250609150037.1cc762e0@kernel.org>
In-Reply-To: <6846e6a6342c7_34e997294f9@willemb.c.googlers.com.notmuch>
References: <20250607204734.1588964-1-kuba@kernel.org>
	<CANP3RGcUbSG3dQQbDrsYq9YSMStXbmEsq6U34jcieA_45H4_JQ@mail.gmail.com>
	<6846e6a6342c7_34e997294f9@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Jun 2025 09:50:30 -0400 Willem de Bruijn wrote:
> > > +       if (ret)
> > > +               return ret;
> > > +
> > >         bpf_compute_data_pointers(skb);
> > > -       return ret;  
> 
> I wonder whether that unconditional call to bpf_compute_data_pointers
> even if ret was there for a reason.
> 
> From reviewing the bpf_skb_proto_xlat error paths, it does seem safe
> to remove it. The cases where an error may be returned after the skb
> is modified only modify the skb in terms of headroom, not headlen.

I should have mentioned, I looked around and also concluded this
unconditional recompute was purely aesthetic.

