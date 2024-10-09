Return-Path: <linux-kselftest+bounces-19391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D519973FF
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 20:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF9D1F24141
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 18:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10B91A265B;
	Wed,  9 Oct 2024 18:04:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753121A0AFA;
	Wed,  9 Oct 2024 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497044; cv=none; b=HJdI3T8AjpEzvN2ZpTrsv+d25l2LBZjCRupZWQKoPFvdRItW23RvTcyI89fhOqE5FAGzJNr7pcrTXMlpq4aX3MbGlMKfTUXwjUnxkHcrcnEegfbBGnl4eiqy46q6IuY4We3UM6A4ktEv2EFBAvu3s7XQpdnH/7PrIytOmvzKT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497044; c=relaxed/simple;
	bh=QLVGJ3iUM6M7egVEwdhZvZ9wMeXkHUm6sKMK2XPCmyY=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=EuzU7TzQ+OH/py6m1iC0API0nl6CNqcKSP+ghVJFo8ssdUlqu7Y/c+v7Yx6wRf+kuFjvl+2Mf+TiFmmwAhow//q2MzHmMM4LsTyq9MAbOCiS9osFCf4ACgAZmeLZQ1b9BrEgtcMm+s3lImuQKtTP+JbjOBAABBNH+L3n9nffH6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XP0yb2KCYz6L6xf;
	Thu, 10 Oct 2024 01:59:35 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id EA562140CB9;
	Thu, 10 Oct 2024 02:03:54 +0800 (CST)
Received: from GurSIX1 (10.204.104.225) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 9 Oct
 2024 20:03:48 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: 'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>
References: <67054127bb083_18b21e2943f@willemb.c.googlers.com.notmuch> <20241009065837.354332-1-gur.stavi@huawei.com> <67068a44bff02_1cca3129431@willemb.c.googlers.com.notmuch>
In-Reply-To: <67068a44bff02_1cca3129431@willemb.c.googlers.com.notmuch>
Subject: RE: [PATCH net-next v02 1/2] af_packet: allow fanout_add when socket is not RUNNING
Date: Wed, 9 Oct 2024 21:03:41 +0300
Message-ID: <002201db1a75$9a83b420$cf8b1c60$@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHbGWzwQMZqw76ooUWOpIJuIeDZyLJ8x9WAgAEVHYCAAHM4AIAAYj2w
Content-Language: en-us
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 frapeml500005.china.huawei.com (7.182.85.13)

> Gur Stavi wrote:
> > >> @@ -1846,21 +1846,21 @@ static int fanout_add(struct sock *sk,
> struct fanout_args *args)
> > >>  	err = -EINVAL;
> > >>
> > >>  	spin_lock(&po->bind_lock);
> > >> -	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
> > >> -	    match->type == type &&
> > >> +	if (match->type == type &&
> > >>  	    match->prot_hook.type == po->prot_hook.type &&
> > >>  	    match->prot_hook.dev == po->prot_hook.dev) {
> > >
> > > Remaining unaddressed issue is that the socket can now be added
> > > before being bound. See comment in v1.
> >
> > I extended the psock_fanout test with unbound fanout test.
> >
> > As far as I understand, the easiest way to verify bind is to test that
> > po->prot_hook.dev != NULL, since we are under a bind_lock anyway.
> > But perhaps a more readable and direct approach to test "bind" would be
> > to test po->ifindex != -1, as ifindex is commented as "bound device".
> > However, at the moment ifindex is not initialized to -1, I can add such
> > initialization, but perhaps I do not fully understand all the logic.
> >
> > Any preferences?
> 
> prot_hook.dev is not necessarily set if a packet socket is bound.
> It may be bound to any device. See dev_add_pack and ptype_head.
> 
> prot_hook.type, on the other hand, must be set if bound and is only
> modified with the bind_lock held too.
> 
> Well, and in packet_create. But setsockopt PACKET_FANOUT_ADD also
> succeeds in case bind() was not called explicitly first to bind to
> a specific device or change ptype.

Please clarify the last paragraph? When you say "also succeeds" do you
mean SHOULD succeed or MAY SUCCEED by mistake if "something" happens ???

Do you refer to the following scenario: socket is created with non-zero
protocol and becomes RUNNING "without bind" for all devices. In that case
it can be added to FANOUT without bind. Is that considered a bug or does
the bind requirement for fanout only apply for all-protocol (0) sockets?

What about using ifindex to detect bind? Initialize it to -1 in
packet_create and ensure that packet_do_bind, on success, sets it
to device id or 0?

psock_fanout, should probably be extended with scenarios that test
"all devices" and all/specific protocols. Any specific scenario
suggestions?



