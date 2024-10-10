Return-Path: <linux-kselftest+bounces-19424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23478997F1D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 10:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AD828333C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 08:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B041CC16A;
	Thu, 10 Oct 2024 07:08:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED421CC160;
	Thu, 10 Oct 2024 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728544126; cv=none; b=OGR1+XN7LAud+14X9nUCdEjYtDZaANcKucMpCRsDbDR5VH46ljyqnC60IrF6SpERK5aKY3vSUwWE+wUCWgZd0YCSr2/kut3n8T2nq9NU6b8SjBcv0ULBivHOenkwp5ZbiM30Q0oh1fcPC6PNjpINs74FMToxfL5vNE3KZk1R8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728544126; c=relaxed/simple;
	bh=0mHBn27Gk9XwRvdcLUXt8GP/u9sorgQCzEHdG/01jro=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NYiujHvKgbnz0UKQNHtDlqWChJ6BaMrRQZfiYo+w17iKBBPpLSLHkuxH+QdLImf+nkvu5HYttAhqwT3rr5RhXtxNe4au8Qy69F6DaSbLDtarCnEcTNTBXfu1AxGzfIwSqXyzWruLWiy/iJjsNU5/PA7o0sQcfQfPdfYL9O7yIU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPLRN0BJhz6F95c;
	Thu, 10 Oct 2024 15:07:12 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id DF73B140519;
	Thu, 10 Oct 2024 15:08:31 +0800 (CST)
Received: from GurSIX1 (10.204.104.168) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 09:08:25 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: 'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>
References: <67054127bb083_18b21e2943f@willemb.c.googlers.com.notmuch> <20241009065837.354332-1-gur.stavi@huawei.com> <67068a44bff02_1cca3129431@willemb.c.googlers.com.notmuch> <002201db1a75$9a83b420$cf8b1c60$@huawei.com> <67072012c983a_1e805629421@willemb.c.googlers.com.notmuch>
In-Reply-To: <67072012c983a_1e805629421@willemb.c.googlers.com.notmuch>
Subject: RE: [PATCH net-next v02 1/2] af_packet: allow fanout_add when socket is not RUNNING
Date: Thu, 10 Oct 2024 10:08:18 +0300
Message-ID: <002701db1ae3$368d9b70$a3a8d250$@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHbGWzwQMZqw76ooUWOpIJuIeDZyLJ8x9WAgAEVHYCAAHM4AIAA1CkdgABhFHA=
Content-Language: en-us
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 frapeml500005.china.huawei.com (7.182.85.13)

> Gur Stavi wrote:
> > > Gur Stavi wrote:
> > > > >> @@ -1846,21 +1846,21 @@ static int fanout_add(struct sock *sk,
> > > struct fanout_args *args)
> > > > >>  	err = -EINVAL;
> > > > >>
> > > > >>  	spin_lock(&po->bind_lock);
> > > > >> -	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
> > > > >> -	    match->type == type &&
> > > > >> +	if (match->type == type &&
> > > > >>  	    match->prot_hook.type == po->prot_hook.type &&
> > > > >>  	    match->prot_hook.dev == po->prot_hook.dev) {
> > > > >
> > > > > Remaining unaddressed issue is that the socket can now be added
> > > > > before being bound. See comment in v1.
> > > >
> > > > I extended the psock_fanout test with unbound fanout test.
> > > >
> > > > As far as I understand, the easiest way to verify bind is to test
> that
> > > > po->prot_hook.dev != NULL, since we are under a bind_lock anyway.
> > > > But perhaps a more readable and direct approach to test "bind"
> would be
> > > > to test po->ifindex != -1, as ifindex is commented as "bound
> device".
> > > > However, at the moment ifindex is not initialized to -1, I can add
> such
> > > > initialization, but perhaps I do not fully understand all the
> logic.
> > > >
> > > > Any preferences?
> > >
> > > prot_hook.dev is not necessarily set if a packet socket is bound.
> > > It may be bound to any device. See dev_add_pack and ptype_head.
> > >
> > > prot_hook.type, on the other hand, must be set if bound and is only
> > > modified with the bind_lock held too.
> > >
> > > Well, and in packet_create. But setsockopt PACKET_FANOUT_ADD also
> > > succeeds in case bind() was not called explicitly first to bind to
> > > a specific device or change ptype.
> >
> > Please clarify the last paragraph? When you say "also succeeds" do you
> > mean SHOULD succeed or MAY SUCCEED by mistake if "something" happens
> ???
> 
> I mean it succeeds currently. Which behavior must then be maintained.
> 
> > Do you refer to the following scenario: socket is created with non-zero
> > protocol and becomes RUNNING "without bind" for all devices. In that
> case
> > it can be added to FANOUT without bind. Is that considered a bug or
> does
> > the bind requirement for fanout only apply for all-protocol (0)
> sockets?
> 
> I'm beginning to think that this bind requirement is not needed.

I agree with that. I think that is an historical mistake that socket
becomes implicitly bound to all interfaces if a protocol is defined
during create. Without this bind requirement would make sense.

> 
> All type and dev are valid, even if an ETH_P_NONE fanout group would
> be fairly useless.

Fanout is all about RX, I think that refusing fanout for socket that
will not receive any packet is OK. The condition can be:
if (po->ifindex == -1 || !po->num)

I realized another possible problem. We should consider adding ifindex
Field to struct packet_fanout to be used for lookup of an existing match.
There is little sense to bind sockets to different interfaces and then
put them in the same fanout group.
If you agree, I can prepare a separate patch for that.

> The type and dev must match that of the fanout group, and once added
> to a fanout group can no longer be changed (bind will fail).
> 
> I briefy considered the reason might be max_num_members accounting.
> Since f->num_members counts running sockets. But that is not used
> when tracking membership of the group, sk_ref is. Every packet socket
> whose po->rollover is increased increases this refcount.
> 
> > What about using ifindex to detect bind? Initialize it to -1 in
> > packet_create and ensure that packet_do_bind, on success, sets it
> > to device id or 0?
> >
> > psock_fanout, should probably be extended with scenarios that test
> > "all devices" and all/specific protocols. Any specific scenario
> > suggestions?
> >
> >
> 



