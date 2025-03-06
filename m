Return-Path: <linux-kselftest+bounces-28443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8154DA55A79
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 00:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB03418989E3
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 23:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080ED279349;
	Thu,  6 Mar 2025 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgEZWsyC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E42E3373;
	Thu,  6 Mar 2025 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302167; cv=none; b=swXh6nnJmgXuNe+MuV3KLnZTP1KIZEpq6TcKI0lSQU7T2aD58IW7Ds/iGJWZtXqZukh+Q8YPIGMiRb7UbkUKY4yITJyfVR2fEOooKrQ7EItWoAER1tjQqoPh9Z+PqxtQ7/md+k/6oyrMduY7CkwDtadhRhgS/XPJcRftiMu5oc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302167; c=relaxed/simple;
	bh=xxzdOTbyVDKJ1V6Mx9dmKMG+OcM8YuhuwEFYbCHADjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OB51rZCujtEu3vdlHhSeia61Tf+sY0BnW2oMNAshB/IhS98e2glsysm1mQxSiQPCU/Qgmdz/jTATbnYBov+4f2RMpESdHrDEG+5u/ENGPsO7SZMfaL7pjN+R6k7WfgO4t2Nz/GwgqrvEhHPlSKXaxrE1jKX/TDMYEaCLmyMaDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgEZWsyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABEFC4CEE0;
	Thu,  6 Mar 2025 23:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741302167;
	bh=xxzdOTbyVDKJ1V6Mx9dmKMG+OcM8YuhuwEFYbCHADjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AgEZWsyCFNH4MgmdfPlRnG8352i6INOBiH0RlJ6kt5NyugNduBFCTmbdKPulK14nq
	 KreMkFdOqGN2l6B6EpywYebIzJaLveGYcbdKzUu7gRvQKxq93FjGP/CXR0G9Jhg7bW
	 GgZSH9b33jeYW6Nr6QT0Xn6befWNJUpwTmGPLLFasjD/kcTp0R8TCj+q91Q4sJBpF8
	 nBQQIFmCRS0jq6i+UKw1LvZ2VStimB4squSZY3sxPs0X4bMnzJ51BVWkwkIAXBL8gO
	 0n9UjfcrGkeeYAlnwOmIzfbPhyfVFBD9qCIIj/h7iCVrGGOyiDbVDNSoxChRzGbhXH
	 vhepwGAKpH+Zg==
Date: Thu, 6 Mar 2025 15:02:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Pranjal Shrivastava <praan@google.com>, Shivaji Kant
 <shivajikant@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
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
Subject: Re: [PATCH net-next v6 1/8] net: add get_netmem/put_netmem support
Message-ID: <20250306150244.7797232f@kernel.org>
In-Reply-To: <CAHS8izM8dnFNj5p8vKiyhV9qeE+9=a=BWRnH=vCu49Tq_XTL9g@mail.gmail.com>
References: <20250227041209.2031104-1-almasrymina@google.com>
	<20250227041209.2031104-2-almasrymina@google.com>
	<20250228163846.0a59fb40@kernel.org>
	<CAHS8izNQnTW7sad_oABtxhy3cHxGR0FWJucrHTSVX7ZAA6jT3Q@mail.gmail.com>
	<20250303162051.09ad684e@kernel.org>
	<CAHS8izNWt2-1bC2f0jv4Qpk_A9VpEXNvVRoXUtL43_16d-Ui-A@mail.gmail.com>
	<20250306134019.1702e609@kernel.org>
	<CAHS8izM8dnFNj5p8vKiyhV9qeE+9=a=BWRnH=vCu49Tq_XTL9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 14:44:41 -0800 Mina Almasry wrote:
> > Meaning it doesn't currently do anything special, or you can't make it
> > do anything special with netdevsim?
>
> Meaning it currently doesn't do anything special with netdevsim. I
> imagine we may be able to create a specialized syzbot instance that
> loads netdevsim and starts fuzzing its APIs. However I'm told
> specialized syzbot instances are much less valuable than making the
> feature discoverable to existing syzbot instances, which is why our
> thoughts went to adding devmem/unreadable skb support to virtio or
> tun/tap.
> 
> Do I surmise from your question you prefer a netdevsim-based approach?
> (and just curious maybe, why?)

My exposure to syzbot is mostly as a consumer of reports, I thought
from looking at the repros that there's a way of teaching syzbot
how to perform more complex "ops", like a sequence of specific
writes. IIRC for netlink it does things like resolve family.
But not sure if it's true or how much of an exception adding such
things is.

Here we'd need to guide syzbot towards a specific series of
sysfs writes, so that it creates the correctly configured netdevsim
instance with higher probability.

Just explaining my thinking, not saying this is the way we should
necessarily go.

> > > We'll need to add queue API/page_pool/unreadable netmem support to
> > > one of the drivers qemu (syzbot) uses, and that should get syzbot
> > > fuzzing the control plane.
> > >
> > > To get syzbot to fuzz the data plane, I think we need to set up a
> > > special syzbot instance which configures udmabuf/rss/flow  
> >
> > To be clear for Tx you don't need RSS and flow steering, Tx should
> > be trivial for any device driver which managers DMAs directly (not USB).
> 
> Yes, we don't need queue API or page_pool support or header split
> either for that matter. TX fuzzing is definitely simpler. Maybe we can
> start with that.

Adding support to virtio would be ideal, if syzbot already fuzzes it. 
I was recently talking to David Wei about it for the Rx side, too, 
so we can test io_uring ZC. But io_uring can only ZC user memory now.
I'm not sure what adding DEVMEM support to virtio would entail.

