Return-Path: <linux-kselftest+bounces-24829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F92A17A2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 10:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C797A3C89
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 09:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE3A1D47A2;
	Tue, 21 Jan 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="GLq/3bB8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tPDKcOCT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6161C1ADB;
	Tue, 21 Jan 2025 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737451707; cv=none; b=rQxZMdzQ19808KKLngQR1yJQ3xEKgS1V9GDrzqjsZ58XgBpYsgkbvBeniDXWLCWxO47llxxBf0Mvhfm5XWovtfsw55j1hC2XF3k7vIEEQ2e71Oev2R9WALPWdC9GjsmzrHg3qVYJ03/DqrJBM/CF8owxwOnI8cMb4uD9ArHIIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737451707; c=relaxed/simple;
	bh=WZkt3Jv6yAnm/LloWwBQwAXRcd+YSzYxPm8QEkmnShs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6ca7yykHbc7vtbwGQAxcHkhrf97Rcy5KGOCIJig2JBieCuOPITAgFD6j4DzLKVenqSmELLbX5nvZ3HmOvX0YLxBB6JVId9iNmo6DD3KL+MpR1g9ehzIdLJh45IQf0q1jowSlLtmhQ9R9/rbsuOHmpSvPfR5mPPdPt6iSplAsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=GLq/3bB8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tPDKcOCT; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 35AD32540183;
	Tue, 21 Jan 2025 04:28:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 21 Jan 2025 04:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737451702; x=
	1737538102; bh=nAayf1exjGtAed6y+2MRv/xWdev9aI4NfH4dqFn/hL0=; b=G
	Lq/3bB8oh68nmrVK6S5OhUiJWnTNV8uNXbtihsrhp6TQmgpl2RiA+WZQRcgw7IP8
	YRXduz/Gy4UP/51dlJ/i8zo+8XAi8tYq1RL4PfPZxAEOA2XOp4x0KotsNlwhaZZf
	L+s3EvsN2iwS0PF0l7YkCiwamrlC7Qy9jf70y9DJCyynW6BEBYv5c2OtLL6tYiE4
	9rQIMgfU7ctrBz4AY7cYvLCxuqeBjojKek4MHMWbGJz2rhA/vDdTdy2p0hBUua03
	It6nP5ib8AjL88ZBXfX1lA/hqoLWQMK/lb+IMPpJ7+nxZmtq5I3NfYBz+pZIumBb
	T8hjqBUijpzDLc7E5KLXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737451702; x=1737538102; bh=nAayf1exjGtAed6y+2MRv/xWdev9aI4NfH4
	dqFn/hL0=; b=tPDKcOCTRPTJrTHAJocbSRX/RNXnB6mRWVTCV2pAQVj4LWO8P0q
	0nLTeL6Gipx3BTD4admzHDaxkgG7lPi+ttnQXLWKk+J/ww6JWJniSmEmXG3B6+JK
	7nDXXahJ46wpid4OBQd7dIIJMfIAXsKaJkZ3EhmtBqWBUfDIGcmNKsO+fWemRltg
	ofWBqokMycf4CUAd8lnNH5e9zz2utAxzlN/iqKAB9wp4MyLJpEpSjBu+Sd3VCp3m
	Qx1yfJPDk3urDdeq1OIrjWCcps+LgctZM/pzt8tAGpJ0uRVhIMjUdyJCZa2e7NEQ
	CzjCLVnuwp/AIX9hdygOyXtNW6Ls+ZJjjbg==
X-ME-Sender: <xms:tWiPZ-b2t_Egx-lL2afHpreNQsOWiUBXxbedPLmABH6rbI4-rQ3uyg>
    <xme:tWiPZxbgJIvrPI071swL00OB-inhtDw6bn8QZVDGe6ZwFF-lWhQYfeeqx1_Fu3pqS
    Df49QjvhD-uSvttCbw>
X-ME-Received: <xmr:tWiPZ4-Fr_9acgeFFZqfJeHya4lxN0eK7CmJjNbZM73CwWmOtRfdEW388yHS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejuddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfek
    geetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonh
    hiohesohhpvghnvhhpnhdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggs
    vghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehrhigriigrnhhovhdrshdrrgesghhmrghilhdrtghomhdprhgtphhtth
    hopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghh
X-ME-Proxy: <xmx:tWiPZwrEcfZqgZt8rwXc5q0TIEbKfM2fVDVytQSk6bWc5xNDcHiffA>
    <xmx:tWiPZ5o4DcbGSW9aTjBbuX5a-z91vzUQb3qL6Z4dUkJMQgSpChIC2A>
    <xmx:tWiPZ-QRWm95ba9T5YYRJIAyMBic3lfPa7IAf_ZIsygJpFKZHL_XdA>
    <xmx:tWiPZ5oHOv7Z9sbdjNI2oP-h--nuZ44yGleVTKfOlBzJ_n433SLPXg>
    <xmx:tmiPZ6742nlWhMDLuRAP_JoT1x5Zp7du2nrWslwuRLJBqBf2f_4abLst>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 04:28:21 -0500 (EST)
Date: Tue, 21 Jan 2025 10:28:19 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH net-next v18 12/25] ovpn: implement TCP transport
Message-ID: <Z49osyyCSxWoe2-X@hog>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-12-1f00db9c2bd6@openvpn.net>
 <Z4qP-x4F-lQiQTRy@hog>
 <6ef40195-9648-40db-8e36-a2a0095aa411@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ef40195-9648-40db-8e36-a2a0095aa411@openvpn.net>

2025-01-20, 15:12:28 +0100, Antonio Quartulli wrote:
> On 17/01/2025 18:14, Sabrina Dubroca wrote:
> > 2025-01-13, 10:31:31 +0100, Antonio Quartulli wrote:
> > > +static int ovpn_tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> > > +			    int flags, int *addr_len)
> > > +{
> > > +	int err = 0, off, copied = 0, ret;
> > > +	struct ovpn_socket *sock;
> > > +	struct ovpn_peer *peer;
> > > +	struct sk_buff *skb;
> > > +
> > > +	rcu_read_lock();
> > > +	sock = rcu_dereference_sk_user_data(sk);
> > > +	if (!sock || !sock->peer) {
> > > +		rcu_read_unlock();
> > > +		return -EBADF;
> > > +	}
> > > +	/* we take a reference to the peer linked to this TCP socket, because
> > > +	 * in turn the peer holds a reference to the socket itself.
> 
> Going back now to this specific comment:
> 
> > 
> > Not anymore since v12? [*]
> > 
> > I think it's ok here because we're only using peer and sk (not
> > anything from ovpn_socket), but it is relevant in _sendmsg, which has
> > the same peer_hold pattern without this comment.
> 
> After applying to _sendmsg() the modifications you suggested (i.e. reference
> peer directly instead of sock->peer), it also only uses peer and sk, but not
> ovpn_socket.
> Therefore it should be fine too.
> 
> This said, the comment above should go away or at least should be modified.

It can probably go away completely, taking a ref on an object we're
clearly using is reasonable and I don't think it requires an
explanation, unlike the old scheme with dependencies (which was not
completely obvious). Thanks.

-- 
Sabrina

