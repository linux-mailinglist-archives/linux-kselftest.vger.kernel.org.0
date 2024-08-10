Return-Path: <linux-kselftest+bounces-15106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1D94DA7F
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 05:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40551C22536
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 03:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A7B13BC25;
	Sat, 10 Aug 2024 03:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdKet3hL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA01C13B7A1;
	Sat, 10 Aug 2024 03:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723261959; cv=none; b=EBphkCqQNYk+b2s1jOLwcabVjnXGf5d43BlwWsT0dIf2n4O3yr+QwhZZPOOhUoXs/t8RsBLVvTrcdZWP76fD6HwEEoMjKQmhsZgnjpClkVbWKYVJjrFUaiLptv4uYZeJfqPMjLaRusUIHTyfZXeG9uE8V8qJpOT809254qs6PIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723261959; c=relaxed/simple;
	bh=rioiNetuw2BwYMEikBfSgmKCffnfLditttehbRMvIxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGa+nzfl4bf004yue6KKwM2HDDkQU6FgTBUAjyYxIfmrCmS3yA/P/h0uwmF12XacJ3nbOwUZSXhOPAlMAwVpBQnDx0QMGuM3N4VTHSbg2bACo14bppN2qj6Ypj7779qsXanHyUtAsTYwpv6inmXvKBGMIl5OWHV6PhCJzovGcSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdKet3hL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED11C32781;
	Sat, 10 Aug 2024 03:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723261959;
	bh=rioiNetuw2BwYMEikBfSgmKCffnfLditttehbRMvIxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CdKet3hLwuiF3hixS1amRwINUTmJ/gUYj4tM+7R+uUjAmmtWQYtHwD4p5wiAd61AF
	 VkSbA7XQtUkEk30X7cCDULjbHR5DU3U38yIdQM1+dk+orTayU9fzvXymqYHZpHlaHi
	 hyjeBhWfrS/hMmFB29QMsoPNVAkLsxuw/90JgcM2TeQ8fVP5I6OPwn7ohQou79zYdu
	 FBzsdEQWvKniGqipav0cBZBuCiWnLDar9JFKMrfV0s/XDMpQo0Pc2EWj5RIj9yKt93
	 Iwy5u4Cyszg+jmWc3Vh4cmaKDln+7ik2d5TFJV9WU7Z32Kv3ooadBQBvjkudvgamCS
	 2bZhpBDbhYrKQ==
Date: Fri, 9 Aug 2024 20:52:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge
 Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, Steffen
 Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, David Wei <dw@davidwei.uk>, Jason
 Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, Shailend
 Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v18 07/14] memory-provider: dmabuf devmem
 memory provider
Message-ID: <20240809205236.77c959b0@kernel.org>
In-Reply-To: <fc6a8f0a-cdb4-4705-a08f-7033ef15213e@gmail.com>
References: <20240805212536.2172174-1-almasrymina@google.com>
	<20240805212536.2172174-8-almasrymina@google.com>
	<20240806135924.5bb65ec7@kernel.org>
	<CAHS8izOA80dxpB9rzOwv7Oe_1w4A7vo5S3c3=uCES8TSnjyzpg@mail.gmail.com>
	<20240808192410.37a49724@kernel.org>
	<CAHS8izMH4UhD+UDYqMjt9d=gu-wpGPQBLyewzVrCWRyoVtQcgA@mail.gmail.com>
	<fc6a8f0a-cdb4-4705-a08f-7033ef15213e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Aug 2024 16:45:50 +0100 Pavel Begunkov wrote:
> > I think this is good, and it doesn't seem hacky to me, because we can
> > check the page_pools of the netdev while we hold rtnl, so we can be
> > sure nothing is messing with the pp configuration in the meantime.
> > Like you say below it does validate the driver rather than rely on the
> > driver saying it's doing the right thing. I'll look into putting this
> > in the next version.  
> 
> Why not have a flag set by the driver and advertising whether it
> supports providers or not, which should be checked for instance in
> netdev_rx_queue_restart()? If set, the driver should do the right
> thing. That's in addition to a new pp_params flag explicitly telling
> if pp should use providers. It's more explicit and feels a little
> less hacky.

You mean like I suggested in the previous two emails? :)

Given how easy the check is to implement, I think it's worth
adding as a sanity check. But the flag should be the main API,
if the sanity check starts to be annoying we'll ditch it.

