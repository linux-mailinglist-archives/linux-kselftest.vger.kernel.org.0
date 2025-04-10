Return-Path: <linux-kselftest+bounces-30480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B41A845A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 16:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2382C3B321D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F004F2857C7;
	Thu, 10 Apr 2025 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="C+FJ+ww3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e621RUxM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18CA1BC5C;
	Thu, 10 Apr 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293846; cv=none; b=XfgUQa4aCi1DEYJdqmDIUCpawskCM60SmdwQFJ5MCndOZacAxEYjzYMMiXQ9B38P9aldMnZHsL5IkaI1yD1Fo5sipp0ad00HPdNMmbCkbb1fp4aQh8fiYnJISRtuFL/1/7fRHkgNNACaqw3azGcsy4iXZSDyxxlLL7+FZZns6jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293846; c=relaxed/simple;
	bh=VZtNoCf3M0bCxDHC8D/FIk+anVcQU6h7SXrw27QGv1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOED31+fwKtAPTErwO5oiSeL2Icboxvf739rpaPWJqWRph2EwgANE0ESci9oXicngvRwug+y/Cbqf7FOYvqbEqxbjuEUqa90W45D+WGzP+R6+VOuqvqIsj3CvuN51bkzERAft4X4TzL71fhGvZy+/CS5CBIaebn+hDA5KK6QAkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=C+FJ+ww3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e621RUxM; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A87331380159;
	Thu, 10 Apr 2025 10:04:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 10 Apr 2025 10:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1744293841; x=
	1744380241; bh=kg+ncTFTY0e1tAlwafnt/dQr4xIAVAaQ5+ezMmfWoiQ=; b=C
	+FJ+ww3czpNOXdQJJkVedN1q+7cFF9aQbuLmGlfSuxwJRlP5VYPYQwCJyTl36Pvv
	lpkRSchCSZuovSWSoFJumyw6xfDGHSYyxZ9DhffmW9MkoXU2ileCa3XpIEACtv/F
	hSeOOncxLogY93AIAu682Li1h7sgGnD5jZtUcyiJk3MzoTzjWFKjlns9/sDw5l0f
	tEDR3UDHlzvW4+v2QP8bzyYXFb91KPuKvy6loPX0JJINzBdcH3C5J4abhCzZoiTZ
	XLLSmD4Ev/bWT8icjN6fDk7mGMDSx7NnfYKnPSPfkjrZ+ARHJhaJit/hgcVI01fb
	2uNKxCtJzBSsDb9E43oYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744293841; x=1744380241; bh=kg+ncTFTY0e1tAlwafnt/dQr4xIAVAaQ5+e
	zMmfWoiQ=; b=e621RUxMIlhsFmxMUA002Kk5gJknqmUJKTyg90GG/o6n7NRTQb5
	eJiWYIUZInraz1nYTOBGFi57GaqJPldTrg8OFhd+GU6I3Z+B3fouIrNBQKvCp2bX
	LZ86W4b3GLq0Sdxbw3W+mdOKwEii4rLDJqlfFl8/wEZq03ynkRpkkp3fpFEnam/k
	drt2fSLw7V5+ZXspwcegmvlTAC2BAYkb2YqiBDs01bI8xzwjcCzENa4Qhp8PvJBF
	yyU5LBhF2dz1P7A5CeKz0s7U40NrECfRiX8Wm2kV+Lh13mbYMQLtPnetYyj0J7ja
	D0TsOwn7TNoMhNHAg5rtotR43LnhT+/2PWw==
X-ME-Sender: <xms:0M_3Z48v5qmD2qqc5pp7gNPBjHMEJPlQ104yt7tYvl1M_-rgO2bkjA>
    <xme:0M_3ZwvWhkcJOLGGhu-O5NQSmnWI2SH5CLcTPmMylEc9oAbY9c4ovkeuN-kuIkFDX
    s9svrucfPnbPG1RSag>
X-ME-Received: <xmr:0M_3Z-BcO2xmeRLNQGCC4q538p3aepo6BXzKQP675ZDcMZwOsN_uEFtIXzL9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeludduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnheptddvhffhhfdugfegvdejfeetuddt
    tdejteehfeejvdeugeffkefhgfffheeuudffnecuffhomhgrihhnpehgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehs
    ugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudelpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvght
    pdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
    dprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhihrgiirghnoh
    hvrdhsrdgrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggv
    vheslhhunhhnrdgthh
X-ME-Proxy: <xmx:0M_3Z4c3G44RqWAjiT5kQ7RQfFTjIqT2zyYt0s7JMPJV-UwIOmRogg>
    <xmx:0M_3Z9OyMXRkISBOi16SLG69oV9HGmw1_tof2MWU-GSSdm9CQOwU9A>
    <xmx:0M_3ZylSPXWgTLxMLFVbChFBMKc7gzmRrIL_VtqYLWVQ775Cdbsdog>
    <xmx:0M_3Z_tiVsE1CCKDNm-xcqPE5yLAxlm3K3My5fJPitpA773Mm2oNbw>
    <xmx:0c_3Z-u76LlzOm866oCqvQpwP7PZK1m2tfZbqX7haTnflbdi8_2SKxzs>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Apr 2025 10:04:00 -0400 (EDT)
Date: Thu, 10 Apr 2025 16:03:57 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
	steffen.klassert@secunet.com, antony.antony@secunet.com,
	willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH net-next v25 00/23] Introducing OpenVPN Data Channel
 Offload
Message-ID: <Z_fPzdq3PSw1efTW@krikkit>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>

2025-04-07, 21:46:08 +0200, Antonio Quartulli wrote:
> Notable changes since v24:
> * disable TCP disconnections of attached sockets (tcp_disconnect()
>   returns -EBUSY) - similarly to kTLS.
> * used rcu_replace_pointer instead of rcu_dereference_protected+rcu_assign_pointer
> * dropped useless skb->ignore_df = 1
> * dropped unneded EXPORT_SYMBOL_GPL(udpv6_prot)
> * dropped obsolete comment for ovpn_crypto_key_slots_swap()
> * dropped calls to kfree() in ovpn_aead_encrypt/decrypt() (release is
>   performed in ovpn_encrypt/decrypt_post())
> * dropped NULL check before calling kfree() in
>   ovpn_encrypt/decrypt_done()
> * converted seq_num from atomic64_t to atomic_t (IV exhaustion is now
>   detected in case of wrap around)
> * call consume_skb() on skb when dropping keepalive message (it is not a
>   failure)
> * made REMOTE_PORT mandatory when REMOTE_IPV4/6 is specified in
>   peer_new/set call
> * ensured ovpn_nl_key_swap_notify() is called only once, even when
>   parsing a batch of received packets concurrently
> 
> Please note that some patches were already reviewed/tested by a few
> people. These patches have retained the tags as they have hardly been
> touched.
> 
> The latest code can also be found at:
> 
> https://github.com/OpenVPN/ovpn-net-next
> 
> Thanks a lot!
> Best Regards,
> 
> Antonio Quartulli
> OpenVPN Inc.
> 
> ---
> Antonio Quartulli (23):
>       net: introduce OpenVPN Data Channel Offload (ovpn)
>       ovpn: add basic netlink support
>       ovpn: add basic interface creation/destruction/management routines
>       ovpn: keep carrier always on for MP interfaces
>       ovpn: introduce the ovpn_peer object
>       ovpn: introduce the ovpn_socket object
>       ovpn: implement basic TX path (UDP)
>       ovpn: implement basic RX path (UDP)
>       ovpn: implement packet processing
>       ovpn: store tunnel and transport statistics
>       ovpn: implement TCP transport
>       skb: implement skb_send_sock_locked_with_flags()
>       ovpn: add support for MSG_NOSIGNAL in tcp_sendmsg
>       ovpn: implement multi-peer support
>       ovpn: implement peer lookup logic
>       ovpn: implement keepalive mechanism
>       ovpn: add support for updating local or remote UDP endpoint
>       ovpn: implement peer add/get/dump/delete via netlink
>       ovpn: implement key add/get/del/swap via netlink
>       ovpn: kill key and notify userspace in case of IV exhaustion
>       ovpn: notify userspace when a peer is deleted
>       ovpn: add basic ethtool support
>       testing/selftests: add test tool and scripts for ovpn module

For the series:
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks again for your patience, Antonio.

-- 
Sabrina

