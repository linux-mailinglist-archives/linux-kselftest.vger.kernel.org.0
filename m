Return-Path: <linux-kselftest+bounces-19459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E9E998C9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 18:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173671F2337D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 16:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768FA1CC15C;
	Thu, 10 Oct 2024 16:01:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F203E4207F;
	Thu, 10 Oct 2024 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576076; cv=none; b=WP3AgubWdFZWewN/EySnk8Xm9UWuQWCFiLYjJkUX47iz25L8LMTYOj6RwwBjo5gZdsXqONguLuyLzossi/Q51WfwMoXZFbs2ElMtxV2LCmGdYgBNdiTy3PZlEbdJNGNYnF4S1zoF2Qlr3leK+JV0uhf0/4A3MzRQb+KcV9axlJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576076; c=relaxed/simple;
	bh=UH4y1cVuG/rp5iFVwmdeZSf8A6fP63A4SCsHVcjrGq4=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=EkhqTZTkuNv1FerwjRO4ytQXCjuqjYwOprfu5XFTrM63aUod4KvmpOjCMqNmk4//X7CN6QTpNE2FMfXOKGnuBj4EX8jtF5fAV7Zpl9ck5fOXCMSXdR1nGiBYfD7cB3XBvNxDjClJb9Po8KM6AmSt42tlmRKkEEADEhEtQfmbt/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPZBV4d5xz6J7t4;
	Thu, 10 Oct 2024 23:56:50 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id CB3FC140518;
	Fri, 11 Oct 2024 00:01:11 +0800 (CST)
Received: from GurSIX1 (10.204.104.168) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 18:01:05 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: 'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
References: <cover.1728555449.git.gur.stavi@huawei.com> <9e15c0c2cd19d94207a1791de0dc9051a5abb95a.1728555449.git.gur.stavi@huawei.com> <6707d56835f42_2029212942b@willemb.c.googlers.com.notmuch>
In-Reply-To: <6707d56835f42_2029212942b@willemb.c.googlers.com.notmuch>
Subject: RE: [PATCH net-next v03 1/3] af_packet: allow fanout_add when socket is not RUNNING
Date: Thu, 10 Oct 2024 19:00:58 +0300
Message-ID: <000001db1b2d$9f9a00f0$dece02d0$@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHbGv7mksA7veRkl0u2n9N9OvQm77J/18cAgABJxLA=
Content-Language: en-us
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 frapeml500005.china.huawei.com (7.182.85.13)

> Gur Stavi wrote:
> > PACKET socket can retain its fanout membership through link down and up
> > and leave a fanout while closed regardless of link state.
> > However, socket was forbidden from joining a fanout while it was not
> > RUNNING.
> >
> > This patch allows PACKET socket to join fanout while not RUNNING.
> >
> > The previous test for RUNNING also implicitly tested that the socket is
> > bound to a device. An explicit test of ifindex was added instead.
> >
> > Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
> > ---
> >  net/packet/af_packet.c | 35 +++++++++++++++++++++--------------
> >  1 file changed, 21 insertions(+), 14 deletions(-)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index f8942062f776..8137c33ab0fd 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -1843,26 +1843,29 @@ static int fanout_add(struct sock *sk, struct
> fanout_args *args)
> >  		match->prot_hook.ignore_outgoing = type_flags &
> PACKET_FANOUT_FLAG_IGNORE_OUTGOING;
> >  		list_add(&match->list, &fanout_list);
> >  	}
> > -	err = -EINVAL;
> >
> >  	spin_lock(&po->bind_lock);
> > -	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
> > -	    match->type == type &&
> > -	    match->prot_hook.type == po->prot_hook.type &&
> > -	    match->prot_hook.dev == po->prot_hook.dev) {
> > +	if (po->ifindex == -1 || po->num == 0) {
> 
> This patch is more complex than it needs to be.
> 
> No need to block the case of ETH_P_NONE or not bound to a socket.


ETH_P_NONE was blocked before as well.
packet_do_bind will not switch socket to RUNNING when proto is 0.

	if (proto == 0 || !need_rehook)
		goto out_unlock;

Same for packet_create.

So the old condition could only pass the RUNNING condition if proto
was non-zero.
The new condition is exactly equivalent except for allowing IFF_UP
to be cleared in the bound device.


Yes, the same result could be achieved with a FEW less line changes
but I think that the new logic is more readable where every clause
explains itself with a comment instead of constructing one large if
statement. And since the solution does add another nested if for the
RUNNING the extra indentation started to look ugly.

> 
> I would have discussed that in v2, but you already respun.
> 
> > +		/* Socket can not receive packets */
> > +		err = -ENXIO;
> > +	} else if (match->type != type ||
> > +		   match->prot_hook.type != po->prot_hook.type ||
> > +		   match->prot_hook.dev != po->prot_hook.dev) {
> > +		/* Joining an existing group, properties must be identical */
> > +		err = -EINVAL;
> > +	} else if (refcount_read(&match->sk_ref) >= match->max_num_members)
> {
> >  		err = -ENOSPC;
> > -		if (refcount_read(&match->sk_ref) < match->max_num_members) {
> > +	} else {
> > +		/* Paired with packet_setsockopt(PACKET_FANOUT_DATA) */
> > +		WRITE_ONCE(po->fanout, match);
> > +		po->rollover = rollover;
> > +		rollover = NULL;
> > +		refcount_set(&match->sk_ref, refcount_read(&match->sk_ref) +
> 1);
> > +		if (packet_sock_flag(po, PACKET_SOCK_RUNNING)) {
> >  			__dev_remove_pack(&po->prot_hook);
> > -
> > -			/* Paired with packet_setsockopt(PACKET_FANOUT_DATA) */
> > -			WRITE_ONCE(po->fanout, match);
> > -
> > -			po->rollover = rollover;
> > -			rollover = NULL;
> > -			refcount_set(&match->sk_ref, refcount_read(&match-
> >sk_ref) + 1);
> >  			__fanout_link(sk, po);
> > -			err = 0;
> >  		}
> > +		err = 0;
> >  	}
> >  	spin_unlock(&po->bind_lock);
> >
> > @@ -3452,8 +3455,12 @@ static int packet_create(struct net *net, struct
> socket *sock, int protocol,
> >  	po->prot_hook.af_packet_net = sock_net(sk);
> >
> >  	if (proto) {
> > +		/* Implicitly bind socket to "any interface" */
> > +		po->ifindex = 0;
> >  		po->prot_hook.type = proto;
> >  		__register_prot_hook(sk);
> > +	} else {
> > +		po->ifindex = -1;
> >  	}
> >
> >  	mutex_lock(&net->packet.sklist_lock);
> > --
> > 2.45.2
> >
> 



