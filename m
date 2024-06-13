Return-Path: <linux-kselftest+bounces-11868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9AC907649
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 17:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359B51F2722E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF231494D1;
	Thu, 13 Jun 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwAN4M93"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B91494CB;
	Thu, 13 Jun 2024 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291707; cv=none; b=P1dxtEv/v2EqY8bhtk5Zji34S/Br6lk+dvKSUHTUEP2cFrQo5xCUbAmNNJ2HOkFdC0tWI6+3efit9WxM8zpBaKs5rWJILfQW1R/Hv9KpVjAZOzcD/K5QjDKQMtHCAiYyvr0ekVlyaBmO6e79/OXixWR8TmClsCYgUT5mA+oOnJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291707; c=relaxed/simple;
	bh=UGMX7r3y2vc+BLuaUSO5ILKzqK/XETMaB5uPu6PRr3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLzxGxFvpxPptVrU9QNomMenELef+IhjmQnJqUTL7Rh/ZdvCubChcfReF0svRi1b4FThio5ZJkUQ5YVpl6vEdY1t9Mb6yCfBG3+BKcBCQ8LbdCK3umgKihYgDS4iKJRtmdLUisbQrZH3QEEnxL5JjoKy+IFEIk8YueoeJms0Nwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwAN4M93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50FFC2BBFC;
	Thu, 13 Jun 2024 15:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718291706;
	bh=UGMX7r3y2vc+BLuaUSO5ILKzqK/XETMaB5uPu6PRr3g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EwAN4M93i2dFJki3F5pcLJc6uuL+sJS9K7MXJLvgZ2k6DzvdIpbtrxtMqZJ9DvrUB
	 881zQ3MCgC6R8fbZpS8JMN1ZjzU7q7PgadbcVz0OdO7YzZnRWrhfcNMsBTVBFYS0z+
	 2BjP51fIR79iZguOf2FGkz5qgal1fe3OHdqYxrPhX194rXpq3zbBp4wSCXKoUXWU1e
	 yX648Xg3a0oUQ6yzhPcCC6olYDGEwKufbPD2grtx3ELXpRWBe/IjVQZG7RDD/khSBK
	 K1h8dNbpzH6dAsLVk+c98VnceU2FWVHdDCPQPXZ2lAjppW8C1bkmsFzESVjgrvm00R
	 QOVpTfolzKmjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5C7B0CE09E0; Thu, 13 Jun 2024 08:15:06 -0700 (PDT)
Date: Thu, 13 Jun 2024 08:15:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, l@kbusch-mbp.dhcp.thefacebook.com,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, davidgow@google.com,
	akpm@linux-foundation.org, venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <73b994eb-c689-48e0-b09c-a414041a0525@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <ZmrscxG51gFRDVlM@kbusch-mbp>
 <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
 <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>
 <31eb40f9-d68d-4348-b1fd-3cf057939297@paulmck-laptop>
 <ZmsGfle1aZQauzRb@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmsGfle1aZQauzRb@kbusch-mbp.dhcp.thefacebook.com>

On Thu, Jun 13, 2024 at 08:47:26AM -0600, Keith Busch wrote:
> On Thu, Jun 13, 2024 at 07:43:35AM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 13, 2024 at 08:36:44AM -0600, Keith Busch wrote:
> > > On Thu, Jun 13, 2024 at 07:11:52PM +0530, Nilay Shroff wrote:
> > > > On 6/13/24 18:26, Keith Busch wrote:
> > > > > But that's not the problem for the rcu case. It's the last line that's
> > > > > the problem:
> > > > > 
> > > > >  	list->prev->next = list;
> > > > > 
> > > > > We can't change forward pointers for any element being detached from
> > > > > @head because a reader iterating the list may see that new pointer value
> > > > > and end up in the wrong list, breaking iteration. A synchronize rcu
> > > > > needs to happen before forward pointers can be mucked with, so it still
> > > > > needs to be done in two steps. Oh bother...
> > > > 
> > > > Agree and probably we may break it down using this API:
> > > > static inline void list_cut_rcu(struct list_head *list,
> > > >  		struct list_head *head, struct list_head *entry, 
> > > > 		void (*sync)(void))
> > > > {
> > > >  	list->next = entry;
> > > >  	list->prev = head->prev;
> > > > 	__list_del(entry->prev, head);
> > > > 	sync();
> > > >  	entry->prev = list;
> > > >  	list->prev->next = list;
> > > > }
> > > 
> > > Yes, that's the pattern, but I think we need an _srcu() variant: the
> > > "sync" callback needs to know the srcu_struct.
> > 
> > Just make a helper function like this:
> > 
> > 	static void my_synchronize_srcu(void)
> > 	{
> > 		synchronize_srcu(&my_srcu_struct);
> > 	}
> > 
> > Or am I missing something subtle here?
> 
> That would work if we had a global srcu, but the intended usage
> dynamically allocates one per device the driver is attached to, so a
> void callback doesn't know which one to sync.

Ah, good point!  I suppose that a further suggestion to just JIT the
needed function would not be well-received?  ;-)

I cannot resist suggesting placing a pointer to the srcu_struct in
the task structure.  /me runs...

Perhaps somewhat more constructively, my usual question:  Is it really
necessary to have per-driver SRCU here?  What would break if there was
a global srcu_struct that applied to all drivers?

						Thanx, Paul

