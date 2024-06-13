Return-Path: <linux-kselftest+bounces-11866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CAE907583
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 16:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C65B1C209F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E454146004;
	Thu, 13 Jun 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8px7EUm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B081411D6;
	Thu, 13 Jun 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289816; cv=none; b=NnFTQMn3LXfyF60Bh/eMSesf1fBs7cgYVK1uk/F9krd1FN3E07BQDNadsSH7hYbfGnTVduH969xDvQ+SUwfOEPb3aDlIQ5Zd/Zu7A4BpYkvOgV02pSQzaeLtmlq69h/B+43i6JnOue/okhU3sqEudgOgCiRaaCc7vKLgw1iV2PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289816; c=relaxed/simple;
	bh=ENTr3coAsQURUsjgzm57k8qmYmYqJPesZfILsIqW9hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4OxAm4391w+2VJPRuLw1sh+sR/viHEE0ZY4CZvqq5vqjIkldG5l2l38NNuI6YDopq5IgeVudVw/yGykdoVPbDA9qneSlquRsXnEThNOxmUd8d7ZOX1FB9oG8QIfUrOIHui/GpsMm8aMwUUIDR63FDGiVJnojYHpaP4xC+N3jO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8px7EUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE122C32786;
	Thu, 13 Jun 2024 14:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289815;
	bh=ENTr3coAsQURUsjgzm57k8qmYmYqJPesZfILsIqW9hs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=k8px7EUmjvL9L3g1sw13b1cWKwG9k2bUEtNZ3rRAi96pkn27aWBb44BxZK4vA1GHZ
	 BYd//uvON2++hb/5T6rd0VVE7Pw6AR45lCrbinXcISP/w2GBN8i30xn92uBDIjUB/7
	 TxzBxp9eJUxB1UDbT8gZEA+JC+qQNXV8+Q/KIMuos3QW0phwzJRd5s7+BJiMl6xLAF
	 1m61ir9x7Hfmm8gs57p/iftOVqB/KS32IYPP7FuXP9DznI3eVvYPb5Kyp4h3K15yws
	 s/8w9p6g0nni+YtNvy9Y/6TZejvXV5YkUfnjKhHUfmAGmwMytbAK2l+LXz3VLO79mO
	 vyPxyQ91dynkg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7A371CE09E0; Thu, 13 Jun 2024 07:43:35 -0700 (PDT)
Date: Thu, 13 Jun 2024 07:43:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, l@kbusch-mbp.dhcp.thefacebook.com,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, davidgow@google.com,
	akpm@linux-foundation.org, venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <31eb40f9-d68d-4348-b1fd-3cf057939297@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <ZmrscxG51gFRDVlM@kbusch-mbp>
 <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
 <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>

On Thu, Jun 13, 2024 at 08:36:44AM -0600, Keith Busch wrote:
> On Thu, Jun 13, 2024 at 07:11:52PM +0530, Nilay Shroff wrote:
> > On 6/13/24 18:26, Keith Busch wrote:
> > > But that's not the problem for the rcu case. It's the last line that's
> > > the problem:
> > > 
> > >  	list->prev->next = list;
> > > 
> > > We can't change forward pointers for any element being detached from
> > > @head because a reader iterating the list may see that new pointer value
> > > and end up in the wrong list, breaking iteration. A synchronize rcu
> > > needs to happen before forward pointers can be mucked with, so it still
> > > needs to be done in two steps. Oh bother...
> > 
> > Agree and probably we may break it down using this API:
> > static inline void list_cut_rcu(struct list_head *list,
> >  		struct list_head *head, struct list_head *entry, 
> > 		void (*sync)(void))
> > {
> >  	list->next = entry;
> >  	list->prev = head->prev;
> > 	__list_del(entry->prev, head);
> > 	sync();
> >  	entry->prev = list;
> >  	list->prev->next = list;
> > }
> 
> Yes, that's the pattern, but I think we need an _srcu() variant: the
> "sync" callback needs to know the srcu_struct.

Just make a helper function like this:

	static void my_synchronize_srcu(void)
	{
		synchronize_srcu(&my_srcu_struct);
	}

Or am I missing something subtle here?

							Thanx, Paul

