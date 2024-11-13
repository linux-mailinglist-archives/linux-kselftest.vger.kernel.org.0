Return-Path: <linux-kselftest+bounces-21912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370DA9C6CF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 11:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7351F22F6A
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 10:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379FC1FE0E1;
	Wed, 13 Nov 2024 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="hJFxK9V4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i1BFr7+W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698B318A6D1;
	Wed, 13 Nov 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731494179; cv=none; b=g+5BlmmzOEwbsqtuB8uwOP8J3yhLdRP5y3Y+zxQ7CwjdekRwyNTRDzmEwAeqJi8ARbTRfxweYCd41XttwiJ2u20pK/mLnBDF8oiqrP2Phwq4DsY1GNUcHFkXSib68p6Oej3fuvSMxuNYJaHKBxfrKOgPUnn9uACqhZY/vQJW+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731494179; c=relaxed/simple;
	bh=yLO/Ts8jUeJARWVb+zMtKwsDIocTm/3IsSv1rnWRZd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2X42U7UBRlvMLWF+SpQeFNr3QPsQS74fvlxAhmBoT7FqRteaeeb4L1ckHq4VgNB8z5xlbVX7zMLZZTiI+IfWkqCsoWdGUTpTpwUOQ0IENS7pyE8JwOQJQl3/4iUjVQHloqv3WTfr0yZ5jtiClGv3jA5kxgTIWYRwsHs2ClxgD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=hJFxK9V4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i1BFr7+W; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 3BC55201D79;
	Wed, 13 Nov 2024 05:36:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 13 Nov 2024 05:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731494174; x=
	1731497774; bh=JS8GGHOUfqV2VFOaX7E5RBnve3G+rENns81TnjIOP00=; b=h
	JFxK9V4zWGmn/8QxrP0In2Op6vxHQnATVJiP0t/GcsJ1BcnhAb9imDFdnk6it4JW
	YQ+m5ddXfbIG6WTBP46ZXLN8j1hgx/zVJ7BrVRum/Wu0csgDQ0OauS18lb+dyWUc
	E1kT2px4wf/XmnJGJAo/GOnJRSAwki/KRDavzyL00DblHFvf4h0VQKqa9EfL/Xqy
	Et/LWAHYfe+hboRvTYBEI2cr+eHDNhF/eRbqNP9kRcIvWLu754C6t8UAp1TJIIum
	BesRekg3Op/5PAZ1FOjrrx0FT1KWOFaN+pJrtnCAelD/zou+ikUIMiKCHWVqrTbH
	NT4W4PklsAjxzE2zYVVfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731494174; x=1731497774; bh=JS8GGHOUfqV2VFOaX7E5RBnve3G+rENns81
	TnjIOP00=; b=i1BFr7+WryUKFttGHpKBgIw7i2AICc83v+U2gJlWAw+cqH9b1Bu
	zl4RgUQR/kMsbitqoe5yBzrZB0dlLQRanrsWh6rxhNhVyBI7jZuJ0wZw+hXqHgAi
	OUrEYrtSzDnRxtFCvvk09LGK8dz7k185me52Zd8+kbu+keUA8/IZ4OmEjhvlnAVd
	ioj+qy5PDDxG1CTZntQ45PZ+1hZOhcP95ZlSlhtVZsCDXHFRmkJOOhzpe50jJPMO
	KxOY56pbrUxvHd7poFmo4sl/Kt9s+lEySbreyB5qXjBCx9AfnCAli4p/zbWroHKE
	/0hDHrX1njMO3yU/lPjuYfVSzm1S+mqJH5g==
X-ME-Sender: <xms:HYE0Z97TslQXmrb_NjleZ7ASKW5XhCtNJlMkyAl9NNLcL_fHTfKIpQ>
    <xme:HYE0Z67FG9e7hb3cTxqoa9KeW3n4AnJ52Dl_Jzea5fgdr7_qXqqM58xVsxZobMKAm
    1CH00t0jdWkViA6fDA>
X-ME-Received: <xmr:HYE0Z0fXNaLay2Cg9wp2Meu_YSY5twgmpRQHjO25L8IFVcIKdAn1s_Z0eGOJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeeg
    teehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnih
    hosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhnrghlugdrhhhu
    nhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprhihrgiirghnohhvrdhsrdgrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HYE0Z2LfrbxtAgH7CfM4Z6KnqtQ6wc3uNVe6h22rS2ItgmWuqDf_AQ>
    <xmx:HYE0ZxLtVbPH_-UVYGpGU4z5iy3eCODN6NskYgOFh07Gb2kkn4ebgw>
    <xmx:HYE0Z_y4Ejgf7IY_8473McZzCyS8fsNnDoUwDhKNYYcFll0SgCP30w>
    <xmx:HYE0Z9K8GDVElI8X5cckgdBEn8RcdvocbFVpNYcZLuSmwqGvB9mc-Q>
    <xmx:HoE0Z48fNf-ZAgtZfUjFSdMNbRlafSxCn1aEvYskMvNJwnWxKFOQKUHv>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 05:36:13 -0500 (EST)
Date: Wed, 13 Nov 2024 11:36:11 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 15/23] ovpn: implement keepalive mechanism
Message-ID: <ZzSBG-RPUlpgVFhA@hog>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-15-de4698c73a25@openvpn.net>
 <ZypfnyfToF1b6YAZ@hog>
 <189dbeea-127a-47e8-84f8-c8cf1cc03536@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <189dbeea-127a-47e8-84f8-c8cf1cc03536@openvpn.net>

2024-11-12, 14:20:45 +0100, Antonio Quartulli wrote:
> On 05/11/2024 19:10, Sabrina Dubroca wrote:
> > 2024-10-29, 11:47:28 +0100, Antonio Quartulli wrote:
> > > @@ -105,6 +132,9 @@ void ovpn_decrypt_post(void *data, int ret)
> > >   		goto drop;
> > >   	}
> > > +	/* keep track of last received authenticated packet for keepalive */
> > > +	peer->last_recv = ktime_get_real_seconds();
> > 
> > It doesn't look like we're locking the peer here so that should be a
> > WRITE_ONCE() (and READ_ONCE(peer->last_recv) for all reads).
> 
> Is that because last_recv is 64 bit long (and might be more than one word on
> certain architectures)?
> 
> I don't remember having to do so for reading/writing 32 bit long integers.

AFAIK it's not just that. The compiler is free to do the read/write in
any way it wants when you don't specify _ONCE. On the read side, it
could read from memory a single time or multiple times (getting
possibly different values each time), or maybe split the load
(possibly reading chunks from different values being written in
parallel).

> I presume we need a WRITE_ONCE also upon initialization in
> ovpn_peer_keepalive_set() right?
> We still want to coordinate that with other reads/writes.

I think it makes sense, yes.

> > > +
> > >   	/* point to encapsulated IP packet */
> > >   	__skb_pull(skb, payload_offset);
> > > @@ -121,6 +151,12 @@ void ovpn_decrypt_post(void *data, int ret)
> > >   			goto drop;
> > >   		}
> > > +		if (ovpn_is_keepalive(skb)) {
> > > +			net_dbg_ratelimited("%s: ping received from peer %u\n",
> > > +					    peer->ovpn->dev->name, peer->id);
> > > +			goto drop;
> > 
> > To help with debugging connectivity issues, maybe keepalives shouldn't
> > be counted as drops? (consume_skb instead of kfree_skb, and not
> > incrementing rx_dropped)
> > The packet was successfully received and did all it had to do.
> 
> you're absolutely right. Will change that.

Thanks.

> > > +	/* check for peer timeout */
> > > +	expired = false;
> > > +	timeout = peer->keepalive_timeout;
> > > +	delta = now - peer->last_recv;
> > 
> > I'm not sure that's always > 0 if we finish decrypting a packet just
> > as the workqueue starts:
> > 
> >    ovpn_peer_keepalive_work
> >      now = ...
> > 
> >                                         ovpn_decrypt_post
> >                                           peer->last_recv = ...
> > 
> >    ovpn_peer_keepalive_work_single
> >      delta: now < peer->last_recv
> > 
> 
> Yeah, there is nothing preventing this from happening...but is this truly a
> problem? The math should still work, no?

We'll fail "delta < timeout" (which we shouldn't), so we'll end up
either in the "expired = true" case, or not updating
keepalive_recv_exp. Both of these seem not ideal.

> 
> However:
> 
> > 
> > 
> > > +	if (delta < timeout) {
> > > +		peer->keepalive_recv_exp = now + timeout - delta;
> > 
> > I'd shorten that to
> > 
> >      peer->keepalive_recv_exp = peer->last_recv + timeout;
> > 
> > it's a bit more readable to my eyes and avoids risks of wrapping
> > values.
> > 
> > So I'd probably get rid of delta and go with:
> > 
> >      last_recv = READ_ONCE(peer->last_recv)
> >      if (now < last_recv + timeout) {
> >      	peer->keepalive_recv_exp = last_recv + timeout;
> >      	next_run1 = peer->keepalive_recv_exp;
> >      } else if ...
> > 
> > > +		next_run1 = peer->keepalive_recv_exp;
> > > +	} else if (peer->keepalive_recv_exp > now) {
> > > +		next_run1 = peer->keepalive_recv_exp;
> > > +	} else {
> > > +		expired = true;
> > > +	}
> 
> I agree this is simpler to read and gets rid of some extra operations.
> 
> [note: I took inspiration from nat_keepalive_work_single() - it could be
> simplified as well I guess]

Ah, ok. I wanted to review this code when it was posted but didn't
have time :(

> > 
> > [...]
> > > +	/* check for peer keepalive */
> > > +	expired = false;
> > > +	interval = peer->keepalive_interval;
> > > +	delta = now - peer->last_sent;
> > > +	if (delta < interval) {
> > > +		peer->keepalive_xmit_exp = now + interval - delta;
> > > +		next_run2 = peer->keepalive_xmit_exp;
> > 
> > and same here
> 
> Yeah, will change both. Thanks!

Thanks.

-- 
Sabrina

