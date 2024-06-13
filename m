Return-Path: <linux-kselftest+bounces-11867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B85907597
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 16:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BA51C23B08
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86B112C526;
	Thu, 13 Jun 2024 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwg5ghc1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07CE7E76D;
	Thu, 13 Jun 2024 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290049; cv=none; b=b0jv8JEFNznohwLcwi46wltLz6HjaDdYwzbvQWApN4z/GPUeTROh5OE6peIIkaDdP5rHYQhXbUhFidv5C1XsArDyRUXYTKWEVZ0d/t7Zp9IEIwpCsR4ktClfFgpQwZV1hUnHbWk6A+jbhAbjIXIY8knxeMuj3M9bzXKQ8U6unu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290049; c=relaxed/simple;
	bh=kjzDGOG2YXMGDf6L85vqKWOLSBd/y+drS146eunQElM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkLDVXa705sal3g2VZx2CPT6uiOG5lNgK9qPYoV+jwaVfo21QmTkih570x5VwrumE52zzimQVKGSdtXcJw+rpodpap0dWenN5DXqMtAT/tgpDHXo82w+iMyeBElBQSFlg9dV3ENvIAs80Vfg9k6Mgxp92iZmMcxLqOfGTeb4268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwg5ghc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B95C32786;
	Thu, 13 Jun 2024 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718290049;
	bh=kjzDGOG2YXMGDf6L85vqKWOLSBd/y+drS146eunQElM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwg5ghc1ZNz7jjOf9igMuFsFU/zOhkMsDbUhpJuEz1nr7Kc/Za+nMY6fXggf3SUpM
	 aw4j3b1+5GyFLkQbWkbTwfU4JCH1+A1gzgCGjBix+eoShbE1qQ9cKf3DXgGVLEMEWT
	 q2VMZhj08lzDgA9MhyvRLAJezfO+L4uIt36v8Vb4XKEHKdGMJ1sHUuw/LDN0OL90nF
	 6UHNs/m9UjwnmOTm6RDX6OV5Gt8slm8BaGAQA3wqhADtRX6EQpY+FWHBfZUEKEEz3E
	 VD/k6HAMaurA3jcAjhGup1iAsq4POeoJIX/nnOC73+DtUIgiCHUdzf3LTY7oUCUgMx
	 nBZU+XpGCVEGw==
Date: Thu, 13 Jun 2024 08:47:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, l@kbusch-mbp.dhcp.thefacebook.com,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, davidgow@google.com,
	akpm@linux-foundation.org, venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <ZmsGfle1aZQauzRb@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <ZmrscxG51gFRDVlM@kbusch-mbp>
 <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
 <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>
 <31eb40f9-d68d-4348-b1fd-3cf057939297@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31eb40f9-d68d-4348-b1fd-3cf057939297@paulmck-laptop>

On Thu, Jun 13, 2024 at 07:43:35AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 13, 2024 at 08:36:44AM -0600, Keith Busch wrote:
> > On Thu, Jun 13, 2024 at 07:11:52PM +0530, Nilay Shroff wrote:
> > > On 6/13/24 18:26, Keith Busch wrote:
> > > > But that's not the problem for the rcu case. It's the last line that's
> > > > the problem:
> > > > 
> > > >  	list->prev->next = list;
> > > > 
> > > > We can't change forward pointers for any element being detached from
> > > > @head because a reader iterating the list may see that new pointer value
> > > > and end up in the wrong list, breaking iteration. A synchronize rcu
> > > > needs to happen before forward pointers can be mucked with, so it still
> > > > needs to be done in two steps. Oh bother...
> > > 
> > > Agree and probably we may break it down using this API:
> > > static inline void list_cut_rcu(struct list_head *list,
> > >  		struct list_head *head, struct list_head *entry, 
> > > 		void (*sync)(void))
> > > {
> > >  	list->next = entry;
> > >  	list->prev = head->prev;
> > > 	__list_del(entry->prev, head);
> > > 	sync();
> > >  	entry->prev = list;
> > >  	list->prev->next = list;
> > > }
> > 
> > Yes, that's the pattern, but I think we need an _srcu() variant: the
> > "sync" callback needs to know the srcu_struct.
> 
> Just make a helper function like this:
> 
> 	static void my_synchronize_srcu(void)
> 	{
> 		synchronize_srcu(&my_srcu_struct);
> 	}
> 
> Or am I missing something subtle here?

That would work if we had a global srcu, but the intended usage
dynamically allocates one per device the driver is attached to, so a
void callback doesn't know which one to sync.

