Return-Path: <linux-kselftest+bounces-23407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315879F2EDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 12:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69651883FF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689AE204096;
	Mon, 16 Dec 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="RTlmaYDF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RjpzLea7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FC0203D7F;
	Mon, 16 Dec 2024 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347403; cv=none; b=PAHhMQF8fU/qok4P9Ai+v0icu+/J+PL5UMR4GNlPZ4E0zHoFV2mDb/WnG7hDX9s/xCyAJucJoLYMqzfyR8ck9cV0bp7afYW0uuuiVVhGelyQCAfCFqTydPnf4E1lv9W4/rpDvpdUBDSTUPIvsR3s1FcIK+n5g0OnFw9DwQsH/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347403; c=relaxed/simple;
	bh=xn95Pi4umwEL5V6TEFqfsF5iwXrY6u8D2aQGSHcBbdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL8gH0KTiJ6gE8p07EFTCXJIfyIQL52J5OS3inFO43r3kvc6V8sahkv6lU2BOu+1smMsGlfGKJQUOxryh6OPhVUNmZFhXFT0spHt0xpH1I4RIlNWLx5eI1h/jhz3cHUTR4pDyEBaKnTM88BiBJWnYovpOi2QQ3H0oZvg1SzzOTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=RTlmaYDF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RjpzLea7; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id CE0E313838F6;
	Mon, 16 Dec 2024 06:09:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 16 Dec 2024 06:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1734347397; x=
	1734433797; bh=ScOq+swQzHKW0GAW9g0fDYWS5GmMw3Ms2ywzxyyuIZ8=; b=R
	TlmaYDF8bHiHa1upgTGd64ZNqHtz7JYzrB5plbvPx557SvTAFFlzXjHynQkbqn6P
	lWLWbWWoXyHEbyJmYeaepWbr0JYij0PEiZFd2IWv2dEBAuKdYKe5YgX5nuGmIA0s
	CkkYUpa9HhEQ4UV7JJpFEkIQ/318AFrK8SBZ+3AvUa0hIMUcAXC9Um8SpVbIg9rt
	clUSR9K4KiCWcJkDKO7Js++NOOwC7H4RsrEolrf3mJmHrZEeLLN18UiZaxbN4aaB
	CQ6ycKEwOKBZQ4IRJrXKkh/D4J3kRwiOLYlnQuctdn+gUvGOLDMT54heeNSAHEXn
	mphhY2vT7Uqeq7trUlJhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734347397; x=1734433797; bh=ScOq+swQzHKW0GAW9g0fDYWS5GmMw3Ms2yw
	zxyyuIZ8=; b=RjpzLea7xVwGsrWp66aQvY6fMFRRKzDEq8zPSjc3PfyVFNZYuYB
	kS9GSJECA95Vzg8fYIcpEDJThXuW82wBvsdTFsrpx29XoHQ5WMizC/aVupZ2sUSa
	OYnQlbqsu7Sq5Z041jyXsW5iyqIKDjXRNiDdtON4ak1odS/CZhIOgeqQDWnlIdG1
	HOY99mSc4TF5Jaqm+87HGsSxmbNDRxWdjZd3gpTiDAPkp5uty+VXh3zTFI5bAiA/
	ZSJ0vgl2Q3vRCSHWKLwspGE2t1Huu7/z7Uw6J2JtiNpIoKnTWwJJ7wgdqcA5b3tO
	gaeD5saDgMXEV53RSqzb3os/8TK6WvJPD0Q==
X-ME-Sender: <xms:hQpgZ-vQDKU4jzgdouM_9L7o5_hQjLnXO37wwZlLVPdjVxuxvHRYUA>
    <xme:hQpgZzcywnSuh5Ugm8KSwxJkI33JhiJyB4eEki-WoRKDMRm8WADFihTF0AxDd75tL
    EYorYyexXFAXl31H2c>
X-ME-Received: <xmr:hQpgZ5wj4SMCDnl-yYJ7tzp_350RAMpRy9tS0mQxnlWdhFMhX9YXwUXtAw4W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeeg
    teehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnih
    hosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:hQpgZ5O9je3oFbYEZX4Ggm67R2SV680KnPR16lCKsuGi9uuCMbD2yA>
    <xmx:hQpgZ--Nc_coUJ7r8yXyPOtiNiQnOTK6dVg_KnNIqRlT7dSqDgh0IA>
    <xmx:hQpgZxXF8shc7m8X3pDwOw1a-Jntm-CdETg8_CsFczuJ5hlCJ4h4zw>
    <xmx:hQpgZ3dZaAQMkH95u55RY5bcLJHpaUgRWItm33KJlIT1jcXSMoZhqg>
    <xmx:hQpgZyWgcFMQvCPAKNZc6dJZm0Y600eTPaYCZEWmi8o7ToTRei_Wc3_h>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 06:09:56 -0500 (EST)
Date: Mon, 16 Dec 2024 12:09:55 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v15 06/22] ovpn: introduce the ovpn_socket object
Message-ID: <Z2AKg6ntLd94anHv@hog>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
 <20241211-b4-ovpn-v15-6-314e2cad0618@openvpn.net>
 <Z1sNEgQLMzZua3mS@hog>
 <fa19f3a8-c273-4d2c-a10e-e9bda2375365@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa19f3a8-c273-4d2c-a10e-e9bda2375365@openvpn.net>

2024-12-12, 23:46:11 +0100, Antonio Quartulli wrote:
> On 12/12/2024 17:19, Sabrina Dubroca wrote:
> > 2024-12-11, 22:15:10 +0100, Antonio Quartulli wrote:
> > > +static struct ovpn_socket *ovpn_socket_get(struct socket *sock)
> > > +{
> > > +	struct ovpn_socket *ovpn_sock;
> > > +
> > > +	rcu_read_lock();
> > > +	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
> > > +	if (WARN_ON(!ovpn_socket_hold(ovpn_sock)))
> > 
> > Could we hit this situation when we're removing the last peer (so
> > detaching its socket) just as we're adding a new one? ovpn_socket_new
> > finds the socket already attached and goes through the EALREADY path,
> > but the refcount has already dropped to 0?
> > 
> 
> hm good point.
> 
> > Then we'd also return NULL from ovpn_socket_new [1], which I don't
> > think is handled well by the caller (at least the netdev_dbg call at
> > the end of ovpn_nl_peer_modify, maybe other spots too).
> > 
> > (I guess it's not an issue you would see with the existing userspace
> > if it's single-threaded)
> 
> The TCP patch 11/22 will convert the socket release routine to a scheduled
> worker.

Oh right, I forgot about that.

> This means we can have the following flow:
> 1) userspace deletes a peer -> peer drops its reference to the ovpn_socket
> 2) ovpn_socket refcnt may hit 0 -> cleanup/detach work is scheduled, but not
> yet executed
> 3) userspace adds a new peer -> attach returns -EALREADY but refcnt is 0
> 
> So not so impossible, even with a single-threaded userspace software.

True, that seems possible.

> > [...]
> > > +struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
> > > +{
> > > +	struct ovpn_socket *ovpn_sock;
> > > +	int ret;
> > > +
> > > +	ret = ovpn_socket_attach(sock, peer);
> > > +	if (ret < 0 && ret != -EALREADY)
> > > +		return ERR_PTR(ret);
> > > +
> > > +	/* if this socket is already owned by this interface, just increase the
> > > +	 * refcounter and use it as expected.
> > > +	 *
> > > +	 * Since UDP sockets can be used to talk to multiple remote endpoints,
> > > +	 * openvpn normally instantiates only one socket and shares it among all
> > > +	 * its peers. For this reason, when we find out that a socket is already
> > > +	 * used for some other peer in *this* instance, we can happily increase
> > > +	 * its refcounter and use it normally.
> > > +	 */
> > > +	if (ret == -EALREADY) {
> > > +		/* caller is expected to increase the sock refcounter before
> > > +		 * passing it to this function. For this reason we drop it if
> > > +		 * not needed, like when this socket is already owned.
> > > +		 */
> > > +		ovpn_sock = ovpn_socket_get(sock);
> > > +		sockfd_put(sock);
> > 
> > [1] so we would need to add
> > 
> >      if (!ovpn_sock)
> >          return -EAGAIN;
> 
> I am not sure returning -EAGAIN is the right move at this point.
> We don't know when the scheduled worker will execute, so we don't know when
> to try again.

Right.

> Maybe we should call cancel_sync_work(&ovpn_sock->work) inside
> ovpn_socket_get()?
> So the latter will return NULL only when it is sure that the socket has been
> detached.
> 
> At that point we can skip the following return and continue along the "new
> socket" path.
> 
> What do you think?

The work may not have been scheduled yet? (small window between the
last kref_put and schedule_work)

Maybe a completion [Documentation/scheduler/completion.rst] would
solve it (but it makes things even more complex, unfortunately):

 - at the end of ovpn_socket_detach: complete(&ovpn_sock->detached);
 - in ovpn_socket_new when handling EALREADY: wait_for_completion(&ovpn_sock->detached);
 - in ovpn_socket_new for the new socket: init_completion(&ovpn_sock->detached);

but ovpn_sock could be gone immediately after complete(). Maybe
something with completion_done() before the kfree_rcu in
ovpn_socket_detach? I'm not that familiar with the completion API.


> However, this makes we wonder: what happens if we have two racing PEER_NEW
> with the same non-yet-attached UDP socket?

mhmm, I remember noticing that, but it seems I never mentioned it in
my reviews. Sorry.

> Maybe we should lock the socket in ovpn_udp_socket_attach() when checking
> its user-data and setting it (in order to make the test-and-set atomic)?

I'd use the lock to protect all of ovpn_socket_new.
ovpn_tcp_socket_attach locks the socket but after doing the initial
checks, so 2 callers could both see sock->sk->sk_user_data == NULL and
do the full attach. And I don't think unlocking before
rcu_assign_sk_user_data is safe for either UDP or TCP.

> I am specifically talking about this in udp.c:
> 
> 345         /* make sure no pre-existing encapsulation handler exists */
> 346         rcu_read_lock();
> 347         old_data = rcu_dereference_sk_user_data(sock->sk);
> 348         if (!old_data) {
> 349                 /* socket is currently unused - we can take it */
> 350                 rcu_read_unlock();
> 351                 setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
> 352                 return 0;
> 353         }
> 
> We will end up returning 0 in both contexts and thus allocate two
> ovpn_sockets instead of re-using the first one we allocated.
> 
> Does it make sense?

Yes.

[...]
> > [I have some more nits/typos here and there but I worry the
> > maintainers will get "slightly" annoyed if I make you repost 22
> > patches once again :) -- if that's all I find in the next few days,
> > everyone might be happier if I stash them and we get them fixed after
> > merging?]
> 
> If we have to rework this socket attaching part, it may be worth throwing in
> those typ0 fixes too :)

ACK, I'll send them out.

> Thanks a lot.

Thanks again for your patience.

-- 
Sabrina

