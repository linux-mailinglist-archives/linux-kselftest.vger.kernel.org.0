Return-Path: <linux-kselftest+bounces-22624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67349DEAB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 17:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0084EB2081B
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A469148316;
	Fri, 29 Nov 2024 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="fSzEwOTR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="46JWbP08"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F5A168DA;
	Fri, 29 Nov 2024 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732896653; cv=none; b=Y12KsgMA+y+BGP2yc3Ws8DWyVn9Wez/XVEMn2SoNoB1e2gwEcgIedzW/RbEb+aBCNvt8PEzrYYMc048IhmnJDywW8ssBKtEu7BGxkzUsSSRWGKcgzjW3e438f/3YnwobHvmsVXZ7g2+fymxvD04N1Fu8b4OnFEp/wbxRp6UfuqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732896653; c=relaxed/simple;
	bh=JFetJ0WzBBJsSHNN5vePTOMGR91U7H26ZU/3zPT4BMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROJDO6SMcmw7IeCBqg+XEMaU/Y6HRAUg/FMglUwEmU1kuVmanf/jUZYRy2kOLyTOkE/wtsoJjHdUzE4Dvata4ynaQ6ilW84oBiGQpHEJP3yWRMJiswii4DhJXftkLNQhmAhbzTWM1DrngkFo2u6EckxDeToOBOk98kNqKnBOyEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=fSzEwOTR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=46JWbP08; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 93E3A1D40D4A;
	Fri, 29 Nov 2024 11:10:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 29 Nov 2024 11:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1732896647; x=1732900247; bh=71hovPwKy11ySr9JPOOX62sWDw4+4hQe
	L1AKeFDFs8Y=; b=fSzEwOTRbOAu+yS0faDIUkxvfVommRCUVTaE/XGUKqQhgH9s
	saIJuLUfP3jvJyIPC1pFJWNnmAJOa7vSUfMLY0qmOXlRqnfVdb3vM9CZt87AGV33
	tv7i8kA/kVrOuS09M1wQ1seDAUGWM4+XrTVG7BNaoIWcN6zG+gboi3TxWN8KEOu7
	8ZUcupcudmxSNH8uHYEInFaWJS6/iunieP9a0ClrawaXAfPWwRsgPdeLz9Tj2K5t
	1XL/l102jxs/HrxDWrqk+c2uRMfSv7kzB3Yg335KL20M05n40IMG6ihCKvb4gVIj
	7CNpHB3zhLI0dKhuB5pXJ0LFXPPJtqZXOGP/5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732896647; x=
	1732900247; bh=71hovPwKy11ySr9JPOOX62sWDw4+4hQeL1AKeFDFs8Y=; b=4
	6JWbP08Fl9Q1oWJC9fi2bJrtwFgdpZJqeOz5cgPNKdGqG57vGdlTssdKVzXhwqRa
	kkGee98gTjvrrRR13MlkBCmplU338ifi2AE/sw4x/0dfM+HkS/2bivjZ7rnQsp+G
	biN5ANj/KUlH4nOwCsc1ksnHg8Dqb7zs+X7w7GbgcYthiBGfbG2UY7R/rqAQZdPv
	a7N6uKcD3DuVJcUn+ZG2oix96dMYxAUfCdQh5tYngubtEpGp4hGMT2HfZ1LDtp14
	HZy7g4Qh1pVX/pYHwpRHK0f+9itGd9ijDEI6VCwrVbT0lpf1+jTc+RMymN6FQXBQ
	Wpjf9U5PMYyNg24KArn6g==
X-ME-Sender: <xms:hudJZxueW_kVs2ohxxUEPv_tJaLLeBPRnEItJkehkTt2-RusJrNIJg>
    <xme:hudJZ6ev6O6QFFK6JYMoo_gXOM0XYz71vUAASUvlmhiJ2Fc7TvFQPgPKXyG9d6S8L
    G5OonhD-vgc47jZkjQ>
X-ME-Received: <xmr:hudJZ0wsN35bCznX5KQsKyfhgXb3hm5clUdCb31XgmJ_OzmUQn90Vbbtyn0e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepveduvddtveehteekvdeiueegheeiveej
    keetfefgfeeffeejgfdvfedtleeufeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsuges
    qhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtgho
    mhdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtoh
    epvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprh
    gtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:h-dJZ4OQPVI-aJ407RFetLnV2QX09M6Pt4cKiikVdSQl7RoBitFTdw>
    <xmx:h-dJZx_-E2Pt_PFCgtdz4ISYZzgv-YVBiOXwInL1jvt3-3wKfzbxOQ>
    <xmx:h-dJZ4WpTc3NwUAE8aaIWubeXwv16SLuSEue_6EDNZAf1A2VX1cquA>
    <xmx:h-dJZyc9mD9m4yE-PZ2bKgQOcnsrfqqPl2wh2M5tgy23BiTApP_7qQ>
    <xmx:h-dJZ9S_eUS3ZsCvHyQHod2WvHzLv7cA3uzjeQUwYpsuNgZTP1g8eghy>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Nov 2024 11:10:46 -0500 (EST)
Date: Fri, 29 Nov 2024 17:10:43 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v11 09/23] ovpn: implement basic RX path (UDP)
Message-ID: <Z0nng5uN6dlQrQEa@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-9-de4698c73a25@openvpn.net>
 <eabe28f9-d6a4-4bdc-a988-418e5137f3cb@gmail.com>
 <288f68cd-533a-4253-85c4-951cc4a9c862@openvpn.net>
 <aac209cc-589c-4b8a-9123-e44df9e794e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aac209cc-589c-4b8a-9123-e44df9e794e4@gmail.com>

2024-11-26, 02:32:38 +0200, Sergey Ryazanov wrote:
> On 15.11.2024 17:02, Antonio Quartulli wrote:
> > On 11/11/2024 02:54, Sergey Ryazanov wrote:
> > [...]
> > > > +    skb_reset_transport_header(skb);
> > > > +    skb_probe_transport_header(skb);
> > > > +    skb_reset_inner_headers(skb);
> > > > +
> > > > +    memset(skb->cb, 0, sizeof(skb->cb));
> > > 
> > > Why do we need to zero the control buffer here?
> > 
> > To avoid the next layer to assume the cb is clean while it is not.
> > Other drivers do the same as well.
> 
> AFAIR, there is no convention to clean the control buffer before the handing
> over. The common practice is a bit opposite, programmer shall not assume
> that the control buffer has been zeroed.
> 
> Not a big deal to clean it here, we just can save some CPU cycles avoiding
> it.
> 
> > I think this was recommended by Sabrina as well.
> 
> Curious. It's macsec that does not zero it, or I've not understood how it
> was done.

I only remember discussing a case [1] where one function within ovpn
was expecting a cleared skb->cb to behave correctly but the caller did
not clear it. In general, as you said, clearing cb "to be nice to
other layers" is not expected. Sorry if some comments I made were
confusing.

[1] https://lore.kernel.org/netdev/ZtXOw-NcL9lvwWa8@hog


> > > > +struct ovpn_struct *ovpn_from_udp_sock(struct sock *sk)
> > > > +{
> > > > +    struct ovpn_socket *ovpn_sock;
> > > > +
> > > > +    if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) !=
> > > > UDP_ENCAP_OVPNINUDP))
> > > > +        return NULL;
> > > > +
> > > > +    ovpn_sock = rcu_dereference_sk_user_data(sk);
> > > > +    if (unlikely(!ovpn_sock))
> > > > +        return NULL;
> > > > +
> > > > +    /* make sure that sk matches our stored transport socket */
> > > > +    if (unlikely(!ovpn_sock->sock || sk != ovpn_sock->sock->sk))
> > > > +        return NULL;
> > > > +
> > > > +    return ovpn_sock->ovpn;
> > > 
> > > Now, returning of this pointer is safe. But the following TCP
> > > transport support calls the socket release via a scheduled work.
> > > What extends socket lifetime and makes it possible to receive a UDP
> > > packet way after the interface private data release. Is it correct
> > > assumption?
> > 
> > Sorry you lost me when sayng "following *TCP* transp[ort support calls".
> > This function is invoked only in UDP context.
> > Was that a typ0?
> 
> Yeah, you are right. The question sounds like a riddle. I should eventually
> stop composing emails at midnight. Let me paraphrase it.
> 
> The potential issue is tricky since we create it patch-by-patch.
> 
> Up to this patch the socket releasing procedure looks solid and reliable.
> E.g. the P2P netdev destroying:
> 
>   ovpn_netdev_notifier_call(NETDEV_UNREGISTER)
>     ovpn_peer_release_p2p
>       ovpn_peer_del_p2p
>         ovpn_peer_put
>           ovpn_peer_release_kref
>             ovpn_peer_release
>               ovpn_socket_put
>                 ovpn_socket_release_kref
>                   ovpn_socket_detach
>                     ovpn_udp_socket_detach
>                       setup_udp_tunnel_sock
>   netdev_run_todo
>     rcu_barrier  <- no running ovpn_udp_encap_recv after this point

It's more the synchronize_net in unregister_netdevice_many_notify?
rcu_barrier waits for pending kfree_rcu/call_rcu, synchronize_rcu
waits for rcu_read_lock sections (see the comments for rcu_barrier and
synchronize_rcu in kernel/rcu/tree.c).

>     free_netdev
> 
> After the setup_udp_tunnel_sock() call no new ovpn_udp_encap_recv() will be
> spawned. And after the rcu_barrier() all running ovpn_udp_encap_recv() will
> be done. All good.
> 
> Then, the following patch 'ovpn: implement TCP transport' disjoin
> ovpn_socket_release_kref() and ovpn_socket_detach() by scheduling the socket
> detach function call:
> 
>   ovpn_socket_release_kref
>     ovpn_socket_schedule_release
>       schedule_work(&sock->work)
> 
> And long time after the socket will be actually detached:
> 
>   ovpn_socket_release_work
>     ovpn_socket_detach
>       ovpn_udp_socket_detach
>         setup_udp_tunnel_sock
> 
> And until this detaching will take a place, UDP handler can call
> ovpn_udp_encap_recv() whatever number of times.
> 
> So, we can end up with this scenario:
> 
>   ovpn_netdev_notifier_call(NETDEV_UNREGISTER)
>     ovpn_peer_release_p2p
>       ovpn_peer_del_p2p
>         ovpn_peer_put
>           ovpn_peer_release_kref
>             ovpn_peer_release
>               ovpn_socket_put
>                 ovpn_socket_release_kref
>                   ovpn_socket_schedule_release
>                     schedule_work(&sock->work)
>   netdev_run_todo
>     rcu_barrier
>     free_netdev
> 
>   ovpn_udp_encap_recv  <- called for an incoming UDP packet
>     ovpn_from_udp_sock <- returns pointer to freed memory
>     // Any access to ovpn pointer is the use-after-free
> 
>   ovpn_socket_release_work  <- kernel finally ivoke the work
>     ovpn_socket_detach
>       ovpn_udp_socket_detach
>         setup_udp_tunnel_sock
> 
> To address the issue, I see two possible solutions:
> 1. flush the workqueue somewhere before the netdev release
> 2. set ovpn_sock->ovpn = NULL before scheduling the socket detach

Going with #2, we could fully split detach into a synchronous part and
async part (with async not needed for UDP). detach_sync clears the
pointers (CBs, strp_stop(), ovpn_sock->ovpn, setup_udp_tunnel_sock) so
that no more packets will be sent through the ovpn driver.

Related to that topic, I'm not sure what's keeping a reference on the
peer to guarantee it doesn't get freed before we're done with
peer->tcp.tx_work at the end of ovpn_tcp_socket_detach. Maybe all this
tcp stuff should move from the peer to ovpn_socket?

-- 
Sabrina

