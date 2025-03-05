Return-Path: <linux-kselftest+bounces-28258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A97DFA4F245
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 01:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF79716ED53
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 00:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE508F4ED;
	Wed,  5 Mar 2025 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qiy9Zl6y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B391C288DA;
	Wed,  5 Mar 2025 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133871; cv=none; b=nWpEkgWyHGDzEN3mavyv3mQQciUjkimd3WWqYKmVoeS5CJxV4A0gareEgaVapwPauvmrD3mk0WG06bxNgmX7U8BasspzCJ7RrkUkOwwdhHhm4ketbFJl4VGkRDIokXd8IAjvJiK+/lCAsvN2lR8tfrmGnrgXQHutWEjKR0ASchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133871; c=relaxed/simple;
	bh=0yno/DE+/JPPbpjlTDp+6AS6Y5WufQLFUtooXTkZzOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcMEaSGBb0En8C0lPS38caGpxDPLEg7yZOSOgV6vMyADODspEw6gKYWNVXy2ICL8HZ1562v8svTXGifliNah8SE+MJrK0m/2mQFJwDX5+RYMgas9FCIVYxzFPFxxeKpnmoY3xqLHd8s7fx75so4Dkmc+aC2Hr0kBoe2hXJBVZrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qiy9Zl6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4BDC4CEE5;
	Wed,  5 Mar 2025 00:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741133871;
	bh=0yno/DE+/JPPbpjlTDp+6AS6Y5WufQLFUtooXTkZzOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qiy9Zl6yv/aKjE9r7FltyhR99JNSR3mZEy7tHtEeAZwJx9e8I+OyYUOIVNR/AvgN4
	 8y/TJexVAPwro/TnXD3bQGzwmuDowlMMQPnXQozziTqqfk4ft5fYlNG2Ew0+QbtsnO
	 eIyPdgpKMmQ/18DHZ7SRDJQb5iNtOpCEkY2L7uSer+P0ci0NrVCxLl100RUgrg3zvo
	 nx1DwfGtnJq5RIvZj/2QasoTO5Pwq+9XrYxDI9iJO7LOaPsIW5g2kdovUQlNW0r6l7
	 j9E0YzHkyykZLrOevBWIxL8cVwlHZEmcr6184buXgx5OLsUD/wTj9miuN8+PRGiuqt
	 lYFzVKL3eR5nQ==
Date: Tue, 4 Mar 2025 16:17:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, Donald
 Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim
 <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v6 7/8] net: check for driver support in netmem
 TX
Message-ID: <20250304161748.42b71228@kernel.org>
In-Reply-To: <CAHS8izOJfSCM+qZ=npPOK3kwuA1pyGHrPo73brRq2VXg8G450g@mail.gmail.com>
References: <20250227041209.2031104-1-almasrymina@google.com>
	<20250227041209.2031104-8-almasrymina@google.com>
	<20250228164301.07af6753@kernel.org>
	<CAHS8izO-N4maVtjhgH7CFv5D-QEtjQaYKSrHUrth=aJje4NZgg@mail.gmail.com>
	<20250303162901.7fa57cd0@kernel.org>
	<CAHS8izOJfSCM+qZ=npPOK3kwuA1pyGHrPo73brRq2VXg8G450g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 19:53:44 -0800 Mina Almasry wrote:
> > Upper devices and BPF access is covered I think, by the skbuff checks.
> > But I think we missed adding a check in validate_xmit_skb() to protect
> > the xmit paths of HW|virt drivers. You can try to add a TC rule which
> > forwards all traffic from your devmem flow back out to the device and
> > see if it crashes on net-next ?  
> 
> No crash, but by adding debug logs I'm detecting that we're passing
> unreadable netmem dma-addresses to the dma_unmap_*() APIs, which is
> known to be unsafe. I just can't reproduce an issue because my
> platform has the IOMMU disabled.
> 
> I guess I do need to send the hunk from validate_xmit_skb() as a fix
> to net and CC stable.
> 
> Another thing I'm worried about is ip_forward() inserting an
> unreadable skb into the tx path somewhere higher up the stack which
> calls more code that isn't expecting unreadable skbs? Specifically
> worried about skb_frag_ref/unref. Does this sound like a concern as
> well? Or is it a similar code path to tc?

I'd say similar to tc. We can protect drivers with a check in
validate_xmit_skb(). The second API surface we need to filter on
is skb / skb_frag helpers. The third is socket API / opt-in for
in-kernel socket readers.

Driver and socket should be "easy" to cover with an explicit
opt in. You already covered skb APIs but it's less centralized
and there may be some abuses we are not aware of. Which is why
patch 1 worries me a little.

