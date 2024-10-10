Return-Path: <linux-kselftest+bounces-19461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F31998DC6
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 18:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 169C7B238A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 16:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C6A1CDA04;
	Thu, 10 Oct 2024 16:14:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522111C3F34;
	Thu, 10 Oct 2024 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576865; cv=none; b=lkMK4SK21Kcj8xt/EozjfruLtoI7Rhgfcwab/wNuydMRxJH0jpZPM8eBU860AXEsrqA5P1qN6lDGYH4B5hGf7d3URojFn5y25xFAukJlzYPZEHNfCLsvhX7nAkPwyPI9tZOfL/hzTeb/THjC5du510QJFQRYXXOpQ34rO31+n+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576865; c=relaxed/simple;
	bh=3igbnr8tPRd3kLCD76/Vz7k2aqjhi0+MfWSLTS9xc+I=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=m/y8+9Fb3QYCOORGTtlCz+E/Qmkyd98xtIQstymq4mouFYlyhCGNy/oM/+jE5NDxzokaw4VbuMdglBe8u2+2z2VXQaiPEdDb8/BAzvazFOOPg5GLdDf1ykNVR5ByQ4ZD9KKPQrwfsUjgvvYQJpOivcptYt4JjW5zHKNOEIT8gTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPZZD66vdz67Gvv;
	Fri, 11 Oct 2024 00:13:56 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id D91F114010C;
	Fri, 11 Oct 2024 00:14:17 +0800 (CST)
Received: from GurSIX1 (10.204.104.168) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 18:14:12 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: 'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>
References: <67054127bb083_18b21e2943f@willemb.c.googlers.com.notmuch> <20241009065837.354332-1-gur.stavi@huawei.com> <67068a44bff02_1cca3129431@willemb.c.googlers.com.notmuch> <002201db1a75$9a83b420$cf8b1c60$@huawei.com> <67072012c983a_1e805629421@willemb.c.googlers.com.notmuch> <002701db1ae3$368d9b70$a3a8d250$@huawei.com> <6707e3028d844_20573a294f0@willemb.c.googlers.com.notmuch>
In-Reply-To: <6707e3028d844_20573a294f0@willemb.c.googlers.com.notmuch>
Subject: RE: [PATCH net-next v02 1/2] af_packet: allow fanout_add when socket is not RUNNING
Date: Thu, 10 Oct 2024 19:14:04 +0300
Message-ID: <000101db1b2f$7410c2f0$5c3248d0$@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHbGWzwQMZqw76ooUWOpIJuIeDZyLJ8x9WAgAEVHYCAAHM4AIAA1CkdgADoeFuAABvjIA==
Content-Language: en-us
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500005.china.huawei.com (7.182.85.13)

> Gur Stavi wrote:
> > > Gur Stavi wrote:
> > > > > Gur Stavi wrote:
> > > > > > >> @@ -1846,21 +1846,21 @@ static int fanout_add(struct sock
> *sk,
> > > > > struct fanout_args *args)
> > > > > > >>  	err = -EINVAL;
> > > > > > >>
> > > > > > >>  	spin_lock(&po->bind_lock);
> > > > > > >> -	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
> > > > > > >> -	    match->type == type &&
> > > > > > >> +	if (match->type == type &&
> > > > > > >>  	    match->prot_hook.type == po->prot_hook.type &&
> > > > > > >>  	    match->prot_hook.dev == po->prot_hook.dev) {
> > > > > > >
> > > > > > > Remaining unaddressed issue is that the socket can now be
> added
> > > > > > > before being bound. See comment in v1.
> > > > > >
> > > > > > I extended the psock_fanout test with unbound fanout test.
> > > > > >
> > > > > > As far as I understand, the easiest way to verify bind is to
> test
> > > that
> > > > > > po->prot_hook.dev != NULL, since we are under a bind_lock
> anyway.
> > > > > > But perhaps a more readable and direct approach to test "bind"
> > > would be
> > > > > > to test po->ifindex != -1, as ifindex is commented as "bound
> > > device".
> > > > > > However, at the moment ifindex is not initialized to -1, I can
> add
> > > such
> > > > > > initialization, but perhaps I do not fully understand all the
> > > logic.
> > > > > >
> > > > > > Any preferences?
> > > > >
> > > > > prot_hook.dev is not necessarily set if a packet socket is bound.
> > > > > It may be bound to any device. See dev_add_pack and ptype_head.
> > > > >
> > > > > prot_hook.type, on the other hand, must be set if bound and is
> only
> > > > > modified with the bind_lock held too.
> > > > >
> > > > > Well, and in packet_create. But setsockopt PACKET_FANOUT_ADD also
> > > > > succeeds in case bind() was not called explicitly first to bind
> to
> > > > > a specific device or change ptype.
> > > >
> > > > Please clarify the last paragraph? When you say "also succeeds" do
> you
> > > > mean SHOULD succeed or MAY SUCCEED by mistake if "something"
> happens
> > > ???
> > >
> > > I mean it succeeds currently. Which behavior must then be maintained.
> > >
> > > > Do you refer to the following scenario: socket is created with non-
> zero
> > > > protocol and becomes RUNNING "without bind" for all devices. In
> that
> > > case
> > > > it can be added to FANOUT without bind. Is that considered a bug or
> > > does
> > > > the bind requirement for fanout only apply for all-protocol (0)
> > > sockets?
> > >
> > > I'm beginning to think that this bind requirement is not needed.
> >
> > I agree with that. I think that is an historical mistake that socket
> > becomes implicitly bound to all interfaces if a protocol is defined
> > during create. Without this bind requirement would make sense.
> >
> > >
> > > All type and dev are valid, even if an ETH_P_NONE fanout group would
> > > be fairly useless.
> >
> > Fanout is all about RX, I think that refusing fanout for socket that
> > will not receive any packet is OK. The condition can be:
> > if (po->ifindex == -1 || !po->num)
> 
> Fanout is not limited to sockets bound to a specific interface.
> This will break existing users.

For specific interface ifindex >= 1
For "any interface" ifindex == 0
ifindex is -1 only if the socket was created unbound with proto == 0
or for the rare race case that during re-bind the new dev became unlisted.
For both of these cases fanout should fail.

> 
> Binding to ETH_P_NONE is useless, but we're not going to slow down
> legitimate users with branches for cases that are harmless.
> 

With "branch", do you refer to performance or something else?
As I said in other mail, ETH_P_NONE could not be used in a fanout
before as well because socket cannot become RUNNING with proto == 0.
For performance, we removed the RUNNING condition and added this.
It is not like we need to perform 5M fanout registrations/sec. It is a
syscall after all.

> > I realized another possible problem. We should consider adding ifindex
> > Field to struct packet_fanout to be used for lookup of an existing
> match.
> > There is little sense to bind sockets to different interfaces and then
> > put them in the same fanout group.
> > If you agree, I can prepare a separate patch for that.
> >
> > > The type and dev must match that of the fanout group, and once added
> > > to a fanout group can no longer be changed (bind will fail).
> > >
> > > I briefy considered the reason might be max_num_members accounting.
> > > Since f->num_members counts running sockets. But that is not used
> > > when tracking membership of the group, sk_ref is. Every packet socket
> > > whose po->rollover is increased increases this refcount.
> > >
> > > > What about using ifindex to detect bind? Initialize it to -1 in
> > > > packet_create and ensure that packet_do_bind, on success, sets it
> > > > to device id or 0?
> > > >
> > > > psock_fanout, should probably be extended with scenarios that test
> > > > "all devices" and all/specific protocols. Any specific scenario
> > > > suggestions?
> > > >
> > > >
> > >
> >
> >
> 



