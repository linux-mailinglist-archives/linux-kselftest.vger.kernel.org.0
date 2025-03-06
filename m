Return-Path: <linux-kselftest+bounces-28432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B7EA558EE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 22:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4F63ADA09
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 21:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4621326D5B6;
	Thu,  6 Mar 2025 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWvQBC8c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A155151990;
	Thu,  6 Mar 2025 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297222; cv=none; b=rIgEnVy4a0V90F1acWNuVIuTCKknnHzOLOCGU1qfBGbiZk56z+pIrbMQbnCdLHvRX2ipDYRKTX7OrzhsLjagCut2xe4nckf0ZOrWNHGPFuyxczQv49aeHco8fWhjCwsu5lqUyWwg/xJtEEZp6e31GOK9ynG3q/KCNnVzCwO/c9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297222; c=relaxed/simple;
	bh=hLwEVcHmWyfHzwJcntUNMaPG82MeB24Us0ZhRuq1ojA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpCOTTI6JK3JHKJLKBRBqtlxmFXi5QWbbScGEH6VCsPRA3xvuRdNDdnYZKNRjdJIm7EsxqA/CkhMJheayX0TkZ4aDX8abLUPoUg8iT5TMPPAF+pNzApJcHEYARC2N+jPoj/RSxXbt0fEy1nRHGqjX6rYRk2jsL7Ratuyt6RiBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWvQBC8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E2DC4CEE0;
	Thu,  6 Mar 2025 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741297221;
	bh=hLwEVcHmWyfHzwJcntUNMaPG82MeB24Us0ZhRuq1ojA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qWvQBC8cMlzIYQijdnco18mw0T0tVzn2B4U0wQLNkSKO5KTDqAxHSAGxvUfNybRah
	 8lgFJ/enNu+swZgndUBSSsT5aSgOH3LFxfQ7CBfpSPo1wvKYEI+3pTXeaGTbLi3nx1
	 rY6v8/WbCqCOX/VNd4Il5HC86ulDEYjbHuSLFbXXU/PbA+kacBAbBC5sPifvmJygEA
	 Gk76Ko19HRTBKiFw167crQ7jTK+XK1Tcg0oetXWQ6gB/SFDpI5GuXRkqgAdhL3hBPs
	 oyvPuKTFtSIWVx07LChKUPoeB6Fpe7zRJAx/slFPjRcMwu7cc6yDZ/HFA3+bfVMKla
	 alosVkK00Ebqw==
Date: Thu, 6 Mar 2025 13:40:19 -0800
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
Subject: Re: [PATCH net-next v6 1/8] net: add get_netmem/put_netmem support
Message-ID: <20250306134019.1702e609@kernel.org>
In-Reply-To: <CAHS8izNWt2-1bC2f0jv4Qpk_A9VpEXNvVRoXUtL43_16d-Ui-A@mail.gmail.com>
References: <20250227041209.2031104-1-almasrymina@google.com>
	<20250227041209.2031104-2-almasrymina@google.com>
	<20250228163846.0a59fb40@kernel.org>
	<CAHS8izNQnTW7sad_oABtxhy3cHxGR0FWJucrHTSVX7ZAA6jT3Q@mail.gmail.com>
	<20250303162051.09ad684e@kernel.org>
	<CAHS8izNWt2-1bC2f0jv4Qpk_A9VpEXNvVRoXUtL43_16d-Ui-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 17:39:37 -0800 Mina Almasry wrote:
> > > Yes, great idea. I don't see why it wouldn't work.
> > >
> > > We don't expect mixing of net_iovs and pages in the same skb, but
> > > netdevsim could create one net_iov skb every N skbs.
> > >
> > > I guess I'm not totally sure something is discoverable to syzbot. Is a
> > > netdevsim hack toggleable via a debugfs sufficient for syzbot? I'll
> > > investigate and ask.  
> >
> > Yeah, my unreliable memory is that syzbot has a mixed record discovering
> > problems with debugfs. If you could ask Dmitry for advice that'd be
> > ideal.  
> 
> Yes, I took a look here and discussed with Willem. Long story short is
> that syzbot support is possible but with a handful of changes. We'll
> look into that.
> 
> Long story long, for syzbot support I don't think netdevsim itself
> will be useful. Its our understanding so far that syzbot doesn't do
> anything special with netdevsim.

Meaning it doesn't currently do anything special, or you can't make it
do anything special with netdevsim?

> We'll need to add queue API/page_pool/unreadable netmem support to
> one of the drivers qemu (syzbot) uses, and that should get syzbot
> fuzzing the control plane.
> 
> To get syzbot to fuzz the data plane, I think we need to set up a
> special syzbot instance which configures udmabuf/rss/flow

To be clear for Tx you don't need RSS and flow steering, Tx should
be trivial for any device driver which managers DMAs directly (not USB).

> steering/netlink binding and start injecting packets through the data
> path. Syzbot would not discover a working config on its own. I'm told
> it's rare to set up specialized syzbot instances but we could sell
> that this coverage is important enough.
> 
> Hacking netdevsim like you suggested would be useful as well, but
> outside of syzbot, AFAICT so far. We can run existing netdevsim data
> path tests with netdevsim in 'unreadable netmem mode' and see if it
> can reproduce issues. Although I'm not sure how to integrate that with
> continuous testing yet.

